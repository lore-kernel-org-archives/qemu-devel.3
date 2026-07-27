Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E282C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKp7-00007P-3B; Mon, 27 Jul 2026 08:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woKop-0008SB-Rv
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woKok-0004ZM-K1
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785156745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ipnCt2tZbsUnqUSL+EbqaQOVjSTVJq/44bnF1aPTAys=;
 b=Nr//+vAZd8h91QBmX8xGVBhIWuP0/27RteQIDmnEg3uXUfApUFEr5HgGTLJPCNWEkXRhQS
 g15OlXsW6rjPQHaMR1DWqULCS8HylAliAvUm35SjshpkAP/OiCCvDnO03Tz7mG76OYdTwx
 PK55HSsByKOZYkjWwx2CljFe5JVZNAY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-NCPJvz01OsOStR_UIhz0Sw-1; Mon,
 27 Jul 2026 08:52:23 -0400
X-MC-Unique: NCPJvz01OsOStR_UIhz0Sw-1
X-Mimecast-MFC-AGG-ID: NCPJvz01OsOStR_UIhz0Sw_1785156742
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94E071955BD0; Mon, 27 Jul 2026 12:52:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.178])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C45451955F7F; Mon, 27 Jul 2026 12:52:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Feifan Qian <bea1e@proton.me>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 5/5] hw/usb/hcd-xhci: Check return value of
 xhci_xfer_create_sgl() for errors
Date: Mon, 27 Jul 2026 14:52:07 +0200
Message-ID: <20260727125207.646148-6-thuth@redhat.com>
In-Reply-To: <20260727125207.646148-1-thuth@redhat.com>
References: <20260727125207.646148-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

From: Thomas Huth <thuth@redhat.com>

xhci_xfer_create_sgl() can fail if a guest programmed the XHCI in
a weird way. The current code ignores this error, and this triggers
an assert() shortly afterwards:

 hw/usb/core.c:612: usb_packet_copy:
  Assertion `p->actual_length + bytes <= iov->size' failed.

Fix it by handling the error correctly (i.e. return with an error to
the caller).

While we're at it, change the DPRINTF statements in xhci_xfer_create_sgl()
into proper qemu_log_mask() statements, so we have a better way to detect
this situation.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3786
Reported-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260724110933.629791-1-thuth@redhat.com>
---
 hw/usb/hcd-xhci.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 569386b8cf1..d342aa2739e 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1464,7 +1464,8 @@ static int xhci_xfer_create_sgl(XHCITransfer *xfer, int in_xfer)
         switch (TRB_TYPE(*trb)) {
         case TR_DATA:
             if ((!(trb->control & TRB_TR_DIR)) != (!in_xfer)) {
-                DPRINTF("xhci: data direction mismatch for TR_DATA\n");
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "xhci: data direction mismatch for TR_DATA\n");
                 goto err;
             }
             /* fallthrough */
@@ -1474,7 +1475,8 @@ static int xhci_xfer_create_sgl(XHCITransfer *xfer, int in_xfer)
             chunk = trb->status & 0x1ffff;
             if (trb->control & TRB_TR_IDT) {
                 if (chunk > 8 || in_xfer) {
-                    DPRINTF("xhci: invalid immediate data TRB\n");
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "xhci: invalid immediate data TRB\n");
                     goto err;
                 }
                 qemu_sglist_add(&xfer->sgl, trb->addr, chunk);
@@ -1617,7 +1619,9 @@ static int xhci_setup_packet(XHCITransfer *xfer)
         }
     }
 
-    xhci_xfer_create_sgl(xfer, dir == USB_TOKEN_IN); /* Also sets int_req */
+    if (xhci_xfer_create_sgl(xfer, dir == USB_TOKEN_IN) < 0) {  /* Also sets int_req */
+        return -1;
+    }
     usb_packet_setup(&xfer->packet, dir, ep, xfer->streamid,
                      xfer->trbs[0].addr, false, xfer->int_req);
     if (usb_packet_map(&xfer->packet, &xfer->sgl)) {
-- 
2.55.0


