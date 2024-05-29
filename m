Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A209C27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCM7V-0001wn-4V; Wed, 29 May 2024 12:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM6y-0001BQ-IV
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:14 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM6v-0006KZ-D3
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:12 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1sCM6i-006COk-V7;
 Wed, 29 May 2024 17:24:56 +0100
From: John Levon <levon@movementarian.org>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jag.raman@oracle.com,
 thanos.makatos@nutanix.com, John Levon <john.levon@nutanix.com>
Subject: [PATCH 05/26] vfio: add vfio_prepare_device()
Date: Wed, 29 May 2024 17:22:58 +0100
Message-Id: <20240529162319.1476680-6-levon@movementarian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529162319.1476680-1-levon@movementarian.org>
References: <20240529162319.1476680-1-levon@movementarian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: John Levon <john.levon@nutanix.com>

Commonize some initialization code shared by the legacy and iommufd vfio
implementations (and later by vfio-user).

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/common.c              | 19 +++++++++++++++++++
 hw/vfio/container.c           | 14 +-------------
 hw/vfio/iommufd.c             |  9 +--------
 include/hw/vfio/vfio-common.h |  2 ++
 4 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 8c3b6ad75a..81f4c88f2d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1542,6 +1542,25 @@ retry:
     return info;
 }
 
+void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+                         VFIOGroup *group, struct vfio_device_info *info)
+{
+    vbasedev->group = group;
+
+    vbasedev->num_irqs = info->num_irqs;
+    vbasedev->num_regions = info->num_regions;
+    vbasedev->flags = info->flags;
+    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
+
+    vbasedev->bcontainer = bcontainer;
+    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
+    if (group) {
+        QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
+    }
+
+    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+}
+
 bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
                                       VFIODevice *vbasedev, AddressSpace *as,
                                       Error **errp)
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 27ddb894e9..1bbcbaa874 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -881,17 +881,11 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
     }
 
     vbasedev->fd = fd;
-    vbasedev->group = group;
-    QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
 
-    vbasedev->num_irqs = info->num_irqs;
-    vbasedev->num_regions = info->num_regions;
-    vbasedev->flags = info->flags;
+    vfio_prepare_device(vbasedev, &group->container->bcontainer, group, info);
 
     trace_vfio_get_device(name, info->flags, info->num_regions, info->num_irqs);
 
-    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
-
     return true;
 }
 
@@ -944,7 +938,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     int groupid = vfio_device_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
-    VFIOContainerBase *bcontainer;
 
     if (groupid < 0) {
         return false;
@@ -969,11 +962,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         return false;
     }
 
-    bcontainer = &group->container->bcontainer;
-    vbasedev->bcontainer = bcontainer;
-    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
-    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
-
     return true;
 }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 7bcadacd0b..dad83e45d7 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -425,14 +425,7 @@ found_container:
         iommufd_cdev_ram_block_discard_disable(false);
     }
 
-    vbasedev->group = 0;
-    vbasedev->num_irqs = dev_info.num_irqs;
-    vbasedev->num_regions = dev_info.num_regions;
-    vbasedev->flags = dev_info.flags;
-    vbasedev->reset_works = !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESET);
-    vbasedev->bcontainer = bcontainer;
-    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
-    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+    vfio_prepare_device(vbasedev, bcontainer, NULL, &dev_info);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 8e13d30d2c..ee022c9cbd 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -223,6 +223,8 @@ void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
 struct vfio_device_info *vfio_get_device_info(int fd);
+void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+                         VFIOGroup *group, struct vfio_device_info *info);
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
 bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
-- 
2.34.1


