Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A063CC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiliq-0006eD-JY; Sun, 12 Jul 2026 00:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilia-0006PH-Q9; Sun, 12 Jul 2026 00:23:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiliY-0007NW-Q6; Sun, 12 Jul 2026 00:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829782; bh=DWSw3n0zgUiKquuD73IAyqoUNmyQ/BCsCpXWdxx/d0g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=p8qg/kfmoVuP7ia6HyKRs7NiyBJw4JIqVKMQ5uXdkkcr1WKlSIkI0wWzT1gJ1Ybv6
 XnJ8giNRTeXTRu5sOynMdRSPZNP/tG3HUgdUIX9bIoG2OdG87BrJVXN6pS43lHKxjr
 xjYlrB8RFU90CftzyhdykwItr14EDTbEGnUoiQdeFt6GuWdBlLmPoFsVt+uB1EK7OL
 wUzeOzU18C0TultKfVLdESiPMXauZkiL+MDDqN7PfXx3SFa21jwy75gJwAtGKm7nF/
 9Ptou0tSQtjwvEnjydSBhdp9kzpCPwqZ1Z2QS0G+L/ktEjLKSIuVGcAOVzy8RPL6vO
 hnRY5SPFWXPGw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 632A11C0C21;
 Sun, 12 Jul 2026 07:16:22 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 963BA3EB981;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BC1A613445; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 70/75] hw/riscv/riscv-iommu.c: set ftype and iova in
 riscv_iommu_ctx()
Date: Sun, 12 Jul 2026 07:15:28 +0300
Message-ID: <20260712041539.108341-70-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We're hardcoding faulting type as READ, where it could very well be a
write access, and we're not recording the faulting addr/iova.

A note was added in the fault_type logic because I wasn't able to
trivially handle a probable code repeitition it in this same patch.
Something to do in a later date.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3564
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260701092241.307801-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit ce7fb3282756c04433274e3abcd59407f77c4923)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index f11698f02f0..4ba4164df41 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1396,6 +1396,7 @@ static void riscv_iommu_ctx_inval(RISCVIOMMUState *s, GHFunc func,
 /* Find or allocate translation context for a given {device_id, process_id} */
 static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
                                           unsigned devid, unsigned process_id,
+                                          IOMMUAccessFlags perm, uint64_t iova,
                                           void **ref)
 {
     GHashTable *ctx_cache;
@@ -1405,6 +1406,7 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
         .process_id = process_id,
     };
     unsigned mode = get_field(s->ddtp, RISCV_IOMMU_DDTP_MODE);
+    uint32_t fault_type;
 
     ctx_cache = g_hash_table_ref(s->ctx_cache);
 
@@ -1440,8 +1442,21 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
     g_hash_table_unref(ctx_cache);
     *ref = NULL;
 
-    riscv_iommu_report_fault(s, ctx, RISCV_IOMMU_FQ_TTYPE_UADDR_RD,
-                             fault, !!process_id, 0, 0);
+    /*
+     * TODO: (1) do we need to distinguish other fault types
+     * for ctx fetching and (2) evaluate putting the 'fault_type'
+     * logic inside riscv_iommu_report_fault() - there's at
+     * least one other place (end of riscv_iommu_translate())
+     * that does something similar.
+     */
+    if (perm & IOMMU_RO) {
+        fault_type = RISCV_IOMMU_FQ_TTYPE_UADDR_RD;
+    } else {
+        fault_type = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
+    }
+
+    riscv_iommu_report_fault(s, ctx, fault_type, fault,
+                             !!process_id, iova, 0);
 
     g_free(ctx);
     return NULL;
@@ -2172,6 +2187,8 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
     uint64_t ctrl = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_TR_REQ_CTL);
     unsigned devid = get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_DID);
     unsigned pid = get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_PID);
+    IOMMUAccessFlags perm = ctrl & RISCV_IOMMU_TR_REQ_CTL_NW
+                            ? IOMMU_RO : IOMMU_RW;
     RISCVIOMMUContext *ctx;
     void *ref;
 
@@ -2179,7 +2196,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
         return;
     }
 
-    ctx = riscv_iommu_ctx(s, devid, pid, &ref);
+    ctx = riscv_iommu_ctx(s, devid, pid, perm, iova, &ref);
     if (ctx == NULL) {
         riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE,
                                  RISCV_IOMMU_TR_RESPONSE_FAULT |
@@ -2187,7 +2204,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
     } else {
         IOMMUTLBEntry iotlb = {
             .iova = iova,
-            .perm = ctrl & RISCV_IOMMU_TR_REQ_CTL_NW ? IOMMU_RO : IOMMU_RW,
+            .perm = perm,
             .addr_mask = ~0,
             .target_as = NULL,
         };
@@ -2526,7 +2543,7 @@ static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
     /* FIXME: PCIe bus remapping for attached endpoints. */
     devid |= s->bus << 8;
 
-    ctx = riscv_iommu_ctx(s, devid, 0, &ref);
+    ctx = riscv_iommu_ctx(s, devid, 0, IOMMU_RW, addr, &ref);
     if (ctx == NULL) {
         res = MEMTX_ACCESS_ERROR;
     } else {
@@ -2816,7 +2833,7 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
     };
     uint32_t devid = riscv_iommu_space_devid(as);
 
-    ctx = riscv_iommu_ctx(as->iommu, devid, iommu_idx, &ref);
+    ctx = riscv_iommu_ctx(as->iommu, devid, iommu_idx, flag, addr, &ref);
     if (ctx == NULL) {
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
-- 
2.47.3


