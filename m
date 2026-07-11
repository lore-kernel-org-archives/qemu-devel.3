Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E393C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifqp-0006oG-RY; Sat, 11 Jul 2026 18:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifqn-0006X8-F8; Sat, 11 Jul 2026 18:07:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifql-00010J-Ej; Sat, 11 Jul 2026 18:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=4dLu/r8GpVdt+cZ1WsuOpEFEiVzdkP6eZ5sgruH3cMc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jc+n41ga9Q0j1/eNyeTgLyBaQmjfR3Bu70duAWev3s3vZzO1X84S/JKaKnnFjQzUz
 EGz8tb68JSjLDHqc7vhBQvBq/Jg6JwvsZEuBuMTLlx9Hv4TW2kWMSmnpXkrD/V7g1U
 l3DBCZtfiK8l9WTW42NKSQ2W8BvUiDBlYMBUAEfwrOIAr1AJaa3qe7tPVr3BKy45D4
 dqFt9epdqqprJ4naxvOu3oUheqfKpA7WVNw/8xOCzGziRbbThr+5Q2GfEvWuoXgJkx
 6iM0qOvZ8m7KFQVbO6ZGgd7Nybehfb3j4aR7FqU2WPoqEgwavRxG+fGc0XTw0oy8JW
 Z19woCC8BucUw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E15011C0AD8;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 98B273EAF63;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id F29AE1337D; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 77/81] hw/riscv/riscv-iommu.c: set ftype and iova in
 riscv_iommu_ctx()
Date: Sun, 12 Jul 2026 00:58:55 +0300
Message-ID: <20260711215904.3757-77-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
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
index f1815eca663..c59e5d40e5e 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1407,6 +1407,7 @@ static void riscv_iommu_ctx_inval(RISCVIOMMUState *s, GHFunc func,
 /* Find or allocate translation context for a given {device_id, process_id} */
 static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
                                           unsigned devid, unsigned process_id,
+                                          IOMMUAccessFlags perm, uint64_t iova,
                                           void **ref)
 {
     GHashTable *ctx_cache;
@@ -1416,6 +1417,7 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
         .process_id = process_id,
     };
     unsigned mode = get_field(s->ddtp, RISCV_IOMMU_DDTP_MODE);
+    uint32_t fault_type;
 
     ctx_cache = g_hash_table_ref(s->ctx_cache);
 
@@ -1451,8 +1453,21 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
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
@@ -2183,6 +2198,8 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
     uint64_t ctrl = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_TR_REQ_CTL);
     unsigned devid = get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_DID);
     unsigned pid = get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_PID);
+    IOMMUAccessFlags perm = ctrl & RISCV_IOMMU_TR_REQ_CTL_NW
+                            ? IOMMU_RO : IOMMU_RW;
     RISCVIOMMUContext *ctx;
     void *ref;
 
@@ -2190,7 +2207,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
         return;
     }
 
-    ctx = riscv_iommu_ctx(s, devid, pid, &ref);
+    ctx = riscv_iommu_ctx(s, devid, pid, perm, iova, &ref);
     if (ctx == NULL) {
         riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE,
                                  RISCV_IOMMU_TR_RESPONSE_FAULT |
@@ -2198,7 +2215,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
     } else {
         IOMMUTLBEntry iotlb = {
             .iova = iova,
-            .perm = ctrl & RISCV_IOMMU_TR_REQ_CTL_NW ? IOMMU_RO : IOMMU_RW,
+            .perm = perm,
             .addr_mask = ~0,
             .target_as = NULL,
         };
@@ -2533,7 +2550,7 @@ static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
     /* FIXME: PCIe bus remapping for attached endpoints. */
     devid |= s->bus << 8;
 
-    ctx = riscv_iommu_ctx(s, devid, 0, &ref);
+    ctx = riscv_iommu_ctx(s, devid, 0, IOMMU_RW, addr, &ref);
     if (ctx == NULL) {
         res = MEMTX_ACCESS_ERROR;
     } else {
@@ -2834,7 +2851,7 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
     };
     uint32_t devid = riscv_iommu_space_devid(as);
 
-    ctx = riscv_iommu_ctx(as->iommu, devid, iommu_idx, &ref);
+    ctx = riscv_iommu_ctx(as->iommu, devid, iommu_idx, flag, addr, &ref);
     if (ctx == NULL) {
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
-- 
2.47.3


