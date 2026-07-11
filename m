Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145FDC44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigmW-0004ge-3M; Sat, 11 Jul 2026 19:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigmU-0004fO-I5; Sat, 11 Jul 2026 19:06:46 -0400
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([50.112.246.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigmR-0003f5-VS; Sat, 11 Jul 2026 19:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811204; x=1815347204;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gkfDaFSIqr+zpEm7SCuKohTGYS4M/erIHyrQHP6KtMY=;
 b=mWEF0NKa/8dXtOwOqM2Afz7vX54vzrkWVU+M2hWAG+Zp5EttZs6Uuir4
 1QoswNd25VJ6u5BacwcpleVxEBf4yDrLv7uZcwy3NEix1suo9P67cGY3E
 AVXiacvstAEyJxiWlhvBOSBeEp8VMGRTEm1sMNQMSzi+DxwKLdEMDiH1L
 5TIKCsylnliN99NyQj+wbLkQafiQ4u8Hh0pDMsXpLVMZKX4ACW2GadfnL
 WVXw8tzp/H7YMkM3fpFi2tRbENWFNLpuju7Vyk5IrpfdhMgzF+Z7MQJDw
 s7XnekG40ucsYWYJIGISFo9JrZ9qufBGwbFf1TozQ9qh7GazRiNHzUF/O A==;
X-CSE-ConnectionGUID: jAobGfk7TSK0AwuF+8Ez7g==
X-CSE-MsgGUID: cu9vMr0iSTykIrkVYJY9vQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23300253"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:06:40 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:15567]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525]
 with esmtp (Farcaster)
 id 33174f51-0f37-427b-aafb-a669e76daf29; Sat, 11 Jul 2026 23:06:40 +0000 (UTC)
X-Farcaster-Flow-ID: 33174f51-0f37-427b-aafb-a669e76daf29
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:06:39 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:06:31 +0000
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
Subject: [RFC PATCH 112/134] hw/arm: Give allocated IRQs an owner and name
Date: Sat, 11 Jul 2026 22:36:45 +0000
Message-ID: <20260711223707.42139-113-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
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

Convert the IRQ allocation calls in hw/arm boards and the OMAP
peripheral models to the parented form.  Thread an Object *owner
through the small helpers that had none:

  omap_timer_clk_setup()  -> +Object *owner
  omap_mcbsp_i2s_attach() -> +Object *owner (no callers, kept for API)

The OMAP init helpers are called multiple times from
omap310_mpu_init() so their IRQ names use the auto-index [*] form.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/armsse.c         |  5 +++--
 hw/arm/exynos4_boards.c |  3 ++-
 hw/arm/mps2-tz.c        |  3 ++-
 hw/arm/omap1.c          | 29 +++++++++++++++++------------
 hw/arm/realview.c       |  3 ++-
 hw/arm/stellaris.c      | 15 ++++++++++-----
 hw/dma/omap_dma.c       |  5 +++--
 hw/timer/arm_timer.c    |  6 ++++--
 include/hw/arm/omap.h   |  2 +-
 9 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 93f6715224..b25f058020 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -693,7 +693,8 @@ static void armsse_forward_sec_resp_cfg(ARMSSE *s)
     DeviceState *dev_splitter = DEVICE(&s->sec_resp_splitter);
 
     qdev_init_gpio_out_named(dev, &s->sec_resp_cfg, "sec_resp_cfg", 1);
-    s->sec_resp_cfg_in = qemu_allocate_irq_orphan(irq_status_forwarder,
+    s->sec_resp_cfg_in = qemu_allocate_irq(OBJECT(s), "sec-resp-cfg-in",
+                                           irq_status_forwarder,
                                            s->sec_resp_cfg, 1);
     qdev_connect_gpio_out(dev_splitter, 2, s->sec_resp_cfg_in);
 }
@@ -1137,7 +1138,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(sbd_secctl, 0, 0x50080000);
     sysbus_mmio_map(sbd_secctl, 1, 0x40080000);
 
-    s->nsc_cfg_in = qemu_allocate_irq_orphan(nsccfg_handler, s, 1);
+    s->nsc_cfg_in = qemu_allocate_irq(OBJECT(dev), "nsc-cfg-in", nsccfg_handler, s, 1);
     qdev_connect_gpio_out_named(dev_secctl, "nsc_cfg", 0, s->nsc_cfg_in);
 
     /* The sec_resp_cfg output from the security controller must be split into
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 537a50f8cc..4f5c99e301 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -146,7 +146,8 @@ static void smdkc210_init(MachineState *machine)
                                                       EXYNOS4_BOARD_SMDKC210);
 
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
-            qemu_irq_invert_orphan(s->soc.irq_table[exynos4210_get_irq(37, 1)]));
+            qemu_irq_invert(OBJECT(machine), "lan9118-irq-inv",
+                            s->soc.irq_table[exynos4210_get_irq(37, 1)]));
     arm_load_kernel(s->soc.cpu[0], machine, &exynos4_board_binfo);
 }
 
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 654eaedd97..ea94f1a6dd 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1209,7 +1209,8 @@ static void mps2tz_common_init(MachineState *machine)
          * Connect the line from the SCC so that we can remap when the
          * guest updates that register.
          */
-        mms->remap_irq = qemu_allocate_irq_orphan(remap_irq_fn, mms, 0);
+        mms->remap_irq = qemu_allocate_irq(OBJECT(machine), "remap-irq",
+                                           remap_irq_fn, mms, 0);
         qdev_connect_gpio_out_named(DEVICE(&mms->scc), "remap", 0,
                                     mms->remap_irq);
     }
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 53e52ef34e..c193b41f5b 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -136,10 +136,11 @@ static void omap_timer_clk_update(void *opaque, int line, int on)
     omap_timer_update(timer);
 }
 
-static void omap_timer_clk_setup(struct omap_mpu_timer_s *timer)
+static void omap_timer_clk_setup(Object *owner, struct omap_mpu_timer_s *timer)
 {
     omap_clk_adduser(timer->clk,
-                    qemu_allocate_irq_orphan(omap_timer_clk_update, timer, 0));
+                    qemu_allocate_irq(owner, "rate-irq[*]",
+                                      omap_timer_clk_update, timer, 0));
     timer->rate = omap_clk_getrate(timer->clk);
 }
 
@@ -232,7 +233,7 @@ static struct omap_mpu_timer_s *omap_mpu_timer_init(Object *owner,
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, omap_timer_tick, s);
     s->tick = qemu_bh_new(omap_timer_fire, s);
     omap_mpu_timer_reset(s);
-    omap_timer_clk_setup(s);
+    omap_timer_clk_setup(owner, s);
 
     memory_region_init_io(&s->iomem, owner, &omap_mpu_timer_ops, s,
                           "omap-mpu-timer", 0x100);
@@ -363,7 +364,7 @@ static struct omap_watchdog_timer_s *omap_wd_timer_init(Object *owner,
     s->timer.clk = clk;
     s->timer.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, omap_timer_tick, &s->timer);
     omap_wd_timer_reset(s);
-    omap_timer_clk_setup(&s->timer);
+    omap_timer_clk_setup(owner, &s->timer);
 
     memory_region_init_io(&s->iomem, owner, &omap_wd_timer_ops, s,
                           "omap-wd-timer", 0x100);
@@ -472,7 +473,7 @@ static struct omap_32khz_timer_s *omap_os_timer_init(Object *owner,
     s->timer.clk = clk;
     s->timer.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, omap_timer_tick, &s->timer);
     omap_os_timer_reset(s);
-    omap_timer_clk_setup(&s->timer);
+    omap_timer_clk_setup(owner, &s->timer);
 
     memory_region_init_io(&s->iomem, owner, &omap_os_timer_ops, s,
                           "omap-os-timer", 0x800);
@@ -2083,14 +2084,15 @@ static struct omap_mpuio_s *omap_mpuio_init(Object *owner,
 
     s->irq = gpio_int;
     s->kbd_irq = kbd_int;
-    s->in = qemu_allocate_irqs_orphan(omap_mpuio_set, s, 16);
+    s->in = qemu_allocate_irqs(owner, "mpuio-in", omap_mpuio_set, s, 16);
     omap_mpuio_reset(s);
 
     memory_region_init_io(&s->iomem, owner, &omap_mpuio_ops, s,
                           "omap-mpuio", 0x800);
     memory_region_add_subregion(memory, base, &s->iomem);
 
-    omap_clk_adduser(clk, qemu_allocate_irq_orphan(omap_mpuio_onoff, s, 0));
+    omap_clk_adduser(clk, qemu_allocate_irq(owner, "mpuio-clk-onoff[*]",
+                                            omap_mpuio_onoff, s, 0));
 
     return s;
 }
@@ -2363,7 +2365,8 @@ static struct omap_pwl_s *omap_pwl_init(Object *owner,
                           "omap-pwl", 0x800);
     memory_region_add_subregion(system_memory, base, &s->iomem);
 
-    omap_clk_adduser(clk, qemu_allocate_irq_orphan(omap_pwl_clk_update, s, 0));
+    omap_clk_adduser(clk, qemu_allocate_irq(owner, "pwl-clk-irq[*]",
+                                            omap_pwl_clk_update, s, 0));
     return s;
 }
 
@@ -3423,11 +3426,12 @@ static void omap_mcbsp_i2s_start(void *opaque, int line, int level)
     }
 }
 
-void omap_mcbsp_i2s_attach(struct omap_mcbsp_s *s, I2SCodec *slave)
+void omap_mcbsp_i2s_attach(Object *owner, struct omap_mcbsp_s *s, I2SCodec *slave)
 {
     s->codec = slave;
-    slave->rx_swallow = qemu_allocate_irq_orphan(omap_mcbsp_i2s_swallow, s, 0);
-    slave->tx_start = qemu_allocate_irq_orphan(omap_mcbsp_i2s_start, s, 0);
+    slave->rx_swallow = qemu_allocate_irq(owner, "rx-swallow[*]",
+                                          omap_mcbsp_i2s_swallow, s, 0);
+    slave->tx_start = qemu_allocate_irq(owner, "tx-start[*]", omap_mcbsp_i2s_start, s, 0);
 }
 
 /* LED Pulse Generators */
@@ -3579,7 +3583,8 @@ static struct omap_lpg_s *omap_lpg_init(Object *owner,
                           "omap-lpg", 0x800);
     memory_region_add_subregion(system_memory, base, &s->iomem);
 
-    omap_clk_adduser(clk, qemu_allocate_irq_orphan(omap_lpg_clk_update, s, 0));
+    omap_clk_adduser(clk, qemu_allocate_irq(owner, "lpg-clk-irq[*]",
+                                            omap_lpg_clk_update, s, 0));
 
     return s;
 }
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index cd63f39f42..99591e7d80 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -276,7 +276,8 @@ static void realview_init(MachineState *machine,
 
     split_irq_from_named(OBJECT(machine), dev, "card-inserted",
                    qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_CARDIN),
-                   qemu_irq_invert_orphan(qdev_get_gpio_in(gpio2, 0)));
+                   qemu_irq_invert(OBJECT(machine), "mmc-cd-inv",
+                                   qdev_get_gpio_in(gpio2, 0)));
 
     dinfo = drive_get(IF_SD, 0, 0);
     if (dinfo) {
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index a5d037094a..a0986dbfe8 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1358,15 +1358,20 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         sysbus_realize(SYS_BUS_DEVICE(gpad), &error_fatal);
 
         qdev_connect_gpio_out(gpad, 0,
-                              qemu_irq_invert_orphan(gpio_in[GPIO_E][0])); /* up */
+                              qemu_irq_invert(OBJECT(ms), "gpio-in-irq[*]",
+                                              gpio_in[GPIO_E][0])); /* up */
         qdev_connect_gpio_out(gpad, 1,
-                              qemu_irq_invert_orphan(gpio_in[GPIO_E][1])); /* down */
+                              qemu_irq_invert(OBJECT(ms), "gpio-in-irq[*]",
+                                              gpio_in[GPIO_E][1])); /* down */
         qdev_connect_gpio_out(gpad, 2,
-                              qemu_irq_invert_orphan(gpio_in[GPIO_E][2])); /* left */
+                              qemu_irq_invert(OBJECT(ms), "gpio-in-irq[*]",
+                                              gpio_in[GPIO_E][2])); /* left */
         qdev_connect_gpio_out(gpad, 3,
-                              qemu_irq_invert_orphan(gpio_in[GPIO_E][3])); /* right */
+                              qemu_irq_invert(OBJECT(ms), "gpio-in-irq[*]",
+                                              gpio_in[GPIO_E][3])); /* right */
         qdev_connect_gpio_out(gpad, 4,
-                              qemu_irq_invert_orphan(gpio_in[GPIO_F][1])); /* select */
+                              qemu_irq_invert(OBJECT(ms), "gpio-in-irq[*]",
+                                              gpio_in[GPIO_F][1])); /* select */
     }
     for (i = 0; i < 7; i++) {
         if (board->dc4 & (1 << i)) {
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 7a2a3310f9..7efb7a8b9a 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -1109,7 +1109,7 @@ struct soc_dma_s *omap_dma_init(Object *owner, hwaddr base, qemu_irq *irqs,
     s->dma->freq = omap_clk_getrate(clk);
     s->dma->transfer_fn = omap_dma_transfer_generic;
     s->dma->setup_fn = omap_dma_transfer_setup;
-    s->dma->drq = qemu_allocate_irqs_orphan(omap_dma_request, s, 32);
+    s->dma->drq = qemu_allocate_irqs(owner, "drq", omap_dma_request, s, 32);
     s->dma->opaque = s;
 
     while (num_irqs --)
@@ -1123,7 +1123,8 @@ struct soc_dma_s *omap_dma_init(Object *owner, hwaddr base, qemu_irq *irqs,
         s->dma->ch[i].opaque = &s->ch[i];
     }
 
-    omap_clk_adduser(s->clk, qemu_allocate_irq_orphan(omap_dma_clk_update, s, 0));
+    omap_clk_adduser(s->clk, qemu_allocate_irq(owner, "clk-irq",
+                                               omap_dma_clk_update, s, 0));
     omap_dma_reset(s->dma);
     omap_dma_clk_update(s, 0, 1);
 
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 1c29db12a2..42ccc99b1e 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -305,8 +305,10 @@ static void sp804_realize(DeviceState *dev, Error **errp)
 
     s->timer[0] = arm_timer_init(s->freq0);
     s->timer[1] = arm_timer_init(s->freq1);
-    s->timer[0]->irq = qemu_allocate_irq_orphan(sp804_set_irq, s, 0);
-    s->timer[1]->irq = qemu_allocate_irq_orphan(sp804_set_irq, s, 1);
+    s->timer[0]->irq = qemu_allocate_irq(OBJECT(dev), "timer-irq[*]",
+                                         sp804_set_irq, s, 0);
+    s->timer[1]->irq = qemu_allocate_irq(OBJECT(dev), "timer-irq[*]",
+                                         sp804_set_irq, s, 1);
 }
 
 /* Integrator/CP timer module.  */
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 591abf752b..a4267ef30a 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -291,7 +291,7 @@ struct I2SCodec {
     } in, out;
 };
 struct omap_mcbsp_s;
-void omap_mcbsp_i2s_attach(struct omap_mcbsp_s *s, I2SCodec *slave);
+void omap_mcbsp_i2s_attach(Object *owner, struct omap_mcbsp_s *s, I2SCodec *slave);
 
 /* omap_lcdc.c */
 struct omap_lcd_panel_s;
-- 
2.47.1


