Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA472C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnqe-00025t-PD; Sun, 16 Feb 2025 18:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpz-0000yD-KX
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:15 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpj-0005R9-On
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:58 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220d132f16dso54394035ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747634; x=1740352434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=508JUuj07L7949MNHFMlFPxhJkIHKsilvdcTFtUkigc=;
 b=kBfCqdIz2GLW6oIbV3ItZgUu9bAC+0qVwFJKAvK23vO0M04rzCM2vpqigopN1gY+XB
 4xs3fm9vjFcgC7lJnPAFT37tX6AAN0pqURJ64GsYGG1oTtBT/jzHJ2vC5ogq+x5na7gi
 7RQlnr04VrPcSrlFzOI30iHiatRqCJ1QvawSPWpfr3AS+9eLcRWMYOfHYZ4/TiXb7rOG
 G1U2GzEer21jIvDTRoM0aMBlIvP2P9imIABty5ep4+htZktIlwj5elJIOkUxATPbsQvk
 Mq4PkgPmXul29nnzF/26I5ILEDE/iLvHbfQ3gb2BZx12KrD3AtY8IGigxs9uhV7M/jGz
 B6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747634; x=1740352434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=508JUuj07L7949MNHFMlFPxhJkIHKsilvdcTFtUkigc=;
 b=NGSoZeqPV2FoXaBar7eKDUSvDCi03DqrTMVN/5PcTzkakkMT6Ol/F0X7bcXt7GqD3n
 1kVFHweh6bUEJnoab/wooHXW98zlH72oYuFC4hjS+AojZIEC+iSEVisIs4/X77ig0SeZ
 XKNEHRQObnz3TBIBhU3f2CvsqxHkxnMJGsHTDyYUgdnsQ+r6EBP/lyJukg5MEVTYuaiY
 Law9jbyHHvErpMEFApKU75ipUqosRalyD93qstsXtczsMQz9KNOkvp4pm5/yCMRd43Zw
 V34VIz3XpHZZK0DJcbZIHFLLyEbizaDSJPFietj6fYSPuXeHuCn+WZ4wqN/iyB7F1qpj
 +BUg==
X-Gm-Message-State: AOJu0YycD1L9ZKqmFLYaYmDAXjHuhE1w9nDFn3gx30hBbR/uHu1OW25c
 dqfDnY42mVhD3DSPaZ0FHVp2q7sz50j6BH+2mQSv68JL5C1Ply2M5vOxCg1NzZ68rpBtzibKrs6
 O
X-Gm-Gg: ASbGncuLLRZmIHySET6yvgKjAga706c7r7nOrsyy8HTFmgso0lYYvJJmiw1axwlK8gW
 xmTGplHT66Y4qtfsfJBwDVDCJI+z2mxcB4iWhzbyMVta2nla3tdkpmZePUr30QK0Pld/IJwHQ6M
 xCqiAOBn2f28QR8g5VzOCO+k30wlCyzX9W/+n1dGgqtoOR3Oc9Im1Oav8iLIJwIbs+FUK6Hj/jg
 3y2+PSj2X6/sq0C7LKokyMmE/OO1dmtIqP6X/PGvVvWI6uutiuRCNiindK10IIiSaJ9gSy64/J6
 bjuO9fS51D+T2tdu2/9VPfJ5pw4AWzvyPMqZ2FE+SgpsiAM=
X-Google-Smtp-Source: AGHT+IE/3XaFQ3UPOvFqGdq6zXGR2FdzPrCvvHPAQcFe/uwVFuJu0ufyPHuiLzWd1W6wdz4vgaKUVw==
X-Received: by 2002:a17:903:1cc:b0:212:514:b30a with SMTP id
 d9443c01a7336-2210400f161mr130744165ad.12.1739747634218; 
 Sun, 16 Feb 2025 15:13:54 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.13.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:13:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 052/162] tcg: Convert shl to TCGOutOpBinary
Date: Sun, 16 Feb 2025 15:08:21 -0800
Message-ID: <20250216231012.2808572-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 tcg/tcg.c                        |  6 ++--
 tcg/aarch64/tcg-target.c.inc     | 38 ++++++++++----------
 tcg/arm/tcg-target.c.inc         | 25 +++++++++----
 tcg/i386/tcg-target.c.inc        | 60 +++++++++++++++++++++++---------
 tcg/loongarch64/tcg-target.c.inc | 43 ++++++++++++++---------
 tcg/mips/tcg-target.c.inc        | 35 ++++++++++++-------
 tcg/ppc/tcg-target.c.inc         | 42 ++++++++++++----------
 tcg/riscv/tcg-target.c.inc       | 38 +++++++++++---------
 tcg/s390x/tcg-target.c.inc       | 37 ++++++++++++++++----
 tcg/sparc64/tcg-target.c.inc     | 27 ++++++++++----
 tcg/tci/tcg-target.c.inc         | 14 ++++++--
 11 files changed, 241 insertions(+), 124 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 12418d1aa6..def7bbbdb9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1042,6 +1042,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
+    OUTOP(INDEX_op_shl_i32, TCGOutOpBinary, outop_shl),
+    OUTOP(INDEX_op_shl_i64, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
@@ -2262,7 +2264,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_extract_i32:
@@ -2314,7 +2315,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_ext_i32_i64:
@@ -5417,6 +5417,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_orc:
     case INDEX_op_rems:
     case INDEX_op_remu:
+    case INDEX_op_shl_i32:
+    case INDEX_op_shl_i64:
     case INDEX_op_xor:
         {
             const TCGOutOpBinary *out =
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 8aa11e9d9d..b57baa1eec 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1347,14 +1347,6 @@ static inline void tcg_out_extr(TCGContext *s, TCGType ext, TCGReg rd,
     tcg_out_insn(s, 3403, EXTR, ext, rd, rn, rm, a);
 }
 
-static inline void tcg_out_shl(TCGContext *s, TCGType ext,
-                               TCGReg rd, TCGReg rn, unsigned int m)
-{
-    int bits = ext ? 64 : 32;
-    int max = bits - 1;
-    tcg_out_ubfm(s, ext, rd, rn, (bits - m) & max, (max - m) & max);
-}
-
 static inline void tcg_out_shr(TCGContext *s, TCGType ext,
                                TCGReg rd, TCGReg rn, unsigned int m)
 {
@@ -2299,6 +2291,25 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3508, LSLV, type, a0, a1, a2);
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int max = type == TCG_TYPE_I32 ? 31 : 63;
+    tcg_out_ubfm(s, type, a0, a1, -a2 & max, ~a2 & max);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2416,15 +2427,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_shl_i64:
-    case INDEX_op_shl_i32:
-        if (c2) {
-            tcg_out_shl(s, ext, a0, a1, a2);
-        } else {
-            tcg_out_insn(s, 3508, LSLV, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_shr_i64:
     case INDEX_op_shr_i32:
         if (c2) {
@@ -3091,12 +3093,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
 
-    case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i64:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index c3d0d37ca4..0bdb3c616f 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1969,6 +1969,25 @@ static const TCGOutOpBinary outop_remu = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, a0, 0, a1, SHIFT_REG_LSL(a2));
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, a0, 0, a1,
+                    SHIFT_IMM_LSL(a2 & 0x1f));
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2120,11 +2139,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_muls2_i32:
         tcg_out_smull32(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
-    /* XXX: Perhaps args[2] & 0x1f is wrong */
-    case INDEX_op_shl_i32:
-        c = const_args[2] ?
-                SHIFT_IMM_LSL(args[2] & 0x1f) : SHIFT_REG_LSL(args[2]);
-        goto gen_shift32;
     case INDEX_op_shr_i32:
         c = const_args[2] ? (args[2] & 0x1f) ? SHIFT_IMM_LSR(args[2] & 0x1f) :
                 SHIFT_IMM_LSL(0) : SHIFT_REG_LSR(args[2]);
@@ -2306,7 +2320,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, r, r);
 
-    case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 645a6956f0..7a0de0924d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2744,6 +2744,49 @@ static const TCGOutOpBinary outop_remu = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static TCGConstraintSetIndex cset_shift(TCGType type, unsigned flags)
+{
+    return have_bmi2 ? C_O1_I2(r, r, ri) : C_O1_I2(r, 0, ci);
+}
+
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    if (have_bmi2) {
+        tcg_out_vex_modrm(s, OPC_SHLX + rexw, a0, a2, a1);
+    } else {
+        tcg_out_modrm(s, OPC_SHIFT_cl + rexw, SHIFT_SHL, a0);
+    }
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+
+    /* For small constant 3-operand shift, use LEA.  */
+    if (a0 != a1 && a2 >= 1 && a2 <= 3) {
+        if (a2 == 1) {
+            /* shl $1,a1,a0 -> lea (a1,a1),a0 */
+            tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, a1, 0, 0);
+        } else {
+            /* shl $n,a1,a0 -> lea 0(,a1,n),a0 */
+            tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, -1, a1, a2, 0);
+        }
+        return;
+    }
+    tcg_out_mov(s, type, a0, a1);
+    tcg_out_shifti(s, SHIFT_SHL + rexw, a0, a2);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_shift,
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2879,21 +2922,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(shl):
-        /* For small constant 3-operand shift, use LEA.  */
-        if (const_a2 && a0 != a1 && (a2 - 1) < 3) {
-            if (a2 - 1 == 0) {
-                /* shl $1,a1,a0 -> lea (a1,a1),a0 */
-                tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, a1, 0, 0);
-            } else {
-                /* shl $n,a1,a0 -> lea 0(,a1,n),a0 */
-                tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, -1, a1, a2, 0);
-            }
-            break;
-        }
-        c = SHIFT_SHL;
-        vexop = OPC_SHLX;
-        goto gen_shift_maybe_vex;
     OP_32_64(shr):
         c = SHIFT_SHR;
         vexop = OPC_SHRX;
@@ -3759,8 +3787,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index cedfcda4a1..4aa3126a09 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1477,6 +1477,32 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_sll_w(s, a0, a1, a2);
+    } else {
+        tcg_out_opc_sll_d(s, a0, a1, a2);
+    }
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_slli_w(s, a0, a1, a2 & 0x1f);
+    } else {
+        tcg_out_opc_slli_d(s, a0, a1, a2 & 0x3f);
+    }
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1648,21 +1674,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_clzctz(s, OPC_CTZ_D, a0, a1, a2, c2, false);
         break;
 
-    case INDEX_op_shl_i32:
-        if (c2) {
-            tcg_out_opc_slli_w(s, a0, a1, a2 & 0x1f);
-        } else {
-            tcg_out_opc_sll_w(s, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_shl_i64:
-        if (c2) {
-            tcg_out_opc_slli_d(s, a0, a1, a2 & 0x3f);
-        } else {
-            tcg_out_opc_sll_d(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_shr_i32:
         if (c2) {
             tcg_out_opc_srli_w(s, a0, a1, a2 & 0x1f);
@@ -2363,8 +2374,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 2ece79c746..3841bf3d37 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1914,6 +1914,29 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_SLLV : OPC_DSLLV;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_sa(s, OPC_SLL, a0, a1, a2);
+    } else {
+        tcg_out_dsll(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2074,9 +2097,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_sar_i32:
         i1 = OPC_SRAV, i2 = OPC_SRA;
         goto do_shift;
-    case INDEX_op_shl_i32:
-        i1 = OPC_SLLV, i2 = OPC_SLL;
-        goto do_shift;
     case INDEX_op_shr_i32:
         i1 = OPC_SRLV, i2 = OPC_SRL;
         goto do_shift;
@@ -2105,13 +2125,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         i1 = OPC_DSRAV;
         goto do_shiftv;
-    case INDEX_op_shl_i64:
-        if (c2) {
-            tcg_out_dsll(s, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DSLLV;
-        goto do_shiftv;
     case INDEX_op_shr_i64:
         if (c2) {
             tcg_out_dsrl(s, a0, a1, a2);
@@ -2299,12 +2312,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
         return C_O2_I2(r, r, r, r);
-    case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotr_i32:
     case INDEX_op_rotl_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotr_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 80ee4d04c9..88cfcd1d91 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3122,6 +3122,30 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? SLW : SLD;
+    tcg_out32(s, insn | SAB(a1, a0, a2));
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    /* Limit immediate shift count lest we create an illegal insn.  */
+    if (type == TCG_TYPE_I32) {
+        tcg_out_shli32(s, a0, a1, a2 & 31);
+    } else {
+        tcg_out_shli64(s, a0, a1, a2 & 63);
+    }
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3272,14 +3296,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
         break;
 
-    case INDEX_op_shl_i32:
-        if (const_args[2]) {
-            /* Limit immediate shift count lest we create an illegal insn.  */
-            tcg_out_shli32(s, args[0], args[1], args[2] & 31);
-        } else {
-            tcg_out32(s, SLW | SAB(args[1], args[0], args[2]));
-        }
-        break;
     case INDEX_op_shr_i32:
         if (const_args[2]) {
             /* Limit immediate shift count lest we create an illegal insn.  */
@@ -3325,14 +3341,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_brcond2(s, args, const_args);
         break;
 
-    case INDEX_op_shl_i64:
-        if (const_args[2]) {
-            /* Limit immediate shift count lest we create an illegal insn.  */
-            tcg_out_shli64(s, args[0], args[1], args[2] & 63);
-        } else {
-            tcg_out32(s, SLD | SAB(args[1], args[0], args[2]));
-        }
-        break;
     case INDEX_op_shr_i64:
         if (const_args[2]) {
             /* Limit immediate shift count lest we create an illegal insn.  */
@@ -4206,12 +4214,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 38ba898042..372c4e1651 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2144,6 +2144,27 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_SLLW : OPC_SLL;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_SLLIW : OPC_SLLI;
+    unsigned mask = type == TCG_TYPE_I32 ? 31 : 63;
+    tcg_out_opc_imm(s, insn, a0, a1, a2 & mask);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2257,21 +2278,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_shl_i32:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_SLLIW, a0, a1, a2 & 0x1f);
-        } else {
-            tcg_out_opc_reg(s, OPC_SLLW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_shl_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_SLLI, a0, a1, a2 & 0x3f);
-        } else {
-            tcg_out_opc_reg(s, OPC_SLL, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_shr_i32:
         if (c2) {
             tcg_out_opc_imm(s, OPC_SRLIW, a0, a1, a2 & 0x1f);
@@ -2758,12 +2764,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 8702d8c928..ed68054664 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2445,6 +2445,36 @@ static const TCGOutOpBinary outop_remu = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_shl_int(TCGContext *s, TCGType type, TCGReg dst,
+                         TCGReg src, TCGReg v, tcg_target_long i)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_sh64(s, RSY_SLLG, dst, src, v, i);
+    } else if (dst == src) {
+        tcg_out_sh32(s, RS_SLL, dst, v, i);
+    } else {
+        tcg_out_sh64(s, RSY_SLLK, dst, src, v, i);
+    }
+}
+
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tgen_shl_int(s, type, a0, a1, a2, 0);
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_shl_int(s, type, a0, a1, TCG_REG_NONE, a2);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2574,9 +2604,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_shl_i32:
-        op = RS_SLL;
-        op2 = RSY_SLLK;
     do_shift32:
         a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
         if (a0 == a1) {
@@ -2746,8 +2773,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_insn(s, RRFa, MGRK, args[1], args[2], args[3]);
         break;
 
-    case INDEX_op_shl_i64:
-        op = RSY_SLLG;
     do_shift64:
         if (const_args[2]) {
             tcg_out_sh64(s, op, args[0], args[1], TCG_REG_NONE, args[2]);
@@ -3346,7 +3371,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i32:
@@ -3363,7 +3387,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_clz_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
         return C_O1_I2(r, r, ri);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index d465c8dd06..6b320a8622 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1484,6 +1484,27 @@ static const TCGOutOpBinary outop_remu = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? SHIFT_SLL : SHIFT_SLLX;
+    tcg_out_arith(s, a0, a1, a2, insn);
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? SHIFT_SLL : SHIFT_SLLX;
+    uint32_t mask = type == TCG_TYPE_I32 ? 31 : 63;
+    tcg_out_arithi(s, a0, a1, a2 & mask, insn);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1587,8 +1608,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_st32_i64:
         tcg_out_ldst(s, a0, a1, a2, STW);
         break;
-    case INDEX_op_shl_i32:
-        c = SHIFT_SLL;
     do_shift32:
         /* Limit immediate shift count lest we create an illegal insn.  */
         tcg_out_arithc(s, a0, a1, a2 & 31, c2, c);
@@ -1656,8 +1675,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_st_i64:
         tcg_out_ldst(s, a0, a1, a2, STX);
         break;
-    case INDEX_op_shl_i64:
-        c = SHIFT_SLLX;
     do_shift64:
         /* Limit immediate shift count lest we create an illegal insn.  */
         tcg_out_arithc(s, a0, a1, a2 & 63, c2, c);
@@ -1751,8 +1768,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index eb30fd04ba..748bb8118f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -79,8 +79,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
@@ -778,6 +776,17 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_shl_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_shl,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -862,7 +871,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(shl)
     CASE_32_64(shr)
     CASE_32_64(sar)
     CASE_32_64(rotl)     /* Optional (TCG_TARGET_HAS_rot_*). */
-- 
2.43.0


