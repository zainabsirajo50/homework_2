import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _displayText = '0';
  double _firstOperand = 0;
  double _secondOperand = 0;
  String _operator = '';
  bool _isOperatorPressed = false;
  bool _hasError = false; 


  void _onButtonPressed(String value) {
    setState(() {
      if (_hasError) {
        _resetCalculator(); 
      }

      if (value == '+' || value == '-' || value == '*' || value == '/') {
        _operator = value;
        _firstOperand = double.parse(_displayText);
        _isOperatorPressed = true;
        _displayText = '0';
      } else if (value == '=') {
        _secondOperand = double.parse(_displayText);
        double result = _calculate();
        _displayText = result.toString();
        _firstOperand = result; // store result to continue calculations
        _isOperatorPressed = false;
        _operator = ''; // reset the operator after calculation
      } else if (value == 'C') {
        _resetCalculator();
      } else {
        if (_displayText == '0' || _isOperatorPressed) {
          _displayText = value;
          _isOperatorPressed = false;
        } else {
          _displayText += value;
        }
      }
    });
  }

  // function to perform the operations
  double _calculate() {
    switch (_operator) {
      case '+':
        return _firstOperand + _secondOperand;
      case '-':
        return _firstOperand - _secondOperand;
      case '*':
        return _firstOperand * _secondOperand;
      case '/':
        if (_secondOperand == 0) {
          _handleError('Cannot divide by zero');
          return 0;
        }
        return _firstOperand / _secondOperand;
      default:
        return _firstOperand; // if no operation, just return the first operand
    }
  }


  void _resetCalculator() {
    _displayText = '0';
    _firstOperand = 0;
    _secondOperand = 0;
    _operator = '';
    _hasError = false;
  }

  // division by zero
  void _handleError(String errorMessage) {
    _displayText = errorMessage;
    _hasError = true;
  }


  Widget _buildButton(String label) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 77, 108, 78),
          foregroundColor: Colors.white,
          padding: EdgeInsets.all(24),
        ),

        onPressed: () => _onButtonPressed(label),
        child: Text(
          label,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
        backgroundColor: const Color.fromARGB(255, 77, 108, 78),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                _displayText,
                style: TextStyle(
                  fontSize: 48, 
                  fontWeight: FontWeight.bold, 
                  color: _hasError ? Colors.red : Colors.black // if dividing by zero change result color to red
                ), 
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('/'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('*'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('-'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('0'),
                    _buildButton('C'),
                    _buildButton('='),
                    _buildButton('+'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}