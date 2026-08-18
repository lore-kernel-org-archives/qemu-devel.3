Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCB6C5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwC86-0005HQ-Nb; Tue, 18 Aug 2026 01:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC85-0005H3-06
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:53 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC82-0003pS-VN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:52 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84a2dcede83so5727459b3a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787029969; x=1787634769; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yDGWIbLiwCQZ5If+WfdVxDr1QS3FHpZI2ZH0Iio93r0=;
 b=RdOjIq6d9mZzQ//nAwCJw/JHTb391bYaWB5tBVqWJ6MTXLSOwQaVfc9no1bnKXW/Y8
 GzjFTGb2KmpZWamclD8rSHkSjwYwvHz3QN6dBT9YwHku3RHNxLyJ55oQ8rRqr2BEGqky
 sMMX7MLgENA35wvFGn4cvIwpYMytqVafKhLv2YjG9seBIIOCiNSwJXLEMZmNyZByj1C3
 tYrEUOnaBX/mmwPJERHhl7+KB0e1dgEybC7SkZGrTVENyMZ0C2JpyfI+TNnfBgGuzFx0
 XltLfLm9H3tuBkFYyPHtrRh/2WWjs6yYMN4XkmIETrfVZ2iQoAjXebOlQrGacLHjsBV/
 lmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029969; x=1787634769;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yDGWIbLiwCQZ5If+WfdVxDr1QS3FHpZI2ZH0Iio93r0=;
 b=EufEvO26aJz1bO7cLN9oKkV42YXlQueD982RLvZHgGFl+18WMSSokBdmBu/GrZ0+TV
 zYN/4F2cVyOz20ejIOiTXsU3vwGPmlsZ4wqxmqbR1E2K2tMEIPfvkrWbk6g/y4rIEcg9
 72mxrqOsGoteLkn8RlkhAcIrE6QuvdLOJj2YkEjMcdiqbP1Ty13dKqOZH8diD1dOO9xF
 t5ZPmoiFv1C8nbys1fV++iao5mooezrXeYDAHuy/2Wv9M4jItPWPT0Q0TEk8EzSOCGPB
 q3L7OttSd5B6AEA2AlKg7FqvEt4dDwJqnvwHrqXMs6U44IBhJmQx7LwcPFFVykRVuMHf
 xCbA==
X-Gm-Message-State: AOJu0Yytji2Ki990TIxrHMCIuSZU2UJNUBqvGuyec+nKtUiNPiv5H2G7
 zrPy9tJplgsJly38w6X1plsjTKS5oNV2JktsA5bteHfelaZzhyfNI8nt
X-Gm-Gg: AR+sD12iGAg7ef3HQ/2szGA1JxI7QmVeWEwDtUTFtPnMMciy6+wuTBX323hlBpU/s4b
 x5V2xTPJZU2XUWMcNQNT2Z7MVfc8b4RA3bZNK89GDd/suBhzKqvTFQSXXUnuWG58PWTHsfeDeAk
 cCzjWHkwiFGlGNYBv/4FPPSWwYVfetwwaE32Puz0oc6KyJW4WNWMUOJooyKc3UgwQoQl812WhYn
 XbhPbi9eyZNXJd9szBsuKwv482uiS6pu8JQQdIwDR2CQH9fGROT+w5A1mqmO8Kv3S94HHQxJOmW
 i8GCtqQXUAb1hbjqfvo3uIXmaAnI8LLnex0eAWT0OSGB30C1FJpXKxLxaCmEOfeTK8mefAO/arZ
 izzm9d9aNkBWt/kOUU9oaMN0VX2AFCUP1n5slOrwcFX5ksWU7Tcb7Ya30SKeIBmxWgaZfsS/eLM
 4Qm48BGByhFoAOS3u5d8hBlygnDWJyPBQJrC/RCSqEgznRmhh+SP8axRqpDLmikAJ3vgHbFiR+w
 AWQ
X-Received: by 2002:a05:6a00:4654:b0:848:4faa:480b with SMTP id
 d2e1a72fcca58-84fddfce887mr29626111b3a.12.1787029969420; 
 Mon, 17 Aug 2026 22:12:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:d043:a40d:25c1:432c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1031160b3a.43.2026.08.17.22.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 22:12:48 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 17 Aug 2026 22:12:26 -0700
Subject: [PATCH RFC v2 11/13] vhost-user: Add memory-isolation qdev
 property to vhost-user devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-vhost-user-isolated-memory-v2-11-948aae960abb@gmail.com>
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>, 
 20260817233147.2867623-1-connorkite@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029936; l=10639;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=bDY61qv1aUuiJX5AihOusx4h4L9qjegBfYljF7KlWx8=;
 b=svydToQc3yKwRDJxMF6SXJDj73zDY4NnrZk9gFJeM50qtdYTDTQELdGbLi55zIK2/HyP27xha
 mBoDB2VpKtOCkPXCeACvJDDlFJSimZQTceBGaSg7jkYVd9WXhMuloXv
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=connorkite@gmail.com; helo=mail-pf1-x429.google.com
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

In support of future work to add a memory isolation mode to vhost-user devices, a
qdev property, "memory-isolation", is added to all vhost-user devices. This is
simply a bool representing whether the mode is active or not.

Signed-off-by: Connor Kite <connorkite@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/vhost-user-blk.c            | 3 ++-
 hw/display/vhost-user-gpu.c          | 3 ++-
 hw/scsi/vhost-user-scsi.c            | 4 +++-
 hw/virtio/vhost-user-base.c          | 6 ++++--
 hw/virtio/vhost-user-fs.c            | 4 +++-
 hw/virtio/vhost-user-scmi.c          | 4 +++-
 hw/virtio/vhost-user-vsock.c         | 4 +++-
 include/hw/virtio/vhost-user-base.h  | 1 +
 include/hw/virtio/vhost-user-blk.h   | 1 +
 include/hw/virtio/vhost-user-fs.h    | 1 +
 include/hw/virtio/vhost-user-scmi.h  | 1 +
 include/hw/virtio/vhost-user-vsock.h | 1 +
 include/hw/virtio/virtio-gpu.h       | 1 +
 include/hw/virtio/virtio-scsi.h      | 1 +
 14 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 4640d7da04..5c1a19eb50 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -506,7 +506,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     }
 
     if (!vhost_user_init(&s->vhost_user, &s->chardev,
-                         false, errp)) {
+                         s->memory_isolation, errp)) {
         return;
     }
 
@@ -632,6 +632,7 @@ static const VMStateDescription vmstate_vhost_user_blk = {
 
 static const Property vhost_user_blk_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserBlk, memory_isolation, false),
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
                        VHOST_USER_BLK_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 6655585b43..d8f710ed65 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -663,7 +663,7 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(g);
 
     vhost_dev_set_config_notifier(&g->vhost->dev, &config_ops);
-    if (vhost_user_backend_dev_init(g->vhost, vdev, 2, false,
+    if (vhost_user_backend_dev_init(g->vhost, vdev, 2, g->memory_isolation,
                                     errp) < 0) {
         return;
     }
@@ -698,6 +698,7 @@ static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
 
 static const Property vhost_user_gpu_properties[] = {
     VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
+    DEFINE_PROP_BOOL("memory-isolation", VhostUserGPU, memory_isolation, false),
 };
 
 static void
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 05bc788304..6f162a7854 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -277,7 +277,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     }
 
     if (!vhost_user_init(&s->vhost_user, &vs->conf.chardev,
-                         false, errp)) {
+                         vs->conf.memory_isolation, errp)) {
         goto free_virtio;
     }
 
@@ -347,6 +347,8 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
 
 static const Property vhost_user_scsi_properties[] = {
     DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VirtIOSCSICommon,
+                     conf.memory_isolation, false),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
                        VIRTIO_SCSI_AUTO_NUM_QUEUES),
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index c10851492a..657a7d174a 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -318,7 +318,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
     }
 
     if (!vhost_user_init(&vub->vhost_user, &vub->chardev,
-                         false, errp)) {
+                         vub->memory_isolation, errp)) {
         return;
     }
 
@@ -410,7 +410,9 @@ static void vub_device_unrealize(DeviceState *dev)
 
 /*Define common qdev properties.  Inherited by all children*/
 static const Property vub_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev)
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserBase, memory_isolation,
+                     false),
 };
 
 
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 34ccbdec10..5529a8afb0 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -239,7 +239,7 @@ static void vuf_device_realize(DeviceState *dev, Error **errp)
     }
 
     if (!vhost_user_init(&fs->vhost_user, &fs->conf.chardev,
-                         false, errp)) {
+                         fs->conf.memory_isolation, errp)) {
         return;
     }
 
@@ -411,6 +411,8 @@ static const VMStateDescription vuf_backend_vmstate = {
 
 static const Property vuf_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserFS, conf.chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserFS, conf.memory_isolation,
+                     false),
     DEFINE_PROP_STRING("tag", VHostUserFS, conf.tag),
     DEFINE_PROP_UINT16("num-request-queues", VHostUserFS,
                        conf.num_request_queues, 1),
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index bd0ec64daf..b32dc09b0c 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -245,7 +245,7 @@ static void vu_scmi_device_realize(DeviceState *dev, Error **errp)
     vdev->host_features |= (1ULL << VIRTIO_SCMI_F_P2A_CHANNELS);
 
     if (!vhost_user_init(&scmi->vhost_user, &scmi->chardev,
-                         false, errp)) {
+                         scmi->memory_isolation, errp)) {
         return;
     }
 
@@ -288,6 +288,8 @@ static const VMStateDescription vu_scmi_vmstate = {
 
 static const Property vu_scmi_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserSCMI, chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserSCMI, memory_isolation,
+                     false),
 };
 
 static void vu_scmi_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index 44a90c76ad..7b62290167 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -107,7 +107,7 @@ static void vuv_device_realize(DeviceState *dev, Error **errp)
     }
 
     if (!vhost_user_init(&vsock->vhost_user, &vsock->conf.chardev,
-                         false, errp)) {
+                         vsock->conf.memory_isolation, errp)) {
         return;
     }
 
@@ -155,6 +155,8 @@ static void vuv_device_unrealize(DeviceState *dev)
 
 static const Property vuv_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserVSock, conf.chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserVSock, conf.memory_isolation,
+                     false),
 };
 
 static void vuv_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/vhost-user-base.h b/include/hw/virtio/vhost-user-base.h
index d5d2f081ae..29bc40736c 100644
--- a/include/hw/virtio/vhost-user-base.h
+++ b/include/hw/virtio/vhost-user-base.h
@@ -25,6 +25,7 @@ struct VHostUserBase {
     uint32_t num_vqs;
     uint32_t vq_size; /* can't exceed VIRTIO_QUEUE_MAX */
     uint32_t config_size;
+    bool memory_isolation;
     /* State tracking */
     VhostUserState vhost_user;
     struct vhost_virtqueue *vhost_vq;
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index dee848cfd8..8126447a86 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -30,6 +30,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserBlk, VHOST_USER_BLK)
 struct VHostUserBlk {
     VirtIODevice parent_obj;
     CharFrontend chardev;
+    bool memory_isolation;
     int32_t bootindex;
     struct virtio_blk_config blkcfg;
     uint16_t num_queues;
diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-user-fs.h
index 5699ea03a1..bf71990b9c 100644
--- a/include/hw/virtio/vhost-user-fs.h
+++ b/include/hw/virtio/vhost-user-fs.h
@@ -28,6 +28,7 @@ typedef struct {
     char *tag;
     uint16_t num_request_queues;
     uint16_t queue_size;
+    bool memory_isolation;
 } VHostUserFSConf;
 
 struct VHostUserFS {
diff --git a/include/hw/virtio/vhost-user-scmi.h b/include/hw/virtio/vhost-user-scmi.h
index 30ab0d7ab7..d346b42ed8 100644
--- a/include/hw/virtio/vhost-user-scmi.h
+++ b/include/hw/virtio/vhost-user-scmi.h
@@ -19,6 +19,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCMI, VHOST_USER_SCMI);
 struct VHostUserSCMI {
     VirtIODevice parent;
     CharFrontend chardev;
+    bool memory_isolation;
     struct vhost_virtqueue *vhost_vqs;
     struct vhost_dev vhost_dev;
     VhostUserState vhost_user;
diff --git a/include/hw/virtio/vhost-user-vsock.h b/include/hw/virtio/vhost-user-vsock.h
index 5db6938b8b..6288b26fa4 100644
--- a/include/hw/virtio/vhost-user-vsock.h
+++ b/include/hw/virtio/vhost-user-vsock.h
@@ -21,6 +21,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserVSock, VHOST_USER_VSOCK)
 
 typedef struct {
     CharFrontend chardev;
+    bool memory_isolation;
 } VHostUserVSockConf;
 
 struct VHostUserVSock {
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 220231ec9d..d0de1437f8 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -276,6 +276,7 @@ struct VhostUserGPU {
     CharFrontend vhost_chr;
     QemuDmaBuf *dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
     bool backend_blocked;
+    bool memory_isolation;
 };
 
 #define MAX_SLOTS 4096
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index b6028bb5cd..47fdc3785c 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -59,6 +59,7 @@ struct VirtIOSCSIConf {
     char *vhostfd;
     char *wwpn;
     CharFrontend chardev;
+    bool memory_isolation;
     uint32_t boot_tpgt;
     IOThread *iothread;
     IOThreadVirtQueueMappingList *iothread_vq_mapping_list;

-- 
2.43.0


