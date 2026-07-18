Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BBAC4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCoE-0000Xq-9p; Sat, 18 Jul 2026 17:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCnn-00007v-W0; Sat, 18 Jul 2026 17:42:36 -0400
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.13.214.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCnl-0002fP-Bz; Sat, 18 Jul 2026 17:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784410949; x=1815946949;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5f3HzwuXe0MvsCBU0ME0zpexJU3MHLtq9ie+g2sflTM=;
 b=Zypekd1FV+MDzw0VPLQJyXXEUe4pbmyNhtB+ea1A0I/TytAyz2++vBBw
 IjSy9hSoREiaAunF5vx1DntIUtrdRI0gFR3kTABlhCl/o1rkcClL12lRV
 Cc+CbwRd3NZKCj9bgrNww9Cn44NVqLpRk3PzgW6gSxd03FtOh+7SaIuGI
 k9sdZ9gPm1YfiaiVrCy2V5urHKxj2CPqhr+ayr5czNB6adUHtmE2sf6C4
 ShWQHsVT5In4Ms+ePme4RLniSppCh8bGXLdzUD2OPo7fcRXI7A8IRRsfj
 6ATjyNBqlDn4GhiB4OY5U+KiQ85zMIJ/G9vhfgz1OnT9OW3RxdZ2bKuae Q==;
X-CSE-ConnectionGUID: K9+R2bHIRgaKIegRivN9sg==
X-CSE-MsgGUID: ODEi2OHxRbqb0tBCbjOHOg==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23903655"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:42:26 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:6891]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.199:2525]
 with esmtp (Farcaster)
 id f206f6b6-4a63-4ecf-9627-73aa492ccfd6; Sat, 18 Jul 2026 21:42:25 +0000 (UTC)
X-Farcaster-Flow-ID: f206f6b6-4a63-4ecf-9627-73aa492ccfd6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:42:25 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:42:15 +0000
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
Subject: [RFC PATCH v2 020/137] hw/or1k: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:34:55 +0000
Message-ID: <20260718213652.37673-21-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.13.214.179;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/or1k to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

  hw/or1k/or1k-sim.c:189 | OBJECT(state) | "irq-splitter[*]" | board-init helper receives Or1ksimState; auto-index (net + serial share the pool)
  hw/or1k/or1k-sim.c:224 | OBJECT(state) | "ompic" | board-init helper receives Or1ksimState; single OMPIC per machine
  hw/or1k/or1k-sim.c:257 | OBJECT(state) | "irq-splitter[*]" | board-init helper receives Or1ksimState; auto-index alongside net splitter
  hw/or1k/or1k-sim.c:302 | OBJECT(machine) | "cpu[*]" | MachineClass.init(); auto-index over smp_cpus
  hw/or1k/virt.c:113 | parent | "irq-splitter[*]" | static helper had no parent-capable arg; add Object *parent first arg, thread OBJECT(state) from all callers; auto-index (serial+rtc+virtio*N)
  hw/or1k/virt.c:209 | OBJECT(state) | "ompic" | board-init helper receives OR1KVirtState; single OMPIC
  hw/or1k/virt.c:303 | OBJECT(state) | "rtc" | board-init helper receives OR1KVirtState; single Goldfish RTC
  hw/or1k/virt.c:382 | OBJECT(state) | "pcie" | board-init helper receives OR1KVirtState; single GPEX host
  hw/or1k/virt.c:454 | OBJECT(state) | "virtio-mmio[*]" | board-init helper receives OR1KVirtState; called VIRTIO_COUNT times, auto-index
  hw/or1k/virt.c:484 | OBJECT(machine) | "cpu[*]" | MachineClass.init(); auto-index over smp_cpus

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/or1k/or1k-sim.c | 17 ++++++++++-------
 hw/or1k/virt.c     | 37 ++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/hw/or1k/or1k-sim.c b/hw/or1k/or1k-sim.c
index 6962313315..da05d7cbe3 100644
--- a/hw/or1k/or1k-sim.c
+++ b/hw/or1k/or1k-sim.c
@@ -186,9 +186,10 @@ static void openrisc_sim_net_init(Or1ksimState *state, hwaddr base, hwaddr size,
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
     if (num_cpus > 1) {
-        DeviceState *splitter = qdev_new_orphan(TYPE_SPLIT_IRQ);
+        DeviceState *splitter = qdev_new(OBJECT(state), "irq-splitter[*]",
+                                         TYPE_SPLIT_IRQ);
         qdev_prop_set_uint32(splitter, "num-lines", num_cpus);
-        qdev_realize_and_unref(splitter, NULL, &error_fatal);
+        qdev_realize(splitter, NULL, &error_fatal);
         for (i = 0; i < num_cpus; i++) {
             qdev_connect_gpio_out(splitter, i, get_cpu_irq(cpus, i, irq_pin));
         }
@@ -221,11 +222,11 @@ static void openrisc_sim_ompic_init(Or1ksimState *state, hwaddr base,
     char *nodename;
     int i;
 
-    dev = qdev_new_orphan("or1k-ompic");
+    dev = qdev_new(OBJECT(state), "ompic", "or1k-ompic");
     qdev_prop_set_uint32(dev, "num-cpus", num_cpus);
 
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     for (i = 0; i < num_cpus; i++) {
         sysbus_connect_irq(s, i, get_cpu_irq(cpus, i, irq_pin));
     }
@@ -254,9 +255,10 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     int i;
 
     if (num_cpus > 1) {
-        DeviceState *splitter = qdev_new_orphan(TYPE_SPLIT_IRQ);
+        DeviceState *splitter = qdev_new(OBJECT(state), "irq-splitter[*]",
+                                         TYPE_SPLIT_IRQ);
         qdev_prop_set_uint32(splitter, "num-lines", num_cpus);
-        qdev_realize_and_unref(splitter, NULL, &error_fatal);
+        qdev_realize(splitter, NULL, &error_fatal);
         for (i = 0; i < num_cpus; i++) {
             qdev_connect_gpio_out(splitter, i, get_cpu_irq(cpus, i, irq_pin));
         }
@@ -299,7 +301,8 @@ static void openrisc_sim_init(MachineState *machine)
 
     assert(smp_cpus >= 1 && smp_cpus <= OR1KSIM_CPUS_MAX);
     for (n = 0; n < smp_cpus; n++) {
-        cpus[n] = OPENRISC_CPU(cpu_create_orphan(machine->cpu_type));
+        cpus[n] = OPENRISC_CPU(cpu_create(OBJECT(machine), "cpu[*]",
+                                          machine->cpu_type));
         if (cpus[n] == NULL) {
             fprintf(stderr, "Unable to find CPU definition!\n");
             exit(1);
diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index f222efafde..7362433a02 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -105,14 +105,16 @@ static qemu_irq get_cpu_irq(OpenRISCCPU *cpus[], int cpunum, int irq_pin)
     return qdev_get_gpio_in_named(DEVICE(cpus[cpunum]), "IRQ", irq_pin);
 }
 
-static qemu_irq get_per_cpu_irq(OpenRISCCPU *cpus[], int num_cpus, int irq_pin)
+static qemu_irq get_per_cpu_irq(Object *parent, OpenRISCCPU *cpus[],
+                                int num_cpus, int irq_pin)
 {
     int i;
 
     if (num_cpus > 1) {
-        DeviceState *splitter = qdev_new_orphan(TYPE_SPLIT_IRQ);
+        DeviceState *splitter = qdev_new(parent, "irq-splitter[*]",
+                                         TYPE_SPLIT_IRQ);
         qdev_prop_set_uint32(splitter, "num-lines", num_cpus);
-        qdev_realize_and_unref(splitter, NULL, &error_fatal);
+        qdev_realize(splitter, NULL, &error_fatal);
         for (i = 0; i < num_cpus; i++) {
             qdev_connect_gpio_out(splitter, i, get_cpu_irq(cpus, i, irq_pin));
         }
@@ -206,11 +208,11 @@ static void openrisc_virt_ompic_init(OR1KVirtState *state, hwaddr base,
     char *nodename;
     int i;
 
-    dev = qdev_new_orphan("or1k-ompic");
+    dev = qdev_new(OBJECT(state), "ompic", "or1k-ompic");
     qdev_prop_set_uint32(dev, "num-cpus", num_cpus);
 
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     for (i = 0; i < num_cpus; i++) {
         sysbus_connect_irq(s, i, get_cpu_irq(cpus, i, irq_pin));
     }
@@ -233,7 +235,8 @@ static void openrisc_virt_serial_init(OR1KVirtState *state, hwaddr base,
 {
     void *fdt = state->fdt;
     char *nodename;
-    qemu_irq serial_irq = get_per_cpu_irq(cpus, num_cpus, irq_pin);
+    qemu_irq serial_irq = get_per_cpu_irq(OBJECT(state), cpus, num_cpus,
+                                          irq_pin);
 
     serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
                    serial_hd(0), DEVICE_BIG_ENDIAN);
@@ -297,10 +300,12 @@ static void openrisc_virt_rtc_init(OR1KVirtState *state, hwaddr base,
 {
     void *fdt = state->fdt;
     char *nodename;
-    qemu_irq rtc_irq = get_per_cpu_irq(cpus, num_cpus, irq_pin);
+    qemu_irq rtc_irq = get_per_cpu_irq(OBJECT(state), cpus, num_cpus,
+                                       irq_pin);
 
     /* Goldfish RTC */
-    sysbus_create_simple_orphan(TYPE_GOLDFISH_RTC, base, rtc_irq);
+    sysbus_create_simple(OBJECT(state), "rtc", TYPE_GOLDFISH_RTC, base,
+                         rtc_irq);
 
     /* Goldfish RTC FDT */
     nodename = g_strdup_printf("/soc/rtc@%" HWADDR_PRIx, base);
@@ -379,8 +384,8 @@ static void openrisc_virt_pcie_init(OR1KVirtState *state,
     qemu_irq pcie_irq;
     int i;
 
-    dev = qdev_new_orphan(TYPE_GPEX_HOST);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(OBJECT(state), "pcie", TYPE_GPEX_HOST);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Map ECAM space. */
     alias = g_new0(MemoryRegion, 1);
@@ -410,7 +415,7 @@ static void openrisc_virt_pcie_init(OR1KVirtState *state,
 
     /* Connect IRQ lines. */
     for (i = 0; i < PCI_NUM_PINS; i++) {
-        pcie_irq = get_per_cpu_irq(cpus, num_cpus, irq_base + i);
+        pcie_irq = get_per_cpu_irq(OBJECT(state), cpus, num_cpus, irq_base + i);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pcie_irq);
         gpex_set_irq_num(GPEX_HOST(dev), i, irq_base + i);
@@ -448,13 +453,14 @@ static void openrisc_virt_virtio_init(OR1KVirtState *state, hwaddr base,
     char *nodename;
     DeviceState *dev;
     SysBusDevice *sysbus;
-    qemu_irq virtio_irq = get_per_cpu_irq(cpus, num_cpus, irq_pin);
+    qemu_irq virtio_irq = get_per_cpu_irq(OBJECT(state), cpus, num_cpus,
+                                          irq_pin);
 
     /* VirtIO MMIO devices */
-    dev = qdev_new_orphan(TYPE_VIRTIO_MMIO);
+    dev = qdev_new(OBJECT(state), "virtio-mmio[*]", TYPE_VIRTIO_MMIO);
     qdev_prop_set_bit(dev, "force-legacy", false);
     sysbus = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus_realize(sysbus, &error_fatal);
     sysbus_connect_irq(sysbus, 0, virtio_irq);
     sysbus_mmio_map(sysbus, 0, base);
 
@@ -481,7 +487,8 @@ static void openrisc_virt_init(MachineState *machine)
 
     assert(smp_cpus >= 1 && smp_cpus <= VIRT_CPUS_MAX);
     for (n = 0; n < smp_cpus; n++) {
-        cpus[n] = OPENRISC_CPU(cpu_create_orphan(machine->cpu_type));
+        cpus[n] = OPENRISC_CPU(cpu_create(OBJECT(machine), "cpu[*]",
+                                          machine->cpu_type));
         if (cpus[n] == NULL) {
             fprintf(stderr, "Unable to find CPU definition!\n");
             exit(1);
-- 
2.47.1


