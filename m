Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7329C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigjT-0005m2-BZ; Sat, 11 Jul 2026 19:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigjR-0005lZ-RD; Sat, 11 Jul 2026 19:03:37 -0400
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.12.53.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigjP-0002hL-HW; Sat, 11 Jul 2026 19:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811015; x=1815347015;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CXOxm0VQ3ug8i73JP92Gty/a5Axf9FdIYmMv6MEY07k=;
 b=bk9rXJ46IXtBVAVnBDWj1gPWPnGphi/OqnwDg8IUwNVMeIBWc2FPIksH
 o4WzxRd/BHeBQUcxiBKXEkF90O9FyUYQHFBCX86JgXTdOoooW/V5jg6JZ
 v424oUl0svyKU/nPRI4Yyhnuw5wqPJd9dgD2IMLaYNDIjatTCBdxYtNCw
 cNeK6TzdCfBkopGfK/IsyDY7i95X4umCWELXU+Qgp7D2ck/6wCMkYO2V/
 2DMbgUocyqL2w+5Z2gVXhsRu9wTwRPG9aLbcSBZL8Xaq1/nOMvPQI9N+d
 jFZWi/QiI+KYgjzEgfPGQBd9DyYgOhtLYYHhu6UaT4K1pdmnsc7fZBBJd Q==;
X-CSE-ConnectionGUID: YQViRy3tQXaepJdQIfyQ3A==
X-CSE-MsgGUID: BgXdbXLFREOiUpzQ3XJoMQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23370040"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:03:32 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:13504]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.175:2525]
 with esmtp (Farcaster)
 id 956b4a00-99b6-4257-9ef4-046b18028040; Sat, 11 Jul 2026 23:03:31 +0000 (UTC)
X-Farcaster-Flow-ID: 956b4a00-99b6-4257-9ef4-046b18028040
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:03:31 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:03:22 +0000
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
Subject: [RFC PATCH 100/134] hw/xtensa: Give memory regions an explicit owner
Date: Sat, 11 Jul 2026 22:36:33 +0000
Message-ID: <20260711223707.42139-101-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
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

Convert memory_region_init*() calls that pass NULL owner to pass
the enclosing machine or device instead.

Thread Object *owner through xtensa_create_memory_regions(), xtensa_mx_pic_register_cpu() and the static xtfpga_fpga_init() helper. All callers are inside board init functions.

No functional change intended.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/xtensa/mx_pic.c         |  4 ++--
 hw/xtensa/sim.c            | 15 ++++++++-------
 hw/xtensa/xtensa_memory.c  |  5 +++--
 hw/xtensa/xtensa_memory.h  |  3 ++-
 hw/xtensa/xtfpga.c         | 30 ++++++++++++++++--------------
 include/hw/xtensa/mx_pic.h |  2 +-
 6 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
index 8ded3bc79b..f349fb125c 100644
--- a/hw/xtensa/mx_pic.c
+++ b/hw/xtensa/mx_pic.c
@@ -299,7 +299,7 @@ static const MemoryRegionOps xtensa_mx_pic_ops = {
     },
 };
 
-MemoryRegion *xtensa_mx_pic_register_cpu(XtensaMxPic *mx,
+MemoryRegion *xtensa_mx_pic_register_cpu(Object *owner, XtensaMxPic *mx,
                                          qemu_irq *irq,
                                          qemu_irq runstall)
 {
@@ -309,7 +309,7 @@ MemoryRegion *xtensa_mx_pic_register_cpu(XtensaMxPic *mx,
     mx_cpu->irq = irq;
     mx_cpu->runstall = runstall;
 
-    memory_region_init_io(&mx_cpu->reg, NULL, &xtensa_mx_pic_ops, mx_cpu,
+    memory_region_init_io(&mx_cpu->reg, owner, &xtensa_mx_pic_ops, mx_cpu,
                           "mx_pic", 0x280);
 
     ++mx->n_cpu;
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index ad1439a0b4..e3cd69ceca 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -60,10 +60,11 @@ XtensaCPU *xtensa_sim_common_init(MachineState *machine)
     XtensaCPU *cpu = NULL;
     CPUXtensaState *env = NULL;
     ram_addr_t ram_size = machine->ram_size;
+    Object *mo = OBJECT(machine);
     int n;
 
     for (n = 0; n < machine->smp.cpus; n++) {
-        cpu = XTENSA_CPU(cpu_create(OBJECT(machine), "cpu[*]", machine->cpu_type));
+        cpu = XTENSA_CPU(cpu_create(mo, "cpu[*]", machine->cpu_type));
         env = &cpu->env;
 
         env->sregs[PRID] = n;
@@ -78,17 +79,17 @@ XtensaCPU *xtensa_sim_common_init(MachineState *machine)
         XtensaMemory sysram = env->config->sysram;
 
         sysram.location[0].size = ram_size;
-        xtensa_create_memory_regions(&env->config->instrom, "xtensa.instrom",
+        xtensa_create_memory_regions(mo, &env->config->instrom, "xtensa.instrom",
                                      get_system_memory());
-        xtensa_create_memory_regions(&env->config->instram, "xtensa.instram",
+        xtensa_create_memory_regions(mo, &env->config->instram, "xtensa.instram",
                                      get_system_memory());
-        xtensa_create_memory_regions(&env->config->datarom, "xtensa.datarom",
+        xtensa_create_memory_regions(mo, &env->config->datarom, "xtensa.datarom",
                                      get_system_memory());
-        xtensa_create_memory_regions(&env->config->dataram, "xtensa.dataram",
+        xtensa_create_memory_regions(mo, &env->config->dataram, "xtensa.dataram",
                                      get_system_memory());
-        xtensa_create_memory_regions(&env->config->sysrom, "xtensa.sysrom",
+        xtensa_create_memory_regions(mo, &env->config->sysrom, "xtensa.sysrom",
                                      get_system_memory());
-        xtensa_create_memory_regions(&sysram, "xtensa.sysram",
+        xtensa_create_memory_regions(mo, &sysram, "xtensa.sysram",
                                      get_system_memory());
     }
     if (serial_hd(0)) {
diff --git a/hw/xtensa/xtensa_memory.c b/hw/xtensa/xtensa_memory.c
index 13a6077d86..4477eea0ad 100644
--- a/hw/xtensa/xtensa_memory.c
+++ b/hw/xtensa/xtensa_memory.c
@@ -31,7 +31,8 @@
 #include "qemu/error-report.h"
 #include "xtensa_memory.h"
 
-void xtensa_create_memory_regions(const XtensaMemory *memory,
+void xtensa_create_memory_regions(Object *owner,
+                                  const XtensaMemory *memory,
                                   const char *name,
                                   MemoryRegion *super)
 {
@@ -43,7 +44,7 @@ void xtensa_create_memory_regions(const XtensaMemory *memory,
 
         g_string_printf(num_name, "%s%u", name, i);
         m = g_new(MemoryRegion, 1);
-        memory_region_init_ram(m, NULL, num_name->str,
+        memory_region_init_ram(m, owner, num_name->str,
                                memory->location[i].size, &error_fatal);
         memory_region_add_subregion(super, memory->location[i].addr, m);
     }
diff --git a/hw/xtensa/xtensa_memory.h b/hw/xtensa/xtensa_memory.h
index c86ad06685..b8b2d4b8b4 100644
--- a/hw/xtensa/xtensa_memory.h
+++ b/hw/xtensa/xtensa_memory.h
@@ -30,7 +30,8 @@
 
 #include "target/xtensa/cpu.h"
 
-void xtensa_create_memory_regions(const XtensaMemory *memory,
+void xtensa_create_memory_regions(Object *owner,
+                                  const XtensaMemory *memory,
                                   const char *name,
                                   MemoryRegion *super);
 
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 1c48283f5d..f0c21180a2 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -125,12 +125,13 @@ static const MemoryRegionOps xtfpga_fpga_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static XtfpgaFpgaState *xtfpga_fpga_init(MemoryRegion *address_space,
+static XtfpgaFpgaState *xtfpga_fpga_init(Object *owner,
+                                         MemoryRegion *address_space,
                                          hwaddr base, uint32_t freq)
 {
     XtfpgaFpgaState *s = g_new(XtfpgaFpgaState, 1);
 
-    memory_region_init_io(&s->iomem, NULL, &xtfpga_fpga_ops, s,
+    memory_region_init_io(&s->iomem, owner, &xtfpga_fpga_ops, s,
                           "xtfpga.fpga", 0x10000);
     memory_region_add_subregion(address_space, base, &s->iomem);
     s->freq = freq;
@@ -243,6 +244,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     uint32_t freq = 10000000;
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
+    Object *mo = OBJECT(machine);
 
     if (smp_cpus > 1) {
         mx_pic = xtensa_mx_pic_init(31);
@@ -262,7 +264,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
         if (mx_pic) {
             MemoryRegion *mx_eri;
 
-            mx_eri = xtensa_mx_pic_register_cpu(mx_pic,
+            mx_eri = xtensa_mx_pic_register_cpu(OBJECT(machine), mx_pic,
                                                 xtensa_get_extints(cenv),
                                                 xtensa_get_runstall(cenv));
             memory_region_add_subregion(xtensa_get_er_region(cenv),
@@ -286,30 +288,30 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
         XtensaMemory sysram = env->config->sysram;
 
         sysram.location[0].size = machine->ram_size;
-        xtensa_create_memory_regions(&env->config->instrom, "xtensa.instrom",
+        xtensa_create_memory_regions(mo, &env->config->instrom, "xtensa.instrom",
                                      system_memory);
-        xtensa_create_memory_regions(&env->config->instram, "xtensa.instram",
+        xtensa_create_memory_regions(mo, &env->config->instram, "xtensa.instram",
                                      system_memory);
-        xtensa_create_memory_regions(&env->config->datarom, "xtensa.datarom",
+        xtensa_create_memory_regions(mo, &env->config->datarom, "xtensa.datarom",
                                      system_memory);
-        xtensa_create_memory_regions(&env->config->dataram, "xtensa.dataram",
+        xtensa_create_memory_regions(mo, &env->config->dataram, "xtensa.dataram",
                                      system_memory);
-        xtensa_create_memory_regions(&sysram, "xtensa.sysram",
+        xtensa_create_memory_regions(mo, &sysram, "xtensa.sysram",
                                      system_memory);
     }
 
     system_io = g_malloc(sizeof(*system_io));
-    memory_region_init_io(system_io, NULL, &xtfpga_io_ops, NULL, "xtfpga.io",
+    memory_region_init_io(system_io, OBJECT(machine), &xtfpga_io_ops, NULL, "xtfpga.io",
                           system_io_size);
     memory_region_add_subregion(system_memory, board->io[0], system_io);
     if (board->io[1]) {
         MemoryRegion *io = g_malloc(sizeof(*io));
 
-        memory_region_init_alias(io, NULL, "xtfpga.io.cached",
+        memory_region_init_alias(io, OBJECT(machine), "xtfpga.io.cached",
                                  system_io, 0, system_io_size);
         memory_region_add_subregion(system_memory, board->io[1], io);
     }
-    xtfpga_fpga_init(system_io, 0x0d020000, freq);
+    xtfpga_fpga_init(OBJECT(machine), system_io, 0x0d020000, freq);
     xtfpga_net_init(system_io, 0x0d030000, 0x0d030400, 0x0d800000, extints[1]);
 
     serial_mm_init(OBJECT(machine), system_io, 0x0d050020, 2, extints[0],
@@ -341,7 +343,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
         lowmem_end += env->config->sysram.location[0].addr;
         cur_lowmem += env->config->sysram.location[0].addr;
 
-        xtensa_create_memory_regions(&env->config->sysrom, "xtensa.sysrom",
+        xtensa_create_memory_regions(mo, &env->config->sysrom, "xtensa.sysrom",
                                      system_memory);
 
         if (kernel_cmdline) {
@@ -465,13 +467,13 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
                 size = board->flash->size - board->flash->boot_base;
             }
 
-            memory_region_init_alias(flash_io, NULL, "xtfpga.flash",
+            memory_region_init_alias(flash_io, OBJECT(machine), "xtfpga.flash",
                                      flash_mr, board->flash->boot_base, size);
             memory_region_add_subregion(system_memory,
                                         env->config->sysrom.location[0].addr,
                                         flash_io);
         } else {
-            xtensa_create_memory_regions(&env->config->sysrom, "xtensa.sysrom",
+            xtensa_create_memory_regions(mo, &env->config->sysrom, "xtensa.sysrom",
                                          system_memory);
         }
     }
diff --git a/include/hw/xtensa/mx_pic.h b/include/hw/xtensa/mx_pic.h
index cd316d86eb..01d5ea884e 100644
--- a/include/hw/xtensa/mx_pic.h
+++ b/include/hw/xtensa/mx_pic.h
@@ -35,7 +35,7 @@ typedef struct XtensaMxPic XtensaMxPic;
 
 XtensaMxPic *xtensa_mx_pic_init(unsigned n_extint);
 void xtensa_mx_pic_reset(void *opaque);
-MemoryRegion *xtensa_mx_pic_register_cpu(XtensaMxPic *mx,
+MemoryRegion *xtensa_mx_pic_register_cpu(Object *owner, XtensaMxPic *mx,
                                          qemu_irq *irq,
                                          qemu_irq runstall);
 qemu_irq *xtensa_mx_pic_get_extints(XtensaMxPic *mx);
-- 
2.47.1


