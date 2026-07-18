Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550C8C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD1O-0006lN-3f; Sat, 18 Jul 2026 17:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD1M-0006kx-1I; Sat, 18 Jul 2026 17:56:32 -0400
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([50.112.246.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD1H-0004fX-Q2; Sat, 18 Jul 2026 17:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411787; x=1815947787;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ryD4CYKSXv6OLvpmUHtpBkHhhYgwrqqNbJwAKFj2HhM=;
 b=GX46IRNYLI7B/b8HU4x1LlaHs5bsRphy0Og4yyzNlAbvhG+xiE7ZgXw0
 6LapMZx16Yq+wVkhfzxUQSXw5RwNYkjP+8uEBMdqbvVo+mPqAnAfineGO
 5CzDLwmbB99p8dS158uqNN8StWUUkLSpuCJ/tKtVNXg3Bq9/ULfkHLJaC
 RLcBk5bR08T1TqRa67inildRHo29R/WadfHjaMYdaHrS6Nyd0dl3vdRb+
 8k6vjAiK7It7CDZWJgILGVTSbukCSqz7eibxSZ5hsNNn1e0r+o9qiFjfn
 MCr5D9wJqvkya48hbIorN79iPtzXcdoVmyLDtbSMps+NbmR6KLZ6umljF g==;
X-CSE-ConnectionGUID: h/bIFewwTuOr0G2bBUaKXA==
X-CSE-MsgGUID: Eo++Umx3RJWFCJrSKr2SkA==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23725094"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:56:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:14107]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.246:2525]
 with esmtp (Farcaster)
 id 0427b51b-9d43-4a6b-a523-ca14d6c5c609; Sat, 18 Jul 2026 21:56:23 +0000 (UTC)
X-Farcaster-Flow-ID: 0427b51b-9d43-4a6b-a523-ca14d6c5c609
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:56:23 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:56:13 +0000
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
Subject: [RFC PATCH v2 069/137] hw/arm/mps2: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:44 +0000
Message-ID: <20260718213652.37673-70-graf@amazon.com>
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
Received-SPF: pass client-ip=50.112.246.219;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in the hw/arm mps2
board files to the new parented API introduced earlier in this
series, so every onboard device gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/mps2.c:302 | qdev_new_orphan | OBJECT(mms) | "uart[*]" | board init (mps2_common_init), MPS2MachineState *mms is machine; indexed loop; drop _and_unref
hw/arm/mps2.c:346 | qdev_new_orphan | OBJECT(mms) | "uart[*]" | board init, second FPGA variant loop; auto-index; drop _and_unref
hw/arm/mps2.c:419 | sysbus_create_simple_orphan | OBJECT(mms) | "spi[*]" | board init; PL022 external ADC; auto-index shared with loop below
hw/arm/mps2.c:438 | sysbus_create_simple_orphan | OBJECT(mms) | "spi[*]" | board init; PL022 in nested loop; auto-index
hw/arm/mps2.c:449 | sysbus_create_simple_orphan | OBJECT(mms) | "i2c[*]" | board init; SBCON I2C in loop; auto-index
hw/arm/mps2-tz.c:511 | qdev_new_orphan | OBJECT(mms) | "lan9118" | make_eth_dev helper receives MPS2TZMachineState *mms (board state); single instance; drop _and_unref
hw/arm/mps2-tz.c:538 | qdev_new_orphan | OBJECT(mms) | "lan9118" | make_eth_usb helper receives mms; single instance (mutually exclusive with make_eth_dev per board); drop _and_unref

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/mps2-tz.c |  8 ++++----
 hw/arm/mps2.c    | 18 ++++++++++--------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index c0ab898f2e..17945d2b71 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -508,11 +508,11 @@ static MemoryRegion *make_eth_dev(MPS2TZMachineState *mms, void *opaque,
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
      */
-    mms->lan9118 = qdev_new_orphan(TYPE_LAN9118);
+    mms->lan9118 = qdev_new(OBJECT(mms), "lan9118", TYPE_LAN9118);
     qemu_configure_nic_device(mms->lan9118, true, NULL);
 
     s = SYS_BUS_DEVICE(mms->lan9118);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_connect_irq(s, 0, get_sse_irq_in(mms, irqs[0]));
     return sysbus_mmio_get_region(s, 0);
 }
@@ -535,11 +535,11 @@ static MemoryRegion *make_eth_usb(MPS2TZMachineState *mms, void *opaque,
      * In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
      */
-    mms->lan9118 = qdev_new_orphan(TYPE_LAN9118);
+    mms->lan9118 = qdev_new(OBJECT(mms), "lan9118", TYPE_LAN9118);
     qemu_configure_nic_device(mms->lan9118, true, NULL);
 
     s = SYS_BUS_DEVICE(mms->lan9118);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_connect_irq(s, 0, get_sse_irq_in(mms, irqs[0]));
 
     memory_region_add_subregion(&mms->eth_usb_container,
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index e646c7c71e..2edd222674 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -299,11 +299,11 @@ static void mps2_common_init(MachineState *machine)
                 rxovrint = qdev_get_gpio_in(orgate_dev, i * 2 + 1);
             }
 
-            dev = qdev_new_orphan(TYPE_CMSDK_APB_UART);
+            dev = qdev_new(OBJECT(mms), "uart[*]", TYPE_CMSDK_APB_UART);
             s = SYS_BUS_DEVICE(dev);
             qdev_prop_set_chr(dev, "chardev", serial_hd(i));
             qdev_prop_set_uint32(dev, "pclk-frq", SYSCLK_FRQ);
-            sysbus_realize_and_unref(s, &error_fatal);
+            sysbus_realize(s, &error_fatal);
             sysbus_mmio_map(s, 0, uartbase[i]);
             sysbus_connect_irq(s, 0, qdev_get_gpio_in(armv7m, uartirq[i] + 1));
             sysbus_connect_irq(s, 1, qdev_get_gpio_in(armv7m, uartirq[i]));
@@ -343,11 +343,11 @@ static void mps2_common_init(MachineState *machine)
             qdev_connect_gpio_out(txrx_orgate_dev, 0,
                                   qdev_get_gpio_in(armv7m, uart_txrx_irqno[i]));
 
-            dev = qdev_new_orphan(TYPE_CMSDK_APB_UART);
+            dev = qdev_new(OBJECT(mms), "uart[*]", TYPE_CMSDK_APB_UART);
             s = SYS_BUS_DEVICE(dev);
             qdev_prop_set_chr(dev, "chardev", serial_hd(i));
             qdev_prop_set_uint32(dev, "pclk-frq", SYSCLK_FRQ);
-            sysbus_realize_and_unref(s, &error_fatal);
+            sysbus_realize(s, &error_fatal);
             sysbus_mmio_map(s, 0, uartbase[i]);
             sysbus_connect_irq(s, 0, qdev_get_gpio_in(txrx_orgate_dev, 0));
             sysbus_connect_irq(s, 1, qdev_get_gpio_in(txrx_orgate_dev, 1));
@@ -416,8 +416,8 @@ static void mps2_common_init(MachineState *machine)
     qdev_prop_set_uint32(DEVICE(&mms->fpgaio), "prescale-clk", 25000000);
     sysbus_realize(SYS_BUS_DEVICE(&mms->fpgaio), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->fpgaio), 0, 0x40028000);
-    sysbus_create_simple_orphan(TYPE_PL022, 0x40025000,        /* External ADC */
-                         qdev_get_gpio_in(armv7m, 22));
+    sysbus_create_simple(OBJECT(mms), "spi[*]", TYPE_PL022, 0x40025000,
+                         qdev_get_gpio_in(armv7m, 22)); /* External ADC */
     for (i = 0; i < 2; i++) {
         static const int spi_irqno[] = {11, 24};
         static const hwaddr spibase[] = {0x40020000,    /* APB */
@@ -435,7 +435,8 @@ static void mps2_common_init(MachineState *machine)
         qdev_connect_gpio_out(orgate_dev, 0,
                               qdev_get_gpio_in(armv7m, spi_irqno[i]));
         for (j = 0; j < 2; j++) {
-            sysbus_create_simple_orphan(TYPE_PL022, spibase[2 * i + j],
+            sysbus_create_simple(OBJECT(mms), "spi[*]", TYPE_PL022,
+                                 spibase[2 * i + j],
                                  qdev_get_gpio_in(orgate_dev, j));
         }
     }
@@ -446,7 +447,8 @@ static void mps2_common_init(MachineState *machine)
                                          0x4002a000};   /* Shield1 */
         DeviceState *dev;
 
-        dev = sysbus_create_simple_orphan(TYPE_ARM_SBCON_I2C, i2cbase[i], NULL);
+        dev = sysbus_create_simple(OBJECT(mms), "i2c[*]",
+                                   TYPE_ARM_SBCON_I2C, i2cbase[i], NULL);
         if (i < 2) {
             /*
              * internal-only bus: mark it full to avoid user-created
-- 
2.47.1


