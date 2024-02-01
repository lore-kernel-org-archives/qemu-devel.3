Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DCAC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRYJ-0007ke-Gh; Thu, 01 Feb 2024 02:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRYA-0006qH-Jl
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:31:58 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRY4-0001kb-Lv
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772708; x=1738308708;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Wif64BZtnQFnyitRvIJHnqYL2A3FK/+JPBbzKxxW/VY=;
 b=Tmy11YyoTBAel9Vv2+XctvkcXI7jCPpsRvE1CYKyU5jHlZI7y3UcKvqu
 /kD1D0nUBitZZlAK3z9OcX/TIAQ4lUWgXwo9JVATMjbmIczsPLuqxdEZT
 cdUXEKmtaQvOhjLjHHgO0QMPE8VAHldxFqqJycT0QSkkzpAb2vbyCftli
 JlL0mkFsWJ73uc3YmITIJaVeSuECDfGpmxoEMjg+R93Ih3huE91EYb0+Z
 vOIHwql97k7K9MSSS4N4k+j13ujaOaTXNLxWvnm93QZ+3TJQtFmmY5yqR
 siqU1JxFtAhwUDQRaetCoSSr75nPVV2X+C3bb+FS5sET3XnrghEZXfZpw A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402676948"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402676948"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:31:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443395"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:31:34 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv2 16/18] intel_iommu: Implement check and sync mechanism
 in iommufd mode
Date: Thu,  1 Feb 2024 15:28:16 +0800
Message-Id: <20240201072818.327930-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201072818.327930-1-zhenzhong.duan@intel.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We use cap_frozen to mark cap/ecap read/writable or read-only,
At init stage, we allow to update cap/ecap based on host IOMMU
cap/ecap, but when machine create done, cap_frozen is set and
we only allow checking cap/ecap for compatibility.

Currently only stage-2 translation is supported which is backed by
shadow page table on host side. So we don't need exact matching of
each bit of cap/ecap between vIOMMU and host. However, we can still
ensure compatibility of host and vIOMMU's address width at least,
i.e., vIOMMU's mgaw <= host IOMMU mgaw, which is missed before.

When stage-1 translation is supported in future, a.k.a. scalable
modern mode, this mechanism will be further extended to check more
bits.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 include/hw/i386/intel_iommu.h  |  1 +
 hw/i386/intel_iommu.c          | 29 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 3301f54b35..33d2298dce 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -206,6 +206,7 @@
 #define VTD_DOMAIN_ID_MASK          ((1UL << VTD_DOMAIN_ID_SHIFT) - 1)
 #define VTD_CAP_ND                  (((VTD_DOMAIN_ID_SHIFT - 4) / 2) & 7ULL)
 #define VTD_ADDRESS_SIZE(aw)        (1ULL << (aw))
+#define VTD_CAP_MGAW_MASK           (0x3fULL << 16)
 #define VTD_CAP_MGAW(aw)            ((((aw) - 1) & 0x3fULL) << 16)
 #define VTD_MAMV                    18ULL
 #define VTD_CAP_MAMV                (VTD_MAMV << 48)
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index c71a133820..a0b530ebc6 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -47,6 +47,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
 #define VTD_HOST_AW_48BIT           48
 #define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
 #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
+#define VTD_MGAW_FROM_CAP(cap)      (((cap >> 16) & 0x3fULL) + 1)
 
 #define DMAR_REPORT_F_INTR          (1)
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7ed2b79669..409f8a59c3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -35,6 +35,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/iommufd.h"
 #include "hw/i386/apic_internal.h"
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
@@ -3830,6 +3831,34 @@ static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
                                   IOMMUFDDevice *idev,
                                   Error **errp)
 {
+    struct iommu_hw_info_vtd vtd;
+    enum iommu_hw_info_type type = IOMMU_HW_INFO_TYPE_INTEL_VTD;
+    long host_mgaw, viommu_mgaw = VTD_MGAW_FROM_CAP(s->cap);
+    uint64_t tmp_cap = s->cap;
+    int ret;
+
+    ret = iommufd_device_get_info(idev, &type, sizeof(vtd), &vtd, errp);
+    if (ret) {
+        return ret;
+    }
+
+    if (type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
+        error_setg(errp, "IOMMU hardware is not compatible");
+        return -EINVAL;
+    }
+
+    host_mgaw = VTD_MGAW_FROM_CAP(vtd.cap_reg);
+    if (viommu_mgaw > host_mgaw) {
+        if (s->cap_frozen) {
+            error_setg(errp, "mgaw %" PRId64 " > host mgaw %" PRId64,
+                       viommu_mgaw, host_mgaw);
+            return -EINVAL;
+        }
+        tmp_cap &= ~VTD_CAP_MGAW_MASK;
+        tmp_cap |= VTD_CAP_MGAW(host_mgaw + 1);
+    }
+
+    s->cap = tmp_cap;
     return 0;
 }
 
-- 
2.34.1


