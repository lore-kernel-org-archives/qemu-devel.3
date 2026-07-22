Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8872C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPP-0007AV-UD; Wed, 22 Jul 2026 08:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWOc-0004EI-Pu; Wed, 22 Jul 2026 08:50:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWOa-0001yt-8h; Wed, 22 Jul 2026 08:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=I3vPw5rCpKcbjGDyJixLsxPc6KMbCJ2m+tkvUKj+x4c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=k6pkdeoHbbIMPR5p1PlupdRDXLvRM+4z97ufWTsXGOdq2cNGRyND6ADmoV8tPdEzf
 EYlFFaPH1r0HVRdCISeek2T0wOiWDTAd4S5lHW41k/6w0JNBEmsJKUuGfZhIWKotf/
 gOwvL82+qSgfo0qW+2txMPNZlCqdqG95cCuM8ONRhao1GVXvxZUBDsxPM0IAmy5GoR
 mifJKAtIKM8sgW+0dugRWvrrXbrWmtTChuw0K30rUBxxQxi04+W61ptzlD0Hcc7LfD
 GB02MZQb9wxnvs9uaGoPd5rYREJ+TAhM2hJpW3sz3pISKb+XtAr9S/QioYOE4h7gso
 7y2xyk/5Rt/Fg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F25E01C3B19;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 45BC93F3773;
 Wed, 22 Jul 2026 15:46:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8D7E017F1B; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Feifan Qian <bea1e@proton.me>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 112/122] usbredir: fix use-after-free on buffered
 bulk packet overflow
Date: Wed, 22 Jul 2026 15:46:01 +0300
Message-ID: <20260722124622.31034-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When usbredir_buffered_bulk_packet() splits a multi-fragment buffered
bulk packet into max-packet-size chunks, only the final fragment owns
the shared parser allocation (via free_on_destroy). If bufp_alloc()
drops the final fragment due to queue overflow, it frees the backing
buffer while earlier fragments already queued still hold interior
pointers into it. Subsequent guest bulk-IN transfers then read from
freed heap memory.

Fix this by tracking how many fragments were queued during the current
packet. When bufp_alloc() fails, remove all already-queued fragments
from the tail of the endpoint queue before breaking out of the loop.
If the dropped fragment was non-final, free the data buffer explicitly
since no fragment took ownership.

Fixes: CVE-2026-15705
Fixes: b2d1fe67d09d ("usbredir: Add support for buffered bulk input (v2)")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3808
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260714185717.1156157-1-marcandre.lureau@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 9bf52d056a03cd3768caccbc4c88fcc34be26c28)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index f3a83b3f4c9..72131289a8f 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2143,7 +2143,7 @@ static void usbredir_buffered_bulk_packet(void *priv, uint64_t id,
     USBRedirDevice *dev = priv;
     uint8_t status, ep = buffered_bulk_packet->endpoint;
     void *free_on_destroy;
-    int i, len;
+    int i, len, queued = 0;
 
     DPRINTF("buffered-bulk-in status %d ep %02X len %d id %"PRIu64"\n",
             buffered_bulk_packet->status, ep, data_len, id);
@@ -2174,8 +2174,24 @@ static void usbredir_buffered_bulk_packet(void *priv, uint64_t id,
         /* bufp_alloc also adds the packet to the ep queue */
         r = bufp_alloc(dev, data + i, len, status, ep, free_on_destroy);
         if (r) {
+            /*
+             * Earlier fragments from this packet are in the queue
+             * with interior pointers into data. If the dropped
+             * fragment was the final one, bufp_alloc already freed
+             * data so those pointers are dangling. Remove them.
+             */
+            while (queued > 0) {
+                struct buf_packet *bufp;
+                bufp = QTAILQ_LAST(&dev->endpoint[EP2I(ep)].bufpq);
+                bufp_free(dev, bufp, ep);
+                queued--;
+            }
+            if (!free_on_destroy) {
+                free(data);
+            }
             break;
         }
+        queued++;
     }
 
     if (dev->endpoint[EP2I(ep)].pending_async_packet) {
-- 
2.47.3


