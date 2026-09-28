Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4528ACA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDFw-0002te-G4; Mon, 28 Sep 2026 11:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xBDFu-0002tO-5K
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xBDFs-00033Y-OA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790609217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QSepLCYcLHkYw6JhqFJ4Yq2ksiR5+lE5XyHbC0U6GAs=;
 b=cNoRqDSrI/P9XcD2yByK/xQoeiaMcF3WJRBW76gRw2kpYbyUBad9hnuxrrUG+rRIZtTf+V
 QO3eBxarxpOVpn/6SNJW7x3sG9fvV99ojjNQ8g2TSvadVyc9+g/jnt6rvPtCRrEef7pcpy
 qQSBGn8L9VSmGcQraRm/QpgsyvGS5EI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-ZFvAbd_ZNxaspmAieGgf3g-1; Mon,
 28 Sep 2026 11:26:53 -0400
X-MC-Unique: ZFvAbd_ZNxaspmAieGgf3g-1
X-Mimecast-MFC-AGG-ID: ZFvAbd_ZNxaspmAieGgf3g_1790609212
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B37C4195FCD5; Mon, 28 Sep 2026 15:26:52 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 517CB30000E7; Mon, 28 Sep 2026 15:26:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] hw/char/virtio-serial: return throttled descriptor on port
 close
Date: Mon, 28 Sep 2026 19:26:48 +0400
Message-ID: <20260928152648.249959-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When the host chardev disconnects while the output queue is throttled,
virtio_serial_close() calls discard_throttle_data() which detaches the
in-flight element with virtqueue_detach_element(). This silently removes
the descriptor without placing it on the used ring, so the guest never
sees the write complete and the descriptor leaks.

Add return_throttle_data(), which pushes the element back via
virtqueue_push() instead of detaching it, and call it from
virtio_serial_close().

Fixes: d4c19cdeeb2f ("virtio-serial: add missing virtio_detach_element() call")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/virtio-serial-bus.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 623e9f17a83e..008cad1b625c 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -158,6 +158,20 @@ static void discard_throttle_data(VirtIOSerialPort *port)
     }
 }
 
+/*
+ * Return a partial element held back by throttling to the guest via
+ * the used ring, so the guest driver can reclaim the descriptor.
+ * Unlike discard_throttle_data() this must be used when the virtqueue
+ * stays live (port close) rather than being reset.
+ */
+static void return_throttle_data(VirtIOSerialPort *port)
+{
+    if (port->elem) {
+        virtqueue_push(port->ovq, port->elem, 0);
+        g_clear_pointer(&port->elem, g_free);
+    }
+}
+
 static void do_flush_queued_data(VirtIOSerialPort *port, VirtQueue *vq,
                                  VirtIODevice *vdev)
 {
@@ -283,7 +297,7 @@ int virtio_serial_close(VirtIOSerialPort *port)
      * consume, reset the throttling flag and discard the data.
      */
     port->throttled = false;
-    discard_throttle_data(port);
+    return_throttle_data(port);
     discard_vq_data(port->ovq, VIRTIO_DEVICE(port->vser));
 
     send_control_event(port->vser, port->id, VIRTIO_CONSOLE_PORT_OPEN, 0);
-- 
2.56.0.rc0.29.g47ce80527c56


