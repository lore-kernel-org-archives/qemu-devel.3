Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E8DC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8dy-00085q-FY; Wed, 12 Aug 2026 09:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8dh-0007Z8-0w; Wed, 12 Aug 2026 09:05:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8de-0004WZ-90; Wed, 12 Aug 2026 09:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=FIQdL0gJhx40R7ceoO9Ak3yW9kMvf3p33gxLy68GsFk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=grvGCv7kEvjr7RJfH76hNzrS0hS/Ejauhzf8XgU50cF4Ba6uT9xTpUxJ9ryQDjTMc
 te10J43l9OMh2+L+JDWacg5314twnsmqvRByOWPEuZSAWLovQ3sRT4nfrefymY7wVY
 TrK4jM2uTO/MgO4nO8L7zVYwuP6reWxARgvmgzffIlPlI7CcAQIb3XRNVFpMJVDklA
 0k06ivp0DnnkFr34lxsw767+BKPECloM1coq3fCHZQ8YXFRlOLpIfSzLgO3UOdfI03
 Ojp8puqoCpf994MA5N/BCgWAj4a5aeAIDJrjOAXfMFbRx7rUEJzhaHZpIRzxSdOtdQ
 LfjHost+U8rEA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 70E4F1CA495;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A65DE409B78;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 05C3B2F8C0; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Feifan Qian <bea1e@proton.me>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 022/102] hw/usb/hcd-xhci: Check return value of
 xhci_xfer_create_sgl() for errors
Date: Wed, 12 Aug 2026 16:00:57 +0300
Message-ID: <20260812130233.621965-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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
index 969f275f32b..97b18f8d362 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1458,7 +1458,8 @@ static int xhci_xfer_create_sgl(XHCITransfer *xfer, int in_xfer)
         switch (TRB_TYPE(*trb)) {
         case TR_DATA:
             if ((!(trb->control & TRB_TR_DIR)) != (!in_xfer)) {
-                DPRINTF("xhci: data direction mismatch for TR_DATA\n");
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "xhci: data direction mismatch for TR_DATA\n");
                 goto err;
             }
             /* fallthrough */
@@ -1468,7 +1469,8 @@ static int xhci_xfer_create_sgl(XHCITransfer *xfer, int in_xfer)
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
2.47.3


