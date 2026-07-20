Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08C3C44527
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllOo-0003mr-3q; Mon, 20 Jul 2026 06:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wllOf-0003kl-E9
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:38:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wllOc-0008H3-Mm
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784543930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmMOrL1qy0em1clNfQjUh4hOg8rqOth/0bemYGgGW1Y=;
 b=AEK866STj6F9FMfIALLrtyT49ulFN4ULkt3sslFWj8A8ni+xAi6KtMKt+slruWG4zqoRNX
 VUqb7UYbIVyrAu+NjTlzMOddHNa+zxJroQnZy8X4dNa+LNswUV2wu1s472VK8pcvnL6blI
 f0gfwtJ0L7qvXAiD7sMVIHURJTbOvNs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-wkUA_KIbPvyOda2kUdcJyQ-1; Mon,
 20 Jul 2026 06:38:48 -0400
X-MC-Unique: wkUA_KIbPvyOda2kUdcJyQ-1
X-Mimecast-MFC-AGG-ID: wkUA_KIbPvyOda2kUdcJyQ_1784543927
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D4F81944E45
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:38:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 513611588; Mon, 20 Jul 2026 10:38:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 5/7] usbredir: fix infinite loop and SIGFPE with zero
 max_packet_size
Date: Mon, 20 Jul 2026 12:38:31 +0200
Message-ID: <20260720103833.364506-6-thuth@redhat.com>
In-Reply-To: <20260720103833.364506-1-thuth@redhat.com>
References: <20260720103833.364506-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

A malicious usbredir peer can send an ep_info message resetting
max_packet_size to 0 after bulk receiving has started. This causes:
- infinite loop in usbredir_buffered_bulk_packet() where the splitting
  loop increments by max_packet_size (0)
- SIGFPE in usbredir_buffered_bulk_in_complete_ftdi() from modulo by 0
- SIGFPE in usbredir_handle_buffered_bulk_in_data() from division by 0
  when computing bytes_per_transfer

Fix by stopping and disabling bulk receiving in usbredir_ep_info() when
max_packet_size is set to 0.

Add post-load check, and assert() for the invariant.

Fixes: CVE-2026-63319
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3995
Reported-by: Tristan @TristanInSec
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260716141107.3597076-1-marcandre.lureau@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/redirect.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 284bcbdb34d..dfd9e8bb50c 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -690,6 +690,7 @@ static void usbredir_buffered_bulk_in_complete_ftdi(USBRedirDevice *dev,
     struct buf_packet *bulkp;
     int count;
 
+    assert(maxp != 0);
     while ((bulkp = QTAILQ_FIRST(&dev->endpoint[EP2I(ep)].bufpq)) &&
            p->actual_length < p->iov.size && p->status == USB_RET_SUCCESS) {
         if (bulkp->len < 2) {
@@ -739,6 +740,7 @@ static void usbredir_handle_buffered_bulk_in_data(USBRedirDevice *dev,
             .stream_id = 0,
             .no_transfers = 5,
         };
+        assert(dev->endpoint[EP2I(ep)].max_packet_size != 0);
         /* Round bytes_per_transfer up to a multiple of max_packet_size */
         bpt = 512 + dev->endpoint[EP2I(ep)].max_packet_size - 1;
         bpt /= dev->endpoint[EP2I(ep)].max_packet_size;
@@ -793,6 +795,7 @@ static void usbredir_handle_bulk_data(USBRedirDevice *dev, USBPacket *p,
     }
 
     if (dev->endpoint[EP2I(ep)].bulk_receiving_enabled) {
+        assert(maxp != 0);
         if (size != 0 && (size % maxp) == 0) {
             usbredir_handle_buffered_bulk_in_data(dev, p, ep);
             return;
@@ -1796,6 +1799,17 @@ static void usbredir_ep_info(void *priv,
         if (usbredirparser_peer_has_cap(dev->parser,
                                      usb_redir_cap_ep_info_max_packet_size)) {
             dev->endpoint[i].max_packet_size = ep_info->max_packet_size[i];
+            if (ep_info->max_packet_size[i] == 0 &&
+                dev->endpoint[i].bulk_receiving_enabled) {
+                USBPacket *p = dev->endpoint[i].pending_async_packet;
+                usbredir_stop_bulk_receiving(dev, I2EP(i));
+                dev->endpoint[i].bulk_receiving_enabled = 0;
+                if (p != NULL) {
+                    dev->endpoint[i].pending_async_packet = NULL;
+                    p->status = USB_RET_IOERROR;
+                    usb_packet_complete(&dev->dev, p);
+                }
+            }
         }
 #if USBREDIR_VERSION >= 0x000700
         if (usbredirparser_peer_has_cap(dev->parser,
@@ -2156,6 +2170,7 @@ static void usbredir_buffered_bulk_packet(void *priv, uint64_t id,
     }
 
     /* Data must be in maxp chunks for buffered_bulk_add_*_data_to_packet */
+    assert(dev->endpoint[EP2I(ep)].max_packet_size != 0);
     len = dev->endpoint[EP2I(ep)].max_packet_size;
     status = usb_redir_success;
     free_on_destroy = NULL;
@@ -2239,6 +2254,15 @@ static int usbredir_post_load(void *priv, int version_id)
     usbredir_setup_usb_eps(dev);
     usbredir_check_bulk_receiving(dev);
 
+    for (int i = 0; i < MAX_ENDPOINTS; i++) {
+        if (dev->endpoint[i].bulk_receiving_started &&
+            dev->endpoint[i].max_packet_size == 0) {
+            error_report("usbredir: endpoint %d has bulk receiving started "
+                         "with zero max_packet_size", i);
+            return -EINVAL;
+        }
+    }
+
     return 0;
 }
 
-- 
2.55.0


