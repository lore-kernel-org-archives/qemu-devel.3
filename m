Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86804EE20A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 13:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voLkz-0006rh-Rw; Fri, 06 Feb 2026 08:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1voLkV-0006nH-8N
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:19:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1voLkD-0004pE-Pl
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770383750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4vbzr6E1tBrLZYj7Qc+2PUxK89aHU39vyY12eXtjJOE=;
 b=ejG+gME5K/j51gvBL24PQeXiCO38CugrAbuGmcxXb4XYYnH72nX1L+o4fPM81NQwmvcKOw
 u2GXgJJ/EPEqMhdyKgQasLLyH9pvf+uF5RtHXoDk2JIdMw7usyUzNxOuMZOylaW5kHIwE3
 UCIfCOHB9/Y75FHBgHgKolKhj/46xd8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-uZMG3gArPDay2ff6RFwB6g-1; Fri,
 06 Feb 2026 08:15:47 -0500
X-MC-Unique: uZMG3gArPDay2ff6RFwB6g-1
X-Mimecast-MFC-AGG-ID: uZMG3gArPDay2ff6RFwB6g_1770383745
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1C391954B16; Fri,  6 Feb 2026 13:15:07 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73EB918003F6; Fri,  6 Feb 2026 13:15:05 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Subject: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT ACPI
 table
Date: Fri,  6 Feb 2026 14:14:35 +0100
Message-ID: <20260206131438.1857182-9-imammedo@redhat.com>
In-Reply-To: <20260206131438.1857182-1-imammedo@redhat.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add SBSA generic watchdog to virt machine type with
all necessary wiring for ACPI watchdog. Which includes
setting its frequency to 1KHz (max that WDAT is able to handle).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/wdat-gwdt.h | 19 ++++++++
 include/hw/arm/virt.h       |  3 ++
 hw/acpi/meson.build         |  2 +
 hw/acpi/wdat-gwdt-stub.c    | 16 +++++++
 hw/acpi/wdat-gwdt.c         | 92 +++++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig              |  1 +
 hw/arm/virt-acpi-build.c    | 16 +++++++
 hw/arm/virt.c               | 26 +++++++++++
 8 files changed, 175 insertions(+)
 create mode 100644 include/hw/acpi/wdat-gwdt.h
 create mode 100644 hw/acpi/wdat-gwdt-stub.c
 create mode 100644 hw/acpi/wdat-gwdt.c

diff --git a/include/hw/acpi/wdat-gwdt.h b/include/hw/acpi/wdat-gwdt.h
new file mode 100644
index 0000000000..42339e031e
--- /dev/null
+++ b/include/hw/acpi/wdat-gwdt.h
@@ -0,0 +1,19 @@
+/*
+ * GWDT Watchdog Action Table (WDAT) definition
+ *
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_HW_ACPI_WDAT_GWDT_H
+#define QEMU_HW_ACPI_WDAT_GWDT_H
+
+#include "hw/acpi/aml-build.h"
+#include "hw/watchdog/sbsa_gwdt.h"
+
+void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
+                     uint64_t freq);
+
+#endif /* QEMU_HW_ACPI_WDAT_GWDT_H */
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 3b382bdf49..d47bb8a72d 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -82,6 +82,9 @@ enum {
     VIRT_NVDIMM_ACPI,
     VIRT_PVTIME,
     VIRT_ACPI_PCIHP,
+    VIRT_GWDT_WS0,
+    VIRT_GWDT_REFRESH,
+    VIRT_GWDT_CONTROL,
     VIRT_LOWMEMMAP_LAST,
 };
 
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index ba974b2f0f..200b525ae1 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -28,12 +28,14 @@ acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ic
 acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
 acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: files('ipmi-stub.c'))
 acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
+acpi_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('wdat-gwdt.c'))
 if have_tpm
   acpi_ss.add(files('tpm.c'))
 endif
 system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
 system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
 system_ss.add(when: 'CONFIG_ACPI_ICH9', if_false: files('wdat-ich9-stub.c'))
+system_ss.add(when: 'CONFIG_WDT_SBSA', if_false: files('wdat-gwdt-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
 system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
diff --git a/hw/acpi/wdat-gwdt-stub.c b/hw/acpi/wdat-gwdt-stub.c
new file mode 100644
index 0000000000..4d43783f70
--- /dev/null
+++ b/hw/acpi/wdat-gwdt-stub.c
@@ -0,0 +1,16 @@
+/*
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/wdat-gwdt.h"
+
+void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
+                     uint64_t freq)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/acpi/wdat-gwdt.c b/hw/acpi/wdat-gwdt.c
new file mode 100644
index 0000000000..226ba3f01e
--- /dev/null
+++ b/hw/acpi/wdat-gwdt.c
@@ -0,0 +1,92 @@
+/*
+ * SBSA GWDT Watchdog Action Table (WDAT)
+ *
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/wdat-gwdt.h"
+#include "hw/acpi/wdat.h"
+#include "hw/watchdog/sbsa_gwdt.h"
+
+#define GWDT_REG(base, reg_offset, reg_width) { \
+                 .space_id = AML_AS_SYSTEM_MEMORY, \
+                 .address = base + reg_offset, .bit_width = reg_width, \
+                 .access_width = AML_DWORD_ACC };
+
+/*
+ *   "Hardware Watchdog Timers Design Specification"
+ *       https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
+ */
+void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
+                     uint64_t freq)
+{
+    AcpiTable table = { .sig = "WDAT", .rev = 1, .oem_id = oem_id,
+                        .oem_table_id = oem_table_id };
+
+    struct AcpiGenericAddress wrr =  GWDT_REG(rbase, 0x0, 32);
+    struct AcpiGenericAddress wor_l =  GWDT_REG(cbase, SBSA_GWDT_WOR, 32);
+    struct AcpiGenericAddress wcs =  GWDT_REG(cbase, SBSA_GWDT_WCS, 32);
+
+    acpi_table_begin(&table, table_data);
+    build_append_int_noprefix(table_data, 0x20, 4); /* Watchdog Header Length */
+    build_append_int_noprefix(table_data, 0xff, 2); /* PCI Segment */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Bus Number */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Device Number */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Function Number */
+    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
+    /*
+     * WDAT spec suports only 1KHz or more coarse watchdog timer,
+     * Set resolution to minimum supported 1ms.
+     * Before starting watchdog Windows set countdown value to 5min.
+     */
+    g_assert(freq <= 1000);
+    build_append_int_noprefix(table_data, 1, 4);/* Timer Period, ms */
+    /*
+     * Needs to be more than 4min, otherwise Windows 11 won't start watchdog.
+     * Set max to limits to arbitrary max 10min and min to 5sec.
+     */
+    build_append_int_noprefix(table_data, 600 * freq, 4);/* Maximum Count */
+    build_append_int_noprefix(table_data, 5 * freq, 4);  /* Minimum Count */
+    /*
+     * WATCHDOG_ENABLED
+     */
+    build_append_int_noprefix(table_data, 0x81, 1); /* Watchdog Flags */
+    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
+    /*
+     * watchdog instruction entries
+     */
+    build_append_int_noprefix(table_data, 8, 4);
+    /* Action table */
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_RUNNING_STATE,
+        WDAT_INS_READ_VALUE,
+        wcs, 0x1, 0x1);
+    build_append_wdat_ins(table_data, WDAT_ACTION_RESET,
+        WDAT_INS_WRITE_VALUE,
+        wrr, 0x1, 0x7);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_COUNTDOWN_PERIOD,
+        WDAT_INS_WRITE_COUNTDOWN,
+        wor_l, 0, 0xffffffff);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_RUNNING_STATE,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        wcs, 1, 0x00000001);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_STOPPED_STATE,
+        WDAT_INS_READ_VALUE,
+        wcs, 0x0, 0x00000001);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_STOPPED_STATE,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        wcs, 0x0, 0x00000001);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_WATCHDOG_STATUS,
+        WDAT_INS_READ_VALUE,
+        wcs, 0x4, 0x00000004);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_WATCHDOG_STATUS,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        wrr, 0x4, 0x4);
+
+    acpi_table_end(linker, &table);
+}
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c66c452737..1222efadd1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -36,6 +36,7 @@ config ARM_VIRT
     select VIRTIO_MEM_SUPPORTED
     select ACPI_CXL
     select ACPI_HMAT
+    select WDT_SBSA
 
 config CUBIEBOARD
     bool
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c145678185..51a1c040a4 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -64,6 +64,7 @@
 #include "hw/virtio/virtio-acpi.h"
 #include "target/arm/cpu.h"
 #include "target/arm/multiprocessing.h"
+#include "hw/acpi/wdat-gwdt.h"
 
 #define ARM_SPI_BASE 32
 
@@ -1270,6 +1271,21 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_madt(tables_blob, tables->linker, vms);
 
+    acpi_add_table(table_offsets, tables_blob);
+    if (ms->acpi_watchdog) {
+        uint64_t freq;
+
+        freq = object_property_get_uint(
+            object_resolve_type_unambiguous(TYPE_WDT_SBSA, &error_abort),
+            "clock-frequency", &error_abort);
+
+        build_gwdt_wdat(tables_blob, tables->linker,
+                        vms->oem_id, vms->oem_table_id,
+                        vms->memmap[VIRT_GWDT_REFRESH].base,
+                        vms->memmap[VIRT_GWDT_CONTROL].base,
+                        freq);
+    }
+
     if (!vmc->no_cpu_topology) {
         acpi_add_table(table_offsets, tables_blob);
         build_pptt(tables_blob, tables->linker, ms,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 390845c503..caf5700ed2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -93,6 +93,7 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
+#include "hw/watchdog/sbsa_gwdt.h"
 
 static GlobalProperty arm_virt_compat[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -194,6 +195,8 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
     [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
     [VIRT_ACPI_PCIHP] =         { 0x090c0000, ACPI_PCIHP_SIZE },
+    [VIRT_GWDT_REFRESH] =       { 0x090d0000, 0x00001000 },
+    [VIRT_GWDT_CONTROL] =       { 0x090d1000, 0x00001000 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -245,12 +248,32 @@ static const int a15irqmap[] = {
     [VIRT_GPIO] = 7,
     [VIRT_UART1] = 8,
     [VIRT_ACPI_GED] = 9,
+    [VIRT_GWDT_WS0] = 10,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
     [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
+static void create_wdt(const VirtMachineState *vms)
+{
+    hwaddr rbase = vms->memmap[VIRT_GWDT_REFRESH].base;
+    hwaddr cbase = vms->memmap[VIRT_GWDT_CONTROL].base;
+    int irq = vms->irqmap[VIRT_GWDT_WS0];
+    DeviceState *dev = qdev_new(TYPE_WDT_SBSA);
+    SysBusDevice *s = SYS_BUS_DEVICE(dev);
+
+    /*
+     * Set watchdog tick freq to 1Kz as it's the max WDAT driver
+     * is able to handle.
+     */
+    qdev_prop_set_uint64(dev, "clock-frequency", 1000 /* 1KHz */);
+    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_mmio_map(s, 0, rbase);
+    sysbus_mmio_map(s, 1, cbase);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
+}
+
 static void create_randomness(MachineState *ms, const char *node)
 {
     struct {
@@ -2515,6 +2538,9 @@ static void machvirt_init(MachineState *machine)
     vms->highmem_ecam &= (!firmware_loaded || aarch64);
 
     create_rtc(vms);
+    if (machine->acpi_watchdog) {
+        create_wdt(vms);
+    }
 
     create_pcie(vms);
     create_cxl_host_reg_region(vms);
-- 
2.47.3


