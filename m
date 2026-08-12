Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889CAC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAMP-00023P-5I; Wed, 12 Aug 2026 10:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAKI-0006iV-Ta; Wed, 12 Aug 2026 10:53:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAKF-00073c-2P; Wed, 12 Aug 2026 10:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=41RqxYpXAxl5M5TC40IEyYrP3DuEG9Dnd4oxeii6E7A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mhPVp1ukJdbVLINad8G7/Ze7yY6lwhyteJWz8PEMME+07i2dD8CBrYCQpCtME/fIn
 aVtaWfzGzZ9sEoiDdmNE6GzxpzNW2L3Y7KcJG93XrC268GYjEb7FP+ZdTy8Zc9u0kl
 POL8H+NTvvF9KCgSCHKpTiZii43jS+iLLH5Los9aSrbeCoYnQm/b6EURUFQRkpd/ST
 EEt6ut+HVTfB1MrEPmbyAM8rtywHBmc7GDz47a3PUMPQpgAACqj04aGmpH1Jr/oAcO
 I4UsYCovlz8Ax+2B0T4FGO/lQaODCjKBfKU+uoPf7UohK3svjZK60wj16MktEKZ02f
 ESyKc+2JZTBBg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7D8181CA621;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D822F409D60;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 41E392F99D; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Yunhe Wang <yunhewwww@163.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 029/120] hw/usb/core: Avoid possible assert() in
 do_parameter() --> usb_packet_copy()
Date: Wed, 12 Aug 2026 17:48:12 +0300
Message-ID: <20260812144955.649205-29-mjt@tls.msk.ru>
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

usb_packet_copy() uses assert(p->actual_length + bytes <= iov->size)
to make sure that there is enough space in the the iov. This assert()
can be triggered from do_parameter() if the guest programs the XHCI
in a weird way. Avoid the hard error by checking for the condition
in do_parameter() first and signalling a USB_RET_STALL to the guest,
just like it is done for another error condition here already some
lines earlier.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3746
Reported-by: Yunhe Wang <yunhewwww@163.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260721185140.247775-1-thuth@redhat.com>
(cherry picked from commit 68809288c7e5bf2a9a9edeb55af8c368f52442ad)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/core.c b/hw/usb/core.c
index 9572a870cc0..11f484b9ad0 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/usb/usb.h"
 #include "qemu/iov.h"
+#include "qemu/log.h"
 #include "trace.h"
 
 void usb_pick_speed(USBPort *port)
@@ -288,6 +289,15 @@ static void do_parameter(USBDevice *s, USBPacket *p)
         p->status = USB_RET_STALL;
         return;
     }
+    if ((p->pid == USB_TOKEN_OUT || p->pid == USB_TOKEN_IN) &&
+        setup_len > p->iov.size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "xhci: setup state param length %u > iov size %zu\n",
+                      setup_len, p->iov.size);
+        p->status = USB_RET_STALL;
+        return;
+    }
+
     s->setup_len = setup_len;
 
     if (p->pid == USB_TOKEN_OUT) {
-- 
2.47.3


