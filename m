Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A7FC25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fQj-0004gO-3t; Wed, 22 May 2024 02:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQN-0004ds-G7
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:07 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQL-0006eK-Hi
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716359165; x=1747895165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+nja1FsyQjlZ15iCQFoLofuev/SaDnUyHRaMOK5gZk0=;
 b=jKusiLQg+Lm964LHjVe2J+I1qd2GCeKxLXqNI+mVoH5bleS5zL6GfujS
 7zBcX3nBph61ydK8O/czziVzXoJIbrguIApNwrvxNfQ9tCGO2sZ0bYcJp
 czEmUwB6X+TCYqKQQ5wB77iyICAbAjdpwi6Ivx9cbCb8t/nTJcUSc4sGU
 732oPVu1XTVXzUzAHvwSvOYqc3uqTu/8RE9LV/6u2edFobdBP5w/p/x0T
 aAxATWKkdGE2JckHRwUxVriR8AsshwafIxXAKX+kusz3j/2Hr46T0/JwP
 BJa27BG9urExnc17jZju0ipcWDFjSKxpatPxCzVUD8La8z5PNU3HFc6NE A==;
X-CSE-ConnectionGUID: 5kQrgRn/RhSv6S4nWB9+bQ==
X-CSE-MsgGUID: BS9m9c9CQw+83uVhIQGEbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37972460"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="37972460"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:04 -0700
X-CSE-ConnectionGUID: 6eSDi8hkTyadN/WjyGPM2Q==
X-CSE-MsgGUID: yoOIUQCKTu6Ybuv/RxoEMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33597634"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:25:59 -0700
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
Subject: [PATCH rfcv2 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Date: Wed, 22 May 2024 14:22:59 +0800
Message-Id: <20240522062313.453317-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522062313.453317-1-zhenzhong.duan@intel.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
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

Add an new element scalable_mode in IntelIOMMUState to mark scalable
modern mode, this element will be exposed as an intel_iommu property
finally.

For now, it's only a placehholder and used for cap/ecap initialization,
compatibility check and block host device passthrough until nesting
is supported.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  2 ++
 include/hw/i386/intel_iommu.h  |  1 +
 hw/i386/intel_iommu.c          | 37 ++++++++++++++++++++++++----------
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 955bc24787..75aea80942 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -196,6 +196,7 @@
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SLTS               (1ULL << 46)
+#define VTD_ECAP_FLTS               (1ULL << 47)
 
 /* CAP_REG */
 /* (offset >> 4) << 24 */
@@ -212,6 +213,7 @@
 #define VTD_CAP_SLLPS               ((1ULL << 34) | (1ULL << 35))
 #define VTD_CAP_DRAIN_WRITE         (1ULL << 54)
 #define VTD_CAP_DRAIN_READ          (1ULL << 55)
+#define VTD_CAP_FS1GP               (1ULL << 56)
 #define VTD_CAP_DRAIN               (VTD_CAP_DRAIN_READ | VTD_CAP_DRAIN_WRITE)
 #define VTD_CAP_CM                  (1ULL << 7)
 #define VTD_PASID_ID_SHIFT          20
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 2bbde41e45..9ba9c45015 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -263,6 +263,7 @@ struct IntelIOMMUState {
 
     bool caching_mode;              /* RO - is cap CM enabled? */
     bool scalable_mode;             /* RO - is Scalable Mode supported? */
+    bool scalable_modern;           /* RO - is modern SM supported? */
     bool snoop_control;             /* RO - is SNP filed supported? */
 
     dma_addr_t root;                /* Current root table pointer */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 348e3a441e..6d1d94ada3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -738,16 +738,20 @@ static inline bool vtd_is_level_supported(IntelIOMMUState *s, uint32_t level)
 }
 
 /* Return true if check passed, otherwise false */
-static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
-                                     VTDPASIDEntry *pe)
+static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
 {
+    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
+
     switch (VTD_PE_GET_TYPE(pe)) {
+    case VTD_SM_PASID_ENTRY_FLT:
+        return s->scalable_modern;
     case VTD_SM_PASID_ENTRY_SLT:
-        return true;
+        return !s->scalable_modern;
+    case VTD_SM_PASID_ENTRY_NESTED:
+        /* Not support NESTED page table type yet */
+        return false;
     case VTD_SM_PASID_ENTRY_PT:
         return x86_iommu->pt_supported;
-    case VTD_SM_PASID_ENTRY_FLT:
-    case VTD_SM_PASID_ENTRY_NESTED:
     default:
         /* Unknown type */
         return false;
@@ -796,7 +800,6 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
     uint8_t pgtt;
     uint32_t index;
     dma_addr_t entry_size;
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     index = VTD_PASID_TABLE_INDEX(pasid);
     entry_size = VTD_PASID_ENTRY_SIZE;
@@ -810,7 +813,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
     }
 
     /* Do translation type check */
-    if (!vtd_pe_type_check(x86_iommu, pe)) {
+    if (!vtd_pe_type_check(s, pe)) {
         return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
@@ -3839,8 +3842,17 @@ static bool vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hdev,
         error_setg(errp, "aw-bits %d > host aw-bits %d", s->aw_bits, ret);
         return false;
     }
-#endif
+
+    if (!s->scalable_modern) {
+        /* All checks requested by VTD non-modern mode pass */
+        return true;
+    }
+
+    error_setg(errp, "host device is unsupported in scalable modern mode yet");
+    return false;
+#else
     return true;
+#endif
 }
 
 static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
@@ -4076,7 +4088,10 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }
 
     /* TODO: read cap/ecap from host to decide which cap to be exposed. */
-    if (s->scalable_mode) {
+    if (s->scalable_modern) {
+        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
+        s->cap |= VTD_CAP_FS1GP;
+    } else if (s->scalable_mode) {
         s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
     }
 
@@ -4243,9 +4258,9 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
-    /* Currently only address widths supported are 39 and 48 bits */
     if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
-        (s->aw_bits != VTD_HOST_AW_48BIT)) {
+        (s->aw_bits != VTD_HOST_AW_48BIT) &&
+        !s->scalable_modern) {
         error_setg(errp, "Supported values for aw-bits are: %d, %d",
                    VTD_HOST_AW_39BIT, VTD_HOST_AW_48BIT);
         return false;
-- 
2.34.1


