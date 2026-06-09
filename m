Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53FBCD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1we-00067o-JA; Tue, 09 Jun 2026 15:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wa-00065A-I2
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:17:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wY-0006Rt-2t
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490c1915793so40645185e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781032616; x=1781637416; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R1ZZAoljY9LdKgDA6VF2zEzprsuGdMG5+tOF++0esww=;
 b=pqpBoWY5PwBzaj1INwRLqhVyK3XlAjCIiEP85QSM447qluv/hUPdKJUxAYkh3NS2+b
 HXlsn3SuE3Q8ZjfBjszq14IuG4P/tAHbrJgUK1d4aY46SQDUDQ1IPKSCzbQsdrEEBsC4
 DPULGCE8mq/uB5lxgZAsLKEcsXjz3n0Chf+ZrL3r3AjkKPQkW27Nb8+iGz5hZPpucPdU
 UmgZA9fi7xIbzQXGfFj35vFEaGgPVYB2BsInDZisJs8LKtV30MXDx+JDKcWODSByEKYy
 mXNbYpbfyoTSf8nkZSwc/TLmQiAvdlojZ8zujOXfvcDRgVka5I7zWQSwJb4qH79/DbzG
 K9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032616; x=1781637416;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R1ZZAoljY9LdKgDA6VF2zEzprsuGdMG5+tOF++0esww=;
 b=k7LtOSmBD4dqWvVmHj/c8ZvdUwwoUz8VQV0YMpLpZq3bjHapGBnoTrmvMOAgA3KSZE
 MmYns2+WVGoG64ue/GYVMpyJyvqHvkfI00TjJE798+QTjptaa6hd0fGj2gHgdwBRb9GG
 T1t7PZblk2eJvfpj37rI/QJ5tCixIb4BZx2A56/LBoh2QF+MZH2K7OgRdsLCnY5bxlIM
 8z/Xp6J8WXyRDETMmhi7nIOYFlW/c+elpbnKKnsREQlhdETEGg34I5KfuCRzqHeF6XZI
 +w0608JH7fXpYt87dj2ncrktlkgoOkpfxyhv8fumIzGzLG+eRk2GnmPeL8uZuuO2ivOp
 nkuA==
X-Gm-Message-State: AOJu0YzfN/kxktotnKdy/zbmHaeeo/Vg++bO+oTrTYWRirc2ochCBLAR
 x0NOj0fzy8qG90TsQ3q99QrS9KEhe+zuIy6RUeFf1PNjDvW3kfSPpM+c
X-Gm-Gg: Acq92OE/Jwj+eOCRtXE2PQzA5U1+TGP9asKfoxMDitrYYGZxY2z96PQmn9Yq9MDrLDq
 q98ZijCmZcsx3yoZvBVvEm2NPOKyiqAfIezPR3ckSvixC0JKJkN9nwEf9I6969w1R4NtvK0eYhF
 6fnc1te1WL0REEjqbNk9/dcHoJ3EixLhRlKALVtt/bkUHZXOps/9avMixPwOzJoGc49xqzdvCEW
 an2mNzotvr3Qn/MtOcByvduox8LUNh+IcWZk4zt9Va05is0nB81x2FL5y7wvJVOqd9H/qcQm5Fe
 HVIRtfprkS4POkd9tqBWo+zShB6OdObMafVrC8eYkARLuoh8swXlnyTLKUXP+BPavTG7peyAG/D
 f/zfJFludzI3mSaWMTxsEYjKAuw5TeNYfEP3efjXCdZLLNFHb9JrlnwWOXU9Cj7pUSrlfRC8ubV
 UuEe6q5urhgGTfwJ5g0SsnY6txxG+1Dry8VNT0yuBcbz8jrC1FiDZ7Tkq7v+d4uKE=
X-Received: by 2002:a05:600c:34cb:b0:490:4b89:5361 with SMTP id
 5b1f17b1804b1-490c25afa03mr347008385e9.7.1781032616460; 
 Tue, 09 Jun 2026 12:16:56 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46028a6dcbdsm53026696f8f.7.2026.06.09.12.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:16:56 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 09 Jun 2026 21:16:21 +0200
Subject: [PATCH v7 11/12] virtio-serial-bus: add terminal resize messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-console-resize-v7-11-0c550fdcec15@gmail.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
In-Reply-To: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781032602; l=8016;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=Y8P6NoW4mR1gnJTshCWApS9hxNntWjZ0ipmI52G4ISI=;
 b=v3L0ODSNgufTyYoNQ9OIs2vbh+CGF6j1jwYaZleNZXsmB5TVbGfbFMA1V14sUOqj//8EQuxoQ
 skyivIZIe6zAoGr2slwYWNK2OX+YRyZgfjSmqIIoJwch4SEacreWShH
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
---
 hw/char/trace-events              |  1 +
 hw/char/virtio-serial-bus.c       | 81 ++++++++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-serial.h |  7 ++++
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/hw/char/trace-events b/hw/char/trace-events
index a3fcc77287..e387c8853f 100644
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
index cd234dc6db..a31e80cfde 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -260,6 +260,68 @@ static size_t send_control_event(VirtIOSerial *vser, uint32_t port_id,
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
+        } buffer;
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
@@ -408,6 +470,7 @@ static void handle_control_message(VirtIOSerial *vser, void *buf, size_t len)
          */
         if (vsc->is_console) {
             send_control_event(vser, port->id, VIRTIO_CONSOLE_CONSOLE_PORT, 1);
+            send_console_resize(port);
         }
 
         if (port->name) {
@@ -557,6 +620,7 @@ static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
 
     vser = VIRTIO_SERIAL(vdev);
 
+    features |= vser->host_features;
     features |= BIT_ULL(VIRTIO_CONSOLE_F_EMERG_WRITE);
     if (vser->bus.max_nr_ports > 1) {
         virtio_add_feature(&features, VIRTIO_CONSOLE_F_MULTIPORT);
@@ -568,11 +632,18 @@ static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
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
@@ -735,6 +806,10 @@ static void virtio_serial_post_load_timer_cb(void *opaque)
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
@@ -1151,6 +1226,8 @@ static const VMStateDescription vmstate_virtio_console = {
 static const Property virtio_serial_properties[] = {
     DEFINE_PROP_UINT32("max_ports", VirtIOSerial, serial.max_virtserial_ports,
                                                   31),
+    DEFINE_PROP_BIT64("console-size", VirtIOSerial, host_features,
+                      VIRTIO_CONSOLE_F_SIZE, false),
 };
 
 static void virtio_serial_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
index da0c91e1a4..bda6d5312a 100644
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
2.54.0


