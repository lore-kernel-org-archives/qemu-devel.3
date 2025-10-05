Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9044DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 17:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5SgJ-0000Mf-Vi; Sun, 05 Oct 2025 13:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5SgI-0000MP-BA; Sun, 05 Oct 2025 13:37:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5SgG-0004dA-CN; Sun, 05 Oct 2025 13:37:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B6C2915AA8C;
 Sun, 05 Oct 2025 20:37:22 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 257CA299738;
 Sun,  5 Oct 2025 20:37:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>,
 Sebastien Boeuf <seb@rivosinc.com>, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>, Nutty Liu <liujingqi@lanxincomputing.com>,
 Chen Pei <cp0613@linux.alibaba.com>,
 =?UTF-8?q?Fangyu=20Yu=C2=A0?= <fangyu.yu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 49/58] hw/riscv/riscv-iommu: Fixup PDT Nested Walk
Date: Sun,  5 Oct 2025 20:36:58 +0300
Message-ID: <20251005173712.445160-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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
Tested-by: Chen Pei <cp0613@linux.alibaba.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Message-ID: <20250913041233.972870-1-guoren@kernel.org>
[ Changes by AF:
 - Add braces to if statements
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 15abfced803929f935bb59a0e1b02558bd8325c4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index a4f62c89e2..92ba45bed7 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -868,6 +868,145 @@ static bool riscv_iommu_validate_process_ctx(RISCVIOMMUState *s,
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
+    if (gatp_mode == RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
+        goto out;
+    }
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
+        if (ret != MEMTX_OK) {
+            return ret;
+        }
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
@@ -1040,7 +1179,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
          */
         const int split = depth * 9 + 8;
         addr |= ((ctx->process_id >> split) << 3) & ~TARGET_PAGE_MASK;
-        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
+        if (pdt_memory_read(s, ctx, addr, &de, sizeof(de),
                             MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
             return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
         }
@@ -1055,7 +1194,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
 
     /* Leaf entry in PDT */
     addr |= (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
-    if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2,
+    if (pdt_memory_read(s, ctx, addr, &dc.ta, sizeof(uint64_t) * 2,
                         MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
         return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
     }
-- 
2.47.3


