Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E30606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 14:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ43v-0003jt-Uu; Sun, 08 Nov 2026 09:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xQ43s-0003im-NO; Sun, 08 Nov 2026 09:40:00 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xQ43p-00038l-9N; Sun, 08 Nov 2026 09:40:00 -0500
Received: from k3-03 (unknown [159.226.43.8])
 by APP-03 (Coremail) with SMTP id rQCowAAXJpetifBqBgKWAA--.15550S3;
 Sun, 08 Nov 2026 22:39:48 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH 1/3] hw/riscv: iommu: Fix implicit G-stage page-table accesses
Date: Sun,  8 Nov 2026 22:39:31 +0800
Message-ID: <20261108143934.129923-2-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108143934.129923-1-tanchi25@mails.ucas.ac.cn>
References: <20261108143934.129923-1-tanchi25@mails.ucas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXJpetifBqBgKWAA--.15550S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WryxCrWDZr4UAF15Jr4ktFb_yoWxXFy8pF
 Z5WrWa9r43Jr1fZan3twn7GF1Fk3WkKrW5Ww1agasayF4YqrW5Xrs0ya4Yy3yqgFykZ3W8
 Jw45ZrsrZF4Yy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPC14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
 43ZEXa7VUjiiSJUUUUU==
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

When translating a DMA write, G-stage accesses to first-stage page
tables are implicit reads. The current implementation checks permissions
using the original DMA access type, which may incorrectly require write
permission for these reads.

Use read permission for implicit page-table accesses while preserving
the original DMA access type for the final translation and fault
reporting.

Also track the fault address separately from the translation result and
set the implicit-access flag in iotval2 for guest-page faults. Route
address-range failures through the common page-fault path to report the
correct fault address.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
 hw/riscv/riscv-iommu.c | 60 ++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 0e6970773a..2dcc528599 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -273,13 +273,15 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
  * Keeping them separate for now, as error reporting and flow specifics are
  * sufficiently different for separate implementation.
  *
- * @s        : IOMMU Device State
- * @ctx      : Translation context for device id and process address space id.
- * @iotlb    : translation data: physical address and access mode.
- * @return   : success or fault cause code.
+ * @s               : IOMMU Device State
+ * @ctx             : Translation context for device id and process
+ *                    address space id.
+ * @iotlb           : translation data: physical address and access mode.
+ * @fault_iotval2   : Fault address and implicit-access flags for iotval2.
+ * @return          : success or fault cause code.
  */
 static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
-    IOMMUTLBEntry *iotlb)
+    IOMMUTLBEntry *iotlb, uint64_t *fault_iotval2)
 {
     IOMMUAccessFlags trans_perm = IOMMU_NONE;
     dma_addr_t addr, base;
@@ -299,10 +301,10 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     MemTxResult ret;
     bool pv = !!ctx->process_id;
     /*
-     * Keep the request permission separate from iotlb->perm.  G-stage
+     * Keep the request permission separate from iotlb->perm. G-stage
      * walks translate S-stage PTE addresses before the real leaf is
      * reached, but permission checks and fault types must still use the
-     * original request.  A successful walk leaves iotlb->perm with the
+     * original request. A successful walk leaves iotlb->perm with the
      * effective leaf permission for the translation cache.
      */
     const IOMMUAccessFlags req_perm = iotlb->perm;
@@ -424,6 +426,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         const dma_addr_t pte_addr = base + idx * sc[pass].ptesize;
         const bool ade =
             ctx->tc & (pass ? RISCV_IOMMU_DC_TC_GADE : RISCV_IOMMU_DC_TC_SADE);
+        /*
+         * G-stage accesses to S-stage page tables are implicit reads.
+         * The original DMA permission is used for the final data access.
+         */
+        const bool implicit_read =
+            pass == G_STAGE && en_s && sc[S_STAGE].step != sc[S_STAGE].levels;
+        const IOMMUAccessFlags acc_perm =
+            implicit_read ? IOMMU_RO : req_perm;
 
         if (ade && !(s->cap & RISCV_IOMMU_CAP_AMO_HWAD)) {
             /* GADE/SADE are reserved bits if AMO_HWAD is cleared.  */
@@ -442,15 +452,11 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                 masked_msbs = (addr >> (va_len - 1)) & mask;
 
                 if (masked_msbs != 0 && masked_msbs != mask) {
-                    return (req_perm & IOMMU_WO) ?
-                                RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S :
-                                RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S;
+                    goto page_fault;
                 }
             } else {
                 if ((addr & va_mask) != addr) {
-                    return (req_perm & IOMMU_WO) ?
-                                RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
-                                RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS;
+                    goto page_fault;
                 }
             }
         }
@@ -499,13 +505,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
              * non-user mode leaf PTE and !pv we need to fault.
              */
             break;
-        } else if ((req_perm & IOMMU_RO) && !(pte & PTE_R)) {
+        } else if ((acc_perm & IOMMU_RO) && !(pte & PTE_R)) {
             break;                /* Read access check failed */
-        } else if ((req_perm & IOMMU_WO) && !(pte & PTE_W)) {
+        } else if ((acc_perm & IOMMU_WO) && !(pte & PTE_W)) {
             break;                /* Write access check failed */
         } else if (!ade && !(pte & PTE_A)) {
             break;                /* Access bit not set */
-        } else if ((req_perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
+        } else if ((acc_perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
             break;                /* Dirty bit not set */
         } else if (pass == G_STAGE && !(pte & PTE_U)) {
             /*
@@ -587,13 +593,22 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         }
     } while (1);
 
+page_fault:
     /*
      * riscv_iommu_translate() will receive a fault and then call
-     * riscv_iommu_report_fault() using iotlb->translated_addr
-     * as iotval2.  Update translated_addr it with the latest
-     * translated addr we have.
+     * riscv_iommu_report_fault() using fault_iotval2 as iotval2.
+     * Update fault_iotval2 with the latest translated address.
+     * For guest-page faults, set the implicit first-stage
+     * page-table access flag in the low bit.
      */
-    iotlb->translated_addr = addr;
+    *fault_iotval2 = addr;
+
+    if (pass == G_STAGE) {
+        bool implicit_read =
+            en_s && sc[S_STAGE].step != sc[S_STAGE].levels;
+        *fault_iotval2 = (addr & ~3ULL) |
+                         (implicit_read ? 1 : 0);
+    }
 
     return (req_perm & IOMMU_WO) ?
                 (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
@@ -1740,6 +1755,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     bool enable_pri;
     hwaddr phys = 0;
     int fault;
+    uint64_t fault_iotval2 = 0;
 
     riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
 
@@ -1776,7 +1792,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_TLB_MISS);
 
     /* Translate using device directory / page table information. */
-    fault = riscv_iommu_spa_fetch(s, ctx, iotlb);
+    fault = riscv_iommu_spa_fetch(s, ctx, iotlb, &fault_iotval2);
 
     if (!fault && iotlb->target_as == &s->trap_as) {
         /* Do not cache trapped MSI translations */
@@ -1827,7 +1843,7 @@ done:
         }
 
         riscv_iommu_report_fault(s, ctx, ttype, fault, enable_pid,
-                                 iotlb->iova, iotlb->translated_addr);
+                                 iotlb->iova, fault_iotval2);
         return fault;
     }
 
-- 
2.53.0


