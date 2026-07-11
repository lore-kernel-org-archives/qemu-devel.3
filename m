Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4230AC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigj9-0005UR-PX; Sat, 11 Jul 2026 19:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigil-0005PW-6T; Sat, 11 Jul 2026 19:02:56 -0400
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.13.214.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigih-0002YQ-51; Sat, 11 Jul 2026 19:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810971; x=1815346971;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Gmd15+SAabzX07bY28nlbu8cJDEIsIgNIuco93iaCqQ=;
 b=F88hCuDiu8RIudgXO4Y7Fs7+DqV7NZ+IB9NkB/SDb1xn2qMxZTzPxNT5
 U6z/2/I6zvbRzyukDWLC3hsqmxzuNDHqo6DI46MmqaoRemqaqPU0mH1/2
 BS61OlQsAiMjP1TOSHFdYLh0rmtCfE8Dd7tBLQCaj19qE29ZAWVdbbVMV
 DH73aLFzuQKdPWu/+hvFHiCcxmWG5KazSShzDVsYIt7wW/DcAdobFsVmm
 LDwBfRIx5OurB3fBh+U8oLeRVqy1JC2+5Qw8+QSaz+vULzlaX4igFIusa
 HsEBBquRpLrAmKZTohYOZDge4nDAoMKomBuCcU5SqfWmCE/eOJI4qfKMq A==;
X-CSE-ConnectionGUID: MeB5+qhvQF2Rr25YL0++zQ==
X-CSE-MsgGUID: orOXU9YyQrWoBFg4QEyMuA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23479679"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:02:35 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:6838]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.33:2525]
 with esmtp (Farcaster)
 id e319b4ac-40a7-4496-a248-a2413f3e68db; Sat, 11 Jul 2026 23:02:35 +0000 (UTC)
X-Farcaster-Flow-ID: e319b4ac-40a7-4496-a248-a2413f3e68db
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:02:35 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:02:26 +0000
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
Subject: [RFC PATCH 096/134] hw/sh4: Give memory regions an explicit owner
Date: Sat, 11 Jul 2026 22:36:29 +0000
Message-ID: <20260711223707.42139-97-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.13.214.179;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert memory_region_init*() calls in the SH7750 SoC model and
its non-QOM sub-block helpers (tmu012_init, sh_intc_init,
r2d_fpga_init) to pass an explicit owner instead of NULL.

Thread Object *owner as the first argument through tmu012_init(),
sh_intc_init() and its static sh_intc_register() helper, and
r2d_fpga_init(). sh7750_init() already carries an Object *parent
from the earlier device conversion; pass it through.

No functional change intended.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/intc/sh_intc.c         | 19 ++++++++++---------
 hw/sh4/r2d.c              |  9 +++++----
 hw/sh4/sh7750.c           | 22 +++++++++++-----------
 hw/timer/sh_timer.c       |  9 +++++----
 include/hw/sh4/sh_intc.h  |  3 ++-
 include/hw/timer/tmu012.h |  3 ++-
 6 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/hw/intc/sh_intc.c b/hw/intc/sh_intc.c
index 0da82f9d5e..37feb6a813 100644
--- a/hw/intc/sh_intc.c
+++ b/hw/intc/sh_intc.c
@@ -349,7 +349,8 @@ void sh_intc_register_sources(struct intc_desc *desc,
     }
 }
 
-static unsigned int sh_intc_register(MemoryRegion *sysmem,
+static unsigned int sh_intc_register(Object *owner,
+                                     MemoryRegion *sysmem,
                                      struct intc_desc *desc,
                                      const unsigned long address,
                                      const char *type,
@@ -368,18 +369,18 @@ static unsigned int sh_intc_register(MemoryRegion *sysmem,
     iomem_a7 = iomem_p4 + 1;
 
     snprintf(name, sizeof(name), "intc-%s-%s-%s", type, action, "p4");
-    memory_region_init_alias(iomem_p4, NULL, name, iomem, A7ADDR(address), 4);
+    memory_region_init_alias(iomem_p4, owner, name, iomem, A7ADDR(address), 4);
     memory_region_add_subregion(sysmem, P4ADDR(address), iomem_p4);
 
     snprintf(name, sizeof(name), "intc-%s-%s-%s", type, action, "a7");
-    memory_region_init_alias(iomem_a7, NULL, name, iomem, A7ADDR(address), 4);
+    memory_region_init_alias(iomem_a7, owner, name, iomem, A7ADDR(address), 4);
     memory_region_add_subregion(sysmem, A7ADDR(address), iomem_a7);
 
     /* used to increment aliases index */
     return 2;
 }
 
-int sh_intc_init(MemoryRegion *sysmem,
+int sh_intc_init(Object *owner, MemoryRegion *sysmem,
                  struct intc_desc *desc,
                  int nr_sources,
                  struct intc_mask_reg *mask_regs,
@@ -403,15 +404,15 @@ int sh_intc_init(MemoryRegion *sysmem,
         desc->sources[i].parent = desc;
     }
     desc->irqs = qemu_allocate_irqs(sh_intc_set_irq, desc, nr_sources);
-    memory_region_init_io(&desc->iomem, NULL, &sh_intc_ops, desc, "intc",
+    memory_region_init_io(&desc->iomem, owner, &sh_intc_ops, desc, "intc",
                           0x100000000ULL);
     j = 0;
     if (desc->mask_regs) {
         for (i = 0; i < desc->nr_mask_regs; i++) {
             struct intc_mask_reg *mr = &desc->mask_regs[i];
 
-            j += sh_intc_register(sysmem, desc, mr->set_reg, "mask", "set", j);
-            j += sh_intc_register(sysmem, desc, mr->clr_reg, "mask", "clr", j);
+            j += sh_intc_register(owner, sysmem, desc, mr->set_reg, "mask", "set", j);
+            j += sh_intc_register(owner, sysmem, desc, mr->clr_reg, "mask", "clr", j);
         }
     }
 
@@ -419,8 +420,8 @@ int sh_intc_init(MemoryRegion *sysmem,
         for (i = 0; i < desc->nr_prio_regs; i++) {
             struct intc_prio_reg *pr = &desc->prio_regs[i];
 
-            j += sh_intc_register(sysmem, desc, pr->set_reg, "prio", "set", j);
-            j += sh_intc_register(sysmem, desc, pr->clr_reg, "prio", "clr", j);
+            j += sh_intc_register(owner, sysmem, desc, pr->set_reg, "prio", "set", j);
+            j += sh_intc_register(owner, sysmem, desc, pr->clr_reg, "prio", "clr", j);
         }
     }
 
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 6154aed2c4..8deda6e5f4 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -187,7 +187,8 @@ static const MemoryRegionOps r2d_fpga_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static r2d_fpga_t *r2d_fpga_init(MemoryRegion *sysmem,
+static r2d_fpga_t *r2d_fpga_init(Object *owner,
+                                 MemoryRegion *sysmem,
                                  hwaddr base, qemu_irq irl)
 {
     r2d_fpga_t *s;
@@ -196,7 +197,7 @@ static r2d_fpga_t *r2d_fpga_init(MemoryRegion *sysmem,
 
     s->irl = irl;
 
-    memory_region_init_io(&s->iomem, NULL, &r2d_fpga_ops, s, "r2d-fpga", 0x40);
+    memory_region_init_io(&s->iomem, owner, &r2d_fpga_ops, s, "r2d-fpga", 0x40);
     memory_region_add_subregion(sysmem, base, &s->iomem);
 
     qemu_init_irqs(s->irq, NR_IRQS, r2d_fpga_irq_set, s);
@@ -261,11 +262,11 @@ static void r2d_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
 
     /* Allocate memory space */
-    memory_region_init_ram(sdram, NULL, "r2d.sdram", SDRAM_SIZE, &error_fatal);
+    memory_region_init_ram(sdram, OBJECT(machine), "r2d.sdram", SDRAM_SIZE, &error_fatal);
     memory_region_add_subregion(address_space_mem, SDRAM_BASE, sdram);
     /* Register peripherals */
     s = sh7750_init(OBJECT(machine), cpu, address_space_mem);
-    fpga = r2d_fpga_init(address_space_mem, 0x04000000, sh7750_irl(s));
+    fpga = r2d_fpga_init(OBJECT(machine), address_space_mem, 0x04000000, sh7750_irl(s));
 
     dev = qdev_new(OBJECT(machine), "pci-host", "sh_pci");
     busdev = SYS_BUS_DEVICE(dev);
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index ff9724fadf..ea55a3a9cc 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -721,38 +721,38 @@ SH7750State *sh7750_init(Object *parent, SuperHCPU *cpu,
     s = g_new0(SH7750State, 1);
     s->cpu = cpu;
     s->periph_freq = 60000000; /* 60MHz */
-    memory_region_init_io(&s->iomem, NULL, &sh7750_mem_ops, s,
+    memory_region_init_io(&s->iomem, parent, &sh7750_mem_ops, s,
                           "memory", 0x1fc01000);
 
-    memory_region_init_alias(&s->iomem_1f0, NULL, "memory-1f0",
+    memory_region_init_alias(&s->iomem_1f0, parent, "memory-1f0",
                              &s->iomem, 0x1f000000, 0x1000);
     memory_region_add_subregion(sysmem, 0x1f000000, &s->iomem_1f0);
 
-    memory_region_init_alias(&s->iomem_ff0, NULL, "memory-ff0",
+    memory_region_init_alias(&s->iomem_ff0, parent, "memory-ff0",
                              &s->iomem, 0x1f000000, 0x1000);
     memory_region_add_subregion(sysmem, 0xff000000, &s->iomem_ff0);
 
-    memory_region_init_alias(&s->iomem_1f8, NULL, "memory-1f8",
+    memory_region_init_alias(&s->iomem_1f8, parent, "memory-1f8",
                              &s->iomem, 0x1f800000, 0x1000);
     memory_region_add_subregion(sysmem, 0x1f800000, &s->iomem_1f8);
 
-    memory_region_init_alias(&s->iomem_ff8, NULL, "memory-ff8",
+    memory_region_init_alias(&s->iomem_ff8, parent, "memory-ff8",
                              &s->iomem, 0x1f800000, 0x1000);
     memory_region_add_subregion(sysmem, 0xff800000, &s->iomem_ff8);
 
-    memory_region_init_alias(&s->iomem_1fc, NULL, "memory-1fc",
+    memory_region_init_alias(&s->iomem_1fc, parent, "memory-1fc",
                              &s->iomem, 0x1fc00000, 0x1000);
     memory_region_add_subregion(sysmem, 0x1fc00000, &s->iomem_1fc);
 
-    memory_region_init_alias(&s->iomem_ffc, NULL, "memory-ffc",
+    memory_region_init_alias(&s->iomem_ffc, parent, "memory-ffc",
                              &s->iomem, 0x1fc00000, 0x1000);
     memory_region_add_subregion(sysmem, 0xffc00000, &s->iomem_ffc);
 
-    memory_region_init_io(&s->mmct_iomem, NULL, &sh7750_mmct_ops, s,
+    memory_region_init_io(&s->mmct_iomem, parent, &sh7750_mmct_ops, s,
                           "cache-and-tlb", 0x08000000);
     memory_region_add_subregion(sysmem, 0xf0000000, &s->mmct_iomem);
 
-    sh_intc_init(sysmem, &s->intc, NR_SOURCES,
+    sh_intc_init(parent, sysmem, &s->intc, NR_SOURCES,
                  _INTC_ARRAY(mask_registers),
                  _INTC_ARRAY(prio_registers));
 
@@ -797,7 +797,7 @@ SH7750State *sh7750_init(Object *parent, SuperHCPU *cpu,
     qdev_connect_gpio_out_named(dev, "txi", 0, s->intc.irqs[SCIF_TXI]);
     qdev_connect_gpio_out_named(dev, "bri", 0, s->intc.irqs[SCIF_BRI]);
 
-    tmu012_init(sysmem, 0x1fd80000,
+    tmu012_init(parent, sysmem, 0x1fd80000,
                 TMU012_FEAT_TOCR | TMU012_FEAT_3CHAN | TMU012_FEAT_EXTCLK,
                 s->periph_freq,
                 s->intc.irqs[TMU0],
@@ -821,7 +821,7 @@ SH7750State *sh7750_init(Object *parent, SuperHCPU *cpu,
         sh_intc_register_sources(&s->intc,
                                  _INTC_ARRAY(vectors_tmu34),
                                  NULL, 0);
-        tmu012_init(sysmem, 0x1e100000, 0, s->periph_freq,
+        tmu012_init(parent, sysmem, 0x1e100000, 0, s->periph_freq,
                     s->intc.irqs[TMU3],
                     s->intc.irqs[TMU4],
                     NULL, NULL);
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index 41ece9c613..ac71d11a0a 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -344,7 +344,8 @@ static const MemoryRegionOps tmu012_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-void tmu012_init(MemoryRegion *sysmem, hwaddr base, int feat, uint32_t freq,
+void tmu012_init(Object *owner, MemoryRegion *sysmem, hwaddr base,
+                 int feat, uint32_t freq,
                  qemu_irq ch0_irq, qemu_irq ch1_irq,
                  qemu_irq ch2_irq0, qemu_irq ch2_irq1)
 {
@@ -360,13 +361,13 @@ void tmu012_init(MemoryRegion *sysmem, hwaddr base, int feat, uint32_t freq,
                                     ch2_irq0); /* ch2_irq1 not supported */
     }
 
-    memory_region_init_io(&s->iomem, NULL, &tmu012_ops, s, "timer", 0x30);
+    memory_region_init_io(&s->iomem, owner, &tmu012_ops, s, "timer", 0x30);
 
-    memory_region_init_alias(&s->iomem_p4, NULL, "timer-p4",
+    memory_region_init_alias(&s->iomem_p4, owner, "timer-p4",
                              &s->iomem, 0, memory_region_size(&s->iomem));
     memory_region_add_subregion(sysmem, P4ADDR(base), &s->iomem_p4);
 
-    memory_region_init_alias(&s->iomem_a7, NULL, "timer-a7",
+    memory_region_init_alias(&s->iomem_a7, owner, "timer-a7",
                              &s->iomem, 0, memory_region_size(&s->iomem));
     memory_region_add_subregion(sysmem, A7ADDR(base), &s->iomem_a7);
     /* ??? Save/restore.  */
diff --git a/include/hw/sh4/sh_intc.h b/include/hw/sh4/sh_intc.h
index 94f183121e..d391710987 100644
--- a/include/hw/sh4/sh_intc.h
+++ b/include/hw/sh4/sh_intc.h
@@ -2,6 +2,7 @@
 #define SH_INTC_H
 
 #include "system/memory.h"
+#include "qom/object.h"
 
 typedef unsigned char intc_enum;
 
@@ -68,7 +69,7 @@ void sh_intc_register_sources(struct intc_desc *desc,
                               struct intc_group *groups,
                               int nr_groups);
 
-int sh_intc_init(MemoryRegion *sysmem,
+int sh_intc_init(Object *owner, MemoryRegion *sysmem,
                  struct intc_desc *desc,
                  int nr_sources,
                  struct intc_mask_reg *mask_regs,
diff --git a/include/hw/timer/tmu012.h b/include/hw/timer/tmu012.h
index 808ed8de1d..fb24c00d3b 100644
--- a/include/hw/timer/tmu012.h
+++ b/include/hw/timer/tmu012.h
@@ -10,12 +10,13 @@
 #define HW_TIMER_TMU012_H
 
 #include "exec/hwaddr.h"
+#include "qom/object.h"
 
 #define TMU012_FEAT_TOCR   (1 << 0)
 #define TMU012_FEAT_3CHAN  (1 << 1)
 #define TMU012_FEAT_EXTCLK (1 << 2)
 
-void tmu012_init(MemoryRegion *sysmem, hwaddr base,
+void tmu012_init(Object *owner, MemoryRegion *sysmem, hwaddr base,
                  int feat, uint32_t freq,
                  qemu_irq ch0_irq, qemu_irq ch1_irq,
                  qemu_irq ch2_irq0, qemu_irq ch2_irq1);
-- 
2.47.1


