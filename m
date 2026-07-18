Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9797AC4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD1h-00075s-6z; Sat, 18 Jul 2026 17:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD1c-0006zL-Fq; Sat, 18 Jul 2026 17:56:50 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD1a-0004gW-77; Sat, 18 Jul 2026 17:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411806; x=1815947806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RFej6oM5oC0mWz/9aAFhqnduo5g5BPd0goE2ENrwDhw=;
 b=BcMYhY02X6wQt5YtqAGSjTQtINg6epOECEnCAdYz0kgzEgKoT4gYZ7FK
 /fnPseDMSnLTCLJvYZOVl+GjSqrZwxuzYbJFwk6g8L8UuaU2FoJFZlzQA
 nYqaoNAMZRu3TgdMTT9Birt4gYs77hrnuixecrUPl1X9cYE567ivn5wS0
 3Di0rnARCpfEwXMK6JJCM+Eh1PEiodqLHh/YcKq8g82Uv5bWvZrpu+gUA
 lNR6UVc2XagJsWHG51FfPaw551U911R/vA3Otv8Kx5lVwmoR9Qy5Z2HfF
 dcolaQsHxkKp/OPq/biU9Ius6Iw295pkMTtQIdl9LYCpK54xSMAK29XGE g==;
X-CSE-ConnectionGUID: Yd1Fo18WR8CT0PcWW/Mn4g==
X-CSE-MsgGUID: tY5ZVIapTiSRTWDh1BouVw==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23423091"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:56:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:28296]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.230:2525]
 with esmtp (Farcaster)
 id 92c5bffa-22eb-4b6f-b051-332befbf2bff; Sat, 18 Jul 2026 21:56:42 +0000 (UTC)
X-Farcaster-Flow-ID: 92c5bffa-22eb-4b6f-b051-332befbf2bff
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:56:42 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:56:32 +0000
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
Subject: [RFC PATCH v2 071/137] hw/arm/misc: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:46 +0000
Message-ID: <20260718213652.37673-72-graf@amazon.com>
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
Received-SPF: pass client-ip=44.245.243.92;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in the hw/arm misc
board files to the new parented API introduced earlier in this
series, so every onboard device gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/max78000fthr.c:29 | qdev_new_orphan | OBJECT(machine) | "soc" | board init; existing add_child(machine,"soc") collapsed; drop _and_unref
hw/arm/msf2-som.c:62 | qdev_new_orphan | OBJECT(machine) | "soc" | board init; existing add_child(machine,"soc") collapsed; drop _and_unref
hw/arm/msf2-som.c:86 | qdev_new_orphan | OBJECT(machine) | "spi-flash" | board init; single m25p80 flash on SPI bus; drop _and_unref
hw/arm/netduino2.c:47 | qdev_new_orphan | OBJECT(machine) | "soc" | board init; existing add_child(machine,"soc") collapsed; drop _and_unref
hw/arm/netduinoplus2.c:47 | qdev_new_orphan | OBJECT(machine) | "soc" | board init; existing add_child(machine,"soc") collapsed; drop _and_unref
hw/arm/olimex-stm32-h405.c:50 | qdev_new_orphan | OBJECT(machine) | "soc" | board init; existing add_child(machine,"soc") collapsed; drop _and_unref
hw/arm/raspi.c:286 | qdev_new_orphan | OBJECT(machine) | "sd-card" | raspi_base_machine_init(MachineState *machine); single SD card; drop _and_unref
hw/arm/stm32vldiscovery.c:50 | qdev_new_orphan | OBJECT(machine) | "soc" | board init; existing add_child(machine,"soc") collapsed; drop _and_unref

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/max78000fthr.c      |  5 ++---
 hw/arm/msf2-som.c          | 10 +++++-----
 hw/arm/netduino2.c         |  5 ++---
 hw/arm/netduinoplus2.c     |  5 ++---
 hw/arm/olimex-stm32-h405.c |  5 ++---
 hw/arm/raspi.c             |  4 ++--
 hw/arm/stm32vldiscovery.c  |  5 ++---
 7 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index d2fb4c018b..e38a3340a4 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -26,10 +26,9 @@ static void max78000_init(MachineState *machine)
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
-    dev = qdev_new_orphan(TYPE_MAX78000_SOC);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
+    dev = qdev_new(OBJECT(machine), "soc", TYPE_MAX78000_SOC);
     qdev_connect_clock_in(dev, "sysclk", sysclk);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     armv7m_load_kernel(ARM_CPU(first_cpu),
                        machine->kernel_filename,
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index bb1e774764..0d0e2514dd 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -59,8 +59,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
                            &error_fatal);
     memory_region_add_subregion(sysmem, DDR_BASE_ADDRESS, ddr);
 
-    dev = qdev_new_orphan(TYPE_MSF2_SOC);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
+    dev = qdev_new(OBJECT(machine), "soc", TYPE_MSF2_SOC);
     qdev_prop_set_string(dev, "part-name", "M2S010");
     qdev_prop_set_uint64(dev, "eNVM-size", M2S010_ENVM_SIZE);
     qdev_prop_set_uint64(dev, "eSRAM-size", M2S010_ESRAM_SIZE);
@@ -77,19 +76,20 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "apb0div", 2);
     qdev_prop_set_uint32(dev, "apb1div", 2);
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     soc = MSF2_SOC(dev);
 
     /* Attach SPI flash to SPI0 controller */
     spi_bus = qdev_get_child_bus(dev, "spi0");
-    spi_flash = qdev_new_orphan("s25sl12801"); /* Spansion S25FL128SDPBHICO */
+    /* Spansion S25FL128SDPBHICO */
+    spi_flash = qdev_new(OBJECT(machine), "spi-flash", "s25sl12801");
     qdev_prop_set_uint8(spi_flash, "spansion-cr2nv", 0x8);
     if (dinfo) {
         qdev_prop_set_drive_err(spi_flash, "drive",
                                 blk_by_legacy_dinfo(dinfo), &error_fatal);
     }
-    qdev_realize_and_unref(spi_flash, spi_bus, &error_fatal);
+    qdev_realize(spi_flash, spi_bus, &error_fatal);
     cs_line = qdev_get_gpio_in_named(spi_flash, SSI_GPIO_CS, 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&soc->spi[0]), 1, cs_line);
 
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index cee887c194..9a1caf06a1 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -44,10 +44,9 @@ static void netduino2_init(MachineState *machine)
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
-    dev = qdev_new_orphan(TYPE_STM32F205_SOC);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
+    dev = qdev_new(OBJECT(machine), "soc", TYPE_STM32F205_SOC);
     qdev_connect_clock_in(dev, "sysclk", sysclk);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     armv7m_load_kernel(STM32F205_SOC(dev)->armv7m.cpu, machine->kernel_filename,
                        0, FLASH_SIZE);
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 65251dfe96..564dae1f16 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -44,10 +44,9 @@ static void netduinoplus2_init(MachineState *machine)
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
-    dev = qdev_new_orphan(TYPE_STM32F405_SOC);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
+    dev = qdev_new(OBJECT(machine), "soc", TYPE_STM32F405_SOC);
     qdev_connect_clock_in(dev, "sysclk", sysclk);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     armv7m_load_kernel(STM32F405_SOC(dev)->armv7m.cpu,
                        machine->kernel_filename,
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 70f7791695..b24142e909 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -47,10 +47,9 @@ static void olimex_stm32_h405_init(MachineState *machine)
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
-    dev = qdev_new_orphan(TYPE_STM32F405_SOC);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
+    dev = qdev_new(OBJECT(machine), "soc", TYPE_STM32F405_SOC);
     qdev_connect_clock_in(dev, "sysclk", sysclk);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     armv7m_load_kernel(STM32F405_SOC(dev)->armv7m.cpu,
                        machine->kernel_filename,
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 2d5f51506d..55ca84cd1d 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -283,9 +283,9 @@ void raspi_base_machine_init(MachineState *machine,
         error_report("No SD bus found in SOC object");
         exit(1);
     }
-    carddev = qdev_new_orphan(TYPE_SD_CARD);
+    carddev = qdev_new(OBJECT(machine), "sd-card", TYPE_SD_CARD);
     qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-    qdev_realize_and_unref(carddev, bus, &error_fatal);
+    qdev_realize(carddev, bus, &error_fatal);
 
     vcram_size = object_property_get_uint(OBJECT(soc), "vcram-size",
                                           &error_abort);
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 8c37d41e63..69503805cb 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -47,10 +47,9 @@ static void stm32vldiscovery_init(MachineState *machine)
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
-    dev = qdev_new_orphan(TYPE_STM32F100_SOC);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
+    dev = qdev_new(OBJECT(machine), "soc", TYPE_STM32F100_SOC);
     qdev_connect_clock_in(dev, "sysclk", sysclk);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     armv7m_load_kernel(STM32F100_SOC(dev)->armv7m.cpu,
                        machine->kernel_filename,
-- 
2.47.1


