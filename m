Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4F8C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weWYy-0003Y5-D0; Tue, 30 Jun 2026 07:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1weWYp-0003Ut-UX
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:23:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1weWYm-0005d1-Ve
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782818603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnk2mBT1aDzVMVKjRPnRen745v+cn0fcjhguALlq9KU=;
 b=c3MEn6ZkY9ZBSZ41WEB/Km3JnNyYGldo4WB89OBmyCeOCtZ0AX1KPWucyxYl7OpratRtfD
 JEPUUOJGIdb3sM/7cfwb+fozVLXEqTCr0saJNWQDCg5ZMTuy/1a6ommyAZie1dFnQnSm/W
 M+kN3ch+zF2aH9IuICByD01MgpBnuEI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-ScHvcqWcMYWQnBIVXfqobg-1; Tue,
 30 Jun 2026 07:23:20 -0400
X-MC-Unique: ScHvcqWcMYWQnBIVXfqobg-1
X-Mimecast-MFC-AGG-ID: ScHvcqWcMYWQnBIVXfqobg_1782818599
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 057BC1954AD9; Tue, 30 Jun 2026 11:23:19 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2AB691800678; Tue, 30 Jun 2026 11:23:16 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH 2/3] hw/display: add vhost-user-media device
Date: Tue, 30 Jun 2026 13:23:09 +0200
Message-ID: <20260630112310.552606-3-aesteve@redhat.com>
In-Reply-To: <20260630112310.552606-1-aesteve@redhat.com>
References: <20260630112310.552606-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
        -chardev socket,path=/tmp/media.sock,id=media \
        -device vhost-user-media-pci,chardev=media,id=media

[1] https://github.com/rust-vmm/vhost-device/pull/944

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/display/Kconfig                   |   5 +
 hw/display/meson.build               |   3 +
 hw/display/vhost-user-media-pci.c    |  77 ++++++
 hw/display/vhost-user-media.c        | 393 +++++++++++++++++++++++++++
 hw/virtio/virtio.c                   |   3 +-
 include/hw/virtio/vhost-user-media.h |  47 ++++
 6 files changed, 527 insertions(+), 1 deletion(-)
 create mode 100644 hw/display/vhost-user-media-pci.c
 create mode 100644 hw/display/vhost-user-media.c
 create mode 100644 include/hw/virtio/vhost-user-media.h

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
index ffecedbf70..214c047df6 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -37,6 +37,9 @@ system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
 system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c'))
 system_ss.add(when: 'CONFIG_DM163', if_true: files('dm163.c'))
+system_ss.add(when: 'CONFIG_VHOST_USER_MEDIA', if_true: files('vhost-user-media.c'))
+system_ss.add(when: ['CONFIG_VHOST_USER_MEDIA', 'CONFIG_VIRTIO_PCI' ],
+  if_true: files('vhost-user-media-pci.c'))
 
 stub_ss.add([files('acpi-vga-stub.c'), pixman])
 if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
diff --git a/hw/display/vhost-user-media-pci.c b/hw/display/vhost-user-media-pci.c
new file mode 100644
index 0000000000..ad9e3900a4
--- /dev/null
+++ b/hw/display/vhost-user-media-pci.c
@@ -0,0 +1,77 @@
+/*
+ * Vhost-user MEDIA virtio device PCI glue
+ *
+ * Copyright Red Hat, Inc. 2024
+ * Authors: Albert Esteve <aesteve@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
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
+    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
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
+    pcidev_k->class_id = PCI_CLASS_STORAGE_OTHER;
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
index 0000000000..5c627437e7
--- /dev/null
+++ b/hw/display/vhost-user-media.c
@@ -0,0 +1,393 @@
+/*
+ * Vhost-user Media device
+ *
+ * Copyright Red Hat, Inc. 2024
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
+#include "hw/core/qdev-properties.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/vhost-user-media.h"
+
+static const int feature_bits[] = {
+    VIRTIO_F_RING_RESET,
+    VHOST_INVALID_FEATURE_BIT
+};
+
+static void
+vhost_user_media_get_config(VirtIODevice *vdev, uint8_t *config_data)
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
+static void vhost_user_media_start(VirtIODevice *vdev)
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
+static void vhost_user_media_stop(VirtIODevice *vdev)
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
+static int vhost_user_media_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(vdev);
+    bool should_start = virtio_device_started(vdev, status);
+
+    if (!vdev->vm_running) {
+        should_start = false;
+    }
+
+    if (media->vhost_dev.started == should_start) {
+        return 0;
+    }
+
+    if (should_start) {
+        vhost_user_media_start(vdev);
+    } else {
+        vhost_user_media_stop(vdev);
+    }
+    return 0;
+}
+
+static uint64_t vhost_user_media_get_features(VirtIODevice *vdev,
+                                      uint64_t requested_features,
+                                      Error **errp)
+{
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(vdev);
+
+    return vhost_get_features(&media->vhost_dev, feature_bits,
+                              requested_features);
+}
+
+static void vhost_user_media_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+    /*
+     * Not normally called; it's the daemon that handles the queue;
+     * however virtio's cleanup path can call this.
+     */
+}
+
+static void vhost_user_media_guest_notifier_mask(VirtIODevice *vdev, int idx,
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
+static bool vhost_user_media_guest_notifier_pending(VirtIODevice *vdev, int idx)
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
+/*
+ * Chardev connect/disconnect events
+ */
+
+static int vhost_user_media_handle_config_change(struct vhost_dev *dev)
+{
+    int ret;
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(dev->vdev);
+    Error *local_err = NULL;
+
+    ret = vhost_dev_get_config(dev, (uint8_t *)&media->conf.config,
+                               sizeof(struct virtio_media_config), &local_err);
+    if (ret < 0) {
+        error_report("get config space failed");
+        return -1;
+    }
+
+    return 0;
+}
+
+static const VhostDevConfigOps media_ops = {
+    .vhost_dev_config_notifier = vhost_user_media_handle_config_change,
+};
+
+static int vhost_user_media_connect(DeviceState *dev)
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
+        vhost_user_media_start(vdev);
+    }
+
+    return 0;
+}
+
+static void vhost_user_media_disconnect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(vdev);
+
+    if (!media->connected) {
+        return;
+    }
+    media->connected = false;
+
+    if (media->vhost_dev.started) {
+        vhost_user_media_stop(vdev);
+    }
+
+    vhost_dev_cleanup(&media->vhost_dev);
+}
+
+static void vhost_user_media_event(void *opaque, QEMUChrEvent event)
+{
+    DeviceState *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(vdev);
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        if (vhost_user_media_connect(dev) < 0) {
+            qemu_chr_fe_disconnect(&media->conf.chardev);
+            return;
+        }
+        break;
+    case CHR_EVENT_CLOSED:
+        vhost_user_media_disconnect(dev);
+        break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
+    }
+}
+
+static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserMEDIA *media)
+{
+    vhost_user_cleanup(&media->vhost_user);
+    virtio_delete_queue(media->command_vq);
+    virtio_delete_queue(media->event_vq);
+    virtio_cleanup(vdev);
+    g_free(media->vhost_dev.vqs);
+    media->vhost_dev.vqs = NULL;
+}
+
+static void vhost_user_media_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(dev);
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
+    /* one command queue and one event queue */
+    media->vhost_dev.nvqs = 2;
+    media->vhost_dev.vqs = g_new0(struct vhost_virtqueue,
+                                  media->vhost_dev.nvqs);
+    media->vhost_dev.vq_index = 0;
+
+    vhost_dev_set_config_notifier(&media->vhost_dev, &media_ops);
+    media->vhost_user.supports_config = true;
+
+    ret = vhost_dev_init(&media->vhost_dev, &media->vhost_user,
+                         VHOST_BACKEND_TYPE_USER, 0, errp);
+    if (ret < 0) {
+        error_report("vhost_dev_init failed: %s", strerror(-ret));
+        goto vhost_dev_init_failed;
+    }
+
+    /* One command queue, for sending commands */
+    media->command_vq = virtio_add_queue(vdev, 128,
+                                         vhost_user_media_handle_output);
+
+    if (!media->command_vq) {
+        error_setg_errno(errp, -1, "virtio_add_queue() failed");
+        goto cmd_q_fail;
+    }
+
+    /* One event queue, for sending events */
+    media->event_vq = virtio_add_queue(vdev, 128,
+                                       vhost_user_media_handle_output);
+
+    if (!media->event_vq) {
+        error_setg_errno(errp, -1, "virtio_add_queue() failed");
+        goto event_q_fail;
+    }
+
+    /*
+     * At this point the next event we will get is a connection from
+     * the daemon on the control socket.
+     */
+
+    qemu_chr_fe_set_handlers(&media->conf.chardev, NULL,
+                             NULL, vhost_user_media_event,
+                             NULL, (void *)dev, NULL, true);
+
+    return;
+
+event_q_fail:
+    virtio_delete_queue(media->event_vq);
+cmd_q_fail:
+    vhost_user_cleanup(&media->vhost_user);
+vhost_dev_init_failed:
+    virtio_cleanup(vdev);
+}
+
+static void vhost_user_media_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserMEDIA *media = VHOST_USER_MEDIA(dev);
+
+    /* This will stop vhost backend if appropriate. */
+    vhost_user_media_set_status(vdev, 0);
+
+    do_vhost_user_cleanup(vdev, media);
+}
+
+static const VMStateDescription vhost_user_media_vmstate = {
+    .name = "vhost-user-media",
+    .unmigratable = 1,
+};
+
+static const Property vhost_user_media_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserMEDIA, conf.chardev),
+};
+
+static void vhost_user_media_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vhost_user_media_properties);
+    dc->vmsd = &vhost_user_media_vmstate;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    vdc->realize = vhost_user_media_device_realize;
+    vdc->unrealize = vhost_user_media_device_unrealize;
+    vdc->get_features = vhost_user_media_get_features;
+    vdc->get_config = vhost_user_media_get_config;
+    vdc->set_status = vhost_user_media_set_status;
+    vdc->guest_notifier_mask = vhost_user_media_guest_notifier_mask;
+    vdc->guest_notifier_pending = vhost_user_media_guest_notifier_pending;
+}
+
+static const TypeInfo vhost_user_media_info = {
+    .name = TYPE_VHOST_USER_MEDIA,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VHostUserMEDIA),
+    .class_init = vhost_user_media_class_init,
+};
+
+static void vhost_user_media_register_types(void)
+{
+    type_register_static(&vhost_user_media_info);
+}
+
+type_init(vhost_user_media_register_types)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f4d86a3655..a07ef66c58 100644
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
diff --git a/include/hw/virtio/vhost-user-media.h b/include/hw/virtio/vhost-user-media.h
new file mode 100644
index 0000000000..30bdef8ce1
--- /dev/null
+++ b/include/hw/virtio/vhost-user-media.h
@@ -0,0 +1,47 @@
+/*
+ * vhost-user-media virtio device
+ *
+ * Copyright Red Hat, Inc. 2024
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
+#include "chardev/char-fe.h"
+#include "qom/object.h"
+
+#define TYPE_VHOST_USER_MEDIA "vhost-user-media-device"
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserMEDIA, VHOST_USER_MEDIA)
+
+struct virtio_media_config {
+    uint32_t device_caps;
+    uint32_t device_type;
+    uint8_t card[32];
+};
+
+typedef struct {
+    CharFrontend chardev;
+    struct virtio_media_config config;
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
-- 
2.54.0


