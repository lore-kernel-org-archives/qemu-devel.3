Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35BDC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMNF-0000TW-4H; Thu, 18 Jul 2024 04:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMND-0000MI-8x
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:20:23 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMN9-0008Uz-Jt
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721290820; x=1752826820;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wqfLVl6CB1F3hQdtOd2KjA5CA92lkiF+PhPKdMsecZg=;
 b=fOpZKRjf6rD9gpgzdHIiim8YunBt9MgIPPsP9I3mZZ6mn7obmKJ1gHWy
 hZ0S2jT7udIB7Oyd6qnj/fcDyBYrmy6BUi8xdF0vQJYQz2QbyuBvQG1NM
 PK/0KYC9LaNWytJxxhKfz657wgFgCTWMI+xtV2xxPOZfr7+eOU6FDhFTT
 UN6ZZIns57CZCBZSFBiteXgXMh1+PgHWw3S2Ww+JBPiQhGW4PzCpVRec4
 hOPNXMXD01l6DmAcLru4ODMCwM410K/sxtQTONpWS9CgViFb+xWEOl9TH
 hwpOQ4kTO2tieCk8Kfv6q0qbNgCEBpHK9sH1IyfMPMzGSk312Vc75yEpk Q==;
X-CSE-ConnectionGUID: iyXqES8HR4mzw+WsIJh2/w==
X-CSE-MsgGUID: UBuz942nTgiI/Bqfa6oVZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29996381"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="29996381"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:20:18 -0700
X-CSE-ConnectionGUID: c2HBP+B4TgG9QiTStCFpEA==
X-CSE-MsgGUID: ZGczPPdAQn2Or7i6+Sbyuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="81717490"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:20:14 -0700
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
Subject: [PATCH v1 13/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
Date: Thu, 18 Jul 2024 16:16:32 +0800
Message-Id: <20240718081636.879544-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718081636.879544-1-zhenzhong.duan@intel.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index 7dd8176e86..ed358aa763 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -377,6 +377,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Descriptor */
 #define VTD_INV_DESC_PIOTLB             0x6 /* PASID-IOTLB Invalidate Desc */
 #define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate Desc */
+#define VTD_INV_DESC_DEV_PIOTLB         0x8 /* PASID-based-DIOTLB inv_desc*/
 #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descriptor */
 
 /* Masks for Invalidation Wait Descriptor*/
@@ -420,6 +421,16 @@ typedef union VTDInvDesc VTDInvDesc;
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
index a17ce2b1f1..8b66d6cfa5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3016,6 +3016,49 @@ static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
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
@@ -3110,6 +3153,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
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


