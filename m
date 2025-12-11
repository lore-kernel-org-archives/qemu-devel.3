Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2C4D43359
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 22:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vToya-0004wE-Qr; Thu, 11 Dec 2025 17:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vToyX-0004vB-8I
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 17:17:29 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vToyU-0002MM-BL
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 17:17:29 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2981f9ce15cso6758815ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 14:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765491445; x=1766096245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W62vxMIQunx3gV5FI+x0umwU13xGfudN88vJGwV26To=;
 b=Vb3Cdc4vapsRbyiSWxFHFb8a2I3h9yQlAST54zI1IC25OZ9kTJpb81396Ca2x7oKts
 K8HdNZ+ILvBT/S1UyJ0iidWiT1Yv7dDpxLqviDrjayEDRSTTirgyk66hpkAiCKVDU+6r
 7XvxniLrj4gNi6IjyQD9hDtbROtq5DFeQhL+QCu0GuMAQU3bAcBKlHbkDvpwfs3y6Zbh
 lzjvJZ4iHZ3s6BI9ew/Snmhb2JkfEI0kpI+95gKsMv31A5EEcskDHTFUN7tngYVcOO02
 1LfBp/hJj9nlqe9TKJAsPuHuVJ+9474Tdhi5Z4nrw1HSE+qzUyb3ch6ABEXIVfZiNedi
 Lu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765491445; x=1766096245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W62vxMIQunx3gV5FI+x0umwU13xGfudN88vJGwV26To=;
 b=lB1Mfe7DlRaBPv0H3cLVvZYHKCgGTdk4V96nyoWxGnMtuIkwUtrahPC9OIMzMCZErq
 1AVtdfZWugo2XLsfFQZOzT+NYtclKIzaWRBRU9H5F8qnPtaGiX0mo4tuNk1z/G77YmVz
 Q4K0amp3HXtQ0NsFx7nJy2LOBUKA8iW0Ch1kjC/GC53ClOlbEFpkf8+RgJmMzwUXaul3
 cX6lzdxcrwMH6UVBqIl/pnUSk+ubhPueX2Vr7Kq9aKkUSPEsyp5OKTst0cKsLak7RVZv
 BjaqN1p2mk81T5T4/40y/X2kf+UTpHcjXam6Skc0lcLdLqj3tCplMULwNIWNm+UMxBrE
 nD0g==
X-Gm-Message-State: AOJu0YyW2vbzP93x7KBKCMdF7VfIW6XdmCvgxW40XO9qfmH9SKRb5oYx
 BpknRFLgihodRs1H5WptYMdX7H9Pc8vKaPk7xyha42hDW00+GxBGDEcEVVlGgdHSfMK9eYyYwi0
 wZzej/R5qsQ==
X-Gm-Gg: AY/fxX78YhMD6X3R+KTDLUI9QSQcx3j3rKPU7Dmdre7tPFg09eKljcW9jOs6IUyJ0r3
 wG/KgmG2r3xIlaYWLo7aoQ+yyKlkW2nW4tfRJrcg4iZcarEjYlzjON5QBGDY2S//uypKMbyCTFr
 WHJCJlrbFG8FAKH7CXB2MH0gkp9rPCDZydhfUw0iYgCboITDkhfr5BLAlx76xmXvbcpx9pLlQOE
 J9MZRigQkM1whRzAK/fAhiFZnRGnjhgsdZTFzdc33GPXJoQ2eJS3o6OfkqpmBaXlXLRXU+zcIla
 0jpBVvBwiBJAXr7JLEC16waDUr9t6lERHl87sZuntz7SkkWWTG+o+nSmi7TMcTzaOtEPdtSFvP3
 tBLrlyQKB8O9vpo5rmMEhi5OQcdfEph+gIgjfN7v9IRDsFU9+H+eLs+nZVmyZd/JqoFRDMagYSv
 PGzxoS4mR1Omt/GRFdH9nxzW1Smitb/Q29Mkew4nmtLuqZ/YUTtjnYjR3of3tNvzqjkfO1SFWiB
 g==
X-Google-Smtp-Source: AGHT+IEriQaTmfjNcAUSWM+4nPjehY65P7lYZx9cKCuz1BEYtJUBAZf1PrKYhNiBqM7m9NgzYqB5rQ==
X-Received: by 2002:a17:903:17c7:b0:297:cf96:45bd with SMTP id
 d9443c01a7336-29f23b52fa2mr1160845ad.19.1765491444712; 
 Thu, 11 Dec 2025 14:17:24 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea06dfbfsm33467785ad.100.2025.12.11.14.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 14:17:24 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, tangtao1634@phytium.com.cn,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] hw/arm/smmu: add memory regions as property for an SMMU
 instance
Date: Thu, 11 Dec 2025 14:17:15 -0800
Message-ID: <20251211221715.2206662-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

This will be used to access non-secure and secure memory. Secure support
and Granule Protection Check (for RME) for SMMU need to access secure
memory.

As well, it allows to remove usage of global address_space_memory,
allowing different SMMU instances to have a specific view of memory.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/arm/smmu-common.h |  4 ++++
 hw/arm/sbsa-ref.c            | 16 ++++++++++++----
 hw/arm/smmu-common.c         | 24 ++++++++++++++++++++++++
 hw/arm/virt.c                | 16 +++++++++++-----
 4 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index a6bdb67a983..0f08ae080c9 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -227,6 +227,10 @@ struct SMMUState {
     uint8_t bus_num;
     PCIBus *primary_bus;
     bool smmu_per_bus; /* SMMU is specific to the primary_bus */
+    MemoryRegion *memory;
+    AddressSpace as_memory;
+    MemoryRegion *secure_memory;
+    AddressSpace as_secure_memory;
 };
 
 struct SMMUBaseClass {
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 45d2e3e946d..840b1a216f4 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -616,7 +616,9 @@ static void create_xhci(const SBSAMachineState *sms)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(sms->gic, irq));
 }
 
-static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
+static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
+                        MemoryRegion *sysmem,
+                        MemoryRegion *secure_sysmem)
 {
     hwaddr base = sbsa_ref_memmap[SBSA_SMMU].base;
     int irq =  sbsa_ref_irqmap[SBSA_SMMU];
@@ -628,6 +630,10 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     object_property_set_str(OBJECT(dev), "stage", "nested", &error_abort);
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
+    object_property_set_link(OBJECT(dev), "memory", OBJECT(sysmem),
+                             &error_abort);
+    object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(secure_sysmem),
+                             &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
@@ -636,7 +642,9 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     }
 }
 
-static void create_pcie(SBSAMachineState *sms)
+static void create_pcie(SBSAMachineState *sms,
+                        MemoryRegion *sysmem,
+                        MemoryRegion *secure_sysmem)
 {
     hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
     hwaddr size_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].size;
@@ -692,7 +700,7 @@ static void create_pcie(SBSAMachineState *sms)
 
     pci_create_simple(pci->bus, -1, "bochs-display");
 
-    create_smmu(sms, pci->bus);
+    create_smmu(sms, pci->bus, sysmem, secure_sysmem);
 }
 
 static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
@@ -831,7 +839,7 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_xhci(sms);
 
-    create_pcie(sms);
+    create_pcie(sms, sysmem, secure_sysmem);
 
     create_secure_ec(secure_sysmem);
 
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 66367adc2a4..5fbfe825fd0 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -1171,6 +1171,12 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    g_assert(s->memory);
+    address_space_init(&s->as_memory, s->memory, "memory");
+    if (s->secure_memory) {
+        address_space_init(&s->as_secure_memory, s->secure_memory, "secure-memory");
+    }
+
     /*
      * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
      * root complexes to be associated with SMMU.
@@ -1235,10 +1241,28 @@ static void smmu_base_class_init(ObjectClass *klass, const void *data)
     rc->phases.exit = smmu_base_reset_exit;
 }
 
+static void smmu_base_instance_init(Object *obj)
+{
+    SMMUState *s = ARM_SMMU(obj);
+
+    object_property_add_link(obj, "memory",
+                             TYPE_MEMORY_REGION,
+                             (Object **)&s->memory,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+
+    object_property_add_link(obj, "secure-memory",
+                             TYPE_MEMORY_REGION,
+                             (Object **)&s->secure_memory,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+}
+
 static const TypeInfo smmu_base_info = {
     .name          = TYPE_ARM_SMMU,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(SMMUState),
+    .instance_init = smmu_base_instance_init,
     .class_data    = NULL,
     .class_size    = sizeof(SMMUBaseClass),
     .class_init    = smmu_base_class_init,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5d205eff3a1..d446c3349e9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1514,8 +1514,9 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms,
                            0x0, vms->iommu_phandle, 0x0, 0x10000);
 }
 
-static void create_smmu(const VirtMachineState *vms,
-                        PCIBus *bus)
+static void create_smmu(const VirtMachineState *vms, PCIBus *bus,
+                        MemoryRegion *sysmem,
+                        MemoryRegion *secure_sysmem)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     int irq =  vms->irqmap[VIRT_SMMU];
@@ -1549,6 +1550,10 @@ static void create_smmu(const VirtMachineState *vms,
     object_property_set_str(OBJECT(dev), "stage", stage, &error_fatal);
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
+    object_property_set_link(OBJECT(dev), "memory", OBJECT(sysmem),
+                             &error_abort);
+    object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(secure_sysmem),
+                             &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
@@ -1587,7 +1592,8 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
     }
 }
 
-static void create_pcie(VirtMachineState *vms)
+static void create_pcie(VirtMachineState *vms,
+                        MemoryRegion *sysmem, MemoryRegion *secure_sysmem)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
@@ -1706,7 +1712,7 @@ static void create_pcie(VirtMachineState *vms)
 
         switch (vms->iommu) {
         case VIRT_IOMMU_SMMUV3:
-            create_smmu(vms, vms->bus);
+            create_smmu(vms, vms->bus, sysmem, secure_sysmem);
             if (!vms->default_bus_bypass_iommu) {
                 qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
                                        0x0, vms->iommu_phandle, 0x0, 0x10000);
@@ -2520,7 +2526,7 @@ static void machvirt_init(MachineState *machine)
 
     create_rtc(vms);
 
-    create_pcie(vms);
+    create_pcie(vms, sysmem, secure_sysmem);
     create_cxl_host_reg_region(vms);
 
     if (aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
-- 
2.47.3


