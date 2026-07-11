Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3197BC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigLg-0008PD-Mf; Sat, 11 Jul 2026 18:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigLd-0008Gh-Rj; Sat, 11 Jul 2026 18:39:01 -0400
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.1.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigLa-0005EG-P7; Sat, 11 Jul 2026 18:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809538; x=1815345538;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mT9pdS15/yojcMcnDmIrgAsw2IDIKNd1K4JQW5VZ5DM=;
 b=OJHVranEIS8fO0Ist/nl+wIQLPyZ61VPZIVpoEqgoT/eh/pyg3vEZdjZ
 Eg0skMYLGo7NdVvgynPvJg/NQzuKlPTYQS9HzFzuAzXNV1akII/IFt8pS
 4qm3LZWMjtndcZn7W3lSJw/a73qI06w3m9t7wnM1IiuUbVxJIq/87utjJ
 Ya+1Ah6JGg3gc9ezlXER3UNSBbdIn0NMTOSBU+4s0Wvg3Le7F3nlgq0+f
 pjXXV4xQKBO0gFnQh/6AP3P0JpqHNs4eUYTMbACqW4bXlpirakM8JwubK
 p7nUN21QApj2/TvZNyg3ezZvUSAhhOJJ6m0me+T/kKXO6MWNxuZn4urky Q==;
X-CSE-ConnectionGUID: uFmroFc4QGaGvXAgUZkntQ==
X-CSE-MsgGUID: QFU8anWqQ5C+bI0/WizidQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23505449"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:38:54 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:28293]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.33:2525]
 with esmtp (Farcaster)
 id 1fbc9e5b-559a-484e-bcd9-4852ba091b82; Sat, 11 Jul 2026 22:38:54 +0000 (UTC)
X-Farcaster-Flow-ID: 1fbc9e5b-559a-484e-bcd9-4852ba091b82
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:38:53 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:38:44 +0000
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
Subject: [RFC PATCH 006/134] isa: Make
 isa_new()/isa_try_new()/isa_create_simple() take a QOM parent
Date: Sat, 11 Jul 2026 22:34:59 +0000
Message-ID: <20260711223707.42139-7-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.1.125;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Same rename-and-reintroduce treatment as the qdev, sysbus and PCI
layers: mechanically rename the three ISA creation helpers to
*_orphan() and reintroduce the short names with a leading
(parent, id, ...) pair.

The parented isa_create_simple() calls qdev_realize() (not
isa_realize_and_unref()) since the child<> property already holds
the sole reference.

The mechanical rename part is generated by

  spatch --sp-file scripts/coccinelle/qom-parent/isa-new-orphan.cocci \
         --in-place --include-headers --dir .

or equivalently

  git ls-files '*.[ch]' '*.[ch].inc' '*.rst' '*.py' | \
      grep -v '^subprojects/' | \
      xargs sed -i \
          's/\bisa_create_simple\b/&_orphan/g;
           s/\bisa_try_new\b/&_orphan/g;
           s/\bisa_new\b/&_orphan/g'

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/alpha/dp264.c                              |  2 +-
 hw/char/parallel-isa.c                        |  2 +-
 hw/char/serial-isa.c                          |  2 +-
 hw/dma/i8257.c                                |  4 +--
 hw/i386/isapc.c                               |  2 +-
 hw/i386/pc.c                                  | 12 ++++----
 hw/ide/isa.c                                  |  2 +-
 hw/intc/i8259_common.c                        |  2 +-
 hw/isa/i82378.c                               |  4 +--
 hw/isa/isa-bus.c                              | 30 +++++++++++++++----
 hw/isa/isa-superio.c                          | 10 +++----
 hw/mips/jazz.c                                |  2 +-
 hw/mips/malta.c                               |  2 +-
 hw/ppc/pnv.c                                  |  2 +-
 hw/ppc/prep.c                                 | 12 ++++----
 hw/rtc/mc146818rtc.c                          |  2 +-
 hw/sparc64/sun4u.c                            |  4 +--
 include/hw/i386/vmport.h                      |  2 +-
 include/hw/isa/isa.h                          | 10 +++++--
 include/hw/net/ne2000-isa.h                   |  2 +-
 include/hw/timer/i8254.h                      |  4 +--
 .../qom-parent/isa-new-orphan.cocci           | 23 ++++++++++++++
 22 files changed, 91 insertions(+), 46 deletions(-)
 create mode 100644 scripts/coccinelle/qom-parent/isa-new-orphan.cocci

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 6999168df6..b07dcebaa0 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -126,7 +126,7 @@ static void clipper_init(MachineState *machine)
     pci_init_nic_devices(pci_bus, mc->default_nic);
 
     /* Super I/O */
-    isa_create_simple(isa_bus, TYPE_SMC37C669_SUPERIO);
+    isa_create_simple_orphan(isa_bus, TYPE_SMC37C669_SUPERIO);
 
     /* IDE disk setup.  */
     pci_dev = pci_create_simple_orphan(pci_bus, -1, "cmd646-ide");
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
index 92e94138f4..19583c0f23 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-isa.c
@@ -22,7 +22,7 @@ static void parallel_init(ISABus *bus, int index, Chardev *chr)
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_new(TYPE_ISA_PARALLEL);
+    isadev = isa_new_orphan(TYPE_ISA_PARALLEL);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "index", index);
     qdev_prop_set_chr(dev, "chardev", chr);
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index eaa4e843c0..4dbdc0df91 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -165,7 +165,7 @@ static void serial_isa_init(ISABus *bus, int index, Chardev *chr)
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_new(TYPE_ISA_SERIAL);
+    isadev = isa_new_orphan(TYPE_ISA_SERIAL);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "index", index);
     qdev_prop_set_chr(dev, "chardev", chr);
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 5771549889..d1ab17b80d 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -651,7 +651,7 @@ void i8257_dma_init(Object *parent, ISABus *bus, bool high_page_enable)
     ISADevice *isa1, *isa2;
     DeviceState *d;
 
-    isa1 = isa_new(TYPE_I8257);
+    isa1 = isa_new_orphan(TYPE_I8257);
     object_property_add_child(parent, "dma[*]", OBJECT(isa1));
     d = DEVICE(isa1);
     qdev_prop_set_int32(d, "base", 0x00);
@@ -660,7 +660,7 @@ void i8257_dma_init(Object *parent, ISABus *bus, bool high_page_enable)
     qdev_prop_set_int32(d, "dshift", 0);
     isa_realize_and_unref(isa1, bus, &error_fatal);
 
-    isa2 = isa_new(TYPE_I8257);
+    isa2 = isa_new_orphan(TYPE_I8257);
     object_property_add_child(parent, "dma[*]", OBJECT(isa2));
     d = DEVICE(isa2);
     qdev_prop_set_int32(d, "base", 0xc0);
diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 1ba9ae22cc..03d68f748f 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -112,7 +112,7 @@ static void pc_init_isa(MachineState *machine)
                           &error_abort);
     isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
-    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    x86ms->rtc = isa_new_orphan(TYPE_MC146818_RTC);
     qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
     isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
     irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 11a9d5df97..905b4960a3 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -998,7 +998,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
     }
     if (create_fdctrl) {
 #ifdef CONFIG_FDC_ISA
-        ISADevice *fdc = isa_new(TYPE_ISA_FDC);
+        ISADevice *fdc = isa_new_orphan(TYPE_ISA_FDC);
         if (fdc) {
             isa_realize_and_unref(fdc, isa_bus, &error_fatal);
             isa_fdc_init_drives(fdc, fd);
@@ -1014,10 +1014,10 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
         return;
     }
 
-    i8042 = isa_create_simple(isa_bus, TYPE_I8042);
+    i8042 = isa_create_simple_orphan(isa_bus, TYPE_I8042);
     if (!no_vmport) {
-        isa_create_simple(isa_bus, TYPE_VMPORT);
-        vmmouse = isa_try_new("vmmouse");
+        isa_create_simple_orphan(isa_bus, TYPE_VMPORT);
+        vmmouse = isa_try_new_orphan("vmmouse");
     } else {
         vmmouse = NULL;
     }
@@ -1026,7 +1026,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
                                  &error_abort);
         isa_realize_and_unref(vmmouse, isa_bus, &error_fatal);
     }
-    port92 = isa_create_simple(isa_bus, TYPE_PORT92);
+    port92 = isa_create_simple_orphan(isa_bus, TYPE_PORT92);
 
     a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
     qdev_connect_gpio_out_named(DEVICE(i8042),
@@ -1639,7 +1639,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->default_bus_bypass_iommu = false;
 
     pc_system_flash_create(pcms);
-    pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
+    pcms->pcspk = isa_new_orphan(TYPE_PC_SPEAKER);
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
     if (pcmc->pci_enabled) {
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index c97b7a1ff4..c9c997344b 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -84,7 +84,7 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int irqnum,
     ISADevice *isadev;
     ISAIDEState *s;
 
-    isadev = isa_new(TYPE_ISA_IDE);
+    isadev = isa_new_orphan(TYPE_ISA_IDE);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "iobase",  iobase);
     qdev_prop_set_uint32(dev, "iobase2", iobase2);
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 8ceb5841b9..45eb0e14a8 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -94,7 +94,7 @@ ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_new(name);
+    isadev = isa_new_orphan(name);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "iobase", master ? 0x20 : 0xa0);
     qdev_prop_set_uint32(dev, "elcr_addr", master ? 0x4d0 : 0x4d1);
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index dfa8a3775c..63d4050db2 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -103,14 +103,14 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     pit = i8254_pit_init(isabus, 0x40, 0, NULL);
 
     /* speaker */
-    pcspk = isa_new(TYPE_PC_SPEAKER);
+    pcspk = isa_new_orphan(TYPE_PC_SPEAKER);
     object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_fatal);
     if (!isa_realize_and_unref(pcspk, isabus, errp)) {
         return;
     }
 
     /* 2 82C37 (dma) */
-    isa_create_simple(isabus, "i82374");
+    isa_create_simple_orphan(isabus, "i82374");
 }
 
 static void i82378_init(Object *obj)
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 5e6340f635..c15cf53469 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -153,21 +153,39 @@ int isa_register_portio_list(ISADevice *dev,
     return 0;
 }
 
-ISADevice *isa_new(const char *name)
+ISADevice *isa_new(Object *parent, const char *id, const char *type)
+{
+    return ISA_DEVICE(qdev_new(parent, id, type));
+}
+
+ISADevice *isa_try_new(Object *parent, const char *id, const char *type)
+{
+    return ISA_DEVICE(qdev_try_new(parent, id, type));
+}
+
+ISADevice *isa_create_simple(Object *parent, const char *id,
+                             ISABus *bus, const char *type)
+{
+    ISADevice *dev = isa_new(parent, id, type);
+    qdev_realize(DEVICE(dev), BUS(bus), &error_fatal);
+    return dev;
+}
+
+ISADevice *isa_new_orphan(const char *name)
 {
     return ISA_DEVICE(qdev_new_orphan(name));
 }
 
-ISADevice *isa_try_new(const char *name)
+ISADevice *isa_try_new_orphan(const char *name)
 {
     return ISA_DEVICE(qdev_try_new_orphan(name));
 }
 
-ISADevice *isa_create_simple(ISABus *bus, const char *name)
+ISADevice *isa_create_simple_orphan(ISABus *bus, const char *name)
 {
     ISADevice *dev;
 
-    dev = isa_new(name);
+    dev = isa_new_orphan(name);
     isa_realize_and_unref(dev, bus, &error_fatal);
     return dev;
 }
@@ -187,12 +205,12 @@ ISADevice *isa_vga_init(ISABus *bus)
     vga_interface_created = true;
     switch (vga_interface_type) {
     case VGA_CIRRUS:
-        return isa_create_simple(bus, "isa-cirrus-vga");
+        return isa_create_simple_orphan(bus, "isa-cirrus-vga");
     case VGA_QXL:
         error_report("%s: qxl: no PCI bus", __func__);
         return NULL;
     case VGA_STD:
-        return isa_create_simple(bus, "isa-vga");
+        return isa_create_simple_orphan(bus, "isa-vga");
     case VGA_VMWARE:
         error_report("%s: vmware_vga: no PCI bus", __func__);
         return NULL;
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index dc6ae3cb10..2d65255f34 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -54,7 +54,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             } else {
                 name = g_strdup_printf("parallel%d", i);
             }
-            isa = isa_new(TYPE_ISA_PARALLEL);
+            isa = isa_new_orphan(TYPE_ISA_PARALLEL);
             d = DEVICE(isa);
             qdev_prop_set_uint32(d, "index", i);
             if (k->parallel.get_iobase) {
@@ -93,7 +93,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             } else {
                 name = g_strdup_printf("serial%d", i);
             }
-            isa = isa_new(TYPE_ISA_SERIAL);
+            isa = isa_new_orphan(TYPE_ISA_SERIAL);
             d = DEVICE(isa);
             qdev_prop_set_uint32(d, "index", i);
             if (k->serial.get_iobase) {
@@ -120,7 +120,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
     assert(k->floppy.count <= 1);
     if (k->floppy.count &&
         (!k->floppy.is_enabled || k->floppy.is_enabled(sio, 0))) {
-        isa = isa_new(TYPE_ISA_FDC);
+        isa = isa_new_orphan(TYPE_ISA_FDC);
         d = DEVICE(isa);
         if (k->floppy.get_iobase) {
             qdev_prop_set_uint32(d, "iobase", k->floppy.get_iobase(sio, 0));
@@ -144,14 +144,14 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
     }
 
     /* Keyboard, mouse */
-    isa = isa_new(TYPE_I8042);
+    isa = isa_new_orphan(TYPE_I8042);
     object_property_add_child(OBJECT(sio), TYPE_I8042, OBJECT(isa));
     isa_realize_and_unref(isa, bus, &error_fatal);
     sio->kbc = isa;
 
     /* IDE */
     if (k->ide.count && (!k->ide.is_enabled || k->ide.is_enabled(sio, 0))) {
-        isa = isa_new("isa-ide");
+        isa = isa_new_orphan("isa-ide");
         d = DEVICE(isa);
         if (k->ide.get_iobase) {
             qdev_prop_set_uint32(d, "iobase", k->ide.get_iobase(sio, 0));
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index a902e400cf..849c97eb10 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -289,7 +289,7 @@ static void mips_jazz_init(MachineState *machine,
     isa_bus_register_input_irqs(isa_bus, i8259);
     i8257_dma_init(OBJECT(rc4030), isa_bus, 0);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    pcspk = isa_new(TYPE_PC_SPEAKER);
+    pcspk = isa_new_orphan(TYPE_PC_SPEAKER);
     object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_fatal);
     isa_realize_and_unref(pcspk, isa_bus, &error_fatal);
 
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 38edbbadd6..da6dd15a59 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1253,7 +1253,7 @@ void mips_malta_init(MachineState *machine)
     g_free(smbus_eeprom_buf);
 
     /* Super I/O: SMS FDC37M817 */
-    isa_create_simple(isa_bus, TYPE_FDC37M81X_SUPERIO);
+    isa_create_simple_orphan(isa_bus, TYPE_FDC37M81X_SUPERIO);
 
     /* Network card */
     network_init(pci_bus);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b85b6dd46c..8346613a68 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1010,7 +1010,7 @@ static bool pnv_match_cpu(const char *default_type, const char *cpu_type)
 
 static void pnv_ipmi_bt_init(ISABus *bus, IPMIBmc *bmc, uint32_t irq)
 {
-    ISADevice *dev = isa_new("isa-ipmi-bt");
+    ISADevice *dev = isa_new_orphan("isa-ipmi-bt");
 
     object_property_set_link(OBJECT(dev), "bmc", OBJECT(bmc), &error_fatal);
     object_property_set_int(OBJECT(dev), "irq", irq, &error_fatal);
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index a716d5da6a..32a28bc12a 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -309,20 +309,20 @@ static void ibm_40p_init(MachineState *machine)
     isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
 
     /* system control ports */
-    isa_dev = isa_new("prep-systemio");
+    isa_dev = isa_new_orphan("prep-systemio");
     dev = DEVICE(isa_dev);
     qdev_prop_set_uint32(dev, "ibm-planar-id", 0xfc);
     qdev_prop_set_uint32(dev, "equipment", 0xc0);
     isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
     /* Memory controller */
-    isa_dev = isa_new("rs6000-mc");
+    isa_dev = isa_new_orphan("rs6000-mc");
     dev = DEVICE(isa_dev);
     qdev_prop_set_uint32(dev, "ram-size", machine->ram_size);
     isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
     /* RTC */
-    isa_dev = isa_new(TYPE_MC146818_RTC);
+    isa_dev = isa_new_orphan(TYPE_MC146818_RTC);
     dev = DEVICE(isa_dev);
     qdev_prop_set_int32(dev, "base_year", 1900);
     isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
@@ -334,9 +334,9 @@ static void ibm_40p_init(MachineState *machine)
 
     /* add some more devices */
     if (defaults_enabled()) {
-        m48t59 = NVRAM(isa_create_simple(isa_bus, "isa-m48t59"));
+        m48t59 = NVRAM(isa_create_simple_orphan(isa_bus, "isa-m48t59"));
 
-        isa_dev = isa_new("cs4231a");
+        isa_dev = isa_new_orphan("cs4231a");
         dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "iobase", 0x830);
         qdev_prop_set_uint32(dev, "irq", 10);
@@ -345,7 +345,7 @@ static void ibm_40p_init(MachineState *machine)
         }
         isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
-        isa_dev = isa_new("pc87312");
+        isa_dev = isa_new_orphan("pc87312");
         dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "config", 12);
         isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index ba396435d1..b9e5ec6ff6 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -930,7 +930,7 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, int base_year,
     ISADevice *isadev;
     MC146818RtcState *s;
 
-    isadev = isa_new(TYPE_MC146818_RTC);
+    isadev = isa_new_orphan(TYPE_MC146818_RTC);
     dev = DEVICE(isadev);
     s = MC146818_RTC(isadev);
     qdev_prop_set_int32(dev, "base_year", base_year);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 5de873126c..b60588cf7d 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -329,13 +329,13 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     parallel_hds_isa_init(s->isa_bus, MAX_PARALLEL_PORTS);
 
     /* Keyboard */
-    isa_create_simple(s->isa_bus, TYPE_I8042);
+    isa_create_simple_orphan(s->isa_bus, TYPE_I8042);
 
     /* Floppy */
     for (i = 0; i < MAX_FD; i++) {
         fd[i] = drive_get(IF_FLOPPY, 0, i);
     }
-    isa_dev = isa_new(TYPE_ISA_FDC);
+    isa_dev = isa_new_orphan(TYPE_ISA_FDC);
     dev = DEVICE(isa_dev);
     qdev_prop_set_uint32(dev, "dma", -1);
     isa_realize_and_unref(isa_dev, s->isa_bus, &error_fatal);
diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
index 8f5e27c6f5..22dd3645d2 100644
--- a/include/hw/i386/vmport.h
+++ b/include/hw/i386/vmport.h
@@ -20,7 +20,7 @@ typedef enum {
 
 static inline void vmport_init(ISABus *bus)
 {
-    isa_create_simple(bus, TYPE_VMPORT);
+    isa_create_simple_orphan(bus, TYPE_VMPORT);
 }
 
 void vmport_register(VMPortCommand command, VMPortReadFunc *func, void *opaque);
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 94bff33fcc..af8e07c253 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -80,10 +80,14 @@ IsaDma *isa_bus_get_dma(ISABus *bus, int nchan);
  * Return IRQ @irqnum from the PIC associated on ISA @bus.
  */
 qemu_irq isa_bus_get_irq(ISABus *bus, unsigned irqnum);
-ISADevice *isa_new(const char *name);
-ISADevice *isa_try_new(const char *name);
+ISADevice *isa_new(Object *parent, const char *id, const char *type);
+ISADevice *isa_try_new(Object *parent, const char *id, const char *type);
+ISADevice *isa_create_simple(Object *parent, const char *id,
+                             ISABus *bus, const char *type);
+ISADevice *isa_new_orphan(const char *name);
+ISADevice *isa_try_new_orphan(const char *name);
 bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp);
-ISADevice *isa_create_simple(ISABus *bus, const char *name);
+ISADevice *isa_create_simple_orphan(ISABus *bus, const char *name);
 
 ISADevice *isa_vga_init(ISABus *bus);
 
diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
index 1e14d1afc0..ef8b3334d7 100644
--- a/include/hw/net/ne2000-isa.h
+++ b/include/hw/net/ne2000-isa.h
@@ -22,7 +22,7 @@ static inline ISADevice *isa_ne2000_init(ISABus *bus, int base, int irq,
 {
     ISADevice *d;
 
-    d = isa_try_new(TYPE_ISA_NE2000);
+    d = isa_try_new_orphan(TYPE_ISA_NE2000);
     if (d) {
         DeviceState *dev = DEVICE(d);
 
diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
index 65775b789d..38f896063e 100644
--- a/include/hw/timer/i8254.h
+++ b/include/hw/timer/i8254.h
@@ -51,7 +51,7 @@ static inline ISADevice *i8254_pit_init(ISABus *bus, int base, int isa_irq,
     DeviceState *dev;
     ISADevice *d;
 
-    d = isa_new(TYPE_I8254);
+    d = isa_new_orphan(TYPE_I8254);
     dev = DEVICE(d);
     qdev_prop_set_uint32(dev, "iobase", base);
     isa_realize_and_unref(d, bus, &error_fatal);
@@ -67,7 +67,7 @@ static inline ISADevice *kvm_pit_init(ISABus *bus, int base)
     DeviceState *dev;
     ISADevice *d;
 
-    d = isa_new(TYPE_KVM_I8254);
+    d = isa_new_orphan(TYPE_KVM_I8254);
     dev = DEVICE(d);
     qdev_prop_set_uint32(dev, "iobase", base);
     isa_realize_and_unref(d, bus, &error_fatal);
diff --git a/scripts/coccinelle/qom-parent/isa-new-orphan.cocci b/scripts/coccinelle/qom-parent/isa-new-orphan.cocci
new file mode 100644
index 0000000000..75393543c8
--- /dev/null
+++ b/scripts/coccinelle/qom-parent/isa-new-orphan.cocci
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Rename isa_new()/isa_try_new()/isa_create_simple() to *_orphan()
+// so that the short names can be reintroduced with a mandatory
+// (parent, id, ...) signature.
+//
+// spatch --sp-file scripts/coccinelle/qom-parent/isa-new-orphan.cocci \
+//        --in-place --include-headers --dir .
+
+@@
+@@
+- isa_new
++ isa_new_orphan
+
+@@
+@@
+- isa_try_new
++ isa_try_new_orphan
+
+@@
+@@
+- isa_create_simple
++ isa_create_simple_orphan
-- 
2.47.1


