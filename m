Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6EDC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigOB-00067x-UJ; Sat, 11 Jul 2026 18:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigOA-000663-K9; Sat, 11 Jul 2026 18:41:38 -0400
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.12.53.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigO8-00060V-C6; Sat, 11 Jul 2026 18:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809696; x=1815345696;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qZLqcWFwyyuo1+YqN2tsQP0C3YqE8iqlsYVFe/D6JGY=;
 b=PwPT7KDpjwDjU9SJHzSx0E7jeEtMqbQX9hsCNy941TOyGysF1oNyuWQU
 6ImTQSK/UHxhuMO/SCTExjGUEHPQJOXt5khuSEYksF/TGHnTIH5fJRoQo
 PLcb7p4KY0wWZ6TBcMqHvumGGwevmDL7JSDGg/mcVTmRVO4f4UmGukpLW
 AfshVC9txAn5PiA0lROM47msKT0l893Zvf0Z5LaldbX/D5vNMKuFonrpG
 03fZ4MmocQE1QsU8EAJ40lVJjVb8ZJoNCG5cyXOaIOZHkm6o8WUQ0uS6n
 xiDMycZjmoO7+Gdr0XSPmYCVYd+MnwVuv6v6CtBzol9wTsxBCdX7c6y5i Q==;
X-CSE-ConnectionGUID: JsFsr1VpST+86DzooOXBiA==
X-CSE-MsgGUID: 3JKju3gKQOSXd6reQ7S0Wg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23369710"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:41:32 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:14607]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.33:2525]
 with esmtp (Farcaster)
 id 658abee9-6d46-49e6-a77c-01fad9bdae41; Sat, 11 Jul 2026 22:41:32 +0000 (UTC)
X-Farcaster-Flow-ID: 658abee9-6d46-49e6-a77c-01fad9bdae41
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:41:32 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:41:23 +0000
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
Subject: [RFC PATCH 017/134] hw/microblaze: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:10 +0000
Message-ID: <20260711223707.42139-18-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
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

Convert the *_orphan() device-creation calls in hw/microblaze to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

  hw/microblaze/petalogix_ml605_mmu.c:113 | OBJECT(machine) | "intc" | board init(); single XPS interrupt controller owned by machine
  hw/microblaze/petalogix_ml605_mmu.c:129 | OBJECT(machine) | "timer" | board init(); single XPS timer block owned by machine
  hw/microblaze/petalogix_ml605_mmu.c:138 | OBJECT(machine) | "xilinx-eth" | board init(); keep existing child name; drop now-redundant object_property_add_child()
  hw/microblaze/petalogix_ml605_mmu.c:139 | OBJECT(machine) | "xilinx-dma" | board init(); keep existing child name; drop now-redundant object_property_add_child()
  hw/microblaze/petalogix_ml605_mmu.c:177 | OBJECT(machine) | "spi" | board init(); single XPS SPI controller owned by machine
  hw/microblaze/petalogix_ml605_mmu.c:191 | OBJECT(machine) | "spi-flash[*]" | board init(); NUM_SPI_FLASHES instances in loop, auto-index; plugged onto SPI bus but lifetime-owned by machine
  hw/microblaze/petalogix_s3adsp1800_mmu.c:110 | OBJECT(machine) | "intc" | board init(); single XPS interrupt controller owned by machine
  hw/microblaze/petalogix_s3adsp1800_mmu.c:122 | OBJECT(machine) | "uart" | board init(); single Xilinx uartlite owned by machine
  hw/microblaze/petalogix_s3adsp1800_mmu.c:130 | OBJECT(machine) | "timer" | board init(); single XPS timer block owned by machine
  hw/microblaze/petalogix_s3adsp1800_mmu.c:138 | OBJECT(machine) | "eth" | board init(); single XPS ethernetlite owned by machine

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/microblaze/petalogix_ml605_mmu.c      | 28 ++++++++++--------------
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 16 +++++++-------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 178cfd4a5e..031de37cec 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -110,10 +110,10 @@ petalogix_ml605_init(MachineState *machine)
                           64 * KiB, 2, 0x89, 0x18, 0x0000, 0x0, 0);
 
 
-    dev = qdev_new_orphan("xlnx.xps-intc");
+    dev = qdev_new(OBJECT(machine), "intc", "xlnx.xps-intc");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "kind-of-intr", 1 << TIMER_IRQ);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(DEVICE(cpu), MB_CPU_IRQ));
@@ -126,21 +126,17 @@ petalogix_ml605_init(MachineState *machine)
                    DEVICE_LITTLE_ENDIAN);
 
     /* 2 timers at irq 2 @ 100 Mhz.  */
-    dev = qdev_new_orphan("xlnx.xps-timer");
+    dev = qdev_new(OBJECT(machine), "timer", "xlnx.xps-timer");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 100 * 1000000);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
     /* axi ethernet and dma initialization. */
-    eth0 = qdev_new_orphan("xlnx.axi-ethernet");
-    dma = qdev_new_orphan("xlnx.axi-dma");
-
-    /* FIXME: attach to the sysbus instead */
-    object_property_add_child(qdev_get_machine(), "xilinx-eth", OBJECT(eth0));
-    object_property_add_child(qdev_get_machine(), "xilinx-dma", OBJECT(dma));
+    eth0 = qdev_new(OBJECT(machine), "xilinx-eth", "xlnx.axi-ethernet");
+    dma = qdev_new(OBJECT(machine), "xilinx-dma", "xlnx.axi-dma");
 
     ds = object_property_get_link(OBJECT(dma),
                                   "axistream-connected-target", NULL);
@@ -153,7 +149,7 @@ petalogix_ml605_init(MachineState *machine)
                              &error_abort);
     object_property_set_link(OBJECT(eth0), "axistream-control-connected", cs,
                              &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(eth0), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(eth0), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(eth0), 0, AXIENET_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(eth0), 0, irq[AXIENET_IRQ]);
 
@@ -166,7 +162,7 @@ petalogix_ml605_init(MachineState *machine)
                              &error_abort);
     object_property_set_link(OBJECT(dma), "axistream-control-connected", cs,
                              &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dma), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, AXIDMA_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dma), 0, irq[AXIDMA_IRQ0]);
     sysbus_connect_irq(SYS_BUS_DEVICE(dma), 1, irq[AXIDMA_IRQ1]);
@@ -174,11 +170,11 @@ petalogix_ml605_init(MachineState *machine)
     {
         SSIBus *spi;
 
-        dev = qdev_new_orphan("xlnx.xps-spi");
+        dev = qdev_new(OBJECT(machine), "spi", "xlnx.xps-spi");
         qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
         qdev_prop_set_uint8(dev, "num-ss-bits", NUM_SPI_FLASHES);
         busdev = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(busdev, &error_fatal);
+        sysbus_realize(busdev, &error_fatal);
         sysbus_mmio_map(busdev, 0, SPI_BASEADDR);
         sysbus_connect_irq(busdev, 0, irq[SPI_IRQ]);
 
@@ -188,14 +184,14 @@ petalogix_ml605_init(MachineState *machine)
             dinfo = drive_get(IF_MTD, 0, i);
             qemu_irq cs_line;
 
-            dev = qdev_new_orphan("n25q128");
+            dev = qdev_new(OBJECT(machine), "spi-flash[*]", "n25q128");
             if (dinfo) {
                 qdev_prop_set_drive_err(dev, "drive",
                                         blk_by_legacy_dinfo(dinfo),
                                         &error_fatal);
             }
             qdev_prop_set_uint8(dev, "cs", i);
-            qdev_realize_and_unref(dev, BUS(spi), &error_fatal);
+            qdev_realize(dev, BUS(spi), &error_fatal);
 
             cs_line = qdev_get_gpio_in_named(dev, SSI_GPIO_CS, 0);
             sysbus_connect_irq(busdev, i+1, cs_line);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 91c1d64451..b4327ad493 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -107,11 +107,11 @@ petalogix_s3adsp1800_init(MachineState *machine)
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
 
-    dev = qdev_new_orphan("xlnx.xps-intc");
+    dev = qdev_new(OBJECT(machine), "intc", "xlnx.xps-intc");
     qdev_prop_set_enum(dev, "endianness", endianness);
     qdev_prop_set_uint32(dev, "kind-of-intr",
                          1 << ETHLITE_IRQ | 1 << UARTLITE_IRQ);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(DEVICE(cpu), MB_CPU_IRQ));
@@ -119,28 +119,28 @@ petalogix_s3adsp1800_init(MachineState *machine)
         irq[i] = qdev_get_gpio_in(dev, i);
     }
 
-    dev = qdev_new_orphan(TYPE_XILINX_UARTLITE);
+    dev = qdev_new(OBJECT(machine), "uart", TYPE_XILINX_UARTLITE);
     qdev_prop_set_enum(dev, "endianness", endianness);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, UARTLITE_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[UARTLITE_IRQ]);
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
-    dev = qdev_new_orphan("xlnx.xps-timer");
+    dev = qdev_new(OBJECT(machine), "timer", "xlnx.xps-timer");
     qdev_prop_set_enum(dev, "endianness", endianness);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
-    dev = qdev_new_orphan("xlnx.xps-ethernetlite");
+    dev = qdev_new(OBJECT(machine), "eth", "xlnx.xps-ethernetlite");
     qdev_prop_set_enum(dev, "endianness", endianness);
     qemu_configure_nic_device(dev, true, NULL);
     qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
     qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
 
-- 
2.47.1


