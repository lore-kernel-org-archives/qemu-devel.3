Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C90C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCzo-000292-Tn; Sat, 18 Jul 2026 17:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCzj-00025c-KU; Sat, 18 Jul 2026 17:54:52 -0400
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.26.1.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCze-00049M-Qg; Sat, 18 Jul 2026 17:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411686; x=1815947686;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XXcX6cyNEpmuM55gtPA9WgOb2tto2fQXz4Qv+yiFgAI=;
 b=rmg09wojh9B09XlwR6cmHI9xMPjYE3GdnQd+poSWdklFCQQ5JWjXJ/QV
 z27Dt5nMGQDBDLJcVKnXqs5KK7sYwczPiE0Fhp9rvcdYHJFkqrH6RWiEW
 O/2aeNE0TvTrxgwxeDBkkkb6VJFVLPZltlLhyb+qJ/YLHVxE3ZXlYvxTl
 6vYFIk6Kat5YKf6llDldBQJdMRxMKfaTsp0IJQ5WEZrl2z/NcdGuT2APQ
 jzpWDo3gEjcgIu4q9xnh0MSJPZf3xLY8ngc148t2FnhzgGS9k/CNNaUgK
 8hmhWxL+tF5WIXjdgFBIehUAqbc5wkmyFoF/LqrM9tiZnHPUE8iDcAnZ/ Q==;
X-CSE-ConnectionGUID: 7epSKBDoQ46DuC3YuSgIdA==
X-CSE-MsgGUID: +j0qoYk4QRS/52GKQySUyQ==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23944248"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:54:43 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:29108]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.115:2525]
 with esmtp (Farcaster)
 id 9acfdff6-759e-4fcd-90ae-05d374577bb8; Sat, 18 Jul 2026 21:54:42 +0000 (UTC)
X-Farcaster-Flow-ID: 9acfdff6-759e-4fcd-90ae-05d374577bb8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:54:42 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:54:32 +0000
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
Subject: [RFC PATCH v2 063/137] hw/arm/versatile,
 vexpress: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:38 +0000
Message-ID: <20260718213652.37673-64-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.26.1.71;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in the hw/arm versatile, vexpress
board files to the new parented API introduced earlier in this
series, so every onboard device gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/versatilepb.c:229 | qdev_new | OBJECT(machine) | "sysctl" | board init(); machine owns onboard sysctl
hw/arm/versatilepb.c:235 | sysbus_create_varargs | OBJECT(machine) | "vic" | board init(); PL190 primary intc
hw/arm/versatilepb.c:242 | sysbus_create_simple | OBJECT(machine) | "sic" | board init(); secondary intc
hw/arm/versatilepb.c:248 | sysbus_create_simple | OBJECT(machine) | "keyboard" | board init(); single KMI kbd
hw/arm/versatilepb.c:249 | sysbus_create_simple | OBJECT(machine) | "mouse" | board init(); single KMI mouse
hw/arm/versatilepb.c:251 | qdev_new | OBJECT(machine) | "pci-host" | board init(); versatile PCI host bridge
hw/arm/versatilepb.c:273 | pci_create_simple | OBJECT(machine) | "usb" | board init(); optional OHCI on PCI bus
hw/arm/versatilepb.c:277 | pci_create_simple | OBJECT(machine) | "scsi[*]" | board init(); loop over IF_SCSI buses
hw/arm/versatilepb.c:287 | qdev_new | OBJECT(machine) | "dma" | board init(); PL080 DMA
hw/arm/versatilepb.c:295 | sysbus_create_simple | OBJECT(machine) | "timer[*]" | board init(); two SP804 blocks
hw/arm/versatilepb.c:296 | sysbus_create_simple | OBJECT(machine) | "timer[*]" | board init(); auto-index sibling
hw/arm/versatilepb.c:298 | sysbus_create_simple | OBJECT(machine) | "gpio[*]" | board init(); four PL061 ports
hw/arm/versatilepb.c:299 | sysbus_create_simple | OBJECT(machine) | "gpio[*]" | board init(); auto-index sibling
hw/arm/versatilepb.c:300 | sysbus_create_simple | OBJECT(machine) | "gpio[*]" | board init(); auto-index sibling
hw/arm/versatilepb.c:301 | sysbus_create_simple | OBJECT(machine) | "gpio[*]" | board init(); auto-index sibling
hw/arm/versatilepb.c:305 | qdev_new | OBJECT(machine) | "clcd" | board init(); PL110 display
hw/arm/versatilepb.c:315 | sysbus_create_varargs | OBJECT(machine) | "mmci[*]" | board init(); two PL181 MMCI
hw/arm/versatilepb.c:320 | qdev_new | OBJECT(machine) | "sd-card[*]" | board init(); removable card owned by machine
hw/arm/versatilepb.c:327 | sysbus_create_varargs | OBJECT(machine) | "mmci[*]" | board init(); auto-index sibling
hw/arm/versatilepb.c:332 | qdev_new | OBJECT(machine) | "sd-card[*]" | board init(); auto-index sibling
hw/arm/versatilepb.c:340 | sysbus_create_simple | OBJECT(machine) | "rtc" | board init(); PL031 RTC
hw/arm/versatilepb.c:342 | sysbus_create_simple | OBJECT(machine) | "i2c" | board init(); SBCon I2C bridge
hw/arm/versatilepb.c:344 | i2c_slave_create_simple | OBJECT(machine) | "ds1338" | board init(); onboard I2C RTC chip
hw/arm/versatilepb.c:347 | qdev_new | OBJECT(machine) | "aaci" | board init(); PL041 audio
hw/arm/vexpress.c:244 | qdev_new | OBJECT(ms) | "mpcore" | init_cpus() takes MachineState *ms; A9/A15 priv block
hw/arm/vexpress.c:304 | qdev_new | OBJECT(vms) | "db-clcd" | a9_daughterboard_init() has vms; distinct from motherboard clcd
hw/arm/vexpress.c:316 | sysbus_create_simple | OBJECT(vms) | "timer[*]" | a9 daughterboard SP804; auto-index shared with motherboard timers
hw/arm/vexpress.c:324 | sysbus_create_varargs | OBJECT(vms) | "l2x0" | a9 daughterboard L2 cache ctrl
hw/arm/vexpress.c:520 | qdev_new | parent | "flash[*]" | helper: thread Object *parent as first arg; two callers pass OBJECT(machine)
hw/arm/vexpress.c:595 | qdev_new | OBJECT(machine) | "sysctl" | vexpress_common_init(MachineState *machine)
hw/arm/vexpress.c:617 | qdev_new | OBJECT(machine) | "aaci" | board init(); PL041 audio
hw/arm/vexpress.c:626 | sysbus_create_varargs | OBJECT(machine) | "mmci" | board init(); single PL181
hw/arm/vexpress.c:636 | qdev_new | OBJECT(machine) | "sd-card" | board init(); single removable SD
hw/arm/vexpress.c:643 | sysbus_create_simple | OBJECT(machine) | "keyboard" | board init(); KMI0
hw/arm/vexpress.c:644 | sysbus_create_simple | OBJECT(machine) | "mouse" | board init(); KMI1
hw/arm/vexpress.c:651 | sysbus_create_simple | OBJECT(machine) | "timer[*]" | board init(); motherboard SP804
hw/arm/vexpress.c:652 | sysbus_create_simple | OBJECT(machine) | "timer[*]" | board init(); auto-index sibling
hw/arm/vexpress.c:654 | sysbus_create_simple | OBJECT(machine) | "i2c" | board init(); SBCon serial DVI I2C
hw/arm/vexpress.c:656 | i2c_slave_create_simple | OBJECT(machine) | "sii9022" | board init(); HDMI transmitter chip
hw/arm/vexpress.c:658 | sysbus_create_simple | OBJECT(machine) | "rtc" | board init(); PL031
hw/arm/vexpress.c:662 | qdev_new | OBJECT(machine) | "clcd" | board init(); motherboard PL111
hw/arm/vexpress.c:709 | sysbus_create_simple | OBJECT(machine) | "virtio-mmio[*]" | board init(); loop of transports

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/versatilepb.c | 70 +++++++++++++++++++++++---------------------
 hw/arm/vexpress.c    | 66 +++++++++++++++++++++--------------------
 2 files changed, 72 insertions(+), 64 deletions(-)

diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 6fb7223265..f68c4765c6 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -226,31 +226,33 @@ static void versatile_init(MachineState *machine, int board_id)
     /* SDRAM at address zero.  */
     memory_region_add_subregion(sysmem, 0, machine->ram);
 
-    sysctl = qdev_new_orphan("realview_sysctl");
+    sysctl = qdev_new(OBJECT(machine), "sysctl", "realview_sysctl");
     qdev_prop_set_uint32(sysctl, "sys_id", 0x41007004);
     qdev_prop_set_uint32(sysctl, "proc_id", 0x02000000);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(sysctl), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(sysctl), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sysctl), 0, 0x10000000);
 
-    dev = sysbus_create_varargs_orphan("pl190", 0x10140000,
+    dev = sysbus_create_varargs(OBJECT(machine), "vic", "pl190", 0x10140000,
                                 qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ),
                                 qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_FIQ),
                                 NULL);
     for (n = 0; n < 32; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
     }
-    dev = sysbus_create_simple_orphan(TYPE_VERSATILE_PB_SIC, 0x10003000, NULL);
+    dev = sysbus_create_simple(OBJECT(machine), "sic",
+                               TYPE_VERSATILE_PB_SIC, 0x10003000, NULL);
     for (n = 0; n < 32; n++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), n, pic[n]);
         sic[n] = qdev_get_gpio_in(dev, n);
     }
 
-    sysbus_create_simple_orphan("pl050_keyboard", 0x10006000, sic[3]);
-    sysbus_create_simple_orphan("pl050_mouse", 0x10007000, sic[4]);
+    sysbus_create_simple(OBJECT(machine), "keyboard", "pl050_keyboard",
+                         0x10006000, sic[3]);
+    sysbus_create_simple(OBJECT(machine), "mouse", "pl050_mouse", 0x10007000, sic[4]);
 
-    dev = qdev_new_orphan("versatile_pci");
+    dev = qdev_new(OBJECT(machine), "pci-host", "versatile_pci");
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x10001000); /* PCI controller regs */
     sysbus_mmio_map(busdev, 1, 0x41000000); /* PCI self-config */
     sysbus_mmio_map(busdev, 2, 0x42000000); /* PCI config */
@@ -270,11 +272,12 @@ static void versatile_init(MachineState *machine, int board_id)
     pci_init_nic_devices(pci_bus, "rtl8139");
 
     if (machine_usb(machine)) {
-        pci_create_simple_orphan(pci_bus, -1, "pci-ohci");
+        pci_create_simple(OBJECT(machine), "usb", pci_bus, -1, "pci-ohci");
     }
     n = drive_get_max_bus(IF_SCSI);
     while (n >= 0) {
-        dev = DEVICE(pci_create_simple_orphan(pci_bus, -1, "lsi53c895a"));
+        dev = DEVICE(pci_create_simple(OBJECT(machine), "scsi[*]",
+                                       pci_bus, -1, "lsi53c895a"));
         lsi53c8xx_handle_legacy_cmdline(dev);
         n--;
     }
@@ -284,72 +287,73 @@ static void versatile_init(MachineState *machine, int board_id)
     pl011_create(OBJECT(machine), 0x101f3000, pic[14], serial_hd(2));
     pl011_create(OBJECT(machine), 0x10009000, sic[6], serial_hd(3));
 
-    dev = qdev_new_orphan("pl080");
+    dev = qdev_new(OBJECT(machine), "dma", "pl080");
     object_property_set_link(OBJECT(dev), "downstream", OBJECT(sysmem),
                              &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x10130000);
     sysbus_connect_irq(busdev, 0, pic[17]);
 
-    sysbus_create_simple_orphan("sp804", 0x101e2000, pic[4]);
-    sysbus_create_simple_orphan("sp804", 0x101e3000, pic[5]);
+    sysbus_create_simple(OBJECT(machine), "timer[*]", "sp804", 0x101e2000, pic[4]);
+    sysbus_create_simple(OBJECT(machine), "timer[*]", "sp804", 0x101e3000, pic[5]);
 
-    sysbus_create_simple_orphan("pl061", 0x101e4000, pic[6]);
-    sysbus_create_simple_orphan("pl061", 0x101e5000, pic[7]);
-    sysbus_create_simple_orphan("pl061", 0x101e6000, pic[8]);
-    sysbus_create_simple_orphan("pl061", 0x101e7000, pic[9]);
+    sysbus_create_simple(OBJECT(machine), "gpio[*]", "pl061", 0x101e4000, pic[6]);
+    sysbus_create_simple(OBJECT(machine), "gpio[*]", "pl061", 0x101e5000, pic[7]);
+    sysbus_create_simple(OBJECT(machine), "gpio[*]", "pl061", 0x101e6000, pic[8]);
+    sysbus_create_simple(OBJECT(machine), "gpio[*]", "pl061", 0x101e7000, pic[9]);
 
     /* The versatile/PB actually has a modified Color LCD controller
        that includes hardware cursor support from the PL111.  */
-    dev = qdev_new_orphan("pl110_versatile");
+    dev = qdev_new(OBJECT(machine), "clcd", "pl110_versatile");
     object_property_set_link(OBJECT(dev), "framebuffer-memory",
                              OBJECT(sysmem), &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x10120000);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[16]);
 
     /* Wire up the mux control signals from the SYS_CLCD register */
     qdev_connect_gpio_out(sysctl, 0, qdev_get_gpio_in(dev, 0));
 
-    dev = sysbus_create_varargs_orphan("pl181", 0x10005000, sic[22], sic[1], NULL);
+    dev = sysbus_create_varargs(OBJECT(machine), "mmci[*]", "pl181",
+                                0x10005000, sic[22], sic[1], NULL);
     dinfo = drive_get(IF_SD, 0, 0);
     if (dinfo) {
         DeviceState *card;
 
-        card = qdev_new_orphan(TYPE_SD_CARD);
+        card = qdev_new(OBJECT(machine), "sd-card[*]", TYPE_SD_CARD);
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
-        qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
-                               &error_fatal);
+        qdev_realize(card, qdev_get_child_bus(dev, "sd-bus"), &error_fatal);
     }
 
-    dev = sysbus_create_varargs_orphan("pl181", 0x1000b000, sic[23], sic[2], NULL);
+    dev = sysbus_create_varargs(OBJECT(machine), "mmci[*]", "pl181",
+                                0x1000b000, sic[23], sic[2], NULL);
     dinfo = drive_get(IF_SD, 0, 1);
     if (dinfo) {
         DeviceState *card;
 
-        card = qdev_new_orphan(TYPE_SD_CARD);
+        card = qdev_new(OBJECT(machine), "sd-card[*]", TYPE_SD_CARD);
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
-        qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
-                               &error_fatal);
+        qdev_realize(card, qdev_get_child_bus(dev, "sd-bus"), &error_fatal);
     }
 
     /* Add PL031 Real Time Clock. */
-    sysbus_create_simple_orphan("pl031", 0x101e8000, pic[10]);
+    sysbus_create_simple(OBJECT(machine), "rtc", "pl031", 0x101e8000, pic[10]);
 
-    dev = sysbus_create_simple_orphan(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
+    dev = sysbus_create_simple(OBJECT(machine), "i2c",
+                               TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
-    i2c_slave_create_simple_orphan(i2c, "ds1338", 0x68);
+    i2c_slave_create_simple(OBJECT(machine), "ds1338", i2c, "ds1338", 0x68);
 
     /* Add PL041 AACI Interface to the LM4549 codec */
-    pl041 = qdev_new_orphan("pl041");
+    pl041 = qdev_new(OBJECT(machine), "aaci", "pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
     if (machine->audiodev) {
         qdev_prop_set_string(pl041, "audiodev", machine->audiodev);
     }
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(pl041), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(pl041), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(pl041), 0, 0x10004000);
     sysbus_connect_irq(SYS_BUS_DEVICE(pl041), 0, sic[24]);
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 7c5a69b5a9..a643c6b079 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -241,11 +241,11 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
      * this must happen after the CPUs are created because a15mpcore_priv
      * wires itself up to the CPU's generic_timer gpio out lines.
      */
-    dev = qdev_new_orphan(privdev);
+    dev = qdev_new(OBJECT(ms), "mpcore", privdev);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
     qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, periphbase);
 
     /* Interrupts [42:0] are from the motherboard;
@@ -301,10 +301,10 @@ static void a9_daughterboard_init(VexpressMachineState *vms,
     /* Daughterboard peripherals : 0x10020000 .. 0x20000000 */
 
     /* 0x10020000 PL111 CLCD (daughterboard) */
-    dev = qdev_new_orphan("pl111");
+    dev = qdev_new(OBJECT(vms), "db-clcd", "pl111");
     object_property_set_link(OBJECT(dev), "framebuffer-memory",
                              OBJECT(sysmem), &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x10020000);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[44]);
 
@@ -313,7 +313,7 @@ static void a9_daughterboard_init(VexpressMachineState *vms,
     /* 0x100e1000 PL354 Static Memory Controller */
     /* 0x100e2000 System Configuration Controller */
 
-    sysbus_create_simple_orphan("sp804", 0x100e4000, pic[48]);
+    sysbus_create_simple(OBJECT(vms), "timer[*]", "sp804", 0x100e4000, pic[48]);
     /* 0x100e5000 SP805 Watchdog module */
     /* 0x100e6000 BP147 TrustZone Protection Controller */
     /* 0x100e9000 PL301 'Fast' AXI matrix */
@@ -321,7 +321,7 @@ static void a9_daughterboard_init(VexpressMachineState *vms,
     /* 0x100ec000 TrustZone Address Space Controller */
     /* 0x10200000 CoreSight debug APB */
     /* 0x1e00a000 PL310 L2 Cache Controller */
-    sysbus_create_varargs_orphan("l2x0", 0x1e00a000, NULL);
+    sysbus_create_varargs(OBJECT(vms), "l2x0", "l2x0", 0x1e00a000, NULL);
 }
 
 /* Voltage values for SYS_CFG_VOLT daughterboard registers;
@@ -514,10 +514,11 @@ static void vexpress_modify_dtb(const struct arm_boot_info *info, void *fdt)
 /* Open code a private version of pflash registration since we
  * need to set non-default device width for VExpress platform.
  */
-static PFlashCFI01 *ve_pflash_cfi01_register(hwaddr base, const char *name,
+static PFlashCFI01 *ve_pflash_cfi01_register(Object *parent,
+                                             hwaddr base, const char *name,
                                              DriveInfo *di)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(parent, "flash[*]", TYPE_PFLASH_CFI01);
 
     if (di) {
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di));
@@ -534,7 +535,7 @@ static PFlashCFI01 *ve_pflash_cfi01_register(hwaddr base, const char *name,
     qdev_prop_set_uint16(dev, "id2", 0x00);
     qdev_prop_set_uint16(dev, "id3", 0x00);
     qdev_prop_set_string(dev, "name", name);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     return PFLASH_CFI01(dev);
@@ -592,7 +593,7 @@ static void vexpress_common_init(MachineState *machine)
 
     sys_id = 0x1190f500;
 
-    sysctl = qdev_new_orphan("realview_sysctl");
+    sysctl = qdev_new(OBJECT(machine), "sysctl", "realview_sysctl");
     qdev_prop_set_uint32(sysctl, "sys_id", sys_id);
     qdev_prop_set_uint32(sysctl, "proc_id", daughterboard->proc_id);
 
@@ -608,22 +609,23 @@ static void vexpress_common_init(MachineState *machine)
     }
     qdev_prop_set_array(sysctl, "db-clock", db_clock);
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(sysctl), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(sysctl), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sysctl), 0, map[VE_SYSREGS]);
 
     /* VE_SP810: not modelled */
     /* VE_SERIALPCI: not modelled */
 
-    pl041 = qdev_new_orphan("pl041");
+    pl041 = qdev_new(OBJECT(machine), "aaci", "pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
     if (machine->audiodev) {
         qdev_prop_set_string(pl041, "audiodev", machine->audiodev);
     }
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(pl041), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(pl041), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(pl041), 0, map[VE_PL041]);
     sysbus_connect_irq(SYS_BUS_DEVICE(pl041), 0, pic[11]);
 
-    dev = sysbus_create_varargs_orphan("pl181", map[VE_MMCI], pic[9], pic[10], NULL);
+    dev = sysbus_create_varargs(OBJECT(machine), "mmci", "pl181",
+                                map[VE_MMCI], pic[9], pic[10], NULL);
     /* Wire up MMC card detect and read-only signals */
     qdev_connect_gpio_out_named(dev, "card-read-only", 0,
                           qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_WPROT));
@@ -633,42 +635,43 @@ static void vexpress_common_init(MachineState *machine)
     if (dinfo) {
         DeviceState *card;
 
-        card = qdev_new_orphan(TYPE_SD_CARD);
+        card = qdev_new(OBJECT(machine), "sd-card", TYPE_SD_CARD);
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
-        qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
-                               &error_fatal);
+        qdev_realize(card, qdev_get_child_bus(dev, "sd-bus"), &error_fatal);
     }
 
-    sysbus_create_simple_orphan("pl050_keyboard", map[VE_KMI0], pic[12]);
-    sysbus_create_simple_orphan("pl050_mouse", map[VE_KMI1], pic[13]);
+    sysbus_create_simple(OBJECT(machine), "keyboard", "pl050_keyboard",
+                         map[VE_KMI0], pic[12]);
+    sysbus_create_simple(OBJECT(machine), "mouse", "pl050_mouse", map[VE_KMI1], pic[13]);
 
     pl011_create(OBJECT(machine), map[VE_UART0], pic[5], serial_hd(0));
     pl011_create(OBJECT(machine), map[VE_UART1], pic[6], serial_hd(1));
     pl011_create(OBJECT(machine), map[VE_UART2], pic[7], serial_hd(2));
     pl011_create(OBJECT(machine), map[VE_UART3], pic[8], serial_hd(3));
 
-    sysbus_create_simple_orphan("sp804", map[VE_TIMER01], pic[2]);
-    sysbus_create_simple_orphan("sp804", map[VE_TIMER23], pic[3]);
+    sysbus_create_simple(OBJECT(machine), "timer[*]", "sp804", map[VE_TIMER01], pic[2]);
+    sysbus_create_simple(OBJECT(machine), "timer[*]", "sp804", map[VE_TIMER23], pic[3]);
 
-    dev = sysbus_create_simple_orphan(TYPE_ARM_SBCON_I2C, map[VE_SERIALDVI], NULL);
+    dev = sysbus_create_simple(OBJECT(machine), "i2c",
+                               TYPE_ARM_SBCON_I2C, map[VE_SERIALDVI], NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
-    i2c_slave_create_simple_orphan(i2c, "sii9022", 0x39);
+    i2c_slave_create_simple(OBJECT(machine), "sii9022", i2c, "sii9022", 0x39);
 
-    sysbus_create_simple_orphan("pl031", map[VE_RTC], pic[4]); /* RTC */
+    sysbus_create_simple(OBJECT(machine), "rtc", "pl031", map[VE_RTC], pic[4]); /* RTC */
 
     /* VE_COMPACTFLASH: not modelled */
 
-    dev = qdev_new_orphan("pl111");
+    dev = qdev_new(OBJECT(machine), "clcd", "pl111");
     object_property_set_link(OBJECT(dev), "framebuffer-memory",
                              OBJECT(sysmem), &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, map[VE_CLCD]);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[14]);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
-    pflash0 = ve_pflash_cfi01_register(map[VE_NORFLASH0], "vexpress.flash0",
-                                       dinfo);
+    pflash0 = ve_pflash_cfi01_register(OBJECT(machine), map[VE_NORFLASH0],
+                                       "vexpress.flash0", dinfo);
 
     if (map[VE_NORFLASHALIAS] != -1) {
         /* Map flash 0 as an alias into low memory */
@@ -680,7 +683,8 @@ static void vexpress_common_init(MachineState *machine)
     }
 
     dinfo = drive_get(IF_PFLASH, 0, 1);
-    ve_pflash_cfi01_register(map[VE_NORFLASH1], "vexpress.flash1", dinfo);
+    ve_pflash_cfi01_register(OBJECT(machine), map[VE_NORFLASH1],
+                             "vexpress.flash1", dinfo);
 
     sram_size = 0x2000000;
     memory_region_init_ram(&vms->sram, NULL, "vexpress.sram", sram_size,
@@ -706,8 +710,8 @@ static void vexpress_common_init(MachineState *machine)
      * no backend is created the transport will just sit harmlessly idle.
      */
     for (i = 0; i < NUM_VIRTIO_TRANSPORTS; i++) {
-        sysbus_create_simple_orphan("virtio-mmio", map[VE_VIRTIO] + 0x200 * i,
-                             pic[40 + i]);
+        sysbus_create_simple(OBJECT(machine), "virtio-mmio[*]", "virtio-mmio",
+                             map[VE_VIRTIO] + 0x200 * i, pic[40 + i]);
     }
 
     daughterboard->bootinfo.ram_size = machine->ram_size;
-- 
2.47.1


