Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03331C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mHR-0003Qj-SL; Tue, 15 Apr 2025 15:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5u-00009X-Pe
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:20 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m57-0004Vc-B1
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:16 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so5880625b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745769; x=1745350569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0Oaaxmj72NkI+ON/gIZofu2weUVs2AFw07BYqVLBK6c=;
 b=kaSh1SqbU/pP1W4OPkFFMsEKWbR1T2cINg34+/J4yDW4iOnryvxfmO2KfscJmo48Z9
 f5385ZsoizIDryq+DUzU0tBBZ3U0itTCrduzags3Ux7RDWXyFv3D2bsExCXLPJ4baec7
 hlu88rW4ciWFn/vZearnpLTtvArwog8ZOca/HcehOjpHQ6Z2HElSC8Sbbdxn5l2eyp7+
 pMCvKDCeuo3an6JdxXRqfexBlp/MldCMb5lk7IU/6W86Ul+sG5T+bET0+6O0w3jZp37c
 iFlsLxOt/sB+XsdutT8XV/GCB3Bp8tHPmZ3ETUN/bmcXuGDxVskXrjcT8rqAm+lqLwZp
 pEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745769; x=1745350569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Oaaxmj72NkI+ON/gIZofu2weUVs2AFw07BYqVLBK6c=;
 b=r6NTwRrLosJDBdgSunPeN4rQVWqAuwo9L0W8wfCE8gbM7ohWHEaquOJnGSkOunv+uP
 vqRxzk2WA7KooqP3JtnfsgLVZLFTKgfzU/cta5UDCd8g3n6AogIFR/BiQbwDOCECRaz/
 odYhPryGcWiwjHhKk7g0sg30Epa/CdBulcl/syG9QX0NpjyRgNXiCWS6+D3a91u+itzf
 VQdwwsLyaOvV+8z6JXAK6OePhUqWZmCjJzik90VKFBBTRoxFJdZERbTpAvvUNr6H7kXU
 XwnqQGgUcTebXUvnk/GlP21PCc06zg8qufDZCd4I1HiCh79AGy2Uvn8zCTtJRMDxQ+UN
 NX0A==
X-Gm-Message-State: AOJu0YxZMwXXV8uKQeNEg7vIi0Sg9OQFHCnVTHeYqOi2nTWMMrQD5O9N
 Z9NZTuM/wBZ0jFpc5DxxEhDXPK4T1fyi2wnuW/Sx/y9F8HFh+3vp3RcMyTgFaLSzmeAenBgerWL
 f
X-Gm-Gg: ASbGncscNv52yWEzvhRNXrY/qwZRGkpjVucxBjCbTdbdob10EksPCfW1fL27/O73xUb
 /9EVy4lmpyyqYzbjn+6XipHMKkEPJcyCTw1NpWQWXLD3lQDd4FW0zivXCBzUTRF9rEpDUMIXwnT
 GCkE18rJjzP9xZVhVc0HDKxnGlTv/awmh3F9zPY6ZzAhP/H3hNWudgWw+jcRWygiB5jmQTR71++
 uY2+xs0j2xZKCyAG69hRCe/5lPSMoVScJx05LedImbClu7bXDk1/DKBFVfP3I2qpRzfyS2i1z/B
 31e2SbqyJ1qQmbV6H376KKteTv0vi2ijevd1bmdOpyUYUhXDirOQ5ahnBNNuOMNsb0uh5frqsKw
 mRY3qAtRDAA==
X-Google-Smtp-Source: AGHT+IHWEuxe8usKp17Alf2PQQYW6+5XqRuChJzZGIJpJScZDVm1mZnI9CkafTQbNEpVkTwN+SRXkw==
X-Received: by 2002:a05:6a00:6c99:b0:730:8a0a:9f09 with SMTP id
 d2e1a72fcca58-73c1fb0ef40mr1029606b3a.18.1744745769087; 
 Tue, 15 Apr 2025 12:36:09 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 135/163] tcg/arm: Implement add/sub carry opcodes
Date: Tue, 15 Apr 2025 12:24:46 -0700
Message-ID: <20250415192515.232910-136-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
index aa0397520d..c464c54ffd 100644
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
-- 
2.43.0


