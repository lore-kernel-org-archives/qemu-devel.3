Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024BAC4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlClF-00030s-LA; Sat, 18 Jul 2026 17:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCl5-0002ny-GL; Sat, 18 Jul 2026 17:39:44 -0400
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.13.214.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCl1-00025p-Op; Sat, 18 Jul 2026 17:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784410779; x=1815946779;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VPXZ5oufGK6iiKeqRU37vBXb9Gf3bdR2KTWvztToIpo=;
 b=bhgVNw51cp43CS6+46Lg+MXW/sKBxr7Z3WtNz7CqqpRE6snuBNa23ypu
 hLpAqC9UTgL+KVgsAl8sfGt1Vx222oniCbPEK3NeabnSS0kNG/uN6gOSe
 ckTAEmzvXY4LGhq+98+G62PeBV7iOe54MR2NSsmzPXP0eDb5cPzYX8CFQ
 F/SxJSUz7kTtktlGdT71ACMDQtX1FT538hj/7TYry7g/9dWO6q/YXh0xs
 52OFEl/9Y5fNLOhLuqrl0RvbZIUp8wzpO4tZS6aL0oS6nvWk31nDADRFV
 VDpZ6yYSZvJNwyqwFxDHa/BWdbhLhn1HBUDiPb7DGZq+IquGT2ZqHS48z Q==;
X-CSE-ConnectionGUID: YdAJvaFlQ3CsWSNCVBs2WQ==
X-CSE-MsgGUID: b2AUPqtNTWaN0Uu2rGcgpQ==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23903583"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:39:36 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:29025]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.34:2525]
 with esmtp (Farcaster)
 id 7687f1f1-42b7-4909-adea-36dbff4460f1; Sat, 18 Jul 2026 21:39:35 +0000 (UTC)
X-Farcaster-Flow-ID: 7687f1f1-42b7-4909-adea-36dbff4460f1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:39:35 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:39:26 +0000
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
Subject: [RFC PATCH v2 009/137] cpu: Make cpu_create() take a QOM parent
Date: Sat, 18 Jul 2026 21:34:44 +0000
Message-ID: <20260718213652.37673-10-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
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

CPUs are the single largest source of orphans in /machine/unattached
because virtually every board that isn't SoC-based creates them via
cpu_create(), which calls object_new() with no parent.  This is also
where the user-visible garbage in query-cpus-fast comes from: qom_path
reads /machine/unattached/device[N] instead of /machine/cpu[N].

Apply the same rename-and-reintroduce treatment: mechanically rename
cpu_create() to cpu_create_orphan() and reintroduce cpu_create()
with a leading (parent, id, ...) pair built on object_new_child().
On realize failure the parented variant unparents (rather than
unrefs) since the sole reference is held by the parent.

The mechanical rename part is generated by

  spatch --sp-file \
      scripts/coccinelle/qom-parent/cpu-create-orphan.cocci \
      --in-place --include-headers --dir .

or equivalently

  git ls-files '*.[ch]' '*.[ch].inc' '*.rst' '*.py' | \
      grep -v '^subprojects/' | \
      xargs sed -i 's/\bcpu_create\b/cpu_create_orphan/g'

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 bsd-user/main.c                                   |  2 +-
 hw/alpha/dp264.c                                  |  2 +-
 hw/arm/musicpal.c                                 |  2 +-
 hw/arm/omap1.c                                    |  2 +-
 hw/arm/strongarm.c                                |  2 +-
 hw/core/cpu-common.c                              | 14 +++++++++++++-
 hw/core/null-machine.c                            |  2 +-
 hw/hppa/machine.c                                 |  2 +-
 hw/m68k/an5206.c                                  |  2 +-
 hw/m68k/mcf5208.c                                 |  2 +-
 hw/m68k/next-cube.c                               |  2 +-
 hw/m68k/virt.c                                    |  2 +-
 hw/or1k/or1k-sim.c                                |  2 +-
 hw/or1k/virt.c                                    |  2 +-
 hw/ppc/amigaone.c                                 |  2 +-
 hw/ppc/mac_newworld.c                             |  2 +-
 hw/ppc/mac_oldworld.c                             |  2 +-
 hw/ppc/pegasos.c                                  |  2 +-
 hw/ppc/ppc440_bamboo.c                            |  2 +-
 hw/ppc/prep.c                                     |  2 +-
 hw/ppc/sam460ex.c                                 |  2 +-
 hw/ppc/virtex_ml507.c                             |  2 +-
 hw/sh4/r2d.c                                      |  2 +-
 hw/tricore/tricore_testboard.c                    |  2 +-
 hw/xtensa/sim.c                                   |  2 +-
 hw/xtensa/xtfpga.c                                |  2 +-
 include/hw/core/cpu.h                             | 15 ++++++++++++++-
 linux-user/main.c                                 |  4 ++--
 .../coccinelle/qom-parent/cpu-create-orphan.cocci | 13 +++++++++++++
 29 files changed, 67 insertions(+), 29 deletions(-)
 create mode 100644 scripts/coccinelle/qom-parent/cpu-create-orphan.cocci

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 694481ae3e..5269ea42a5 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -474,7 +474,7 @@ int main(int argc, char **argv)
     set_preferred_target_page_bits(ctz32(host_page_size));
     finalize_target_page_bits();
 
-    cpu = cpu_create(cpu_type);
+    cpu = cpu_create_orphan(cpu_type);
     env = cpu_env(cpu);
     cpu_reset(cpu);
     thread_cpu = cpu;
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index b07dcebaa0..512b270838 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -65,7 +65,7 @@ static void clipper_init(MachineState *machine)
     /* Create up to 4 cpus.  */
     memset(cpus, 0, sizeof(cpus));
     for (i = 0; i < smp_cpus; ++i) {
-        cpus[i] = ALPHA_CPU(cpu_create(machine->cpu_type));
+        cpus[i] = ALPHA_CPU(cpu_create_orphan(machine->cpu_type));
     }
 
     /*
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index baab159bfd..a07359813e 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1232,7 +1232,7 @@ static void musicpal_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    cpu = ARM_CPU(cpu_create(machine->cpu_type));
+    cpu = ARM_CPU(cpu_create_orphan(machine->cpu_type));
 
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 9115d12fad..eefa2e441a 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3749,7 +3749,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     MemoryRegion *system_memory = get_system_memory();
 
     /* Core */
-    s->cpu = ARM_CPU(cpu_create(cpu_type));
+    s->cpu = ARM_CPU(cpu_create_orphan(cpu_type));
     s->sdram_size = memory_region_size(dram);
     s->sram_size = OMAP15XX_SRAM_SIZE;
 
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index f67aaa23ed..1704db8baa 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1620,7 +1620,7 @@ StrongARMState *sa1110_init(const char *cpu_type)
         exit(1);
     }
 
-    s->cpu = ARM_CPU(cpu_create(cpu_type));
+    s->cpu = ARM_CPU(cpu_create_orphan(cpu_type));
 
     s->pic = sysbus_create_varargs_orphan("strongarm_pic", 0x90050000,
                     qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ),
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index e314f916f8..eef243c1ad 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -56,7 +56,19 @@ bool cpu_exists(int64_t id)
     return !!cpu_by_arch_id(id);
 }
 
-CPUState *cpu_create(const char *typename)
+CPUState *cpu_create(Object *parent, const char *id, const char *typename)
+{
+    Error *err = NULL;
+    CPUState *cpu = CPU(object_new_child(parent, id, typename));
+    if (!qdev_realize(DEVICE(cpu), NULL, &err)) {
+        error_report_err(err);
+        object_unparent(OBJECT(cpu));
+        exit(EXIT_FAILURE);
+    }
+    return cpu;
+}
+
+CPUState *cpu_create_orphan(const char *typename)
 {
     Error *err = NULL;
     CPUState *cpu = CPU(object_new(typename));
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index f132a7b89b..7cc4b9ab3b 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -25,7 +25,7 @@ static void machine_none_init(MachineState *mch)
 
     /* Initialize CPU (if user asked for it) */
     if (mch->cpu_type) {
-        cpu = cpu_create(mch->cpu_type);
+        cpu = cpu_create_orphan(mch->cpu_type);
         if (!cpu) {
             error_report("Unable to initialize CPU");
             exit(1);
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 44dab9225a..a4b8e9ee77 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -298,7 +298,7 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
 
     /* Create CPUs.  */
     for (unsigned int i = 0; i < smp_cpus; i++) {
-        cpu[i] = HPPA_CPU(cpu_create(machine->cpu_type));
+        cpu[i] = HPPA_CPU(cpu_create_orphan(machine->cpu_type));
     }
 
     /* Initialize memory */
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index f29c3b5226..b649605140 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -46,7 +46,7 @@ static void an5206_init(MachineState *machine)
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *sram = g_new(MemoryRegion, 1);
 
-    cpu = M68K_CPU(cpu_create(machine->cpu_type));
+    cpu = M68K_CPU(cpu_create_orphan(machine->cpu_type));
     env = &cpu->env;
 
     /* Initialize CPU registers.  */
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index a8068c91f2..d79ec173e6 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -288,7 +288,7 @@ static void mcf5208evb_init(MachineState *machine)
     MemoryRegion *sram = g_new(MemoryRegion, 1);
     DeviceState *intc;
 
-    cpu = M68K_CPU(cpu_create(machine->cpu_type));
+    cpu = M68K_CPU(cpu_create_orphan(machine->cpu_type));
     env = &cpu->env;
 
     /* Initialize CPU registers.  */
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 0c1f5b4481..d97168d9f3 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1260,7 +1260,7 @@ static void next_cube_init(MachineState *machine)
     DeviceState *pcdev;
 
     /* Initialize the cpu core */
-    cpu = M68K_CPU(cpu_create(machine->cpu_type));
+    cpu = M68K_CPU(cpu_create_orphan(machine->cpu_type));
     if (!cpu) {
         error_report("Unable to find m68k CPU definition");
         exit(1);
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index e2af0196e8..64ac8c8166 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -145,7 +145,7 @@ static void virt_init(MachineState *machine)
     reset_info = g_new0(ResetInfo, 1);
 
     /* init CPUs */
-    cpu = M68K_CPU(cpu_create(machine->cpu_type));
+    cpu = M68K_CPU(cpu_create_orphan(machine->cpu_type));
 
     reset_info->cpu = cpu;
     qemu_register_reset(main_cpu_reset, reset_info);
diff --git a/hw/or1k/or1k-sim.c b/hw/or1k/or1k-sim.c
index bd668d0e47..6962313315 100644
--- a/hw/or1k/or1k-sim.c
+++ b/hw/or1k/or1k-sim.c
@@ -299,7 +299,7 @@ static void openrisc_sim_init(MachineState *machine)
 
     assert(smp_cpus >= 1 && smp_cpus <= OR1KSIM_CPUS_MAX);
     for (n = 0; n < smp_cpus; n++) {
-        cpus[n] = OPENRISC_CPU(cpu_create(machine->cpu_type));
+        cpus[n] = OPENRISC_CPU(cpu_create_orphan(machine->cpu_type));
         if (cpus[n] == NULL) {
             fprintf(stderr, "Unable to find CPU definition!\n");
             exit(1);
diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index 9451a0b7df..f222efafde 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -481,7 +481,7 @@ static void openrisc_virt_init(MachineState *machine)
 
     assert(smp_cpus >= 1 && smp_cpus <= VIRT_CPUS_MAX);
     for (n = 0; n < smp_cpus; n++) {
-        cpus[n] = OPENRISC_CPU(cpu_create(machine->cpu_type));
+        cpus[n] = OPENRISC_CPU(cpu_create_orphan(machine->cpu_type));
         if (cpus[n] == NULL) {
             fprintf(stderr, "Unable to find CPU definition!\n");
             exit(1);
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index c6b331ff16..80802d42c6 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -279,7 +279,7 @@ static void amigaone_init(MachineState *machine)
     struct boot_info *bi = NULL;
 
     /* init CPU */
-    cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
+    cpu = POWERPC_CPU(cpu_create_orphan(machine->cpu_type));
     env = &cpu->env;
     if (PPC_INPUT(env) != PPC_FLAGS_INPUT_6xx) {
         error_report("Incompatible CPU, only 6xx bus supported");
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 72baeef60a..8c46ecd6d1 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -159,7 +159,7 @@ static void ppc_core99_init(MachineState *machine)
 
     /* init CPUs */
     for (i = 0; i < machine->smp.cpus; i++) {
-        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
+        cpu = POWERPC_CPU(cpu_create_orphan(machine->cpu_type));
         env = &cpu->env;
 
         /* Set time-base frequency to 100 Mhz */
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index e6c5830c38..4c5746b754 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -111,7 +111,7 @@ static void ppc_heathrow_init(MachineState *machine)
 
     /* init CPUs */
     for (i = 0; i < machine->smp.cpus; i++) {
-        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
+        cpu = POWERPC_CPU(cpu_create_orphan(machine->cpu_type));
         env = &cpu->env;
 
         /* Set time-base frequency to 16.6 Mhz */
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 0030068ab3..bba73f60c8 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -163,7 +163,7 @@ static void pegasos_init(MachineState *machine)
     uint8_t *spd_data;
 
     /* init CPU */
-    pm->cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
+    pm->cpu = POWERPC_CPU(cpu_create_orphan(machine->cpu_type));
     env = &pm->cpu->env;
     if (PPC_INPUT(env) != PPC_FLAGS_INPUT_6xx) {
         error_report("Incompatible CPU, only 6xx bus supported");
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 7a6c3ebec5..68c7328129 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -148,7 +148,7 @@ static void bamboo_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
+    cpu = POWERPC_CPU(cpu_create_orphan(machine->cpu_type));
     env = &cpu->env;
 
     if (env->mmu_model != POWERPC_MMU_BOOKE) {
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 32a28bc12a..c861e022f0 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -257,7 +257,7 @@ static void ibm_40p_init(MachineState *machine)
     }
 
     /* init CPU */
-    cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
+    cpu = POWERPC_CPU(cpu_create_orphan(machine->cpu_type));
     env = &cpu->env;
     if (PPC_INPUT(env) != PPC_FLAGS_INPUT_6xx) {
         error_report("only 6xx bus is supported on this machine");
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 39e704dfaa..d23d2c2bd8 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -260,7 +260,7 @@ static void sam460ex_init(MachineState *machine)
     uint8_t *spd_data;
     int success;
 
-    cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
+    cpu = POWERPC_CPU(cpu_create_orphan(machine->cpu_type));
     env = &cpu->env;
     if (env->mmu_model != POWERPC_MMU_BOOKE) {
         error_report("Only MMU model BookE is supported by this machine.");
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index d7fd72d353..9163d8acf8 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -76,7 +76,7 @@ static PowerPCCPU *ppc440_init_xilinx(const char *cpu_type, uint32_t sysclk)
     DeviceState *uicdev;
     SysBusDevice *uicsbd;
 
-    cpu = POWERPC_CPU(cpu_create(cpu_type));
+    cpu = POWERPC_CPU(cpu_create_orphan(cpu_type));
     env = &cpu->env;
 
     ppc_booke_timers_init(cpu, sysclk, 0/* no flags */);
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 6f8d270fae..9f313a77cb 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -251,7 +251,7 @@ static void r2d_init(MachineState *machine)
     USBBus *usb_bus;
     r2d_fpga_t *fpga;
 
-    cpu = SUPERH_CPU(cpu_create(machine->cpu_type));
+    cpu = SUPERH_CPU(cpu_create_orphan(machine->cpu_type));
     env = &cpu->env;
 
     reset_info = g_new0(ResetData, 1);
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index afed9ad0ae..69794d3445 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -67,7 +67,7 @@ static void tricore_testboard_init(MachineState *machine, int board_id)
     MemoryRegion *pcp_data = g_new(MemoryRegion, 1);
     MemoryRegion *pcp_text = g_new(MemoryRegion, 1);
 
-    cpu = TRICORE_CPU(cpu_create(machine->cpu_type));
+    cpu = TRICORE_CPU(cpu_create_orphan(machine->cpu_type));
     env = &cpu->env;
     memory_region_init_ram(ext_cram, NULL, "powerlink_ext_c.ram",
                            2 * MiB, &error_fatal);
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 835cd04fe0..17245a0388 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -63,7 +63,7 @@ XtensaCPU *xtensa_sim_common_init(MachineState *machine)
     int n;
 
     for (n = 0; n < machine->smp.cpus; n++) {
-        cpu = XTENSA_CPU(cpu_create(machine->cpu_type));
+        cpu = XTENSA_CPU(cpu_create_orphan(machine->cpu_type));
         env = &cpu->env;
 
         env->sregs[PRID] = n;
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 4b1009a398..0ee7350945 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -250,7 +250,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     for (n = 0; n < smp_cpus; n++) {
         CPUXtensaState *cenv = NULL;
 
-        cpu = XTENSA_CPU(cpu_create(machine->cpu_type));
+        cpu = XTENSA_CPU(cpu_create_orphan(machine->cpu_type));
         cenv = &cpu->env;
         if (!env) {
             env = cenv;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b54035fb13..1b2ec1ab1e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -846,13 +846,26 @@ char *cpu_model_from_type(const char *typename);
 
 /**
  * cpu_create:
+ * @parent: the QOM parent (usually the machine or SoC container)
+ * @id: child<> property name, e.g. "cpu[0]" or "cpu[*]"
+ * @typename: the CPU type
+ *
+ * Instantiates a CPU as a child of @parent under @id and realizes it.
+ * The returned CPU is owned by @parent.
+ *
+ * Returns: A #CPUState.  Failure to realize is fatal.
+ */
+CPUState *cpu_create(Object *parent, const char *id, const char *typename);
+
+/**
+ * cpu_create_orphan:
  * @typename: The CPU type.
  *
  * Instantiates a CPU and realizes the CPU.
  *
  * Returns: A #CPUState or %NULL if an error occurred.
  */
-CPUState *cpu_create(const char *typename);
+CPUState *cpu_create_orphan(const char *typename);
 
 /**
  * parse_cpu_option:
diff --git a/linux-user/main.c b/linux-user/main.c
index 60a695b7ca..966322dbb3 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -235,7 +235,7 @@ void init_task_state(TaskState *ts)
 CPUArchState *cpu_copy(CPUArchState *env)
 {
     CPUState *cpu = env_cpu(env);
-    CPUState *new_cpu = cpu_create(cpu_type);
+    CPUState *new_cpu = cpu_create_orphan(cpu_type);
     CPUArchState *new_env = cpu_env(new_cpu);
     CPUBreakpoint *bp;
 
@@ -817,7 +817,7 @@ int main(int argc, char **argv, char **envp)
     set_preferred_target_page_bits(ctz32(host_page_size));
     finalize_target_page_bits();
 
-    cpu = cpu_create(cpu_type);
+    cpu = cpu_create_orphan(cpu_type);
     env = cpu_env(cpu);
     cpu_reset(cpu);
     thread_cpu = cpu;
diff --git a/scripts/coccinelle/qom-parent/cpu-create-orphan.cocci b/scripts/coccinelle/qom-parent/cpu-create-orphan.cocci
new file mode 100644
index 0000000000..c268c05b0c
--- /dev/null
+++ b/scripts/coccinelle/qom-parent/cpu-create-orphan.cocci
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Rename cpu_create() to cpu_create_orphan() so that the short
+// name can be reintroduced with a mandatory (parent, id, type)
+// signature.
+//
+// spatch --sp-file scripts/coccinelle/qom-parent/cpu-create-orphan.cocci \
+//        --in-place --include-headers --dir .
+
+@@
+@@
+- cpu_create
++ cpu_create_orphan
-- 
2.47.1


