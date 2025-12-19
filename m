Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D3EE6689C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 22:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWiub-0001kg-2L; Fri, 19 Dec 2025 17:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vWiuR-0001h1-JG
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:25:16 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vWiuP-0004zt-HZ
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:25:15 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64b7a38f07eso2786835a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 14:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766183112; x=1766787912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdRLm5zMkoDQZ5YxMVTuMYcF0Rw/N9qJIqQIdpP+JoM=;
 b=RFlEJvV9GRtn4DBinPrxojjn7Ftyst3IEmDf0zvFyCxvaVVfY74xmjTDodbWVhMNGs
 9AyFcn8hOPj7GmJiDZSYLaOuD7gl0qJSxRjlT41mxn/rdnnr+/kjqPQczuB0LKYNGEfl
 pKePNU05TbBNjCMaP7C7lDtBeBFJlVWeCikRxB3hscSXaE6KdcIbSQDp2XIeRuN360J6
 HeFW+vppHgzeAIbBnpFfqUHrwqNuT4GNRm+dLC9+G7Cthutr2JvXXz9GZYR7hbE/DtId
 E4uhWUBui/AaTe9LJPtWfqXydtLjOlK0BXALCeWsdG8drSL6zydS0oza9aFMNH0jDpSu
 1gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766183112; x=1766787912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CdRLm5zMkoDQZ5YxMVTuMYcF0Rw/N9qJIqQIdpP+JoM=;
 b=NQeBv0yYiRiRen22Ex8uCY848MgqSORMVPUC5XgKZSsGncAoWDDbXQ/4Cy1UvBEIQd
 tPS/FBst5rov968yb3acmGlw7Lwv+FiofDUFTayiXTYu5Pz7gQPGliKNRfNTokXkJQ74
 IK3sV+XIb9V6/61vOSlRUQZfqU3s3PyMe7yL4bU2d3K0qnpgGdonsCSGksr6dJi1EN0q
 po66uMzHTbSKgbsew9e9dJRYmf4h7objwG6hED5xdSv9tPKuvwVLmAXGe4j4AupcBav1
 u4Oq2gYsT3BMuNtDISQHAJUqsGa1WV2S9VzYbiBtSNgfZCTzXcbcuDCCSM/p6Qi+vhyI
 cvAg==
X-Gm-Message-State: AOJu0YxabtSqNmWg+08pjlFBUZO/v6eCnjcE1w/jylXUD4lREW1graM3
 pTawITgQeOBzIf92ZVAPDCoywbvsXMQlhTqHFde11g8Sh1Jd5PZb+yTaXO6kyRGp
X-Gm-Gg: AY/fxX6QCG4BMVPT12WOTLezUgYDtBXQd6TcEjYs60FqeXuHh53Z+ZeZE5kBFNZR4uG
 B7KYai3u/z6kJQ8102Ag9s3WWjKiloxWmWZLZbYeUjGvSVa7TJUz4dVAP0QoZizvxCQ12nF23d0
 iozFzgFtzu+bC5Crdw3jEFqxcrAcy7xfyTcHWtWmnq+mGwLE/8QK1XPbvjjowPgGrfxxMUJ7V1j
 hM2hZPfJVj1CB8gnvTOLz0JFFuhWIxXqbbSgFFDFkhGb1ryN2sFLdhwuiIDnh9uT4bIB+FVa63L
 gQzd6A+nCrPV9+UXLxdHSHU/+Q47Wjg5VZ/9SEnRuoMhgoHcFJnwkhTOnD9m82gof8Pi8sk9WPw
 A3V9UN063tzmTpei6vUokz+RNuyfnyBPepyuBQtjQAK1TwXTsS2uCFNwapTKLxvMzEFgYPiOuUg
 8Se/DFaTe/pTHO6HCBVUTlnAQRbZloHv5s+UUQAQDtKlhMJothUWpCk5mcKufm+w==
X-Google-Smtp-Source: AGHT+IHr0AmTgpAnzoj0Q9cG/4FZY8tcc0Y9PnzO3WK3MfPQDbIeV0ejj5Eb2eji2Sz/4N+0y+daKg==
X-Received: by 2002:a05:6402:1ec8:b0:647:5518:8c35 with SMTP id
 4fb4d7f45d1cf-64b8ea60f47mr4189440a12.6.1766183111682; 
 Fri, 19 Dec 2025 14:25:11 -0800 (PST)
Received: from thinkpad-t470s.. (93-138-210-222.adsl.net.t-com.hr.
 [93.138.210.222]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91599605sm3237440a12.23.2025.12.19.14.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 14:25:10 -0800 (PST)
From: ruslichenko.r@gmail.com
X-Google-Original-From: ruslan_ruslichenko@epam.com
To: qemu-devel@nongnu.org
Cc: ruslan_ruslichenko@epam.com, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>,
 Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
Subject: [RFC PATCH 3/6] hw/arm/virt: create smmu for sysbus
Date: Fri, 19 Dec 2025 23:24:36 +0100
Message-ID: <20251219222439.2497195-4-ruslan_ruslichenko@epam.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
References: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>

Create new smmu device for sysbus.
Add memory region for SMMU to memory map.

Signed-off-by: Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/arm/virt-acpi-build.c |  4 +-
 hw/arm/virt.c            | 84 +++++++++++++++++++++++++++++++++-------
 include/hw/arm/virt.h    |  4 +-
 3 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 200e2a1da7..2d7e2e2725 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -334,8 +334,8 @@ static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
      */
     g_array_sort(sdev.rc_smmu_idmaps, iort_idmap_compare);
 
-    sdev.base = vms->memmap[VIRT_SMMU].base;
-    sdev.irq = vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+    sdev.base = vms->memmap[VIRT_SMMU_PCIE].base;
+    sdev.irq = vms->irqmap[VIRT_SMMU_PCIE] + ARM_SPI_BASE;
     g_array_append_val(sdev_blob, sdev);
     return sdev.rc_smmu_idmaps->len;
 }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d9d7b982b3..ad609bc651 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -187,13 +187,14 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
     [VIRT_UART1] =              { 0x09040000, 0x00001000 },
-    [VIRT_SMMU] =               { 0x09050000, SMMU_IO_LEN },
-    [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
-    [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
-    [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
-    [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
-    [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
-    [VIRT_ACPI_PCIHP] =         { 0x090c0000, ACPI_PCIHP_SIZE },
+    [VIRT_SMMU_PCIE] =          { 0x09050000, SMMU_IO_LEN },
+    [VIRT_SMMU_SYSBUS] =        { 0x09070000, SMMU_IO_LEN },
+    [VIRT_PCDIMM_ACPI] =        { 0x09090000, MEMORY_HOTPLUG_IO_LEN },
+    [VIRT_ACPI_GED] =           { 0x090a0000, ACPI_GED_EVT_SEL_LEN },
+    [VIRT_NVDIMM_ACPI] =        { 0x090b0000, NVDIMM_ACPI_IO_LEN},
+    [VIRT_PVTIME] =             { 0x090c0000, 0x00010000 },
+    [VIRT_SECURE_GPIO] =        { 0x090d0000, 0x00001000 },
+    [VIRT_ACPI_PCIHP] =         { 0x090e0000, ACPI_PCIHP_SIZE },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -247,7 +248,8 @@ static const int a15irqmap[] = {
     [VIRT_ACPI_GED] = 9,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
-    [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
+    [VIRT_SMMU_PCIE] = 74, /* ...to 74 + NUM_SMMU_IRQS - 1 */
+    [VIRT_SMMU_SYSBUS] = 78, /* ...to 78 + NUM_SMMU_IRQS - 1 */
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
@@ -1514,14 +1516,14 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms,
                            0x0, vms->iommu_phandle, 0x0, 0x10000);
 }
 
-static void create_smmu(const VirtMachineState *vms,
+static void create_smmu_pcie(const VirtMachineState *vms,
                         PCIBus *bus)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
-    int irq =  vms->irqmap[VIRT_SMMU];
+    int irq =  vms->irqmap[VIRT_SMMU_PCIE];
     int i;
-    hwaddr base = vms->memmap[VIRT_SMMU].base;
-    hwaddr size = vms->memmap[VIRT_SMMU].size;
+    hwaddr base = vms->memmap[VIRT_SMMU_PCIE].base;
+    hwaddr size = vms->memmap[VIRT_SMMU_PCIE].size;
     DeviceState *dev;
 
     if (vms->iommu != VIRT_IOMMU_SMMUV3 || !vms->iommu_phandle) {
@@ -1533,7 +1535,7 @@ static void create_smmu(const VirtMachineState *vms,
     if (!vmc->no_nested_smmu) {
         object_property_set_str(OBJECT(dev), "stage", "nested", &error_fatal);
     }
-    object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
+    object_property_set_link(OBJECT(dev), "pci-primary-bus", OBJECT(bus),
                              &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
@@ -1544,6 +1546,58 @@ static void create_smmu(const VirtMachineState *vms,
     create_smmuv3_dt_bindings(vms, base, size, irq);
 }
 
+static void create_smmu_sysbus(VirtMachineState *vms)
+{
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    char *node;
+    const char compat[] = "arm,smmu-v3";
+    int irq =  vms->irqmap[VIRT_SMMU_SYSBUS];
+    int i;
+    hwaddr base = vms->memmap[VIRT_SMMU_SYSBUS].base;
+    hwaddr size = vms->memmap[VIRT_SMMU_SYSBUS].size;
+    const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
+    DeviceState *dev;
+    MachineState *ms = MACHINE(vms);
+
+    vms->sysbus_iommu_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+
+    dev = qdev_new(TYPE_ARM_SMMUV3);
+
+    if (!vmc->no_nested_smmu) {
+        object_property_set_str(OBJECT(dev), "stage", "nested", &error_fatal);
+    }
+    object_property_set_link(OBJECT(dev), "generic-primary-bus", 
+                             OBJECT(sysbus_get_default()), &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+    for (i = 0; i < NUM_SMMU_IRQS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(vms->gic, irq + i));
+    }
+
+    node = g_strdup_printf("/smmuv3@%" PRIx64, base);
+    qemu_fdt_add_subnode(ms->fdt, node);
+    qemu_fdt_setprop(ms->fdt, node, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ms->fdt, node, "reg", 2, base, 2, size);
+
+    qemu_fdt_setprop_cells(ms->fdt, node, "interrupts",
+            GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
+
+    qemu_fdt_setprop(ms->fdt, node, "interrupt-names", irq_names,
+                     sizeof(irq_names));
+
+    qemu_fdt_setprop(ms->fdt, node, "dma-coherent", NULL, 0);
+
+    qemu_fdt_setprop_cell(ms->fdt, node, "#iommu-cells", 1);
+
+    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->sysbus_iommu_phandle);
+
+    g_free(node);
+}
+
 static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
 {
     const char compat[] = "virtio,pci-iommu\0pci1af4,1057";
@@ -1692,7 +1746,7 @@ static void create_pcie(VirtMachineState *vms)
 
         switch (vms->iommu) {
         case VIRT_IOMMU_SMMUV3:
-            create_smmu(vms, vms->bus);
+            create_smmu_pcie(vms, vms->bus);
             if (!vms->default_bus_bypass_iommu) {
                 qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
                                        0x0, vms->iommu_phandle, 0x0, 0x10000);
@@ -2509,6 +2563,8 @@ static void machvirt_init(MachineState *machine)
     create_pcie(vms);
     create_cxl_host_reg_region(vms);
 
+    create_smmu_sysbus(vms);
+
     if (aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
         vms->generic_error_notifier.notify = virt_generic_error_req;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c77a33f6df..00b276ecf0 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -63,7 +63,8 @@ enum {
     VIRT_GIC_VCPU,
     VIRT_GIC_ITS,
     VIRT_GIC_REDIST,
-    VIRT_SMMU,
+    VIRT_SMMU_PCIE,
+    VIRT_SMMU_SYSBUS,
     VIRT_UART0,
     VIRT_MMIO,
     VIRT_RTC,
@@ -168,6 +169,7 @@ struct VirtMachineState {
     uint32_t gic_phandle;
     uint32_t msi_phandle;
     uint32_t iommu_phandle;
+    uint32_t sysbus_iommu_phandle;
     int psci_conduit;
     hwaddr highest_gpa;
     DeviceState *gic;
-- 
2.43.0


