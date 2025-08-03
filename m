Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102B4C87FCA
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 07:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiTap-0000dN-Jx; Sun, 03 Aug 2025 03:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoren@kernel.org>)
 id 1uiQdE-0000L6-DI; Sun, 03 Aug 2025 00:47:36 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoren@kernel.org>)
 id 1uiQdC-0005SG-FR; Sun, 03 Aug 2025 00:47:36 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 00F7860010;
 Sun,  3 Aug 2025 04:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F3AC4CEEB;
 Sun,  3 Aug 2025 04:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754196450;
 bh=ZBFJA+2M3hcttBaisWoJmy6ThkkTuXw2EvXWMCuGRoo=;
 h=From:To:Cc:Subject:Date:From;
 b=ioRaXyxhH3Rb3JQgRHFUycYLCp56MHY8HMAHv7ny6nV+VqHqP5ejZw+aLeADDLnNm
 7uL+3RLCBgeGBJwuPrBSfKOIeLQq59CDVFMygj0WLJWeDGDpBFGc9v6xTMXXPBGOkc
 o6SMct2qKJwLUb/JfywOLxZmWDItins5oAjsyVNy42/S0zdAaYuCh1Cwl+yCQ0NUZ+
 1x8srTwYzHF+2nWIPZsyCW9/NAidsz5sa6jxevzI+sdIeU+DV/YUN0HC06ivs4CuHj
 8prJbC7rmzLvj2josYTKqC/bzKjlzlDzrWteTKR8hTgUtRSwKB8MnQOeoVBE02QGpz
 OaEt8zd5AwqoQ==
From: guoren@kernel.org
To: zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com,
 alistair.francis@wdc.com, seb@rivosinc.com, tjeznach@rivosinc.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>,
 qemu-stable@nongnu.org
Subject: [PATCH] hw/riscv/riscv-iommu: Fixup PDT Nested Walk
Date: Sun,  3 Aug 2025 00:43:38 -0400
Message-Id: <20250803044338.4098505-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=guoren@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 03 Aug 2025 03:14:05 -0400
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
Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 hw/riscv/riscv-iommu.c | 148 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 96a7fbdefcf3..c4dccc9e5c5d 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -866,6 +866,145 @@ static bool riscv_iommu_validate_process_ctx(RISCVIOMMUState *s,
     return true;
 }
 
+/**
+ * pdt_memory_read: PDT wrapper of dma_memory_read.
+ *
+ * @s: IOMMU Device State
+ * @ctx: Device Translation Context with devid and pasid set
+ * nested: Add G-stage translation or not
+ * @addr: address within that address space
+ * @buf: buffer with the data transferred
+ * @len: length of the data transferred
+ * @attrs: memory transaction attributes
+ */
+static MemTxResult pdt_memory_read(RISCVIOMMUState *s,
+                                   RISCVIOMMUContext *ctx, bool nested,
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
+    if (!nested)
+        goto out;
+
+    /* G stages translation mode */
+    gatp_mode = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
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
+        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
+            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_W */
+        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == (PTE_W | PTE_X)) {
+            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_W + PTE_X */
+        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
+            return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
+        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
+            base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
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
@@ -884,6 +1023,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
     const size_t dc_len = sizeof(dc) >> dc_fmt;
     int depth;
     uint64_t de;
+    bool pdt_nested = false;
 
     switch (mode) {
     case RISCV_IOMMU_DDTP_MODE_OFF:
@@ -1029,6 +1169,10 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
         return RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED;
     }
 
+    /* Detect nested PDT walk */
+    pdt_nested = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD) !=
+                 RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
+
     for (depth = mode - RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8; depth-- > 0; ) {
         riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_PD_WALK);
 
@@ -1038,7 +1182,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
          */
         const int split = depth * 9 + 8;
         addr |= ((ctx->process_id >> split) << 3) & ~TARGET_PAGE_MASK;
-        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
+        if (pdt_memory_read(s, ctx, pdt_nested, addr, &de, sizeof(de),
                             MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
             return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
         }
@@ -1053,7 +1197,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
 
     /* Leaf entry in PDT */
     addr |= (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
-    if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2,
+    if (pdt_memory_read(s, ctx, pdt_nested, addr, &dc.ta, sizeof(uint64_t) * 2,
                         MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
         return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
     }
-- 
2.40.1


