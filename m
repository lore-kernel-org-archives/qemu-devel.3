Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB51E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4av-0001Xi-VR; Tue, 07 Jan 2025 03:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ah-0000ih-99
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:32 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aV-0003Q6-VM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:31 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2166360285dso224285305ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237118; x=1736841918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUPGC8XQ2c+hYLLHwLFbIgtNZNL9fx60kAHV/TFCgr4=;
 b=tLSQIRMp93K4hZngZcUnHrxm0QkqOmT589QOWdgXHsVzWgl1zVDIZ312qhDAeO9zNQ
 om4KF/GY+298nqdbuGp7b2HnxTcx7LvgmRVgYkXi1xjxLfaikN1QO9vFtf2Je0E/5c60
 3OXElP/fXFnZ4o5USo5iZvl537xjfsa0qi/CrFsh2G+RG/kf23d2WRexQ/6n/4RLhwV5
 ysapI5HLtrqhYM9EZUQ8mYmzmxLcsaGA0C/XihWUX83KAfpKyMP8h6PanI+fVxERY+Vz
 6491RcOt097eijHK7s2Xt9F/L4SRNz3/xZwNGVN712i2DEr9cvZ4m2JAHL96XoJ2ffFv
 711w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237118; x=1736841918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aUPGC8XQ2c+hYLLHwLFbIgtNZNL9fx60kAHV/TFCgr4=;
 b=nCR5kuNFs5vVyL4dpG2pBRGcaKXvJ9vIAzp2fHEtfGwwORietePTvFe3dQqHwVkFdw
 tBHgxFt2HbeEHoMQRp3WnhK8k6qjM3bjnfgdIKYO5q9M3VoLmb5E1I6ikidYVScxkZMy
 Z2VVPiJOLR5wMCOgFptKiMqfLv2p0ExgiKKDM66cZndCbav+Zni+JIOjO+w8K4rsvalB
 Yij9Fwk3IC1CDZRSwoZI8gh2hzDf9Oif6wU877tQGBFbQjCFx4Nf7obH4XeOGbYhTYzk
 /m3XSHYj0ke5D+hL7ZRHpC/M7q3vKQmg85Vzy84uK4gkrijx4cxRi1LHeWXh0INO8eEc
 sfQg==
X-Gm-Message-State: AOJu0Yz4KQzCit+ezJ1Sw6rtbiislPiD1KKk8+nSkXR4+cqYVI7D50yU
 y9enqyBY3Of8uKDmpJ4DIDtaN0l0lA1kByE7iQK7KkqUALYLf6lVduqyxojeCcLH4Qo9nQkUnCa
 w
X-Gm-Gg: ASbGncuwXZnqfcaitruV7SqVHSGznlIAFoMcQ6+idlZpqQCtaFka52J3QANnd/r8H0Y
 bNfOezhRsTJSEcNDHPlX3jMZ7ASsxgzYMSAhFx9XAtf416ISnlEpoZeTka9ezUmFyRRHW77tY2x
 J6rNuNbQ5m2knCSd4udWgA/8cvgRoGKiZGejdE2X/u9NC3aOb25ajYV71Oo+G7JTusXfQWR75GF
 O+4NXjMxrwMSfWlzO/wAIVoOsiYnJe5x2DPF1gvy3yDZubjFBLbgYUj/88TAIH7sSaQpRGIuyUq
 b1T4M2n6EXUiw3HR9Q==
X-Google-Smtp-Source: AGHT+IFMSk/iiA0w2FB1e/uUOX0LwunBsNJ/sZQ4czmREWkBXxE1OvFEChYYH5ynXivYgK6rf5VnLw==
X-Received: by 2002:a05:6a21:100f:b0:1e0:d848:9e83 with SMTP id
 adf61e73a8af0-1e5e07a853amr96233231637.25.1736237118297; 
 Tue, 07 Jan 2025 00:05:18 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 60/81] tcg: Convert or to TCGOutOpBinary
Date: Tue,  7 Jan 2025 00:00:51 -0800
Message-ID: <20250107080112.1175095-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        |  4 +++
 tcg/aarch64/tcg-target.c.inc     | 31 ++++++++++++---------
 tcg/arm/tcg-target.c.inc         | 24 ++++++++++++----
 tcg/i386/tcg-target.c.inc        | 25 +++++++++++++----
 tcg/loongarch64/tcg-target.c.inc | 29 ++++++++++++--------
 tcg/mips/tcg-target.c.inc        | 25 ++++++++++++-----
 tcg/ppc/tcg-target.c.inc         | 29 ++++++++++++--------
 tcg/riscv/tcg-target.c.inc       | 29 ++++++++++++--------
 tcg/s390x/tcg-target.c.inc       | 47 +++++++++++++++++---------------
 tcg/sparc64/tcg-target.c.inc     | 23 ++++++++++++----
 tcg/tci/tcg-target.c.inc         | 14 ++++++++--
 11 files changed, 186 insertions(+), 94 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 52f0d55e31..ab4646e20e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -994,6 +994,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
+    OUTOP(INDEX_op_or_i32, TCGOutOpBinary, outop_or),
+    OUTOP(INDEX_op_or_i64, TCGOutOpBinary, outop_or),
 };
 
 #undef OUTOP
@@ -5426,6 +5428,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
+    case INDEX_op_or_i32:
+    case INDEX_op_or_i64:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 06d082ffd9..cf7758b39a 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2157,6 +2157,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3510, ORR, type, a0, a1, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_logicali(s, I3404_ORRI, type, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rL),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2242,17 +2260,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
         break;
 
-    case INDEX_op_or_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_or_i64:
-        if (c2) {
-            tcg_out_logicali(s, I3404_ORRI, ext, a0, a1, a2);
-        } else {
-            tcg_out_insn(s, 3510, ORR, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_orc_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -3028,8 +3035,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_mulsh_i64:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
     case INDEX_op_orc_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 9db2a59be1..f935d13138 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1907,6 +1907,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_ORR, a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_imm(s, COND_AL, ARITH_ORR, a0, a1, encode_imm_nofail(a2));
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1969,13 +1987,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                             args[0], args[1], args[2], const_args[2]);
         }
         break;
-    case INDEX_op_or_i32:
-        c = ARITH_ORR;
-        goto gen_arith;
     case INDEX_op_xor_i32:
         c = ARITH_EOR;
-        /* Fall through.  */
-    gen_arith:
         tcg_out_dat_rI(s, COND_AL, c, args[0], args[1], args[2], const_args[2]);
         break;
     case INDEX_op_add2_i32:
@@ -2253,7 +2266,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, r, r);
 
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
         return C_O1_I2(r, r, rI);
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 7fc4fdd9d6..22dd190cf3 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2698,6 +2698,26 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_OR + rexw, a0, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_OR + rexw, a0, a2, 0);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2783,9 +2803,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(or):
-        c = ARITH_OR;
-        goto gen_arith;
     OP_32_64(xor):
         c = ARITH_XOR;
         goto gen_arith;
@@ -3740,8 +3757,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, 0, re);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 7503c3f25c..498d560538 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1324,6 +1324,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_or(s, a0, a1, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg rd, TCGReg rs, tcg_target_long imm)
+{
+    tcg_out_opc_ori(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rU),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1384,15 +1402,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-        if (c2) {
-            tcg_out_opc_ori(s, a0, a1, a2);
-        } else {
-            tcg_out_opc_or(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         if (c2) {
@@ -2310,8 +2319,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         /* LoongArch reg-imm bitops have their imms ZERO-extended */
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 1720ec45cd..c4f5f2492a 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1735,6 +1735,24 @@ static const TCGOutOpBinary outop_andc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_OR, a0, a1, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_imm(s, OPC_ORI, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1813,14 +1831,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-        i1 = OPC_OR, i2 = OPC_ORI;
-        goto do_binary;
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         i1 = OPC_XOR, i2 = OPC_XORI;
-    do_binary:
         if (c2) {
             tcg_out_opc_imm(s, i2, a0, a1, a2);
             break;
@@ -2272,9 +2285,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
         return C_O2_I2(r, r, r, r);
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rI);
     case INDEX_op_shl_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 563471497f..8fd73ea4d1 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2992,6 +2992,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, OR | SAB(a1, a0, a2));
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_ori32(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rU),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3077,15 +3095,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i64:
-    case INDEX_op_or_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_ori32(s, a0, a1, a2);
-        } else {
-            tcg_out32(s, OR | SAB(a1, a0, a2));
-        }
-        break;
     case INDEX_op_xor_i64:
     case INDEX_op_xor_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
@@ -4204,7 +4213,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
     case INDEX_op_orc_i32:
     case INDEX_op_eqv_i32:
@@ -4246,7 +4254,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
         return C_O1_I2(r, rI, ri);
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rU);
     case INDEX_op_sub_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 8d56d887e0..ff0741b12c 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2016,6 +2016,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_OR, a0, a1, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_imm(s, OPC_ORI, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2094,15 +2112,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ORI, a0, a1, a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_OR, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         if (c2) {
@@ -2683,9 +2692,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rZ, r);
 
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 789e68a061..35feaeb35c 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2242,6 +2242,31 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, OGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, OR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, ORK, a0, a1, a2);
+    }
+}
+
+static void tgen_ori_3(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    tgen_ori(s, a0, type == TCG_TYPE_I32 ? (uint32_t)a2 : a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rK),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori_3,
+};
+
 
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
@@ -2310,17 +2335,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen_ori(s, a0, a2);
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RR, OR, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, ORK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_xor_i32:
         a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
         if (const_args[2]) {
@@ -2567,15 +2581,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_ori(s, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, OGRK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_xor_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
@@ -3288,10 +3293,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
         return C_O1_I2(r, r, ri);
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rK);
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 87a496f4a8..4c50b33105 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1336,6 +1336,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_OR);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_arithi(s, a0, a1, a2, ARITH_OR);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1393,9 +1411,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(or):
-        c = ARITH_OR;
-        goto gen_arith;
     OP_32_64(orc):
         c = ARITH_ORN;
         goto gen_arith;
@@ -1623,8 +1638,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
     case INDEX_op_xor_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 8575b94fb7..9d0fc35a70 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -101,8 +101,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
     case INDEX_op_xor_i32:
@@ -690,6 +688,17 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_or_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_or,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -734,7 +743,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     CASE_32_64(sub)
     CASE_32_64(mul)
-    CASE_32_64(or)
     CASE_32_64(xor)
     CASE_32_64(orc)      /* Optional (TCG_TARGET_HAS_orc_*). */
     CASE_32_64(eqv)      /* Optional (TCG_TARGET_HAS_eqv_*). */
-- 
2.43.0


