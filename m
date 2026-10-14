Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AB1CC6B25
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpsE-0002Yf-VG; Tue, 13 Oct 2026 23:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpsD-0002U3-FE
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:49 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpsB-0001mm-71
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:49 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-398a4dcf289so1916197a91.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949306; x=1792554106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fWwiX9qlCVlGJZ20VXjJKHuc7sbsBOv9A2igLxGQovI=;
 b=pjvCPsDSyCoBl5VZ37oO11SCzNFsDQw4DbXqIbFqAZkHFk6c5e7woLo0O+8UGx9lnx
 YN5/HNDTHnjNrlozWH+N+dlOpvLvDxZ2y8YGXtlFktilgsPVCi/6n/J0AU2OVM6pisGr
 6HrNPW4ORyB2wuRGe4B57booxqs85i76WrM7yeMftje5z0AgrGIooDe7Kawen2DUBhC+
 kSF/xq+zLy/2We9Ctt3KwDukwLznthMbMqD30jTOIafaUjAKTMzEYVIJlOqaAQ7lnLYH
 pY1+MXSJeX1/VLpLXsW8olvJTVBvnNkrnq5ZiUbgOGXGEHQRgpbOa/91S16g7uauiZJ9
 2f6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949306; x=1792554106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fWwiX9qlCVlGJZ20VXjJKHuc7sbsBOv9A2igLxGQovI=;
 b=ciZAmI6xVfPpp93HnQqT0/CbfGPyl1NR/XAhVvOKxT386ZsaBBvBfwEzrc2HQd8TB+
 t29GKoNuV+xtme/4i8I2kQMLoxmqPoKSmBWY7MmDc7KUAYJ2pIO7SEDMnNlDk+geJ0mP
 1E0TUZ7HSzmLRuJindMUAEuwXu6t379RXV02ro3gVbORj0k/1FA2w6TNjkoxhB1WzLr5
 DYW1swLNViTHvd7RzVgrMgP6oXanuTVW0zedM26xh4rQcTwtpPYDNqCMDwkHxSgAUSPZ
 1NuFEz8MUzNQnXorto+mUyz5JGRd8cPwIeUkdc7w/5UAld94E/tDTBB7aE9q3tNwKtrK
 0Cew==
X-Gm-Message-State: AFq9FYJKJ6pI5DXNm0tzdGG9dCUmfJV3A3U2F56SD1ZNkuhRa20AdCdf
 dmGDNFzZNcN3Cal1tK+3oSxtC2YCBHI5NcXtXZ88K4Twc+ghTXfgzZ01pYGsYQ==
X-Gm-Gg: AYBFou1uR9HUHLuWsxe9Pzgs3XYxUSkBaPjukLy1MHQX+sCXIMPZjOr7QfbXrF2GHDr
 OfMEiKwbo+u9MEgyc9jhpcvagorN7MYubLw8KCUlk1y2MTZeLoMBUXBuCXVIvex5xxFYGMG0HVf
 WwyCMMWNBkkJpUNRMMATzU9M1fmJtoqkx7JmbEvQKoVzUibzOjs5rsvsunZV3OjtwIAagKufk9p
 PCyZfmn0gUdQszJgl6MHFsoAOiJ/FXn2LzCU18qKax8MFN97n/9DhuB/aWWmq9n85CamNzbWBmP
 m2DXAFe2xmtZ20dbMt+FiAq88iN6RbXBXvbQ7QgnO/AUoTWZNaPSWR8gBxxqqFNZuzOnJQ+4tA+
 lZy9A1FGlc5ocVCABQhNSs/MD1XrvFz+08lxNcui+rPoV9nB/2vV2cRoh4lV3AuVrZ8q27qUZMt
 R0sNA9c6XTAkfVdon7k9YJt97nIYFrjYUVWO/juaWE4Bj9DLw42vD4SVnmxejI4/82fRiXLDSBY
 Gn7w/OQICSCH1Iq
X-Received: by 2002:a17:90b:2687:b0:3a7:e0ab:d923 with SMTP id
 98e67ed59e1d1-3ab3acb9ce5mr12067085a91.39.1791949305580; 
 Tue, 13 Oct 2026 20:41:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:41:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, Rick <rick@sloservers.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 45/52] Revert "linux-user/riscv: invalidate reservations after
 stores"
Date: Wed, 14 Oct 2026 13:39:00 +1000
Message-ID: <20261014033907.3332383-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20261001232119.1765494-1-alistair.francis@wdc.com>
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
index bbef354354..61dc25e209 100644
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
index 62d53729b9..1cffcad580 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1387,11 +1387,6 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
 /* Zalrsc SC write probe */
 DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
 
-#ifdef CONFIG_USER_ONLY
-/* Invalidate reservations overlapping a completed linux-user store. */
-DEF_HELPER_3(riscv_invalidate_reservations, void, env, tl, tl)
-#endif
-
 /* SiFive Custom int8 Matrix-Multiply */
 DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5e7a7f782d..a682350d28 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1095,9 +1095,6 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
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
index dc76055b80..b8b3e43ccd 100644
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
index 470a5e71b2..ede9c2563f 100644
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
@@ -1153,34 +1150,10 @@ static bool gen_unary_per_ol(DisasContext *ctx, arg_r2 *a, DisasExtend ext,
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
@@ -1195,9 +1168,6 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
     func(dest, src1, src2, ctx->mem_idx, mop);
-#ifdef CONFIG_USER_ONLY
-    gen_riscv_invalidate_reservations(src1, mop);
-#endif
 
     gen_set_gpr(ctx, a->rd, dest);
     return true;
@@ -1526,10 +1496,6 @@ void riscv_translate_init(void)
     size_t pc_offset     = offsetof(CPURISCVState, pc) + field_offset;
     size_t res_offset    = offsetof(CPURISCVState, load_res) + field_offset;
     size_t val_offset    = offsetof(CPURISCVState, load_val) + field_offset;
-#ifdef CONFIG_USER_ONLY
-    size_t res_size_offset = offsetof(CPURISCVState, load_res_size)
-                             + field_offset;
-#endif
 
     for (i = 1; i < 32; i++) {
         cpu_gpr[i] = tcg_global_mem_new(tcg_env,
@@ -1549,9 +1515,5 @@ void riscv_translate_init(void)
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
index cb83b5247e..ecebec0eef 100644
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


