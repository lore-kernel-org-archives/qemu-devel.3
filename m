Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D39C44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigaD-00053u-F2; Sat, 11 Jul 2026 18:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigaA-00053O-Qi; Sat, 11 Jul 2026 18:54:02 -0400
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.83.148.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wiga7-0000Qh-9P; Sat, 11 Jul 2026 18:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810439; x=1815346439;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z8QC9EgYqepfR3DwyRyFOP+DGujn22RAsBW42HAJwOM=;
 b=XpYr7nnpZiW6fMpzm28c04b7KluF5h8+cJlwL+vlllaPtHuARiQaKEdd
 R/U0Q+zSRdmAl138/tn9sPtsPxXM3J6FFZLlsipwDWwrljk+JqhYGbnib
 mKMxMux0nIGDxeG/SsUKTqv0JcErVyfd7w9JWxYHu/EsLZjkdF19+iqJF
 xM0IycBEjlPpziY5GD3ZrrLInbzlVP0o5kDSeaUwkd9vw4FgEtGmtEmFR
 sccBnXi/7BgDZDysT1x3DgDZ2FECU7GNrniiJ7zxnx8+xWRnUgnxNH26K
 xBiS7+Wi37v5IkluuvkF3RtYHHjfW6sJ9suHfm/ReThbPISrqixPzslJw A==;
X-CSE-ConnectionGUID: SPlLIvslTaObjA8kPD38YA==
X-CSE-MsgGUID: lBUGM8ehTXSizD2pjjI9pg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23287682"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:53:54 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:15066]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.68:2525]
 with esmtp (Farcaster)
 id 84a6503a-5e51-4325-a72b-fbd3868914c1; Sat, 11 Jul 2026 22:53:54 +0000 (UTC)
X-Farcaster-Flow-ID: 84a6503a-5e51-4325-a72b-fbd3868914c1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:53:53 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:53:44 +0000
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
Subject: [RFC PATCH 063/134] hw/arm/stellaris,
 musicpal: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:56 +0000
Message-ID: <20260711223707.42139-64-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.83.148.184;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in the hw/arm stellaris, musicpal
board files to the new parented API introduced earlier in this
series, so every onboard device gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/musicpal.c:1235 | cpu_create | OBJECT(machine) | "cpu" | musicpal_init(MachineState *machine); single CPU
hw/arm/musicpal.c:1243 | sysbus_create_simple | OBJECT(machine) | "pic" | board init(); primary intc
hw/arm/musicpal.c:1245 | sysbus_create_varargs | OBJECT(machine) | "pit" | board init(); MV88W8618 timer block
hw/arm/musicpal.c:1252 | qdev_new | OBJECT(machine) | "uart-orgate" | board init(); OR-IRQ combiner
hw/arm/musicpal.c:1290 | sysbus_create_simple | OBJECT(machine) | "flashcfg" | board init(); flash config regs
hw/arm/musicpal.c:1292 | qdev_new | OBJECT(machine) | "eth" | board init(); on-chip ethernet
hw/arm/musicpal.c:1301 | sysbus_create_simple | OBJECT(machine) | "wlan" | board init(); WLAN stub
hw/arm/musicpal.c:1303 | sysbus_create_simple | OBJECT(machine) | "misc" | board init(); misc regs
hw/arm/musicpal.c:1305 | sysbus_create_simple | OBJECT(machine) | "gpio" | board init(); GPIO block
hw/arm/musicpal.c:1307 | sysbus_create_simple | OBJECT(machine) | "i2c" | board init(); bit-bang GPIO I2C
hw/arm/musicpal.c:1310 | sysbus_create_simple | OBJECT(machine) | "lcd" | board init(); front-panel LCD
hw/arm/musicpal.c:1311 | sysbus_create_simple | OBJECT(machine) | "keys" | board init(); front-panel buttons
hw/arm/musicpal.c:1331 | i2c_slave_new | OBJECT(machine) | "wm8750" | board init(); audio codec on I2C bus
hw/arm/musicpal.c:1337 | qdev_new | OBJECT(machine) | "audio" | board init(); audio DMA controller
hw/arm/stellaris.c:1099 | qdev_new | soc_container | "sys" | collapse existing add_child; keep name
hw/arm/stellaris.c:1126 | qdev_new | soc_container | "v7m" | collapse existing add_child; keep name
hw/arm/stellaris.c:1146 | sysbus_create_varargs | soc_container | "adc" | board init(); on-SoC ADC
hw/arm/stellaris.c:1160 | qdev_new | soc_container | "gptm[*]" | collapse existing add_child; keep name
hw/arm/stellaris.c:1175 | qdev_new | soc_container | "wdg" | collapse existing add_child; keep name
hw/arm/stellaris.c:1192 | sysbus_create_simple | soc_container | "gpio[*]" | board init(); loop over PL061 ports
hw/arm/stellaris.c:1204 | sysbus_create_simple | soc_container | "i2c[*]" | board init(); loop over I2C blocks
hw/arm/stellaris.c:1212 | i2c_slave_create_simple | OBJECT(ms) | "oled-i2c" | board init(); external I2C OLED panel
hw/arm/stellaris.c:1219 | qdev_new | soc_container | "uart[*]" | collapse existing add_child; keep name
hw/arm/stellaris.c:1229 | sysbus_create_simple | soc_container | "ssi" | board init(); PL022 SPI
hw/arm/stellaris.c:1303 | ssi_create_peripheral | OBJECT(ms) | "ssi-sd" | board init(); external SD adapter on SSI bus
hw/arm/stellaris.c:1307 | qdev_new | OBJECT(ms) | "sd-card" | board init(); removable SD card
hw/arm/stellaris.c:1313 | qdev_new | OBJECT(ms) | "oled" | collapse existing add_child; keep name
hw/arm/stellaris.c:1318 | qdev_new | OBJECT(ms) | "splitter" | collapse existing add_child; keep name
hw/arm/stellaris.c:1340 | qdev_new | soc_container | "enet" | collapse existing add_child; keep name
hw/arm/stellaris.c:1360 | qdev_new | OBJECT(ms) | "gamepad" | collapse existing add_child; keep name

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/musicpal.c  | 41 ++++++++++++++++------------
 hw/arm/stellaris.c | 68 ++++++++++++++++++++--------------------------
 2 files changed, 53 insertions(+), 56 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index d9fe08d57b..86ea348d3d 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1232,7 +1232,7 @@ static void musicpal_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    cpu = ARM_CPU(cpu_create_orphan(machine->cpu_type));
+    cpu = ARM_CPU(cpu_create(OBJECT(machine), "cpu", machine->cpu_type));
 
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
@@ -1240,18 +1240,20 @@ static void musicpal_init(MachineState *machine)
                            &error_fatal);
     memory_region_add_subregion(address_space_mem, MP_SRAM_BASE, sram);
 
-    pic = sysbus_create_simple_orphan(TYPE_MV88W8618_PIC, MP_PIC_BASE,
+    pic = sysbus_create_simple(OBJECT(machine), "pic",
+                               TYPE_MV88W8618_PIC, MP_PIC_BASE,
                                qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
-    sysbus_create_varargs_orphan(TYPE_MV88W8618_PIT, MP_PIT_BASE,
+    sysbus_create_varargs(OBJECT(machine), "pit",
+                          TYPE_MV88W8618_PIT, MP_PIT_BASE,
                           qdev_get_gpio_in(pic, MP_TIMER1_IRQ),
                           qdev_get_gpio_in(pic, MP_TIMER2_IRQ),
                           qdev_get_gpio_in(pic, MP_TIMER3_IRQ),
                           qdev_get_gpio_in(pic, MP_TIMER4_IRQ), NULL);
 
     /* Logically OR both UART IRQs together */
-    uart_orgate = qdev_new_orphan(TYPE_OR_IRQ);
+    uart_orgate = qdev_new(OBJECT(machine), "uart-orgate", TYPE_OR_IRQ);
     object_property_set_int(OBJECT(uart_orgate), "num-lines", 2, &error_fatal);
-    qdev_realize_and_unref(uart_orgate, NULL, &error_fatal);
+    qdev_realize(uart_orgate, NULL, &error_fatal);
     qdev_connect_gpio_out(uart_orgate, 0,
                           qdev_get_gpio_in(pic, MP_UART_SHARED_IRQ));
 
@@ -1287,28 +1289,31 @@ static void musicpal_init(MachineState *machine)
                               2, 0x00BF, 0x236D, 0x0000, 0x0000,
                               0x5555, 0x2AAA, 0);
     }
-    sysbus_create_simple_orphan(TYPE_MV88W8618_FLASHCFG, MP_FLASHCFG_BASE, NULL);
+    sysbus_create_simple(OBJECT(machine), "flashcfg",
+                         TYPE_MV88W8618_FLASHCFG, MP_FLASHCFG_BASE, NULL);
 
-    dev = qdev_new_orphan(TYPE_MV88W8618_ETH);
+    dev = qdev_new(OBJECT(machine), "eth", TYPE_MV88W8618_ETH);
     qemu_configure_nic_device(dev, true, "mv88w8618");
     object_property_set_link(OBJECT(dev), "dma-memory",
                              OBJECT(get_system_memory()), &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, MP_ETH_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(pic, MP_ETH_IRQ));
 
-    sysbus_create_simple_orphan("mv88w8618_wlan", MP_WLAN_BASE, NULL);
+    sysbus_create_simple(OBJECT(machine), "wlan", "mv88w8618_wlan", MP_WLAN_BASE, NULL);
 
-    sysbus_create_simple_orphan(TYPE_MUSICPAL_MISC, MP_MISC_BASE, NULL);
+    sysbus_create_simple(OBJECT(machine), "misc", TYPE_MUSICPAL_MISC, MP_MISC_BASE, NULL);
 
-    dev = sysbus_create_simple_orphan(TYPE_MUSICPAL_GPIO, MP_GPIO_BASE,
+    dev = sysbus_create_simple(OBJECT(machine), "gpio",
+                               TYPE_MUSICPAL_GPIO, MP_GPIO_BASE,
                                qdev_get_gpio_in(pic, MP_GPIO_IRQ));
-    i2c_dev = sysbus_create_simple_orphan(TYPE_GPIO_I2C, -1, NULL);
+    i2c_dev = sysbus_create_simple(OBJECT(machine), "i2c", TYPE_GPIO_I2C, -1, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(i2c_dev, "i2c");
 
-    lcd_dev = sysbus_create_simple_orphan(TYPE_MUSICPAL_LCD, MP_LCD_BASE, NULL);
-    key_dev = sysbus_create_simple_orphan(TYPE_MUSICPAL_KEY, -1, NULL);
+    lcd_dev = sysbus_create_simple(OBJECT(machine), "lcd",
+                                   TYPE_MUSICPAL_LCD, MP_LCD_BASE, NULL);
+    key_dev = sysbus_create_simple(OBJECT(machine), "keys", TYPE_MUSICPAL_KEY, -1, NULL);
 
     /* I2C read data */
     qdev_connect_gpio_out(i2c_dev, 0,
@@ -1328,17 +1333,17 @@ static void musicpal_init(MachineState *machine)
         qdev_connect_gpio_out(key_dev, i, qdev_get_gpio_in(dev, i + 15));
     }
 
-    wm8750_dev = i2c_slave_new_orphan(TYPE_WM8750, MP_WM_ADDR);
+    wm8750_dev = i2c_slave_new(OBJECT(machine), "wm8750", TYPE_WM8750, MP_WM_ADDR);
     if (machine->audiodev) {
         qdev_prop_set_string(DEVICE(wm8750_dev), "audiodev", machine->audiodev);
     }
-    i2c_slave_realize_and_unref(wm8750_dev, i2c, &error_abort);
+    qdev_realize(DEVICE(wm8750_dev), BUS(i2c), &error_abort);
 
-    dev = qdev_new_orphan(TYPE_MV88W8618_AUDIO);
+    dev = qdev_new(OBJECT(machine), "audio", TYPE_MV88W8618_AUDIO);
     s = SYS_BUS_DEVICE(dev);
     object_property_set_link(OBJECT(dev), "wm8750", OBJECT(wm8750_dev),
                              NULL);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(pic, MP_AUDIO_IRQ));
 
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 7a18d98477..b2ff6f4d97 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1096,8 +1096,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      * Create the system-registers object early, because we will
      * need its sysclk output.
      */
-    ssys_dev = qdev_new_orphan(TYPE_STELLARIS_SYS);
-    object_property_add_child(soc_container, "sys", OBJECT(ssys_dev));
+    ssys_dev = qdev_new(soc_container, "sys", TYPE_STELLARIS_SYS);
 
     /*
      * Most devices come preprogrammed with a MAC address in the user data.
@@ -1121,10 +1120,9 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     qdev_prop_set_uint32(ssys_dev, "dc2", board->dc2);
     qdev_prop_set_uint32(ssys_dev, "dc3", board->dc3);
     qdev_prop_set_uint32(ssys_dev, "dc4", board->dc4);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(ssys_dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(ssys_dev), &error_fatal);
 
-    armv7m = qdev_new_orphan(TYPE_ARMV7M);
-    object_property_add_child(soc_container, "v7m", OBJECT(armv7m));
+    armv7m = qdev_new(soc_container, "v7m", TYPE_ARMV7M);
     qdev_prop_set_uint32(armv7m, "num-irq", NUM_IRQ_LINES);
     qdev_prop_set_uint8(armv7m, "num-prio-bits", NUM_PRIO_BITS);
     qdev_prop_set_string(armv7m, "cpu-type", ms->cpu_type);
@@ -1135,7 +1133,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     object_property_set_link(OBJECT(armv7m), "memory",
                              OBJECT(get_system_memory()), &error_abort);
     /* This will exit with an error if the user passed us a bad cpu_type */
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(armv7m), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(armv7m), &error_fatal);
     nvic = armv7m;
 
     /* Now we can wire up the IRQ and MMIO of the system registers */
@@ -1143,7 +1141,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     sysbus_connect_irq(SYS_BUS_DEVICE(ssys_dev), 0, qdev_get_gpio_in(nvic, 28));
 
     if (DEV_CAP(1, ADC)) {
-        dev = sysbus_create_varargs_orphan(TYPE_STELLARIS_ADC, 0x40038000,
+        dev = sysbus_create_varargs(soc_container, "adc",
+                                    TYPE_STELLARIS_ADC, 0x40038000,
                                     qdev_get_gpio_in(nvic, 14),
                                     qdev_get_gpio_in(nvic, 15),
                                     qdev_get_gpio_in(nvic, 16),
@@ -1157,12 +1156,11 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         if (DEV_CAP(2, GPTM(i))) {
             SysBusDevice *sbd;
 
-            dev = qdev_new_orphan(TYPE_STELLARIS_GPTM);
+            dev = qdev_new(soc_container, "gptm[*]", TYPE_STELLARIS_GPTM);
             sbd = SYS_BUS_DEVICE(dev);
-            object_property_add_child(soc_container, "gptm[*]", OBJECT(dev));
             qdev_connect_clock_in(dev, "clk",
                                   qdev_get_clock_out(ssys_dev, "SYSCLK"));
-            sysbus_realize_and_unref(sbd, &error_fatal);
+            sysbus_realize(sbd, &error_fatal);
             sysbus_mmio_map(sbd, 0, 0x40030000 + i * 0x1000);
             sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(nvic, timer_irq[i]));
             /* TODO: This is incorrect, but we get away with it because
@@ -1172,12 +1170,11 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     }
 
     if (DEV_CAP(1, WDT)) {
-        dev = qdev_new_orphan(TYPE_LUMINARY_WATCHDOG);
-        object_property_add_child(soc_container, "wdg", OBJECT(dev));
+        dev = qdev_new(soc_container, "wdg", TYPE_LUMINARY_WATCHDOG);
         qdev_connect_clock_in(dev, "WDOGCLK",
                               qdev_get_clock_out(ssys_dev, "SYSCLK"));
 
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev),
                         0,
                         0x40000000u);
@@ -1189,7 +1186,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
     for (i = 0; i < NUM_GPIO; i++) {
         if (DEV_CAP(4, GPIO(i))) {
-            gpio_dev[i] = sysbus_create_simple_orphan("pl061_luminary", gpio_addr[i],
+            gpio_dev[i] = sysbus_create_simple(soc_container, "gpio[*]",
+                                               "pl061_luminary", gpio_addr[i],
                                                qdev_get_gpio_in(nvic,
                                                                 gpio_irq[i]));
             for (j = 0; j < 8; j++) {
@@ -1201,7 +1199,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
     for (i = 0; i < NUM_I2C; i++) {
         if (DEV_CAP(2, I2C(i))) {
-            i2c_dev[i] = sysbus_create_simple_orphan(TYPE_STELLARIS_I2C, i2c_addr[i],
+            i2c_dev[i] = sysbus_create_simple(soc_container, "i2c[*]",
+                                              TYPE_STELLARIS_I2C, i2c_addr[i],
                                               qdev_get_gpio_in(nvic,
                                                                i2c_irq[i]));
         }
@@ -1209,24 +1208,23 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     if (board->peripherals & BP_OLED_I2C) {
         I2CBus *bus = (I2CBus *)qdev_get_child_bus(i2c_dev[0], "i2c");
 
-        i2c_slave_create_simple_orphan(bus, "ssd0303", 0x3d);
+        i2c_slave_create_simple(OBJECT(ms), "oled-i2c", bus, "ssd0303", 0x3d);
     }
 
     for (i = 0; i < NUM_UART; i++) {
         if (DEV_CAP(2, UART(i))) {
             SysBusDevice *sbd;
 
-            dev = qdev_new_orphan("pl011_luminary");
-            object_property_add_child(soc_container, "uart[*]", OBJECT(dev));
+            dev = qdev_new(soc_container, "uart[*]", "pl011_luminary");
             sbd = SYS_BUS_DEVICE(dev);
             qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-            sysbus_realize_and_unref(sbd, &error_fatal);
+            sysbus_realize(sbd, &error_fatal);
             sysbus_mmio_map(sbd, 0, 0x4000c000 + i * 0x1000);
             sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(nvic, uart_irq[i]));
         }
     }
     if (DEV_CAP(2, SSI)) {
-        dev = sysbus_create_simple_orphan("pl022", 0x40008000,
+        dev = sysbus_create_simple(soc_container, "ssi", "pl022", 0x40008000,
                                    qdev_get_gpio_in(nvic, 7));
         if (board->peripherals & BP_OLED_SSI) {
             void *bus;
@@ -1300,26 +1298,22 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
              *  - Make the ssd0323 OLED controller chipselect active-low
              */
             bus = qdev_get_child_bus(dev, "ssi");
-            sddev = ssi_create_peripheral_orphan(bus, "ssi-sd");
+            sddev = ssi_create_peripheral(OBJECT(ms), "ssi-sd", bus, "ssi-sd");
 
             dinfo = drive_get(IF_SD, 0, 0);
             blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
-            carddev = qdev_new_orphan(TYPE_SD_CARD_SPI);
+            carddev = qdev_new(OBJECT(ms), "sd-card", TYPE_SD_CARD_SPI);
             qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-            qdev_realize_and_unref(carddev,
-                                   qdev_get_child_bus(sddev, "sd-bus"),
-                                   &error_fatal);
+            qdev_realize(carddev, qdev_get_child_bus(sddev, "sd-bus"),
+                         &error_fatal);
 
-            ssddev = qdev_new_orphan("ssd0323");
-            object_property_add_child(OBJECT(ms), "oled", OBJECT(ssddev));
+            ssddev = qdev_new(OBJECT(ms), "oled", "ssd0323");
             qdev_prop_set_uint8(ssddev, "cs", 1);
-            qdev_realize_and_unref(ssddev, bus, &error_fatal);
+            qdev_realize(ssddev, bus, &error_fatal);
 
-            gpio_d_splitter = qdev_new_orphan(TYPE_SPLIT_IRQ);
-            object_property_add_child(OBJECT(ms), "splitter",
-                                      OBJECT(gpio_d_splitter));
+            gpio_d_splitter = qdev_new(OBJECT(ms), "splitter", TYPE_SPLIT_IRQ);
             qdev_prop_set_uint32(gpio_d_splitter, "num-lines", 2);
-            qdev_realize_and_unref(gpio_d_splitter, NULL, &error_fatal);
+            qdev_realize(gpio_d_splitter, NULL, &error_fatal);
             qdev_connect_gpio_out(
                     gpio_d_splitter, 0,
                     qdev_get_gpio_in_named(sddev, SSI_GPIO_CS, 0));
@@ -1337,15 +1331,14 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     if (DEV_CAP(4, EMAC)) {
         DeviceState *enet;
 
-        enet = qdev_new_orphan("stellaris_enet");
-        object_property_add_child(soc_container, "enet", OBJECT(enet));
+        enet = qdev_new(soc_container, "enet", "stellaris_enet");
         if (nd) {
             qdev_set_nic_properties(enet, nd);
         } else {
             qdev_prop_set_macaddr(enet, "mac", mac.a);
         }
 
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(enet), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(enet), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(enet), 0, 0x40048000);
         sysbus_connect_irq(SYS_BUS_DEVICE(enet), 0, qdev_get_gpio_in(nvic, 42));
     }
@@ -1357,13 +1350,12 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         };
         DeviceState *gpad;
 
-        gpad = qdev_new_orphan(TYPE_STELLARIS_GAMEPAD);
-        object_property_add_child(OBJECT(ms), "gamepad", OBJECT(gpad));
+        gpad = qdev_new(OBJECT(ms), "gamepad", TYPE_STELLARIS_GAMEPAD);
         for (i = 0; i < ARRAY_SIZE(gpad_keycode); i++) {
             qlist_append_int(gpad_keycode_list, gpad_keycode[i]);
         }
         qdev_prop_set_array(gpad, "keycodes", gpad_keycode_list);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(gpad), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(gpad), &error_fatal);
 
         qdev_connect_gpio_out(gpad, 0,
                               qemu_irq_invert(gpio_in[GPIO_E][0])); /* up */
-- 
2.47.1


