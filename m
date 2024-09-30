Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36419CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCjp-0002PL-RR; Mon, 30 Sep 2024 05:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svCjk-00029P-3a
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:30:36 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svCjg-000759-TY
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727688633; x=1759224633;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tN9YMZp1tfxoGEW1iXDop2n32WieujyyUjL+UuYiCkM=;
 b=bLoWGpl7yuVtks9CX2ZnK7usXfVj1avFKBNtOcpl1U3H637+LyXrZffp
 W3TUBgJCL2LsIjf2U3yCLo53Y+q6p64GoM+jWzFO+i+fgLlliueOIFXgT
 YcJmHJp8bMldnGdt3pB0bnCWYOO8AiL8Lpnbs8R3kpVr2qmh0V6zjczTf
 ON0rcR/OJvRjbPvOcBYwoZA/c3muGVE8yz/JtabIkWtYWKr06b5gazw2g
 9KH/n+S6hux2tsUr0Cb+tEI4tD9y5Eb3wlOJLJdH/fzBkTLjm6gneIyTa
 A8Ac68uwaIQGhWIsn9oVDqIJzGG+DQ5EkyXC/sCiH9jJ1HaPJ9mEF+ZaN Q==;
X-CSE-ConnectionGUID: wqFaKs3LQESk2o1LAZRUUQ==
X-CSE-MsgGUID: w7icyubjQMquIdFlD2WUdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26721835"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="26721835"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 02:30:32 -0700
X-CSE-ConnectionGUID: K7hadIoITS2fINvwPAR2Jw==
X-CSE-MsgGUID: XjaeZGj0Q3y50JCwz2gtVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="77749869"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 02:30:27 -0700
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
Subject: [PATCH v4 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
Date: Mon, 30 Sep 2024 17:26:26 +0800
Message-Id: <20240930092631.2997543-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h | 11 ++++++++
 hw/i386/intel_iommu.c          | 50 ++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 20d922d600..2702edd27f 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -376,6 +376,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Descriptor */
 #define VTD_INV_DESC_PIOTLB             0x6 /* PASID-IOTLB Invalidate Desc */
 #define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate Desc */
+#define VTD_INV_DESC_DEV_PIOTLB         0x8 /* PASID-based-DIOTLB inv_desc*/
 #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descriptor */
 
 /* Masks for Invalidation Wait Descriptor*/
@@ -414,6 +415,16 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0f1f0
 
+/* Mask for PASID Device IOTLB Invalidate Descriptor */
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_ADDR(val) ((val) & \
+                                                   0xfffffffffffff000ULL)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_SIZE(val) ((val >> 11) & 0x1)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_GLOBAL(val) ((val) & 0x1)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(val) (((val) >> 16) & 0xffffULL)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_PASID(val) ((val >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_HI 0x7feULL
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_LO 0xfff000000000f000ULL
+
 /* Rsvd field masks for spte */
 #define VTD_SPTE_SNP 0x800ULL
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a1596ba47d..5ea59167b3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3020,6 +3020,49 @@ static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
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
+
+    if ((inv_desc->hi & VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_HI) ||
+         (inv_desc->lo & VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_LO)) {
+        error_report_once("%s: invalid pasid-based dev iotlb inv desc:"
+                          "hi=%"PRIx64 "(reserved nonzero)",
+                          __func__, inv_desc->hi);
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
@@ -3106,6 +3149,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
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


