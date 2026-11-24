Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BC8606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aWdfTOoX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVl7R-0001XI-4v; Tue, 24 Nov 2026 02:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xVl7P-0001XA-Ne
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:39:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xVl7N-0006MZ-LW
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795505947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4mF++8ngePl8M3F+ojz+ryTaw7Z9F3O1xBU5VrCMi3g=;
 b=aWdfTOoXadoY+NH42EOAHtFLXT2d/8rCy9CZjuDIgfyA6069pYM0NaPB2Tb2wrsN2f9ZxF
 EqDdaoCejMIPvTHhlRrY7yWqvJQSnFVz0Vo66hHeJ3CsU92yhH/TlbhoFqu962SBreBy2J
 k99ge160eG9PCEiV8yg6tTUlJf2Mj9Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-RegUca3DNfKbehKVsrNMBQ-1; Tue,
 24 Nov 2026 07:39:03 +0000
X-MC-Unique: RegUca3DNfKbehKVsrNMBQ-1
X-Mimecast-MFC-AGG-ID: RegUca3DNfKbehKVsrNMBQ_1795505942
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0022D1956042; Tue, 24 Nov 2026 07:39:01 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DA41195B3C2; Tue, 24 Nov 2026 07:38:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3] hw/char/virtio-serial: return throttled descriptor on port
 close
Date: Tue, 24 Nov 2026 11:38:58 +0400
Message-ID: <20261124073857.3582931-2-marcandre.lureau@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/virtio-serial-bus.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 7fe90571249f..264bf60beb41 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -158,6 +158,21 @@ static void discard_throttle_data(VirtIOSerialPort *port)
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
+        virtio_notify(VIRTIO_DEVICE(port->vser), port->ovq);
+    }
+}
+
 static void do_flush_queued_data(VirtIOSerialPort *port, VirtQueue *vq,
                                  VirtIODevice *vdev)
 {
@@ -345,7 +360,7 @@ int virtio_serial_close(VirtIOSerialPort *port)
      * consume, reset the throttling flag and discard the data.
      */
     port->throttled = false;
-    discard_throttle_data(port);
+    return_throttle_data(port);
     discard_vq_data(port->ovq, VIRTIO_DEVICE(port->vser));
 
     send_control_event(port->vser, port->id, VIRTIO_CONSOLE_PORT_OPEN, 0);
-- 
2.56.0.116.g6de20f6092dc


