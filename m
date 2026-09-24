Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA366C98317
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9fPI-0008F5-VX; Thu, 24 Sep 2026 05:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9fP8-0008Db-Kl
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9fP6-0000il-VQ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790240767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/y4tAkq6DY1jkS56knddMT7VM1YLyHbL7+VadZFxtw=;
 b=i7mKqNUK1pq3jTpBR6bBi7F3lwISIyPpRqxV0N0kEtQG02SRmCfKqjFeRZsXD4VT9vizdL
 IGF/Vefc7tRIbem5PPNq+QJ+zRX1A9N5YhA4UgcL/Iy0T41+dmk3KaUulZcm+NHnATnCHH
 oXGC+a78Sjcg9guOKXVEgHhUqsRhcBo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-noaHclC8PpKPdDTBZbE4Jg-1; Thu,
 24 Sep 2026 05:06:04 -0400
X-MC-Unique: noaHclC8PpKPdDTBZbE4Jg-1
X-Mimecast-MFC-AGG-ID: noaHclC8PpKPdDTBZbE4Jg_1790240763
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7ACC91944EB7; Thu, 24 Sep 2026 09:06:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE5A5195604C; Thu, 24 Sep 2026 09:06:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/7] hw/usb/hcd-xhci: Limit DMA transfers to plain memory
Date: Thu, 24 Sep 2026 11:05:53 +0200
Message-ID: <20260924090558.801845-3-thuth@redhat.com>
In-Reply-To: <20260924090558.801845-1-thuth@redhat.com>
References: <20260924090558.801845-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/usb/hcd-xhci.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 12f8ffece0f..0ebf7a638a1 100644
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
@@ -2453,6 +2454,7 @@ static void xhci_detach_slot(XHCIState *xhci, USBPort *uport)
 static TRBCCode xhci_get_port_bandwidth(XHCIState *xhci, uint64_t pctx)
 {
     dma_addr_t ctx;
+    const MemTxAttrs memtx_attrs = { .memory = true };
 
     DPRINTF("xhci_get_port_bandwidth()\n");
 
@@ -2461,9 +2463,9 @@ static TRBCCode xhci_get_port_bandwidth(XHCIState *xhci, uint64_t pctx)
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
2.55.0


