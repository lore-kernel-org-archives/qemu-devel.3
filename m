Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC56EE020B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 05:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soFsT-0003nb-PP; Wed, 11 Sep 2024 01:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soFsS-0003ds-1A
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:26:52 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soFsQ-0004Mp-63
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726032410; x=1757568410;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZwKp+8eHtxXPB4bOM2qK/aeQYA/KH0gqZOePfTEvkaQ=;
 b=nZB3pGTfDONywerjeN0Nr4ZXmRFAWWcQZUzCJVR+B//hNxhQSunyIIdg
 sxcTfWes7yAilHg0ihfmBf3A4qhrE67F/viHSXL/QRhSXNLIx8QGw+7XS
 DMgsXs9KEYvb75USz5SBFdoRL5TmDvW34HbwCaYBsxHViKxXkoas334kV
 jBa913lXhoEyX6oU+i5ClXMd9RvQnn4flR9cDwrQtVb5+xKrcFliiHAv0
 HAK5d7EzcQS14PyQNYXV6p8mihtkJpxN+9uurXtOMmMtZuC0KIJqgQ1Ex
 rc43IxLwDk/pttqVLzfLAKXGrp5KYzeWEjn0JJPX0Y89oDG26RNsQpw1T g==;
X-CSE-ConnectionGUID: qFpkx+cwThihmi51/hBCbQ==
X-CSE-MsgGUID: nO/KdsUMTMOm1/dfW9hU0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35403596"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="35403596"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 22:26:50 -0700
X-CSE-ConnectionGUID: z0Xoax1LT32dbKs2oHuT3w==
X-CSE-MsgGUID: 0a3R6sZYS9+URHIvux5f7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="67536504"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 22:26:45 -0700
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
Subject: [PATCH v3 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
Date: Wed, 11 Sep 2024 13:22:50 +0800
Message-Id: <20240911052255.1294071-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
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

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h | 11 ++++++++
 hw/i386/intel_iommu.c          | 50 ++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 4f2c3a9350..52bdbf3bc5 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -375,6 +375,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Descriptor */
 #define VTD_INV_DESC_PIOTLB             0x6 /* PASID-IOTLB Invalidate Desc */
 #define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate Desc */
+#define VTD_INV_DESC_DEV_PIOTLB         0x8 /* PASID-based-DIOTLB inv_desc*/
 #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descriptor */
 
 /* Masks for Invalidation Wait Descriptor*/
@@ -413,6 +414,16 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
 
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
index d28c862598..4cf56924e1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3017,6 +3017,49 @@ static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
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
@@ -3111,6 +3154,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
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


