Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9C0C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWG4f-0000vD-K6; Tue, 23 Jul 2024 10:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG4a-0000dC-Ok
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG4Y-0003h9-Vu
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721743256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y91ZozT8vCYV8W+px3Vnc/F4bnB3yMFeYn7PnIcl820=;
 b=MArgyKnFYoPyPtxiXaIKYR7CKt4WK9tnmUGQA/vdunoCdIjhV/jbKXl3LT0CCCl1FlHQmT
 KI57quDWCyM0IftXJl0TXT2mrJuE3WwyQrSpRzsw2BYFqiAI2fKOjHwcU0eUFvc2i4Nm6+
 1lsjzqNFexSqy+VOzmLEiNCF9mo5x+A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-sXzOYJwuMFm9LaGCSYnc9w-1; Tue,
 23 Jul 2024 10:00:52 -0400
X-MC-Unique: sXzOYJwuMFm9LaGCSYnc9w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51BD21944A89; Tue, 23 Jul 2024 14:00:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.91])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECA291955D4C; Tue, 23 Jul 2024 14:00:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.cm>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 11/16] vfio/{iommufd,
 container}: Invoke HostIOMMUDevice::realize() during attach_device()
Date: Tue, 23 Jul 2024 16:00:14 +0200
Message-ID: <20240723140019.387786-12-clg@redhat.com>
In-Reply-To: <20240723140019.387786-1-clg@redhat.com>
References: <20240723140019.387786-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Joao Martins <joao.m.martins@oracle.com>

Move the HostIOMMUDevice::realize() to be invoked during the attach of the device
before we allocate IOMMUFD hardware pagetable objects (HWPT). This allows the use
of the hw_caps obtained by IOMMU_GET_HW_INFO that essentially tell if the IOMMU
behind the device supports dirty tracking.

Note: The HostIOMMUDevice data from legacy backend is static and doesn't
need any information from the (type1-iommu) backend to be initialized.
In contrast however, the IOMMUFD HostIOMMUDevice data requires the
iommufd FD to be connected and having a devid to be able to successfully
GET_HW_INFO. This means vfio_device_hiod_realize() is called in
different places within the backend .attach_device() implementation.

Suggested-by: Cédric Le Goater <clg@redhat.cm>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
[ clg: Fixed error handling in iommufd_cdev_attach() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/common.c              | 16 ++++++----------
 hw/vfio/container.c           |  4 ++++
 hw/vfio/helpers.c             | 11 +++++++++++
 hw/vfio/iommufd.c             | 11 +++++++++++
 5 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1a96678f8c384e7ff4a1db1e0ba90a5f9624bcff..4e44b26d3c453b5b47a819df371a21a4ca3b39c3 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -242,6 +242,7 @@ void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
 struct vfio_device_info *vfio_get_device_info(int fd);
 bool vfio_device_is_mdev(VFIODevice *vbasedev);
+bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index d7f02be595b5e71558d7e2d75d21d28f05968252..26e74fa430db4c7618698ded5d514d524f33d273 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1536,7 +1536,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 {
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
-    HostIOMMUDevice *hiod;
+    HostIOMMUDevice *hiod = NULL;
 
     if (vbasedev->iommufd) {
         ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
@@ -1544,21 +1544,17 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 
     assert(ops);
 
-    if (!ops->attach_device(name, vbasedev, as, errp)) {
-        return false;
-    }
 
-    if (vbasedev->mdev) {
-        return true;
+    if (!vbasedev->mdev) {
+        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
+        vbasedev->hiod = hiod;
     }
 
-    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
-    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
+    if (!ops->attach_device(name, vbasedev, as, errp)) {
         object_unref(hiod);
-        ops->detach_device(vbasedev);
+        vbasedev->hiod = NULL;
         return false;
     }
-    vbasedev->hiod = hiod;
 
     return true;
 }
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 10cb4b4320ac3d6b3a1da3625e964af5f2f2f9a7..9ccdb639ac84f885da40eace8a0059f397295619 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -914,6 +914,10 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
 
     trace_vfio_attach_device(vbasedev->name, groupid);
 
+    if (!vfio_device_hiod_realize(vbasedev, errp)) {
+        return false;
+    }
+
     group = vfio_get_group(groupid, as, errp);
     if (!group) {
         return false;
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 7e23e9080c9d2860dea51ca5ef5fbc840d42a32d..ea15c79db0a3643f260fc1ce3abfeaa7001ab306 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -689,3 +689,14 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
     subsys = realpath(tmp, NULL);
     return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
 }
+
+bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
+{
+    HostIOMMUDevice *hiod = vbasedev->hiod;
+
+    if (!hiod) {
+        return true;
+    }
+
+    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index fb87e64e443035bc239f4f4272ae1c28fa8ab8c9..798c4798a55e0c839c5128b3cd9571356157dce9 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -404,6 +404,17 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     space = vfio_get_address_space(as);
 
+    /*
+     * The HostIOMMUDevice data from legacy backend is static and doesn't need
+     * any information from the (type1-iommu) backend to be initialized. In
+     * contrast however, the IOMMUFD HostIOMMUDevice data requires the iommufd
+     * FD to be connected and having a devid to be able to successfully call
+     * iommufd_backend_get_device_info().
+     */
+    if (!vfio_device_hiod_realize(vbasedev, errp)) {
+        goto err_alloc_ioas;
+    }
+
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
-- 
2.45.2


