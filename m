Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D475606A32A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvd-0002yQ-Pd; Fri, 13 Nov 2026 03:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvb-0002xR-Hk
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:35 -0500
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvX-0007Qv-Kq
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:35 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 1E6371DD;
 Fri, 13 Nov 2026 14:16:29 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 14/26] target/loongarch: add LVZ to TLB functions
Date: Fri, 13 Nov 2026 16:45:29 +0800
Message-ID: <3eedf194c24ae2bb1c1670899cb25c183d7489db.1794558695.git.prcups@krgm.moe>
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

Add LVZ to most TLB handler, except invtlb and ptw.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.h            |  1 +
 target/loongarch/cpu_helper.c     | 13 ++++----
 target/loongarch/tcg/tlb_helper.c | 50 ++++++++++++++++++++++---------
 3 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 9987d47734..f27c4ada07 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -262,6 +262,7 @@ FIELD(TLB_MISC, ASID, 1, 10)
 FIELD(TLB_MISC, VPPN, 13, 35)
 FIELD(TLB_MISC, PS, 48, 6)
 FIELD(TLB_MISC, GID, 54, 8)
+FIELD(TLB_MISC, VM_LEVEL, 62, 1)
 
 /*Msg interrupt registers */
 #define N_MSGIS                4
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 0e7390cd88..245bb24b35 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -22,7 +22,7 @@
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                         uint64_t *dir_width, unsigned int level, int vm_level)
 {
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     switch (level) {
     case 1:
@@ -52,7 +52,7 @@ void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
 TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
                            MMUAccessType access_type, int mmu_idx)
 {
-    uint64_t plv = mmu_idx;
+    uint64_t plv = mmu_idx_to_plv(mmu_idx);
     uint64_t tlb_entry, tlb_ppn;
     uint8_t tlb_ps, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
     bool tlb_v, tlb_d;
@@ -285,16 +285,17 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
                             int is_debug, uintptr_t retaddr)
 {
-    int user_mode = mmu_idx == MMU_USER_IDX;
-    int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
+    int user_mode = mmu_idx_to_plv(mmu_idx) == MMU_USER_IDX;
+    int kernel_mode = mmu_idx_to_plv(mmu_idx) == MMU_KERNEL_IDX;
+    int vm_level = mmu_idx_vm_level(mmu_idx);
     uint32_t plv, base_c, base_v;
     int64_t addr_high;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
     vaddr address;
 
     /* Check PG and DA */
     address = context->addr;
-    if (mmu_idx == MMU_DA_IDX) {
+    if (mmu_idx == MMU_DA_IDX || mmu_idx == MMU_GUEST_DA_IDX) {
         context->physical = address & loongarch_palen_mask(env);
         context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         context->mmu_index = MMU_DA_IDX;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 8ce3528871..0c93d0fcb4 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -18,6 +18,8 @@
 #include "exec/target_page.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-loop.h"
+#include "accel/tcg/probe.h"
+#include "exec/tlb-flags.h"
 #include "exec/log.h"
 #include "cpu-csr.h"
 #include "tcg/tcg_loongarch.h"
@@ -39,9 +41,15 @@ static inline bool tlb_entry_matches_gid(const LoongArchTLB *tlb, uint8_t gid)
     return FIELD_EX64(tlb->tlb_misc, TLB_MISC, GID) == gid;
 }
 
+static inline bool tlb_entry_matches_vm_level(const LoongArchTLB *tlb,
+                                              uint8_t vm_level)
+{
+    return FIELD_EX64(tlb->tlb_misc, TLB_MISC, VM_LEVEL) == vm_level;
+}
+
 bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
 {
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, VM_LEVEL0);
 
     if (tlb_ps >= 64) {
         return false;
@@ -136,7 +144,9 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index, int vm_level
     target_ulong addr, mask, pagesize;
     uint8_t tlb_ps;
     LoongArchTLB *tlb = &env->tlb[index];
-    int idxmap = BIT(MMU_KERNEL_IDX) | BIT(MMU_USER_IDX);
+    int bit_offset = vm_level ? MMU_GUEST_IDX : 0;
+    int idxmap = (BIT(MMU_KERNEL_IDX + bit_offset)
+                  | BIT(MMU_USER_IDX + bit_offset));
     uint64_t tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
     bool tlb_v;
 
@@ -164,7 +174,7 @@ static void invalidate_tlb(CPULoongArchState *env, int index, int vm_level)
     LoongArchTLB *tlb;
     uint16_t csr_asid, tlb_asid, tlb_g;
     uint8_t tlb_e;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
     tlb = &env->tlb[index];
@@ -189,7 +199,7 @@ static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context,
 {
     uint64_t lo0, lo1, csr_vppn;
     uint8_t csr_ps;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         csr_ps = FIELD_EX64(sys->CSR_TLBREHI, CSR_TLBREHI, PS);
@@ -223,7 +233,7 @@ static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
     uint64_t lo0, lo1, csr_vppn;
     uint16_t csr_asid;
     uint8_t csr_ps;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     csr_vppn = context->addr >> R_TLB_MISC_VPPN_SHIFT;
     csr_ps   = context->ps;
@@ -236,6 +246,8 @@ static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 1);
     csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, ASID, csr_asid);
+    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, GID, get_gid(env, vm_level));
+    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, VM_LEVEL, vm_level);
 
     tlb->tlb_entry0 = lo0;
     tlb->tlb_entry1 = lo1;
@@ -269,7 +281,7 @@ static const LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
     bool tlb_g;
     int i, compare_shift;
     uint64_t vpn, tlb_vppn;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     stlb_ps = FIELD_EX64(sys->CSR_STLBPS, CSR_STLBPS, PS);
     vpn = (vaddr & TARGET_VIRT_MASK) >> (stlb_ps + 1);
@@ -286,6 +298,8 @@ static const LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
             tlb_g = !!FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
 
             if (func(tlb_g, csr_asid, tlb_asid) &&
+                tlb_entry_matches_gid(tlb, gid) &&
+                tlb_entry_matches_vm_level(tlb, vm_level) &&
                 (vpn == (tlb_vppn >> compare_shift))) {
                 return tlb;
             }
@@ -304,6 +318,8 @@ static const LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
             compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
             vpn = (vaddr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
             if (func(tlb_g, csr_asid, tlb_asid) &&
+                tlb_entry_matches_gid(tlb, gid) &&
+                tlb_entry_matches_vm_level(tlb, vm_level) &&
                 (vpn == (tlb_vppn >> compare_shift))) {
                 return tlb;
             }
@@ -318,7 +334,7 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
     int csr_asid;
     tlb_match func;
     const LoongArchTLB *tlb;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     func = tlb_match_any;
     csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
@@ -437,7 +453,7 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
     uint16_t asid, tlb_asid, stlb_ps;
     LoongArchTLB *tlb;
     uint8_t tlb_e, tlb_g;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     /* Validity of stlb_ps is checked in helper_csrwr_stlbps() */
     stlb_ps = FIELD_EX64(sys->CSR_STLBPS, CSR_STLBPS, PS);
@@ -457,7 +473,8 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
 
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (tlb_g == 0 && asid != tlb_asid) {
+            if (tlb_g == 0 && asid != tlb_asid &&
+                tlb_entry_matches_gid(tlb, get_gid(env, vm_level))) {
                 set = i;
             }
         }
@@ -481,7 +498,8 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
 
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (tlb_g == 0 && asid != tlb_asid) {
+            if (tlb_g == 0 && asid != tlb_asid &&
+                tlb_entry_matches_gid(tlb, get_gid(env, vm_level))) {
                 index = i;
             }
         }
@@ -524,6 +542,7 @@ void HELPER(tlbclr)(CPULoongArchState *env)
     int i, index;
     uint16_t csr_asid, tlb_asid, tlb_g;
     CPUSysState *sys = env_sys(env);
+    int vm_level = env_vm_level(env);
 
     csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
     index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
@@ -534,7 +553,8 @@ void HELPER(tlbclr)(CPULoongArchState *env)
             tlb = &env->tlb[i * 256 + (index % 256)];
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (!tlb_g && tlb_asid == csr_asid) {
+            if (!tlb_g && tlb_asid == csr_asid &&
+                tlb_entry_matches_gid(tlb, get_gid(env, vm_level))) {
                 tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
             }
         }
@@ -544,7 +564,8 @@ void HELPER(tlbclr)(CPULoongArchState *env)
             tlb = &env->tlb[i];
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (!tlb_g && tlb_asid == csr_asid) {
+            if (!tlb_g && tlb_asid == csr_asid &&
+                tlb_entry_matches_gid(tlb, get_gid(env, vm_level))) {
                 tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
             }
         }
@@ -724,7 +745,8 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                      mmu_idx, TARGET_PAGE_SIZE);
         qemu_log_mask(CPU_LOG_MMU,
                       "%s address=%" VADDR_PRIx " physical " HWADDR_FMT_plx
-                      " prot %d\n", __func__, address, physical, prot);
+                      " prot %d guest %d\n", __func__, address, physical,
+                      prot, mmu_idx_vm_level(mmu_idx));
         return true;
     } else {
         qemu_log_mask(CPU_LOG_MMU,
@@ -908,7 +930,7 @@ TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
                                    MMUAccessType access_type, int mmu_idx)
 {
     int index, match;
-    int vm_level = env_vm_level(env);
+    int vm_level = mmu_idx_vm_level(mmu_idx);
 
     match = loongarch_tlb_search(env, context->addr, &index,
                                  vm_level, get_gid(env, vm_level));
-- 
2.56.0


