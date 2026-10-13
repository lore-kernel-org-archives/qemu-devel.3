Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B17CCC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcUu-0002U6-EI; Tue, 13 Oct 2026 09:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUP-0001mb-J1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUN-0004hk-OW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yABWt6wtPynIMMvCnBpk1ucRQg6G8nj+vDawAMDsozA=;
 b=XS42oLn3q6tQ6+WgrTaB4o9jT811IeW/z8Yh5bZPLEH1NxvIacX43t7DmetOYsw/w5ewzH
 HjXm59H5pV8jhLmrz/YCBqd9yHpaJ87aegp2xJrboSnPRMB8gKo8VPeJo86Wzmyh1SFIjz
 JJ/prOIFHXk68IxfpvHXX6hEukXeJGo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-GEUDQ8LyOwmY_w4iT4oCmQ-1; Tue,
 13 Oct 2026 13:24:09 +0000
X-MC-Unique: GEUDQ8LyOwmY_w4iT4oCmQ-1
X-Mimecast-MFC-AGG-ID: GEUDQ8LyOwmY_w4iT4oCmQ_1791897848
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80F0A1865FCD; Tue, 13 Oct 2026 13:24:06 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 598B61800446; Tue, 13 Oct 2026 13:24:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:09 +0400
Subject: [GIT PULL 12/40] virtio-serial-bus: add terminal resize messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-12-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8207;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xih0uhpUFA9eXPGrEHxDpEzhNSvKkeoSxrJsnewhYOM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDCPfHc40lM5dxYwwfjn+0NhRRCkrx9OlE17
 Z+VYkGqw3iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwgAKCRDa6OEJdZac
 5R2TD/9HC7ZZgocxx41fzLjkI8u+hejT8n9nq8DiAmGVNMkCCAlYeYcyhY7ZDtk396/5Q+O7Vcj
 gxxmciAdC60UOiUZ6U4gJ3duH0ycdwGA3fmSRB/ojJZR/SlVrPxb+fq5JzgKYbrZ4ubqaqikDl1
 4qLPCGz5YKkLZlSm5wkAWfsiDawG68bqt7l/4agszRo87rK0eRSgMv36Tu7ZlSIvYGk1WFSiuPf
 WzV3uVXFZmd4U3TZrpZkANUEsdr5BTKLQlAfVkOLzZShYz439FbgkJjzxnwoNYssKcVEcFVySes
 hQJQIxl0BNdNpL0knLG3RSfHFOvoUDSdJt/jlKpx1ikQblQTVcbUnz4NcFiPgpQFmPN8oz1EGgX
 cSYnYrc24w79AIfwAJBioVx2n7gPdiRjoOpX9IwjpgSQeW8uq/cDYQ5ivJ7/E9vLBZEMZNKSbq9
 VysOpKq7nTcli13QhbKZ1BU38UlV+MAhDdcAlqt9ZCzH9vbmQF2kUnNQ+qSs49I+Bd8NQdGtF6W
 ylX2UM9anPK7Ldxe7G9chnYrtvrqqTAxyguV9v+D2huO5JGpW2CkJ24HSl930jwXmhKQauLbqgB
 KU3KE3lpkA7Y9hoT7MFUzCqTeZ6/Fxfe/hLe533LejmGOg3Lw4QGEOaXQVSVDUF7U58J14iNEtH
 RPcfWIaFepdEVfw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Filip Hejsek <filip.hejsek@gmail.com>

Implement the part of the virtio spec that allows to notify the virtio
driver about terminal resizes. Gate the new resize support behind the
console-size property, which defaults to off. To implement the property,
restore VirtIOSerial::host_features (previously removed by commit
d0660e5b7fc7e97926232d13d2500a16df32b310).

The virtio spec contains two methods to inform the guest about console
size:

For legacy drivers, we have only one port and we put the terminal size
in the config space and inject the config changed interrupt.

For multiport devices, we use the control virtqueue to send a
packet containing the terminal size. Unfortunately, old versions
of the Linux kernel used an incorrect order for the fields (rows
then cols instead of cols then rows), until it was fixed by commit
5326ab737a47278dbd16ed3ee7380b26c7056ddd. As a result, when running an
old guest kernel, the number of rows and columns will be swapped.

Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.com>,
but partially rewritten to fix various corner cases.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261012-console-resize-v10-11-2c3b10d829b3@gmail.com>
---
 hw/char/trace-events              |  1 +
 hw/char/virtio-serial-bus.c       | 81 ++++++++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-serial.h |  7 ++++
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/hw/char/trace-events b/hw/char/trace-events
index a3fcc772877a..e387c8853fcf 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -11,6 +11,7 @@ serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop
 
 # virtio-serial-bus.c
 virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
+virtio_serial_send_console_resize(unsigned int port, uint16_t cols, uint16_t rows) "port %u, cols %u, rows %u"
 virtio_serial_throttle_port(unsigned int port, bool throttle) "port %u, throttle %d"
 virtio_serial_handle_control_message(uint16_t event, uint16_t value) "event %u, value %u"
 virtio_serial_handle_control_message_port(unsigned int port) "port %u"
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index c36e18a4cfb5..882765ac88ab 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -261,6 +261,68 @@ static size_t send_control_event(VirtIOSerial *vser, uint32_t port_id,
     return send_control_msg(vser, &cpkt, sizeof(cpkt));
 }
 
+/*
+ * This struct should be added to the Linux kernel uapi headers
+ * and later imported to standard-headers/linux/virtio_console.h
+ */
+struct virtio_console_resize {
+    __virtio16 cols;
+    __virtio16 rows;
+};
+
+static void send_console_resize(VirtIOSerialPort *port)
+{
+    VirtIOSerial *vser = port->vser;
+    VirtIODevice *vdev = VIRTIO_DEVICE(vser);
+
+    if (!virtio_has_feature(vser->host_features, VIRTIO_CONSOLE_F_SIZE)) {
+        return;
+    }
+
+    trace_virtio_serial_send_console_resize(port->id, port->cols, port->rows);
+
+    if (use_multiport(vser)) {
+        struct {
+            struct virtio_console_control control;
+            struct virtio_console_resize resize;
+        } buffer = {};
+
+        virtio_stl_p(vdev, &buffer.control.id, port->id);
+        virtio_stw_p(vdev, &buffer.control.event, VIRTIO_CONSOLE_RESIZE);
+        virtio_stw_p(vdev, &buffer.resize.cols, port->cols);
+        virtio_stw_p(vdev, &buffer.resize.rows, port->rows);
+
+        send_control_msg(vser, &buffer, sizeof(buffer));
+    }
+}
+
+void virtio_serial_resize_console(VirtIOSerialPort *port,
+                                  uint16_t cols, uint16_t rows)
+{
+    VirtIOSerial *vser = port->vser;
+    VirtIODevice *vdev = VIRTIO_DEVICE(vser);
+
+    if (port->cols == cols && port->rows == rows) {
+        return;
+    }
+
+    port->cols = cols;
+    port->rows = rows;
+
+    if (port->id == 0 && !use_multiport(vser) &&
+        virtio_vdev_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)) {
+        virtio_notify_config(vdev);
+    }
+
+    /*
+     * We will send these messages even before we told the guest that
+     * it is a console port (by sending VIRTIO_CONSOLE_CONSOLE_PORT
+     * message), but that should be fine as the guest will likely
+     * ignore them.
+     */
+    send_console_resize(port);
+}
+
 /* Functions for use inside qemu to open and read from/write to ports */
 int virtio_serial_open(VirtIOSerialPort *port)
 {
@@ -403,6 +465,7 @@ static void handle_control_message(VirtIOSerial *vser,
          */
         if (vsc->is_console) {
             send_control_event(vser, port->id, VIRTIO_CONSOLE_CONSOLE_PORT, 1);
+            send_console_resize(port);
         }
 
         if (port->name) {
@@ -538,6 +601,7 @@ static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
 
     vser = VIRTIO_SERIAL(vdev);
 
+    features |= vser->host_features;
     features |= BIT_ULL(VIRTIO_CONSOLE_F_EMERG_WRITE);
     if (vser->bus.max_nr_ports > 1) {
         virtio_add_feature(&features, VIRTIO_CONSOLE_F_MULTIPORT);
@@ -549,11 +613,18 @@ static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
 static void get_config(VirtIODevice *vdev, uint8_t *config_data)
 {
     VirtIOSerial *vser = VIRTIO_SERIAL(vdev);
+    VirtIOSerialPort *port;
     struct virtio_console_config *config =
         (struct virtio_console_config *)config_data;
 
-    config->cols = 0;
-    config->rows = 0;
+    port = find_port_by_id(vser, 0);
+    if (port) {
+        config->cols = virtio_tswap16(vdev, port->cols);
+        config->rows = virtio_tswap16(vdev, port->rows);
+    } else {
+        config->cols = 0;
+        config->rows = 0;
+    }
     config->max_nr_ports = virtio_tswap32(vdev,
                                           vser->serial.max_virtserial_ports);
 }
@@ -716,6 +787,10 @@ static void virtio_serial_post_load_timer_cb(void *opaque)
                                port->host_connected);
         }
         vsc = VIRTIO_SERIAL_PORT_GET_CLASS(port);
+        /*
+         * TODO: let the guest know about new console size if it has changed
+         * (this will require sending old size in the migration stream)
+         */
         if (vsc->set_guest_connected) {
             vsc->set_guest_connected(port, port->guest_connected);
         }
@@ -1142,6 +1217,8 @@ static const VMStateDescription vmstate_virtio_console = {
 static const Property virtio_serial_properties[] = {
     DEFINE_PROP_UINT32("max_ports", VirtIOSerial, serial.max_virtserial_ports,
                                                   31),
+    DEFINE_PROP_BIT64("console-size", VirtIOSerial, host_features,
+                      VIRTIO_CONSOLE_F_SIZE, false),
 };
 
 static void virtio_serial_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
index da0c91e1a403..bda6d5312af6 100644
--- a/include/hw/virtio/virtio-serial.h
+++ b/include/hw/virtio/virtio-serial.h
@@ -145,6 +145,9 @@ struct VirtIOSerialPort {
     bool host_connected;
     /* Do apps not want to receive data? */
     bool throttled;
+
+    /* Terminal size reported to the guest.  Only used for consoles. */
+    uint16_t cols, rows;
 };
 
 /* The virtio-serial bus on top of which the ports will ride as devices */
@@ -186,6 +189,8 @@ struct VirtIOSerial {
     struct VirtIOSerialPostLoad *post_load;
 
     virtio_serial_conf serial;
+
+    uint64_t host_features;
 };
 
 /* Interface to the virtio-serial bus */
@@ -220,5 +225,7 @@ size_t virtio_serial_guest_ready(VirtIOSerialPort *port);
  */
 void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle);
 
+void virtio_serial_resize_console(VirtIOSerialPort *port,
+                                  uint16_t cols, uint16_t rows);
 
 #endif

-- 
2.56.0.116.g6de20f6092dc


