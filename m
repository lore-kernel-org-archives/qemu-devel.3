Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEC0CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 14:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3awG-0005Na-8c; Tue, 30 Sep 2025 10:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangyu.yu@linux.alibaba.com>)
 id 1v3a7H-0005SM-V9; Tue, 30 Sep 2025 09:10:05 -0400
Received: from [115.124.30.118] (helo=out30-118.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangyu.yu@linux.alibaba.com>)
 id 1v3a7B-0001nR-95; Tue, 30 Sep 2025 09:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1759237771; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 bh=BywjRjbTi2+324yl5WcDORCYjq+NxPQ5bGc+JBMtF64=;
 b=I4MSGY/LX4mbKaTVfaAVgOqGUYQMdUeRwmdWOaOzfhSn0Je934fD2Lu9eOtsFhnGb2NXmGfDUqUUgGhddW0lLnuCe5ESVGJiZ+7sZj3zu3+caXDxWUiWhwd64FhDOKdlkqtq5m98fhFe6O47rFD7rVp5lq/xFLD80MeoU0iu7Iw=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com
 fp:SMTPD_---0WpBU8QX_1759237447 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 30 Sep 2025 21:04:09 +0800
From: fangyu.yu@linux.alibaba.com
To: guoren@kernel.org
Cc: alistair.francis@wdc.com, liujingqi@lanxincomputing.com,
 liwei1518@gmail.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 qemu-stable@nongnu.org, seb@rivosinc.com, tjeznach@rivosinc.com,
 zhiwei_liu@linux.alibaba.com,
 =?UTF-8?q?Fangyu=20Yu=C2=A0?= <fangyu.yu@linux.alibaba.com>
Subject: Re: [PATCH V3] hw/riscv/riscv-iommu: Fixup PDT Nested Walk 
Date: Tue, 30 Sep 2025 21:04:03 +0800
Message-Id: <20250930130403.13349-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250913041233.972870-1-guoren@kernel.org>
References: <20250913041233.972870-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.118 (deferred)
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=fangyu.yu@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Sep 2025 10:02:35 -0400
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

>From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
>Current implementation is wrong when iohgatp != bare. The RISC-V
>IOMMU specification has defined that the PDT is based on GPA, not
>SPA. So this patch fixes the problem, making PDT walk correctly
>when the G-stage table walk is enabled.
>
>Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
>Cc: qemu-stable@nongnu.org
>Cc: Sebastien Boeuf <seb@rivosinc.com>
>Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
>Reviewed-by: Weiwei Li <liwei1518@gmail.com>
>Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
>Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
>---
>Changes in V3:
> - Fixup inner non-leaf walking for 4KB-align.
> - Add two Reviewed-by tags.
>
>Changes in V2:
> - Remove nested param to make patch clearer.
>---
> hw/riscv/riscv-iommu.c | 141 ++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 139 insertions(+), 2 deletions(-)
>
>diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>index 96a7fbdefcf3..ddb5236f55d1 100644
>--- a/hw/riscv/riscv-iommu.c
>+++ b/hw/riscv/riscv-iommu.c
>@@ -866,6 +866,143 @@ static bool riscv_iommu_validate_process_ctx(RISCVIOMMUState *s,
>     return true;
> }
> 
>+/**
>+ * pdt_memory_read: PDT wrapper of dma_memory_read.
>+ *
>+ * @s: IOMMU Device State
>+ * @ctx: Device Translation Context with devid and pasid set
>+ * @addr: address within that address space
>+ * @buf: buffer with the data transferred
>+ * @len: length of the data transferred
>+ * @attrs: memory transaction attributes
>+ */
>+static MemTxResult pdt_memory_read(RISCVIOMMUState *s,
>+                                   RISCVIOMMUContext *ctx,
>+                                   dma_addr_t addr,
>+                                   void *buf, dma_addr_t len,
>+                                   MemTxAttrs attrs)
>+{
>+    uint64_t gatp_mode, pte;
>+    struct {
>+        unsigned char step;
>+        unsigned char levels;
>+        unsigned char ptidxbits;
>+        unsigned char ptesize;
>+    } sc;
>+    MemTxResult ret;
>+    dma_addr_t base = addr;
>+
>+    /* G stages translation mode */
>+    gatp_mode = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
>+    if (gatp_mode == RISCV_IOMMU_DC_IOHGATP_MODE_BARE)
>+        goto out;
>+
>+    /* G stages translation tables root pointer */
>+    base = PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
>+
>+    /* Start at step 0 */
>+    sc.step = 0;
>+
>+    if (s->fctl & RISCV_IOMMU_FCTL_GXL) {
>+        /* 32bit mode for GXL == 1 */
>+        switch (gatp_mode) {
>+        case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:
>+            if (!(s->cap & RISCV_IOMMU_CAP_SV32X4)) {
>+                return MEMTX_ACCESS_ERROR;
>+            }
>+            sc.levels    = 2;
>+            sc.ptidxbits = 10;
>+            sc.ptesize   = 4;
>+            break;
>+        default:
>+            return MEMTX_ACCESS_ERROR;
>+        }
>+    } else {
>+        /* 64bit mode for GXL == 0 */
>+        switch (gatp_mode) {
>+        case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
>+            if (!(s->cap & RISCV_IOMMU_CAP_SV39X4)) {
>+                return MEMTX_ACCESS_ERROR;
>+            }
>+            sc.levels    = 3;
>+            sc.ptidxbits = 9;
>+            sc.ptesize   = 8;
>+            break;
>+        case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
>+            if (!(s->cap & RISCV_IOMMU_CAP_SV48X4)) {
>+                return MEMTX_ACCESS_ERROR;
>+            }
>+            sc.levels    = 4;
>+            sc.ptidxbits = 9;
>+            sc.ptesize   = 8;
>+            break;
>+        case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
>+            if (!(s->cap & RISCV_IOMMU_CAP_SV57X4)) {
>+                return MEMTX_ACCESS_ERROR;
>+            }
>+            sc.levels    = 5;
>+            sc.ptidxbits = 9;
>+            sc.ptesize   = 8;
>+            break;
>+        default:
>+            return MEMTX_ACCESS_ERROR;
>+        }
>+    }
>+
>+    do {
>+        const unsigned va_bits = (sc.step ? 0 : 2) + sc.ptidxbits;
>+        const unsigned va_skip = TARGET_PAGE_BITS + sc.ptidxbits *
>+                                 (sc.levels - 1 - sc.step);
>+        const unsigned idx = (addr >> va_skip) & ((1 << va_bits) - 1);
>+        const dma_addr_t pte_addr = base + idx * sc.ptesize;
>+
>+        /* Address range check before first level lookup */
>+        if (!sc.step) {
>+            const uint64_t va_mask = (1ULL << (va_skip + va_bits)) - 1;
>+            if ((addr & va_mask) != addr) {
>+                return MEMTX_ACCESS_ERROR;
>+            }
>+        }
>+
>+        /* Read page table entry */
>+        if (sc.ptesize == 4) {
>+            uint32_t pte32 = 0;
>+            ret = ldl_le_dma(s->target_as, pte_addr, &pte32, attrs);
>+            pte = pte32;
>+        } else {
>+            ret = ldq_le_dma(s->target_as, pte_addr, &pte, attrs);
>+        }
>+        if (ret != MEMTX_OK)
>+            return ret;
>+
>+        sc.step++;
>+        hwaddr ppn = pte >> PTE_PPN_SHIFT;
>+
>+        if (!(pte & PTE_V)) {
>+            return MEMTX_ACCESS_ERROR; /* Invalid PTE */
>+        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
>+            base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
>+        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
>+            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_W */
>+        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == (PTE_W | PTE_X)) {
>+            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_W + PTE_X */
>+        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
>+            return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
>+        } else {
>+            /* Leaf PTE, translation completed. */
>+            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
>+            break;
>+        }
>+
>+        if (sc.step == sc.levels) {
>+            return MEMTX_ACCESS_ERROR; /* Can't find leaf PTE */
>+        }
>+    } while (1);
>+
>+out:
>+    return dma_memory_read(s->target_as, base, buf, len, attrs);
>+}
>+
> /*
>  * RISC-V IOMMU Device Context Loopkup - Device Directory Tree Walk
>  *
>@@ -1038,7 +1175,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
>          */
>         const int split = depth * 9 + 8;
>         addr |= ((ctx->process_id >> split) << 3) & ~TARGET_PAGE_MASK;
>-        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
>+        if (pdt_memory_read(s, ctx, addr, &de, sizeof(de),
>                             MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
>             return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
>         }
>@@ -1053,7 +1190,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
> 
>     /* Leaf entry in PDT */
>     addr |= (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
>-    if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2,
>+    if (pdt_memory_read(s, ctx, addr, &dc.ta, sizeof(uint64_t) * 2,
>                         MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
>         return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
>     }
>-- 
>2.40.1

Enabled PDT in the VM and test this patch works correctly.

Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Thanks,
Fangyu

