Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DA4CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyJt-00012F-DD; Mon, 01 Sep 2025 02:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1usyJn-0000zw-HT
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1usyJg-0002zF-5q
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756709218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xubuu3luGvvUwq1zwRtj03pcX83GhH1DRsiK0Kj4a2Q=;
 b=XHvXmo4vBxnMZxKOW90Zgk0ckQyfnUmrKNvRclxW4MLYWWHT0LDrmXPECID4jzFhxu5J/P
 uClpeTPEHHhDGTPf0TiKeVq9iSYSvltlktriClKZavskLc3pi64XuINwVZhQDHG83A08Q9
 vZ6hG4QR1hsLuEbHHp02M0r8jkERofY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-ukxXNhFWOImnqS9RtJTpZA-1; Mon,
 01 Sep 2025 02:46:55 -0400
X-MC-Unique: ukxXNhFWOImnqS9RtJTpZA-1
X-Mimecast-MFC-AGG-ID: ukxXNhFWOImnqS9RtJTpZA_1756709214
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F3B919560B2; Mon,  1 Sep 2025 06:46:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B26D31955E89; Mon,  1 Sep 2025 06:46:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 5/8] vfio: Remove 'vfio-amd-xgbe' device
Date: Mon,  1 Sep 2025 08:46:28 +0200
Message-ID: <20250901064631.530723-6-clg@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The VFIO_AMD_XGBE device type has been deprecated in the QEMU 10.0
timeframe. The AMD "Seattle" device is not supported anymore. Remove it.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250731121947.1346927-2-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst       |   6 -
 docs/about/removed-features.rst |   9 +
 docs/devel/kconfig.rst          |   1 -
 include/hw/vfio/vfio-amd-xgbe.h |  46 -----
 hw/arm/virt.c                   |   2 -
 hw/core/sysbus-fdt.c            | 316 --------------------------------
 hw/vfio/amd-xgbe.c              |  61 ------
 hw/arm/Kconfig                  |   1 -
 hw/vfio/Kconfig                 |   5 -
 hw/vfio/meson.build             |   1 -
 10 files changed, 9 insertions(+), 439 deletions(-)
 delete mode 100644 include/hw/vfio/vfio-amd-xgbe.h
 delete mode 100644 hw/vfio/amd-xgbe.c

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 5d1579dcf8296968350c8de4e4a7c606632a2ef8..4c2ccd3167532886a1b4f0a9eba0c2805ad1d299 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -516,12 +516,6 @@ The vfio-calxeda-xgmac device allows to assign a host Calxeda Highbank
 string) to a guest. Calxeda HW has been ewasted now and there is no point
 keeping that device.
 
-``-device vfio-amd-xgbe`` (since 10.0)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-The vfio-amd-xgbe device allows to assign a host AMD 10GbE controller
-to a guest ("amd,xgbe-seattle-v1a" compatibility string). AMD "Seattle"
-is not supported anymore and there is no point keeping that device.
-
 ``-device vfio-platform`` (since 10.0)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 The vfio-platform device allows to assign a host platform device
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 25a904032c5582299562a5fb6c7e0b6d7572cdda..838b5db2eed5f795bfa6dcfd92525fd8718d8668 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1270,6 +1270,15 @@ The corresponding upstream server project is no longer maintained.
 Users are recommended to switch to an alternative distributed block
 device driver such as RBD.
 
+VFIO devices
+------------
+
+``-device vfio-amd-xgbe`` (since 10.2)
+''''''''''''''''''''''''''''''''''''''
+The vfio-amd-xgbe device allows to assign a host AMD 10GbE controller
+to a guest ("amd,xgbe-seattle-v1a" compatibility string). AMD "Seattle"
+is not supported anymore and there is no point keeping that device.
+
 Tools
 -----
 
diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
index 493b76c4fbf70dc4f2943e23704d1246e324f4cb..9fdf5015298ea2d19b97857c212ab38dca9ab85f 100644
--- a/docs/devel/kconfig.rst
+++ b/docs/devel/kconfig.rst
@@ -59,7 +59,6 @@ stanza like the following::
       config ARM_VIRT
          bool
          imply PCI_DEVICES
-         imply VFIO_AMD_XGBE
          imply VFIO_XGMAC
          select A15MPCORE
          select ACPI
diff --git a/include/hw/vfio/vfio-amd-xgbe.h b/include/hw/vfio/vfio-amd-xgbe.h
deleted file mode 100644
index a894546c02d140d2b689f09ace733c4d43019371..0000000000000000000000000000000000000000
--- a/include/hw/vfio/vfio-amd-xgbe.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * VFIO AMD XGBE device
- *
- * Copyright Linaro Limited, 2015
- *
- * Authors:
- *  Eric Auger <eric.auger@linaro.org>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- */
-
-#ifndef HW_VFIO_VFIO_AMD_XGBE_H
-#define HW_VFIO_VFIO_AMD_XGBE_H
-
-#include "hw/vfio/vfio-platform.h"
-#include "qom/object.h"
-
-#define TYPE_VFIO_AMD_XGBE "vfio-amd-xgbe"
-
-/**
- * This device exposes:
- * - 5 MMIO regions: MAC, PCS, SerDes Rx/Tx regs,
-     SerDes Integration Registers 1/2 & 2/2
- * - 2 level sensitive IRQs and optional DMA channel IRQs
- */
-struct VFIOAmdXgbeDevice {
-    VFIOPlatformDevice vdev;
-};
-
-typedef struct VFIOAmdXgbeDevice VFIOAmdXgbeDevice;
-
-struct VFIOAmdXgbeDeviceClass {
-    /*< private >*/
-    VFIOPlatformDeviceClass parent_class;
-    /*< public >*/
-    DeviceRealize parent_realize;
-};
-
-typedef struct VFIOAmdXgbeDeviceClass VFIOAmdXgbeDeviceClass;
-
-DECLARE_OBJ_CHECKERS(VFIOAmdXgbeDevice, VFIOAmdXgbeDeviceClass,
-                     VFIO_AMD_XGBE_DEVICE, TYPE_VFIO_AMD_XGBE)
-
-#endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e5c4142e822d78261f32b986f86d40ee5562e592..75fb157f6cc676127781adfb206613528f975cc6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -39,7 +39,6 @@
 #include "hw/arm/virt.h"
 #include "hw/block/flash.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
-#include "hw/vfio/vfio-amd-xgbe.h"
 #include "hw/display/ramfb.h"
 #include "net/net.h"
 #include "system/device_tree.h"
@@ -3219,7 +3218,6 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
      */
     mc->max_cpus = 512;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_CALXEDA_XGMAC);
-    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index c339a27875cbee8131b064674aa09adf4b9efa25..d3649d5367e7294cd7a269a7b08e56d8cbd5021a 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -34,7 +34,6 @@
 #include "hw/platform-bus.h"
 #include "hw/vfio/vfio-platform.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
-#include "hw/vfio/vfio-amd-xgbe.h"
 #include "hw/vfio/vfio-region.h"
 #include "hw/display/ramfb.h"
 #include "hw/uefi/var-service-api.h"
@@ -68,142 +67,6 @@ typedef struct HostProperty {
 
 #ifdef CONFIG_LINUX
 
-/**
- * copy_properties_from_host
- *
- * copies properties listed in an array from host device tree to
- * guest device tree. If a non optional property is not found, the
- * function asserts. An optional property is ignored if not found
- * in the host device tree.
- * @props: array of HostProperty to copy
- * @nb_props: number of properties in the array
- * @host_dt: host device tree blob
- * @guest_dt: guest device tree blob
- * @node_path: host dt node path where the property is supposed to be
-              found
- * @nodename: guest node name the properties should be added to
- */
-static void copy_properties_from_host(HostProperty *props, int nb_props,
-                                      void *host_fdt, void *guest_fdt,
-                                      char *node_path, char *nodename)
-{
-    int i, prop_len;
-    const void *r;
-    Error *err = NULL;
-
-    for (i = 0; i < nb_props; i++) {
-        r = qemu_fdt_getprop(host_fdt, node_path,
-                             props[i].name,
-                             &prop_len,
-                             &err);
-        if (r) {
-            qemu_fdt_setprop(guest_fdt, nodename,
-                             props[i].name, r, prop_len);
-        } else {
-            if (props[i].optional && prop_len == -FDT_ERR_NOTFOUND) {
-                /* optional property does not exist */
-                error_free(err);
-            } else {
-                error_report_err(err);
-            }
-            if (!props[i].optional) {
-                /* mandatory property not found: bail out */
-                exit(1);
-            }
-            err = NULL;
-        }
-    }
-}
-
-/* clock properties whose values are copied/pasted from host */
-static HostProperty clock_copied_properties[] = {
-    {"compatible", false},
-    {"#clock-cells", false},
-    {"clock-frequency", true},
-    {"clock-output-names", true},
-};
-
-/**
- * fdt_build_clock_node
- *
- * Build a guest clock node, used as a dependency from a passthrough'ed
- * device. Most information are retrieved from the host clock node.
- * Also check the host clock is a fixed one.
- *
- * @host_fdt: host device tree blob from which info are retrieved
- * @guest_fdt: guest device tree blob where the clock node is added
- * @host_phandle: phandle of the clock in host device tree
- * @guest_phandle: phandle to assign to the guest node
- */
-static void fdt_build_clock_node(void *host_fdt, void *guest_fdt,
-                                uint32_t host_phandle,
-                                uint32_t guest_phandle)
-{
-    char *node_path = NULL;
-    char *nodename;
-    const void *r;
-    int ret, node_offset, prop_len, path_len = 16;
-
-    node_offset = fdt_node_offset_by_phandle(host_fdt, host_phandle);
-    if (node_offset <= 0) {
-        error_report("not able to locate clock handle %d in host device tree",
-                     host_phandle);
-        exit(1);
-    }
-    node_path = g_malloc(path_len);
-    while ((ret = fdt_get_path(host_fdt, node_offset, node_path, path_len))
-            == -FDT_ERR_NOSPACE) {
-        path_len += 16;
-        node_path = g_realloc(node_path, path_len);
-    }
-    if (ret < 0) {
-        error_report("not able to retrieve node path for clock handle %d",
-                     host_phandle);
-        exit(1);
-    }
-
-    r = qemu_fdt_getprop(host_fdt, node_path, "compatible", &prop_len,
-                         &error_fatal);
-    if (strcmp(r, "fixed-clock")) {
-        error_report("clock handle %d is not a fixed clock", host_phandle);
-        exit(1);
-    }
-
-    nodename = strrchr(node_path, '/');
-    qemu_fdt_add_subnode(guest_fdt, nodename);
-
-    copy_properties_from_host(clock_copied_properties,
-                              ARRAY_SIZE(clock_copied_properties),
-                              host_fdt, guest_fdt,
-                              node_path, nodename);
-
-    qemu_fdt_setprop_cell(guest_fdt, nodename, "phandle", guest_phandle);
-
-    g_free(node_path);
-}
-
-/**
- * sysfs_to_dt_name: convert the name found in sysfs into the node name
- * for instance e0900000.xgmac is converted into xgmac@e0900000
- * @sysfs_name: directory name in sysfs
- *
- * returns the device tree name upon success or NULL in case the sysfs name
- * does not match the expected format
- */
-static char *sysfs_to_dt_name(const char *sysfs_name)
-{
-    gchar **substrings =  g_strsplit(sysfs_name, ".", 2);
-    char *dt_name = NULL;
-
-    if (!substrings || !substrings[0] || !substrings[1]) {
-        goto out;
-    }
-    dt_name = g_strdup_printf("%s@%s", substrings[1], substrings[0]);
-out:
-    g_strfreev(substrings);
-    return dt_name;
-}
-
 /* Device Specific Code */
 
 /**
@@ -261,183 +124,6 @@ static int add_calxeda_midway_xgmac_fdt_node(SysBusDevice *sbdev, void *opaque)
     g_free(nodename);
     return 0;
 }
-
-/* AMD xgbe properties whose values are copied/pasted from host */
-static HostProperty amd_xgbe_copied_properties[] = {
-    {"compatible", false},
-    {"dma-coherent", true},
-    {"amd,per-channel-interrupt", true},
-    {"phy-mode", false},
-    {"mac-address", true},
-    {"amd,speed-set", false},
-    {"amd,serdes-blwc", true},
-    {"amd,serdes-cdr-rate", true},
-    {"amd,serdes-pq-skew", true},
-    {"amd,serdes-tx-amp", true},
-    {"amd,serdes-dfe-tap-config", true},
-    {"amd,serdes-dfe-tap-enable", true},
-    {"clock-names", false},
-};
-
-/**
- * add_amd_xgbe_fdt_node
- *
- * Generates the combined xgbe/phy node following kernel >=4.2
- * binding documentation:
- * Documentation/devicetree/bindings/net/amd-xgbe.txt:
- * Also 2 clock nodes are created (dma and ptp)
- *
- * Asserts in case of error
- */
-static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
-{
-    PlatformBusFDTData *data = opaque;
-    PlatformBusDevice *pbus = data->pbus;
-    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
-    VFIODevice *vbasedev = &vdev->vbasedev;
-    VFIOINTp *intp;
-    const char *parent_node = data->pbus_node_name;
-    char **node_path, *nodename, *dt_name;
-    void *guest_fdt = data->fdt, *host_fdt;
-    const void *r;
-    int i, prop_len;
-    uint32_t *irq_attr, *reg_attr;
-    const uint32_t *host_clock_phandles;
-    uint64_t mmio_base, irq_number;
-    uint32_t guest_clock_phandles[2];
-
-    host_fdt = load_device_tree_from_sysfs();
-
-    dt_name = sysfs_to_dt_name(vbasedev->name);
-    if (!dt_name) {
-        error_report("%s incorrect sysfs device name %s",
-                     __func__, vbasedev->name);
-        exit(1);
-    }
-    node_path = qemu_fdt_node_path(host_fdt, dt_name, vdev->compat,
-                                   &error_fatal);
-    if (!node_path || !node_path[0]) {
-        error_report("%s unable to retrieve node path for %s/%s",
-                     __func__, dt_name, vdev->compat);
-        exit(1);
-    }
-
-    if (node_path[1]) {
-        error_report("%s more than one node matching %s/%s!",
-                     __func__, dt_name, vdev->compat);
-        exit(1);
-    }
-
-    g_free(dt_name);
-
-    if (vbasedev->num_regions != 5) {
-        error_report("%s Does the host dt node combine XGBE/PHY?", __func__);
-        exit(1);
-    }
-
-    /* generate nodes for DMA_CLK and PTP_CLK */
-    r = qemu_fdt_getprop(host_fdt, node_path[0], "clocks",
-                         &prop_len, &error_fatal);
-    if (prop_len != 8) {
-        error_report("%s clocks property should contain 2 handles", __func__);
-        exit(1);
-    }
-    host_clock_phandles = r;
-    guest_clock_phandles[0] = qemu_fdt_alloc_phandle(guest_fdt);
-    guest_clock_phandles[1] = qemu_fdt_alloc_phandle(guest_fdt);
-
-    /**
-     * clock handles fetched from host dt are in be32 layout whereas
-     * rest of the code uses cpu layout. Also guest clock handles are
-     * in cpu layout.
-     */
-    fdt_build_clock_node(host_fdt, guest_fdt,
-                         be32_to_cpu(host_clock_phandles[0]),
-                         guest_clock_phandles[0]);
-
-    fdt_build_clock_node(host_fdt, guest_fdt,
-                         be32_to_cpu(host_clock_phandles[1]),
-                         guest_clock_phandles[1]);
-
-    /* combined XGBE/PHY node */
-    mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
-    nodename = g_strdup_printf("%s/%s@%" PRIx64, parent_node,
-                               vbasedev->name, mmio_base);
-    qemu_fdt_add_subnode(guest_fdt, nodename);
-
-    copy_properties_from_host(amd_xgbe_copied_properties,
-                       ARRAY_SIZE(amd_xgbe_copied_properties),
-                       host_fdt, guest_fdt,
-                       node_path[0], nodename);
-
-    qemu_fdt_setprop_cells(guest_fdt, nodename, "clocks",
-                           guest_clock_phandles[0],
-                           guest_clock_phandles[1]);
-
-    reg_attr = g_new(uint32_t, vbasedev->num_regions * 2);
-    for (i = 0; i < vbasedev->num_regions; i++) {
-        mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, i);
-        reg_attr[2 * i] = cpu_to_be32(mmio_base);
-        reg_attr[2 * i + 1] = cpu_to_be32(
-                                memory_region_size(vdev->regions[i]->mem));
-    }
-    qemu_fdt_setprop(guest_fdt, nodename, "reg", reg_attr,
-                     vbasedev->num_regions * 2 * sizeof(uint32_t));
-
-    irq_attr = g_new(uint32_t, vbasedev->num_irqs * 3);
-    for (i = 0; i < vbasedev->num_irqs; i++) {
-        irq_number = platform_bus_get_irqn(pbus, sbdev , i)
-                         + data->irq_start;
-        irq_attr[3 * i] = cpu_to_be32(GIC_FDT_IRQ_TYPE_SPI);
-        irq_attr[3 * i + 1] = cpu_to_be32(irq_number);
-        /*
-          * General device interrupt and PCS auto-negotiation interrupts are
-          * level-sensitive while the 4 per-channel interrupts are edge
-          * sensitive
-          */
-        QLIST_FOREACH(intp, &vdev->intp_list, next) {
-            if (intp->pin == i) {
-                break;
-            }
-        }
-        if (intp->flags & VFIO_IRQ_INFO_AUTOMASKED) {
-            irq_attr[3 * i + 2] = cpu_to_be32(GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        } else {
-            irq_attr[3 * i + 2] = cpu_to_be32(GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
-        }
-    }
-    qemu_fdt_setprop(guest_fdt, nodename, "interrupts",
-                     irq_attr, vbasedev->num_irqs * 3 * sizeof(uint32_t));
-
-    g_free(host_fdt);
-    g_strfreev(node_path);
-    g_free(irq_attr);
-    g_free(reg_attr);
-    g_free(nodename);
-    return 0;
-}
-
-/* DT compatible matching */
-static bool vfio_platform_match(SysBusDevice *sbdev,
-                                const BindingEntry *entry)
-{
-    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
-    const char *compat;
-    unsigned int n;
-
-    for (n = vdev->num_compat, compat = vdev->compat; n > 0;
-         n--, compat += strlen(compat) + 1) {
-        if (!strcmp(entry->compat, compat)) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
-#define VFIO_PLATFORM_BINDING(compat, add_fn) \
-    {TYPE_VFIO_PLATFORM, (compat), (add_fn), vfio_platform_match}
-
 #endif /* CONFIG_LINUX */
 
 #ifdef CONFIG_TPM
@@ -512,8 +198,6 @@ static bool type_match(SysBusDevice *sbdev, const BindingEntry *entry)
 static const BindingEntry bindings[] = {
 #ifdef CONFIG_LINUX
     TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
-    TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
-    VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
 #endif
 #ifdef CONFIG_TPM
     TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
deleted file mode 100644
index 58f590e385b90ac39464f96b7b896e7f845e5271..0000000000000000000000000000000000000000
--- a/hw/vfio/amd-xgbe.c
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * AMD XGBE VFIO device
- *
- * Copyright Linaro Limited, 2015
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
-#include "hw/vfio/vfio-amd-xgbe.h"
-#include "migration/vmstate.h"
-#include "qemu/module.h"
-#include "qemu/error-report.h"
-
-static void amd_xgbe_realize(DeviceState *dev, Error **errp)
-{
-    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(dev);
-    VFIOAmdXgbeDeviceClass *k = VFIO_AMD_XGBE_DEVICE_GET_CLASS(dev);
-
-    warn_report("-device vfio-amd-xgbe is deprecated");
-    vdev->compat = g_strdup("amd,xgbe-seattle-v1a");
-    vdev->num_compat = 1;
-
-    k->parent_realize(dev, errp);
-}
-
-static const VMStateDescription vfio_platform_amd_xgbe_vmstate = {
-    .name = "vfio-amd-xgbe",
-    .unmigratable = 1,
-};
-
-static void vfio_amd_xgbe_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VFIOAmdXgbeDeviceClass *vcxc =
-        VFIO_AMD_XGBE_DEVICE_CLASS(klass);
-    device_class_set_parent_realize(dc, amd_xgbe_realize,
-                                    &vcxc->parent_realize);
-    dc->desc = "VFIO AMD XGBE";
-    dc->vmsd = &vfio_platform_amd_xgbe_vmstate;
-}
-
-static const TypeInfo vfio_amd_xgbe_dev_info = {
-    .name = TYPE_VFIO_AMD_XGBE,
-    .parent = TYPE_VFIO_PLATFORM,
-    .instance_size = sizeof(VFIOAmdXgbeDevice),
-    .class_init = vfio_amd_xgbe_class_init,
-    .class_size = sizeof(VFIOAmdXgbeDeviceClass),
-};
-
-static void register_amd_xgbe_dev_type(void)
-{
-    type_register_static(&vfio_amd_xgbe_dev_info);
-}
-
-type_init(register_amd_xgbe_dev_type)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2aa4b5d77864ff01e69650711e7d914f351e9966..64b2ec87b59b12601e28023cd8a5ae925f101a77 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -5,7 +5,6 @@ config ARM_VIRT
     depends on TCG || KVM || HVF
     imply PCI_DEVICES
     imply TEST_DEVICES
-    imply VFIO_AMD_XGBE
     imply VFIO_PLATFORM
     imply VFIO_XGMAC
     imply TPM_TIS_SYSBUS
diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index 91d9023b79b594975c6c5f65273011b89240691c..bc984f198639627043a88ecab95da4e927355e5a 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -28,11 +28,6 @@ config VFIO_XGMAC
     default y
     depends on VFIO_PLATFORM
 
-config VFIO_AMD_XGBE
-    bool
-    default y
-    depends on VFIO_PLATFORM
-
 config VFIO_AP
     bool
     default y
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index bfaf6be805483d46190232bd6805a7a042380a0d..0edcaf5155c8853d165d03e4a3ae514f77ca5e8c 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -20,7 +20,6 @@ vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
 system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
-system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'cpr.c',
   'cpr-legacy.c',
-- 
2.51.0


