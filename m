Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19E2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhUK-0006Ax-Ks; Wed, 21 May 2025 07:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTy-0005g1-3M
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:19:35 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTv-0006SH-2l
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747826371; x=1779362371;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=862Qrq6B7llxG2ZyH9VLUzo299XP08WrrJYfUF8rJdk=;
 b=nUrSQsdpuGSBj0knEYlE+IcR541sihcc6fYeDXaaMp4OiVciV0YY6j1o
 Im/ONZkkm+prlW7EXx0+eeWjzSzFOpTz9XLB02Kd3EJrH1RQ2lxVfNOMI
 IbE5RKriZI4BGTE9N3BmYZ2g0JjnLQXeoBIaktMMpcOdEQVtyP2XjHXyi
 rHvrNb8TkyZ0eKgCnVHafjfAwH4SQ1VJO2uIs/kV6RcpyTgRwxFhJ/NfS
 vLQfYs7iHZFTl+VYu6a8hi0Gf88xoQamxBVfYcTPF3gr7esB3EWFzrKIm
 6ZgPMjhZfmr0CCssYECnBx2ARIblPwrFI8FI5MDDhr9nP/jdLCutN5kQa w==;
X-CSE-ConnectionGUID: +CNA5HCrTquXAejolCfsng==
X-CSE-MsgGUID: 6nGupY3hQSSKnC1NTHBRgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49895051"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49895051"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:19:30 -0700
X-CSE-ConnectionGUID: H/IATk6pQqi88aKum8Wryw==
X-CSE-MsgGUID: WPl/cR6aTHKeGk92xtjWng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145158346"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:19:25 -0700
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
Subject: [PATCH rfcv3 11/21] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Date: Wed, 21 May 2025 19:14:41 +0800
Message-Id: <20250521111452.3316354-12-zhenzhong.duan@intel.com>
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
index b2ea109c7c..a9c0bd5021 100644
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


