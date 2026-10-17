Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3120ACCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB0Y-0005eW-MS; Sat, 17 Oct 2026 16:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIAzt-00058T-Ka; Sat, 17 Oct 2026 16:27:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIAzr-0003tg-Nr; Sat, 17 Oct 2026 16:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268825; bh=6pXOt0ia7QAaC5wLDLqH+RhiMCf7zr9Wk6BH3Uo71gs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lR0zW1SqBua99XtpYgL9wFloQi3nr8rtlqTpFrt2G3VbCZyt7S5r+SsLCYFAeFn7a
 IM3g3pRKgriBPSB6wT6jzDyVTKS/oVt2AXU5Hct1CrGwpbeU//FcMCmSaS4Nc/ouBg
 RBDilIbNJkd7eWi+pioVGsgq5njPxskHik3fJMulEQLUkF2NwoJIQzDoxjkhOTyt51
 6u7sntbwfxjuwHUZGNMAwatCG3tngycjVDyonb32jnsbiyqU+uE8f4keKRO1AUaZfE
 SL2vhaTLDc6fVgc6DgqWeJKx6Fz+LJNEdlM2Xhq4DH3V3b4hzyDZL4VLM5laoMh9Ry
 NhNGjS9YtDcjg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D62311DE73F;
 Sat, 17 Oct 2026 23:27:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id F3342443416;
 Sat, 17 Oct 2026 23:27:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 04/73] hw/usb/hcd-xhci: Limit DMA transfers to plain
 memory
Date: Sat, 17 Oct 2026 23:25:22 +0300
Message-ID: <20261017202638.728621-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

XHCI is a complex controller, involving lots of descriptors that
are written and read via DMA transfers. As some recent bugs like
https://gitlab.com/qemu-project/qemu/-/work_items/3926 revealed,
this can sometimes be exploited from the guest side to crash or
stall QEMU.

The code currently does DMA writes with the MEMTXATTRS_UNSPECIFIED
attribute, i.e. the controller is allowed to write to other MMIO
regions, too. However, in normal operation, this should not be
necessary, all descriptors should reside in normal memory. So let's
decrease the attack surface a little bit and limit the DMA writes
to normal memory here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260915123242.549150-1-thuth@redhat.com>
(cherry picked from commit 89e653b77369ad2d3e579139b1fa2567daa86a79)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 624ce4ee75..376bc00264 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -518,6 +518,7 @@ static inline void xhci_dma_write_u32s(XHCIState *xhci, dma_addr_t addr,
     int i;
     uint32_t tmp[5];
     uint32_t n = len / sizeof(uint32_t);
+    const MemTxAttrs memtx_attrs = { .memory = true };
 
     assert((len % sizeof(uint32_t)) == 0);
     assert(n <= ARRAY_SIZE(tmp));
@@ -525,8 +526,7 @@ static inline void xhci_dma_write_u32s(XHCIState *xhci, dma_addr_t addr,
     for (i = 0; i < n; i++) {
         tmp[i] = cpu_to_le32(buf[i]);
     }
-    if (dma_memory_write(xhci->as, addr, tmp, len,
-                         MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
+    if (dma_memory_write(xhci->as, addr, tmp, len, memtx_attrs) != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: DMA memory access failed!\n",
                       __func__);
         xhci_die(xhci);
@@ -613,6 +613,7 @@ static void xhci_write_event(XHCIState *xhci, XHCIEvent *event, int v)
     XHCIInterrupter *intr = &xhci->intr[v];
     XHCITRB ev_trb;
     dma_addr_t addr;
+    const MemTxAttrs memtx_attrs = { .memory = true };
 
     ev_trb.parameter = cpu_to_le64(event->ptr);
     ev_trb.status = cpu_to_le32(event->length | (event->ccode << 24));
@@ -629,7 +630,7 @@ static void xhci_write_event(XHCIState *xhci, XHCIEvent *event, int v)
 
     addr = intr->er_start + TRB_SIZE*intr->er_ep_idx;
     if (dma_memory_write(xhci->as, addr, &ev_trb, TRB_SIZE,
-                         MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
+                         memtx_attrs) != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: DMA memory access failed!\n",
                       __func__);
         xhci_die(xhci);
@@ -2440,6 +2441,7 @@ static void xhci_detach_slot(XHCIState *xhci, USBPort *uport)
 static TRBCCode xhci_get_port_bandwidth(XHCIState *xhci, uint64_t pctx)
 {
     dma_addr_t ctx;
+    const MemTxAttrs memtx_attrs = { .memory = true };
 
     DPRINTF("xhci_get_port_bandwidth()\n");
 
@@ -2448,9 +2450,9 @@ static TRBCCode xhci_get_port_bandwidth(XHCIState *xhci, uint64_t pctx)
     DPRINTF("xhci: bandwidth context at "DMA_ADDR_FMT"\n", ctx);
 
     /* TODO: actually implement real values here. This is 80% for all ports. */
-    if (stb_dma(xhci->as, ctx, 0, MEMTXATTRS_UNSPECIFIED) != MEMTX_OK ||
+    if (stb_dma(xhci->as, ctx, 0, memtx_attrs) != MEMTX_OK ||
         dma_memory_set(xhci->as, ctx + 1, 80, xhci->numports,
-                       MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
+                       memtx_attrs) != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: DMA memory write failed!\n",
                       __func__);
         return CC_TRB_ERROR;
-- 
2.47.3


