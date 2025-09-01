Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDAFCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyJl-0000w6-5r; Mon, 01 Sep 2025 02:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1usyJk-0000sd-4P
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1usyJg-0002ze-Fq
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756709219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHMdJFSIXg2Hzai9uqkKF6FhwitKksEY9iXrujYh8kQ=;
 b=TxioB0ARzLTfLenQbZTzIMO548n3akQssLVysBGSNa/jCPW6+a3ec7Viel7nyYQTAySPSs
 4WzOT20iiCdBuwjTu+RCzisoZIY3kzVeCsKldwgBueNmXEP+igDvmj/xvfIVRoO9+lVnpV
 TUNxDiANCkOZn2CZWkH/GXGaknpvmfE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-bdaEvuJ5M_6E6pxCiWhvoA-1; Mon,
 01 Sep 2025 02:46:58 -0400
X-MC-Unique: bdaEvuJ5M_6E6pxCiWhvoA-1
X-Mimecast-MFC-AGG-ID: bdaEvuJ5M_6E6pxCiWhvoA_1756709217
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 488B91956095; Mon,  1 Sep 2025 06:46:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18D5E1955E89; Mon,  1 Sep 2025 06:46:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 6/8] vfio: Remove 'vfio-calxeda-xgmac' device
Date: Mon,  1 Sep 2025 08:46:29 +0200
Message-ID: <20250901064631.530723-7-clg@redhat.com>
In-Reply-To: <20250901064631.530723-1-clg@redhat.com>
References: <20250901064631.530723-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The VFIO_XGMAC device type has been deprecated in the QEMU 10.0
timeframe. Remove it.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250731121947.1346927-3-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst            |  7 ---
 docs/about/removed-features.rst      |  7 +++
 docs/devel/kconfig.rst               |  1 -
 include/hw/vfio/vfio-calxeda-xgmac.h | 43 ------------------
 hw/arm/virt.c                        |  3 +-
 hw/core/sysbus-fdt.c                 | 67 ----------------------------
 hw/vfio/calxeda-xgmac.c              | 61 -------------------------
 hw/arm/Kconfig                       |  1 -
 hw/vfio/Kconfig                      |  5 ---
 hw/vfio/meson.build                  |  1 -
 10 files changed, 8 insertions(+), 188 deletions(-)
 delete mode 100644 include/hw/vfio/vfio-calxeda-xgmac.h
 delete mode 100644 hw/vfio/calxeda-xgmac.c

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4c2ccd3167532886a1b4f0a9eba0c2805ad1d299..bbdc5e72bcfcd5e0fef7d826aee9092e69715f8b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -509,13 +509,6 @@ which is not enough for all types of use cases, use ``reconnect-ms`` instead.
 VFIO device options
 '''''''''''''''''''
 
-``-device vfio-calxeda-xgmac`` (since 10.0)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-The vfio-calxeda-xgmac device allows to assign a host Calxeda Highbank
-10Gb XGMAC Ethernet controller device ("calxeda,hb-xgmac" compatibility
-string) to a guest. Calxeda HW has been ewasted now and there is no point
-keeping that device.
-
 ``-device vfio-platform`` (since 10.0)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 The vfio-platform device allows to assign a host platform device
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 838b5db2eed5f795bfa6dcfd92525fd8718d8668..97d6c7dbaf6c7013e704ee77786c60a2132721fa 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1273,6 +1273,13 @@ device driver such as RBD.
 VFIO devices
 ------------
 
+``-device vfio-calxeda-xgmac`` (since 10.2)
+'''''''''''''''''''''''''''''''''''''''''''
+The vfio-calxeda-xgmac device allows to assign a host Calxeda Highbank
+10Gb XGMAC Ethernet controller device ("calxeda,hb-xgmac" compatibility
+string) to a guest. Calxeda HW has been ewasted now and there is no point
+keeping that device.
+
 ``-device vfio-amd-xgbe`` (since 10.2)
 ''''''''''''''''''''''''''''''''''''''
 The vfio-amd-xgbe device allows to assign a host AMD 10GbE controller
diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
index 9fdf5015298ea2d19b97857c212ab38dca9ab85f..1d4a114a022af99a5a652da08034f2c1f3617bb0 100644
--- a/docs/devel/kconfig.rst
+++ b/docs/devel/kconfig.rst
@@ -59,7 +59,6 @@ stanza like the following::
       config ARM_VIRT
          bool
          imply PCI_DEVICES
-         imply VFIO_XGMAC
          select A15MPCORE
          select ACPI
          select ARM_SMMUV3
diff --git a/include/hw/vfio/vfio-calxeda-xgmac.h b/include/hw/vfio/vfio-calxeda-xgmac.h
deleted file mode 100644
index 8482f151dd5ab8ca5f7e8f4300e67314604a68e3..0000000000000000000000000000000000000000
--- a/include/hw/vfio/vfio-calxeda-xgmac.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * VFIO calxeda xgmac device
- *
- * Copyright Linaro Limited, 2014
- *
- * Authors:
- *  Eric Auger <eric.auger@linaro.org>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- */
-
-#ifndef HW_VFIO_VFIO_CALXEDA_XGMAC_H
-#define HW_VFIO_VFIO_CALXEDA_XGMAC_H
-
-#include "hw/vfio/vfio-platform.h"
-#include "qom/object.h"
-
-#define TYPE_VFIO_CALXEDA_XGMAC "vfio-calxeda-xgmac"
-
-/**
- * This device exposes:
- * - a single MMIO region corresponding to its register space
- * - 3 IRQS (main and 2 power related IRQs)
- */
-struct VFIOCalxedaXgmacDevice {
-    VFIOPlatformDevice vdev;
-};
-typedef struct VFIOCalxedaXgmacDevice VFIOCalxedaXgmacDevice;
-
-struct VFIOCalxedaXgmacDeviceClass {
-    /*< private >*/
-    VFIOPlatformDeviceClass parent_class;
-    /*< public >*/
-    DeviceRealize parent_realize;
-};
-typedef struct VFIOCalxedaXgmacDeviceClass VFIOCalxedaXgmacDeviceClass;
-
-DECLARE_OBJ_CHECKERS(VFIOCalxedaXgmacDevice, VFIOCalxedaXgmacDeviceClass,
-                     VFIO_CALXEDA_XGMAC_DEVICE, TYPE_VFIO_CALXEDA_XGMAC)
-
-#endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 75fb157f6cc676127781adfb206613528f975cc6..6a887228bbb8b65cf8e38f14d839fe1e80b8abce 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -38,7 +38,7 @@
 #include "hw/arm/primecell.h"
 #include "hw/arm/virt.h"
 #include "hw/block/flash.h"
-#include "hw/vfio/vfio-calxeda-xgmac.h"
+#include "hw/vfio/vfio-platform.h"
 #include "hw/display/ramfb.h"
 #include "net/net.h"
 #include "system/device_tree.h"
@@ -3217,7 +3217,6 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
      * configuration of the particular instance.
      */
     mc->max_cpus = 512;
-    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_CALXEDA_XGMAC);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index d3649d5367e7294cd7a269a7b08e56d8cbd5021a..07117363a6f27ec9128d8732a87eaed3f054ef55 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -32,9 +32,6 @@
 #include "system/device_tree.h"
 #include "system/tpm.h"
 #include "hw/platform-bus.h"
-#include "hw/vfio/vfio-platform.h"
-#include "hw/vfio/vfio-calxeda-xgmac.h"
-#include "hw/vfio/vfio-region.h"
 #include "hw/display/ramfb.h"
 #include "hw/uefi/var-service-api.h"
 #include "hw/arm/fdt.h"
@@ -65,67 +62,6 @@ typedef struct HostProperty {
     bool optional;
 } HostProperty;
 
-#ifdef CONFIG_LINUX
-
-/* Device Specific Code */
-
-/**
- * add_calxeda_midway_xgmac_fdt_node
- *
- * Generates a simple node with following properties:
- * compatible string, regs, interrupts, dma-coherent
- */
-static int add_calxeda_midway_xgmac_fdt_node(SysBusDevice *sbdev, void *opaque)
-{
-    PlatformBusFDTData *data = opaque;
-    PlatformBusDevice *pbus = data->pbus;
-    void *fdt = data->fdt;
-    const char *parent_node = data->pbus_node_name;
-    int compat_str_len, i;
-    char *nodename;
-    uint32_t *irq_attr, *reg_attr;
-    uint64_t mmio_base, irq_number;
-    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
-    VFIODevice *vbasedev = &vdev->vbasedev;
-
-    mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
-    nodename = g_strdup_printf("%s/%s@%" PRIx64, parent_node,
-                               vbasedev->name, mmio_base);
-    qemu_fdt_add_subnode(fdt, nodename);
-
-    compat_str_len = strlen(vdev->compat) + 1;
-    qemu_fdt_setprop(fdt, nodename, "compatible",
-                          vdev->compat, compat_str_len);
-
-    qemu_fdt_setprop(fdt, nodename, "dma-coherent", "", 0);
-
-    reg_attr = g_new(uint32_t, vbasedev->num_regions * 2);
-    for (i = 0; i < vbasedev->num_regions; i++) {
-        mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, i);
-        reg_attr[2 * i] = cpu_to_be32(mmio_base);
-        reg_attr[2 * i + 1] = cpu_to_be32(
-                                memory_region_size(vdev->regions[i]->mem));
-    }
-    qemu_fdt_setprop(fdt, nodename, "reg", reg_attr,
-                     vbasedev->num_regions * 2 * sizeof(uint32_t));
-
-    irq_attr = g_new(uint32_t, vbasedev->num_irqs * 3);
-    for (i = 0; i < vbasedev->num_irqs; i++) {
-        irq_number = platform_bus_get_irqn(pbus, sbdev , i)
-                         + data->irq_start;
-        irq_attr[3 * i] = cpu_to_be32(GIC_FDT_IRQ_TYPE_SPI);
-        irq_attr[3 * i + 1] = cpu_to_be32(irq_number);
-        irq_attr[3 * i + 2] = cpu_to_be32(GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    }
-    qemu_fdt_setprop(fdt, nodename, "interrupts",
-                     irq_attr, vbasedev->num_irqs * 3 * sizeof(uint32_t));
-    g_free(irq_attr);
-    g_free(reg_attr);
-    g_free(nodename);
-    return 0;
-}
-#endif /* CONFIG_LINUX */
-
 #ifdef CONFIG_TPM
 /*
  * add_tpm_tis_fdt_node: Create a DT node for TPM TIS
@@ -196,9 +132,6 @@ static bool type_match(SysBusDevice *sbdev, const BindingEntry *entry)
 
 /* list of supported dynamic sysbus bindings */
 static const BindingEntry bindings[] = {
-#ifdef CONFIG_LINUX
-    TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
-#endif
 #ifdef CONFIG_TPM
     TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
 #endif
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
deleted file mode 100644
index 03f2ff57630b557dfbd5bde03544f5b6395c29c4..0000000000000000000000000000000000000000
--- a/hw/vfio/calxeda-xgmac.c
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * calxeda xgmac VFIO device
- *
- * Copyright Linaro Limited, 2014
- *
- * Authors:
- *  Eric Auger <eric.auger@linaro.org>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "hw/vfio/vfio-calxeda-xgmac.h"
-#include "migration/vmstate.h"
-#include "qemu/module.h"
-#include "qemu/error-report.h"
-
-static void calxeda_xgmac_realize(DeviceState *dev, Error **errp)
-{
-    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(dev);
-    VFIOCalxedaXgmacDeviceClass *k = VFIO_CALXEDA_XGMAC_DEVICE_GET_CLASS(dev);
-
-    warn_report("-device vfio-calxeda-xgmac is deprecated");
-    vdev->compat = g_strdup("calxeda,hb-xgmac");
-    vdev->num_compat = 1;
-
-    k->parent_realize(dev, errp);
-}
-
-static const VMStateDescription vfio_platform_calxeda_xgmac_vmstate = {
-    .name = "vfio-calxeda-xgmac",
-    .unmigratable = 1,
-};
-
-static void vfio_calxeda_xgmac_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VFIOCalxedaXgmacDeviceClass *vcxc =
-        VFIO_CALXEDA_XGMAC_DEVICE_CLASS(klass);
-    device_class_set_parent_realize(dc, calxeda_xgmac_realize,
-                                    &vcxc->parent_realize);
-    dc->desc = "VFIO Calxeda XGMAC";
-    dc->vmsd = &vfio_platform_calxeda_xgmac_vmstate;
-}
-
-static const TypeInfo vfio_calxeda_xgmac_dev_info = {
-    .name = TYPE_VFIO_CALXEDA_XGMAC,
-    .parent = TYPE_VFIO_PLATFORM,
-    .instance_size = sizeof(VFIOCalxedaXgmacDevice),
-    .class_init = vfio_calxeda_xgmac_class_init,
-    .class_size = sizeof(VFIOCalxedaXgmacDeviceClass),
-};
-
-static void register_calxeda_xgmac_dev_type(void)
-{
-    type_register_static(&vfio_calxeda_xgmac_dev_info);
-}
-
-type_init(register_calxeda_xgmac_dev_type)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 64b2ec87b59b12601e28023cd8a5ae925f101a77..3fca48349ade97002597c866fa6457a784c3219d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -6,7 +6,6 @@ config ARM_VIRT
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VFIO_PLATFORM
-    imply VFIO_XGMAC
     imply TPM_TIS_SYSBUS
     imply TPM_TIS_I2C
     imply NVDIMM
diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index bc984f198639627043a88ecab95da4e927355e5a..9a1dbe29267ea61709c3e28e4f8c25be01c3aa33 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -23,11 +23,6 @@ config VFIO_PLATFORM
     select VFIO
     depends on LINUX && PLATFORM_BUS
 
-config VFIO_XGMAC
-    bool
-    default y
-    depends on VFIO_PLATFORM
-
 config VFIO_AP
     bool
     default y
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 0edcaf5155c8853d165d03e4a3ae514f77ca5e8c..06473a078990eab9ec5ce76a6d9897326280dc03 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -19,7 +19,6 @@ vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
-system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'cpr.c',
   'cpr-legacy.c',
-- 
2.51.0


