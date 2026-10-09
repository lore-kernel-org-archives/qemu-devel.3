Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C03CA5FED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0xI-0006YU-Ia; Thu, 08 Oct 2026 23:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vi-0004fD-Nm
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:05 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vf-0005np-1y
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:53 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id 3E79CDFE8;
 Fri, 09 Oct 2026 08:35:48 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 14/23] target/loongarch: add LVZ to TLB functions
Date: Fri,  9 Oct 2026 11:05:10 +0800
Message-ID: <0a5d9f323283586d3ca7bb34763ad761a62e52c9.1791514848.git.prcups@krgm.moe>
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

Add LVZ to most TLB handler, except invtlb and ptw.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu-mmu.h        |   2 +
 target/loongarch/cpu.h            |   1 +
 target/loongarch/cpu_helper.c     |  10 +--
 target/loongarch/tcg/tlb_helper.c | 132 ++++++++++++++++++++++++------
 4 files changed, 115 insertions(+), 30 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 4d76d96ee5..29b0c109fb 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -110,6 +110,8 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
                      uintptr_t retaddr);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                         uint64_t *dir_width, unsigned int level, int vm_level);
+hwaddr loongarch_get_host_address(CPULoongArchState *env, hwaddr gpa,
+                                  uintptr_t retaddr);
 TLBRet loongarch_map_address(CPULoongArchState *env, MMUContext *context,
                              MMUAccessType access_type, int mmu_idx,
                              int is_debug, int vm_level, uintptr_t retaddr);
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index a42c5fe170..995e8f5a7f 100644
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
index 8eabb4a9dc..23d26385c6 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -21,7 +21,7 @@
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                         uint64_t *dir_width, unsigned int level, int vm_level)
 {
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     switch (level) {
     case 1:
@@ -51,7 +51,7 @@ void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
 TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
                            MMUAccessType access_type, int mmu_idx, int vm_level)
 {
-    uint64_t plv = mmu_idx;
+    uint64_t plv = mmu_idx_to_plv(mmu_idx);
     uint64_t tlb_entry, tlb_ppn;
     uint8_t tlb_ps, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
     bool tlb_v, tlb_d;
@@ -316,12 +316,12 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
                             int is_debug, uintptr_t retaddr)
 {
-    int user_mode = mmu_idx == MMU_USER_IDX;
-    int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
+    int user_mode = mmu_idx_to_plv(mmu_idx) == MMU_USER_IDX;
+    int kernel_mode = mmu_idx_to_plv(mmu_idx) == MMU_KERNEL_IDX;
     int vm_level = env_vm_level(env);
     uint32_t plv, base_c, base_v;
     int64_t addr_high;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
     uint8_t da = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, DA);
     uint8_t pg = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG);
     vaddr address;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index aabb463e4d..60c7193283 100644
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
@@ -40,9 +42,15 @@ static inline bool tlb_entry_matches_gid(const LoongArchTLB *tlb, uint8_t gid)
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
@@ -137,7 +145,9 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index, int vm_level
     target_ulong addr, mask, pagesize;
     uint8_t tlb_ps;
     LoongArchTLB *tlb = &env->tlb[index];
-    int idxmap = BIT(MMU_KERNEL_IDX) | BIT(MMU_USER_IDX);
+    int bit_offset = vm_level ? MMU_GUEST_IDX : 0;
+    int idxmap = (BIT(MMU_KERNEL_IDX + bit_offset)
+                  | BIT(MMU_USER_IDX + bit_offset));
     uint64_t tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
     bool tlb_v;
 
@@ -165,7 +175,7 @@ static void invalidate_tlb(CPULoongArchState *env, int index, int vm_level)
     LoongArchTLB *tlb;
     uint16_t csr_asid, tlb_asid, tlb_g;
     uint8_t tlb_e;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
     tlb = &env->tlb[index];
@@ -190,7 +200,7 @@ static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context,
 {
     uint64_t lo0, lo1, csr_vppn;
     uint8_t csr_ps;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         csr_ps = FIELD_EX64(sys->CSR_TLBREHI, CSR_TLBREHI, PS);
@@ -224,7 +234,7 @@ static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
     uint64_t lo0, lo1, csr_vppn;
     uint16_t csr_asid;
     uint8_t csr_ps;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     csr_vppn = context->addr >> R_TLB_MISC_VPPN_SHIFT;
     csr_ps   = context->ps;
@@ -237,6 +247,8 @@ static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 1);
     csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, ASID, csr_asid);
+    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, GID, get_tgid(env));
+    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, VM_LEVEL, vm_level);
 
     tlb->tlb_entry0 = lo0;
     tlb->tlb_entry1 = lo1;
@@ -270,7 +282,7 @@ static const LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
     bool tlb_g;
     int i, compare_shift;
     uint64_t vpn, tlb_vppn;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     stlb_ps = FIELD_EX64(sys->CSR_STLBPS, CSR_STLBPS, PS);
     vpn = (vaddr & TARGET_VIRT_MASK) >> (stlb_ps + 1);
@@ -287,6 +299,8 @@ static const LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
             tlb_g = !!FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
 
             if (func(tlb_g, csr_asid, tlb_asid) &&
+                tlb_entry_matches_gid(tlb, gid) &&
+                tlb_entry_matches_vm_level(tlb, vm_level) &&
                 (vpn == (tlb_vppn >> compare_shift))) {
                 return tlb;
             }
@@ -305,6 +319,8 @@ static const LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
             compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
             vpn = (vaddr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
             if (func(tlb_g, csr_asid, tlb_asid) &&
+                tlb_entry_matches_gid(tlb, gid) &&
+                tlb_entry_matches_vm_level(tlb, vm_level) &&
                 (vpn == (tlb_vppn >> compare_shift))) {
                 return tlb;
             }
@@ -319,7 +335,7 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
     int csr_asid;
     tlb_match func;
     const LoongArchTLB *tlb;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     func = tlb_match_any;
     csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
@@ -335,7 +351,7 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
 void helper_tlbsrch(CPULoongArchState *env, uint32_t vm_level)
 {
     int index, match;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         match = loongarch_tlb_search(env, sys->CSR_TLBREHI,
@@ -359,7 +375,7 @@ void helper_tlbrd(CPULoongArchState *env, uint32_t vm_level)
     LoongArchTLB *tlb;
     int index;
     uint8_t tlb_ps, tlb_e;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
     tlb = &env->tlb[index];
@@ -415,7 +431,7 @@ static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
 
 void helper_tlbwr(CPULoongArchState *env, uint32_t vm_level)
 {
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
     int index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
     MMUContext context;
 
@@ -436,7 +452,7 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
     uint16_t asid, tlb_asid, stlb_ps;
     LoongArchTLB *tlb;
     uint8_t tlb_e, tlb_g;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     /* Validity of stlb_ps is checked in helper_csrwr_stlbps() */
     stlb_ps = FIELD_EX64(sys->CSR_STLBPS, CSR_STLBPS, PS);
@@ -456,7 +472,8 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
 
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (tlb_g == 0 && asid != tlb_asid) {
+            if (tlb_g == 0 && asid != tlb_asid &&
+                tlb_entry_matches_gid(tlb, get_tgid(env))) {
                 set = i;
             }
         }
@@ -480,7 +497,8 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
 
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (tlb_g == 0 && asid != tlb_asid) {
+            if (tlb_g == 0 && asid != tlb_asid &&
+                tlb_entry_matches_gid(tlb, get_tgid(env))) {
                 index = i;
             }
         }
@@ -498,7 +516,7 @@ void helper_tlbfill(CPULoongArchState *env, uint32_t vm_level)
     vaddr entryhi;
     int index, pagesize;
     MMUContext context;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         entryhi = sys->CSR_TLBREHI;
@@ -521,7 +539,7 @@ void helper_tlbclr(CPULoongArchState *env, uint32_t vm_level)
     LoongArchTLB *tlb;
     int i, index;
     uint16_t csr_asid, tlb_asid, tlb_g;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
     index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
@@ -532,7 +550,8 @@ void helper_tlbclr(CPULoongArchState *env, uint32_t vm_level)
             tlb = &env->tlb[i * 256 + (index % 256)];
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (!tlb_g && tlb_asid == csr_asid) {
+            if (!tlb_g && tlb_asid == csr_asid &&
+                tlb_entry_matches_gid(tlb, get_tgid(env))) {
                 tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
             }
         }
@@ -542,7 +561,8 @@ void helper_tlbclr(CPULoongArchState *env, uint32_t vm_level)
             tlb = &env->tlb[i];
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (!tlb_g && tlb_asid == csr_asid) {
+            if (!tlb_g && tlb_asid == csr_asid &&
+                tlb_entry_matches_gid(tlb, get_tgid(env))) {
                 tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
             }
         }
@@ -554,7 +574,7 @@ void helper_tlbclr(CPULoongArchState *env, uint32_t vm_level)
 void helper_tlbflush(CPULoongArchState *env, uint32_t vm_level)
 {
     int i, index;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
 
@@ -659,15 +679,25 @@ static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context,
     update_tlb_index(env, context, index, vm_level);
 }
 
+static TLBRet loongarch_map_host_address(CPULoongArchState *env, MMUContext *context,
+                                  MMUAccessType access_type, uintptr_t retaddr)
+{
+    TLBRet ret;
+
+    ret = loongarch_map_address(env, context, access_type, MMU_KERNEL_IDX,
+                                false, false, retaddr);
+    return TLBRET_HOST_MATCH + ret;
+}
+
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr)
 {
     CPULoongArchState *env = cpu_env(cs);
-    hwaddr physical;
     int vm_level = env_vm_level(env);
-    int prot;
-    MMUContext context;
+    hwaddr physical;
+    int prot, host_prot;
+    MMUContext context, host_context;
     TLBRet ret;
 
     /* Data access */
@@ -714,12 +744,30 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (ret == TLBRET_MATCH) {
         physical = context.physical;
         prot = context.prot;
+        if (vm_level) {
+            host_context.addr = physical;
+            host_context.tlb_index = -1;
+            ret = loongarch_map_host_address(env, &host_context, access_type,
+                                             retaddr);
+            if (ret != TLBRET_HOST_MATCH) {
+                if (probe) {
+                    return false;
+                }
+                raise_mmu_exception(env, physical, access_type, ret);
+                cpu_loop_exit_restore(cs, retaddr);
+                return false;
+            }
+            physical = host_context.physical;
+            host_prot = host_context.prot;
+            prot &= host_prot;
+        }
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot,
                      mmu_idx, TARGET_PAGE_SIZE);
         qemu_log_mask(CPU_LOG_MMU,
                       "%s address=%" VADDR_PRIx " physical " HWADDR_FMT_plx
-                      " prot %d\n", __func__, address, physical, prot);
+                      " prot %d guest %d\n", __func__, address, physical,
+                      prot, is_guest_mmu_idx(mmu_idx));
         return true;
     } else {
         qemu_log_mask(CPU_LOG_MMU,
@@ -748,6 +796,31 @@ static inline uint64_t loongarch_sanitize_hw_pte(CPULoongArchState *env,
     return (pte & ~ppn_mask) | ((pte & ppn_mask) & palen_mask);
 }
 
+hwaddr loongarch_get_host_address(CPULoongArchState *env, hwaddr gpa,
+                                  uintptr_t retaddr)
+{
+    MMUContext host_context;
+    TLBRet ret;
+    CPUTLBEntryFull *full;
+    int flags = probe_access_full_mmu(env, gpa, 1, MMU_DATA_LOAD,
+                                      MMU_KERNEL_IDX + MMU_GUEST_IDX, NULL, &full);
+    if (!(flags & TLB_INVALID_MASK)) {
+        return (full->phys_addr & TARGET_PAGE_MASK) | (gpa & ~TARGET_PAGE_MASK);
+    }
+
+    host_context.addr = gpa;
+    host_context.tlb_index = -1;
+    ret = loongarch_map_host_address(env, &host_context, MMU_DATA_LOAD,
+                                     retaddr);
+
+    if (ret != TLBRET_HOST_MATCH) {
+        raise_mmu_exception(env, gpa, MMU_DATA_LOAD, ret);
+        cpu_loop_exit_restore(env_cpu(env), retaddr);
+    }
+
+    return host_context.physical;
+}
+
 target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
                           uint32_t level, uint32_t mem_idx)
 {
@@ -785,7 +858,12 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
                        env_vm_level(env));
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
-    val = address_space_ldq_le(cs->as, phys, MEMTXATTRS_UNSPECIFIED, NULL);
+    val = address_space_ldq_le(
+        cs->as,
+        env_vm_level(env) == VM_LEVEL1 ?
+        loongarch_get_host_address(env, phys, GETPC()) :
+                            phys,
+        MEMTXATTRS_UNSPECIFIED, NULL);
 
     return val & palen_mask;
 }
@@ -855,8 +933,12 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
         ptoffset0 = ptindex << 3;
         ptoffset1 = (ptindex + 1) << 3;
         phys = base | (odd ? ptoffset1 : ptoffset0);
-        pte_raw = address_space_ldq_le(cs->as, phys,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
+        pte_raw = address_space_ldq_le(
+            cs->as,
+            env_vm_level(env) == VM_LEVEL1 ?
+            loongarch_get_host_address(env, phys, GETPC()) :
+                                phys,
+            MEMTXATTRS_UNSPECIFIED, NULL);
         tmp0 = loongarch_sanitize_hw_pte(env, pte_raw);
         ps = ptbase;
     }
-- 
2.55.0


