Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC80FC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigb3-0006H4-Tc; Sat, 11 Jul 2026 18:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigb2-0006Ab-53; Sat, 11 Jul 2026 18:54:56 -0400
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.77.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigb0-0000aB-2Y; Sat, 11 Jul 2026 18:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810494; x=1815346494;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D9g+aVM94UMznw+s65uqey3AbIXgNoxopxgQZq/AO70=;
 b=nXVxqUVUtHVT3sO8/NxjzcJFuJ79tLuE+7+5FSWe0424erB8sShQ1R0R
 C7riTDegrDVrR8q1fnOBDJdrOWu55vc7pal/9HUCuxWF/AEXCxGjp6w+t
 ppFXbGat8pZPFijIj8ILNRgN+1G/28SF5wfMDrAbV3pSQIWW9LuhAe15F
 o3qntbjIms1bTMuBHbOi9IuWFJiotcElfyiIcDphdemrqexW6QqnWkw73
 GzN5vga6pI4GKJCVvQcue0KQQVEspxb4NnQoI9sG+PfmaE54fydTNh/Qn
 waHA6mjO2x1zzRqiqtjRXGbQk0zFM70dRHGcwoijr//cG2YrCqdwFXvul g==;
X-CSE-ConnectionGUID: r5i9ri9kQw+Ggemfhy22Mw==
X-CSE-MsgGUID: 3PM/+ZQ1RKqgJn08eMY1vQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23493179"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:54:50 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:10930]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.212:2525]
 with esmtp (Farcaster)
 id bdb2d29d-60c8-4ef1-ad63-10db65981f50; Sat, 11 Jul 2026 22:54:49 +0000 (UTC)
X-Farcaster-Flow-ID: bdb2d29d-60c8-4ef1-ad63-10db65981f50
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:54:49 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:54:40 +0000
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
Subject: [RFC PATCH 067/134] hw/arm/omap: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:36:00 +0000
Message-ID: <20260711223707.42139-68-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.77.92;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
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

Convert the *_orphan() device-creation calls in the hw/arm omap
board files to the new parented API introduced earlier in this
series, so every onboard device gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/omap1.c:3752 | cpu_create | parent | "cpu" | omap310_mpu_init() already receives Object *parent; use it directly.
hw/arm/omap1.c:3766 | qdev_new | parent | "intc[0]" | Two interrupt controllers, explicit index. Paired sysbus_realize_and_unref -> sysbus_realize.
hw/arm/omap1.c:3776 | qdev_new | parent | "intc[1]" | Second intc. Paired sysbus_realize_and_unref -> sysbus_realize.
hw/arm/omap1.c:3879 | qdev_new | parent | "mmc" | Single MMC. Paired sysbus_realize_and_unref -> sysbus_realize.
hw/arm/omap1.c:3891 | qdev_new | parent | "sd-card" | Single SD card (bus is not parent). Paired qdev_realize_and_unref -> qdev_realize.
hw/arm/omap1.c:3903 | qdev_new | parent | "gpio" | Single GPIO. Paired sysbus_realize_and_unref -> sysbus_realize.
hw/arm/omap1.c:3920 | qdev_new | parent | "i2c" | Single i2c (only i2c[0] populated on omap1). Paired sysbus_realize_and_unref -> sysbus_realize.

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/omap1.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index c86914a464..e5e092e074 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3749,7 +3749,7 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
     MemoryRegion *system_memory = get_system_memory();
 
     /* Core */
-    s->cpu = ARM_CPU(cpu_create_orphan(cpu_type));
+    s->cpu = ARM_CPU(cpu_create(parent, "cpu", cpu_type));
     s->sdram_size = memory_region_size(dram);
     s->sram_size = OMAP15XX_SRAM_SIZE;
 
@@ -3763,21 +3763,21 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
 
     omap_clkm_init(system_memory, 0xfffece00, 0xe1008000, s);
 
-    s->ih[0] = qdev_new_orphan("omap-intc");
+    s->ih[0] = qdev_new(parent, "intc[0]", "omap-intc");
     qdev_prop_set_uint32(s->ih[0], "size", 0x100);
     omap_intc_set_iclk(OMAP_INTC(s->ih[0]), omap_findclk(s, "arminth_ck"));
     busdev = SYS_BUS_DEVICE(s->ih[0]);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ));
     sysbus_connect_irq(busdev, 1,
                        qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_FIQ));
     sysbus_mmio_map(busdev, 0, 0xfffecb00);
-    s->ih[1] = qdev_new_orphan("omap-intc");
+    s->ih[1] = qdev_new(parent, "intc[1]", "omap-intc");
     qdev_prop_set_uint32(s->ih[1], "size", 0x800);
     omap_intc_set_iclk(OMAP_INTC(s->ih[1]), omap_findclk(s, "arminth_ck"));
     busdev = SYS_BUS_DEVICE(s->ih[1]);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(s->ih[0], OMAP_INT_15XX_IH2_IRQ));
     /* The second interrupt controller's FIQ output is not wired up */
@@ -3876,8 +3876,8 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
         warn_report("missing SecureDigital device");
     }
 
-    s->mmc = qdev_new_orphan(TYPE_OMAP_MMC);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(s->mmc), &error_fatal);
+    s->mmc = qdev_new(parent, "mmc", TYPE_OMAP_MMC);
+    sysbus_realize(SYS_BUS_DEVICE(s->mmc), &error_fatal);
     omap_mmc_set_clk(s->mmc, omap_findclk(s, "mmc_ck"));
 
     memory_region_add_subregion(system_memory, 0xfffb7800,
@@ -3888,11 +3888,11 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
                        qdev_get_gpio_in(s->ih[1], OMAP_INT_OQN));
 
     if (dinfo) {
-        DeviceState *card = qdev_new_orphan(TYPE_SD_CARD);
+        DeviceState *card = qdev_new(parent, "sd-card", TYPE_SD_CARD);
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
-        qdev_realize_and_unref(card, qdev_get_child_bus(s->mmc, "sd-bus"),
-                               &error_fatal);
+        qdev_realize(card, qdev_get_child_bus(s->mmc, "sd-bus"),
+                     &error_fatal);
     }
 
     s->mpuio = omap_mpuio_init(system_memory, 0xfffb5000,
@@ -3900,9 +3900,9 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
                                qdev_get_gpio_in(s->ih[1], OMAP_INT_MPUIO),
                                omap_findclk(s, "clk32-kHz"));
 
-    s->gpio = qdev_new_orphan("omap-gpio");
+    s->gpio = qdev_new(parent, "gpio", "omap-gpio");
     omap_gpio_set_clk(OMAP1_GPIO(s->gpio), omap_findclk(s, "arm_gpio_ck"));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(s->gpio), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(s->gpio), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(s->gpio), 0,
                        qdev_get_gpio_in(s->ih[0], OMAP_INT_GPIO_BANK1));
     sysbus_mmio_map(SYS_BUS_DEVICE(s->gpio), 0, 0xfffce000);
@@ -3917,11 +3917,11 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
     s->pwt = omap_pwt_init(system_memory, 0xfffb6000,
                            omap_findclk(s, "armxor_ck"));
 
-    s->i2c[0] = qdev_new_orphan("omap_i2c");
+    s->i2c[0] = qdev_new(parent, "i2c", "omap_i2c");
     qdev_prop_set_uint8(s->i2c[0], "revision", 0x11);
     omap_i2c_set_fclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "mpuper_ck"));
     busdev = SYS_BUS_DEVICE(s->i2c[0]);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(s->ih[1], OMAP_INT_I2C));
     sysbus_connect_irq(busdev, 1, s->drq[OMAP_DMA_I2C_TX]);
     sysbus_connect_irq(busdev, 2, s->drq[OMAP_DMA_I2C_RX]);
-- 
2.47.1


