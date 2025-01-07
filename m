Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D70EE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Xb-0000q1-Sc; Tue, 07 Jan 2025 03:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X1-0000Id-1T
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:44 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wx-0002xL-OR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:41 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2165cb60719so225437655ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236898; x=1736841698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICjMT30pbNAxJ2BEFh69CWp7qxF8653eZpt/ojt3HlM=;
 b=OGn4YW9ADp/FPxtNS8y6EoBwXX4+oIM2vzXF9OlW1eCaNZbBeexjVM3fh7hL4FBuBr
 UqwwegZOtriegq7rgekEnTyVS5wtvWD2DmgZUKLd+opAVZe56nXSXh4pvmabGBpXnzKk
 16OUU6LIwuS5QdifOloa7q9jRJ3KUSdQNxDuUbLwJOHzXEXT5HTt/Yb8MZT+UJMt9aVj
 YF+1R2TsZsqKenBrsUoyAgbSq0oDs8SdXWwWFsLn5UvOSjxMMnIlOvwkvYvmFSNgWYum
 TjDsVUboUhsBM4wyO451oy2dOC9xJSEObgfXb/vgU63E6RZFZ1Bq2S4TD6arX4Jn6Xo6
 tyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236898; x=1736841698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICjMT30pbNAxJ2BEFh69CWp7qxF8653eZpt/ojt3HlM=;
 b=RlNe8n9fGQH4vxzxnx+AfnJWeErYhCpv4IrFoRRaCIEO8T46pxOV7IoWATIqYgJObo
 BP1egmbMy4gAciIwOAofhkVB+1JGytfCTxcnXJxzJf2bfmk0ofI6gujd8bbOKREblZEP
 1UKNPQG7IQ+HqjYbL8hOGuKXvzbZFN1/frQ2v8a3TpuVs9CUhKcqnojckL5dva0E4WIX
 lj+yk2kqR9ADGuNgOteGblwA597FNofTrsuZngZP4ypNP3BVUupknlVeJK6bp23e9gaY
 b20A/7aji47VLRIKfTkFaqAHnRQ0gbCx9JNx/YThBhT8XRBdzbLorc5dYWxE0gtNM0Kh
 kQuA==
X-Gm-Message-State: AOJu0YwuIW6zucQcLvSXq6dYByzTECrzVQpF+t2bJ2CHRvJEWgi6ljFl
 REBMKyLbub+oNN360UuVlnsGekSZjTQnOrkhqWIFNdBnuT95hYNdhWr32uhjixjrjX2bVAY4WP3
 V
X-Gm-Gg: ASbGncvUuYhAh6A5eFh+hu+qvV7QZvn61rwThVDDU3TfoSfQbrC6GTPCgMRufYdN7u2
 m7uPIHlXzldDsu0sH4KFzMuFIHqmGnZY1zkyJNl5hMFpz2RpUJNopv7MYC778s7QvTrvH7SIrJX
 7gS8Wn+n/rz49z0Zp8GLgNGKbUXwbD2ImpCKDKisqhICxDhQzLms7AjD0bQAFq4yzoceWtW+ReY
 WFQtlc72vmEE+U+fqEM7YcSCvcE7qG1hM9cApe2CPny3yUHU/8LAgsIk+v4qVdzZVZbuxtTMQtH
 FVkAlyjjnEfrQC91Tw==
X-Google-Smtp-Source: AGHT+IEoZBZz2ZUxVBaZr02UjQFSbbda+XegHUXcPfNyrnjMs4KzyXOk8vrJSZggl6am+SEiJhDe3w==
X-Received: by 2002:a17:902:f705:b0:216:6fbc:3904 with SMTP id
 d9443c01a7336-219e6e9d91emr948748205ad.13.1736236898479; 
 Tue, 07 Jan 2025 00:01:38 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 23/81] tcg: Remove args_ct from TCGOpDef
Date: Tue,  7 Jan 2025 00:00:14 -0800
Message-ID: <20250107080112.1175095-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
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

Introduce a new function, opcode_args_ct, to look up the argument
set for an opcode.  We lose the ability to assert the correctness
of the map from TCGOpcode to constraint sets at startup, but we can
still validate at runtime upon lookup.

Rename process_op_defs to process_constraint_sets, as it now does
nothing to TCGOpDef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  1 -
 tcg/tcg-common.c  |  2 +-
 tcg/tcg.c         | 82 ++++++++++++++++++++++-------------------------
 3 files changed, 40 insertions(+), 45 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index ee9718d2bb..612260a528 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -714,7 +714,6 @@ typedef struct TCGOpDef {
     const char *name;
     uint8_t nb_oargs, nb_iargs, nb_cargs, nb_args;
     uint8_t flags;
-    const TCGArgConstraint *args_ct;
 } TCGOpDef;
 
 extern TCGOpDef tcg_op_defs[];
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index fadc33c3d1..0f30e5b3ec 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -28,7 +28,7 @@
 
 TCGOpDef tcg_op_defs[] = {
 #define DEF(s, oargs, iargs, cargs, flags) \
-         { #s, oargs, iargs, cargs, iargs + oargs + cargs, flags, NULL },
+         { #s, oargs, iargs, cargs, iargs + oargs + cargs, flags },
 #include "tcg/tcg-opc.h"
 #undef DEF
 };
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d5ab0abe9d..234e837e39 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1496,7 +1496,7 @@ static void init_call_layout(TCGHelperInfo *info)
 }
 
 static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
-static void process_op_defs(TCGContext *s);
+static void process_constraint_sets(TCGContext *s);
 static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
                                             TCGReg reg, const char *name);
 
@@ -1517,7 +1517,7 @@ static void tcg_context_init(unsigned max_cpus)
     init_call_layout(&info_helper_st128_mmu);
 
     tcg_target_init(s);
-    process_op_defs(s);
+    process_constraint_sets(s);
 
     /* Reverse the order of the saved registers, assuming they're all at
        the start of tcg_target_reg_alloc_order.  */
@@ -3176,7 +3176,7 @@ static void sort_constraints(TCGArgConstraint *a, int start, int n)
 static const TCGArgConstraint empty_cts[TCG_MAX_OP_ARGS];
 static TCGArgConstraint all_cts[ARRAY_SIZE(constraint_sets)][TCG_MAX_OP_ARGS];
 
-static void process_op_defs(TCGContext *s)
+static void process_constraint_sets(TCGContext *s)
 {
     for (size_t c = 0; c < ARRAY_SIZE(constraint_sets); ++c) {
         const TCGConstraintSet *tdefs = &constraint_sets[c];
@@ -3360,38 +3360,28 @@ static void process_op_defs(TCGContext *s)
         sort_constraints(args_ct, 0, nb_oargs);
         sort_constraints(args_ct, nb_oargs, nb_iargs);
     }
+}
 
-    for (TCGOpcode op = 0; op < NB_OPS; op++) {
-        TCGOpDef *def = &tcg_op_defs[op];
-        const TCGConstraintSet *tdefs;
-        TCGConstraintSetIndex con_set;
-        int nb_args;
+static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
+{
+    TCGOpDef *def = &tcg_op_defs[op->opc];
+    TCGConstraintSetIndex con_set;
 
-        nb_args = def->nb_iargs + def->nb_oargs;
-        if (nb_args == 0) {
-            continue;
-        }
-
-        if (def->flags & TCG_OPF_NOT_PRESENT) {
-            def->args_ct = empty_cts;
-            continue;
-        }
-
-        /*
-         * Macro magic should make it impossible, but double-check that
-         * the array index is in range.  At the same time, double-check
-         * that the opcode is implemented, i.e. not C_NotImplemented.
-         */
-        con_set = tcg_target_op_def(op);
-        tcg_debug_assert(con_set >= 0 && con_set < ARRAY_SIZE(constraint_sets));
-
-        /* The constraint arguments must match TCGOpcode arguments. */
-        tdefs = &constraint_sets[con_set];
-        tcg_debug_assert(tdefs->nb_oargs == def->nb_oargs);
-        tcg_debug_assert(tdefs->nb_iargs == def->nb_iargs);
-
-        def->args_ct = all_cts[con_set];
+    if (def->nb_iargs + def->nb_oargs == 0) {
+        return NULL;
     }
+    if (def->flags & TCG_OPF_NOT_PRESENT) {
+        return empty_cts;
+    }
+
+    con_set = tcg_target_op_def(op->opc);
+    tcg_debug_assert(con_set >= 0 && con_set < ARRAY_SIZE(constraint_sets));
+
+    /* The constraint arguments must match TCGOpcode arguments. */
+    tcg_debug_assert(constraint_sets[con_set].nb_oargs == def->nb_oargs);
+    tcg_debug_assert(constraint_sets[con_set].nb_iargs == def->nb_iargs);
+
+    return all_cts[con_set];
 }
 
 static void remove_label_use(TCGOp *op, int idx)
@@ -3864,6 +3854,7 @@ liveness_pass_1(TCGContext *s)
         TCGTemp *ts;
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
+        const TCGArgConstraint *args_ct;
 
         switch (opc) {
         case INDEX_op_call:
@@ -4153,8 +4144,9 @@ liveness_pass_1(TCGContext *s)
                 break;
 
             default:
+                args_ct = opcode_args_ct(op);
                 for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
-                    const TCGArgConstraint *ct = &def->args_ct[i];
+                    const TCGArgConstraint *ct = &args_ct[i];
                     TCGRegSet set, *pset;
 
                     ts = arg_temp(op->args[i]);
@@ -4941,6 +4933,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
 {
     const TCGLifeData arg_life = op->life;
     TCGRegSet dup_out_regs, dup_in_regs;
+    const TCGArgConstraint *dup_args_ct;
     TCGTemp *its, *ots;
     TCGType itype, vtype;
     unsigned vece;
@@ -4967,8 +4960,9 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
         return;
     }
 
-    dup_out_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[0].regs;
-    dup_in_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[1].regs;
+    dup_args_ct = opcode_args_ct(op);
+    dup_out_regs = dup_args_ct[0].regs;
+    dup_in_regs = dup_args_ct[1].regs;
 
     /* Allocate the output register now.  */
     if (ots->val_type != TEMP_VAL_REG) {
@@ -5054,6 +5048,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     int i, k, nb_iargs, nb_oargs;
     TCGReg reg;
     TCGArg arg;
+    const TCGArgConstraint *args_ct;
     const TCGArgConstraint *arg_ct;
     TCGTemp *ts;
     TCGArg new_args[TCG_MAX_OP_ARGS];
@@ -5098,6 +5093,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
     }
 
+    args_ct = opcode_args_ct(op);
+
     /* satisfy input constraints */
     for (k = 0; k < nb_iargs; k++) {
         TCGRegSet i_preferred_regs, i_required_regs;
@@ -5105,9 +5102,9 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         TCGTemp *ts2;
         int i1, i2;
 
-        i = def->args_ct[nb_oargs + k].sort_index;
+        i = args_ct[nb_oargs + k].sort_index;
         arg = op->args[i];
-        arg_ct = &def->args_ct[i];
+        arg_ct = &args_ct[i];
         ts = arg_temp(arg);
 
         if (ts->val_type == TEMP_VAL_CONST
@@ -5137,7 +5134,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                  * register and move it.
                  */
                 if (temp_readonly(ts) || !IS_DEAD_ARG(i)
-                    || def->args_ct[arg_ct->alias_index].newreg) {
+                    || args_ct[arg_ct->alias_index].newreg) {
                     allocate_new_reg = true;
                 } else if (ts->val_type == TEMP_VAL_REG) {
                     /*
@@ -5322,10 +5319,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
 
         /* satisfy the output constraints */
-        for(k = 0; k < nb_oargs; k++) {
-            i = def->args_ct[k].sort_index;
+        for (k = 0; k < nb_oargs; k++) {
+            i = args_ct[k].sort_index;
             arg = op->args[i];
-            arg_ct = &def->args_ct[i];
+            arg_ct = &args_ct[i];
             ts = arg_temp(arg);
 
             /* ENV should not be modified.  */
@@ -5465,8 +5462,7 @@ static bool tcg_reg_alloc_dup2(TCGContext *s, const TCGOp *op)
     /* Allocate the output register now.  */
     if (ots->val_type != TEMP_VAL_REG) {
         TCGRegSet allocated_regs = s->reserved_regs;
-        TCGRegSet dup_out_regs =
-            tcg_op_defs[INDEX_op_dup_vec].args_ct[0].regs;
+        TCGRegSet dup_out_regs = opcode_args_ct(op)[0].regs;
         TCGReg oreg;
 
         /* Make sure to not spill the input registers. */
-- 
2.43.0


