Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF375C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 15:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ7ey-0000R7-5D; Sat, 06 Jul 2024 11:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krashmisha@gmail.com>)
 id 1sQ7ex-0000Qp-6x; Sat, 06 Jul 2024 11:49:11 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <krashmisha@gmail.com>)
 id 1sQ7eu-0006oT-OC; Sat, 06 Jul 2024 11:49:10 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52db11b1d31so3811475e87.0; 
 Sat, 06 Jul 2024 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720280945; x=1720885745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ps1OTsPgHu7DmiiaBr2/1FO/1RwAhAJwt/LoB4lQR0Y=;
 b=O0MUxS4RVMM0fiZ5/4f4LXvPWI8VaJLlaP8b5QbMtT2DpOc5UWE0qdUy0ddeU3g6El
 OEZtLBQSf4o5ONyvG9elhDTh0UA+P1TkJmYs8YoaBPe263XiUGnHqvwOo1V+9glPdDBY
 8P84Z/MQt7InBXpJBGQIwym+sglhiEMw+mHLj5LMe2BO8In4sX5RfLmRQRLKKT7gF/d4
 YW8+OTtVJHPpgRZLzrQF9w19JZo0100WC4Vdbt5n6UGnx4idduHP/Ruzh8qGd8zX8kG7
 8Dx7bS4+XWEP/YuYj28f0wgh7MH+42QT6iU3wCCqmT1hKdHeq3qbumI2tA00yVv2VLgI
 TaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720280945; x=1720885745;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ps1OTsPgHu7DmiiaBr2/1FO/1RwAhAJwt/LoB4lQR0Y=;
 b=hb2LrMEh99mXJbRA0FIrP4p4XMNh+H7WrSCP64pJTG0yPnPddESFub4kT70azWApO7
 AoCRW8Pc46NfoW2IKsavYMpNUysV30cZzSW5C+OSWOv176TqbiErPX82U2voQeRirq/e
 4sUy0V2CPGJlf1n+8aiVURYFhPFEN1eJd0qDKKVzX/BWgwQWTkFELA51BgYtDFCceVzx
 MJN5w4FciV8vJ/uor4nqiNkXEiKnjQmaRWKZnmBPZ5opWCK8sP09S5e691z2oHvgK806
 tRxqP04vbdRFyYFGVnfUTYagejhsJILt4EAGoHWMMi+HZqa0TrvMC0PTBw5DY0O5vv6H
 JDEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNe48UtMbIiZ0FHP0YRiDH1EVBy7brhe7mQ+hQ2hoUdsOHEIq/JTAN5Wx1ggINRigV5jmtpdmTy0obw8eTKPB+UjDFcGI=
X-Gm-Message-State: AOJu0YymtHKy1T/FZ0lfHEOvjnpC+W/uqhx8eGgeh1IXSB9xKs96DvXi
 OAT88+4YuA91XPJLVWjzGk69YcYxfmVTLhADEWWTcGr0ozz4FJMu5whPBlQTOsU=
X-Google-Smtp-Source: AGHT+IEvLyGlW5W67H2bKCln75xIyQhqRHTIbqkgr0TUn0Iebp5RyzKmMHF+a3R7oymO0ZMp2AdhpQ==
X-Received: by 2002:a05:6512:4804:b0:52e:8b15:7c55 with SMTP id
 2adb3069b0e04-52ea0629e49mr5298708e87.27.1720280944813; 
 Sat, 06 Jul 2024 08:49:04 -0700 (PDT)
Received: from localhost.localdomain ([176.194.243.4])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ea91adaa3sm261593e87.25.2024.07.06.08.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 08:49:04 -0700 (PDT)
From: Mikhail Krasheninnikov <krashmisha@gmail.com>
To: qemu-devel@nongnu.org
Cc: Mi <krashmisha@gmail.com>, Matwey Kornilov <matwey.kornilov@gmail.com>,
 qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH RFC v4] virtio: Implement Virtio Backend for SD/MMC in QEMU
Date: Sat,  6 Jul 2024 15:48:40 +0000
Message-Id: <20240706154840.39503-1-krashmisha@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=krashmisha@gmail.com; helo=mail-lf1-x12e.google.com
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

From: Mi <krashmisha@gmail.com>

Add a Virtio backend for SD/MMC devices. Confirmed interoperability with
Linux.

Linux patch link: https://lore.kernel.org/linux-mmc/20240701120642.30001-1-krashmisha@gmail.com/

Signed-off-by: Mikhail Krasheninnikov <krashmisha@gmail.com>
CC: Matwey Kornilov <matwey.kornilov@gmail.com>
CC: qemu-block@nongnu.org
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---

Changes from v3:
 - Many structs were moved to uapi in kernel patch (new link would be
   sent as response to this letter). This patch integrates them.
 - Since there's no corresponding patch to Virtio specification yet,
   this patch is marked as RFC.

 hw/block/Kconfig                              |   6 +
 hw/block/meson.build                          |   1 +
 hw/block/virtio-sdhci.c                       | 142 ++++++++++++++++++
 hw/virtio/meson.build                         |   1 +
 hw/virtio/virtio-sdhci-pci.c                  |  86 +++++++++++
 hw/virtio/virtio.c                            |   3 +-
 include/hw/virtio/virtio-sdhci.h              |  22 +++
 include/standard-headers/linux/virtio_ids.h   |   1 +
 include/standard-headers/linux/virtio_sdhci.h |  39 +++++
 9 files changed, 300 insertions(+), 1 deletion(-)
 create mode 100644 hw/block/virtio-sdhci.c
 create mode 100644 hw/virtio/virtio-sdhci-pci.c
 create mode 100644 include/hw/virtio/virtio-sdhci.h
 create mode 100644 include/standard-headers/linux/virtio_sdhci.h

diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 9e8f28f982..5b5363da01 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -44,3 +44,9 @@ config VHOST_USER_BLK
 
 config SWIM
     bool
+
+config VIRTIO_SDHCI
+    bool
+    default y
+    select SD
+    depends on VIRTIO
diff --git a/hw/block/meson.build b/hw/block/meson.build
index 8aa4dc3893..82356c264e 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -19,5 +19,6 @@ system_ss.add(when: 'CONFIG_TC58128', if_true: files('tc58128.c'))
 
 specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c', 'virtio-blk-common.c'))
 specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c', 'virtio-blk-common.c'))
+specific_ss.add(when: 'CONFIG_VIRTIO_SDHCI', if_true: files('virtio-sdhci.c'))
 
 subdir('dataplane')
diff --git a/hw/block/virtio-sdhci.c b/hw/block/virtio-sdhci.c
new file mode 100644
index 0000000000..d3a90f7b5a
--- /dev/null
+++ b/hw/block/virtio-sdhci.c
@@ -0,0 +1,142 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-sdhci.h"
+#include "qemu/typedefs.h"
+#include "sysemu/blockdev.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_sdhci.h"
+
+static void send_command(SDBus *sdbus, struct mmc_req *mmc_request, uint8_t *response,
+                         struct virtio_mmc_response *virtio_resp)
+{
+    SDRequest sdreq;
+    int resp_len;
+
+    sdreq.cmd = (uint8_t)mmc_request->opcode;
+    sdreq.arg = mmc_request->arg;
+    resp_len = sdbus_do_command(sdbus, &sdreq, response);
+    virtio_resp->cmd_resp_len = resp_len;
+
+    for (int i = 0; i < resp_len / sizeof(__le32); i++) {
+        virtio_resp->cmd_resp[i] = ldl_be_p(&virtio_resp->cmd_resp[i]);
+    }
+}
+
+static void send_command_without_response(SDBus *sdbus, struct mmc_req *mmc_request)
+{
+    SDRequest sdreq;
+    uint8_t response[4];
+
+    sdreq.cmd = (uint8_t)mmc_request->opcode;
+    sdreq.arg = mmc_request->arg;
+    sdbus_do_command(sdbus, &sdreq, response);
+}
+
+static void handle_mmc_request(VirtIODevice *vdev, struct virtio_mmc_request *virtio_req,
+                               struct virtio_mmc_response *virtio_resp)
+{
+    VirtIOSDHCI *vsd = VIRTIO_SDHCI(vdev);
+    SDBus *sdbus = &vsd->sdbus;
+
+    if (virtio_req->flags & VIRTIO_MMC_REQUEST_SBC) {
+        send_command_without_response(sdbus, &virtio_req->sbc_req);
+    }
+
+    send_command(sdbus, &virtio_req->request,
+    (uint8_t *)virtio_resp->cmd_resp, virtio_resp);
+
+    if (virtio_req->flags & VIRTIO_MMC_REQUEST_DATA) {
+        if (virtio_req->flags & VIRTIO_MMC_REQUEST_WRITE) {
+            sdbus_write_data(sdbus, virtio_req->buf, virtio_req->buf_len);
+        } else {
+            sdbus_read_data(sdbus, virtio_resp->buf, virtio_req->buf_len);
+        }
+    }
+
+    if (virtio_req->flags & VIRTIO_MMC_REQUEST_STOP) {
+        send_command_without_response(sdbus, &virtio_req->stop_req);
+    }
+}
+
+static void handle_request(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtQueueElement *elem;
+    struct virtio_mmc_request virtio_req;
+    struct virtio_mmc_response virtio_resp;
+
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+
+    iov_to_buf(elem->out_sg, elem->out_num, 0,
+    &virtio_req, sizeof(struct virtio_mmc_request));
+
+    handle_mmc_request(vdev, &virtio_req, &virtio_resp);
+
+    iov_from_buf(elem->in_sg, elem->in_num, 0,
+    &virtio_resp, sizeof(struct virtio_mmc_response));
+
+    virtqueue_push(vq, elem, 1);
+
+    virtio_notify(vdev, vq);
+}
+
+static void virtio_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIOSDHCI *vsd = VIRTIO_SDHCI(dev);
+
+    virtio_init(vdev, VIRTIO_ID_SDHCI, 0);
+
+    vsd->vq = virtio_add_queue(vdev, 1, handle_request);
+
+    BlockBackend *blk = vsd->blk;
+    if (!blk) {
+        error_setg(errp, "Block backend not found");
+        return;
+    }
+
+    qbus_init(&vsd->sdbus, sizeof(vsd->sdbus), TYPE_SD_BUS, dev, "sd-bus");
+    DeviceState *card = qdev_new(TYPE_SD_CARD);
+    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
+    qdev_realize_and_unref(card,
+    qdev_get_child_bus(dev, "sd-bus"), &error_fatal);
+}
+
+static void virtio_sdhci_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    virtio_cleanup(vdev);
+}
+
+static uint64_t virtio_sdhci_get_features(VirtIODevice *vdev,
+                                          uint64_t features, Error **errp)
+{
+    return features;
+}
+
+static void virtio_sdhci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *k = VIRTIO_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+
+    k->realize = virtio_sdhci_realize;
+    k->unrealize = virtio_sdhci_unrealize;
+    k->get_features = virtio_sdhci_get_features;
+}
+
+static const TypeInfo virtio_sdhci_info = {
+    .name = TYPE_VIRTIO_SDHCI,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VirtIOSDHCI),
+    .class_init = virtio_sdhci_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&virtio_sdhci_info);
+}
+
+type_init(virtio_register_types)
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 47baf00366..c7a8707ba6 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -68,6 +68,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-md-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SDHCI', if_true: files('virtio-sdhci-pci.c'))
 
 specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
diff --git a/hw/virtio/virtio-sdhci-pci.c b/hw/virtio/virtio-sdhci-pci.c
new file mode 100644
index 0000000000..889352f577
--- /dev/null
+++ b/hw/virtio/virtio-sdhci-pci.c
@@ -0,0 +1,86 @@
+#include "qemu/osdep.h"
+
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-sdhci.h"
+#include "hw/qdev-properties-system.h"
+#include "qemu/typedefs.h"
+#include "qapi/error.h"
+#include "sysemu/block-backend-global-state.h"
+
+typedef struct VirtIOSDHCIPCI VirtIOSDHCIPCI;
+
+/*
+ * virtio-mmc-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_SDHCI_PCI "virtio-sdhci-pci-base"
+DECLARE_INSTANCE_CHECKER(VirtIOSDHCIPCI, VIRTIO_SDHCI_PCI,
+                         TYPE_VIRTIO_SDHCI_PCI)
+
+struct VirtIOSDHCIPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOSDHCI vdev;
+    BlockBackend *blk;
+};
+
+static void virtio_sdhci_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOSDHCIPCI *vsd = VIRTIO_SDHCI_PCI(vpci_dev);
+    DeviceState *dev = DEVICE(&vsd->vdev);
+    VirtIOSDHCI *vsd_dev;
+
+    if (!vsd->blk) {
+        error_setg(errp, "Drive property not set");
+        return;
+    }
+    vsd_dev = &vsd->vdev;
+    vsd_dev->blk = vsd->blk;
+    blk_detach_dev(vsd->blk, DEVICE(vpci_dev));
+
+    qdev_set_parent_bus(dev, BUS(&vpci_dev->bus), errp);
+
+    virtio_pci_force_virtio_1(vpci_dev);
+    object_property_set_bool(OBJECT(dev), "realized", true, errp);
+}
+
+static Property virtio_sdhci_properties[] = {
+    DEFINE_PROP_DRIVE("drive", VirtIOSDHCIPCI, blk),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_sdhci_pci_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    VirtioPCIClass *virtio_pci_class = VIRTIO_PCI_CLASS(oc);
+    PCIDeviceClass *pci_device_class = PCI_DEVICE_CLASS(oc);
+
+    device_class_set_props(dc, virtio_sdhci_properties);
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+
+    virtio_pci_class->realize = virtio_sdhci_pci_realize;
+
+    pci_device_class->revision = VIRTIO_PCI_ABI_VERSION;
+    pci_device_class->class_id = PCI_CLASS_MEMORY_FLASH;
+}
+
+static void virtio_sdhci_pci_instance_init(Object *obj)
+{
+    VirtIOSDHCIPCI *dev = VIRTIO_SDHCI_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_SDHCI);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_sdhci_pci_info = {
+    .base_name     = TYPE_VIRTIO_SDHCI_PCI,
+    .generic_name  = "virtio-sdhci-pci",
+    .instance_size = sizeof(VirtIOSDHCIPCI),
+    .class_init    = virtio_sdhci_pci_class_init,
+    .instance_init = virtio_sdhci_pci_instance_init,
+};
+
+static void virtio_sdhci_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_sdhci_pci_info);
+}
+
+type_init(virtio_sdhci_pci_register)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 7549094154..90a346dfc0 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -193,7 +193,8 @@ const char *virtio_device_names[] = {
     [VIRTIO_ID_PARAM_SERV] = "virtio-param-serv",
     [VIRTIO_ID_AUDIO_POLICY] = "virtio-audio-pol",
     [VIRTIO_ID_BT] = "virtio-bluetooth",
-    [VIRTIO_ID_GPIO] = "virtio-gpio"
+    [VIRTIO_ID_GPIO] = "virtio-gpio",
+    [VIRTIO_ID_SDHCI] = "virtio-sdhci",
 };
 
 static const char *virtio_id_to_name(uint16_t device_id)
diff --git a/include/hw/virtio/virtio-sdhci.h b/include/hw/virtio/virtio-sdhci.h
new file mode 100644
index 0000000000..0d91f4a973
--- /dev/null
+++ b/include/hw/virtio/virtio-sdhci.h
@@ -0,0 +1,22 @@
+#ifndef QEMU_VIRTIO_SDHCI_H
+#define QEMU_VIRTIO_SDHCI_H
+
+#include "hw/virtio/virtio.h"
+#include "hw/sd/sd.h"
+#include "qemu/typedefs.h"
+
+#define TYPE_VIRTIO_SDHCI "virtio-sdhci-device"
+#define VIRTIO_SDHCI(obj) \
+    OBJECT_CHECK(VirtIOSDHCI, (obj), TYPE_VIRTIO_SDHCI)
+#define VIRTIO_SDHCI_GET_PARENT_CLASS(obj) \
+    OBJECT_GET_PARENT_CLASS(VIRTIO_SDHCI(obj), TYPE_VIRTIO_SDHCI)
+
+typedef struct VirtIOSDHCI {
+    VirtIODevice parent_obj;
+
+    VirtQueue *vq;
+    SDBus sdbus;
+    BlockBackend *blk;
+} VirtIOSDHCI;
+
+#endif
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 7aa2eb7662..7f13999359 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -68,6 +68,7 @@
 #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
+#define VIRTIO_ID_SDHCI			42 /* virtio sdhci */
 
 /*
  * Virtio Transitional IDs
diff --git a/include/standard-headers/linux/virtio_sdhci.h b/include/standard-headers/linux/virtio_sdhci.h
new file mode 100644
index 0000000000..d620441c4a
--- /dev/null
+++ b/include/standard-headers/linux/virtio_sdhci.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *  VirtIO SD/MMC driver
+ *
+ *  Author: Mikhail Krasheninnikov <krashmisha@gmail.com>
+ */
+#ifndef _LINUX_VIRTIO_MMC_H
+#define _LINUX_VIRTIO_MMC_H
+#include <linux/types.h>
+
+struct mmc_req {
+	__le32 opcode;
+	__le32 arg;
+};
+
+struct virtio_mmc_request {
+	uint8_t flags;
+
+#define VIRTIO_MMC_REQUEST_DATA BIT(1)
+#define VIRTIO_MMC_REQUEST_WRITE BIT(2)
+#define VIRTIO_MMC_REQUEST_STOP BIT(3)
+#define VIRTIO_MMC_REQUEST_SBC BIT(4)
+
+	struct mmc_req request;
+
+	uint8_t buf[4096];
+	__le32 buf_len;
+
+	struct mmc_req stop_req;
+	struct mmc_req sbc_req;
+};
+
+struct virtio_mmc_response {
+	__le32 cmd_resp[4];
+	int cmd_resp_len;
+	uint8_t buf[4096];
+};
+
+#endif /* _LINUX_VIRTIO_MMC_H */
-- 
2.34.1


