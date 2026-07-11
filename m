Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF906C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wign8-0005xd-Uo; Sat, 11 Jul 2026 19:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wign7-0005x3-Ox; Sat, 11 Jul 2026 19:07:25 -0400
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.35.192.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wign4-0003m4-V2; Sat, 11 Jul 2026 19:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811242; x=1815347242;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dunFlv0nuaRd8Cf/ycPQ27x2htRTbREOzws3IBoiZQA=;
 b=ro2KQ/t7pzEcvBEs6jt7NJHgeFXnhymGJh0bFhcUYHIMXrs87K2tTlRP
 gOM7mQFZFxNHMIrOkMh5hdc9wjaNqiaa3II3pswwl1ZxSFdmkf3eCGzZk
 VecPobJddHvZWr9W3Fw0okKTzAa/XNpVzst9UsgCVvGNMGxGFIZqEggDq
 UnUZ5dMcZsOeYCDKzV/qOIJPODqgeNgsa67Eqqo9/VB/91caIQ29g39Ia
 JGlWV3oFAhrPQMIVhX+gZw5kPe041jucKTsAgZ/ETZfAN5VDU4VbCfWXt
 10rM8BrVpD37cN8stTwdQjf2+NOMQZK6H8uaPZNonvSof5dE9ZV6gBDMR A==;
X-CSE-ConnectionGUID: Mwdg2ODHRA6GtbXbKXKQfA==
X-CSE-MsgGUID: uR5SPSZjTmWi0DTICob/2w==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23270013"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:07:19 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:7649]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525]
 with esmtp (Farcaster)
 id 5063ba0e-75cb-44b2-a492-ff819cdbefed; Sat, 11 Jul 2026 23:07:18 +0000 (UTC)
X-Farcaster-Flow-ID: 5063ba0e-75cb-44b2-a492-ff819cdbefed
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:07:18 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:07:09 +0000
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
Subject: [RFC PATCH 114/134] hw: Give allocated IRQs an owner and name
Date: Sat, 11 Jul 2026 22:36:47 +0000
Message-ID: <20260711223707.42139-115-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.35.192.45;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the remaining IRQ allocation calls across hw/ to the parented
form.  Owner is the enclosing device for realize()-time allocations
and the machine for board-init allocations.  Names describe the pin's
purpose; the auto-indexed [*] form is used where the same allocation
runs in a loop.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/alpha/typhoon.c          | 4 ++--
 hw/char/diva-gsp.c          | 3 ++-
 hw/display/macfb.c          | 2 +-
 hw/ide/ahci.c               | 2 +-
 hw/ide/pci.c                | 2 +-
 hw/intc/sh_intc.c           | 2 +-
 hw/isa/i82378.c             | 3 ++-
 hw/isa/lpc_ich9.c           | 2 +-
 hw/m68k/mcf5206.c           | 2 +-
 hw/m68k/q800.c              | 4 ++--
 hw/mips/mips_int.c          | 2 +-
 hw/net/can/can_kvaser_pci.c | 2 +-
 hw/pci-host/pnv_phb3.c      | 3 ++-
 hw/pci-host/pnv_phb3_msi.c  | 3 ++-
 hw/pci-host/pnv_phb4.c      | 3 ++-
 hw/ppc/e500.c               | 3 ++-
 hw/ppc/pnv_lpc.c            | 2 +-
 hw/ppc/pnv_psi.c            | 6 ++++--
 hw/ppc/spapr_irq.c          | 2 +-
 hw/riscv/sifive_u.c         | 3 ++-
 hw/scsi/esp-pci.c           | 2 +-
 hw/sh4/sh7750.c             | 2 +-
 hw/sparc/sun4m.c            | 5 +++--
 hw/sparc64/sun4u.c          | 3 ++-
 hw/xen/xen-pvh-common.c     | 5 +++--
 25 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 671e8f89d9..bc2073bfa9 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -849,8 +849,8 @@ PCIBus *typhoon_init(Object *parent, MemoryRegion *ram, qemu_irq *p_isa_irq,
         }
     }
 
-    *p_isa_irq = qemu_allocate_irq_orphan(typhoon_set_isa_irq, s, 0);
-    *p_rtc_irq = qemu_allocate_irq_orphan(typhoon_set_timer_irq, s, 0);
+    *p_isa_irq = qemu_allocate_irq(parent, "isa-irq", typhoon_set_isa_irq, s, 0);
+    *p_rtc_irq = qemu_allocate_irq(parent, "rtc-irq", typhoon_set_timer_irq, s, 0);
 
     /* Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
        but the address space hole reserved at this point is 8TB.  */
diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index bf1da1faee..b70811f24f 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -126,7 +126,8 @@ static void diva_pci_realize(PCIDevice *dev, Error **errp)
     pci->dev.config[PCI_INTERRUPT_PIN] = 1;
     memory_region_init(&pci->membar, OBJECT(pci), "serial_ports", 4096);
     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &pci->membar);
-    pci->irqs = qemu_allocate_irqs_orphan(multi_serial_irq_mux, pci, di.nports);
+    pci->irqs = qemu_allocate_irqs(OBJECT(dev), "serial-irq",
+                                   multi_serial_irq_mux, pci, di.nports);
 
     for (i = 0; i < di.nports; i++) {
         s = pci->state + i;
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index de5c83884e..b59523a0ac 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -737,7 +737,7 @@ static void macfb_nubus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&nd->slot_mem, DAFB_BASE, &ms->mem_ctrl);
     memory_region_add_subregion(&nd->slot_mem, VIDEO_BASE, &ms->mem_vram);
 
-    ms->irq = qemu_allocate_irq_orphan(macfb_nubus_set_irq, s, 0);
+    ms->irq = qemu_allocate_irq(OBJECT(dev), "nubus-irq", macfb_nubus_set_irq, s, 0);
 }
 
 static void macfb_nubus_unrealize(DeviceState *dev)
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index ac1cf26bab..b8f4e018b9 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1594,7 +1594,7 @@ void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as)
     assert(s->ports > 0);
     s->dev = g_new0(AHCIDevice, s->ports);
     ahci_reg_init(s);
-    irqs = qemu_allocate_irqs_orphan(ahci_irq_set, s, s->ports);
+    irqs = qemu_allocate_irqs(OBJECT(qdev), "port-irq", ahci_irq_set, s, s->ports);
     for (i = 0; i < s->ports; i++) {
         AHCIDevice *ad = &s->dev[i];
 
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index c808469008..56750b7b6f 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -606,7 +606,7 @@ void bmdma_init(IDEBus *bus, BMDMAState *bm, PCIIDEState *d)
     bm->dma.ops = &bmdma_ops;
     bus->dma = &bm->dma;
     bm->irq = bus->irq;
-    bus->irq = qemu_allocate_irq_orphan(bmdma_irq, bm, 0);
+    bus->irq = qemu_allocate_irq(OBJECT(d), "bmdma-irq[*]", bmdma_irq, bm, 0);
     bm->bus = bus;
     bm->pci_dev = d;
 }
diff --git a/hw/intc/sh_intc.c b/hw/intc/sh_intc.c
index 63f4eee2aa..4eaaeefeea 100644
--- a/hw/intc/sh_intc.c
+++ b/hw/intc/sh_intc.c
@@ -403,7 +403,7 @@ int sh_intc_init(Object *owner, MemoryRegion *sysmem,
     for (i = 0; i < nr_sources; i++) {
         desc->sources[i].parent = desc;
     }
-    desc->irqs = qemu_allocate_irqs_orphan(sh_intc_set_irq, desc, nr_sources);
+    desc->irqs = qemu_allocate_irqs(owner, "src-irq", sh_intc_set_irq, desc, nr_sources);
     memory_region_init_io(&desc->iomem, owner, &sh_intc_ops, desc, "intc",
                           0x100000000ULL);
     j = 0;
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 4f0be992e0..263a0c0dcf 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -95,7 +95,8 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
 
     /* 2 82C59 (irq) */
     s->isa_irqs_in = i8259_init(OBJECT(pci), isabus,
-                                qemu_allocate_irq_orphan(i82378_request_out0_irq,
+                                qemu_allocate_irq(OBJECT(dev), "out0-irq",
+                                                  i82378_request_out0_irq,
                                                   s, 0));
     isa_bus_register_input_irqs(isabus, s->isa_irqs_in);
 
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 7cb82519fb..7b44423372 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -429,7 +429,7 @@ static void ich9_lpc_pm_init(ICH9LPCState *lpc)
     qemu_irq sci_irq;
     FWCfgState *fw_cfg = fw_cfg_find();
 
-    sci_irq = qemu_allocate_irq_orphan(ich9_set_sci, lpc, 0);
+    sci_irq = qemu_allocate_irq(OBJECT(lpc), "sci-irq", ich9_set_sci, lpc, 0);
     ich9_pm_init(PCI_DEVICE(lpc), &lpc->pm, sci_irq);
 
     if (lpc->smi_host_features && fw_cfg) {
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index cbb361fae9..ec70d482eb 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -593,7 +593,7 @@ static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
                           "mbar", 0x00001000);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 
-    s->pic = qemu_allocate_irqs_orphan(m5206_mbar_set_irq, s, 14);
+    s->pic = qemu_allocate_irqs(OBJECT(dev), "pic-irq", m5206_mbar_set_irq, s, 14);
     m5206_timer_init(&s->timer[0], s->pic[9]);
     m5206_timer_init(&s->timer[1], s->pic[10]);
     s->uart[0] = mcf_uart_create(OBJECT(s), s->pic[12], serial_hd(0));
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 177fff0289..677dc4ad80 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -474,11 +474,11 @@ static void q800_machine_init(MachineState *machine)
     sysbus_realize(sysbus, &error_fatal);
     /* SCSI and SCSI data IRQs are negative edge triggered */
     sysbus_connect_irq(sysbus, 0,
-                       qemu_irq_invert_orphan(
+                       qemu_irq_invert(OBJECT(machine), "scsi-irq-inv",
                            qdev_get_gpio_in(DEVICE(&m->via2),
                                                    VIA2_IRQ_SCSI_BIT)));
     sysbus_connect_irq(sysbus, 1,
-                       qemu_irq_invert_orphan(
+                       qemu_irq_invert(OBJECT(machine), "scsi-drq-inv",
                            qdev_get_gpio_in(DEVICE(&m->via2),
                                                    VIA2_IRQ_SCSI_DATA_BIT)));
     memory_region_add_subregion(&m->macio, ESP_BASE - IO_BASE,
diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 814d07319f..c404063762 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -56,7 +56,7 @@ void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
     qemu_irq *qi;
     int i;
 
-    qi = qemu_allocate_irqs_orphan(cpu_mips_irq_request, cpu, 8);
+    qi = qemu_allocate_irqs(OBJECT(cpu), "cpu-irq", cpu_mips_irq_request, cpu, 8);
     for (i = 0; i < 8; i++) {
         env->irq[i] = qi[i];
     }
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 69fc66de14..95bae684d6 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -224,7 +224,7 @@ static void kvaser_pci_realize(PCIDevice *pci_dev, Error **errp)
     pci_conf = pci_dev->config;
     pci_conf[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
 
-    d->irq = qemu_allocate_irq_orphan(kvaser_pci_irq_handler, d, 0);
+    d->irq = qemu_allocate_irq(OBJECT(s), "kvaser-irq", kvaser_pci_irq_handler, d, 0);
 
     can_sja_init(s, d->irq);
 
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 63da48f5af..410a27a073 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -1054,7 +1054,8 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
         ics_set_irq_type(&phb->lsis, i, true);
     }
 
-    phb->qirqs = qemu_allocate_irqs_orphan(ics_set_irq, &phb->lsis, phb->lsis.nr_irqs);
+    phb->qirqs = qemu_allocate_irqs(OBJECT(dev), "lsi-irq",
+                                    ics_set_irq, &phb->lsis, phb->lsis.nr_irqs);
 
     /* MSI sources */
     object_property_set_link(OBJECT(&phb->msis), "phb", OBJECT(phb),
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index fa5f61ea2b..1bba60c616 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -267,7 +267,8 @@ static void phb3_msi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    msi->qirqs = qemu_allocate_irqs_orphan(phb3_msi_set_irq, msi, ics->nr_irqs);
+    msi->qirqs = qemu_allocate_irqs(OBJECT(dev), "msi-irq",
+                                    phb3_msi_set_irq, msi, ics->nr_irqs);
 }
 
 static void phb3_msi_instance_init(Object *obj)
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 7a1988a2b2..9b567413c7 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1605,7 +1605,8 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
 
     pnv_phb4_update_xsrc(phb);
 
-    phb->qirqs = qemu_allocate_irqs_orphan(xive_source_set_irq, xsrc, xsrc->nr_irqs);
+    phb->qirqs = qemu_allocate_irqs(OBJECT(dev), "lsi-irq",
+                                    xive_source_set_irq, xsrc, xsrc->nr_irqs);
 
     pnv_phb4_xscom_realize(phb);
 }
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 62692f5776..f3917c0755 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1089,7 +1089,8 @@ void ppce500_init(MachineState *machine)
                                     sysbus_mmio_get_region(s, 0));
 
         /* Power Off GPIO at Pin 0 */
-        poweroff_irq = qemu_allocate_irq_orphan(ppce500_power_off, NULL, 0);
+        poweroff_irq = qemu_allocate_irq(OBJECT(machine), "poweroff",
+                                         ppce500_power_off, NULL, 0);
         qdev_connect_gpio_out(dev, 0, poweroff_irq);
     }
 
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index e89defb321..a13d633f64 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -993,7 +993,7 @@ ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error **errp)
     }
 
     /* POWER has a 17th irq, QEMU only implements the 16 regular device irqs */
-    irqs = qemu_allocate_irqs_orphan(handler, lpc, ISA_NUM_IRQS);
+    irqs = qemu_allocate_irqs(OBJECT(lpc), "isa-irq", handler, lpc, ISA_NUM_IRQS);
 
     isa_bus_register_input_irqs(isa_bus, irqs);
 
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 1ff33596ac..1f2148a4d3 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -509,7 +509,8 @@ static void pnv_psi_power8_realize(DeviceState *dev, Error **errp)
 
     qdev_init_gpio_in(dev, pnv_psi_power8_set_irq, ics->nr_irqs);
 
-    psi->qirqs = qemu_allocate_irqs_orphan(ics_set_irq, ics, ics->nr_irqs);
+    psi->qirqs = qemu_allocate_irqs(OBJECT(dev), "psi-irq",
+                                    ics_set_irq, ics, ics->nr_irqs);
 
     /* XSCOM region for PSI registers */
     pnv_xscom_region_init(&psi->xscom_regs, OBJECT(dev), &pnv_psi_xscom_ops,
@@ -872,7 +873,8 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
         xive_source_irq_set_lsi(xsrc, i);
     }
 
-    psi->qirqs = qemu_allocate_irqs_orphan(xive_source_set_irq, xsrc, xsrc->nr_irqs);
+    psi->qirqs = qemu_allocate_irqs(OBJECT(dev), "psi-irq",
+                                    xive_source_set_irq, xsrc, xsrc->nr_irqs);
 
     qdev_init_gpio_in(dev, pnv_psi_power9_set_irq, xsrc->nr_irqs);
 
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index a05edb78bc..82869ea03a 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -339,7 +339,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         spapr_xive_hcall_init(spapr);
     }
 
-    spapr->qirqs = qemu_allocate_irqs_orphan(spapr_set_irq, spapr,
+    spapr->qirqs = qemu_allocate_irqs(OBJECT(spapr), "irq", spapr_set_irq, spapr,
                                       SPAPR_NR_XIRQS + SPAPR_IRQ_NR_IPIS);
 
     /*
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3df9fafb12..3f4a9b9b7b 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -484,7 +484,8 @@ static void sifive_u_machine_init(MachineState *machine)
 
     /* register gpio-restart */
     qdev_connect_gpio_out(DEVICE(&(s->soc.gpio)), 10,
-                          qemu_allocate_irq_orphan(sifive_u_machine_reset, NULL, 0));
+                          qemu_allocate_irq(OBJECT(machine), "reset-irq",
+                                            sifive_u_machine_reset, NULL, 0));
 
     /* load/create device tree */
     if (machine->dtb) {
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 4c02b23a28..bfc61b8f3b 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -407,7 +407,7 @@ static void esp_pci_scsi_realize(PCIDevice *dev, Error **errp)
                           "esp-io", 0x80);
 
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->io);
-    s->irq = qemu_allocate_irq_orphan(esp_irq_handler, pci, 0);
+    s->irq = qemu_allocate_irq(OBJECT(s), "esp-irq", esp_irq_handler, pci, 0);
 
     scsi_bus_init(&s->bus, sizeof(s->bus), d, &esp_pci_scsi_info);
 }
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 307daa523d..a42b753a1d 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -848,5 +848,5 @@ SH7750State *sh7750_init(Object *parent, SuperHCPU *cpu,
 qemu_irq sh7750_irl(SH7750State *s)
 {
     sh_intc_toggle_source(&s->intc.sources[IRL], 1, 0); /* enable */
-    return qemu_allocate_irq_orphan(sh_intc_set_irl, &s->intc.sources[IRL], 0);
+    return qemu_allocate_irq(OBJECT(s), "irl", sh_intc_set_irl, &s->intc.sources[IRL], 0);
 }
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 0a35b20e17..51f5468a02 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -1008,7 +1008,8 @@ static void sun4m_hw_init(MachineState *machine)
 
     if (hwdef->apc_base) {
         apc_init(OBJECT(machine), hwdef->apc_base,
-                 qemu_allocate_irq_orphan(cpu_halt_signal, NULL, 0));
+                 qemu_allocate_irq(OBJECT(machine), "cpu-halt",
+                                   cpu_halt_signal, NULL, 0));
     }
 
     if (hwdef->fd_base) {
@@ -1018,7 +1019,7 @@ static void sun4m_hw_init(MachineState *machine)
         sun4m_fdctrl_init(OBJECT(machine), slavio_irq[22], hwdef->fd_base, fd,
                           &fdc_tc);
     } else {
-        fdc_tc = qemu_allocate_irq_orphan(dummy_fdc_tc, NULL, 0);
+        fdc_tc = qemu_allocate_irq(OBJECT(machine), "fdc-tc", dummy_fdc_tc, NULL, 0);
     }
 
     slavio_misc_init(OBJECT(machine), hwdef->slavio_base, hwdef->aux1_base,
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 389436fd3d..7d84dc201f 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -311,7 +311,8 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     /* ISA bus */
-    s->isa_irqs_in = qemu_allocate_irqs_orphan(ebus_isa_irq_handler, s, ISA_NUM_IRQS);
+    s->isa_irqs_in = qemu_allocate_irqs(OBJECT(s), "isa-irq-in",
+                                        ebus_isa_irq_handler, s, ISA_NUM_IRQS);
     isa_bus_register_input_irqs(s->isa_bus, s->isa_irqs_in);
     qdev_init_gpio_out_named(DEVICE(s), s->isa_irqs_out, "isa-irq",
                              ISA_NUM_IRQS);
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 42514a599e..76893c8fcf 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -170,7 +170,7 @@ static void xen_create_virtio_mmio_devices(XenPVHMachineState *s)
      */
     for (i = s->cfg.virtio_mmio_num - 1; i >= 0; i--) {
         hwaddr base = s->cfg.virtio_mmio.base + i * s->cfg.virtio_mmio.size;
-        qemu_irq irq = qemu_allocate_irq_orphan(xen_set_irq, NULL,
+        qemu_irq irq = qemu_allocate_irq(OBJECT(s), "virtio-irq[*]", xen_set_irq, NULL,
                                          s->cfg.virtio_mmio_irq_base + i);
 
         sysbus_create_simple(OBJECT(s), "virtio-mmio[*]", "virtio-mmio",
@@ -260,7 +260,8 @@ static inline void xenpvh_gpex_init(XenPVHMachineState *s,
     assert(xpc->set_pci_intx_irq);
 
     for (i = 0; i < PCI_NUM_PINS; i++) {
-        qemu_irq irq = qemu_allocate_irq_orphan(xpc->set_pci_intx_irq, s, i);
+        qemu_irq irq = qemu_allocate_irq(OBJECT(s), "pci-intx-irq[*]",
+                                         xpc->set_pci_intx_irq, s, i);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
         gpex_set_irq_num(GPEX_HOST(dev), i, s->cfg.pci_intx_irq_base + i);
-- 
2.47.1


