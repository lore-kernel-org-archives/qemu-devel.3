Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6CDC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnuN-0004HC-7l; Sun, 16 Feb 2025 18:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntQ-0002zc-CK
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:44 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntM-00065U-OI
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:44 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220c8eb195aso78762545ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747859; x=1740352659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NoLDG6qUCVGX98iJYUNQkB9K0ToFQu26kBjIJeuDs04=;
 b=lyfR1pgztIMUPT8+ukmNKA/Fomx3BtHirdZ7QhNCqlGZMjQsMx5dA9dV/VW0TNzAVU
 Hcf0YX5NUR5hRxhnTp3zPr5ZSI6INyy/KqrjACSovnLP9FvpQUICfkVkE/1uwcTjxz8D
 dmS9+8+KCXl8T7GmWQJKKifrC2cTXtshWkp4KSCHSCcLtyHrsf7odRRsNHzyoXUjs6kt
 0ogwzsJEp58CFPgZaxf42RBnqwFGsSWpeXWu9kVkJADpcLOu1En8amFE5KuEJRAgKcFw
 JPVncOOX8Co2Q4+H6/GcEH+6XA53b9Ov5RVd1mkwIuXGIvHvu+1AUWZdLO2xsVE+eEIG
 brWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747859; x=1740352659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NoLDG6qUCVGX98iJYUNQkB9K0ToFQu26kBjIJeuDs04=;
 b=t+Ijx1+5CPAeHH20/yN9y4Bw/EKbiL6gicUQz64/Ei6GWFFx4CVSYVRiSLW6Qppvsj
 daAv9q9+hv0qhBLT8VjzBg+6um1skM5BpNQsQ8yS429EY1aVyfhUq4yEUPJIRzdJ6TAd
 1YwVWX77Qe4SayST8dpR6m3/vbebwSy4tF8ozDEMyPAEFt7YfM7NM0pJD3NKZBTbpU4R
 bFoPtg/KkpDc6qir6IiGKXTfEgR2qRGAFJfOj7YKLLYcFxlTU6UfuUuq/lr1B899nLn7
 drVAHPZWbuCbNB0MvxIEPfR/ZM0wWaQijTDye0mLHG38IoYYpVm27NVSJ+jf9JqCbyYG
 PFwg==
X-Gm-Message-State: AOJu0Ywv7RolswgYqQihZzPU/A1eZwIHvizOgliXDQLiCbWjBvjME72V
 JXJnutM3yJmP27NEfz0144K8/JHFsbm49v2X0VCMm8wYIlaInPRoSABCCFTS8Xkn5n9tlIcRsEH
 8
X-Gm-Gg: ASbGncvI+02yw4GTJT2HTIYncH98utQIsDbl7m7U6mFeZkGypZ7/B2+aFSkdi6+Q870
 f1onEQu8pFZRlq4J/c3FeLKTroPME07voi6ICvSbaILX3PJ1JpdNFlCNKb1StB/yD3wn0vXULZu
 OV8A/anXaDqcuW6Mv8zqFn/cxTcIj57H5KR0ErAYJCj0CdBcSwM850UdiV7XbQvaGYul5CzG2ie
 XrzmHmXgTAYvjn5rNAQPx8yLFhlz/z94lVS+Xgs2M0CKp/3+OOGw5K3nq1ZybrbrPfSmmFoOnrx
 YV/+QfN1sofMltCPt8xj8+RX5FnHrIdf8BHnICvbw1bbdvA=
X-Google-Smtp-Source: AGHT+IFwzyJD+BeJIX1Dx7wucYjxJ9+FDgUAhOy5WNrVaSE6CexmdIhzlcEv2Gtt3LC04iARLgX9Pw==
X-Received: by 2002:a17:902:dac5:b0:215:431f:268f with SMTP id
 d9443c01a7336-22103efc119mr134687675ad.10.1739747859083; 
 Sun, 16 Feb 2025 15:17:39 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 113/162] tcg: Add TCGOutOp structures for add/sub carry
 opcodes
Date: Sun, 16 Feb 2025 15:09:22 -0800
Message-ID: <20250216231012.2808572-114-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 tcg/tcg.c                        | 61 +++++++++++++++++++++++++++-----
 tcg/aarch64/tcg-target.c.inc     | 34 ++++++++++++++++++
 tcg/arm/tcg-target.c.inc         | 34 ++++++++++++++++++
 tcg/i386/tcg-target.c.inc        | 34 ++++++++++++++++++
 tcg/loongarch64/tcg-target.c.inc | 34 ++++++++++++++++++
 tcg/mips/tcg-target.c.inc        | 34 ++++++++++++++++++
 tcg/ppc/tcg-target.c.inc         | 34 ++++++++++++++++++
 tcg/riscv/tcg-target.c.inc       | 34 ++++++++++++++++++
 tcg/s390x/tcg-target.c.inc       | 34 ++++++++++++++++++
 tcg/sparc64/tcg-target.c.inc     | 34 ++++++++++++++++++
 tcg/tci/tcg-target.c.inc         | 34 ++++++++++++++++++
 11 files changed, 393 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 88e4c6c7c8..6f28caf02e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -133,6 +133,8 @@ static void tcg_out_addi_ptr(TCGContext *s, TCGReg, TCGReg, tcg_target_long);
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2);
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg);
 static void tcg_out_goto_tb(TCGContext *s, int which);
+static void tcg_out_set_carry(TCGContext *s);
+static void tcg_out_set_borrow(TCGContext *s);
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS]);
@@ -978,6 +980,18 @@ typedef struct TCGOutOp {
     TCGConstraintSetIndex (*dynamic_constraint)(TCGType type, unsigned flags);
 } TCGOutOp;
 
+typedef struct TCGOutOpAddSubCarry {
+    TCGOutOp base;
+    void (*out_rrr)(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2);
+    void (*out_rri)(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, tcg_target_long a2);
+    void (*out_rir)(TCGContext *s, TCGType type,
+                    TCGReg a0, tcg_target_long a1, TCGReg a2);
+    void (*out_rii)(TCGContext *s, TCGType type,
+                    TCGReg a0, tcg_target_long a1, tcg_target_long a2);
+} TCGOutOpAddSubCarry;
+
 typedef struct TCGOutOpBinary {
     TCGOutOp base;
     void (*out_rrr)(TCGContext *s, TCGType type,
@@ -1131,6 +1145,11 @@ static const TCGOutOpUnary outop_extrl_i64_i32 = {
 /* Register allocation descriptions for every TCGOpcode. */
 static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
+    OUTOP(INDEX_op_addci, TCGOutOpAddSubCarry, outop_addci),
+    OUTOP(INDEX_op_addcio, TCGOutOpBinary, outop_addcio),
+    OUTOP(INDEX_op_addco, TCGOutOpBinary, outop_addco),
+    /* addc1o is implemented with set_carry + addcio */
+    OUTOP(INDEX_op_addc1o, TCGOutOpBinary, outop_addcio),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_brcond, TCGOutOpBrcond, outop_brcond),
@@ -1170,6 +1189,11 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
+    OUTOP(INDEX_op_subbi, TCGOutOpAddSubCarry, outop_subbi),
+    OUTOP(INDEX_op_subbio, TCGOutOpAddSubCarry, outop_subbio),
+    OUTOP(INDEX_op_subbo, TCGOutOpAddSubCarry, outop_subbo),
+    /* subb1o is implemented with set_borrow + subbio */
+    OUTOP(INDEX_op_subb1o, TCGOutOpAddSubCarry, outop_subbio),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 
 #if TCG_TARGET_REG_BITS == 32
@@ -5536,7 +5560,12 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     /* emit instruction */
     TCGType type = TCGOP_TYPE(op);
     switch (op->opc) {
+    case INDEX_op_addc1o:
+        tcg_out_set_carry(s);
+        /* fall through */
     case INDEX_op_add:
+    case INDEX_op_addcio:
+    case INDEX_op_addco:
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_clz:
@@ -5574,8 +5603,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
     case INDEX_op_sub:
         {
-            const TCGOutOpSubtract *out =
-                container_of(all_outop[op->opc], TCGOutOpSubtract, base);
+            const TCGOutOpSubtract *out = &outop_sub;
 
             tcg_debug_assert(!const_args[2]);
             if (const_args[1]) {
@@ -5586,15 +5614,32 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_addco:
-    case INDEX_op_subbo:
+    case INDEX_op_subb1o:
+        tcg_out_set_borrow(s);
+        /* fall through */
     case INDEX_op_addci:
     case INDEX_op_subbi:
-    case INDEX_op_addcio:
     case INDEX_op_subbio:
-    case INDEX_op_addc1o:
-    case INDEX_op_subb1o:
-        g_assert_not_reached();
+    case INDEX_op_subbo:
+        {
+            const TCGOutOpAddSubCarry *out =
+                container_of(all_outop[op->opc], TCGOutOpAddSubCarry, base);
+
+            if (const_args[2]) {
+                if (const_args[1]) {
+                    out->out_rii(s, type, new_args[0],
+                                 new_args[1], new_args[2]);
+                } else {
+                    out->out_rri(s, type, new_args[0],
+                                 new_args[1], new_args[2]);
+                }
+            } else if (const_args[1]) {
+                out->out_rir(s, type, new_args[0], new_args[1], new_args[2]);
+            } else {
+                out->out_rrr(s, type, new_args[0], new_args[1], new_args[2]);
+            }
+        }
+        break;
 
     case INDEX_op_bswap64:
     case INDEX_op_ext_i32_i64:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index bece494c55..87f8c98ed7 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2078,6 +2078,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2421,6 +2438,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index c2f97b4b01..2a7b0f09db 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1832,6 +1832,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2141,6 +2158,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rir = tgen_subfi,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index d213776dd0..1782a38e4d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2629,6 +2629,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3054,6 +3071,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 735dcc117a..937f19fe6b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1326,6 +1326,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tcg_out_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1715,6 +1732,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index f2d03cb6f9..39939d659b 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1593,6 +1593,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2050,6 +2067,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index a964239aab..5b04655f3b 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2863,6 +2863,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3267,6 +3284,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rir = tgen_subfi,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index dce46dcba6..707ebb8f6d 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1947,6 +1947,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2333,6 +2350,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index ff06834e6e..a30afb455e 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2248,6 +2248,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2766,6 +2783,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 4c7d916302..12f0dbd23d 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1381,6 +1381,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1717,6 +1734,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 9a5ca9c778..bba96d7a19 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -573,6 +573,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rrr = tgen_add,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -893,6 +910,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-- 
2.43.0


