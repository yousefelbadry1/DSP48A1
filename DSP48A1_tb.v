module DSP48A1_tb();
//parameters
parameter A0REG=0; parameter A1REG=1 ; parameter B0REG=0 ; parameter B1REG=1;
parameter CREG=1; parameter DREG=1 ; parameter MREG=1 ; parameter PREG=1;
parameter CARRYINREG=1 ; parameter CARRYOUTREG=1 ; parameter OPMODEREG=1;
parameter CARRYINSEL="OPMODE5" ;parameter B_INPUT="DIRECT" ; parameter RSTTYPE="SYNC" ;

//inputs and outputs
reg [17:0]A;
reg [17:0]B;
reg [17:0]D;
reg [47:0]C;
reg clk,CARRYIN;
reg [7:0]OPMODE;
reg [17:0]BCIN;
reg RSTA,RSTB,RSTM,RSTP,RSTC,RSTD,RSTCARRYIN,RSTOPMODE, //active high resets
      CEA,CEB,CEM,CEP,CEC,CED,CECARRYIN,CEOPMODE; //clock enable
reg [47:0]PCIN;
wire [17:0]BCOUT;
wire [47:0]PCOUT;
wire [47:0]P;
wire [35:0]M;
wire CARRYOUT,CARRYOUTF;

// Instantiate the DUT
DSP48A1 #(
    .A0REG(A0REG),
    .A1REG(A1REG),
    .B0REG(B0REG),
    .B1REG(B1REG),
    .CREG(CREG),
    .DREG(DREG),
    .MREG(MREG),
    .PREG(PREG),
    .CARRYINREG(CARRYINREG),
    .CARRYOUTREG(CARRYOUTREG),
    .OPMODEREG(OPMODEREG),
    .CARRYINSEL(CARRYINSEL),
    .B_INPUT(B_INPUT),
    .RSTTYPE(RSTTYPE)
) Dut (
    .A(A),
    .B(B),
    .D(D),
    .C(C),
    .clk(clk),
    .CARRYIN(CARRYIN),
    .OPMODE(OPMODE),
    .BCIN(BCIN),
    .RSTA(RSTA),
    .RSTB(RSTB),
    .RSTM(RSTM),
    .RSTP(RSTP),
    .RSTC(RSTC),
    .RSTD(RSTD),
    .RSTCARRYIN(RSTCARRYIN),
    .RSTOPMODE(RSTOPMODE),
    .CEA(CEA),
    .CEB(CEB),
    .CEM(CEM),
    .CEP(CEP),
    .CEC(CEC),
    .CED(CED),
    .CECARRYIN(CECARRYIN),
    .CEOPMODE(CEOPMODE),
    .PCIN(PCIN),
    .BCOUT(BCOUT),
    .PCOUT(PCOUT),
    .P(P),
    .M(M),
    .CARRYOUT(CARRYOUT),
    .CARRYOUTF(CARRYOUTF)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; 
end

initial begin
    // Initialize inputs
    A = 0; B = 0; D = 0; C = 0; CARRYIN = 0; OPMODE = 0;
    BCIN = 0; RSTA = 0; RSTB = 0; RSTM = 0; RSTP = 0; RSTC = 0; RSTD = 0; RSTCARRYIN = 0; RSTOPMODE = 0;
    CEA = 0; CEB = 0; CEM = 0; CEP = 0; CEC = 0; CED = 0; CECARRYIN = 0; CEOPMODE = 0; PCIN = 0;

    // Reset the design
    RSTA = 1; RSTB = 1; RSTM = 1; RSTP = 1; RSTC = 1; RSTD = 1; RSTCARRYIN = 1; RSTOPMODE = 1;

    A=18'd50; B=18'd20; C=48'd70; D=18'd90; PCIN=48'd150; CARRYIN=1; BCIN=18'd250; 
    repeat(4) @(negedge clk);
    
    RSTA = 0; RSTB = 0; RSTM = 0; RSTP = 0; RSTC = 0; RSTD = 0; RSTCARRYIN = 0; RSTOPMODE = 0;
    CEA = 1; CEB = 1; CEM = 1; CEP = 1; CEC = 1; CED = 1; CECARRYIN = 1; CEOPMODE = 1;
    
    //****************************************************************************
    //test add -- add Xmux paths (00) & Zmux paths (00) with CIN(opmode[5]) =1
    OPMODE=8'b00110000;
    repeat(2) @(negedge clk);

    //test add -- add Xmux paths (00) & Zmux paths (01) with CIN(opmode[5]) =1
    OPMODE=8'b00110100;
    repeat(2) @(negedge clk);

    //test add -- add Xmux paths (00) & Zmux paths (10) with CIN(opmode[5]) =0
    OPMODE=8'b00101000;
    repeat(1) @(negedge clk);

    //test add -- add Xmux paths (00) & Zmux paths (11) with CIN(opmode[5]) =1
    OPMODE=8'b00111100;
    repeat(3) @(negedge clk);
    //****************************************************************************
    //test add -- add Xmux paths (00) & Zmux paths (11) with CIN(opmode[5]) =1
    OPMODE=8'b10111100;
    repeat(3) @(negedge clk);
    //****************************************************************************
    //test add -- add Xmux paths (01) & Zmux paths (00) with CIN(opmode[5]) =1
    OPMODE=8'b00110001;
    repeat(4) @(negedge clk);

    //test add -- add Xmux paths (01) & Zmux paths (01) with CIN(opmode[5]) =1
    OPMODE=8'b00110101;
    repeat(4) @(negedge clk);

    //test add -- add Xmux paths (01) & Zmux paths (10) with CIN(opmode[5]) =1
    OPMODE=8'b00111001;
    repeat(4) @(negedge clk);

    //test add -- add Xmux paths (01) & Zmux paths (11) with CIN(opmode[5]) =1
    OPMODE=8'b00111101;
    repeat(4) @(negedge clk);
    //****************************************************************************
    //test sub -- add Xmux paths (01) & Zmux paths (00) with CIN(opmode[5]) =1
    OPMODE=8'b01110001;
    repeat(4) @(negedge clk);

    //test sub -- add Xmux paths (01) & Zmux paths (01) with CIN(opmode[5]) =1
    OPMODE=8'b01110101;
    repeat(4) @(negedge clk);

    //test sub -- add Xmux paths (01) & Zmux paths (10) with CIN(opmode[5]) =1
    OPMODE=8'b01111001;
    repeat(4) @(negedge clk);

    //test sub -- add Xmux paths (01) & Zmux paths (11) with CIN(opmode[5]) =1
    OPMODE=8'b01111101;
    repeat(4) @(negedge clk);
    //****************************************************************************
    //test add -- add Xmux paths (10) & Zmux paths (00) with CIN(opmode[5]) =1
    OPMODE=8'b00110010;
    repeat(2) @(negedge clk);

    //test add -- add Xmux paths (10) & Zmux paths (01) with CIN(opmode[5]) =1
    OPMODE=8'b00110110;
    repeat(2) @(negedge clk);

    //test add -- add Xmux paths (10) & Zmux paths (10) with CIN(opmode[5]) =1
    OPMODE=8'b00111010;
    repeat(2) @(negedge clk);

    //test add -- add Xmux paths (10) & Zmux paths (11) with CIN(opmode[5]) =1
    OPMODE=8'b00111110;
    repeat(2) @(negedge clk);
     //****************************************************************************
    //test add -- sub Xmux paths (10) & Zmux paths (00) with CIN(opmode[5]) =1
    OPMODE=8'b10110010;
    repeat(2) @(negedge clk);

    //test add -- sub Xmux paths (10) & Zmux paths (01) with CIN(opmode[5]) =1
    OPMODE=8'b10110110;
    repeat(2) @(negedge clk);

    //test add -- sub Xmux paths (10) & Zmux paths (10) with CIN(opmode[5]) =1
    OPMODE=8'b10111010;
    repeat(2) @(negedge clk);

    //test add -- sub Xmux paths (10) & Zmux paths (11) with CIN(opmode[5]) =1
    OPMODE=8'b10111110;
    repeat(2) @(negedge clk);
    //****************************************************************************
    //test add -- add Xmux paths (11) & Zmux paths (00) with CIN(opmode[5]) =1
    OPMODE=8'b00110011;
    repeat(3) @(negedge clk);

    //test add -- add Xmux paths (11) & Zmux paths (01) with CIN(opmode[5]) =1
    OPMODE=8'b00110111;
    repeat(3) @(negedge clk);

    //test add -- add Xmux paths (11) & Zmux paths (10) with CIN(opmode[5]) =1
    OPMODE=8'b00111011;
    repeat(3) @(negedge clk);

    //test add -- add Xmux paths (11) & Zmux paths (11) with CIN(opmode[5]) =1
    OPMODE=8'b00111111;
    repeat(3) @(negedge clk);
    //****************************************************************************
    //test add -- sub Xmux paths (11) & Zmux paths (00) with CIN(opmode[5]) =1
    OPMODE=8'b10110011;
    repeat(3) @(negedge clk);

    //test add -- sub Xmux paths (11) & Zmux paths (01) with CIN(opmode[5]) =1
    OPMODE=8'b10110111;
    repeat(3) @(negedge clk);

    //test add -- sub Xmux paths (11) & Zmux paths (10) with CIN(opmode[5]) =1
    OPMODE=8'b10111011;
    repeat(3) @(negedge clk);

    //test add -- sub Xmux paths (11) & Zmux paths (11) with CIN(opmode[5]) =1
    OPMODE=8'b10111111;
    repeat(3) @(negedge clk);
    //****************************************************************************
    //test sub -- add Xmux paths (11) & Zmux paths (00) with CIN(opmode[5]) =1
    OPMODE=8'b01110011;
    repeat(3) @(negedge clk);

    //test sub -- add Xmux paths (11) & Zmux paths (01) with CIN(opmode[5]) =1
    OPMODE=8'b01110111;
    repeat(3) @(negedge clk);

    //test sub -- add Xmux paths (11) & Zmux paths (10) with CIN(opmode[5]) =1
    OPMODE=8'b01111011;
    repeat(3) @(negedge clk);

    //test sub -- add Xmux paths (11) & Zmux paths (11) with CIN(opmode[5]) =1
    OPMODE=8'b01111111;
    repeat(3) @(negedge clk);
    //****************************************************************************
    //test sub -- sub Xmux paths (11) & Zmux paths (00) with CIN(opmode[5]) =1
    OPMODE=8'b11110011;
    repeat(3) @(negedge clk);

    //test sub -- sub Xmux paths (11) & Zmux paths (01) with CIN(opmode[5]) =1
    OPMODE=8'b11110111;
    repeat(3) @(negedge clk);

    //test sub -- sub Xmux paths (11) & Zmux paths (10) with CIN(opmode[5]) =1
    OPMODE=8'b11111011;
    repeat(3) @(negedge clk);

    //test sub -- sub Xmux paths (11) & Zmux paths (11) with CIN(opmode[5]) =1
    OPMODE=8'b11111111;
    repeat(3) @(negedge clk);



$stop;
end
endmodule
