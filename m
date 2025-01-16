Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC7DC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQTA-0004JL-Rt; Thu, 16 Jan 2025 09:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b63efa7a8ebec188a7bb+7816+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tYQT2-0004IZ-GS
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:03:31 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b63efa7a8ebec188a7bb+7816+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tYQSy-0008BJ-O4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=YPOJS8KN/mgokbLkYWI9MS7jVrflO/UVeajYvyFzY9Y=; b=ZXrX80oCWsH7H6lQWlo8HHuj1e
 zNFjOeSY3iItduPb+1F6mcfu2O6Ll84YjxYsOmXBG5OAqtOuIHbuEctDgrEbSlXt+2F4/WqPmvKkI
 5IDykhnAr28dZw06vRAA08iCqgW2haSDovvvmbqo7pI/IrNoqamMDsek4a8KFzxFhj3Nv4JSUjnlf
 elIaTgae8PMIt03fkmnbJT9AXGNFZ0k1Ig0YhtsC7RIwj/Rnj8gH743pewCZLqieHiglt0RosRKtb
 93aMoomu10+Ib6RKQqfkZfTaM5991F3y024zdmYBFiGc7LG1mxTjzbAGqfTCcDk8lWpS+uxtVDTTj
 IX0hiNWQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tYQSr-0000000BFGh-3GY6; Thu, 16 Jan 2025 14:03:19 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tYQSq-0000000AJh6-1vi2; Thu, 16 Jan 2025 14:03:16 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cornelia Huck <cohuck@redhat.com>,
 Peter Hilber <quic_philber@quicinc.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v7 3/3] hw/acpi: Add vmclock device
Date: Thu, 16 Jan 2025 13:59:43 +0000
Message-ID: <20250116140315.2455143-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250116140315.2455143-1-dwmw2@infradead.org>
References: <20250116140315.2455143-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+b63efa7a8ebec188a7bb+7816+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

The vmclock device addresses the problem of live migration with
precision clocks. The tolerances of a hardware counter (e.g. TSC) are
typically around ±50PPM. A guest will use NTP/PTP/PPS to discipline that
counter against an external source of 'real' time, and track the precise
frequency of the counter as it changes with environmental conditions.

When a guest is live migrated, anything it knows about the frequency of
the underlying counter becomes invalid. It may move from a host where
the counter running at -50PPM of its nominal frequency, to a host where
it runs at +50PPM. There will also be a step change in the value of the
counter, as the correctness of its absolute value at migration is
limited by the accuracy of the source and destination host's time
synchronization.

The device exposes a shared memory region to guests, which can be mapped
all the way to userspace. In the first phase, this merely advertises a
'disruption_marker', which indicates that the guest should throw away any
NTP synchronization it thinks it has, and start again.

Because the region can be exposed all the way to userspace, applications
can still use time from a fast vDSO 'system call', and check the
disruption marker to be sure that their timestamp is indeed truthful.

The structure also allows for the precise time, as known by the host, to
be exposed directly to guests so that they don't have to wait for NTP to
resync from scratch.

The values and fields are based on the nascent virtio-rtc specification,
and the intent is that a version (hopefully precisely this version) of
this structure will be included as an optional part of that spec. In the
meantime, a simple ACPI device along the lines of VMGENID is perfectly
sufficient and is compatible with what's being shipped in certain
commercial hypervisors.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS               |   5 ++
 hw/acpi/Kconfig           |   5 ++
 hw/acpi/meson.build       |   1 +
 hw/acpi/vmclock.c         | 179 ++++++++++++++++++++++++++++++++++++++
 hw/i386/Kconfig           |   1 +
 hw/i386/acpi-build.c      |  10 ++-
 include/hw/acpi/vmclock.h |  34 ++++++++
 7 files changed, 234 insertions(+), 1 deletion(-)
 create mode 100644 hw/acpi/vmclock.c
 create mode 100644 include/hw/acpi/vmclock.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b9d9a7cac..b51860aaed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2414,6 +2414,11 @@ F: hw/audio/virtio-snd-pci.c
 F: include/hw/audio/virtio-snd.h
 F: docs/system/devices/virtio-snd.rst
 
+vmclock
+M: David Woodhouse <dwmw2@infradead.org>
+S: Supported
+F: hw/acpi/vmclock.c
+
 nvme
 M: Keith Busch <kbusch@kernel.org>
 M: Klaus Jensen <its@irrelevant.dk>
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index e07d3204eb..1d4e9f0845 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -60,6 +60,11 @@ config ACPI_VMGENID
     default y
     depends on PC
 
+config ACPI_VMCLOCK
+    bool
+    default y
+    depends on PC
+
 config ACPI_VIOT
     bool
     depends on ACPI
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index c8854f4d48..73f02b9691 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -15,6 +15,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_false: files('acpi-nvdimm-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('cxl-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: files('ghes-stub.c'))
diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c
new file mode 100644
index 0000000000..7387e5c9ca
--- /dev/null
+++ b/hw/acpi/vmclock.c
@@ -0,0 +1,179 @@
+/*
+ * Virtual Machine Clock Device
+ *
+ * Copyright © 2024 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * Authors: David Woodhouse <dwmw2@infradead.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/i386/e820_memory_layout.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/vmclock.h"
+#include "hw/nvram/fw_cfg.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "migration/vmstate.h"
+#include "system/reset.h"
+
+#include "standard-headers/linux/vmclock-abi.h"
+
+void vmclock_build_acpi(VmclockState *vms, GArray *table_data,
+                        BIOSLinker *linker, const char *oem_id)
+{
+    Aml *ssdt, *dev, *scope, *crs;
+    AcpiTable table = { .sig = "SSDT", .rev = 1,
+                        .oem_id = oem_id, .oem_table_id = "VMCLOCK" };
+
+    /* Put VMCLOCK into a separate SSDT table */
+    acpi_table_begin(&table, table_data);
+    ssdt = init_aml_allocator();
+
+    scope = aml_scope("\\_SB");
+    dev = aml_device("VCLK");
+    aml_append(dev, aml_name_decl("_HID", aml_string("AMZNC10C")));
+    aml_append(dev, aml_name_decl("_CID", aml_string("VMCLOCK")));
+    aml_append(dev, aml_name_decl("_DDN", aml_string("VMCLOCK")));
+
+    /* Simple status method */
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
+
+    crs = aml_resource_template();
+    aml_append(crs, aml_qword_memory(AML_POS_DECODE,
+                                     AML_MIN_FIXED, AML_MAX_FIXED,
+                                     AML_CACHEABLE, AML_READ_ONLY,
+                                     0xffffffffffffffffULL,
+                                     vms->physaddr,
+                                     vms->physaddr + VMCLOCK_SIZE - 1,
+                                     0, VMCLOCK_SIZE));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+    aml_append(ssdt, scope);
+
+    g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
+    acpi_table_end(linker, &table);
+    free_aml_allocator();
+}
+
+static void vmclock_update_guest(VmclockState *vms)
+{
+    uint64_t disruption_marker;
+    uint32_t seq_count;
+
+    if (!vms->clk) {
+        return;
+    }
+
+    seq_count = le32_to_cpu(vms->clk->seq_count) | 1;
+    vms->clk->seq_count = cpu_to_le32(seq_count);
+    /* These barriers pair with read barriers in the guest */
+    smp_wmb();
+
+    disruption_marker = le64_to_cpu(vms->clk->disruption_marker);
+    disruption_marker++;
+    vms->clk->disruption_marker = cpu_to_le64(disruption_marker);
+
+    /* These barriers pair with read barriers in the guest */
+    smp_wmb();
+    vms->clk->seq_count = cpu_to_le32(seq_count + 1);
+}
+
+/*
+ * After restoring an image, we need to update the guest memory to notify
+ * it of clock disruption.
+ */
+static int vmclock_post_load(void *opaque, int version_id)
+{
+    VmclockState *vms = opaque;
+
+    vmclock_update_guest(vms);
+    return 0;
+}
+
+static const VMStateDescription vmstate_vmclock = {
+    .name = "vmclock",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = vmclock_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(physaddr, VmclockState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void vmclock_handle_reset(void *opaque)
+{
+    VmclockState *vms = VMCLOCK(opaque);
+
+    if (!memory_region_is_mapped(&vms->clk_page)) {
+        memory_region_add_subregion_overlap(get_system_memory(),
+                                            vms->physaddr,
+                                            &vms->clk_page, 0);
+    }
+}
+
+static void vmclock_realize(DeviceState *dev, Error **errp)
+{
+    VmclockState *vms = VMCLOCK(dev);
+
+    /*
+     * Given that this function is executing, there is at least one VMCLOCK
+     * device. Check if there are several.
+     */
+    if (!find_vmclock_dev()) {
+        error_setg(errp, "at most one %s device is permitted", TYPE_VMCLOCK);
+        return;
+    }
+
+    vms->physaddr = VMCLOCK_ADDR;
+
+    e820_add_entry(vms->physaddr, VMCLOCK_SIZE, E820_RESERVED);
+
+    memory_region_init_ram(&vms->clk_page, OBJECT(dev), "vmclock_page",
+                           VMCLOCK_SIZE, &error_abort);
+    memory_region_set_enabled(&vms->clk_page, true);
+    vms->clk = memory_region_get_ram_ptr(&vms->clk_page);
+    memset(vms->clk, 0, VMCLOCK_SIZE);
+
+    vms->clk->magic = cpu_to_le32(VMCLOCK_MAGIC);
+    vms->clk->size = cpu_to_le16(VMCLOCK_SIZE);
+    vms->clk->version = cpu_to_le16(1);
+
+    /* These are all zero and thus default, but be explicit */
+    vms->clk->clock_status = VMCLOCK_STATUS_UNKNOWN;
+    vms->clk->counter_id = VMCLOCK_COUNTER_INVALID;
+
+    qemu_register_reset(vmclock_handle_reset, vms);
+
+    vmclock_update_guest(vms);
+}
+
+static void vmclock_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_vmclock;
+    dc->realize = vmclock_realize;
+    dc->hotpluggable = false;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo vmclock_device_info = {
+    .name          = TYPE_VMCLOCK,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(VmclockState),
+    .class_init    = vmclock_device_class_init,
+};
+
+static void vmclock_register_types(void)
+{
+    type_register_static(&vmclock_device_info);
+}
+
+type_init(vmclock_register_types)
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 32818480d2..d34ce07b21 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -43,6 +43,7 @@ config PC
     select SERIAL_ISA
     select ACPI_PCI
     select ACPI_VMGENID
+    select ACPI_VMCLOCK
     select VIRTIO_PMEM_SUPPORTED
     select VIRTIO_MEM_SUPPORTED
     select HV_BALLOON_SUPPORTED
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 733b8f0851..d482f974df 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -43,6 +43,7 @@
 #include "system/tpm.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/vmgenid.h"
+#include "hw/acpi/vmclock.h"
 #include "hw/acpi/erst.h"
 #include "hw/acpi/piix4.h"
 #include "system/tpm_backend.h"
@@ -2432,7 +2433,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     uint8_t *u;
     GArray *tables_blob = tables->table_data;
     AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
-    Object *vmgenid_dev;
+    Object *vmgenid_dev, *vmclock_dev;
     char *oem_id;
     char *oem_table_id;
 
@@ -2505,6 +2506,13 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                            tables->vmgenid, tables->linker, x86ms->oem_id);
     }
 
+    vmclock_dev = find_vmclock_dev();
+    if (vmclock_dev) {
+        acpi_add_table(table_offsets, tables_blob);
+        vmclock_build_acpi(VMCLOCK(vmclock_dev), tables_blob, tables->linker,
+                           x86ms->oem_id);
+    }
+
     if (misc.has_hpet) {
         acpi_add_table(table_offsets, tables_blob);
         build_hpet(tables_blob, tables->linker, x86ms->oem_id,
diff --git a/include/hw/acpi/vmclock.h b/include/hw/acpi/vmclock.h
new file mode 100644
index 0000000000..5605605812
--- /dev/null
+++ b/include/hw/acpi/vmclock.h
@@ -0,0 +1,34 @@
+#ifndef ACPI_VMCLOCK_H
+#define ACPI_VMCLOCK_H
+
+#include "hw/acpi/bios-linker-loader.h"
+#include "hw/qdev-core.h"
+#include "qemu/uuid.h"
+#include "qom/object.h"
+
+#define TYPE_VMCLOCK    "vmclock"
+
+#define VMCLOCK_ADDR    0xfeffb000
+#define VMCLOCK_SIZE    0x1000
+
+OBJECT_DECLARE_SIMPLE_TYPE(VmclockState, VMCLOCK)
+
+struct vmclock_abi;
+
+struct VmclockState {
+    DeviceState parent_obj;
+    MemoryRegion clk_page;
+    uint64_t physaddr;
+    struct vmclock_abi *clk;
+};
+
+/* returns NULL unless there is exactly one device */
+static inline Object *find_vmclock_dev(void)
+{
+    return object_resolve_path_type("", TYPE_VMCLOCK, NULL);
+}
+
+void vmclock_build_acpi(VmclockState *vms, GArray *table_data,
+                        BIOSLinker *linker, const char *oem_id);
+
+#endif
-- 
2.47.0


