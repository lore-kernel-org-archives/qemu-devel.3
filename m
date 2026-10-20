Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F94606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y1jCIZu/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ8D1-0005Mv-9g; Tue, 20 Oct 2026 07:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJ8Cz-0005MX-MA
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 07:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJ8Cx-0005ie-5J
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 07:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792496441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sp9jq6kXtWZZsUwq0XdkMYbhEcu8HadaVkOvMEE9mqE=;
 b=Y1jCIZu/kAbKhObCQDnJmQxfd5T11Rmy2pZaBsH5E7JFKrsMeRb9fKQUVE/D1DpJ7p58vI
 XRkDEIZA6t+G/GRy6g7pJjlB1PKpsO1/vf2h9i7d8yENQluIdZD2zvj8VeD1YUG23jzByv
 K/NPP6UT1LacY5cjLXl6Yr4A435yoos=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-iER7kwwmMn2aL75OgZxO1g-1; Tue,
 20 Oct 2026 11:40:37 +0000
X-MC-Unique: iER7kwwmMn2aL75OgZxO1g-1
X-Mimecast-MFC-AGG-ID: iER7kwwmMn2aL75OgZxO1g_1792496436
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17EBB19541B4; Tue, 20 Oct 2026 11:40:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 744161956089; Tue, 20 Oct 2026 11:40:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tommaso Califano <tcalifano@redhat.com>, Junjie Cao <junjie.cao@intel.com>,
 Nikhil Agrawal <nikhil.agrawal@mettlelabs.ai>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] hw/usb/hcd-xhci: More reentrancy guard fixes for the XHCI code
Date: Tue, 20 Oct 2026 13:40:31 +0200
Message-ID: <20261020114031.687929-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The XHCI controller's USB port and bus callbacks -- xhci_complete(),
xhci_wakeup_endpoint(), xhci_attach(), xhci_detach(), and
xhci_wakeup() -- can be invoked from outside any MMIO handler context.
The device's mem_reentrancy_guard is therefore not engaged during
this processing.

A malicious guest can exploit this gap via MSI-X self-targeting: it
programs the MSI-X vector's message address to point at the XHCI
doorbell register array (both reside in the same BAR0 MemoryRegion).
When any of these callbacks posts an event via xhci_event() ->
xhci_intr_raise(), the resulting msix_notify() -> pci_msi_trigger()
issues an address_space_stl_le() that writes doorbell 0, triggering
xhci_process_commands() reentrantly. A CR_DISABLE_SLOT command
planted on the command ring then frees XHCITransfer/XHCIEPContext
objects that the outer call stack still references, causing a
heap use-after-free.

Fix this by setting engaged_in_io on the device's mem_reentrancy_guard
around the processing in all five callbacks. The guard is set
conditionally (only when not already engaged) because these callbacks
may also be reached from within a guarded MMIO context.

xhci_child_detach() is intentionally left unguarded: it only calls
xhci_detach_slot() which passes report=0 to xhci_ep_nuke_xfers(),
suppressing event generation, so it never reaches xhci_event().

Note: This is similar to the fixes done for CVE-2026-17588, see
f91b0544fe ("Set reentrancy guard in timer functions").

CVE: CVE-2026-111819
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4625
Reported-by: Ken Hsu, Royce Lu, and Bo Qu of Palo Alto Networks
Buglink: https://gitlab.com/qemu-project/qemu/-/work_items/4642
Reported-by:  Nikhil Agrawal <nikhil.agrawal@mettlelabs.ai>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/hcd-xhci.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 376bc00264d..5d7a77b8bcf 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3251,49 +3251,73 @@ static const MemoryRegionOps xhci_doorbell_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static bool xhci_engage_reentrancy_guard(XHCIState *xhci)
+{
+    bool prev_engaged = xhci->parent.mem_reentrancy_guard.engaged_in_io;
+
+    xhci->parent.mem_reentrancy_guard.engaged_in_io = true;
+    return prev_engaged;
+}
+
+static void xhci_restore_reentrancy_guard(XHCIState *xhci, bool engaged)
+{
+    xhci->parent.mem_reentrancy_guard.engaged_in_io = engaged;
+}
+
 static void xhci_attach(USBPort *usbport)
 {
     XHCIState *xhci = usbport->opaque;
     XHCIPort *port = xhci_lookup_port(xhci, usbport);
+    bool prev_engaged = xhci_engage_reentrancy_guard(xhci);
 
     xhci_port_update(port, 0);
+    xhci_restore_reentrancy_guard(xhci, prev_engaged);
 }
 
 static void xhci_detach(USBPort *usbport)
 {
     XHCIState *xhci = usbport->opaque;
     XHCIPort *port = xhci_lookup_port(xhci, usbport);
+    bool prev_engaged = xhci_engage_reentrancy_guard(xhci);
 
     xhci_detach_slot(xhci, usbport);
     xhci_port_update(port, 1);
+    xhci_restore_reentrancy_guard(xhci, prev_engaged);
 }
 
 static void xhci_wakeup(USBPort *usbport)
 {
     XHCIState *xhci = usbport->opaque;
     XHCIPort *port = xhci_lookup_port(xhci, usbport);
+    bool prev_engaged;
 
     assert(port);
     if (get_field(port->portsc, PORTSC_PLS) != PLS_U3) {
         return;
     }
+    prev_engaged = xhci_engage_reentrancy_guard(xhci);
     set_field(&port->portsc, PLS_RESUME, PORTSC_PLS);
     xhci_port_notify(port, PORTSC_PLC);
+    xhci_restore_reentrancy_guard(xhci, prev_engaged);
 }
 
 static void xhci_complete(USBPort *port, USBPacket *packet)
 {
     XHCITransfer *xfer = container_of(packet, XHCITransfer, packet);
+    XHCIState *xhci = xfer->epctx->xhci;
+    bool prev_engaged;
 
     if (packet->status == USB_RET_REMOVE_FROM_QUEUE) {
         xhci_ep_nuke_one_xfer(xfer, 0);
         return;
     }
+    prev_engaged = xhci_engage_reentrancy_guard(xhci);
     xhci_try_complete_packet(xfer);
     xhci_kick_epctx(xfer->epctx, xfer->streamid);
     if (xfer->complete) {
         xhci_ep_free_xfer(xfer);
     }
+    xhci_restore_reentrancy_guard(xhci, prev_engaged);
 }
 
 static void xhci_child_detach(USBPort *uport, USBDevice *child)
@@ -3345,6 +3369,7 @@ static void xhci_wakeup_endpoint(USBBus *bus, USBEndpoint *ep,
 {
     XHCIState *xhci = container_of(bus, XHCIState, bus);
     int slotid;
+    bool prev_engaged;
 
     DPRINTF("%s\n", __func__);
     slotid = ep->dev->addr;
@@ -3353,7 +3378,9 @@ static void xhci_wakeup_endpoint(USBBus *bus, USBEndpoint *ep,
         DPRINTF("%s: oops, no slot for dev %d\n", __func__, ep->dev->addr);
         return;
     }
+    prev_engaged = xhci_engage_reentrancy_guard(xhci);
     xhci_kick_ep(xhci, slotid, xhci_find_epid(ep), stream);
+    xhci_restore_reentrancy_guard(xhci, prev_engaged);
 }
 
 static USBBusOps xhci_bus_ops = {
-- 
2.56.0


