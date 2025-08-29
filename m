Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2686DCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNIi-0001kK-Sb; Sat, 30 Aug 2025 11:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiU-0001CA-S2
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiO-0008Pb-PD
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nL10Pb0C0oM+hnv3YRRH5NRvJhhCyi5mIDRBLogPgA4=;
 b=C0OYSJe4uaT/9ie0pe5dHH+jMyuyvmI/SXrQ29FYIpmgDWZqPmHJNDoSUeOmBrVpHBrZ+h
 rGuHRJTDuv56zn+MVE7n+vMo9iVpd0g3062uOKTArTTbN6CPdR2zxg+zbJYnQxJAnTOLT2
 FzGefKaZVVKa5caJZ94W0cjCp19pFhk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-iPYCVuAWOUScOzPWPDASWw-1; Fri, 29 Aug 2025 09:00:21 -0400
X-MC-Unique: iPYCVuAWOUScOzPWPDASWw-1
X-Mimecast-MFC-AGG-ID: iPYCVuAWOUScOzPWPDASWw_1756472420
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3cf48ec9dcbso828939f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472419; x=1757077219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nL10Pb0C0oM+hnv3YRRH5NRvJhhCyi5mIDRBLogPgA4=;
 b=BPgRHi0fFZWXXO1sA40tvKsBPXqzcdd+9u+3RITRrP1D05EuPDqGVmQD28hcRYPCmb
 mZkLSwC67h7IUbzcPGLmFVUW3mWGGC6PHakBYPjqtrITin16Eln7qvYiZS6+TcwNQ4US
 BtzqDqO97EiEje+2+AymtzZB6DyM/5gl1HB8DW/26RhfGwnPjLQ18ikMevBsvM5T5S7K
 P6E8jY+y1uzgmpvNkUdCCBgQof2S0O26sqt2UyBHbROSkFmM0bKlF/wWBZwTkj3HMyQt
 RZAEtmKuAkp0MIFehEhYcFe9cLRwSlOHTH82k7If87oMMrCOpSgwA8siRCK93TZP7NM0
 1jkg==
X-Gm-Message-State: AOJu0YyB05n1IsxZxJoC4gciwWKCm8pYnDzGtIRcx6DavCGFqKisBKUF
 Poy+j8CmclUMf04OQhx71cvMcez+IqR554bUZz0VsbD0IIwJ+7BYZgySjDY8kRFaUHcNzV6MbOB
 wZ3qJ7mUBH3AqNOOdG7XB5juoj9dOIh9FkCYKAujSBjpEzrmuCgD3uU7sJoOSWqO/plxN1viRiB
 pENIcsAQYZL6DOloREaCThDQ3myErznGYooeaRnBNo
X-Gm-Gg: ASbGnctLzUXgv/VH5VFHTUA9gJys+vncwaHIFgQFKSo79sUc1x6XM94CBp2WAQkCrp+
 gWOhMYepiYqXSe/fjAUQgjGNLXqnd/4ej1MsasF9e+QWS0BSCVtW480DyrBPEoF1oRinWRTp55K
 0/LiplxLBlFebAfrNmsCiSDNaOShe/jWJYD23X/YhHtuZ/6W+9utIOksxcR2uIHfzEZSfJLN3aq
 +3f4q012TTu1JchPVZ38hrHIWWiq4XT1P29aFAY7K3a3NnOGwnWuBFGTACPnXmwWCF1m6yE5HPH
 cESxin1or04pOrfFWTCEgGNPr90Z8/AbKdG0yZu4a+TYp9AjIKHpgmpznDz99J2JJIG8m2lI2F5
 eUaY0SG29KXte5RJeoq6f6eVsBHLUt25LPzBvhHxyBDQ=
X-Received: by 2002:adf:a155:0:b0:3ce:9872:fd3 with SMTP id
 ffacd0b85a97d-3ce987213dfmr2758851f8f.34.1756472419236; 
 Fri, 29 Aug 2025 06:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF1UfZ01N6dZ/xHrZ7Z/scelEM3D0hdN1H4/pJIiCA6v6p/WnkrhleIqeaARm+GK/2zeraIw==
X-Received: by 2002:adf:a155:0:b0:3ce:9872:fd3 with SMTP id
 ffacd0b85a97d-3ce987213dfmr2758822f8f.34.1756472418587; 
 Fri, 29 Aug 2025 06:00:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d164a57097sm85802f8f.40.2025.08.29.06.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 15/28] hw/i386/pc_piix.c: assume pcmc->pci_enabled is always
 true in pc_init1()
Date: Fri, 29 Aug 2025 14:59:22 +0200
Message-ID: <20250829125935.1526984-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

PCI is always enabled on the pc-i440fx machine so hardcode the relevant logic
in pc_init1(). Add an assert() to ensure that this is always the case at
runtime as already done in pc_q35_init().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250828111057.468712-16-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 192 ++++++++++++++++++----------------------------
 1 file changed, 76 insertions(+), 116 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 72ddd9b149d..3ea77b2c44f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -125,6 +125,11 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
+    PCIDevice *pci_dev;
+    DeviceState *dev;
+    size_t i;
+
+    assert(pcmc->pci_enabled);
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -195,38 +200,36 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-    if (pcmc->pci_enabled) {
-        pci_memory = g_new(MemoryRegion, 1);
-        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-        rom_memory = pci_memory;
+    pci_memory = g_new(MemoryRegion, 1);
+    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+    rom_memory = pci_memory;
 
-        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
-        object_property_add_child(OBJECT(machine), "i440fx", phb);
-        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
-                                 OBJECT(ram_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
-                                 OBJECT(pci_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
-                                 OBJECT(system_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
-                                 OBJECT(system_io), &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
-                                 x86ms->below_4g_mem_size, &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
-                                 x86ms->above_4g_mem_size, &error_fatal);
-        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
-                                &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+    phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
+    object_property_add_child(OBJECT(machine), "i440fx", phb);
+    object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
+                             OBJECT(ram_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
+                             OBJECT(pci_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
+                             OBJECT(system_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
+                             OBJECT(system_io), &error_fatal);
+    object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
+                             x86ms->below_4g_mem_size, &error_fatal);
+    object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                             x86ms->above_4g_mem_size, &error_fatal);
+    object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+                            &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
-        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
-        pci_bus_map_irqs(pcms->pcibus,
-                         xen_enabled() ? xen_pci_slot_get_pirq
-                                       : pc_pci_slot_get_pirq);
+    pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+    pci_bus_map_irqs(pcms->pcibus,
+                     xen_enabled() ? xen_pci_slot_get_pirq
+                                   : pc_pci_slot_get_pirq);
 
-        hole64_size = object_property_get_uint(phb,
-                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
-                                               &error_abort);
-    }
+    hole64_size = object_property_get_uint(phb,
+                                           PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                                           &error_abort);
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
@@ -242,72 +245,51 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+    gsi_state = pc_gsi_create(&x86ms->gsi, true);
 
-    if (pcmc->pci_enabled) {
-        PCIDevice *pci_dev;
-        DeviceState *dev;
-        size_t i;
-
-        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
-        object_property_set_bool(OBJECT(pci_dev), "has-usb",
-                                 machine_usb(machine), &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
-                                 x86_machine_is_acpi_enabled(x86ms),
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
-                                 &error_abort);
-        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
-        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
-                                 x86_machine_is_smm_enabled(x86ms),
-                                 &error_abort);
-        dev = DEVICE(pci_dev);
-        for (i = 0; i < ISA_NUM_IRQS; i++) {
-            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
-        }
-        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
-
-        if (xen_enabled()) {
-            pci_device_set_intx_routing_notifier(
-                        pci_dev, piix_intx_routing_notifier_xen);
-
-            /*
-             * Xen supports additional interrupt routes from the PCI devices to
-             * the IOAPIC: the four pins of each PCI device on the bus are also
-             * connected to the IOAPIC directly.
-             * These additional routes can be discovered through ACPI.
-             */
-            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
-                         XEN_IOAPIC_NUM_PIRQS);
-        }
-
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                              "rtc"));
-        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
-        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
-        pci_ide_create_devs(PCI_DEVICE(dev));
-        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
-        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
-    } else {
-        uint32_t irq;
-
-        isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                              &error_abort);
-        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
-
-        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
-        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
-                                       &error_fatal);
-        isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
-
-        i8257_dma_init(OBJECT(machine), isa_bus, 0);
-        pcms->hpet_enabled = false;
+    pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+    object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                             machine_usb(machine), &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-acpi",
+                             x86_machine_is_acpi_enabled(x86ms),
+                             &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
+                             &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                             &error_abort);
+    qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
+    object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
+                             x86_machine_is_smm_enabled(x86ms),
+                             &error_abort);
+    dev = DEVICE(pci_dev);
+    for (i = 0; i < ISA_NUM_IRQS; i++) {
+        qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
     }
+    pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
+
+    if (xen_enabled()) {
+        pci_device_set_intx_routing_notifier(
+                    pci_dev, piix_intx_routing_notifier_xen);
+
+        /*
+         * Xen supports additional interrupt routes from the PCI devices to
+         * the IOAPIC: the four pins of each PCI device on the bus are also
+         * connected to the IOAPIC directly.
+         * These additional routes can be discovered through ACPI.
+         */
+        pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
+                     XEN_IOAPIC_NUM_PIRQS);
+    }
+
+    isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
+    x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                          "rtc"));
+    piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
+    dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
+    pci_ide_create_devs(PCI_DEVICE(dev));
+    pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
+    pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
+
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
@@ -321,7 +303,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+    pc_vga_init(isa_bus, pcms->pcibus);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
@@ -329,28 +311,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
-#ifdef CONFIG_IDE_ISA
-    if (!pcmc->pci_enabled) {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        int i;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-        for (i = 0; i < MAX_IDE_BUS; i++) {
-            ISADevice *dev;
-            char busname[] = "ide.0";
-            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                               ide_irq[i],
-                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-            /*
-             * The ide bus name is ide.0 for the first bus and ide.1 for the
-             * second one.
-             */
-            busname[4] = '0' + i;
-            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-        }
-    }
-#endif
-
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
 
-- 
2.51.0


