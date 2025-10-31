Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0E2CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 14:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEq7f-0007Tg-Gh; Fri, 31 Oct 2025 10:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vEq7Z-0007TH-6f
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 10:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vEq7O-00087x-HZ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 10:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761920914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVxH/2PDVkL3Qb/UujNIvwb469Ron62wSbKBKwgulLc=;
 b=QwuT/DmfHi4flbE8f8GNFNQ2gKCP8YizJvh7MLjqWBz5ICa8FTuCAN0MrqB90eWQQoLPqh
 wWs23q6z3GULE3MD9qssBCYrO8/fzjxqsLat2ZsxUMVddbs/9g95gNi3l7IoF6fO7Tazn2
 HGRPoE5jSQvdywcZj10PUSfVN60UUIo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-UWisoiQWPjqnMzf_9a-JwQ-1; Fri,
 31 Oct 2025 10:28:30 -0400
X-MC-Unique: UWisoiQWPjqnMzf_9a-JwQ-1
X-Mimecast-MFC-AGG-ID: UWisoiQWPjqnMzf_9a-JwQ_1761920909
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73924180057A; Fri, 31 Oct 2025 14:28:29 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57DCB1955BE3; Fri, 31 Oct 2025 14:28:28 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5] hw/i386/pc: Remove PCMachineClass::legacy_cpu_hotplug field
Date: Fri, 31 Oct 2025 15:28:25 +0100
Message-ID: <20251031142825.179239-1-imammedo@redhat.com>
In-Reply-To: <20250508133550.81391-3-philmd@linaro.org>
References: <20250508133550.81391-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

For compatibility reasons PC/Q35 will start with legacy
CPU hotplug interface by default but with new CPU hotplug
AML code since 2.7 machine type. That way legacy firmware
that doesn't use QEMU generated ACPI tables was able to
continue using legacy CPU hotplug interface.

While later machine types, with firmware supporting QEMU
provided ACPI tables, generate new CPU hotplug AML,
which will switch to new CPU hotplug interface when
guest OS executes its _INI method on ACPI tables
loading.

Since 2.6 machine type is now gone, drop legacy CPU hotplug
code (both ACPI and related hardware bits) and initialize
'modern' hotplug from the very beginning.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
   PS:
   it does compile but I do not remember if I've actually tested hotplug path
  
---
 include/hw/acpi/cpu.h                       |   1 -
 include/hw/acpi/cpu_hotplug.h               |  37 ------
 include/hw/acpi/ich9.h                      |   3 -
 include/hw/acpi/piix4.h                     |   4 +-
 tests/qtest/bios-tables-test-allowed-diff.h |  42 +++++++
 hw/acpi/acpi-cpu-hotplug-stub.c             |  18 +--
 hw/acpi/cpu.c                               |  10 --
 hw/acpi/cpu_hotplug.c                       | 118 --------------------
 hw/acpi/generic_event_device.c              |   1 +
 hw/acpi/ich9.c                              |  61 ++--------
 hw/acpi/meson.build                         |   2 +-
 hw/acpi/piix4.c                             |  60 ++--------
 hw/i386/acpi-build.c                        |   4 +-
 hw/i386/pc.c                                |   3 +-
 hw/i386/pc_piix.c                           |   2 -
 hw/i386/pc_q35.c                            |   2 -
 hw/i386/x86-common.c                        |   1 -
 hw/loongarch/virt-acpi-build.c              |   1 -
 18 files changed, 65 insertions(+), 305 deletions(-)
 delete mode 100644 include/hw/acpi/cpu_hotplug.h
 delete mode 100644 hw/acpi/cpu_hotplug.c

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 32654dc274..2cb0ca4f3d 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -54,7 +54,6 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
 
 typedef struct CPUHotplugFeatures {
     bool acpi_1_compatible;
-    bool has_legacy_cphp;
     bool fw_unplugs_cpu;
     const char *smi_path;
 } CPUHotplugFeatures;
diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
deleted file mode 100644
index aeee630cf0..0000000000
--- a/include/hw/acpi/cpu_hotplug.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * QEMU ACPI hotplug utilities
- *
- * Copyright (C) 2013 Red Hat Inc
- *
- * Authors:
- *   Igor Mammedov <imammedo@redhat.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef HW_ACPI_CPU_HOTPLUG_H
-#define HW_ACPI_CPU_HOTPLUG_H
-
-#include "hw/acpi/acpi.h"
-#include "hw/acpi/pc-hotplug.h"
-#include "hw/acpi/aml-build.h"
-#include "hw/hotplug.h"
-#include "hw/acpi/cpu.h"
-
-typedef struct AcpiCpuHotplug {
-    Object *device;
-    MemoryRegion io;
-    uint8_t sts[ACPI_GPE_PROC_LEN];
-} AcpiCpuHotplug;
-
-void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
-                             AcpiCpuHotplug *g, DeviceState *dev, Error **errp);
-
-void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
-                                  AcpiCpuHotplug *gpe_cpu, uint16_t base);
-
-void acpi_switch_to_modern_cphp(AcpiCpuHotplug *gpe_cpu,
-                                CPUHotplugState *cpuhp_state,
-                                uint16_t io_port);
-#endif
diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 245fe08dc2..5a1986edbd 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -22,7 +22,6 @@
 #define HW_ACPI_ICH9_H
 
 #include "hw/acpi/acpi.h"
-#include "hw/acpi/cpu_hotplug.h"
 #include "hw/acpi/cpu.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/acpi/memory_hotplug.h"
@@ -53,8 +52,6 @@ typedef struct ICH9LPCPMRegs {
     uint32_t pm_io_base;
     Notifier powerdown_notifier;
 
-    bool cpu_hotplug_legacy;
-    AcpiCpuHotplug gpe_cpu;
     CPUHotplugState cpuhp_state;
 
     bool keep_pci_slot_hpc;
diff --git a/include/hw/acpi/piix4.h b/include/hw/acpi/piix4.h
index eb1c122d80..863382a814 100644
--- a/include/hw/acpi/piix4.h
+++ b/include/hw/acpi/piix4.h
@@ -24,11 +24,11 @@
 
 #include "hw/pci/pci_device.h"
 #include "hw/acpi/acpi.h"
-#include "hw/acpi/cpu_hotplug.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/isa/apm.h"
+#include "hw/acpi/cpu.h"
 
 #define TYPE_PIIX4_PM "PIIX4_PM"
 OBJECT_DECLARE_SIMPLE_TYPE(PIIX4PMState, PIIX4_PM)
@@ -63,8 +63,6 @@ struct PIIX4PMState {
     uint8_t disable_s4;
     uint8_t s4_val;
 
-    bool cpu_hotplug_legacy;
-    AcpiCpuHotplug gpe_cpu;
     CPUHotplugState cpuhp_state;
 
     MemHotplugState acpi_memory_hotplug;
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..7191854857 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,43 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT",
+"tests/data/acpi/x86/q35/DSDT",
+"tests/data/acpi/x86/pc/DSDT.bridge",
+"tests/data/acpi/x86/pc/DSDT.ipmikcs",
+"tests/data/acpi/x86/pc/DSDT.cphp",
+"tests/data/acpi/x86/pc/DSDT.numamem",
+"tests/data/acpi/x86/pc/DSDT.nohpet",
+"tests/data/acpi/x86/pc/DSDT.memhp",
+"tests/data/acpi/x86/pc/DSDT.dimmpxm",
+"tests/data/acpi/x86/pc/DSDT.acpihmat",
+"tests/data/acpi/x86/pc/DSDT.acpierst",
+"tests/data/acpi/x86/pc/DSDT.roothp",
+"tests/data/acpi/x86/pc/DSDT.hpbridge",
+"tests/data/acpi/x86/pc/DSDT.hpbrroot",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
+"tests/data/acpi/x86/q35/DSDT.bridge",
+"tests/data/acpi/x86/q35/DSDT.noacpihp",
+"tests/data/acpi/x86/q35/DSDT.multi-bridge",
+"tests/data/acpi/x86/q35/DSDT.ipmibt",
+"tests/data/acpi/x86/q35/DSDT.cphp",
+"tests/data/acpi/x86/q35/DSDT.numamem",
+"tests/data/acpi/x86/q35/DSDT.nohpet",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/DSDT.memhp",
+"tests/data/acpi/x86/q35/DSDT.dimmpxm",
+"tests/data/acpi/x86/q35/DSDT.acpihmat",
+"tests/data/acpi/x86/q35/DSDT.mmio64",
+"tests/data/acpi/x86/q35/DSDT.acpierst",
+"tests/data/acpi/x86/q35/DSDT.applesmc",
+"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
+"tests/data/acpi/x86/q35/DSDT.ivrs",
+"tests/data/acpi/x86/q35/DSDT.type4-count",
+"tests/data/acpi/x86/q35/DSDT.core-count",
+"tests/data/acpi/x86/q35/DSDT.core-count2",
+"tests/data/acpi/x86/q35/DSDT.thread-count",
+"tests/data/acpi/x86/q35/DSDT.thread-count2",
+"tests/data/acpi/x86/q35/DSDT.viot",
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.ipmismbus",
+"tests/data/acpi/x86/q35/DSDT.xapic",
diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
index 9872dd55e4..ad5d862032 100644
--- a/hw/acpi/acpi-cpu-hotplug-stub.c
+++ b/hw/acpi/acpi-cpu-hotplug-stub.c
@@ -1,22 +1,11 @@
 #include "qemu/osdep.h"
-#include "hw/acpi/cpu_hotplug.h"
 #include "migration/vmstate.h"
+#include "hw/acpi/cpu.h"
 
 
 /* Following stubs are all related to ACPI cpu hotplug */
 const VMStateDescription vmstate_cpu_hotplug;
 
-void acpi_switch_to_modern_cphp(AcpiCpuHotplug *gpe_cpu,
-                                CPUHotplugState *cpuhp_state,
-                                uint16_t io_port)
-{
-}
-
-void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
-                                  AcpiCpuHotplug *gpe_cpu, uint16_t base)
-{
-}
-
 void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
                          CPUHotplugState *state, hwaddr base_addr)
 {
@@ -31,11 +20,6 @@ void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
 {
 }
 
-void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
-                             AcpiCpuHotplug *g, DeviceState *dev, Error **errp)
-{
-}
-
 void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
                         DeviceState *dev, Error **errp)
 {
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 6f1ae79edb..d63ca83c1b 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -408,16 +408,6 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         aml_append(field, aml_reserved_field(4 * 8));
         aml_append(field, aml_named_field(CPU_DATA, 32));
         aml_append(cpu_ctrl_dev, field);
-
-        if (opts.has_legacy_cphp) {
-            method = aml_method("_INI", 0, AML_SERIALIZED);
-            /* switch off legacy CPU hotplug HW and use new one,
-             * on reboot system is in new mode and writing 0
-             * in CPU_SELECTOR selects BSP, which is NOP at
-             * the time _INI is called */
-            aml_append(method, aml_store(zero, aml_name(CPU_SELECTOR)));
-            aml_append(cpu_ctrl_dev, method);
-        }
     }
     aml_append(sb_scope, cpu_ctrl_dev);
 
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
deleted file mode 100644
index fe439705bd..0000000000
--- a/hw/acpi/cpu_hotplug.c
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * QEMU ACPI hotplug utilities
- *
- * Copyright (C) 2013 Red Hat Inc
- *
- * Authors:
- *   Igor Mammedov <imammedo@redhat.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-#include "qemu/osdep.h"
-#include "hw/acpi/cpu_hotplug.h"
-#include "qapi/error.h"
-#include "hw/core/cpu.h"
-#include "hw/i386/x86.h"
-#include "hw/pci/pci_device.h"
-#include "qemu/error-report.h"
-
-#define CPU_EJECT_METHOD "CPEJ"
-#define CPU_MAT_METHOD "CPMA"
-#define CPU_ON_BITMAP "CPON"
-#define CPU_STATUS_METHOD "CPST"
-#define CPU_STATUS_MAP "PRS"
-#define CPU_SCAN_METHOD "PRSC"
-
-static uint64_t cpu_status_read(void *opaque, hwaddr addr, unsigned int size)
-{
-    AcpiCpuHotplug *cpus = opaque;
-    uint64_t val = cpus->sts[addr];
-
-    return val;
-}
-
-static void cpu_status_write(void *opaque, hwaddr addr, uint64_t data,
-                             unsigned int size)
-{
-    /* firmware never used to write in CPU present bitmap so use
-       this fact as means to switch QEMU into modern CPU hotplug
-       mode by writing 0 at the beginning of legacy CPU bitmap
-     */
-    if (addr == 0 && data == 0) {
-        AcpiCpuHotplug *cpus = opaque;
-        object_property_set_bool(cpus->device, "cpu-hotplug-legacy", false,
-                                 &error_abort);
-    }
-}
-
-static const MemoryRegionOps AcpiCpuHotplug_ops = {
-    .read = cpu_status_read,
-    .write = cpu_status_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4,
-    },
-    .impl = {
-        .max_access_size = 1,
-    },
-};
-
-static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu,
-                                     bool *swtchd_to_modern)
-{
-    int64_t cpu_id;
-
-    cpu_id = cpu->cc->get_arch_id(cpu);
-    if ((cpu_id / 8) >= ACPI_GPE_PROC_LEN) {
-        object_property_set_bool(g->device, "cpu-hotplug-legacy", false,
-                                 &error_abort);
-        *swtchd_to_modern = true;
-        return;
-    }
-
-    *swtchd_to_modern = false;
-    g->sts[cpu_id / 8] |= (1 << (cpu_id % 8));
-}
-
-void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
-                             AcpiCpuHotplug *g, DeviceState *dev, Error **errp)
-{
-    bool swtchd_to_modern;
-    Error *local_err = NULL;
-
-    acpi_set_cpu_present_bit(g, CPU(dev), &swtchd_to_modern);
-    if (swtchd_to_modern) {
-        /* propagate the hotplug to the modern interface */
-        hotplug_handler_plug(hotplug_dev, dev, &local_err);
-    } else {
-        acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
-    }
-}
-
-void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
-                                  AcpiCpuHotplug *gpe_cpu, uint16_t base)
-{
-    CPUState *cpu;
-    bool swtchd_to_modern;
-
-    memory_region_init_io(&gpe_cpu->io, owner, &AcpiCpuHotplug_ops,
-                          gpe_cpu, "acpi-cpu-hotplug", ACPI_GPE_PROC_LEN);
-    memory_region_add_subregion(parent, base, &gpe_cpu->io);
-    gpe_cpu->device = owner;
-
-    CPU_FOREACH(cpu) {
-        acpi_set_cpu_present_bit(gpe_cpu, cpu, &swtchd_to_modern);
-    }
-}
-
-void acpi_switch_to_modern_cphp(AcpiCpuHotplug *gpe_cpu,
-                                CPUHotplugState *cpuhp_state,
-                                uint16_t io_port)
-{
-    MemoryRegion *parent = pci_address_space_io(PCI_DEVICE(gpe_cpu->device));
-
-    memory_region_del_subregion(parent, &gpe_cpu->io);
-    cpu_hotplug_hw_init(parent, gpe_cpu->device, cpuhp_state, io_port);
-}
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index e7b773d84d..9d0962d602 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pcihp.h"
+#include "hw/acpi/cpu.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/pci/pci.h"
 #include "hw/irq.h"
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 2b3b493c01..bbb1bd60a2 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -40,6 +40,7 @@
 #include "hw/southbridge/ich9.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/acpi/pc-hotplug.h"
 
 static void ich9_pm_update_sci_fn(ACPIREGS *regs)
 {
@@ -183,26 +184,10 @@ static const VMStateDescription vmstate_tco_io_state = {
     }
 };
 
-static bool vmstate_test_use_cpuhp(void *opaque)
-{
-    ICH9LPCPMRegs *s = opaque;
-    return !s->cpu_hotplug_legacy;
-}
-
-static int vmstate_cpuhp_pre_load(void *opaque)
-{
-    ICH9LPCPMRegs *s = opaque;
-    Object *obj = OBJECT(s->gpe_cpu.device);
-    object_property_set_bool(obj, "cpu-hotplug-legacy", false, &error_abort);
-    return 0;
-}
-
 static const VMStateDescription vmstate_cpuhp_state = {
     .name = "ich9_pm/cpuhp",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = vmstate_test_use_cpuhp,
-    .pre_load = vmstate_cpuhp_pre_load,
     .fields = (const VMStateField[]) {
         VMSTATE_CPU_HOTPLUG(cpuhp_state, ICH9LPCPMRegs),
         VMSTATE_END_OF_LIST()
@@ -338,8 +323,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
     pm->powerdown_notifier.notify = pm_powerdown_req;
     qemu_register_powerdown_notifier(&pm->powerdown_notifier);
 
-    legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
-        OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
+    cpu_hotplug_hw_init(pci_address_space_io(lpc_pci),
+        OBJECT(lpc_pci), &pm->cpuhp_state, ICH9_CPU_HOTPLUG_IO_BASE);
 
     acpi_memory_hotplug_init(pci_address_space_io(lpc_pci), OBJECT(lpc_pci),
                              &pm->acpi_memory_hotplug,
@@ -355,26 +340,6 @@ static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
-static bool ich9_pm_get_cpu_hotplug_legacy(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    return s->pm.cpu_hotplug_legacy;
-}
-
-static void ich9_pm_set_cpu_hotplug_legacy(Object *obj, bool value,
-                                           Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    assert(!value);
-    if (s->pm.cpu_hotplug_legacy && value == false) {
-        acpi_switch_to_modern_cphp(&s->pm.gpe_cpu, &s->pm.cpuhp_state,
-                                   ICH9_CPU_HOTPLUG_IO_BASE);
-    }
-    s->pm.cpu_hotplug_legacy = value;
-}
-
 static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
 {
     ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
@@ -419,7 +384,6 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
 {
     static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
     pm->acpi_memory_hotplug.is_enabled = true;
-    pm->cpu_hotplug_legacy = true;
     pm->disable_s3 = 0;
     pm->disable_s4 = 0;
     pm->s4_val = 2;
@@ -438,9 +402,6 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                         NULL, NULL, pm);
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
                                    &gpe0_len, OBJ_PROP_FLAG_READ);
-    object_property_add_bool(obj, "cpu-hotplug-legacy",
-                             ich9_pm_get_cpu_hotplug_legacy,
-                             ich9_pm_set_cpu_hotplug_legacy);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
                                   &pm->disable_s3, OBJ_PROP_FLAG_READWRITE);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
@@ -493,11 +454,7 @@ void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 dev, errp);
         }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        if (lpc->pm.cpu_hotplug_legacy) {
-            legacy_acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.gpe_cpu, dev, errp);
-        } else {
-            acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.cpuhp_state, dev, errp);
-        }
+        acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.cpuhp_state, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         acpi_pcihp_device_plug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
                                   dev, errp);
@@ -516,8 +473,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
         acpi_memory_unplug_request_cb(hotplug_dev,
                                       &lpc->pm.acpi_memory_hotplug, dev,
                                       errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
-               !lpc->pm.cpu_hotplug_legacy) {
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         uint64_t negotiated = lpc->smi_negotiated_features;
 
         if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
@@ -549,8 +505,7 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         acpi_memory_unplug_cb(&lpc->pm.acpi_memory_hotplug, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
-               !lpc->pm.cpu_hotplug_legacy) {
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         acpi_cpu_unplug_cb(&lpc->pm.cpuhp_state, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         acpi_pcihp_device_unplug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
@@ -572,7 +527,5 @@ void ich9_pm_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
     ICH9LPCState *s = ICH9_LPC_DEVICE(adev);
 
     acpi_memory_ospm_status(&s->pm.acpi_memory_hotplug, list);
-    if (!s->pm.cpu_hotplug_legacy) {
-        acpi_cpu_ospm_status(&s->pm.cpuhp_state, list);
-    }
+    acpi_cpu_ospm_status(&s->pm.cpuhp_state, list);
 }
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 56b5d1ec96..66c978aae8 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -6,7 +6,7 @@ acpi_ss.add(files(
   'core.c',
   'utils.c',
 ))
-acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu.c', 'cpu_hotplug.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_false: files('acpi-cpu-hotplug-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_true: files('memory_hotplug.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_false: files('acpi-mem-hotplug-stub.c'))
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 7a18f18dda..fa4358da15 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -33,7 +33,6 @@
 #include "system/xen.h"
 #include "qapi/error.h"
 #include "qemu/range.h"
-#include "hw/acpi/cpu_hotplug.h"
 #include "hw/acpi/cpu.h"
 #include "hw/hotplug.h"
 #include "hw/mem/pc-dimm.h"
@@ -43,6 +42,7 @@
 #include "migration/vmstate.h"
 #include "hw/core/cpu.h"
 #include "qom/object.h"
+#include "hw/acpi/pc-hotplug.h"
 
 #define GPE_BASE 0xafe0
 #define GPE_LEN 4
@@ -195,25 +195,10 @@ static const VMStateDescription vmstate_memhp_state = {
     }
 };
 
-static bool vmstate_test_use_cpuhp(void *opaque)
-{
-    PIIX4PMState *s = opaque;
-    return !s->cpu_hotplug_legacy;
-}
-
-static int vmstate_cpuhp_pre_load(void *opaque)
-{
-    Object *obj = OBJECT(opaque);
-    object_property_set_bool(obj, "cpu-hotplug-legacy", false, &error_abort);
-    return 0;
-}
-
 static const VMStateDescription vmstate_cpuhp_state = {
     .name = "piix4_pm/cpuhp",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = vmstate_test_use_cpuhp,
-    .pre_load = vmstate_cpuhp_pre_load,
     .fields = (const VMStateField[]) {
         VMSTATE_CPU_HOTPLUG(cpuhp_state, PIIX4PMState),
         VMSTATE_END_OF_LIST()
@@ -351,11 +336,7 @@ static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        if (s->cpu_hotplug_legacy) {
-            legacy_acpi_cpu_plug_cb(hotplug_dev, &s->gpe_cpu, dev, errp);
-        } else {
-            acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
-        }
+        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
     } else {
         g_assert_not_reached();
     }
@@ -373,8 +354,7 @@ static void piix4_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         acpi_pcihp_device_unplug_request_cb(hotplug_dev, &s->acpi_pci_hotplug,
                                             dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
-               !s->cpu_hotplug_legacy) {
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug request for not supported device"
@@ -393,8 +373,7 @@ static void piix4_device_unplug_cb(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
                                     errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
-               !s->cpu_hotplug_legacy) {
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug for not supported device"
@@ -539,25 +518,6 @@ static const MemoryRegionOps piix4_gpe_ops = {
 };
 
 
-static bool piix4_get_cpu_hotplug_legacy(Object *obj, Error **errp)
-{
-    PIIX4PMState *s = PIIX4_PM(obj);
-
-    return s->cpu_hotplug_legacy;
-}
-
-static void piix4_set_cpu_hotplug_legacy(Object *obj, bool value, Error **errp)
-{
-    PIIX4PMState *s = PIIX4_PM(obj);
-
-    assert(!value);
-    if (s->cpu_hotplug_legacy && value == false) {
-        acpi_switch_to_modern_cphp(&s->gpe_cpu, &s->cpuhp_state,
-                                   PIIX4_CPU_HOTPLUG_IO_BASE);
-    }
-    s->cpu_hotplug_legacy = value;
-}
-
 static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
                                            PCIBus *bus, PIIX4PMState *s)
 {
@@ -573,12 +533,8 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
         qbus_set_hotplug_handler(BUS(pci_get_bus(PCI_DEVICE(s))), OBJECT(s));
     }
 
-    s->cpu_hotplug_legacy = true;
-    object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
-                             piix4_get_cpu_hotplug_legacy,
-                             piix4_set_cpu_hotplug_legacy);
-    legacy_acpi_cpu_hotplug_init(parent, OBJECT(s), &s->gpe_cpu,
-                                 PIIX4_CPU_HOTPLUG_IO_BASE);
+    cpu_hotplug_hw_init(parent, OBJECT(s), &s->cpuhp_state,
+                        PIIX4_CPU_HOTPLUG_IO_BASE);
 
     if (s->acpi_memory_hotplug.is_enabled) {
         acpi_memory_hotplug_init(parent, OBJECT(s), &s->acpi_memory_hotplug,
@@ -591,9 +547,7 @@ static void piix4_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
     PIIX4PMState *s = PIIX4_PM(adev);
 
     acpi_memory_ospm_status(&s->acpi_memory_hotplug, list);
-    if (!s->cpu_hotplug_legacy) {
-        acpi_cpu_ospm_status(&s->cpuhp_state, list);
-    }
+    acpi_cpu_ospm_status(&s->cpuhp_state, list);
 }
 
 static void piix4_send_gpe(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 98dd3740ee..b01828ba5d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -35,6 +35,7 @@
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/cpu.h"
+#include "hw/acpi/pc-hotplug.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/acpi/acpi_aml_interface.h"
@@ -78,6 +79,7 @@
 #include "hw/acpi/hmat.h"
 #include "hw/acpi/viot.h"
 
+
 #include CONFIG_DEVICES
 
 /* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
@@ -962,7 +964,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
     {
         CPUHotplugFeatures opts = {
-            .acpi_1_compatible = true, .has_legacy_cphp = true,
+            .acpi_1_compatible = true,
             .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,
             .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
         };
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 34b00663f2..9694c87820 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -48,7 +48,8 @@
 #include "hw/xen/xen.h"
 #include "qobject/qlist.h"
 #include "qemu/error-report.h"
-#include "hw/acpi/cpu_hotplug.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/pc-hotplug.h"
 #include "acpi-build.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/cxl/cxl_host.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7b3611e973..ee2b01f15b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -736,10 +736,8 @@ DEFINE_I440FX_MACHINE(2, 7);
 static void pc_i440fx_machine_2_6_options(MachineClass *m)
 {
     X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
     pc_i440fx_machine_2_7_options(m);
-    pcmc->legacy_cpu_hotplug = true;
     x86mc->fwcfg_dma_enabled = false;
     compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
     compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6015e639d7..1a4787d310 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -685,10 +685,8 @@ DEFINE_Q35_MACHINE(2, 7);
 static void pc_q35_machine_2_6_options(MachineClass *m)
 {
     X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
     pc_q35_machine_2_7_options(m);
-    pcmc->legacy_cpu_hotplug = true;
     x86mc->fwcfg_dma_enabled = false;
     compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
     compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 7512be64d6..603ab3f016 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -36,7 +36,6 @@
 #include "hw/rtc/mc146818rtc.h"
 #include "target/i386/sev.h"
 
-#include "hw/acpi/cpu_hotplug.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "multiboot.h"
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 8c2228a772..c835403a93 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -370,7 +370,6 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
 
     if (event & ACPI_GED_CPU_HOTPLUG_EVT) {
         opts.acpi_1_compatible = false;
-        opts.has_legacy_cphp = false;
         opts.fw_unplugs_cpu = false;
         opts.smi_path = NULL;
 
-- 
2.47.3


