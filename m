Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F202C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr2N-0004C0-S2; Fri, 17 Jan 2025 13:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr2B-0004Av-P5
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:32 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr29-0007vd-IC
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:31 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2164b662090so47461115ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138328; x=1737743128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZKhK0VW7EkxUROV1Mw2sNMrRo2GVhvDfIPbGj8+yGM=;
 b=kxs/3aUvMt+j/7V3pKAJl462xfS1Ru+9X/3po9ZZdSUqcljWSjH4GO77RPXClhCjFD
 5ry0FVFjNtr6uVkL/iceClsuH6Mlvu/7A2VrnSDoIteu1Q5m3pMU55MrguCihIg0fO+V
 +RCbsYDpWfTkYknSIZdiJk7cwTtbg4B7Ng2110CE3YpY53Ca3AQ6ebo7v3BxOv5vYv4H
 q8hFVXk+UwxbcQVb09db8BnNzyB3ghf6LpDwzoh8FddJhmnfIZBuPoOr7pl1JY+DvdEo
 0TH/dCLyrifI4w4SFHhIYMpukM9jKv9HeeSCsnwcrR9/1xq761YtYC7GvNvG8u7+vQDY
 kVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138328; x=1737743128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZKhK0VW7EkxUROV1Mw2sNMrRo2GVhvDfIPbGj8+yGM=;
 b=hM9anJ3Y13rcNEjC4ilNvpUtM7yrya1dXx7KK6m+eyP1p/sNc3DSBMowTZL8cEQiCv
 1Dl2slpAX8E5lkQGR5ABGyk3JP/al6n0nNUWr82DTP/ytwQIyTVRjfxkgCbeE1VpYxq5
 aujaux+/sL2/hxvcjZE2WUgp4Vr3gxN5uPGtYsE3qNaTHlbMKntFt3cfZSlFOtgPIqO6
 hRslPTFOwXMTAk5wRXHobRiy9UxLqxq7+UgBboFn6AdniONk+jV1m/y95uGvgGZ1XnRd
 pvM4hb8O+YYx3Nbdmr8xnv0UehmqcArw4fDIYkv5qCmUZBTvajQxegCZEyrMTNb5YBKu
 Xl/g==
X-Gm-Message-State: AOJu0YwfY3rd5+to6xccwewJ8HMelqSxds3kmwfsU0TRLD2kXtOCPuTp
 urGpBT0VWlYyGv1jFiD1E0/A/lXxjvyzSUAgbPJHy52ryYfHfjaeqrTPHsLEcY+WCRYrMl91fGf
 +
X-Gm-Gg: ASbGncsEb2NFbL/GB5j/G0ngYzbUCqI7j8wHQju66EgklhXSg1R9l6bXwsfg67gkst+
 PfIXFlkgGGdoYdfcuJciTMYMs0+WoeBzsrN20gmNdbqaWs8vcqJYzyJBA1hJinjevUJHoAmrDc9
 VIHd4hhVtlpJTozv6ZUSh3VdkIBqLw8TGwxDJMXNNtDh5yM3Ttp8pQWE9niJQQeZqBqGCOSISRR
 T0RjfdIBMCeFcl1h7BcZeibdnDF3Ly5eIg4MI21UK3bpZwl6diJT8fIbHWNZoPL44pVMM6mExv1
 cgumpBdeeKM4+iM=
X-Google-Smtp-Source: AGHT+IGtRHhMt7TMRChfAMMomjg81pwBSAF7DujHZyRUeMKYkQZB0We+imdgQ0N3vczc8sdx8ZfXPw==
X-Received: by 2002:a17:902:e548:b0:216:60a3:b3fd with SMTP id
 d9443c01a7336-21c351d345amr45013705ad.3.1737138328217; 
 Fri, 17 Jan 2025 10:25:28 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/68] tcg: Remove args_ct from TCGOpDef
Date: Fri, 17 Jan 2025 10:24:25 -0800
Message-ID: <20250117182456.2077110-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Introduce a new function, opcode_args_ct, to look up the argument
set for an opcode.  We lose the ability to assert the correctness
of the map from TCGOpcode to constraint sets at startup, but we can
still validate at runtime upon lookup.

Rename process_op_defs to process_constraint_sets, as it now does
nothing to TCGOpDef.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  1 -
 tcg/tcg-common.c  |  2 +-
 tcg/tcg.c         | 82 ++++++++++++++++++++++-------------------------
 3 files changed, 40 insertions(+), 45 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a02de82508..e28894c57b 100644
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
index d5ab0abe9d..df7c4dab88 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1496,7 +1496,7 @@ static void init_call_layout(TCGHelperInfo *info)
 }
 
 static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
-static void process_op_defs(TCGContext *s);
+static void process_constraint_sets(void);
 static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
                                             TCGReg reg, const char *name);
 
@@ -1517,7 +1517,7 @@ static void tcg_context_init(unsigned max_cpus)
     init_call_layout(&info_helper_st128_mmu);
 
     tcg_target_init(s);
-    process_op_defs(s);
+    process_constraint_sets();
 
     /* Reverse the order of the saved registers, assuming they're all at
        the start of tcg_target_reg_alloc_order.  */
@@ -3176,7 +3176,7 @@ static void sort_constraints(TCGArgConstraint *a, int start, int n)
 static const TCGArgConstraint empty_cts[TCG_MAX_OP_ARGS];
 static TCGArgConstraint all_cts[ARRAY_SIZE(constraint_sets)][TCG_MAX_OP_ARGS];
 
-static void process_op_defs(TCGContext *s)
+static void process_constraint_sets(void)
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


