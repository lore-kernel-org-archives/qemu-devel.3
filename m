Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A583606A326
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=l+c+qy+h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLCh-00081r-JD; Mon, 26 Oct 2026 09:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLBt-0007Am-SP; Mon, 26 Oct 2026 09:56:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLBr-0000F9-Kf; Mon, 26 Oct 2026 09:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022903; bh=Wjx5gQETulAKKBlktDJ+rXfIR8zuFCdQw6w/sMm7Tgs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=l+c+qy+htxC+K7EzmWRLNlVXcXp3Wyu8Ve3zfnC6p5v2RExL/CO08JOgEqIG8ii9G
 SN4ZB3BRtfmME/BwrKi7Jtas8iniL7uiskEP+PQEmsC/WgmcKuhTC8Az7vL+aOxUCS
 IRzzGfrUzZCYHydHak+X7BDF9lqsyGDJyOqI9mYr9IzLI8imdHCZKFKUXRWeCOgKbT
 hQuKxuwobrNa1CPmOgE9QrBPjnuvTrq0EpBb9nXo27yosTTrGKmWHps+YxrXzziHot
 ElcPuJfvttN2l+6L2CkE00V5a+4fuvocrg3nAw3UFYtS+MGU/txMmemW1Kv53N2e7V
 QpttYyh+fAz/w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E358D1E128D;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E16B944B8D9;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BAF7D934A9; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Nikhil Agrawal <nikhil.agrawal@mettlelabs.ai>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 87/91] hw/usb/hcd-xhci: More reentrancy guard
 fixes for the XHCI code
Date: Mon, 26 Oct 2026 16:54:30 +0300
Message-ID: <20261026135441.1019505-24-mjt@tls.msk.ru>
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

From: Thomas Huth <thuth@redhat.com>

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
(Mjt: this is commit 1622c9abec1 in 10.0.x series)

CVE: CVE-2026-111819
Message-ID: <20261020114031.687929-1-thuth@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4625
Reported-by: Ken Hsu, Royce Lu, and Bo Qu of Palo Alto Networks
Buglink: https://gitlab.com/qemu-project/qemu/-/work_items/4642
Reported-by: Nikhil Agrawal <nikhil.agrawal@mettlelabs.ai>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit cfa70f3a82f581ad758586ecf408fe7f3602850f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index fd0a88f9612..faded9ac1ed 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3253,49 +3253,73 @@ static const MemoryRegionOps xhci_doorbell_ops = {
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
@@ -3347,6 +3371,7 @@ static void xhci_wakeup_endpoint(USBBus *bus, USBEndpoint *ep,
 {
     XHCIState *xhci = container_of(bus, XHCIState, bus);
     int slotid;
+    bool prev_engaged;
 
     DPRINTF("%s\n", __func__);
     slotid = ep->dev->addr;
@@ -3355,7 +3380,9 @@ static void xhci_wakeup_endpoint(USBBus *bus, USBEndpoint *ep,
         DPRINTF("%s: oops, no slot for dev %d\n", __func__, ep->dev->addr);
         return;
     }
+    prev_engaged = xhci_engage_reentrancy_guard(xhci);
     xhci_kick_ep(xhci, slotid, xhci_find_epid(ep), stream);
+    xhci_restore_reentrancy_guard(xhci, prev_engaged);
 }
 
 static USBBusOps xhci_bus_ops = {
-- 
2.47.3


