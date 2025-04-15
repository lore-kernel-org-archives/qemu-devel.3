Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0419C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mGP-0000v9-1U; Tue, 15 Apr 2025 15:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m6s-0001HL-3v
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:38:36 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5d-0004Ys-RN
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:41 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so5038301b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745777; x=1745350577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5snSNelfjAuN0Iv9eBzGjW9mLu+ft67qxWZukX4mhf4=;
 b=ZRBTxlL4p1Nkdr+oEW2PtMd91Ni7X7vxcB6pgomTMGcWesayOBxjKsv9wU83z3oecA
 7Lmrvbr7v6w8ielkuMsZt0gfbJJtLB7Zh2zdktY0XFrfE9C6mjCxqRURWZCF0nX0nR1O
 4Oz1H592X+74kOmTeevV1aaNuuhX5Tl44coMB+m9BmPid/r+E4xZYOeQOJxYYVKVmUiO
 Bw2qTC6u7fQGjuG6ZQFJDGC8Bw4brGKHnGoa7dDYwngBTdrVuvdJMpLgCcQ5OngOXCa8
 ydGZaiT87kt4RolpodZ/xfAFNKjjabYBUnIfZlAKaNzpNSDbW5wuwzhwHNw3vdObUt6U
 mNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745777; x=1745350577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5snSNelfjAuN0Iv9eBzGjW9mLu+ft67qxWZukX4mhf4=;
 b=v/yLDdnky7I06qFCmzGs21iC2BXRyjaIBSaYk6Zb4HZkKf2nm+IWQlh6/3EPA3ML1J
 OnsfZ+ySpYR5Uu1JvRuMVy3NG0FNZj23glU5IKzolJQZ0/y6hSdW0TTMcP8fuJgZBAm6
 VqYtp9pwrny+sX8N/RfvFaLWnJlvQKf01B/tgnIwKm6+EiFjwkYdZMva9SfyJw6jx0m/
 Hyr6e9k0vA5hvztvhuzBOvdhxaCpuiy5oLBpWrrqSHpWqglH6egGKf/puYig20d41iZS
 WKDW4JObDq3YR1tcwRw874F3q37n9ZpfJGJk17aa/7C/pmW1QHDUXNZ/NRGxK3NccDZc
 01fA==
X-Gm-Message-State: AOJu0YxEvxYNO8f2BUTZrN/XmTlKWFMh87T5sVuYO/o+FMgg5kDedyR3
 QP6vckbpYrJNSoCI/rBiDIn5qZqUGB8rFOjc79YMME/psOBi6DnqOSfxXhoCaNm2yh6D6KRPDeT
 q
X-Gm-Gg: ASbGncth3szYebFnFCPmKrl6jwk2BMArzA/AZ8NIk3NCgLTnd9lvAZ0GGejGaJQXT0z
 mGDWLE7+xlrJq43f6xq9nzVZ1BN1DLYYlLIuf7O2RZZlwti7HFayC0BS0GKndExLyx1DL8C2KEe
 T5QBNzxBtxVsR4uuaWRqrLLbUHmMXQddCwc22EwvtzFNDObx0fMU+/S/gb9EwH2y+vlzGtwF6xa
 IAdSZV8XLkTrbMfKzomw1ivV2wW+HcUUTnbig+zyCFZbjqalvhcfNondGQTXsBTaDIxQGPt6y79
 PoSfTt3PKBAOTI+bHMc52sGSHwDHfDhFHo8KIqFD20UQ+EQDmdocAhZ0A+jMjpi+Cie14b3ss6k
 =
X-Google-Smtp-Source: AGHT+IE5hbxoGEDxcRoh6uhoiLENIZh22SJuPN8JPsY6WBcuMzqoMfHEL6Bpl5LKJzKeBOLvyOcaUA==
X-Received: by 2002:a05:6a00:1807:b0:736:4a5b:7f08 with SMTP id
 d2e1a72fcca58-73c1fb26251mr849460b3a.22.1744745776772; 
 Tue, 15 Apr 2025 12:36:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 145/163] tcg/sparc64: Implement add/sub carry opcodes
Date: Tue, 15 Apr 2025 12:24:56 -0700
Message-ID: <20250415192515.232910-146-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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


