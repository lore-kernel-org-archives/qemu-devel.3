Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B257CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 18:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDRmX-0004sO-9T; Mon, 27 Oct 2025 14:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRmS-0004rG-R4
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:17:22 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRm9-0003ym-UY
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=LPqMvd/KP6bSzTAxxYWPGChwz82wcPrkdDVYLW87PrU=; b=sQpwS8EwKVPz50V
 vBiO4vTjcyqmemZBUVuIvTANx5v4l9aZWbSjXD0Ll8a+mQKLW5vT+uGU/XxDNKl1K8AWjKqj089n4
 CSv9b//LrC7/Zv2Ur+W3fNzcdyiREgYY9YR/hvgegROEzRiF7cK9hn44fUjJimgFmbnKCqxvofVX7
 fU=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v4 10/33] target/riscv: Fix size of vector CSRs
Date: Mon, 27 Oct 2025 19:18:07 +0100
Message-ID: <20251027181831.27016-11-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-1-anjo@rev.ng>
References: <20251027181831.27016-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to version 20250508 of the unprivileged specification:
- vtype: bits 0..7 used, bit XLEN-1 illegal, rest reserved
  => fix to 64-bits.

- vxsat: bit 0 used, vxrm which would occupy bits 1..2 is stored
  separately, and bits 3..31 are set to 0
  => fix to 8-bits.

- vxrm: 2 lowest bits are used for rounding mode, rest set to 0
  => fix to 8-bits.

- vstart: maximum value of VLMAX-1, where VLMAX is at most 2^16
  => fix to 32-bits as vstart is mapped to a TCG global.

- vl: maximum value of VLEN which is at most 2^16
  => fix to 32-bits as vl is mapped to a TCG global.

Fields are shuffled for reduced padding.

Note, the cpu/vector VMSTATE version is bumped, breaking migration from
older versions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/riscv/cpu.h                      | 12 ++++++------
 target/riscv/machine.c                  | 14 +++++++-------
 target/riscv/translate.c                | 12 ++++++++----
 target/riscv/vector_helper.c            | 22 ++++++++++++++++++----
 target/riscv/insn_trans/trans_rvv.c.inc | 24 ++++++++++++------------
 5 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6b4edbfe9e..bd200ccad4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -192,7 +192,7 @@ FIELD(VTYPE, VSEW, 3, 3)
 FIELD(VTYPE, VTA, 6, 1)
 FIELD(VTYPE, VMA, 7, 1)
 FIELD(VTYPE, VEDIV, 8, 2)
-FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
+FIELD(VTYPE, RESERVED, 10, sizeof(uint64_t) * 8 - 11)
 
 typedef struct PMUCTRState {
     /* Current value of a counter */
@@ -218,11 +218,11 @@ struct CPUArchState {
 
     /* vector coprocessor state. */
     uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
-    target_ulong vxrm;
-    target_ulong vxsat;
-    target_ulong vl;
-    target_ulong vstart;
-    target_ulong vtype;
+    uint64_t vtype;
+    uint32_t vl;
+    uint32_t vstart;
+    uint8_t vxrm;
+    uint8_t vxsat;
     bool vill;
 
     target_ulong pc;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 7349383eab..440b09fc32 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -137,16 +137,16 @@ static bool vector_needed(void *opaque)
 
 static const VMStateDescription vmstate_vector = {
     .name = "cpu/vector",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .needed = vector_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.vreg, RISCVCPU, 32 * RV_VLEN_MAX / 64),
-        VMSTATE_UINTTL(env.vxrm, RISCVCPU),
-        VMSTATE_UINTTL(env.vxsat, RISCVCPU),
-        VMSTATE_UINTTL(env.vl, RISCVCPU),
-        VMSTATE_UINTTL(env.vstart, RISCVCPU),
-        VMSTATE_UINTTL(env.vtype, RISCVCPU),
+        VMSTATE_UINT64(env.vtype, RISCVCPU),
+        VMSTATE_UINT32(env.vl, RISCVCPU),
+        VMSTATE_UINT32(env.vstart, RISCVCPU),
+        VMSTATE_UINT8(env.vxrm, RISCVCPU),
+        VMSTATE_UINT8(env.vxsat, RISCVCPU),
         VMSTATE_BOOL(env.vill, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 8df1a2ed3c..15eee7f6ee 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -39,8 +39,9 @@
 #include "tcg/tcg-cpu.h"
 
 /* global register indices */
-static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
+static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
+static TCGv_i32 cpu_vl, cpu_vstart;
 static TCGv load_res;
 static TCGv load_val;
 
@@ -1455,6 +1456,10 @@ void riscv_translate_init(void)
     size_t field_offset = 0;
 #endif
 
+    /* 32 bits in size, no offset needed */
+    size_t vl_offset = offsetof(CPURISCVState, vl);
+    size_t vstart_offset = offsetof(CPURISCVState, vstart);
+
     for (i = 1; i < 32; i++) {
         cpu_gpr[i] = tcg_global_mem_new(tcg_env,
             offsetof(CPURISCVState, gpr[i]) + field_offset,
@@ -1470,9 +1475,8 @@ void riscv_translate_init(void)
     }
 
     cpu_pc = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, pc), "pc");
-    cpu_vl = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, vl), "vl");
-    cpu_vstart = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, vstart),
-                            "vstart");
+    cpu_vl = tcg_global_mem_new_i32(tcg_env, vl_offset, "vl");
+    cpu_vstart = tcg_global_mem_new_i32(tcg_env, vstart_offset, "vstart");
     load_res = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_res),
                              "load_res");
     load_val = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_val),
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 2de3358ee8..cf9a199566 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -360,6 +360,12 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     uint32_t evl = env->vstart + elems;
     MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
 
+    /*
+     * Maximum vector length is VLMAX == 2^16 == LMUL * VL / SEW, and
+     * occurs for LMUL == 8, SEW == 8, VL == 2^16.
+     */
+    g_assert(env->vstart < UINT16_MAX && UINT16_MAX - env->vstart >= elems);
+
     /* Check page permission/pmp/watchpoint/etc. */
     probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &flags,
                 true);
@@ -2594,19 +2600,27 @@ static inline uint8_t get_round(int vxrm, uint64_t v, uint8_t shift)
 
     d1 = extract64(v, shift - 1, 1);
     D1 = extract64(v, 0, shift);
-    if (vxrm == 0) { /* round-to-nearest-up (add +0.5 LSB) */
+    switch (vxrm) {
+    case 0:
+        /* round-to-nearest-up (add +0.5 LSB) */
         return d1;
-    } else if (vxrm == 1) { /* round-to-nearest-even */
+    case 1:
+        /* round-to-nearest-even */
         if (shift > 1) {
             D2 = extract64(v, 0, shift - 1);
             return d1 & ((D2 != 0) | d);
         } else {
             return d1 & d;
         }
-    } else if (vxrm == 3) { /* round-to-odd (OR bits into LSB, aka "jam") */
+    case 2:
+        /* round-down (truncate) */
+        return 0;
+    case 3:
+        /* round-to-odd (OR bits into LSB, aka "jam") */
         return !d & (D1 != 0);
+    default:
+        g_assert_not_reached();
     }
-    return 0; /* round-down (truncate) */
 }
 
 static inline int32_t aadd32(CPURISCVState *env, int vxrm, int32_t a,
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 2a487179f6..32474a21dc 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -194,7 +194,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
 
     if (rd == 0 && rs1 == 0) {
         s1 = tcg_temp_new();
-        tcg_gen_mov_tl(s1, cpu_vl);
+        tcg_gen_ext_i32_tl(s1, cpu_vl);
     } else if (rs1 == 0) {
         /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
         s1 = tcg_constant_tl(RV_VLEN_MAX);
@@ -1213,9 +1213,9 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
                             MO_LE | MO_64 | atomicity);
                 }
                 if (i == size - 8) {
-                    tcg_gen_movi_tl(cpu_vstart, 0);
+                    tcg_gen_movi_i32(cpu_vstart, 0);
                 } else {
-                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 8 >> log2_esz);
+                    tcg_gen_addi_i32(cpu_vstart, cpu_vstart, 8 >> log2_esz);
                 }
             }
         } else {
@@ -1231,9 +1231,9 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
                             MO_LE | MO_32 | atomicity);
                 }
                 if (i == size - 4) {
-                    tcg_gen_movi_tl(cpu_vstart, 0);
+                    tcg_gen_movi_i32(cpu_vstart, 0);
                 } else {
-                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 4 >> log2_esz);
+                    tcg_gen_addi_i32(cpu_vstart, cpu_vstart, 4 >> log2_esz);
                 }
             }
         }
@@ -3459,7 +3459,7 @@ static bool trans_vmv_x_s(DisasContext *s, arg_vmv_x_s *a)
         vec_element_loadi(s, t1, a->rs2, 0, true);
         tcg_gen_trunc_i64_tl(dest, t1);
         gen_set_gpr(s, a->rd, dest);
-        tcg_gen_movi_tl(cpu_vstart, 0);
+        tcg_gen_movi_i32(cpu_vstart, 0);
         finalize_rvv_inst(s);
         return true;
     }
@@ -3476,7 +3476,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         TCGv s1;
         TCGLabel *over = gen_new_label();
 
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
+        tcg_gen_brcond_i32(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         t1 = tcg_temp_new_i64();
 
@@ -3488,7 +3488,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         tcg_gen_ext_tl_i64(t1, s1);
         vec_element_storei(s, a->rd, 0, t1);
         gen_set_label(over);
-        tcg_gen_movi_tl(cpu_vstart, 0);
+        tcg_gen_movi_i32(cpu_vstart, 0);
         finalize_rvv_inst(s);
         return true;
     }
@@ -3516,7 +3516,7 @@ static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
         }
 
         mark_fs_dirty(s);
-        tcg_gen_movi_tl(cpu_vstart, 0);
+        tcg_gen_movi_i32(cpu_vstart, 0);
         finalize_rvv_inst(s);
         return true;
     }
@@ -3536,7 +3536,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
         TCGLabel *over = gen_new_label();
 
         /* if vstart >= vl, skip vector register write back */
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
+        tcg_gen_brcond_i32(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         /* NaN-box f[rs1] */
         t1 = tcg_temp_new_i64();
@@ -3545,7 +3545,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
         vec_element_storei(s, a->rd, 0, t1);
 
         gen_set_label(over);
-        tcg_gen_movi_tl(cpu_vstart, 0);
+        tcg_gen_movi_i32(cpu_vstart, 0);
         finalize_rvv_inst(s);
         return true;
     }
@@ -3610,7 +3610,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
                                                                         \
         fns[s->sew](dest, mask, src1, src2, tcg_env, desc);             \
                                                                         \
-        tcg_gen_movi_tl(cpu_vstart, 0);                                 \
+        tcg_gen_movi_i32(cpu_vstart, 0);                                \
         finalize_rvv_inst(s);                                           \
                                                                         \
         return true;                                                    \
-- 
2.51.0


