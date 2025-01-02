Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8632DE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPet-0007yg-FP; Thu, 02 Jan 2025 13:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeb-0007NW-3A
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:44 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeY-0006Em-NN
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:40 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso154755065ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841437; x=1736446237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vKDhHdNzKjHYYHMIVIUNa/KwUwgtD1aVWMyeEtqPxTI=;
 b=BzJH+KX35eySPlPuTGpg+XCT2BWdg0woYS0hadtnPh1WuN1MO6tF3mEvcwnlo9Fj9f
 dep+8OWWG32YYWA71qx2kyYaMKJnGjfjtNhc7K8VicGtOneGW4NFnA/rtk5yjhpUDSHh
 /J9QEkTpLlmhkT3ALMEMdyXCYcq0b4drIBOpBi0WYrKNjGoDkyoqqmxrm3XQtiCx+kQB
 LkGHnt7h2LtgZtM6l+HLGK3eLeul7OcG+M8LhL7bkouR7xpkisT+t9OMlI7+JmNaCfvY
 UG/v1nmkWQIxh+EB94cYejaI2Df9sBkwG4NoW23eBWqzHhb4P/4sYRDc8Vt9V4fBNHeV
 7bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841437; x=1736446237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKDhHdNzKjHYYHMIVIUNa/KwUwgtD1aVWMyeEtqPxTI=;
 b=NlAaL33FnvXZZhv0orf8+5odR4UrXm0XOneQZ4bmJVXKT/I4GWeNT9593tG0/Ejn9N
 cNbH4JCI3yYwoCZhywoh94nIQvgF5occkJNKahHeJb3WwrgTqO7W9V6QOT5pr7amgcqc
 AJlsKRfUh3ETj9U7c/buG4S2VG2ArHFLh5BarX7bhGYf4F9ELN9kVyYZA02olYc0vMPW
 hAMTA+6Eh2nkWSzye6FglFnN+XEhY6wtRs4JGgCLujVzIy6liMtps9QSrplQmSeGVJZW
 iKb6o9wwoCDtCcRKvT775uU49Up2RHexOLcgG67pc4ElHK87W+A4roHrw4J6jczWjfVx
 DuaQ==
X-Gm-Message-State: AOJu0Yw+2u69zSEHULBGMwcK+/UjaAS/LlzXG10as8LnF7puXS08pgiz
 yNE5shZcV4wkBtxTvlABOJrkw5ewozRIalW6Yb6xqCiIM4y763Y1QdnHya/ZpeNR2TFQEYophf6
 W
X-Gm-Gg: ASbGncskUxnRfnX83ZNJm2ByquKsFzQKroZuznSFKAcTQUFTl2Kv+D9ixltHzLC+JBN
 nVc/xiyvTWjhuUk7CzZte0J2qpZcjjwxn6wWP7rjk4LmrnQm6yxj0dNo/RPff3lUZ04l8a5D8tJ
 CbI41wjSbdOxYcq0aWPgTa6m0l6HYymBZu/2tYqY6v2CpimRH5D2r1aSsQ9sBe9jl2kfA04kLd1
 tsbf4u2vLOqyowT5QsoKELGc3iulM7HbQgMcY61b71vuIg65ds839nA3xKAwQ==
X-Google-Smtp-Source: AGHT+IEtOnPdyf6fuIuq+HfdxHrZP8VTYnYzi4J3Z+Qy4H8bJ6phseW0tDTu1KRFjlePVtH/0mzsFw==
X-Received: by 2002:a05:6a20:c70b:b0:1e1:c054:4c58 with SMTP id
 adf61e73a8af0-1e5e0450020mr73061262637.2.1735841437104; 
 Thu, 02 Jan 2025 10:10:37 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 54/73] tcg: Pass TCGOp to tcg_target_op_def
Date: Thu,  2 Jan 2025 10:06:34 -0800
Message-ID: <20250102180654.1420056-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Allow the backend to make constraint choices based on
the entire TCGOp.  The type and vector element fields
within the main TCGOp structure are valid to inspect,
as well as any constant operands, e.g. a MemOp.

We lose the ability to assert the correctness of the map
from TCGOpcode to constraint sets at startup, but we can
still validate at runtime upon lookup.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 51 +++++++-------------------------
 tcg/aarch64/tcg-target.c.inc     |  4 +--
 tcg/arm/tcg-target.c.inc         |  4 +--
 tcg/i386/tcg-target.c.inc        |  4 +--
 tcg/loongarch64/tcg-target.c.inc |  4 +--
 tcg/mips/tcg-target.c.inc        |  4 +--
 tcg/ppc/tcg-target.c.inc         |  4 +--
 tcg/riscv/tcg-target.c.inc       |  4 +--
 tcg/s390x/tcg-target.c.inc       |  4 +--
 tcg/sparc64/tcg-target.c.inc     |  4 +--
 tcg/tci/tcg-target.c.inc         |  4 +--
 11 files changed, 31 insertions(+), 60 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 095008ac25..fb8b1f2a2d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -875,7 +875,7 @@ typedef enum {
 #include "tcg-target-con-set.h"
 } TCGConstraintSetIndex;
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
+static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *);
 
 #undef C_O0_I1
 #undef C_O0_I2
@@ -1512,14 +1512,14 @@ static void init_call_layout(TCGHelperInfo *info)
 }
 
 static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
-static void process_op_defs(TCGContext *s);
+static void process_constraint_sets(void);
 static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
                                             TCGReg reg, const char *name);
 
 static void tcg_context_init(unsigned max_cpus)
 {
     TCGContext *s = &tcg_init_ctx;
-    int  n, i;
+    int n, i;
     TCGTemp *ts;
 
     memset(s, 0, sizeof(*s));
@@ -1533,7 +1533,7 @@ static void tcg_context_init(unsigned max_cpus)
     init_call_layout(&info_helper_st128_mmu);
 
     tcg_target_init(s);
-    process_op_defs(s);
+    process_constraint_sets();
 
     /* Reverse the order of the saved registers, assuming they're all at
        the start of tcg_target_reg_alloc_order.  */
@@ -3135,12 +3135,8 @@ static void sort_constraints(TCGArgConstraint *a, int start, int n)
 static const TCGArgConstraint empty_cts[TCG_MAX_OP_ARGS];
 static TCGArgConstraint all_args_cts[ARRAY_SIZE(constraint_sets)][TCG_MAX_OP_ARGS];
 
-static void process_op_defs(TCGContext *s)
+static void process_constraint_sets(void)
 {
-    /*
-     * Process each constraint set.
-     */
-
     for (size_t c = 0; c < ARRAY_SIZE(constraint_sets); ++c) {
         const TCGConstraintSet *tdefs = &constraint_sets[c];
         TCGArgConstraint *args_ct = all_args_cts[c];
@@ -3323,36 +3319,6 @@ static void process_op_defs(TCGContext *s)
         sort_constraints(args_ct, 0, nb_oargs);
         sort_constraints(args_ct, nb_oargs, nb_iargs);
     }
-
-    for (TCGOpcode op = 0; op < NB_OPS; op++) {
-        const TCGOpDef *def = &tcg_op_defs[op];
-        const TCGConstraintSet *tdefs;
-        TCGConstraintSetIndex con_set;
-        TCGType type;
-
-        if (def->flags & TCG_OPF_NOT_PRESENT) {
-            continue;
-        }
-
-        type = (def->flags & TCG_OPF_VECTOR ? TCG_TYPE_V64
-                : def->flags & TCG_OPF_64BIT ? TCG_TYPE_I64
-                : TCG_TYPE_I32);
-        if (!tcg_op_supported(op, type)) {
-            continue;
-        }
-
-        /*
-         * Macro magic should make it impossible, but double-check that
-         * the array index is in range.
-         */
-        con_set = tcg_target_op_def(op);
-        tcg_debug_assert(con_set >= 0 && con_set < ARRAY_SIZE(constraint_sets));
-
-        /* The constraint arguments must match TCGOpcode arguments. */
-        tdefs = &constraint_sets[con_set];
-        tcg_debug_assert(tdefs->nb_oargs == def->nb_oargs);
-        tcg_debug_assert(tdefs->nb_iargs == def->nb_iargs);
-    }
 }
 
 static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
@@ -3367,8 +3333,13 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
 
     tcg_debug_assert(tcg_op_supported(opc, op->type));
 
-    con_set = tcg_target_op_def(opc);
+    con_set = tcg_target_op_def(op);
     tcg_debug_assert(con_set >= 0 && con_set < ARRAY_SIZE(constraint_sets));
+
+    /* The constraint arguments must match TCGOpcode arguments. */
+    tcg_debug_assert(constraint_sets[con_set].nb_oargs == def->nb_oargs);
+    tcg_debug_assert(constraint_sets[con_set].nb_iargs == def->nb_iargs);
+
     return all_args_cts[con_set];
 }
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 72e64c7dba..acc6dadfe5 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2961,9 +2961,9 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 {
-    switch (op) {
+    switch (op->opc) {
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index d0c39f7122..e8908702d2 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2162,9 +2162,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 {
-    switch (op) {
+    switch (op->opc) {
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index b6b15723b4..aa6b72f591 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3661,9 +3661,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 {
-    switch (op) {
+    switch (op->opc) {
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 900558d301..293bf36656 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2209,9 +2209,9 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     g_assert_not_reached();
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 {
-    switch (op) {
+    switch (op->opc) {
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index d2ace88aae..8d3b005f2d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2168,9 +2168,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 {
-    switch (op) {
+    switch (op->opc) {
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 62110619f0..0cb04241fa 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -4161,9 +4161,9 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     va_end(va);
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 {
-    switch (op) {
+    switch (op->opc) {
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 8e0a2d967e..37a2be0551 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2611,9 +2611,9 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 {
-    switch (op) {
+    switch (op->opc) {
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index cb0b7ff25e..35a9d6ee45 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3235,9 +3235,9 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     va_end(va);
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 {
-    switch (op) {
+    switch (op->opc) {
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index c104636cf7..6d28498815 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1535,9 +1535,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 {
-    switch (op) {
+    switch (op->opc) {
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 57293e1458..583cec1ecf 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -36,9 +36,9 @@
 #endif
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 {
-    switch (op) {
+    switch (op->opc) {
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-- 
2.43.0


