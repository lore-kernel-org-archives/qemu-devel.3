Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8BD606A886
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvd-0002y3-1r; Fri, 13 Nov 2026 03:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvZ-0002w9-Ky
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:33 -0500
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvW-0007QN-9b
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:33 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 91A73850;
 Fri, 13 Nov 2026 14:16:28 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 13/26] target/loongarch: add LVZ parameters to TLB functions
Date: Fri, 13 Nov 2026 16:45:28 +0800
Message-ID: <d42073fd45990da4ee84f765eda60c97588d5ba0.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add parameters related to LVZ (mainly vm_level) to statements and definitions
of TLB, so that LVZ patches to TLB can be divided into parts later.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu-mmu.h                    |  21 ++--
 target/loongarch/cpu_helper.c                 |  33 ++---
 target/loongarch/tcg/helper.h                 |  10 +-
 .../tcg/insn_trans/trans_privileged.c.inc     |  30 +++--
 target/loongarch/tcg/tlb_helper.c             | 117 ++++++++++--------
 5 files changed, 120 insertions(+), 91 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 17fb92a213..20fe1cd836 100644
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
@@ -102,11 +104,14 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
                            MMUAccessType access_type, int mmu_idx);
 TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
-                            int is_debug);
+                            int is_debug, uintptr_t retaddr);
 TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
-                     int access_type, int mmu_idx, int debug);
+                     int access_type, int mmu_idx, int debug, uintptr_t retaddr);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-                        uint64_t *dir_width, unsigned int level);
+                        uint64_t *dir_width, unsigned int level, int vm_level);
+TLBRet loongarch_map_address(CPULoongArchState *env, MMUContext *context,
+                             MMUAccessType access_type, int mmu_idx,
+                             int is_debug, uintptr_t retaddr);
 bool loongarch_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
                                        TranslateForDebugResult *result);
 uint64_t loongarch_palen_mask(CPULoongArchState *env);
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 6b98fff691..0e7390cd88 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -20,7 +20,7 @@
 #include "tcg/tcg_loongarch.h"
 
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-                        uint64_t *dir_width, unsigned int level)
+                        uint64_t *dir_width, unsigned int level, int vm_level)
 {
     CPUSysState *sys = env_sys(env);
 
@@ -56,11 +56,12 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
     uint64_t tlb_entry, tlb_ppn;
     uint8_t tlb_ps, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
     bool tlb_v, tlb_d;
+    int vm_level = mmu_idx_vm_level(mmu_idx);
 
     tlb_entry = context->pte;
     tlb_ps = context->ps;
-    tlb_v = pte_present(env, tlb_entry);
-    tlb_d = pte_write(env, tlb_entry);
+    tlb_v = pte_present(env, tlb_entry, vm_level);
+    tlb_d = pte_write(env, tlb_entry, vm_level);
     tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
     if (is_la64(env)) {
         tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
@@ -116,12 +117,13 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
 }
 
 TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
-                     int access_type, int mmu_idx, int debug)
+                     int access_type, int mmu_idx, int debug, uintptr_t retaddr)
 {
     hwaddr index = 0, phys = 0;
     uint64_t palen_mask = loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
     uint64_t base, pte, old;
+    int vm_level = mmu_idx_vm_level(mmu_idx);
     int level, ptw_idx = MMU_DA_IDX;
     vaddr address;
     TLBRet ret;
@@ -137,7 +139,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
     base &= palen_mask;
 
     for (level = 4; level >= 0; level--) {
-        get_dir_base_width(env, &dir_base, &dir_width, level);
+        get_dir_base_width(env, &dir_base, &dir_width, level, vm_level);
 
         if (dir_width == 0) {
             continue;
@@ -175,7 +177,7 @@ restart:
         context->pte_buddy[index] = base;
         context->pte_buddy[1 - index] = base + BIT_ULL(dir_base);
         base += (BIT_ULL(dir_base) & address);
-    } else if (cpu_has_ptw(env)) {
+    } else if (cpu_has_ptw(env, vm_level)) {
         uint64_t val;
 
         index &= 1;
@@ -198,7 +200,7 @@ restart:
      * Need atomic compchxg operation with pte update, other vCPUs may
      * update pte at the same time.
      */
-    if (ret == TLBRET_MATCH && cpu_has_ptw(env)) {
+    if (ret == TLBRET_MATCH && cpu_has_ptw(env, vm_level)) {
         if (access_type == MMU_DATA_STORE && pte_dirty(base)) {
             return ret;
         }
@@ -242,10 +244,9 @@ restart:
     return ret;
 }
 
-static TLBRet loongarch_map_address(CPULoongArchState *env,
-                                    MMUContext *context,
-                                    MMUAccessType access_type, int mmu_idx,
-                                    int is_debug)
+TLBRet loongarch_map_address(CPULoongArchState *env, MMUContext *context,
+                             MMUAccessType access_type, int mmu_idx,
+                             int is_debug, uintptr_t retaddr)
 {
     TLBRet ret;
 
@@ -262,7 +263,8 @@ static TLBRet loongarch_map_address(CPULoongArchState *env,
          * legal mapping, even if the mapping is not yet in TLB. return 0 if
          * there is a valid map, else none zero.
          */
-        return loongarch_ptw(env, context, access_type, mmu_idx, is_debug);
+        return loongarch_ptw(env, context, access_type, mmu_idx, is_debug,
+                             retaddr);
     }
 
     return TLBRET_NOMATCH;
@@ -281,7 +283,7 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, uint64_t dmw)
 
 TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
-                            int is_debug)
+                            int is_debug, uintptr_t retaddr)
 {
     int user_mode = mmu_idx == MMU_USER_IDX;
     int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
@@ -327,7 +329,8 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
     }
 
     /* Mapped address */
-    return loongarch_map_address(env, context, access_type, mmu_idx, is_debug);
+    return loongarch_map_address(env, context, access_type, mmu_idx, is_debug,
+                                 retaddr);
 }
 
 bool loongarch_cpu_translate_for_debug(CPUState *cs, vaddr addr,
@@ -338,7 +341,7 @@ bool loongarch_cpu_translate_for_debug(CPUState *cs, vaddr addr,
 
     context.addr = addr;
     if (get_physical_address(env, &context, MMU_DATA_LOAD,
-                             cpu_mmu_index(cs, false), 1) != TLBRET_MATCH) {
+                             cpu_mmu_index(cs, false), 1, 0) != TLBRET_MATCH) {
         return false;
     }
     *result = (TranslateForDebugResult) {
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 7ee655b027..4643ec14d5 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -122,11 +122,11 @@ DEF_HELPER_1(tlbsrch, void, env)
 DEF_HELPER_1(tlbrd, void, env)
 DEF_HELPER_1(tlbclr, void, env)
 DEF_HELPER_1(tlbflush, void, env)
-DEF_HELPER_1(invtlb_all, void, env)
-DEF_HELPER_2(invtlb_all_g, void, env, i32)
-DEF_HELPER_2(invtlb_all_asid, void, env, tl)
-DEF_HELPER_3(invtlb_page_asid, void, env, tl, tl)
-DEF_HELPER_3(invtlb_page_asid_or_g, void, env, tl, tl)
+DEF_HELPER_4(invtlb_all, void, env, tl, i32, i32)
+DEF_HELPER_4(invtlb_all_g, void, env, tl, i32, i32)
+DEF_HELPER_3(invtlb_all_asid, void, env, tl, i32)
+DEF_HELPER_4(invtlb_page_asid, void, env, tl, tl, i32)
+DEF_HELPER_4(invtlb_page_asid_or_g, void, env, tl, tl, i32)
 
 DEF_HELPER_4(lddir, tl, env, tl, i32, i32)
 DEF_HELPER_4(ldpte, void, env, tl, tl, i32)
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 7ee3bb8e27..db637249f1 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -323,24 +323,28 @@ static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
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
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 178f55a67e..8ce3528871 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -131,7 +131,7 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
    }
 }
 
-static void invalidate_tlb_entry(CPULoongArchState *env, int index)
+static void invalidate_tlb_entry(CPULoongArchState *env, int index, int vm_level)
 {
     target_ulong addr, mask, pagesize;
     uint8_t tlb_ps;
@@ -146,20 +146,20 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
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
@@ -180,11 +180,12 @@ static void invalidate_tlb(CPULoongArchState *env, int index)
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
@@ -217,7 +218,7 @@ static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
 }
 
 static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
-                           MMUContext *context)
+                           MMUContext *context, int vm_level)
 {
     uint64_t lo0, lo1, csr_vppn;
     uint16_t csr_asid;
@@ -256,9 +257,11 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
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
@@ -310,7 +313,7 @@ loongarch_tlb_search_cb(CPULoongArchState *env, vaddr vaddr,
 }
 
 static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
-                                 int *index)
+                                 int *index, int vm_level, uint8_t gid)
 {
     int csr_asid;
     tlb_match func;
@@ -319,7 +322,7 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
 
     func = tlb_match_any;
     csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
-    tlb = loongarch_tlb_search_cb(env, vaddr, csr_asid, func);
+    tlb = loongarch_tlb_search_cb(env, vaddr, csr_asid, func, vm_level, gid);
     if (tlb) {
         *index = tlb - env->tlb;
         return true;
@@ -332,11 +335,14 @@ void HELPER(tlbsrch)(CPULoongArchState *env)
 {
     int index, match;
     CPUSysState *sys = env_sys(env);
+    int vm_level = env_vm_level(env);
 
     if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        match = loongarch_tlb_search(env, sys->CSR_TLBREHI, &index);
+        match = loongarch_tlb_search(env, sys->CSR_TLBREHI,
+                                     &index, vm_level, get_gid(env, vm_level));
     } else {
-        match = loongarch_tlb_search(env, sys->CSR_TLBEHI, &index);
+        match = loongarch_tlb_search(env, sys->CSR_TLBEHI,
+                                     &index, vm_level, get_gid(env, vm_level));
     }
 
     if (match) {
@@ -381,18 +387,18 @@ void HELPER(tlbrd)(CPULoongArchState *env)
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
@@ -401,7 +407,7 @@ static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
 
     /* flush tlb before updating the entry */
     if (!skip_inv) {
-        invalidate_tlb(env, index);
+        invalidate_tlb(env, index, vm_level);
     }
 
     *old = new;
@@ -412,18 +418,19 @@ void HELPER(tlbwr)(CPULoongArchState *env)
     CPUSysState *sys = env_sys(env);
     int index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
     MMUContext context;
+    int vm_level = env_vm_level(env);
 
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
@@ -493,6 +500,7 @@ void HELPER(tlbfill)(CPULoongArchState *env)
     int index, pagesize;
     MMUContext context;
     CPUSysState *sys = env_sys(env);
+    int vm_level = env_vm_level(env);
 
     if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         entryhi = sys->CSR_TLBREHI;
@@ -504,10 +512,10 @@ void HELPER(tlbfill)(CPULoongArchState *env)
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
 
 void HELPER(tlbclr)(CPULoongArchState *env)
@@ -570,7 +578,8 @@ void HELPER(tlbflush)(CPULoongArchState *env)
     tlb_flush(env_cpu(env));
 }
 
-void HELPER(invtlb_all)(CPULoongArchState *env)
+void HELPER(invtlb_all)(CPULoongArchState *env, target_ulong info, uint32_t op,
+                       uint32_t vm_level)
 {
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         env->tlb[i].tlb_misc = FIELD_DP64(env->tlb[i].tlb_misc,
@@ -579,7 +588,8 @@ void HELPER(invtlb_all)(CPULoongArchState *env)
     tlb_flush(env_cpu(env));
 }
 
-void HELPER(invtlb_all_g)(CPULoongArchState *env, uint32_t g)
+void HELPER(invtlb_all_g)(CPULoongArchState *env, target_ulong info, uint32_t g,
+                         uint32_t vm_level)
 {
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
@@ -592,7 +602,8 @@ void HELPER(invtlb_all_g)(CPULoongArchState *env, uint32_t g)
     tlb_flush(env_cpu(env));
 }
 
-void HELPER(invtlb_all_asid)(CPULoongArchState *env, target_ulong info)
+void HELPER(invtlb_all_asid)(CPULoongArchState *env, target_ulong info,
+                            uint32_t vm_level)
 {
     uint16_t asid = info & R_CSR_ASID_ASID_MASK;
 
@@ -609,43 +620,45 @@ void HELPER(invtlb_all_asid)(CPULoongArchState *env, target_ulong info)
 }
 
 void HELPER(invtlb_page_asid)(CPULoongArchState *env, target_ulong info,
-                             target_ulong addr)
+                             target_ulong addr, uint32_t vm_level)
 {
     int asid = info & 0x3ff;
     const LoongArchTLB *tlb;
     tlb_match func;
 
     func = tlb_match_asid;
-    tlb = loongarch_tlb_search_cb(env, addr, asid, func);
+    tlb = loongarch_tlb_search_cb(env, addr, asid, func, env_vm_level(env), 0);
     if (tlb) {
-        invalidate_tlb(env, tlb - env->tlb);
+        invalidate_tlb(env, tlb - env->tlb, env_vm_level(env));
     }
 }
 
-void HELPER(invtlb_page_asid_or_g)(CPULoongArchState *env,
-                                  target_ulong info, target_ulong addr)
+void HELPER(invtlb_page_asid_or_g)(CPULoongArchState *env, target_ulong info,
+                                  target_ulong addr, uint32_t vm_level)
 {
     int asid = info & 0x3ff;
     const LoongArchTLB *tlb;
     tlb_match func;
 
     func = tlb_match_any;
-    tlb = loongarch_tlb_search_cb(env, addr, asid, func);
+    tlb = loongarch_tlb_search_cb(env, addr, asid, func,
+                                  env_vm_level(env), 0);
     if (tlb) {
-        invalidate_tlb(env, tlb - env->tlb);
+        invalidate_tlb(env, tlb - env->tlb, env_vm_level(env));
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
@@ -661,9 +674,9 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     /* Data access */
     context.addr = address;
     context.tlb_index = -1;
-    ret = get_physical_address(env, &context, access_type, mmu_idx, 0);
+    ret = get_physical_address(env, &context, access_type, mmu_idx, 0, retaddr);
     if (ret == TLBRET_MATCH && context.mmu_index != MMU_DA_IDX
-        && cpu_has_ptw(env)) {
+        && cpu_has_ptw(env, env_vm_level(env))) {
         bool need_update = true;
 
         if (access_type == MMU_DATA_STORE && pte_dirty(context.pte)) {
@@ -678,15 +691,15 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         }
     }
 
-    if (ret != TLBRET_MATCH && cpu_has_ptw(env)) {
+    if (ret != TLBRET_MATCH && cpu_has_ptw(env, env_vm_level(env))) {
         /* Take HW PTW if TLB missed or bit P is zero */
         if (ret == TLBRET_NOMATCH || ret == TLBRET_INVALID) {
-            ret = loongarch_ptw(env, &context, access_type, mmu_idx, 0);
+            ret = loongarch_ptw(env, &context, access_type, mmu_idx, 0, retaddr);
             if (ret == TLBRET_MATCH) {
-                ptw_update_tlb(env, &context);
+                ptw_update_tlb(env, &context, env_vm_level(env));
             }
         } else if (context.tlb_index >= 0) {
-            invalidate_tlb(env, context.tlb_index);
+            invalidate_tlb(env, context.tlb_index, env_vm_level(env));
         }
     }
 
@@ -701,7 +714,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
          * Store walks have already handled D, but context.pte may still
          * contain its old value. Direct mappings have no PTE to check.
          */
-        if (cpu_has_ptw(env) && context.mmu_index != MMU_DA_IDX &&
+        if (cpu_has_ptw(env, env_vm_level(env)) && context.mmu_index != MMU_DA_IDX &&
             access_type != MMU_DATA_STORE && !pte_dirty(context.pte)) {
             prot &= ~PAGE_WRITE;
         }
@@ -788,7 +801,8 @@ target_ulong HELPER(lddir)(CPULoongArchState *env, target_ulong base,
 
     badvaddr = sys->CSR_TLBRBADV;
     base = base & palen_mask;
-    get_dir_base_width(env, &dir_base, &dir_width, level);
+    get_dir_base_width(env, &dir_base, &dir_width, level,
+                       env_vm_level(env));
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
     val = cpu_ldq_le_data_ra(env, phys, GETPC());
@@ -825,7 +839,8 @@ void HELPER(ldpte)(CPULoongArchState *env, target_ulong base, target_ulong odd,
          * Move HGLOBAL bit to GLOBAL bit.
          */
         get_dir_base_width(env, &dir_base, &dir_width,
-                           FIELD_EX64(base, TLBENTRY, LEVEL));
+                           FIELD_EX64(base, TLBENTRY, LEVEL),
+                           env_vm_level(env));
 
         base = FIELD_DP64(base, TLBENTRY, LEVEL, 0);
         base = FIELD_DP64(base, TLBENTRY, HUGE, 0);
@@ -893,8 +908,10 @@ TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
                                    MMUAccessType access_type, int mmu_idx)
 {
     int index, match;
+    int vm_level = env_vm_level(env);
 
-    match = loongarch_tlb_search(env, context->addr, &index);
+    match = loongarch_tlb_search(env, context->addr, &index,
+                                 vm_level, get_gid(env, vm_level));
     if (match) {
         return loongarch_map_tlb_entry(env, context, access_type, index,
                                        mmu_idx);
-- 
2.56.0


