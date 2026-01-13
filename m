Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F87D29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaqF-0007sZ-KO; Tue, 13 Jan 2026 04:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqD-0007jf-UY
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqC-0003LX-2d
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16go3Zbvd/Ek1pzySnrk2h8UNixWr9Z1NFH46NMmfv4=;
 b=Q31gWePe1aiy4SUNL6x5xXqH636PzQxyayoxjnt22bY6Y255RH4IKkxv8x+IFlV77N3COI
 fPrCiig1B1LET938kjHVYkB2V1kSU5jAVCo2kkAJ7k7PH4ALbm/+aupa8LOdcXUq3B/tM3
 ShFMTg/8j6f1Kyo9l+3WmqW/royrxCY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-D55bB6I2OqW56sw30bozIA-1; Tue,
 13 Jan 2026 04:37:16 -0500
X-MC-Unique: D55bB6I2OqW56sw30bozIA-1
X-Mimecast-MFC-AGG-ID: D55bB6I2OqW56sw30bozIA_1768297035
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0589E1956088; Tue, 13 Jan 2026 09:37:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7CF0630001A2; Tue, 13 Jan 2026 09:37:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/41] intel_iommu_accel: Check for compatibility with IOMMUFD
 backed device when x-flts=on
Date: Tue, 13 Jan 2026 10:36:07 +0100
Message-ID: <20260113093637.1549214-12-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

When vIOMMU is configured x-flts=on in scalable mode, first stage page table
is passed to host to construct nested page table for passthrough devices.

We need to check compatibility of some critical IOMMU capabilities between
vIOMMU and host IOMMU to ensure guest first stage page table could be used by
host.

For instance, vIOMMU supports first stage 1GB large page mapping, but host does
not, then this IOMMUFD backed device should fail.

Even of the checks pass, for now we willingly reject the association because
all the bits are not there yet, it will be relaxed in the end of this series.

Note vIOMMU has exposed VIOMMU_FLAG_WANT_NESTING_PARENT flag to force
VFIO core to create nesting parent HWPT, if host doesn't support nested
translation, the creation will fail. So no need to check nested
capability here.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260106061304.314546-10-zhenzhong.duan@intel.com
[ clg: - hw/i386/intel_iommu_accel.[hc]: Changed Copyright date 2025 -> 2026
       - in commit log :
       	 IOMMU_HWPT_ALLOC_NEST_PARENT -> VIOMMU_FLAG_WANT_NESTING_PARENT  ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
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
index 620b184aa5f91f8f86879cf22eabe720a9fa33a3..4ddbfba9f0118190b7dd3a3d6400e34774d5e17a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3961,6 +3961,7 @@ R: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
 S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
+F: hw/i386/intel_iommu_accel.*
 F: include/hw/i386/intel_iommu.h
 F: tests/functional/x86_64/test_intel_iommu.py
 F: tests/qtest/intel-iommu-test.c
diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
new file mode 100644
index 0000000000000000000000000000000000000000..79117b25a030a3d22d75b635725a6f78a21ec407
--- /dev/null
+++ b/hw/i386/intel_iommu_accel.h
@@ -0,0 +1,28 @@
+/*
+ * Intel IOMMU acceleration with nested translation
+ *
+ * Copyright (C) 2026 Intel Corporation.
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
index 3a3725e489595121b1fdb0f38a1e85fa7f64c1f6..b11798d4b75b7fb6961a1b2bde8851667b0d07db 100644
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
index 0000000000000000000000000000000000000000..2942eff100b9e7871326d27b58b71517ff705271
--- /dev/null
+++ b/hw/i386/intel_iommu_accel.c
@@ -0,0 +1,42 @@
+/*
+ * Intel IOMMU acceleration with nested translation
+ *
+ * Copyright (C) 2026 Intel Corporation.
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
index 6a0ab54bea4ab8599965a7b4dec60194f85877cb..12473acaa7344c36f6bf20eadd058d414dc6f945 100644
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
index 436b3ce52d6480457a84c796ee5ed79e3a0bec36..63ae57baa511e6e29b0e6a276352cd61df6602a6 100644
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
2.52.0


