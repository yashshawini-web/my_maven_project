<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>JSP Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f6f9;
        }
        .calculator-card {
            background: #ffffff;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        h2 {
            margin-top: 0;
            text-align: center;
            color: #333;
        }
        .form-group {
            margin-bottom: 14px;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-size: 14px;
            color: #555;
        }
        input, select {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 14px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            border-radius: 6px;
            color: white;
            font-size: 15px;
            cursor: pointer;
            font-weight: bold;
        }
        button:hover {
            background-color: #0056b3;
        }
        .result-box {
            margin-top: 18px;
            padding: 12px;
            background-color: #e9f7ef;
            border: 1px solid #c3e6cb;
            color: #155724;
            border-radius: 6px;
            text-align: center;
            font-size: 16px;
            font-weight: bold;
        }
        .error-box {
            margin-top: 18px;
            padding: 12px;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            border-radius: 6px;
            text-align: center;
            font-size: 14px;
        }
    </style>
</head>
<body>

<div class="calculator-card">
    <h2>Calculator</h2>
    <form method="post">
        <div class="form-group">
            <label>First Number</label>
            <input type="number" step="any" name="num1" required value="<%= request.getParameter("num1") != null ? request.getParameter("num1") : "" %>">
        </div>
        <div class="form-group">
            <label>Operation</label>
            <select name="operation">
                <option value="add" <%= "add".equals(request.getParameter("operation")) ? "selected" : "" %>>Addition (+)</option>
                <option value="subtract" <%= "subtract".equals(request.getParameter("operation")) ? "selected" : "" %>>Subtraction (-)</option>
                <option value="multiply" <%= "multiply".equals(request.getParameter("operation")) ? "selected" : "" %>>Multiplication (*)</option>
                <option value="divide" <%= "divide".equals(request.getParameter("operation")) ? "selected" : "" %>>Division (/)</option>
            </select>
        </div>
        <div class="form-group">
            <label>Second Number</label>
            <input type="number" step="any" name="num2" required value="<%= request.getParameter("num2") != null ? request.getParameter("num2") : "" %>">
        </div>
        <button type="submit">Calculate</button>
    </form>

    <%
        String n1 = request.getParameter("num1");
        String n2 = request.getParameter("num2");
        String op = request.getParameter("operation");

        if (n1 != null && n2 != null && op != null) {
            try {
                double val1 = Double.parseDouble(n1);
                double val2 = Double.parseDouble(n2);
                double result = 0;
                boolean valid = true;
                String errorMsg = "";

                if ("add".equals(op)) {
                    result = val1 + val2;
                } else if ("subtract".equals(op)) {
                    result = val1 - val2;
                } else if ("multiply".equals(op)) {
                    result = val1 * val2;
                } else if ("divide".equals(op)) {
                    if (val2 == 0) {
                        valid = false;
                        errorMsg = "Cannot divide by zero.";
                    } else {
                        result = val1 / val2;
                    }
                }

                if (valid) {
    %>
                    <div class="result-box">Result: <%= result %></div>
    <%
                } else {
    %>
                    <div class="error-box"><%= errorMsg %></div>
    <%
                }
            } catch (NumberFormatException e) {
    %>
                <div class="error-box">Invalid numeric input.</div>
    <%
            }
        }
    %>
</div>

</body>
</html>