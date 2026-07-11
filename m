Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D965C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigaR-0005DH-Tj; Sat, 11 Jul 2026 18:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigaQ-0005C7-EY; Sat, 11 Jul 2026 18:54:18 -0400
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.34.181.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigaN-0000Th-51; Sat, 11 Jul 2026 18:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810455; x=1815346455;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iIPM+ob7e8V7G3dwYLSqkCDf+GYvnGAV46cu17rqTLY=;
 b=MKffReoQ2UNTf17VHlOzq+ZbhU25fegWmYb7EAg9NXqIa386EoXqgFU1
 fxlgaWlQc6Ov4Y9QMxEf4jCiPXeww6vNvvh21UMg9UDZsBrjyMA2g7X1w
 NA4fa+0543K8MONBBY+5L4RaSKuR0jKVSGoHd1ORcWawjopJf550lxT0x
 l7S4AagVjvBCFyrj/56t3dGkxl2IGTSbnfEeVT4YvJKnqsC1+RHqOw8Zo
 l/V7el94GIvhCiIwPHzyDa0H4+YcXHi802HS778Vu0WHApZSgG3cycmc8
 5DmPB/zJYH4zLz0mI5Og09jXJTU4neNLJkqD9V+JXocsFVwrURk8msXmT A==;
X-CSE-ConnectionGUID: ezwu5teCQYS8wfa/Pt2Mvg==
X-CSE-MsgGUID: 97a7/2N2TCGvgs/XfyqolQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23483473"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:54:11 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:25300]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.212:2525]
 with esmtp (Farcaster)
 id bf76de13-6d7a-4fd2-b7eb-d92baa2bb100; Sat, 11 Jul 2026 22:54:10 +0000 (UTC)
X-Farcaster-Flow-ID: bf76de13-6d7a-4fd2-b7eb-d92baa2bb100
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:54:10 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:54:02 +0000
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
Subject: [RFC PATCH 065/134] hw/arm/allwinner: Give onboard devices a QOM
 parent
Date: Sat, 11 Jul 2026 22:35:58 +0000
Message-ID: <20260711223707.42139-66-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.34.181.151;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in the hw/arm allwinner
board files to the new parented API introduced earlier in this
series, so every onboard device gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/allwinner-h3.c:382 | sysbus_create_simple | OBJECT(s) | "ehci[*]" | allwinner_h3_realize() SoC realize; 4 instances, auto-index.
hw/arm/allwinner-h3.c:385 | sysbus_create_simple | OBJECT(s) | "ehci[*]" | SoC realize; auto-index.
hw/arm/allwinner-h3.c:388 | sysbus_create_simple | OBJECT(s) | "ehci[*]" | SoC realize; auto-index.
hw/arm/allwinner-h3.c:391 | sysbus_create_simple | OBJECT(s) | "ehci[*]" | SoC realize; auto-index.
hw/arm/allwinner-h3.c:395 | sysbus_create_simple | OBJECT(s) | "ohci[*]" | SoC realize; 4 instances, auto-index.
hw/arm/allwinner-h3.c:398 | sysbus_create_simple | OBJECT(s) | "ohci[*]" | SoC realize; auto-index.
hw/arm/allwinner-h3.c:401 | sysbus_create_simple | OBJECT(s) | "ohci[*]" | SoC realize; auto-index.
hw/arm/allwinner-h3.c:404 | sysbus_create_simple | OBJECT(s) | "ohci[*]" | SoC realize; auto-index.
hw/arm/bananapi_m2u.c:53 | qdev_new | OBJECT(s) | "sd-card[*]" | mmc_attach_drive() helper receives AwR40State *s (SoC, itself child of machine); use it as parent. Multiple units -> auto-index. Paired qdev_realize_and_unref -> qdev_realize.
hw/arm/bananapi_m2u.c:117 | i2c_slave_create_simple | OBJECT(machine) | "axp221" | Board init(); PMU is board-level peripheral on i2c bus.
hw/arm/cubieboard.c:84 | i2c_slave_create_simple | OBJECT(machine) | "axp209" | Board init(); PMU is board-level peripheral.
hw/arm/cubieboard.c:92 | qdev_new | OBJECT(machine) | "sd-card" | Board init(); single SD card. Paired qdev_realize_and_unref -> qdev_realize.
hw/arm/orangepi.c:88 | qdev_new | OBJECT(machine) | "sd-card" | Board init(); single SD card. Paired qdev_realize_and_unref -> qdev_realize.

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/allwinner-h3.c | 24 ++++++++++++++++--------
 hw/arm/bananapi_m2u.c |  6 +++---
 hw/arm/cubieboard.c   |  6 +++---
 hw/arm/orangepi.c     |  4 ++--
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index ce716d1687..6f9a07610f 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -379,29 +379,37 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_EMAC));
 
     /* Universal Serial Bus */
-    sysbus_create_simple_orphan(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI0],
+    sysbus_create_simple(OBJECT(s), "ehci[*]", TYPE_AW_H3_EHCI,
+                         s->memmap[AW_H3_DEV_EHCI0],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_EHCI0));
-    sysbus_create_simple_orphan(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI1],
+    sysbus_create_simple(OBJECT(s), "ehci[*]", TYPE_AW_H3_EHCI,
+                         s->memmap[AW_H3_DEV_EHCI1],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_EHCI1));
-    sysbus_create_simple_orphan(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI2],
+    sysbus_create_simple(OBJECT(s), "ehci[*]", TYPE_AW_H3_EHCI,
+                         s->memmap[AW_H3_DEV_EHCI2],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_EHCI2));
-    sysbus_create_simple_orphan(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI3],
+    sysbus_create_simple(OBJECT(s), "ehci[*]", TYPE_AW_H3_EHCI,
+                         s->memmap[AW_H3_DEV_EHCI3],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_EHCI3));
 
-    sysbus_create_simple_orphan("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI0],
+    sysbus_create_simple(OBJECT(s), "ohci[*]", "sysbus-ohci",
+                         s->memmap[AW_H3_DEV_OHCI0],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI0));
-    sysbus_create_simple_orphan("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI1],
+    sysbus_create_simple(OBJECT(s), "ohci[*]", "sysbus-ohci",
+                         s->memmap[AW_H3_DEV_OHCI1],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI1));
-    sysbus_create_simple_orphan("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI2],
+    sysbus_create_simple(OBJECT(s), "ohci[*]", "sysbus-ohci",
+                         s->memmap[AW_H3_DEV_OHCI2],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI2));
-    sysbus_create_simple_orphan("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI3],
+    sysbus_create_simple(OBJECT(s), "ohci[*]", "sysbus-ohci",
+                         s->memmap[AW_H3_DEV_OHCI3],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI3));
 
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 809c8bbc43..ae2d8bd2f7 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -50,9 +50,9 @@ static void mmc_attach_drive(AwR40State *s, AwSdHostState *mmc, int unit,
         exit(1);
     }
 
-    carddev = qdev_new_orphan(TYPE_SD_CARD);
+    carddev = qdev_new(OBJECT(s), "sd-card[*]", TYPE_SD_CARD);
     qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-    qdev_realize_and_unref(carddev, bus, &error_fatal);
+    qdev_realize(carddev, bus, &error_fatal);
 
     if (load_bootroom && blk && blk_is_available(blk)) {
         /* Use Boot ROM to copy data from SD card to SRAM */
@@ -114,7 +114,7 @@ static void bpim2u_init(MachineState *machine)
 
     /* Connect AXP221 */
     i2c = I2C_BUS(qdev_get_child_bus(DEVICE(&r40->i2c0), "i2c"));
-    i2c_slave_create_simple_orphan(i2c, "axp221_pmu", 0x34);
+    i2c_slave_create_simple(OBJECT(machine), "axp221", i2c, "axp221_pmu", 0x34);
 
     /* SDRAM */
     memory_region_add_subregion(get_system_memory(),
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 7ce5179345..fa5eaa5378 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -81,7 +81,7 @@ static void cubieboard_init(MachineState *machine)
 
     /* Connect AXP 209 */
     i2c = I2C_BUS(qdev_get_child_bus(DEVICE(&a10->i2c0), "i2c"));
-    i2c_slave_create_simple_orphan(i2c, "axp209_pmu", 0x34);
+    i2c_slave_create_simple(OBJECT(machine), "axp209", i2c, "axp209_pmu", 0x34);
 
     /* Retrieve SD bus */
     di = drive_get(IF_SD, 0, 0);
@@ -89,9 +89,9 @@ static void cubieboard_init(MachineState *machine)
     bus = qdev_get_child_bus(DEVICE(a10), "sd-bus");
 
     /* Plug in SD card */
-    carddev = qdev_new_orphan(TYPE_SD_CARD);
+    carddev = qdev_new(OBJECT(machine), "sd-card", TYPE_SD_CARD);
     qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-    qdev_realize_and_unref(carddev, bus, &error_fatal);
+    qdev_realize(carddev, bus, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), AW_A10_SDRAM_BASE,
                                 machine->ram);
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index d705cc43b4..1a37c97eef 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -85,9 +85,9 @@ static void orangepi_init(MachineState *machine)
     bus = qdev_get_child_bus(DEVICE(h3), "sd-bus");
 
     /* Plug in SD card */
-    carddev = qdev_new_orphan(TYPE_SD_CARD);
+    carddev = qdev_new(OBJECT(machine), "sd-card", TYPE_SD_CARD);
     qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-    qdev_realize_and_unref(carddev, bus, &error_fatal);
+    qdev_realize(carddev, bus, &error_fatal);
 
     /* SDRAM */
     memory_region_add_subregion(get_system_memory(), h3->memmap[AW_H3_DEV_SDRAM],
-- 
2.47.1


