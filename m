Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E1ECD129A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWAW-00028g-Cv; Thu, 04 Apr 2024 19:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAE-000237-8l
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:34 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWA9-0007ko-Uo
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:32 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2a2f82ded89so485885a91.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271988; x=1712876788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJHHILIZeAXQQp3muG0Zx3EhXXpXgC+WOu9E4BLXxf0=;
 b=XJ6H3smptko/LaYTm+ITUpq7U5mmNiNFX+Xvy5G/RhObLkFQEmdEZMHaSPb9TQMvsd
 2lQ2k1zvYU9yzHTgkp8uGufGt3fsBFXEKuWTVFAj1+SeH9VzzF+dsXzjpJYLsPdzO32R
 nVsnjLa0jsRH/D3Haq9sJE+P1/0cJ2dVbLOnHoa3zVawWVL65Uo0lTR/hiIRMnsbUkpy
 nl+mBxqsEKASULJQNcVb9kFHW0oU5yp1i4zTKbQU7ZNPXUFQA78mMf/7HZkJoWSAmHJp
 DyvX3fc0SNegEieYpmG5aZZfNW+JOVIq0lXEkLHHnoRwziqtfZx4C++uOhbXea5a7PoG
 E5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271988; x=1712876788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJHHILIZeAXQQp3muG0Zx3EhXXpXgC+WOu9E4BLXxf0=;
 b=TmhRn9PE3kWOPcSuxiUJ/vr4qZWEltHRyDvuHQC3z/TaIHyH0QubHW98ha0AZeGtqm
 0p0ybMi0XcFF1DbUvG8LCH0DUVzTKnZkivvdDGYJeqTMMvLJ5c987+URzOHk+qkw11hg
 03fk1NoVLy+3oilFh5Lg51Fg2gjoF3r6kwyW234xIXpXCExplQyCTPKjyTLbCvdqLHIz
 F+8QVCL1MpMbYku6PU5u0/bjPlAyL8+L/gHc5S5q0lmoClDnY5w8jpHieRrjratoiFxt
 a45ibLFICe68i1zwM5iTbr04IY0OGwxvJmpgRpaCUSr9FFh4EpFWwbCyGa4hZAYP2kjE
 v+HA==
X-Gm-Message-State: AOJu0YxGue/TGaRh3PpEmqpFcs58rwYcHa489uwp09C6r2MdyiZF5Obk
 KkrltldxK8BC9SnXY+kJpSHU+jQ+2I36iQz+uTzhba2CN20sHdadDxKmaCszW+VnvTx1b9XcxvM
 X
X-Google-Smtp-Source: AGHT+IEPRXjZmeR6dUpN9ksNxtFL83vXsXnyHFDW9My7nQZfUfZ/6TBrCGQeMksLV1dg//tlbf6aiw==
X-Received: by 2002:a17:90b:3595:b0:2a2:c127:5aed with SMTP id
 mm21-20020a17090b359500b002a2c1275aedmr1417466pjb.0.1712271988294; 
 Thu, 04 Apr 2024 16:06:28 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 11/21] plugins: Use emit_before_op for PLUGIN_GEN_FROM_MEM
Date: Thu,  4 Apr 2024 13:06:01 -1000
Message-Id: <20240404230611.21231-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Introduce a new plugin_mem_cb op to hold the address temp
and meminfo computed by tcg-op-ldst.c.  Because this now
has its own opcode, we no longer need PLUGIN_GEN_FROM_MEM.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/plugin-gen.h   |   4 -
 include/tcg/tcg-op-common.h |   1 +
 include/tcg/tcg-opc.h       |   1 +
 accel/tcg/plugin-gen.c      | 408 ++++--------------------------------
 tcg/tcg-op-ldst.c           |   6 +-
 tcg/tcg-op.c                |   5 +
 6 files changed, 54 insertions(+), 371 deletions(-)

diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index c4552b5061..f333f33198 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -25,7 +25,6 @@ void plugin_gen_insn_start(CPUState *cpu, const struct DisasContextBase *db);
 void plugin_gen_insn_end(void);
 
 void plugin_gen_disable_mem_helpers(void);
-void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t info);
 
 #else /* !CONFIG_PLUGIN */
 
@@ -48,9 +47,6 @@ static inline void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
 static inline void plugin_gen_disable_mem_helpers(void)
 { }
 
-static inline void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t info)
-{ }
-
 #endif /* CONFIG_PLUGIN */
 
 #endif /* QEMU_PLUGIN_GEN_H */
diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9de5a7f280..72b80b20d0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -75,6 +75,7 @@ void tcg_gen_goto_tb(unsigned idx);
 void tcg_gen_lookup_and_goto_ptr(void);
 
 void tcg_gen_plugin_cb(unsigned from);
+void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr);
 void tcg_gen_plugin_cb_end(void);
 
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 3b7cb2bce1..be9e36e386 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -198,6 +198,7 @@ DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
+DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_cb_start, 0, 0, 3, TCG_OPF_NOT_PRESENT)
 DEF(plugin_cb_end, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index a3dd82df4b..8f8ae156b6 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -67,7 +67,6 @@
 enum plugin_gen_from {
     PLUGIN_GEN_FROM_TB,
     PLUGIN_GEN_FROM_INSN,
-    PLUGIN_GEN_FROM_MEM,
     PLUGIN_GEN_AFTER_INSN,
     PLUGIN_GEN_AFTER_TB,
     PLUGIN_GEN_N_FROMS,
@@ -98,60 +97,6 @@ void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
                                 void *userdata)
 { }
 
-/*
- * For now we only support addi_i64.
- * When we support more ops, we can generate one empty inline cb for each.
- */
-static void gen_empty_inline_cb(void)
-{
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-    TCGv_ptr cpu_index_as_ptr = tcg_temp_ebb_new_ptr();
-    TCGv_i64 val = tcg_temp_ebb_new_i64();
-    TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
-
-    tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    /* second operand will be replaced by immediate value */
-    tcg_gen_mul_i32(cpu_index, cpu_index, cpu_index);
-    tcg_gen_ext_i32_ptr(cpu_index_as_ptr, cpu_index);
-
-    tcg_gen_movi_ptr(ptr, 0);
-    tcg_gen_add_ptr(ptr, ptr, cpu_index_as_ptr);
-    tcg_gen_ld_i64(val, ptr, 0);
-    /* second operand will be replaced by immediate value */
-    tcg_gen_add_i64(val, val, val);
-
-    tcg_gen_st_i64(val, ptr, 0);
-    tcg_temp_free_ptr(ptr);
-    tcg_temp_free_i64(val);
-    tcg_temp_free_ptr(cpu_index_as_ptr);
-    tcg_temp_free_i32(cpu_index);
-}
-
-static void gen_empty_mem_cb(TCGv_i64 addr, uint32_t info)
-{
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-    TCGv_i32 meminfo = tcg_temp_ebb_new_i32();
-    TCGv_ptr udata = tcg_temp_ebb_new_ptr();
-
-    tcg_gen_movi_i32(meminfo, info);
-    tcg_gen_movi_ptr(udata, 0);
-    tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-
-    gen_helper_plugin_vcpu_mem_cb(cpu_index, meminfo, addr, udata);
-
-    tcg_temp_free_ptr(udata);
-    tcg_temp_free_i32(meminfo);
-    tcg_temp_free_i32(cpu_index);
-}
-
-static void gen_plugin_cb_start(enum plugin_gen_from from,
-                                enum plugin_gen_cb type, unsigned wr)
-{
-    tcg_gen_plugin_cb_start(from, type, wr);
-}
-
 static void plugin_gen_empty_callback(enum plugin_gen_from from)
 {
     switch (from) {
@@ -165,278 +110,6 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
     }
 }
 
-void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t info)
-{
-    enum qemu_plugin_mem_rw rw = get_plugin_meminfo_rw(info);
-
-    gen_plugin_cb_start(PLUGIN_GEN_FROM_MEM, PLUGIN_GEN_CB_MEM, rw);
-    gen_empty_mem_cb(addr, info);
-    tcg_gen_plugin_cb_end();
-
-    gen_plugin_cb_start(PLUGIN_GEN_FROM_MEM, PLUGIN_GEN_CB_INLINE, rw);
-    gen_empty_inline_cb();
-    tcg_gen_plugin_cb_end();
-}
-
-static TCGOp *find_op(TCGOp *op, TCGOpcode opc)
-{
-    while (op) {
-        if (op->opc == opc) {
-            return op;
-        }
-        op = QTAILQ_NEXT(op, link);
-    }
-    return NULL;
-}
-
-static TCGOp *rm_ops_range(TCGOp *begin, TCGOp *end)
-{
-    TCGOp *ret = QTAILQ_NEXT(end, link);
-
-    QTAILQ_REMOVE_SEVERAL(&tcg_ctx->ops, begin, end, link);
-    return ret;
-}
-
-/* remove all ops until (and including) plugin_cb_end */
-static TCGOp *rm_ops(TCGOp *op)
-{
-    TCGOp *end_op = find_op(op, INDEX_op_plugin_cb_end);
-
-    tcg_debug_assert(end_op);
-    return rm_ops_range(op, end_op);
-}
-
-static TCGOp *copy_op_nocheck(TCGOp **begin_op, TCGOp *op)
-{
-    TCGOp *old_op = QTAILQ_NEXT(*begin_op, link);
-    unsigned nargs = old_op->nargs;
-
-    *begin_op = old_op;
-    op = tcg_op_insert_after(tcg_ctx, op, old_op->opc, nargs);
-    memcpy(op->args, old_op->args, sizeof(op->args[0]) * nargs);
-
-    return op;
-}
-
-static TCGOp *copy_op(TCGOp **begin_op, TCGOp *op, TCGOpcode opc)
-{
-    op = copy_op_nocheck(begin_op, op);
-    tcg_debug_assert((*begin_op)->opc == opc);
-    return op;
-}
-
-static TCGOp *copy_const_ptr(TCGOp **begin_op, TCGOp *op, void *ptr)
-{
-    if (UINTPTR_MAX == UINT32_MAX) {
-        /* mov_i32 */
-        op = copy_op(begin_op, op, INDEX_op_mov_i32);
-        op->args[1] = tcgv_i32_arg(tcg_constant_i32((uintptr_t)ptr));
-    } else {
-        /* mov_i64 */
-        op = copy_op(begin_op, op, INDEX_op_mov_i64);
-        op->args[1] = tcgv_i64_arg(tcg_constant_i64((uintptr_t)ptr));
-    }
-    return op;
-}
-
-static TCGOp *copy_ld_i32(TCGOp **begin_op, TCGOp *op)
-{
-    return copy_op(begin_op, op, INDEX_op_ld_i32);
-}
-
-static TCGOp *copy_ext_i32_ptr(TCGOp **begin_op, TCGOp *op)
-{
-    if (UINTPTR_MAX == UINT32_MAX) {
-        op = copy_op(begin_op, op, INDEX_op_mov_i32);
-    } else {
-        op = copy_op(begin_op, op, INDEX_op_ext_i32_i64);
-    }
-    return op;
-}
-
-static TCGOp *copy_add_ptr(TCGOp **begin_op, TCGOp *op)
-{
-    if (UINTPTR_MAX == UINT32_MAX) {
-        op = copy_op(begin_op, op, INDEX_op_add_i32);
-    } else {
-        op = copy_op(begin_op, op, INDEX_op_add_i64);
-    }
-    return op;
-}
-
-static TCGOp *copy_ld_i64(TCGOp **begin_op, TCGOp *op)
-{
-    if (TCG_TARGET_REG_BITS == 32) {
-        /* 2x ld_i32 */
-        op = copy_ld_i32(begin_op, op);
-        op = copy_ld_i32(begin_op, op);
-    } else {
-        /* ld_i64 */
-        op = copy_op(begin_op, op, INDEX_op_ld_i64);
-    }
-    return op;
-}
-
-static TCGOp *copy_st_i64(TCGOp **begin_op, TCGOp *op)
-{
-    if (TCG_TARGET_REG_BITS == 32) {
-        /* 2x st_i32 */
-        op = copy_op(begin_op, op, INDEX_op_st_i32);
-        op = copy_op(begin_op, op, INDEX_op_st_i32);
-    } else {
-        /* st_i64 */
-        op = copy_op(begin_op, op, INDEX_op_st_i64);
-    }
-    return op;
-}
-
-static TCGOp *copy_add_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
-{
-    if (TCG_TARGET_REG_BITS == 32) {
-        /* all 32-bit backends must implement add2_i32 */
-        g_assert(TCG_TARGET_HAS_add2_i32);
-        op = copy_op(begin_op, op, INDEX_op_add2_i32);
-        op->args[4] = tcgv_i32_arg(tcg_constant_i32(v));
-        op->args[5] = tcgv_i32_arg(tcg_constant_i32(v >> 32));
-    } else {
-        op = copy_op(begin_op, op, INDEX_op_add_i64);
-        op->args[2] = tcgv_i64_arg(tcg_constant_i64(v));
-    }
-    return op;
-}
-
-static TCGOp *copy_mul_i32(TCGOp **begin_op, TCGOp *op, uint32_t v)
-{
-    op = copy_op(begin_op, op, INDEX_op_mul_i32);
-    op->args[2] = tcgv_i32_arg(tcg_constant_i32(v));
-    return op;
-}
-
-static TCGOp *copy_call(TCGOp **begin_op, TCGOp *op, void *func, int *cb_idx)
-{
-    TCGOp *old_op;
-    int func_idx;
-
-    /* copy all ops until the call */
-    do {
-        op = copy_op_nocheck(begin_op, op);
-    } while (op->opc != INDEX_op_call);
-
-    /* fill in the op call */
-    old_op = *begin_op;
-    TCGOP_CALLI(op) = TCGOP_CALLI(old_op);
-    TCGOP_CALLO(op) = TCGOP_CALLO(old_op);
-    tcg_debug_assert(op->life == 0);
-
-    func_idx = TCGOP_CALLO(op) + TCGOP_CALLI(op);
-    *cb_idx = func_idx;
-    op->args[func_idx] = (uintptr_t)func;
-
-    return op;
-}
-
-static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
-                               TCGOp *begin_op, TCGOp *op,
-                               int *unused)
-{
-    char *ptr = cb->inline_insn.entry.score->data->data;
-    size_t elem_size = g_array_get_element_size(
-        cb->inline_insn.entry.score->data);
-    size_t offset = cb->inline_insn.entry.offset;
-
-    op = copy_ld_i32(&begin_op, op);
-    op = copy_mul_i32(&begin_op, op, elem_size);
-    op = copy_ext_i32_ptr(&begin_op, op);
-    op = copy_const_ptr(&begin_op, op, ptr + offset);
-    op = copy_add_ptr(&begin_op, op);
-    op = copy_ld_i64(&begin_op, op);
-    op = copy_add_i64(&begin_op, op, cb->inline_insn.imm);
-    op = copy_st_i64(&begin_op, op);
-    return op;
-}
-
-static TCGOp *append_mem_cb(const struct qemu_plugin_dyn_cb *cb,
-                            TCGOp *begin_op, TCGOp *op, int *cb_idx)
-{
-    enum plugin_gen_cb type = begin_op->args[1];
-
-    tcg_debug_assert(type == PLUGIN_GEN_CB_MEM);
-
-    /* const_i32 == mov_i32 ("info", so it remains as is) */
-    op = copy_op(&begin_op, op, INDEX_op_mov_i32);
-
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
-    if (type == PLUGIN_GEN_CB_MEM) {
-        /* call */
-        op = copy_call(&begin_op, op, cb->regular.f.vcpu_udata, cb_idx);
-    }
-
-    return op;
-}
-
-typedef TCGOp *(*inject_fn)(const struct qemu_plugin_dyn_cb *cb,
-                            TCGOp *begin_op, TCGOp *op, int *intp);
-typedef bool (*op_ok_fn)(const TCGOp *op, const struct qemu_plugin_dyn_cb *cb);
-
-static bool op_rw(const TCGOp *op, const struct qemu_plugin_dyn_cb *cb)
-{
-    int w;
-
-    w = op->args[2];
-    return !!(cb->rw & (w + 1));
-}
-
-static void inject_cb_type(const GArray *cbs, TCGOp *begin_op,
-                           inject_fn inject, op_ok_fn ok)
-{
-    TCGOp *end_op;
-    TCGOp *op;
-    int cb_idx = -1;
-    int i;
-
-    if (!cbs || cbs->len == 0) {
-        rm_ops(begin_op);
-        return;
-    }
-
-    end_op = find_op(begin_op, INDEX_op_plugin_cb_end);
-    tcg_debug_assert(end_op);
-
-    op = end_op;
-    for (i = 0; i < cbs->len; i++) {
-        struct qemu_plugin_dyn_cb *cb =
-            &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
-
-        if (!ok(begin_op, cb)) {
-            continue;
-        }
-        op = inject(cb, begin_op, op, &cb_idx);
-    }
-    rm_ops_range(begin_op, end_op);
-}
-
-static void
-inject_inline_cb(const GArray *cbs, TCGOp *begin_op, op_ok_fn ok)
-{
-    inject_cb_type(cbs, begin_op, append_inline_cb, ok);
-}
-
-static void
-inject_mem_cb(const GArray *cbs, TCGOp *begin_op)
-{
-    inject_cb_type(cbs, begin_op, append_mem_cb, op_rw);
-}
-
 /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
 void plugin_gen_disable_mem_helpers(void)
 {
@@ -445,23 +118,6 @@ void plugin_gen_disable_mem_helpers(void)
     }
 }
 
-static void plugin_gen_mem_regular(const struct qemu_plugin_tb *ptb,
-                                   TCGOp *begin_op, int insn_idx)
-{
-    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
-    inject_mem_cb(insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR], begin_op);
-}
-
-static void plugin_gen_mem_inline(const struct qemu_plugin_tb *ptb,
-                                  TCGOp *begin_op, int insn_idx)
-{
-    const GArray *cbs;
-    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
-
-    cbs = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE];
-    inject_inline_cb(cbs, begin_op, op_rw);
-}
-
 static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
                                   struct qemu_plugin_insn *insn)
 {
@@ -551,6 +207,21 @@ static void gen_inline_cb(struct qemu_plugin_dyn_cb *cb)
     tcg_temp_free_ptr(ptr);
 }
 
+static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb,
+                       qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
+{
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+
+    tcg_gen_ld_i32(cpu_index, tcg_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    tcg_gen_call4(cb->regular.f.vcpu_mem, cb->regular.info, NULL,
+                  tcgv_i32_temp(cpu_index),
+                  tcgv_i32_temp(tcg_constant_i32(meminfo)),
+                  tcgv_i64_temp(addr),
+                  tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+    tcg_temp_free_i32(cpu_index);
+}
+
 /* #define DEBUG_PLUGIN_GEN_OPS */
 static void pr_ops(void)
 {
@@ -699,34 +370,43 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
             break;
         }
 
-        case INDEX_op_plugin_cb_start:
+        case INDEX_op_plugin_mem_cb:
         {
-            enum plugin_gen_from from = op->args[0];
-            enum plugin_gen_cb type = op->args[1];
+            TCGv_i64 addr = temp_tcgv_i64(arg_temp(op->args[0]));
+            qemu_plugin_meminfo_t meminfo = op->args[1];
+            struct qemu_plugin_insn *insn;
+            const GArray *cbs;
+            int i, n, rw;
 
-            switch (from) {
-            case PLUGIN_GEN_FROM_MEM:
-            {
-                g_assert(insn_idx >= 0);
+            assert(insn_idx >= 0);
+            insn = g_ptr_array_index(plugin_tb->insns, insn_idx);
+            rw = qemu_plugin_mem_is_store(meminfo) ? 2 : 1;
 
-                switch (type) {
-                case PLUGIN_GEN_CB_MEM:
-                    plugin_gen_mem_regular(plugin_tb, op, insn_idx);
-                    break;
-                case PLUGIN_GEN_CB_INLINE:
-                    plugin_gen_mem_inline(plugin_tb, op, insn_idx);
-                    break;
-                default:
-                    g_assert_not_reached();
+            tcg_ctx->emit_before_op = op;
+
+            cbs = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
+            for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
+                struct qemu_plugin_dyn_cb *cb =
+                    &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
+                if (cb->rw & rw) {
+                    gen_mem_cb(cb, meminfo, addr);
                 }
+            }
 
-                break;
-            }
-            default:
-                g_assert_not_reached();
+            cbs = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE];
+            for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
+                struct qemu_plugin_dyn_cb *cb =
+                    &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
+                if (cb->rw & rw) {
+                    gen_inline_cb(cb);
+                }
             }
+
+            tcg_ctx->emit_before_op = NULL;
+            tcg_op_remove(tcg_ctx, op);
             break;
         }
+
         default:
             /* plugins don't care about any other ops */
             break;
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index f11043b449..8510160258 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -161,14 +161,14 @@ plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
                 copy_addr = tcg_temp_ebb_new_i64();
                 tcg_gen_extu_i32_i64(copy_addr, temp_tcgv_i32(orig_addr));
             }
-            plugin_gen_empty_mem_callback(copy_addr, info);
+            tcg_gen_plugin_mem_cb(copy_addr, info);
             tcg_temp_free_i64(copy_addr);
         } else {
             if (copy_addr) {
-                plugin_gen_empty_mem_callback(copy_addr, info);
+                tcg_gen_plugin_mem_cb(copy_addr, info);
                 tcg_temp_free_i64(copy_addr);
             } else {
-                plugin_gen_empty_mem_callback(temp_tcgv_i64(orig_addr), info);
+                tcg_gen_plugin_mem_cb(temp_tcgv_i64(orig_addr), info);
             }
         }
     }
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0f2026c91c..0ae12fa49d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -317,6 +317,11 @@ void tcg_gen_plugin_cb(unsigned from)
     tcg_gen_op1(INDEX_op_plugin_cb, from);
 }
 
+void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
+{
+    tcg_gen_op2(INDEX_op_plugin_mem_cb, tcgv_i64_arg(addr), meminfo);
+}
+
 void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr)
 {
     tcg_gen_op3(INDEX_op_plugin_cb_start, from, type, wr);
-- 
2.34.1


