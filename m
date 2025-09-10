Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC20CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 02:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwAin-00073H-46; Tue, 09 Sep 2025 22:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uwAil-00072p-Fo
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 22:38:07 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uwAif-0005fl-Rf
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 22:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757471881; x=1789007881;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7WAwv9vUQFAur+V3PKq2isaFy9n/1SVHStpDpcXSul8=;
 b=Ekgn2Y9trF9qxDxud49mrHnLZE0gPhXMlqn66vdBweGEyL+mlgesO1Cp
 KTg6EvBi8ZSJ2XzK/LzczB24ygu6+wUAjlVgjfl+ZvM0T7/TcP5zWoMdy
 +Ipwtt0ZRRw0+V2sEP22XntC5ja76s/kBgre2+4QUOoH7RGV2RvOlpU/q
 aEp7mQDpqb8J39bXdelDR97hO4xV3BA8YWQYGbvyainCDK9mUyVKO5hn0
 IlXVD4e/gkvLsa0pR5bKrJxPEzGd0cO7S9O7PiLweg88qt/d5WDMpGOYX
 3C6X1lqrxwPrLETBYRuP+hycgsx4CFxSN//rkZ/F4+O3dKKROaigM31ul g==;
X-CSE-ConnectionGUID: sX8wJ3wpRVSqum6pO8CnVQ==
X-CSE-MsgGUID: 9mqAzyRBQfWATOmB9NYLIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="62402818"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; d="scan'208";a="62402818"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 19:37:48 -0700
X-CSE-ConnectionGUID: 93xHmiL7S9auX+SLpuoK0A==
X-CSE-MsgGUID: /cs5QtL4SNO1hZrywD0y6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; d="scan'208";a="196930595"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 19:37:45 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, mark.gross@intel.com,
 arjan.van.de.ven@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Zeng <jason.zeng@intel.com>
Subject: [PATCH 5/5] vfio/migration: Allow live migration with vIOMMU without
 VFs using device dirty tracking
Date: Tue,  9 Sep 2025 22:37:01 -0400
Message-ID: <20250910023701.244356-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250910023701.244356-1-zhenzhong.duan@intel.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Commit e46883204c38 ("vfio/migration: Block migration with vIOMMU")
introduces a migration blocker when vIOMMU is enabled, because we need
to calculate the IOVA ranges for device dirty tracking. But this is
unnecessary for iommu dirty tracking.

Limit the vfio_viommu_preset() check to those devices which use device
dirty tracking. This allows live migration with VFIO devices which use
iommu dirty tracking.

Introduce a helper vfio_device_dirty_pages_disabled() to facilicate it.

Suggested-by: Jason Zeng <jason.zeng@intel.com>
Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
---
 include/hw/vfio/vfio-device.h | 10 ++++++++++
 hw/vfio/container-base.c      |  5 +----
 hw/vfio/device.c              |  6 ++++++
 hw/vfio/migration.c           |  6 +++---
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 6e4d5ccdac..0c663a49d5 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -148,6 +148,16 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
 
 void vfio_device_reset_handler(void *opaque);
 bool vfio_device_is_mdev(VFIODevice *vbasedev);
+/**
+ * vfio_device_dirty_pages_disabled: Check if device dirty tracking will be
+ * used for a VFIO device
+ *
+ * @vbasedev: The VFIODevice to transform
+ *
+ * Return: true if either @vbasedev doesn't support device dirty tracking or
+ * is forcedly disabled from command line, otherwise false.
+ */
+bool vfio_device_dirty_pages_disabled(VFIODevice *vbasedev);
 bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
                                          const char *typename, Error **errp);
 bool vfio_device_attach(char *name, VFIODevice *vbasedev,
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 56304978e1..39c88812f8 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -177,10 +177,7 @@ bool vfio_container_devices_dirty_tracking_is_supported(
     VFIODevice *vbasedev;
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
-        if (vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) {
-            return false;
-        }
-        if (!vbasedev->dirty_pages_supported) {
+        if (vfio_device_dirty_pages_disabled(vbasedev)) {
             return false;
         }
     }
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 52a1996dc4..d0975e0e40 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -400,6 +400,12 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
     return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
 }
 
+bool vfio_device_dirty_pages_disabled(VFIODevice *vbasedev)
+{
+    return (!vbasedev->dirty_pages_supported ||
+            vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF);
+}
+
 bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
                                          const char *typename, Error **errp)
 {
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 4c06e3db93..810a5cb157 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1183,8 +1183,7 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-    if ((!vbasedev->dirty_pages_supported ||
-         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) &&
+    if (vfio_device_dirty_pages_disabled(vbasedev) &&
         !vbasedev->iommu_dirty_tracking) {
         if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
             error_setg(&err,
@@ -1202,7 +1201,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         goto out_deinit;
     }
 
-    if (vfio_viommu_preset(vbasedev)) {
+    if (!vfio_device_dirty_pages_disabled(vbasedev) &&
+        vfio_viommu_preset(vbasedev)) {
         error_setg(&err, "%s: Migration is currently not supported "
                    "with vIOMMU enabled", vbasedev->name);
         goto add_blocker;
-- 
2.47.1


