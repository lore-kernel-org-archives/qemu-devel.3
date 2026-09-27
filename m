Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E879C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmRf-00066w-HY; Sun, 27 Sep 2026 06:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRU-0005zJ-23; Sun, 27 Sep 2026 06:49:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRP-00011z-42; Sun, 27 Sep 2026 06:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506130; bh=HFWTNEYVsRXA1yt5eFrsJRvvPa9Sk/Ol2jyZx4iz71Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z2MCheQ6tcaU25aixSPkhSI7T7VnuK/5tpZzttYk2RaOoSxQDNwcrFm6WQNmiI46D
 YdTK/CuOJAVLv28xfcf7pFSFAEGflYxbHTNUZpteOG49OOkc6QlVBxo0uztlIUeDLt
 dtuvg/ZPRA1bpz8jnhN3IehacikUVslUDzvjsHcuwW7uzYROYpWo5S62e7+G85W9Ne
 QwhMR82XSsW7xp3zvAr5ZLQbaRLPvbC2bKkpWH4j7/cebHe86QBCmn/lW3BfS/LTKH
 05OHCRCkD27mlbEgTQfBC5+X4L7x9p5wBcgXYEgG0BnJwIBBQY0q5FFZrLBIPexaRN
 qspLdBDzfcJtQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8626D1D8B5F;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8344B432166;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 590815E776; Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 64/92] linux-user/riscv: invalidate reservations
 after stores
Date: Sun, 27 Sep 2026 13:47:40 +0300
Message-ID: <20260927104821.196183-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: wangyang <wangyang25@otcaix.iscas.ac.cn>

In linux-user parallel execution, AMO and ordinary integer stores do not
invalidate load reservations held by another hart. A store that preserves
the numeric value can therefore leave the reservation intact and allow a
later SC to succeed.

Use the existing EXCP_ATOMIC path to re-execute LR, SC, AMO, and ordinary
integer store instructions in a serial context. The completed store and
reservation invalidation then cannot be interleaved with another guest
hart. Track the LR access size and invalidate every other-hart reservation
whose byte range overlaps the completed store. A successful SC uses the
same invalidation helper.

Clear the reservation when cloning a new linux-user RISC-V hart so that a
child cannot inherit the parent's reservation state.

The change is limited to linux-user TCG and the base scalar integer/
A-extension translator paths.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4149

Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 5089493e45d3be2bae9ffd2a22186f57b0cabe3f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
index 9c642367a36..eff18b37bad 100644
--- a/linux-user/riscv/target_cpu.h
+++ b/linux-user/riscv/target_cpu.h
@@ -9,6 +9,8 @@ static inline void cpu_clone_regs_child(CPURISCVState *env, target_ulong newsp,
     }
 
     env->gpr[xA0] = 0;
+    env->load_res = -1;
+    env->load_res_size = 0;
 }
 
 static inline void cpu_clone_regs_parent(CPURISCVState *env, unsigned flags)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b04beee5cba..6454d05bf8e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1083,6 +1083,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->xl = riscv_cpu_mxl(env);
     cs->exception_index = RISCV_EXCP_NONE;
     env->load_res = -1;
+#ifdef CONFIG_USER_ONLY
+    env->load_res_size = 0;
+#endif
     set_default_nan_mode(1, &env->fp_status);
     /* Default NaN value: sign bit clear, frac msb set */
     set_float_default_nan_pattern(0b01000000, &env->fp_status);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e980b5964dd..77689700391 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -264,6 +264,9 @@ struct CPUArchState {
 
     uint64_t pc;
     uint64_t load_res;
+#ifdef CONFIG_USER_ONLY
+    uint64_t load_res_size;
+#endif
     uint64_t load_val;
 
     /* Floating-Point state */
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 542b7c264fc..12a294ded93 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1358,3 +1358,8 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
 
 /* Zalrsc SC write probe */
 DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
+
+#ifdef CONFIG_USER_ONLY
+/* Invalidate reservations overlapping a completed linux-user store. */
+DEF_HELPER_3(riscv_invalidate_reservations, void, env, tl, tl)
+#endif
diff --git a/target/riscv/tcg/insn_trans/trans_rva.c.inc b/target/riscv/tcg/insn_trans/trans_rva.c.inc
index 44c1696fe4d..248a8c60d79 100644
--- a/target/riscv/tcg/insn_trans/trans_rva.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rva.c.inc
@@ -32,6 +32,11 @@
 
 static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
+#ifdef CONFIG_USER_ONLY
+    if (!gen_riscv_reservation_serialize(ctx)) {
+        return false;
+    }
+#endif
     TCGv src1;
 
     mop |= MO_ALIGN;
@@ -53,6 +58,9 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
 
     /* Put addr in load_res, data in load_val.  */
     tcg_gen_mov_tl(load_res, src1);
+#ifdef CONFIG_USER_ONLY
+    tcg_gen_movi_tl(load_res_size, memop_size(mop));
+#endif
     gen_set_gpr(ctx, a->rd, load_val);
 
     return true;
@@ -60,9 +68,17 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
 
 static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
+#ifdef CONFIG_USER_ONLY
+    if (!gen_riscv_reservation_serialize(ctx)) {
+        return false;
+    }
+#endif
     TCGv dest, src1, src2;
     TCGLabel *l1 = gen_new_label();
     TCGLabel *l2 = gen_new_label();
+#ifdef CONFIG_USER_ONLY
+    TCGLabel *l3 = gen_new_label();
+#endif
 
     mop |= MO_ALIGN;
     mop |= ctx->mo_endianness;
@@ -79,6 +95,11 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
     src2 = get_gpr(ctx, a->rs2, EXT_NONE);
     tcg_gen_atomic_cmpxchg_tl(dest, load_res, load_val, src2,
                               ctx->mem_idx, mop);
+#ifdef CONFIG_USER_ONLY
+    tcg_gen_brcond_tl(TCG_COND_NE, dest, load_val, l3);
+    gen_riscv_invalidate_reservations(src1, mop);
+    gen_set_label(l3);
+#endif
     tcg_gen_setcond_tl(TCG_COND_NE, dest, dest, load_val);
     gen_set_gpr(ctx, a->rd, dest);
     tcg_gen_br(l2);
@@ -104,6 +125,9 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
      * an SC to any address, in between an LR and SC pair.
      */
     tcg_gen_movi_tl(load_res, -1);
+#ifdef CONFIG_USER_ONLY
+    tcg_gen_movi_tl(load_res_size, 0);
+#endif
 
     return true;
 }
diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index e47b16a7fa2..e61ead9ea87 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
@@ -486,6 +486,9 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
     }
 
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
+#ifdef CONFIG_USER_ONLY
+    gen_riscv_invalidate_reservations(addr, memop);
+#endif
     return true;
 }
 
@@ -515,11 +518,19 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
         }
         tcg_gen_qemu_st_i128(t16, addrl, ctx->mem_idx, memop);
     }
+#ifdef CONFIG_USER_ONLY
+    gen_riscv_invalidate_reservations(addrl, memop);
+#endif
     return true;
 }
 
 static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
+#ifdef CONFIG_USER_ONLY
+    if (!gen_riscv_reservation_serialize(ctx)) {
+        return false;
+    }
+#endif
     memop |= ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
diff --git a/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
index 0eef0338388..1831bbcfc07 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
@@ -32,6 +32,9 @@ static bool trans_wrs_sto(DisasContext *ctx, arg_wrs_sto *a)
 
     /* Clear the load reservation  (if any).  */
     tcg_gen_movi_tl(load_res, -1);
+#ifdef CONFIG_USER_ONLY
+    tcg_gen_movi_tl(load_res_size, 0);
+#endif
 
     gen_update_pc(ctx, ctx->cur_insn_len);
     tcg_gen_exit_tb(NULL, 0);
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 3e94005d2bd..b67c7718db4 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -19,6 +19,9 @@
  */
 
 #include "qemu/osdep.h"
+#ifdef CONFIG_USER_ONLY
+#include "qemu/rcu.h"
+#endif
 #include "cpu.h"
 #include "target/riscv/tcg/csr.h"
 #ifndef CONFIG_USER_ONLY
@@ -298,6 +301,38 @@ void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
     probe_write(env, addr, size, mmu_idx, ra);
 }
 
+#ifdef CONFIG_USER_ONLY
+
+void helper_riscv_invalidate_reservations(CPURISCVState *env,
+                                          target_ulong addr,
+                                          target_ulong size)
+{
+    CPUState *cpu;
+
+    /* EXCP_ATOMIC keeps other guest harts out while this list is updated. */
+    WITH_RCU_READ_LOCK_GUARD() {
+        CPU_FOREACH(cpu) {
+            CPURISCVState *other_env = cpu_env(cpu);
+            target_ulong reservation = other_env->load_res;
+            target_ulong reservation_size = other_env->load_res_size;
+            bool overlap;
+
+            if (other_env == env || reservation == (target_ulong)-1) {
+                continue;
+            }
+            overlap = reservation < addr
+                ? addr - reservation < reservation_size
+                : reservation - addr < size;
+            if (overlap) {
+                other_env->load_res = -1;
+                other_env->load_res_size = 0;
+            }
+        }
+    }
+}
+
+#endif
+
 #ifndef CONFIG_USER_ONLY
 
 target_ulong helper_sret(CPURISCVState *env)
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 9684dbe7528..cce3b6dc721 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -42,6 +42,9 @@ static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
 static TCGv_i32 cpu_vl, cpu_vstart;
 static TCGv load_res;
+#ifdef CONFIG_USER_ONLY
+static TCGv load_res_size;
+#endif
 static TCGv load_val;
 
 /*
@@ -1141,10 +1144,34 @@ static bool gen_unary_per_ol(DisasContext *ctx, arg_r2 *a, DisasExtend ext,
     return gen_unary(ctx, a, ext, f_tl);
 }
 
+#ifdef CONFIG_USER_ONLY
+static bool gen_riscv_reservation_serialize(DisasContext *ctx)
+{
+    /* Keep the memory operation and reservation update in one guest step. */
+    if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+        gen_helper_exit_atomic(tcg_env);
+        ctx->base.is_jmp = DISAS_NORETURN;
+        return false;
+    }
+    return true;
+}
+
+static void gen_riscv_invalidate_reservations(TCGv addr, MemOp mop)
+{
+    gen_helper_riscv_invalidate_reservations(tcg_env, addr,
+                                             tcg_constant_tl(memop_size(mop)));
+}
+#endif
+
 static bool gen_amo(DisasContext *ctx, arg_atomic *a,
                     void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
                     MemOp mop)
 {
+#ifdef CONFIG_USER_ONLY
+    if (!gen_riscv_reservation_serialize(ctx)) {
+        return false;
+    }
+#endif
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
     MemOp size = mop & MO_SIZE;
@@ -1159,6 +1186,9 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
     func(dest, src1, src2, ctx->mem_idx, mop);
+#ifdef CONFIG_USER_ONLY
+    gen_riscv_invalidate_reservations(src1, mop);
+#endif
 
     gen_set_gpr(ctx, a->rd, dest);
     return true;
@@ -1482,6 +1512,10 @@ void riscv_translate_init(void)
     size_t pc_offset     = offsetof(CPURISCVState, pc) + field_offset;
     size_t res_offset    = offsetof(CPURISCVState, load_res) + field_offset;
     size_t val_offset    = offsetof(CPURISCVState, load_val) + field_offset;
+#ifdef CONFIG_USER_ONLY
+    size_t res_size_offset = offsetof(CPURISCVState, load_res_size)
+                             + field_offset;
+#endif
 
     for (i = 1; i < 32; i++) {
         cpu_gpr[i] = tcg_global_mem_new(tcg_env,
@@ -1501,5 +1535,9 @@ void riscv_translate_init(void)
     cpu_vl = tcg_global_mem_new_i32(tcg_env, vl_offset, "vl");
     cpu_vstart = tcg_global_mem_new_i32(tcg_env, vstart_offset, "vstart");
     load_res = tcg_global_mem_new(tcg_env, res_offset, "load_res");
+#ifdef CONFIG_USER_ONLY
+    load_res_size = tcg_global_mem_new(tcg_env, res_size_offset,
+                                       "load_res_size");
+#endif
     load_val = tcg_global_mem_new(tcg_env, val_offset, "load_val");
 }
-- 
2.47.3


