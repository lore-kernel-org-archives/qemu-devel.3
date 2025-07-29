Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A22C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 09:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uggWw-00051f-HB; Tue, 29 Jul 2025 05:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggWK-0004dX-Vt
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:21:20 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggWI-0002av-TI
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753780875; x=1785316875;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H90IjbHFk/C0B72MY53kb+vMeadxug3mnzm1G5/mZdM=;
 b=W0+C6UOzsxQeQjpJiKjGIIPg0wiJfNOyJli8bAq7fvKB0xIyfLcl/RKH
 Qz90siFB7vhqu+ZKgG2r6bn7gKVVvKgmGKNXNYvvGAmzniVBdP3dncH8b
 4Ll44hv11xRTgoJtopwGkdYv2x0zIy+J+7uloKdG8Anjql0vVXVa1IXjH
 BV323mEa55U59G7LkBZNPHGiCRhatg/ZLMn+ddmO/O7Cy4Cs5aCSVWzZB
 ftRCo0uWxDYyxHCZEdCg8hUePlVBHPnWOBoJWse0XW0sFPWSv4yFzofwZ
 pFzUnMFGN5jODoS4eMEUxULAOaKqys28nBTPDp9R1S2O8MLHYUXadjTtl Q==;
X-CSE-ConnectionGUID: DGxCXqoGRxC7/mb62Owi/Q==
X-CSE-MsgGUID: hAbUzuIiQTygs/rN1Ab/rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55981863"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="55981863"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:21:12 -0700
X-CSE-ConnectionGUID: mFMAsr4KSTqxGDXwzpKcpg==
X-CSE-MsgGUID: qBRVDKr+RRCvZoULea4QLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="162691120"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:21:09 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 03/20] intel_iommu: Implement get_viommu_cap() callback
Date: Tue, 29 Jul 2025 05:20:25 -0400
Message-ID: <20250729092043.785836-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250729092043.785836-1-zhenzhong.duan@intel.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
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

Implement get_viommu_cap() callback and expose stage-1 capability for now.

VFIO uses it to create nested parent domain which is further used to create
nested domain in vIOMMU. All these will be implemented in following patches.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/i386/intel_iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c97953d7a1..178c15e31c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -24,6 +24,7 @@
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
+#include "hw/iommu.h"
 #include "intel_iommu_internal.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
@@ -4420,6 +4421,16 @@ static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
     vtd_iommu_unlock(s);
 }
 
+static uint64_t vtd_get_viommu_cap(void *opaque)
+{
+    IntelIOMMUState *s = opaque;
+    uint64_t caps;
+
+    caps = s->flts ? VIOMMU_CAP_HW_NESTED : 0;
+
+    return caps;
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
@@ -4850,6 +4861,7 @@ static PCIIOMMUOps vtd_iommu_ops = {
     .register_iotlb_notifier = vtd_register_iotlb_notifier,
     .unregister_iotlb_notifier = vtd_unregister_iotlb_notifier,
     .ats_request_translation = vtd_ats_request_translation,
+    .get_viommu_cap = vtd_get_viommu_cap,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
-- 
2.47.1


