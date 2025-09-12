Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192FFCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 03:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwuhE-00073k-UJ; Thu, 11 Sep 2025 23:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwuh4-00071b-Va
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugs-0007wI-Aa
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3e249a4d605so1426334f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 20:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757648589; x=1758253389; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8jQCrxIz3Qwz5hNpEtd6AT11QHNqPX2j92aTBRs4Mbs=;
 b=EH5U3rJJ2FbPnsLmhogRY3fsTvX/tEU7A/7ozJ5pw6qeLSwi/HiEL/SbarCAlEAd00
 /9Ndq9wSGJWeit608tlD8SzQwbRSaivgGXeTaPew+CCN9JrbzCE1/328WlnXunwLuxWm
 gbLP9HmdRj4qCeeeiDVRGOz9GcRp9CKlTD3fdd7kdYgrw/3mapQwPqj7DpQGCPbXQd4W
 ZT5UU/TJyH/lMSyDemJojk9tfETXeNYjusIlw+6Ll8NaBktjYFPCXXnGtniEM3Fil3Et
 HAfPTRHeRAzG7HPF64jJt1qxcPAxMVUWgylsvulfP0r0FXOaXtEyOkNHs1HFV9RQFidG
 5qpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757648589; x=1758253389;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jQCrxIz3Qwz5hNpEtd6AT11QHNqPX2j92aTBRs4Mbs=;
 b=MJpUpigYeAU72Sx3Hte1qBbpQPxTotabQA9Pcdpl9nvatPF5MsZIp7wUhPmRpgTYjR
 cxfKtr7THTVzeldm1xconCUKTskV+zpYdjzZbmkSBq4QpVJ1+fWiQzmFN6CKOdGNX2m9
 TSUfrwsrRRIxi8na4ajoyvz8w4w51/P39rADQ6u7RS4eFAl6rMF82+IfEnBJueAilkR7
 L0pLj5zU3S+9a4w+GggT1VO68+XJhoLJM/JwvUC73NV8GcBWRBr8Dcg2pQb9Cz4KpKC3
 PJaI8vIx9unjiHIC/HI2LdIHwrh1EeBvCNiOwjX0TnZsURsz5FNzJKIlI6lohQ9iXfL2
 m72w==
X-Gm-Message-State: AOJu0Yxq8m5H0uPYKxHGrBqDSxAsKEp8uSskCGaZXndUHUjVav110zSe
 oMDdJFExvTbdk4K3+OwjJ9dlnnSvzAMjekbjv7019MlNLKcJh5Wbdp6j
X-Gm-Gg: ASbGnctkwHV4uBOvJBcSBMzv8UAa+yRs0rf2qe9JIk3jq/2f/G96ZDBTINGPOjZRbI5
 b+rIE+NG3bCBhDsnYP+mR5EPiRbdc/zLQYgO86tW4w/zi0eqayazRIYY+4dlsCyVI0dG1tXqh0C
 eD81vo592AqPrgZpzfoPuzeKL161WMjJtpHD9ZszGwLm/PFQH0J5PC+G/V9EaMEpXYl3kSJMQq5
 8XHsxeiBC+Pah9heSpaFbgnJ6J3rFGDdvv53GtUhdmVmW1J+tnZlcEEAbkdaldem1AhXWfahBo4
 dENEVwYVhdNFqaGOqZ2V/lHYYlNFlJUmPBhXt5W9DxF4BVBtd2wHMnMWhK6x8+6+Y3QAhSHEgxi
 X0e/q3bRO7uYL5DKHX74jvFGjy6CDMBPSUWGVo0Xw4MAdCWUk2WSn
X-Google-Smtp-Source: AGHT+IHG+YSU0F4heTQZ+7pGeURP7cj9uH7RPuUFghn3vuVy7mdn1//iqOOPLh5kVUgldCu7ev8sIQ==
X-Received: by 2002:a05:6000:40c9:b0:3e7:60fc:316f with SMTP id
 ffacd0b85a97d-3e765a01444mr1221993f8f.45.1757648588932; 
 Thu, 11 Sep 2025 20:43:08 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3e760786c95sm5039210f8f.17.2025.09.11.20.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 20:43:08 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Fri, 12 Sep 2025 05:39:53 +0200
Subject: [PATCH v4 08/10] virtio-serial-bus: add terminal resize messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-console-resize-v4-8-7925e444afc4@gmail.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
In-Reply-To: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648577; l=6138;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=euHDSiKfiPtR/UUkZ7M5sVkaScA8I5CFN1ajva2o9VY=;
 b=iUThZTt6OVb7iGTvlVLAN1+7XW3GPqL8MTJwe+T3DmMMtPPNyD6SDn9fT4DFLBKQThIGLBAiR
 OIerP45o9DgC1eFd+jmRckxQs67HYRPLjofnuKvqC1jkvpFG4MPfXfg
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x430.google.com
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 hw/char/trace-events              |  1 +
 hw/char/virtio-serial-bus.c       | 43 +++++++++++++++++++++++++++++++++++++--
 hw/core/machine.c                 |  4 +++-
 include/hw/virtio/virtio-serial.h |  5 +++++
 4 files changed, 50 insertions(+), 3 deletions(-)

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
index 673c50f0be08ef9b7142c16eaf8e6e31c7a00ca5..1d2963efcd74494a1f0d428f8ace0e72bb4c6647 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -260,6 +260,43 @@ static size_t send_control_event(VirtIOSerial *vser, uint32_t port_id,
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
+    trace_virtio_serial_send_console_resize(port->id, cols, rows);
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
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
+
+    } else if (virtio_vdev_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)) {
+        vser->port0_cols = cols;
+        vser->port0_rows = rows;
+        virtio_notify_config(vdev);
+    }
+}
+
 /* Functions for use inside qemu to open and read from/write to ports */
 int virtio_serial_open(VirtIOSerialPort *port)
 {
@@ -571,8 +608,8 @@ static void get_config(VirtIODevice *vdev, uint8_t *config_data)
     struct virtio_console_config *config =
         (struct virtio_console_config *)config_data;
 
-    config->cols = 0;
-    config->rows = 0;
+    config->cols = virtio_tswap16(vdev, vser->port0_cols);
+    config->rows = virtio_tswap16(vdev, vser->port0_rows);
     config->max_nr_ports = virtio_tswap32(vdev,
                                           vser->serial.max_virtserial_ports);
 }
@@ -1158,6 +1195,8 @@ static const Property virtio_serial_properties[] = {
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


