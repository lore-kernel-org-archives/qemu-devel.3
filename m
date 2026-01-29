Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156BCD6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUaR-00005v-LP; Thu, 29 Jan 2026 11:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaN-000050-OF
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:35 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaL-0006a8-Cc
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:35 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-435903c4040so814445f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702972; x=1770307772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EdqpYAEo9HKKYO0HNXK8z4+e4Jb03at30j4c2u3DrAk=;
 b=sl23plPOUDgwjJumFO4SK5qqk0Tw643zERZDo013fpepZW0Y4V8OQl9SeUezWN1tWp
 iHOjXva3YWfm98iX5eYa8ixetgWVTyzY5flMpUOgKWQgElsU7wZ7Aycco2UeYjLA5KDy
 iUkI4fBigV3iLeuKY4P9tjnVTyVsEkFcFvcdZU/7sCRzkKCgsMo2EcChejCES/ir2ulO
 L9Oyh3AWpn6rDKRDVSUGoMAtlFZ23XR/rQGU2V0K15rAWl9Q4he596O+sq7G2tMLO5ak
 cAt8xZ8jSY3Qo1YoEW3VDCb4664MRhszx4OxoS7hN5Tq/LgOkj6M0uVbSnkV76lKgyVf
 vY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702972; x=1770307772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EdqpYAEo9HKKYO0HNXK8z4+e4Jb03at30j4c2u3DrAk=;
 b=EltdR4zOmOkAw7xO5jKaZ8ASVRtL1gE9Aj0xibBAwAyLBpOTAdB6xqhlhL9PWP+POh
 W44dQPA68Y7f3eyuu/HzqVPFW+ybQeUSIs02f/8LR077OcJmqdm2dPV72wTQAnVcK0jo
 Nkxv4R6f47KYpX2Ks04jcz23pYooIiyMvqx/JdGqMmhq71rcvPnjfk8Pjmo/DoTZvudH
 rZ5449rXRVHCrSWofWx375g3iRiCPppsVc5nJ7xaC2k5x7lCEEknPTZtRV1BLHSceevJ
 /wd+zAeb605CUzWra/135mzt1VV0575/S0hSw53TEKxIUwqB/bIefdQVNIKuXLzP6age
 qiww==
X-Gm-Message-State: AOJu0Yw+/GGh2m9QEs5ImbQGk98/OF9KuYEJGceGEaKJJ8sqB6tkED+/
 6Hre264tgL1Lo5xrSVRyKpx9YaEGVxHUZFQUkUv/dS5ESGYxaanbL7YxUIItieMDjrw3G45gUfM
 L3L1jpjU=
X-Gm-Gg: AZuq6aI0vu6aeYXa0Vw6e32x8y76tNYZLu8dbe8FS33cyP9YNpp1CIZaAu930sMeh2C
 YJ0hbVG9x32KaMJQM7cCWjEgYmszt+wYlVFR4yEZ5PMADWZyJE09EAhyGs6xXobVGkAk2rs0/JI
 X377AXVWqBhBzC5zJgn9q+n982En8nMZBJdw/U6frGOFo+s4KCIl+Sa2FMMvsOMhGWf5NriOgY7
 7HzAPL4qUJ9jhSIpvo95QC9chrzAQhl0RYPiu40zH3M56KBT90NFpMoyZZTvN1YEIXUQT3r4GGg
 ZWVT6BaolDC5Zu44PVrR5mX6DtPVRhsuFewuE00dgr+43Woe7iyaIvX2n0BImbOLee72WavbnS+
 A26RMvklQoDCVoApisNhaJ4QF2QMQIAakAUlPhYlJ0mdsCoFeEOw8zeu2ZoAdVh4Sm4qIZaupHu
 Cr1smFlNCBVL6aGp4eyzbzp+ef8VFLzzH7NjJOqxEN
X-Received: by 2002:a5d:5f47:0:b0:432:84f9:8c04 with SMTP id
 ffacd0b85a97d-435f3a86558mr177509f8f.24.1769702971731; 
 Thu, 29 Jan 2026 08:09:31 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/43] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to
 vfio-pci endpoints with iommufd
Date: Thu, 29 Jan 2026 16:08:44 +0000
Message-ID: <20260129160917.1415092-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Accelerated SMMUv3 is only meaningful when a device can leverage the host
SMMUv3 in nested mode (S1+S2 translation). To keep the model consistent
and correct, this mode is restricted to vfio-pci endpoint devices using
the iommufd backend.

Non-endpoint emulated devices such as PCIe root ports and bridges are also
permitted so that vfio-pci devices can be attached downstream. All other
device types are unsupported in accelerated mode.

Implement supports_address_space() callback to reject all such unsupported
devices.

This restriction also avoids complications with IOTLB invalidations. Some
TLBI commands (e.g. CMD_TLBI_NH_ASID) lack an associated SID, making it
difficult to trace the originating device. Allowing emulated endpoints
would require invalidating both QEMU’s software IOTLB and the host’s
hardware IOTLB, which can significantly degrade performance.

A key design choice is the address space returned for accelerated vfio-pci
endpoints. VFIO core has a container that manages an HWPT. By default, it
allocates a stage-1 normal HWPT, unless vIOMMU requests for a nesting
parent HWPT for accelerated cases.

VFIO core adds a listener for that HWPT and sets up a handler
vfio_container_region_add() where it checks the memory region.

 -If the region is a non-IOMMU translated one (system address space), VFIO
  treats it as RAM and handles all stage-2 mappings for the core allocated
  nesting parent HWPT.

 -If the region is an IOMMU address space, VFIO instead enables IOTLB
  notifier handling and translation replay, skipping the RAM listener and
  therefore not installing stage-2 mappings.

For accelerated SMMUv3, correct operation requires the S1+S2 nesting
model, and therefore VFIO must take the "system address space" path so
that stage-2 mappings are properly built. Returning an alias of the
system address space ensures this happens. Returning the IOMMU address
space would omit stage-2 mapping and break nested translation.

Another option considered was forcing a pre-registration path using
vfio_prereg_listener() to set up stage-2 mappings, but this requires
changes in VFIO core and was not adopted. Returning an alias of the
system address space keeps the design aligned with existing VFIO/iommufd
nesting flows and avoids the need for cross-subsystem changes.

In summary:
 - vfio-pci devices(with iommufd as backend) return an address space
   aliased to system address space.
 - bridges and root ports return the IOMMU address space.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-11-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c | 77 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index b2eded743e..2fcd301322 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -7,8 +7,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci-host/gpex.h"
+#include "hw/vfio/pci.h"
+
 #include "smmuv3-accel.h"
 
 /*
@@ -37,6 +42,48 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
     return accel_dev;
 }
 
+/*
+ * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
+ * endpoints can sit downstream. Accelerated SMMUv3 requires a vfio-pci
+ * endpoint using the iommufd backend; all other device types are rejected.
+ * This avoids supporting emulated endpoints, which would complicate IOTLB
+ * invalidation and hurt performance.
+ */
+static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
+{
+
+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
+        object_dynamic_cast(OBJECT(pdev), TYPE_PXB_PCIE_DEV) ||
+        object_dynamic_cast(OBJECT(pdev), TYPE_GPEX_ROOT_DEVICE)) {
+        return true;
+    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI))) {
+        *vfio_pci = true;
+        if (object_property_get_link(OBJECT(pdev), "iommufd", NULL)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static bool smmuv3_accel_supports_as(PCIBus *bus, void *opaque, int devfn,
+                                     Error **errp)
+{
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
+    bool vfio_pci = false;
+
+    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
+        if (vfio_pci) {
+            error_setg(errp, "vfio-pci endpoint devices without an iommufd "
+                       "backend not allowed when using arm-smmuv3,accel=on");
+
+        } else {
+            error_setg(errp, "Emulated endpoint devices are not allowed when "
+                       "using arm-smmuv3,accel=on");
+        }
+        return false;
+    }
+    return true;
+}
 /*
  * Find or add an address space for the given PCI device.
  *
@@ -47,15 +94,43 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
 static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
                                               int devfn)
 {
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
     SMMUState *bs = opaque;
     SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
     SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
     SMMUDevice *sdev = &accel_dev->sdev;
+    bool vfio_pci = false;
 
-    return &sdev->as;
+    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
+        /* Should never be here: supports_address_space() filters these out */
+        g_assert_not_reached();
+    }
+
+    /*
+     * In the accelerated mode, a vfio-pci device attached via the iommufd
+     * backend must remain in the system address space. Such a device is
+     * always translated by its physical SMMU (using either a stage-2-only
+     * STE or a nested STE), where the parent stage-2 page table is allocated
+     * by the VFIO core to back the system address space.
+     *
+     * Return the shared_as_sysmem aliased to the global system memory in this
+     * case. Sharing address_space_memory also allows devices under different
+     * vSMMU instances in the same VM to reuse a single nesting parent HWPT in
+     * the VFIO core.
+     *
+     * For non-endpoint emulated devices such as PCIe root ports and bridges,
+     * which may use the normal emulated translation path and software IOTLBs,
+     * return the SMMU's IOMMU address space.
+     */
+    if (vfio_pci) {
+        return shared_as_sysmem;
+    } else {
+        return &sdev->as;
+    }
 }
 
 static const PCIIOMMUOps smmuv3_accel_ops = {
+    .supports_address_space = smmuv3_accel_supports_as,
     .get_address_space = smmuv3_accel_find_add_as,
 };
 
-- 
2.43.0


