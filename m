Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE86C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 22:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYCVC-0007ID-6q; Thu, 08 Feb 2024 17:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCVA-0007Hk-Dg
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:12 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCV8-0005Eo-8s
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:11 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so609891a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 14:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707429848; x=1708034648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wa855J4F52XiMiTJ4ylFN2d4k/xaiIUVIXYd3X0jIL8=;
 b=ezPX8Fez9NeuL5oTUnibGsxm1NtdVOIbmtRMoDVG5V/Z1wopldQcfjbHE0WdqzNR1K
 +rQLz63mLEDxFyu83eHTrb/S0HKYc3oGKe4gcWxt7ZNcJdOdiy8P+JDXwHYX+vCffswO
 hu9qFrXu+6GDIyupepUT/fsep/15PFt+84D1hGrfB9hsy2wLk48rP71Xr4oD8Kd16a1S
 O84/JvrDFD5lb3MlPu0IcCRmgIBV/+Ui7WNNqvGExTIu2yJhr8H1gKVtynbmRqFWwtyj
 rH6bBR1hKOrxJSJJS61nOmy0UJHnACyawyN068rw8MHKpzEk0COhw2x/KxXAH2+XMB3F
 AaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707429848; x=1708034648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wa855J4F52XiMiTJ4ylFN2d4k/xaiIUVIXYd3X0jIL8=;
 b=PnjaV8/WdZjE1ataaGpN+W+OKZ+qp0qXyZoEOb540DhVH6UNlIZVMoy31Zyri45hwT
 F4SAHXqijJoi5EEktn83NZJQyN2lKprsQFQIDfz5lHEm2264FheHeKnNLp+7PHLCWnBl
 qylMo8URH0vd6yIDSjHyAjMbzgl7D7Yy7xiXMP5ycuUnndGMIbfdzUt34o97jmeVkK0z
 1hG6QaBbaUx9+SnDRW9rOHZYQpxQtoXIs5K9NJFBp/Rh51SGnB2gvHRAoVzl8QAbRT3z
 gUBlnyalIc0YNjUnSi1biCYHWqnJf/e35u8qlbjx7Ft/pr4GOzoUpCc18GR/4iM31XoZ
 1teg==
X-Gm-Message-State: AOJu0YyB2QR6X88lUSC6AozncjXdQU2+yITNGMpcddD8i6rsnlOizFrS
 wDSVVcuW7RRifP3t80Ct0wDYfuDQrM6p64mU53nQL9IA6PxCErLV7zWfNcuH
X-Google-Smtp-Source: AGHT+IGoPRJysr95h4BEDipVo452uMpheNw7x1rQKpYicu0iTzkcz7OvZjANg+53YDgetJaS65IE6w==
X-Received: by 2002:a17:906:1694:b0:a38:9446:106 with SMTP id
 s20-20020a170906169400b00a3894460106mr420016ejd.51.1707429848010; 
 Thu, 08 Feb 2024 14:04:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWTFcWxTj4X11xfNufesgCfXw0Xt8p0GCak2ARi1q8IYDZpvbI0YdsKArN6Z3aiapM9UZwc4uRMt1tmU+JMuOTb1Uu6bulqlmCFDGtITl9h7259c+5LgZYGTnARmTkWf8fDTMScwCj2JpO53bjhVHgOrb00hqvKAgpRNNird78wFuc8ooQyOg7OW46sFeAnshNjUJnCAhpCsR6oHgCQjR/glHyGX3YjQAcTcfl/Uw7GKBzevPDz
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 ti9-20020a170907c20900b00a3109a492d4sm109753ejc.20.2024.02.08.14.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 14:04:06 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 9/9] hw/i386/pc_{piix,
 q35}: Eliminate local pci_bus/pci_host variables
Date: Thu,  8 Feb 2024 23:03:49 +0100
Message-ID: <20240208220349.4948-10-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208220349.4948-1-shentey@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There is no advantage in having these local variables which 1/ needlessly have
different identifiers in both machines and 2/ which are redundant to pcms->bus
which is almost as short.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_piix.c | 14 ++++++--------
 hw/i386/pc_q35.c  | 16 +++++++---------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index adb7926b2e..a9f0e255ad 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -109,7 +109,6 @@ static void pc_init1(MachineState *machine,
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     Object *phb = NULL;
-    PCIBus *pci_bus = NULL;
     ISABus *isa_bus;
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
@@ -213,11 +212,10 @@ static void pc_init1(MachineState *machine,
                                 &error_fatal);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
-        pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
-        pci_bus_map_irqs(pci_bus,
+        pcms->bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+        pci_bus_map_irqs(pcms->bus,
                          xen_enabled() ? xen_pci_slot_get_pirq
                                        : pc_pci_slot_get_pirq);
-        pcms->bus = pci_bus;
 
         hole64_size = object_property_get_uint(phb,
                                                PCI_HOST_PROP_PCI_HOLE64_SIZE,
@@ -262,7 +260,7 @@ static void pc_init1(MachineState *machine,
         for (i = 0; i < ISA_NUM_IRQS; i++) {
             qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
         }
-        pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
+        pci_realize_and_unref(pci_dev, pcms->bus, &error_fatal);
 
         if (xen_enabled()) {
             pci_device_set_intx_routing_notifier(
@@ -274,7 +272,7 @@ static void pc_init1(MachineState *machine,
              * connected to the IOAPIC directly.
              * These additional routes can be discovered through ACPI.
              */
-            pci_bus_irqs(pci_bus, xen_intx_set_irq, pci_dev,
+            pci_bus_irqs(pcms->bus, xen_intx_set_irq, pci_dev,
                          XEN_IOAPIC_NUM_PIRQS);
         }
 
@@ -313,7 +311,7 @@ static void pc_init1(MachineState *machine,
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pci_bus : NULL);
+    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->bus : NULL);
 
     assert(pcms->vmport != ON_OFF_AUTO__MAX);
     if (pcms->vmport == ON_OFF_AUTO_AUTO) {
@@ -324,7 +322,7 @@ static void pc_init1(MachineState *machine,
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, true,
                          0x4);
 
-    pc_nic_init(pcmc, isa_bus, pci_bus);
+    pc_nic_init(pcmc, isa_bus, pcms->bus);
 
 #ifdef CONFIG_IDE_ISA
     if (!pcmc->pci_enabled) {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d313ba5509..0eef9e6ca1 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -122,7 +122,6 @@ static void pc_q35_init(MachineState *machine)
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
     Object *phb;
-    PCIBus *host_bus;
     PCIDevice *lpc;
     DeviceState *lpc_dev;
     BusState *idebus[MAX_SATA_PORTS];
@@ -227,8 +226,7 @@ static void pc_q35_init(MachineState *machine)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
     /* pci */
-    host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
-    pcms->bus = host_bus;
+    pcms->bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
 
     /* irq lines */
     gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
@@ -242,7 +240,7 @@ static void pc_q35_init(MachineState *machine)
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
     }
-    pci_realize_and_unref(lpc, host_bus, &error_fatal);
+    pci_realize_and_unref(lpc, pcms->bus, &error_fatal);
 
     x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
@@ -293,7 +291,7 @@ static void pc_q35_init(MachineState *machine)
 
     if (pcms->sata_enabled) {
         /* ahci and SATA device, for q35 1 ahci controller is built-in */
-        ahci = pci_create_simple_multifunction(host_bus,
+        ahci = pci_create_simple_multifunction(pcms->bus,
                                                PCI_DEVFN(ICH9_SATA1_DEV,
                                                          ICH9_SATA1_FUNC),
                                                "ich9-ahci");
@@ -308,14 +306,14 @@ static void pc_q35_init(MachineState *machine)
 
     if (machine_usb(machine)) {
         /* Should we create 6 UHCI according to ich9 spec? */
-        ehci_create_ich9_with_companions(host_bus, 0x1d);
+        ehci_create_ich9_with_companions(pcms->bus, 0x1d);
     }
 
     if (pcms->smbus_enabled) {
         PCIDevice *smb;
 
         /* TODO: Populate SPD eeprom data.  */
-        smb = pci_create_simple_multifunction(host_bus,
+        smb = pci_create_simple_multifunction(pcms->bus,
                                               PCI_DEVFN(ICH9_SMB_DEV,
                                                         ICH9_SMB_FUNC),
                                               TYPE_ICH9_SMB_DEVICE);
@@ -327,8 +325,8 @@ static void pc_q35_init(MachineState *machine)
     pc_cmos_init(pcms, idebus[0], idebus[1], x86ms->rtc);
 
     /* the rest devices to which pci devfn is automatically assigned */
-    pc_vga_init(isa_bus, host_bus);
-    pc_nic_init(pcmc, isa_bus, host_bus);
+    pc_vga_init(isa_bus, pcms->bus);
+    pc_nic_init(pcmc, isa_bus, pcms->bus);
 
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-- 
2.43.0


