Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D893BC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGWl-0005Re-C7; Wed, 28 Feb 2024 04:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfGWj-0005LO-NY
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:47:01 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfGWh-0002AQ-3N
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709113619; x=1740649619;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zzQtmneALoan6h7kPxfiyycxQTue6ulWrRA2sEohjFA=;
 b=YTzrWl5oWGxzLrAcBfI95tDrkq6sRfFGkn3minAORhsU0TKcT5OQ1g1D
 9ly9mltOaS8M1OfOQHRdYQPcHyNFO//YvuaEuBvECaqkKIoc6yUFdtB8w
 plhCFdSIAoz3PWHFzpIgiUQ5WLflL1i5JSwsM/eavhCeCQsA/7yCAyBUQ
 X07U/1J+r1MwsYvzIWqZxBajENEIvRExlti5ztTab86XUUDHagsNbLbHh
 l9dPbuCr4AVZrx1o7Z4y2rXTvO3wqHToZ5BwBjcIpLxxCtjt8FP4IVfm9
 fjZWZYjH9mER9vbioJxyktVB1c5gbZDcAxi2MZJ5iP17ub60FXytSLr8q A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25969996"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="25969996"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 01:46:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7810012"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 01:46:53 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v1 3/6] intel_iommu: Add a framework to check and sync host
 IOMMU cap/ecap
Date: Wed, 28 Feb 2024 17:44:29 +0800
Message-Id: <20240228094432.1092748-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Yi Liu <yi.l.liu@intel.com>

Add a framework to check and synchronize host IOMMU cap/ecap with
vIOMMU cap/ecap.

The sequence will be:

vtd_cap_init() initializes iommu->cap/ecap.
vtd_check_hdev() update iommu->cap/ecap based on host cap/ecap.
iommu->cap_frozen set when machine create done, iommu->cap/ecap become readonly.

Implementation details for different backends will be in following patches.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |  1 +
 hw/i386/intel_iommu.c         | 50 ++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index bbc7b96add..c71a133820 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -283,6 +283,7 @@ struct IntelIOMMUState {
 
     uint64_t cap;                   /* The value of capability reg */
     uint64_t ecap;                  /* The value of extended capability reg */
+    bool cap_frozen;                /* cap/ecap become read-only after frozen */
 
     uint32_t context_cache_gen;     /* Should be in [1,MAX] */
     GHashTable *iotlb;              /* IOTLB */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ffa1ad6429..a9f9dfd6a7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -35,6 +35,8 @@
 #include "sysemu/kvm.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
+#include "hw/vfio/vfio-common.h"
+#include "sysemu/iommufd.h"
 #include "hw/i386/apic_internal.h"
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
@@ -3819,6 +3821,38 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
+static int vtd_check_legacy_hdev(IntelIOMMUState *s,
+                                 IOMMULegacyDevice *ldev,
+                                 Error **errp)
+{
+    return 0;
+}
+
+static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
+                                  IOMMUFDDevice *idev,
+                                  Error **errp)
+{
+    return 0;
+}
+
+static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hdev,
+                          Error **errp)
+{
+    HostIOMMUDevice *base_dev = vtd_hdev->dev;
+    IOMMUFDDevice *idev;
+
+    if (base_dev->type == HID_LEGACY) {
+        IOMMULegacyDevice *ldev = container_of(base_dev,
+                                               IOMMULegacyDevice, base);
+
+        return vtd_check_legacy_hdev(s, ldev, errp);
+    }
+
+    idev = container_of(base_dev, IOMMUFDDevice, base);
+
+    return vtd_check_iommufd_hdev(s, idev, errp);
+}
+
 static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                     HostIOMMUDevice *base_dev, Error **errp)
 {
@@ -3829,6 +3863,7 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         .devfn = devfn,
     };
     struct vtd_as_key *new_key;
+    int ret;
 
     assert(base_dev);
 
@@ -3848,6 +3883,13 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     vtd_hdev->iommu_state = s;
     vtd_hdev->dev = base_dev;
 
+    ret = vtd_check_hdev(s, vtd_hdev, errp);
+    if (ret) {
+        g_free(vtd_hdev);
+        vtd_iommu_unlock(s);
+        return ret;
+    }
+
     new_key = g_malloc(sizeof(*new_key));
     new_key->bus = bus;
     new_key->devfn = devfn;
@@ -4083,7 +4125,9 @@ static void vtd_init(IntelIOMMUState *s)
     s->iq_dw = false;
     s->next_frcd_reg = 0;
 
-    vtd_cap_init(s);
+    if (!s->cap_frozen) {
+        vtd_cap_init(s);
+    }
 
     /*
      * Rsvd field masks for spte
@@ -4254,6 +4298,10 @@ static int vtd_machine_done_notify_one(Object *child, void *unused)
 
 static void vtd_machine_done_hook(Notifier *notifier, void *unused)
 {
+    IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
+
+    iommu->cap_frozen = true;
+
     object_child_foreach_recursive(object_get_root(),
                                    vtd_machine_done_notify_one, NULL);
 }
-- 
2.34.1


