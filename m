Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18198C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNU08-0008Gm-V1; Fri, 06 Jun 2025 06:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNU07-0008GY-ST
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:08:39 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNU06-0007c5-1s
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749204518; x=1780740518;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QNfMpmiCptpOxp1FVWJoHoPhLSHGPh7wjkENZaj10Ow=;
 b=HPjcIsWxSCq7r7wT2QfMNlPGWdPM0o0pV9KcU0H/RKLEgoXgj+E/SxAH
 pV9evs1/QrlTUeB5bYYk4eYUPjko2oly0b9Vm7kGdwszlmiYpe87AmWGz
 IWh28YGDGCmPdqjiyGCZFrGqY++doEkSPQhNEYhNPB7J9Nyw+dnuGBFO/
 fCiFZOhbg3BPawLXrHqJvf/1ai41xHdTsRHfdYu4jMBkfxmcDCvidfhUC
 /O49igMrqsOgASOlboEX/xi/Mzw/HzjSchbgIuSlAVpP4gcbrbhROPGNd
 I3G8i60Un+5JLudlzGLUpdRgwzEajJNyen1psLPmt934Q2WLm+QKRy5EC w==;
X-CSE-ConnectionGUID: Up2UxMGhQSeO9u0GmKTe6A==
X-CSE-MsgGUID: IqixyC5wQYau3Dsg/7qr/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="76747228"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="76747228"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:08:37 -0700
X-CSE-ConnectionGUID: l5chEk+gS+CZIC5HSkn68g==
X-CSE-MsgGUID: oe0K35SjSvy0t9hQcQQfUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="146759074"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:08:33 -0700
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
Subject: [PATCH v1 05/15] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Date: Fri,  6 Jun 2025 18:04:06 +0800
Message-Id: <20250606100416.346132-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606100416.346132-1-zhenzhong.duan@intel.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

We already have vtd_find_add_as() to find an AS from BDF+pasid, but this
pasid is passed from PCI subsystem. PCI device supports two request types,
Requests-without-PASID and Requests-with-PASID. Requests-without-PASID
doesn't include a PASID TLP prefix, IOMMU fetches rid_pasid from context
entry and use it as IOMMU's pasid to index pasid table.

So we need to translate between PCI's pasid and IOMMU's pasid specially
for Requests-without-PASID, e.g., PCI_NO_PASID(-1) <-> rid_pasid.
For Requests-with-PASID, PCI's pasid and IOMMU's pasid are same value.

vtd_as_from_iommu_pasid_locked() translates from BDF+iommu_pasid to vtd_as
which contains PCI's pasid vtd_as->pasid.

vtd_as_to_iommu_pasid_locked() translates from BDF+vtd_as->pasid to iommu_pasid.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 796b71605c..112e09e305 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1617,6 +1617,56 @@ static int vtd_as_to_context_entry(VTDAddressSpace *vtd_as, VTDContextEntry *ce)
     }
 }
 
+static inline int vtd_as_to_iommu_pasid_locked(VTDAddressSpace *vtd_as,
+                                               uint32_t *pasid)
+{
+    VTDContextEntry ce;
+    int ret;
+
+    ret = vtd_as_to_context_entry(vtd_as, &ce);
+    if (ret) {
+        return ret;
+    }
+
+    /* Translate to iommu pasid if PCI_NO_PASID */
+    if (vtd_as->pasid == PCI_NO_PASID) {
+        *pasid = VTD_CE_GET_RID2PASID(&ce);
+    } else {
+        *pasid = vtd_as->pasid;
+    }
+
+    return 0;
+}
+
+static gboolean vtd_find_as_by_sid_and_iommu_pasid(gpointer key, gpointer value,
+                                                   gpointer user_data)
+{
+    VTDAddressSpace *vtd_as = (VTDAddressSpace *)value;
+    struct vtd_as_raw_key *target = (struct vtd_as_raw_key *)user_data;
+    uint16_t sid = PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn);
+    uint32_t pasid;
+
+    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
+        return false;
+    }
+
+    return (pasid == target->pasid) && (sid == target->sid);
+}
+
+/* Translate iommu pasid to vtd_as */
+static inline
+VTDAddressSpace *vtd_as_from_iommu_pasid_locked(IntelIOMMUState *s,
+                                                uint16_t sid, uint32_t pasid)
+{
+    struct vtd_as_raw_key key = {
+        .sid = sid,
+        .pasid = pasid
+    };
+
+    return g_hash_table_find(s->vtd_address_spaces,
+                             vtd_find_as_by_sid_and_iommu_pasid, &key);
+}
+
 static int vtd_sync_shadow_page_hook(const IOMMUTLBEvent *event,
                                      void *private)
 {
-- 
2.34.1


