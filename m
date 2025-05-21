Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E31BC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhUH-00063t-Ts; Wed, 21 May 2025 07:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTt-0005bp-CJ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:19:31 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTn-0006SH-QC
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747826364; x=1779362364;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YCEK4guH+zxZ4cdXjewze95hAdbr9FNgVfo6kAul0Ow=;
 b=EMCKz6fsmEBjixzar8+E4umxOOmClyYXs7igZFkWIUyPLWeCTzKbcBgp
 55qYjmUbfzH6vQj4C8AQ4ZUA/MF6RTibCXiGkG2QeqvKELtFEi0BrCja4
 BKvXMw+crezsUF6mAIpn5rZuwCubpCkaJST2H4Eeg2XR0DrQpetPHxVEV
 ULcWSOE9cycBGX9m3E4izZc8IBgGYFh5MTKrLtxbjdcxOnBBLjvHTEggh
 xSitNbzFi9wHyuYMpq0/GAFZmRs2Y/BL8Ha7H6S0WFUKaeaX5MFp+4iPI
 W00LbBLEd1GnaQmj5r63tu43nAvR6Ai0N4zGeRgLvJOB7CCDPgiszyJru A==;
X-CSE-ConnectionGUID: ONYMm9qCT1mMbjQ0hUN4qA==
X-CSE-MsgGUID: 7Qm/aAMdRoyl2oSn6L5AUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49895006"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49895006"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:19:20 -0700
X-CSE-ConnectionGUID: V/nx36OaSd+4dGB1vpHAXQ==
X-CSE-MsgGUID: muY/OyvSQyq0ZQeII2sSXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145158339"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:19:15 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv3 09/21] intel_iommu: Check for compatibility with IOMMUFD
 backed device when x-flts=on
Date: Wed, 21 May 2025 19:14:39 +0800
Message-Id: <20250521111452.3316354-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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

When vIOMMU is configured x-flts=on in scalable mode, stage-1 page table
is passed to host to construct nested page table. We need to check
compatibility of some critical IOMMU capabilities between vIOMMU and
host IOMMU to ensure guest stage-1 page table could be used by host.

For instance, vIOMMU supports stage-1 1GB huge page mapping, but host
does not, then this IOMMUFD backed device should be failed.

Declare an enum type host_iommu_device_iommu_hw_info_type aliased to
iommu_hw_info_type which comes from iommufd header file. This can avoid
build failure on windows which doesn't support iommufd.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/host_iommu_device.h | 13 +++++++++++
 hw/i386/intel_iommu.c              | 36 ++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index 30da88789d..38070aff09 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -125,5 +125,18 @@ struct HostIOMMUDeviceClass {
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
index a2f3250724..dc839037cf 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -39,6 +39,7 @@
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "system/iommufd.h"
 
 /* context entry operations */
 #define VTD_CE_GET_RID2PASID(ce) \
@@ -4361,6 +4362,41 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return true;
     }
 
+    /* Remaining checks are all stage-1 translation specific */
+    if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
+        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
+        return false;
+    }
+
+    /*
+     * HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE should be supported by different
+     * backend devices, either VFIO or VDPA.
+     */
+    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE, errp);
+    assert(ret >= 0);
+    if (ret != HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_INTEL_VTD) {
+        error_setg(errp, "Incompatible host platform IOMMU type %d", ret);
+        return false;
+    }
+
+    /*
+     * HOST_IOMMU_DEVICE_CAP_NESTING/FS1GP are VTD vendor specific
+     * capabilities, so get_cap() should never fail on them now that
+     * HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_INTEL_VTD type check passed
+     * above.
+     */
+    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_NESTING, errp);
+    if (ret != 1) {
+        error_setg(errp, "Host IOMMU doesn't support nested translation");
+        return false;
+    }
+
+    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_FS1GP, errp);
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


