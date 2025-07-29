Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C07CC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 09:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uggXd-0006CW-I8; Tue, 29 Jul 2025 05:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggWj-0004tg-56
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:21:44 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggWg-0002cx-AK
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753780898; x=1785316898;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GUC4RzUWGM5tKjt/0JFvAk6Xt3JqGlvpzu1w06idpMk=;
 b=U2arzrCgN5JJfScWW/jJf/iGvcs2Qvl0S+klT10YZ00ODvgmp0zd9yaJ
 JkMl/5lo0RfinGuyp3ePuC1G0GtaA5kn+nLcmjqjgZh+HclPZtkny2g4E
 bEghp1KRetnm0Mml+pE1KfC/7V+RMdvluvUzEqMgzua+qQV04WiqUOH+2
 eKPVTtKPy/etMticSf+8TKlF4ZppvBFdL6NQZvv0fGjyqII5gadWD3YGN
 MEU4VQzXHP0loVTUXxyT/Z2t9i2pxJaLE2tuSJZGPNkqzZX22g+i4gy0o
 nhQgJgWvRmXXm1fIwKUU4otaWv9G0g0xAdtddcuK0EUYAcgGEwyy92AoA w==;
X-CSE-ConnectionGUID: 7wlvZJvpRqKW74CmBFDPVw==
X-CSE-MsgGUID: C7gbUcSETyKlV7nHIJQG7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55981927"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="55981927"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:21:37 -0700
X-CSE-ConnectionGUID: IBAv/ouMQtuOz3ZZGKBKfQ==
X-CSE-MsgGUID: DkbTSSJKRGqv1LiyHYSYFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="162691278"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:21:33 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 09/20] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Date: Tue, 29 Jul 2025 05:20:31 -0400
Message-ID: <20250729092043.785836-10-zhenzhong.duan@intel.com>
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

PCI device supports two request types, Requests-without-PASID and
Requests-with-PASID. Requests-without-PASID doesn't include a PASID TLP
prefix, IOMMU fetches rid_pasid from context entry and use it as IOMMU's
pasid to index pasid table.

So we need to translate between PCI's pasid and IOMMU's pasid specially
for Requests-without-PASID, e.g., PCI_NO_PASID(-1) <-> rid_pasid.
For Requests-with-PASID, PCI's pasid and IOMMU's pasid are same value.

vtd_as_from_iommu_pasid_locked() translates from BDF+iommu_pasid to vtd_as
which contains PCI's pasid vtd_as->pasid.

vtd_as_to_iommu_pasid_locked() translates from BDF+vtd_as->pasid to iommu_pasid.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/i386/intel_iommu.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1410ddd65e..eb0e799e4a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1602,6 +1602,64 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
     return 0;
 }
 
+static int vtd_as_to_iommu_pasid_locked(VTDAddressSpace *vtd_as,
+                                        uint32_t *pasid)
+{
+    VTDContextCacheEntry *cc_entry = &vtd_as->context_cache_entry;
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    uint8_t bus_num = pci_bus_num(vtd_as->bus);
+    uint8_t devfn = vtd_as->devfn;
+    VTDContextEntry ce;
+    int ret;
+
+    /* For Requests-with-PASID, its pasid value is used by vIOMMU directly */
+    if (vtd_as->pasid != PCI_NO_PASID) {
+        *pasid = vtd_as->pasid;
+        return 0;
+    }
+
+    if (cc_entry->context_cache_gen == s->context_cache_gen) {
+        ce = cc_entry->context_entry;
+    } else {
+        ret = vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    *pasid = VTD_CE_GET_RID2PASID(&ce);
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
2.47.1


