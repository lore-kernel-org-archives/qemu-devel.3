Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A256DC5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAMg-0002Lq-Ju; Wed, 12 Aug 2026 10:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAKI-0006iW-U5; Wed, 12 Aug 2026 10:53:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAKG-00074D-PZ; Wed, 12 Aug 2026 10:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=m+ZZ/hb2gmgAbPYWvMYTVuqmMP7vNsKTvEPWKHWFZyQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OlUDsvCvzPrGp0o5j6dtcYeDGYEzKxX4E/njYKrESIX42lIxi89DujrsUQLFzRhxf
 MjFNz14tUGYrKvts9pQhm4HtgZb2gRhBdR1HYKijIRBH7/tszZr+e61DjeaSzWl87I
 XJaVklLqHj6iXf6MWKwAFKsZChIkD02w43yUL/0eOkLiCHoBZQ6KcZ7zjD/PrMd8Kd
 9zYnRXuBysxL06KGuv3DMvGUFnlrGka//8ZgygQaXeDewiPeRBF1PA/lo/lja21luV
 ReWFkzAfeZSNzegkHQ04WLeqBbGffCcvOXBgrFSfd7cZsHrja431Vo7drCiMPPe5FA
 ZHS8Ef6gQxsPA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 851491CA622;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E02A0409D61;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4A3082F99F; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Feifan Qian <bea1e@proton.me>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 030/120] hw/usb/hcd-xhci: Check return value of
 xhci_xfer_create_sgl() for errors
Date: Wed, 12 Aug 2026 17:48:13 +0300
Message-ID: <20260812144955.649205-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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
(cherry picked from commit 92abc3c51ebb3223a6fdb5bd3414b2943d7653b2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 5131d05c6ee..be06240cee2 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1465,7 +1465,8 @@ static int xhci_xfer_create_sgl(XHCITransfer *xfer, int in_xfer)
         switch (TRB_TYPE(*trb)) {
         case TR_DATA:
             if ((!(trb->control & TRB_TR_DIR)) != (!in_xfer)) {
-                DPRINTF("xhci: data direction mismatch for TR_DATA\n");
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "xhci: data direction mismatch for TR_DATA\n");
                 goto err;
             }
             /* fallthrough */
@@ -1475,7 +1476,8 @@ static int xhci_xfer_create_sgl(XHCITransfer *xfer, int in_xfer)
             chunk = trb->status & 0x1ffff;
             if (trb->control & TRB_TR_IDT) {
                 if (chunk > 8 || in_xfer) {
-                    DPRINTF("xhci: invalid immediate data TRB\n");
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "xhci: invalid immediate data TRB\n");
                     goto err;
                 }
                 qemu_sglist_add(&xfer->sgl, trb->addr, chunk);
@@ -1618,7 +1620,9 @@ static int xhci_setup_packet(XHCITransfer *xfer)
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
2.47.3


