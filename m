Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F5CC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnxH-000649-SK; Sun, 16 Feb 2025 18:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwf-0004OO-Ss
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:08 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwZ-0006S6-KF
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:02 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fa8ac56891so5361238a91.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748056; x=1740352856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O0mOItUH/2VSQ6VzWsX0BDE0pFuGuEyJkKNip3d2Yxk=;
 b=U5ZwnKusrs82YTDh07QYzN8aRHFVF3xHIgy3/496aEmGcLjaBj9olgKsWdzPlpfCrB
 Ep9X41JcvxoulGWdIcWrHjKTpL0tv+ZeMIAB9w52zONP2FLFSKoLs3H4n/mMzh2+lf5v
 UtlASEwmp2702Q3e+L3ILA8QVjR2ihfIpr6HnPf4qVjF8tthT+dfGOZ/F74+NWwMh1Yb
 79Y2oVNYkkwsfSz5O0aM/OrFoVcWbarvbvLas6xq9oXzFvLuzzyxVaKuN3kdOL+tHemP
 4hfv86DTWxuXTtd5OjUa37SLvvgODeHcVSxYmuJdNBUH7tN429hJvthiQjYsCXCkL3RS
 xbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748056; x=1740352856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0mOItUH/2VSQ6VzWsX0BDE0pFuGuEyJkKNip3d2Yxk=;
 b=EbLa80gW3Co8QBBhhvpRYJzU0yO7ONYmbhdRQAph7uPZ3/aQBS/Tm7boNlS+unglXa
 MqmrbFSHig5kIQdpt/0DXXgEl0UWJdKjThjl49Haxd8MJaoAx+T7JFyunDFS8b2IF5BM
 DrgIb/ED4mEdoupLCdL73+nWD2q9IM0IB0SwLJuohLZe0MBcunk4N0QzHCgsywlca001
 4MHbzusRPLUkgmgPiaGkiS0enAEuFm1SOK1wbu056cvO7lNP+1BBIp5lVXBhN3MHvlj1
 J/eeuYAMKEkoWKSC69kaD2tokiTYHxK1F8rnttQJh4smYm31ajydNW85HSn2fIHmxRht
 d1PA==
X-Gm-Message-State: AOJu0Yy3QzxjlNE0w/l6cl6xaEr44AViUDrJMmSjZWQJg9OVsocQHkWK
 zSbZVzXzWTVEo/Y5fHOdCtbah5fXp+rwKO7bNqe/41+vqytEQSZzfATIYTZKYWN9AntHt90UKVo
 q
X-Gm-Gg: ASbGnctjcABTcjVOf1BUoleSYPJWyIVGZ5Sauveu4tE2qQ1hxIszOO+JNmZuX40EU5G
 attPLoT5Voh2zs/XaW7evQ6XSc9nbLXuY/b4IAIQUlAuyerYajFEmLWWnCMl/xHvkqao/YkjdH7
 TmLvl6IFMaYZtp/76YlQ9QX2xc9L54eiqbXftsTyr0P3cofhuKjLAP3rjqASJWEntPLZIY3y8GG
 TrmDdbo7/wLxMvhxvwgdEUTRbXCPJOVEsX99PAjOOhhDUuKU61Q0FrV1DQQqFNziNb3Q0XBigNC
 GqSmGWSuXxyiFPlqB2dYS3BW1jcrWOrXH0Qj5G/87hTa418=
X-Google-Smtp-Source: AGHT+IEOjAbtohFuQ6frMEo7ijXaDIVMI5IewB7D9Imgaf3xsRPiZe1WRMxix+V/55hBCeK2mIBFIA==
X-Received: by 2002:a17:90b:2789:b0:2ee:f80c:6889 with SMTP id
 98e67ed59e1d1-2fc4116bc28mr12791632a91.33.1739748056468; 
 Sun, 16 Feb 2025 15:20:56 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 134/162] tcg/arm: Implement add/sub carry opcodes
Date: Sun, 16 Feb 2025 15:09:43 -0800
Message-ID: <20250216231012.2808572-135-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
 tcg/arm/tcg-target-con-set.h |   2 +
 tcg/arm/tcg-target.c.inc     | 165 +++++++++++++++++++++++++++++++++--
 2 files changed, 159 insertions(+), 8 deletions(-)

diff --git a/tcg/arm/tcg-target-con-set.h b/tcg/arm/tcg-target-con-set.h
index f46a8444fb..a44625ba63 100644
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
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 2a7b0f09db..c60b7e5faa 100644
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
@@ -1832,21 +1834,74 @@ static const TCGOutOpBinary outop_add = {
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
@@ -2158,21 +2213,115 @@ static const TCGOutOpSubtract outop_sub = {
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
-- 
2.43.0


