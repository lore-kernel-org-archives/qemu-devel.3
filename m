Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE86606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=gZ+lEPB/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLB1-0005ks-B0; Mon, 26 Oct 2026 09:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLAz-0005iG-Op; Mon, 26 Oct 2026 09:55:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLAx-00009y-IC; Mon, 26 Oct 2026 09:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022903; bh=XTCvxBPlUcfUK1q3koGiS/pvHKaR891p+ah5s43T99Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gZ+lEPB/muuUGu+rFow1WRD4Rk3fqSkKA9FHCalcWz+dgD2Mqz52UHqu0QJ6l9KFq
 4MOdcgVjNoRXDi8mpnFkj7r0ngc38dbOVzY4zr5y3NmuwVkzgePwX5n3t0TG6sfclY
 usp9ZYgvD7+8QlqFX4Gqp/6rc6an7gkMv0PcPYE7+Jn8DAY/fupAIO62Cp+deiEeYa
 t/qqwRfVsLk9gifFyU42A4QE80oS63GHUcKVDU8nVpKNUin5UAqpspm0sOtuoiMx/f
 2JLZPCeuA5qb1iiR8ybuOnr7y9Ttmw3fKfX8KfWzNFbL59g4Jk3eA28XJp0x/kOINT
 sqW2vcmGZ7UXQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BDAF81E1284;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BB67644B8D0;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A055893497; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 78/91] hw/usb/hcd-ohci: Fail iso packets sent to
 non-iso endpoints and vice-versa
Date: Mon, 26 Oct 2026 16:54:21 +0300
Message-ID: <20261026135441.1019505-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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
(Mjt: this is 415e862f4c78dc5899843ffddf915afabcb0d046 in 10.0.x series)
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3729
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261001194756.3003085-1-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 9ad9a5a9239802aad163c8acd32f36e3d529cee1)
(Mjt: context fixup in hw/usb/hcd-ohci.c, QEMU_UNINITIALIZED)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 9ec9d8a462e..917d9b6ca60 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -577,7 +577,6 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
     int i;
     USBDevice *dev;
     USBEndpoint *ep;
-    USBPacket *pkt;
     uint8_t buf[8192];
     bool int_req;
     struct ohci_iso_td iso_td;
@@ -740,24 +739,31 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
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
@@ -1005,16 +1011,23 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
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
index dd04f14add1..31bc7df1118 100644
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
2.47.3


