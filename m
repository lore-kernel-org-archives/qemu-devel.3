Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC1BCA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBasn-0005Ad-Nt; Tue, 29 Sep 2026 12:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasm-00059u-FT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:44 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBask-0006Nx-33
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:44 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffe817151so17990165e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790700041; x=1791304841; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l0PYHA6RrE88tZ77C1oINvZS756ml3SDfHa/y09NmKo=;
 b=L1s3NeGB65VM0BkDRe4NmWTuodgfoDkonjpscO6V2Ph9/Z9D50p8khrGaNTW47zpQP
 WHS7IkIg1D0jcn4Pcmw0GBLazDJNzNFgv36ycSLajkOBIpdLfDUMdcjx+XGsdzbqpfsf
 5siXWQlUXWV2nRM+VaOYVv1A/AEvwrUyCFBh01ElhujgFHxKTzN44gVkwz61YJ4NZ1b8
 vjnEgbJBSfPr09X9Ryjzl0W/NcGKpDTv9Nh73nqVM8MvdHqIZ/PvtYchHoJ/JtlrgPXO
 GwhAEQ9inBT1hB505aAPt6gVXIv8GalK3wffxc/SedE19KWRpnkYHZ654KtzHxSJxzGB
 X+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790700041; x=1791304841;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l0PYHA6RrE88tZ77C1oINvZS756ml3SDfHa/y09NmKo=;
 b=X93Qswu2gIxwmyx9bHYMvw1n43HPeWNVVlDprqde0bObDwKBos/gr1sM15NXoMFwrI
 Y5DdBarUSOLtSRCtnO9kPAPSa6siFNyX0Ox3qv44ecw6uDAbEdvwdW2ODgSXJTS1Xekl
 nhebM6Vvk81onr+udwLv1o+bTGdl53aqpHcc+LYd2mINSUYXo9Ts2RzsKmpJctWGO34M
 erfxJu0+d7EqM5mSwZ3Xo0jDTnMpHx3becvWcHJNohe/xz5bf9ox8dqdtbJFjITx/a/J
 xGoFcs7MsDZ7qRRxFG14p9P9SLDIZ0TJyjwSqNyrZGaShCbpJ0DyHxphX1fX6nKm76q7
 SZxw==
X-Gm-Message-State: AFuF++k8Y13JDaEEuP5heXepP64cAF/qXvEekbCHPgWv9gyNbz8dzO7t
 sDamtZqgfp5we8sv9SNAC5i6yc8Mmrzrg3cDHrBz/NHh3ZSoPzPdafml
X-Gm-Gg: AYBFou09IkmD7W+6Kd+q+XUNBF5u3zcPNmY73Lv83EaG34ATfG1c+vx37LTZlJioiyx
 9cqP7kh59usyfAYSicPKn3VWPWYcIPb1dVN2V+oUQ47cIiBdHVgtBGow8egDfxplLH7OH0U+wI6
 z0+JOYZFBJSiCq+8WseeDwqRXssT7JrjDF1oqsPh5DU23as9kBDuYZnWH81zQ1kBRSb+BKd0MsN
 gmmGpT4tE9Uh5TfauNCqC/EpI1N5SisG+xrzEktY9eEHqeoCJ/4Z2oX9IBIIshuuDOqz5jwo1Rz
 m3pq4mbRX9J1lfC660D+OAl8xJpfWNhuiM1x66h3ZrXhaQLmOcxGfix2ock/xDzMGvJzIuRPaGj
 Be2Mc1Qd6DZFldgVXSh5vpD46VyM2GpoZI3IsuxcPU1sv+Xi43la2iB3vJR5aTovMaIBvSZXtKt
 IIE5FMgtXqMdoe8qw52c1FToM1ecHu6KuGmNn0iCZeHvz+Xzo0SaTosAYofkXUYJt61FXULkpV/
 LNCuo8WcmzRS9zudlBJhaIq7AA=
X-Received: by 2002:a05:600d:8653:10b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-49fe70151ebmr217698515e9.9.1790700040640; 
 Tue, 29 Sep 2026 09:40:40 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a014951f24sm30715e9.1.2026.09.29.09.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:40:40 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 29 Sep 2026 18:38:39 +0200
Subject: [PATCH v8 11/12] virtio-serial-bus: add terminal resize messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-console-resize-v8-11-2ff9183f8750@gmail.com>
References: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
In-Reply-To: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
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
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790700030; l=7998;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=W6Ngl+5uqHdlNcDJIkFBYbNYDzHwfMLxTQr45thgrTw=;
 b=hsZK1cPCRG+4bTKUVQWb/BuhM8dpqeaENJhB0kNC76Wh3v/wPsf4szj+jFK+x+mmPQPFqH6Kw
 gt2o/BZfYF7CpjxDfs99NSCKtifteecqNXtLhlxHDz16J090+TVrNce
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm2-x11.google.com
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
index c36e18a4cf..882765ac88 100644
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
2.55.0


