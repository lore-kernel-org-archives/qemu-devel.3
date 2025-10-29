Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31977CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2tH-0005ud-8F; Wed, 29 Oct 2025 05:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE2t7-0005tA-MN
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:54:42 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE2t4-0002mo-SM
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761731679; x=1793267679;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uESL6J226lu7w756/0wvfdMdWkKxtHNzGnOAHbi93zQ=;
 b=E0IrNR0Ur86MQqnpxbZ955LfaUlYakoM7qr7VjHh61MRLveG0dskdtte
 +Dd1exFz1T3SVT5xNFGtwqjxRiqcNxns5M/mRY/6OYlnCl7dsEHjKbY8W
 af64ZFoSQPTXOQfARNI4iR6hwBowonRztL+fvHtQm9fO0NgYW23ZevIkx
 Ik/g6rc8x++dIKzsNgAN/eIfta3KPn58eVIG8XbGMRzvdylD59lpnNAwA
 AbD5/4PXFCLk2Rf4P/zpWAlPfENiVyU6xtJ28qtORXBFnPEnvasovZiQE
 6PEm8KPUOzeEpp6PI+/+6/e8fXOUT2viUxAN42X1UtGcyafdOlsTCUo3G w==;
X-CSE-ConnectionGUID: OXtb9X8ORW6KrsoSBk5snA==
X-CSE-MsgGUID: PB0ZJWAWTYCtUJRxBmhV8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67685134"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="67685134"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:54:37 -0700
X-CSE-ConnectionGUID: OxDBAQWWR72L9TVEsbZTUw==
X-CSE-MsgGUID: crnB1RxVQXWNZ8bKPa3MaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="185529858"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:54:33 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 04/10] vfio: Introduce a helper
 vfio_device_dirty_pages_disabled()
Date: Wed, 29 Oct 2025 05:53:47 -0400
Message-ID: <20251029095354.56305-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251029095354.56305-1-zhenzhong.duan@intel.com>
References: <20251029095354.56305-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
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

Introduce a helper vfio_device_dirty_pages_disabled() to check if device
dirty tracking will be used for a VFIO device. Use it to replace existing
code, it will also be used in subsequent patches.

No functional change intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 include/hw/vfio/vfio-device.h | 10 ++++++++++
 hw/vfio/container.c           |  5 +----
 hw/vfio/device.c              |  6 ++++++
 hw/vfio/migration.c           |  3 +--
 4 files changed, 18 insertions(+), 6 deletions(-)

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
index 9ddec300e3..077eb57304 100644
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
index 4c06e3db93..3d819eb87e 100644
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
-- 
2.47.1


