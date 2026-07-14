Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0407C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 18:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiKW-00086O-09; Tue, 14 Jul 2026 14:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wjiKH-00085P-Ln
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wjiKF-000769-Dy
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784055468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pZQRop7NxXFk7gnyavLOZTndcCkMSteSxqrXQxIt9II=;
 b=fxcQIszhhRTr89tyOZ+EzWZIhRrFteRtk/Qp9zKTcHdk/xUqPYqfT9nUMozUohQkAOxiAS
 c776YqZJbVgIL9heyEUngOrOYNv6QQXbROaNumMxZr+S6KwqaCHmW3K48B7uKXGZKEx/DL
 dV4ouBRUYl/th6OYoSW5yExM8Fn8pAc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-nvWQVT7ENdeaHHN_om1ceA-1; Tue,
 14 Jul 2026 14:57:32 -0400
X-MC-Unique: nvWQVT7ENdeaHHN_om1ceA-1
X-Mimecast-MFC-AGG-ID: nvWQVT7ENdeaHHN_om1ceA_1784055444
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DED101955F75
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 18:57:22 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC2431956056; Tue, 14 Jul 2026 18:57:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] usbredir: fix use-after-free on buffered bulk packet overflow
Date: Tue, 14 Jul 2026 22:57:17 +0400
Message-ID: <20260714185717.1156157-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
---
 hw/usb/redirect.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index bde821e214b..284bcbdb34d 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2138,7 +2138,7 @@ static void usbredir_buffered_bulk_packet(void *priv, uint64_t id,
     USBRedirDevice *dev = priv;
     uint8_t status, ep = buffered_bulk_packet->endpoint;
     void *free_on_destroy;
-    int i, len;
+    int i, len, queued = 0;
 
     DPRINTF("buffered-bulk-in status %d ep %02X len %d id %"PRIu64"\n",
             buffered_bulk_packet->status, ep, data_len, id);
@@ -2169,8 +2169,24 @@ static void usbredir_buffered_bulk_packet(void *priv, uint64_t id,
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
2.55.0


