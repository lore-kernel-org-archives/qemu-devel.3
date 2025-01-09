Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F139E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 03:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tViyz-0000k1-P9; Wed, 08 Jan 2025 22:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1tViyt-0000hm-2K; Wed, 08 Jan 2025 22:13:11 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1tViyq-0001MK-Rz; Wed, 08 Jan 2025 22:13:10 -0500
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 5092jniQ028932;
 Thu, 9 Jan 2025 10:45:49 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 5092j2Fd027904
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jan 2025 10:45:02 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 9 Jan 2025
 10:45:02 +0800
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <peterx@redhat.com>,
 <david@redhat.com>, <philmd@linaro.org>, <qemu-riscv@nongnu.org>,
 Ethan Chen <ethan84@andestech.com>
Subject: [PATCH v9 8/8] hw/riscv/virt: Add IOPMP support
Date: Thu, 9 Jan 2025 10:44:41 +0800
Message-ID: <20250109024441.3283671-9-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
In-Reply-To: <20250109024441.3283671-1-ethan84@andestech.com>
References: <20250109024441.3283671-1-ethan84@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.1.106]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5092jniQ028932
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- Add 'iopmp=on' option to enable IOPMP. It adds iopmp devices virt machine
  to protect all regions of system memory.

Signed-off-by: Ethan Chen <ethan84@andestech.com>
---
 docs/system/riscv/virt.rst |  7 ++++
 hw/riscv/Kconfig           |  1 +
 hw/riscv/virt.c            | 75 ++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h    |  4 ++
 4 files changed, 87 insertions(+)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 60850970ce..6b5fc1d37d 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -146,6 +146,13 @@ The following machine-specific options are supported:
 
   Enables the riscv-iommu-sys platform device. Defaults to 'off'.
 
+- iopmp=[on|off]
+
+  When this option is "on", IOPMP devices are added to machine. IOPMP checks
+  memory transcations in system memory. This option is assumed to be "off". To
+  enable the CPU to perform transactions with a specified RRID, use the CPU
+  option "-cpu <cpu>,iopmp=true,iopmp_rrid=<rrid>"
+
 Running Linux kernel
 --------------------
 
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index e6a0ac1fa1..637438af2c 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -68,6 +68,7 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
+    select RISCV_IOPMP
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2bc5a9dd98..95f8946ae1 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -57,6 +57,8 @@
 #include "hw/acpi/aml-build.h"
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/misc/riscv_iopmp.h"
+#include "hw/misc/riscv_iopmp_dispatcher.h"
 
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
@@ -94,6 +96,7 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_UART0] =        { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
+    [VIRT_IOPMP] =        { 0x10200000,      0x100000 },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
     [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
@@ -102,6 +105,11 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_DRAM] =         { 0x80000000,           0x0 },
 };
 
+static const MemMapEntry iopmp_protect_memmap[] = {
+    /* IOPMP protect all regions by default */
+    {0x0, 0xFFFFFFFF},
+};
+
 /* PCIe high mmio is fixed for RV32 */
 #define VIRT32_HIGH_PCIE_MMIO_BASE  0x300000000ULL
 #define VIRT32_HIGH_PCIE_MMIO_SIZE  (4 * GiB)
@@ -1117,6 +1125,24 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
                            bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
 }
 
+static void create_fdt_iopmp(RISCVVirtState *s, const MemMapEntry *memmap,
+                             uint32_t irq_mmio_phandle) {
+    g_autofree char *name = NULL;
+    MachineState *ms = MACHINE(s);
+
+    name = g_strdup_printf("/soc/iopmp@%lx", (long)memmap[VIRT_IOPMP].base);
+    qemu_fdt_add_subnode(ms->fdt, name);
+    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "riscv_iopmp");
+    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0, memmap[VIRT_IOPMP].base,
+        0x0, memmap[VIRT_IOPMP].size);
+    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
+    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
+        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", IOPMP_IRQ);
+    } else {
+        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", IOPMP_IRQ, 0x4);
+    }
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -1141,6 +1167,10 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
 
     create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
+
+    if (s->have_iopmp) {
+        create_fdt_iopmp(s, virt_memmap, irq_mmio_phandle);
+    }
 }
 
 static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
@@ -1529,6 +1559,8 @@ static void virt_machine_init(MachineState *machine)
     DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
     int i, base_hartid, hart_count;
     int socket_count = riscv_socket_count(machine);
+    DeviceState *iopmp_dev, *iopmp_disp_dev;
+    StreamSink *iopmp_ss, *iopmp_disp_ss;
 
     /* Check socket count limit */
     if (VIRT_SOCKETS_MAX < socket_count) {
@@ -1710,6 +1742,29 @@ static void virt_machine_init(MachineState *machine)
     }
     virt_flash_map(s, system_memory);
 
+    if (s->have_iopmp) {
+        iopmp_dev = iopmp_create(memmap[VIRT_IOPMP].base,
+            qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP_IRQ));
+
+        iopmp_setup_system_memory(iopmp_dev, &iopmp_protect_memmap[0], 1, 0);
+
+        iopmp_disp_dev = qdev_new(TYPE_RISCV_IOPMP_DISP);
+        qdev_prop_set_uint32(DEVICE(iopmp_disp_dev), "target-num", 1);
+        qdev_prop_set_uint32(DEVICE(iopmp_disp_dev), "stage-num", 1);
+        qdev_realize(DEVICE(iopmp_disp_dev), NULL, &error_fatal);
+
+        /* Add memmap inforamtion to dispatcher */
+        iopmp_ss = (StreamSink *)&(RISCV_IOPMP(iopmp_dev)->txn_info_sink);
+        iopmp_dispatcher_add_target(DEVICE(iopmp_disp_dev), iopmp_ss,
+                                    iopmp_protect_memmap[0].base,
+                                    iopmp_protect_memmap[0].size,
+                                    0, 0);
+
+        iopmp_disp_ss =
+            (StreamSink *)&(RISCV_IOPMP_DISP(iopmp_disp_dev)->txn_info_sink);
+        iopmp_setup_sink(iopmp_dev, iopmp_disp_ss);
+    }
+
     /* load/create device tree */
     if (machine->dtb) {
         machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
@@ -1845,6 +1900,20 @@ static void virt_set_iommu_sys(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
 }
 
+static bool virt_get_iopmp(Object *obj, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    return s->have_iopmp;
+}
+
+static void virt_set_iopmp(Object *obj, bool value, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    s->have_iopmp = value;
+}
+
 bool virt_is_acpi_enabled(RISCVVirtState *s)
 {
     return s->acpi != ON_OFF_AUTO_OFF;
@@ -1972,6 +2041,12 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                               NULL, NULL);
     object_class_property_set_description(oc, "iommu-sys",
                                           "Enable IOMMU platform device");
+
+    object_class_property_add_bool(oc, "iopmp", virt_get_iopmp,
+                                   virt_set_iopmp);
+    object_class_property_set_description(oc, "iopmp",
+                                          "Set on/off to enable/disable "
+                                          "iopmp device");
 }
 
 static const TypeInfo virt_machine_typeinfo = {
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 48a14bea2e..77dcbd5450 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -55,6 +55,7 @@ struct RISCVVirtState {
 
     int fdt_size;
     bool have_aclint;
+    bool have_iopmp;
     RISCVVirtAIAType aia_type;
     int aia_guests;
     char *oem_id;
@@ -87,11 +88,14 @@ enum {
     VIRT_PLATFORM_BUS,
     VIRT_PCIE_ECAM,
     VIRT_IOMMU_SYS,
+    VIRT_IOPMP,
 };
 
 enum {
     UART0_IRQ = 10,
     RTC_IRQ = 11,
+    IOPMP_IRQ = 12,
+    DMA_IRQ = 13,
     VIRTIO_IRQ = 1, /* 1 to 8 */
     VIRTIO_COUNT = 8,
     PCIE_IRQ = 0x20, /* 32 to 35 */
-- 
2.34.1


