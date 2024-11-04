Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7D1D132BE
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wg4-0005xH-AC; Mon, 04 Nov 2024 07:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7wg3-0005wq-4D
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:59:27 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7wg1-0004jb-32
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730725165; x=1762261165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gC6nFQp8R3EE40xOpE2kJhTT8zrqkLaiPEn+wAgdjdM=;
 b=FbI+23UvWmUUTtWD9qH0pgP5lQpTM9x3h52CWQq/f5qgR/FMTGCzY/Cl
 6Bbn+rjRtz0sgw+91zxfHoFB4JVVguH/3zTh58xj/oy2BsI4Gd6M+QNbG
 hY4ojcrlwndJfF4lNggYmVGchuIej/z2zZT2HsWxP6QTvPO7lX5VNOwmI
 Y5mPtIWnfq+F9bM2WJVpnwXqjVwm/m2gt9QoTt2zfCGF9RYTpMreEERZM
 teJ+wMRWop5zagGxnDN+u+Vi+Ux/DQuAXkvmW9Lu9WmVItXsRcQw0bX1B
 tYHwcSDhDf7sPR5iWQ4NKNU+P90Erx5zPrYpNN+OD9ONq46XCkhX7hRDg Q==;
X-CSE-ConnectionGUID: JI7TZ7YATZCjjEdYxCBWWA==
X-CSE-MsgGUID: 7wc/9NNxRnOwztU/8jU1kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41524695"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="41524695"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 04:59:20 -0800
X-CSE-ConnectionGUID: hyZaN4lbRG6bNm+OmlyNlA==
X-CSE-MsgGUID: OL2KZAhNR2W7amrWDjUg9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; d="scan'208";a="84465243"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 04:59:07 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
Date: Mon,  4 Nov 2024 20:55:35 +0800
Message-Id: <20241104125536.1236118-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

According to VTD spec, a 256-bit descriptor will result in an invalid
descriptor error if submitted in an IQ that is setup to provide hardware
with 128-bit descriptors (IQA_REG.DW=0). Meanwhile, there are old inv desc
types (e.g. iotlb_inv_desc) that can be either 128bits or 256bits. If a
128-bit version of this descriptor is submitted into an IQ that is setup
to provide hardware with 256-bit descriptors will also result in an invalid
descriptor error.

The 2nd will be captured by the tail register update. So we only need to
focus on the 1st.

Because the reserved bit check between different types of invalidation desc
are common, so introduce a common function vtd_inv_desc_reserved_check()
to do all the checks and pass the differences as parameters.

With this change, need to replace error_report_once() call with error_report()
to catch different call sites. This isn't an issue as error_report_once()
here is mainly used to help debug guest error, but it only dumps once in
qemu life cycle and doesn't help much, we need error_report() instead.

Fixes: c0c1d351849b ("intel_iommu: add 256 bits qi_desc support")
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 80 ++++++++++++++++++++++++----------
 2 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 2f9bc0147d..75ccd501b0 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -356,6 +356,7 @@ union VTDInvDesc {
 typedef union VTDInvDesc VTDInvDesc;
 
 /* Masks for struct VTDInvDesc */
+#define VTD_INV_DESC_ALL_ONE            -1ULL
 #define VTD_INV_DESC_TYPE(val)          ((((val) >> 5) & 0x70ULL) | \
                                          ((val) & 0xfULL))
 #define VTD_INV_DESC_CC                 0x1 /* Context-cache Invalidate Desc */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1ecfe47963..2fc3866433 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2532,15 +2532,51 @@ static bool vtd_get_inv_desc(IntelIOMMUState *s,
     return true;
 }
 
+static bool vtd_inv_desc_reserved_check(IntelIOMMUState *s,
+                                        VTDInvDesc *inv_desc,
+                                        uint64_t mask[4], bool dw,
+                                        const char *func_name,
+                                        const char *desc_type)
+{
+    if (s->iq_dw) {
+        if (inv_desc->val[0] & mask[0] || inv_desc->val[1] & mask[1] ||
+            inv_desc->val[2] & mask[2] || inv_desc->val[3] & mask[3]) {
+            error_report("%s: invalid %s desc val[3]: 0x%"PRIx64
+                         " val[2]: 0x%"PRIx64" val[1]=0x%"PRIx64
+                         " val[0]=0x%"PRIx64" (reserved nonzero)",
+                         func_name, desc_type, inv_desc->val[3],
+                         inv_desc->val[2], inv_desc->val[1],
+                         inv_desc->val[0]);
+            return false;
+        }
+    } else {
+        if (dw) {
+            error_report("%s: 256-bit %s desc in 128-bit invalidation queue",
+                         func_name, desc_type);
+            return false;
+        }
+
+        if (inv_desc->lo & mask[0] || inv_desc->hi & mask[1]) {
+            error_report("%s: invalid %s desc: hi=%"PRIx64", lo=%"PRIx64
+                         " (reserved nonzero)", func_name, desc_type,
+                         inv_desc->hi, inv_desc->lo);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 {
-    if ((inv_desc->hi & VTD_INV_DESC_WAIT_RSVD_HI) ||
-        (inv_desc->lo & VTD_INV_DESC_WAIT_RSVD_LO)) {
-        error_report_once("%s: invalid wait desc: hi=%"PRIx64", lo=%"PRIx64
-                          " (reserved nonzero)", __func__, inv_desc->hi,
-                          inv_desc->lo);
+    uint64_t mask[4] = {VTD_INV_DESC_WAIT_RSVD_LO, VTD_INV_DESC_WAIT_RSVD_HI,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
+                                     __func__, "wait")) {
         return false;
     }
+
     if (inv_desc->lo & VTD_INV_DESC_WAIT_SW) {
         /* Status Write */
         uint32_t status_data = (uint32_t)(inv_desc->lo >>
@@ -2574,13 +2610,14 @@ static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
                                            VTDInvDesc *inv_desc)
 {
     uint16_t sid, fmask;
+    uint64_t mask[4] = {VTD_INV_DESC_CC_RSVD, VTD_INV_DESC_ALL_ONE,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
 
-    if ((inv_desc->lo & VTD_INV_DESC_CC_RSVD) || inv_desc->hi) {
-        error_report_once("%s: invalid cc inv desc: hi=%"PRIx64", lo=%"PRIx64
-                          " (reserved nonzero)", __func__, inv_desc->hi,
-                          inv_desc->lo);
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
+                                     __func__, "cc inv")) {
         return false;
     }
+
     switch (inv_desc->lo & VTD_INV_DESC_CC_G) {
     case VTD_INV_DESC_CC_DOMAIN:
         trace_vtd_inv_desc_cc_domain(
@@ -2610,12 +2647,11 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
     uint16_t domain_id;
     uint8_t am;
     hwaddr addr;
+    uint64_t mask[4] = {VTD_INV_DESC_IOTLB_RSVD_LO, VTD_INV_DESC_IOTLB_RSVD_HI,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
 
-    if ((inv_desc->lo & VTD_INV_DESC_IOTLB_RSVD_LO) ||
-        (inv_desc->hi & VTD_INV_DESC_IOTLB_RSVD_HI)) {
-        error_report_once("%s: invalid iotlb inv desc: hi=0x%"PRIx64
-                          ", lo=0x%"PRIx64" (reserved bits unzero)",
-                          __func__, inv_desc->hi, inv_desc->lo);
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
+                                     __func__, "iotlb inv")) {
         return false;
     }
 
@@ -2705,19 +2741,19 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
     hwaddr addr;
     uint16_t sid;
     bool size;
+    uint64_t mask[4] = {VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO,
+                        VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
+                                     __func__, "dev-iotlb inv")) {
+        return false;
+    }
 
     addr = VTD_INV_DESC_DEVICE_IOTLB_ADDR(inv_desc->hi);
     sid = VTD_INV_DESC_DEVICE_IOTLB_SID(inv_desc->lo);
     size = VTD_INV_DESC_DEVICE_IOTLB_SIZE(inv_desc->hi);
 
-    if ((inv_desc->lo & VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO) ||
-        (inv_desc->hi & VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI)) {
-        error_report_once("%s: invalid dev-iotlb inv desc: hi=%"PRIx64
-                          ", lo=%"PRIx64" (reserved nonzero)", __func__,
-                          inv_desc->hi, inv_desc->lo);
-        return false;
-    }
-
     /*
      * Using sid is OK since the guest should have finished the
      * initialization of both the bus and device.
-- 
2.34.1


