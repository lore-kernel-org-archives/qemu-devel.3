Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AAAC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 04:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9GV7-00048t-Tg; Mon, 28 Apr 2025 00:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongweimin@kylinos.cn>)
 id 1u9Dz9-0008Fp-Tq
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 22:12:43 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongweimin@kylinos.cn>)
 id 1u9Dz4-0005ak-Ru
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 22:12:43 -0400
X-UUID: 36f2901423d611f0b29709d653e92f7d-20250428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45, REQID:35d55787-060c-4df4-8585-783d08288a8a, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:6493067, CLOUDID:aa11c65a3c721f671fc2ee454d94591c,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1|19,IP:nil,
 URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1
 ,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 36f2901423d611f0b29709d653e92f7d-20250428
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
 (envelope-from <xiongweimin@kylinos.cn>) (Generic MTA)
 with ESMTP id 1577691064; Mon, 28 Apr 2025 10:12:20 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
 by mail.kylinos.cn (NSMail) with SMTP id D2CB6E003508;
 Mon, 28 Apr 2025 10:12:19 +0800 (CST)
X-ns-mid: postfix-680EE402-68306087
Received: from xwm-TianYi510Pro-14IMB.. (unknown [10.42.12.111])
 by mail.kylinos.cn (NSMail) with ESMTPA id 77544E003505;
 Mon, 28 Apr 2025 10:12:18 +0800 (CST)
From: Weimin Xiong <xiongweimin@kylinos.cn>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] hw/rdma: Add initial Support for Vhost-User-Rdma Device
Date: Mon, 28 Apr 2025 10:12:16 +0800
Message-ID: <20250428021216.144387-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=xiongweimin@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Apr 2025 00:53:48 -0400
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

From: xiongweimin <xiongweimin@kylinos.cn>

Add initial support for vhost-user-rdma device model for qemu,
this includes the interaction(e.g feature negotiation, setting
vring baseaddr, setting device status) between guest kernel and
host vhost-user-rdma backend device

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 hw/rdma/vhost-user-rdma.c                   | 466 ++++++++++++++++++++
 hw/virtio/meson.build                       |   1 +
 hw/virtio/vhost-user-rdma-pci.c             | 102 +++++
 hw/virtio/virtio.c                          |   1 +
 include/hw/pci/pci.h                        |   1 +
 include/hw/virtio/vhost-user-rdma.h         |  45 ++
 include/standard-headers/linux/virtio_ids.h |   1 +
 include/standard-headers/rdma/virtio_rdma.h |  60 +++
 8 files changed, 677 insertions(+)
 create mode 100644 hw/rdma/vhost-user-rdma.c
 create mode 100644 hw/virtio/vhost-user-rdma-pci.c
 create mode 100644 include/hw/virtio/vhost-user-rdma.h
 create mode 100644 include/standard-headers/rdma/virtio_rdma.h

diff --git a/hw/rdma/vhost-user-rdma.c b/hw/rdma/vhost-user-rdma.c
new file mode 100644
index 000000000..b87ba6941
--- /dev/null
+++ b/hw/rdma/vhost-user-rdma.c
@@ -0,0 +1,466 @@
+/*
+ * vhost-user-rdma.c
+ *
+ * Copyright (c) 2025 Weimin Xiong <xiongweimin@kylinos.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/cutils.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user-rdma.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-access.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
+
+#define VHOST_USER_RDMA_NUM_QUEUES 256
+#define VHOST_USER_RDMA_QUEUE_SIZE 512
+
+static const int user_feature_bits[] =3D {
+    VIRTIO_F_VERSION_1,
+    VIRTIO_RING_F_INDIRECT_DESC,
+    VIRTIO_RING_F_EVENT_IDX,
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VHOST_INVALID_FEATURE_BIT
+};
+
+static int vhost_user_rdma_start(VirtIODevice *vdev)
+{
+    VhostUserRdma *r =3D VHOST_USER_RDMA(vdev);
+    BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
+    int i, ret;
+
+    if (!k->set_guest_notifiers) {
+        error_report("binding does not support guest notifiers");
+        return -ENOSYS;
+    }
+
+    ret =3D vhost_dev_enable_notifiers(&r->dev, vdev);
+    if (ret < 0) {
+        error_report("Error enabling host notifiers: %d", -ret);
+        return ret;
+    }
+
+    ret =3D k->set_guest_notifiers(qbus->parent, r->dev.nvqs, true);
+    if (ret < 0) {
+        error_report("Error binding guest notifier: %d", -ret);
+        goto err_host_notifiers;
+    }
+
+    r->dev.acked_features =3D vdev->guest_features;
+
+    ret =3D vhost_dev_start(&r->dev, vdev, true);
+    if (ret < 0) {
+        error_report("Error starting vhost: %d", -ret);
+        goto err_guest_notifiers;
+    }
+    r->started_vu =3D true;
+
+    for (i =3D 0; i < r->dev.nvqs; i++) {
+        vhost_virtqueue_mask(&r->dev, vdev, i, false);
+    }
+
+    return ret;
+
+err_guest_notifiers:
+    k->set_guest_notifiers(qbus->parent, r->dev.nvqs, false);
+err_host_notifiers:
+    vhost_dev_disable_notifiers(&r->dev, vdev);
+    return ret;
+}
+
+static void vhost_user_rdma_stop(VirtIODevice *vdev)
+{
+    VhostUserRdma *r =3D VHOST_USER_RDMA(vdev);
+    BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+
+    if (!r->started_vu) {
+        return;
+    }
+    r->started_vu =3D false;
+
+    if (!k->set_guest_notifiers) {
+        return;
+    }
+
+    vhost_dev_stop(&r->dev, vdev, true);
+
+    ret =3D k->set_guest_notifiers(qbus->parent, r->dev.nvqs, false);
+    if (ret < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", ret);
+        return;
+    }
+
+    vhost_dev_disable_notifiers(&r->dev, vdev);
+}
+
+static int vhost_user_rdma_handle_config_change(struct vhost_dev *dev)
+{
+    int ret;
+    VhostUserRdma *r =3D VHOST_USER_RDMA(dev->vdev);
+    Error *local_err =3D NULL;
+
+    ret =3D vhost_dev_get_config(dev, (uint8_t *)&r->rdma_backend_cfg,
+                               sizeof(struct virtio_rdma_config), &local=
_err);
+    if (ret < 0) {
+        error_report("get config space failed");
+        return -1;
+    }
+
+    virtio_notify_config(dev->vdev);
+    return 0;
+}
+
+const VhostDevConfigOps rdma_ops =3D {
+    .vhost_dev_config_notifier =3D vhost_user_rdma_handle_config_change,
+};
+
+static int vhost_user_rdma_connect(DeviceState *dev)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VhostUserRdma *r =3D VHOST_USER_RDMA(vdev);
+    int ret =3D 0;
+    Error *local_err =3D NULL;
+
+    if (r->connected) {
+        return 0;
+    }
+    r->connected =3D true;
+
+    r->dev.nvqs =3D r->num_queues;
+    r->dev.vqs =3D r->vhost_vqs;
+    r->dev.vq_index =3D 0;
+    r->dev.backend_features =3D 0;
+
+    vhost_dev_set_config_notifier(&r->dev, &rdma_ops);
+
+    ret =3D vhost_dev_init(&r->dev, &r->vu_state,
+                         VHOST_BACKEND_TYPE_USER, 0, &local_err);
+    if (ret < 0) {
+        error_report("vhost-user-rdma: vhost initialization failed: %s",
+                     strerror(-ret));
+        return ret;
+    }
+
+    /* restore vhost state */
+    if (virtio_device_started(vdev, vdev->status)) {
+        info_report("vhost_user_rdma: vhost ss?");
+        ret =3D vhost_user_rdma_start(vdev);
+        if (ret < 0) {
+            error_report("vhost-user-rdma: vhost start failed: %s",
+                         strerror(-ret));
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+static void vhost_user_rdma_disconnect(DeviceState *dev)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VhostUserRdma *s =3D VHOST_USER_RDMA(vdev);
+
+    if (!s->connected) {
+        return;
+    }
+    s->connected =3D false;
+
+    vhost_user_rdma_stop(vdev);
+
+    vhost_dev_cleanup(&s->dev);
+}
+
+static void vhost_user_rdma_event(void *opaque, QEMUChrEvent event);
+
+static void vhost_user_rdma_chr_closed_bh(void *opaque)
+{
+    DeviceState *dev =3D opaque;
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VhostUserRdma *r =3D VHOST_USER_RDMA(vdev);
+
+    vhost_user_rdma_disconnect(dev);
+    qemu_chr_fe_set_handlers(&r->chardev, NULL, NULL, vhost_user_rdma_ev=
ent,
+            NULL, opaque, NULL, true);
+}
+
+static void vhost_user_rdma_event(void *opaque, QEMUChrEvent event)
+{
+    DeviceState *dev =3D opaque;
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VhostUserRdma *r =3D VHOST_USER_RDMA(vdev);
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        if (vhost_user_rdma_connect(dev) < 0) {
+            qemu_chr_fe_disconnect(&r->chardev);
+            return;
+        }
+        break;
+    case CHR_EVENT_CLOSED:
+        if (runstate_is_running()) {
+            AioContext *ctx =3D qemu_get_current_aio_context();
+
+            qemu_chr_fe_set_handlers(&r->chardev, NULL, NULL, NULL, NULL=
,
+                    NULL, NULL, false);
+            aio_bh_schedule_oneshot(ctx, vhost_user_rdma_chr_closed_bh, =
opaque);
+        }
+
+        r->dev.started =3D false;
+        break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
+    }
+}
+
+static void vhost_user_rdma_handle_output(VirtIODevice *vdev, VirtQueue =
*vq)
+{
+    VhostUserRdma *r =3D VHOST_USER_RDMA(vdev);
+    int i, ret;
+
+    if (!vdev->start_on_kick) {
+        return;
+    }
+
+    if (!r->connected) {
+        return;
+    }
+
+    if (r->dev.started) {
+        return;
+    }
+
+    ret =3D vhost_user_rdma_start(vdev);
+    if (ret < 0) {
+        error_report("vhost-user-rdma: vhost start failed: %s",
+                     strerror(-ret));
+        qemu_chr_fe_disconnect(&r->chardev);
+        return;
+    }
+
+    for (i =3D 0; i < r->dev.nvqs; i++) {
+        VirtQueue *kick_vq =3D virtio_get_queue(vdev, i);
+
+        if (!virtio_queue_get_desc_addr(vdev, i)) {
+            continue;
+        }
+        event_notifier_set(virtio_queue_get_host_notifier(kick_vq));
+    }
+}
+
+static void vhost_user_rdma_update_config(VirtIODevice *vdev, uint8_t *c=
onfig)
+{
+    VhostUserRdma *r =3D VHOST_USER_RDMA(vdev);
+
+    memcpy(config, &r->rdma_backend_cfg, sizeof(struct virtio_rdma_confi=
g));
+}
+
+static uint64_t vhost_user_rdma_get_features(VirtIODevice *vdev,
+                                            uint64_t features,
+                                            Error **errp)
+{
+    VhostUserRdma *s =3D VHOST_USER_RDMA(vdev);
+
+    return vhost_get_features(&s->dev, user_feature_bits, features);
+}
+
+static void vhost_user_rdma_set_status(VirtIODevice *vdev, uint8_t statu=
s)
+{
+    VhostUserRdma *r =3D VHOST_USER_RDMA(vdev);
+    bool should_start =3D virtio_device_started(vdev, status);
+    int ret;
+
+    if (!vdev->vm_running) {
+        should_start =3D false;
+    }
+
+    if (!r->connected) {
+        return;
+    }
+
+    if (r->dev.started =3D=3D should_start) {
+        return;
+    }
+
+    if (should_start) {
+        ret =3D vhost_user_rdma_start(vdev);
+        if (ret < 0) {
+            error_report("vhost-user-rdma: vhost start failed: %s",
+                         strerror(-ret));
+            qemu_chr_fe_disconnect(&r->chardev);
+        }
+    } else {
+        vhost_user_rdma_stop(vdev);
+    }
+}
+
+static void vhost_user_rdma_device_realize(DeviceState *dev, Error **err=
p)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VhostUserRdma *r =3D VHOST_USER_RDMA(vdev);
+    Error *err =3D NULL;
+    int i, ret;
+
+    if (!r->chardev.chr) {
+        error_setg(errp, "vhost-user-rdma: chardev is mandatory");
+        return;
+    }
+
+    r->num_queues =3D VHOST_USER_RDMA_NUM_QUEUES;
+
+    if (r->num_queues > VIRTIO_QUEUE_MAX) {
+        error_setg(errp, "vhost-user-rdma: invalid number of IO queues")=
;
+        return;
+    }
+
+    if (!vhost_user_init(&r->vu_state, &r->chardev, errp)) {
+        return;
+    }
+
+    virtio_init(vdev, VIRTIO_ID_RDMA, sizeof(struct virtio_rdma_config))=
;
+
+    r->virtqs =3D g_new(VirtQueue *, r->num_queues);
+
+    for (i =3D 0; i < r->num_queues; i++) {
+        r->virtqs[i] =3D virtio_add_queue(vdev, VHOST_USER_RDMA_QUEUE_SI=
ZE,
+                                        vhost_user_rdma_handle_output);
+    }
+
+    r->vhost_vqs =3D g_new0(struct vhost_virtqueue, r->num_queues);
+    r->connected =3D false;
+
+    qemu_chr_fe_set_handlers(&r->chardev,  NULL, NULL, vhost_user_rdma_e=
vent,
+                             NULL, (void *)dev, NULL, true);
+
+reconnect:
+    if (qemu_chr_fe_wait_connected(&r->chardev, &err) < 0) {
+        error_report_err(err);
+        goto virtio_err;
+    }
+
+    /* check whether vhost_user_rdma_connect() failed or not */
+    if (!r->connected) {
+        goto reconnect;
+    }
+
+    ret =3D vhost_dev_get_config(&r->dev, (uint8_t *)&r->rdma_backend_cf=
g,
+                               sizeof(struct virtio_rdma_config), &err);
+    if (ret < 0) {
+        error_report("vhost-user-rdma: get rdma config failed");
+        goto reconnect;
+    }
+
+    return;
+
+virtio_err:
+    g_free(r->vhost_vqs);
+    r->vhost_vqs =3D NULL;
+    for (i =3D 0; i < r->num_queues; i++) {
+        virtio_delete_queue(r->virtqs[i]);
+    }
+    g_free(r->virtqs);
+    virtio_cleanup(vdev);
+    vhost_user_cleanup(&r->vu_state);
+}
+
+static void vhost_user_rdma_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VhostUserRdma *r =3D VHOST_USER_RDMA(dev);
+    int i;
+
+    virtio_set_status(vdev, 0);
+    qemu_chr_fe_set_handlers(&r->chardev,  NULL, NULL, NULL,
+                             NULL, NULL, NULL, false);
+    vhost_dev_cleanup(&r->dev);
+    g_free(r->vhost_vqs);
+    r->vhost_vqs =3D NULL;
+    for (i =3D 0; i < r->num_queues; i++) {
+        virtio_delete_queue(r->virtqs[i]);
+    }
+    g_free(r->virtqs);
+    virtio_cleanup(vdev);
+    vhost_user_cleanup(&r->vu_state);
+}
+
+static void vhost_user_rdma_instance_init(Object *obj)
+{
+    VhostUserRdma *r =3D VHOST_USER_RDMA(obj);
+
+    device_add_bootindex_property(obj, &r->bootindex, "bootindex",
+                                  "bootindex", DEVICE(obj));
+}
+
+static const VMStateDescription vmstate_vhost_user_rdma =3D {
+    .name =3D "vhost-user-rdma",
+    .minimum_version_id =3D 1,
+    .version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static Property vhost_user_rdma_properties[] =3D {
+    DEFINE_PROP_CHR("chardev", VhostUserRdma, chardev),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_rdma_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vhost_user_rdma_properties);
+    dc->vmsd =3D &vmstate_vhost_user_rdma;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+
+    vdc->realize =3D vhost_user_rdma_device_realize;
+    vdc->unrealize =3D vhost_user_rdma_device_unrealize;
+    vdc->get_config =3D vhost_user_rdma_update_config;
+    vdc->set_config =3D NULL;
+    vdc->get_features =3D vhost_user_rdma_get_features;
+    vdc->set_status =3D vhost_user_rdma_set_status;
+}
+
+static const TypeInfo vhost_user_rdma_info =3D {
+    .name =3D TYPE_VHOST_USER_RDMA,
+    .parent =3D TYPE_VIRTIO_DEVICE,
+    .instance_size =3D sizeof(VhostUserRdma),
+    .instance_init =3D vhost_user_rdma_instance_init,
+    .class_init =3D vhost_user_rdma_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&vhost_user_rdma_info);
+}
+
+type_init(virtio_register_types)
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 164f6fd99..84603ac12 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -65,6 +65,7 @@ virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: =
files('vhost-vsock-pci.c'
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost=
-user-vsock-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-u=
ser-blk-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-=
user-scsi-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_RDMA', if_true: files('vhost-=
user-rdma-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-=
pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-us=
er-fs-pci.c'))
=20
diff --git a/hw/virtio/vhost-user-rdma-pci.c b/hw/virtio/vhost-user-rdma-=
pci.c
new file mode 100644
index 000000000..bbfa2d357
--- /dev/null
+++ b/hw/virtio/vhost-user-rdma-pci.c
@@ -0,0 +1,102 @@
+/*
+ * Vhost user rdma PCI Bindings
+ *
+ * Copyright(C) 2025 KylinSoft Inc. All rights reserved.
+ *
+ * Authors:
+ *  Weimin Xiong <xiongweimin@kylinos.cn>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or l=
ater.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "standard-headers/rdma/virtio_rdma.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost-user-rdma.h"
+#include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "hw/virtio/virtio-pci.h"
+#include "qom/object.h"
+
+typedef struct VhostUserRdmaPCI VhostUserRdmaPCI;
+
+#define TYPE_VHOST_USER_RDMA_PCI "vhost-user-rdma-pci"
+DECLARE_INSTANCE_CHECKER(VhostUserRdmaPCI, VHOST_USER_RDMA_PCI,
+                         TYPE_VHOST_USER_RDMA_PCI)
+
+struct VhostUserRdmaPCI {
+    VirtIOPCIProxy parent_obj;
+    VhostUserRdma vdev;
+};
+
+static Property vhost_user_rdma_pci_properties[] =3D {
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_rdma_pci_realize(VirtIOPCIProxy *vpci_dev, Error =
**errp)
+{
+    VhostUserRdmaPCI *dev =3D VHOST_USER_RDMA_PCI(vpci_dev);
+    DeviceState *vdev =3D DEVICE(&dev->vdev);
+
+    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors =3D dev->vdev.num_queues + 1;
+    }
+
+    virtio_pci_force_virtio_1(vpci_dev);
+
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+}
+
+static void vhost_user_rdma_pci_class_init(ObjectClass *klass, void *dat=
a)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *k_pcidev =3D PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    device_class_set_props(dc, vhost_user_rdma_pci_properties);
+    k->realize =3D vhost_user_rdma_pci_realize;
+    k_pcidev->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
+    k_pcidev->device_id =3D PCI_DEVICE_ID_VIRTIO_RDMA;
+    k_pcidev->revision =3D VIRTIO_PCI_ABI_VERSION;
+    k_pcidev->class_id =3D PCI_CLASS_NETWORK_OTHER;
+}
+
+static void vhost_user_rdma_pci_instance_init(Object *obj)
+{
+    VhostUserRdmaPCI *dev =3D VHOST_USER_RDMA_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_RDMA);
+
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex");
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_rdma_pci_info =3D {
+    .base_name               =3D TYPE_VHOST_USER_RDMA_PCI,
+    .generic_name            =3D "vhost-user-rdma-pci",
+    .transitional_name       =3D "vhost-user-rdma-pci-transitional",
+    .non_transitional_name   =3D "vhost-user-rdma-pci-non-transitional",
+    .instance_size  =3D sizeof(VhostUserRdmaPCI),
+    .instance_init  =3D vhost_user_rdma_pci_instance_init,
+    .class_init     =3D vhost_user_rdma_pci_class_init,
+};
+
+static void vhost_user_rdma_pci_register(void)
+{
+    virtio_pci_types_register(&vhost_user_rdma_pci_info);
+}
+
+type_init(vhost_user_rdma_pci_register)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce3..277fc9637 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -182,6 +182,7 @@ const char *virtio_device_names[] =3D {
     [VIRTIO_ID_FS] =3D "virtio-user-fs",
     [VIRTIO_ID_PMEM] =3D "virtio-pmem",
     [VIRTIO_ID_RPMB] =3D "virtio-rpmb",
+    [VIRTIO_ID_RDMA] =3D "virtio-rdma",
     [VIRTIO_ID_MAC80211_HWSIM] =3D "virtio-mac-hwsim",
     [VIRTIO_ID_VIDEO_ENCODER] =3D "virtio-vid-encoder",
     [VIRTIO_ID_VIDEO_DECODER] =3D "virtio-vid-decoder",
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 822fbacdf..776fccb65 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -90,6 +90,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
+#define PCI_DEVICE_ID_VIRTIO_RDMA        0x1016
=20
 /*
  * modern virtio-pci devices get their id assigned automatically,
diff --git a/include/hw/virtio/vhost-user-rdma.h b/include/hw/virtio/vhos=
t-user-rdma.h
new file mode 100644
index 000000000..89a9dddae
--- /dev/null
+++ b/include/hw/virtio/vhost-user-rdma.h
@@ -0,0 +1,45 @@
+/*
+ * vhost-user-rdma host device
+ * Copyright(C) 2025 KylinSoft Inc. All rights reserved.
+ *
+ * Authors:
+ *  Weimin Xiong <xiongweimin@kylinos.cn>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or l=
ater.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef VHOST_USER_RDMA_H
+#define VHOST_USER_RDMA_H
+
+#include "standard-headers/rdma/virtio_rdma.h"
+#include "chardev/char-fe.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+#include "qom/object.h"
+
+#define TYPE_VHOST_USER_RDMA "vhost-user-rdma"
+OBJECT_DECLARE_SIMPLE_TYPE(VhostUserRdma, VHOST_USER_RDMA)
+
+struct VhostUserRdma {
+    VirtIODevice parent_obj;
+    CharBackend chardev;
+    int32_t bootindex;
+    struct virtio_rdma_config rdma_backend_cfg;
+    struct vhost_dev dev;
+    VhostUserState vu_state;
+    struct vhost_virtqueue *vhost_vqs;
+    VirtQueue **virtqs;
+
+    int num_queues;
+
+    /* vhost_user_rdma_connect/vhost_user_rdma_disconnect */
+    bool connected;
+    /* vhost_user_rdma_start/vhost_user_rdma_stop */
+    bool started_vu;
+};
+
+#endif
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standa=
rd-headers/linux/virtio_ids.h
index 7aa2eb766..ff2d0b01b 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -68,6 +68,7 @@
 #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
+#define VIRTIO_ID_RDMA          42 /* virtio rdma */
=20
 /*
  * Virtio Transitional IDs
diff --git a/include/standard-headers/rdma/virtio_rdma.h b/include/standa=
rd-headers/rdma/virtio_rdma.h
new file mode 100644
index 000000000..01823bfa9
--- /dev/null
+++ b/include/standard-headers/rdma/virtio_rdma.h
@@ -0,0 +1,60 @@
+/*
+ * Virtio RDMA Device
+ *
+ * Copyright (C) 2025 KylinSoft Inc.
+ *
+ * Authors:
+ *  Weimin Xiong <xiongweimin@kylinos.cn>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef _LINUX_VIRTIO_RDMA_H
+#define _LINUX_VIRTIO_RDMA_H
+
+#include <linux/types.h>
+#include <infiniband/verbs.h>
+
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_config.h"
+#include "standard-headers/linux/virtio_types.h"
+
+struct virtio_rdma_config {
+    __le32         phys_port_cnt;
+
+    __le64         sys_image_guid;
+    __le32         vendor_id;
+    __le32         vendor_part_id;
+    __le32         hw_ver;
+    __le64         max_mr_size;
+    __le64         page_size_cap;
+    __le32         max_qp;
+    __le32         max_qp_wr;
+    __le64         device_cap_flags;
+    __le32         max_send_sge;
+    __le32         max_recv_sge;
+    __le32         max_sge_rd;
+    __le32         max_cq;
+    __le32         max_cqe;
+    __le32         max_mr;
+    __le32         max_pd;
+    __le32         max_qp_rd_atom;
+    __le32         max_res_rd_atom;
+    __le32         max_qp_init_rd_atom;
+    __le32         atomic_cap;
+    __le32         max_mw;
+    __le32         max_mcast_grp;
+    __le32         max_mcast_qp_attach;
+    __le32         max_total_mcast_qp_attach;
+    __le32         max_ah;
+    __le32         max_fast_reg_page_list_len;
+    __le32         max_pi_fast_reg_page_list_len;
+    __le16         max_pkeys;
+    uint8_t        local_ca_ack_delay;
+
+    uint8_t           reserved[64];
+} QEMU_PACKED;
+
+#endif
--=20
2.41.0


