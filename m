Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C44BCA5FED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0wu-0005ay-7Z; Thu, 08 Oct 2026 23:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vg-0004f7-RV
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:00 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vc-0005mR-K9
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:52 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id B12B7E001;
 Fri, 09 Oct 2026 08:35:45 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 13/23] target/loongarch: add LVZ parameters to TLB functions
Date: Fri,  9 Oct 2026 11:05:09 +0800
Message-ID: <21a6bf0c2a00333ecf6d936afe89e116b8988076.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

Add parameters related to LVZ (mainly vm_level) to statements and definitions
of TLB, so that LVZ patches to TLB can be divided into parts later.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu-mmu.h                    |  24 ++--
 target/loongarch/cpu_helper.c                 |  40 +++---
 target/loongarch/tcg/helper.h                 |  22 +--
 .../tcg/insn_trans/trans_privileged.c.inc     |  48 ++++---
 target/loongarch/tcg/tcg_loongarch.h          |   3 +-
 target/loongarch/tcg/tlb_helper.c             | 133 ++++++++++--------
 6 files changed, 153 insertions(+), 117 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 2b46e481bd..4d76d96ee5 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -38,18 +38,19 @@ typedef struct MMUContext {
     uint64_t      pte_buddy[2];
 } MMUContext;
 
-static inline bool cpu_has_ptw(CPULoongArchState *env)
+static inline bool cpu_has_ptw(CPULoongArchState *env, int vm_level)
 {
     CPUSysState *sys = env_sys(env);
 
     return !!FIELD_EX64(sys->CSR_PWCH, CSR_PWCH, HPTW_EN);
 }
 
-static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
+static inline bool pte_present(CPULoongArchState *env, uint64_t entry,
+                               int vm_level)
 {
     uint8_t present;
 
-    if (cpu_has_ptw(env)) {
+    if (cpu_has_ptw(env, vm_level)) {
         present = FIELD_EX64(entry, TLBENTRY, P);
     } else {
         present = FIELD_EX64(entry, TLBENTRY, V);
@@ -58,11 +59,12 @@ static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
     return !!present;
 }
 
-static inline bool pte_write(CPULoongArchState *env, uint64_t entry)
+static inline bool pte_write(CPULoongArchState *env, uint64_t entry,
+                             int vm_level)
 {
     uint8_t writable;
 
-    if (cpu_has_ptw(env)) {
+    if (cpu_has_ptw(env, vm_level)) {
         writable = FIELD_EX64(entry, TLBENTRY, W);
     } else {
         writable = FIELD_EX64(entry, TLBENTRY, D);
@@ -99,14 +101,18 @@ static inline bool pte_dirty(uint64_t entry)
 
 bool check_ps(CPULoongArchState *ent, uint8_t ps);
 TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
-                           MMUAccessType access_type, int mmu_idx);
+                           MMUAccessType access_type, int mmu_idx, int vm_level);
 TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
-                            int is_debug);
+                            int is_debug, uintptr_t retaddr);
 TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
-                     int access_type, int mmu_idx, int debug);
+                     int access_type, int mmu_idx, int debug, int vm_level,
+                     uintptr_t retaddr);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-                        uint64_t *dir_width, unsigned int level);
+                        uint64_t *dir_width, unsigned int level, int vm_level);
+TLBRet loongarch_map_address(CPULoongArchState *env, MMUContext *context,
+                             MMUAccessType access_type, int mmu_idx,
+                             int is_debug, int vm_level, uintptr_t retaddr);
 hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 uint64_t loongarch_palen_mask(CPULoongArchState *env);
 
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 123cad3d93..8eabb4a9dc 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -19,7 +19,7 @@
 #include "tcg/tcg_loongarch.h"
 
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-                        uint64_t *dir_width, unsigned int level)
+                        uint64_t *dir_width, unsigned int level, int vm_level)
 {
     CPUSysState *sys = env_sys(env);
 
@@ -49,7 +49,7 @@ void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
 }
 
 TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
-                           MMUAccessType access_type, int mmu_idx)
+                           MMUAccessType access_type, int mmu_idx, int vm_level)
 {
     uint64_t plv = mmu_idx;
     uint64_t tlb_entry, tlb_ppn;
@@ -58,8 +58,8 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
 
     tlb_entry = context->pte;
     tlb_ps = context->ps;
-    tlb_v = pte_present(env, tlb_entry);
-    tlb_d = pte_write(env, tlb_entry);
+    tlb_v = pte_present(env, tlb_entry, vm_level);
+    tlb_d = pte_write(env, tlb_entry, vm_level);
     tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
     if (is_la64(env)) {
         tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
@@ -147,7 +147,8 @@ static MemTxResult loongarch_cmpxchg_phys(CPUState *cs, hwaddr phys,
 }
 
 TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
-                     int access_type, int mmu_idx, int debug)
+                     int access_type, int mmu_idx, int debug, int vm_level,
+                     uintptr_t retaddr)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     CPUState *cs = env_cpu(env);
@@ -170,7 +171,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
     base &= palen_mask;
 
     for (level = 4; level >= 0; level--) {
-        get_dir_base_width(env, &dir_base, &dir_width, level);
+        get_dir_base_width(env, &dir_base, &dir_width, level, vm_level);
 
         if (dir_width == 0) {
             continue;
@@ -208,7 +209,7 @@ restart:
         context->pte_buddy[index] = base;
         context->pte_buddy[1 - index] = base + BIT_ULL(dir_base);
         base += (BIT_ULL(dir_base) & address);
-    } else if (cpu_has_ptw(env)) {
+    } else if (cpu_has_ptw(env, vm_level)) {
         uint64_t val;
 
         index &= 1;
@@ -220,7 +221,7 @@ restart:
 
     context->ps = dir_base;
     context->pte = base;
-    ret = loongarch_check_pte(env, context, access_type, mmu_idx);
+    ret = loongarch_check_pte(env, context, access_type, mmu_idx, vm_level);
     if (debug) {
         return ret;
     }
@@ -231,7 +232,7 @@ restart:
      * Need atomic compchxg operation with pte update, other vCPUs may
      * update pte at the same time.
      */
-    if (ret == TLBRET_MATCH && cpu_has_ptw(env)) {
+    if (ret == TLBRET_MATCH && cpu_has_ptw(env, vm_level)) {
         if (access_type == MMU_DATA_STORE && pte_dirty(base)) {
             return ret;
         }
@@ -273,15 +274,15 @@ restart:
     return ret;
 }
 
-static TLBRet loongarch_map_address(CPULoongArchState *env,
-                                    MMUContext *context,
-                                    MMUAccessType access_type, int mmu_idx,
-                                    int is_debug)
+TLBRet loongarch_map_address(CPULoongArchState *env, MMUContext *context,
+                             MMUAccessType access_type, int mmu_idx,
+                             int is_debug, int vm_level, uintptr_t retaddr)
 {
     TLBRet ret;
 
     if (tcg_enabled()) {
-        ret = loongarch_get_addr_from_tlb(env, context, access_type, mmu_idx);
+        ret = loongarch_get_addr_from_tlb(env, context, access_type, mmu_idx,
+                                          vm_level);
         if (ret != TLBRET_NOMATCH) {
             return ret;
         }
@@ -293,7 +294,8 @@ static TLBRet loongarch_map_address(CPULoongArchState *env,
          * legal mapping, even if the mapping is not yet in TLB. return 0 if
          * there is a valid map, else none zero.
          */
-        return loongarch_ptw(env, context, access_type, mmu_idx, is_debug);
+        return loongarch_ptw(env, context, access_type, mmu_idx, is_debug,
+                             vm_level, retaddr);
     }
 
     return TLBRET_NOMATCH;
@@ -312,10 +314,11 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, uint64_t dmw)
 
 TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
-                            int is_debug)
+                            int is_debug, uintptr_t retaddr)
 {
     int user_mode = mmu_idx == MMU_USER_IDX;
     int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
+    int vm_level = env_vm_level(env);
     uint32_t plv, base_c, base_v;
     int64_t addr_high;
     CPUSysState *sys = env_sys(env);
@@ -360,7 +363,8 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
     }
 
     /* Mapped address */
-    return loongarch_map_address(env, context, access_type, mmu_idx, is_debug);
+    return loongarch_map_address(env, context, access_type, mmu_idx, is_debug,
+                                 vm_level, retaddr);
 }
 
 hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
@@ -370,7 +374,7 @@ hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     context.addr = addr;
     if (get_physical_address(env, &context, MMU_DATA_LOAD,
-                             cpu_mmu_index(cs, false), 1) != TLBRET_MATCH) {
+                             cpu_mmu_index(cs, false), 1, 0) != TLBRET_MATCH) {
         return -1;
     }
     return context.physical;
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index e76c73c775..a27b80b087 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -114,17 +114,17 @@ DEF_HELPER_3(iocsrwr_w, void, env, tl, tl)
 DEF_HELPER_3(iocsrwr_d, void, env, tl, tl)
 
 /* TLB helper */
-DEF_HELPER_1(tlbwr, void, env)
-DEF_HELPER_1(tlbfill, void, env)
-DEF_HELPER_1(tlbsrch, void, env)
-DEF_HELPER_1(tlbrd, void, env)
-DEF_HELPER_1(tlbclr, void, env)
-DEF_HELPER_1(tlbflush, void, env)
-DEF_HELPER_1(invtlb_all, void, env)
-DEF_HELPER_2(invtlb_all_g, void, env, i32)
-DEF_HELPER_2(invtlb_all_asid, void, env, tl)
-DEF_HELPER_3(invtlb_page_asid, void, env, tl, tl)
-DEF_HELPER_3(invtlb_page_asid_or_g, void, env, tl, tl)
+DEF_HELPER_2(tlbwr, void, env, i32)
+DEF_HELPER_2(tlbfill, void, env, i32)
+DEF_HELPER_2(tlbsrch, void, env, i32)
+DEF_HELPER_2(tlbrd, void, env, i32)
+DEF_HELPER_2(tlbclr, void, env, i32)
+DEF_HELPER_2(tlbflush, void, env, i32)
+DEF_HELPER_4(invtlb_all, void, env, tl, i32, i32)
+DEF_HELPER_4(invtlb_all_g, void, env, tl, i32, i32)
+DEF_HELPER_3(invtlb_all_asid, void, env, tl, i32)
+DEF_HELPER_4(invtlb_page_asid, void, env, tl, tl, i32)
+DEF_HELPER_4(invtlb_page_asid_or_g, void, env, tl, tl, i32)
 
 DEF_HELPER_4(lddir, tl, env, tl, i32, i32)
 DEF_HELPER_4(ldpte, void, env, tl, tl, i32)
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 7ee3bb8e27..493ed7f24b 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -260,7 +260,8 @@ static bool trans_tlbsrch(DisasContext *ctx, arg_tlbsrch *a)
     if (check_plv(ctx)) {
         return false;
     }
-    gen_helper_tlbsrch(tcg_env);
+    gen_helper_tlbsrch(tcg_env,
+                       tcg_constant_i32(is_guest_mmu_idx(ctx->mem_idx)));
     return true;
 }
 
@@ -269,7 +270,8 @@ static bool trans_tlbrd(DisasContext *ctx, arg_tlbrd *a)
     if (check_plv(ctx)) {
         return false;
     }
-    gen_helper_tlbrd(tcg_env);
+    gen_helper_tlbrd(tcg_env,
+                     tcg_constant_i32(is_guest_mmu_idx(ctx->mem_idx)));
     return true;
 }
 
@@ -278,7 +280,8 @@ static bool trans_tlbwr(DisasContext *ctx, arg_tlbwr *a)
     if (check_plv(ctx)) {
         return false;
     }
-    gen_helper_tlbwr(tcg_env);
+    gen_helper_tlbwr(tcg_env,
+                     tcg_constant_i32(is_guest_mmu_idx(ctx->mem_idx)));
     check_mmu_idx(ctx);
     return true;
 }
@@ -288,7 +291,8 @@ static bool trans_tlbfill(DisasContext *ctx, arg_tlbfill *a)
     if (check_plv(ctx)) {
         return false;
     }
-    gen_helper_tlbfill(tcg_env);
+    gen_helper_tlbfill(tcg_env,
+                       tcg_constant_i32(is_guest_mmu_idx(ctx->mem_idx)));
     check_mmu_idx(ctx);
     return true;
 }
@@ -298,7 +302,8 @@ static bool trans_tlbclr(DisasContext *ctx, arg_tlbclr *a)
     if (check_plv(ctx)) {
         return false;
     }
-    gen_helper_tlbclr(tcg_env);
+    gen_helper_tlbclr(tcg_env,
+                      tcg_constant_i32(is_guest_mmu_idx(ctx->mem_idx)));
     check_mmu_idx(ctx);
     return true;
 }
@@ -308,7 +313,8 @@ static bool trans_tlbflush(DisasContext *ctx, arg_tlbflush *a)
     if (check_plv(ctx)) {
         return false;
     }
-    gen_helper_tlbflush(tcg_env);
+    gen_helper_tlbflush(tcg_env,
+                        tcg_constant_i32(is_guest_mmu_idx(ctx->mem_idx)));
     check_mmu_idx(ctx);
     return true;
 }
@@ -323,24 +329,28 @@ static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
     }
 
     switch (a->imm) {
-    case 0:
-    case 1:
-        gen_helper_invtlb_all(tcg_env);
+    case 0x0:
+    case 0x1:
+        gen_helper_invtlb_all(tcg_env, rj, tcg_constant_i32(a->imm),
+                              tcg_constant_i32(0));
         break;
-    case 2:
-        gen_helper_invtlb_all_g(tcg_env, tcg_constant_i32(1));
+    case 0x2:
+        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(1),
+                                tcg_constant_i32(0));
         break;
-    case 3:
-        gen_helper_invtlb_all_g(tcg_env, tcg_constant_i32(0));
+    case 0x3:
+        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(0),
+                                tcg_constant_i32(0));
         break;
-    case 4:
-        gen_helper_invtlb_all_asid(tcg_env, rj);
+    case 0x4:
+        gen_helper_invtlb_all_asid(tcg_env, rj, tcg_constant_i32(0));
         break;
-    case 5:
-        gen_helper_invtlb_page_asid(tcg_env, rj, rk);
+    case 0x5:
+        gen_helper_invtlb_page_asid(tcg_env, rj, rk, tcg_constant_i32(0));
         break;
-    case 6:
-        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk);
+    case 0x6:
+        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk,
+                                         tcg_constant_i32(0));
         break;
     default:
         return false;
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
index 7fb627f2d6..6c0080c2b3 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -18,6 +18,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
 TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
                                    MMUContext *context,
-                                   MMUAccessType access_type, int mmu_idx);
+                                   MMUAccessType access_type, int mmu_idx,
+                                   int vm_level);
 
 #endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 821aa26328..aabb463e4d 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -132,7 +132,7 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
    }
 }
 
-static void invalidate_tlb_entry(CPULoongArchState *env, int index)
+static void invalidate_tlb_entry(CPULoongArchState *env, int index, int vm_level)
 {
     target_ulong addr, mask, pagesize;
     uint8_t tlb_ps;
@@ -147,20 +147,20 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
     addr = (tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & ~mask;
     addr = sextract64(addr, 0, TARGET_VIRT_ADDR_SPACE_BITS);
 
-    tlb_v = pte_present(env, tlb->tlb_entry0);
+    tlb_v = pte_present(env, tlb->tlb_entry0, vm_level);
     if (tlb_v) {
         tlb_flush_range_by_mmuidx(env_cpu(env), addr, pagesize,
                                   idxmap, TARGET_LONG_BITS);
     }
 
-    tlb_v = pte_present(env, tlb->tlb_entry1);
+    tlb_v = pte_present(env, tlb->tlb_entry1, vm_level);
     if (tlb_v) {
         tlb_flush_range_by_mmuidx(env_cpu(env), addr + pagesize, pagesize,
                                   idxmap, TARGET_LONG_BITS);
     }
 }
 
-static void invalidate_tlb(CPULoongArchState *env, int index)
+static void invalidate_tlb(CPULoongArchState *env, int index, int vm_level)
 {
     LoongArchTLB *tlb;
     uint16_t csr_asid, tlb_asid, tlb_g;
@@ -181,11 +181,12 @@ static void invalidate_tlb(CPULoongArchState *env, int index)
     if (tlb_g == 0 && tlb_asid != csr_asid) {
         return;
     }
-    invalidate_tlb_entry(env, index);
+    invalidate_tlb_entry(env, index, vm_level);
 }
 
 /* Prepare tlb entry information in software PTW mode */
-static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
+static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context,
+                                 int vm_level)
 {
     uint64_t lo0, lo1, csr_vppn;
     uint8_t csr_ps;
@@ -218,7 +219,7 @@ static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
 }
 
 static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
-                           MMUContext *context)
+                           MMUContext *context, int vm_level)
 {
     uint64_t lo0, lo1, csr_vppn;
     uint16_t csr_asid;
@@ -257,9 +258,11 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
  * field in tlb entry contains bit[47:13], so need adjust.
  * virt_vpn = vaddr[47:13]
  */
-static const LoongArchTLB *
-loongarch_tlb_search_cb(CPULoongArchState *env, vaddr vaddr,
-                        int csr_asid, tlb_match func)
+
+static const LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
+                                             vaddr vaddr, int csr_asid,
+                                             tlb_match func, int vm_level,
+                                             uint8_t gid)
 {
     const LoongArchTLB *tlb;
     uint16_t tlb_asid, stlb_idx;
@@ -311,7 +314,7 @@ loongarch_tlb_search_cb(CPULoongArchState *env, vaddr vaddr,
 }
 
 static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
-                                 int *index)
+                                 int *index, int vm_level, uint8_t gid)
 {
     int csr_asid;
     tlb_match func;
@@ -320,7 +323,7 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
 
     func = tlb_match_any;
     csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
-    tlb = loongarch_tlb_search_cb(env, vaddr, csr_asid, func);
+    tlb = loongarch_tlb_search_cb(env, vaddr, csr_asid, func, vm_level, gid);
     if (tlb) {
         *index = tlb - env->tlb;
         return true;
@@ -329,15 +332,17 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
     return false;
 }
 
-void helper_tlbsrch(CPULoongArchState *env)
+void helper_tlbsrch(CPULoongArchState *env, uint32_t vm_level)
 {
     int index, match;
     CPUSysState *sys = env_sys(env);
 
     if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        match = loongarch_tlb_search(env, sys->CSR_TLBREHI, &index);
+        match = loongarch_tlb_search(env, sys->CSR_TLBREHI,
+                                     &index, vm_level, get_tgid(env));
     } else {
-        match = loongarch_tlb_search(env, sys->CSR_TLBEHI, &index);
+        match = loongarch_tlb_search(env, sys->CSR_TLBEHI,
+                                     &index, vm_level, get_tgid(env));
     }
 
     if (match) {
@@ -349,7 +354,7 @@ void helper_tlbsrch(CPULoongArchState *env)
     sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
 }
 
-void helper_tlbrd(CPULoongArchState *env)
+void helper_tlbrd(CPULoongArchState *env, uint32_t vm_level)
 {
     LoongArchTLB *tlb;
     int index;
@@ -382,18 +387,18 @@ void helper_tlbrd(CPULoongArchState *env)
 }
 
 static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
-                             int index)
+                             int index, int vm_level)
 {
     LoongArchTLB *old, new = {};
     bool skip_inv = false, tlb_v0, tlb_v1;
 
     old = env->tlb + index;
-    fill_tlb_entry(env, &new, context);
+    fill_tlb_entry(env, &new, context, vm_level);
     /* Check whether ASID/VPPN is the same */
     if (old->tlb_misc == new.tlb_misc) {
         /* Check whether both even/odd pages is the same or invalid */
-        tlb_v0 = pte_present(env, old->tlb_entry0);
-        tlb_v1 = pte_present(env, old->tlb_entry1);
+        tlb_v0 = pte_present(env, old->tlb_entry0, vm_level);
+        tlb_v1 = pte_present(env, old->tlb_entry1, vm_level);
         if ((!tlb_v0 || new.tlb_entry0 == old->tlb_entry0) &&
             (!tlb_v1 || new.tlb_entry1 == old->tlb_entry1)) {
             skip_inv = true;
@@ -402,29 +407,29 @@ static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
 
     /* flush tlb before updating the entry */
     if (!skip_inv) {
-        invalidate_tlb(env, index);
+        invalidate_tlb(env, index, vm_level);
     }
 
     *old = new;
 }
 
-void helper_tlbwr(CPULoongArchState *env)
+void helper_tlbwr(CPULoongArchState *env, uint32_t vm_level)
 {
     CPUSysState *sys = env_sys(env);
     int index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
     MMUContext context;
 
     if (FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, NE)) {
-        invalidate_tlb(env, index);
+        invalidate_tlb(env, index, vm_level);
         return;
     }
 
-    sptw_prepare_context(env, &context);
-    update_tlb_index(env, &context, index);
+    sptw_prepare_context(env, &context, vm_level);
+    update_tlb_index(env, &context, index, vm_level);
 }
 
 static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
-                                int pagesize)
+                                int pagesize, int vm_level)
 {
     uint64_t address;
     int index, set, i, stlb_idx;
@@ -488,7 +493,7 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
     return index;
 }
 
-void helper_tlbfill(CPULoongArchState *env)
+void helper_tlbfill(CPULoongArchState *env, uint32_t vm_level)
 {
     vaddr entryhi;
     int index, pagesize;
@@ -505,13 +510,13 @@ void helper_tlbfill(CPULoongArchState *env)
         pagesize = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, PS);
     }
 
-    sptw_prepare_context(env, &context);
-    index = get_tlb_random_index(env, entryhi, pagesize);
-    invalidate_tlb(env, index);
-    fill_tlb_entry(env, env->tlb + index, &context);
+    sptw_prepare_context(env, &context, vm_level);
+    index = get_tlb_random_index(env, entryhi, pagesize, vm_level);
+    invalidate_tlb(env, index, vm_level);
+    fill_tlb_entry(env, env->tlb + index, &context, vm_level);
 }
 
-void helper_tlbclr(CPULoongArchState *env)
+void helper_tlbclr(CPULoongArchState *env, uint32_t vm_level)
 {
     LoongArchTLB *tlb;
     int i, index;
@@ -546,7 +551,7 @@ void helper_tlbclr(CPULoongArchState *env)
     tlb_flush(env_cpu(env));
 }
 
-void helper_tlbflush(CPULoongArchState *env)
+void helper_tlbflush(CPULoongArchState *env, uint32_t vm_level)
 {
     int i, index;
     CPUSysState *sys = env_sys(env);
@@ -571,7 +576,8 @@ void helper_tlbflush(CPULoongArchState *env)
     tlb_flush(env_cpu(env));
 }
 
-void helper_invtlb_all(CPULoongArchState *env)
+void helper_invtlb_all(CPULoongArchState *env, target_ulong info, uint32_t op,
+                       uint32_t to_guest)
 {
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         env->tlb[i].tlb_misc = FIELD_DP64(env->tlb[i].tlb_misc,
@@ -580,7 +586,8 @@ void helper_invtlb_all(CPULoongArchState *env)
     tlb_flush(env_cpu(env));
 }
 
-void helper_invtlb_all_g(CPULoongArchState *env, uint32_t g)
+void helper_invtlb_all_g(CPULoongArchState *env, target_ulong info, uint32_t g,
+                         uint32_t to_guest)
 {
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
@@ -593,7 +600,8 @@ void helper_invtlb_all_g(CPULoongArchState *env, uint32_t g)
     tlb_flush(env_cpu(env));
 }
 
-void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info)
+void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info,
+                            uint32_t to_guest)
 {
     uint16_t asid = info & R_CSR_ASID_ASID_MASK;
 
@@ -610,43 +618,45 @@ void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info)
 }
 
 void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
-                             target_ulong addr)
+                             target_ulong addr, uint32_t to_guest)
 {
     int asid = info & 0x3ff;
     const LoongArchTLB *tlb;
     tlb_match func;
 
     func = tlb_match_asid;
-    tlb = loongarch_tlb_search_cb(env, addr, asid, func);
+    tlb = loongarch_tlb_search_cb(env, addr, asid, func, to_guest, 0);
     if (tlb) {
-        invalidate_tlb(env, tlb - env->tlb);
+        invalidate_tlb(env, tlb - env->tlb, to_guest);
     }
 }
 
-void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
-                                  target_ulong info, target_ulong addr)
+void helper_invtlb_page_asid_or_g(CPULoongArchState *env, target_ulong info,
+                                  target_ulong addr, uint32_t to_guest)
 {
     int asid = info & 0x3ff;
     const LoongArchTLB *tlb;
     tlb_match func;
 
     func = tlb_match_any;
-    tlb = loongarch_tlb_search_cb(env, addr, asid, func);
+    tlb = loongarch_tlb_search_cb(env, addr, asid, func,
+                                  to_guest, 0);
     if (tlb) {
-        invalidate_tlb(env, tlb - env->tlb);
+        invalidate_tlb(env, tlb - env->tlb, to_guest);
     }
 }
 
-static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context)
+static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context,
+                           int vm_level)
 {
     int index;
 
     index = context->tlb_index;
     if (index < 0) {
-        index = get_tlb_random_index(env, context->addr, context->ps);
+        index = get_tlb_random_index(env, context->addr, context->ps, vm_level);
     }
 
-    update_tlb_index(env, context, index);
+    update_tlb_index(env, context, index, vm_level);
 }
 
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
@@ -655,6 +665,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 {
     CPULoongArchState *env = cpu_env(cs);
     hwaddr physical;
+    int vm_level = env_vm_level(env);
     int prot;
     MMUContext context;
     TLBRet ret;
@@ -662,9 +673,9 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     /* Data access */
     context.addr = address;
     context.tlb_index = -1;
-    ret = get_physical_address(env, &context, access_type, mmu_idx, 0);
+    ret = get_physical_address(env, &context, access_type, mmu_idx, 0, retaddr);
     if (ret == TLBRET_MATCH && context.mmu_index != MMU_DA_IDX
-        && cpu_has_ptw(env)) {
+        && cpu_has_ptw(env, vm_level)) {
         bool need_update = true;
 
         if (access_type == MMU_DATA_STORE && pte_dirty(context.pte)) {
@@ -688,15 +699,15 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         }
     }
 
-    if (ret != TLBRET_MATCH && cpu_has_ptw(env)) {
+    if (ret != TLBRET_MATCH && cpu_has_ptw(env, vm_level)) {
         /* Take HW PTW if TLB missed or bit P is zero */
         if (ret == TLBRET_NOMATCH || ret == TLBRET_INVALID) {
-            ret = loongarch_ptw(env, &context, access_type, mmu_idx, 0);
+            ret = loongarch_ptw(env, &context, access_type, mmu_idx, 0, vm_level, retaddr);
             if (ret == TLBRET_MATCH) {
-                ptw_update_tlb(env, &context);
+                ptw_update_tlb(env, &context, vm_level);
             }
         } else if (context.tlb_index >= 0) {
-            invalidate_tlb(env, context.tlb_index);
+            invalidate_tlb(env, context.tlb_index, vm_level);
         }
     }
 
@@ -770,7 +781,8 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
 
     badvaddr = sys->CSR_TLBRBADV;
     base = base & palen_mask;
-    get_dir_base_width(env, &dir_base, &dir_width, level);
+    get_dir_base_width(env, &dir_base, &dir_width, level,
+                       env_vm_level(env));
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
     val = address_space_ldq_le(cs->as, phys, MEMTXATTRS_UNSPECIFIED, NULL);
@@ -808,7 +820,8 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
          * Move HGLOBAL bit to GLOBAL bit.
          */
         get_dir_base_width(env, &dir_base, &dir_width,
-                           FIELD_EX64(base, TLBENTRY, LEVEL));
+                           FIELD_EX64(base, TLBENTRY, LEVEL),
+                           env_vm_level(env));
 
         base = FIELD_DP64(base, TLBENTRY, LEVEL, 0);
         base = FIELD_DP64(base, TLBENTRY, HUGE, 0);
@@ -859,7 +872,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
 static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
                                       MMUContext *context,
                                       MMUAccessType access_type, int index,
-                                      int mmu_idx)
+                                      int mmu_idx, int vm_level)
 {
     const LoongArchTLB *tlb = &env->tlb[index];
     uint8_t tlb_ps, n;
@@ -869,19 +882,21 @@ static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
     context->pte = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
     context->ps = tlb_ps;
     context->tlb_index = index;
-    return loongarch_check_pte(env, context, access_type, mmu_idx);
+    return loongarch_check_pte(env, context, access_type, mmu_idx, vm_level);
 }
 
 TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
                                    MMUContext *context,
-                                   MMUAccessType access_type, int mmu_idx)
+                                   MMUAccessType access_type, int mmu_idx,
+                                   int vm_level)
 {
     int index, match;
 
-    match = loongarch_tlb_search(env, context->addr, &index);
+    match = loongarch_tlb_search(env, context->addr, &index,
+                                 vm_level, get_tgid(env));
     if (match) {
         return loongarch_map_tlb_entry(env, context, access_type, index,
-                                       mmu_idx);
+                                       mmu_idx, vm_level);
     }
 
     return TLBRET_NOMATCH;
-- 
2.55.0


