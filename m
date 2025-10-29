Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69073CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2tZ-00064U-Ag; Wed, 29 Oct 2025 05:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE2tT-0005yk-Ow
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:55:06 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE2tP-0002n9-Ko
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761731700; x=1793267700;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xIePEUHN6MNvv4wku67sYuOEq8f7ZF75gXyrZc8VzUI=;
 b=J92nKARe5jQgdPPc3ytedfsAT5/76KAEHyukza3vSbk9RJRtgPrw61kJ
 njU8lsbaBdK+rmFoXaP0QEr/bO+ttATqcguID4JZwaBC2O53l9c1XOFYm
 io+w8hdIKTQxEHPzrEKxHbc51VhkT08iGK37tCAx6NOPuCDQwCoC5D7v+
 DQS7aYQr0DAa0rVIw1vItXIq2MSPW0SR2EroSuSAoz4d2YY8JjETK+UlA
 Z8sdoVN6LJS1IP3ACu836WTYN+XzPox3BTSYpn8vo5O2EQnAIuRCmHTn6
 PXySWK93QDJkkrdpkAUhwLfHARVBLs93NCe3Kc05EBLchUBPLo+u/fHG5 A==;
X-CSE-ConnectionGUID: YrK1M4bwTnmLmyjSmVo19w==
X-CSE-MsgGUID: 6+OuHfWxRkSU6Ypfcqq+HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67685157"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="67685157"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:54:57 -0700
X-CSE-ConnectionGUID: qwHPvGZdQHuDEQx821ynHQ==
X-CSE-MsgGUID: Lmf4LWPZR46FbP0wI4dpow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="185529921"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:54:53 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 09/10] vfio/migration: Add migration blocker if VM memory
 is too large to cause unmap_bitmap failure
Date: Wed, 29 Oct 2025 05:53:52 -0400
Message-ID: <20251029095354.56305-10-zhenzhong.duan@intel.com>
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

With default config, kernel VFIO IOMMU type1 driver limits dirty bitmap to
256MB for unmap_bitmap ioctl so the maximum guest memory region is no more
than 8TB size for the ioctl to succeed.

Be conservative here to limit total guest memory to max value supported
by unmap_bitmap ioctl or else add a migration blocker. IOMMUFD backend
doesn't have such limit, one can use IOMMUFD backed device if there is a
need to migration such large VM.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c   |  5 +++++
 hw/vfio/migration.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index ba5c6b6586..8de765c769 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -633,6 +633,11 @@ skip_ioas_alloc:
     QLIST_INIT(&container->hwpt_list);
 
     bcontainer = VFIO_IOMMU(container);
+
+    /* There is no limitation on dirty bitmap size in IOMMUFD */
+    bcontainer->max_dirty_bitmap_size = UINT64_MAX;
+    bcontainer->dirty_pgsizes = qemu_real_host_page_size();
+
     vfio_address_space_insert(space, bcontainer);
 
     if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 3d819eb87e..0a1d8cac2c 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -16,6 +16,7 @@
 #include <sys/ioctl.h>
 
 #include "system/runstate.h"
+#include "hw/boards.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-migration.h"
 #include "migration/misc.h"
@@ -1152,6 +1153,28 @@ static bool vfio_viommu_preset(VFIODevice *vbasedev)
     return vbasedev->bcontainer->space->as != &address_space_memory;
 }
 
+static bool vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
+{
+    VFIOContainer *bcontainer = vbasedev->bcontainer;
+    uint64_t max_size, page_size;
+
+    /*
+     * VFIO IOMMU type1 driver has limitation of bitmap size on unmap_bitmap
+     * ioctl(), calculate the limit and compare with guest memory size to
+     * catch dirty tracking failure early.
+     *
+     * This limit is 8TB with default kernel and QEMU config, we are a bit
+     * conservative here as VM memory layout may be nonconsecutive or VM
+     * can run with vIOMMU enabled so the limitation could be relaxed. One
+     * can also switch to use IOMMUFD backend if there is a need to migrate
+     * large VM.
+     */
+    page_size = 1 << ctz64(bcontainer->dirty_pgsizes);
+    max_size = bcontainer->max_dirty_bitmap_size * BITS_PER_BYTE * page_size;
+
+    return current_machine->ram_size > max_size;
+}
+
 /*
  * Return true when either migration initialized or blocker registered.
  * Currently only return false when adding blocker fails which will
@@ -1194,6 +1217,12 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
 
         warn_report("%s: VFIO device doesn't support device and "
                     "IOMMU dirty tracking", vbasedev->name);
+    } else if (vfio_device_dirty_pages_disabled(vbasedev) &&
+               vfio_dirty_tracking_exceed_limit(vbasedev)) {
+        error_setg(&err, "%s: Migration is currently not supported with large "
+                   "memory VM due to dirty tracking limitation in backend",
+                   vbasedev->name);
+        goto add_blocker;
     }
 
     ret = vfio_block_multiple_devices_migration(vbasedev, errp);
-- 
2.47.1


