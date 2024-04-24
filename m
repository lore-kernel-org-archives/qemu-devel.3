Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0370CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldS-0003l9-2g; Wed, 24 Apr 2024 19:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldQ-0003kl-FV
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:40 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldO-0002dl-48
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:40 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ecee1f325bso441762b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999756; x=1714604556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/qL7hPT5BRbOA8liuFR3tQMzphxIlFBB93p3SZvf90=;
 b=DeqpeshsD3aQOGToLsSq6He10jM8s4/BBxFxX3Hn+AI0o4jF3QS0l2LJTpvDHC9UqU
 QLbpyQBoaZhBf2qhMw9UuVZfg9ntXgswybb3QNGmIbvrLzVZCt8g9saloef90pdFbShA
 4R3wT1JykFC7HWG6chjG+DelG12MQGYdcs7Ua3CPgWns5eENo2dqLujUbMFRi7vdk6Un
 xLaConXMk8XxB816IWX7Y7b6vBhOYYz/tjpRSwHhF9adC9cW7qau44It6s0znLCffkUw
 PHsIZI38VBZfs9sFQuIB2/d30OoB5C/taYOCOgJM7EZAYZdb0sEb7G0TMY3as1CZapNx
 leag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999756; x=1714604556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/qL7hPT5BRbOA8liuFR3tQMzphxIlFBB93p3SZvf90=;
 b=HiXUGKpzu+gdMa0+03bQpUG8uTdvRb3AIQCydOXZkSWTzYZ/1mdxiAkKjMTVCKBo8t
 wLJ6XMDO0vPevgjBeuEeTlpb3kD3qeRsHrNqNdp9r2TBH8G733xB+jsA3+/PRu3vAXv/
 AAgT43S3n3XbdRYjZrt4qmd6r4a9KcwyB/3mBlkzhwF3VvY6EbACEo0+YPPR5GX9V26p
 KFunINsmkc4s55iat+99RTZvOaxOmvMVBQoJoza48Bg3AQ68y7I3fP3kToqIBvsCOYPU
 MbK71Oep3hHsvO7OuNVnFdESzvv6IRb+jEYowP7jZvvEN5j6t5CllrAItTNcYuo98NVQ
 mLzA==
X-Gm-Message-State: AOJu0YzJK0Sfj+xU/eU6sVsFupzuNpXo1UfRpvqQcM8fFDzr0r7T9p9z
 iVx46wJX15XV142I0ZsDdEj+opbPgXO9Kudr8j5Jsrk2fli9cB5J6uKR5MJ4tZOmGDI9Q/qellA
 A
X-Google-Smtp-Source: AGHT+IGz3+g4xo9+rpe0yxH5Ls+rAyxMV8Rkt3+DcqUXC1zclXq3qmhdieWAPAGcRwOOU9zs4RPtNg==
X-Received: by 2002:a05:6a00:cd5:b0:6ea:e2d2:5e68 with SMTP id
 b21-20020a056a000cd500b006eae2d25e68mr5350052pfv.27.1713999756432; 
 Wed, 24 Apr 2024 16:02:36 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 09/20] plugins: Use emit_before_op for PLUGIN_GEN_FROM_INSN
Date: Wed, 24 Apr 2024 16:02:13 -0700
Message-Id: <20240424230224.941028-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 include/qemu/plugin.h  |   1 -
 accel/tcg/plugin-gen.c | 286 ++++++++++-------------------------------
 plugins/api.c          |   8 +-
 3 files changed, 67 insertions(+), 228 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 793c44f1f2..ee1c1b174a 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -73,7 +73,6 @@ enum plugin_dyn_cb_type {
 
 enum plugin_dyn_cb_subtype {
     PLUGIN_CB_REGULAR,
-    PLUGIN_CB_REGULAR_R,
     PLUGIN_CB_INLINE,
     PLUGIN_N_CB_SUBTYPES,
 };
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 1faa49cb8f..a3dd82df4b 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -98,30 +98,6 @@ void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
                                 void *userdata)
 { }
 
-static void gen_empty_udata_cb(void (*gen_helper)(TCGv_i32, TCGv_ptr))
-{
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-    TCGv_ptr udata = tcg_temp_ebb_new_ptr();
-
-    tcg_gen_movi_ptr(udata, 0);
-    tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    gen_helper(cpu_index, udata);
-
-    tcg_temp_free_ptr(udata);
-    tcg_temp_free_i32(cpu_index);
-}
-
-static void gen_empty_udata_cb_no_wg(void)
-{
-    gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_wg);
-}
-
-static void gen_empty_udata_cb_no_rwg(void)
-{
-    gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_rwg);
-}
-
 /*
  * For now we only support addi_i64.
  * When we support more ops, we can generate one empty inline cb for each.
@@ -170,51 +146,19 @@ static void gen_empty_mem_cb(TCGv_i64 addr, uint32_t info)
     tcg_temp_free_i32(cpu_index);
 }
 
-/*
- * Share the same function for enable/disable. When enabling, the NULL
- * pointer will be overwritten later.
- */
-static void gen_empty_mem_helper(void)
-{
-    TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
-
-    tcg_gen_movi_ptr(ptr, 0);
-    tcg_gen_st_ptr(ptr, tcg_env, offsetof(CPUState, plugin_mem_cbs) -
-                                 offsetof(ArchCPU, env));
-    tcg_temp_free_ptr(ptr);
-}
-
 static void gen_plugin_cb_start(enum plugin_gen_from from,
                                 enum plugin_gen_cb type, unsigned wr)
 {
     tcg_gen_plugin_cb_start(from, type, wr);
 }
 
-static void gen_wrapped(enum plugin_gen_from from,
-                        enum plugin_gen_cb type, void (*func)(void))
-{
-    gen_plugin_cb_start(from, type, 0);
-    func();
-    tcg_gen_plugin_cb_end();
-}
-
 static void plugin_gen_empty_callback(enum plugin_gen_from from)
 {
     switch (from) {
     case PLUGIN_GEN_AFTER_INSN:
     case PLUGIN_GEN_FROM_TB:
-        tcg_gen_plugin_cb(from);
-        break;
     case PLUGIN_GEN_FROM_INSN:
-        /*
-         * Note: plugin_gen_inject() relies on ENABLE_MEM_HELPER being
-         * the first callback of an instruction
-         */
-        gen_wrapped(from, PLUGIN_GEN_ENABLE_MEM_HELPER,
-                    gen_empty_mem_helper);
-        gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb_no_rwg);
-        gen_wrapped(from, PLUGIN_GEN_CB_UDATA_R, gen_empty_udata_cb_no_wg);
-        gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
+        tcg_gen_plugin_cb(from);
         break;
     default:
         g_assert_not_reached();
@@ -368,18 +312,6 @@ static TCGOp *copy_mul_i32(TCGOp **begin_op, TCGOp *op, uint32_t v)
     return op;
 }
 
-static TCGOp *copy_st_ptr(TCGOp **begin_op, TCGOp *op)
-{
-    if (UINTPTR_MAX == UINT32_MAX) {
-        /* st_i32 */
-        op = copy_op(begin_op, op, INDEX_op_st_i32);
-    } else {
-        /* st_i64 */
-        op = copy_st_i64(begin_op, op);
-    }
-    return op;
-}
-
 static TCGOp *copy_call(TCGOp **begin_op, TCGOp *op, void *func, int *cb_idx)
 {
     TCGOp *old_op;
@@ -403,32 +335,6 @@ static TCGOp *copy_call(TCGOp **begin_op, TCGOp *op, void *func, int *cb_idx)
     return op;
 }
 
-/*
- * When we append/replace ops here we are sensitive to changing patterns of
- * TCGOps generated by the tcg_gen_FOO calls when we generated the
- * empty callbacks. This will assert very quickly in a debug build as
- * we assert the ops we are replacing are the correct ones.
- */
-static TCGOp *append_udata_cb(const struct qemu_plugin_dyn_cb *cb,
-                              TCGOp *begin_op, TCGOp *op, int *cb_idx)
-{
-    /* const_ptr */
-    op = copy_const_ptr(&begin_op, op, cb->userp);
-
-    /* copy the ld_i32, but note that we only have to copy it once */
-    if (*cb_idx == -1) {
-        op = copy_op(&begin_op, op, INDEX_op_ld_i32);
-    } else {
-        begin_op = QTAILQ_NEXT(begin_op, link);
-        tcg_debug_assert(begin_op && begin_op->opc == INDEX_op_ld_i32);
-    }
-
-    /* call */
-    op = copy_call(&begin_op, op, cb->regular.f.vcpu_udata, cb_idx);
-
-    return op;
-}
-
 static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
                                TCGOp *begin_op, TCGOp *op,
                                int *unused)
@@ -482,11 +388,6 @@ typedef TCGOp *(*inject_fn)(const struct qemu_plugin_dyn_cb *cb,
                             TCGOp *begin_op, TCGOp *op, int *intp);
 typedef bool (*op_ok_fn)(const TCGOp *op, const struct qemu_plugin_dyn_cb *cb);
 
-static bool op_ok(const TCGOp *op, const struct qemu_plugin_dyn_cb *cb)
-{
-    return true;
-}
-
 static bool op_rw(const TCGOp *op, const struct qemu_plugin_dyn_cb *cb)
 {
     int w;
@@ -524,12 +425,6 @@ static void inject_cb_type(const GArray *cbs, TCGOp *begin_op,
     rm_ops_range(begin_op, end_op);
 }
 
-static void
-inject_udata_cb(const GArray *cbs, TCGOp *begin_op)
-{
-    inject_cb_type(cbs, begin_op, append_udata_cb, op_ok);
-}
-
 static void
 inject_inline_cb(const GArray *cbs, TCGOp *begin_op, op_ok_fn ok)
 {
@@ -542,71 +437,6 @@ inject_mem_cb(const GArray *cbs, TCGOp *begin_op)
     inject_cb_type(cbs, begin_op, append_mem_cb, op_rw);
 }
 
-/* we could change the ops in place, but we can reuse more code by copying */
-static void inject_mem_helper(TCGOp *begin_op, GArray *arr)
-{
-    TCGOp *orig_op = begin_op;
-    TCGOp *end_op;
-    TCGOp *op;
-
-    end_op = find_op(begin_op, INDEX_op_plugin_cb_end);
-    tcg_debug_assert(end_op);
-
-    /* const ptr */
-    op = copy_const_ptr(&begin_op, end_op, arr);
-
-    /* st_ptr */
-    op = copy_st_ptr(&begin_op, op);
-
-    rm_ops_range(orig_op, end_op);
-}
-
-/*
- * Tracking memory accesses performed from helpers requires extra work.
- * If an instruction is emulated with helpers, we do two things:
- * (1) copy the CB descriptors, and keep track of it so that they can be
- * freed later on, and (2) point CPUState.plugin_mem_cbs to the descriptors, so
- * that we can read them at run-time (i.e. when the helper executes).
- * This run-time access is performed from qemu_plugin_vcpu_mem_cb.
- *
- * Note that plugin_gen_disable_mem_helpers undoes (2). Since it
- * is possible that the code we generate after the instruction is
- * dead, we also add checks before generating tb_exit etc.
- */
-static void inject_mem_enable_helper(struct qemu_plugin_tb *ptb,
-                                     struct qemu_plugin_insn *plugin_insn,
-                                     TCGOp *begin_op)
-{
-    GArray *cbs[2];
-    GArray *arr;
-    size_t n_cbs, i;
-
-    cbs[0] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
-    cbs[1] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE];
-
-    n_cbs = 0;
-    for (i = 0; i < ARRAY_SIZE(cbs); i++) {
-        n_cbs += cbs[i]->len;
-    }
-
-    plugin_insn->mem_helper = plugin_insn->calls_helpers && n_cbs;
-    if (likely(!plugin_insn->mem_helper)) {
-        rm_ops(begin_op);
-        return;
-    }
-    ptb->mem_helper = true;
-
-    arr = g_array_sized_new(false, false,
-                            sizeof(struct qemu_plugin_dyn_cb), n_cbs);
-
-    for (i = 0; i < ARRAY_SIZE(cbs); i++) {
-        g_array_append_vals(arr, cbs[i]->data, cbs[i]->len);
-    }
-
-    qemu_plugin_add_dyn_cb_arr(arr);
-    inject_mem_helper(begin_op, arr);
-}
-
 /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
 void plugin_gen_disable_mem_helpers(void)
 {
@@ -615,30 +445,6 @@ void plugin_gen_disable_mem_helpers(void)
     }
 }
 
-static void plugin_gen_insn_udata(const struct qemu_plugin_tb *ptb,
-                                  TCGOp *begin_op, int insn_idx)
-{
-    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
-
-    inject_udata_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR], begin_op);
-}
-
-static void plugin_gen_insn_udata_r(const struct qemu_plugin_tb *ptb,
-                                    TCGOp *begin_op, int insn_idx)
-{
-    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
-
-    inject_udata_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR_R], begin_op);
-}
-
-static void plugin_gen_insn_inline(const struct qemu_plugin_tb *ptb,
-                                   TCGOp *begin_op, int insn_idx)
-{
-    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
-    inject_inline_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
-                     begin_op, op_ok);
-}
-
 static void plugin_gen_mem_regular(const struct qemu_plugin_tb *ptb,
                                    TCGOp *begin_op, int insn_idx)
 {
@@ -656,11 +462,51 @@ static void plugin_gen_mem_inline(const struct qemu_plugin_tb *ptb,
     inject_inline_cb(cbs, begin_op, op_rw);
 }
 
-static void plugin_gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
-                                         TCGOp *begin_op, int insn_idx)
+static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
+                                  struct qemu_plugin_insn *insn)
 {
-    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
-    inject_mem_enable_helper(ptb, insn, begin_op);
+    GArray *cbs[2];
+    GArray *arr;
+    size_t n_cbs;
+
+    /*
+     * Tracking memory accesses performed from helpers requires extra work.
+     * If an instruction is emulated with helpers, we do two things:
+     * (1) copy the CB descriptors, and keep track of it so that they can be
+     * freed later on, and (2) point CPUState.plugin_mem_cbs to the
+     * descriptors, so that we can read them at run-time
+     * (i.e. when the helper executes).
+     * This run-time access is performed from qemu_plugin_vcpu_mem_cb.
+     *
+     * Note that plugin_gen_disable_mem_helpers undoes (2). Since it
+     * is possible that the code we generate after the instruction is
+     * dead, we also add checks before generating tb_exit etc.
+     */
+    if (!insn->calls_helpers) {
+        return;
+    }
+
+    cbs[0] = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
+    cbs[1] = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE];
+    n_cbs = cbs[0]->len + cbs[1]->len;
+
+    if (n_cbs == 0) {
+        insn->mem_helper = false;
+        return;
+    }
+    insn->mem_helper = true;
+    ptb->mem_helper = true;
+
+    arr = g_array_sized_new(false, false,
+                            sizeof(struct qemu_plugin_dyn_cb), n_cbs);
+    g_array_append_vals(arr, cbs[0]->data, cbs[0]->len);
+    g_array_append_vals(arr, cbs[1]->data, cbs[1]->len);
+
+    qemu_plugin_add_dyn_cb_arr(arr);
+
+    tcg_gen_st_ptr(tcg_constant_ptr((intptr_t)arr), tcg_env,
+                   offsetof(CPUState, plugin_mem_cbs) -
+                   offsetof(ArchCPU, env));
 }
 
 static void gen_disable_mem_helper(void)
@@ -824,6 +670,26 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 }
                 break;
 
+            case PLUGIN_GEN_FROM_INSN:
+                assert(insn != NULL);
+
+                gen_enable_mem_helper(plugin_tb, insn);
+
+                cbs = insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR];
+                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
+                    struct qemu_plugin_dyn_cb *cb =
+                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
+                    gen_udata_cb(cb);
+                }
+
+                cbs = insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE];
+                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
+                    struct qemu_plugin_dyn_cb *cb =
+                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
+                    gen_inline_cb(cb);
+                }
+                break;
+
             default:
                 g_assert_not_reached();
             }
@@ -839,28 +705,6 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
             enum plugin_gen_cb type = op->args[1];
 
             switch (from) {
-            case PLUGIN_GEN_FROM_INSN:
-            {
-                g_assert(insn_idx >= 0);
-
-                switch (type) {
-                case PLUGIN_GEN_CB_UDATA:
-                    plugin_gen_insn_udata(plugin_tb, op, insn_idx);
-                    break;
-                case PLUGIN_GEN_CB_UDATA_R:
-                    plugin_gen_insn_udata_r(plugin_tb, op, insn_idx);
-                    break;
-                case PLUGIN_GEN_CB_INLINE:
-                    plugin_gen_insn_inline(plugin_tb, op, insn_idx);
-                    break;
-                case PLUGIN_GEN_ENABLE_MEM_HELPER:
-                    plugin_gen_enable_mem_helper(plugin_tb, op, insn_idx);
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
-            }
             case PLUGIN_GEN_FROM_MEM:
             {
                 g_assert(insn_idx >= 0);
diff --git a/plugins/api.c b/plugins/api.c
index 5d119e8049..29cce2d97c 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -115,12 +115,8 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             void *udata)
 {
     if (!insn->mem_only) {
-        int index = flags == QEMU_PLUGIN_CB_R_REGS ||
-                    flags == QEMU_PLUGIN_CB_RW_REGS ?
-                    PLUGIN_CB_REGULAR_R : PLUGIN_CB_REGULAR;
-
-        plugin_register_dyn_cb__udata(&insn->cbs[PLUGIN_CB_INSN][index],
-                                      cb, flags, udata);
+        plugin_register_dyn_cb__udata(
+            &insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR], cb, flags, udata);
     }
 }
 
-- 
2.34.1


