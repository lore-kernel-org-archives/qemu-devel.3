Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5745C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpN7-00082w-6V; Tue, 11 Aug 2026 12:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMg-0007bE-Cz
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMY-0000An-9H
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHt4pArgodBhKOAZEmTMPN6e8DNmhKFidvrTXPXzwlA=;
 b=ZxAUJdp64h0dZnp//nIaMGBbwOxebkaVzKSb7FyrMvwMNgPfHs44YD9rHT2jDVH0fd/cY7
 37thTSiTfxs1fJ0rY2FVpAppg9VLP0o9X8XVPlbZeLxDUi4Bm+9aDZHXXFfFs3zZnMbOZe
 ZX9BvxESgwuyKXuufVMsgkWBDF7tEuo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-twJv7HpsM_OuRV64dOC9Rw-1; Tue,
 11 Aug 2026 12:29:57 -0400
X-MC-Unique: twJv7HpsM_OuRV64dOC9Rw-1
X-Mimecast-MFC-AGG-ID: twJv7HpsM_OuRV64dOC9Rw_1786465796
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 723E918004BB; Tue, 11 Aug 2026 16:29:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 891B4195DF91; Tue, 11 Aug 2026 16:29:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/83] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Date: Tue, 11 Aug 2026 18:28:21 +0200
Message-ID: <20260811162938.1403216-7-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

EHCI supports 64-bit control data structure addressing when the
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,
the CTRLDSSEGMENT register supplies the upper 32 bits which are
concatenated with 32-bit link pointer fields to form full 64-bit
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).

The current implementation assumes 32-bit QH descriptor addresses
and directly uses link pointer values without applying the
CTRLDSSEGMENT upper dword.

Introduce a helper, ehci_get_desc_addr(), to construct full 64-bit
descriptor addresses when 64-bit capability is enabled. Update QH
traversal paths (async list walk, horizontal QH link, and periodic
schedule entry handling) to use the translated 64-bit addresses.

EHCI 64-bit buffer pointer fields are defined in Appendix B as
split 32-bit low/high parts located at separate offsets, rather
than a single contiguous 64-bit field. Therefore, the buffer
pointers cannot be represented as uint64_t bufptr[5] without
violating the descriptor layout defined by the specification.

Introduce ehci_get_buf_addr() to construct full 64-bit buffer
addresses from bufptr[] and bufptr_hi[] fields. Use this helper
when calculating transfer buffer addresses so that data buffers
above 4GB are correctly handled.

Also add bufptr_hi[5] to EHCIqh to support 64-bit buffer pointer
fields as defined in Appendix B.

When 64-bit capability is disabled, descriptor addresses remain
32-bit and existing behaviour is unchanged.

Note: Similar split 64-bit buffer pointer handling is required for
qTD, iTD and siTD descriptors, which will be addressed in follow-up
changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260713032704.3583103-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/usb/hcd-ehci.h   |  4 +++
 hw/usb/hcd-ehci.c   | 72 +++++++++++++++++++++++++++++++++++----------
 hw/usb/trace-events |  2 +-
 3 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index f739e6371b23..8732264fdebb 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -141,6 +141,9 @@ typedef struct EHCIqtd {
 #define QTD_BUFPTR_SH                 12
 } EHCIqtd;
 
+/* QH overlay: altnext_qtd, token, bufptr[5], bufptr_hi[5] */
+#define EHCI_QH_OVERLAY_COUNT 12
+
 /*
  * EHCI spec version 1.0 Section 3.6
  */
@@ -194,6 +197,7 @@ typedef struct EHCIqh {
 #define BUFPTR_FRAMETAG_MASK          0x0000001f
 #define BUFPTR_SBYTES_MASK            0x00000fe0
 #define BUFPTR_SBYTES_SH              5
+    uint32_t bufptr_hi[5];
 } EHCIqh;
 
 enum async_state {
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index e65ea825b021..fd5be7430ef6 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -96,6 +96,15 @@ typedef enum {
     *data = val; \
     } while (0)
 
+/*
+ * EHCIqh / EHCIqtd / EHCIitd are sized to always include the extended
+ * high buffer pointer fields from EHCI 1.0 Appendix B. When 64-bit
+ * addressing capability is not advertised to the guest, the descriptors
+ * in guest memory only have the classic 32-bit layout, so DMA transfers
+ * must not read or write past that boundary.
+ */
+#define EHCI_QH_DWORDS_32   (offsetof(EHCIqh, bufptr_hi) / sizeof(uint32_t))
+
 static const char *ehci_state_names[] = {
     [EST_INACTIVE]     = "INACTIVE",
     [EST_ACTIVE]       = "ACTIVE",
@@ -147,6 +156,28 @@ static const char *addr2str(hwaddr addr)
     return nr2str(ehci_mmio_names, ARRAY_SIZE(ehci_mmio_names), addr);
 }
 
+static uint64_t ehci_get_buf_addr(const EHCIState *s, uint32_t hi,
+                                  uint32_t lo, uint32_t lo_mask)
+{
+    uint64_t addr = lo & lo_mask;
+
+    if (s->caps_64bit_addr) {
+        addr = deposit64(addr, 32, 32, hi);
+    }
+
+    return addr;
+}
+
+static uint64_t ehci_get_desc_addr(const EHCIState *s, uint32_t lo)
+{
+    return ehci_get_buf_addr(s, s->ctrldssegment, lo, UINT32_MAX);
+}
+
+static uint32_t ehci_qh_dwords(const EHCIState *s)
+{
+    return s->caps_64bit_addr ? (sizeof(EHCIqh) >> 2) : EHCI_QH_DWORDS_32;
+}
+
 static void ehci_trace_usbsts(uint32_t mask, int state)
 {
     /* interrupts */
@@ -440,7 +471,7 @@ static bool ehci_verify_qh(EHCIQueue *q, EHCIqh *qh)
         (qh->current_qtd != q->qh.current_qtd) ||
         (q->async && qh->next_qtd != q->qh.next_qtd) ||
         (memcmp(&qh->altnext_qtd, &q->qh.altnext_qtd,
-                                 7 * sizeof(uint32_t)) != 0) ||
+                EHCI_QH_OVERLAY_COUNT * sizeof(uint32_t)) != 0) ||
         (q->dev != NULL && q->dev->addr != devaddr)) {
         return false;
     } else {
@@ -487,8 +518,9 @@ static void ehci_writeback_async_complete_packet(EHCIPacket *p)
     int state;
 
     /* Verify the qh + qtd, like we do when going through fetchqh & fetchqtd */
+    memset(&qh, 0, sizeof(qh));
     get_dwords(q->ehci, NLPTR_GET(q->qhaddr),
-               (uint32_t *) &qh, sizeof(EHCIqh) >> 2);
+               (uint32_t *) &qh, ehci_qh_dwords(q->ehci));
     get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),
                (uint32_t *) &qtd, sizeof(EHCIqtd) >> 2);
     if (!ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {
@@ -1143,7 +1175,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
 static void ehci_flush_qh(EHCIQueue *q)
 {
     uint32_t *qh = (uint32_t *) &q->qh;
-    uint32_t dwords = sizeof(EHCIqh) >> 2;
+    uint32_t dwords = ehci_qh_dwords(q->ehci);
     uint64_t addr = NLPTR_GET(q->qhaddr);
 
     put_dwords(q->ehci, addr + 3 * sizeof(uint32_t), qh + 3, dwords - 3);
@@ -1538,7 +1570,9 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
     EHCIqh qh;
     int i = 0;
     int again = 0;
-    uint64_t entry = ehci->asynclistaddr;
+    uint64_t entry = 0;
+
+    entry = ehci_get_desc_addr(ehci, ehci->asynclistaddr);
 
     /* set reclamation flag at start event (4.8.6) */
     if (async) {
@@ -1548,9 +1582,10 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
     ehci_queues_rip_unused(ehci, async);
 
     /*  Find the head of the list (4.9.1.1) */
+    memset(&qh, 0, sizeof(qh));
     for (i = 0; i < MAX_QH; i++) {
         if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &qh,
-                       sizeof(EHCIqh) >> 2) < 0) {
+                       ehci_qh_dwords(ehci)) < 0) {
             return 0;
         }
         ehci_trace_qh(NULL, NLPTR_GET(entry), &qh);
@@ -1566,8 +1601,8 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
             goto out;
         }
 
-        entry = qh.next;
-        if (entry == ehci->asynclistaddr) {
+        entry = ehci_get_desc_addr(ehci, qh.next);
+        if (entry == ehci_get_desc_addr(ehci, ehci->asynclistaddr)) {
             break;
         }
     }
@@ -1651,8 +1686,9 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
         goto out;
     }
 
+    memset(&qh, 0, sizeof(qh));
     if (get_dwords(ehci, NLPTR_GET(q->qhaddr),
-                   (uint32_t *) &qh, sizeof(EHCIqh) >> 2) < 0) {
+                   (uint32_t *) &qh, ehci_qh_dwords(ehci)) < 0) {
         q = NULL;
         goto out;
     }
@@ -1693,7 +1729,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
     }
 
     if (trace_event_get_state_backends(TRACE_USB_EHCI_FETCHQH_DBG)) {
-        if (q->qhaddr != q->qh.next) {
+        if (q->qhaddr != ehci_get_desc_addr(ehci, q->qh.next)) {
             trace_usb_ehci_fetchqh_dbg(q->qhaddr,
                                        q->qh.epchar & QH_EPCHAR_H,
                                        q->qh.token & QTD_TOKEN_HALT,
@@ -1876,10 +1912,12 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
 
 static int ehci_state_horizqh(EHCIQueue *q)
 {
+    uint64_t addr;
     int again = 0;
 
-    if (ehci_get_fetch_addr(q->ehci, q->async) != q->qh.next) {
-        ehci_set_fetch_addr(q->ehci, q->async, q->qh.next);
+    addr = ehci_get_desc_addr(q->ehci, q->qh.next);
+    if (ehci_get_fetch_addr(q->ehci, q->async) != addr) {
+        ehci_set_fetch_addr(q->ehci, q->async, addr);
         ehci_set_state(q->ehci, q->async, EST_FETCHENTRY);
         again = 1;
     } else {
@@ -2205,6 +2243,8 @@ static void ehci_advance_periodic_state(EHCIState *ehci)
     uint32_t entry;
     uint32_t list;
     const int async = 0;
+    uint64_t entry64;
+    uint64_t list64;
 
     /* 4.6 */
 
@@ -2229,12 +2269,14 @@ static void ehci_advance_periodic_state(EHCIState *ehci)
             break;
         }
         list |= ((ehci->frindex & 0x1ff8) >> 1);
-
-        if (get_dwords(ehci, list, &entry, 1) < 0) {
+        list64 = ehci_get_desc_addr(ehci, list);
+        if (get_dwords(ehci, list64, &entry, 1) < 0) {
             break;
         }
-        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8, list, entry);
-        ehci_set_fetch_addr(ehci, async, entry);
+        entry64 = ehci_get_desc_addr(ehci, entry);
+        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8,
+                                              list64, entry64);
+        ehci_set_fetch_addr(ehci, async, entry64);
         ehci_set_state(ehci, async, EST_FETCHENTRY);
         ehci_advance_state(ehci, async);
         ehci_queues_rip_unused(ehci, async);
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 8c90688bb3e7..67249d69c2f6 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -113,7 +113,7 @@ usb_ehci_dma_error(void) ""
 usb_ehci_execute_complete(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr, int status, int actual_length) "qhaddr=0x%" PRIx64 ", next=0x%x, qtdaddr=0x%" PRIx64 ", status=%d, actual_length=%d"
 usb_ehci_fetchqh_reclaim_done(uint64_t qhaddr) "QH 0x%" PRIx64 " H-bit set, reclamation status reset - done processing"
 usb_ehci_fetchqh_dbg(uint64_t qhaddr, uint32_t h, uint32_t halt, uint32_t active, uint32_t next) "QH 0x%" PRIx64 " (h 0x%x halt 0x%x active 0x%x) next 0x%08x"
-usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t entry) "frame=%d, list=0x%x, entry=0x%x"
+usb_ehci_periodic_state_advance(uint32_t frame, uint64_t list, uint64_t entry) "frame=%d, list=0x%" PRIx64 ", entry=0x%" PRIx64
 usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uframes"
 usb_ehci_log(const char *msg) "%s"
 
-- 
2.55.0


