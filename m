Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB96ECCF9E5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 02:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC7Fx-0004jy-Pv; Thu, 23 Oct 2025 22:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vC7Fu-0004jF-6k
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 22:10:14 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vC7Fs-0006Ox-GE
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 22:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761271812; x=1792807812;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TsGQjpSaiCigw06ThV1ReigSCAZXU2bwig3p/fdJvxs=;
 b=f322SeSTulOiWKYA2HOYiE8EylVw9EmXw50ozztmiHEQuCstN0MYtN+j
 V0XhwXkG9fAgmsk3/R5f89BruUW5MayeyyH5MS0Y1Dg4a3B3sFy5yYEI7
 s2yO85tnWk3mkjUEBJa3DlRTfI4AzOS7U0EQ29inrTX+7qnf+VcSylU6j
 UD/ysoUb27Atr4HT+MSXyvxOr4M7q4/PwIo/O5FXHAt3nTKOn6jR+nCdG
 Fo4jyMUyEGAWu2Nrp+z+7OPjwvuZR/wBVBjgrVeEN+vFcJN+Ko0VaIhnI
 vYrWwsxdxu9tYd2oU0k3ntDqtGnPTkTtbNlNtauCAq5PvEOv+B4MdQBQC A==;
X-CSE-ConnectionGUID: K9+uPv2mRYebLqpgo6y44g==
X-CSE-MsgGUID: iv5m37B7RdKk/4Vis3lGXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62662161"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="62662161"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 19:10:11 -0700
X-CSE-ConnectionGUID: KaqTwZjoTvyPGItMogb8Mg==
X-CSE-MsgGUID: jtCPdLRNQf+P6HEpaa1qUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="189440810"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 19:10:08 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 7/8] vfio/migration: Add migration blocker if VM memory is
 too large to cause unmap_bitmap failure
Date: Thu, 23 Oct 2025 22:09:21 -0400
Message-ID: <20251024020922.13053-8-zhenzhong.duan@intel.com>
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
 hw/vfio/migration.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

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
index 4c06e3db93..44bab024b7 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -16,6 +16,7 @@
 #include <sys/ioctl.h>
 
 #include "system/runstate.h"
+#include "hw/boards.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-migration.h"
 #include "migration/misc.h"
@@ -1152,6 +1153,31 @@ static bool vfio_viommu_preset(VFIODevice *vbasedev)
     return vbasedev->bcontainer->space->as != &address_space_memory;
 }
 
+static bool vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
+{
+    VFIOContainer *bcontainer = vbasedev->bcontainer;
+    uint64_t max_size, page_size;
+
+    if (!bcontainer->dirty_pages_supported) {
+        return true;
+    }
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
@@ -1208,6 +1234,13 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         goto add_blocker;
     }
 
+    if (vfio_dirty_tracking_exceed_limit(vbasedev)) {
+        error_setg(&err, "%s: Migration is currently not supported with "
+                   "large memory VM due to dirty tracking limitation in "
+                   "VFIO type1 driver", vbasedev->name);
+        goto add_blocker;
+    }
+
     trace_vfio_migration_realize(vbasedev->name);
     return true;
 
-- 
2.47.1


