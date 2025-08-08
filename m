Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C17C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 04:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukEQH-0004u1-Qm; Fri, 08 Aug 2025 00:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ukEQD-0004eP-1i
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 00:09:37 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ukEQB-0001Bo-0P
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 00:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754626175; x=1786162175;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xSUtEfTsL+H3cTGiHvaDa44K2TBtSyViTSdD4eoF76E=;
 b=KoJ8lZYRnm7pUx3S7vTrsCsZNzMiRZydvnqeRekgS4huQTZFGQeL3no3
 cTJUjVy7/oTjIap8IVH0oYu1TIJnuigtfy8Ge9MQwbvsqp43IOPqMENDN
 Dol76VQcK//yovxiC8eO5OorqoAfF1Fevujqld96OuC0KTbLsk7gvw0aO
 hQVLY42CjVTbJ28kO3FdHM8RYMl78DHPKLgHsVjbtMH4cPJQRU0aCu8M3
 KsUfDh6/U019jZ4VbEKPummD9JYaAUOLdMK8Om15e6sihqghsNuhNZLC3
 3y6yZ/bhE56TDXD9+Py+/U4jZK7NOPOY7BStqiiOcXGv6lnBG8gE2kRoH A==;
X-CSE-ConnectionGUID: rGVvXrUcR7KLJlZWRP0AXQ==
X-CSE-MsgGUID: LHVIo4XyRbChtBxkvQMPoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67669043"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="67669043"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 21:09:31 -0700
X-CSE-ConnectionGUID: W9wHz2WiTKS1DpHVlG01gg==
X-CSE-MsgGUID: O7MZKLNeTeeI/A/+lQAorg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="165253556"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 21:09:30 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, joao.m.martins@oracle.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] vfio: Allow live migration with VFIO devices which use iommu
 dirty tracking
Date: Fri,  8 Aug 2025 00:09:14 -0400
Message-ID: <20250808040914.19837-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Commit e46883204c38 ("vfio/migration: Block migration with vIOMMU")
introduces a migration blocker when vIOMMU is enabled, because we need
to calculate the IOVA ranges for device dirty tracking. But this is
unnecessary for iommu dirty tracking.

Limit the vfio_viommu_preset() check to those devices which use device
dirty tracking. This allows live migration with VFIO devices which use
iommu dirty tracking.

Introduce a helper vfio_device_dirty_pages_disabled() to facilicate it.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
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
index 08f12ac31f..7a5f249826 100644
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


