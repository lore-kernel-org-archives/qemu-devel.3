Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2132C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihT-00058t-RU; Wed, 22 May 2024 05:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihS-0004yE-3C
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihC-0001lV-Ld
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ngui3EdeL/PoRl67peYHgHmXRZ/AvOL33ibesNHCX3g=;
 b=J6Z++6R4nK7/HbLohIfMTDj3my9Xzj/yUx8S45kLSEYXX1RB1rzVIQ0VRwTKr2qBvT3drD
 tqMaAcFpKS0FlCbyakcn5Gj8TWFRb+UkPLjrfNMGczkvB/cid7Do7CEikAqw+kY5IUcGKt
 fIRtNWgC9eJ8T7qiRGxgH/1IiIsfcO8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-_ZVBIr-JOOGHi6gvf8DDqA-1; Wed, 22 May 2024 05:55:39 -0400
X-MC-Unique: _ZVBIr-JOOGHi6gvf8DDqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99D5280028D;
 Wed, 22 May 2024 09:55:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78B2D28E3;
 Wed, 22 May 2024 09:55:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 35/47] vfio/platform: Make vfio_populate_device() and
 vfio_base_device_init() return bool
Date: Wed, 22 May 2024 11:54:30 +0200
Message-ID: <20240522095442.195243-36-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

This is to follow the coding standand in qapi/error.h to return bool
for bool-valued functions.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/platform.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index e1a32863d919fe09a743f5fb108f9787984d4378..a85c199c76aa25559acf931621b84dd3dac6184d 100644
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
2.45.1


