Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8ACCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvhp-0004bK-Ta; Mon, 17 Nov 2025 04:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKvhY-0004RF-CQ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:39:12 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKvhW-0006HR-Kd
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763372351; x=1794908351;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=506YKE/Z/cOoeAPuJMZQcNMH9xKHCboDtQr3nvOJ598=;
 b=ErX5GYmBaDOpyTO0GlAPL55x4Tc+AZETFAgHb7Dvhc9s8Lizwgac2Ucp
 0RVxKP2UXWXqAMfwKBYmJxskfjysF4IYnjJQm/sWsMTosEbauWEoQZeOJ
 LKL/CNbTxBASHQIAuJ+XoLLoHjLyCyCTjhEkDt3QosOtvkEP0R8hGFe/g
 9erMCbB9tYOnMf51B226U4awj4uLe+C+uCv/zqMUKtD+OGP58g2AN/fJp
 fHIwO00EemnAh7hot+8K+A//NKdQJhaNR+/8IiGxWUz0tk7leO7cfT4Fh
 9c5KdzmGhHTvcoyElo8E+5nRGliW5Ihr51/mQTOWvacdwwZPdcNkk4kPK g==;
X-CSE-ConnectionGUID: PkcNhjNLRXWw9zkPFBuQ8w==
X-CSE-MsgGUID: FvJVPlTWSDuc+Nbmq6BL/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76045973"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="76045973"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:39:09 -0800
X-CSE-ConnectionGUID: gpnI5MW7Qfq23IiSFKV1xw==
X-CSE-MsgGUID: 6zSpBM+nS0ioAHlo+/vyZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="190070917"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:39:05 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v8 09/23] intel_iommu_accel: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Date: Mon, 17 Nov 2025 04:37:12 -0500
Message-ID: <20251117093729.1121324-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When vIOMMU is configured x-flts=on in scalable mode, first stage page table
is passed to host to construct nested page table for passthrough devices.

We need to check compatibility of some critical IOMMU capabilities between
vIOMMU and host IOMMU to ensure guest first stage page table could be used by
host.

For instance, vIOMMU supports first stage 1GB large page mapping, but host does
not, then this IOMMUFD backed device should fail.

Even of the checks pass, for now we willingly reject the association because
all the bits are not there yet, it will be relaxed in the end of this series.

Note vIOMMU has exposed IOMMU_HWPT_ALLOC_NEST_PARENT flag to force VFIO core to
create nesting parent HWPT, if host doesn't support nested translation, the
creation will fail. So no need to check nested capability here.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 MAINTAINERS                 |  1 +
 hw/i386/intel_iommu_accel.h | 28 +++++++++++++++++++++++++
 hw/i386/intel_iommu.c       |  5 ++---
 hw/i386/intel_iommu_accel.c | 42 +++++++++++++++++++++++++++++++++++++
 hw/i386/Kconfig             |  5 +++++
 hw/i386/meson.build         |  1 +
 6 files changed, 79 insertions(+), 3 deletions(-)
 create mode 100644 hw/i386/intel_iommu_accel.h
 create mode 100644 hw/i386/intel_iommu_accel.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f4a30c126b..bc1d2b6261 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3929,6 +3929,7 @@ R: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
 S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
+F: hw/i386/intel_iommu_accel.*
 F: include/hw/i386/intel_iommu.h
 F: tests/functional/x86_64/test_intel_iommu.py
 F: tests/qtest/intel-iommu-test.c
diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
new file mode 100644
index 0000000000..c5274e342c
--- /dev/null
+++ b/hw/i386/intel_iommu_accel.h
@@ -0,0 +1,28 @@
+/*
+ * Intel IOMMU acceleration with nested translation
+ *
+ * Copyright (C) 2025 Intel Corporation.
+ *
+ * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_I386_INTEL_IOMMU_ACCEL_H
+#define HW_I386_INTEL_IOMMU_ACCEL_H
+#include CONFIG_DEVICES
+
+#ifdef CONFIG_VTD_ACCEL
+bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
+                          Error **errp);
+#else
+static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
+                                        HostIOMMUDevice *hiod,
+                                        Error **errp)
+{
+    error_setg(errp,
+               "host IOMMU is incompatible with guest first stage translation");
+    return false;
+}
+#endif
+#endif
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3095d78321..d3c8a75878 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "hw/iommu.h"
 #include "intel_iommu_internal.h"
+#include "intel_iommu_accel.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
@@ -4596,9 +4597,7 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return true;
     }
 
-    error_setg(errp,
-               "host device is uncompatible with first stage translation");
-    return false;
+    return vtd_check_hiod_accel(s, hiod, errp);
 }
 
 static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
new file mode 100644
index 0000000000..6846c6ec4d
--- /dev/null
+++ b/hw/i386/intel_iommu_accel.c
@@ -0,0 +1,42 @@
+/*
+ * Intel IOMMU acceleration with nested translation
+ *
+ * Copyright (C) 2025 Intel Corporation.
+ *
+ * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/iommufd.h"
+#include "intel_iommu_internal.h"
+#include "intel_iommu_accel.h"
+
+bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
+                          Error **errp)
+{
+    struct HostIOMMUDeviceCaps *caps = &hiod->caps;
+    struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
+
+    if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
+        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
+        return false;
+    }
+
+    if (caps->type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
+        error_setg(errp, "Incompatible host platform IOMMU type %d",
+                   caps->type);
+        return false;
+    }
+
+    if (s->fs1gp && !(vtd->cap_reg & VTD_CAP_FS1GP)) {
+        error_setg(errp,
+                   "First stage 1GB large page is unsupported by host IOMMU");
+        return false;
+    }
+
+    error_setg(errp,
+               "host IOMMU is incompatible with guest first stage translation");
+    return false;
+}
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 6a0ab54bea..12473acaa7 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -150,8 +150,13 @@ config X86_IOMMU
 
 config VTD
     bool
+    imply VTD_ACCEL
     select X86_IOMMU
 
+config VTD_ACCEL
+    bool
+    depends on VTD && IOMMUFD
+
 config AMD_IOMMU
     bool
     select X86_IOMMU
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 436b3ce52d..63ae57baa5 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -21,6 +21,7 @@ i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
 i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmouse.c'))
 i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
 i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
+i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_accel.c'))
 i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
                                 if_false: files('sgx-stub.c'))
 
-- 
2.47.1


