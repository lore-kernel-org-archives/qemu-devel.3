Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3954BC3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 01:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u48ae-0004M7-1r; Sun, 13 Apr 2025 21:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u48aE-00045I-Qe
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 21:26:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u48a9-00036Q-RP
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 21:25:57 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx63EOZPxnoHO8AA--.50064S3;
 Mon, 14 Apr 2025 09:25:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxzxsJZPxnTz6AAA--.562S7;
 Mon, 14 Apr 2025 09:25:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 5/5] target/loongarch: Move function loongarch_tlb_search to
 directory tcg
Date: Mon, 14 Apr 2025 09:25:28 +0800
Message-Id: <20250414012528.4075447-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250414012528.4075447-1-maobibo@loongson.cn>
References: <20250414012528.4075447-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzxsJZPxnTz6AAA--.562S7
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Function loongarch_tlb_search() and loongarch_map_tlb_entry() works
only in TCG mode, move these functions to directory tcg.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu_helper.c     | 153 ------------------------------
 target/loongarch/internals.h      |  14 ++-
 target/loongarch/tcg/tlb_helper.c | 144 ++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 155 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 7a56482282..6fbea6424e 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -11,159 +11,6 @@
 #include "internals.h"
 #include "cpu-csr.h"
 
-#ifdef CONFIG_TCG
-static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
-                                   int *prot, target_ulong address,
-                                   int access_type, int index, int mmu_idx)
-{
-    LoongArchTLB *tlb = &env->tlb[index];
-    uint64_t plv = mmu_idx;
-    uint64_t tlb_entry, tlb_ppn;
-    uint8_t tlb_ps, n, tlb_v, tlb_d, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
-
-    if (index >= LOONGARCH_STLB) {
-        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
-    } else {
-        tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
-    }
-    n = (address >> tlb_ps) & 0x1;/* Odd or even */
-
-    tlb_entry = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
-    tlb_v = FIELD_EX64(tlb_entry, TLBENTRY, V);
-    tlb_d = FIELD_EX64(tlb_entry, TLBENTRY, D);
-    tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
-    if (is_la64(env)) {
-        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
-        tlb_nx = FIELD_EX64(tlb_entry, TLBENTRY_64, NX);
-        tlb_nr = FIELD_EX64(tlb_entry, TLBENTRY_64, NR);
-        tlb_rplv = FIELD_EX64(tlb_entry, TLBENTRY_64, RPLV);
-    } else {
-        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_32, PPN);
-        tlb_nx = 0;
-        tlb_nr = 0;
-        tlb_rplv = 0;
-    }
-
-    /* Remove sw bit between bit12 -- bit PS*/
-    tlb_ppn = tlb_ppn & ~(((0x1UL << (tlb_ps - 12)) -1));
-
-    /* Check access rights */
-    if (!tlb_v) {
-        return TLBRET_INVALID;
-    }
-
-    if (access_type == MMU_INST_FETCH && tlb_nx) {
-        return TLBRET_XI;
-    }
-
-    if (access_type == MMU_DATA_LOAD && tlb_nr) {
-        return TLBRET_RI;
-    }
-
-    if (((tlb_rplv == 0) && (plv > tlb_plv)) ||
-        ((tlb_rplv == 1) && (plv != tlb_plv))) {
-        return TLBRET_PE;
-    }
-
-    if ((access_type == MMU_DATA_STORE) && !tlb_d) {
-        return TLBRET_DIRTY;
-    }
-
-    *physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
-                (address & MAKE_64BIT_MASK(0, tlb_ps));
-    *prot = PAGE_READ;
-    if (tlb_d) {
-        *prot |= PAGE_WRITE;
-    }
-    if (!tlb_nx) {
-        *prot |= PAGE_EXEC;
-    }
-    return TLBRET_MATCH;
-}
-
-/*
- * One tlb entry holds an adjacent odd/even pair, the vpn is the
- * content of the virtual page number divided by 2. So the
- * compare vpn is bit[47:15] for 16KiB page. while the vppn
- * field in tlb entry contains bit[47:13], so need adjust.
- * virt_vpn = vaddr[47:13]
- */
-bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
-                          int *index)
-{
-    LoongArchTLB *tlb;
-    uint16_t csr_asid, tlb_asid, stlb_idx;
-    uint8_t tlb_e, tlb_ps, tlb_g, stlb_ps;
-    int i, compare_shift;
-    uint64_t vpn, tlb_vppn;
-
-    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
-    stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
-    vpn = (vaddr & TARGET_VIRT_MASK) >> (stlb_ps + 1);
-    stlb_idx = vpn & 0xff; /* VA[25:15] <==> TLBIDX.index for 16KiB Page */
-    compare_shift = stlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
-
-    /* Search STLB */
-    for (i = 0; i < 8; ++i) {
-        tlb = &env->tlb[i * 256 + stlb_idx];
-        tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
-        if (tlb_e) {
-            tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
-            tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
-            tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-
-            if ((tlb_g == 1 || tlb_asid == csr_asid) &&
-                (vpn == (tlb_vppn >> compare_shift))) {
-                *index = i * 256 + stlb_idx;
-                return true;
-            }
-        }
-    }
-
-    /* Search MTLB */
-    for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; ++i) {
-        tlb = &env->tlb[i];
-        tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
-        if (tlb_e) {
-            tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
-            tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
-            tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
-            tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
-            vpn = (vaddr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
-            if ((tlb_g == 1 || tlb_asid == csr_asid) &&
-                (vpn == (tlb_vppn >> compare_shift))) {
-                *index = i;
-                return true;
-            }
-        }
-    }
-    return false;
-}
-
-static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
-                                       int *prot, target_ulong address,
-                                       MMUAccessType access_type, int mmu_idx)
-{
-    int index, match;
-
-    match = loongarch_tlb_search(env, address, &index);
-    if (match) {
-        return loongarch_map_tlb_entry(env, physical, prot,
-                                       address, access_type, index, mmu_idx);
-    }
-
-    return TLBRET_NOMATCH;
-}
-#else
-static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
-                                       int *prot, target_ulong address,
-                                       MMUAccessType access_type, int mmu_idx)
-{
-    return TLBRET_NOMATCH;
-}
-#endif
-
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                         uint64_t *dir_width, target_ulong level)
 {
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 9fdc3059d8..f85927860b 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -54,8 +54,6 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
 uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
                                                uint64_t value);
-bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
-                          int *index);
 int get_physical_address(CPULoongArchState *env, hwaddr *physical,
                          int *prot, target_ulong address,
                          MMUAccessType access_type, int mmu_idx, int is_debug);
@@ -67,6 +65,18 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr);
+int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
+                                int *prot, target_ulong address,
+                                MMUAccessType access_type, int mmu_idx);
+#else
+static inline int loongarch_get_addr_from_tlb(CPULoongArchState *env,
+                                              hwaddr *physical,
+                                              int *prot, target_ulong address,
+                                              MMUAccessType access_type,
+                                              int mmu_idx)
+{
+    return TLBRET_NOMATCH;
+}
 #endif
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index e6cfcc55c8..f0c23e3838 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -201,6 +201,66 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
     return val % (high - low + 1) + low;
 }
 
+/*
+ * One tlb entry holds an adjacent odd/even pair, the vpn is the
+ * content of the virtual page number divided by 2. So the
+ * compare vpn is bit[47:15] for 16KiB page. while the vppn
+ * field in tlb entry contains bit[47:13], so need adjust.
+ * virt_vpn = vaddr[47:13]
+ */
+static bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
+                                 int *index)
+{
+    LoongArchTLB *tlb;
+    uint16_t csr_asid, tlb_asid, stlb_idx;
+    uint8_t tlb_e, tlb_ps, tlb_g, stlb_ps;
+    int i, compare_shift;
+    uint64_t vpn, tlb_vppn;
+
+    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
+    stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+    vpn = (vaddr & TARGET_VIRT_MASK) >> (stlb_ps + 1);
+    stlb_idx = vpn & 0xff; /* VA[25:15] <==> TLBIDX.index for 16KiB Page */
+    compare_shift = stlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
+
+    /* Search STLB */
+    for (i = 0; i < 8; ++i) {
+        tlb = &env->tlb[i * 256 + stlb_idx];
+        tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
+        if (tlb_e) {
+            tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
+            tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
+            tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
+
+            if ((tlb_g == 1 || tlb_asid == csr_asid) &&
+                (vpn == (tlb_vppn >> compare_shift))) {
+                *index = i * 256 + stlb_idx;
+                return true;
+            }
+        }
+    }
+
+    /* Search MTLB */
+    for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; ++i) {
+        tlb = &env->tlb[i];
+        tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
+        if (tlb_e) {
+            tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
+            tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
+            tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
+            tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
+            compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
+            vpn = (vaddr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
+            if ((tlb_g == 1 || tlb_asid == csr_asid) &&
+                (vpn == (tlb_vppn >> compare_shift))) {
+                *index = i;
+                return true;
+            }
+        }
+    }
+    return false;
+}
+
 void helper_tlbsrch(CPULoongArchState *env)
 {
     int index, match;
@@ -609,3 +669,87 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     }
     env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, PS, ps);
 }
+
+static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
+                                   int *prot, target_ulong address,
+                                   int access_type, int index, int mmu_idx)
+{
+    LoongArchTLB *tlb = &env->tlb[index];
+    uint64_t plv = mmu_idx;
+    uint64_t tlb_entry, tlb_ppn;
+    uint8_t tlb_ps, n, tlb_v, tlb_d, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
+
+    if (index >= LOONGARCH_STLB) {
+        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
+    } else {
+        tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+    }
+    n = (address >> tlb_ps) & 0x1;/* Odd or even */
+
+    tlb_entry = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
+    tlb_v = FIELD_EX64(tlb_entry, TLBENTRY, V);
+    tlb_d = FIELD_EX64(tlb_entry, TLBENTRY, D);
+    tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
+    if (is_la64(env)) {
+        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
+        tlb_nx = FIELD_EX64(tlb_entry, TLBENTRY_64, NX);
+        tlb_nr = FIELD_EX64(tlb_entry, TLBENTRY_64, NR);
+        tlb_rplv = FIELD_EX64(tlb_entry, TLBENTRY_64, RPLV);
+    } else {
+        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_32, PPN);
+        tlb_nx = 0;
+        tlb_nr = 0;
+        tlb_rplv = 0;
+    }
+
+    /* Remove sw bit between bit12 -- bit PS*/
+    tlb_ppn = tlb_ppn & ~(((0x1UL << (tlb_ps - 12)) - 1));
+
+    /* Check access rights */
+    if (!tlb_v) {
+        return TLBRET_INVALID;
+    }
+
+    if (access_type == MMU_INST_FETCH && tlb_nx) {
+        return TLBRET_XI;
+    }
+
+    if (access_type == MMU_DATA_LOAD && tlb_nr) {
+        return TLBRET_RI;
+    }
+
+    if (((tlb_rplv == 0) && (plv > tlb_plv)) ||
+        ((tlb_rplv == 1) && (plv != tlb_plv))) {
+        return TLBRET_PE;
+    }
+
+    if ((access_type == MMU_DATA_STORE) && !tlb_d) {
+        return TLBRET_DIRTY;
+    }
+
+    *physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
+                (address & MAKE_64BIT_MASK(0, tlb_ps));
+    *prot = PAGE_READ;
+    if (tlb_d) {
+        *prot |= PAGE_WRITE;
+    }
+    if (!tlb_nx) {
+        *prot |= PAGE_EXEC;
+    }
+    return TLBRET_MATCH;
+}
+
+int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
+                                int *prot, target_ulong address,
+                                MMUAccessType access_type, int mmu_idx)
+{
+    int index, match;
+
+    match = loongarch_tlb_search(env, address, &index);
+    if (match) {
+        return loongarch_map_tlb_entry(env, physical, prot,
+                                       address, access_type, index, mmu_idx);
+    }
+
+    return TLBRET_NOMATCH;
+}
-- 
2.39.3


