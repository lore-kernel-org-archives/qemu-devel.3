Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C8BC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksP-0007m1-UC; Sun, 27 Sep 2026 05:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkqk-0001kO-VM; Sun, 27 Sep 2026 05:07:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkqj-0008BV-7v; Sun, 27 Sep 2026 05:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499961; bh=DXnL3q15LC2f1uZJ0VwjHZYJh7TpE9/BeTGUGaaZ+/I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HyJLR+vfYerGXyAB/t85UmL/yIvldfS4h1+82WTMVp/FVQBSdDkS1D68W9mpdI9uO
 bSefNP/P1a2QrrHBkwv4HRy2mOe5S9Nsv0FFxR4qikKEgT+OvLt8JwDC9hBGYdciN5
 rsOsEkU/gCWN35ttrhBzzk94gll83Emx7Qs6V2j78/DjmHWCd46KkUc5J8HEV4X5gb
 RTqLpEa5SG02YV+5LSfUX40e134wJ/L6WLpMrQ0FST1dN2ESeYMkN/qk9FlXC7fYmk
 qmaeKGPb9K97SIIhiFqzhK2VI1iIAHSQ4GevTVZZrE1v0ym6EwL+vHlgVl17jUNTBU
 kCZSu2g3y8oJA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B1A71D8B1D;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 38E504320D6;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D731B5E66B; Sun, 27 Sep 2026 12:06:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 Feifan Qian <bea1e@proton.me>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 76/86] hw/usb/hcd-xhci: don't assert on NAK when
 retrying an isoch transfer
Date: Sun, 27 Sep 2026 12:05:23 +0300
Message-ID: <20260927090540.102811-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
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
index 68714193a66..3ead278323e 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1928,26 +1928,15 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
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


