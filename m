Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68219CF07B5
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 06:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syn32-00018I-Az; Thu, 10 Oct 2024 02:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1syn2z-00017Y-45
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 02:53:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1syn2w-00040c-0f
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 02:53:16 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxnnPWeQdn9+IRAA--.26015S3;
 Thu, 10 Oct 2024 14:53:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxXuTTeQdnBiAiAA--.41709S7;
 Thu, 10 Oct 2024 14:53:09 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn,
	philmd@linaro.org
Subject: [PATCH v2 5/5] target/loongarch/tcg: Add hardware page table walker
 support
Date: Thu, 10 Oct 2024 14:35:36 +0800
Message-Id: <20241010063536.2276871-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241010063536.2276871-1-gaosong@loongson.cn>
References: <20241010063536.2276871-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXuTTeQdnBiAiAA--.41709S7
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

Add hardware page table walker (HPTW) feature for la664.
Set CPUCFG2.HPTW = 1 to indicate that HPTW is implemented on this CPU.
Set PWCH.HPTW_EN = 1 to enable HPTW.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu-csr.h        |   3 +
 target/loongarch/cpu.c            |   1 +
 target/loongarch/cpu.h            |   1 +
 target/loongarch/cpu_helper.c     |  26 +++++-
 target/loongarch/internals.h      |   4 +-
 target/loongarch/tcg/tlb_helper.c | 147 +++++++++++++++++++++++++++++-
 6 files changed, 176 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 0834e91f30..1aa015dc44 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -68,6 +68,8 @@ FIELD(TLBENTRY, PLV, 2, 2)
 FIELD(TLBENTRY, MAT, 4, 2)
 FIELD(TLBENTRY, G, 6, 1)
 FIELD(TLBENTRY, HUGE, 6, 1)
+FIELD(TLBENTRY, PRESENT, 7, 1)
+FIELD(TLBENTRY, WRITE, 8, 1)
 FIELD(TLBENTRY, HGLOBAL, 12, 1)
 FIELD(TLBENTRY, LEVEL, 13, 2)
 FIELD(TLBENTRY_32, PPN, 8, 24)
@@ -103,6 +105,7 @@ FIELD(CSR_PWCH, DIR3_BASE, 0, 6)
 FIELD(CSR_PWCH, DIR3_WIDTH, 6, 6)
 FIELD(CSR_PWCH, DIR4_BASE, 12, 6)
 FIELD(CSR_PWCH, DIR4_WIDTH, 18, 6)
+FIELD(CSR_PWCH, HPTW_EN, 24, 1)
 
 #define LOONGARCH_CSR_STLBPS         0x1e /* Stlb page size */
 FIELD(CSR_STLBPS, PS, 0, 5)
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d55b4110a9..9dbf2ce67b 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -476,6 +476,7 @@ static void loongarch_la664_initfn(Object *obj)
     env->cpucfg[0] = 0x14d000; /* PRID */
 
     loongarch_common_initfn(env, obj);
+    env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, HPTW, 1);
 }
 
 static void loongarch_la464_initfn(Object *obj)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 6c41fafb70..84f92507d6 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -155,6 +155,7 @@ FIELD(CPUCFG2, LBT_ARM, 19, 1)
 FIELD(CPUCFG2, LBT_MIPS, 20, 1)
 FIELD(CPUCFG2, LSPW, 21, 1)
 FIELD(CPUCFG2, LAM, 22, 1)
+FIELD(CPUCFG2, HPTW, 24, 1)
 
 /* cpucfg[3] bits */
 FIELD(CPUCFG3, CCDMA, 0, 1)
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 580362ac3e..35c95e9a27 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -178,10 +178,11 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
 
 int get_physical_address(CPULoongArchState *env, hwaddr *physical,
                          int *prot, target_ulong address,
-                         MMUAccessType access_type, int mmu_idx)
+                         MMUAccessType access_type, int mmu_idx, bool is_debug)
 {
     int user_mode = mmu_idx == MMU_USER_IDX;
     int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
+    int ret;
     uint32_t plv, base_c, base_v;
     int64_t addr_high;
     uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
@@ -221,8 +222,25 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
     }
 
     /* Mapped address */
-    return loongarch_map_address(env, physical, prot, address,
-                                 access_type, mmu_idx);
+    ret = loongarch_map_address(env, physical, prot, address,
+                                access_type, mmu_idx);
+#ifdef CONFIG_TCG
+    if (!FIELD_EX32(env->cpucfg[2], CPUCFG2, HPTW)) {
+        return ret;
+    }
+
+    if (!FIELD_EX32(env->CSR_PWCH, CSR_PWCH, HPTW_EN)) {
+        return ret;
+    }
+
+    if (do_page_walk(env, address, access_type, ret, physical, is_debug)) {
+        if (!is_debug) {
+            ret = loongarch_map_address(env, physical, prot, address,
+                                        access_type, mmu_idx);
+        }
+    }
+#endif
+    return ret;
 }
 
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
@@ -232,7 +250,7 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot;
 
     if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
-                             cpu_mmu_index(cs, false)) != 0) {
+                             cpu_mmu_index(cs, false), true) != 0) {
         return -1;
     }
     return phys_addr;
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 1a02427627..fc8357914b 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -56,13 +56,15 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
                           int *index);
 int get_physical_address(CPULoongArchState *env, hwaddr *physical,
                          int *prot, target_ulong address,
-                         MMUAccessType access_type, int mmu_idx);
+                         MMUAccessType access_type, int mmu_idx, bool is_debug);
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
 #ifdef CONFIG_TCG
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr);
+bool do_page_walk(CPULoongArchState *env, vaddr address,
+                  MMUAccessType, int tlb_error, hwaddr *physical, bool is_debug);
 #endif
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 463e9be7f2..cecffde56e 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/guest-random.h"
+#include "qemu/atomic.h"
 
 #include "cpu.h"
 #include "internals.h"
@@ -504,7 +505,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
     /* Data access */
     ret = get_physical_address(env, &physical, &prot, address,
-                               access_type, mmu_idx);
+                               access_type, mmu_idx, false);
 
     if (ret == TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
@@ -651,3 +652,147 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     }
     env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, PS, ps);
 }
+
+static target_ulong get_pte_base(CPULoongArchState *env, vaddr address)
+{
+    uint64_t dir_base, dir_width;
+    target_ulong base;
+    int i;
+
+    /* Get PGD */
+    base = ((address >> 63) & 0x1) ? env->CSR_PGDH : env->CSR_PGDL;
+
+    for (i = 4; i > 0; i--) {
+        get_dir_base_width(env, &dir_base, &dir_width, i);
+        /*
+         * LDDIR: level = 2 corresponds to Dir1 in PWCL.
+         * PWCL/PWCH: dir >= 1 && dir_width == 0 means no such level.
+         */
+        if (i >= 2 && dir_width == 0) {
+            continue;
+        }
+        base = do_lddir(env, base, address, i);
+    }
+
+    return base;
+}
+
+bool do_page_walk(CPULoongArchState *env, vaddr address,
+                  MMUAccessType access_type, int tlb_error,
+                  hwaddr *physical, bool is_debug)
+{
+    CPUState *cs = env_cpu(env);
+    target_ulong base, ps, tmp0, tmp1, ptindex, ptoffset, cur_val, new_val, old_val;
+    uint64_t entrylo0, entrylo1, tlbehi, vppn;
+    uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
+    uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
+    int index, shift;
+    bool ret = false;
+
+    /*
+     * tlb error map :
+     * TLBRET_NOMATCH : tlb fill
+     * TLBRET_INVALID : access_type = 0/2  tlb_load
+     *                : access_type = 1    tlb_store
+     * TLBRET_DIRTY   : tlb_modify
+     */
+    switch (tlb_error) {
+    case TLBRET_NOMATCH:
+        base = get_pte_base(env, address);
+        if (base == 0) {
+            return ret;
+        }
+        do_ldpte(env, base, address, &tmp0, &tmp1, &ps);
+        entrylo0 = tmp0;
+        entrylo1 = tmp1;
+        tlbehi = address & (TARGET_PAGE_MASK << 1);
+        vppn = FIELD_EX64(tlbehi, CSR_TLBEHI_64, VPPN);
+        if (is_debug) {
+            uint64_t tlb_ppn, tlb_entry;
+            uint8_t n;
+            n = (address >> ps) & 0x1;/* Odd or even */
+
+            tlb_entry = n ? entrylo1: entrylo1;
+            tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
+            /* Remove sw bit between bit12 -- bit PS */
+            tlb_ppn = tlb_ppn & ~(((0x1UL << (ps - 12)) -1));
+            *physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
+                        (address & MAKE_64BIT_MASK(0, ps));
+        } else {
+            index = get_random_tlb_index(env, tlbehi, ps);
+            invalidate_tlb(env, index);
+            do_fill_tlb_entry(env, vppn, entrylo0, entrylo1, index, ps);
+        }
+
+        ret = true;
+        break;
+    case TLBRET_DIRTY:
+    case TLBRET_INVALID:
+        base = get_pte_base(env, address);
+
+        /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
+        shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
+        shift = (shift + 1) * 3;
+        ptindex = (address >> ptbase) & ((1 << ptwidth) -1);
+        ptoffset = ptindex << shift;
+        tmp0 = base | ptoffset;
+      retry:
+        old_val = ldq_phys(cs->as, tmp0) & TARGET_PHYS_MASK;
+
+        if (old_val == 0) {
+            return ret;
+        }
+
+        new_val = old_val;
+        /* Check pte val, and do tlb modify. */
+        if ((tlb_error == TLBRET_INVALID) &&
+            (access_type == MMU_INST_FETCH )) {
+            if (!(FIELD_EX64(new_val, TLBENTRY, PRESENT))) {
+                break;
+            }
+            new_val = FIELD_DP64(new_val, TLBENTRY, V, 1);
+        } else if ((tlb_error == TLBRET_INVALID) &&
+                   access_type == MMU_DATA_STORE) {
+            if (!((FIELD_EX64(new_val, TLBENTRY, PRESENT) &&
+                  (FIELD_EX64(new_val, TLBENTRY, WRITE))))){
+                break;
+            }
+            new_val = FIELD_DP64(new_val, TLBENTRY, V, 1);
+        } else if (tlb_error ==  TLBRET_DIRTY) {
+            if (!(FIELD_EX64(new_val, TLBENTRY, PRESENT) &&
+                 (FIELD_EX64(new_val, TLBENTRY, WRITE)))) {
+                break;
+            }
+            new_val = FIELD_DP64(new_val, TLBENTRY, V, 1);
+        }
+
+        if (old_val != new_val) {
+            cur_val = qatomic_cmpxchg((uint64_t *)tmp0, old_val, new_val);
+            if (cur_val == old_val) {
+                goto retry;
+            }
+        }
+
+        tmp0 = tmp0 & (~0x8);
+        entrylo0 = ldq_phys(cs->as, tmp0) & TARGET_PHYS_MASK;
+        entrylo1 = ldq_phys(cs->as, tmp0 | 0x8) & TARGET_PHYS_MASK;
+        tlbehi = address & (TARGET_PAGE_MASK << 1);
+        ps = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
+        vppn = FIELD_EX64(tlbehi, CSR_TLBEHI_64, VPPN);
+
+        /*
+         * srch tlb index with tlb entryhi
+         * if no match, we use get_random_tlb_index() to get random index.
+         */
+        if (!loongarch_tlb_search(env, tlbehi, &index)) {
+            index = get_random_tlb_index(env, tlbehi, ps);
+        }
+        invalidate_tlb(env, index);
+        do_fill_tlb_entry(env, vppn, entrylo0, entrylo1, index, ps);
+        ret = true;
+        break;
+    default:
+        ;
+    }
+    return ret;
+}
-- 
2.33.0


