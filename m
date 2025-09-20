Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5580CAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 23:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v07Hk-00050y-3V; Sat, 20 Sep 2025 19:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07Hb-0004z0-Px
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HW-0006gG-KD
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso3935950f8f.1
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 16:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758411976; x=1759016776; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=owAQKcv5Ed6RgR5sBkiaGovxd3NJfl9ADFmjYXOuFLI=;
 b=e4YcJ9oUjz/rhg3mDkDtk3Ry+ywaDC50/F9tz5fDhSCD2LpRcyL/yQ15Ka2291+LKl
 uK59S1+piXI5XLcNtxMpiU8/0mQrv+vZ1FSRf72jcqSn4I13ncOkCzO7JH7EKnIbp8ZF
 nAOWapQJ7bo/FH7XGQnNErVz4kn6Ga1ccO8Tr9Ji4cDM6tX2Sg4yE9roqVbIO9V8ydH0
 q2840YhgxEecrzaajdtfIICT9QmZoHGAKoMv4iVKHR2Dq1HghWTd+kqvF59Dtz0EIlDR
 05Pu6AZ7USCgGxH4Kvklqz7eu+Sf0rgNCDbt8TH0Jm51qoJYB0P1Lm6W2ZEDA2306g4U
 fuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758411976; x=1759016776;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=owAQKcv5Ed6RgR5sBkiaGovxd3NJfl9ADFmjYXOuFLI=;
 b=hcWQ0y+jl6DPBL1SQ+bcPvz6EQTTavDu7uFRjzRkQOUDQq61bYFciu9FKap2Lmogbo
 9B6HhDUP8OLo0nGu9dvlP49iv8vyIV7DLFwVowBExZvF16YFDiMpfqN/N3DHohtJJxIy
 lRvaMU/P174jvhVFHVxbQWeezntHawZGyGe7DVY6gm77z4lA/ovBkysKLJw0tOEt8grF
 bUlpBLPi7kcP21FAp7p/JrZqv5QIAIUfBBqRQwuojf1v6jAM1ObLJpNG2QjbLaQ/Nlai
 3jHyoWyMhp+5CzUfyIJdrWfmwveuNIR2Vwlg9zKHffqgZG9eiNW8HXmOcPh0DHBPa9SP
 ZzvA==
X-Gm-Message-State: AOJu0Yzc5juyoz1vhVldrPNlgzQ+Lgej2oHvIyy3R15yBNZfkS8rRspD
 pjhIgQZdnSOGTKp82tM0KS165+qLxJoUcA4Wh40R1frvOukvNjkPLwO+
X-Gm-Gg: ASbGncv6JGM6vyrrHJWD4kPQNpBNhkhSRX0W5Sy78RqXkCDDxZMMEW4c49VCrbZic+i
 KIftFTK81eruvkYSd5f/2y7I57xaSpXjVD/FbOx5AfnO+nECZQen3cds1/jMXg6mrQ5IvRk0IyV
 GA5GVW52Ow/fq2KjsHRYl8xnxoW/axndjIEYHA9kpnLqFgVsR3vPpDBVFBOX8Cf+txCJwMoW4xA
 3jktWrIfVcRMkrckmCwa0pyIdayPp0OCv6GPx0zsK69pOfk9eZE+K+DmLYVycbewx5SoavQr/+I
 LHcX34mvrWERIVombo52pN7gTlAqQ7XxBnvYfrbTZqEH0BiU9AOzjq9vZVqfzQ5PealDb2zsnqM
 Ag5S/EQaOFIGzKegU+pnsErJyJlbXf/2UbCZoAz+ODmQ2ftko1b5ZEjyi97nxsBk=
X-Google-Smtp-Source: AGHT+IG9dd9hiXamlT6XfPnOPt0kvT6qLL7KhOaFydDvu3VdR5z73Df255k5ONUZZ+0HZpWmuAW43g==
X-Received: by 2002:a05:6000:2403:b0:3ee:1118:df7d with SMTP id
 ffacd0b85a97d-3ee87aca5b6mr6413258f8f.47.1758411975862; 
 Sat, 20 Sep 2025 16:46:15 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3ee0fc00a92sm13832486f8f.63.2025.09.20.16.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 16:46:15 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Sun, 21 Sep 2025 01:45:38 +0200
Subject: [PATCH RFC v5 08/12] virtio-serial-bus: add terminal resize messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-console-resize-v5-8-89e3c6727060@gmail.com>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
In-Reply-To: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758411962; l=6374;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=PCOI+I4SOE5dgkaa1pmUzz/E8GMzwCq7zEhUfTtRutY=;
 b=uk9IiXf6EIORc2EHp9QspsJuG8Ao+aDVtStmB4ARc/WnQrQq7WHlobmMnetLHgx8NRFvDIYAw
 ZZp/H9W3MwNDhrk2bQU2fKzY7nxpmiS5yLMT/AtTysDSlnGqBIutKbH
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x42d.google.com
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
List-Id: <qemu-devel.nongnu.org>
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

Implement the part of the virtio spec that allows to notify the virtio
driver about terminal resizes. The virtio spec contains two methods to
achieve that:

For legacy drivers, we have only one port and we put the terminal size
in the config space and inject the config changed interrupt.

For multiport devices, we use the control virtqueue to send a packet
containing the terminal size. Note that old versions of the Linux kernel
used an incorrect order for the fields (rows then cols instead of cols
then rows), until it was fixed by commit 5326ab737a47278dbd16ed3ee7380b26c7056ddd.

As a result, when using a Linux kernel older than 6.15, the number of rows
and columns will be swapped.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
[Filip: swap rows/cols, console-size affects multiport too,
        size config always updated, use use_multiport, move trace call]
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 hw/char/trace-events              |  1 +
 hw/char/virtio-serial-bus.c       | 51 +++++++++++++++++++++++++++++++++++++--
 hw/core/machine.c                 |  4 ++-
 include/hw/virtio/virtio-serial.h |  5 ++++
 4 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/hw/char/trace-events b/hw/char/trace-events
index 05a33036c12070242c2b193c19011839d623bec4..9a975ab1e2a525a9391d0f0a85ddbe80aa6361fc 100644
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
index 673c50f0be08ef9b7142c16eaf8e6e31c7a00ca5..30e3ec73a1733449b2505f231a3d2b3516ae4b4e 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -260,6 +260,51 @@ static size_t send_control_event(VirtIOSerial *vser, uint32_t port_id,
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
+void virtio_serial_send_console_resize(VirtIOSerialPort *port,
+                                       uint16_t cols, uint16_t rows)
+{
+    VirtIOSerial *vser = port->vser;
+    VirtIODevice *vdev = VIRTIO_DEVICE(vser);
+
+    if (!virtio_has_feature(vser->host_features, VIRTIO_CONSOLE_F_SIZE)) {
+        return;
+    }
+
+    trace_virtio_serial_send_console_resize(port->id, cols, rows);
+
+    if (port->id == 0) {
+        vser->port0_cols = cols;
+        vser->port0_rows = rows;
+        if (!use_multiport(vser) &&
+            virtio_vdev_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)) {
+            virtio_notify_config(vdev);
+        }
+    }
+
+    if (use_multiport(vser)) {
+        struct {
+            struct virtio_console_control control;
+            struct virtio_console_resize resize;
+        } buffer;
+
+        virtio_stl_p(vdev, &buffer.control.id, port->id);
+        virtio_stw_p(vdev, &buffer.control.event, VIRTIO_CONSOLE_RESIZE);
+        virtio_stw_p(vdev, &buffer.resize.cols, cols);
+        virtio_stw_p(vdev, &buffer.resize.rows, rows);
+
+        send_control_msg(vser, &buffer, sizeof(buffer));
+    }
+}
+
 /* Functions for use inside qemu to open and read from/write to ports */
 int virtio_serial_open(VirtIOSerialPort *port)
 {
@@ -571,8 +616,8 @@ static void get_config(VirtIODevice *vdev, uint8_t *config_data)
     struct virtio_console_config *config =
         (struct virtio_console_config *)config_data;
 
-    config->cols = 0;
-    config->rows = 0;
+    config->cols = virtio_tswap16(vdev, vser->port0_cols);
+    config->rows = virtio_tswap16(vdev, vser->port0_rows);
     config->max_nr_ports = virtio_tswap32(vdev,
                                           vser->serial.max_virtserial_ports);
 }
@@ -1158,6 +1203,8 @@ static const Property virtio_serial_properties[] = {
                                                   31),
     DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
                       VIRTIO_CONSOLE_F_EMERG_WRITE, true),
+    DEFINE_PROP_BIT64("console-size", VirtIOSerial, host_features,
+                      VIRTIO_CONSOLE_F_SIZE, true),
 };
 
 static void virtio_serial_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 38c949c4f2ce4a117cbfca62f56919711ce392b4..74a747ec6578c958b35e1f9712e5dbed7bca72e8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -37,7 +37,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_10_1[] = {};
+GlobalProperty hw_compat_10_1[] = {
+    { "virtio-serial-device", "console-size", "off" },
+};
 const size_t hw_compat_10_1_len = G_N_ELEMENTS(hw_compat_10_1);
 
 GlobalProperty hw_compat_10_0[] = {
diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
index d87c62eab7a270809daf47f932a73dd1fa3d5a6e..81efa853f804a52866890a9ec2c71bfbcabca4a0 100644
--- a/include/hw/virtio/virtio-serial.h
+++ b/include/hw/virtio/virtio-serial.h
@@ -187,6 +187,8 @@ struct VirtIOSerial {
     virtio_serial_conf serial;
 
     uint64_t host_features;
+
+    uint16_t port0_cols, port0_rows;
 };
 
 /* Interface to the virtio-serial bus */
@@ -221,6 +223,9 @@ size_t virtio_serial_guest_ready(VirtIOSerialPort *port);
  */
 void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle);
 
+void virtio_serial_send_console_resize(VirtIOSerialPort *port,
+                                       uint16_t cols, uint16_t rows);
+
 #define TYPE_VIRTIO_SERIAL "virtio-serial-device"
 OBJECT_DECLARE_SIMPLE_TYPE(VirtIOSerial, VIRTIO_SERIAL)
 

-- 
2.51.0


