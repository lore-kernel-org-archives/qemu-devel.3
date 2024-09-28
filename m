Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030A9CF6496
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 09:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suTIi-0005fu-Tn; Sat, 28 Sep 2024 04:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTIe-0005OR-Fr
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:59:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTIb-0002Ss-Fl
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:59:36 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37ccdc0d7f6so1565972f8f.0
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 01:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1727513971; x=1728118771;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnJbHfbRpxiH7lm9OYUgmVKZzN/3LCteRLW7vnwJa7M=;
 b=QNg9TPELGjoL5duAwvUBXR/fkYStU4/l/8qNad44+yCxfGZ74LRhuNXjG44VZZR4ET
 X1MzybwIuT6+WXoafmrCKs5/da5lZPbcDmlP69NbibWTwBRVk9++8AqnwjOHOgcizsDe
 Ei/XdTx3Yv3kFk5CFHrlmbzgZrx590ApYDMyOpL+XXRtfiTm3DFJW2LA163rmFk/7oQO
 IwmgGcE8c2sti40RL4FLy+cYS28itNS6nicb7uHxNMa5EIj2rbdM7cgDRG3cvR50Ch3p
 tz52LJnW01DyYLZyeqK6wyX1MaibVh0KtNFlg/ddmzuLalt7Nx9q7Q14CPUSUozQGCfE
 RX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727513971; x=1728118771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vnJbHfbRpxiH7lm9OYUgmVKZzN/3LCteRLW7vnwJa7M=;
 b=IjPuRIAZ5PDRM814YocklUo3ZAtPbx7MOuH22ovt3hOOZmla5LjteParvoxLfekKu5
 s95tllk6kizsLI/1Rua+kzjiyi0z9J16nXSoI+8O5dDczO7WdgyxCEv5F53SOzhg0gK5
 A/F9iErIPFQgmlpf8L7bDmO9DeuTEkQ7Y/JOaQ1uzmuPXG6xo6tU6r18SPIhBJoZEfbM
 TsLdRzyNMHLaZ2cNzgO5JGQxW0C9+KJYOSR8sIj51PUFewhbOuBbpKdZuHl8dePdVICd
 g1jwW+cCLSxCCq0o8bouwnGMLygDpPRf5ulnrzyxaMs8RlPSE1QLY9K/Vr9fc4aLtiUR
 T4Lg==
X-Gm-Message-State: AOJu0YwfBn3uWHjLtYjPye4aMlCnDabZYXdqw5xwf8WhBKzuRpsWncOs
 Y4kEPPyZWiUdHwowq55zRf8eSyKQyhQtzgVVTRiPg0w84ChFITSmwJrZ4FA0tu7ymESaVuHBk6X
 ZYQ==
X-Google-Smtp-Source: AGHT+IEqYjbKQj/waLteF3SmDa8WqqfWxrXj/vn12Y0qkz0bxphs/J+TZdcBTfpCWZuEIlYmtJL/GQ==
X-Received: by 2002:a05:6000:108f:b0:37c:cd0d:3437 with SMTP id
 ffacd0b85a97d-37cd5b09c91mr2650715f8f.58.1727513970866; 
 Sat, 28 Sep 2024 01:59:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bb8:2ae:e42d:7dbb:76ba:120d:8a28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57423afsm4313167f8f.90.2024.09.28.01.59.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Sep 2024 01:59:30 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Subject: [PATCH v3 13/14] hw/vmapple/virtio-blk: Add support for apple
 virtio-blk
Date: Sat, 28 Sep 2024 10:57:26 +0200
Message-Id: <20240928085727.56883-14-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240928085727.56883-1-phil@philjordan.eu>
References: <20240928085727.56883-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::429;
 envelope-from=phil@philjordan.eu; helo=mail-wr1-x429.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

Apple has its own virtio-blk PCI device ID where it deviates from the
official virtio-pci spec slightly: It puts a new "apple type"
field at a static offset in config space and introduces a new barrier
command.

This patch first creates a mechanism for virtio-blk downstream classes to
handle unknown commands. It then creates such a downstream class and a new
vmapple-virtio-blk-pci class which support the additional apple type config
identifier as well as the barrier command.

It then exposes 2 subclasses from that that we can use to expose root and
aux virtio-blk devices: "vmapple-virtio-root" and "vmapple-virtio-aux".

Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/block/virtio-blk.c           |  19 ++-
 hw/vmapple/Kconfig              |   3 +
 hw/vmapple/meson.build          |   1 +
 hw/vmapple/virtio-blk.c         | 212 ++++++++++++++++++++++++++++++++
 include/hw/pci/pci_ids.h        |   1 +
 include/hw/virtio/virtio-blk.h  |  12 +-
 include/hw/vmapple/virtio-blk.h |  39 ++++++
 7 files changed, 282 insertions(+), 5 deletions(-)
 create mode 100644 hw/vmapple/virtio-blk.c
 create mode 100644 include/hw/vmapple/virtio-blk.h

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 115795392c4..cecc4cef9e4 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -50,12 +50,12 @@ static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
     req->mr_next = NULL;
 }
 
-static void virtio_blk_free_request(VirtIOBlockReq *req)
+void virtio_blk_free_request(VirtIOBlockReq *req)
 {
     g_free(req);
 }
 
-static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
+void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
 {
     VirtIOBlock *s = req->dev;
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
@@ -966,8 +966,18 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
         break;
     }
     default:
-        virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
-        virtio_blk_free_request(req);
+    {
+        /*
+         * Give subclasses a chance to handle unknown requests. This way the
+         * class lookup is not in the hot path.
+         */
+        VirtIOBlkClass *vbk = VIRTIO_BLK_GET_CLASS(s);
+        if (!vbk->handle_unknown_request ||
+            !vbk->handle_unknown_request(req, mrb, type)) {
+            virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
+            virtio_blk_free_request(req);
+        }
+    }
     }
     return 0;
 }
@@ -2044,6 +2054,7 @@ static const TypeInfo virtio_blk_info = {
     .instance_size = sizeof(VirtIOBlock),
     .instance_init = virtio_blk_instance_init,
     .class_init = virtio_blk_class_init,
+    .class_size = sizeof(VirtIOBlkClass),
 };
 
 static void virtio_register_types(void)
diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
index 8bbeb9a9237..bcd1be63e3c 100644
--- a/hw/vmapple/Kconfig
+++ b/hw/vmapple/Kconfig
@@ -7,3 +7,6 @@ config VMAPPLE_BDIF
 config VMAPPLE_CFG
     bool
 
+config VMAPPLE_VIRTIO_BLK
+    bool
+
diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
index 64b78693a31..bf17cf906c9 100644
--- a/hw/vmapple/meson.build
+++ b/hw/vmapple/meson.build
@@ -1,3 +1,4 @@
 system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
 system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
 system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true: files('cfg.c'))
+system_ss.add(when: 'CONFIG_VMAPPLE_VIRTIO_BLK',  if_true: files('virtio-blk.c'))
diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
new file mode 100644
index 00000000000..720eaa61a86
--- /dev/null
+++ b/hw/vmapple/virtio-blk.c
@@ -0,0 +1,212 @@
+/*
+ * VMApple specific VirtIO Block implementation
+ *
+ * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * VMApple uses almost standard VirtIO Block, but with a few key differences:
+ *
+ *  - Different PCI device/vendor ID
+ *  - An additional "type" identifier to differentiate AUX and Root volumes
+ *  - An additional BARRIER command
+ */
+
+#include "qemu/osdep.h"
+#include "hw/vmapple/virtio-blk.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+
+#define VIRTIO_BLK_T_APPLE_BARRIER     0x10000
+
+#define VIRTIO_APPLE_TYPE_ROOT 1
+#define VIRTIO_APPLE_TYPE_AUX  2
+
+static bool vmapple_virtio_blk_handle_unknown_request(VirtIOBlockReq *req,
+                                                      MultiReqBuffer *mrb,
+                                                      uint32_t type)
+{
+    switch (type) {
+    case VIRTIO_BLK_T_APPLE_BARRIER:
+        /* We ignore barriers for now. YOLO. */
+        virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
+        virtio_blk_free_request(req);
+        return true;
+    default:
+        return false;
+    }
+}
+
+/*
+ * VMApple virtio-blk uses the same config format as normal virtio, with one
+ * exception: It adds an "apple type" specififer at the same location that
+ * the spec reserves for max_secure_erase_sectors. Let's hook into the
+ * get_config code path here, run it as usual and then patch in the apple type.
+ */
+static void vmapple_virtio_blk_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VMAppleVirtIOBlk *dev = VMAPPLE_VIRTIO_BLK(vdev);
+    VMAppleVirtIOBlkClass *vvbk = VMAPPLE_VIRTIO_BLK_GET_CLASS(dev);
+    struct virtio_blk_config *blkcfg = (struct virtio_blk_config *)config;
+
+    vvbk->get_config(vdev, config);
+
+    g_assert(dev->parent_obj.config_size >= endof(struct virtio_blk_config, zoned));
+
+    /* Apple abuses the field for max_secure_erase_sectors as type id */
+    blkcfg->max_secure_erase_sectors = dev->apple_type;
+}
+
+static Property vmapple_virtio_blk_properties[] = {
+    DEFINE_PROP_UINT32("apple-type", VMAppleVirtIOBlk, apple_type, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vmapple_virtio_blk_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOBlkClass *vbk = VIRTIO_BLK_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    VMAppleVirtIOBlkClass *vvbk = VMAPPLE_VIRTIO_BLK_CLASS(klass);
+
+    vbk->handle_unknown_request = vmapple_virtio_blk_handle_unknown_request;
+    vvbk->get_config = vdc->get_config;
+    vdc->get_config = vmapple_virtio_blk_get_config;
+    device_class_set_props(dc, vmapple_virtio_blk_properties);
+}
+
+static const TypeInfo vmapple_virtio_blk_info = {
+    .name          = TYPE_VMAPPLE_VIRTIO_BLK,
+    .parent        = TYPE_VIRTIO_BLK,
+    .instance_size = sizeof(VMAppleVirtIOBlk),
+    .class_init    = vmapple_virtio_blk_class_init,
+};
+
+/* PCI Devices */
+
+typedef struct VMAppleVirtIOBlkPCI {
+    VirtIOPCIProxy parent_obj;
+    VMAppleVirtIOBlk vdev;
+    uint32_t apple_type;
+} VMAppleVirtIOBlkPCI;
+
+/*
+ * vmapple-virtio-blk-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VMAPPLE_VIRTIO_BLK_PCI "vmapple-virtio-blk-pci-base"
+DECLARE_INSTANCE_CHECKER(VMAppleVirtIOBlkPCI, VMAPPLE_VIRTIO_BLK_PCI,
+                         TYPE_VMAPPLE_VIRTIO_BLK_PCI)
+
+static Property vmapple_virtio_blk_pci_properties[] = {
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vmapple_virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+    VirtIOBlkConf *conf = &dev->vdev.parent_obj.conf;
+
+    if (conf->num_queues == VIRTIO_BLK_AUTO_NUM_QUEUES) {
+        conf->num_queues = virtio_pci_optimal_num_queues(0);
+    }
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = conf->num_queues + 1;
+    }
+
+    /*
+     * We don't support zones, but we need the additional config space size.
+     * Let's just expose the feature so the rest of the virtio-blk logic
+     * allocates enough space for us. The guest will ignore zones anyway.
+     */
+    virtio_add_feature(&dev->vdev.parent_obj.host_features, VIRTIO_BLK_F_ZONED);
+    /* Propagate the apple type down to the virtio-blk device */
+    qdev_prop_set_uint32(DEVICE(&dev->vdev), "apple-type", dev->apple_type);
+    /* and spawn the virtio-blk device */
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+
+    /*
+     * The virtio-pci machinery adjusts its vendor/device ID based on whether
+     * we support modern or legacy virtio. Let's patch it back to the Apple
+     * identifiers here.
+     */
+    pci_config_set_vendor_id(vpci_dev->pci_dev.config, PCI_VENDOR_ID_APPLE);
+    pci_config_set_device_id(vpci_dev->pci_dev.config, PCI_DEVICE_ID_APPLE_VIRTIO_BLK);
+}
+
+static void vmapple_virtio_blk_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    device_class_set_props(dc, vmapple_virtio_blk_pci_properties);
+    k->realize = vmapple_virtio_blk_pci_realize;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_APPLE;
+    pcidev_k->device_id = PCI_DEVICE_ID_APPLE_VIRTIO_BLK;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
+}
+
+static void vmapple_virtio_blk_pci_instance_init(Object *obj)
+{
+    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VMAPPLE_VIRTIO_BLK);
+}
+
+static const VirtioPCIDeviceTypeInfo vmapple_virtio_blk_pci_info = {
+    .base_name     = TYPE_VMAPPLE_VIRTIO_BLK_PCI,
+    .generic_name  = "vmapple-virtio-blk-pci",
+    .instance_size = sizeof(VMAppleVirtIOBlkPCI),
+    .instance_init = vmapple_virtio_blk_pci_instance_init,
+    .class_init    = vmapple_virtio_blk_pci_class_init,
+};
+
+static void vmapple_virtio_root_instance_init(Object *obj)
+{
+    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(obj);
+
+    dev->apple_type = VIRTIO_APPLE_TYPE_ROOT;
+}
+
+static const TypeInfo vmapple_virtio_root_info = {
+    .name          = TYPE_VMAPPLE_VIRTIO_ROOT,
+    .parent        = "vmapple-virtio-blk-pci",
+    .instance_size = sizeof(VMAppleVirtIOBlkPCI),
+    .instance_init = vmapple_virtio_root_instance_init,
+};
+
+static void vmapple_virtio_aux_instance_init(Object *obj)
+{
+    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(obj);
+
+    dev->apple_type = VIRTIO_APPLE_TYPE_AUX;
+}
+
+static const TypeInfo vmapple_virtio_aux_info = {
+    .name          = TYPE_VMAPPLE_VIRTIO_AUX,
+    .parent        = "vmapple-virtio-blk-pci",
+    .instance_size = sizeof(VMAppleVirtIOBlkPCI),
+    .instance_init = vmapple_virtio_aux_instance_init,
+};
+
+static void vmapple_virtio_blk_register_types(void)
+{
+    type_register_static(&vmapple_virtio_blk_info);
+    virtio_pci_types_register(&vmapple_virtio_blk_pci_info);
+    type_register_static(&vmapple_virtio_root_info);
+    type_register_static(&vmapple_virtio_aux_info);
+}
+
+type_init(vmapple_virtio_blk_register_types)
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index f1a53fea8d6..33e2898be95 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -191,6 +191,7 @@
 #define PCI_DEVICE_ID_APPLE_UNI_N_AGP    0x0020
 #define PCI_DEVICE_ID_APPLE_U3_AGP       0x004b
 #define PCI_DEVICE_ID_APPLE_UNI_N_GMAC   0x0021
+#define PCI_DEVICE_ID_APPLE_VIRTIO_BLK   0x1a00
 
 #define PCI_VENDOR_ID_SUN                0x108e
 #define PCI_DEVICE_ID_SUN_EBUS           0x1000
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 5c14110c4b1..28d5046ea6c 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -24,7 +24,7 @@
 #include "qapi/qapi-types-virtio.h"
 
 #define TYPE_VIRTIO_BLK "virtio-blk-device"
-OBJECT_DECLARE_SIMPLE_TYPE(VirtIOBlock, VIRTIO_BLK)
+OBJECT_DECLARE_TYPE(VirtIOBlock, VirtIOBlkClass, VIRTIO_BLK)
 
 /* This is the last element of the write scatter-gather list */
 struct virtio_blk_inhdr
@@ -100,6 +100,16 @@ typedef struct MultiReqBuffer {
     bool is_write;
 } MultiReqBuffer;
 
+typedef struct VirtIOBlkClass {
+    /*< private >*/
+    VirtioDeviceClass parent;
+    /*< public >*/
+    bool (*handle_unknown_request)(VirtIOBlockReq *req, MultiReqBuffer *mrb,
+                                   uint32_t type);
+} VirtIOBlkClass;
+
 void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq);
+void virtio_blk_free_request(VirtIOBlockReq *req);
+void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status);
 
 #endif
diff --git a/include/hw/vmapple/virtio-blk.h b/include/hw/vmapple/virtio-blk.h
new file mode 100644
index 00000000000..b23106a3dfb
--- /dev/null
+++ b/include/hw/vmapple/virtio-blk.h
@@ -0,0 +1,39 @@
+/*
+ * VMApple specific VirtIO Block implementation
+ *
+ * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_VMAPPLE_CFG_H
+#define HW_VMAPPLE_CFG_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-blk.h"
+
+#define TYPE_VMAPPLE_VIRTIO_BLK "vmapple-virtio-blk"
+#define TYPE_VMAPPLE_VIRTIO_ROOT "vmapple-virtio-root"
+#define TYPE_VMAPPLE_VIRTIO_AUX "vmapple-virtio-aux"
+
+OBJECT_DECLARE_TYPE(VMAppleVirtIOBlk, VMAppleVirtIOBlkClass, VMAPPLE_VIRTIO_BLK)
+
+typedef struct VMAppleVirtIOBlkClass {
+    /*< private >*/
+    VirtIOBlkClass parent;
+    /*< public >*/
+    void (*get_config)(VirtIODevice *vdev, uint8_t *config);
+} VMAppleVirtIOBlkClass;
+
+typedef struct VMAppleVirtIOBlk {
+    /* <private> */
+    VirtIOBlock parent_obj;
+
+    /* <public> */
+    uint32_t apple_type;
+} VMAppleVirtIOBlk;
+
+#endif /* HW_VMAPPLE_CFG_H */
-- 
2.39.3 (Apple Git-145)


