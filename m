Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E92C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigau-0005lb-7k; Sat, 11 Jul 2026 18:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigat-0005gj-4T; Sat, 11 Jul 2026 18:54:47 -0400
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([50.112.246.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigaq-0000Yy-Sr; Sat, 11 Jul 2026 18:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810484; x=1815346484;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MW3P9SgTvFq9SPiktBatupfPQXymyENjuoN85Sn7L2I=;
 b=iO3w87+qsUvF03k5bmOSZ7wK8JCCA4DFV7dpBvApXEGNWJ5SyoE+oScP
 9CcBIoypu/8477v25wnrjhhkVEvKutVSh/dAYNHvezj9B7S1cpNjugTE9
 Qvd2umMS9Ul7nyzNAxdHRNZn595d/Fp5EVY5rUxu2xXdTemNaEozSvaPu
 FAwMVkQXBD53/EZrZ9owCm+TeBQ3bTDyyo8PjbEviIZlN/6v/cGWQkiwK
 sYr4kR6U2SCPb2gNtGs3YYKweZhURlpgK21riqdP4aNoOeVPe61odiap9
 10JkDyPCvDwujoNxxfDbxsWYs1yho6U099U8xymsWo+VEhNZ/PUfQf5eF A==;
X-CSE-ConnectionGUID: E+fwtORxRiGv0nNW70y+aA==
X-CSE-MsgGUID: qsBGwhy+TByDWhvbCgPXAg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23300053"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:54:41 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:10476]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.212:2525]
 with esmtp (Farcaster)
 id 2627543e-87b6-4be6-86aa-138e48a26d60; Sat, 11 Jul 2026 22:54:41 +0000 (UTC)
X-Farcaster-Flow-ID: 2627543e-87b6-4be6-86aa-138e48a26d60
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:54:41 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:54:32 +0000
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
Subject: [RFC PATCH 066/134] hw/arm/strongarm: Give onboard devices a QOM
 parent
Date: Sat, 11 Jul 2026 22:35:59 +0000
Message-ID: <20260711223707.42139-67-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=50.112.246.219;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in the hw/arm strongarm
board files to the new parented API introduced earlier in this
series, so every onboard device gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/collie.c:67 | sysbus_create_simple | OBJECT(machine) | "scoop" | Board .init(MachineState *machine); single instance.
hw/arm/strongarm.c:649 | qdev_new | parent (threaded) | "gpio" | strongarm_gpio_init() static helper: added Object *parent as first arg, threaded from sa1110_init(). Paired sysbus_realize_and_unref -> sysbus_realize.
hw/arm/strongarm.c:1623 | cpu_create | parent (threaded) | "cpu" | sa1110_init() has no parent-capable pointer; added Object *parent as first arg (prototype in strongarm.h updated), threaded from collie_init() with OBJECT(machine).
hw/arm/strongarm.c:1625 | sysbus_create_varargs | parent | "pic" | sa1110_init(); single PIC.
hw/arm/strongarm.c:1630 | sysbus_create_varargs | parent | "timer" | sa1110_init(); single timer.
hw/arm/strongarm.c:1637 | sysbus_create_simple | parent | "rtc" | sa1110_init(); single RTC.
hw/arm/strongarm.c:1642 | sysbus_create_varargs | parent | "ppc" | sa1110_init(); single PPC.
hw/arm/strongarm.c:1645 | qdev_new | parent | "uart[*]" | sa1110_init(); loop over sa_serial[]. Paired sysbus_realize_and_unref -> sysbus_realize.
hw/arm/strongarm.c:1654 | sysbus_create_varargs | parent | "ssp" | sa1110_init(); single SSP.

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/collie.c    |  4 ++--
 hw/arm/strongarm.c | 27 ++++++++++++++-------------
 hw/arm/strongarm.h |  2 +-
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index b3646daa3b..afd4e14315 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -52,7 +52,7 @@ static void collie_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    cms->sa1110 = sa1110_init(machine->cpu_type);
+    cms->sa1110 = sa1110_init(OBJECT(machine), machine->cpu_type);
 
     memory_region_add_subregion(get_system_memory(), SA_SDCS0, machine->ram);
 
@@ -64,7 +64,7 @@ static void collie_init(MachineState *machine)
                               FLASH_SECTOR_SIZE, 4, 0x00, 0x00, 0x00, 0x00, 0);
     }
 
-    sysbus_create_simple_orphan("scoop", 0x40800000, NULL);
+    sysbus_create_simple(OBJECT(machine), "scoop", "scoop", 0x40800000, NULL);
 
     collie_binfo.board_id = 0x208;
     arm_load_kernel(cms->sa1110->cpu, machine, &collie_binfo);
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 1704db8baa..0b3b56218a 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -640,14 +640,14 @@ static const MemoryRegionOps strongarm_gpio_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static DeviceState *strongarm_gpio_init(hwaddr base,
+static DeviceState *strongarm_gpio_init(Object *parent, hwaddr base,
                 DeviceState *pic)
 {
     DeviceState *dev;
     int i;
 
-    dev = qdev_new_orphan(TYPE_STRONGARM_GPIO);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(parent, "gpio", TYPE_STRONGARM_GPIO);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < 12; i++)
@@ -1608,7 +1608,7 @@ static const TypeInfo strongarm_ssp_info = {
 };
 
 /* Main CPU functions */
-StrongARMState *sa1110_init(const char *cpu_type)
+StrongARMState *sa1110_init(Object *parent, const char *cpu_type)
 {
     StrongARMState *s;
     int i;
@@ -1620,38 +1620,39 @@ StrongARMState *sa1110_init(const char *cpu_type)
         exit(1);
     }
 
-    s->cpu = ARM_CPU(cpu_create_orphan(cpu_type));
+    s->cpu = ARM_CPU(cpu_create(parent, "cpu", cpu_type));
 
-    s->pic = sysbus_create_varargs_orphan("strongarm_pic", 0x90050000,
+    s->pic = sysbus_create_varargs(parent, "pic", "strongarm_pic", 0x90050000,
                     qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ),
                     qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_FIQ),
                     NULL);
 
-    sysbus_create_varargs_orphan("pxa25x-timer", 0x90000000,
+    sysbus_create_varargs(parent, "timer", "pxa25x-timer", 0x90000000,
                     qdev_get_gpio_in(s->pic, SA_PIC_OSTC0),
                     qdev_get_gpio_in(s->pic, SA_PIC_OSTC1),
                     qdev_get_gpio_in(s->pic, SA_PIC_OSTC2),
                     qdev_get_gpio_in(s->pic, SA_PIC_OSTC3),
                     NULL);
 
-    sysbus_create_simple_orphan(TYPE_STRONGARM_RTC, 0x90010000,
+    sysbus_create_simple(parent, "rtc", TYPE_STRONGARM_RTC, 0x90010000,
                     qdev_get_gpio_in(s->pic, SA_PIC_RTC_ALARM));
 
-    s->gpio = strongarm_gpio_init(0x90040000, s->pic);
+    s->gpio = strongarm_gpio_init(parent, 0x90040000, s->pic);
 
-    s->ppc = sysbus_create_varargs_orphan(TYPE_STRONGARM_PPC, 0x90060000, NULL);
+    s->ppc = sysbus_create_varargs(parent, "ppc", TYPE_STRONGARM_PPC,
+                                   0x90060000, NULL);
 
     for (i = 0; sa_serial[i].io_base; i++) {
-        DeviceState *dev = qdev_new_orphan(TYPE_STRONGARM_UART);
+        DeviceState *dev = qdev_new(parent, "uart[*]", TYPE_STRONGARM_UART);
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
                 sa_serial[i].io_base);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                 qdev_get_gpio_in(s->pic, sa_serial[i].irq));
     }
 
-    s->ssp = sysbus_create_varargs_orphan(TYPE_STRONGARM_SSP, 0x80070000,
+    s->ssp = sysbus_create_varargs(parent, "ssp", TYPE_STRONGARM_SSP, 0x80070000,
                 qdev_get_gpio_in(s->pic, SA_PIC_SSP), NULL);
     s->ssp_bus = (SSIBus *)qdev_get_child_bus(s->ssp, "ssi");
 
diff --git a/hw/arm/strongarm.h b/hw/arm/strongarm.h
index b11b3a3379..72bb9e075c 100644
--- a/hw/arm/strongarm.h
+++ b/hw/arm/strongarm.h
@@ -62,6 +62,6 @@ typedef struct {
     SSIBus *ssp_bus;
 } StrongARMState;
 
-StrongARMState *sa1110_init(const char *cpu_type);
+StrongARMState *sa1110_init(Object *parent, const char *cpu_type);
 
 #endif
-- 
2.47.1


