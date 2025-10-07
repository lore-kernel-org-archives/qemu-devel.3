Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11283CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v65oU-00040K-1d; Tue, 07 Oct 2025 07:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v65oP-0003zE-Ua; Tue, 07 Oct 2025 07:24:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v65oN-0006UA-Bf; Tue, 07 Oct 2025 07:24:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D27B915B413;
 Tue, 07 Oct 2025 14:24:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id F208729AC11;
 Tue,  7 Oct 2025 14:24:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.21 17/18] hw/usb/hcd-uhci: don't assert for SETUP to
 non-0 endpoint
Date: Tue,  7 Oct 2025 14:24:44 +0300
Message-ID: <20251007112449.499875-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.21-20251007142433@cover.tls.msk.ru>
References: <qemu-stable-7.2.21-20251007142433@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

If the guest feeds invalid data to the UHCI controller, we
can assert:
qemu-system-x86_64: ../../hw/usb/core.c:744: usb_ep_get: Assertion `pid == USB_TOKEN_IN || pid == USB_TOKEN_OUT' failed.

(see issue 2548 for the repro case).  This happens because the guest
attempts USB_TOKEN_SETUP to an endpoint other than 0, which is not
valid.  The controller code doesn't catch this guest error, so
instead we hit the assertion in the USB core code.

Catch the case of SETUP to non-zero endpoint, and treat it as a fatal
error in the TD, in the same way we do for an invalid PID value in
the TD.

This is the UHCI equivalent of the same bug in OHCI that we fixed in
commit 3c3c233677 ("hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or
OUT").

This bug has been tracked as CVE-2024-8354.

Cc: qemu-stable@nongnu.org
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2548
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit d0af3cd0274e265435170a583c72b9f0a4100dff)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index ef967c42a1..1e7fc728a0 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -724,6 +724,7 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
     bool spd;
     bool queuing = (q != NULL);
     uint8_t pid = td->token & 0xff;
+    uint8_t ep_id = (td->token >> 15) & 0xf;
     UHCIAsync *async;
 
     async = uhci_async_find_td(s, td_addr);
@@ -767,9 +768,14 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
 
     switch (pid) {
     case USB_TOKEN_OUT:
-    case USB_TOKEN_SETUP:
     case USB_TOKEN_IN:
         break;
+    case USB_TOKEN_SETUP:
+        /* SETUP is only valid to endpoint 0 */
+        if (ep_id == 0) {
+            break;
+        }
+        /* fallthrough */
     default:
         /* invalid pid : frame interrupted */
         s->status |= UHCI_STS_HCPERR;
@@ -816,7 +822,7 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
             return uhci_handle_td_error(s, td, td_addr, USB_RET_NODEV,
                                         int_mask);
         }
-        ep = usb_ep_get(dev, pid, (td->token >> 15) & 0xf);
+        ep = usb_ep_get(dev, pid, ep_id);
         q = uhci_queue_new(s, qh_addr, td, ep);
     }
     async = uhci_async_alloc(q, td_addr);
-- 
2.47.3


