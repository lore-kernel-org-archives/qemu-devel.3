Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748FCCCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDQJ-000580-NA; Fri, 24 Oct 2025 04:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDQH-00057S-Mf
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:45:21 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDQA-0006Uo-Ot
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761295515; x=1792831515;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1Uf95f0OPqx561A9lu3za/8GenVH9dQv814u2kwXs+o=;
 b=Z9v1PgrCFPv5Pf8DR/aByJ9sJJkiCZ7SwS20y8qtSOjwC+jC1YOzdiXu
 WILR4QpmsMzd/baKrHsEW+pQr+Y1nCf4ZG6lFnPwqEyA2KvLVasBHyeuA
 PoaZwosZbHs/cVJ8cD5icCHQUZFyBjkw6MQGxNJdS8B1jD74thrERo/UH
 Bqbgns3YESywITKc3LdnGERO8w7gyF+eTjNYmvYFO3o3qnT0wnurt9gAT
 EYZ/yurIJDN4uqN467m/RHqnbM2nzDMc/ZEAcJzXBk3d8aa7TVNTJJ338
 zVdPZVMSWoPlftBNCki5zvqoAoQfBnu3eUD/oFz8pk0ZGQhVTmdIKAtau Q==;
X-CSE-ConnectionGUID: Bq+8SWNyTJauwoOyH7sjlA==
X-CSE-MsgGUID: M2Oxo9GsREC3gFY2bDgQlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62504867"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="62504867"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:14 -0700
X-CSE-ConnectionGUID: HI/upXgFRNC4wwN0j02rXg==
X-CSE-MsgGUID: EAkSC/H/Rsa/co7hZzphtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183985938"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:10 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 10/23] intel_iommu: Check for compatibility with IOMMUFD
 backed device when x-flts=on
Date: Fri, 24 Oct 2025 04:43:34 -0400
Message-ID: <20251024084349.102322-11-zhenzhong.duan@intel.com>
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

When vIOMMU is configured x-flts=on in scalable mode, first stage page table
is passed to host to construct nested page table for passthrough devices.

We need to check compatibility of some critical IOMMU capabilities between
vIOMMU and host IOMMU to ensure guest first stage page table could be used by
host.

For instance, vIOMMU supports first stage 1GB large page mapping, but host does
not, then this IOMMUFD backed device should fail.

Even of the checks pass, for now we willingly reject the association because
all the bits are not there yet, it will be relaxed in the end of this series.

Note vIOMMU has exposed IOMMU_HWPT_ALLOC_NEST_PARENT flag to force VFIO core to
create nesting parent HWPT, if host doesn't support nested translation, the
creation will fail. So no need to check nested capability here.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/i386/intel_iommu.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ce4c54165e..7d908cdb58 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4636,8 +4636,31 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return true;
     }
 
+#ifdef CONFIG_IOMMUFD
+    struct HostIOMMUDeviceCaps *caps = &hiod->caps;
+    struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
+
+    /* Remaining checks are all first stage translation specific */
+    if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
+        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
+        return false;
+    }
+
+    if (caps->type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
+        error_setg(errp, "Incompatible host platform IOMMU type %d",
+                   caps->type);
+        return false;
+    }
+
+    if (s->fs1gp && !(vtd->cap_reg & VTD_CAP_FS1GP)) {
+        error_setg(errp,
+                   "First stage 1GB large page is unsupported by host IOMMU");
+        return false;
+    }
+#endif
+
     error_setg(errp,
-               "host device is uncompatible with first stage translation");
+               "host IOMMU is incompatible with guest first stage translation");
     return false;
 }
 
-- 
2.47.1


