Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AC6CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbhFg-0001sK-6B; Mon, 22 Jun 2026 12:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wbhFa-0001rn-M0
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wbhFY-0000Be-GA
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782144710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ma6dsYdCVPYfWQWDqH3DZDdyXl9n2kbNGsk9i4sYk1c=;
 b=KCO/o47F3JAELNADONxV3MjMkXnKaTZbOy0syE0tI0+SOTZX4rKtv2GhT8V6WU4jgwjpKv
 +xyyg6bVApuIJQKxcs/hlz0Ukc8EP/SqSp7XmaMlQmN5uR2/sW5gw3GJgIhvvcn27UuIZ4
 kiTa2YTykcU8AcKQd48g1ENdd4Lai8o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-9QDKfWYaM7OyNSkuhEYAyg-1; Mon,
 22 Jun 2026 12:11:48 -0400
X-MC-Unique: 9QDKfWYaM7OyNSkuhEYAyg-1
X-Mimecast-MFC-AGG-ID: 9QDKfWYaM7OyNSkuhEYAyg_1782144708
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDC73195604A; Mon, 22 Jun 2026 16:11:47 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D023536512; Mon, 22 Jun 2026 16:11:45 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] hw/char/virtio-serial-bus: fix guest-triggerable OOM in
 control_out()
Date: Mon, 22 Jun 2026 18:11:44 +0200
Message-ID: <20260622161144.2883799-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A malicious guest can craft virtqueue descriptors with arbitrary lengths.
control_out() calls iov_size() on the guest-supplied scatter-gather list
and passes the result directly to g_malloc(), allowing a guest to force
QEMU to attempt multi-gigabyte allocations and crash the host process.

Fix this by copying at most sizeof(struct virtio_console_control) into a
stack-local variable instead of allocating a buffer sized by the guest.
handle_control_message() only accesses the fixed-size id, event, and
value fields, so no data beyond the struct was ever needed.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3585
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/char/virtio-serial-bus.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index cd234dc6db1d..c1973f0248fc 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -344,22 +344,16 @@ void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle)
 }
 
 /* Guest wants to notify us of some event */
-static void handle_control_message(VirtIOSerial *vser, void *buf, size_t len)
+static void handle_control_message(VirtIOSerial *vser,
+                                   struct virtio_console_control *gcpkt)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(vser);
     struct VirtIOSerialPort *port;
     VirtIOSerialPortClass *vsc;
-    struct virtio_console_control cpkt, *gcpkt;
+    struct virtio_console_control cpkt;
     uint8_t *buffer;
     size_t buffer_len;
 
-    gcpkt = buf;
-
-    if (len < sizeof(cpkt)) {
-        /* The guest sent an invalid control packet */
-        return;
-    }
-
     cpkt.event = virtio_lduw_p(vdev, &gcpkt->event);
     cpkt.value = virtio_lduw_p(vdev, &gcpkt->value);
 
@@ -457,41 +451,27 @@ static void control_in(VirtIODevice *vdev, VirtQueue *vq)
 
 static void control_out(VirtIODevice *vdev, VirtQueue *vq)
 {
+    struct virtio_console_control cpkt;
     VirtQueueElement *elem;
     VirtIOSerial *vser;
-    uint8_t *buf;
     size_t len;
 
     vser = VIRTIO_SERIAL(vdev);
 
-    len = 0;
-    buf = NULL;
     for (;;) {
-        size_t cur_len;
-
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             break;
         }
 
-        cur_len = iov_size(elem->out_sg, elem->out_num);
-        /*
-         * Allocate a new buf only if we didn't have one previously or
-         * if the size of the buf differs
-         */
-        if (cur_len > len) {
-            g_free(buf);
-
-            buf = g_malloc(cur_len);
-            len = cur_len;
+        len = iov_to_buf(elem->out_sg, elem->out_num, 0, &cpkt, sizeof(cpkt));
+        if (len == sizeof(cpkt)) {
+            handle_control_message(vser, &cpkt);
         }
-        iov_to_buf(elem->out_sg, elem->out_num, 0, buf, cur_len);
 
-        handle_control_message(vser, buf, cur_len);
         virtqueue_push(vq, elem, 0);
         g_free(elem);
     }
-    g_free(buf);
     virtio_notify(vdev, vq);
 }
 
-- 
2.54.0


