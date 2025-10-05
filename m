Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAFFCCD182
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 17:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Sg0-0000Fq-NV; Sun, 05 Oct 2025 13:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sfq-0000Br-QR; Sun, 05 Oct 2025 13:37:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sfp-0004bw-5M; Sun, 05 Oct 2025 13:37:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0208E15AA86;
 Sun, 05 Oct 2025 20:37:15 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E85E9299733;
 Sun,  5 Oct 2025 20:37:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 44/58] hw/riscv/riscv-iommu: Fix MSI table size limit
Date: Sun,  5 Oct 2025 20:36:53 +0300
Message-ID: <20251005173712.445160-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Andrew Jones <ajones@ventanamicro.com>

The MSI table is not limited to 4k. The only constraint the table has
is that its base address must be aligned to its size, ensuring no
offsets of the table size will overrun when added to the base address
(see "8.5. MSI page tables" of the AIA spec).

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250904132723.614507-2-ajones@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 4f7528295b3e6dfe1189f660fa7865ad972d82e7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 76e0fcd873..a4f62c89e2 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -557,6 +557,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
     MemTxResult res;
     dma_addr_t addr;
     uint64_t intn;
+    size_t offset;
     uint32_t n190;
     uint64_t pte[2];
     int fault_type = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
@@ -564,16 +565,18 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
 
     /* Interrupt File Number */
     intn = riscv_iommu_pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
-    if (intn >= 256) {
+    offset = intn * sizeof(pte);
+
+    /* fetch MSI PTE */
+    addr = PPN_PHYS(get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_PPN));
+    if (addr & offset) {
         /* Interrupt file number out of range */
         res = MEMTX_ACCESS_ERROR;
         cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
         goto err;
     }
 
-    /* fetch MSI PTE */
-    addr = PPN_PHYS(get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_PPN));
-    addr = addr | (intn * sizeof(pte));
+    addr |= offset;
     res = dma_memory_read(s->target_as, addr, &pte, sizeof(pte),
             MEMTXATTRS_UNSPECIFIED);
     if (res != MEMTX_OK) {
-- 
2.47.3


