Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC196C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW5m-0005ZW-I2; Fri, 20 Jun 2025 03:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5l-0005UD-DW
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:17 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5j-0008IS-Bq
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404195; x=1781940195;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hNjzVaKFCwVRuZP8JnfjtysWXGQfahRUN8nIqfws418=;
 b=B+oW3iPCvWipmzi5fHLGjoZgAKd2gY7YDCIyfJ4r98V92EJ9GPwOHGXJ
 +7+2Lo6mRAYby2d6bLWESGaJ288krM1tt1nhiqZLvejSN/hWhVk2hBle2
 kKnZliNNl4mrRwrnL0lkljgIJjLFo2uPsNQobat3Bv0yrQi9trayN+0ym
 QW6u8/M1dM2ZhJ71WB7vVovHQJNwOYioIy5eSxn9JUQas7AhR4n9KHznl
 +3YDZYDSJe2QvfWZlv2SR1ZwXJgGf8IgE333t3FFI97iYdjfNmGHWp/FT
 wRGhh2p0++nxT2cirFQY6yfTzuzZ4tcIA4Ewmm88qtaWyV6hy3Tq/Td8b g==;
X-CSE-ConnectionGUID: g0l/CgSXS4C5vYrBmxkGTQ==
X-CSE-MsgGUID: DfCVYx3BQ1aSItcb1iwt2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532461"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532461"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:14 -0700
X-CSE-ConnectionGUID: XOVQaZ//S92lWRLy7pib5g==
X-CSE-MsgGUID: HDUdy+GqS66P8xtUvp1o9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863251"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:10 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 13/19] intel_iommu: Stick to system MR for IOMMUFD backed
 host device when x-fls=on
Date: Fri, 20 Jun 2025 15:18:07 +0800
Message-Id: <20250620071813.55571-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

When guest in scalable mode and x-flts=on, we stick to system MR for IOMMUFD
backed host device. Then its default hwpt contains GPA->HPA mappings which is
used directly if PGTT=PT and used as nested parent if PGTT=FLT. Otherwise
fallback to original processing.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ed71bb8ec7..be01f8885f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1779,6 +1779,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
              */
             return false;
         }
+
         return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
     }
 
@@ -1790,10 +1791,33 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
 {
     IntelIOMMUState *s;
     VTDContextEntry ce;
+    struct vtd_as_key key = {
+        .bus = as->bus,
+        .devfn = as->devfn,
+    };
 
     assert(as);
 
     s = as->iommu_state;
+
+    /*
+     * When guest in scalable mode and x-flts=on, we stick to system MR
+     * for IOMMUFD backed host device. Then its default hwpt contains
+     * GPA->HPA mappings which is used directly if PGTT=PT and used as
+     * nested parent if PGTT=FLT. Otherwise fallback to original
+     * processing.
+     */
+     if (s->root_scalable && s->flts) {
+        VTDHostIOMMUDevice *vtd_hiod;
+
+        vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
+        if (vtd_hiod && vtd_hiod->hiod &&
+            object_dynamic_cast(OBJECT(vtd_hiod->hiod),
+                                TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
+            return true;
+        }
+    }
+
     if (vtd_dev_to_context_entry(s, pci_bus_num(as->bus), as->devfn,
                                  &ce)) {
         /*
-- 
2.34.1


