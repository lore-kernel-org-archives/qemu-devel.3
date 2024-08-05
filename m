Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17759C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 06:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sarFa-0003fY-Ru; Mon, 05 Aug 2024 02:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarFP-00033R-VE
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:31:15 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarFN-0002As-L0
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722839469; x=1754375469;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7FKPsNxVa+rQoT4fL8eP4XHT0WdjEShcvYbsGsA1oeY=;
 b=mJTxjdPMh9W6NfgftgR8pFcN7eTKmRHIAQcOF27gbJCrC/G176HQgqat
 TEPLsG7++wGtsvZ2KuMuVfhtm/YCLH1FU1FEvNwX5wk0TvcuCF77DhPpU
 sOprQa9gd3TTZu8FbhAJl5zmL+okdkMiG9U6FE4CghssI4cLagr/u5fM6
 k0oZqJBVTQzNnUlB4uEzCcDEqktG9VSqE0PzcAwRqjI2C4xmAksp24q7B
 BpJHbaad4zXiTKxqXEqA5sHV2Td+agLTbQkejKVPyFhER1PwYhfcxwc+S
 uRUQ2bomxm0fJbQsrcaBbP4qRgfrjkND/yyWBd4okCI0e9W34R+ylXOIx g==;
X-CSE-ConnectionGUID: fV8/9XnGTuij3CoTEo4D2g==
X-CSE-MsgGUID: P/vlUr8xQoqdQBTUdoekcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="38282777"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="38282777"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:31:00 -0700
X-CSE-ConnectionGUID: AOw0hgq2QwiZy9dSEscQKQ==
X-CSE-MsgGUID: uMCm1aV5TLWakQftVDWx6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="56786917"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:55 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 11/17] intel_iommu: Add an internal API to find an address
 space with PASID
Date: Mon,  5 Aug 2024 14:27:21 +0800
Message-Id: <20240805062727.2307552-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

This will be used to implement the device IOTLB invalidation

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1bedb65bd8..5e4f22cd1d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -70,6 +70,11 @@ struct vtd_hiod_key {
     uint8_t devfn;
 };
 
+struct vtd_as_raw_key {
+    uint16_t sid;
+    uint32_t pasid;
+};
+
 struct vtd_iotlb_key {
     uint64_t gfn;
     uint32_t pasid;
@@ -1875,29 +1880,33 @@ static inline bool vtd_is_interrupt_addr(hwaddr addr)
     return VTD_INTERRUPT_ADDR_FIRST <= addr && addr <= VTD_INTERRUPT_ADDR_LAST;
 }
 
-static gboolean vtd_find_as_by_sid(gpointer key, gpointer value,
-                                   gpointer user_data)
+static gboolean vtd_find_as_by_sid_and_pasid(gpointer key, gpointer value,
+                                             gpointer user_data)
 {
     struct vtd_as_key *as_key = (struct vtd_as_key *)key;
-    uint16_t target_sid = *(uint16_t *)user_data;
+    struct vtd_as_raw_key target = *(struct vtd_as_raw_key *)user_data;
     uint16_t sid = PCI_BUILD_BDF(pci_bus_num(as_key->bus), as_key->devfn);
-    return sid == target_sid;
+
+    return (as_key->pasid == target.pasid) &&
+           (sid == target.sid);
 }
 
-static VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
+static VTDAddressSpace *vtd_get_as_by_sid_and_pasid(IntelIOMMUState *s,
+                                                    uint16_t sid,
+                                                    uint32_t pasid)
 {
-    uint8_t bus_num = PCI_BUS_NUM(sid);
-    VTDAddressSpace *vtd_as = s->vtd_as_cache[bus_num];
-
-    if (vtd_as &&
-        (sid == PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn))) {
-        return vtd_as;
-    }
+    struct vtd_as_raw_key key = {
+        .sid = sid,
+        .pasid = pasid
+    };
 
-    vtd_as = g_hash_table_find(s->vtd_address_spaces, vtd_find_as_by_sid, &sid);
-    s->vtd_as_cache[bus_num] = vtd_as;
+    return g_hash_table_find(s->vtd_address_spaces,
+                             vtd_find_as_by_sid_and_pasid, &key);
+}
 
-    return vtd_as;
+static VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
+{
+    return vtd_get_as_by_sid_and_pasid(s, sid, PCI_NO_PASID);
 }
 
 static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id)
-- 
2.34.1


