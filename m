Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9070C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD8q-0006Rf-7p; Sat, 18 Jul 2026 18:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD8o-0006HL-2V; Sat, 18 Jul 2026 18:04:14 -0400
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.83.148.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD8l-0005Rn-FW; Sat, 18 Jul 2026 18:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412251; x=1815948251;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UszJO6dpHUEc0oBzDpMHf6YsdxQvwRUTymqKhrUJFdA=;
 b=DZmxuPyjq/yAtXVSf6jvF8d0SuXeaHQo3vonn2klBSoHL7JX3w7hy75s
 il8ifrGRUWDiJXJUAObWGeYzNzLghJdZQBnPhToxpXDOw/S4XW8nsljms
 HYGiuDXJEIenS6Fuu5B/EHTLEqd6/8Du3AIRbeEF7jqJ1LGV26AjC0NqY
 dGeDEm1w4nIyYxKhl7r6DSNo6viCtNzGmfl50B7aorxwGUHLjIaq7EuZP
 HFgIJ5+Dgkw8qtlX/wSx8I5GkCaQcu1ceg+8uincQ8DDhH/5NE5EcBeO2
 TEm0nKNvgBVBEbHicEzt1El/9R4L7+9uyw3ikuXAPi92NVt/gSZWk1dOI A==;
X-CSE-ConnectionGUID: AE+D3zhRRD23ufJ/47GRng==
X-CSE-MsgGUID: VCmEqhMbRty0qYOrg+Cm7A==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23713038"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:04:07 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:3999]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.177:2525]
 with esmtp (Farcaster)
 id 70796ffa-92d7-4d44-9450-44f775fab9bc; Sat, 18 Jul 2026 22:04:07 +0000 (UTC)
X-Farcaster-Flow-ID: 70796ffa-92d7-4d44-9450-44f775fab9bc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:04:07 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:03:57 +0000
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
Subject: [RFC PATCH v2 097/137] hw/sh4: Give memory regions an explicit owner
Date: Sat, 18 Jul 2026 21:36:12 +0000
Message-ID: <20260718213652.37673-98-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.83.148.184;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert memory_region_init*() calls in the SH7750 SoC model and
its non-QOM sub-block helpers (tmu012_init, sh_intc_init,
r2d_fpga_init) to pass an explicit owner instead of NULL.

Thread Object *owner as the first argument through tmu012_init(),
sh_intc_init() and its static sh_intc_register() helper, and
r2d_fpga_init(). sh7750_init() already carries an Object *parent
from the earlier device conversion; pass it through.

No functional change intended.

RAMBlock idstrs are unchanged: the owners added here are Machine
or SysBus devices, and memory_region_register_ram() maps both to
dev=NULL for qemu_ram_set_idstr().

AI-used-for: code (refactoring)
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


