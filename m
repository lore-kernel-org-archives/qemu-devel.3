Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DFBC982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 05:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Wrk-0000sp-Bz; Mon, 21 Sep 2026 01:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x8WrZ-0000rJ-3X; Mon, 21 Sep 2026 01:46:51 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x8WrX-000300-DY; Mon, 21 Sep 2026 01:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789969607; x=1821505607;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WwFnVAWQhsH1iFCpZolWcz8dYoU5erTKAAmttsMHl3o=;
 b=ehNaQdGwX18/oBtAfN3rsdficm/yd6PvUOTeRb3aUNAViOpMhraUf3uX
 UpolN8Q4t3fkdbicD40uTqhfrbHRhiSX0zMoKi53PSLPAcBmqFPGFjBT0
 LKy9fasIgVBaRUWGzYQh+rixUm/eoynDT0RA0meEd5i5Jz1tJYCmlUwzN
 Xt1sL9rMnXZuCv/UcLZ1GOUNomNH0M2vJhp59c/v1ICtbJYlvLrB9mKTq
 DlxTDRkrGKSTV6NWgLEaLYG/JRtVNWdikk9CIjlLVTQ93yIpTp+yPE5Rp
 RCgwtvKCCRIyqd4ATB9LWjASGWmOCn0btklcBsk4fs00KcxvlKJAcdGt0 w==;
X-CSE-ConnectionGUID: LV1a2rt3TUqJJDS4AXRnJg==
X-CSE-MsgGUID: gUhyeXTVQ/qdf49ujBHmOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="94287038"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="94287038"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 22:46:46 -0700
X-CSE-ConnectionGUID: uPelgDRBQfC42ikuRGA4jg==
X-CSE-MsgGUID: cWrc4d0gS0uONYxG9oQnYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3815204"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 22:46:44 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Feifan Qian <bea1e@proton.me>,
 qemu-stable@nongnu.org
Subject: [PATCH 2/4] hw/usb/hcd-xhci: don't assert on NAK when retrying an
 isoch transfer
Date: Mon, 21 Sep 2026 13:46:30 +0800
Message-ID: <44227b05b22064a22f4c135e025ff0b1d838b9e3.1789968699.git.junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789968699.git.junjie.cao@intel.com>
References: <cover.1789968699.git.junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
---
 hw/usb/hcd-xhci.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index ce042e74bd..6cd5ac87b8 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1912,26 +1912,15 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
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
2.43.0


