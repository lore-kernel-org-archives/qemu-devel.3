Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D08606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dtcnotwY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqA6-0003Xg-13; Thu, 22 Oct 2026 06:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqA4-0003X9-JR
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqA2-0007lg-M5
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792665398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pux0hQpGS9B3kP/CPRGMWK7hx46SCUyi/4+fSolikcQ=;
 b=dtcnotwYhSNvE350+VDVkhE3tzBnUbugMFeTOW/eDVsP02eVRh/GvfOWU6KX3CbZ2bYvA5
 4qUY6p9V5w3XXJ9mBLfSHebyKQFrfBW6BpCgV75uk80jD5uptS5C/pEGcJEOjchpCOplFF
 N55+RZTpomgQCT4fN08gIsN3N8vx2Go=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-W_G73-p6OOCzTtAuY3phYA-1; Thu,
 22 Oct 2026 10:36:34 +0000
X-MC-Unique: W_G73-p6OOCzTtAuY3phYA-1
X-Mimecast-MFC-AGG-ID: W_G73-p6OOCzTtAuY3phYA_1792665393
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C9E7195606D; Thu, 22 Oct 2026 10:36:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF9AD30000E7; Thu, 22 Oct 2026 10:36:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-stable@nongnu.org
Subject: [PULL 02/11] hw/usb/hcd-ohci: Fail iso packets sent to non-iso
 endpoints and vice-versa
Date: Thu, 22 Oct 2026 12:36:13 +0200
Message-ID: <20261022103622.1151089-3-thuth@redhat.com>
In-Reply-To: <20261022103622.1151089-1-thuth@redhat.com>
References: <20261022103622.1151089-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The OHCI USB controller requires software to set up an Endpoint
Descriptor data structure.  This specifies (among other things) both
an EndpointNumber telling the controller which USB endpoint to talk
to, and a Format (F) bit which is 1 for Isochronous transfers and 0
for General transfers.

The specification requires that software matches the F bit with the
endpoint it's setting up the descriptor for, so that Control, Bulk
and Interrupt endpoints use F=0, and Isochronous endpoints use F=1.
It doesn't require the controller to check whether software gets this
right.

The spec isn't totally clear about what happens if software creates
an ED with a mismatch, but I believe that the controller just trusts
the F bit, and tries to talk to the endpoint with the wrong sequence
of USB tokens (notably, isochronous transactions have no handshaking
and the others do). This probably results in the transfer failing.

In hcd-ehci.c we check for the "iso transfer to non-iso endpoint" and
make it fail, but we don't do this in hcd-ohci.c.  The result is that
a guest that deliberately sets up this situation can cause us to hit
the assertion added in commit 7b1eba96aeca, where the endpoint is not
isochronous and returns USB_RET_ASYNC to an iso TD handling function
that isn't prepared to deal with that.

Add checks for both "iso transfer to non-iso endpoint" and "non-iso
transfer to iso endpoint" and make those TDs fail rather than blindly
sending them to the endpoint.

Cc: qemu-stable@nongnu.org
CVE: CVE-2026-7180 (together with 7b1eba96aecac32d186d4c16b81c7b4681186844)
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3729
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261001194756.3003085-1-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/hcd-ohci.c   | 67 +++++++++++++++++++++++++++------------------
 hw/usb/trace-events |  2 ++
 2 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 5e5fe41f473..4d38150a845 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -579,7 +579,6 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
     int i;
     USBDevice *dev;
     USBEndpoint *ep;
-    USBPacket *pkt;
     QEMU_UNINITIALIZED uint8_t buf[8192];
     bool int_req;
     struct ohci_iso_td iso_td;
@@ -742,24 +741,31 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
         return 1;
     }
     ep = usb_ep_get(dev, pid, OHCI_BM(ed->flags, ED_EN));
-    pkt = g_new0(USBPacket, 1);
-    usb_packet_init(pkt);
-    int_req = relative_frame_number == frame_count &&
-              OHCI_BM(iso_td.flags, TD_DI) == 0;
-    usb_packet_setup(pkt, pid, ep, 0, addr, false, int_req);
-    usb_packet_addbuf(pkt, buf, len);
-    usb_handle_packet(dev, pkt);
-
-    /* The USB core guarantees to never defer ISO TDs. */
-    assert(pkt->status != USB_RET_ASYNC);
-
-    if (pkt->status == USB_RET_SUCCESS) {
-        ret = pkt->actual_length;
+    if (ep->type == USB_ENDPOINT_XFER_ISOC) {
+        USBPacket *pkt = g_new0(USBPacket, 1);
+
+        usb_packet_init(pkt);
+        int_req = relative_frame_number == frame_count &&
+            OHCI_BM(iso_td.flags, TD_DI) == 0;
+        usb_packet_setup(pkt, pid, ep, 0, addr, false, int_req);
+        usb_packet_addbuf(pkt, buf, len);
+        usb_handle_packet(dev, pkt);
+
+        /* The USB core guarantees to never defer ISO TDs. */
+        assert(pkt->status != USB_RET_ASYNC);
+
+        if (pkt->status == USB_RET_SUCCESS) {
+            ret = pkt->actual_length;
+        } else {
+            ret = pkt->status;
+        }
+        usb_packet_cleanup(pkt);
+        g_free(pkt);
     } else {
-        ret = pkt->status;
+        /* Attempted iso transfer to non-iso endpoint */
+        ret = USB_RET_NAK;
+        trace_usb_ohci_iso_td_to_non_iso_endpoint(ep->nr);
     }
-    usb_packet_cleanup(pkt);
-    g_free(pkt);
 
     trace_usb_ohci_iso_td_so(start_offset, end_offset, start_addr, end_addr,
                              str, len, ret);
@@ -1022,16 +1028,23 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
             trace_usb_ohci_td_too_many_pending(ep->nr);
             return 1;
         }
-        usb_packet_setup(&ohci->usb_packet, pid, ep, 0, addr, !flag_r,
-                         OHCI_BM(td.flags, TD_DI) == 0);
-        usb_packet_addbuf(&ohci->usb_packet, ohci->usb_buf, pktlen);
-        usb_handle_packet(dev, &ohci->usb_packet);
-        trace_usb_ohci_td_packet_status(ohci->usb_packet.status);
-
-        if (ohci->usb_packet.status == USB_RET_ASYNC) {
-            usb_device_flush_ep_queue(dev, ep);
-            ohci->async_td = addr;
-            return 1;
+        if (ep->type != USB_ENDPOINT_XFER_ISOC) {
+            usb_packet_setup(&ohci->usb_packet, pid, ep, 0, addr, !flag_r,
+                             OHCI_BM(td.flags, TD_DI) == 0);
+            usb_packet_addbuf(&ohci->usb_packet, ohci->usb_buf, pktlen);
+            usb_handle_packet(dev, &ohci->usb_packet);
+            trace_usb_ohci_td_packet_status(ohci->usb_packet.status);
+
+            if (ohci->usb_packet.status == USB_RET_ASYNC) {
+                usb_device_flush_ep_queue(dev, ep);
+                ohci->async_td = addr;
+                return 1;
+            }
+        } else {
+            /* Attempted non-iso transfer to iso endpoint */
+            ohci->usb_packet.status = USB_RET_NAK;
+            ohci->usb_packet.actual_length = 0;
+            trace_usb_ohci_td_to_iso_endpoint(ep->nr);
         }
     }
     if (ohci->usb_packet.status == USB_RET_SUCCESS) {
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 80ead23358f..15f2d27dbfd 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -23,6 +23,7 @@ usb_ohci_iso_td_bad_direction(int dir) "Bad direction %d"
 usb_ohci_iso_td_bad_bp_be(uint32_t bp, uint32_t be) "ISO_TD bp 0x%.8x be 0x%.8x"
 usb_ohci_iso_td_bad_cc_not_accessed(uint32_t start, uint32_t next) "ISO_TD cc != not accessed 0x%.8x 0x%.8x"
 usb_ohci_iso_td_bad_cc_overrun(uint32_t start, uint32_t next) "ISO_TD start_offset=0x%.8x > next_offset=0x%.8x"
+usb_ohci_iso_td_to_non_iso_endpoint(int ep) "ep=%d"
 usb_ohci_iso_td_so(uint32_t so, uint32_t eo, uint32_t s, uint32_t e, const char *str, ssize_t len, int ret) "0x%.8x eo 0x%.8x sa 0x%.8x ea 0x%.8x dir %s len %zu ret %d"
 usb_ohci_iso_td_data_overrun(int ret, ssize_t len) "DataOverrun %d > %zu"
 usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
@@ -55,6 +56,7 @@ usb_ohci_td_pkt_short(const char *dir, const char *buf) "%s data: %s"
 usb_ohci_td_pkt_full(const char *dir, const char *buf) "%s data: %s"
 usb_ohci_td_too_many_pending(int ep) "ep=%d"
 usb_ohci_td_packet_status(int status) "status=%d"
+usb_ohci_td_to_iso_endpoint(int ep) "ep=%d"
 usb_ohci_ed_read_error(uint32_t addr) "ED read error at 0x%x"
 usb_ohci_ed_pkt(uint32_t cur, int h, int c, uint32_t head, uint32_t tail, uint32_t next) "ED @ 0x%.8x h=%u c=%u head=0x%.8x tailp=0x%.8x next=0x%.8x"
 usb_ohci_ed_pkt_flags(uint32_t fa, uint32_t en, uint32_t d, int s, int k, int f, uint32_t mps) "fa=%u en=%u d=%u s=%u k=%u f=%u mps=%u"
-- 
2.56.0


