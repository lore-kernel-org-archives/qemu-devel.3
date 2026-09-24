Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD6CC98311
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9fPM-0008Fy-M4; Thu, 24 Sep 2026 05:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9fPE-0008EU-UL
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9fPD-0000jg-40
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790240773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5WQc7UCGNWpE427khC14ftuYg6kEP5837Fe2UUU48U=;
 b=XFDbZgAJdXBaiBsN/rP0mnDsjoE8j2Ze/DBo1nzn9COlMbUWxUfKR62V5Spz5hF4zDTn9H
 rHNyWCnDo1iVmdl2i8sJy0+wMFspnvo43GdqtWCWG3XUGt/2Re8xowhCRime4sBL6IgClL
 9K+UhEJKsOuWh/lkz0ErLsUHY8MVVL0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-tbE4g3QWNo-nMcfi47z2QA-1; Thu,
 24 Sep 2026 05:06:10 -0400
X-MC-Unique: tbE4g3QWNo-nMcfi47z2QA-1
X-Mimecast-MFC-AGG-ID: tbE4g3QWNo-nMcfi47z2QA_1790240769
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D3C31954B21; Thu, 24 Sep 2026 09:06:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E89E195604C; Thu, 24 Sep 2026 09:06:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Junjie Cao <junjie.cao@intel.com>, Feifan Qian <bea1e@proton.me>,
 qemu-stable@nongnu.org
Subject: [PULL 5/7] hw/usb/hcd-xhci: don't assert on NAK when retrying an
 isoch transfer
Date: Thu, 24 Sep 2026 11:05:56 +0200
Message-ID: <20260924090558.801845-6-thuth@redhat.com>
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
---
 hw/usb/hcd-xhci.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 2f82b76272d..376bc00264d 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1926,26 +1926,15 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
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
2.55.0


