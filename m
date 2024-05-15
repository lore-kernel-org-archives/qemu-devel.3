Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947D9C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79vq-00028e-7p; Wed, 15 May 2024 04:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vd-00026Z-11
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:01 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79va-00074Z-MZ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715761438; x=1747297438;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RS2o5MSumh7P4PM1sc4bKQuA+A9psNU/xRJ8H8A86Q0=;
 b=nWcCbMVxo7yC4inr1PFjEzQuYjb4hugbQv5fFl20xkWdOO9qrhoWpOtf
 QlQboHCoh0dgnuQbs1tQjH8n6pdHIxoKVIWoNA0DRIHUghlQfJqYWmVFj
 XXcwVAj+LBusEevjYXcwipKFBEizQEgfM5hbdcpHrkaj3iX+tWVswIfEZ
 /r6BtybuDVyHhOpapmvpNHm19Dp8VGmT9p31ATUvJts7IqSAwRB42zHNI
 e0Q0yHsqS7wjY0gypYgijGer7iveVFeTVQsRMFczOgbr1JkLSnuFAC0NU
 rSNp0xeEhEiFRXO5i4lAPWA6BrM8U3sKrTyV2rmd3BWcAbd+ycxgZx+dq w==;
X-CSE-ConnectionGUID: pUQzI9S5QVaIl6RSkmDFYw==
X-CSE-MsgGUID: lVjarqjbTfWJyuKbYYauRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11961546"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="11961546"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:23:58 -0700
X-CSE-ConnectionGUID: s0TqyAyBQWGrcOb0d05lNg==
X-CSE-MsgGUID: js/AocQdSbuxZwzFgP1q3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="31396295"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:23:56 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 06/16] vfio/platform: Make vfio_populate_device() and
 vfio_base_device_init() return bool
Date: Wed, 15 May 2024 16:20:31 +0800
Message-Id: <20240515082041.556571-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515082041.556571-1-zhenzhong.duan@intel.com>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

This is to follow the coding standand in qapi/error.h to return bool
for bool-valued functions.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/platform.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index e1a32863d9..a85c199c76 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -441,7 +441,7 @@ static int vfio_platform_hot_reset_multi(VFIODevice *vbasedev)
  * @errp: error object
  *
  */
-static int vfio_populate_device(VFIODevice *vbasedev, Error **errp)
+static bool vfio_populate_device(VFIODevice *vbasedev, Error **errp)
 {
     VFIOINTp *intp, *tmp;
     int i, ret = -1;
@@ -450,7 +450,7 @@ static int vfio_populate_device(VFIODevice *vbasedev, Error **errp)
 
     if (!(vbasedev->flags & VFIO_DEVICE_FLAGS_PLATFORM)) {
         error_setg(errp, "this isn't a platform device");
-        return ret;
+        return false;
     }
 
     vdev->regions = g_new0(VFIORegion *, vbasedev->num_regions);
@@ -487,12 +487,11 @@ static int vfio_populate_device(VFIODevice *vbasedev, Error **errp)
                                                     irq.flags);
             intp = vfio_init_intp(vbasedev, irq, errp);
             if (!intp) {
-                ret = -1;
                 goto irq_err;
             }
         }
     }
-    return 0;
+    return true;
 irq_err:
     timer_del(vdev->mmap_timer);
     QLIST_FOREACH_SAFE(intp, &vdev->intp_list, next, tmp) {
@@ -507,7 +506,7 @@ reg_error:
         g_free(vdev->regions[i]);
     }
     g_free(vdev->regions);
-    return ret;
+    return false;
 }
 
 /* specialized functions for VFIO Platform devices */
@@ -527,10 +526,8 @@ static VFIODeviceOps vfio_platform_ops = {
  * fd retrieval, resource query.
  * Precondition: the device name must be initialized
  */
-static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
+static bool vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
 {
-    int ret;
-
     /* @fd takes precedence over @sysfsdev which takes precedence over @host */
     if (vbasedev->fd < 0 && vbasedev->sysfsdev) {
         g_free(vbasedev->name);
@@ -538,7 +535,7 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
     } else if (vbasedev->fd < 0) {
         if (!vbasedev->name || strchr(vbasedev->name, '/')) {
             error_setg(errp, "wrong host device name");
-            return -EINVAL;
+            return false;
         }
 
         vbasedev->sysfsdev = g_strdup_printf("/sys/bus/platform/devices/%s",
@@ -546,20 +543,20 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
     }
 
     if (!vfio_device_get_name(vbasedev, errp)) {
-        return -EINVAL;
+        return false;
     }
 
     if (!vfio_attach_device(vbasedev->name, vbasedev,
                             &address_space_memory, errp)) {
-        return -EINVAL;
+        return false;
     }
 
-    ret = vfio_populate_device(vbasedev, errp);
-    if (ret) {
-        vfio_detach_device(vbasedev);
+    if (vfio_populate_device(vbasedev, errp)) {
+        return true;
     }
 
-    return ret;
+    vfio_detach_device(vbasedev);
+    return false;
 }
 
 /**
@@ -576,7 +573,7 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
     VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(dev);
     SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
     VFIODevice *vbasedev = &vdev->vbasedev;
-    int i, ret;
+    int i;
 
     qemu_mutex_init(&vdev->intp_mutex);
 
@@ -584,9 +581,8 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
                                 vbasedev->sysfsdev : vbasedev->name,
                                 vdev->compat);
 
-    ret = vfio_base_device_init(vbasedev, errp);
-    if (ret) {
-        goto out;
+    if (!vfio_base_device_init(vbasedev, errp)) {
+        goto init_err;
     }
 
     if (!vdev->compat) {
@@ -618,11 +614,9 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
         }
         sysbus_init_mmio(sbdev, vdev->regions[i]->mem);
     }
-out:
-    if (!ret) {
-        return;
-    }
+    return;
 
+init_err:
     if (vdev->vbasedev.name) {
         error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     } else {
-- 
2.34.1


