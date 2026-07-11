Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAED7C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigLK-0007LN-Sd; Sat, 11 Jul 2026 18:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigLE-0007Hv-Ir; Sat, 11 Jul 2026 18:38:38 -0400
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.68.102])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigL5-0005AW-QR; Sat, 11 Jul 2026 18:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809507; x=1815345507;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SAbO8xtgufeiztqHcf6570YLxbKaQVabWzjh+fB2HvY=;
 b=nUwFpdLAmcnzZivr4wfscgu5qnOusDJerIU4vWvgfml98mzOk1QzSKuu
 x5EDx4pDeLCDcAof2gp5NsUQSnzoeQoLWJGbZQzuE0YoM4pgsxhZ88riF
 AHXLW9kGCgOdSwPPWEEjq2c0IhPPCChVT8qPS8zUIZHFkMbsjfby/TAbS
 u4fguj+R++VyVK9y9VRg17rjmgMnR+XajlZrxo/G+VEJW+gB5m9X7ge7j
 ragsWKYKYC99KAGdWgI9dl6wUpEUhabIX3+fV67BiO6kXhQ2HPLus2uw2
 rrkvxIUxoqiTbAS9iJgsT6OtjoQLKQ/iwFrXtDaJOtEhcCvxjL2ikR28f g==;
X-CSE-ConnectionGUID: O/2dgsxqTRC/weQi37YUxQ==
X-CSE-MsgGUID: nDNvud2SRx+U3uYU0WvduQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23516973"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:38:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:21086]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.214:2525]
 with esmtp (Farcaster)
 id db881b66-8c38-4543-8527-b4d50cb00405; Sat, 11 Jul 2026 22:38:23 +0000 (UTC)
X-Farcaster-Flow-ID: db881b66-8c38-4543-8527-b4d50cb00405
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:38:23 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:38:14 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Brian
 Cain" <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Gautam Gala" <ggala@linux.ibm.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, "Laurent Vivier" <laurent@vivier.eu>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael Rolnik" <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 "Niek Linnenbank" <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, "Paolo Bonzini" <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>, Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow
 <shentey@gmail.com>, Stafford Horne <shorne@gmail.com>, Sergio Lopez
 <slp@redhat.com>, "Subbaraya Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth
 <th.huth+qemu@posteo.eu>, "Ran Wang" <wangran@bosc.ac.cn>, Hao Wu
 <wuhaotsh@google.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: [RFC PATCH 005/134] pci: Make pci_new*()/pci_create_simple*() take a
 QOM parent
Date: Sat, 11 Jul 2026 22:34:58 +0000
Message-ID: <20260711223707.42139-6-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.68.102;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Same rename-and-reintroduce treatment as qdev_new() and
sysbus_create_*(): mechanically rename the four PCI creation
helpers to *_orphan() and reintroduce the short names with a
leading (parent, id, ...) pair.

The parented pci_create_simple*() variants call qdev_realize() (not
pci_realize_and_unref()) since the child<> property already holds
the sole reference.

The mechanical rename part is generated by

  spatch --sp-file scripts/coccinelle/qom-parent/pci-new-orphan.cocci \
         --in-place --include-headers --dir .

or equivalently

  git ls-files '*.[ch]' '*.[ch].inc' '*.rst' '*.py' | \
      grep -v '^subprojects/' | \
      xargs sed -i \
        's/\bpci_create_simple_multifunction\b/&_orphan/g;
         s/\bpci_create_simple\b/&_orphan/g;
         s/\bpci_new_multifunction\b/&_orphan/g;
         s/\bpci_new\b/&_orphan/g'

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/alpha/dp264.c                              |  4 +-
 hw/arm/realview.c                             |  4 +-
 hw/arm/sbsa-ref.c                             |  2 +-
 hw/arm/versatilepb.c                          |  4 +-
 hw/hppa/machine.c                             |  8 +--
 hw/i386/pc.c                                  |  2 +-
 hw/i386/pc_piix.c                             |  4 +-
 hw/i386/pc_q35.c                              | 10 +--
 hw/mips/boston.c                              |  2 +-
 hw/mips/fuloong2e.c                           |  4 +-
 hw/mips/loongson3_virt.c                      |  2 +-
 hw/mips/malta.c                               |  2 +-
 hw/pci-host/articia.c                         |  4 +-
 hw/pci-host/bonito.c                          |  2 +-
 hw/pci-host/grackle.c                         |  2 +-
 hw/pci-host/gt64120.c                         |  2 +-
 hw/pci-host/i440fx.c                          |  2 +-
 hw/pci-host/mv64361.c                         |  2 +-
 hw/pci-host/pnv_phb.c                         |  2 +-
 hw/pci-host/ppc4xx_pci.c                      |  2 +-
 hw/pci-host/ppce500.c                         |  2 +-
 hw/pci-host/raven.c                           |  2 +-
 hw/pci-host/sabre.c                           |  6 +-
 hw/pci-host/sh_pci.c                          |  2 +-
 hw/pci-host/uninorth.c                        |  8 +--
 hw/pci/pci.c                                  | 65 +++++++++++++++----
 hw/pci/pcie_sriov.c                           |  2 +-
 hw/ppc/amigaone.c                             |  2 +-
 hw/ppc/mac_newworld.c                         |  4 +-
 hw/ppc/mac_oldworld.c                         |  4 +-
 hw/ppc/pegasos.c                              |  2 +-
 hw/ppc/prep.c                                 |  4 +-
 hw/ppc/sam460ex.c                             |  4 +-
 hw/ppc/spapr.c                                |  2 +-
 hw/riscv/boston-aia.c                         |  2 +-
 hw/sparc64/sun4u.c                            |  8 +--
 hw/vfio/igd.c                                 |  2 +-
 hw/xen/xen_pt_graphics.c                      |  2 +-
 include/hw/pci/pci.h                          | 18 +++--
 .../qom-parent/pci-new-orphan.cocci           | 28 ++++++++
 40 files changed, 157 insertions(+), 78 deletions(-)
 create mode 100644 scripts/coccinelle/qom-parent/pci-new-orphan.cocci

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index f928e0cee8..6999168df6 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -110,7 +110,7 @@ static void clipper_init(MachineState *machine)
      * Importantly, we need to provide a PCI device node for it, otherwise
      * some operating systems won't notice there's an ISA bus to configure.
      */
-    i82378_dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(7, 0), "i82378"));
+    i82378_dev = DEVICE(pci_create_simple_orphan(pci_bus, PCI_DEVFN(7, 0), "i82378"));
     isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
 
     /* Connect the ISA PIC to the Typhoon IRQ used for ISA interrupts. */
@@ -129,7 +129,7 @@ static void clipper_init(MachineState *machine)
     isa_create_simple(isa_bus, TYPE_SMC37C669_SUPERIO);
 
     /* IDE disk setup.  */
-    pci_dev = pci_create_simple(pci_bus, -1, "cmd646-ide");
+    pci_dev = pci_create_simple_orphan(pci_bus, -1, "cmd646-ide");
     pci_ide_create_devs(pci_dev);
 
     /* Load PALcode.  Given that this is not "real" cpu palcode,
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 287c092c2d..0642e35dd2 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -297,11 +297,11 @@ static void realview_init(MachineState *machine,
         sysbus_connect_irq(busdev, 3, pic[51]);
         pci_bus = (PCIBus *)qdev_get_child_bus(dev, "pci");
         if (machine_usb(machine)) {
-            pci_create_simple(pci_bus, -1, "pci-ohci");
+            pci_create_simple_orphan(pci_bus, -1, "pci-ohci");
         }
         n = drive_get_max_bus(IF_SCSI);
         while (n >= 0) {
-            dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
+            dev = DEVICE(pci_create_simple_orphan(pci_bus, -1, "lsi53c895a"));
             lsi53c8xx_handle_legacy_cmdline(dev);
             n--;
         }
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index a821833fa7..f9fb681d31 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -695,7 +695,7 @@ static void create_pcie(SBSAMachineState *sms,
 
     pci_init_nic_devices(pci->bus, mc->default_nic);
 
-    pci_create_simple(pci->bus, -1, "bochs-display");
+    pci_create_simple_orphan(pci->bus, -1, "bochs-display");
 
     create_smmu(sms, pci->bus, sysmem, secure_sysmem);
 }
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index b80410db0d..81bd397b5d 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -270,11 +270,11 @@ static void versatile_init(MachineState *machine, int board_id)
     pci_init_nic_devices(pci_bus, "rtl8139");
 
     if (machine_usb(machine)) {
-        pci_create_simple(pci_bus, -1, "pci-ohci");
+        pci_create_simple_orphan(pci_bus, -1, "pci-ohci");
     }
     n = drive_get_max_bus(IF_SCSI);
     while (n >= 0) {
-        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
+        dev = DEVICE(pci_create_simple_orphan(pci_bus, -1, "lsi53c895a"));
         lsi53c8xx_handle_legacy_cmdline(dev);
         n--;
     }
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 02cafbda85..91fe4845c4 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -428,7 +428,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     if (pci_bus && hppa_is_pa20(&cpu[0]->env)) {
         /* BMC board: HP Diva GSP PCI card */
-        pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");
+        pci_dev = pci_new_multifunction_orphan(PCI_DEVFN(2, 0), "diva-gsp");
         if (!lasi_dev) {
             /* bind default keyboard/serial to Diva card */
             qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(0));
@@ -443,7 +443,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     if (!lasi_dev && machine->enable_graphics && defaults_enabled()) {
         USBBus *usb_bus;
 
-        pci_create_simple(pci_bus, -1, "pci-ohci");
+        pci_create_simple_orphan(pci_bus, -1, "pci-ohci");
         usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                           &error_abort));
         usb_create_simple(usb_bus, "usb-kbd");
@@ -721,7 +721,7 @@ static void machine_HP_B160L_init(MachineState *machine)
 
     /* SCSI disk setup. */
     if (drive_get_max_bus(IF_SCSI) >= 0) {
-        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
+        dev = DEVICE(pci_create_simple_orphan(pci_bus, -1, "lsi53c895a"));
         lsi53c8xx_handle_legacy_cmdline(dev);
     }
 
@@ -773,7 +773,7 @@ static void machine_HP_C3700_init(MachineState *machine)
 
     /* SCSI disk setup. */
     if (drive_get_max_bus(IF_SCSI) >= 0) {
-        DeviceState *dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
+        DeviceState *dev = DEVICE(pci_create_simple_orphan(pci_bus, -1, "lsi53c895a"));
         lsi53c8xx_handle_legacy_cmdline(dev);
     }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bd5ab3d854..11a9d5df97 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1104,7 +1104,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         xen_gnttab_create();
         xen_xenstore_create();
         if (pcms->pcibus) {
-            pci_create_simple(pcms->pcibus, -1, "xen-platform");
+            pci_create_simple_orphan(pcms->pcibus, -1, "xen-platform");
         }
         xen_bus_init();
     }
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e580f9f2a6..bd4c129143 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -236,7 +236,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     gsi_state = pc_gsi_create(&x86ms->gsi, true);
 
-    pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+    pci_dev = pci_new_multifunction_orphan(-1, pcms->south_bridge);
     object_property_set_bool(OBJECT(pci_dev), "has-usb",
                              machine_usb(machine), &error_abort);
     object_property_set_bool(OBJECT(pci_dev), "has-acpi",
@@ -384,7 +384,7 @@ static void pc_xen_hvm_init(MachineState *machine)
                       : TYPE_I440FX_PCI_DEVICE);
 
     xen_igd_reserve_slot(pcms->pcibus);
-    pci_create_simple(pcms->pcibus, -1, "xen-platform");
+    pci_create_simple_orphan(pcms->pcibus, -1, "xen-platform");
 }
 #endif
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0731403e55..daa75dbc26 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -114,12 +114,12 @@ static int ehci_create_ich9_with_companions(PCIBus *bus, int slot)
         return -1;
     }
 
-    ehci = pci_new_multifunction(PCI_DEVFN(slot, 7), name);
+    ehci = pci_new_multifunction_orphan(PCI_DEVFN(slot, 7), name);
     pci_realize_and_unref(ehci, bus, &error_fatal);
     usbbus = QLIST_FIRST(&ehci->qdev.child_bus);
 
     for (i = 0; i < 3; i++) {
-        uhci = pci_new_multifunction(PCI_DEVFN(slot, comp[i].func),
+        uhci = pci_new_multifunction_orphan(PCI_DEVFN(slot, comp[i].func),
                                      comp[i].name);
         qdev_prop_set_string(&uhci->qdev, "masterbus", usbbus->name);
         qdev_prop_set_uint32(&uhci->qdev, "firstport", comp[i].port);
@@ -235,7 +235,7 @@ static void pc_q35_init(MachineState *machine)
     gsi_state = pc_gsi_create(&x86ms->gsi, true);
 
     /* create ISA bus */
-    lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
+    lpc = pci_new_multifunction_orphan(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
                                 TYPE_ICH9_LPC_DEVICE);
     lpc_dev = DEVICE(lpc);
     qdev_prop_set_bit(lpc_dev, "smm-enabled",
@@ -290,7 +290,7 @@ static void pc_q35_init(MachineState *machine)
         AHCIPCIState *ich9;
 
         /* ahci and SATA device, for q35 1 ahci controller is built-in */
-        pdev = pci_create_simple_multifunction(pcms->pcibus,
+        pdev = pci_create_simple_multifunction_orphan(pcms->pcibus,
                                                PCI_DEVFN(ICH9_SATA1_DEV,
                                                          ICH9_SATA1_FUNC),
                                                "ich9-ahci");
@@ -311,7 +311,7 @@ static void pc_q35_init(MachineState *machine)
         PCIDevice *smb;
 
         /* TODO: Populate SPD eeprom data.  */
-        smb = pci_create_simple_multifunction(pcms->pcibus,
+        smb = pci_create_simple_multifunction_orphan(pcms->pcibus,
                                               PCI_DEVFN(ICH9_SMB_DEV,
                                                         ICH9_SMB_FUNC),
                                               TYPE_ICH9_SMB_DEVICE);
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index e328c578a5..18ede54ae8 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -769,7 +769,7 @@ static void boston_mach_init(MachineState *machine)
     qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
                              boston_lcd_event, NULL, s, NULL, true);
 
-    pdev = pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
+    pdev = pci_create_simple_multifunction_orphan(&PCI_BRIDGE(&pcie2->root)->sec_bus,
                                            PCI_DEVFN(0, 0), TYPE_ICH9_AHCI);
     ich9 = ICH9_AHCI(pdev);
     g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 9a712ee930..e0cbf4df3d 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -286,7 +286,7 @@ static void mips_fuloong2e_init(MachineState *machine)
     pci_bus = bonito_init((qemu_irq *)&(env->irq[2]));
 
     /* South bridge -> IP5 */
-    pci_dev = pci_new_multifunction(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
+    pci_dev = pci_new_multifunction_orphan(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
                                     TYPE_VT82C686B_ISA);
 
     /* Set properties on individual devices before realizing the south bridge */
@@ -312,7 +312,7 @@ static void mips_fuloong2e_init(MachineState *machine)
     /* GPU */
     if (vga_interface_type != VGA_NONE) {
         vga_interface_created = true;
-        pci_dev = pci_new(-1, "ati-vga");
+        pci_dev = pci_new_orphan(-1, "ati-vga");
         dev = DEVICE(pci_dev);
         qdev_prop_set_uint32(dev, "vgamem_mb", 16);
         qdev_prop_set_uint16(dev, "x-device-id", 0x5159);
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 854f7f6801..1729eb1c0b 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -465,7 +465,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
     if (defaults_enabled() && object_class_by_name("pci-ohci")) {
         USBBus *usb_bus;
 
-        pci_create_simple(pci_bus, -1, "pci-ohci");
+        pci_create_simple_orphan(pci_bus, -1, "pci-ohci");
         usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                           &error_abort));
         usb_create_simple(usb_bus, "usb-kbd");
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index fc5dbf262c..38edbbadd6 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1233,7 +1233,7 @@ void mips_malta_init(MachineState *machine)
     pci_bus_map_irqs(pci_bus, malta_pci_slot_get_pirq);
 
     /* Southbridge */
-    piix4 = pci_new_multifunction(PIIX4_PCI_DEVFN, TYPE_PIIX4_PCI_DEVICE);
+    piix4 = pci_new_multifunction_orphan(PIIX4_PCI_DEVFN, TYPE_PIIX4_PCI_DEVICE);
     qdev_prop_set_uint32(DEVICE(piix4), "smb_io_base", 0x1100);
     pci_realize_and_unref(piix4, pci_bus, &error_fatal);
     isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix4), "isa.0"));
diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
index 04623dfd84..0556c0ccff 100644
--- a/hw/pci-host/articia.c
+++ b/hw/pci-host/articia.c
@@ -185,10 +185,10 @@ static void articia_realize(DeviceState *dev, Error **errp)
     h->bus = pci_register_root_bus(dev, NULL, articia_pcihost_set_irq,
                                    amigaone_pcihost_bus0_map_irq, dev, &s->mem,
                                    &s->io, PCI_DEVFN(8, 0), 4, TYPE_PCI_BUS);
-    pdev = pci_create_simple_multifunction(h->bus, PCI_DEVFN(0, 0),
+    pdev = pci_create_simple_multifunction_orphan(h->bus, PCI_DEVFN(0, 0),
                                            TYPE_ARTICIA_PCI_HOST);
     ARTICIA_PCI_HOST(pdev)->as = s;
-    pci_create_simple(h->bus, PCI_DEVFN(0, 1), TYPE_ARTICIA_PCI_BRIDGE);
+    pci_create_simple_orphan(h->bus, PCI_DEVFN(0, 1), TYPE_ARTICIA_PCI_BRIDGE);
 
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->reg);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mem);
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index cd7272c90c..40a62d62b6 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -747,7 +747,7 @@ PCIBus *bonito_init(qemu_irq *pic)
     pcihost->pic = pic;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    d = pci_new(PCI_DEVFN(0, 0), TYPE_PCI_BONITO);
+    d = pci_new_orphan(PCI_DEVFN(0, 0), TYPE_PCI_BONITO);
     s = PCI_BONITO(d);
     s->pcihost = pcihost;
     pcihost->pci_dev = s;
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index b0db7870b0..c76cb61dc9 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -60,7 +60,7 @@ static void grackle_realize(DeviceState *dev, Error **errp)
                                      &s->pci_io,
                                      0, 4, TYPE_PCI_BUS);
 
-    pci_create_simple(phb->bus, 0, "grackle");
+    pci_create_simple_orphan(phb->bus, 0, "grackle");
 }
 
 static void grackle_init(Object *obj)
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 566f928304..c1a94a3daa 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1204,7 +1204,7 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
                                 get_system_io(),
                                 PCI_DEVFN(18, 0), TYPE_PCI_BUS);
 
-    pci_create_simple(phb->bus, PCI_DEVFN(0, 0), "gt64120_pci");
+    pci_create_simple_orphan(phb->bus, PCI_DEVFN(0, 0), "gt64120_pci");
     memory_region_init_io(&phb->conf_mem, OBJECT(phb),
                           &pci_host_conf_le_ops,
                           s, "pci-conf-idx", 4);
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index c1982f7962..e91ddd5d07 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -282,7 +282,7 @@ static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
                          s->io_memory, 0, TYPE_PCI_BUS);
     phb->bus = b;
 
-    d = pci_create_simple(b, 0, s->pci_type);
+    d = pci_create_simple_orphan(b, 0, s->pci_type);
     f = I440FX_PCI_DEVICE(d);
 
     range_set_bounds(&s->pci_hole, s->below_4g_mem_size,
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index 495a82befd..f75951c873 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -94,7 +94,7 @@ static void mv64361_pcihost_realize(DeviceState *dev, Error **errp)
                                    pci_swizzle_map_irq_fn, dev,
                                    &s->mem, &s->io, 0, 4, TYPE_PCI_BUS);
     g_free(name);
-    pci_create_simple(h->bus, 0, TYPE_MV64361_PCI_BRIDGE);
+    pci_create_simple_orphan(h->bus, 0, TYPE_MV64361_PCI_BRIDGE);
     qdev_init_gpio_out(dev, s->irq, ARRAY_SIZE(s->irq));
 }
 
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 0b556d1bf5..fc0b226bef 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -167,7 +167,7 @@ static void pnv_phb_realize(DeviceState *dev, Error **errp)
     }
 
     if (defaults_enabled()) {
-        PCIDevice *root = pci_new(PCI_DEVFN(0, 0), TYPE_PNV_PHB_ROOT_PORT);
+        PCIDevice *root = pci_new_orphan(PCI_DEVFN(0, 0), TYPE_PNV_PHB_ROOT_PORT);
 
         pci_realize_and_unref(root, pci->bus, errp);
     }
diff --git a/hw/pci-host/ppc4xx_pci.c b/hw/pci-host/ppc4xx_pci.c
index b9a00f5193..cd7b16aa87 100644
--- a/hw/pci-host/ppc4xx_pci.c
+++ b/hw/pci-host/ppc4xx_pci.c
@@ -332,7 +332,7 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
                               TYPE_PCI_BUS);
     h->bus = b;
 
-    pci_create_simple(b, 0, TYPE_PPC4xx_HOST_BRIDGE);
+    pci_create_simple_orphan(b, 0, TYPE_PPC4xx_HOST_BRIDGE);
 
     /* XXX split into 2 memory regions, one for config space, one for regs */
     memory_region_init(&s->container, OBJECT(s), "pci-container", PCI_ALL_SIZE);
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 67180ba5f0..838a01608c 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -473,7 +473,7 @@ static void e500_pcihost_realize(DeviceState *dev, Error **errp)
     address_space_init(&s->bm_as, &s->bm, "pci-bm");
     pci_setup_iommu(b, &ppce500_iommu_ops, s);
 
-    pci_create_simple(b, 0, TYPE_PPC_E500_PCI_BRIDGE);
+    pci_create_simple_orphan(b, 0, TYPE_PPC_E500_PCI_BRIDGE);
 
     memory_region_init(&s->container, OBJECT(h), "pci-container", PCIE500_ALL_SIZE);
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_be_ops, h,
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index b3836dc9a2..abcf9b28e1 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -281,7 +281,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
                           "pci-intack", 1);
     memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
 
-    pci_create_simple(h->bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
+    pci_create_simple_orphan(h->bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
 
     address_space_init(&s->bm_as, &s->bm, "raven-bm");
     pci_setup_iommu(h->bus, &raven_iommu_ops, s);
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index cd2328ad53..d8c815d404 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -383,7 +383,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
                                      &s->pci_ioport,
                                      0, 0x40, TYPE_PCI_BUS);
 
-    pci_create_simple(phb->bus, 0, TYPE_SABRE_PCI_DEVICE);
+    pci_create_simple_orphan(phb->bus, 0, TYPE_SABRE_PCI_DEVICE);
 
     /* IOMMU */
     memory_region_add_subregion_overlap(&s->sabre_config, 0x200,
@@ -391,12 +391,12 @@ static void sabre_realize(DeviceState *dev, Error **errp)
     pci_setup_iommu(phb->bus, &sabre_iommu_ops, s->iommu);
 
     /* APB secondary busses */
-    pci_dev = pci_new_multifunction(PCI_DEVFN(1, 0), TYPE_SIMBA_PCI_BRIDGE);
+    pci_dev = pci_new_multifunction_orphan(PCI_DEVFN(1, 0), TYPE_SIMBA_PCI_BRIDGE);
     s->bridgeB = PCI_BRIDGE(pci_dev);
     pci_bridge_map_irq(s->bridgeB, "pciB", pci_simbaB_map_irq);
     pci_realize_and_unref(pci_dev, phb->bus, &error_fatal);
 
-    pci_dev = pci_new_multifunction(PCI_DEVFN(1, 1), TYPE_SIMBA_PCI_BRIDGE);
+    pci_dev = pci_new_multifunction_orphan(PCI_DEVFN(1, 1), TYPE_SIMBA_PCI_BRIDGE);
     s->bridgeA = PCI_BRIDGE(pci_dev);
     pci_bridge_map_irq(s->bridgeA, "pciA", pci_simbaA_map_irq);
     pci_realize_and_unref(pci_dev, phb->bus, &error_fatal);
diff --git a/hw/pci-host/sh_pci.c b/hw/pci-host/sh_pci.c
index 3ffd2cdbd7..749b9d76a1 100644
--- a/hw/pci-host/sh_pci.c
+++ b/hw/pci-host/sh_pci.c
@@ -142,7 +142,7 @@ static void sh_pcic_host_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->memconfig_a7);
     memory_region_add_subregion(get_system_memory(), 0xfe240000, &s->isa);
 
-    s->dev = pci_create_simple(phb->bus, PCI_DEVFN(0, 0), "sh_pci_host");
+    s->dev = pci_create_simple_orphan(phb->bus, PCI_DEVFN(0, 0), "sh_pci_host");
 }
 
 static void sh_pcic_pci_realize(PCIDevice *d, Error **errp)
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 10972de694..4590687bd3 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -126,7 +126,7 @@ static void pci_unin_main_realize(DeviceState *dev, Error **errp)
                                    &s->pci_io,
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
-    pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-pci");
+    pci_create_simple_orphan(h->bus, PCI_DEVFN(11, 0), "uni-north-pci");
 
     /*
      * DEC 21154 bridge was unused for many years, this comment is
@@ -176,7 +176,7 @@ static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
                                    &s->pci_io,
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
-    pci_create_simple(h->bus, PCI_DEVFN(11, 0), "u3-agp");
+    pci_create_simple_orphan(h->bus, PCI_DEVFN(11, 0), "u3-agp");
 }
 
 static void pci_u3_agp_init(Object *obj)
@@ -220,7 +220,7 @@ static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
                                    &s->pci_io,
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
-    pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
+    pci_create_simple_orphan(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
 }
 
 static void pci_unin_agp_init(Object *obj)
@@ -253,7 +253,7 @@ static void pci_unin_internal_realize(DeviceState *dev, Error **errp)
                                    &s->pci_io,
                                    PCI_DEVFN(14, 0), 4, TYPE_PCI_BUS);
 
-    pci_create_simple(h->bus, PCI_DEVFN(14, 0), "uni-north-internal-pci");
+    pci_create_simple_orphan(h->bus, PCI_DEVFN(14, 0), "uni-north-internal-pci");
 }
 
 static void pci_unin_internal_init(Object *obj)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d14fc6478e..61b9f2a230 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2118,7 +2118,7 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char *model,
         exit(1);
     }
 
-    pci_dev = pci_new(devfn, model);
+    pci_dev = pci_new_orphan(devfn, model);
     qdev_set_nic_properties(&pci_dev->qdev, nd);
     pci_realize_and_unref(pci_dev, bus, &error_fatal);
     return true;
@@ -2129,15 +2129,15 @@ PCIDevice *pci_vga_init(PCIBus *bus)
     vga_interface_created = true;
     switch (vga_interface_type) {
     case VGA_CIRRUS:
-        return pci_create_simple(bus, -1, "cirrus-vga");
+        return pci_create_simple_orphan(bus, -1, "cirrus-vga");
     case VGA_QXL:
-        return pci_create_simple(bus, -1, "qxl-vga");
+        return pci_create_simple_orphan(bus, -1, "qxl-vga");
     case VGA_STD:
-        return pci_create_simple(bus, -1, "VGA");
+        return pci_create_simple_orphan(bus, -1, "VGA");
     case VGA_VMWARE:
-        return pci_create_simple(bus, -1, "vmware-svga");
+        return pci_create_simple_orphan(bus, -1, "vmware-svga");
     case VGA_VIRTIO:
-        return pci_create_simple(bus, -1, "virtio-vga");
+        return pci_create_simple_orphan(bus, -1, "virtio-vga");
     case VGA_NONE:
     default: /* Other non-PCI types. Checking for unsupported types is already
                 done in vl.c. */
@@ -2399,12 +2399,53 @@ static PCIDevice *pci_new_internal(int devfn, bool multifunction,
     return PCI_DEVICE(dev);
 }
 
-PCIDevice *pci_new_multifunction(int devfn, const char *name)
+static PCIDevice *pci_new_child_internal(Object *parent, const char *id,
+                                          int devfn, bool multifunction,
+                                          const char *type)
+{
+    DeviceState *dev;
+
+    dev = qdev_new(parent, id, type);
+    qdev_prop_set_int32(dev, "addr", devfn);
+    qdev_prop_set_bit(dev, "multifunction", multifunction);
+    return PCI_DEVICE(dev);
+}
+
+PCIDevice *pci_new_multifunction(Object *parent, const char *id,
+                                 int devfn, const char *type)
+{
+    return pci_new_child_internal(parent, id, devfn, true, type);
+}
+
+PCIDevice *pci_new(Object *parent, const char *id,
+                   int devfn, const char *type)
+{
+    return pci_new_child_internal(parent, id, devfn, false, type);
+}
+
+PCIDevice *pci_create_simple_multifunction(Object *parent, const char *id,
+                                           PCIBus *bus, int devfn,
+                                           const char *type)
+{
+    PCIDevice *dev = pci_new_multifunction(parent, id, devfn, type);
+    qdev_realize(DEVICE(dev), BUS(bus), &error_fatal);
+    return dev;
+}
+
+PCIDevice *pci_create_simple(Object *parent, const char *id,
+                             PCIBus *bus, int devfn, const char *type)
+{
+    PCIDevice *dev = pci_new(parent, id, devfn, type);
+    qdev_realize(DEVICE(dev), BUS(bus), &error_fatal);
+    return dev;
+}
+
+PCIDevice *pci_new_multifunction_orphan(int devfn, const char *name)
 {
     return pci_new_internal(devfn, true, name);
 }
 
-PCIDevice *pci_new(int devfn, const char *name)
+PCIDevice *pci_new_orphan(int devfn, const char *name)
 {
     return pci_new_internal(devfn, false, name);
 }
@@ -2414,17 +2455,17 @@ bool pci_realize_and_unref(PCIDevice *dev, PCIBus *bus, Error **errp)
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
 }
 
-PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
+PCIDevice *pci_create_simple_multifunction_orphan(PCIBus *bus, int devfn,
                                            const char *name)
 {
-    PCIDevice *dev = pci_new_multifunction(devfn, name);
+    PCIDevice *dev = pci_new_multifunction_orphan(devfn, name);
     pci_realize_and_unref(dev, bus, &error_fatal);
     return dev;
 }
 
-PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name)
+PCIDevice *pci_create_simple_orphan(PCIBus *bus, int devfn, const char *name)
 {
-    PCIDevice *dev = pci_new(devfn, name);
+    PCIDevice *dev = pci_new_orphan(devfn, name);
     pci_realize_and_unref(dev, bus, &error_fatal);
     return dev;
 }
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index c41ac95bee..a69a41cdde 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -171,7 +171,7 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     dev->exp.sriov_pf.vf = g_new(PCIDevice *, total_vfs);
 
     for (uint16_t i = 0; i < total_vfs; i++) {
-        PCIDevice *vf = pci_new(devfn, vfname);
+        PCIDevice *vf = pci_new_orphan(devfn, vfname);
         vf->exp.sriov_vf.pf = dev;
         vf->exp.sriov_vf.vf_number = i;
 
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 528c2c656a..c6b331ff16 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -355,7 +355,7 @@ static void amigaone_init(MachineState *machine)
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
 
     /* VIA VT82c686B South Bridge (multifunction PCI device) */
-    via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(7, 0),
+    via = OBJECT(pci_create_simple_multifunction_orphan(pci_bus, PCI_DEVFN(7, 0),
                                                  TYPE_VT82C686B_ISA));
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(via, "rtc"),
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 31dda69127..0df953b9e1 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -348,7 +348,7 @@ static void ppc_core99_init(MachineState *machine)
     pci_bus = PCI_HOST_BRIDGE(uninorth_pci_dev)->bus;
 
     /* MacIO */
-    macio = OBJECT(pci_new(-1, TYPE_NEWWORLD_MACIO));
+    macio = OBJECT(pci_new_orphan(-1, TYPE_NEWWORLD_MACIO));
     dev = DEVICE(macio);
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
     qdev_prop_set_bit(dev, "has-pmu", has_pmu);
@@ -416,7 +416,7 @@ static void ppc_core99_init(MachineState *machine)
     }
 
     if (machine->usb) {
-        pci_create_simple(pci_bus, -1, "pci-ohci");
+        pci_create_simple_orphan(pci_bus, -1, "pci-ohci");
 
         /* U3 needs to use USB for input because Linux doesn't support via-cuda
         on PPC64 */
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index aa366ca190..e6c5830c38 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -229,7 +229,7 @@ static void ppc_heathrow_init(MachineState *machine)
     pci_bus = PCI_HOST_BRIDGE(grackle_dev)->bus;
 
     /* MacIO */
-    macio = OBJECT(pci_new(PCI_DEVFN(16, 0), TYPE_OLDWORLD_MACIO));
+    macio = OBJECT(pci_new_orphan(PCI_DEVFN(16, 0), TYPE_OLDWORLD_MACIO));
     qdev_prop_set_uint64(DEVICE(macio), "frequency", tbfreq);
 
     dev = DEVICE(object_resolve_path_component(macio, "escc"));
@@ -285,7 +285,7 @@ static void ppc_heathrow_init(MachineState *machine)
     qdev_realize_and_unref(dev, adb_bus, &error_fatal);
 
     if (machine_usb(machine)) {
-        pci_create_simple(pci_bus, -1, "pci-ohci");
+        pci_create_simple_orphan(pci_bus, -1, "pci-ohci");
     }
 
     if (!graphic_width) {
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 3dc02423ee..0030068ab3 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -241,7 +241,7 @@ static void pegasos_init(MachineState *machine)
 
     /* VIA VT8231 South Bridge (multifunction PCI device) */
     devfn = PCI_DEVFN(pm->type == PEGASOS1 ? 7 : 12, 0);
-    pm->sb = DEVICE(pci_new_multifunction(devfn, TYPE_VT8231_ISA));
+    pm->sb = DEVICE(pci_new_multifunction_orphan(devfn, TYPE_VT8231_ISA));
     via = OBJECT(pm->sb);
 
     /* Set properties on individual devices before realizing the south bridge */
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index f53ff9c582..a716d5da6a 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -300,7 +300,7 @@ static void ibm_40p_init(MachineState *machine)
     }
 
     /* PCI -> ISA bridge */
-    i82378_dev = DEVICE(pci_new(PCI_DEVFN(11, 0), "i82378"));
+    i82378_dev = DEVICE(pci_new_orphan(PCI_DEVFN(11, 0), "i82378"));
     qdev_realize_and_unref(i82378_dev, BUS(pci_bus), &error_fatal);
     qdev_connect_gpio_out(i82378_dev, 0,
                           qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
@@ -350,7 +350,7 @@ static void ibm_40p_init(MachineState *machine)
         qdev_prop_set_uint32(dev, "config", 12);
         isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
-        dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0), "lsi53c810"));
+        dev = DEVICE(pci_create_simple_orphan(pci_bus, PCI_DEVFN(1, 0), "lsi53c810"));
         lsi53c8xx_handle_legacy_cmdline(dev);
         qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in(i82378_dev, 13));
 
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 88c4e66b2d..0c4c6f6256 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -422,14 +422,14 @@ static void sam460ex_init(MachineState *machine)
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
 
     /* PCI devices */
-    pci_create_simple(pci_bus, PCI_DEVFN(6, 0), "sm501");
+    pci_create_simple_orphan(pci_bus, PCI_DEVFN(6, 0), "sm501");
     /*
      * SoC has a single SATA port but we don't emulate that
      * However, firmware and usual clients have driver for SiI311x
      * PCI SATA card so add one for convenience by default
      */
     if (defaults_enabled()) {
-        PCIIDEState *s = PCI_IDE(pci_create_simple(pci_bus, -1, "sii3112"));
+        PCIIDEState *s = PCI_IDE(pci_create_simple_orphan(pci_bus, -1, "sii3112"));
         DriveInfo *di;
 
         di = drive_get_by_index(IF_IDE, 0);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 30bf0cd0c0..4ead6ba664 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3075,7 +3075,7 @@ static void spapr_machine_init(MachineState *machine)
     }
 
     if (machine->usb) {
-        pci_create_simple(phb->bus, -1, "nec-usb-xhci");
+        pci_create_simple_orphan(phb->bus, -1, "nec-usb-xhci");
 
         if (has_vga) {
             USBBus *usb_bus;
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 0fbb44c5df..029cf23696 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -418,7 +418,7 @@ static void boston_mach_init(MachineState *machine)
     qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
                              boston_lcd_event, NULL, s, NULL, true);
 
-    pdev = pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
+    pdev = pci_create_simple_multifunction_orphan(&PCI_BRIDGE(&pcie2->root)->sec_bus,
                                            PCI_DEVFN(0, 0), TYPE_ICH9_AHCI);
     ich9 = ICH9_AHCI(pdev);
     g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index bd73d26e2c..5de873126c 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -599,7 +599,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     pci_bus_set_slot_reserved_mask(pci_busA, 0xfffffff1);
     pci_bus_set_slot_reserved_mask(pci_busB, 0xfffffff0);
 
-    ebus = pci_new_multifunction(PCI_DEVFN(1, 0), TYPE_EBUS);
+    ebus = pci_new_multifunction_orphan(PCI_DEVFN(1, 0), TYPE_EBUS);
     qdev_prop_set_uint64(DEVICE(ebus), "console-serial-base",
                          hwdef->console_serial_base);
     pci_realize_and_unref(ebus, pci_busA, &error_fatal);
@@ -618,7 +618,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
 
     switch (vga_interface_type) {
     case VGA_STD:
-        pci_create_simple(pci_busA, PCI_DEVFN(2, 0), "VGA");
+        pci_create_simple_orphan(pci_busA, PCI_DEVFN(2, 0), "VGA");
         vga_interface_created = true;
         break;
     case VGA_NONE:
@@ -632,7 +632,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
 
     nd = qemu_find_nic_info(mc->default_nic, true, NULL);
     if (nd) {
-        pci_dev = pci_new_multifunction(PCI_DEVFN(1, 1), mc->default_nic);
+        pci_dev = pci_new_multifunction_orphan(PCI_DEVFN(1, 1), mc->default_nic);
         dev = &pci_dev->qdev;
         qdev_set_nic_properties(dev, nd);
         pci_realize_and_unref(pci_dev, pci_busA, &error_fatal);
@@ -648,7 +648,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
         qemu_macaddr_default_if_unset(&macaddr);
     }
 
-    pci_dev = pci_new(PCI_DEVFN(3, 0), "cmd646-ide");
+    pci_dev = pci_new_orphan(PCI_DEVFN(3, 0), "cmd646-ide");
     qdev_prop_set_uint32(&pci_dev->qdev, "secondary", 1);
     pci_realize_and_unref(pci_dev, pci_busA, &error_fatal);
     pci_ide_create_devs(pci_dev);
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e091f21b6a..bea0d57a11 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -334,7 +334,7 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
     lpc_bridge = pci_find_device(pci_device_root_bus(pdev),
                                  0, PCI_DEVFN(0x1f, 0));
     if (!lpc_bridge) {
-        lpc_bridge = pci_create_simple(pci_device_root_bus(pdev),
+        lpc_bridge = pci_create_simple_orphan(pci_device_root_bus(pdev),
                                  PCI_DEVFN(0x1f, 0), "vfio-pci-igd-lpc-bridge");
     }
 
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 7df9344500..4457209e83 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -399,7 +399,7 @@ void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
     }
 
     /* Currently IGD drivers always need to access PCH by 1f.0. */
-    bridge_dev = pci_create_simple(bus, PCI_DEVFN(0x1f, 0),
+    bridge_dev = pci_create_simple_orphan(bus, PCI_DEVFN(0x1f, 0),
                                    "igd-passthrough-isa-bridge");
 
     /*
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f2448e941a..cbbb6a3756 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -1088,13 +1088,23 @@ pci_set_quad_by_mask(uint8_t *config, uint64_t mask, uint64_t reg)
     pci_set_quad(config, (~mask & val) | (mask & rval));
 }
 
-PCIDevice *pci_new_multifunction(int devfn, const char *name);
-PCIDevice *pci_new(int devfn, const char *name);
+PCIDevice *pci_new_multifunction(Object *parent, const char *id,
+                                 int devfn, const char *type);
+PCIDevice *pci_new(Object *parent, const char *id,
+                   int devfn, const char *type);
+PCIDevice *pci_create_simple_multifunction(Object *parent, const char *id,
+                                           PCIBus *bus, int devfn,
+                                           const char *type);
+PCIDevice *pci_create_simple(Object *parent, const char *id,
+                             PCIBus *bus, int devfn, const char *type);
+
+PCIDevice *pci_new_multifunction_orphan(int devfn, const char *name);
+PCIDevice *pci_new_orphan(int devfn, const char *name);
 bool pci_realize_and_unref(PCIDevice *dev, PCIBus *bus, Error **errp);
 
-PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
+PCIDevice *pci_create_simple_multifunction_orphan(PCIBus *bus, int devfn,
                                            const char *name);
-PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name);
+PCIDevice *pci_create_simple_orphan(PCIBus *bus, int devfn, const char *name);
 
 void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev);
 
diff --git a/scripts/coccinelle/qom-parent/pci-new-orphan.cocci b/scripts/coccinelle/qom-parent/pci-new-orphan.cocci
new file mode 100644
index 0000000000..e6cfd0d6c1
--- /dev/null
+++ b/scripts/coccinelle/qom-parent/pci-new-orphan.cocci
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Rename pci_new*/pci_create_simple*() to *_orphan() so that the
+// short names can be reintroduced with a mandatory (parent, id, ...)
+// signature.
+//
+// spatch --sp-file scripts/coccinelle/qom-parent/pci-new-orphan.cocci \
+//        --in-place --include-headers --dir .
+
+@@
+@@
+- pci_new_multifunction
++ pci_new_multifunction_orphan
+
+@@
+@@
+- pci_new
++ pci_new_orphan
+
+@@
+@@
+- pci_create_simple_multifunction
++ pci_create_simple_multifunction_orphan
+
+@@
+@@
+- pci_create_simple
++ pci_create_simple_orphan
-- 
2.47.1


