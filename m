Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE0ACD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 18:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUqhH-0002XQ-Iy; Wed, 03 Jun 2026 14:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wUpT7-0003NF-Cn
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:33:29 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wUpT4-0002yy-Fw
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:33:28 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-137335bc3caso11857825c88.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780508003; x=1781112803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bcibRKnRKqw8l+rOuwRQfsaHQlskfBWkaslXsjpLrvg=;
 b=Wo6XciYslUY5bzn54RfrVUlWrxMgcDKd9L6Y8Vn47CObxkijOwUgfksFDbWnwh+mT0
 R4Qfe79MdCGgYZhJ6hIePsNAl/UEvbmsgBD0RmnjyQ6E53UEGAzg8/m2aRqys/SeAW2S
 kiX3vH68woq3awjPvz/lQbKpTPl9jJkdljmDQuur1lxYrU9q1sQucZjMP8Mmk1IFTFcB
 X4FlMs7OtVEsr3FCxUm0kJIacwUmQMb4cfEW7Kztlsdb62/h5jbNOxNtVF3QNoGvthgI
 ESTi/BSxQN4P28JxLuYxUAwoaMHHZHuK+xeANTDuwfXhn1vf42G2rDJzaDzstE6uXven
 3D6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508003; x=1781112803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcibRKnRKqw8l+rOuwRQfsaHQlskfBWkaslXsjpLrvg=;
 b=MU7hvBhDXvsHTONzQouT4BzkogkH/CD2m1REYo+bLKhk7bINtDIxrKTBfm6RZ29e3g
 4tiv+i8Bw7r1m90Quizoc30elmnipXr/4MHgEkZUnKo5slQ8gNDG58s9c1ms6E9lYFAp
 7Y74MN05jACk9KHGt//yMlKr17QBKMkCJft9YlIjU/m4YMe+YsCGWDfISimRmKv9Naec
 Fe+gROISAnlhEqS8giZLSG9ljBcIi0GZALOtOkJaWzxrD1M0Q4XIwtPA4xhZPJQ8pgwH
 MTUw76Ed23C9eeEI2I/G+0sfazteHsiHiqeVFqTvMv5lYE3eWPRQkXQ3vYoD4dgc7YWL
 DcDQ==
X-Gm-Message-State: AOJu0YynvYFq8gq3lW0dUZfxsYl1Qw61z2dzM7wEt/PuYTePxCI/BFC1
 XJLXvS6X/5QViHrsgmMWAVBENB36jdeSaDxo2Oddz0GQ7w5iWyPG1w85wHoj0g==
X-Gm-Gg: Acq92OGY1T8JBpfz06W3+KOsyOCXNmuTc+5BnBH14MaDwMJJxqDV9q1dkc9Ib5NDSu2
 FJYQt4JB15gED4C6jAGEbJdChFhlK3vNf+xYLT9mfXtWALsUf+Gw+tBlF7E20OZ+syGjb847754
 EQE3xmKkO8pMTT/rY40VREut+gZwYbDS8zW94pmd+7F/3qWNUoRT4SbFikUiBDZSYHcBWJ/6KaF
 HXFNV1b7uvzcd1G1hKGPPw2mbmKcG4wOGJG3h9eTncIQ0z+cO+maXf4kwIjxkKgOrKytJExQip3
 VnKuUdm65el4hEfO1yZ0fkulY9EG6/2LSIRalNXuTEIUtRnQ6/AGAlIf0XEDUpmd7EBLg/kyVT3
 MvJMJFxiS3T8VmnVSa/JX5gta5Z4MeB08HWo/VJjFdFj5Uq+pEf3MFhyllrc+tiKP3pb+3GpPQQ
 ww4maBXCeslvQVjUKoboBEW54bHhkZ0qI50PbeyK0rCFID2VEYlH93fpwu/rGd
X-Received: by 2002:a05:7022:ec07:b0:136:5c88:d917 with SMTP id
 a92af1059eb24-137f6a4b1a0mr1593499c88.2.1780508002907; 
 Wed, 03 Jun 2026 10:33:22 -0700 (PDT)
Received: from MacLin.attlocal.net ([2600:1700:e140:14d0:82a0:9743:8a0a:4598])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f53f06c4sm2290008c88.0.2026.06.03.10.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:33:22 -0700 (PDT)
From: ConKite <connorkite@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	hreitz@redhat.com,
	ConKite <connorkite@gmail.com>
Subject: [RFC] vhost-user: Add memoryIsolation qdev property to vhost-user
 devices
Date: Wed,  3 Jun 2026 10:32:28 -0700
Message-ID: <20260603173239.3189102-1-connorkite@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=connorkite@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Jun 2026 14:52:10 -0400
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
qdev property, "memory-isolation", is added to all vhost-user devices.  This is
simply a bool representing whether the mode is active or not.

Additionally, common property definitions for all children of vhost-user-base are
consolidated. Those property definitions now occur when VHostUserBase is initialized

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/block/vhost-user-blk.c            |  1 +
 hw/display/vhost-user-gpu.c          |  1 +
 hw/scsi/vhost-user-scsi.c            |  1 +
 hw/virtio/vhost-user-base.c          | 10 ++++++++++
 hw/virtio/vhost-user-fs.c            |  1 +
 hw/virtio/vhost-user-gpio.c          |  4 ----
 hw/virtio/vhost-user-i2c.c           |  5 -----
 hw/virtio/vhost-user-input.c         |  5 -----
 hw/virtio/vhost-user-rng.c           |  5 -----
 hw/virtio/vhost-user-rtc.c           |  4 ----
 hw/virtio/vhost-user-scmi.c          |  1 +
 hw/virtio/vhost-user-snd.c           |  1 -
 hw/virtio/vhost-user-spi.c           |  5 -----
 hw/virtio/vhost-user-test-device.c   |  1 -
 hw/virtio/vhost-user-vsock.c         |  1 +
 include/hw/virtio/vhost-user-base.h  |  1 +
 include/hw/virtio/vhost-user-blk.h   |  1 +
 include/hw/virtio/vhost-user-fs.h    |  1 +
 include/hw/virtio/vhost-user-scmi.h  |  1 +
 include/hw/virtio/vhost-user-vsock.h |  1 +
 include/hw/virtio/virtio-gpu.h       |  1 +
 include/hw/virtio/virtio-scsi.h      |  1 +
 22 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c151e83677..849f437d9e 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -605,6 +605,7 @@ static const VMStateDescription vmstate_vhost_user_blk = {
 
 static const Property vhost_user_blk_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserBlk, memoryIsolation, false),
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
                        VHOST_USER_BLK_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 6e5e6540a4..d7a94fc856 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -664,6 +664,7 @@ static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
 
 static const Property vhost_user_gpu_properties[] = {
     VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
+    DEFINE_PROP_BOOL("memory-isolation", VhostUserGPU, memoryIsolation, false),
 };
 
 static void
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 3612897d4b..6ec5236b1d 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -347,6 +347,7 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
 
 static const Property vhost_user_scsi_properties[] = {
     DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VirtIOSCSICommon, conf.memoryIsolation, false),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
                        VIRTIO_SCSI_AUTO_NUM_QUEUES),
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 01ab9ca56b..cbc5792ac7 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -353,9 +353,17 @@ static void vub_device_unrealize(DeviceState *dev)
     do_vhost_user_cleanup(vdev, vub);
 }
 
+//Define common properties
+static const Property vub_properties[] = {
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserBase, memoryIsolation, false),
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev)
+};
+
+
 static void vub_class_init(ObjectClass *klass, const void *data)
 {
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     vdc->realize = vub_device_realize;
     vdc->unrealize = vub_device_unrealize;
@@ -363,6 +371,8 @@ static void vub_class_init(ObjectClass *klass, const void *data)
     vdc->get_config = vub_get_config;
     vdc->set_config = vub_set_config;
     vdc->set_status = vub_set_status;
+
+    device_class_set_props(dc, vub_properties);
 }
 
 static const TypeInfo vub_types[] = {
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index ad6fcacf06..df2dd5e775 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -409,6 +409,7 @@ static const VMStateDescription vuf_backend_vmstate = {
 
 static const Property vuf_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserFS, conf.chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserFS, conf.memoryIsolation, false),
     DEFINE_PROP_STRING("tag", VHostUserFS, conf.tag),
     DEFINE_PROP_UINT16("num-request-queues", VHostUserFS,
                        conf.num_request_queues, 1),
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index d473f87077..33b8752282 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -14,9 +14,6 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_gpio.h"
 
-static const Property vgpio_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
 
 static void vgpio_realize(DeviceState *dev, Error **errp)
 {
@@ -42,7 +39,6 @@ static void vu_gpio_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_gpio_vmstate;
-    device_class_set_props(dc, vgpio_properties);
     device_class_set_parent_realize(dc, vgpio_realize,
                                     &vubc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/virtio/vhost-user-i2c.c b/hw/virtio/vhost-user-i2c.c
index 152b1f6740..3f5427b5b2 100644
--- a/hw/virtio/vhost-user-i2c.c
+++ b/hw/virtio/vhost-user-i2c.c
@@ -14,10 +14,6 @@
 #include "qemu/error-report.h"
 #include "standard-headers/linux/virtio_ids.h"
 
-static const Property vi2c_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
-
 static void vi2c_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
@@ -42,7 +38,6 @@ static void vu_i2c_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_i2c_vmstate;
-    device_class_set_props(dc, vi2c_properties);
     device_class_set_parent_realize(dc, vi2c_realize,
                                     &vubc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/virtio/vhost-user-input.c b/hw/virtio/vhost-user-input.c
index 5cfc5bbb56..8fe6349ffc 100644
--- a/hw/virtio/vhost-user-input.c
+++ b/hw/virtio/vhost-user-input.c
@@ -7,10 +7,6 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio-input.h"
 
-static const Property vinput_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
-
 static void vinput_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
@@ -36,7 +32,6 @@ static void vhost_input_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_vhost_input;
-    device_class_set_props(dc, vinput_properties);
     device_class_set_parent_realize(dc, vinput_realize,
                                     &vubc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/virtio/vhost-user-rng.c b/hw/virtio/vhost-user-rng.c
index 106c8f211a..664aee403d 100644
--- a/hw/virtio/vhost-user-rng.c
+++ b/hw/virtio/vhost-user-rng.c
@@ -20,10 +20,6 @@ static const VMStateDescription vu_rng_vmstate = {
     .unmigratable = 1,
 };
 
-static const Property vrng_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
-
 static void vu_rng_base_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
@@ -43,7 +39,6 @@ static void vu_rng_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_rng_vmstate;
-    device_class_set_props(dc, vrng_properties);
     device_class_set_parent_realize(dc, vu_rng_base_realize,
                                     &vubc->parent_realize);
 
diff --git a/hw/virtio/vhost-user-rtc.c b/hw/virtio/vhost-user-rtc.c
index 88b0c70b90..6d80cb6263 100644
--- a/hw/virtio/vhost-user-rtc.c
+++ b/hw/virtio/vhost-user-rtc.c
@@ -19,9 +19,6 @@ static const VMStateDescription vu_rtc_vmstate = {
     .unmigratable = 1,
 };
 
-static const Property vrtc_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
 
 static void vu_rtc_base_realize(DeviceState *dev, Error **errp)
 {
@@ -42,7 +39,6 @@ static void vu_rtc_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_rtc_vmstate;
-    device_class_set_props(dc, vrtc_properties);
     device_class_set_parent_realize(dc, vu_rtc_base_realize,
                                     &vubc->parent_realize);
 
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index f9264c4374..0f586adfb1 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -282,6 +282,7 @@ static const VMStateDescription vu_scmi_vmstate = {
 
 static const Property vu_scmi_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserSCMI, chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserSCMI, memoryIsolation, false),
 };
 
 static void vu_scmi_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
index 7129b77d9c..3663450aed 100644
--- a/hw/virtio/vhost-user-snd.c
+++ b/hw/virtio/vhost-user-snd.c
@@ -34,7 +34,6 @@ static const VMStateDescription vu_snd_vmstate = {
 };
 
 static const Property vsnd_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_BIT64("controls", VHostUserBase,
                       parent_obj.host_features, VIRTIO_SND_F_CTLS, false),
 };
diff --git a/hw/virtio/vhost-user-spi.c b/hw/virtio/vhost-user-spi.c
index 707f96c250..fb6168d391 100644
--- a/hw/virtio/vhost-user-spi.c
+++ b/hw/virtio/vhost-user-spi.c
@@ -15,10 +15,6 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_spi.h"
 
-static const Property vspi_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
-
 static void vspi_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
@@ -44,7 +40,6 @@ static void vu_spi_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_spi_vmstate;
-    device_class_set_props(dc, vspi_properties);
     device_class_set_parent_realize(dc, vspi_realize,
                                     &vubc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/virtio/vhost-user-test-device.c b/hw/virtio/vhost-user-test-device.c
index a2f963fdf6..91e23bf07a 100644
--- a/hw/virtio/vhost-user-test-device.c
+++ b/hw/virtio/vhost-user-test-device.c
@@ -30,7 +30,6 @@ static const VMStateDescription vud_vmstate = {
 };
 
 static const Property vud_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_UINT16("virtio-id", VHostUserBase, virtio_id, 0),
     DEFINE_PROP_UINT32("vq_size", VHostUserBase, vq_size, 64),
     DEFINE_PROP_UINT32("num_vqs", VHostUserBase, num_vqs, 1),
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index c2cd376e73..8170b12ae9 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -154,6 +154,7 @@ static void vuv_device_unrealize(DeviceState *dev)
 
 static const Property vuv_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserVSock, conf.chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserVSock, conf.memoryIsolation, false),
 };
 
 static void vuv_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/vhost-user-base.h b/include/hw/virtio/vhost-user-base.h
index d5d2f081ae..23dc667d05 100644
--- a/include/hw/virtio/vhost-user-base.h
+++ b/include/hw/virtio/vhost-user-base.h
@@ -25,6 +25,7 @@ struct VHostUserBase {
     uint32_t num_vqs;
     uint32_t vq_size; /* can't exceed VIRTIO_QUEUE_MAX */
     uint32_t config_size;
+    bool memoryIsolation;
     /* State tracking */
     VhostUserState vhost_user;
     struct vhost_virtqueue *vhost_vq;
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 1e41a2bcdf..d4dfce824e 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -30,6 +30,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserBlk, VHOST_USER_BLK)
 struct VHostUserBlk {
     VirtIODevice parent_obj;
     CharFrontend chardev;
+    bool memoryIsolation;
     int32_t bootindex;
     struct virtio_blk_config blkcfg;
     uint16_t num_queues;
diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-user-fs.h
index 5699ea03a1..47e253db07 100644
--- a/include/hw/virtio/vhost-user-fs.h
+++ b/include/hw/virtio/vhost-user-fs.h
@@ -28,6 +28,7 @@ typedef struct {
     char *tag;
     uint16_t num_request_queues;
     uint16_t queue_size;
+    bool memoryIsolation;
 } VHostUserFSConf;
 
 struct VHostUserFS {
diff --git a/include/hw/virtio/vhost-user-scmi.h b/include/hw/virtio/vhost-user-scmi.h
index 30ab0d7ab7..ad91216ac6 100644
--- a/include/hw/virtio/vhost-user-scmi.h
+++ b/include/hw/virtio/vhost-user-scmi.h
@@ -19,6 +19,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCMI, VHOST_USER_SCMI);
 struct VHostUserSCMI {
     VirtIODevice parent;
     CharFrontend chardev;
+    bool memoryIsolation;
     struct vhost_virtqueue *vhost_vqs;
     struct vhost_dev vhost_dev;
     VhostUserState vhost_user;
diff --git a/include/hw/virtio/vhost-user-vsock.h b/include/hw/virtio/vhost-user-vsock.h
index 5db6938b8b..2f455bc1dc 100644
--- a/include/hw/virtio/vhost-user-vsock.h
+++ b/include/hw/virtio/vhost-user-vsock.h
@@ -21,6 +21,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserVSock, VHOST_USER_VSOCK)
 
 typedef struct {
     CharFrontend chardev;
+    bool memoryIsolation;
 } VHostUserVSockConf;
 
 struct VHostUserVSock {
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index f69fc19462..1d02e106c0 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -276,6 +276,7 @@ struct VhostUserGPU {
     CharFrontend vhost_chr;
     QemuDmaBuf *dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
     bool backend_blocked;
+    bool memoryIsolation;
 };
 
 #define MAX_SLOTS 4096
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index b6028bb5cd..afe02f8d21 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -59,6 +59,7 @@ struct VirtIOSCSIConf {
     char *vhostfd;
     char *wwpn;
     CharFrontend chardev;
+    bool memoryIsolation;
     uint32_t boot_tpgt;
     IOThread *iothread;
     IOThreadVirtQueueMappingList *iothread_vq_mapping_list;
-- 
2.43.0


