Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37693C021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfQB-0005YT-UL; Wed, 19 Feb 2025 03:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQ4-0005Xg-KC
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:00 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQ2-0004bS-0K
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953618; x=1771489618;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YkKG3U4URwqi/DdDGTpyXo93ZK+iuSB6xF85FkczKCU=;
 b=RVdSvWdHBtbKnpDz0ExFOrBGCi8srG4tmN6jRUtgbFUnJPm6rkr4mcWR
 x3oN4IOMw2ImHodOZxZFdHvjOPNH0BtCVCHEwpFIIzNhP35lEglQ+CA9u
 1Usmm/+Nf17br/L/L0RmFIk2Sda0uCNK/pmp1EpgpL5r/EuN9BHGsdszu
 mGLs8l9esLceTkj15dGrE2ZscvIcHCMRgLJeMAUs/93sMJyj523GwdqhQ
 Mmqc1Rw4n01+LsGtzZCB2hJNi/dRO+nLhYvhJnaRgrl8uzuVaFhG/0nk6
 Kkkjg+kQUeolxYk+IzFnWIyckJn5ZI9MS6tpbyRWZ0e2k0RBeeygw/FLM w==;
X-CSE-ConnectionGUID: 8aSCvewAR76oUfh7CYoVnA==
X-CSE-MsgGUID: Mf0PcxSjRtG0rbOKut6MnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544177"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544177"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:57 -0800
X-CSE-ConnectionGUID: 6pA7Z+QOTtyNUZOvEhlqZg==
X-CSE-MsgGUID: 1zxlyqKPSpi0XiQUr3ShiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119851135"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:51 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv2 11/20] intel_iommu: Check for compatibility with IOMMUFD
 backed device when x-flts=on
Date: Wed, 19 Feb 2025 16:22:19 +0800
Message-Id: <20250219082228.3303163-12-zhenzhong.duan@intel.com>
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

When vIOMMU is configured x-flts=on in scalable mode, stage-1 page table
is passed to host to construct nested page table. We need to check
compatibility of some critical IOMMU capabilities between vIOMMU and
host IOMMU to ensure guest stage-1 page table could be used by host.

For instance, vIOMMU supports stage-1 1GB huge page mapping, but host
does not, then this IOMMUFD backed device should be failed.

Declare an enum type host_iommu_device_iommu_hw_info_type aliased to
iommu_hw_info_type which come from iommufd header file. This can avoid
build failure on windows which doesn't support iommufd.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/host_iommu_device.h | 13 ++++++++++++
 hw/i386/intel_iommu.c              | 34 ++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index 250600fc1d..aa3885d7ee 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -133,5 +133,18 @@ struct HostIOMMUDeviceClass {
 #define HOST_IOMMU_DEVICE_CAP_FS1GP             3
 #define HOST_IOMMU_DEVICE_CAP_ERRATA            4
 
+/**
+ * enum host_iommu_device_iommu_hw_info_type - IOMMU Hardware Info Types
+ * @HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not
+ *                                             report hardware info
+ * @HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
+ *
+ * This is alias to enum iommu_hw_info_type but for general purpose.
+ */
+enum host_iommu_device_iommu_hw_info_type {
+    HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_NONE,
+    HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_INTEL_VTD,
+};
+
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
 #endif
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7709f55be5..9de60e607d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -39,6 +39,7 @@
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "system/iommufd.h"
 
 /* context entry operations */
 #define VTD_CE_GET_RID2PASID(ce) \
@@ -4346,6 +4347,39 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return true;
     }
 
+    /* Remaining checks are all stage-1 translation specific */
+    if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
+        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
+        return false;
+    }
+
+    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE, errp);
+    if (ret < 0) {
+        return false;
+    }
+    if (ret != HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_INTEL_VTD) {
+        error_setg(errp, "Incompatible host platform IOMMU type %d", ret);
+        return false;
+    }
+
+    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_NESTING, errp);
+    if (ret < 0) {
+        return false;
+    }
+    if (ret != 1) {
+        error_setg(errp, "Host IOMMU doesn't support nested translation");
+        return false;
+    }
+
+    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_FS1GP, errp);
+    if (ret < 0) {
+        return false;
+    }
+    if (s->fs1gp && ret != 1) {
+        error_setg(errp, "Stage-1 1GB huge page is unsupported by host IOMMU");
+        return false;
+    }
+
     error_setg(errp, "host device is uncompatible with stage-1 translation");
     return false;
 }
-- 
2.34.1


