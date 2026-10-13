Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55722CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcUd-0001td-FK; Tue, 13 Oct 2026 09:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUO-0001mW-PX
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUN-0004hb-6O
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q9R/V4zJAD6AdNxnCsAk9HsyJ3Cy/rTTuZWpPgNG94w=;
 b=RibJO5ec/tEbESis3hx98qPSNAxBNfyAVffFAny93nte6+o1P7oI9dth5I3amrkzxUBa3m
 MC9RLFAFNnAHdPREPQ9h1v/Lx9j8FybP1Zm0gNsh1z4VeNR/yjm8nCd0yH4QQPj82tHiNE
 i4cZv8Mw6g45XZQFk5Sm7fn3qLUhapA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-RjRgbwF3OQqCHjRM9SNAFA-1; Tue,
 13 Oct 2026 13:24:13 +0000
X-MC-Unique: RjRgbwF3OQqCHjRM9SNAFA-1
X-Mimecast-MFC-AGG-ID: RjRgbwF3OQqCHjRM9SNAFA_1791897851
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8036B195C25A; Tue, 13 Oct 2026 13:24:10 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DED430001B9; Tue, 13 Oct 2026 13:24:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:10 +0400
Subject: [GIT PULL 13/40] virtio-console: notify the guest about terminal
 resizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-13-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3503;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Gg6SBUmT73EGEO/wryPTu53u34iJhMH41iv5umUW3Tc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDCNuiY6GjUgRdqpsH+sy8Qr2Q3VSk/iXrsc
 QswCx4L1z6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwgAKCRDa6OEJdZac
 5exAEACSXvj/y4KxTRjURNMFeJiuQrsA6kIIzEIavM+/ILMm9dLbgOvCRae55n+QU/tZlD6OJ8s
 SvoK+bBKNZRNRlegXhWf3l7GFcv/EbCgkcLDksgZahs67gcrkebu6jis7Mv5gFm8Xrq729NBMwX
 PVcKEMzYYa32rIwtQz6dgLCjPKzMGQYg2xZVJE6q2kp/Jrso3qW0c0JXJ0/Xf1+wUrWg1t2rSwg
 QWOARy4Q7oP4zd+s1jMPDIRoKh6G2yHsNqVRZCZqYtk4Gfrz4XzfqWbvLs9Pen/rwsNaQoAuWby
 eRWFUHbSMSk1wSVXzBKGtQWKp3xIYW4R76w1YeX19Rhha3vWIUPRP8MQuB9Ij8ilAaomeYrctK9
 eGbqG8R4mJqwL/3kja49CI9do44GuW1bOdhiJc47zt76IIOTVgCT6xWhCTSEjEDyEJRxEiVczxK
 cXeyQLfYfxT0JPE1fEiVQuddJMtcDhkapJ0jGOwhE2E1a37L9xlABw39hSamzMNG+ca62pMn6YB
 FNvNMFAZYeOpCnDozfcQ4gEfLdk9t7ov2MhCd+yhbNTLpCQFf9WUV+QIwzduulgYySQrmWxk3jx
 Sz5Te3Pt+gSwwUgZ4Dtkhpf8AD837y6k1yH+2Ukg5NdFzmioXN9MFSagoohvYtPVUsVaQ/BKZaW
 X9vpVPOvgjMgphw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Szymon Lukasz <noh4hss@gmail.com>

If a virtio serial port is a console port, forward terminal resize
messages from the chardev backend to the guest.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
[Filip: rename things, remove logic that is now handled in virtio-serial-bus.c]
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261012-console-resize-v10-12-2c3b10d829b3@gmail.com>
---
 hw/char/virtio-console.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 36ad2ddc3f62..db9d8ca797f0 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -107,6 +107,15 @@ static ssize_t flush_buf(VirtIOSerialPort *port,
     return ret;
 }
 
+static void virtconsole_update_size(VirtIOSerialPort *port)
+{
+    uint16_t cols, rows;
+    VirtConsole *vcon = VIRTIO_CONSOLE(port);
+
+    qemu_chr_fe_get_winsize(&vcon->chr, &cols, &rows);
+    virtio_serial_resize_console(port, cols, rows);
+}
+
 /* Callback function that's called when the guest opens/closes the port */
 static void set_guest_connected(VirtIOSerialPort *port, int guest_connected)
 {
@@ -171,6 +180,23 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     }
 }
 
+static void chr_event_console(void *opaque, QEMUChrEvent event)
+{
+    VirtConsole *vcon = opaque;
+    VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(vcon);
+
+    trace_virtio_console_chr_event(port->id, event);
+    switch (event) {
+    case CHR_EVENT_OPENED:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_RESIZE:
+        virtconsole_update_size(port);
+        break;
+    default:
+        break;
+    }
+}
+
 static int chr_be_change(void *opaque)
 {
     VirtConsole *vcon = opaque;
@@ -179,7 +205,9 @@ static int chr_be_change(void *opaque)
 
     if (k->is_console) {
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                 NULL, chr_be_change, vcon, NULL, true);
+                                 chr_event_console, chr_be_change,
+                                 vcon, NULL, true);
+        virtconsole_update_size(port);
     } else {
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
                                  chr_event, chr_be_change, vcon, NULL, false);
@@ -207,7 +235,7 @@ static void virtconsole_enable_backend(VirtIOSerialPort *port, bool enable)
         VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
 
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                 k->is_console ? NULL : chr_event,
+                                 k->is_console ? chr_event_console : chr_event,
                                  chr_be_change, vcon, NULL, false);
     } else {
         qemu_chr_fe_set_handlers(&vcon->chr, NULL, NULL, NULL,
@@ -239,7 +267,7 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
          */
         if (k->is_console) {
             qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                     NULL, chr_be_change,
+                                     chr_event_console, chr_be_change,
                                      vcon, NULL, true);
             virtio_serial_open(port);
         } else {

-- 
2.56.0.116.g6de20f6092dc


