Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A1FCA0FE4
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 06:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upLTU-00083i-DP; Fri, 22 Aug 2025 02:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLTS-000820-3B
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:42:06 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLTQ-0000lZ-1b
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755844924; x=1787380924;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=n1AYY9sLKpZLVrmwGwJBs088FA6QHkXkQvSnpeX3C4U=;
 b=X+0aOYHeXB70tl98g2AT3AplHnWdyCqlJ+KQfz5I+/bopLlHnPP64YB1
 tWWa1A7fbxIuw44yfmaEkpXlqUzCGqAKaBt02tIPvs2CLjmTzeh8e61gb
 mmAOfYvnmA4dGLPuNmVZBQCF+PtJmpcAeL9+EmfrA+vageqXqtbz0dJb4
 VsFXyuCvXjqGIh90Fk/0sQGIBFMr7HI8BPD1ofL+tGfU0W3l9DpnGfYFC
 iu2IkpDk67yUCZvVkoCgOJaddBlAshx3zVNPNBOeMg231ogAjpUoTYwT2
 QCytz1Vp3woRA9sqCt0K0Ym6d8NEP28jUpcjKH63zRwJyl2BHBXSSqMaQ A==;
X-CSE-ConnectionGUID: QAhBRx/NSg2CUR6a4jGKPg==
X-CSE-MsgGUID: GYB5IdWGRpSk4Qe3PwPJWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68851910"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="68851910"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:42:03 -0700
X-CSE-ConnectionGUID: 7DKYZpbRRuK4w8HiP2rIcA==
X-CSE-MsgGUID: 3gIMtUioSBWT8QA29iveuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="168244963"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:41:59 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 10/21] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Date: Fri, 22 Aug 2025 02:40:48 -0400
Message-ID: <20250822064101.123526-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250822064101.123526-1-zhenzhong.duan@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
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
index 6edd91d94e..1801f1cdf6 100644
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


