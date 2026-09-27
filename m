Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9C6C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjJW-0001xE-Ps; Sun, 27 Sep 2026 03:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjIG-0000LO-W7; Sun, 27 Sep 2026 03:27:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjIF-0005UC-5x; Sun, 27 Sep 2026 03:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790494013; bh=ADRC8PT9oMNdyhIQADbwSFkd2z06GUFKrBzVmDDd+Fg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UjgBunXHkAJ/Qwrami7Kg26j4YOC8tCrgEEcUuoVcvIJPOwS57ae5c9PB4MOjTg9x
 00v7OlleyxG/BrlEexhphdyQhP5tRazVh7kYoTa3xJa845CFqo1TcPVm2hSu9PYXA7
 WpatmzMOgkq39g+/U8fkyryqxhCpM/VDuDocHwyHh3uXBBgUVRxDNTa82OOc486wAA
 2vI3TocsPMdPr09+af9vV3TEuNqWD5DDa2Dxq5qP8jN9R1lw2K9Yn0JzceMy7HBnpG
 9az6xBttBdECQIF/+hyO4OJldLc4629R3WpEhmhf+yzJB4M/V4egeSdZppVd8kQ7Nr
 syWeBUkgXfuWA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BCF291D8AC0;
 Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A6BDC432052;
 Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id F0EBB5E62F; Sun, 27 Sep 2026 10:26:52 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 Feifan Qian <bea1e@proton.me>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 v2 62/72] hw/usb/hcd-xhci: don't assert on NAK when
 retrying an isoch transfer
Date: Sun, 27 Sep 2026 10:25:54 +0300
Message-ID: <20260927072622.93656-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
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

From: Junjie Cao <junjie.cao@intel.com>

The endpoint type in the xHCI endpoint context comes from the guest and
is not checked against the device. A guest can configure the interrupt
IN endpoint of usb-kbd as Isoch IN. The idle HID endpoint NAKs, and as
soon as the transfer goes through the retry path in xhci_kick_epctx()
it hits

  assert(xfer->packet.status != USB_RET_NAK);

No device model NAKs on an isoch endpoint, so this only triggers with a
mismatched endpoint type.

The two retry branches differ only in what they do on NAK: the isoch one
asserts, the other keeps the transfer pending. Merge them.

Fixes: 3d1396842d ("xhci: iso xfer support")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3886
Reported-by: Feifan Qian <bea1e@proton.me>
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <44227b05b22064a22f4c135e025ff0b1d838b9e3.1789968699.git.junjie.cao@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 45684127cdee2d212125fd8d1de8a9c4804ee8bb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 26dcb8c6bd7..88937683aad 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1927,26 +1927,15 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
             xfer->timed_xfer = 0;
             xfer->running_retry = 1;
         }
-        if (xfer->iso_xfer) {
-            /* retry iso transfer */
-            if (xhci_setup_packet(xfer) < 0) {
-                return;
-            }
-            usb_handle_packet(xfer->packet.ep->dev, &xfer->packet);
-            assert(xfer->packet.status != USB_RET_NAK);
-            xhci_try_complete_packet(xfer);
-        } else {
-            /* retry nak'ed transfer */
-            if (xhci_setup_packet(xfer) < 0) {
-                return;
-            }
-            usb_handle_packet(xfer->packet.ep->dev, &xfer->packet);
-            if (xfer->packet.status == USB_RET_NAK) {
-                xhci_xfer_unmap(xfer);
-                return;
-            }
-            xhci_try_complete_packet(xfer);
+        if (xhci_setup_packet(xfer) < 0) {
+            return;
+        }
+        usb_handle_packet(xfer->packet.ep->dev, &xfer->packet);
+        if (xfer->packet.status == USB_RET_NAK) {
+            xhci_xfer_unmap(xfer);
+            return;
         }
+        xhci_try_complete_packet(xfer);
         assert(!xfer->running_retry);
         if (xfer->complete) {
             /* update ring dequeue ptr */
-- 
2.47.3


