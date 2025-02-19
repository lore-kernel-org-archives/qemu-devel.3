Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2544C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfPo-0005VS-5X; Wed, 19 Feb 2025 03:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPl-0005V0-93
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:41 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPi-0004bS-Pq
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953599; x=1771489599;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5YWhRrVeEhH3CktmhBAgaRZUYzH0H93Jc1vO/aXiBcc=;
 b=I6gw4OHgofd0gjSp2uR9ZGbFWI70eX9IDs2aJUG0m5CXgu50L3b//Tdl
 nypcytG9z7WtQvMLLAHA7e3JtLnPhoGwDc6xUqXW+n23CpeB27Y6ppSnb
 3JVSVqoGBKWUryKGr17Ujjw4GucLxV8JEqEx8hCk0uRWhOc/CWXxPTJH+
 ZH6Xtm2gD290v22g4k6NaWXoUZu6a/eHRDrnuseMFwTWqUGO+0KGbypz6
 t628VdVGa6LI7oKt/aE3JzPV7TwrdZ4pnO0Q19dOBoaaIpnD6Kife7R+a
 Qzo6AYb3W/lCcnYw0CUnM57g8QpHXv4i0IasBInupHAyjaQ/ZaQts5dQE Q==;
X-CSE-ConnectionGUID: 5w7ZRfY6QjKPTZUihaIPBQ==
X-CSE-MsgGUID: f8uXy9M3Rf2olP/acYULMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544128"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544128"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:37 -0800
X-CSE-ConnectionGUID: wwxKKnOtRKqw2quFCqXQpQ==
X-CSE-MsgGUID: ZLg8sdTPSjSYAzVPi7K6sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119851069"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:32 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv2 07/20] iommufd: Implement query of
 HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
Date: Wed, 19 Feb 2025 16:22:15 +0800
Message-Id: <20250219082228.3303163-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Implement query of HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP] for IOMMUFD
backed host IOMMU device.

Query on these two capabilities is not supported for legacy backend
because there is no plan to support nesting with leacy backend backed
host device.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 backends/iommufd.c             |  4 ++++
 hw/vfio/iommufd.c              | 11 +++++++++++
 3 files changed, 16 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index e8b211e8b0..2cda744786 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -191,6 +191,7 @@
 #define VTD_ECAP_PT                 (1ULL << 6)
 #define VTD_ECAP_SC                 (1ULL << 7)
 #define VTD_ECAP_MHMV               (15ULL << 20)
+#define VTD_ECAP_NEST               (1ULL << 26)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 574f330c27..0a1a40cbba 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -370,6 +370,10 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
         return caps->type;
     case HOST_IOMMU_DEVICE_CAP_AW_BITS:
         return vfio_device_get_aw_bits(hiod->agent);
+    case HOST_IOMMU_DEVICE_CAP_NESTING:
+        return caps->nesting;
+    case HOST_IOMMU_DEVICE_CAP_FS1GP:
+        return caps->fs1gp;
     default:
         error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
         return -EINVAL;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 175c4fe1f4..df6a12d200 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -26,6 +26,7 @@
 #include "qemu/chardev_open.h"
 #include "pci.h"
 #include "exec/ram_addr.h"
+#include "hw/i386/intel_iommu_internal.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
@@ -843,6 +844,16 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     caps->type = type;
     caps->hw_caps = hw_caps;
 
+    switch (type) {
+    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
+        caps->nesting = !!(data.vtd.ecap_reg & VTD_ECAP_NEST);
+        caps->fs1gp = !!(data.vtd.cap_reg & VTD_CAP_FS1GP);
+        break;
+    case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
+    case IOMMU_HW_INFO_TYPE_NONE:
+        break;
+    }
+
     return true;
 }
 
-- 
2.34.1


