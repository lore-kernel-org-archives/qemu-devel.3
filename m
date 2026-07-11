Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A857C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigle-0002k1-KG; Sat, 11 Jul 2026 19:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigld-0002eO-6k; Sat, 11 Jul 2026 19:05:53 -0400
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([34.218.115.239])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wiglY-0003Kz-Tj; Sat, 11 Jul 2026 19:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811148; x=1815347148;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HmGyU68MNWFytBn0GA7orhGnkSlOwbqt5winEMY98VU=;
 b=mgrcTo8PFm9QC2t+AWQ/seSnPdDVzWjreYtgvYpgqROooXk7O7guT3q4
 nf5gm5OKL0JU9sirqs4IaJCePin/MBncPmhkDdAvAK7qBtHT1byHiuLv9
 g2wQJ73myTMjRyb6BPGL4NLkM0rb0hEbs8XWVY4f0AVEvnX9XACKrYHoo
 k4HbY8tLTcnD/0TllWQJpRcZeYE8d4F09YdrDmIIpOFegx1iWv6yXVpfg
 Bo1Ne3K2nfnruJPDmjI3oQxe3jYeLDQiGXxVbckggOSCHZV3Q7SnuPAEP
 g2sxi6bREYbyiB5avKRffxcnropfFIy/el2W+KcJCqjcqG+p8tqFsLhXG A==;
X-CSE-ConnectionGUID: 878m59ZuTCyFTcRh58kEzw==
X-CSE-MsgGUID: xbxyYvCOTiedCllKr9eJdQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23296929"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:05:45 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:28601]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.135:2525]
 with esmtp (Farcaster)
 id 426a84de-0de4-4abb-9543-e6408b10fba2; Sat, 11 Jul 2026 23:05:44 +0000 (UTC)
X-Farcaster-Flow-ID: 426a84de-0de4-4abb-9543-e6408b10fba2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:05:44 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:05:35 +0000
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
Subject: [RFC PATCH 108/134] irq: Rename qemu_allocate_irq*() and friends to
 *_orphan()
Date: Sat, 11 Jul 2026 22:36:41 +0000
Message-ID: <20260711223707.42139-109-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=34.218.115.239;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Mechanical rename of the IRQ allocation helpers that create an
IRQState via object_new() with no QOM parent:

  qemu_allocate_irq   -> qemu_allocate_irq_orphan
  qemu_allocate_irqs  -> qemu_allocate_irqs_orphan
  qemu_extend_irqs    -> qemu_extend_irqs_orphan
  qemu_irq_invert     -> qemu_irq_invert_orphan

The next commit reintroduces the well-known names with a mandatory
(owner, name, ...) prefix, and later commits convert every caller
per subdirectory before deleting the *_orphan() variants.

Coccinelle: scripts/coccinelle/qom-parent/irq-rename.cocci

  git ls-files '*.c' '*.h' | grep -v '^subprojects/' |
    xargs sed -i -e 's/\bqemu_allocate_irqs\b/qemu_allocate_irqs_orphan/g' \
                 -e 's/\bqemu_allocate_irq\b/qemu_allocate_irq_orphan/g' \
                 -e 's/\bqemu_extend_irqs\b/qemu_extend_irqs_orphan/g' \
                 -e 's/\bqemu_irq_invert\b/qemu_irq_invert_orphan/g'

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/alpha/typhoon.c                             |  4 ++--
 hw/arm/armsse.c                                |  4 ++--
 hw/arm/exynos4_boards.c                        |  2 +-
 hw/arm/mps2-tz.c                               |  2 +-
 hw/arm/omap1.c                                 | 14 +++++++-------
 hw/arm/realview.c                              |  2 +-
 hw/arm/stellaris.c                             | 10 +++++-----
 hw/char/diva-gsp.c                             |  2 +-
 hw/core/gpio.c                                 |  2 +-
 hw/core/irq.c                                  | 14 +++++++-------
 hw/display/macfb.c                             |  2 +-
 hw/dma/omap_dma.c                              |  4 ++--
 hw/i386/kvm/i8259.c                            |  2 +-
 hw/i386/microvm.c                              |  2 +-
 hw/i386/pc.c                                   |  4 ++--
 hw/i386/pc_piix.c                              |  2 +-
 hw/i386/x86-cpu.c                              |  2 +-
 hw/i386/xen/xen-hvm.c                          |  2 +-
 hw/ide/ahci.c                                  |  2 +-
 hw/ide/pci.c                                   |  2 +-
 hw/intc/sh_intc.c                              |  2 +-
 hw/isa/i82378.c                                |  2 +-
 hw/isa/lpc_ich9.c                              |  2 +-
 hw/m68k/mcf5206.c                              |  2 +-
 hw/m68k/q800.c                                 |  4 ++--
 hw/mips/mips_int.c                             |  2 +-
 hw/net/can/can_kvaser_pci.c                    |  2 +-
 hw/pci-host/pnv_phb3.c                         |  2 +-
 hw/pci-host/pnv_phb3_msi.c                     |  2 +-
 hw/pci-host/pnv_phb4.c                         |  2 +-
 hw/pci/pci.c                                   |  2 +-
 hw/ppc/e500.c                                  |  2 +-
 hw/ppc/pnv_lpc.c                               |  2 +-
 hw/ppc/pnv_psi.c                               |  4 ++--
 hw/ppc/spapr_irq.c                             |  2 +-
 hw/riscv/sifive_u.c                            |  2 +-
 hw/scsi/esp-pci.c                              |  2 +-
 hw/sh4/sh7750.c                                |  2 +-
 hw/sparc/sun4m.c                               |  4 ++--
 hw/sparc64/sun4u.c                             |  2 +-
 hw/timer/arm_timer.c                           |  4 ++--
 hw/usb/vt82c686-uhci-pci.c                     |  2 +-
 hw/xen/xen-pvh-common.c                        |  4 ++--
 hw/xtensa/mx_pic.c                             |  2 +-
 hw/xtensa/pic_cpu.c                            |  4 ++--
 include/hw/core/irq.h                          |  8 ++++----
 scripts/coccinelle/qom-parent/irq-rename.cocci | 14 ++++++++++++++
 system/qtest.c                                 |  2 +-
 48 files changed, 90 insertions(+), 76 deletions(-)
 create mode 100644 scripts/coccinelle/qom-parent/irq-rename.cocci

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index af39f2659b..671e8f89d9 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -849,8 +849,8 @@ PCIBus *typhoon_init(Object *parent, MemoryRegion *ram, qemu_irq *p_isa_irq,
         }
     }
 
-    *p_isa_irq = qemu_allocate_irq(typhoon_set_isa_irq, s, 0);
-    *p_rtc_irq = qemu_allocate_irq(typhoon_set_timer_irq, s, 0);
+    *p_isa_irq = qemu_allocate_irq_orphan(typhoon_set_isa_irq, s, 0);
+    *p_rtc_irq = qemu_allocate_irq_orphan(typhoon_set_timer_irq, s, 0);
 
     /* Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
        but the address space hole reserved at this point is 8TB.  */
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 81895ad370..93f6715224 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -693,7 +693,7 @@ static void armsse_forward_sec_resp_cfg(ARMSSE *s)
     DeviceState *dev_splitter = DEVICE(&s->sec_resp_splitter);
 
     qdev_init_gpio_out_named(dev, &s->sec_resp_cfg, "sec_resp_cfg", 1);
-    s->sec_resp_cfg_in = qemu_allocate_irq(irq_status_forwarder,
+    s->sec_resp_cfg_in = qemu_allocate_irq_orphan(irq_status_forwarder,
                                            s->sec_resp_cfg, 1);
     qdev_connect_gpio_out(dev_splitter, 2, s->sec_resp_cfg_in);
 }
@@ -1137,7 +1137,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(sbd_secctl, 0, 0x50080000);
     sysbus_mmio_map(sbd_secctl, 1, 0x40080000);
 
-    s->nsc_cfg_in = qemu_allocate_irq(nsccfg_handler, s, 1);
+    s->nsc_cfg_in = qemu_allocate_irq_orphan(nsccfg_handler, s, 1);
     qdev_connect_gpio_out_named(dev_secctl, "nsc_cfg", 0, s->nsc_cfg_in);
 
     /* The sec_resp_cfg output from the security controller must be split into
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 8430317815..537a50f8cc 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -146,7 +146,7 @@ static void smdkc210_init(MachineState *machine)
                                                       EXYNOS4_BOARD_SMDKC210);
 
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
-            qemu_irq_invert(s->soc.irq_table[exynos4210_get_irq(37, 1)]));
+            qemu_irq_invert_orphan(s->soc.irq_table[exynos4210_get_irq(37, 1)]));
     arm_load_kernel(s->soc.cpu[0], machine, &exynos4_board_binfo);
 }
 
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index a57915e208..654eaedd97 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1209,7 +1209,7 @@ static void mps2tz_common_init(MachineState *machine)
          * Connect the line from the SCC so that we can remap when the
          * guest updates that register.
          */
-        mms->remap_irq = qemu_allocate_irq(remap_irq_fn, mms, 0);
+        mms->remap_irq = qemu_allocate_irq_orphan(remap_irq_fn, mms, 0);
         qdev_connect_gpio_out_named(DEVICE(&mms->scc), "remap", 0,
                                     mms->remap_irq);
     }
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 474a3902fe..53e52ef34e 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -139,7 +139,7 @@ static void omap_timer_clk_update(void *opaque, int line, int on)
 static void omap_timer_clk_setup(struct omap_mpu_timer_s *timer)
 {
     omap_clk_adduser(timer->clk,
-                    qemu_allocate_irq(omap_timer_clk_update, timer, 0));
+                    qemu_allocate_irq_orphan(omap_timer_clk_update, timer, 0));
     timer->rate = omap_clk_getrate(timer->clk);
 }
 
@@ -2083,14 +2083,14 @@ static struct omap_mpuio_s *omap_mpuio_init(Object *owner,
 
     s->irq = gpio_int;
     s->kbd_irq = kbd_int;
-    s->in = qemu_allocate_irqs(omap_mpuio_set, s, 16);
+    s->in = qemu_allocate_irqs_orphan(omap_mpuio_set, s, 16);
     omap_mpuio_reset(s);
 
     memory_region_init_io(&s->iomem, owner, &omap_mpuio_ops, s,
                           "omap-mpuio", 0x800);
     memory_region_add_subregion(memory, base, &s->iomem);
 
-    omap_clk_adduser(clk, qemu_allocate_irq(omap_mpuio_onoff, s, 0));
+    omap_clk_adduser(clk, qemu_allocate_irq_orphan(omap_mpuio_onoff, s, 0));
 
     return s;
 }
@@ -2363,7 +2363,7 @@ static struct omap_pwl_s *omap_pwl_init(Object *owner,
                           "omap-pwl", 0x800);
     memory_region_add_subregion(system_memory, base, &s->iomem);
 
-    omap_clk_adduser(clk, qemu_allocate_irq(omap_pwl_clk_update, s, 0));
+    omap_clk_adduser(clk, qemu_allocate_irq_orphan(omap_pwl_clk_update, s, 0));
     return s;
 }
 
@@ -3426,8 +3426,8 @@ static void omap_mcbsp_i2s_start(void *opaque, int line, int level)
 void omap_mcbsp_i2s_attach(struct omap_mcbsp_s *s, I2SCodec *slave)
 {
     s->codec = slave;
-    slave->rx_swallow = qemu_allocate_irq(omap_mcbsp_i2s_swallow, s, 0);
-    slave->tx_start = qemu_allocate_irq(omap_mcbsp_i2s_start, s, 0);
+    slave->rx_swallow = qemu_allocate_irq_orphan(omap_mcbsp_i2s_swallow, s, 0);
+    slave->tx_start = qemu_allocate_irq_orphan(omap_mcbsp_i2s_start, s, 0);
 }
 
 /* LED Pulse Generators */
@@ -3579,7 +3579,7 @@ static struct omap_lpg_s *omap_lpg_init(Object *owner,
                           "omap-lpg", 0x800);
     memory_region_add_subregion(system_memory, base, &s->iomem);
 
-    omap_clk_adduser(clk, qemu_allocate_irq(omap_lpg_clk_update, s, 0));
+    omap_clk_adduser(clk, qemu_allocate_irq_orphan(omap_lpg_clk_update, s, 0));
 
     return s;
 }
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 73bfffa6e6..cd63f39f42 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -276,7 +276,7 @@ static void realview_init(MachineState *machine,
 
     split_irq_from_named(OBJECT(machine), dev, "card-inserted",
                    qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_CARDIN),
-                   qemu_irq_invert(qdev_get_gpio_in(gpio2, 0)));
+                   qemu_irq_invert_orphan(qdev_get_gpio_in(gpio2, 0)));
 
     dinfo = drive_get(IF_SD, 0, 0);
     if (dinfo) {
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 1bc428e063..a5d037094a 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1358,15 +1358,15 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         sysbus_realize(SYS_BUS_DEVICE(gpad), &error_fatal);
 
         qdev_connect_gpio_out(gpad, 0,
-                              qemu_irq_invert(gpio_in[GPIO_E][0])); /* up */
+                              qemu_irq_invert_orphan(gpio_in[GPIO_E][0])); /* up */
         qdev_connect_gpio_out(gpad, 1,
-                              qemu_irq_invert(gpio_in[GPIO_E][1])); /* down */
+                              qemu_irq_invert_orphan(gpio_in[GPIO_E][1])); /* down */
         qdev_connect_gpio_out(gpad, 2,
-                              qemu_irq_invert(gpio_in[GPIO_E][2])); /* left */
+                              qemu_irq_invert_orphan(gpio_in[GPIO_E][2])); /* left */
         qdev_connect_gpio_out(gpad, 3,
-                              qemu_irq_invert(gpio_in[GPIO_E][3])); /* right */
+                              qemu_irq_invert_orphan(gpio_in[GPIO_E][3])); /* right */
         qdev_connect_gpio_out(gpad, 4,
-                              qemu_irq_invert(gpio_in[GPIO_F][1])); /* select */
+                              qemu_irq_invert_orphan(gpio_in[GPIO_F][1])); /* select */
     }
     for (i = 0; i < 7; i++) {
         if (board->dc4 & (1 << i)) {
diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index 53fd0fe2a1..bf1da1faee 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -126,7 +126,7 @@ static void diva_pci_realize(PCIDevice *dev, Error **errp)
     pci->dev.config[PCI_INTERRUPT_PIN] = 1;
     memory_region_init(&pci->membar, OBJECT(pci), "serial_ports", 4096);
     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &pci->membar);
-    pci->irqs = qemu_allocate_irqs(multi_serial_irq_mux, pci, di.nports);
+    pci->irqs = qemu_allocate_irqs_orphan(multi_serial_irq_mux, pci, di.nports);
 
     for (i = 0; i < di.nports; i++) {
         s = pci->state + i;
diff --git a/hw/core/gpio.c b/hw/core/gpio.c
index 37cda5ce4d..ef8ef8f25a 100644
--- a/hw/core/gpio.c
+++ b/hw/core/gpio.c
@@ -49,7 +49,7 @@ void qdev_init_gpio_in_named_with_opaque(DeviceState *dev,
     NamedGPIOList *gpio_list = qdev_get_named_gpio_list(dev, name);
 
     assert(gpio_list->num_out == 0 || !name);
-    gpio_list->in = qemu_extend_irqs(gpio_list->in, gpio_list->num_in, handler,
+    gpio_list->in = qemu_extend_irqs_orphan(gpio_list->in, gpio_list->num_in, handler,
                                      opaque, n);
 
     if (!name) {
diff --git a/hw/core/irq.c b/hw/core/irq.c
index 1b610e75e1..f8fdeb7e02 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -68,7 +68,7 @@ void qemu_init_irqs(IRQState irq[], size_t count,
     }
 }
 
-qemu_irq *qemu_extend_irqs(qemu_irq *old, int n_old, qemu_irq_handler handler,
+qemu_irq *qemu_extend_irqs_orphan(qemu_irq *old, int n_old, qemu_irq_handler handler,
                            void *opaque, int n)
 {
     qemu_irq *s;
@@ -79,17 +79,17 @@ qemu_irq *qemu_extend_irqs(qemu_irq *old, int n_old, qemu_irq_handler handler,
     }
     s = old ? g_renew(qemu_irq, old, n + n_old) : g_new(qemu_irq, n);
     for (i = n_old; i < n + n_old; i++) {
-        s[i] = qemu_allocate_irq(handler, opaque, i);
+        s[i] = qemu_allocate_irq_orphan(handler, opaque, i);
     }
     return s;
 }
 
-qemu_irq *qemu_allocate_irqs(qemu_irq_handler handler, void *opaque, int n)
+qemu_irq *qemu_allocate_irqs_orphan(qemu_irq_handler handler, void *opaque, int n)
 {
-    return qemu_extend_irqs(NULL, 0, handler, opaque, n);
+    return qemu_extend_irqs_orphan(NULL, 0, handler, opaque, n);
 }
 
-qemu_irq qemu_allocate_irq(qemu_irq_handler handler, void *opaque, int n)
+qemu_irq qemu_allocate_irq_orphan(qemu_irq_handler handler, void *opaque, int n)
 {
     IRQState *irq = IRQ(object_new(TYPE_IRQ));
     init_irq_fields(irq, handler, opaque, n);
@@ -117,11 +117,11 @@ static void qemu_notirq(void *opaque, int line, int level)
     qemu_set_irq(irq, !level);
 }
 
-qemu_irq qemu_irq_invert(qemu_irq irq)
+qemu_irq qemu_irq_invert_orphan(qemu_irq irq)
 {
     /* The default state for IRQs is low, so raise the output now.  */
     qemu_irq_raise(irq);
-    return qemu_allocate_irq(qemu_notirq, irq, 0);
+    return qemu_allocate_irq_orphan(qemu_notirq, irq, 0);
 }
 
 void qemu_irq_set_observer(qemu_irq *gpio_in, qemu_irq_handler handler, int n)
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index f40a7ed9f5..de5c83884e 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -737,7 +737,7 @@ static void macfb_nubus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&nd->slot_mem, DAFB_BASE, &ms->mem_ctrl);
     memory_region_add_subregion(&nd->slot_mem, VIDEO_BASE, &ms->mem_vram);
 
-    ms->irq = qemu_allocate_irq(macfb_nubus_set_irq, s, 0);
+    ms->irq = qemu_allocate_irq_orphan(macfb_nubus_set_irq, s, 0);
 }
 
 static void macfb_nubus_unrealize(DeviceState *dev)
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index b130ba2480..7a2a3310f9 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -1109,7 +1109,7 @@ struct soc_dma_s *omap_dma_init(Object *owner, hwaddr base, qemu_irq *irqs,
     s->dma->freq = omap_clk_getrate(clk);
     s->dma->transfer_fn = omap_dma_transfer_generic;
     s->dma->setup_fn = omap_dma_transfer_setup;
-    s->dma->drq = qemu_allocate_irqs(omap_dma_request, s, 32);
+    s->dma->drq = qemu_allocate_irqs_orphan(omap_dma_request, s, 32);
     s->dma->opaque = s;
 
     while (num_irqs --)
@@ -1123,7 +1123,7 @@ struct soc_dma_s *omap_dma_init(Object *owner, hwaddr base, qemu_irq *irqs,
         s->dma->ch[i].opaque = &s->ch[i];
     }
 
-    omap_clk_adduser(s->clk, qemu_allocate_irq(omap_dma_clk_update, s, 0));
+    omap_clk_adduser(s->clk, qemu_allocate_irq_orphan(omap_dma_clk_update, s, 0));
     omap_dma_reset(s->dma);
     omap_dma_clk_update(s, 0, 1);
 
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 5fb11d3613..7ef7a0b487 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -136,7 +136,7 @@ qemu_irq *kvm_i8259_init(Object *parent, ISABus *bus)
     i8259_init_chip(parent, TYPE_KVM_I8259, bus, true);
     i8259_init_chip(parent, TYPE_KVM_I8259, bus, false);
 
-    return qemu_allocate_irqs(kvm_pic_set_irq, NULL, ISA_NUM_IRQS);
+    return qemu_allocate_irqs_orphan(kvm_pic_set_irq, NULL, ISA_NUM_IRQS);
 }
 
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 751e3962fa..07dbe3a18b 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -168,7 +168,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     /* Core components */
     ioapics = microvm_ioapics(mms);
     gsi_state = g_malloc0(sizeof(*gsi_state));
-    x86ms->gsi = qemu_allocate_irqs(gsi_handler, gsi_state,
+    x86ms->gsi = qemu_allocate_irqs_orphan(gsi_handler, gsi_state,
                                     IOAPIC_NUM_PINS * ioapics);
 
     isa_bus = isa_bus_new_bridge(OBJECT(mms), get_system_memory(), get_system_io(),
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8057058ff0..249fa699c7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -200,7 +200,7 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
     if (kvm_ioapic_in_kernel()) {
         kvm_pc_setup_irq_routing(pci_enabled);
     }
-    *irqs = qemu_allocate_irqs(gsi_handler, s, IOAPIC_NUM_PINS);
+    *irqs = qemu_allocate_irqs_orphan(gsi_handler, s, IOAPIC_NUM_PINS);
 
     return s;
 }
@@ -1028,7 +1028,7 @@ static void pc_superio_init(Object *parent, ISABus *isa_bus, bool create_fdctrl,
     }
     port92 = isa_create_simple(parent, "port92", isa_bus, TYPE_PORT92);
 
-    a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
+    a20_line = qemu_allocate_irqs_orphan(handle_a20_line_change, first_cpu, 2);
     qdev_connect_gpio_out_named(DEVICE(i8042),
                                 I8042_A20_LINE, 0, a20_line[0]);
     qdev_connect_gpio_out_named(DEVICE(port92),
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0b8d7d88b9..f76d684d6b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -299,7 +299,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
     if (piix4_pm) {
-        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
+        smi_irq = qemu_allocate_irq_orphan(pc_acpi_smi_interrupt, first_cpu, 0);
 
         qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
         pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
diff --git a/hw/i386/x86-cpu.c b/hw/i386/x86-cpu.c
index 95e08e3c2a..6d010291cf 100644
--- a/hw/i386/x86-cpu.c
+++ b/hw/i386/x86-cpu.c
@@ -63,7 +63,7 @@ static void pic_irq_request(void *opaque, int irq, int level)
 
 qemu_irq x86_allocate_cpu_irq(void)
 {
-    return qemu_allocate_irq(pic_irq_request, NULL, 0);
+    return qemu_allocate_irq_orphan(pic_irq_request, NULL, 0);
 }
 
 int cpu_get_pic_interrupt(CPUX86State *env)
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 01d851ce3e..e87c8237ea 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -114,7 +114,7 @@ static void xen_set_irq(void *opaque, int irq, int level)
 
 qemu_irq *xen_interrupt_controller_init(void)
 {
-    return qemu_allocate_irqs(xen_set_irq, NULL, 16);
+    return qemu_allocate_irqs_orphan(xen_set_irq, NULL, 16);
 }
 
 /* Memory Ops */
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 749f0efa1d..ac1cf26bab 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1594,7 +1594,7 @@ void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as)
     assert(s->ports > 0);
     s->dev = g_new0(AHCIDevice, s->ports);
     ahci_reg_init(s);
-    irqs = qemu_allocate_irqs(ahci_irq_set, s, s->ports);
+    irqs = qemu_allocate_irqs_orphan(ahci_irq_set, s, s->ports);
     for (i = 0; i < s->ports; i++) {
         AHCIDevice *ad = &s->dev[i];
 
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 7ce1ae67ab..c808469008 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -606,7 +606,7 @@ void bmdma_init(IDEBus *bus, BMDMAState *bm, PCIIDEState *d)
     bm->dma.ops = &bmdma_ops;
     bus->dma = &bm->dma;
     bm->irq = bus->irq;
-    bus->irq = qemu_allocate_irq(bmdma_irq, bm, 0);
+    bus->irq = qemu_allocate_irq_orphan(bmdma_irq, bm, 0);
     bm->bus = bus;
     bm->pci_dev = d;
 }
diff --git a/hw/intc/sh_intc.c b/hw/intc/sh_intc.c
index 37feb6a813..63f4eee2aa 100644
--- a/hw/intc/sh_intc.c
+++ b/hw/intc/sh_intc.c
@@ -403,7 +403,7 @@ int sh_intc_init(Object *owner, MemoryRegion *sysmem,
     for (i = 0; i < nr_sources; i++) {
         desc->sources[i].parent = desc;
     }
-    desc->irqs = qemu_allocate_irqs(sh_intc_set_irq, desc, nr_sources);
+    desc->irqs = qemu_allocate_irqs_orphan(sh_intc_set_irq, desc, nr_sources);
     memory_region_init_io(&desc->iomem, owner, &sh_intc_ops, desc, "intc",
                           0x100000000ULL);
     j = 0;
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 995d1eaa53..4f0be992e0 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -95,7 +95,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
 
     /* 2 82C59 (irq) */
     s->isa_irqs_in = i8259_init(OBJECT(pci), isabus,
-                                qemu_allocate_irq(i82378_request_out0_irq,
+                                qemu_allocate_irq_orphan(i82378_request_out0_irq,
                                                   s, 0));
     isa_bus_register_input_irqs(isabus, s->isa_irqs_in);
 
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index edf9783ec8..7cb82519fb 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -429,7 +429,7 @@ static void ich9_lpc_pm_init(ICH9LPCState *lpc)
     qemu_irq sci_irq;
     FWCfgState *fw_cfg = fw_cfg_find();
 
-    sci_irq = qemu_allocate_irq(ich9_set_sci, lpc, 0);
+    sci_irq = qemu_allocate_irq_orphan(ich9_set_sci, lpc, 0);
     ich9_pm_init(PCI_DEVICE(lpc), &lpc->pm, sci_irq);
 
     if (lpc->smi_host_features && fw_cfg) {
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index ee39a6ac30..cbb361fae9 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -593,7 +593,7 @@ static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
                           "mbar", 0x00001000);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 
-    s->pic = qemu_allocate_irqs(m5206_mbar_set_irq, s, 14);
+    s->pic = qemu_allocate_irqs_orphan(m5206_mbar_set_irq, s, 14);
     m5206_timer_init(&s->timer[0], s->pic[9]);
     m5206_timer_init(&s->timer[1], s->pic[10]);
     s->uart[0] = mcf_uart_create(OBJECT(s), s->pic[12], serial_hd(0));
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 954cdf8489..177fff0289 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -474,11 +474,11 @@ static void q800_machine_init(MachineState *machine)
     sysbus_realize(sysbus, &error_fatal);
     /* SCSI and SCSI data IRQs are negative edge triggered */
     sysbus_connect_irq(sysbus, 0,
-                       qemu_irq_invert(
+                       qemu_irq_invert_orphan(
                            qdev_get_gpio_in(DEVICE(&m->via2),
                                                    VIA2_IRQ_SCSI_BIT)));
     sysbus_connect_irq(sysbus, 1,
-                       qemu_irq_invert(
+                       qemu_irq_invert_orphan(
                            qdev_get_gpio_in(DEVICE(&m->via2),
                                                    VIA2_IRQ_SCSI_DATA_BIT)));
     memory_region_add_subregion(&m->macio, ESP_BASE - IO_BASE,
diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 26e7dd6d5f..814d07319f 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -56,7 +56,7 @@ void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
     qemu_irq *qi;
     int i;
 
-    qi = qemu_allocate_irqs(cpu_mips_irq_request, cpu, 8);
+    qi = qemu_allocate_irqs_orphan(cpu_mips_irq_request, cpu, 8);
     for (i = 0; i < 8; i++) {
         env->irq[i] = qi[i];
     }
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index f2912b206d..69fc66de14 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -224,7 +224,7 @@ static void kvaser_pci_realize(PCIDevice *pci_dev, Error **errp)
     pci_conf = pci_dev->config;
     pci_conf[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
 
-    d->irq = qemu_allocate_irq(kvaser_pci_irq_handler, d, 0);
+    d->irq = qemu_allocate_irq_orphan(kvaser_pci_irq_handler, d, 0);
 
     can_sja_init(s, d->irq);
 
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 4ffdb4ce31..63da48f5af 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -1054,7 +1054,7 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
         ics_set_irq_type(&phb->lsis, i, true);
     }
 
-    phb->qirqs = qemu_allocate_irqs(ics_set_irq, &phb->lsis, phb->lsis.nr_irqs);
+    phb->qirqs = qemu_allocate_irqs_orphan(ics_set_irq, &phb->lsis, phb->lsis.nr_irqs);
 
     /* MSI sources */
     object_property_set_link(OBJECT(&phb->msis), "phb", OBJECT(phb),
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index 66ba7b7913..fa5f61ea2b 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -267,7 +267,7 @@ static void phb3_msi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    msi->qirqs = qemu_allocate_irqs(phb3_msi_set_irq, msi, ics->nr_irqs);
+    msi->qirqs = qemu_allocate_irqs_orphan(phb3_msi_set_irq, msi, ics->nr_irqs);
 }
 
 static void phb3_msi_instance_init(Object *obj)
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 705a5bcf07..7a1988a2b2 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1605,7 +1605,7 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
 
     pnv_phb4_update_xsrc(phb);
 
-    phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
+    phb->qirqs = qemu_allocate_irqs_orphan(xive_source_set_irq, xsrc, xsrc->nr_irqs);
 
     pnv_phb4_xscom_realize(phb);
 }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 5ef9dfa8b7..9ba7bfd977 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1869,7 +1869,7 @@ qemu_irq pci_allocate_irq(PCIDevice *pci_dev)
     int intx = pci_intx(pci_dev);
     assert(0 <= intx && intx < PCI_NUM_PINS);
 
-    return qemu_allocate_irq(pci_irq_handler, pci_dev, intx);
+    return qemu_allocate_irq_orphan(pci_irq_handler, pci_dev, intx);
 }
 
 void pci_set_irq(PCIDevice *pci_dev, int level)
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 21e656e87f..62692f5776 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1089,7 +1089,7 @@ void ppce500_init(MachineState *machine)
                                     sysbus_mmio_get_region(s, 0));
 
         /* Power Off GPIO at Pin 0 */
-        poweroff_irq = qemu_allocate_irq(ppce500_power_off, NULL, 0);
+        poweroff_irq = qemu_allocate_irq_orphan(ppce500_power_off, NULL, 0);
         qdev_connect_gpio_out(dev, 0, poweroff_irq);
     }
 
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 6ae228088f..e89defb321 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -993,7 +993,7 @@ ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error **errp)
     }
 
     /* POWER has a 17th irq, QEMU only implements the 16 regular device irqs */
-    irqs = qemu_allocate_irqs(handler, lpc, ISA_NUM_IRQS);
+    irqs = qemu_allocate_irqs_orphan(handler, lpc, ISA_NUM_IRQS);
 
     isa_bus_register_input_irqs(isa_bus, irqs);
 
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index e8701c6100..1ff33596ac 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -509,7 +509,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, Error **errp)
 
     qdev_init_gpio_in(dev, pnv_psi_power8_set_irq, ics->nr_irqs);
 
-    psi->qirqs = qemu_allocate_irqs(ics_set_irq, ics, ics->nr_irqs);
+    psi->qirqs = qemu_allocate_irqs_orphan(ics_set_irq, ics, ics->nr_irqs);
 
     /* XSCOM region for PSI registers */
     pnv_xscom_region_init(&psi->xscom_regs, OBJECT(dev), &pnv_psi_xscom_ops,
@@ -872,7 +872,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
         xive_source_irq_set_lsi(xsrc, i);
     }
 
-    psi->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
+    psi->qirqs = qemu_allocate_irqs_orphan(xive_source_set_irq, xsrc, xsrc->nr_irqs);
 
     qdev_init_gpio_in(dev, pnv_psi_power9_set_irq, xsrc->nr_irqs);
 
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index b9e5f5d710..a05edb78bc 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -339,7 +339,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         spapr_xive_hcall_init(spapr);
     }
 
-    spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
+    spapr->qirqs = qemu_allocate_irqs_orphan(spapr_set_irq, spapr,
                                       SPAPR_NR_XIRQS + SPAPR_IRQ_NR_IPIS);
 
     /*
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9d3f5c8f59..3df9fafb12 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -484,7 +484,7 @@ static void sifive_u_machine_init(MachineState *machine)
 
     /* register gpio-restart */
     qdev_connect_gpio_out(DEVICE(&(s->soc.gpio)), 10,
-                          qemu_allocate_irq(sifive_u_machine_reset, NULL, 0));
+                          qemu_allocate_irq_orphan(sifive_u_machine_reset, NULL, 0));
 
     /* load/create device tree */
     if (machine->dtb) {
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index b31ccdbecc..4c02b23a28 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -407,7 +407,7 @@ static void esp_pci_scsi_realize(PCIDevice *dev, Error **errp)
                           "esp-io", 0x80);
 
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->io);
-    s->irq = qemu_allocate_irq(esp_irq_handler, pci, 0);
+    s->irq = qemu_allocate_irq_orphan(esp_irq_handler, pci, 0);
 
     scsi_bus_init(&s->bus, sizeof(s->bus), d, &esp_pci_scsi_info);
 }
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index ea55a3a9cc..307daa523d 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -848,5 +848,5 @@ SH7750State *sh7750_init(Object *parent, SuperHCPU *cpu,
 qemu_irq sh7750_irl(SH7750State *s)
 {
     sh_intc_toggle_source(&s->intc.sources[IRL], 1, 0); /* enable */
-    return qemu_allocate_irq(sh_intc_set_irl, &s->intc.sources[IRL], 0);
+    return qemu_allocate_irq_orphan(sh_intc_set_irl, &s->intc.sources[IRL], 0);
 }
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index a0d0213d0b..0a35b20e17 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -1008,7 +1008,7 @@ static void sun4m_hw_init(MachineState *machine)
 
     if (hwdef->apc_base) {
         apc_init(OBJECT(machine), hwdef->apc_base,
-                 qemu_allocate_irq(cpu_halt_signal, NULL, 0));
+                 qemu_allocate_irq_orphan(cpu_halt_signal, NULL, 0));
     }
 
     if (hwdef->fd_base) {
@@ -1018,7 +1018,7 @@ static void sun4m_hw_init(MachineState *machine)
         sun4m_fdctrl_init(OBJECT(machine), slavio_irq[22], hwdef->fd_base, fd,
                           &fdc_tc);
     } else {
-        fdc_tc = qemu_allocate_irq(dummy_fdc_tc, NULL, 0);
+        fdc_tc = qemu_allocate_irq_orphan(dummy_fdc_tc, NULL, 0);
     }
 
     slavio_misc_init(OBJECT(machine), hwdef->slavio_base, hwdef->aux1_base,
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index dbf49ef43d..389436fd3d 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -311,7 +311,7 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     /* ISA bus */
-    s->isa_irqs_in = qemu_allocate_irqs(ebus_isa_irq_handler, s, ISA_NUM_IRQS);
+    s->isa_irqs_in = qemu_allocate_irqs_orphan(ebus_isa_irq_handler, s, ISA_NUM_IRQS);
     isa_bus_register_input_irqs(s->isa_bus, s->isa_irqs_in);
     qdev_init_gpio_out_named(DEVICE(s), s->isa_irqs_out, "isa-irq",
                              ISA_NUM_IRQS);
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index fb70333c53..1c29db12a2 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -305,8 +305,8 @@ static void sp804_realize(DeviceState *dev, Error **errp)
 
     s->timer[0] = arm_timer_init(s->freq0);
     s->timer[1] = arm_timer_init(s->freq1);
-    s->timer[0]->irq = qemu_allocate_irq(sp804_set_irq, s, 0);
-    s->timer[1]->irq = qemu_allocate_irq(sp804_set_irq, s, 1);
+    s->timer[0]->irq = qemu_allocate_irq_orphan(sp804_set_irq, s, 0);
+    s->timer[1]->irq = qemu_allocate_irq_orphan(sp804_set_irq, s, 1);
 }
 
 /* Integrator/CP timer module.  */
diff --git a/hw/usb/vt82c686-uhci-pci.c b/hw/usb/vt82c686-uhci-pci.c
index 97c09a51cf..b58b61e609 100644
--- a/hw/usb/vt82c686-uhci-pci.c
+++ b/hw/usb/vt82c686-uhci-pci.c
@@ -23,7 +23,7 @@ static void usb_uhci_vt82c686b_realize(PCIDevice *dev, Error **errp)
 
     usb_uhci_common_realize(dev, errp);
     object_unref(s->irq);
-    s->irq = qemu_allocate_irq(uhci_isa_set_irq, s, 0);
+    s->irq = qemu_allocate_irq_orphan(uhci_isa_set_irq, s, 0);
 }
 
 static UHCIInfo uhci_info[] = {
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 1047aabd57..42514a599e 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -170,7 +170,7 @@ static void xen_create_virtio_mmio_devices(XenPVHMachineState *s)
      */
     for (i = s->cfg.virtio_mmio_num - 1; i >= 0; i--) {
         hwaddr base = s->cfg.virtio_mmio.base + i * s->cfg.virtio_mmio.size;
-        qemu_irq irq = qemu_allocate_irq(xen_set_irq, NULL,
+        qemu_irq irq = qemu_allocate_irq_orphan(xen_set_irq, NULL,
                                          s->cfg.virtio_mmio_irq_base + i);
 
         sysbus_create_simple(OBJECT(s), "virtio-mmio[*]", "virtio-mmio",
@@ -260,7 +260,7 @@ static inline void xenpvh_gpex_init(XenPVHMachineState *s,
     assert(xpc->set_pci_intx_irq);
 
     for (i = 0; i < PCI_NUM_PINS; i++) {
-        qemu_irq irq = qemu_allocate_irq(xpc->set_pci_intx_irq, s, i);
+        qemu_irq irq = qemu_allocate_irq_orphan(xpc->set_pci_intx_irq, s, i);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
         gpex_set_irq_num(GPEX_HOST(dev), i, s->cfg.pci_intx_irq_base + i);
diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
index f349fb125c..9959bec5f2 100644
--- a/hw/xtensa/mx_pic.c
+++ b/hw/xtensa/mx_pic.c
@@ -346,7 +346,7 @@ XtensaMxPic *xtensa_mx_pic_init(unsigned n_irq)
     XtensaMxPic *mx = g_new0(XtensaMxPic, 1);
 
     mx->n_irq = n_irq + 1;
-    mx->irq_inputs = qemu_allocate_irqs(xtensa_mx_pic_set_irq, mx,
+    mx->irq_inputs = qemu_allocate_irqs_orphan(xtensa_mx_pic_set_irq, mx,
                                         mx->n_irq);
     return mx;
 }
diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index 370a353f1e..c3163a8b6c 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -102,7 +102,7 @@ void xtensa_irq_init(CPUXtensaState *env)
 {
     unsigned i;
 
-    env->irq_inputs = qemu_allocate_irqs(xtensa_set_irq, env,
+    env->irq_inputs = qemu_allocate_irqs_orphan(xtensa_set_irq, env,
                                          env->config->ninterrupt);
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_TIMER_INTERRUPT)) {
         env->time_base = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -118,7 +118,7 @@ void xtensa_irq_init(CPUXtensaState *env)
 
         env->ext_irq_inputs[i] = env->irq_inputs[irq];
     }
-    env->runstall_irq = qemu_allocate_irq(xtensa_set_runstall, env, 0);
+    env->runstall_irq = qemu_allocate_irq_orphan(xtensa_set_runstall, env, 0);
 }
 
 qemu_irq *xtensa_get_extints(CPUXtensaState *env)
diff --git a/include/hw/core/irq.h b/include/hw/core/irq.h
index 299a4a9a8c..f984c02c14 100644
--- a/include/hw/core/irq.h
+++ b/include/hw/core/irq.h
@@ -77,25 +77,25 @@ void qemu_init_irqs(IRQState irq[], size_t count,
 /* Returns an array of N IRQs. Each IRQ is assigned the argument handler and
  * opaque data.
  */
-qemu_irq *qemu_allocate_irqs(qemu_irq_handler handler, void *opaque, int n);
+qemu_irq *qemu_allocate_irqs_orphan(qemu_irq_handler handler, void *opaque, int n);
 
 /*
  * Allocates a single IRQ. The irq is assigned with a handler, an opaque
  * data and the interrupt number.
  */
-qemu_irq qemu_allocate_irq(qemu_irq_handler handler, void *opaque, int n);
+qemu_irq qemu_allocate_irq_orphan(qemu_irq_handler handler, void *opaque, int n);
 
 /* Extends an Array of IRQs. Old IRQs have their handlers and opaque data
  * preserved. New IRQs are assigned the argument handler and opaque data.
  */
-qemu_irq *qemu_extend_irqs(qemu_irq *old, int n_old, qemu_irq_handler handler,
+qemu_irq *qemu_extend_irqs_orphan(qemu_irq *old, int n_old, qemu_irq_handler handler,
                                 void *opaque, int n);
 
 void qemu_free_irqs(qemu_irq *s, int n);
 void qemu_free_irq(qemu_irq irq);
 
 /* Returns a new IRQ with opposite polarity.  */
-qemu_irq qemu_irq_invert(qemu_irq irq);
+qemu_irq qemu_irq_invert_orphan(qemu_irq irq);
 
 /* For internal use in qtest. */
 void qemu_irq_set_observer(qemu_irq *gpio_in, qemu_irq_handler handler, int n);
diff --git a/scripts/coccinelle/qom-parent/irq-rename.cocci b/scripts/coccinelle/qom-parent/irq-rename.cocci
new file mode 100644
index 0000000000..5587c3a4f9
--- /dev/null
+++ b/scripts/coccinelle/qom-parent/irq-rename.cocci
@@ -0,0 +1,14 @@
+// Rename the IRQ allocation helpers to *_orphan() so the parented
+// variants can take the well-known names.
+@@ @@
+- qemu_allocate_irqs
++ qemu_allocate_irqs_orphan
+@@ @@
+- qemu_allocate_irq
++ qemu_allocate_irq_orphan
+@@ @@
+- qemu_extend_irqs
++ qemu_extend_irqs_orphan
+@@ @@
+- qemu_irq_invert
++ qemu_irq_invert_orphan
diff --git a/system/qtest.c b/system/qtest.c
index cf30123917..f38feaac89 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -346,7 +346,7 @@ void qtest_set_command_cb(bool (*pc_cb)(CharFrontend *chr, gchar **words))
 static void qtest_install_gpio_out_intercept(DeviceState *dev, const char *name, int n)
 {
     qemu_irq *disconnected = g_new0(qemu_irq, 1);
-    qemu_irq icpt = qemu_allocate_irq(qtest_irq_handler,
+    qemu_irq icpt = qemu_allocate_irq_orphan(qtest_irq_handler,
                                       disconnected, n);
 
     *disconnected = qdev_intercept_gpio_out(dev, icpt, name, n);
-- 
2.47.1


