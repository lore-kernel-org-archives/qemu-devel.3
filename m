Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E979CAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 04:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxHeK-0006cQ-Om; Sat, 13 Sep 2025 00:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoren@kernel.org>)
 id 1uxHeI-0006bj-EP; Sat, 13 Sep 2025 00:14:06 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoren@kernel.org>)
 id 1uxHeF-0000Kd-LB; Sat, 13 Sep 2025 00:14:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CEACC60205;
 Sat, 13 Sep 2025 04:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37039C4CEF7;
 Sat, 13 Sep 2025 04:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757736832;
 bh=yI/wNKoKkiHhntq9dZLbgPTDK0G9sGYrWumBMXKUjQU=;
 h=From:To:Cc:Subject:Date:From;
 b=WuwmmhK+io3Nyq50EfdI+HY8M4n7n2HwX7iEezxiEwZYFXNvU1FBsgpkbWKSg//TD
 Pa2BRAPA1nAm7iUAalY8t2kyq2tDUE/LL5g1mbMr52LpDRlobwniMNZZzR6kw9Fx8v
 L6BsxvpHDZMtLJOSxc/DrKgMFaamOR5aBTfoBi7K78nKZdDS5Pa6GspxppXjQ5XVwc
 xrX1Y8dHMM7xb8zztYmzJe5bFTq1MsZv8U1G6HemOLbjgwl2xaBT7XpSou8OtnI+oQ
 EHUHwv+6v1juS1+T6y1bb0NyWvN7PknWzS0u697lH07gaRbRlmgU6s/7BSY3Ch8uxn
 MOOq5tsy2IhJg==
From: guoren@kernel.org
To: zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com,
 alistair.francis@wdc.com, seb@rivosinc.com, tjeznach@rivosinc.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>,
 qemu-stable@nongnu.org, Nutty Liu <liujingqi@lanxincomputing.com>
Subject: [PATCH V3] hw/riscv/riscv-iommu: Fixup PDT Nested Walk
Date: Sat, 13 Sep 2025 00:12:33 -0400
Message-Id: <20250913041233.972870-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=guoren@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

Current implementation is wrong when iohgatp != bare. The RISC-V
IOMMU specification has defined that the PDT is based on GPA, not
SPA. So this patch fixes the problem, making PDT walk correctly
when the G-stage table walk is enabled.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Cc: qemu-stable@nongnu.org
Cc: Sebastien Boeuf <seb@rivosinc.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
Reviewed-by: Weiwei Li <liwei1518@gmail.com>
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
Changes in V3:
 - Fixup inner non-leaf walking for 4KB-align.
 - Add two Reviewed-by tags.

Changes in V2:
 - Remove nested param to make patch clearer.
---
 hw/riscv/riscv-iommu.c | 141 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 96a7fbdefcf3..ddb5236f55d1 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -866,6 +866,143 @@ static bool riscv_iommu_validate_process_ctx(RISCVIOMMUState *s,
     return true;
 }
 
+/**
+ * pdt_memory_read: PDT wrapper of dma_memory_read.
+ *
+ * @s: IOMMU Device State
+ * @ctx: Device Translation Context with devid and pasid set
+ * @addr: address within that address space
+ * @buf: buffer with the data transferred
+ * @len: length of the data transferred
+ * @attrs: memory transaction attributes
+ */
+static MemTxResult pdt_memory_read(RISCVIOMMUState *s,
+                                   RISCVIOMMUContext *ctx,
+                                   dma_addr_t addr,
+                                   void *buf, dma_addr_t len,
+                                   MemTxAttrs attrs)
+{
+    uint64_t gatp_mode, pte;
+    struct {
+        unsigned char step;
+        unsigned char levels;
+        unsigned char ptidxbits;
+        unsigned char ptesize;
+    } sc;
+    MemTxResult ret;
+    dma_addr_t base = addr;
+
+    /* G stages translation mode */
+    gatp_mode = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
+    if (gatp_mode == RISCV_IOMMU_DC_IOHGATP_MODE_BARE)
+        goto out;
+
+    /* G stages translation tables root pointer */
+    base = PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
+
+    /* Start at step 0 */
+    sc.step = 0;
+
+    if (s->fctl & RISCV_IOMMU_FCTL_GXL) {
+        /* 32bit mode for GXL == 1 */
+        switch (gatp_mode) {
+        case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:
+            if (!(s->cap & RISCV_IOMMU_CAP_SV32X4)) {
+                return MEMTX_ACCESS_ERROR;
+            }
+            sc.levels    = 2;
+            sc.ptidxbits = 10;
+            sc.ptesize   = 4;
+            break;
+        default:
+            return MEMTX_ACCESS_ERROR;
+        }
+    } else {
+        /* 64bit mode for GXL == 0 */
+        switch (gatp_mode) {
+        case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
+            if (!(s->cap & RISCV_IOMMU_CAP_SV39X4)) {
+                return MEMTX_ACCESS_ERROR;
+            }
+            sc.levels    = 3;
+            sc.ptidxbits = 9;
+            sc.ptesize   = 8;
+            break;
+        case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
+            if (!(s->cap & RISCV_IOMMU_CAP_SV48X4)) {
+                return MEMTX_ACCESS_ERROR;
+            }
+            sc.levels    = 4;
+            sc.ptidxbits = 9;
+            sc.ptesize   = 8;
+            break;
+        case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
+            if (!(s->cap & RISCV_IOMMU_CAP_SV57X4)) {
+                return MEMTX_ACCESS_ERROR;
+            }
+            sc.levels    = 5;
+            sc.ptidxbits = 9;
+            sc.ptesize   = 8;
+            break;
+        default:
+            return MEMTX_ACCESS_ERROR;
+        }
+    }
+
+    do {
+        const unsigned va_bits = (sc.step ? 0 : 2) + sc.ptidxbits;
+        const unsigned va_skip = TARGET_PAGE_BITS + sc.ptidxbits *
+                                 (sc.levels - 1 - sc.step);
+        const unsigned idx = (addr >> va_skip) & ((1 << va_bits) - 1);
+        const dma_addr_t pte_addr = base + idx * sc.ptesize;
+
+        /* Address range check before first level lookup */
+        if (!sc.step) {
+            const uint64_t va_mask = (1ULL << (va_skip + va_bits)) - 1;
+            if ((addr & va_mask) != addr) {
+                return MEMTX_ACCESS_ERROR;
+            }
+        }
+
+        /* Read page table entry */
+        if (sc.ptesize == 4) {
+            uint32_t pte32 = 0;
+            ret = ldl_le_dma(s->target_as, pte_addr, &pte32, attrs);
+            pte = pte32;
+        } else {
+            ret = ldq_le_dma(s->target_as, pte_addr, &pte, attrs);
+        }
+        if (ret != MEMTX_OK)
+            return ret;
+
+        sc.step++;
+        hwaddr ppn = pte >> PTE_PPN_SHIFT;
+
+        if (!(pte & PTE_V)) {
+            return MEMTX_ACCESS_ERROR; /* Invalid PTE */
+        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
+            base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
+        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
+            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_W */
+        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == (PTE_W | PTE_X)) {
+            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_W + PTE_X */
+        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
+            return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
+        } else {
+            /* Leaf PTE, translation completed. */
+            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
+            break;
+        }
+
+        if (sc.step == sc.levels) {
+            return MEMTX_ACCESS_ERROR; /* Can't find leaf PTE */
+        }
+    } while (1);
+
+out:
+    return dma_memory_read(s->target_as, base, buf, len, attrs);
+}
+
 /*
  * RISC-V IOMMU Device Context Loopkup - Device Directory Tree Walk
  *
@@ -1038,7 +1175,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
          */
         const int split = depth * 9 + 8;
         addr |= ((ctx->process_id >> split) << 3) & ~TARGET_PAGE_MASK;
-        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
+        if (pdt_memory_read(s, ctx, addr, &de, sizeof(de),
                             MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
             return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
         }
@@ -1053,7 +1190,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
 
     /* Leaf entry in PDT */
     addr |= (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
-    if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2,
+    if (pdt_memory_read(s, ctx, addr, &dc.ta, sizeof(uint64_t) * 2,
                         MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
         return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
     }
-- 
2.40.1


