Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57186CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDQB-0004qA-BU; Fri, 24 Oct 2025 04:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDQ9-0004hM-2D
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:45:13 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDQ7-0006Uo-5L
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761295511; x=1792831511;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Inkic57jt8dbvrxZKR7yXdJhp5sXTJj+obwh4c6NNyk=;
 b=BSPq10tSUQ8FN73QqNaI9s44FOEyiHnsHCR7PQzn99k6MGyFsgLdBr8B
 VVDrOWV6KbvrJpFgACR2i39QIHynm8uZWK4n+qMYIRC7D70izSq8CT9fL
 EryDXx66Q2C78Ci5YKN5UP1ZoYcbeb4Saf0ntxlgTHk8MyAHTXrpvPfD7
 JeSf8aV709fxC6LOJHXBQU7Z4HvyLwtB2KNwGh2ogB0WMOkDIpMRAFfiZ
 hxCmOPGeoetOS+jdbZ/poOOTTVtXpW1YXmtJ6fNHFeHWB80DyzbjPDNVB
 nD+bbCQGRqQRg3qvKggz5uoe5wvD1Nga4tLJ+mddSPKjkeLfQ+i7+GDHK g==;
X-CSE-ConnectionGUID: cNhS5+gPQh2YRf6h4RvfkA==
X-CSE-MsgGUID: qH7bjypUTLSyTzVGFwTejw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62504858"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="62504858"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:09 -0700
X-CSE-ConnectionGUID: BhVqrqEdQKSkspzwT1BHoA==
X-CSE-MsgGUID: YcGJoHkGTj+M1Z/r0iCTOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183985915"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:06 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 09/23] intel_iommu: Stick to system MR for IOMMUFD backed
 host device when x-flts=on
Date: Fri, 24 Oct 2025 04:43:33 -0400
Message-ID: <20251024084349.102322-10-zhenzhong.duan@intel.com>
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

When guest enables scalable mode and setup first stage page table, we don't
want to use IOMMU MR but rather continue using the system MR for IOMMUFD
backed host device.

Then default HWPT in VFIO contains GPA->HPA mappings which could be reused
as nesting parent HWPT to construct nested HWPT in vIOMMU.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4c83578c54..ce4c54165e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -41,6 +41,7 @@
 #include "migration/misc.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "system/iommufd.h"
 
 /* context entry operations */
 #define PASID_0    0
@@ -1713,6 +1714,24 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
 
 }
 
+static VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
+{
+    IntelIOMMUState *s = as->iommu_state;
+    struct vtd_as_key key = {
+        .bus = as->bus,
+        .devfn = as->devfn,
+    };
+    VTDHostIOMMUDevice *vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev,
+                                                       &key);
+
+    if (vtd_hiod && vtd_hiod->hiod &&
+        object_dynamic_cast(OBJECT(vtd_hiod->hiod),
+                            TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
+        return vtd_hiod;
+    }
+    return NULL;
+}
+
 static bool vtd_as_pt_enabled(VTDAddressSpace *as)
 {
     IntelIOMMUState *s;
@@ -1738,12 +1757,25 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
 /* Return whether the device is using IOMMU translation. */
 static bool vtd_switch_address_space(VTDAddressSpace *as)
 {
+    IntelIOMMUState *s;
     bool use_iommu, pt;
 
     assert(as);
 
-    use_iommu = as->iommu_state->dmar_enabled && !vtd_as_pt_enabled(as);
-    pt = as->iommu_state->dmar_enabled && vtd_as_pt_enabled(as);
+    s = as->iommu_state;
+    use_iommu = s->dmar_enabled && !vtd_as_pt_enabled(as);
+    pt = s->dmar_enabled && vtd_as_pt_enabled(as);
+
+    /*
+     * When guest enables scalable mode and sets up first stage page table,
+     * we stick to system MR for IOMMUFD backed host device. Then its
+     * default hwpt contains GPA->HPA mappings which is used directly if
+     * PGTT=PT and used as nesting parent if PGTT=FST. Otherwise fall back
+     * to original processing.
+     */
+    if (s->root_scalable && s->fsts && vtd_find_hiod_iommufd(as)) {
+        use_iommu = false;
+    }
 
     trace_vtd_switch_address_space(pci_bus_num(as->bus),
                                    VTD_PCI_SLOT(as->devfn),
-- 
2.47.1


