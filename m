Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B04AC4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCxc-0006K2-4i; Sat, 18 Jul 2026 17:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCxa-0006DT-KT; Sat, 18 Jul 2026 17:52:38 -0400
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.162.73.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCxW-000407-Bh; Sat, 18 Jul 2026 17:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411554; x=1815947554;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VT5Xn5WbVnSZ7ByuXx0hTwhAi7XNb6UyTHSfSUFkxdc=;
 b=CuOa8nC5YyVHYnQ1llILcrhl1fA4sATjsmB0TYpXuuxTfAJZ3RRpMGxH
 Ks6/ffEezNLkb37o+/NBzJQ1oje6bX+TOG0GDkdDvnay5L8zFygJZhjtS
 /vCqQD2jOrr7toEBPiX2fxmotAieCdjJ6v3+pQhwkevTEX1JNYVjuwbtm
 064edRmZtDCJOZYwKTdgw+WZOiFpO1aCQYN4enZ4ZnRW+7Y5TeOGwIqjc
 R9TKcj4IplmJsB8f/PDctAKHNeeBZLTI3MAK1stPqWHq9Wqm1qU2k9OtZ
 mgprmTYgQpuwUl0ljiuSQCmp7ubBsCcieYXjAQI2IgZyqOiYewtO1CZBs w==;
X-CSE-ConnectionGUID: tUPGAHQ1RqmLPiCZ6CJCNA==
X-CSE-MsgGUID: xoVE2v16TGaE2nRbRgJLqg==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23715854"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:52:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:14792]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.230:2525]
 with esmtp (Farcaster)
 id bce34910-ea26-41eb-87b9-81931ed62287; Sat, 18 Jul 2026 21:52:30 +0000 (UTC)
X-Farcaster-Flow-ID: bce34910-ea26-41eb-87b9-81931ed62287
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:52:30 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:52:20 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, Francisco Iglesias <francisco.iglesias@amd.com>, "Gaurav
 Sharma" <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>, "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>, "Subbaraya
 Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth <th.huth+qemu@posteo.eu>, "Ran
 Wang" <wangran@bosc.ac.cn>, Hao Wu <wuhaotsh@google.com>
Subject: [RFC PATCH v2 056/137] hw/pci,
 hw/isa: Give VGA and slot-NIC helpers a QOM parent
Date: Sat, 18 Jul 2026 21:35:31 +0000
Message-ID: <20260718213652.37673-57-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.162.73.231;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
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

Now that all callers of pci_vga_init(), pci_init_nic_in_slot() and
isa_vga_init() live in already-converted board files, thread an
Object *parent through these three convenience helpers so that the
default VGA and default NIC created via -vga and -net become proper
children of their machine instead of landing under
/machine/unattached.

pc_vga_init() and the two static network_init() helpers in
hw/mips/{fuloong2e,malta}.c gain the parent argument as well and
pass it through.

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/alpha/dp264.c         |  2 +-
 hw/i386/isapc.c          |  2 +-
 hw/i386/pc.c             |  6 +++---
 hw/i386/pc_piix.c        |  2 +-
 hw/i386/pc_q35.c         |  2 +-
 hw/isa/isa-bus.c         |  6 +++---
 hw/mips/fuloong2e.c      |  6 +++---
 hw/mips/loongson3_virt.c |  2 +-
 hw/mips/malta.c          |  8 ++++----
 hw/pci/pci.c             | 18 +++++++++---------
 hw/ppc/amigaone.c        |  2 +-
 hw/ppc/mac_newworld.c    |  2 +-
 hw/ppc/mac_oldworld.c    |  2 +-
 hw/ppc/pegasos.c         |  2 +-
 hw/ppc/prep.c            |  4 ++--
 hw/ppc/spapr.c           |  6 +++---
 hw/riscv/boston-aia.c    |  3 ++-
 hw/sh4/r2d.c             |  2 +-
 include/hw/i386/pc.h     |  2 +-
 include/hw/isa/isa.h     |  2 +-
 include/hw/pci/pci.h     |  4 ++--
 21 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 40dee88f2d..d7d4fe3e8b 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -122,7 +122,7 @@ static void clipper_init(MachineState *machine)
     mc146818_rtc_init(mo, isa_bus, 1900, rtc_irq);
 
     /* VGA setup.  Don't bother loading the bios.  */
-    pci_vga_init(pci_bus);
+    pci_vga_init(OBJECT(machine), pci_bus);
 
     /* Network setup.  e1000 is good enough, failing Tulip support.  */
     pci_init_nic_devices(pci_bus, mc->default_nic);
diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index c5bba66967..842ae94acb 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -130,7 +130,7 @@ static void pc_init_isa(MachineState *machine)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, NULL);
+    pc_vga_init(OBJECT(machine), isa_bus, NULL);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1073888b42..0c89310ab7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -946,15 +946,15 @@ uint64_t pc_pci_hole64_start(void)
     return ROUND_UP(hole64_start, 1 * GiB);
 }
 
-DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
+DeviceState *pc_vga_init(Object *parent, ISABus *isa_bus, PCIBus *pci_bus)
 {
     DeviceState *dev = NULL;
 
     if (pci_bus) {
-        PCIDevice *pcidev = pci_vga_init(pci_bus);
+        PCIDevice *pcidev = pci_vga_init(parent, pci_bus);
         dev = pcidev ? &pcidev->qdev : NULL;
     } else if (isa_bus) {
-        ISADevice *isadev = isa_vga_init(isa_bus);
+        ISADevice *isadev = isa_vga_init(parent, isa_bus);
         dev = isadev ? DEVICE(isadev) : NULL;
     }
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8ae2108e73..c9e6c61734 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -290,7 +290,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcms->pcibus);
+    pc_vga_init(OBJECT(machine), isa_bus, pcms->pcibus);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 1a65811fae..62625abed8 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -325,7 +325,7 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* the rest devices to which pci devfn is automatically assigned */
-    pc_vga_init(isa_bus, pcms->pcibus);
+    pc_vga_init(OBJECT(machine), isa_bus, pcms->pcibus);
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
     if (machine->nvdimms_state->is_enabled) {
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index c15cf53469..fb20c43869 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -200,17 +200,17 @@ ISABus *isa_bus_from_device(ISADevice *dev)
     return ISA_BUS(qdev_get_parent_bus(DEVICE(dev)));
 }
 
-ISADevice *isa_vga_init(ISABus *bus)
+ISADevice *isa_vga_init(Object *parent, ISABus *bus)
 {
     vga_interface_created = true;
     switch (vga_interface_type) {
     case VGA_CIRRUS:
-        return isa_create_simple_orphan(bus, "isa-cirrus-vga");
+        return isa_create_simple(parent, "vga", bus, "isa-cirrus-vga");
     case VGA_QXL:
         error_report("%s: qxl: no PCI bus", __func__);
         return NULL;
     case VGA_STD:
-        return isa_create_simple_orphan(bus, "isa-vga");
+        return isa_create_simple(parent, "vga", bus, "isa-vga");
     case VGA_VMWARE:
         error_report("%s: vmware_vga: no PCI bus", __func__);
         return NULL;
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 88d2901829..477ad99c87 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -201,10 +201,10 @@ static void main_cpu_reset(void *opaque)
 }
 
 /* Network support */
-static void network_init(PCIBus *pci_bus)
+static void network_init(Object *parent, PCIBus *pci_bus)
 {
     /* The Fuloong board has a RTL8139 card using PCI SLOT 7 */
-    pci_init_nic_in_slot(pci_bus, "rtl8139", NULL, "07");
+    pci_init_nic_in_slot(parent, pci_bus, "rtl8139", NULL, "07");
     pci_init_nic_devices(pci_bus, "rtl8139");
 }
 
@@ -326,7 +326,7 @@ static void mips_fuloong2e_init(MachineState *machine)
     smbus_eeprom_init_one(OBJECT(machine), smbus, 0x50, spd_data);
 
     /* Network card: RTL8139D */
-    network_init(pci_bus);
+    network_init(OBJECT(machine), pci_bus);
 }
 
 static void mips_fuloong2e_machine_init(MachineClass *mc)
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 9ab1edceb2..99d2016ef1 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -460,7 +460,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
     }
     msi_nonbroken = true;
 
-    pci_vga_init(pci_bus);
+    pci_vga_init(OBJECT(machine), pci_bus);
 
     if (defaults_enabled() && object_class_by_name("pci-ohci")) {
         USBBus *usb_bus;
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index ebd1456657..e8c130d5bb 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -602,10 +602,10 @@ static MaltaFPGAState *malta_fpga_init(Object *parent, MemoryRegion *address_spa
 }
 
 /* Network support */
-static void network_init(PCIBus *pci_bus)
+static void network_init(Object *parent, PCIBus *pci_bus)
 {
     /* The malta board has a PCNet card using PCI SLOT 11 */
-    pci_init_nic_in_slot(pci_bus, "pcnet", NULL, "0b");
+    pci_init_nic_in_slot(parent, pci_bus, "pcnet", NULL, "0b");
     pci_init_nic_devices(pci_bus, "pcnet");
 }
 
@@ -1259,10 +1259,10 @@ void mips_malta_init(MachineState *machine)
                       TYPE_FDC37M81X_SUPERIO);
 
     /* Network card */
-    network_init(pci_bus);
+    network_init(OBJECT(machine), pci_bus);
 
     /* Optional PCI video card */
-    pci_vga_init(pci_bus);
+    pci_vga_init(OBJECT(machine), pci_bus);
 }
 
 static void mips_malta_instance_init(Object *obj)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 61b9f2a230..ca5882ba59 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2083,7 +2083,7 @@ void pci_init_nic_devices(PCIBus *bus, const char *default_model)
                                 "virtio", "virtio-net-pci");
 }
 
-bool pci_init_nic_in_slot(PCIBus *rootbus, const char *model,
+bool pci_init_nic_in_slot(Object *parent, PCIBus *rootbus, const char *model,
                           const char *alias, const char *devaddr)
 {
     NICInfo *nd = qemu_find_nic_info(model, true, alias);
@@ -2118,26 +2118,26 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char *model,
         exit(1);
     }
 
-    pci_dev = pci_new_orphan(devfn, model);
+    pci_dev = pci_new(parent, "nic[*]", devfn, model);
     qdev_set_nic_properties(&pci_dev->qdev, nd);
-    pci_realize_and_unref(pci_dev, bus, &error_fatal);
+    qdev_realize(DEVICE(pci_dev), BUS(bus), &error_fatal);
     return true;
 }
 
-PCIDevice *pci_vga_init(PCIBus *bus)
+PCIDevice *pci_vga_init(Object *parent, PCIBus *bus)
 {
     vga_interface_created = true;
     switch (vga_interface_type) {
     case VGA_CIRRUS:
-        return pci_create_simple_orphan(bus, -1, "cirrus-vga");
+        return pci_create_simple(parent, "vga", bus, -1, "cirrus-vga");
     case VGA_QXL:
-        return pci_create_simple_orphan(bus, -1, "qxl-vga");
+        return pci_create_simple(parent, "vga", bus, -1, "qxl-vga");
     case VGA_STD:
-        return pci_create_simple_orphan(bus, -1, "VGA");
+        return pci_create_simple(parent, "vga", bus, -1, "VGA");
     case VGA_VMWARE:
-        return pci_create_simple_orphan(bus, -1, "vmware-svga");
+        return pci_create_simple(parent, "vga", bus, -1, "vmware-svga");
     case VGA_VIRTIO:
-        return pci_create_simple_orphan(bus, -1, "virtio-vga");
+        return pci_create_simple(parent, "vga", bus, -1, "virtio-vga");
     case VGA_NONE:
     default: /* Other non-PCI types. Checking for unsupported types is already
                 done in vl.c. */
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index faf76f12be..60aed15a6e 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -370,7 +370,7 @@ static void amigaone_init(MachineState *machine)
                                                              "pirq", i));
     }
     pci_ide_create_devs(PCI_DEVICE(object_resolve_path_component(via, "ide")));
-    pci_vga_init(pci_bus);
+    pci_vga_init(OBJECT(machine), pci_bus);
 
     if (!machine->kernel_filename) {
         return;
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index e9ee44a2f1..a6af53e21a 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -435,7 +435,7 @@ static void ppc_core99_init(MachineState *machine)
         }
     }
 
-    pci_vga_init(pci_bus);
+    pci_vga_init(OBJECT(machine), pci_bus);
 
     if (!graphic_width) {
         graphic_width = 800;
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 6ef8207f96..f9b62a518a 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -267,7 +267,7 @@ static void ppc_heathrow_init(MachineState *machine)
         }
     }
 
-    pci_vga_init(pci_bus);
+    pci_vga_init(OBJECT(machine), pci_bus);
 
     pci_init_nic_devices(pci_bus, mc->default_nic);
 
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 6ce1e3f174..4917d8137a 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -267,7 +267,7 @@ static void pegasos_init(MachineState *machine)
     smbus_eeprom_init_one(OBJECT(machine), i2c_bus, 0x57, spd_data);
 
     /* other PC hardware */
-    pci_vga_init(pci_bus);
+    pci_vga_init(OBJECT(machine), pci_bus);
 
     /* pci interrupt routing */
     switch (pm->type) {
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index ff85a4e64b..52f94b206a 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -357,10 +357,10 @@ static void ibm_40p_init(MachineState *machine)
         qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in(i82378_dev, 13));
 
         /* XXX: s3-trio at PCI_DEVFN(2, 0) */
-        pci_vga_init(pci_bus);
+        pci_vga_init(OBJECT(machine), pci_bus);
 
         /* First PCNET device at PCI_DEVFN(3, 0) */
-        pci_init_nic_in_slot(pci_bus, mc->default_nic, NULL, "3");
+        pci_init_nic_in_slot(OBJECT(machine), pci_bus, mc->default_nic, NULL, "3");
         pci_init_nic_devices(pci_bus, mc->default_nic);
     }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fbf6c59516..9b6b5e7257 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1909,7 +1909,7 @@ static void spapr_rtc_create(SpaprMachineState *spapr)
 }
 
 /* Returns whether we want to use VGA or not */
-static bool spapr_vga_init(PCIBus *pci_bus, Error **errp)
+static bool spapr_vga_init(Object *parent, PCIBus *pci_bus, Error **errp)
 {
     vga_interface_created = true;
     switch (vga_interface_type) {
@@ -1920,7 +1920,7 @@ static bool spapr_vga_init(PCIBus *pci_bus, Error **errp)
     case VGA_STD:
     case VGA_VIRTIO:
     case VGA_CIRRUS:
-        return pci_vga_init(pci_bus) != NULL;
+        return pci_vga_init(parent, pci_bus) != NULL;
     default:
         error_setg(errp,
                    "Unsupported VGA mode, only -vga std or -vga virtio is supported");
@@ -3066,7 +3066,7 @@ static void spapr_machine_init(MachineState *machine)
     }
 
     /* Graphics */
-    has_vga = spapr_vga_init(phb->bus, &error_fatal);
+    has_vga = spapr_vga_init(OBJECT(machine), phb->bus, &error_fatal);
     if (has_vga) {
         spapr->want_stdout_path = !machine->enable_graphics;
         machine->usb |= defaults_enabled() && !machine->usb_disabled;
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 3b0eba00a7..5a9ec28068 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -428,7 +428,8 @@ static void boston_mach_init(MachineState *machine)
     ahci_ide_create_devs(&ich9->ahci, hd);
 
     /* Create e1000e using slot 0 func 1 */
-    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", NULL,
+    pci_init_nic_in_slot(OBJECT(machine), &PCI_BRIDGE(&pcie2->root)->sec_bus,
+                         "e1000e", NULL,
                          "00.1");
     pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
 
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index c03df91aca..6154aed2c4 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -315,7 +315,7 @@ static void r2d_init(MachineState *machine)
                           0x555, 0x2aa, 0);
 
     /* NIC: rtl8139 on-board, and 2 slots. */
-    pci_init_nic_in_slot(pci_bus, mc->default_nic, NULL, "2");
+    pci_init_nic_in_slot(OBJECT(machine), pci_bus, mc->default_nic, NULL, "2");
     pci_init_nic_devices(pci_bus, mc->default_nic);
 
     /* USB keyboard */
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index dbaf61bcf1..a059409243 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -183,7 +183,7 @@ void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *rom_memory,
                     uint64_t pci_hole64_size);
 uint64_t pc_pci_hole64_start(void);
-DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
+DeviceState *pc_vga_init(Object *parent, ISABus *isa_bus, PCIBus *pci_bus);
 void pc_basic_device_init(struct PCMachineState *pcms,
                           ISABus *isa_bus, qemu_irq *gsi,
                           ISADevice *rtc_state,
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index af8e07c253..9e35d88b1e 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -89,7 +89,7 @@ ISADevice *isa_try_new_orphan(const char *name);
 bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp);
 ISADevice *isa_create_simple_orphan(ISABus *bus, const char *name);
 
-ISADevice *isa_vga_init(ISABus *bus);
+ISADevice *isa_vga_init(Object *parent, ISABus *bus);
 
 qemu_irq isa_get_irq(ISADevice *dev, unsigned isairq);
 void isa_connect_gpio_out(ISADevice *isadev, int gpioirq, unsigned isairq);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index cbbb6a3756..9c6bcc0b96 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -337,9 +337,9 @@ void pci_device_set_intx_routing_notifier(PCIDevice *dev,
 void pci_device_reset(PCIDevice *dev);
 
 void pci_init_nic_devices(PCIBus *bus, const char *default_model);
-bool pci_init_nic_in_slot(PCIBus *rootbus, const char *default_model,
+bool pci_init_nic_in_slot(Object *parent, PCIBus *rootbus, const char *default_model,
                           const char *alias, const char *devaddr);
-PCIDevice *pci_vga_init(PCIBus *bus);
+PCIDevice *pci_vga_init(Object *parent, PCIBus *bus);
 
 static inline PCIBus *pci_get_bus(const PCIDevice *dev)
 {
-- 
2.47.1


