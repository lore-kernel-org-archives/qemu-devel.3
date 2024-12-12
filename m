Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845E6E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLemK-0005Ua-SV; Thu, 12 Dec 2024 03:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLely-0004ur-BL
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:42:15 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLelw-00084H-J7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733992932; x=1765528932;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kQzJEKx7pni1gSbM/vSf080p+1QxWOxDD9RrJTtDelU=;
 b=jmm3qz/wl8vYLgwAF17LMk1HTwXUaMDsESGY97oBnQUbBkDX4Wi+/TKt
 ItExYF5gfiogL+P85cNODQJ/x3shZxoU1rRKvAel82U3uuu2Ytsjneam1
 LrZE4ulGhg82DU01BxkBS5xQ73b1Fr9L8rdaujwgurr/vR8I1NwMgdLG4
 Co6Pg+/ak6C1TJltraM4NPfh9C+6MaOpDpgZOAMlwduRV1wWPpVR+mAJh
 QjCAzwkW749ZQSJBL0UqNUsfmO/bKebhdSRK4HHflL1qm7sP/TmJFeZGG
 /YrPPamc16+jGLtJlHxF+z99p0PHIVkLk0mO8d95LzOHRm9pWHvMSD3ze A==;
X-CSE-ConnectionGUID: Jw6wJXy2SlCNWK2aAa2lww==
X-CSE-MsgGUID: b4l1AqlmTdaM4kihTS1ERA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34124976"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="34124976"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:42:11 -0800
X-CSE-ConnectionGUID: e61gsTKIRy+mG1IHu+DGDA==
X-CSE-MsgGUID: bM8prFmzSSu0bwZoa0znLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119407135"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:42:06 -0800
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
Subject: [PATCH v6 13/20] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
Date: Thu, 12 Dec 2024 16:37:50 +0800
Message-Id: <20241212083757.605022-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212083757.605022-1-zhenzhong.duan@intel.com>
References: <20241212083757.605022-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 11 ++++++++
 hw/i386/intel_iommu.c          | 50 ++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 5e4e563e62..2c977aa7da 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -385,6 +385,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Descriptor */
 #define VTD_INV_DESC_PIOTLB             0x6 /* PASID-IOTLB Invalidate Desc */
 #define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate Desc */
+#define VTD_INV_DESC_DEV_PIOTLB         0x8 /* PASID-based-DIOTLB inv_desc*/
 #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descriptor */
 
 /* Masks for Invalidation Wait Descriptor*/
@@ -426,6 +427,16 @@ typedef union VTDInvDesc VTDInvDesc;
 /* Masks for Interrupt Entry Invalidate Descriptor */
 #define VTD_INV_DESC_IEC_RSVD           0xffff000007fff1e0ULL
 
+/* Masks for PASID based Device IOTLB Invalidate Descriptor */
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_ADDR(val) ((val) & \
+                                                   0xfffffffffffff000ULL)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_SIZE(val) ((val >> 11) & 0x1)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_GLOBAL(val) ((val) & 0x1)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(val) (((val) >> 16) & 0xffffULL)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_PASID(val) ((val >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_VAL0 0xfff000000000f000ULL
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_VAL1 0x7feULL
+
 /* Rsvd field masks for spte */
 #define VTD_SPTE_SNP 0x800ULL
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index bf18c83e69..68f1808945 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3075,6 +3075,49 @@ static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
     memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
 }
 
+static bool vtd_process_device_piotlb_desc(IntelIOMMUState *s,
+                                           VTDInvDesc *inv_desc)
+{
+    uint16_t sid;
+    VTDAddressSpace *vtd_dev_as;
+    bool size;
+    bool global;
+    hwaddr addr;
+    uint32_t pasid;
+    uint64_t mask[4] = {VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_VAL0,
+                        VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_VAL1,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, true,
+                                     __func__, "device piotlb inv")) {
+        return false;
+    }
+
+    global = VTD_INV_DESC_PASID_DEVICE_IOTLB_GLOBAL(inv_desc->hi);
+    size = VTD_INV_DESC_PASID_DEVICE_IOTLB_SIZE(inv_desc->hi);
+    addr = VTD_INV_DESC_PASID_DEVICE_IOTLB_ADDR(inv_desc->hi);
+    sid = VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(inv_desc->lo);
+    if (global) {
+        QLIST_FOREACH(vtd_dev_as, &s->vtd_as_with_notifiers, next) {
+            if ((vtd_dev_as->pasid != PCI_NO_PASID) &&
+                (PCI_BUILD_BDF(pci_bus_num(vtd_dev_as->bus),
+                                           vtd_dev_as->devfn) == sid)) {
+                do_invalidate_device_tlb(vtd_dev_as, size, addr);
+            }
+        }
+    } else {
+        pasid = VTD_INV_DESC_PASID_DEVICE_IOTLB_PASID(inv_desc->lo);
+        vtd_dev_as = vtd_get_as_by_sid_and_pasid(s, sid, pasid);
+        if (!vtd_dev_as) {
+            return true;
+        }
+
+        do_invalidate_device_tlb(vtd_dev_as, size, addr);
+    }
+
+    return true;
+}
+
 static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
                                           VTDInvDesc *inv_desc)
 {
@@ -3161,6 +3204,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+    case VTD_INV_DESC_DEV_PIOTLB:
+        trace_vtd_inv_desc("device-piotlb", inv_desc.hi, inv_desc.lo);
+        if (!vtd_process_device_piotlb_desc(s, &inv_desc)) {
+            return false;
+        }
+        break;
+
     case VTD_INV_DESC_DEVICE:
         trace_vtd_inv_desc("device", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_device_iotlb_desc(s, &inv_desc)) {
-- 
2.34.1


