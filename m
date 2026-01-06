Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE4BCD043E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0KV-0003Na-Jk; Tue, 06 Jan 2026 01:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0KU-0003Mm-D5
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:14:06 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0KQ-0007J8-TK
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767680043; x=1799216043;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1ygu3CRxj06O9rmnUnTm9Hgrynjbm0C12ZyY7mRQhOg=;
 b=aS/S5hzyiKlPUqSupwpDb8erRW0XEVfe17LZZT9yE8LysujLBCK8F6t7
 Ocz8LdFX/UjzAnfJ5BZYUY4z2MIU4bMqp/lhd0ypEObOdHrXbvk5lXE3d
 y+Pw/jxcV6F2yThq829pKXEQj3EXtQlfmzUVJHMYrscYvQRHu636cK08s
 3DSNLiwOkY9YUE5BATvAQGgYUGR5tyavjL2qCSiPzqJC1/3M6Z8uY5qki
 qRV5wQ2IYS6dV3Lr9FRrmzy6viftSQhqqwtd3QzE7l+zQtmr9u8K2Jg6z
 ToUq00R0sTZEP0nT6bt4tjnDROzlDPbtieyP6Gs62cVmT8O6+2EeI28tL A==;
X-CSE-ConnectionGUID: tJ87pmOYQ7+k/+Nua34aJA==
X-CSE-MsgGUID: PBvWhg1vTdasjAVJ7bGJBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69094017"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="69094017"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:14:00 -0800
X-CSE-ConnectionGUID: kU7FO+TWQIyNRJU74FskIQ==
X-CSE-MsgGUID: o9QGi8+TRqae2R0+B81Y0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="202588828"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:13:55 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v10 10/19] intel_iommu_accel: Fail passthrough device under
 PCI bridge if x-flts=on
Date: Tue,  6 Jan 2026 01:12:52 -0500
Message-ID: <20260106061304.314546-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260106061304.314546-1-zhenzhong.duan@intel.com>
References: <20260106061304.314546-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Currently we don't support nested translation for passthrough device with
emulated device under same PCI bridge, because they require different address
space when x-flts=on.

In theory, we do support if devices under same PCI bridge are all passthrough
devices. But emulated device can be hotplugged under same bridge. To simplify,
just forbid passthrough device under PCI bridge no matter if there is, or will
be emulated devices under same bridge. This is acceptable because PCIE bridge
is more popular than PCI bridge now.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/i386/intel_iommu_accel.h |  4 ++--
 hw/i386/intel_iommu.c       |  7 ++++---
 hw/i386/intel_iommu_accel.c | 12 +++++++++++-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 472ae109e2..76e0d26942 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -13,11 +13,11 @@
 #include CONFIG_DEVICES
 
 #ifdef CONFIG_VTD_ACCEL
-bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
+bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
-                                        HostIOMMUDevice *hiod,
+                                        VTDHostIOMMUDevice *vtd_hiod,
                                         Error **errp)
 {
     error_setg(errp, "host IOMMU cannot be checked!");
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b11798d4b7..0817b17772 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4570,9 +4570,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
-static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
+static bool vtd_check_hiod(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                            Error **errp)
 {
+    HostIOMMUDevice *hiod = vtd_hiod->hiod;
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
     int ret;
 
@@ -4596,7 +4597,7 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return true;
     }
 
-    return vtd_check_hiod_accel(s, hiod, errp);
+    return vtd_check_hiod_accel(s, vtd_hiod, errp);
 }
 
 static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
@@ -4632,7 +4633,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     vtd_hiod->iommu_state = s;
     vtd_hiod->hiod = hiod;
 
-    if (!vtd_check_hiod(s, hiod, errp)) {
+    if (!vtd_check_hiod(s, vtd_hiod, errp)) {
         g_free(vtd_hiod);
         vtd_iommu_unlock(s);
         return false;
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 6846c6ec4d..ead6c42879 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -12,12 +12,16 @@
 #include "system/iommufd.h"
 #include "intel_iommu_internal.h"
 #include "intel_iommu_accel.h"
+#include "hw/pci/pci_bus.h"
 
-bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
+bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp)
 {
+    HostIOMMUDevice *hiod = vtd_hiod->hiod;
     struct HostIOMMUDeviceCaps *caps = &hiod->caps;
     struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
+    PCIBus *bus = vtd_hiod->bus;
+    PCIDevice *pdev = bus->devices[vtd_hiod->devfn];
 
     if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
         error_setg(errp, "Need IOMMUFD backend when x-flts=on");
@@ -36,6 +40,12 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return false;
     }
 
+    if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
+        error_setg(errp, "Host device downstream to a PCI bridge is "
+                   "unsupported when x-flts=on");
+        return false;
+    }
+
     error_setg(errp,
                "host IOMMU is incompatible with guest first stage translation");
     return false;
-- 
2.47.1


