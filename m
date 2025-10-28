Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31557CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlYj-0007aA-VT; Tue, 28 Oct 2025 11:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDlYh-0007Z1-8R
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:24:27 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDlYV-0001Nk-RW
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:24:25 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-592fcf7a1ceso5473672e87.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761665047; x=1762269847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIsOX/4l3/jVdB7kFcqrxxVnf99gG5xQHvX6wvWatmQ=;
 b=nPoj+eNIF9RgQGjACGGDMpVaSdqQ2dDk4KzZNdn0sNaJCFgj1Eb0hnSGjNFQ3nBP25
 wBBsV2fTInGY2nUHJSXdW+dEF8FAlnGtCj/XEgC7ncRrTPzfhMmLpTebZcYXeC0+X9m9
 mzo/lnUnNkumGpBEfaNn+U+7ZloRdA/Xsad5Ayh+9Ildc5zftI0dsCJ86KllHiGGQuRD
 NjJnAnMgQJnK0DmSV7sQoQ3HphAq7mcAg0N0t07VD6FGa64klVcw15Vwjv/jW40XVvcz
 Xkw5+9WfJLu8rJq2MHPCSLHLspP2mc0QQniuEe1i0dtndT82ZCBs81oFbUjKiaOQy4o0
 0tGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761665047; x=1762269847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIsOX/4l3/jVdB7kFcqrxxVnf99gG5xQHvX6wvWatmQ=;
 b=DQNQmPRw4Jr9nLWDVknedtpnWOzdAwtzyhcwHfEptQ7+3MxqQsikLOFiAR/TfY8sTi
 JNuLnXY9RD/16yEwELJRUIhBfuC4De8PiX7nWWjJiDQbz4MqVWRt3nJ3/hJhis+YhtbP
 DKRvua9LB9w3ok6ptAjP1qrW3/0qbnbjEONXjI51A7c6CCqt/N8/yAEeinAAGZkA/jCU
 7jXjaTTj4cNhCmLr0ZXQLFU5KTXtegtSrA/nhs738mK6CHQMC+oI09PKBAG9Mmq8VmuH
 1E+NGP8b8i0H0n4ZmnjvrSk7g/DfyCmg7ho1gHHBb5VWKKy5Nnb8bYgukFd8EIQM39rR
 7Yjw==
X-Gm-Message-State: AOJu0Yx2R+LDGRBeuNQRaq2QRt8rvrltgxISi/wnytkjn+WA3IA4GOqS
 jgS2QP+jBh70jEq4XAFKywzJYGOEVjl0kAmzOQRsV87sSTP4CLy3Kh6hJgUM25aoGM7WMA==
X-Gm-Gg: ASbGncuDhLp4OgT1BubiX9uL/lkqM91Ztf0ws4stx15W5iNqtIVkLKdA9Mfdy4eueve
 APoJh7O2/BWDNozDsBzE3txRUZnEz+KKC2RA0r2pCQDQFN6tMSi1qMwaDUBzWSKpmEF2bpUEMqL
 2u2gvmekNKRVQxQIw2qpXYFcbTq4zeN1Nh9cBOsjQNZiWbn+JfKeapTsuiBCkmAnzGPUXx6apzU
 jYksaJArNn03oV6Zq9YD3wq4UoBRhlB/1JmUao7RVm42znhpTrXU+OcMtEdxeF/Iu1pbON5x3Tf
 +NzYKbkUnbiWIgUzyb0qz48nN3Adwm8vxqFf9VEQBCTLAWnXHpKfKv6xPJdLMZxdWrpIk87+iaV
 oWjDImzkBsFOXg3Jq387tl7JGU3SPJ6dAaW4rZ+2f7bng8ojdan+mpP2dxvEO7fIeTdB6wFCcdZ
 m2JLF6sQJBtCLPDyoeXm6I4zlO/AC+YT9ouHj+
X-Google-Smtp-Source: AGHT+IHzW8KpLU/Tnapstgw9lqzXCoWox4BRk8FW7Gx1m+AqjwG6UmCkw/jEiyPU7Oop7a+rxdOHXA==
X-Received: by 2002:a05:6512:696:b0:592:fb96:2af8 with SMTP id
 2adb3069b0e04-5930e9e6d9dmr1584987e87.51.1761665046521; 
 Tue, 28 Oct 2025 08:24:06 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59301f50661sm3067968e87.33.2025.10.28.08.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 08:24:05 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: alex.bennee@linaro.org,
	bill.mills@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v1 3/5] virtio: Add the virtio-msg transport
Date: Tue, 28 Oct 2025 16:23:48 +0100
Message-ID: <20251028152351.1247812-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
References: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add the new virtio-msg transport together with a framework
for virtio-msg buses.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/virtio/Kconfig                   |   4 +
 hw/virtio/meson.build               |   5 +
 hw/virtio/virtio-msg-bus.c          |  89 +++
 hw/virtio/virtio-msg.c              | 695 +++++++++++++++++++++++
 include/hw/virtio/virtio-msg-bus.h  |  95 ++++
 include/hw/virtio/virtio-msg-prot.h | 846 ++++++++++++++++++++++++++++
 include/hw/virtio/virtio-msg.h      |  56 ++
 7 files changed, 1790 insertions(+)
 create mode 100644 hw/virtio/virtio-msg-bus.c
 create mode 100644 hw/virtio/virtio-msg.c
 create mode 100644 include/hw/virtio/virtio-msg-bus.h
 create mode 100644 include/hw/virtio/virtio-msg-prot.h
 create mode 100644 include/hw/virtio/virtio-msg.h

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 10f5c53ac0..d2d8c475b2 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -26,6 +26,10 @@ config VIRTIO_MMIO
     bool
     select VIRTIO
 
+config VIRTIO_MSG
+    bool
+    select VIRTIO
+
 config VIRTIO_CCW
     bool
     select VIRTIO
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index affd66887d..7944bbb652 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -13,6 +13,11 @@ specific_virtio_ss = ss.source_set()
 specific_virtio_ss.add(files('virtio.c'))
 specific_virtio_ss.add(files('virtio-qmp.c'))
 
+specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MSG', if_true: files(
+    'virtio-msg.c',
+    'virtio-msg-bus.c',
+))
+
 if have_vhost
   system_virtio_ss.add(files('vhost.c'))
   system_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
diff --git a/hw/virtio/virtio-msg-bus.c b/hw/virtio/virtio-msg-bus.c
new file mode 100644
index 0000000000..e907fd64ec
--- /dev/null
+++ b/hw/virtio/virtio-msg-bus.c
@@ -0,0 +1,89 @@
+/*
+ * VirtIO MSG bus.
+ *
+ * Copyright (c) 2024 Advanced Micro Devices, Inc.
+ * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/virtio/virtio-msg-bus.h"
+
+bool virtio_msg_bus_connect(BusState *bus,
+                            const VirtIOMSGBusPort *port,
+                            void *opaque)
+{
+    VirtIOMSGBusDevice *bd = virtio_msg_bus_get_device(bus);
+
+    if (!bd) {
+        /* Nothing connected to this virtio-msg device. Ignore. */
+        return false;
+    }
+
+    bd->peer = port;
+    bd->opaque = opaque;
+    return true;
+}
+
+void virtio_msg_bus_process(VirtIOMSGBusDevice *bd)
+{
+    VirtIOMSGBusDeviceClass *bdc;
+    bdc = VIRTIO_MSG_BUS_DEVICE_CLASS(object_get_class(OBJECT(bd)));
+
+    bdc->process(bd);
+}
+
+int virtio_msg_bus_send(BusState *bus, VirtIOMSG *msg_req)
+{
+    VirtIOMSGBusDevice *bd = virtio_msg_bus_get_device(bus);
+    VirtIOMSGBusDeviceClass *bdc;
+    int r = VIRTIO_MSG_NO_ERROR;
+
+    bdc = VIRTIO_MSG_BUS_DEVICE_CLASS(object_get_class(OBJECT(bd)));
+
+    if (bdc->send) {
+        r = bdc->send(bd, msg_req);
+    }
+    return r;
+}
+
+static void virtio_msg_bus_class_init(ObjectClass *klass, const void *data)
+{
+    BusClass *bc = BUS_CLASS(klass);
+
+    bc->max_dev = 1;
+}
+
+static const TypeInfo virtio_msg_bus_info = {
+    .name = TYPE_VIRTIO_MSG_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = sizeof(BusState),
+    .class_init = virtio_msg_bus_class_init,
+};
+
+static void virtio_msg_bus_device_class_init(ObjectClass *klass,
+                                             const void *data)
+{
+    DeviceClass *k = DEVICE_CLASS(klass);
+
+    k->bus_type = TYPE_VIRTIO_MSG_BUS;
+}
+
+static const TypeInfo virtio_msg_bus_device_type_info = {
+    .name = TYPE_VIRTIO_MSG_BUS_DEVICE,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(VirtIOMSGBusDevice),
+    .abstract = true,
+    .class_size = sizeof(VirtIOMSGBusDeviceClass),
+    .class_init = virtio_msg_bus_device_class_init,
+};
+
+static void virtio_msg_bus_register_types(void)
+{
+    type_register_static(&virtio_msg_bus_info);
+    type_register_static(&virtio_msg_bus_device_type_info);
+}
+
+type_init(virtio_msg_bus_register_types)
diff --git a/hw/virtio/virtio-msg.c b/hw/virtio/virtio-msg.c
new file mode 100644
index 0000000000..a84da1714f
--- /dev/null
+++ b/hw/virtio/virtio-msg.c
@@ -0,0 +1,695 @@
+/*
+ * Virtio MSG bindings
+ *
+ * Copyright (c) 2024 Advanced Micro Devices, Inc.
+ * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-msg-bus.h"
+#include "hw/virtio/virtio-msg.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "trace.h"
+
+#define VIRTIO_MSG_VENDOR_ID 0x554D4551 /* 'QEMU' */
+
+static bool virtio_msg_bad(VirtIOMSGProxy *s, VirtIOMSG *msg)
+{
+    bool drop = false;
+    size_t min_size;
+    unsigned int n;
+
+    min_size = virtio_msg_header_size();
+    switch (msg->msg_id) {
+    case VIRTIO_MSG_GET_DEVICE_STATUS:
+    case VIRTIO_MSG_DEVICE_INFO:
+        break;
+    case VIRTIO_MSG_GET_FEATURES:
+        min_size += sizeof msg->get_features;
+        break;
+    case VIRTIO_MSG_SET_FEATURES:
+        n = msg->set_features.num;
+
+        /* We expect at least one feature block.  */
+        if (n == 0 || n > VIRTIO_MSG_MAX_FEATURE_NUM) {
+            drop = true;
+            break;
+        }
+
+        min_size += sizeof msg->set_features + n * 4;
+        break;
+    case VIRTIO_MSG_GET_CONFIG:
+        min_size += sizeof msg->get_config;
+        break;
+    case VIRTIO_MSG_SET_CONFIG:
+        if (msg->set_config.size > VIRTIO_MSG_MAX_CONFIG_BYTES) {
+            drop = true;
+            break;
+        }
+
+        min_size += sizeof msg->set_config + msg->set_config.size;
+        break;
+    case VIRTIO_MSG_SET_DEVICE_STATUS:
+        min_size += sizeof msg->set_device_status;
+        break;
+    case VIRTIO_MSG_GET_VQUEUE:
+        min_size += sizeof msg->get_vqueue;
+        break;
+    case VIRTIO_MSG_SET_VQUEUE:
+        min_size += sizeof msg->set_vqueue;
+        break;
+    case VIRTIO_MSG_RESET_VQUEUE:
+        min_size += sizeof msg->reset_vqueue;
+        break;
+    case VIRTIO_MSG_EVENT_AVAIL:
+        min_size += sizeof msg->event_avail;
+        break;
+    default:
+        /* Unexpected message.  */
+        drop = true;
+        break;
+    }
+
+    /* Accept large messages allowing future backwards compatible extensions. */
+    if (drop ||
+        msg->msg_size < min_size || msg->msg_size > VIRTIO_MSG_MAX_SIZE) {
+        return true;
+    }
+
+    if (msg->dev_num >= ARRAY_SIZE(s->devs)) {
+        return true;
+    }
+
+    return false;
+}
+
+static VirtIODevice *virtio_msg_vdev(VirtIOMSGProxy *s, uint16_t dev_num)
+{
+    VirtIODevice *vdev;
+
+    vdev = virtio_bus_get_device(&s->devs[dev_num].bus);
+    return vdev;
+}
+
+static void virtio_msg_bus_get_devices(VirtIOMSGProxy *s,
+                                       VirtIOMSG *msg)
+{
+    VirtIODevice *vdev;
+    VirtIOMSG msg_resp;
+    uint8_t data[VIRTIO_MSG_MAX_DEVS / 8] = {0};
+    uint16_t num = MAX(msg->bus_get_devices.num, VIRTIO_MSG_MAX_DEVS);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->devs); i++) {
+        vdev = virtio_msg_vdev(s, i);
+        if (vdev) {
+            data[i / 8] |= 1U << (i & 7);
+        }
+    }
+
+    virtio_msg_pack_bus_get_devices_resp(&msg_resp,
+                                         msg->bus_get_devices.offset, num, 0,
+                                         data);
+    virtio_msg_bus_send(&s->msg_bus, &msg_resp);
+}
+
+static void virtio_msg_device_info(VirtIOMSGProxy *s,
+                                   VirtIOMSG *msg)
+{
+    VirtIODevice *vdev = virtio_msg_vdev(s, msg->dev_num);
+    uint32_t config_len = 0;
+    uint32_t device_id = 0;
+    VirtIOMSG msg_resp;
+
+    if (vdev) {
+        device_id = vdev->device_id;
+        config_len = vdev->config_len;
+    } else {
+        error_report("%s: No virtio device on bus %s!",
+                     __func__, BUS(&s->devs[msg->dev_num].bus)->name);
+    }
+
+    virtio_msg_pack_get_device_info_resp(&msg_resp, msg->dev_num, msg->token,
+                                         device_id,
+                                         VIRTIO_MSG_VENDOR_ID,
+                                         /* Feature bits */
+                                         64,
+                                         config_len,
+                                         VIRTIO_QUEUE_MAX,
+                                         0, 0);
+    virtio_msg_bus_send(&s->msg_bus, &msg_resp);
+}
+
+static void virtio_msg_get_features(VirtIOMSGProxy *s,
+                                    VirtIOMSG *msg)
+{
+    VirtIODevice *vdev = virtio_msg_vdev(s, msg->dev_num);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    VirtIOMSG msg_resp;
+    uint32_t index = msg->get_features.index;
+    uint32_t f[VIRTIO_MSG_MAX_FEATURE_NUM] = { 0 };
+    uint32_t num = msg->get_features.num;
+    uint64_t features;
+
+    features = vdev->host_features & ~vdc->legacy_features;
+
+    /* We only have 64 feature bits. If driver asks for more, return zeros  */
+    if (index < 2) {
+        features >>= index * 32;
+        f[0] = features;
+        f[1] = features >> 32;
+    }
+
+    /* If index is out of bounds, we respond with num=0, f=0.  */
+    virtio_msg_pack_get_features_resp(&msg_resp, msg->dev_num, msg->token,
+                                      index, num, f);
+    virtio_msg_bus_send(&s->msg_bus, &msg_resp);
+}
+
+static void virtio_msg_set_features(VirtIOMSGProxy *s,
+                                    VirtIOMSG *msg)
+{
+    VirtIOMSG msg_resp;
+    unsigned int i;
+    uint64_t f;
+
+    f = s->devs[msg->dev_num].guest_features;
+
+    for (i = 0; i < msg->set_features.num; i++) {
+        unsigned int feature_index = i + msg->set_features.index;
+
+        /* We only support up to 64bits  */
+        if (feature_index >= 2) {
+            break;
+        }
+
+        f = deposit64(f, feature_index * 32, 32, msg->set_features.b32[i]);
+    }
+
+    s->devs[msg->dev_num].guest_features = f;
+
+    virtio_msg_pack_set_features_resp(&msg_resp, msg->dev_num, msg->token);
+    virtio_msg_bus_send(&s->msg_bus, &msg_resp);
+}
+
+static void virtio_msg_soft_reset(VirtIOMSGProxy *s, uint16_t dev_num)
+{
+    assert(dev_num < ARRAY_SIZE(s->devs));
+
+    virtio_bus_reset(&s->devs[dev_num].bus);
+    s->devs[dev_num].guest_features = 0;
+}
+
+static void virtio_msg_set_device_status(VirtIOMSGProxy *s,
+                                         VirtIOMSG *msg)
+{
+    VirtIODevice *vdev = virtio_msg_vdev(s, msg->dev_num);
+    uint32_t status = msg->set_device_status.status;
+    VirtIOMSG msg_resp;
+
+    if (!vdev) {
+        return;
+    }
+
+    if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+        virtio_bus_stop_ioeventfd(&s->devs[msg->dev_num].bus);
+    }
+
+    if (status & VIRTIO_CONFIG_S_FEATURES_OK) {
+        virtio_set_features(vdev, s->devs[msg->dev_num].guest_features);
+    }
+
+    virtio_set_status(vdev, status);
+    assert(vdev->status == status);
+
+    if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+        virtio_bus_start_ioeventfd(&s->devs[msg->dev_num].bus);
+    }
+
+    if (status == 0) {
+        virtio_msg_soft_reset(s, msg->dev_num);
+    }
+
+    virtio_msg_pack_set_device_status_resp(&msg_resp, msg->dev_num, msg->token,
+                                           vdev->status);
+    virtio_msg_bus_send(&s->msg_bus, &msg_resp);
+}
+
+static void virtio_msg_get_device_status(VirtIOMSGProxy *s,
+                                         VirtIOMSG *msg)
+{
+    VirtIODevice *vdev = virtio_msg_vdev(s, msg->dev_num);
+    VirtIOMSG msg_resp;
+
+    virtio_msg_pack_get_device_status_resp(&msg_resp, msg->dev_num, msg->token,
+                                           vdev->status);
+    virtio_msg_bus_send(&s->msg_bus, &msg_resp);
+}
+
+static void virtio_msg_get_config(VirtIOMSGProxy *s,
+                                  VirtIOMSG *msg)
+{
+    VirtIODevice *vdev = virtio_msg_vdev(s, msg->dev_num);
+    uint32_t size = msg->get_config.size;
+    uint32_t offset = msg->get_config.offset;
+    uint8_t data[VIRTIO_MSG_MAX_CONFIG_BYTES];
+    VirtIOMSG msg_resp;
+    unsigned int i;
+
+    if (size > VIRTIO_MSG_MAX_CONFIG_BYTES) {
+        return;
+    }
+
+    for (i = 0; i < size; i++) {
+        data[i] = virtio_config_modern_readb(vdev, offset + i);
+    }
+
+    virtio_msg_pack_get_config_resp(&msg_resp, msg->dev_num, msg->token,
+                                    size, offset,
+                                    vdev->generation, data);
+    virtio_msg_bus_send(&s->msg_bus, &msg_resp);
+}
+
+static void virtio_msg_set_config(VirtIOMSGProxy *s,
+                                  VirtIOMSG *msg)
+{
+    VirtIODevice *vdev = virtio_msg_vdev(s, msg->dev_num);
+    uint32_t offset = msg->set_config.offset;
+    uint32_t size = msg->set_config.size;
+    uint8_t *data = msg->set_config.data;
+    VirtIOMSG msg_resp;
+    unsigned int i;
+
+    for (i = 0; i < size; i++) {
+        virtio_config_modern_writeb(vdev, offset + i, data[i]);
+    }
+
+    virtio_msg_pack_set_config_resp(&msg_resp, msg->dev_num, msg->token,
+                                    size, offset,
+                                    vdev->generation, data);
+    virtio_msg_bus_send(&s->msg_bus, &msg_resp);
+}
+
+static void virtio_msg_get_vqueue(VirtIOMSGProxy *s,
+                                  VirtIOMSG *msg)
+{
+    VirtIODevice *vdev = virtio_msg_vdev(s, msg->dev_num);
+    uint32_t max_size = VIRTQUEUE_MAX_SIZE;
+    uint32_t index = msg->get_vqueue.index;
+    hwaddr desc, avail, used;
+    VirtIOMSG msg_resp;
+    uint32_t size;
+
+    if (index < VIRTIO_QUEUE_MAX) {
+        size = virtio_queue_get_num(vdev, index);
+        if (!size) {
+            max_size = 0;
+        }
+
+        virtio_queue_get_rings(vdev, index, &desc, &avail, &used);
+        virtio_msg_pack_get_vqueue_resp(&msg_resp, msg->dev_num, msg->token,
+                                        index, max_size, size,
+                                        desc, avail, used);
+    } else {
+        /* OOB index, respond with all zeroes. */
+        virtio_msg_pack_get_vqueue_resp(&msg_resp, msg->dev_num, msg->token,
+                                        index, 0, 0, 0, 0, 0);
+    }
+
+    virtio_msg_bus_send(&s->msg_bus, &msg_resp);
+}
+
+static void virtio_msg_set_vqueue(VirtIOMSGProxy *s, VirtIOMSG *msg)
+{
+    VirtIODevice *vdev = virtio_msg_vdev(s, msg->dev_num);
+    uint32_t index = msg->set_vqueue.index;
+    VirtIOMSG msg_resp;
+
+    if (index >= VIRTIO_QUEUE_MAX) {
+        /* OOB index, ignore. */
+        return;
+    }
+
+    virtio_queue_set_num(vdev, index, msg->set_vqueue.size);
+    virtio_queue_set_rings(vdev, index,
+                           msg->set_vqueue.descriptor_addr,
+                           msg->set_vqueue.driver_addr,
+                           msg->set_vqueue.device_addr);
+    virtio_queue_enable(vdev, index);
+
+    virtio_msg_pack_set_vqueue_resp(&msg_resp, msg->dev_num, msg->token);
+    virtio_msg_bus_send(&s->msg_bus, &msg_resp);
+}
+
+static void virtio_msg_reset_vqueue(VirtIOMSGProxy *s, VirtIOMSG *msg)
+{
+    VirtIODevice *vdev = virtio_msg_vdev(s, msg->dev_num);
+    VirtIOMSG msg_resp;
+
+    virtio_queue_reset(vdev, msg->reset_vqueue.index);
+
+    virtio_msg_pack_reset_vqueue_resp(&msg_resp, msg->dev_num, msg->token);
+    virtio_msg_bus_send(&s->msg_bus, &msg_resp);
+}
+
+static void virtio_msg_event_avail(VirtIOMSGProxy *s,
+                                   VirtIOMSG *msg)
+{
+    VirtIODevice *vdev = virtio_msg_vdev(s, msg->dev_num);
+    uint16_t vq_idx = msg->event_avail.index;
+
+    if (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+        VirtIOMSG msg_ev;
+
+        virtio_error(vdev, "Notification while driver not OK?");
+        virtio_msg_pack_event_config(&msg_ev, msg->dev_num,
+                                     vdev->status, vdev->generation,
+                                     0, 0, NULL);
+        virtio_msg_bus_send(&s->msg_bus, &msg_ev);
+        return;
+    }
+
+    if (vq_idx >= VIRTIO_QUEUE_MAX) {
+        virtio_error(vdev, "Notification to bad VQ!");
+        return;
+    }
+
+    if (!virtio_queue_get_num(vdev, vq_idx)) {
+        virtio_error(vdev, "Notification to unconfigured VQ!");
+        return;
+    }
+
+    /* NOTIFICATION_DATA doesn't exist in QEMU 8.2.7. if (0) it */
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA) && 0) {
+        VirtQueue *vq = virtio_get_queue(vdev, vq_idx);
+        uint32_t next_offset_wrap = msg->event_avail.next_offset_wrap;
+        uint16_t qsize = virtio_queue_get_num(vdev, vq_idx);
+        uint32_t offset = next_offset_wrap & 0x7fffffff;
+        bool wrap = next_offset_wrap & 0x80000000;
+        uint16_t data;
+
+        if (offset > 0x7fff || offset >= qsize) {
+            virtio_error(vdev, "Next offset to large!");
+            /* Bail out without notification???  */
+            return;
+        }
+
+        data = wrap << 15;
+        data |= offset & 0x7fff;
+
+        virtio_queue_set_shadow_avail_idx(vq, data);
+    }
+    virtio_queue_notify(vdev, msg->event_avail.index);
+}
+
+typedef void (*VirtIOMSGHandler)(VirtIOMSGProxy *s,
+                                 VirtIOMSG *msg);
+
+static const VirtIOMSGHandler msg_handlers[] = {
+    [VIRTIO_MSG_DEVICE_INFO] = virtio_msg_device_info,
+    [VIRTIO_MSG_GET_FEATURES] = virtio_msg_get_features,
+    [VIRTIO_MSG_SET_FEATURES] = virtio_msg_set_features,
+    [VIRTIO_MSG_GET_DEVICE_STATUS] = virtio_msg_get_device_status,
+    [VIRTIO_MSG_SET_DEVICE_STATUS] = virtio_msg_set_device_status,
+    [VIRTIO_MSG_GET_CONFIG] = virtio_msg_get_config,
+    [VIRTIO_MSG_SET_CONFIG] = virtio_msg_set_config,
+    [VIRTIO_MSG_GET_VQUEUE] = virtio_msg_get_vqueue,
+    [VIRTIO_MSG_SET_VQUEUE] = virtio_msg_set_vqueue,
+    [VIRTIO_MSG_RESET_VQUEUE] = virtio_msg_reset_vqueue,
+    [VIRTIO_MSG_EVENT_AVAIL] = virtio_msg_event_avail,
+};
+
+static int virtio_msg_receive_msg(VirtIOMSGBusDevice *bd, VirtIOMSG *msg)
+{
+    VirtIOMSGProxy *s = VIRTIO_MSG(bd->opaque);
+    VirtIOMSGHandler handler;
+
+    /* virtio_msg_print(msg); */
+
+    /* We handle some generic bus messages. */
+    if (msg->type & VIRTIO_MSG_TYPE_BUS) {
+        if (msg->msg_id == VIRTIO_MSG_BUS_GET_DEVICES) {
+            virtio_msg_bus_get_devices(s, msg);
+            return VIRTIO_MSG_NO_ERROR;
+        }
+    }
+
+    if (msg->msg_id > ARRAY_SIZE(msg_handlers)) {
+        return VIRTIO_MSG_ERROR_UNSUPPORTED_MESSAGE_ID;
+    }
+
+    handler = msg_handlers[msg->msg_id];
+    assert((msg->type & VIRTIO_MSG_TYPE_RESPONSE) == 0);
+
+    if (virtio_msg_bad(s, msg)) {
+        /* Drop bad messages.  */
+        return VIRTIO_MSG_ERROR_BAD_MESSAGE;
+    }
+
+    if (handler) {
+        handler(s, msg);
+    }
+
+    return VIRTIO_MSG_NO_ERROR;
+}
+
+static const VirtIOMSGBusPort virtio_msg_port = {
+    .receive = virtio_msg_receive_msg,
+    .is_driver = false
+};
+
+static void virtio_msg_notify_queue(DeviceState *opaque, uint16_t index)
+{
+    VirtIOMSGDev *mdev = VIRTIO_MSG_DEV(opaque);
+    VirtIOMSGProxy *s = VIRTIO_MSG(mdev->proxy);
+    VirtIODevice *vdev = virtio_msg_vdev(s, mdev->dev_num);
+    VirtIOMSG msg;
+
+    if (!vdev || !virtio_msg_bus_connected(&s->msg_bus)) {
+        return;
+    }
+
+    virtio_msg_pack_event_used(&msg, mdev->dev_num, index);
+    virtio_msg_bus_send(&s->msg_bus, &msg);
+}
+
+static void virtio_msg_notify(DeviceState *opaque, uint16_t vector)
+{
+    VirtIOMSGDev *mdev = VIRTIO_MSG_DEV(opaque);
+    VirtIOMSGProxy *s = VIRTIO_MSG(mdev->proxy);
+    VirtIODevice *vdev = virtio_msg_vdev(s, mdev->dev_num);
+    VirtIOMSG msg;
+
+    if (!virtio_msg_bus_connected(&s->msg_bus)) {
+        return;
+    }
+
+    /* Check if we're notifying for VQ or CONFIG updates.  */
+    if (vdev->isr & 2) {
+        virtio_msg_pack_event_config(&msg, mdev->dev_num,
+                                     vdev->status, vdev->generation,
+                                     0, 0, NULL);
+        virtio_msg_bus_send(&s->msg_bus, &msg);
+    }
+}
+
+static const VMStateDescription vmstate_virtio_msg_state_sub = {
+    .name = "virtio_msg_device",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_virtio_msg = {
+    .name = "virtio_msg_proxy_backend",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_virtio_msg_state_sub,
+        NULL
+    }
+};
+
+static void virtio_msg_save_extra_state(DeviceState *opaque, QEMUFile *f)
+{
+    VirtIOMSGProxy *s = VIRTIO_MSG(opaque);
+
+    vmstate_save_state(f, &vmstate_virtio_msg, s, NULL, &error_fatal);
+}
+
+static int virtio_msg_load_extra_state(DeviceState *opaque, QEMUFile *f)
+{
+    VirtIOMSGProxy *s = VIRTIO_MSG(opaque);
+
+    return vmstate_load_state(f, &vmstate_virtio_msg, s, 1, &error_fatal);
+}
+
+static bool virtio_msg_has_extra_state(DeviceState *opaque)
+{
+    return true;
+}
+
+static void virtio_msg_reset_hold(Object *obj, ResetType type)
+{
+    VirtIOMSGProxy *s = VIRTIO_MSG(obj);
+    VirtIODevice *vdev;
+    bool found_a_vdev;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->devs); i++) {
+        virtio_msg_soft_reset(s, i);
+
+        vdev = virtio_msg_vdev(s, i);
+        if (vdev) {
+            found_a_vdev = true;
+        }
+    }
+
+    /* Only connect transports with virtio-devs.  */
+    if (found_a_vdev) {
+        bool r;
+
+        r = virtio_msg_bus_connect(&s->msg_bus, &virtio_msg_port, s);
+        if (!r) {
+            /* This is a user error, forgetting to setup a msg-bus.  */
+            error_report("%s: No bus connected!",
+                         object_get_canonical_path(obj));
+            exit(EXIT_FAILURE);
+        }
+    }
+}
+
+static void virtio_msg_pre_plugged(DeviceState *d, Error **errp)
+{
+    VirtIOMSGDev *mdev = VIRTIO_MSG_DEV(d);
+    VirtIOMSGProxy *s = VIRTIO_MSG(mdev->proxy);
+    VirtIODevice *vdev = virtio_msg_vdev(s, mdev->dev_num);
+
+    virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
+}
+
+static AddressSpace *virtio_msg_get_dma_as(DeviceState *d)
+{
+    VirtIOMSGProxy *s = VIRTIO_MSG(d);
+    AddressSpace *as;
+
+    as = virtio_msg_bus_get_remote_as(&s->msg_bus);
+    return as;
+}
+
+static void virtio_msg_realize(DeviceState *d, Error **errp)
+{
+    VirtIOMSGProxy *s = VIRTIO_MSG(d);
+    Object *o = OBJECT(d);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->devs); i++) {
+        g_autofree char *outer_bus_name = g_strdup_printf("bus%d", i);
+
+        qbus_init(&s->devs_bus[i], sizeof(s->devs_bus[i]),
+                  TYPE_VIRTIO_MSG_OUTER_BUS, d, outer_bus_name);
+
+        object_initialize_child(o, "dev[*]", &s->devs[i], TYPE_VIRTIO_MSG_DEV);
+        s->devs[i].proxy = s;
+        s->devs[i].dev_num = i;
+        qdev_realize(DEVICE(&s->devs[i]), BUS(&s->devs_bus[i]), &error_fatal);
+
+        qbus_init(&s->devs[i].bus, sizeof(s->devs[i].bus),
+                  TYPE_VIRTIO_MSG_PROXY_BUS, DEVICE(&s->devs[i]), "bus");
+    }
+
+    qbus_init(&s->msg_bus, sizeof(s->msg_bus),
+              TYPE_VIRTIO_MSG_BUS, d, "msg-bus");
+}
+
+static void virtio_msg_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = virtio_msg_realize;
+    dc->bus_type = TYPE_VIRTIO_MSG_OUTER_BUS;
+    dc->user_creatable = true;
+    rc->phases.hold = virtio_msg_reset_hold;
+}
+
+static void virtio_msg_dev_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->bus_type = TYPE_VIRTIO_MSG_OUTER_BUS;
+}
+
+static const TypeInfo virtio_msg_types[] = {
+    {
+        .name          = TYPE_VIRTIO_MSG,
+        .parent        = TYPE_DEVICE,
+        .instance_size = sizeof(VirtIOMSGProxy),
+        .class_init    = virtio_msg_class_init,
+    },
+    {
+        .name          = TYPE_VIRTIO_MSG_DEV,
+        .parent        = TYPE_DEVICE,
+        .instance_size = sizeof(DeviceState),
+        .class_init    = virtio_msg_dev_class_init,
+    },
+};
+DEFINE_TYPES(virtio_msg_types);
+
+static char *virtio_msg_bus_get_dev_path(DeviceState *dev)
+{
+    BusState *bus = qdev_get_parent_bus(dev);
+    return strdup(object_get_canonical_path(OBJECT(bus->parent)));
+}
+
+static void virtio_msg_bus_class_init(ObjectClass *klass, const void *data)
+{
+    BusClass *bus_class = BUS_CLASS(klass);
+    VirtioBusClass *k = VIRTIO_BUS_CLASS(klass);
+
+    k->notify_queue = virtio_msg_notify_queue;
+    k->notify = virtio_msg_notify;
+    k->save_extra_state = virtio_msg_save_extra_state;
+    k->load_extra_state = virtio_msg_load_extra_state;
+    k->has_extra_state = virtio_msg_has_extra_state;
+    k->pre_plugged = virtio_msg_pre_plugged;
+    k->has_variable_vring_alignment = true;
+    k->get_dma_as = virtio_msg_get_dma_as;
+
+    /* Needed for multiple devs of the same kind (virtio-net).  */
+    bus_class->get_dev_path = virtio_msg_bus_get_dev_path;
+}
+
+static const TypeInfo virtio_msg_bus_types[] = {
+    {
+        /* Specialized virtio-bus with our custom callbacks.  */
+        .name          = TYPE_VIRTIO_MSG_PROXY_BUS,
+        .parent        = TYPE_VIRTIO_BUS,
+        .instance_size = sizeof(VirtioBusState),
+        .class_init    = virtio_msg_bus_class_init,
+    },
+    {
+        /*
+         * Outer bus to hold virtio-msg objects making them visible to the
+         * qom-tree.
+         */
+        .name          = TYPE_VIRTIO_MSG_OUTER_BUS,
+        .parent        = TYPE_BUS,
+        .instance_size = sizeof(BusState),
+    },
+};
+
+DEFINE_TYPES(virtio_msg_bus_types);
diff --git a/include/hw/virtio/virtio-msg-bus.h b/include/hw/virtio/virtio-msg-bus.h
new file mode 100644
index 0000000000..12ef8030f4
--- /dev/null
+++ b/include/hw/virtio/virtio-msg-bus.h
@@ -0,0 +1,95 @@
+/*
+ * VirtIO MSG bus.
+ *
+ * Copyright (c) 2024 Advanced Micro Devices, Inc.
+ * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VIRTIO_MSG_BUS_H
+#define QEMU_VIRTIO_MSG_BUS_H
+
+#include "qom/object.h"
+#include "system/dma.h"
+#include "hw/qdev-core.h"
+#include "hw/virtio/virtio-msg-prot.h"
+
+#define TYPE_VIRTIO_MSG_BUS "virtio-msg-bus"
+DECLARE_INSTANCE_CHECKER(BusState, VIRTIO_MSG_BUS,
+                         TYPE_VIRTIO_MSG_BUS)
+
+
+#define TYPE_VIRTIO_MSG_BUS_DEVICE "virtio-msg-bus-device"
+OBJECT_DECLARE_TYPE(VirtIOMSGBusDevice, VirtIOMSGBusDeviceClass,
+                    VIRTIO_MSG_BUS_DEVICE)
+
+typedef struct VirtIOMSGBusPort {
+    int (*receive)(VirtIOMSGBusDevice *bd, VirtIOMSG *msg);
+    bool is_driver;
+} VirtIOMSGBusPort;
+
+struct VirtIOMSGBusDeviceClass {
+    /*< private >*/
+    DeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
+
+    /*
+     * Ask the bus to receive and process all messages that
+     * are readily available. The bus will call the registered
+     * VirtIOMSGBusPort.receive() function for each message.
+     *
+     * Will return immediately if no messages are available.
+     */
+    void (*process)(VirtIOMSGBusDevice *bd);
+
+    /*
+     * Called by the transport to send a message.
+     */
+    int (*send)(VirtIOMSGBusDevice *bd, VirtIOMSG *msg_req);
+};
+
+typedef struct VirtIOMSGBusDevice {
+    DeviceState parent;
+
+    const VirtIOMSGBusPort *peer;
+    void *opaque;
+} VirtIOMSGBusDevice;
+
+static inline VirtIOMSGBusDevice *virtio_msg_bus_get_device(BusState *qbus)
+{
+    BusChild *kid = QTAILQ_FIRST(&qbus->children);
+    DeviceState *qdev = kid ? kid->child : NULL;
+
+    return (VirtIOMSGBusDevice *)qdev;
+}
+
+static inline bool virtio_msg_bus_connected(BusState *bus)
+{
+    VirtIOMSGBusDevice *bd = virtio_msg_bus_get_device(bus);
+
+    return bd && bd->peer != NULL;
+}
+
+void virtio_msg_bus_process(VirtIOMSGBusDevice *bd);
+
+bool virtio_msg_bus_connect(BusState *bus,
+                            const VirtIOMSGBusPort *port,
+                            void *opaque);
+
+static inline void
+virtio_msg_bus_receive(VirtIOMSGBusDevice *bd, VirtIOMSG *msg)
+{
+    virtio_msg_unpack(msg);
+    bd->peer->receive(bd, msg);
+}
+
+int virtio_msg_bus_send(BusState *bus, VirtIOMSG *msg_req);
+
+static inline AddressSpace *virtio_msg_bus_get_remote_as(BusState *bus)
+{
+    return &address_space_memory;
+}
+#endif
diff --git a/include/hw/virtio/virtio-msg-prot.h b/include/hw/virtio/virtio-msg-prot.h
new file mode 100644
index 0000000000..8b3828b2b6
--- /dev/null
+++ b/include/hw/virtio/virtio-msg-prot.h
@@ -0,0 +1,846 @@
+/*
+ * Virtio MSG - Message packing/unpacking functions.
+ *
+ * Copyright (c) 2024 Advanced Micro Devices, Inc.
+ * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VIRTIO_MSG_H
+#define QEMU_VIRTIO_MSG_H
+
+#include <stdint.h>
+#include "standard-headers/linux/virtio_config.h"
+
+enum {
+    VIRTIO_MSG_NO_ERROR = 0,
+    VIRTIO_MSG_ERROR_RETRY,
+    VIRTIO_MSG_ERROR_TIMEOUT,
+    VIRTIO_MSG_ERROR_UNSUPPORTED_MESSAGE_ID,
+    VIRTIO_MSG_ERROR_BAD_MESSAGE,
+    VIRTIO_MSG_ERROR_MEMORY, /* General memory error. */
+};
+
+enum {
+    VIRTIO_MSG_DEVICE_INFO       = 0x02,
+    VIRTIO_MSG_GET_FEATURES      = 0x03,
+    VIRTIO_MSG_SET_FEATURES      = 0x04,
+    VIRTIO_MSG_GET_CONFIG        = 0x05,
+    VIRTIO_MSG_SET_CONFIG        = 0x06,
+    VIRTIO_MSG_GET_DEVICE_STATUS = 0x07,
+    VIRTIO_MSG_SET_DEVICE_STATUS = 0x08,
+    VIRTIO_MSG_GET_VQUEUE        = 0x09,
+    VIRTIO_MSG_SET_VQUEUE        = 0x0a,
+    VIRTIO_MSG_RESET_VQUEUE      = 0x0b,
+    VIRTIO_MSG_GET_SHM           = 0x0c, /* Not yet supported */
+    VIRTIO_MSG_EVENT_CONFIG      = 0x40,
+    VIRTIO_MSG_EVENT_AVAIL       = 0x41,
+    VIRTIO_MSG_EVENT_USED        = 0x42,
+
+    /* Generic bus messages.  */
+    VIRTIO_MSG_BUS_GET_DEVICES   = 0x02,
+
+    VIRTIO_MSG_MAX = VIRTIO_MSG_EVENT_USED,
+};
+
+#define VIRTIO_MSG_MAX_SIZE 48
+
+#define VIRTIO_MSG_TYPE_RESPONSE  (1 << 0)
+#define VIRTIO_MSG_TYPE_BUS       (1 << 1)
+
+typedef struct VirtIOMSG {
+    uint8_t type;
+    uint8_t msg_id;
+    uint16_t dev_num;
+    uint16_t token;
+    uint16_t msg_size;
+
+    union {
+        uint8_t payload_u8[40];
+
+        struct {
+            uint32_t device_id;
+            uint32_t vendor_id;
+            uint32_t num_feature_bits;
+            uint32_t config_size;
+            uint32_t max_vqs;
+            uint16_t admin_vq_idx;
+            uint16_t admin_vq_count;
+        } QEMU_PACKED get_device_info_resp;
+        struct {
+            uint32_t index;
+            uint32_t num;
+        } QEMU_PACKED get_features;
+        struct {
+            uint32_t index;
+            uint32_t num;
+            uint32_t b32[];
+        } QEMU_PACKED get_features_resp;
+        struct {
+            uint32_t index;
+            uint32_t num;
+            uint32_t b32[];
+        } QEMU_PACKED set_features;
+        struct {
+            uint32_t offset;
+            uint32_t size;
+        } QEMU_PACKED get_config;
+        struct {
+            uint32_t generation;
+            uint32_t offset;
+            uint32_t size;
+            uint8_t data[];
+        } QEMU_PACKED get_config_resp;
+        struct {
+            uint32_t generation;
+            uint32_t offset;
+            uint32_t size;
+            uint8_t data[];
+        } QEMU_PACKED set_config;
+        struct {
+            uint32_t generation;
+            uint32_t offset;
+            uint32_t size;
+            uint8_t data[];
+        } QEMU_PACKED set_config_resp;
+        struct {
+            uint32_t status;
+        } QEMU_PACKED get_device_status_resp;
+        struct {
+            uint32_t status;
+        } QEMU_PACKED set_device_status;
+        struct {
+            uint32_t status;
+        } QEMU_PACKED set_device_status_resp;
+        struct {
+            uint32_t index;
+        } QEMU_PACKED get_vqueue;
+        struct {
+            uint32_t index;
+            uint32_t max_size;
+            uint32_t size;
+            uint32_t reserved;
+            uint64_t descriptor_addr;
+            uint64_t driver_addr;
+            uint64_t device_addr;
+        } QEMU_PACKED get_vqueue_resp;
+        struct {
+            uint32_t index;
+            uint32_t unused;
+            uint32_t size;
+            uint32_t reserved;
+            uint64_t descriptor_addr;
+            uint64_t driver_addr;
+            uint64_t device_addr;
+        } QEMU_PACKED set_vqueue;
+        struct {
+            uint32_t index;
+        } QEMU_PACKED reset_vqueue;
+        struct {
+            uint32_t status;
+            uint32_t generation;
+            uint32_t offset;
+            uint32_t size;
+            uint8_t config_value[];
+        } QEMU_PACKED event_config;
+        struct {
+            uint32_t index;
+            uint32_t next_offset_wrap;
+        } QEMU_PACKED event_avail;
+        struct {
+            uint32_t index;
+        } QEMU_PACKED event_used;
+
+        /* Generic bus messages.  */
+        struct {
+            uint16_t offset;
+            uint16_t num;
+        } QEMU_PACKED bus_get_devices;
+        struct {
+            uint16_t offset;
+            uint16_t num;
+            uint16_t next_offset;
+            uint8_t data[];
+        } QEMU_PACKED bus_get_devices_resp;
+    };
+} QEMU_PACKED VirtIOMSG;
+
+/* Maximum number of 32b feature-blocks in a single message.  */
+#define VIRTIO_MSG_MAX_FEATURE_NUM \
+    ((VIRTIO_MSG_MAX_SIZE - offsetof(VirtIOMSG, get_features_resp.b32)) / 4)
+
+/* Maximum amount of config-data in a single message, in bytes.  */
+#define VIRTIO_MSG_MAX_CONFIG_BYTES \
+    (VIRTIO_MSG_MAX_SIZE - offsetof(VirtIOMSG, set_config.data))
+
+#define LE_TO_CPU(v)                                        \
+{                                                           \
+    if (sizeof(v) == 2) {                                   \
+        v = le16_to_cpu(v);                                 \
+    } else if (sizeof(v) == 4) {                            \
+        v = le32_to_cpu(v);                                 \
+    } else if (sizeof(v) == 8) {                            \
+        v = le64_to_cpu(v);                                 \
+    } else {                                                \
+        g_assert_not_reached();                             \
+    }                                                       \
+}
+
+static inline void virtio_msg_unpack_bus(VirtIOMSG *msg)
+{
+    switch (msg->msg_id) {
+    case VIRTIO_MSG_BUS_GET_DEVICES:
+        LE_TO_CPU(msg->bus_get_devices.offset);
+        LE_TO_CPU(msg->bus_get_devices.num);
+        break;
+    default:
+        break;
+    }
+}
+
+/**
+ * virtio_msg_unpack_resp: Unpacks a wire virtio message responses into
+ *                         a host version
+ * @msg: the virtio message to unpack
+ *
+ * See virtio_msg_unpack().
+ */
+static inline void virtio_msg_unpack_resp(VirtIOMSG *msg)
+{
+    int i;
+
+    switch (msg->msg_id) {
+    case VIRTIO_MSG_DEVICE_INFO:
+        LE_TO_CPU(msg->get_device_info_resp.device_id);
+        LE_TO_CPU(msg->get_device_info_resp.vendor_id);
+        LE_TO_CPU(msg->get_device_info_resp.num_feature_bits);
+        LE_TO_CPU(msg->get_device_info_resp.config_size);
+        LE_TO_CPU(msg->get_device_info_resp.max_vqs);
+        LE_TO_CPU(msg->get_device_info_resp.admin_vq_idx);
+        LE_TO_CPU(msg->get_device_info_resp.admin_vq_count);
+        break;
+    case VIRTIO_MSG_GET_FEATURES:
+        LE_TO_CPU(msg->get_features_resp.index);
+        LE_TO_CPU(msg->get_features_resp.num);
+        for (i = 0; i < VIRTIO_MSG_MAX_FEATURE_NUM &&
+                    i < msg->get_features_resp.num; i++) {
+            LE_TO_CPU(msg->get_features_resp.b32[i]);
+        }
+        break;
+    case VIRTIO_MSG_GET_DEVICE_STATUS:
+        LE_TO_CPU(msg->get_device_status_resp.status);
+        break;
+    case VIRTIO_MSG_GET_CONFIG:
+        LE_TO_CPU(msg->get_config_resp.generation);
+        LE_TO_CPU(msg->get_config_resp.offset);
+        LE_TO_CPU(msg->get_config_resp.size);
+        break;
+    case VIRTIO_MSG_SET_CONFIG:
+        LE_TO_CPU(msg->set_config_resp.generation);
+        LE_TO_CPU(msg->set_config_resp.offset);
+        LE_TO_CPU(msg->set_config_resp.size);
+        break;
+    case VIRTIO_MSG_GET_VQUEUE:
+        LE_TO_CPU(msg->get_vqueue_resp.index);
+        LE_TO_CPU(msg->get_vqueue_resp.max_size);
+        LE_TO_CPU(msg->get_vqueue_resp.size);
+        LE_TO_CPU(msg->get_vqueue_resp.descriptor_addr);
+        LE_TO_CPU(msg->get_vqueue_resp.driver_addr);
+        LE_TO_CPU(msg->get_vqueue_resp.device_addr);
+        break;
+    default:
+        break;
+    }
+}
+
+/**
+ * virtio_msg_unpack: Unpacks a wire virtio message into a host version
+ * @msg: the virtio message to unpack
+ *
+ * Virtio messages arriving on the virtio message bus have a specific
+ * format (little-endian, packet encoding, etc). To simplify for the
+ * the rest of the implementation, we have packers and unpackers that
+ * convert the wire messages into host versions. This includes endianess
+ * conversion and potentially future decoding and expansion.
+ *
+ * At the moment, we only do endian conversion, virtio_msg_unpack() should
+ * get completely eliminated by the compiler when targetting little-endian
+ * hosts.
+ */
+static inline void virtio_msg_unpack(VirtIOMSG *msg)
+{
+    int i;
+
+    LE_TO_CPU(msg->dev_num);
+    LE_TO_CPU(msg->token);
+    LE_TO_CPU(msg->msg_size);
+
+    if (msg->type & VIRTIO_MSG_TYPE_BUS) {
+        virtio_msg_unpack_bus(msg);
+        return;
+    }
+
+    if (msg->type & VIRTIO_MSG_TYPE_RESPONSE) {
+        virtio_msg_unpack_resp(msg);
+        return;
+    }
+
+    switch (msg->msg_id) {
+    case VIRTIO_MSG_GET_FEATURES:
+        LE_TO_CPU(msg->get_features.index);
+        LE_TO_CPU(msg->get_features.num);
+        break;
+    case VIRTIO_MSG_SET_FEATURES:
+        LE_TO_CPU(msg->set_features.index);
+        LE_TO_CPU(msg->set_features.num);
+        for (i = 0; i < VIRTIO_MSG_MAX_FEATURE_NUM &&
+                    i < msg->set_features.num; i++) {
+            LE_TO_CPU(msg->set_features.b32[i]);
+        }
+        break;
+    case VIRTIO_MSG_SET_DEVICE_STATUS:
+        LE_TO_CPU(msg->set_device_status.status);
+        break;
+    case VIRTIO_MSG_GET_CONFIG:
+        LE_TO_CPU(msg->get_config.offset);
+        LE_TO_CPU(msg->get_config.size);
+        break;
+    case VIRTIO_MSG_SET_CONFIG:
+        LE_TO_CPU(msg->set_config.generation);
+        LE_TO_CPU(msg->set_config.offset);
+        LE_TO_CPU(msg->set_config.size);
+        break;
+    case VIRTIO_MSG_GET_VQUEUE:
+        LE_TO_CPU(msg->get_vqueue.index);
+        break;
+    case VIRTIO_MSG_SET_VQUEUE:
+        LE_TO_CPU(msg->set_vqueue.index);
+        LE_TO_CPU(msg->set_vqueue.size);
+        LE_TO_CPU(msg->set_vqueue.descriptor_addr);
+        LE_TO_CPU(msg->set_vqueue.driver_addr);
+        LE_TO_CPU(msg->set_vqueue.device_addr);
+        break;
+    case VIRTIO_MSG_RESET_VQUEUE:
+        LE_TO_CPU(msg->reset_vqueue.index);
+        break;
+    case VIRTIO_MSG_EVENT_CONFIG:
+        LE_TO_CPU(msg->event_config.status);
+        LE_TO_CPU(msg->event_config.generation);
+        LE_TO_CPU(msg->event_config.offset);
+        LE_TO_CPU(msg->event_config.size);
+        break;
+    case VIRTIO_MSG_EVENT_AVAIL:
+        LE_TO_CPU(msg->event_avail.index);
+        LE_TO_CPU(msg->event_avail.next_offset_wrap);
+        break;
+    case VIRTIO_MSG_EVENT_USED:
+        LE_TO_CPU(msg->event_used.index);
+        break;
+    default:
+        break;
+    }
+}
+
+static inline size_t virtio_msg_header_size(void)
+{
+    return offsetof(VirtIOMSG, payload_u8);
+}
+
+static inline void virtio_msg_pack_header(VirtIOMSG *msg,
+                                          uint8_t msg_id,
+                                          uint8_t type,
+                                          uint16_t dev_num,
+                                          uint16_t token,
+                                          uint16_t payload_size)
+{
+    uint16_t msg_size = virtio_msg_header_size() + payload_size;
+
+    msg->type = type;
+    msg->msg_id = msg_id;
+    msg->dev_num = cpu_to_le16(dev_num);
+    msg->token = cpu_to_le16(token);
+    msg->msg_size = cpu_to_le16(msg_size);
+
+    /* Keep things predictable.  */
+    memset(msg->payload_u8, 0, sizeof msg->payload_u8);
+}
+
+static inline void virtio_msg_pack_get_device_info(VirtIOMSG *msg,
+                                                   uint16_t dev_num,
+                                                   uint16_t token)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_DEVICE_INFO, 0, dev_num, token, 0);
+}
+
+static inline void virtio_msg_pack_get_device_info_resp(VirtIOMSG *msg,
+                                                   uint16_t dev_num,
+                                                   uint16_t token,
+                                                   uint32_t device_id,
+                                                   uint32_t vendor_id,
+                                                   uint32_t num_feature_bits,
+                                                   uint32_t config_size,
+                                                   uint32_t max_vqs,
+                                                   uint16_t admin_vq_idx,
+                                                   uint16_t admin_vq_count)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_DEVICE_INFO,
+                           VIRTIO_MSG_TYPE_RESPONSE, dev_num, token,
+                           sizeof msg->get_device_info_resp);
+
+    msg->get_device_info_resp.device_id = cpu_to_le32(device_id);
+    msg->get_device_info_resp.vendor_id = cpu_to_le32(vendor_id);
+    msg->get_device_info_resp.num_feature_bits = cpu_to_le32(num_feature_bits);
+    msg->get_device_info_resp.config_size = cpu_to_le32(config_size);
+    msg->get_device_info_resp.max_vqs = cpu_to_le32(max_vqs);
+    msg->get_device_info_resp.admin_vq_idx = cpu_to_le16(admin_vq_idx);
+    msg->get_device_info_resp.admin_vq_count = cpu_to_le16(admin_vq_count);
+}
+
+static inline void virtio_msg_pack_get_features(VirtIOMSG *msg,
+                                                uint16_t dev_num,
+                                                uint16_t token,
+                                                uint32_t index,
+                                                uint32_t num)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_GET_FEATURES, 0, dev_num, token,
+                           sizeof msg->get_features);
+
+    msg->get_features.index = cpu_to_le32(index);
+    msg->get_features.num = cpu_to_le32(num);
+}
+
+static inline void virtio_msg_pack_get_features_resp(VirtIOMSG *msg,
+                                                     uint16_t dev_num,
+                                                     uint16_t token,
+                                                     uint32_t index,
+                                                     uint32_t num,
+                                                     uint32_t *f)
+{
+    unsigned int i;
+
+    virtio_msg_pack_header(msg, VIRTIO_MSG_GET_FEATURES,
+                           VIRTIO_MSG_TYPE_RESPONSE, dev_num, token,
+                           sizeof msg->get_features_resp + num * sizeof(*f));
+
+    msg->get_features_resp.index = cpu_to_le32(index);
+    msg->get_features_resp.num = cpu_to_le32(num);
+
+    assert(num <= VIRTIO_MSG_MAX_FEATURE_NUM);
+
+    for (i = 0; i < num && i < VIRTIO_MSG_MAX_FEATURE_NUM; i++) {
+        msg->get_features_resp.b32[i] = cpu_to_le32(f[i]);
+    }
+}
+
+static inline void virtio_msg_pack_set_features(VirtIOMSG *msg,
+                                                uint16_t dev_num,
+                                                uint16_t token,
+                                                uint32_t index,
+                                                uint32_t num,
+                                                uint32_t *f)
+{
+    unsigned int i;
+
+    virtio_msg_pack_header(msg, VIRTIO_MSG_SET_FEATURES, 0, dev_num, token,
+                           sizeof msg->set_features + num * sizeof(*f));
+
+    msg->set_features.index = cpu_to_le32(index);
+    msg->set_features.num = cpu_to_le32(num);
+
+    assert(num <= VIRTIO_MSG_MAX_FEATURE_NUM);
+
+    for (i = 0; i < num && i < VIRTIO_MSG_MAX_FEATURE_NUM; i++) {
+        msg->set_features.b32[i] = cpu_to_le32(f[i]);
+    }
+}
+
+static inline void virtio_msg_pack_set_features_resp(VirtIOMSG *msg,
+                                                     uint16_t dev_num,
+                                                     uint16_t token)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_SET_FEATURES,
+                           VIRTIO_MSG_TYPE_RESPONSE, dev_num, token, 0);
+}
+
+static inline void virtio_msg_pack_set_device_status(VirtIOMSG *msg,
+                                                     uint16_t dev_num,
+                                                     uint16_t token,
+                                                     uint32_t status)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_SET_DEVICE_STATUS, 0, dev_num,
+                           token, sizeof msg->set_device_status);
+
+    msg->set_device_status.status = cpu_to_le32(status);
+}
+
+static inline void virtio_msg_pack_set_device_status_resp(VirtIOMSG *msg,
+                                                          uint16_t dev_num,
+                                                          uint16_t token,
+                                                          uint32_t status)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_SET_DEVICE_STATUS,
+                           VIRTIO_MSG_TYPE_RESPONSE, dev_num, token,
+                           sizeof msg->set_device_status_resp);
+
+    msg->set_device_status_resp.status = cpu_to_le32(status);
+}
+
+static inline void virtio_msg_pack_get_device_status(VirtIOMSG *msg,
+                                                     uint16_t dev_num,
+                                                     uint16_t token)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_GET_DEVICE_STATUS, 0,
+                           dev_num, token, 0);
+}
+
+static inline void virtio_msg_pack_get_device_status_resp(VirtIOMSG *msg,
+                                                          uint16_t dev_num,
+                                                          uint16_t token,
+                                                          uint32_t status)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_GET_DEVICE_STATUS,
+                           VIRTIO_MSG_TYPE_RESPONSE, dev_num, token,
+                           sizeof msg->get_device_status_resp);
+
+    msg->get_device_status_resp.status = cpu_to_le32(status);
+}
+
+static inline void virtio_msg_pack_get_config(VirtIOMSG *msg,
+                                              uint16_t dev_num,
+                                              uint16_t token,
+                                              uint32_t size,
+                                              uint32_t offset)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_GET_CONFIG, 0, dev_num, token,
+                           sizeof msg->get_config);
+
+    msg->get_config.offset = cpu_to_le32(offset);
+    msg->get_config.size = cpu_to_le32(size);
+}
+
+static inline void virtio_msg_pack_get_config_resp(VirtIOMSG *msg,
+                                                   uint16_t dev_num,
+                                                   uint16_t token,
+                                                   uint32_t size,
+                                                   uint32_t offset,
+                                                   uint32_t generation,
+                                                   uint8_t data[])
+{
+    assert(size <= VIRTIO_MSG_MAX_CONFIG_BYTES);
+
+    virtio_msg_pack_header(msg, VIRTIO_MSG_GET_CONFIG,
+                           VIRTIO_MSG_TYPE_RESPONSE, dev_num, token,
+                           sizeof msg->get_config_resp + size);
+
+    msg->get_config_resp.generation = cpu_to_le32(generation);
+    msg->get_config_resp.offset = cpu_to_le32(offset);
+    msg->get_config_resp.size = cpu_to_le32(size);
+
+    memcpy(&msg->get_config_resp.data, data, size);
+}
+
+static inline void virtio_msg_pack_set_config(VirtIOMSG *msg,
+                                              uint16_t dev_num,
+                                              uint16_t token,
+                                              uint32_t size,
+                                              uint32_t offset,
+                                              uint32_t generation,
+                                              uint8_t data[])
+{
+    assert(size <= VIRTIO_MSG_MAX_CONFIG_BYTES);
+
+    virtio_msg_pack_header(msg, VIRTIO_MSG_SET_CONFIG, 0, dev_num, token,
+                           sizeof msg->set_config + size);
+
+    msg->set_config.offset = cpu_to_le32(offset);
+    msg->set_config.size = cpu_to_le32(size);
+    msg->set_config.generation = cpu_to_le32(generation);
+
+    memcpy(&msg->set_config.data, data, size);
+}
+
+static inline void virtio_msg_pack_set_config_resp(VirtIOMSG *msg,
+                                                   uint16_t dev_num,
+                                                   uint16_t token,
+                                                   uint32_t size,
+                                                   uint32_t offset,
+                                                   uint32_t generation,
+                                                   uint8_t data[])
+{
+    assert(size <= VIRTIO_MSG_MAX_CONFIG_BYTES);
+
+    virtio_msg_pack_header(msg, VIRTIO_MSG_SET_CONFIG,
+                           VIRTIO_MSG_TYPE_RESPONSE, dev_num, token,
+                           sizeof msg->set_config_resp + size);
+
+    msg->set_config_resp.offset = cpu_to_le32(offset);
+    msg->set_config_resp.size = cpu_to_le32(size);
+    msg->set_config_resp.generation = cpu_to_le32(generation);
+
+    memcpy(&msg->set_config_resp.data, data, size);
+}
+
+static inline void virtio_msg_pack_get_vqueue(VirtIOMSG *msg,
+                                              uint16_t dev_num,
+                                              uint16_t token,
+                                              uint32_t index)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_GET_VQUEUE, 0, dev_num, token,
+                           sizeof msg->get_vqueue);
+
+    msg->get_vqueue.index = cpu_to_le32(index);
+}
+
+static inline void virtio_msg_pack_get_vqueue_resp(VirtIOMSG *msg,
+                                                   uint16_t dev_num,
+                                                   uint16_t token,
+                                                   uint32_t index,
+                                                   uint32_t max_size,
+                                                   uint32_t size,
+                                                   uint64_t descriptor_addr,
+                                                   uint64_t driver_addr,
+                                                   uint64_t device_addr)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_GET_VQUEUE,
+                           VIRTIO_MSG_TYPE_RESPONSE, dev_num, token,
+                           sizeof msg->get_vqueue_resp);
+
+    msg->get_vqueue_resp.index = cpu_to_le32(index);
+    msg->get_vqueue_resp.max_size = cpu_to_le32(max_size);
+    msg->get_vqueue_resp.size = cpu_to_le32(size);
+    msg->get_vqueue_resp.descriptor_addr = cpu_to_le64(descriptor_addr);
+    msg->get_vqueue_resp.driver_addr = cpu_to_le64(driver_addr);
+    msg->get_vqueue_resp.device_addr = cpu_to_le64(device_addr);
+}
+
+static inline void virtio_msg_pack_reset_vqueue(VirtIOMSG *msg,
+                                                uint16_t dev_num,
+                                                uint16_t token,
+                                                uint32_t index)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_RESET_VQUEUE, 0, dev_num, token,
+                           sizeof msg->reset_vqueue);
+
+    msg->reset_vqueue.index = cpu_to_le32(index);
+}
+
+static inline void virtio_msg_pack_reset_vqueue_resp(VirtIOMSG *msg,
+                                                     uint16_t dev_num,
+                                                     uint16_t token)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_RESET_VQUEUE,
+                           VIRTIO_MSG_TYPE_RESPONSE, dev_num, token, 0);
+}
+
+static inline void virtio_msg_pack_set_vqueue(VirtIOMSG *msg,
+                                              uint16_t dev_num,
+                                              uint16_t token,
+                                              uint32_t index,
+                                              uint32_t size,
+                                              uint64_t descriptor_addr,
+                                              uint64_t driver_addr,
+                                              uint64_t device_addr)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_SET_VQUEUE, 0, dev_num, token,
+                           sizeof msg->set_vqueue);
+
+    msg->set_vqueue.index = cpu_to_le32(index);
+    msg->set_vqueue.unused = 0;
+    msg->set_vqueue.size = cpu_to_le32(size);
+    msg->set_vqueue.descriptor_addr = cpu_to_le64(descriptor_addr);
+    msg->set_vqueue.driver_addr = cpu_to_le64(driver_addr);
+    msg->set_vqueue.device_addr = cpu_to_le64(device_addr);
+}
+
+static inline void virtio_msg_pack_set_vqueue_resp(VirtIOMSG *msg,
+                                                   uint16_t dev_num,
+                                                   uint16_t token)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_SET_VQUEUE,
+                           VIRTIO_MSG_TYPE_RESPONSE, dev_num, token, 0);
+}
+
+static inline void virtio_msg_pack_event_avail(VirtIOMSG *msg,
+                                               uint16_t dev_num,
+                                               uint32_t index,
+                                               uint32_t next_offset,
+                                               bool next_wrap)
+{
+    uint32_t next_ow;
+
+    virtio_msg_pack_header(msg, VIRTIO_MSG_EVENT_AVAIL, 0, dev_num, 0,
+                           sizeof msg->event_avail);
+
+    /* next_offset is 31b wide.  */
+    assert((next_offset & 0x80000000U) == 0);
+
+    /* Pack the next_offset_wrap field. */
+    next_ow = next_wrap << 31;
+    next_ow |= next_offset;
+
+    msg->event_avail.index = cpu_to_le32(index);
+    msg->event_avail.next_offset_wrap = cpu_to_le32(next_ow);
+}
+
+static inline void virtio_msg_pack_event_used(VirtIOMSG *msg,
+                                              uint16_t dev_num,
+                                              uint32_t index)
+{
+    virtio_msg_pack_header(msg, VIRTIO_MSG_EVENT_USED, 0, dev_num, 0,
+                           sizeof msg->event_used);
+
+    msg->event_used.index = cpu_to_le32(index);
+}
+
+static inline void virtio_msg_pack_event_config(VirtIOMSG *msg,
+                                                uint16_t dev_num,
+                                                uint32_t status,
+                                                uint32_t generation,
+                                                uint32_t offset,
+                                                uint32_t size,
+                                                uint8_t *value)
+{
+    unsigned int max_size;
+
+    virtio_msg_pack_header(msg, VIRTIO_MSG_EVENT_CONFIG, 0, dev_num, 0,
+                           sizeof msg->event_config);
+
+    msg->event_config.status = cpu_to_le32(status);
+    msg->event_config.generation = cpu_to_le32(generation);
+    msg->event_config.offset = cpu_to_le32(offset);
+    msg->event_config.size = cpu_to_le32(size);
+
+    max_size = VIRTIO_MSG_MAX_SIZE;
+    max_size -= offsetof(VirtIOMSG, event_config.config_value);
+    assert(size <= max_size);
+
+    if (size > 0 && size <= max_size) {
+        memcpy(&msg->event_config.config_value[0], value, size);
+    }
+}
+
+static inline void virtio_msg_pack_bus_get_devices(VirtIOMSG *msg,
+                                                   uint16_t offset,
+                                                   uint16_t num)
+{
+    virtio_msg_pack_header(msg,
+                           VIRTIO_MSG_BUS_GET_DEVICES, VIRTIO_MSG_TYPE_BUS,
+                           0, 0, sizeof msg->bus_get_devices);
+
+    msg->bus_get_devices.offset = cpu_to_le16(offset);
+    msg->bus_get_devices.num = cpu_to_le16(num);
+}
+
+static inline void virtio_msg_pack_bus_get_devices_resp(VirtIOMSG *msg,
+                                                        uint16_t offset,
+                                                        uint16_t num,
+                                                        uint16_t next_offset,
+                                                        uint8_t *data)
+{
+    virtio_msg_pack_header(msg,
+                           VIRTIO_MSG_BUS_GET_DEVICES,
+                           VIRTIO_MSG_TYPE_BUS | VIRTIO_MSG_TYPE_RESPONSE,
+                           0, 0, sizeof msg->bus_get_devices_resp + num);
+
+    msg->bus_get_devices_resp.offset = cpu_to_le16(offset);
+    msg->bus_get_devices_resp.num = cpu_to_le16(num);
+    msg->bus_get_devices_resp.next_offset = cpu_to_le16(next_offset);
+
+    memcpy(msg->bus_get_devices_resp.data, data, num / 8);
+}
+
+static inline const char *virtio_msg_id_to_str(unsigned int type)
+{
+#define VIRTIO_MSG_TYPE2STR(x) [VIRTIO_MSG_ ## x] = stringify(x)
+    static const char *type2str[VIRTIO_MSG_MAX + 1] = {
+        VIRTIO_MSG_TYPE2STR(DEVICE_INFO),
+        VIRTIO_MSG_TYPE2STR(GET_FEATURES),
+        VIRTIO_MSG_TYPE2STR(SET_FEATURES),
+        VIRTIO_MSG_TYPE2STR(GET_CONFIG),
+        VIRTIO_MSG_TYPE2STR(SET_CONFIG),
+        VIRTIO_MSG_TYPE2STR(GET_DEVICE_STATUS),
+        VIRTIO_MSG_TYPE2STR(SET_DEVICE_STATUS),
+        VIRTIO_MSG_TYPE2STR(GET_VQUEUE),
+        VIRTIO_MSG_TYPE2STR(SET_VQUEUE),
+        VIRTIO_MSG_TYPE2STR(RESET_VQUEUE),
+        VIRTIO_MSG_TYPE2STR(EVENT_CONFIG),
+        VIRTIO_MSG_TYPE2STR(EVENT_AVAIL),
+        VIRTIO_MSG_TYPE2STR(EVENT_USED),
+    };
+
+    return type2str[type];
+}
+
+static inline void virtio_msg_print_status(uint32_t status)
+{
+    printf("status %x", status);
+
+    if (status & VIRTIO_CONFIG_S_ACKNOWLEDGE) {
+        printf(" ACKNOWLEDGE");
+    }
+    if (status & VIRTIO_CONFIG_S_DRIVER) {
+        printf(" DRIVER");
+    }
+    if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+        printf(" DRIVER_OK");
+    }
+    if (status & VIRTIO_CONFIG_S_FEATURES_OK) {
+        printf(" FEATURES_OK");
+    }
+    if (status & VIRTIO_CONFIG_S_NEEDS_RESET) {
+        printf(" NEEDS_RESET");
+    }
+    if (status & VIRTIO_CONFIG_S_FAILED) {
+        printf(" FAILED");
+    }
+
+    printf("\n");
+}
+
+static inline void virtio_msg_print(VirtIOMSG *msg)
+{
+    bool resp = msg->type & VIRTIO_MSG_TYPE_RESPONSE;
+    size_t payload_size;
+    int i;
+
+    assert(msg);
+    printf("virtio-msg: id %s 0x%x type 0x%x dev_num 0x%x msg_size 0x%x\n",
+           virtio_msg_id_to_str(msg->msg_id), msg->msg_id,
+           msg->type, msg->dev_num, msg->msg_size);
+
+    payload_size = msg->msg_size - offsetof(VirtIOMSG, payload_u8);
+    if (payload_size > ARRAY_SIZE(msg->payload_u8)) {
+        printf("Size overflow! %zu > %zu\n",
+                payload_size, ARRAY_SIZE(msg->payload_u8));
+        payload_size = ARRAY_SIZE(msg->payload_u8);
+    }
+
+    for (i = 0; i < payload_size; i++) {
+        printf("%2.2x ", msg->payload_u8[i]);
+        if (((i + 1) %  16) == 0) {
+            printf("\n");
+        }
+    }
+
+    switch (msg->msg_id) {
+    case VIRTIO_MSG_GET_DEVICE_STATUS:
+        if (resp) {
+            virtio_msg_print_status(msg->get_device_status_resp.status);
+        }
+        break;
+    case VIRTIO_MSG_SET_DEVICE_STATUS:
+        virtio_msg_print_status(msg->set_device_status.status);
+        break;
+    case VIRTIO_MSG_SET_VQUEUE:
+        printf("set-vqueue: index=%d size=%d desc-addr=%lx "
+               "driver-addr=%lx device-addr=%lx\n",
+               msg->set_vqueue.index, msg->set_vqueue.size,
+               msg->set_vqueue.descriptor_addr,
+               msg->set_vqueue.driver_addr,
+               msg->set_vqueue.device_addr);
+        break;
+    }
+    printf("\n");
+}
+#endif
diff --git a/include/hw/virtio/virtio-msg.h b/include/hw/virtio/virtio-msg.h
new file mode 100644
index 0000000000..e92bad84d2
--- /dev/null
+++ b/include/hw/virtio/virtio-msg.h
@@ -0,0 +1,56 @@
+/*
+ * Virtio MSG bindings
+ *
+ * Copyright (c) 2024 Advanced Micro Devices, Inc.
+ * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VIRTIO_MSG_H
+#define HW_VIRTIO_MSG_H
+
+#include "hw/sysbus.h"
+#include "hw/virtio/virtio-bus.h"
+
+#define TYPE_VIRTIO_MSG_PROXY_BUS "virtio-msg-proxy-bus"
+/* This is reusing the VirtioBusState typedef from TYPE_VIRTIO_BUS */
+DECLARE_OBJ_CHECKERS(VirtioBusState, VirtioBusClass,
+                     VIRTIO_MSG_PROXY_BUS, TYPE_VIRTIO_MSG_PROXY_BUS)
+
+#define TYPE_VIRTIO_MSG_OUTER_BUS "virtio-msg-outer-bus"
+OBJECT_DECLARE_SIMPLE_TYPE(BusState, VIRTIO_MSG_OUTER_BUS)
+
+#define TYPE_VIRTIO_MSG_DEV "virtio-msg-dev"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtIOMSGDev, VIRTIO_MSG_DEV)
+
+#define TYPE_VIRTIO_MSG "virtio-msg"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtIOMSGProxy, VIRTIO_MSG)
+
+struct VirtIOMSGDev {
+    DeviceState parent_obj;
+
+    /* virtio-bus */
+    VirtioBusState bus;
+
+    VirtIOMSGProxy *proxy;
+    uint16_t dev_num;
+    uint64_t guest_features;
+};
+
+#define VIRTIO_MSG_MAX_DEVS 32
+struct VirtIOMSGProxy {
+    DeviceState parent_obj;
+
+    AddressSpace dma_as;
+    AddressSpace *bus_as;
+    IOMMUMemoryRegion mr_iommu;
+    MemoryRegion *mr_bus;
+
+    BusState devs_bus[VIRTIO_MSG_MAX_DEVS];
+    VirtIOMSGDev devs[VIRTIO_MSG_MAX_DEVS];
+
+    /* virtio-msg-bus.  */
+    BusState msg_bus;
+};
+#endif
-- 
2.43.0


