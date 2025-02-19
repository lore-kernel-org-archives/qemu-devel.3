Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BC0C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfPq-0005W6-SX; Wed, 19 Feb 2025 03:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPo-0005VT-5w
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:44 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPl-0004bS-U0
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953602; x=1771489602;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fAmvZPigYvBGTxKieocJue8kt2n1eYxTq2NEydSanWg=;
 b=EDVvb0fN8DmWph4H72G4C0rW6F6nMI0VpuphJBDWMmuBpAJcDOJ1CGtf
 9Q/7+NQTT+tG+DKZiAhXkiB7+8vSZY73nc8ck8M7HaORs4LyJarPlUyvi
 Ukf72rPIZdWd7xDO+LCV3kyBa8clAHibJNwK+qvYU8WzcDU3p3DvAK6wP
 QWvgJYN5wAWK6woDhplpObK5WKvR6DwhMAnajig196LkE1mMbYV2lcwbh
 TBUBzCqlQlWBg0oI6VBPuxY4uLl3X22tEFQ07QpiTZ7Hc8TQWDN/vsGpE
 FrYQRuj+nNpeyUBvomcUw7UXXwQoVLBL89OSDI9ZatL4Nko/auKPpKssI w==;
X-CSE-ConnectionGUID: EH7fJzaqRMG/Odhe2PkEfA==
X-CSE-MsgGUID: LaYrINppQJSqHisw4jfQsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544139"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544139"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:41 -0800
X-CSE-ConnectionGUID: mDGEis9XTrexhxxEbRd71w==
X-CSE-MsgGUID: /aVnDjqzSRuFAEj7y7MIFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119851075"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:37 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 08/20] iommufd: Implement query of
 HOST_IOMMU_DEVICE_CAP_ERRATA
Date: Wed, 19 Feb 2025 16:22:16 +0800
Message-Id: <20250219082228.3303163-9-zhenzhong.duan@intel.com>
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

Implement query of HOST_IOMMU_DEVICE_CAP_ERRATA for IOMMUFD
backed host IOMMU device.

Query on this capability is not supported for legacy backend
because there is no plan to support nesting with leacy backend
backed host device.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/host_iommu_device.h | 2 ++
 backends/iommufd.c                 | 2 ++
 hw/vfio/iommufd.c                  | 1 +
 3 files changed, 5 insertions(+)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index 18f8b5e5cf..250600fc1d 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -32,6 +32,7 @@ typedef struct HostIOMMUDeviceCaps {
     uint64_t hw_caps;
     bool nesting;
     bool fs1gp;
+    uint32_t errata;
 } HostIOMMUDeviceCaps;
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
@@ -130,6 +131,7 @@ struct HostIOMMUDeviceClass {
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS           1
 #define HOST_IOMMU_DEVICE_CAP_NESTING           2
 #define HOST_IOMMU_DEVICE_CAP_FS1GP             3
+#define HOST_IOMMU_DEVICE_CAP_ERRATA            4
 
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 0a1a40cbba..3c23caef96 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -374,6 +374,8 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
         return caps->nesting;
     case HOST_IOMMU_DEVICE_CAP_FS1GP:
         return caps->fs1gp;
+    case HOST_IOMMU_DEVICE_CAP_ERRATA:
+        return caps->errata;
     default:
         error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
         return -EINVAL;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index df6a12d200..58bff030e1 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -848,6 +848,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     case IOMMU_HW_INFO_TYPE_INTEL_VTD:
         caps->nesting = !!(data.vtd.ecap_reg & VTD_ECAP_NEST);
         caps->fs1gp = !!(data.vtd.cap_reg & VTD_CAP_FS1GP);
+        caps->errata = data.vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
         break;
     case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
     case IOMMU_HW_INFO_TYPE_NONE:
-- 
2.34.1


