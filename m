Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A879EC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RC3-0007Zm-2A; Fri, 25 Apr 2025 18:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAy-0003hp-O7
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:44 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAv-0001sE-Kl
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:40 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso2996671b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618736; x=1746223536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fQyxP2bCNTdNzUewP4bCl+oELM2hSUH7UnDgd98J9Q=;
 b=hNtpMUm1pjWbM7FkpzL5WLeMHeadqmxyT9Iix5Gdxc2KQoqTT+eXdP94K1dT703Z7V
 Zxp6wcQgjqYSbROhmIsXQozdYpqXJjhPB65pVMbSDQol+8z7xDWovJLumtWg+tbUlWZ1
 spu6ntbVJ/LoFjbSAdTqhhDyibCKGyeVv2B5brMTvBotSuKM2XA9jiUloK4dE9u6V+jr
 wzH/AWqUFXkWGEobHTITXmOY1hM0HGhfJwSk6hogQy5v6xAEIPjcf8rfjxFmXrm9wqj2
 OR1q0E1S+XnNsBECYpYmrXqTEMSMkhPbMLKwzVDm9wHPg9eVUcqe+oqYRhOcMUo3ha2T
 fHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618736; x=1746223536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fQyxP2bCNTdNzUewP4bCl+oELM2hSUH7UnDgd98J9Q=;
 b=wMGpzOb0B2r0Bp0KrtN0w3IsqMijk9sM8ApQu1JvSZP43RT6DM5GGWr6KAA0K2wmVi
 vyvBMQRzFkS2elr9CwX3uABVwzgJ3D0POEJAsdOIH0vSOjxcjY6v583DPa2ZE3QTQ3+a
 +dDF4sE2wSXFChBnloKPcvlHbZ8fXWg5+TY+9WjbHfWKA5ApEkV6pFbQD+lj8b9agp11
 n3l27Wr+lABYz1qFvqFCiXvNb1JHLieMrX/ncjJuj4/uS9e2PS/9wf/Oz9OR1k3Fb5CM
 w1zbS0DMjekgOVDX4NO1haD3rkl6QwaAeNPh8a8N9CCopeGWO2KPfYyveky2Ja/goia1
 ROUQ==
X-Gm-Message-State: AOJu0YyKC+PHAsPkjUPIxd5bD5RoFkPr4VfKrqle0su3kxFhiMycjxnV
 m+Nfl7fU6X1RWqj+MQ/BWK2dIlVtIsC1icqAu7xUsdrHcMtNcpSEB+9oVNgKRbqL1ap5X6YxApM
 T
X-Gm-Gg: ASbGncs4ZaTKU7nJTqKub6d9zFN0c54hKtTTxANkvmrsbzmJFSlQ11wXJBfZ7/083HU
 H4N1DTmIpraJ2xg3dvcEdjsB5ir8JJ5I0vZ4kwBYB/NbW5+YcFX2uECMa67rNPDfpSErBFV88Wu
 9WNmT0VYOpY7MSjcqIDVeWYRin1tmIKENeAt9fzQUg6zqnfGRRE+GxwkoFSjRwESXsGIJs1fvr4
 dckMG4dCgNjXm8FAfaA+jBhuIQCNVrByXk8p0aRYm/ge/76FnLwqH9/QRN6MDXxLxQE3TyluIZh
 gWYNv1lcEbLBElZfJZQBjb0xrACW9W6CxF8y9KRVbQi0XagB0pHdDLKt9dRiCryUbBI4WXmUGn4
 =
X-Google-Smtp-Source: AGHT+IEnXTfxFLFvWrz4Izx6gJt+CbxYtlvD5Q+ipLqnZPRosh2mH5wsTI2cQ8FxM/5uFwmHL13ysA==
X-Received: by 2002:a05:6a00:3c91:b0:732:a24:7354 with SMTP id
 d2e1a72fcca58-73fd690183fmr5393161b3a.4.1745618736193; 
 Fri, 25 Apr 2025 15:05:36 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 137/159] tcg/arm: Implement add/sub carry opcodes
Date: Fri, 25 Apr 2025 14:54:31 -0700
Message-ID: <20250425215454.886111-138-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target-con-set.h |   4 +-
 tcg/arm/tcg-target-has.h     |   4 +-
 tcg/arm/tcg-target.c.inc     | 212 ++++++++++++++++++++++++++---------
 3 files changed, 161 insertions(+), 59 deletions(-)

diff --git a/tcg/arm/tcg-target-con-set.h b/tcg/arm/tcg-target-con-set.h
index f46a8444fb..16b1193228 100644
--- a/tcg/arm/tcg-target-con-set.h
+++ b/tcg/arm/tcg-target-con-set.h
@@ -31,6 +31,8 @@ C_O1_I2(r, r, rIK)
 C_O1_I2(r, r, rIN)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, rI, r)
+C_O1_I2(r, rI, rIK)
+C_O1_I2(r, rI, rIN)
 C_O1_I2(r, rZ, rZ)
 C_O1_I2(w, 0, w)
 C_O1_I2(w, w, w)
@@ -43,5 +45,3 @@ C_O1_I4(r, r, rIN, rIK, 0)
 C_O2_I1(e, p, q)
 C_O2_I2(e, p, q, q)
 C_O2_I2(r, r, r, r)
-C_O2_I4(r, r, r, r, rIN, rIK)
-C_O2_I4(r, r, rI, rI, rIN, rIK)
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 3973df1f12..f4bd15c68a 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -24,8 +24,8 @@ extern bool use_neon_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index aa0397520d..3c9042ebfa 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -178,6 +178,8 @@ typedef enum {
     INSN_DMB_ISH   = 0xf57ff05b,
     INSN_DMB_MCR   = 0xee070fba,
 
+    INSN_MSRI_CPSR = 0x0360f000,
+
     /* Architected nop introduced in v6k.  */
     /* ??? This is an MSR (imm) 0,0,0 insn.  Anyone know if this
        also Just So Happened to do nothing on pre-v6k so that we
@@ -1826,21 +1828,74 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_addco(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_ADD | TO_CPSR,
+                    a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_addco_imm(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_IN(s, COND_AL, ARITH_ADD | TO_CPSR, ARITH_SUB | TO_CPSR,
+                   a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, rIN),
+    .out_rrr = tgen_addco,
+    .out_rri = tgen_addco_imm,
 };
 
+static void tgen_addci(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_ADC, a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_addci_imm(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_IK(s, COND_AL, ARITH_ADC, ARITH_SBC, a0, a1, a2);
+}
+
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, rIK),
+    .out_rrr = tgen_addci,
+    .out_rri = tgen_addci_imm,
 };
 
+static void tgen_addcio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_ADC | TO_CPSR,
+                    a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_addcio_imm(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_IK(s, COND_AL, ARITH_ADC | TO_CPSR, ARITH_SBC | TO_CPSR,
+                   a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, rIK),
+    .out_rrr = tgen_addcio,
+    .out_rri = tgen_addcio_imm,
 };
 
+/* Set C to @c; NZVQ all set to 0. */
+static void tcg_out_movi_apsr_c(TCGContext *s, bool c)
+{
+    int imm12 = encode_imm_nofail(c << 29);
+    tcg_out32(s, (COND_AL << 28) | INSN_MSRI_CPSR | 0x80000 | imm12);
+}
+
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_movi_apsr_c(s, 1);
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -2152,21 +2207,115 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rir = tgen_subfi,
 };
 
+static void tgen_subbo_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_SUB | TO_CPSR,
+                    a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_subbo_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_IN(s, COND_AL, ARITH_SUB | TO_CPSR, ARITH_ADD | TO_CPSR,
+                   a0, a1, a2);
+}
+
+static void tgen_subbo_rir(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tcg_out_dat_imm(s, COND_AL, ARITH_RSB | TO_CPSR,
+                    a0, a2, encode_imm_nofail(a1));
+}
+
+static void tgen_subbo_rii(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
+{
+    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, a2);
+    tgen_subbo_rir(s, TCG_TYPE_I32, a0, a1, TCG_REG_TMP);
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rI, rIN),
+    .out_rrr = tgen_subbo_rrr,
+    .out_rri = tgen_subbo_rri,
+    .out_rir = tgen_subbo_rir,
+    .out_rii = tgen_subbo_rii,
 };
 
+static void tgen_subbi_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_SBC,
+                    a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_subbi_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_IK(s, COND_AL, ARITH_SBC, ARITH_ADC, a0, a1, a2);
+}
+
+static void tgen_subbi_rir(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tcg_out_dat_imm(s, COND_AL, ARITH_RSC, a0, a2, encode_imm_nofail(a1));
+}
+
+static void tgen_subbi_rii(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
+{
+    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, a2);
+    tgen_subbi_rir(s, TCG_TYPE_I32, a0, a1, TCG_REG_TMP);
+}
+
 static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rI, rIK),
+    .out_rrr = tgen_subbi_rrr,
+    .out_rri = tgen_subbi_rri,
+    .out_rir = tgen_subbi_rir,
+    .out_rii = tgen_subbi_rii,
 };
 
+static void tgen_subbio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_SBC | TO_CPSR,
+                    a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_subbio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_IK(s, COND_AL, ARITH_SBC | TO_CPSR, ARITH_ADC | TO_CPSR,
+                   a0, a1, a2);
+}
+
+static void tgen_subbio_rir(TCGContext *s, TCGType type,
+                            TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tcg_out_dat_imm(s, COND_AL, ARITH_RSC | TO_CPSR,
+                    a0, a2, encode_imm_nofail(a1));
+}
+
+static void tgen_subbio_rii(TCGContext *s, TCGType type,
+                            TCGReg a0, tcg_target_long a1, tcg_target_long a2)
+{
+    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, a2);
+    tgen_subbio_rir(s, TCG_TYPE_I32, a0, a1, TCG_REG_TMP);
+}
+
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rI, rIK),
+    .out_rrr = tgen_subbio_rrr,
+    .out_rri = tgen_subbio_rri,
+    .out_rir = tgen_subbio_rir,
+    .out_rii = tgen_subbio_rii,
 };
 
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_movi_apsr_c(s, 0);  /* borrow = !carry */
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
@@ -2369,8 +2518,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGArg a0, a1, a2, a3, a4, a5;
-
     switch (opc) {
     case INDEX_op_goto_ptr:
         tcg_out_b_reg(s, COND_AL, args[0]);
@@ -2404,47 +2551,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st32(s, COND_AL, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_add2_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        a3 = args[3], a4 = args[4], a5 = args[5];
-        if (a0 == a3 || (a0 == a5 && !const_args[5])) {
-            a0 = TCG_REG_TMP;
-        }
-        tcg_out_dat_rIN(s, COND_AL, ARITH_ADD | TO_CPSR, ARITH_SUB | TO_CPSR,
-                        a0, a2, a4, const_args[4]);
-        tcg_out_dat_rIK(s, COND_AL, ARITH_ADC, ARITH_SBC,
-                        a1, a3, a5, const_args[5]);
-        tcg_out_mov_reg(s, COND_AL, args[0], a0);
-        break;
-    case INDEX_op_sub2_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        a3 = args[3], a4 = args[4], a5 = args[5];
-        if ((a0 == a3 && !const_args[3]) || (a0 == a5 && !const_args[5])) {
-            a0 = TCG_REG_TMP;
-        }
-        if (const_args[2]) {
-            if (const_args[4]) {
-                tcg_out_movi32(s, COND_AL, a0, a4);
-                a4 = a0;
-            }
-            tcg_out_dat_rI(s, COND_AL, ARITH_RSB | TO_CPSR, a0, a4, a2, 1);
-        } else {
-            tcg_out_dat_rIN(s, COND_AL, ARITH_SUB | TO_CPSR,
-                            ARITH_ADD | TO_CPSR, a0, a2, a4, const_args[4]);
-        }
-        if (const_args[3]) {
-            if (const_args[5]) {
-                tcg_out_movi32(s, COND_AL, a1, a5);
-                a5 = a1;
-            }
-            tcg_out_dat_rI(s, COND_AL, ARITH_RSC, a1, a5, a3, 1);
-        } else {
-            tcg_out_dat_rIK(s, COND_AL, ARITH_SBC, ARITH_ADC,
-                            a1, a3, a5, const_args[5]);
-        }
-        tcg_out_mov_reg(s, COND_AL, args[0], a0);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
@@ -2490,10 +2596,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i32:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add2_i32:
-        return C_O2_I4(r, r, r, r, rIN, rIK);
-    case INDEX_op_sub2_i32:
-        return C_O2_I4(r, r, rI, rI, rIN, rIK);
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, q);
     case INDEX_op_qemu_ld_i64:
-- 
2.43.0


