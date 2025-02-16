Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE65C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyP-0007iF-87; Sun, 16 Feb 2025 18:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwo-0004Vk-6k
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:15 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwi-0006Tk-Mj
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:13 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so5727022a91.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748065; x=1740352865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5snSNelfjAuN0Iv9eBzGjW9mLu+ft67qxWZukX4mhf4=;
 b=Mj16aWMtlsXZfPZ+X1QKlYGj/87yKD25YCM0Q+Mo5JE03hQf+C4YGXiM8QY4kThwkz
 Xe/RvdDXjRXhSLScm3WVNGlR2sNjRX1YZxVfK/hrFE0mlFrzZ0/lXK/3ebq+Z02Vb9E6
 rNTxEMOVljJOCr3R7tEy5MvC1ujI0TYfqn0KRQQMuhBbTzCBRaJSPKqNbzqOJexPfNqM
 X/ouPRcw5+ipZsjMoTH8/RbMz8aacqhcmV29olQC2lmu6R0ahnB+5Hae3f7jXf6ir9iT
 gQzHBor8PB+QAWseXW754uFmz0rkaMbbMCnCsNYrYYCtuKg5eB6Wg96WObEQA+AWCL0B
 6uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748065; x=1740352865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5snSNelfjAuN0Iv9eBzGjW9mLu+ft67qxWZukX4mhf4=;
 b=KJ8LOvxYGe3Svy+TT9GnFv2HffjGBaIyJqvt71xsc41LfdZL+s14O42UKSrE0TIrc4
 f5uNHDx+aUdDZ9GxgKj9CgXpX11wWT0XYTMNZn3DpjsjFNmhEkmg0l0YctHQgovHxyEt
 2LwAislR0KoOLYcMyWNPGFYp3meUB9J632EJQrSUCKw1OnvmTlkMPF8fev5JZePBsYHP
 5sd3zFkx9/LsAmYykhPuXN72wCT752/VEgozm0QyPBHDNMEJEZgtlPtdg+J1+A9MCjGr
 KomGBkOFQ790Q7vhXirVCIuVGbNgv1eOTe/I0EfDqsjpznh8SsdqDviU5oKfFSao66eK
 hS5g==
X-Gm-Message-State: AOJu0YzSGWuIaA7YtdHHxBwf4o9N0Qrkj6JxsMExU+9k0NQoRo/SQC7K
 r3J+wEFeiRSPE/LCVaK3lxQVdonVkZKddnvfez4vJiCDtaRjsJq64WesnmWATy+CK0yjt070QKs
 P
X-Gm-Gg: ASbGncs1OeZXwsB5vekgxULiLAA/KG+/K0lQEfu13/vt2wkUZksPONLEM+UDgA+5gte
 83l5em9YUTDM0+ftRADiMo3p07zOxtp55j+hxpquP5dW32m/7yJKe5AhFibpO08e/GRZNjo6gY+
 9QhoCq/IlXcuACrgOVIMNm1vS2YZCv/UZ9Imbb8515CLsSNLnTrbRKd8cHOexv0r6/gSW/97Skf
 NrUcyblTDM7/AkPOqOgho/AXN12uFkT83kpFDS5ceBA6ZIIapOKvxonz7wMilI7yHmtFf9hUANg
 u+HJ9hVuaIp8HxcElJx/PmsyLlZifACpMZB28AvDcVtCIIM=
X-Google-Smtp-Source: AGHT+IHTd/IqhPjTQQ4jlEWx/4agYPTsi/+eup1LNQDqaxs5sgqdZJF9GGe2LbeKa3PAFCds5I1WGA==
X-Received: by 2002:a17:90b:3904:b0:2ee:5111:a54b with SMTP id
 98e67ed59e1d1-2fc4115c78dmr10359637a91.31.1739748064420; 
 Sun, 16 Feb 2025 15:21:04 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 144/162] tcg/sparc64: Implement add/sub carry opcodes
Date: Sun, 16 Feb 2025 15:09:53 -0800
Message-ID: <20250216231012.2808572-145-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
 tcg/sparc64/tcg-target-con-set.h |   3 +
 tcg/sparc64/tcg-target.c.inc     | 244 ++++++++++++++++++++++++++++++-
 2 files changed, 239 insertions(+), 8 deletions(-)

diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
index 8cec396173..37cb190450 100644
--- a/tcg/sparc64/tcg-target-con-set.h
+++ b/tcg/sparc64/tcg-target-con-set.h
@@ -15,6 +15,9 @@ C_O0_I2(r, rJ)
 C_O1_I1(r, r)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, rJ)
+C_O1_I2(r, r, rZ)
+C_O1_I2(r, rZ, rJ)
+C_O1_I2(r, rZ, rZ)
 C_O1_I4(r, r, rJ, rI, 0)
 C_O2_I2(r, r, r, r)
 C_O2_I4(r, r, rz, rz, rJ, rJ)
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 350a7f6332..93bb88b05f 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -199,7 +199,9 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define ARITH_SUB  (INSN_OP(2) | INSN_OP3(0x04))
 #define ARITH_SUBCC (INSN_OP(2) | INSN_OP3(0x14))
 #define ARITH_ADDC (INSN_OP(2) | INSN_OP3(0x08))
+#define ARITH_ADDCCC (INSN_OP(2) | INSN_OP3(0x18))
 #define ARITH_SUBC (INSN_OP(2) | INSN_OP3(0x0c))
+#define ARITH_SUBCCC (INSN_OP(2) | INSN_OP3(0x1c))
 #define ARITH_UMUL (INSN_OP(2) | INSN_OP3(0x0a))
 #define ARITH_SMUL (INSN_OP(2) | INSN_OP3(0x0b))
 #define ARITH_UDIV (INSN_OP(2) | INSN_OP3(0x0e))
@@ -211,6 +213,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define ARITH_MOVR (INSN_OP(2) | INSN_OP3(0x2f))
 
 #define ARITH_ADDXC (INSN_OP(2) | INSN_OP3(0x36) | INSN_OPF(0x11))
+#define ARITH_ADDXCCC (INSN_OP(2) | INSN_OP3(0x36) | INSN_OPF(0x13))
 #define ARITH_UMULXHI (INSN_OP(2) | INSN_OP3(0x36) | INSN_OPF(0x16))
 
 #define SHIFT_SLL  (INSN_OP(2) | INSN_OP3(0x25))
@@ -223,6 +226,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 
 #define RDY        (INSN_OP(2) | INSN_OP3(0x28) | INSN_RS1(0))
 #define WRY        (INSN_OP(2) | INSN_OP3(0x30) | INSN_RD(0))
+#define WRCCR      (INSN_OP(2) | INSN_OP3(0x30) | INSN_RD(2))
 #define JMPL       (INSN_OP(2) | INSN_OP3(0x38))
 #define RETURN     (INSN_OP(2) | INSN_OP3(0x39))
 #define SAVE       (INSN_OP(2) | INSN_OP3(0x3c))
@@ -1382,21 +1386,150 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_addco_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_ADDCC);
+}
+
+static void tgen_addco_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_arithi(s, a0, a1, a2, ARITH_ADDCC);
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_addco_rrr,
+    .out_rri = tgen_addco_rri,
 };
 
+static void tgen_addci_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_arith(s, a0, a1, a2, ARITH_ADDC);
+    } else if (use_vis3_instructions) {
+        tcg_out_arith(s, a0, a1, a2, ARITH_ADDXC);
+    } else {
+        tcg_out_arith(s, TCG_REG_T1, a1, a2, ARITH_ADD);  /* for CC */
+        tcg_out_arithi(s, a0, TCG_REG_T1, 1, ARITH_ADD);  /* for CS */
+        /* Select the correct result based on actual carry value. */
+        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, TCG_REG_T1, false);
+    }
+}
+
+static void tgen_addci_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_arithi(s, a0, a1, a2, ARITH_ADDC);
+    } else if (use_vis3_instructions) {
+        tcg_debug_assert(a2 == 0);
+        tcg_out_arith(s, a0, a1, TCG_REG_G0, ARITH_ADDXC);
+    } else if (a2 != 0) {
+        tcg_out_arithi(s, TCG_REG_T1, a1, a2, ARITH_ADD); /* for CC */
+        tcg_out_arithi(s, a0, TCG_REG_T1, 1, ARITH_ADD);  /* for CS */
+        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, TCG_REG_T1, false);
+    } else if (a0 == a1) {
+        tcg_out_arithi(s, TCG_REG_T1, a1, 1, ARITH_ADD);
+        tcg_out_movcc(s, COND_CS, MOVCC_XCC, a0, TCG_REG_T1, false);
+    } else {
+        tcg_out_arithi(s, a0, a1, 1, ARITH_ADD);
+	tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, a1, false);
+    }
+}
+
+static void tgen_addci_rir(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tgen_addci_rri(s, type, a0, a2, a1);
+}
+
+static void tgen_addci_rii(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
+{
+    tgen_addci_rri(s, type, a0, TCG_REG_G0, a2);
+}
+
+static TCGConstraintSetIndex cset_addci(TCGType type, unsigned flags)
+{
+    if (use_vis3_instructions && type == TCG_TYPE_I64) {
+        /* Note that ADDXC doesn't accept immediates.  */
+        return C_O1_I2(r, rZ, rZ);
+    }
+    return C_O1_I2(r, rZ, rJ);
+}
+
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addci,
+    .out_rrr = tgen_addci_rrr,
+    .out_rri = tgen_addci_rri,
+    .out_rir = tgen_addci_rir,
+    .out_rii = tgen_addci_rii,
 };
 
+/* Copy %xcc.c to %icc.c */
+static void tcg_out_dup_xcc_c(TCGContext *s)
+{
+    if (use_vis3_instructions) {
+        tcg_out_arith(s, TCG_REG_T1, TCG_REG_G0, TCG_REG_G0, ARITH_ADDXC);
+    } else {
+        tcg_out_movi_s13(s, TCG_REG_T1, 0);
+        tcg_out_movcc(s, COND_CS, MOVCC_XCC, TCG_REG_T1, 1, true);
+    }
+    /* Write carry-in into %icc via {0,1} + -1. */
+    tcg_out_arithi(s, TCG_REG_G0, TCG_REG_T1, -1, ARITH_ADDCC);
+}
+
+static void tgen_addcio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        if (use_vis3_instructions) {
+            tcg_out_arith(s, a0, a1, a2, ARITH_ADDXCCC);
+            return;
+        }
+        tcg_out_dup_xcc_c(s);
+    }
+    tcg_out_arith(s, a0, a1, a2, ARITH_ADDCCC);
+}
+
+static void tgen_addcio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type != TCG_TYPE_I32) {
+        if (use_vis3_instructions) {
+            tcg_debug_assert(a2 == 0);
+            tcg_out_arith(s, a0, a1, TCG_REG_G0, ARITH_ADDXCCC);
+            return;
+        }
+        tcg_out_dup_xcc_c(s);
+    }
+    tcg_out_arithi(s, a0, a1, a2, ARITH_ADDCCC);
+}
+
+static TCGConstraintSetIndex cset_addcio(TCGType type, unsigned flags)
+{
+    if (use_vis3_instructions && type == TCG_TYPE_I64) {
+        /* Note that ADDXC doesn't accept immediates.  */
+        return C_O1_I2(r, r, rZ);
+    }
+    return C_O1_I2(r, r, rJ);
+}
+
 static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addcio,
+    .out_rrr = tgen_addcio_rrr,
+    .out_rri = tgen_addcio_rri,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    /* 0x11 -> xcc = nzvC, icc = nzvC */
+    tcg_out_arithi(s, 0, TCG_REG_G0, 0x11, WRCCR);
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -1735,21 +1868,116 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static void tgen_subbo_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_SUBCC);
+}
+
+static void tgen_subbo_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_arithi(s, a0, a1, a2, ARITH_SUBCC);
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_subbo_rrr,
+    .out_rri = tgen_subbo_rri,
 };
 
+static void tgen_subbi_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_arith(s, a0, a1, a2, ARITH_ADDC);
+    } else {
+        tcg_out_arith(s, TCG_REG_T1, a1, a2, ARITH_SUB);  /* for CC */
+        tcg_out_arithi(s, a0, TCG_REG_T1, 1, ARITH_SUB);  /* for CS */
+        /* Select the correct result based on actual borrow value. */
+        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, TCG_REG_T1, false);
+    }
+}
+
+static void tgen_subbi_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_arithi(s, a0, a1, a2, ARITH_ADDC);
+    } else if (a2 != 0) {
+        tcg_out_arithi(s, TCG_REG_T1, a1, a2, ARITH_SUB);  /* for CC */
+        tcg_out_arithi(s, a0, TCG_REG_T1, 1, ARITH_SUB);   /* for CS */
+        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, TCG_REG_T1, false);
+    } else if (a0 == a1) {
+        tcg_out_arithi(s, TCG_REG_T1, a1, 1, ARITH_SUB);
+        tcg_out_movcc(s, COND_CS, MOVCC_XCC, a0, TCG_REG_T1, false);
+    } else {
+        tcg_out_arithi(s, a0, a1, 1, ARITH_SUB);
+        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, a1, false);
+    }
+}
+
+static void tgen_subbi_rir(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tgen_subbi_rrr(s, type, a0, TCG_REG_G0, a2);
+}
+
+static void tgen_subbi_rii(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
+{
+    tgen_subbi_rri(s, type, a0, TCG_REG_G0, a2);
+}
+
 static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rZ, rJ),
+    .out_rrr = tgen_subbi_rrr,
+    .out_rri = tgen_subbi_rri,
+    .out_rir = tgen_subbi_rir,
+    .out_rii = tgen_subbi_rii,
 };
 
+static void tgen_subbio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_dup_xcc_c(s);
+    }
+    tcg_out_arith(s, a0, a1, a2, ARITH_SUBCCC);
+}
+
+static void tgen_subbio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_dup_xcc_c(s);
+    }
+    tcg_out_arithi(s, a0, a1, a2, ARITH_SUBCCC);
+}
+
+static void tgen_subbio_rir(TCGContext *s, TCGType type,
+                            TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tgen_subbio_rrr(s, type, a0, TCG_REG_G0, a2);
+}
+
+static void tgen_subbio_rii(TCGContext *s, TCGType type,
+                            TCGReg a0, tcg_target_long a1, tcg_target_long a2)
+{
+    tgen_subbio_rri(s, type, a0, TCG_REG_G0, a2);
+}
+
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rZ, rJ),
+    .out_rrr = tgen_subbio_rrr,
+    .out_rri = tgen_subbio_rri,
+    .out_rir = tgen_subbio_rir,
+    .out_rii = tgen_subbio_rii,
 };
 
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_set_carry(s);  /* borrow == carry */
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
-- 
2.43.0


