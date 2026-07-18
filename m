Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F771C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD0j-0004DQ-9m; Sat, 18 Jul 2026 17:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD0e-00040D-KU; Sat, 18 Jul 2026 17:55:48 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD0c-0004Zq-Fi; Sat, 18 Jul 2026 17:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411746; x=1815947746;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dKzfer9ZfJv7EUeLtSaSW1MA9kxz2rl8TgAOt4P8l24=;
 b=E9YSag9peTZErV09XThptKkqlVfGN5e2+kNw5FKTQP82XjCSTXU/H0p5
 WEqUAkzBoO8HA9bw75sfopzPEvftH51QqFjN+e9fv2DYA59G/6j7Q9cec
 C5SXRIDzBJL2zwC9u9Q1mTR034t5ccnInFUBUZ4dAbRJccBSAtbZbWBwa
 MKmbNYlXJ31glkM5f9I7XABbZspPV5Mn6Il2l5w4exadbA0CNR5T4p/66
 mBOaSLUmxeMXY9BbM61mozPjfo0kJSL8WlGcT0lgNRzKebDqrnqQYUltH
 A+haDyBl6E6+5ECKjqLQA3UD7lcTK8Flfgjy4t3XVf0Z8XuFP7vNrVcv4 Q==;
X-CSE-ConnectionGUID: 84eN5zcnTUCgRCgrhfkoZA==
X-CSE-MsgGUID: wgEVQXpmT0+sbDKeVRdE2w==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23423058"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:55:43 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:12402]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.17:2525]
 with esmtp (Farcaster)
 id bdb54ba2-6c82-4779-ae62-9539c1132905; Sat, 18 Jul 2026 21:55:42 +0000 (UTC)
X-Farcaster-Flow-ID: bdb54ba2-6c82-4779-ae62-9539c1132905
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:55:42 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:55:33 +0000
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
Subject: [RFC PATCH v2 067/137] hw/arm/strongarm: Give onboard devices a QOM
 parent
Date: Sat, 18 Jul 2026 21:35:42 +0000
Message-ID: <20260718213652.37673-68-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
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
AI-used-for: code (refactoring)
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


