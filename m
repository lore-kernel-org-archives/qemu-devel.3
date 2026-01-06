Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247DBCD0437
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0KO-0003Ht-Ki; Tue, 06 Jan 2026 01:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0KL-0003Cr-2I
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:13:58 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0KJ-0007Gj-4s
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767680035; x=1799216035;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RwWPR0GfcOoZmyPROvS1qUq63fvGbmLtSYfQ31zBXE8=;
 b=krrZEwVIb/EMqtbz/kbNcNsp2jegW8t5MdCzYzE0jR0IEoa1Y+OWplEJ
 Yvp9gFspHxRc8UR0q6tiYyT4W+FkzFYVI8OfMX04GJMTappJFOMb+/8Zu
 YWqGmJBtv6F4pQyVm1HXBYi7UgJGTOD6M2KAWuTHSOgL14PZU6ggA0qbS
 qGpRa6lMeuG/Wh0TujURaNpsDxGbc+LoK602BxTUn8qVHLp3xMXJuC3cg
 /jkyETZnM9VEXdIKqmX1cU5S633bBG2UQmqKxGWg/cpGLj9AWEPBXTdNW
 VEM0lCbtMjvifktx8oX/kfaRvSWTzbzZxvq8iWZ/21+kQ3g3mlHkpoBu4 g==;
X-CSE-ConnectionGUID: rF9INyi7SoaohwK8Kg6+9Q==
X-CSE-MsgGUID: hSzPoj2SRYS65aOC/HyiRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69087621"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="69087621"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:13:54 -0800
X-CSE-ConnectionGUID: 9qVrivNhRze9hHMs/PpNYQ==
X-CSE-MsgGUID: M73d/AkeSiKbZYyA/p15vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="202588800"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:13:51 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v10 09/19] intel_iommu_accel: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Date: Tue,  6 Jan 2026 01:12:51 -0500
Message-ID: <20260106061304.314546-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260106061304.314546-1-zhenzhong.duan@intel.com>
References: <20260106061304.314546-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
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
index 3ff0d3a4da..a00539e650 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3931,6 +3931,7 @@ R: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
 S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
+F: hw/i386/intel_iommu_accel.*
 F: include/hw/i386/intel_iommu.h
 F: tests/functional/x86_64/test_intel_iommu.py
 F: tests/qtest/intel-iommu-test.c
diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
new file mode 100644
index 0000000000..472ae109e2
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
+    error_setg(errp, "host IOMMU cannot be checked!");
+    error_append_hint(errp, "CONFIG_VTD_ACCEL is not enabled");
+    return false;
+}
+#endif
+#endif
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3a3725e489..b11798d4b7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -26,6 +26,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/core/iommu.h"
 #include "intel_iommu_internal.h"
+#include "intel_iommu_accel.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/core/qdev-properties.h"
@@ -4595,9 +4596,7 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
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


