Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83970CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCQ5l-00018e-Hc; Thu, 01 Oct 2026 19:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xCQ5k-00018M-Ay
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 19:21:32 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xCQ5h-0001A5-P6
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 19:21:32 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d8fb334e72so29734895ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790896888; x=1791501688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=umuO7KjrzWJxY73yA3QaLJ0MmCz3EkHg6ALsjC4PLOA=;
 b=Eo4oLMUo21WRGSdSalCiFFAicUu2iHKgKXVDY/33uDR8Y34s7P7h2AtsGdEDw8Fang
 J4VpWSkld5occ3dNoKfnU8ri7xld7grmD4LsnBxpUEVs/5g7ZjoZsxbtjU2gavk49LVM
 upg4oDAMDZNAX5KozgcMx9t6FndjTWR9VKv8rN7S0OUWS09CtFd/Qs2H5R0h/V2XYOSS
 B+ipqdm0zPOQL0ykLbCym5EjtL3mSEKav+K8g4c+WLxZchvJ68HYDgJxQVIbWnI5bLGm
 2wCyPy9lZd2uCqnt8snqSj0UXv7PdpZm6cOPhz5PILdaC+KMIJ5MTvJyk5xb/1yncXqi
 H9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790896888; x=1791501688;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=umuO7KjrzWJxY73yA3QaLJ0MmCz3EkHg6ALsjC4PLOA=;
 b=eH3mzkQFATnoqCybI9Zp/NGbe+OgqVFBruzVW9HOQiMBG8OQTcKu7fBIILD9YAgeyR
 0DemTQVkTd6BmWc6iESb9e6Qan0oyAGHFliQrhbnykGakoDyUJTSr+W59uth799SvfjO
 QPX8yLLZQdeWT/oXCeF9DwX0KDTVrfge2Z+7zp1iRkVzJg5x7GAT7RPZ8Yh9ywmNJYe+
 6yx5poQcJdGL2YsbGiySeDG2D8apEx6aG5hOuFutO4Fd1VOG08rCKXGn2ZoUFiw7s8tb
 L2yHL3O3i4zsy/mcYyHnUFeAh87yNAOdaygEp0M4xEljwp/u0uNqgXZT3eNJ1AVccD8k
 8fMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxywEQ/EDl7Cjqpwa5GCwRBcrZO/AcjlliGcW2Z+ipwmkgihFud4W2Ddqme8yZvZkcokFtdy6VQRs1/@nongnu.org
X-Gm-Message-State: AFq9FYJyWhtWg26Ciy+YNqf8zr0F4m1xizI3x34ycchlSJUbai0/BV1w
 azTMUCmMV6ZydW8RtaqaWtglEvjQ6oPHGw6UzDCjkP8IVqpJdLKULnwz
X-Gm-Gg: AYBFou1f3b2ijTgHhrcT0Y5sHlINi5FGW7/XosupfadoNhjh7ai5OnflDgDW8hzq96f
 2QmJO4M2BptuvXrwjBJFpsX5Syq2N5Xsr0aMFhC+CLqvsql/6Tk/CaeV1sqVLY3NZHDvJW8vyDf
 5I8fOxDZR5qOpsiq05EZ7WbmQ79ACXGJoUG0rPPF0q3hJ79CGwFzAL/f+5yG0BXhj0a4U/mmyKs
 aOrlY8n7ZBc1SjWiqEouxMklHxGt02UdgpL/DdQfq5Tdp0m7AP2JipW6PREDXv11aNu/ndBLhNX
 CTKuBbyqz2yMC+Fd9o04GaUweV06aqMTNvrSOvBR2rXi+RZ9k/HPbSFpqehwLG03B88C6qs8xB3
 sO6hmrd95mRyDI775KWmunsZMqpQsa37anBBVPZIlZ3NLxCP2sgFkO4QhkW/OL4yXkHkgB0lrl7
 Yba3Hnp7zreHQtjMNaA0M6umGcBgak12ugVt8ZJydzNr8zUZFuq3mZwi8YPLJky6tdM2FiSHa4W
 6tufk87c2D2EQ0EzA==
X-Received: by 2002:a17:902:e88e:b0:2dd:ad73:5b69 with SMTP id
 d9443c01a7336-2e49b651eedmr8519995ad.25.1790896887555; 
 Thu, 01 Oct 2026 16:21:27 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f71c1d8sm1750815ad.70.2026.10.01.16.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 16:21:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Rick <rick@sloservers.com>
Subject: [PATCH] Revert "linux-user/riscv: invalidate reservations after
 stores"
Date: Fri,  2 Oct 2026 09:21:19 +1000
Message-ID: <20261001232119.1765494-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=alistair23@gmail.com; helo=mail-pj2-x10.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alistair Francis <alistair.francis@wdc.com>

This reverts commit 5089493e45d3be2bae9ffd2a22186f57b0cabe3f.

Rick reported that this patch results in large slowdowns when using
multiple threads. The original patch serialises all stores, resulting in
all vCPUs stopping for every store, which would explain the slowdown.

The results from Rick show

xz compressing 2 MB at -6, without and with the patch:

                 without patch    with patch
   xz -T1        5 s              122 s   (identical output)
   xz -T8        1 s              no output after 600 s

That is too large of an overhead, so let's revert this patch until a
better solution is found.

Reported-by: Rick <rick@sloservers.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/riscv/target_cpu.h                 |  2 -
 target/riscv/cpu.h                            |  3 --
 target/riscv/helper.h                         |  5 ---
 target/riscv/cpu.c                            |  3 --
 target/riscv/tcg/op_helper.c                  | 35 -----------------
 target/riscv/tcg/translate.c                  | 38 -------------------
 target/riscv/tcg/insn_trans/trans_rva.c.inc   | 24 ------------
 target/riscv/tcg/insn_trans/trans_rvi.c.inc   | 11 ------
 .../riscv/tcg/insn_trans/trans_rvzawrs.c.inc  |  3 --
 9 files changed, 124 deletions(-)

diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
index eff18b37ba..9c642367a3 100644
--- a/linux-user/riscv/target_cpu.h
+++ b/linux-user/riscv/target_cpu.h
@@ -9,8 +9,6 @@ static inline void cpu_clone_regs_child(CPURISCVState *env, target_ulong newsp,
     }
 
     env->gpr[xA0] = 0;
-    env->load_res = -1;
-    env->load_res_size = 0;
 }
 
 static inline void cpu_clone_regs_parent(CPURISCVState *env, unsigned flags)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c8ffe94cd..c2138dbd4b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -264,9 +264,6 @@ struct CPUArchState {
 
     uint64_t pc;
     uint64_t load_res;
-#ifdef CONFIG_USER_ONLY
-    uint64_t load_res_size;
-#endif
     uint64_t load_val;
 
     /* Floating-Point state */
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index aab92bf132..4fc2d3a155 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1357,8 +1357,3 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
 
 /* Zalrsc SC write probe */
 DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
-
-#ifdef CONFIG_USER_ONLY
-/* Invalidate reservations overlapping a completed linux-user store. */
-DEF_HELPER_3(riscv_invalidate_reservations, void, env, tl, tl)
-#endif
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index da4c1a090b..5fff9d745e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1084,9 +1084,6 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->xl = riscv_cpu_mxl(env);
     cs->exception_index = RISCV_EXCP_NONE;
     env->load_res = -1;
-#ifdef CONFIG_USER_ONLY
-    env->load_res_size = 0;
-#endif
     set_default_nan_mode(1, &env->fp_status);
     /* Default NaN value: sign bit clear, frac msb set */
     set_float_default_nan_pattern(0b01000000, &env->fp_status);
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index b67c7718db..3e94005d2b 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -19,9 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#ifdef CONFIG_USER_ONLY
-#include "qemu/rcu.h"
-#endif
 #include "cpu.h"
 #include "target/riscv/tcg/csr.h"
 #ifndef CONFIG_USER_ONLY
@@ -301,38 +298,6 @@ void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
     probe_write(env, addr, size, mmu_idx, ra);
 }
 
-#ifdef CONFIG_USER_ONLY
-
-void helper_riscv_invalidate_reservations(CPURISCVState *env,
-                                          target_ulong addr,
-                                          target_ulong size)
-{
-    CPUState *cpu;
-
-    /* EXCP_ATOMIC keeps other guest harts out while this list is updated. */
-    WITH_RCU_READ_LOCK_GUARD() {
-        CPU_FOREACH(cpu) {
-            CPURISCVState *other_env = cpu_env(cpu);
-            target_ulong reservation = other_env->load_res;
-            target_ulong reservation_size = other_env->load_res_size;
-            bool overlap;
-
-            if (other_env == env || reservation == (target_ulong)-1) {
-                continue;
-            }
-            overlap = reservation < addr
-                ? addr - reservation < reservation_size
-                : reservation - addr < size;
-            if (overlap) {
-                other_env->load_res = -1;
-                other_env->load_res_size = 0;
-            }
-        }
-    }
-}
-
-#endif
-
 #ifndef CONFIG_USER_ONLY
 
 target_ulong helper_sret(CPURISCVState *env)
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index cce3b6dc72..9684dbe752 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -42,9 +42,6 @@ static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
 static TCGv_i32 cpu_vl, cpu_vstart;
 static TCGv load_res;
-#ifdef CONFIG_USER_ONLY
-static TCGv load_res_size;
-#endif
 static TCGv load_val;
 
 /*
@@ -1144,34 +1141,10 @@ static bool gen_unary_per_ol(DisasContext *ctx, arg_r2 *a, DisasExtend ext,
     return gen_unary(ctx, a, ext, f_tl);
 }
 
-#ifdef CONFIG_USER_ONLY
-static bool gen_riscv_reservation_serialize(DisasContext *ctx)
-{
-    /* Keep the memory operation and reservation update in one guest step. */
-    if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
-        gen_helper_exit_atomic(tcg_env);
-        ctx->base.is_jmp = DISAS_NORETURN;
-        return false;
-    }
-    return true;
-}
-
-static void gen_riscv_invalidate_reservations(TCGv addr, MemOp mop)
-{
-    gen_helper_riscv_invalidate_reservations(tcg_env, addr,
-                                             tcg_constant_tl(memop_size(mop)));
-}
-#endif
-
 static bool gen_amo(DisasContext *ctx, arg_atomic *a,
                     void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
                     MemOp mop)
 {
-#ifdef CONFIG_USER_ONLY
-    if (!gen_riscv_reservation_serialize(ctx)) {
-        return false;
-    }
-#endif
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
     MemOp size = mop & MO_SIZE;
@@ -1186,9 +1159,6 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
     func(dest, src1, src2, ctx->mem_idx, mop);
-#ifdef CONFIG_USER_ONLY
-    gen_riscv_invalidate_reservations(src1, mop);
-#endif
 
     gen_set_gpr(ctx, a->rd, dest);
     return true;
@@ -1512,10 +1482,6 @@ void riscv_translate_init(void)
     size_t pc_offset     = offsetof(CPURISCVState, pc) + field_offset;
     size_t res_offset    = offsetof(CPURISCVState, load_res) + field_offset;
     size_t val_offset    = offsetof(CPURISCVState, load_val) + field_offset;
-#ifdef CONFIG_USER_ONLY
-    size_t res_size_offset = offsetof(CPURISCVState, load_res_size)
-                             + field_offset;
-#endif
 
     for (i = 1; i < 32; i++) {
         cpu_gpr[i] = tcg_global_mem_new(tcg_env,
@@ -1535,9 +1501,5 @@ void riscv_translate_init(void)
     cpu_vl = tcg_global_mem_new_i32(tcg_env, vl_offset, "vl");
     cpu_vstart = tcg_global_mem_new_i32(tcg_env, vstart_offset, "vstart");
     load_res = tcg_global_mem_new(tcg_env, res_offset, "load_res");
-#ifdef CONFIG_USER_ONLY
-    load_res_size = tcg_global_mem_new(tcg_env, res_size_offset,
-                                       "load_res_size");
-#endif
     load_val = tcg_global_mem_new(tcg_env, val_offset, "load_val");
 }
diff --git a/target/riscv/tcg/insn_trans/trans_rva.c.inc b/target/riscv/tcg/insn_trans/trans_rva.c.inc
index 248a8c60d7..44c1696fe4 100644
--- a/target/riscv/tcg/insn_trans/trans_rva.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rva.c.inc
@@ -32,11 +32,6 @@
 
 static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
-#ifdef CONFIG_USER_ONLY
-    if (!gen_riscv_reservation_serialize(ctx)) {
-        return false;
-    }
-#endif
     TCGv src1;
 
     mop |= MO_ALIGN;
@@ -58,9 +53,6 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
 
     /* Put addr in load_res, data in load_val.  */
     tcg_gen_mov_tl(load_res, src1);
-#ifdef CONFIG_USER_ONLY
-    tcg_gen_movi_tl(load_res_size, memop_size(mop));
-#endif
     gen_set_gpr(ctx, a->rd, load_val);
 
     return true;
@@ -68,17 +60,9 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
 
 static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
-#ifdef CONFIG_USER_ONLY
-    if (!gen_riscv_reservation_serialize(ctx)) {
-        return false;
-    }
-#endif
     TCGv dest, src1, src2;
     TCGLabel *l1 = gen_new_label();
     TCGLabel *l2 = gen_new_label();
-#ifdef CONFIG_USER_ONLY
-    TCGLabel *l3 = gen_new_label();
-#endif
 
     mop |= MO_ALIGN;
     mop |= ctx->mo_endianness;
@@ -95,11 +79,6 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
     src2 = get_gpr(ctx, a->rs2, EXT_NONE);
     tcg_gen_atomic_cmpxchg_tl(dest, load_res, load_val, src2,
                               ctx->mem_idx, mop);
-#ifdef CONFIG_USER_ONLY
-    tcg_gen_brcond_tl(TCG_COND_NE, dest, load_val, l3);
-    gen_riscv_invalidate_reservations(src1, mop);
-    gen_set_label(l3);
-#endif
     tcg_gen_setcond_tl(TCG_COND_NE, dest, dest, load_val);
     gen_set_gpr(ctx, a->rd, dest);
     tcg_gen_br(l2);
@@ -125,9 +104,6 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
      * an SC to any address, in between an LR and SC pair.
      */
     tcg_gen_movi_tl(load_res, -1);
-#ifdef CONFIG_USER_ONLY
-    tcg_gen_movi_tl(load_res_size, 0);
-#endif
 
     return true;
 }
diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index 40b4c9aa4a..cc1b5dbbad 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
@@ -489,9 +489,6 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
     }
 
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
-#ifdef CONFIG_USER_ONLY
-    gen_riscv_invalidate_reservations(addr, memop);
-#endif
     return true;
 }
 
@@ -521,19 +518,11 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
         }
         tcg_gen_qemu_st_i128(t16, addrl, ctx->mem_idx, memop);
     }
-#ifdef CONFIG_USER_ONLY
-    gen_riscv_invalidate_reservations(addrl, memop);
-#endif
     return true;
 }
 
 static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
-#ifdef CONFIG_USER_ONLY
-    if (!gen_riscv_reservation_serialize(ctx)) {
-        return false;
-    }
-#endif
     memop |= ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
diff --git a/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
index 1831bbcfc0..0eef033838 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
@@ -32,9 +32,6 @@ static bool trans_wrs_sto(DisasContext *ctx, arg_wrs_sto *a)
 
     /* Clear the load reservation  (if any).  */
     tcg_gen_movi_tl(load_res, -1);
-#ifdef CONFIG_USER_ONLY
-    tcg_gen_movi_tl(load_res_size, 0);
-#endif
 
     gen_update_pc(ctx, ctx->cur_insn_len);
     tcg_gen_exit_tb(NULL, 0);
-- 
2.55.0


