Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82597C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigZZ-0002cj-Ql; Sat, 11 Jul 2026 18:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigZO-0002Mq-VV; Sat, 11 Jul 2026 18:53:15 -0400
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.12.53.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigZK-0000Ac-4k; Sat, 11 Jul 2026 18:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810390; x=1815346390;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vwkgnduj/+HXlS+7CWphWPURMwYQ0I314noMXbvQwxY=;
 b=h3HejtJxBmgsGAVi7MPAOye7AwRCuYAiymdsDYbuEZ4My+tzxpYqmROk
 /ltb72+q+FBMt41dwwUg/zpfaREHtyjWTjG5FPYVzr6dbITsMts+mQmUE
 vkDpLR8vb6E66yyotAZWQM9elIkp8DtHgT9lWv09NTpRU9HqW00wILXq/
 8LI9jBqHCoAwBLi33Qbs+iaB7QcLrz5cmzLo3VpiCx+Fhpg0ofm97FCPj
 jgomy9UQ+7jILrJarIdS6mLFE/dJnPi6BlYaiOpod8m3T6tN+DRmU8BGE
 1hE3MTmtWNnNEqj99P6WbRgtvrTKihSZXhvfI9Rhk9BaAWzJfUlirn98z Q==;
X-CSE-ConnectionGUID: hCgQ2S8kSt2IE28oI9mdWg==
X-CSE-MsgGUID: hOHBdJVASk+ZPinhqPy6hg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23369899"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:53:06 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:22626]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.135:2525]
 with esmtp (Farcaster)
 id 60bd7a42-b55d-44a5-9f8c-19f21ed63b41; Sat, 11 Jul 2026 22:53:06 +0000 (UTC)
X-Farcaster-Flow-ID: 60bd7a42-b55d-44a5-9f8c-19f21ed63b41
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:53:05 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:52:56 +0000
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
Subject: [RFC PATCH 060/134] hw/arm/realview,
 integratorcp: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:53 +0000
Message-ID: <20260711223707.42139-61-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.12.53.23;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in the hw/arm realview, integratorcp
board files to the new parented API introduced earlier in this
series, so every onboard device gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/integratorcp.c:624 | qdev_new | OBJECT(machine) | "core" | board init; single core module
hw/arm/integratorcp.c:629 | sysbus_create_varargs | OBJECT(machine) | "pic" | board init; primary PIC
hw/arm/integratorcp.c:636 | sysbus_create_simple | OBJECT(machine) | "sic" | board init; secondary PIC
hw/arm/integratorcp.c:637 | sysbus_create_varargs | OBJECT(machine) | "pit" | board init; single PIT
hw/arm/integratorcp.c:639 | sysbus_create_simple | OBJECT(machine) | "rtc" | board init; single pl031 RTC
hw/arm/integratorcp.c:642 | sysbus_create_simple | OBJECT(machine) | "icp" | board init; ICP control regs
hw/arm/integratorcp.c:644 | sysbus_create_simple | OBJECT(machine) | "keyboard" | board init; pl050 KMI0
hw/arm/integratorcp.c:645 | sysbus_create_simple | OBJECT(machine) | "mouse" | board init; pl050 KMI1
hw/arm/integratorcp.c:646 | sysbus_create_simple | OBJECT(machine) | "debug" | board init; single debug LEDs
hw/arm/integratorcp.c:648 | sysbus_create_varargs | OBJECT(machine) | "mmc" | board init; single pl181 MMC
hw/arm/integratorcp.c:657 | qdev_new | OBJECT(machine) | "sd-card" | board init; single SD card
hw/arm/integratorcp.c:664 | qdev_new | OBJECT(machine) | "aaci" | board init; single pl041 audio
hw/arm/integratorcp.c:676 | qdev_new | OBJECT(machine) | "clcd" | board init; single pl110 CLCD
hw/arm/realview.c:64 | qdev_new | parent | "split-irq[*]" | helper: threaded Object *parent from board init; called twice → auto-index
hw/arm/realview.c:183 | qdev_new | OBJECT(machine) | "sysctl" | board init; single sysctl
hw/arm/realview.c:191 | qdev_new | OBJECT(machine) | "mpcore" | board init; A9 mpcore (excl. w/ 194,209)
hw/arm/realview.c:194 | qdev_new | OBJECT(machine) | "mpcore" | board init; 11MP mpcore (excl. w/ 191,209)
hw/arm/realview.c:203 | sysbus_create_varargs | OBJECT(machine) | "l2x0" | board init; single L2 cache ctlr
hw/arm/realview.c:209 | sysbus_create_simple | OBJECT(machine) | "gic" | board init; single GIC (excl. w/ 191,194)
hw/arm/realview.c:215 | qdev_new | OBJECT(machine) | "aaci" | board init; single pl041 audio
hw/arm/realview.c:224 | sysbus_create_simple | OBJECT(machine) | "keyboard" | board init; pl050 KMI0
hw/arm/realview.c:225 | sysbus_create_simple | OBJECT(machine) | "mouse" | board init; pl050 KMI1
hw/arm/realview.c:233 | qdev_new | OBJECT(machine) | "dma" | board init; single pl081 DMA
hw/arm/realview.c:241 | sysbus_create_simple | OBJECT(machine) | "timer[*]" | board init; 2× sp804 → auto-index
hw/arm/realview.c:242 | sysbus_create_simple | OBJECT(machine) | "timer[*]" | board init; 2× sp804 → auto-index
hw/arm/realview.c:244 | sysbus_create_simple | OBJECT(machine) | "gpio[*]" | board init; 3× pl061 → auto-index
hw/arm/realview.c:245 | sysbus_create_simple | OBJECT(machine) | "gpio[*]" | board init; 3× pl061 → auto-index
hw/arm/realview.c:246 | sysbus_create_simple | OBJECT(machine) | "gpio[*]" | board init; 3× pl061 → auto-index
hw/arm/realview.c:248 | qdev_new | OBJECT(machine) | "clcd" | board init; single pl111 CLCD
hw/arm/realview.c:255 | sysbus_create_varargs | OBJECT(machine) | "mmc" | board init; single pl181 MMC
hw/arm/realview.c:274 | qdev_new | OBJECT(machine) | "sd-card" | board init; single SD card
hw/arm/realview.c:281 | sysbus_create_simple | OBJECT(machine) | "rtc" | board init; single pl031 RTC
hw/arm/realview.c:284 | qdev_new | OBJECT(machine) | "pci-host" | board init; single PCI host bridge
hw/arm/realview.c:300 | pci_create_simple | OBJECT(machine) | "ohci" | board init; single OHCI USB
hw/arm/realview.c:304 | pci_create_simple | OBJECT(machine) | "scsi[*]" | board init; loop → auto-index
hw/arm/realview.c:322 | sysbus_create_simple | OBJECT(machine) | "i2c" | board init; single SBCon I2C
hw/arm/realview.c:324 | i2c_slave_create_simple | OBJECT(machine) | "ds1338" | board init; single DS1338 RTC

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/integratorcp.c | 45 ++++++++++++----------
 hw/arm/realview.c     | 87 +++++++++++++++++++++++++------------------
 2 files changed, 76 insertions(+), 56 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 7560ad5983..ed715a3eb8 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -621,31 +621,38 @@ static void integratorcp_init(MachineState *machine)
                              0, ram_size);
     memory_region_add_subregion(address_space_mem, 0x80000000, ram_alias);
 
-    dev = qdev_new_orphan(TYPE_INTEGRATOR_CM);
+    dev = qdev_new(OBJECT(machine), "core", TYPE_INTEGRATOR_CM);
     qdev_prop_set_uint32(dev, "memsz", ram_size >> 20);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map((SysBusDevice *)dev, 0, 0x10000000);
 
-    dev = sysbus_create_varargs_orphan(TYPE_INTEGRATOR_PIC, 0x14000000,
+    dev = sysbus_create_varargs(OBJECT(machine), "pic",
+                                TYPE_INTEGRATOR_PIC, 0x14000000,
                                 qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ),
                                 qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_FIQ),
                                 NULL);
     for (i = 0; i < 32; i++) {
         pic[i] = qdev_get_gpio_in(dev, i);
     }
-    sic = sysbus_create_simple_orphan(TYPE_INTEGRATOR_PIC, 0xca000000, pic[26]);
-    sysbus_create_varargs_orphan("integrator_pit", 0x13000000,
+    sic = sysbus_create_simple(OBJECT(machine), "sic",
+                               TYPE_INTEGRATOR_PIC, 0xca000000, pic[26]);
+    sysbus_create_varargs(OBJECT(machine), "pit", "integrator_pit", 0x13000000,
                           pic[5], pic[6], pic[7], NULL);
-    sysbus_create_simple_orphan("pl031", 0x15000000, pic[8]);
+    sysbus_create_simple(OBJECT(machine), "rtc", "pl031", 0x15000000, pic[8]);
     pl011_create(OBJECT(machine), 0x16000000, pic[1], serial_hd(0));
     pl011_create(OBJECT(machine), 0x17000000, pic[2], serial_hd(1));
-    icp = sysbus_create_simple_orphan(TYPE_ICP_CONTROL_REGS, 0xcb000000,
+    icp = sysbus_create_simple(OBJECT(machine), "icp",
+                               TYPE_ICP_CONTROL_REGS, 0xcb000000,
                                qdev_get_gpio_in(sic, 3));
-    sysbus_create_simple_orphan("pl050_keyboard", 0x18000000, pic[3]);
-    sysbus_create_simple_orphan("pl050_mouse", 0x19000000, pic[4]);
-    sysbus_create_simple_orphan(TYPE_INTEGRATOR_DEBUG, 0x1a000000, 0);
-
-    dev = sysbus_create_varargs_orphan("pl181", 0x1c000000, pic[23], pic[24], NULL);
+    sysbus_create_simple(OBJECT(machine), "keyboard",
+                         "pl050_keyboard", 0x18000000, pic[3]);
+    sysbus_create_simple(OBJECT(machine), "mouse",
+                         "pl050_mouse", 0x19000000, pic[4]);
+    sysbus_create_simple(OBJECT(machine), "debug",
+                         TYPE_INTEGRATOR_DEBUG, 0x1a000000, 0);
+
+    dev = sysbus_create_varargs(OBJECT(machine), "mmc", "pl181",
+                                0x1c000000, pic[23], pic[24], NULL);
     qdev_connect_gpio_out_named(dev, "card-read-only", 0,
                           qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_WPROT, 0));
     qdev_connect_gpio_out_named(dev, "card-inserted", 0,
@@ -654,18 +661,18 @@ static void integratorcp_init(MachineState *machine)
     if (dinfo) {
         DeviceState *card;
 
-        card = qdev_new_orphan(TYPE_SD_CARD);
+        card = qdev_new(OBJECT(machine), "sd-card", TYPE_SD_CARD);
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
-        qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
-                               &error_fatal);
+        qdev_realize(card, qdev_get_child_bus(dev, "sd-bus"),
+                     &error_fatal);
     }
 
-    dev = qdev_new_orphan("pl041");
+    dev = qdev_new(OBJECT(machine), "aaci", "pl041");
     if (machine->audiodev) {
         qdev_prop_set_string(dev, "audiodev", machine->audiodev);
     }
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x1d000000);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[25]);
 
@@ -673,10 +680,10 @@ static void integratorcp_init(MachineState *machine)
         smc91c111_init(OBJECT(machine), 0xc8000000, pic[27]);
     }
 
-    dev = qdev_new_orphan("pl110");
+    dev = qdev_new(OBJECT(machine), "clcd", "pl110");
     object_property_set_link(OBJECT(dev), "framebuffer-memory",
                              OBJECT(address_space_mem), &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xc0000000);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[22]);
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 965fef4fcf..2441137222 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -59,13 +59,14 @@ static const int realview_board_id[] = {
     0x76d
 };
 
-static void split_irq_from_named(DeviceState *src, const char* outname,
-                                 qemu_irq out1, qemu_irq out2) {
-    DeviceState *splitter = qdev_new_orphan(TYPE_SPLIT_IRQ);
+static void split_irq_from_named(Object *parent, DeviceState *src,
+                                  const char *outname,
+                                  qemu_irq out1, qemu_irq out2) {
+    DeviceState *splitter = qdev_new(parent, "split-irq[*]", TYPE_SPLIT_IRQ);
 
     qdev_prop_set_uint32(splitter, "num-lines", 2);
 
-    qdev_realize_and_unref(splitter, NULL, &error_fatal);
+    qdev_realize(splitter, NULL, &error_fatal);
 
     qdev_connect_gpio_out(splitter, 0, out1);
     qdev_connect_gpio_out(splitter, 1, out2);
@@ -180,49 +181,53 @@ static void realview_init(MachineState *machine,
     }
 
     sys_id = is_pb ? 0x01780500 : 0xc1400400;
-    sysctl = qdev_new_orphan("realview_sysctl");
+    sysctl = qdev_new(OBJECT(machine), "sysctl", "realview_sysctl");
     qdev_prop_set_uint32(sysctl, "sys_id", sys_id);
     qdev_prop_set_uint32(sysctl, "proc_id", proc_id);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(sysctl), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(sysctl), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sysctl), 0, 0x10000000);
 
     if (is_mpcore) {
         if (is_pb) {
-            dev = qdev_new_orphan(TYPE_A9MPCORE_PRIV);
+            dev = qdev_new(OBJECT(machine), "mpcore", TYPE_A9MPCORE_PRIV);
             qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
         } else {
-            dev = qdev_new_orphan("realview_mpcore");
+            dev = qdev_new(OBJECT(machine), "mpcore", "realview_mpcore");
         }
         qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
         busdev = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(busdev, &error_fatal);
+        sysbus_realize(busdev, &error_fatal);
         sysbus_mmio_map(busdev, 0, periphbase);
         for (n = 0; n < smp_cpus; n++) {
             sysbus_connect_irq(busdev, n, cpu_irq[n]);
         }
-        sysbus_create_varargs_orphan("l2x0", periphbase + 0x2000, NULL);
+        sysbus_create_varargs(OBJECT(machine), "l2x0", "l2x0",
+                              periphbase + 0x2000, NULL);
         /* Both A9 and 11MPCore put the GIC CPU i/f at base + 0x100 */
         realview_binfo.gic_cpu_if_addr = periphbase + 0x100;
     } else {
         uint32_t gic_addr = is_pb ? 0x1e000000 : 0x10040000;
         /* For now just create the nIRQ GIC, and ignore the others.  */
-        dev = sysbus_create_simple_orphan(TYPE_REALVIEW_GIC, gic_addr, cpu_irq[0]);
+        dev = sysbus_create_simple(OBJECT(machine), "gic",
+                                   TYPE_REALVIEW_GIC, gic_addr, cpu_irq[0]);
     }
     for (n = 0; n < GIC_EXT_IRQS; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
-    pl041 = qdev_new_orphan("pl041");
+    pl041 = qdev_new(OBJECT(machine), "aaci", "pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
     if (machine->audiodev) {
         qdev_prop_set_string(pl041, "audiodev", machine->audiodev);
     }
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(pl041), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(pl041), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(pl041), 0, 0x10004000);
     sysbus_connect_irq(SYS_BUS_DEVICE(pl041), 0, pic[19]);
 
-    sysbus_create_simple_orphan("pl050_keyboard", 0x10006000, pic[20]);
-    sysbus_create_simple_orphan("pl050_mouse", 0x10007000, pic[21]);
+    sysbus_create_simple(OBJECT(machine), "keyboard",
+                         "pl050_keyboard", 0x10006000, pic[20]);
+    sysbus_create_simple(OBJECT(machine), "mouse",
+                         "pl050_mouse", 0x10007000, pic[21]);
 
     pl011_create(OBJECT(machine), 0x10009000, pic[12], serial_hd(0));
     pl011_create(OBJECT(machine), 0x1000a000, pic[13], serial_hd(1));
@@ -230,40 +235,46 @@ static void realview_init(MachineState *machine,
     pl011_create(OBJECT(machine), 0x1000c000, pic[15], serial_hd(3));
 
     /* DMA controller is optional, apparently.  */
-    dev = qdev_new_orphan("pl081");
+    dev = qdev_new(OBJECT(machine), "dma", "pl081");
     object_property_set_link(OBJECT(dev), "downstream", OBJECT(sysmem),
                              &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x10030000);
     sysbus_connect_irq(busdev, 0, pic[24]);
 
-    sysbus_create_simple_orphan("sp804", 0x10011000, pic[4]);
-    sysbus_create_simple_orphan("sp804", 0x10012000, pic[5]);
+    sysbus_create_simple(OBJECT(machine), "timer[*]",
+                         "sp804", 0x10011000, pic[4]);
+    sysbus_create_simple(OBJECT(machine), "timer[*]",
+                         "sp804", 0x10012000, pic[5]);
 
-    sysbus_create_simple_orphan("pl061", 0x10013000, pic[6]);
-    sysbus_create_simple_orphan("pl061", 0x10014000, pic[7]);
-    gpio2 = sysbus_create_simple_orphan("pl061", 0x10015000, pic[8]);
+    sysbus_create_simple(OBJECT(machine), "gpio[*]",
+                         "pl061", 0x10013000, pic[6]);
+    sysbus_create_simple(OBJECT(machine), "gpio[*]",
+                         "pl061", 0x10014000, pic[7]);
+    gpio2 = sysbus_create_simple(OBJECT(machine), "gpio[*]",
+                                 "pl061", 0x10015000, pic[8]);
 
-    dev = qdev_new_orphan("pl111");
+    dev = qdev_new(OBJECT(machine), "clcd", "pl111");
     object_property_set_link(OBJECT(dev), "framebuffer-memory",
                              OBJECT(sysmem), &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x10020000);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[23]);
 
-    dev = sysbus_create_varargs_orphan("pl181", 0x10005000, pic[17], pic[18], NULL);
+    dev = sysbus_create_varargs(OBJECT(machine), "mmc", "pl181",
+                                0x10005000, pic[17], pic[18], NULL);
     /* Wire up MMC card detect and read-only signals. These have
      * to go to both the PL061 GPIO and the sysctl register.
      * Note that the PL181 orders these lines (readonly,inserted)
      * and the PL061 has them the other way about. Also the card
      * detect line is inverted.
      */
-    split_irq_from_named(dev, "card-read-only",
+    split_irq_from_named(OBJECT(machine), dev, "card-read-only",
                    qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_WPROT),
                    qdev_get_gpio_in(gpio2, 1));
 
-    split_irq_from_named(dev, "card-inserted",
+    split_irq_from_named(OBJECT(machine), dev, "card-inserted",
                    qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_CARDIN),
                    qemu_irq_invert(qdev_get_gpio_in(gpio2, 0)));
 
@@ -271,19 +282,19 @@ static void realview_init(MachineState *machine,
     if (dinfo) {
         DeviceState *card;
 
-        card = qdev_new_orphan(TYPE_SD_CARD);
+        card = qdev_new(OBJECT(machine), "sd-card", TYPE_SD_CARD);
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
-        qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
-                               &error_fatal);
+        qdev_realize(card, qdev_get_child_bus(dev, "sd-bus"),
+                     &error_fatal);
     }
 
-    sysbus_create_simple_orphan("pl031", 0x10017000, pic[10]);
+    sysbus_create_simple(OBJECT(machine), "rtc", "pl031", 0x10017000, pic[10]);
 
     if (!is_pb) {
-        dev = qdev_new_orphan("realview_pci");
+        dev = qdev_new(OBJECT(machine), "pci-host", "realview_pci");
         busdev = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(busdev, &error_fatal);
+        sysbus_realize(busdev, &error_fatal);
         sysbus_mmio_map(busdev, 0, 0x10019000); /* PCI controller registers */
         sysbus_mmio_map(busdev, 1, 0x60000000); /* PCI self-config */
         sysbus_mmio_map(busdev, 2, 0x61000000); /* PCI config */
@@ -297,11 +308,12 @@ static void realview_init(MachineState *machine,
         sysbus_connect_irq(busdev, 3, pic[51]);
         pci_bus = (PCIBus *)qdev_get_child_bus(dev, "pci");
         if (machine_usb(machine)) {
-            pci_create_simple_orphan(pci_bus, -1, "pci-ohci");
+            pci_create_simple(OBJECT(machine), "ohci", pci_bus, -1, "pci-ohci");
         }
         n = drive_get_max_bus(IF_SCSI);
         while (n >= 0) {
-            dev = DEVICE(pci_create_simple_orphan(pci_bus, -1, "lsi53c895a"));
+            dev = DEVICE(pci_create_simple(OBJECT(machine), "scsi[*]",
+                                           pci_bus, -1, "lsi53c895a"));
             lsi53c8xx_handle_legacy_cmdline(dev);
             n--;
         }
@@ -319,9 +331,10 @@ static void realview_init(MachineState *machine,
         pci_init_nic_devices(pci_bus, "rtl8139");
     }
 
-    dev = sysbus_create_simple_orphan(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
+    dev = sysbus_create_simple(OBJECT(machine), "i2c",
+                               TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
-    i2c_slave_create_simple_orphan(i2c, "ds1338", 0x68);
+    i2c_slave_create_simple(OBJECT(machine), "ds1338", i2c, "ds1338", 0x68);
 
     /* Memory map for RealView Emulation Baseboard:  */
     /* 0x10000000 System registers.  */
-- 
2.47.1


