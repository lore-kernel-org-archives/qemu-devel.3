Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBA9C88E45
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nrE-0007tT-5o; Thu, 10 Sep 2026 19:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lRr-0005BW-AK
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lRV-0002c5-LC
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Pkx3kxAuiL1nB7bUYs1e0dAYEeoWG4XC8UPSEM/wlk=;
 b=QDO2ahh8kUpzxwE7YDAyH4p5g29y6V5oEyeBcFlJgv5+pfI9BABsxAicNpWkzN1MPnN+k+
 UhB3If/0hqUF+skjJHYwyFBnax9HwskKEYLUMWgSV/tSUqBTUR3DT3PkBGJ4+vIqE8ajO1
 HduIvuAzrozKWLMH9ruypQZdwkeoou0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-MY-9gvxmObyjAfyxyP0-vw-1; Thu, 10 Sep 2026 16:12:03 -0400
X-MC-Unique: MY-9gvxmObyjAfyxyP0-vw-1
X-Mimecast-MFC-AGG-ID: MY-9gvxmObyjAfyxyP0-vw_1789071121
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso1401685e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071121; x=1789675921; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7Pkx3kxAuiL1nB7bUYs1e0dAYEeoWG4XC8UPSEM/wlk=;
 b=n/2ksFCj99VHlIkxghIfXv5R6K4oombAafVU/7nNqOt+brQq/HE6BTQNuYD4aMGmI5
 X8ClKGKmETXByXTmV7hwer/LE7xiiMsQ0q09/uDaDbr1L1AL5vaigyqZVkqaOr/Ldqzg
 mUGHPYPEVTg9ATJFDCrLR34zuU0dWoWoUat3VZz56kZtPJApa4Befd3B9m0nq9V55TGc
 m4UDiaAPK0NaxzMdVhU+33x68j5EnQELGKxeuR0yQTg+Fuxwepna4tFSkndpFz8shwmv
 reSRbuRhCAtvUkUai4IVaXfkKtyEefeUsNXrxjIt5hFn+Q1oOjaPKRTMoZXSHQlMx4aD
 iv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071121; x=1789675921;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7Pkx3kxAuiL1nB7bUYs1e0dAYEeoWG4XC8UPSEM/wlk=;
 b=JjW1YcJwQVErHzv1quJllvMfoyEjKSBDrMMsKJ3bBc9kvDk4d2vYBX0Be4AOeSJH13
 HAS0jYta11K9FiMflegwirjLsZ1D2KmQpQ1T+4mezhN3zJEqupDCzi2uC3GWtNaJM2XV
 YNOQ3vOi6S3go86XpPPmK5aIPJaNmamK/jpeYKViEQVKVO+t+oXOveZ6YBEmbGr8PeJl
 0M1X0XZu1KPQCFpDlz6dvul1ha/gP/J5JoDuu0f1BzDYuPElhlviCOWhF5j5SGKtXkKg
 Rq7jF2Fc+ff37Z4LyCC/Xyg6ZVOwk3zqOgxgCNApZ4HGIEe9020JVYe8ljJwQaUTsBIV
 n7Sw==
X-Gm-Message-State: AFuF++ksr074DqsJaFC81SG014pfh3vrUlsxdILqrazVKVpfGd7oiVEd
 3+SeAh/AUdRAAD/mx/xT/sPJV8qKjIgVLA96TDB47zoeu2F61pofDQecHoqK7gAqHydW/HUOGjR
 csnyddK79tOmnYsIX/vCq2pft0ZwD5+GSU6UAJ/m/Xq0w7/YoqV2aW7LhoYyIEQll+Z3aK7nM0F
 OzhjzVgLsdj5IAwaNhlT3hkCP+loiwx1E29w==
X-Gm-Gg: AYBFou3kjMLUyjlCj8wSz2qoczmxqlsy1frG2TViz5vie6zzyDQ03Lg0J7W1FFtUf47
 S7l/KBQttw5fJcKpT4rnt3W9/Y9zaNWlfPZ5qKXXEn9hRDAO6MdMW01aCVn3ktz++Mc6WVKm6By
 VWYCDstSiq+XO2f0yIxwwxd70uHrSbK5tKIJy+LI5f8qyCxx6/4pB1gtMuBhsU+g0mhOWnXw6u2
 NfHYdPvPElbycA6cKBUcS6XvTnpbH4GoaQc9/rpO1LibD/A9sAGkMa8RH/c03SWYTUiHRHJ/gdJ
 qrQavuYpAzDoeWtRVL2Y1DtJ92G/Z26qBzLCTHWJ99OWZ93HspGFdIuYUPdWQZX4x/KiQ+3cNJS
 8plnNaWVQTQd8vzUT5n4/uS0=
X-Received: by 2002:a05:600c:a016:b0:49c:ffe3:2b3f with SMTP id
 5b1f17b1804b1-49e619a0458mr8567945e9.3.1789071121137; 
 Thu, 10 Sep 2026 13:12:01 -0700 (PDT)
X-Received: by 2002:a05:600c:a016:b0:49c:ffe3:2b3f with SMTP id
 5b1f17b1804b1-49e619a0458mr8567415e9.3.1789071120501; 
 Thu, 10 Sep 2026 13:12:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm162602505e9.6.2026.09.10.13.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:00 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Dorinda Bassey <dbassey@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PULL 16/90] hw/display: add vhost-user-media device
Message-ID: <a2ddd21b5c54a80211ea6ddf3684eea9d72f03cd.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Albert Esteve <aesteve@redhat.com>

Add the QEMU side of the vhost-user-media device, which connects to a
virtio-media vhost-user backend daemon implementing the V4L2 API over
the virtio-media protocol.

The virtio-media device is specified in the VirtIO specification v1.4,
section 5.22:
    https://docs.oasis-open.org/virtio/virtio/v1.4/cs01/virtio-v1.4-cs01.html

Tested with the rust-vmm vhost-device-media backend [1]:

    cargo run -- -s /path/to/media.sock -d /dev/video0 --backend v4l2-proxy

Example invocation:

    qemu-system-x86_64 \
        -chardev socket,path=/path/to/media.sock,id=media \
        -device vhost-user-media-pci,chardev=media,id=media

[1] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-media

Tested-by: Dorinda Bassey <dbassey@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260901-virtio-media-v2-2-bd3cc9347ab9@redhat.com>
---
 MAINTAINERS                          |   6 +
 include/hw/virtio/vhost-user-media.h |  46 ++++
 hw/display/vhost-user-media-pci.c    |  80 ++++++
 hw/display/vhost-user-media.c        | 348 +++++++++++++++++++++++++++
 hw/virtio/virtio.c                   |   3 +-
 hw/display/Kconfig                   |   5 +
 hw/display/meson.build               |   3 +
 7 files changed, 490 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/virtio/vhost-user-media.h
 create mode 100644 hw/display/vhost-user-media-pci.c
 create mode 100644 hw/display/vhost-user-media.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7183babd6a..ec313c3259 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2690,6 +2690,12 @@ S: Supported
 F: include/hw/virtio/vhost-user-rtc.h
 F: hw/virtio/vhost-user-rtc*
 
+vhost-user-media
+M: Albert Esteve <aesteve@redhat.com>
+S: Supported
+F: hw/display/vhost-user-media*
+F: include/hw/virtio/vhost-user-media.h
+
 virtio-crypto
 M: Gonglei <arei.gonglei@huawei.com>
 S: Supported
diff --git a/include/hw/virtio/vhost-user-media.h b/include/hw/virtio/vhost-user-media.h
new file mode 100644
index 0000000000..d040c70f63
--- /dev/null
+++ b/include/hw/virtio/vhost-user-media.h
@@ -0,0 +1,46 @@
+/*
+ * vhost-user-media virtio device
+ *
+ * Copyright Red Hat, Inc. 2026
+ *
+ * Authors:
+ *     Albert Esteve <aesteve@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VHOST_USER_MEDIA_H
+#define QEMU_VHOST_USER_MEDIA_H
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+#include "qom/object.h"
+
+#define TYPE_VHOST_USER_MEDIA "vhost-user-media-device"
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserMEDIA, VHOST_USER_MEDIA)
+
+/* virtio-media config layout, spec 5.22.4 */
+struct virtio_media_config {
+    uint32_t device_caps;
+    uint32_t device_type;
+    uint8_t card[32];
+} QEMU_PACKED;
+
+typedef struct {
+    CharFrontend chardev;
+} VHostUserMEDIAConf;
+
+struct VHostUserMEDIA {
+    /*< private >*/
+    VirtIODevice parent;
+    VHostUserMEDIAConf conf;
+    struct vhost_dev vhost_dev;
+    VhostUserState vhost_user;
+    VirtQueue *command_vq;
+    VirtQueue *event_vq;
+    bool connected;
+    /*< public >*/
+};
+
+#endif /* QEMU_VHOST_USER_MEDIA_H */
diff --git a/hw/display/vhost-user-media-pci.c b/hw/display/vhost-user-media-pci.c
new file mode 100644
index 0000000000..3e09fcfdd0
--- /dev/null
+++ b/hw/display/vhost-user-media-pci.c
@@ -0,0 +1,80 @@
+/*
+ * Vhost-user MEDIA virtio device PCI glue
+ *
+ * Copyright Red Hat, Inc. 2026
+ * Authors: Albert Esteve <aesteve@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/virtio/vhost-user-media.h"
+#include "hw/virtio/virtio-pci.h"
+
+#define TYPE_VHOST_USER_MEDIA_PCI "vhost-user-media-pci-base"
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserMEDIAPCI, VHOST_USER_MEDIA_PCI)
+
+struct VHostUserMEDIAPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserMEDIA vdev;
+};
+
+static const Property vumedia_pci_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+};
+
+static void vumedia_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserMEDIAPCI *dev = VHOST_USER_MEDIA_PCI(vpci_dev);
+    DeviceState *dev_state = DEVICE(&dev->vdev);
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = 1;
+    }
+
+    if (!qdev_realize(dev_state, BUS(&vpci_dev->bus), errp)) {
+        return;
+    }
+}
+
+static void vumedia_pci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vumedia_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, vumedia_pci_properties);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_MULTIMEDIA_VIDEO;
+}
+
+static void vumedia_pci_instance_init(Object *obj)
+{
+    VHostUserMEDIAPCI *dev = VHOST_USER_MEDIA_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_MEDIA);
+}
+
+static const VirtioPCIDeviceTypeInfo vumedia_pci_info = {
+    .base_name             = TYPE_VHOST_USER_MEDIA_PCI,
+    .non_transitional_name = "vhost-user-media-pci",
+    .instance_size = sizeof(VHostUserMEDIAPCI),
+    .instance_init = vumedia_pci_instance_init,
+    .class_init    = vumedia_pci_class_init,
+};
+
+static void vumedia_pci_register(void)
+{
+    virtio_pci_types_register(&vumedia_pci_info);
+}
+
+type_init(vumedia_pci_register);
diff --git a/hw/display/vhost-user-media.c b/hw/display/vhost-user-media.c
new file mode 100644
index 0000000000..14edc7c668
--- /dev/null
+++ b/hw/display/vhost-user-media.c
@@ -0,0 +1,348 @@
+/*
+ * Vhost-user Media device
+ *
+ * Copyright Red Hat, Inc. 2026
+ *
+ * This is the boilerplate for instantiating a vhost-user device
+ * implementing a virtio-media device.
+ *
+ * Authors:
+ *     Albert Esteve <aesteve@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/core/qdev-properties-system.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/vhost-user-media.h"
+
+static const int feature_bits[] = {
+    VIRTIO_F_VERSION_1,
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_RING_F_INDIRECT_DESC,
+    VIRTIO_RING_F_EVENT_IDX,
+    VIRTIO_F_RING_RESET,
+    VHOST_INVALID_FEATURE_BIT
+};
+
+static void
+vu_media_get_config(VirtIODevice *vdev, uint8_t *config_data)
+{
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(vdev);
+    Error *local_err = NULL;
+    int ret;
+
+    memset(config_data, 0, sizeof(struct virtio_media_config));
+
+    ret = vhost_dev_get_config(&media->vhost_dev,
+                               config_data, sizeof(struct virtio_media_config),
+                               &local_err);
+    if (ret) {
+        error_report_err(local_err);
+        return;
+    }
+}
+
+static void vu_media_start(VirtIODevice *vdev)
+{
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+    int i;
+
+    if (!k->set_guest_notifiers) {
+        error_report("binding does not support guest notifiers");
+        return;
+    }
+
+    ret = vhost_dev_enable_notifiers(&media->vhost_dev, vdev);
+    if (ret < 0) {
+        error_report("Error enabling host notifiers: %d", -ret);
+        return;
+    }
+
+    ret = k->set_guest_notifiers(qbus->parent, media->vhost_dev.nvqs, true);
+    if (ret < 0) {
+        error_report("Error binding guest notifier: %d", -ret);
+        goto err_host_notifiers;
+    }
+
+    media->vhost_dev.acked_features = vdev->guest_features;
+
+    media->vhost_dev.vq_index_end = media->vhost_dev.nvqs;
+    ret = vhost_dev_start(&media->vhost_dev, vdev, true);
+    if (ret < 0) {
+        error_report("Error starting vhost-user-media: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
+    /*
+     * guest_notifier_mask/pending not used yet, so just unmask
+     * everything here.  virtio-pci will do the right thing by
+     * enabling/disabling irqfd.
+     */
+    for (i = 0; i < media->vhost_dev.nvqs; i++) {
+        vhost_virtqueue_mask(&media->vhost_dev, vdev, i, false);
+    }
+
+    return;
+
+err_guest_notifiers:
+    k->set_guest_notifiers(qbus->parent, media->vhost_dev.nvqs, false);
+err_host_notifiers:
+    vhost_dev_disable_notifiers(&media->vhost_dev, vdev);
+}
+
+static void vu_media_stop(VirtIODevice *vdev)
+{
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+
+    if (!k->set_guest_notifiers) {
+        return;
+    }
+
+    vhost_dev_stop(&media->vhost_dev, vdev, true);
+
+    ret = k->set_guest_notifiers(qbus->parent, media->vhost_dev.nvqs, false);
+    if (ret < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", ret);
+        return;
+    }
+
+    vhost_dev_disable_notifiers(&media->vhost_dev, vdev);
+}
+
+static int vu_media_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(vdev);
+    bool should_start = virtio_device_should_start(vdev, status);
+
+    if (vhost_dev_is_started(&media->vhost_dev) == should_start) {
+        return 0;
+    }
+
+    if (should_start) {
+        vu_media_start(vdev);
+    } else {
+        vu_media_stop(vdev);
+    }
+    return 0;
+}
+
+static uint64_t vu_media_get_features(VirtIODevice *vdev,
+                                      uint64_t requested_features,
+                                      Error **errp)
+{
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(vdev);
+
+    return vhost_get_features(&media->vhost_dev, feature_bits,
+                              requested_features);
+}
+
+static void vu_media_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+    /*
+     * Not normally called; it's the daemon that handles the queue;
+     * however virtio's cleanup path can call this.
+     */
+}
+
+static void vu_media_guest_notifier_mask(VirtIODevice *vdev, int idx,
+                                            bool mask)
+{
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(vdev);
+
+    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
+        return;
+    }
+
+    vhost_virtqueue_mask(&media->vhost_dev, vdev, idx, mask);
+}
+
+static bool vu_media_guest_notifier_pending(VirtIODevice *vdev, int idx)
+{
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(vdev);
+
+    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
+        return false;
+    }
+
+    return vhost_virtqueue_pending(&media->vhost_dev, idx);
+}
+
+static int vu_media_handle_config_change(struct vhost_dev *dev)
+{
+    virtio_notify_config(dev->vdev);
+    return 0;
+}
+
+static const VhostDevConfigOps media_ops = {
+    .vhost_dev_config_notifier = vu_media_handle_config_change,
+};
+
+static int vu_media_connect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(vdev);
+
+    if (media->connected) {
+        return 0;
+    }
+    media->connected = true;
+
+    /* restore vhost state */
+    if (virtio_device_started(vdev, vdev->status)) {
+        vu_media_start(vdev);
+    }
+
+    return 0;
+}
+
+static void vu_media_disconnect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(vdev);
+
+    if (!media->connected) {
+        return;
+    }
+    media->connected = false;
+
+    if (vhost_dev_is_started(&media->vhost_dev)) {
+        vu_media_stop(vdev);
+    }
+}
+
+static void vu_media_event(void *opaque, QEMUChrEvent event)
+{
+    DeviceState *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(vdev);
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        if (vu_media_connect(dev) < 0) {
+            qemu_chr_fe_disconnect(&media->conf.chardev);
+            return;
+        }
+        break;
+    case CHR_EVENT_CLOSED:
+        vu_media_disconnect(dev);
+        break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
+    }
+}
+
+static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserMEDIA *media,
+                                  struct vhost_virtqueue *vhost_vqs)
+{
+    virtio_delete_queue(media->command_vq);
+    virtio_delete_queue(media->event_vq);
+    g_free(vhost_vqs);
+    virtio_cleanup(vdev);
+    vhost_user_cleanup(&media->vhost_user);
+}
+
+static void vu_media_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(dev);
+    struct vhost_virtqueue *vhost_vqs;
+    int ret;
+
+    if (!media->conf.chardev.chr) {
+        error_setg(errp, "vhost-user-media: chardev is mandatory");
+        return;
+    }
+
+    if (!vhost_user_init(&media->vhost_user, &media->conf.chardev, errp)) {
+        return;
+    }
+
+    virtio_init(vdev, VIRTIO_ID_MEDIA, sizeof(struct virtio_media_config));
+
+    media->command_vq = virtio_add_queue(vdev, 128, vu_media_handle_output);
+    media->event_vq = virtio_add_queue(vdev, 128, vu_media_handle_output);
+    media->vhost_dev.nvqs = 2;
+    media->vhost_dev.vqs = g_new0(struct vhost_virtqueue,
+                                  media->vhost_dev.nvqs);
+    vhost_vqs = media->vhost_dev.vqs;
+
+    vhost_dev_set_config_notifier(&media->vhost_dev, &media_ops);
+    media->vhost_user.supports_config = true;
+
+    ret = vhost_dev_init(&media->vhost_dev, &media->vhost_user,
+                         VHOST_BACKEND_TYPE_USER, 0, errp);
+    if (ret < 0) {
+        do_vhost_user_cleanup(vdev, media, vhost_vqs);
+        return;
+    }
+
+    qemu_chr_fe_set_handlers(&media->conf.chardev, NULL,
+                             NULL, vu_media_event,
+                             NULL, (void *)dev, NULL, true);
+}
+
+static void vu_media_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(dev);
+    struct vhost_virtqueue *vhost_vqs = media->vhost_dev.vqs;
+
+    /* This will stop vhost backend if appropriate. */
+    vu_media_set_status(vdev, 0);
+    vhost_dev_cleanup(&media->vhost_dev);
+    do_vhost_user_cleanup(vdev, media, vhost_vqs);
+}
+
+static const VMStateDescription vu_media_vmstate = {
+    .name = "vhost-user-media",
+    .unmigratable = 1,
+};
+
+static const Property vu_media_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserMEDIA, conf.chardev),
+};
+
+static void vu_media_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vu_media_properties);
+    dc->vmsd = &vu_media_vmstate;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    vdc->realize = vu_media_device_realize;
+    vdc->unrealize = vu_media_device_unrealize;
+    vdc->get_features = vu_media_get_features;
+    vdc->get_config = vu_media_get_config;
+    vdc->set_status = vu_media_set_status;
+    vdc->guest_notifier_mask = vu_media_guest_notifier_mask;
+    vdc->guest_notifier_pending = vu_media_guest_notifier_pending;
+}
+
+static const TypeInfo vu_media_info = {
+    .name = TYPE_VHOST_USER_MEDIA,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VHostUserMEDIA),
+    .class_init = vu_media_class_init,
+};
+
+static void vu_media_register_types(void)
+{
+    type_register_static(&vu_media_info);
+}
+
+type_init(vu_media_register_types)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 848fe8539e..0b2fbbed3f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -198,7 +198,8 @@ const char *virtio_device_names[] = {
     [VIRTIO_ID_AUDIO_POLICY] = "virtio-audio-pol",
     [VIRTIO_ID_BT] = "virtio-bluetooth",
     [VIRTIO_ID_GPIO] = "virtio-gpio",
-    [VIRTIO_ID_SPI] = "virtio-spi"
+    [VIRTIO_ID_SPI] = "virtio-spi",
+    [VIRTIO_ID_MEDIA] = "virtio-media",
 };
 
 static const char *virtio_id_to_name(uint16_t device_id)
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index b3593fe981..060274b1e6 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -120,6 +120,11 @@ config VHOST_USER_VGA
     default y
     depends on VIRTIO_VGA && VHOST_USER_GPU
 
+config VHOST_USER_MEDIA
+    bool
+    default y
+    depends on VIRTIO && VHOST_USER
+
 config DPCD
     bool
     select AUX
diff --git a/hw/display/meson.build b/hw/display/meson.build
index ffecedbf70..d8b4e121fe 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -37,6 +37,9 @@ system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
 system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c'))
 system_ss.add(when: 'CONFIG_DM163', if_true: files('dm163.c'))
+system_ss.add(when: 'CONFIG_VHOST_USER_MEDIA', if_true: files('vhost-user-media.c'))
+system_ss.add(when: ['CONFIG_VHOST_USER_MEDIA', 'CONFIG_VIRTIO_PCI'],
+  if_true: files('vhost-user-media-pci.c'))
 
 stub_ss.add([files('acpi-vga-stub.c'), pixman])
 if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
-- 
MST


