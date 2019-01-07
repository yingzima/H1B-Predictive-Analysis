/*Classification Tree*/

proc import datafile="\\tsclient\Desktop\Cleaned Data_12102018.csv"
out=H1B
dbms=csv; 
getnames=yes;
run;

/*Tree 1*/
ods graphics on;
proc hpsplit data=H1B plots=all;
class agent sector region;
model agent(event="Y") = sector region;
run;
ods graphics off;

/*Tree 2*/
ods graphics on;
proc hpsplit data=H1B plots=all;
class agent NACIS state dependent;
model agent(event="Y") = NACIS state dependent;
run;
ods graphics off;


/*Logistic Regression*/
ods graphics on;
proc logistic data = H1B plots(unpack)=(roc influence) plot (maximum = none);
class dependent agent state NACIS / PARAM = GLM;
model agent(event='Y') = wage NACIS state dependent wage*NACIS wage*state / ctable lackfit;
run;
ods graphics off;
