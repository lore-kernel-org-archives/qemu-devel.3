Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83656C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8dd-0007O6-UK; Wed, 12 Aug 2026 09:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8dc-0007N3-DH; Wed, 12 Aug 2026 09:04:56 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8da-0004VF-Li; Wed, 12 Aug 2026 09:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=UVidIZ9yG0V3bcG4J5rL3qcDy2zclfjKzUSZ84t7TI8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=l8fpQFAEHIXfSfm3bE6nCbqBF12fdIt0hLXwFuOksXJYcCYeDhVCDPlptD5PxpSLB
 DpPc7X8dLF3gFjGlv8LjNfDf8yqXOdrWK499Wh1lvgqlG+2FprrlgwlkOoFekdrz/8
 pIm8W0WeOwp7vL9PEiLbmE1kQkUzfVQN1HlPO+lkS1G09OO6dz2ipeN4yjRgZYxP/e
 J72DGzhBNhNQGWfT6FKGqd0TkZsL5DJ7Pc9DWHmKhnCRZVI4UvLNdX/d776YZxFIeN
 AWoIq4zfHvMaTnfaIHDz4CCayhK2zmWPqp6iBhX92jG+KeoCHEZOs/42onCimpUcyS
 D177oP587O3OA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6B7311CA494;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A1458409B77;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 033032F8BE; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Yunhe Wang <yunhewwww@163.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 021/102] hw/usb/core: Avoid possible assert() in
 do_parameter() --> usb_packet_copy()
Date: Wed, 12 Aug 2026 16:00:56 +0300
Message-ID: <20260812130233.621965-21-mjt@tls.msk.ru>
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
index 975f76250a1..975a601356d 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/usb.h"
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


