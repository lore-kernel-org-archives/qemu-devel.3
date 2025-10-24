Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76437CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 02:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC7G0-0004kG-AA; Thu, 23 Oct 2025 22:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vC7Fy-0004k0-Ek
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 22:10:18 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vC7Fw-0006Ox-L2
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 22:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761271816; x=1792807816;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yvlZDmPpw8Fy2Qzy9pBS5ZRAZH5Ep7kV1+63b2utO0A=;
 b=X0KhYmfX9oW694IGboZhFIlwkIsdJjFz2vzN+g9buCW92PLkIkheP2g8
 E4BWSWda1UyYiJcOqGV8xbEEGnA6ApRsFBNmNMkCrStj3cN3P14cyz3/v
 gAw97Pray/Pam1l7DUnuhX0un1bJKbWo4ts/9vfcseAKvbefQaJUI8/90
 /5wyYjgvr6QA4Ray6AH0SpaliX7uomjU3BnSg00UiEQPbxw7qULLPu6X0
 /jft/iyY/QrlMnNHobHzIyBnehZqVw5YOjMG/LqaLdcpYEI6Zt60hZqqV
 BHxthqauQ2RN+mLW75RpDV/ye6OD6wsQco2EBF+iIlb2u752wP6GUUjpT g==;
X-CSE-ConnectionGUID: 12oHaik5S2SyJncc+cPigw==
X-CSE-MsgGUID: 6XdjVYatT0mXS7/DwvDsQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62662165"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="62662165"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 19:10:16 -0700
X-CSE-ConnectionGUID: 0sD7H3JBQzi9nNWXzkEv7A==
X-CSE-MsgGUID: F/JNoluiRUKR/Vka1bf0eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="189440824"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 19:10:12 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Zeng <jason.zeng@intel.com>
Subject: [PATCH v3 8/8] vfio/migration: Allow live migration with vIOMMU
 without VFs using device dirty tracking
Date: Thu, 23 Oct 2025 22:09:22 -0400
Message-ID: <20251024020922.13053-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024020922.13053-1-zhenzhong.duan@intel.com>
References: <20251024020922.13053-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Commit e46883204c38 ("vfio/migration: Block migration with vIOMMU")
introduces a migration blocker when vIOMMU is enabled, because we need
to calculate the IOVA ranges for device dirty tracking. But this is
unnecessary for iommu dirty tracking.

Limit the vfio_viommu_preset() check to those devices which use device
dirty tracking. This allows live migration with VFIO devices which use
iommu dirty tracking.

Introduce a helper vfio_device_dirty_pages_disabled() to facilitate it.

Suggested-by: Jason Zeng <jason.zeng@intel.com>
Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
Tested-by: Rohith S R <rohith.s.r@intel.com>
---
 include/hw/vfio/vfio-device.h | 10 ++++++++++
 hw/vfio/container.c           |  5 +----
 hw/vfio/device.c              |  6 ++++++
 hw/vfio/migration.c           |  6 +++---
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 0fe6c60ba2..a0b8fc2eb6 100644
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
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 7706603c1c..8879da78c8 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -178,10 +178,7 @@ bool vfio_container_devices_dirty_tracking_is_supported(
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
index 8b63e765ac..5ed3103e72 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -411,6 +411,12 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
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
index 44bab024b7..fdfb44fa4f 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1209,8 +1209,7 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-    if ((!vbasedev->dirty_pages_supported ||
-         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) &&
+    if (vfio_device_dirty_pages_disabled(vbasedev) &&
         !vbasedev->iommu_dirty_tracking) {
         if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
             error_setg(&err,
@@ -1228,7 +1227,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
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


