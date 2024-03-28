Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F42ACD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps7a-00051u-M7; Thu, 28 Mar 2024 11:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps74-0004HT-39
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:25 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps71-0002Nk-HA
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:21 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-513e6777af4so1700653e87.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641377; x=1712246177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1jNCFtYZSmUOBchzYP/5PRkNu6FHAH8wzcx932FlSY=;
 b=XbWjQnxCd4A8s2e6R2ZZH2FLan6+OX46wdU+XB7fbmC8D7KoBlW0tVY8fDdprXAmsc
 yyofQNmcN6MEiqrmiN9Je9BctqmfiZUtJehxH+XmHfNP2E4eGZFUlp9vQCfs64hhJui3
 LeCfwlVgq8RPWTdsmJLPhow9mnQpwzT0EGmegZ0HIoDxXvyQVuhKDFVdL/ZC6ujidDyW
 1lNzHsJcoVRH4/a0OUyWyh0CziG0ofgq0S6jIspqMkU/Nwnw3IPK4AQtomZKZ3ycv5lP
 zQUqR354g7iy1rtWn4wlab1WJQcpM2MBJ4jdmKpFjvSAtSt8ntGdmYEKeMwZ8mP4steB
 aafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641377; x=1712246177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a1jNCFtYZSmUOBchzYP/5PRkNu6FHAH8wzcx932FlSY=;
 b=Hc0JsKDUu2B3QRlODbEnNVkSTIX7ipdSU6gNbTlvtp6d5hAG2FmxqICR75VKJ/CfnV
 qme5jjSN3PgcuI68Y46hAahtxASO6OL4jTTZwkDU3ylB76R7S7GxQxoXToiZ0Ac6QTqz
 CkArGhWXqDyKaAD7ZB2fmSHPJFkwk86M3S5m+BLWtZmWyBcfILITEs9oLoW7rZWUoSMv
 ZkOvCUMqcrhKat3ij2m+I0kuVJM16sVYaXhoNHQAp0Axrf6bByyz4tQ+glGFewq+5IKc
 c0Xp8n/5UWe3BvhkArTkwk0JjIvBptfQUstFfWgKw3LYfnEq68ALRuGEL2DuTVRmsyhm
 /Bug==
X-Gm-Message-State: AOJu0YzXRdvLwWOhdYMrLqvKT1KVJK1vBRbiEcvt28MS9oK8rs8gLGOy
 hZjjBUEAKTOqDnkDNF64KBfk/baU+cKPL3zkQt+a0fiS+yxRP6AIyuTfMz5XnZ6/yn945fXDli4
 T
X-Google-Smtp-Source: AGHT+IHXj5Yz165xDmy5t4NF8sNvW6bTjTmkAtHF7KcewPKZsVQV788UJXIfXnYu/c9dgv0TxzoB4g==
X-Received: by 2002:a05:6512:110a:b0:515:c882:c44a with SMTP id
 l10-20020a056512110a00b00515c882c44amr2329607lfg.39.1711641377096; 
 Thu, 28 Mar 2024 08:56:17 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 z1-20020a170906668100b00a474b7bbc76sm886773ejo.56.2024.03.28.08.56.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:56:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 15/29] hw/i386/pc: Move FW/pflash related fields
 to PcPciMachineState
Date: Thu, 28 Mar 2024 16:54:23 +0100
Message-ID: <20240328155439.58719-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Only PCI-based machines use the set of parallel flash devices.
Move the fields from PCMachineState to PcPciMachineState.
Directly pass a PcPciMachineState argument to the
pc_system_flash/fw methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 10 ++++----
 hw/i386/pc.c         | 25 +++++++++---------
 hw/i386/pc_piix.c    |  3 ++-
 hw/i386/pc_sysfw.c   | 60 +++++++++++++++++++-------------------------
 4 files changed, 45 insertions(+), 53 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 67f8f4730b..668347c248 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -30,7 +30,6 @@ typedef struct PCMachineState {
     /* Pointers to devices and objects: */
     PCIBus *pcibus;
     I2CBus *smbus;
-    PFlashCFI01 *flash[2];
     ISADevice *pcspk;
     DeviceState *iommu;
     BusState *idebus[MAX_IDE_BUS];
@@ -47,7 +46,6 @@ typedef struct PCMachineState {
     bool i8042_enabled;
     bool default_bus_bypass_iommu;
     bool fd_bootchk;
-    uint64_t max_fw_size;
 
     /* ACPI Memory hotplug IO base address */
     hwaddr memhp_io_base;
@@ -61,7 +59,9 @@ typedef struct PcPciMachineState {
     Notifier machine_done;
 
     bool acpi_build_enabled;
+    uint64_t max_fw_size;
 
+    PFlashCFI01 *flash[2];
     CXLState cxl_devices_state;
 } PcPciMachineState;
 
@@ -184,9 +184,9 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 #define TYPE_PORT92 "port92"
 
 /* pc_sysfw.c */
-void pc_system_flash_create(PCMachineState *pcms);
-void pc_system_flash_cleanup_unused(PCMachineState *pcms);
-void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
+void pc_system_flash_create(PcPciMachineState *ppms);
+void pc_system_flash_cleanup_unused(PcPciMachineState *ppms);
+void pc_system_firmware_init(PcPciMachineState *ppms, MemoryRegion *rom_memory);
 bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
                                int *data_len);
 void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 33724791fd..5753a3ff0b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -957,7 +957,7 @@ void pc_memory_init(PCMachineState *pcms,
 
     /* Initialize PC system firmware */
     if (pci_enabled) {
-        pc_system_firmware_init(pcms, rom_memory);
+        pc_system_firmware_init(ppms, rom_memory);
     } else {
         x86_bios_rom_init(machine, "bios.bin", rom_memory, true);
     }
@@ -1617,8 +1617,8 @@ static void pc_machine_get_max_fw_size(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
-    PCMachineState *pcms = PC_MACHINE(obj);
-    uint64_t value = pcms->max_fw_size;
+    PcPciMachineState *ppms = PC_PCI_MACHINE(obj);
+    uint64_t value = ppms->max_fw_size;
 
     visit_type_size(v, name, &value, errp);
 }
@@ -1627,7 +1627,7 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
-    PCMachineState *pcms = PC_MACHINE(obj);
+    PcPciMachineState *ppms = PC_PCI_MACHINE(obj);
     uint64_t value;
 
     if (!visit_type_size(v, name, &value, errp)) {
@@ -1651,7 +1651,7 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
         return;
     }
 
-    pcms->max_fw_size = value;
+    ppms->max_fw_size = value;
 }
 
 
@@ -1672,7 +1672,6 @@ static void pc_machine_initfn(Object *obj)
     pcms->smbus_enabled = true;
     pcms->sata_enabled = true;
     pcms->i8042_enabled = true;
-    pcms->max_fw_size = 8 * MiB;
 #ifdef CONFIG_HPET
     pcms->hpet_enabled = true;
 #endif
@@ -1692,8 +1691,9 @@ static void pc_pci_machine_initfn(Object *obj)
     PcPciMachineState *ppms = PC_PCI_MACHINE(obj);
 
     ppms->acpi_build_enabled = true;
+    ppms->max_fw_size = 8 * MiB;
 
-    pc_system_flash_create(PC_MACHINE(obj));
+    pc_system_flash_create(ppms);
     cxl_machine_init(obj, &ppms->cxl_devices_state);
 
     ppms->machine_done.notify = pc_pci_machine_done;
@@ -1815,12 +1815,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
         pc_machine_get_default_bus_bypass_iommu,
         pc_machine_set_default_bus_bypass_iommu);
 
-    object_class_property_add(oc, PC_MACHINE_MAX_FW_SIZE, "size",
-        pc_machine_get_max_fw_size, pc_machine_set_max_fw_size,
-        NULL, NULL);
-    object_class_property_set_description(oc, PC_MACHINE_MAX_FW_SIZE,
-        "Maximum combined firmware size");
-
     object_class_property_add(oc, PC_MACHINE_SMBIOS_EP, "str",
         pc_machine_get_smbios_ep, pc_machine_set_smbios_ep,
         NULL, NULL);
@@ -1834,6 +1828,11 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
 static void pc_pci_machine_class_init(ObjectClass *oc, void *data)
 {
+    object_class_property_add(oc, PC_MACHINE_MAX_FW_SIZE, "size",
+                              pc_machine_get_max_fw_size,
+                              pc_machine_set_max_fw_size, NULL, NULL);
+    object_class_property_set_description(oc, PC_MACHINE_MAX_FW_SIZE,
+                                          "Maximum combined firmware size");
 }
 
 bool pc_machine_is_pci_enabled(PCMachineState *pcms)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7aa2598e10..6b3403d0bd 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -118,6 +118,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
     bool pci_enabled = pc_machine_is_pci_enabled(pcms);
+    PcPciMachineState *ppms = pci_enabled ? PC_PCI_MACHINE(pcms) : NULL;
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -228,7 +229,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
 
-        pc_system_flash_cleanup_unused(pcms);
+        pc_system_flash_cleanup_unused(ppms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
             xen_load_linux(pcms);
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 167ff24fcb..54d15afa49 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -71,7 +71,7 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
     memory_region_set_readonly(isa_bios, true);
 }
 
-static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
+static PFlashCFI01 *pc_pflash_create(PcPciMachineState *ppms,
                                      const char *name,
                                      const char *alias_prop_name)
 {
@@ -80,8 +80,8 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     qdev_prop_set_uint64(dev, "sector-length", FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 1);
     qdev_prop_set_string(dev, "name", name);
-    object_property_add_child(OBJECT(pcms), name, OBJECT(dev));
-    object_property_add_alias(OBJECT(pcms), alias_prop_name,
+    object_property_add_child(OBJECT(ppms), name, OBJECT(dev));
+    object_property_add_alias(OBJECT(ppms), alias_prop_name,
                               OBJECT(dev), "drive");
     /*
      * The returned reference is tied to the child property and
@@ -91,28 +91,24 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     return PFLASH_CFI01(dev);
 }
 
-void pc_system_flash_create(PCMachineState *pcms)
+void pc_system_flash_create(PcPciMachineState *ppms)
 {
-    assert(pc_machine_is_pci_enabled(pcms));
-
-    pcms->flash[0] = pc_pflash_create(pcms, "system.flash0", "pflash0");
-    pcms->flash[1] = pc_pflash_create(pcms, "system.flash1", "pflash1");
+    ppms->flash[0] = pc_pflash_create(ppms, "system.flash0", "pflash0");
+    ppms->flash[1] = pc_pflash_create(ppms, "system.flash1", "pflash1");
 }
 
-void pc_system_flash_cleanup_unused(PCMachineState *pcms)
+void pc_system_flash_cleanup_unused(PcPciMachineState *ppms)
 {
     char *prop_name;
     int i;
 
-    assert(pc_machine_is_pci_enabled(pcms));
-
-    for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
-        if (!qdev_is_realized(DEVICE(pcms->flash[i]))) {
+    for (i = 0; i < ARRAY_SIZE(ppms->flash); i++) {
+        if (!qdev_is_realized(DEVICE(ppms->flash[i]))) {
             prop_name = g_strdup_printf("pflash%d", i);
-            object_property_del(OBJECT(pcms), prop_name);
+            object_property_del(OBJECT(ppms), prop_name);
             g_free(prop_name);
-            object_unparent(OBJECT(pcms->flash[i]));
-            pcms->flash[i] = NULL;
+            object_unparent(OBJECT(ppms->flash[i]));
+            ppms->flash[i] = NULL;
         }
     }
 }
@@ -130,7 +126,7 @@ void pc_system_flash_cleanup_unused(PCMachineState *pcms)
  * pc_isa_bios_init().  Merging several flash devices for isa-bios is
  * not supported.
  */
-static void pc_system_flash_map(PCMachineState *pcms,
+static void pc_system_flash_map(PcPciMachineState *ppms,
                                 MemoryRegion *rom_memory)
 {
     hwaddr total_size = 0;
@@ -142,10 +138,8 @@ static void pc_system_flash_map(PCMachineState *pcms,
     void *flash_ptr;
     int flash_size;
 
-    assert(pc_machine_is_pci_enabled(pcms));
-
-    for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
-        system_flash = pcms->flash[i];
+    for (i = 0; i < ARRAY_SIZE(ppms->flash); i++) {
+        system_flash = ppms->flash[i];
         blk = pflash_cfi01_get_blk(system_flash);
         if (!blk) {
             break;
@@ -166,10 +160,10 @@ static void pc_system_flash_map(PCMachineState *pcms,
         }
         if ((hwaddr)size != size
             || total_size > HWADDR_MAX - size
-            || total_size + size > pcms->max_fw_size) {
+            || total_size + size > ppms->max_fw_size) {
             error_report("combined size of system firmware exceeds "
                          "%" PRIu64 " bytes",
-                         pcms->max_fw_size);
+                         ppms->max_fw_size);
             exit(1);
         }
 
@@ -194,23 +188,21 @@ static void pc_system_flash_map(PCMachineState *pcms,
     }
 }
 
-void pc_system_firmware_init(PCMachineState *pcms,
+void pc_system_firmware_init(PcPciMachineState *ppms,
                              MemoryRegion *rom_memory)
 {
     int i;
-    BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
-
-    assert(pc_machine_is_pci_enabled(pcms));
+    BlockBackend *pflash_blk[ARRAY_SIZE(ppms->flash)];
 
     /* Map legacy -drive if=pflash to machine properties */
-    for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
-        pflash_cfi01_legacy_drive(pcms->flash[i],
+    for (i = 0; i < ARRAY_SIZE(ppms->flash); i++) {
+        pflash_cfi01_legacy_drive(ppms->flash[i],
                                   drive_get(IF_PFLASH, 0, i));
-        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
+        pflash_blk[i] = pflash_cfi01_get_blk(ppms->flash[i]);
     }
 
     /* Reject gaps */
-    for (i = 1; i < ARRAY_SIZE(pcms->flash); i++) {
+    for (i = 1; i < ARRAY_SIZE(ppms->flash); i++) {
         if (pflash_blk[i] && !pflash_blk[i - 1]) {
             error_report("pflash%d requires pflash%d", i, i - 1);
             exit(1);
@@ -219,7 +211,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
 
     if (!pflash_blk[0]) {
         /* Machine property pflash0 not set, use ROM mode */
-        x86_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory, false);
+        x86_bios_rom_init(MACHINE(ppms), "bios.bin", rom_memory, false);
     } else {
         if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
             /*
@@ -231,10 +223,10 @@ void pc_system_firmware_init(PCMachineState *pcms,
             exit(1);
         }
 
-        pc_system_flash_map(pcms, rom_memory);
+        pc_system_flash_map(ppms, rom_memory);
     }
 
-    pc_system_flash_cleanup_unused(pcms);
+    pc_system_flash_cleanup_unused(ppms);
 }
 
 void x86_firmware_configure(void *ptr, int size)
-- 
2.41.0


