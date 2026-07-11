Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321C6C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigVK-0002jk-GY; Sat, 11 Jul 2026 18:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigV9-0002Y7-13; Sat, 11 Jul 2026 18:48:55 -0400
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.42.203.116])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigV1-0007is-86; Sat, 11 Jul 2026 18:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810123; x=1815346123;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cjOww6QiL/hj8HgD2cr+EQ+VepUESTbjn+BqiEs27nA=;
 b=h3wrQeE1I9ckTaifeL7/6bg0zfK6CRJTNHFGNI2DsskgMWHDb8CY/e02
 4dG+8hmcdHvyxpTZpJjhBaJRPs3MBBBrhKkSx6aELu6m8iMSsjlc+cd3O
 wU+P+a7aL8eXnB1Djc15zin4phx5dutbaPFjYW8k9Ld8nagALRqMVQUqY
 ox6vEGbuhoq9ydENGjubBpQGEliSpgz0sM7LGxuVGLqg704FCo5uA1pfA
 WlcozaX1+3Z4z1yVdWVfn7s4c70YjSJtHW1GqQGG9tSS7OwNkOi/Osbun
 awTay7dG/M84GRCl2BF55gJQ5fjDoM7Pw6uSZC+POzqqmJvscGro3WrZy w==;
X-CSE-ConnectionGUID: JaqDw82jTSGnvPoGO1WnqQ==
X-CSE-MsgGUID: WAcGKIUSQIWblKnMKEanug==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23517833"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:48:38 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:26735]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.212:2525]
 with esmtp (Farcaster)
 id cddc9e8b-19e1-4c5f-bb80-c9b3b8827e07; Sat, 11 Jul 2026 22:48:38 +0000 (UTC)
X-Farcaster-Flow-ID: cddc9e8b-19e1-4c5f-bb80-c9b3b8827e07
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:48:37 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:48:29 +0000
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
Subject: [RFC PATCH 044/134] hw/m68k: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:37 +0000
Message-ID: <20260711223707.42139-45-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.42.203.116;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/m68k to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/m68k/an5206.c:28 | qdev_new | parent | "mbar" | mcf5206_init() helper: thread Object *parent from board init
hw/m68k/an5206.c:49 | cpu_create | OBJECT(machine) | "cpu" | an5206_init() board init
hw/m68k/mcf5208.c:291 | cpu_create | OBJECT(machine) | "cpu" | mcf5208evb_init() board init
hw/m68k/mcf_intc.c:214 | qdev_new | parent | "intc" | mcf_intc_init() global helper: add Object *parent, update header + caller
hw/m68k/next-cube.c:1263 | cpu_create | OBJECT(machine) | "cpu" | next_cube_init() board init
hw/m68k/next-cube.c:1275 | qdev_new | OBJECT(machine) | "pc" | next_cube_init() board init; peripheral controller
hw/m68k/next-cube.c:1283 | sysbus_create_simple | OBJECT(machine) | "fb" | next_cube_init() board init; framebuffer
hw/m68k/next-cube.c:1322 | sysbus_create_simple | OBJECT(machine) | "kbd" | next_cube_init() board init
hw/m68k/q800.c:358 | qdev_new | OBJECT(machine) | "adb-keyboard" | q800_machine_init() board init; drop _and_unref
hw/m68k/q800.c:360 | qdev_new | OBJECT(machine) | "adb-mouse" | q800_machine_init() board init; drop _and_unref
hw/m68k/virt.c:148 | cpu_create | OBJECT(machine) | "cpu" | virt_init() board init
hw/m68k/virt.c:158 | qdev_new | OBJECT(machine) | "irqc" | virt_init() board init
hw/m68k/virt.c:172 | qdev_new | OBJECT(machine) | "pic[*]" | virt_init() board init; loop
hw/m68k/virt.c:186 | qdev_new | OBJECT(machine) | "rtc[*]" | virt_init() board init; loop
hw/m68k/virt.c:197 | qdev_new | OBJECT(machine) | "tty" | virt_init() board init
hw/m68k/virt.c:205 | sysbus_create_simple | OBJECT(machine) | "virt-ctrl" | virt_init() board init
hw/m68k/virt.c:211 | qdev_new | OBJECT(machine) | "virtio-mmio[*]" | virt_init() board init; loop

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/m68k/an5206.c      | 11 ++++++-----
 hw/m68k/mcf5208.c     |  4 ++--
 hw/m68k/mcf_intc.c    |  7 ++++---
 hw/m68k/next-cube.c   | 10 +++++-----
 hw/m68k/q800.c        |  8 ++++----
 hw/m68k/virt.c        | 25 +++++++++++++------------
 include/hw/m68k/mcf.h |  2 +-
 7 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index b649605140..5027311cad 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -20,16 +20,17 @@
 #define AN5206_MBAR_ADDR 0x10000000
 #define AN5206_RAMBAR_ADDR 0x20000000
 
-static void mcf5206_init(M68kCPU *cpu, MemoryRegion *sysmem, uint32_t base)
+static void mcf5206_init(Object *parent, M68kCPU *cpu, MemoryRegion *sysmem,
+                         uint32_t base)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan(TYPE_MCF5206_MBAR);
+    dev = qdev_new(parent, "mbar", TYPE_MCF5206_MBAR);
     object_property_set_link(OBJECT(dev), "m68k-cpu",
                              OBJECT(cpu), &error_abort);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
 
     memory_region_add_subregion(sysmem, base, sysbus_mmio_get_region(s, 0));
 }
@@ -46,7 +47,7 @@ static void an5206_init(MachineState *machine)
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *sram = g_new(MemoryRegion, 1);
 
-    cpu = M68K_CPU(cpu_create_orphan(machine->cpu_type));
+    cpu = M68K_CPU(cpu_create(OBJECT(machine), "cpu", machine->cpu_type));
     env = &cpu->env;
 
     /* Initialize CPU registers.  */
@@ -62,7 +63,7 @@ static void an5206_init(MachineState *machine)
     memory_region_init_ram(sram, NULL, "an5206.sram", 512, &error_fatal);
     memory_region_add_subregion(address_space_mem, AN5206_RAMBAR_ADDR, sram);
 
-    mcf5206_init(cpu, address_space_mem, AN5206_MBAR_ADDR);
+    mcf5206_init(OBJECT(machine), cpu, address_space_mem, AN5206_MBAR_ADDR);
 
     /* Load kernel.  */
     if (!kernel_filename) {
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index d79ec173e6..0b8636daa9 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -288,7 +288,7 @@ static void mcf5208evb_init(MachineState *machine)
     MemoryRegion *sram = g_new(MemoryRegion, 1);
     DeviceState *intc;
 
-    cpu = M68K_CPU(cpu_create_orphan(machine->cpu_type));
+    cpu = M68K_CPU(cpu_create(OBJECT(machine), "cpu", machine->cpu_type));
     env = &cpu->env;
 
     /* Initialize CPU registers.  */
@@ -307,7 +307,7 @@ static void mcf5208evb_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0x80000000, sram);
 
     /* Internal peripherals.  */
-    intc = mcf_intc_init(address_space_mem, 0xfc048000, cpu);
+    intc = mcf_intc_init(OBJECT(machine), address_space_mem, 0xfc048000, cpu);
 
     mcf_uart_create_mmap(0xfc060000, qdev_get_gpio_in(intc, 26), serial_hd(0));
     mcf_uart_create_mmap(0xfc064000, qdev_get_gpio_in(intc, 27), serial_hd(1));
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 123bd7e385..5ae8fddc52 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -207,14 +207,15 @@ static void mcf_intc_register_types(void)
 
 type_init(mcf_intc_register_types)
 
-DeviceState *mcf_intc_init(MemoryRegion *sysmem, hwaddr base, M68kCPU *cpu)
+DeviceState *mcf_intc_init(Object *parent, MemoryRegion *sysmem, hwaddr base,
+                           M68kCPU *cpu)
 {
     DeviceState  *dev;
 
-    dev = qdev_new_orphan(TYPE_MCF_INTC);
+    dev = qdev_new(parent, "intc", TYPE_MCF_INTC);
     object_property_set_link(OBJECT(dev), "m68k-cpu",
                              OBJECT(cpu), &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
     return dev;
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 530dc1ab59..c80d32ef29 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1260,7 +1260,7 @@ static void next_cube_init(MachineState *machine)
     DeviceState *pcdev;
 
     /* Initialize the cpu core */
-    cpu = M68K_CPU(cpu_create_orphan(machine->cpu_type));
+    cpu = M68K_CPU(cpu_create(OBJECT(machine), "cpu", machine->cpu_type));
     if (!cpu) {
         error_report("Unable to find m68k CPU definition");
         exit(1);
@@ -1272,15 +1272,15 @@ static void next_cube_init(MachineState *machine)
     env->sr  = 0x2700;
 
     /* Peripheral Controller */
-    pcdev = qdev_new_orphan(TYPE_NEXT_PC);
+    pcdev = qdev_new(OBJECT(machine), "pc", TYPE_NEXT_PC);
     object_property_set_link(OBJECT(pcdev), "cpu", OBJECT(cpu), &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(pcdev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(pcdev), &error_fatal);
 
     /* 64MB RAM starting at 0x04000000  */
     memory_region_add_subregion(sysmem, 0x04000000, machine->ram);
 
     /* Framebuffer */
-    sysbus_create_simple_orphan(TYPE_NEXTFB, 0x0B000000, NULL);
+    sysbus_create_simple(OBJECT(machine), "fb", TYPE_NEXTFB, 0x0B000000, NULL);
 
     /* MMIO */
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 0, 0x02005000);
@@ -1319,7 +1319,7 @@ static void next_cube_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0x820c0000, &m->bmapm2);
 
     /* KBD */
-    sysbus_create_simple_orphan(TYPE_NEXTKBD, 0x0200e000, NULL);
+    sysbus_create_simple(OBJECT(machine), "kbd", TYPE_NEXTKBD, 0x0200e000, NULL);
 
     /* Load ROM here */
     memory_region_init_rom(&m->rom, NULL, "next.rom", 0x20000, &error_fatal);
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 688299ee2d..15b3bcab5f 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -355,10 +355,10 @@ static void q800_machine_init(MachineState *machine)
                                                  "auxmode", 0));
 
     adb_bus = qdev_get_child_bus(DEVICE(&m->via1), "adb.0");
-    dev = qdev_new_orphan(TYPE_ADB_KEYBOARD);
-    qdev_realize_and_unref(dev, adb_bus, &error_fatal);
-    dev = qdev_new_orphan(TYPE_ADB_MOUSE);
-    qdev_realize_and_unref(dev, adb_bus, &error_fatal);
+    dev = qdev_new(OBJECT(machine), "adb-keyboard", TYPE_ADB_KEYBOARD);
+    qdev_realize(dev, adb_bus, &error_fatal);
+    dev = qdev_new(OBJECT(machine), "adb-mouse", TYPE_ADB_MOUSE);
+    qdev_realize(dev, adb_bus, &error_fatal);
 
     /* VIA 2 */
     object_initialize_child(OBJECT(machine), "via2", &m->via2,
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 64ac8c8166..5d5ea72314 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -145,7 +145,7 @@ static void virt_init(MachineState *machine)
     reset_info = g_new0(ResetInfo, 1);
 
     /* init CPUs */
-    cpu = M68K_CPU(cpu_create_orphan(machine->cpu_type));
+    cpu = M68K_CPU(cpu_create(OBJECT(machine), "cpu", machine->cpu_type));
 
     reset_info->cpu = cpu;
     qemu_register_reset(main_cpu_reset, reset_info);
@@ -155,10 +155,10 @@ static void virt_init(MachineState *machine)
 
     /* IRQ Controller */
 
-    irqc_dev = qdev_new_orphan(TYPE_M68K_IRQC);
+    irqc_dev = qdev_new(OBJECT(machine), "irqc", TYPE_M68K_IRQC);
     object_property_set_link(OBJECT(irqc_dev), "m68k-cpu",
                              OBJECT(cpu), &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(irqc_dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(irqc_dev), &error_fatal);
 
     /*
      * 6 goldfish-pic
@@ -169,10 +169,10 @@ static void virt_init(MachineState *machine)
      */
     io_base = VIRT_GF_PIC_MMIO_BASE;
     for (i = 0; i < VIRT_GF_PIC_NB; i++) {
-        pic_dev[i] = qdev_new_orphan(TYPE_GOLDFISH_PIC);
+        pic_dev[i] = qdev_new(OBJECT(machine), "pic[*]", TYPE_GOLDFISH_PIC);
         sysbus = SYS_BUS_DEVICE(pic_dev[i]);
         qdev_prop_set_uint8(pic_dev[i], "index", i);
-        sysbus_realize_and_unref(sysbus, &error_fatal);
+        sysbus_realize(sysbus, &error_fatal);
 
         sysbus_mmio_map(sysbus, 0, io_base);
         sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(irqc_dev, i));
@@ -183,10 +183,10 @@ static void virt_init(MachineState *machine)
     /* goldfish-rtc */
     io_base = VIRT_GF_RTC_MMIO_BASE;
     for (i = 0; i < VIRT_GF_RTC_NB; i++) {
-        dev = qdev_new_orphan(TYPE_GOLDFISH_RTC);
+        dev = qdev_new(OBJECT(machine), "rtc[*]", TYPE_GOLDFISH_RTC);
         qdev_prop_set_bit(dev, "big-endian", true);
         sysbus = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(sysbus, &error_fatal);
+        sysbus_realize(sysbus, &error_fatal);
         sysbus_mmio_map(sysbus, 0, io_base);
         sysbus_connect_irq(sysbus, 0, PIC_GPIO(VIRT_GF_RTC_IRQ_BASE + i));
 
@@ -194,24 +194,25 @@ static void virt_init(MachineState *machine)
     }
 
     /* goldfish-tty */
-    dev = qdev_new_orphan(TYPE_GOLDFISH_TTY);
+    dev = qdev_new(OBJECT(machine), "tty", TYPE_GOLDFISH_TTY);
     sysbus = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus_realize(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 0, VIRT_GF_TTY_MMIO_BASE);
     sysbus_connect_irq(sysbus, 0, PIC_GPIO(VIRT_GF_TTY_IRQ_BASE));
 
     /* virt controller */
-    dev = sysbus_create_simple_orphan(TYPE_VIRT_CTRL, VIRT_CTRL_MMIO_BASE,
+    dev = sysbus_create_simple(OBJECT(machine), "virt-ctrl", TYPE_VIRT_CTRL,
+                               VIRT_CTRL_MMIO_BASE,
                                PIC_GPIO(VIRT_CTRL_IRQ_BASE));
 
     /* virtio-mmio */
     io_base = VIRT_VIRTIO_MMIO_BASE;
     for (i = 0; i < 128; i++) {
-        dev = qdev_new_orphan(TYPE_VIRTIO_MMIO);
+        dev = qdev_new(OBJECT(machine), "virtio-mmio[*]", TYPE_VIRTIO_MMIO);
         qdev_prop_set_bit(dev, "force-legacy", false);
         sysbus = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(sysbus, &error_fatal);
+        sysbus_realize(sysbus, &error_fatal);
         sysbus_connect_irq(sysbus, 0, PIC_GPIO(VIRT_VIRTIO_IRQ_BASE + i));
         sysbus_mmio_map(sysbus, 0, io_base);
         io_base += 0x200;
diff --git a/include/hw/m68k/mcf.h b/include/hw/m68k/mcf.h
index b2a599adaa..ff818c55d0 100644
--- a/include/hw/m68k/mcf.h
+++ b/include/hw/m68k/mcf.h
@@ -14,7 +14,7 @@ DeviceState *mcf_uart_create(qemu_irq irq, Chardev *chr);
 DeviceState *mcf_uart_create_mmap(hwaddr base, qemu_irq irq, Chardev *chr);
 
 /* mcf_intc.c */
-DeviceState *mcf_intc_init(struct MemoryRegion *sysmem,
+DeviceState *mcf_intc_init(Object *parent, struct MemoryRegion *sysmem,
                            hwaddr base, M68kCPU *cpu);
 
 /* mcf5206.c */
-- 
2.47.1


