Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27A1606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 14:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ446-0003mm-Ru; Sun, 08 Nov 2026 09:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xQ43u-0003jw-G9; Sun, 08 Nov 2026 09:40:03 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xQ43q-00038r-WC; Sun, 08 Nov 2026 09:40:02 -0500
Received: from k3-03 (unknown [159.226.43.8])
 by APP-03 (Coremail) with SMTP id rQCowAAXJpetifBqBgKWAA--.15550S5;
 Sun, 08 Nov 2026 22:39:54 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH 3/3] hw/riscv: iommu: Support automatic PTE A/D updates
Date: Sun,  8 Nov 2026 22:39:33 +0800
Message-ID: <20261108143934.129923-4-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108143934.129923-1-tanchi25@mails.ucas.ac.cn>
References: <20261108143934.129923-1-tanchi25@mails.ucas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXJpetifBqBgKWAA--.15550S5
X-Coremail-Antispam: 1UD129KBjvJXoW3ZFyUKFyktr4kXryktr4ruFg_yoWDZr1DpF
 95GrWagr45tr1fuFsxJw1DGF1ru3Z5G343W390gasYkF4jqrW5Xan0ya45AF4DKryUZ3WF
 qa1rZFsxZr4IvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
 8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
 z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mx
 kF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
 MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
 AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
 80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
 43ZEXa7VUbBMKJUUUUU==
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=tanchi25@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the AMO_HWAD capability to automatically update the
accessed and dirty bits of leaf PTEs when SADE or GADE is enabled.

Use atomic compare-and-exchange to update PTEs, restarting the
page-table walk if a concurrent modification is detected.

For nested translation, check G-stage write permissions before updating
an S-stage PTE. Restart the walk if the write translation resolves to a
different physical address.

Avoid caching write permission when the PTE's dirty bit is clear, so
subsequent writes can trigger the required update.

Expose the capability through the new "amo-hwad" device property,
disabled by default.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
 hw/riscv/riscv-iommu.c | 196 ++++++++++++++++++++++++++++++++++++++++-
 hw/riscv/riscv-iommu.h |   1 +
 2 files changed, 193 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 6760699eb8..04d50cd620 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -265,6 +265,128 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
     return page_mask;
 }
 
+typedef enum RISCVIOMMUADResult {
+    RISCV_IOMMU_AD_SUCCESS,
+    RISCV_IOMMU_AD_RETRY,
+    RISCV_IOMMU_AD_FAULT,
+} RISCVIOMMUADResult;
+
+/*
+ * Atomically update the A/D bits of a leaf PTE.
+ * Retry the page-table walk if the PTE has changed.
+ */
+static RISCVIOMMUADResult
+riscv_iommu_ad_update(RISCVIOMMUState *s, hwaddr pte_addr,
+                      unsigned int pte_size, uint64_t pte, uint64_t updated_pte)
+{
+    MemoryRegion *mr;
+    hwaddr offset, len = pte_size;
+    uint64_t old_pte;
+    void *pte_ptr;
+
+    if (pte_addr & (pte_size - 1)) {
+        return RISCV_IOMMU_AD_FAULT;
+    }
+
+    RCU_READ_LOCK_GUARD();
+
+    mr = address_space_translate(s->target_as, pte_addr, &offset,
+                                 &len, true, MEMTXATTRS_UNSPECIFIED);
+
+    if (len < pte_size || !memory_region_is_ram(mr)) {
+        /*
+         * The entire PTE must be backed by a single RAM region
+         * for an atomic update.
+         */
+        return RISCV_IOMMU_AD_FAULT;
+    }
+
+    pte_ptr = qemu_map_ram_ptr(mr->ram_block, offset);
+
+    if (pte_size == 4) {
+        uint32_t expected = cpu_to_le32((uint32_t)pte);
+        uint32_t desired = cpu_to_le32((uint32_t)updated_pte);
+
+        old_pte = qatomic_cmpxchg((uint32_t *)pte_ptr, expected, desired);
+        old_pte = le32_to_cpu(old_pte);
+    } else {
+        uint64_t expected = cpu_to_le64(pte);
+        uint64_t desired = cpu_to_le64(updated_pte);
+
+        old_pte = qatomic_cmpxchg((uint64_t *)pte_ptr, expected, desired);
+        old_pte = le64_to_cpu(old_pte);
+    }
+
+    if (old_pte != pte) {
+        return RISCV_IOMMU_AD_RETRY;
+    }
+
+    return RISCV_IOMMU_AD_SUCCESS;
+}
+
+static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
+    IOMMUTLBEntry *iotlb, bool implicit_write, uint64_t *fault_iotval2);
+
+/*
+ * Updating a first-stage leaf PTE requires an implicit write.
+ * Translate its GPA through the G-stage, checking write permission
+ * and updating the G-stage's A/D bits as needed.
+ */
+static int riscv_iommu_check_pte_write(RISCVIOMMUState *s,
+                                       RISCVIOMMUContext *ctx,
+                                       dma_addr_t pte_gpa,
+                                       IOMMUAccessFlags req_perm,
+                                       hwaddr *pte_spa,
+                                       uint64_t *fault_iotval2)
+{
+    RISCVIOMMUContext gctx = *ctx;
+    uint64_t iotval2 = 0;
+    int fault;
+
+    IOMMUTLBEntry iotlb = {
+        .iova = pte_gpa,
+        .target_as = s->target_as,
+        .addr_mask = ~0ULL,
+        .perm = IOMMU_WO,
+    };
+
+    gctx.satp = RISCV_IOMMU_DC_FSC_MODE_BARE;
+
+    fault = riscv_iommu_spa_fetch(s, &gctx, &iotlb, true, &iotval2);
+
+    if (fault) {
+        *fault_iotval2 = iotval2;
+
+        if (fault == RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS ||
+            fault == RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS) {
+            /*
+             * Per the RISC-V IOMMU Fault/Event Queue format, iotval2[0]
+             * indicates an implicit first-stage access and iotval2[1]
+             * indicates an implicit write. Report the fault for the
+             * original DMA access rather than the implicit write.
+             */
+            *fault_iotval2 = (pte_gpa & ~3ULL) | 3;
+
+            fault = (req_perm & IOMMU_WO) ?
+                        RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
+                        RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS;
+        } else if (fault == RISCV_IOMMU_FQ_CAUSE_RD_FAULT ||
+                   fault == RISCV_IOMMU_FQ_CAUSE_WR_FAULT) {
+            /*
+             * A physical access fault also uses the original
+             * DMA access type.
+             */
+            fault = (req_perm & IOMMU_WO) ?
+                        RISCV_IOMMU_FQ_CAUSE_WR_FAULT :
+                        RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
+        }
+        return fault;
+    }
+
+    *pte_spa = iotlb.translated_addr;
+    return 0;
+}
+
 /*
  * RISCV IOMMU Address Translation Lookup - Page Table Walk
  *
@@ -277,14 +399,15 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
  * @ctx             : Translation context for device id and process
  *                    address space id.
  * @iotlb           : translation data: physical address and access mode.
+ * @implicit_write  : Whether this is an implicit write to a first-stage PTE.
  * @fault_iotval2   : Fault address and implicit-access flags for iotval2.
  * @return          : success or fault cause code.
  */
 static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
-    IOMMUTLBEntry *iotlb, uint64_t *fault_iotval2)
+    IOMMUTLBEntry *iotlb, bool implicit_write, uint64_t *fault_iotval2)
 {
     IOMMUAccessFlags trans_perm = IOMMU_NONE;
-    dma_addr_t addr, base;
+    dma_addr_t addr, base, s_base_gpa = 0;
     uint64_t satp, gatp, pte;
     bool en_s, en_g;
     struct {
@@ -308,6 +431,8 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
      * effective leaf permission for the translation cache.
      */
     const IOMMUAccessFlags req_perm = iotlb->perm;
+    const hwaddr addr_mask = iotlb->addr_mask;
+    const hwaddr translated_addr = iotlb->translated_addr;
 
     satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
     gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
@@ -326,7 +451,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
      * means we can't do an early MSI check unless we have
      * strictly !en_s.
      */
-    if (!en_s && (req_perm & IOMMU_WO) &&
+    if (!implicit_write && !en_s && (req_perm & IOMMU_WO) &&
         riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
         iotlb->target_as = &s->trap_as;
         iotlb->translated_addr = iotlb->iova;
@@ -413,6 +538,17 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     /* S/G stages translation tables root pointers */
     gatp = PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
     satp = PPN_PHYS(get_field(ctx->satp, RISCV_IOMMU_ATP_PPN_FIELD));
+
+restart:
+    sc[S_STAGE].step = 0;
+    sc[G_STAGE].step = 0;
+    trans_perm = IOMMU_NONE;
+    iotlb->addr_mask = addr_mask;
+    iotlb->translated_addr = translated_addr;
+    iotlb->perm = req_perm;
+    s_base_gpa = 0;
+    *fault_iotval2 = 0;
+
     addr = (en_s && en_g) ? satp : iotlb->iova;
     base = en_g ? gatp : satp;
     pass = en_g ? G_STAGE : S_STAGE;
@@ -540,8 +676,51 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                 iotlb->addr_mask &= (1ULL << va_skip) - 1;
             }
 
+            /* Automatically update the leaf PTE's A/D bits when enabled. */
+            uint64_t updated_pte = pte;
+            if (ade) {
+                updated_pte |= PTE_A;
+
+                if (acc_perm & IOMMU_WO) {
+                    updated_pte |= PTE_D;
+                }
+            }
+            if (updated_pte != pte) {
+                if (pass == S_STAGE && en_g) {
+                    const dma_addr_t s_pte_gpa =
+                        s_base_gpa + idx * sc[pass].ptesize;
+                    hwaddr write_spa;
+
+                    int fault = riscv_iommu_check_pte_write(
+                        s, ctx, s_pte_gpa, req_perm, &write_spa,
+                        fault_iotval2);
+                    if (fault) {
+                        return fault;
+                    }
+
+                    if (write_spa != pte_addr) {
+                        goto restart;
+                    }
+                }
+
+                RISCVIOMMUADResult result = riscv_iommu_ad_update(
+                    s, pte_addr, sc[pass].ptesize, pte, updated_pte);
+
+                if (result == RISCV_IOMMU_AD_RETRY) {
+                    goto restart;
+                }
+                if (result == RISCV_IOMMU_AD_FAULT) {
+                    return (req_perm & IOMMU_WO) ?
+                        RISCV_IOMMU_FQ_CAUSE_WR_FAULT :
+                        RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
+                }
+                pte = updated_pte;
+            }
+
             /* Continue with S-Stage translation? */
             if (pass && sc[0].step != sc[0].levels) {
+                /* Save the S-stage page-table GPA for A/D updates. */
+                s_base_gpa = addr;
                 pass = S_STAGE;
                 addr = iotlb->iova;
                 continue;
@@ -552,6 +731,11 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                                          ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO) :
                                          IOMMU_RO;
 
+            /* Do not cache write permission until the D bit is set. */
+            if (!(pte & PTE_D)) {
+                leaf_perm &= ~IOMMU_WO;
+            }
+
             trans_perm = trans_perm == IOMMU_NONE ?
                          leaf_perm : trans_perm & leaf_perm;
 
@@ -1794,7 +1978,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_TLB_MISS);
 
     /* Translate using device directory / page table information. */
-    fault = riscv_iommu_spa_fetch(s, ctx, iotlb, &fault_iotval2);
+    fault = riscv_iommu_spa_fetch(s, ctx, iotlb, false, &fault_iotval2);
 
     if (!fault && iotlb->target_as == &s->trap_as) {
         /* Do not cache trapped MSI translations */
@@ -2732,6 +2916,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     if (s->enable_ats) {
         s->cap |= RISCV_IOMMU_CAP_ATS;
     }
+    if (s->enable_amo_hwad) {
+        s->cap |= RISCV_IOMMU_CAP_AMO_HWAD;
+    }
     if (s->enable_s_stage) {
         s->cap |= RISCV_IOMMU_CAP_SV32 | RISCV_IOMMU_CAP_SV39 |
                   RISCV_IOMMU_CAP_SV48 | RISCV_IOMMU_CAP_SV57;
@@ -2891,6 +3078,7 @@ static const Property riscv_iommu_properties[] = {
         LIMIT_CACHE_IOT),
     DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
     DEFINE_PROP_BOOL("ats", RISCVIOMMUState, enable_ats, TRUE),
+    DEFINE_PROP_BOOL("amo-hwad", RISCVIOMMUState, enable_amo_hwad, false),
     DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
     DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
     DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 403d10b321..8cf228f698 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -44,6 +44,7 @@ struct RISCVIOMMUState {
     bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
     bool enable_msi;      /* Enable MSI remapping */
     bool enable_ats;      /* Enable ATS support */
+    bool enable_amo_hwad; /* Enable hardware A/D updates */
     bool enable_s_stage;  /* Enable S/VS-Stage translation */
     bool enable_g_stage;  /* Enable G-Stage translation */
 
-- 
2.53.0


