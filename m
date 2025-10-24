Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5502CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDRG-0006Vo-FJ; Fri, 24 Oct 2025 04:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDQz-0006GV-6j
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:46:06 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDQw-0006cN-MS
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761295563; x=1792831563;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TEdLr2vhXunVdkhiq1E3hxObvwui4fsdaQTvn1KoYi0=;
 b=nA95oMKwSKSln4GMeYXvewttlDTuTb0M1kLFZTZS5/6m0eztq5WbOQdb
 6Lk2UVcfF0ICQbzPouDZGlTEm6vVuvwbknuHroX3okzGXvmF9CIcdgmy6
 aZ3z+8mhhoEE83A47+Qs65m6DovQSDDX31XKDc5CpQu9Nprijz0nOEpar
 ktt0K66aQa61dI2XVTR4hS2yiSQoFikFomo0va4y+Hli3VgeGMRaoRHnB
 BoVNVJ9S1gsBVK+aMawa1GyL2UjikFyEFfCBOHZsy5DwFyC6Bq8f7bEIU
 pbiP7HhlNrNJ+fPN0vrSfHfzu/k6/tbtqtJkfWZwz6+nG3CvyfrK8+oGo A==;
X-CSE-ConnectionGUID: MwRMsvKrRnWWtSKpW8fCzg==
X-CSE-MsgGUID: np89MgNtQxKiCi0gdSKvIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62504902"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="62504902"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:51 -0700
X-CSE-ConnectionGUID: 4eiDRfRCRqG65079pOissQ==
X-CSE-MsgGUID: z+2oXKaFQuCr5WH9tBxtGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183986050"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:47 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 19/23] Workaround for ERRATA_772415_SPR17
Date: Fri, 24 Oct 2025 04:43:43 -0400
Message-ID: <20251024084349.102322-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024084349.102322-1-zhenzhong.duan@intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
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

On a system influenced by ERRATA_772415, IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the readonly
range mapped on second stage page table could still be written.

Reference from 4th Gen Intel Xeon Processor Scalable Family Specification
Update, Errata Details, SPR17.
https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/eagle-stream/sapphire-rapids-specification-update/

Also copied the SPR17 details from above link:
"Problem: When remapping hardware is configured by system software in
scalable mode as Nested (PGTT=011b) and with PWSNP field Set in the
PASID-table-entry, it may Set Accessed bit and Dirty bit (and Extended
Access bit if enabled) in first-stage page-table entries even when
second-stage mappings indicate that corresponding first-stage page-table
is Read-Only.

Implication: Due to this erratum, pages mapped as Read-only in second-stage
page-tables may be modified by remapping hardware Access/Dirty bit updates.

Workaround: None identified. System software enabling nested translations
for a VM should ensure that there are no read-only pages in the
corresponding second-stage mappings."

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f9d0926274..f9da0e79cc 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -15,6 +15,7 @@
 #include <linux/vfio.h>
 #include <linux/iommufd.h>
 
+#include "hw/iommu.h"
 #include "hw/vfio/vfio-device.h"
 #include "qemu/error-report.h"
 #include "trace.h"
@@ -351,6 +352,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
     uint32_t type, flags = 0;
     uint64_t hw_caps;
+    VendorCaps caps;
     VFIOIOASHwpt *hwpt;
     uint32_t hwpt_id;
     int ret;
@@ -396,7 +398,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      * instead.
      */
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
-                                         &type, NULL, 0, &hw_caps, errp)) {
+                                         &type, &caps, sizeof(caps), &hw_caps,
+                                         errp)) {
         return false;
     }
 
@@ -411,6 +414,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      */
     if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
         flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
+
+        if (host_iommu_extract_quirks(type, &caps) &
+            HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO) {
+            bcontainer->bypass_ro = true;
+        }
     }
 
     if (cpr_is_incoming()) {
-- 
2.47.1


