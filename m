Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91958D637B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 22:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVdql-00046z-6A; Tue, 16 Dec 2025 17:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVdqk-00046k-8H
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 17:48:58 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVdqh-0008Mc-Th
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 17:48:58 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso38403305ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 14:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765925334; x=1766530134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hxBvBNN1uZq8IchzEaUXh4rpqGrFZZwnhCysTNaRbaE=;
 b=xJYh2h53mGt9/4glJVsezq5tcDB3VFQwvqQ951acRASg4ffMf4DGOpHYuouNUknaLC
 AzT65s44c+IISFDHm1LC2yb++JzS+qb2NY7OfXWn6pm7NOXp/x333P97R7lTieiZxa7H
 ok+JPLKo5uUiiZh/sm/ccoQJdJhRjRS6gNQvHhkeGaFKpikW/NkHFT7g44rhmMGZRrh6
 v6BUExaoQwppDoI4mYckoCBwQeBgGfnRwgji5xDeCwiVlCXNiZs5BQGEWZKgRzCvS7o7
 WL/RitdsMkFeCyZ0rJHMeTaBlSod3px+xOFnxtidZW2fswRnr5ksG5PSURE2udKdQQrV
 EXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765925334; x=1766530134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxBvBNN1uZq8IchzEaUXh4rpqGrFZZwnhCysTNaRbaE=;
 b=LdmXlJ+AGALqDeZ6ewlNoZLVxADj4QghTVt0TkSoLy9DvPmdOpWUzKimTOEX6Fk2eE
 L7yg7KrRiA7Ltfur8DIU/K5ku+hwk+r8JSCS/anynt1bcVImHy/V3H9mdRXRt772j2gI
 YLUbUsm0mKDjk8EYqv7C03E4DWLsth8jJmNwyHzseBWDA5NmxEU3vN+Kaafeu1mo/i7P
 l+92hpO7bMWiRNmeWGQ7hRfpY0bLPA5HZHohF0Nt11znzb4pJWwcYU9XhYsBR21ppMGJ
 ZZC1DG0FmswhaNg2qwCrM3LCDCxj8n0aRSSJ3T5/jh9R4UK+RlR2VZIrLHR7/CPy1Uif
 zJ3Q==
X-Gm-Message-State: AOJu0YzIFDa7OzGDaDH3+DW0OWahymcfWXRzvQHF3i3N2cnJCkq/RkaH
 jg9rpYNTqvxdKcgvJVgXpf8EH3WbQhdUhB3SqkbfAbVM8n6yQr17Yc42+84TUnddhY8DEZBgum2
 zqnd9GhGbxA==
X-Gm-Gg: AY/fxX5ATYWwrtgVUl9zaLQzwNvrWXotG9ei3s088LnUqK6nkIz2qFjxKLOEZTPxz7a
 QsUwICjrDUDAjKFzDG6JPbi3UjUo0GMp70yP4klqOydJRjHtuUk0lHJYhAkVpRRHX+HU/2srdMw
 1dGdX2NQgUZMThOutNqlmiB6GoGEQmNn67L7TqDXNEUsoWHjPQi6JGkKUF2BcdDgEs7RvMpZ+/1
 YF9f6MeNuWLETa5LKE3IksGnly8sLuQiz+p9l5vq6bBV9GQe60Btht5TAtMIIs8Zw1ABX5PkCE2
 D5lvfVinUtdI4TrkNrwoywOXzaJq6txgu6Di2ACCs5duY9zIk0h+sDUyb+c9hiWikE9EBeUfRqY
 2OUThMqcLPQJ8fIQo9vuyUnQlwdyDWPNUGVVn5AZw4wJQHnFr6R1jMlSkEUPMSv+SjoYePAYj6i
 2cetx7Uutjvwf0ElREDs9q2SzjG99bG21UdRTS0fpvmvWFiqq6g8ww1AeQRmcIO4iyvszoyjKA5
 g==
X-Google-Smtp-Source: AGHT+IGTRtcX8ukRua0gXCLRtf5VG0jc9byQ/dh0lsqsGrT1pBAd053ZTxIxnbR/2NKS3NFQ4Gc7PQ==
X-Received: by 2002:a17:903:3bac:b0:295:560a:e499 with SMTP id
 d9443c01a7336-29f23b1296cmr159552185ad.5.1765925333676; 
 Tue, 16 Dec 2025 14:48:53 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fcbb11ea69sm580707b3a.31.2025.12.16.14.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 14:48:53 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: tangtao1634@phytium.com.cn, Peter Maydell <peter.maydell@linaro.org>,
 richard.henderson@linaro.org, Eric Auger <eric.auger@redhat.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3] hw/arm/smmu: add memory regions as property for an SMMU
 instance
Date: Tue, 16 Dec 2025 14:48:45 -0800
Message-ID: <20251216224845.1673051-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/arm/smmu-common.c         | 27 +++++++++++++++++++++++++++
 hw/arm/virt.c                | 16 +++++++++++-----
 4 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 80d0fecfde8..d9bade3c803 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -162,6 +162,10 @@ struct SMMUState {
     uint8_t bus_num;
     PCIBus *primary_bus;
     bool smmu_per_bus; /* SMMU is specific to the primary_bus */
+    MemoryRegion *memory;
+    AddressSpace memory_as;
+    MemoryRegion *secure_memory;
+    AddressSpace secure_memory_as;
 };
 
 struct SMMUBaseClass {
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 2205500a8da..cc9d4385826 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -613,7 +613,9 @@ static void create_xhci(const SBSAMachineState *sms)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(sms->gic, irq));
 }
 
-static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
+static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
+                        MemoryRegion *sysmem,
+                        MemoryRegion *secure_sysmem)
 {
     hwaddr base = sbsa_ref_memmap[SBSA_SMMU].base;
     int irq =  sbsa_ref_irqmap[SBSA_SMMU];
@@ -625,6 +627,10 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
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
@@ -633,7 +639,9 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     }
 }
 
-static void create_pcie(SBSAMachineState *sms)
+static void create_pcie(SBSAMachineState *sms,
+                        MemoryRegion *sysmem,
+                        MemoryRegion *secure_sysmem)
 {
     hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
     hwaddr size_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].size;
@@ -689,7 +697,7 @@ static void create_pcie(SBSAMachineState *sms)
 
     pci_create_simple(pci->bus, -1, "bochs-display");
 
-    create_smmu(sms, pci->bus);
+    create_smmu(sms, pci->bus, sysmem, secure_sysmem);
 }
 
 static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
@@ -825,7 +833,7 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_xhci(sms);
 
-    create_pcie(sms);
+    create_pcie(sms, sysmem, secure_sysmem);
 
     create_secure_ec(secure_sysmem);
 
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 62a76121841..2310da781b6 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -944,6 +944,15 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!s->memory) {
+        s->memory = get_system_memory();
+    }
+    address_space_init(&s->memory_as, s->memory, "smmu-memory-view");
+    if (s->secure_memory) {
+        address_space_init(&s->secure_memory_as, s->secure_memory,
+                           "smmu-secure-memory-view");
+    }
+
     /*
      * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
      * root complexes to be associated with SMMU.
@@ -1008,10 +1017,28 @@ static void smmu_base_class_init(ObjectClass *klass, const void *data)
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
index 25fb2bab568..32ef51c3ad7 100644
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
@@ -1535,6 +1536,10 @@ static void create_smmu(const VirtMachineState *vms,
     }
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
+    object_property_set_link(OBJECT(dev), "memory", OBJECT(sysmem),
+                             &error_abort);
+    object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(secure_sysmem),
+                             &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
@@ -1573,7 +1578,8 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
     }
 }
 
-static void create_pcie(VirtMachineState *vms)
+static void create_pcie(VirtMachineState *vms,
+                        MemoryRegion *sysmem, MemoryRegion *secure_sysmem)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
@@ -1692,7 +1698,7 @@ static void create_pcie(VirtMachineState *vms)
 
         switch (vms->iommu) {
         case VIRT_IOMMU_SMMUV3:
-            create_smmu(vms, vms->bus);
+            create_smmu(vms, vms->bus, sysmem, secure_sysmem);
             if (!vms->default_bus_bypass_iommu) {
                 qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
                                        0x0, vms->iommu_phandle, 0x0, 0x10000);
@@ -2506,7 +2512,7 @@ static void machvirt_init(MachineState *machine)
 
     create_rtc(vms);
 
-    create_pcie(vms);
+    create_pcie(vms, sysmem, secure_sysmem);
     create_cxl_host_reg_region(vms);
 
     if (aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
-- 
2.47.3


