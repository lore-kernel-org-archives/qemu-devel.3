Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7229CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ell-0001XE-Rd; Fri, 25 Apr 2025 04:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EkO-000708-HI
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EkL-0003N2-Sx
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aMOAoBVc7BaKcWu6OylWK+5uEVey7Rp74m+rA7vNbGk=;
 b=YcaorBuXIgQY3SRyjIEO1l0w3WK9PuDIU6s5nMsBdefHZTkik1BkOy1bF2Dgl4hb+RGOnT
 6U7UB5O8WhzpAbIjEzj9FCobPY9U76s5N4+LLczaPI27styStNia7IQYVnweDXphYKNQwm
 rVRmWglsw0/Wxrnrku0aAr3zru9puLI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-imI24BznNFKg4D4Ua8GZjg-1; Fri,
 25 Apr 2025 04:49:17 -0400
X-MC-Unique: imI24BznNFKg4D4Ua8GZjg-1
X-Mimecast-MFC-AGG-ID: imI24BznNFKg4D4Ua8GZjg_1745570956
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 528021955DC5; Fri, 25 Apr 2025 08:49:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A00BE30001A2; Fri, 25 Apr 2025 08:49:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 46/50] vfio: Cleanup host IOMMU device creation
Date: Fri, 25 Apr 2025 10:46:39 +0200
Message-ID: <20250425084644.102196-47-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

realize() is now moved after attachment, do the same for hiod creation.
Introduce a new function vfio_device_hiod_create_and_realize() to do
them all in one go.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250423072824.3647952-5-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h |  3 ++-
 hw/vfio/container.c           |  5 ++++-
 hw/vfio/device.c              | 33 ++++++++++++++-------------------
 hw/vfio/iommufd.c             |  4 +++-
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 696ed87f01038bf29df26046fa9b75051971ede3..81c95bb51eeead0e8c4d126c2d0561e235632946 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -123,7 +123,8 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
 
 void vfio_device_reset_handler(void *opaque);
 bool vfio_device_is_mdev(VFIODevice *vbasedev);
-bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
+bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
+                                         const char *typename, Error **errp);
 bool vfio_device_attach(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
 void vfio_device_detach(VFIODevice *vbasedev);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 652a6197ceaff96399f16f4727ea3188eafec4dc..78f70e63d6fcef09a7c12cbd01526701073e6952 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -898,7 +898,9 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         goto group_put_exit;
     }
 
-    if (!vfio_device_hiod_realize(vbasedev, errp)) {
+    if (!vfio_device_hiod_create_and_realize(vbasedev,
+                                             TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
+                                             errp)) {
         goto device_put_exit;
     }
 
@@ -924,6 +926,7 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, container_next);
     vbasedev->bcontainer = NULL;
     trace_vfio_device_detach(vbasedev->name, group->groupid);
+    object_unref(vbasedev->hiod);
     vfio_device_put(vbasedev);
     vfio_group_put(group);
 }
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 4de6948cf472806ed639f629cc3d980f51021f2c..d625a7c4dbbf4ac222541283c4034e840da02b08 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -347,15 +347,24 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
     return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
 }
 
-bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
+bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
+                                         const char *typename, Error **errp)
 {
-    HostIOMMUDevice *hiod = vbasedev->hiod;
+    HostIOMMUDevice *hiod;
 
-    if (!hiod) {
+    if (vbasedev->mdev) {
         return true;
     }
 
-    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
+    hiod = HOST_IOMMU_DEVICE(object_new(typename));
+
+    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
+        object_unref(hiod);
+        return false;
+    }
+
+    vbasedev->hiod = hiod;
+    return true;
 }
 
 VFIODevice *vfio_get_vfio_device(Object *obj)
@@ -372,7 +381,6 @@ bool vfio_device_attach(char *name, VFIODevice *vbasedev,
 {
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
-    HostIOMMUDevice *hiod = NULL;
 
     if (vbasedev->iommufd) {
         ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
@@ -380,19 +388,7 @@ bool vfio_device_attach(char *name, VFIODevice *vbasedev,
 
     assert(ops);
 
-
-    if (!vbasedev->mdev) {
-        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
-        vbasedev->hiod = hiod;
-    }
-
-    if (!ops->attach_device(name, vbasedev, as, errp)) {
-        object_unref(hiod);
-        vbasedev->hiod = NULL;
-        return false;
-    }
-
-    return true;
+    return ops->attach_device(name, vbasedev, as, errp);
 }
 
 void vfio_device_detach(VFIODevice *vbasedev)
@@ -400,6 +396,5 @@ void vfio_device_detach(VFIODevice *vbasedev)
     if (!vbasedev->bcontainer) {
         return;
     }
-    object_unref(vbasedev->hiod);
     VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer)->detach_device(vbasedev);
 }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f273dc87127075e4ff2f3781a49757dfb628da27..8a010a51ea3882ef62fd1906b97ed3b77c5e57ef 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -574,7 +574,8 @@ found_container:
         goto err_listener_register;
     }
 
-    if (!vfio_device_hiod_realize(vbasedev, errp)) {
+    if (!vfio_device_hiod_create_and_realize(vbasedev,
+                     TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
         goto err_hiod_realize;
     }
 
@@ -630,6 +631,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
         iommufd_cdev_ram_block_discard_disable(false);
     }
 
+    object_unref(vbasedev->hiod);
     vfio_cpr_unregister_container(bcontainer);
     iommufd_cdev_detach_container(vbasedev, container);
     iommufd_cdev_container_destroy(container);
-- 
2.49.0


