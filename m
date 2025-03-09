Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89A6C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 09:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trD9g-0000I9-UH; Sun, 09 Mar 2025 05:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1trD9f-0000Hg-Cj
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 05:41:07 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1trD9d-0004Bf-Gj
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 05:41:07 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-225477548e1so13116715ad.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 01:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1741513264; x=1742118064;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ySNXBRXbnlWGaKRtbvqCGzEZMz6zc9dLcyulHwbJso=;
 b=ppacD6+Qxpdihy14q4GdWYMAteNuQMxVuYot53eHupqO/GVYDxSVLIFAYQ2MoqHijE
 SbWETWNCmMQIQfYqCMnViymPXksIXjqbXHEltZmxFuwA83C4LWiuhkFu03gCe+2L4no2
 HBPw3mrssyQ9JJqQmt8pPOfSssItG+DBJENurCzMlL9zj4G3VyVkKGNnHN3V/GFvlqjT
 YNJOQH1N54JKenc/jPZaeK56Cz6OEwjdnDqtgqtjSOh/hIUdp8vKH8Zlid1h/rWCtkdY
 JfUKeFUFuR/RLfZ/OI0QVWH2OVB/FjWRyxrGLVzTCJHkEyxGSTcP3hqN3jgn09gGkZXV
 /Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741513264; x=1742118064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ySNXBRXbnlWGaKRtbvqCGzEZMz6zc9dLcyulHwbJso=;
 b=VWUu8UfigePTi85Qvl8QLyluzPb1GzAAUwEL4jb8i/LJg46vw3i40qHx3UL3XNJmn9
 cHJ/q24coiwST9xPzhMaHz4yS3v4i87v7/3sZ5t+yWjPhbDwMi0WFDgK5HKfoz6HuzAe
 vM0G/PsEKvjPwHQetRWheClsgbG8XYt1O8fVu7+v9VUgKsf4TqqgFGhG3Wdap1ctJTP6
 kXRd6mqygUhitJdbByKPe9mnHOfkjrJiGTUfm4btyZ1OfomUz7K9RVmdhvuaAfwL+X10
 U7x+BbIHcgKFkLpdWxJ4uDipwPhIu2rmWYyB1G7OIs5OgZ9jiLHUauaTjlqh0YGKQOul
 G/wA==
X-Gm-Message-State: AOJu0YyC79Rq9ZRq2uYDWhfntNnLJRzYA1jRzBeaXl+/3eDDkexFlExv
 LmhXOb91Nk/SLV0HenpvZGqk5fUZLkls9ot+yE+To2WubG6qjp7moTsU4z47CMZCPNOsGULgk55
 UmncyCmYp72BmbOw5
X-Gm-Gg: ASbGncvKiB4WxnW9p9b7kodpWk0rveVfGmtaynum1+ddBKD4NhoRslmOd3WDeI+iaaL
 uR4bo/++NMvXAbakRfBzQar+AdtvBhXG3oZXeQ1FviJrdnauZaqnhz8bWUai70eV3uwvXluWxYk
 mbKBVfJRADwvnI2sL5r9zzIDRr+6mBayq9JVGBgqMSOaxRocjtNKhNuPfLhXOR7m0bzXJ2WMe25
 sHRTjAp7n8saScf0/pZ4UdIFLKdfAxfB2B9FFiee5u5VD4yAj8BhLb7qYMHBG3HD7NmEMPFygqg
 Zfhmuwwa13ri44fIfPWdi7WjYR+4hnSbczCbZoAayjdGCLmJN9EJ
X-Google-Smtp-Source: AGHT+IFgP/MEs8k8gKEAPDloLiStbhcsdlBmOxR/6l/e6npgwJxqsqh6OC1p6JmveTHSqoluTOVtwg==
X-Received: by 2002:a17:903:2445:b0:21f:988d:5758 with SMTP id
 d9443c01a7336-22428c075ccmr158438235ad.35.1741513263769; 
 Sun, 09 Mar 2025 01:41:03 -0800 (PST)
Received: from fedora.smartx.com ([103.85.74.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410ac0794sm57716185ad.259.2025.03.09.01.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 01:41:03 -0800 (PST)
From: Haoqian He <haoqian.he@smartx.com>
To: qemu-devel@nongnu.org
Cc: fengli@smartx.com, yuhua@smartx.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 3/3] vhost-user: return failure if backend crash when live
 migration
Date: Sun,  9 Mar 2025 05:40:51 -0400
Message-ID: <20250309094051.3655292-2-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250309094051.3655292-1-haoqian.he@smartx.com>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250309094051.3655292-1-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Live migration should be terminated if backend crash.

Since the vhost device will be stopped when VM is stopped before
the end of the live migration, current implementation if vhost
backend died, vhost device's set_status() will not return failure,
live migration won't perceive the disconnection between qemu and
vhost backend, inflight io would be submitted in migration target
host, leading to IO error.

To fix this issue:
1. Add set_status_ext() which has return value for
VirtioDeviceClass and vhost-user-blk/scsi use the _ext version.

2. In set_status_ext(), return failure if the flag `connected`
is false or vhost_dev_stop return failure, which means qemu lost
connection with backend.

Hence migration_completion() will process failure, terminate
migration and restore VM.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
---
 hw/block/vhost-user-blk.c             | 29 +++++++++++++++------------
 hw/scsi/vhost-scsi-common.c           | 11 +++++-----
 hw/scsi/vhost-user-scsi.c             | 20 ++++++++++--------
 hw/virtio/virtio.c                    | 20 +++++++++++++-----
 include/hw/virtio/vhost-scsi-common.h |  2 +-
 include/hw/virtio/virtio.h            |  1 +
 6 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index ae42327cf8..4865786c54 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -204,7 +204,7 @@ err_host_notifiers:
     return ret;
 }
 
-static void vhost_user_blk_stop(VirtIODevice *vdev)
+static int vhost_user_blk_stop(VirtIODevice *vdev)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
@@ -212,26 +212,26 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
     int ret;
 
     if (!s->started_vu) {
-        return;
+        return 0;
     }
     s->started_vu = false;
 
     if (!k->set_guest_notifiers) {
-        return;
+        return 0;
     }
 
-    vhost_dev_stop(&s->dev, vdev, true);
+    ret = vhost_dev_stop(&s->dev, vdev, true);
 
-    ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
-    if (ret < 0) {
+    if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < 0) {
         error_report("vhost guest notifier cleanup failed: %d", ret);
-        return;
+        return -1;
     }
 
     vhost_dev_disable_notifiers(&s->dev, vdev);
+    return ret;
 }
 
-static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
+static int vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
@@ -239,11 +239,11 @@ static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
     int ret;
 
     if (!s->connected) {
-        return;
+        return -1;
     }
 
     if (vhost_dev_is_started(&s->dev) == should_start) {
-        return;
+        return 0;
     }
 
     if (should_start) {
@@ -253,9 +253,12 @@ static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
             qemu_chr_fe_disconnect(&s->chardev);
         }
     } else {
-        vhost_user_blk_stop(vdev);
+        ret = vhost_user_blk_stop(vdev);
+        if (ret < 0) {
+            return ret;
+        }
     }
-
+    return 0;
 }
 
 static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
@@ -597,7 +600,7 @@ static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
     vdc->get_config = vhost_user_blk_update_config;
     vdc->set_config = vhost_user_blk_set_config;
     vdc->get_features = vhost_user_blk_get_features;
-    vdc->set_status = vhost_user_blk_set_status;
+    vdc->set_status_ext = vhost_user_blk_set_status;
     vdc->reset = vhost_user_blk_reset;
     vdc->get_vhost = vhost_user_blk_get_vhost;
 }
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index 4c8637045d..bfeed0cb1b 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -101,24 +101,25 @@ err_host_notifiers:
     return ret;
 }
 
-void vhost_scsi_common_stop(VHostSCSICommon *vsc)
+int vhost_scsi_common_stop(VHostSCSICommon *vsc)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(vsc);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret = 0;
 
-    vhost_dev_stop(&vsc->dev, vdev, true);
+    ret = vhost_dev_stop(&vsc->dev, vdev, true);
 
     if (k->set_guest_notifiers) {
-        ret = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
-        if (ret < 0) {
+        int r = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
+        if (r < 0) {
                 error_report("vhost guest notifier cleanup failed: %d", ret);
         }
+        assert(r >= 0);
     }
-    assert(ret >= 0);
 
     vhost_dev_disable_notifiers(&vsc->dev, vdev);
+    return ret;
 }
 
 uint64_t vhost_scsi_common_get_features(VirtIODevice *vdev, uint64_t features,
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index adb41b9816..8e7efc38f2 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -52,19 +52,19 @@ static int vhost_user_scsi_start(VHostUserSCSI *s, Error **errp)
     return ret;
 }
 
-static void vhost_user_scsi_stop(VHostUserSCSI *s)
+static int vhost_user_scsi_stop(VHostUserSCSI *s)
 {
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
 
     if (!s->started_vu) {
-        return;
+        return 0;
     }
     s->started_vu = false;
 
-    vhost_scsi_common_stop(vsc);
+    return vhost_scsi_common_stop(vsc);
 }
 
-static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
+static int vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserSCSI *s = (VHostUserSCSI *)vdev;
     DeviceState *dev = DEVICE(vdev);
@@ -75,11 +75,11 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
     int ret;
 
     if (!s->connected) {
-        return;
+        return -1;
     }
 
     if (vhost_dev_is_started(&vsc->dev) == should_start) {
-        return;
+        return 0;
     }
 
     if (should_start) {
@@ -91,8 +91,12 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
             qemu_chr_fe_disconnect(&vs->conf.chardev);
         }
     } else {
-        vhost_user_scsi_stop(s);
+        ret = vhost_user_scsi_stop(s);
+        if (ret) {
+            return ret;
+        }
     }
+    return 0;
 }
 
 static void vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue *vq)
@@ -399,7 +403,7 @@ static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
     vdc->unrealize = vhost_user_scsi_unrealize;
     vdc->get_features = vhost_scsi_common_get_features;
     vdc->set_config = vhost_scsi_common_set_config;
-    vdc->set_status = vhost_user_scsi_set_status;
+    vdc->set_status_ext = vhost_user_scsi_set_status;
     fwc->get_dev_path = vhost_scsi_common_get_fw_dev_path;
     vdc->reset = vhost_user_scsi_reset;
     vdc->get_vhost = vhost_user_scsi_get_vhost;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5e8d4cab53..fff7cdb35d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2221,12 +2221,12 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     trace_virtio_set_status(vdev, val);
+    int ret = 0;
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         if (!(vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) &&
             val & VIRTIO_CONFIG_S_FEATURES_OK) {
-            int ret = virtio_validate_features(vdev);
-
+            ret = virtio_validate_features(vdev);
             if (ret) {
                 return ret;
             }
@@ -2238,12 +2238,18 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
         virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
     }
 
-    if (k->set_status) {
+    if (k->set_status_ext) {
+        ret = k->set_status_ext(vdev, val);
+        if (ret) {
+            qemu_log("set %s status to %d failed, old status: %d\n",
+                     vdev->name, val, vdev->status);
+        }
+    } else if (k->set_status) {
         k->set_status(vdev, val);
     }
     vdev->status = val;
 
-    return 0;
+    return ret;
 }
 
 static enum virtio_device_endian virtio_default_endian(void)
@@ -3436,7 +3442,11 @@ static int virtio_vmstate_change(void *opaque, bool running, RunState state)
     }
 
     if (!backend_run) {
-        virtio_set_status(vdev, vdev->status);
+        // the return value was used for stopping VM during migration
+        int ret = virtio_set_status(vdev, vdev->status);
+        if (ret) {
+            return ret;
+        }
     }
     return 0;
 }
diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vhost-scsi-common.h
index c5d2c09455..d54d9c916f 100644
--- a/include/hw/virtio/vhost-scsi-common.h
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -40,7 +40,7 @@ struct VHostSCSICommon {
 };
 
 int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp);
-void vhost_scsi_common_stop(VHostSCSICommon *vsc);
+int vhost_scsi_common_stop(VHostSCSICommon *vsc);
 char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState *bus,
                                         DeviceState *dev);
 void vhost_scsi_common_set_config(VirtIODevice *vdev, const uint8_t *config);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 6386910280..c99d56f519 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -187,6 +187,7 @@ struct VirtioDeviceClass {
     void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
     void (*reset)(VirtIODevice *vdev);
     void (*set_status)(VirtIODevice *vdev, uint8_t val);
+    int (*set_status_ext)(VirtIODevice *vdev, uint8_t val);
     /* Device must validate queue_index.  */
     void (*queue_reset)(VirtIODevice *vdev, uint32_t queue_index);
     /* Device must validate queue_index.  */
-- 
2.48.1


