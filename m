Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3440D2E9C2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 08:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAPxk-0006r9-CD; Mon, 11 Nov 2024 03:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPws-0004wi-36
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:39:02 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPwq-0003UY-H1
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731314340; x=1762850340;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xwrDb5BN2s7CX5mFDAARzkjX1Zpeq2dXuxYz9mZaSDI=;
 b=n0d1Y4dTfFVBtVhYm4uLrBvC6ju9kN4qeHkYFU4KD8WlGNmiMkVMBF8d
 /21acl6Lgg788H04e5F/i+ATv9QQD/90zRo2tHcjnT2bDQ4kCE49mUIbU
 EIwr+m//v5ooUP/JFTmQxucbupkXmgdcaVz5vPvRUJ7vkvysUs2aaJZAK
 ugYySKl7V2TIQ1KbKIN0pnm5Te3fve8GyywGFIjjmDtRaIrCPnjwZ+wJX
 Hp0jyUIUowZ3Q8R0pcFrpGyNY33pzmukbfPzpD8aB0zbco4p3ZuYS+qOF
 up2dx7Hq7ykUj4kYdI5LwggWdB53/8JiWX2ptMoGxnLyCq8xYMArL2vwy Q==;
X-CSE-ConnectionGUID: 0BRsW6o+TKWKr/b+l+QcuA==
X-CSE-MsgGUID: V8NVETUYSnGA0MMiHXob5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31334494"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="31334494"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:39:00 -0800
X-CSE-ConnectionGUID: N5If6k25Raagm1EUYxmS0A==
X-CSE-MsgGUID: aV+F4SUAQc+bY1mW0yVsZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="87608336"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:56 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 12/20] intel_iommu: Add an internal API to find an address
 space with PASID
Date: Mon, 11 Nov 2024 16:34:49 +0800
Message-Id: <20241111083457.2090664-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

This will be used to implement the device IOTLB invalidation

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 71ef5d741a..599d017b18 100644
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
@@ -1859,29 +1864,32 @@ static inline bool vtd_is_interrupt_addr(hwaddr addr)
     return VTD_INTERRUPT_ADDR_FIRST <= addr && addr <= VTD_INTERRUPT_ADDR_LAST;
 }
 
-static gboolean vtd_find_as_by_sid(gpointer key, gpointer value,
-                                   gpointer user_data)
+static gboolean vtd_find_as_by_sid_and_pasid(gpointer key, gpointer value,
+                                             gpointer user_data)
 {
     struct vtd_as_key *as_key = (struct vtd_as_key *)key;
-    uint16_t target_sid = *(uint16_t *)user_data;
+    struct vtd_as_raw_key *target = (struct vtd_as_raw_key *)user_data;
     uint16_t sid = PCI_BUILD_BDF(pci_bus_num(as_key->bus), as_key->devfn);
-    return sid == target_sid;
+
+    return (as_key->pasid == target->pasid) && (sid == target->sid);
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


