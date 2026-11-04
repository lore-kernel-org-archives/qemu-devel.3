Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028CD606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=odTMKEZA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOasr-00070G-T3; Wed, 04 Nov 2026 08:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOasp-0006zs-My
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 08:18:31 -0500
Received: from out-246.mta1.migadu.com ([95.215.58.246] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOasn-0002y5-Id
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 08:18:31 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=WgMvKjmjAmDoq+b+d/1gPxUFchVvWbMDgA7lbEpN1pY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793798307; v=1; x=1794403107;
 b=odTMKEZABhzwslGAjAjdCayWw6P5zOBWqEKQCy11WN/Ot5OOXEiU8NQCz03VFIODhUvHIhWC
 WafpQOwvHcFz9z6YB7zDqrB1wFhslzUD/GOu7Uql3UVA80BDtUvL2oZea6w9VBx4QxRUBEQIIFP
 i7Nwecu0G9ibLguWi9BqiXxs=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 90a5ff6a45cdb2f1;
 Wed, 04 Nov 2026 13:18:27 +0000
X-Mizu-Trace-ID: 90a5ff6a45cdb2f1
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 zhao1.liu@intel.com, richard.henderson@linaro.org, farosas@suse.de,
 lvivier@redhat.com, pierrick.bouvier@oss.qualcomm.com, thuth@redhat.com,
 peter.maydell@linaro.org, kraxel@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com, deller@gmx.de, clg@redhat.com,
 jamin_lin@aspeedtech.com, junjie.cao@linux.dev
Subject: [RFC PATCH 2/4] hw/i386: let -usb create qemu-xhci on new pc and q35
 machine types
Date: Wed,  4 Nov 2026 07:18:08 -0600
Message-ID: <20261104131810.2063834-3-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104131810.2063834-1-junjie.cao@linux.dev>
References: <20261104131810.2063834-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.246; envelope-from=junjie.cao@linux.dev;
 helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

-usb gives the PIIX3 UHCI on pc and the ICH9 EHCI with three UHCI
companions on q35, so the one-switch way to get USB still picks a
USB 1.1 or 2.0 controller. libvirt disables machine-created USB
controllers with usb=off and adds controllers explicitly.

From pc-i440fx-12.0 and pc-q35-12.0 on, create qemu-xhci at 1d.0
instead. On q35 that is where the first UHCI sat, so every other
device keeps its PCI address. On pc the PIIX3's own USB function is
out: the i440fx DSDT routes slot 1 INTA to the SCI link and qemu-xhci
interrupts on INTA, so a guest that does not use MSI gets "PCI INT A:
no GSI" and never enumerates its devices; the UHCI there uses INTD.
Slot 1d is free on pc and keeps the two machines alike.

The device stays optional in Kconfig. A build without it fails -usb
with a message instead of a fatal "unknown type" error.

Guests without an xHCI driver (Windows 7 and earlier) need an older
machine type or an explicit -device piix3-usb-uhci.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/qemu-devel/CAFEAcA9b2oeZaZtGkn5YPMKOXWDdZQEvdoBj5mGVh51aKi-BYw@mail.gmail.com/
Link: https://lore.kernel.org/qemu-devel/agrz1zBDwGc9Bvlo@sirius.home.kraxel.org/
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 hw/i386/Kconfig      |  2 ++
 hw/i386/pc.c         | 18 ++++++++++++++++++
 hw/i386/pc_piix.c    | 11 ++++++++++-
 hw/i386/pc_q35.c     | 12 ++++++++++--
 include/hw/i386/pc.h |  4 ++++
 5 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index e27d8816e5..1d88726618 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -78,6 +78,7 @@ config I440FX
     imply E1000_PCI
     imply VMPORT
     imply VMMOUSE
+    imply USB_XHCI_PCI
     select ACPI_PIIX4
     select PC_PCI
     select PC_ACPI
@@ -108,6 +109,7 @@ config Q35
     imply VMPORT
     imply VMMOUSE
     imply IOMMUFD
+    imply USB_XHCI_PCI
     select PC_PCI
     select PC_ACPI
     select PCI_EXPRESS_Q35
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8a6b7978cc..6b8fc2914e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -55,6 +55,7 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/cxl/cxl_host.h"
 #include "hw/usb/usb.h"
+#include "hw/usb/xhci.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
 #include "hw/virtio/virtio-iommu.h"
@@ -1164,6 +1165,23 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
     }
 }
 
+/*
+ * 1d.0 is where q35's first UHCI sat. On pc the PIIX3's own USB function
+ * is out: the DSDT routes slot 1 INTA to the SCI link and qemu-xhci
+ * interrupts on INTA.
+ */
+void pc_usb_xhci_create(PCIBus *pci_bus)
+{
+    DeviceState *dev = qdev_try_new(TYPE_QEMU_XHCI);
+
+    if (!dev) {
+        error_report("-usb: this build has no %s device", TYPE_QEMU_XHCI);
+        exit(1);
+    }
+    qdev_prop_set_int32(dev, "addr", PCI_DEVFN(0x1d, 0));
+    qdev_realize_and_unref(dev, BUS(pci_bus), &error_fatal);
+}
+
 void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
 {
     qemu_irq *i8259;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c0ddf6011f..845092f5f1 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -245,7 +245,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     pci_dev = pci_new_multifunction(-1,
                                     pc_south_bridge_type[pcms->south_bridge]);
     object_property_set_bool(OBJECT(pci_dev), "has-usb",
-                             machine_usb(machine), &error_abort);
+                             machine_usb(machine) && !pcmc->usb_xhci,
+                             &error_abort);
     object_property_set_bool(OBJECT(pci_dev), "has-acpi",
                              x86_machine_is_acpi_enabled(x86ms),
                              &error_abort);
@@ -305,6 +306,10 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
+    if (machine_usb(machine) && pcmc->usb_xhci) {
+        pc_usb_xhci_create(pcms->pcibus);
+    }
+
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
 
@@ -375,6 +380,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     pcmc->default_south_bridge = PC_SOUTH_BRIDGE_OPTION_PIIX3;
     pcmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
+    pcmc->usb_xhci = true;
 
     m->family = "pc_piix";
     m->desc = "Standard PC (i440FX + PIIX, 1996)";
@@ -406,7 +412,10 @@ DEFINE_I440FX_MACHINE_AS_LATEST(12, 0);
 
 static void pc_i440fx_machine_11_2_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_machine_12_0_options(m);
+    pcmc->usb_xhci = false;
     compat_props_add(m->compat_props, hw_compat_11_2, hw_compat_11_2_len);
     compat_props_add(m->compat_props, pc_compat_11_2, pc_compat_11_2_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index e302ff283c..8a856bf199 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -298,8 +298,12 @@ static void pc_q35_init(MachineState *machine)
     }
 
     if (machine_usb(machine)) {
-        /* Should we create 6 UHCI according to ich9 spec? */
-        ehci_create_ich9_with_companions(pcms->pcibus, 0x1d);
+        if (pcmc->usb_xhci) {
+            pc_usb_xhci_create(pcms->pcibus);
+        } else {
+            /* Should we create 6 UHCI according to ich9 spec? */
+            ehci_create_ich9_with_companions(pcms->pcibus, 0x1d);
+        }
     }
 
     if (pcms->smbus_enabled) {
@@ -353,6 +357,7 @@ static void pc_q35_machine_options(MachineClass *m)
     ObjectClass *oc = OBJECT_CLASS(m);
     pcmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
+    pcmc->usb_xhci = true;
 
     m->family = "pc_q35";
     m->desc = "Standard PC (Q35 + ICH9, 2009)";
@@ -387,7 +392,10 @@ DEFINE_Q35_MACHINE_AS_LATEST(12, 0);
 
 static void pc_q35_machine_11_2_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_q35_machine_12_0_options(m);
+    pcmc->usb_xhci = false;
     compat_props_add(m->compat_props, hw_compat_11_2, hw_compat_11_2_len);
     compat_props_add(m->compat_props, pc_compat_11_2, pc_compat_11_2_len);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index caceddc74b..c378c804f8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -119,6 +119,9 @@ struct PCMachineClass {
     /* create kvmclock device even when KVM PV features are not exposed */
     bool kvmclock_create_always;
 
+    /* -usb creates qemu-xhci instead of the chipset's UHCI/EHCI */
+    bool usb_xhci;
+
     /*
      * whether the machine type implements broken 32-bit address space bound
      * check for memory.
@@ -195,6 +198,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
                           bool create_fdctrl,
                           uint32_t hpet_irqs);
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus);
+void pc_usb_xhci_create(PCIBus *pci_bus);
 
 void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 
-- 
2.43.0


