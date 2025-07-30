Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEC4C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 03:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugxDH-0001Uy-2Q; Tue, 29 Jul 2025 23:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ugxCt-0001OP-A5
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 23:10:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ugxCq-0008TI-QQ
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 23:10:18 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxDeMVjYlorLw0AQ--.4401S3;
 Wed, 30 Jul 2025 11:10:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxpeQUjYlo4vIsAA--.30353S2;
 Wed, 30 Jul 2025 11:10:12 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 14/19] target/loongarch: Track user space address accessed
 in kernel mode
Date: Wed, 30 Jul 2025 11:10:12 +0800
Message-Id: <20250730031012.3426155-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250730030202.3425934-1-maobibo@loongson.cn>
References: <20250730030202.3425934-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpeQUjYlo4vIsAA--.30353S2
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The concept of mmu idx between QEMU TLB and LoongArch TLB emulation
is different:
  mmu idx in QEMU TLB comes from currently working mode of vCPU
  mmu idx from LoongArch TLB is page priviledge level
With copy_from_user() executed in system, vCPU is in kernel mode
however PLV of PTE is user mode.

Here field KM is added in LoongArch TLB entry to track whether the
lo0/lo1 pte entry is accessed in kernel mode. If set, when LoongArch
TLB is flushed, need flush QEMU TLB with mmu idx MMU_KERNEL_IDX.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-mmu.h        |  2 ++
 target/loongarch/cpu.h            | 14 ++++++++++++++
 target/loongarch/cpu_helper.c     |  3 +++
 target/loongarch/tcg/tlb_helper.c | 26 ++++++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 0068d22efc..311bf7b2d7 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -25,6 +25,8 @@ typedef struct MMUContext {
     hwaddr        physical;
     int           ps;  /* page size shift */
     int           prot;
+    int           tlb_index;
+    int           mmu_index;
 } MMUContext;
 
 bool check_ps(CPULoongArchState *ent, uint8_t ps);
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 7731f6acdc..3c5fcaa154 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -253,6 +253,20 @@ FIELD(TLB_MISC, E, 0, 1)
 FIELD(TLB_MISC, ASID, 1, 10)
 FIELD(TLB_MISC, VPPN, 13, 35)
 FIELD(TLB_MISC, PS, 48, 6)
+/*
+ * Used by QEMU software, concept of mmu idx between QEMU TLB and LoongArch
+ * TLB emulation is different:
+ *   mmu idx in QEMU TLB is current working mode of vCPU
+ *   mmu idx in LoongArch TLB is PLV access level
+ * When funtion copy_from_user() executed with system emulation method,
+ * vCPU is in kernel mode however accessed address is user memory space.
+ *
+ * TLB lo0/lo1 entry mask with PLV MMU_USER_IDX accessed in kernel mode
+ */
+FIELD(TLB_MISC, KM, 54, 2)
+#define TLB_MISC_KM_PTE(n)          BIT_ULL(R_TLB_MISC_KM_SHIFT + n)
+#define TLB_MISC_KM_PTE_LOW0        TLB_MISC_KM_PTE(0)
+#define TLB_MISC_KM_PTE_LOW1        TLB_MISC_KM_PTE(1)
 
 #define LSX_LEN    (128)
 #define LASX_LEN   (256)
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index ec84fb5425..8831c95549 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -96,6 +96,7 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
     context->physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
                         (context->addr & MAKE_64BIT_MASK(0, tlb_ps));
     context->prot = PAGE_READ;
+    context->mmu_index = tlb_plv;
     if (tlb_d) {
         context->prot |= PAGE_WRITE;
     }
@@ -217,6 +218,7 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
     if (da & !pg) {
         context->physical = address & TARGET_PHYS_MASK;
         context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        context->mmu_index = MMU_DA_IDX;
         return TLBRET_MATCH;
     }
 
@@ -236,6 +238,7 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
         if ((plv & env->CSR_DMW[i]) && (base_c == base_v)) {
             context->physical = dmw_va2pa(env, address, env->CSR_DMW[i]);
             context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+            context->mmu_index = MMU_DA_IDX;
             return TLBRET_MATCH;
         }
     }
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 7d3f98633d..d86a189239 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -172,6 +172,7 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
     }
 
     /* Store page size in field PS */
+    tlb->tlb_misc = 0;
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, VPPN, csr_vppn);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 1);
@@ -510,6 +511,24 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
     tlb_flush(env_cpu(env));
 }
 
+/*
+ * Record tlb entry with virtual address from user mode accessed from
+ * vCPU kernel mode.
+ *
+ * If set, when LoongArch TLB is flushed, need flush QEMU TLB with mmu
+ * idx MMU_KERNEL_IDX
+ */
+static inline void tlb_set_accessed(CPULoongArchState *env, vaddr address,
+                                    int index)
+{
+    LoongArchTLB *tlb = &env->tlb[index];
+    uint8_t tlb_ps, n;
+
+    tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
+    n = (address >> tlb_ps) & 0x1;/* Odd or even */
+    tlb->tlb_misc |= TLB_MISC_KM_PTE(n);
+}
+
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr)
@@ -529,6 +548,12 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot,
                      mmu_idx, TARGET_PAGE_SIZE);
+
+        /* user mode address space is accessed in vCPU kernel mode */
+        if (mmu_idx == MMU_KERNEL_IDX && context.mmu_index == MMU_USER_IDX) {
+            tlb_set_accessed(env, address, context.tlb_index);
+        }
+
         qemu_log_mask(CPU_LOG_MMU,
                       "%s address=%" VADDR_PRIx " physical " HWADDR_FMT_plx
                       " prot %d\n", __func__, address, physical, prot);
@@ -662,6 +687,7 @@ static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
     n = (context->addr >> tlb_ps) & 0x1;/* Odd or even */
     context->pte = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
     context->ps = tlb_ps;
+    context->tlb_index = index;
     return loongarch_check_pte(env, context, access_type, mmu_idx);
 }
 
-- 
2.39.3


