Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A91EC4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD5b-0006Kt-6W; Sat, 18 Jul 2026 18:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD4u-00061F-QT; Sat, 18 Jul 2026 18:00:19 -0400
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.34.181.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD4r-0004uf-Fe; Sat, 18 Jul 2026 18:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412009; x=1815948009;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b7JTR8AmMUiHD38GkMccPy6Amfoy8c83JujLhhjT6yA=;
 b=N+seCABHvLBnu0UdP2JIb9jnNkRbC0VkCd7e3Jz77A1yAEhWbqxbLkZD
 EYMQXFHXlTYqKMtXMx84TCwUNzyd0fjznhGSOPHmYohEvPEg+J9vvCLFZ
 ylI/X0A9dIXNDLRWlkrt9iA6hj3MzimkjAhbLJNGL9YeyetQBoQ8OKnHh
 tMuUXa6lKsROFXaDFrk0FJCjsZ1RmYx5V7UfGIHCAx20ENXYxoBexwPQb
 70/76+FMHB0aIeLfrv/4Xd1eUrHzGKB0+yzabP5D7Y97xSERWjXGZUXXD
 8iQECm0NHxKCsjgP7sl3ZVEmUQp9bDQ9f3mTIDAQf2+BlRDYVJ5fJ0D22 A==;
X-CSE-ConnectionGUID: i5taSnfuSdSD2iD/Z+/4SA==
X-CSE-MsgGUID: YLNC87bpQ9Sg+vYBpBAO+g==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23910813"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:00:05 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:8867]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.250:2525]
 with esmtp (Farcaster)
 id 1d7adfaf-9207-4b96-84c2-600e41e79238; Sat, 18 Jul 2026 22:00:05 +0000 (UTC)
X-Farcaster-Flow-ID: 1d7adfaf-9207-4b96-84c2-600e41e79238
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:00:04 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:59:55 +0000
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
Subject: [RFC PATCH v2 083/137] net,
 target/mips: Give -nic and CPU-with-clock helpers a QOM parent
Date: Sat, 18 Jul 2026 21:35:58 +0000
Message-ID: <20260718213652.37673-84-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.34.181.151;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
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

qemu_create_nic_device() and qemu_create_nic_bus_devices() are the
board-side and bus-side halves of the '-nic' command-line path.
Thread an explicit parent through the former (each of the seven
callers now supplies the machine or SoC that owns the on-board NIC)
and let the latter place devices under /machine/peripheral-anon
like -device does.  s390 was already parenting the returned device
by hand; drop that now-redundant open-coding.

mips_cpu_create_with_clock() likewise gains an explicit parent; the
four MIPS boards pass the machine and name the CPU cpu[*].
xtensa_cpu_create_with_clock() has no callers, so just remove it.

For linux-user/bsd-user there is no machine and hence no composition
tree; open-code object_new()+qdev_realize() where cpu_create_orphan()
used to be.

While at it, fix a stale doc reference in migration.c.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 bsd-user/main.c            |  3 ++-
 hw/arm/exynos4_boards.c    |  4 ++--
 hw/hppa/machine.c          |  4 ++--
 hw/m68k/mcf5208.c          |  4 ++--
 hw/mips/fuloong2e.c        |  3 ++-
 hw/mips/jazz.c             |  2 +-
 hw/mips/loongson3_virt.c   |  3 ++-
 hw/mips/malta.c            |  2 +-
 hw/or1k/or1k-sim.c         |  4 ++--
 hw/s390x/s390-virtio-ccw.c |  8 +++-----
 hw/vmapple/vmapple.c       |  5 +++--
 hw/xtensa/xtfpga.c         |  4 ++--
 include/net/net.h          |  5 ++++-
 linux-user/main.c          |  6 ++++--
 migration/migration.c      |  2 +-
 net/net.c                  | 10 ++++++----
 target/mips/cpu.c          |  5 +++--
 target/mips/cpu.h          |  3 ++-
 target/xtensa/cpu.c        | 11 -----------
 target/xtensa/cpu.h        |  2 --
 20 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 5269ea42a5..6dbd1cc1ae 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -474,7 +474,8 @@ int main(int argc, char **argv)
     set_preferred_target_page_bits(ctz32(host_page_size));
     finalize_target_page_bits();
 
-    cpu = cpu_create_orphan(cpu_type);
+    cpu = CPU(object_new(cpu_type));
+    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
     env = cpu_env(cpu);
     cpu_reset(cpu);
     thread_cpu = cpu;
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 1b8c9b618f..dce2c24860 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -78,11 +78,11 @@ static void lan9215_init(uint32_t base, qemu_irq irq)
     SysBusDevice *s;
 
     /* This should be a 9215 but the 9118 is close enough */
-    dev = qemu_create_nic_device(TYPE_LAN9118, true, NULL);
+    dev = qemu_create_nic_device(qdev_get_machine(), "lan9215", TYPE_LAN9118, true, NULL);
     if (dev) {
         qdev_prop_set_uint32(dev, "mode_16bit", 1);
         s = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(s, &error_fatal);
+        sysbus_realize(s, &error_fatal);
         sysbus_mmio_map(s, 0, base);
         sysbus_connect_irq(s, 0, irq);
     }
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d52f27c51c..4fcb3e5e37 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -640,9 +640,9 @@ static void machine_HP_715_init(MachineState *machine)
     }
 
     /* LASI i82596 network */
-    dev = qemu_create_nic_device(TYPE_LASI_82596, true, "lasi");
+    dev = qemu_create_nic_device(OBJECT(machine), "lan", TYPE_LASI_82596, true, "lasi");
     if (dev) {
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                            qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
         memory_region_add_subregion(addr_space,
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index f305478b8d..a955efebeb 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -260,13 +260,13 @@ static void mcf_fec_init(MemoryRegion *sysmem, hwaddr base, DeviceState *intc)
     SysBusDevice *s;
     int i;
 
-    dev = qemu_create_nic_device(TYPE_MCF_FEC_NET, true, NULL);
+    dev = qemu_create_nic_device(qdev_get_machine(), "fec", TYPE_MCF_FEC_NET, true, NULL);
     if (!dev) {
         return;
     }
 
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     for (i = 0; i < FEC_NUM_IRQ; i++) {
         sysbus_connect_irq(s, i, qdev_get_gpio_in(intc, i + 36));
     }
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 477ad99c87..1b105ca37c 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -231,7 +231,8 @@ static void mips_fuloong2e_init(MachineState *machine)
     clock_set_hz(cpuclk, 533080000); /* ~533 MHz */
 
     /* init CPUs */
-    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, false);
+    cpu = mips_cpu_create_with_clock(OBJECT(machine), "cpu[*]",
+                                     machine->cpu_type, cpuclk, false);
     env = &cpu->env;
 
     qemu_register_reset(main_cpu_reset, cpu);
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 8c52608913..cb24d8c00d 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -209,7 +209,7 @@ static void mips_jazz_init(MachineState *machine,
                          * ext_clk[jazz_model].pll_mult);
 
     /* init CPUs */
-    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk,
+    cpu = mips_cpu_create_with_clock(OBJECT(machine), "cpu[*]", machine->cpu_type, cpuclk,
                                      TARGET_BIG_ENDIAN);
     env = &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 8d8430562c..93c14026ab 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -552,7 +552,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
         hwaddr ipi_base = ((hwaddr)node << 44) + virt_memmap[VIRT_IPI].base;
 
         /* init CPUs */
-        cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, false);
+        cpu = mips_cpu_create_with_clock(OBJECT(machine), "cpu[*]",
+                                         machine->cpu_type, cpuclk, false);
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index e8c130d5bb..72bc97625f 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1027,7 +1027,7 @@ static void create_cpu_without_cps(MachineState *ms, MaltaState *s,
     int i;
 
     for (i = 0; i < ms->smp.cpus; i++) {
-        cpu = mips_cpu_create_with_clock(ms->cpu_type, s->cpuclk,
+        cpu = mips_cpu_create_with_clock(OBJECT(ms), "cpu[*]", ms->cpu_type, s->cpuclk,
                                          TARGET_BIG_ENDIAN);
 
         /* Init internal devices */
diff --git a/hw/or1k/or1k-sim.c b/hw/or1k/or1k-sim.c
index 7ea61327c3..293970f156 100644
--- a/hw/or1k/or1k-sim.c
+++ b/hw/or1k/or1k-sim.c
@@ -178,13 +178,13 @@ static void openrisc_sim_net_init(Or1ksimState *state, hwaddr base, hwaddr size,
     char *nodename;
     int i;
 
-    dev = qemu_create_nic_device("open_eth", true, NULL);
+    dev = qemu_create_nic_device(OBJECT(state), "eth", "open_eth", true, NULL);
     if (!dev) {
         return;
     }
 
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     if (num_cpus > 1) {
         DeviceState *splitter = qdev_new(OBJECT(state), "irq-splitter[*]",
                                          TYPE_SPLIT_IRQ);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 1848cde0c4..037cb6eb5e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -237,12 +237,10 @@ static void s390_init_ipl_dev(const char *kernel_filename,
 static void s390_create_virtio_net(BusState *bus, const char *name)
 {
     DeviceState *dev;
-    int cnt = 0;
 
-    while ((dev = qemu_create_nic_device(name, true, "virtio"))) {
-        g_autofree char *childname = g_strdup_printf("%s[%d]", name, cnt++);
-        object_property_add_child(OBJECT(bus), childname, OBJECT(dev));
-        qdev_realize_and_unref(dev, bus, &error_fatal);
+    while ((dev = qemu_create_nic_device(qdev_get_machine(), "nic[*]",
+                                         name, true, "virtio"))) {
+        qdev_realize(dev, bus, &error_fatal);
     }
 }
 
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 60c7dab89b..67e499b74a 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -416,8 +416,9 @@ static void create_pcie(VMAppleMachineState *vms)
     vms->bus = pci->bus;
     g_assert(vms->bus);
 
-    while ((dev = qemu_create_nic_device("virtio-net-pci", true, NULL))) {
-        qdev_realize_and_unref(dev, BUS(vms->bus), &error_fatal);
+    while ((dev = qemu_create_nic_device(OBJECT(vms), "nic[*]",
+                                         "virtio-net-pci", true, NULL))) {
+        qdev_realize(dev, BUS(vms->bus), &error_fatal);
     }
 
     if (defaults_enabled()) {
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 10bbc34399..1c48283f5d 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -149,13 +149,13 @@ static void xtfpga_net_init(MemoryRegion *address_space,
     SysBusDevice *s;
     MemoryRegion *ram;
 
-    dev = qemu_create_nic_device("open_eth", true, NULL);
+    dev = qemu_create_nic_device(qdev_get_machine(), "eth", "open_eth", true, NULL);
     if (!dev) {
         return;
     }
 
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_connect_irq(s, 0, irq);
     memory_region_add_subregion(address_space, base,
             sysbus_mmio_get_region(s, 0));
diff --git a/include/net/net.h b/include/net/net.h
index 45bc86fc86..3bba6e8c11 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -243,6 +243,8 @@ bool qemu_configure_nic_device(DeviceState *dev, bool match_default,
 
 /**
  * qemu_create_nic_device: Create a NIC device if a configuration exists for it
+ * @parent: QOM parent of the created device
+ * @id: child<> property name
  * @typename: Object typename of network device
  * @match_default: Match NIC configurations with no model specified
  * @alias: Additional model string to match
@@ -250,7 +252,8 @@ bool qemu_configure_nic_device(DeviceState *dev, bool match_default,
  * Search for a NIC configuration for the provided device type. If found,
  * create an object of the corresponding type and return it.
  */
-DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
+DeviceState *qemu_create_nic_device(Object *parent, const char *id,
+                                    const char *typename, bool match_default,
                                     const char *alias);
 
 /*
diff --git a/linux-user/main.c b/linux-user/main.c
index 966322dbb3..c04d21ba84 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -235,7 +235,8 @@ void init_task_state(TaskState *ts)
 CPUArchState *cpu_copy(CPUArchState *env)
 {
     CPUState *cpu = env_cpu(env);
-    CPUState *new_cpu = cpu_create_orphan(cpu_type);
+    CPUState *new_cpu = CPU(object_new(cpu_type));
+    qdev_realize(DEVICE(new_cpu), NULL, &error_fatal);
     CPUArchState *new_env = cpu_env(new_cpu);
     CPUBreakpoint *bp;
 
@@ -817,7 +818,8 @@ int main(int argc, char **argv, char **envp)
     set_preferred_target_page_bits(ctz32(host_page_size));
     finalize_target_page_bits();
 
-    cpu = cpu_create_orphan(cpu_type);
+    cpu = CPU(object_new(cpu_type));
+    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
     env = cpu_env(cpu);
     cpu_reset(cpu);
     thread_cpu = cpu;
diff --git a/migration/migration.c b/migration/migration.c
index bdd163b65d..9736c14458 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4076,7 +4076,7 @@ static const TypeInfo migration_type = {
     .name = TYPE_MIGRATION,
     /*
      * NOTE: TYPE_MIGRATION is not really a device, as the object is
-     * not created using qdev_new_orphan(), it is not attached to the qdev
+     * not created using qdev_new(), it is not attached to the qdev
      * device tree, and it is never realized.
      *
      * TODO: Make this TYPE_OBJECT once QOM provides something like
diff --git a/net/net.c b/net/net.c
index e09f0c0d4f..2224367523 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1204,7 +1204,8 @@ bool qemu_configure_nic_device(DeviceState *dev, bool match_default,
 }
 
 /* "Please create a device, if you have a configuration for it" */
-DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
+DeviceState *qemu_create_nic_device(Object *parent, const char *id,
+                                    const char *typename, bool match_default,
                                     const char *alias)
 {
     NICInfo *nd = qemu_find_nic_info(typename, match_default, alias);
@@ -1214,7 +1215,7 @@ DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
         return NULL;
     }
 
-    dev = qdev_new_orphan(typename);
+    dev = qdev_new(parent, id, typename);
     qdev_set_nic_properties(dev, nd);
     return dev;
 }
@@ -1264,9 +1265,10 @@ void qemu_create_nic_bus_devices(BusState *bus, const char *parent_type,
             continue;
         }
 
-        dev = qdev_new_orphan(model);
+        dev = qdev_new(machine_get_container("peripheral-anon"),
+                       "nic[*]", model);
         qdev_set_nic_properties(dev, nd);
-        qdev_realize_and_unref(dev, bus, &error_fatal);
+        qdev_realize(dev, bus, &error_fatal);
     }
 
     g_ptr_array_free(nic_models, true);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 9ad1b4177d..735a2041b7 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -751,12 +751,13 @@ static void mips_cpu_register_types(void)
 type_init(mips_cpu_register_types)
 
 /* Could be used by generic CPU object */
-MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk,
+MIPSCPU *mips_cpu_create_with_clock(Object *parent, const char *id,
+                                    const char *cpu_type, Clock *cpu_refclk,
                                     bool is_big_endian)
 {
     DeviceState *cpu;
 
-    cpu = qdev_new_orphan(cpu_type);
+    cpu = qdev_new(parent, id, cpu_type);
     qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
     object_property_set_bool(OBJECT(cpu), "big-endian", is_big_endian,
                              &error_abort);
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 319147a948..491a190271 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1429,7 +1429,8 @@ void cpu_mips_restore_fp_status(CPUMIPSState *env);
  *
  * Returns: A #CPUState or %NULL if an error occurred.
  */
-MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk,
+MIPSCPU *mips_cpu_create_with_clock(Object *parent, const char *id,
+                                    const char *cpu_type, Clock *cpu_refclk,
                                     bool is_big_endian);
 
 #endif /* MIPS_CPU_H */
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 8e888a19d1..7573c1d67b 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -284,17 +284,6 @@ static void xtensa_cpu_initfn(Object *obj)
 #endif
 }
 
-XtensaCPU *xtensa_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk)
-{
-    DeviceState *cpu;
-
-    cpu = qdev_new_orphan(cpu_type);
-    qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
-    qdev_realize(cpu, NULL, &error_abort);
-
-    return XTENSA_CPU(cpu);
-}
-
 #ifndef CONFIG_USER_ONLY
 static const VMStateDescription vmstate_xtensa_cpu = {
     .name = "cpu",
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 442e98bd1b..019d0b56c1 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -736,8 +736,6 @@ static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 #define XTENSA_CSBASE_LBEG_OFF_MASK 0x00ff0000
 #define XTENSA_CSBASE_LBEG_OFF_SHIFT 16
 
-XtensaCPU *xtensa_cpu_create_with_clock(const char *cpu_type,
-                                        Clock *cpu_refclk);
 
 /*
  * Set the NaN propagation rule for future FPU operations:
-- 
2.47.1


