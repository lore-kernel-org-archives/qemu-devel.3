Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF343CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCMlK-0007YT-SV; Thu, 01 Oct 2026 15:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCMl8-0007XA-Gf
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:48:02 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCMl6-0005JH-85
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:48:02 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffed768deso19411565e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790884078; x=1791488878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=23uqGxTIRP+avYlWnX6RBS8M1xljOsbsyiHLIJKGG9o=;
 b=YaBFdeZ2l1M2Bh+ELIfqdOXXN9y6VzdACBX+NP8e1bwJsOitE0mL2916bI24LyEYdu
 bm3AHHrXRlQ4q06+Zk5pSsuwtz7CRzsxOYyZ0zvhyBCPrr3LemnHrua5ujaVSVMCok7V
 TdVeVRi/JyWxuacbTfJ+v6hNQAzAzaInat/vSRgF1ArYFeOyVczR+KR7Rj6r9ALromAL
 KHqY3cUntt2B85vSeLQq6gWNcCYrw501qBDNpJs48bJy5D62HTAhgoPumSOEIQuLZSay
 qDKAEK1KPzm0TXjHIqNqVJh7oEdN8KDerj/M4lbLEKlb9nLEoBnkR2ABk7VVqlwL1ySb
 IvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790884078; x=1791488878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=23uqGxTIRP+avYlWnX6RBS8M1xljOsbsyiHLIJKGG9o=;
 b=zFTUgSkeuqToAQK8HTjgOzshuCxXADUp5kU8+Wf0hyihFxX4MPbRCDzXG7nWR7lOmC
 gCOK95Tmcmq+qrn/kk4iwQw1r8DuFaYb5UJF8X23v1trY2HTQoZB014DkW0QbnDh/sl+
 NxqD/1AotGCeeFpwnhvKj7VqWq3HPp+yIWtOCP9jObN3TpO3HG0hUCYEGhwO8DNh/CcH
 TtWWqOelpg/7q8smajII0sFSmJnznraVXA/a4gG133gmKR6WiKMUZHDv3bXMHAG/6r37
 E7Msjr2439F7DOnaFr9fB7vXb0D0wdqF+k8WiOnx291mc5X34Illwt7BvqEUMqe9oA52
 ihcQ==
X-Gm-Message-State: AFuF++k1UADQr6/k1wpYQaiSXMBjafkct1I06rAhcl76uMS4Xam7S51y
 ehC14tJL/vszF3y46fOch+2e5F7GAiRKQWhFwnPkyHmQAiKbbJW9WDBrRxDBxlTnfXw7UikV6u4
 BpBaiWQM=
X-Gm-Gg: AYBFou0NLEJVdkyU6o2v9G4Za7C6GGMzSBJqFX6Q7fiHTVuWf4dVr6gdX0GDg8q1X02
 uK6YvFS1ykTPKrpi2FX9/LeTA6nXWaP4nv0wfAFKlOYo4L1f9QHjtk7960QKjBisF9PAzxh8VQm
 hvmQY7cGPBbdo76TmzY5OVZRE4taemTRgW1BguNJT9UdyF5DFtrduDPxBGIqtaq808D/H1rLSEh
 uXCgof8oAXkHsU5eYMYeLASrB9B9WD6HmM0x0pSPJzKRWIUtEe9e5JW4bA+udW1J5tx4xQc98Vk
 kNF4flyMHUTQmilTFqlebEr5x63JDNr0dMpR27ndIsf/EjYUASh+D+V+FF9yHVKRIwbs8UMeEIN
 spFQD17KWx7b5hmKZfxs4dXcMBKQcShUaXcl6yhkyabgo2vVZa0K1FBPBQF3usBpu60JSHrV1Fu
 1HbJG0NqH+mT0fv4CdwkyL6lYM4PgRDDqcsmBlkPJ7o7WJt47KKm2w8WSRy8b6cF45FCI5D5Mmt
 ibeNI0E5Q9+cB6HNu1s43OjVRtRnqN2U+Bv1u+hBqu+DJj+W0yYP0XoU0oqLq3xQZS+SvVcUKvw
 9LA=
X-Received: by 2002:a05:600c:4e93:b0:4a0:1ef1:b62b with SMTP id
 5b1f17b1804b1-4a02754f71emr11551095e9.10.1790884078484; 
 Thu, 01 Oct 2026 12:47:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03ff0c2fbsm220025e9.3.2026.10.01.12.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 12:47:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] hw/usb/hcd-ohci: Fail iso packets sent to non-iso endpoints
 and vice-versa
Date: Thu,  1 Oct 2026 20:47:56 +0100
Message-ID: <20261001194756.3003085-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3729
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The diff looks a little complex because of the re-indenting;
looking at an "ignore whitespace changes" diff might be clearer

Only testing here has been running the repro in the bug tracker
plus "make check-functional", which probably doesn't exercise
USB very much.

---
 hw/usb/hcd-ohci.c   | 61 +++++++++++++++++++++++++++------------------
 hw/usb/trace-events |  2 ++
 2 files changed, 39 insertions(+), 24 deletions(-)

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
+    if (ep->type == USB_ENDPOINT_XFER_ISOC) {
+        USBPacket *pkt = g_new0(USBPacket, 1);
 
-    /* The USB core guarantees to never defer ISO TDs. */
-    assert(pkt->status != USB_RET_ASYNC);
+        usb_packet_init(pkt);
+        int_req = relative_frame_number == frame_count &&
+            OHCI_BM(iso_td.flags, TD_DI) == 0;
+        usb_packet_setup(pkt, pid, ep, 0, addr, false, int_req);
+        usb_packet_addbuf(pkt, buf, len);
+        usb_handle_packet(dev, pkt);
 
-    if (pkt->status == USB_RET_SUCCESS) {
-        ret = pkt->actual_length;
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
+        if (ep->type != USB_ENDPOINT_XFER_ISOC) {
+            usb_packet_setup(&ohci->usb_packet, pid, ep, 0, addr, !flag_r,
+                             OHCI_BM(td.flags, TD_DI) == 0);
+            usb_packet_addbuf(&ohci->usb_packet, ohci->usb_buf, pktlen);
+            usb_handle_packet(dev, &ohci->usb_packet);
+            trace_usb_ohci_td_packet_status(ohci->usb_packet.status);
 
-        if (ohci->usb_packet.status == USB_RET_ASYNC) {
-            usb_device_flush_ep_queue(dev, ep);
-            ohci->async_td = addr;
-            return 1;
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
2.43.0


