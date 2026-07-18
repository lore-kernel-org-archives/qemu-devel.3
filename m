Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE1FC44521
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD04-0002jK-RO; Sat, 18 Jul 2026 17:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD00-0002Sd-Jp; Sat, 18 Jul 2026 17:55:10 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCzy-0004Bc-0R; Sat, 18 Jul 2026 17:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411706; x=1815947706;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=piG5i0Kw/mZf3qHVMQIIrj0TNSz9zrPVWmSDq4bnoEg=;
 b=bV0EITH1tuojdExmxhvlDTEODB2OcJDX0nYbZpiDPDIeH2MbPDKpr+al
 oaOj1yeTWn0+710qTiiopETjMg1Y9oiXETdVjTgG1rDD4GmKsdbdJrNfp
 6sDIAqXudATLSu4aps8+8hHUVUW0QocUyz0E5ITJM/SDFdTlg3rwy6qpj
 3KkUjKvIgIcknE66SKoqN8AfLmLaB/59Nt8dkvLu9EMX8g2S7KH6/Dm1/
 j3HhWRQYR9+esyJA7s/EvgQc4DhDRRWO/tBk4mnkwlCJFdTfTVYG6NRcH
 FqhAGoP8LNWlnq8+E4edf7EqXYiuhzz3CpOhqHvaRjbJjTE8fCrBJnkZp g==;
X-CSE-ConnectionGUID: v9HHeFCgRM+Sjthrlh2CcQ==
X-CSE-MsgGUID: cp++HSuCTWOXRWW9vOgL6g==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23423041"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:55:02 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:9413]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.230:2525]
 with esmtp (Farcaster)
 id 0aca974a-d9f7-429c-a693-a2e670e44ff1; Sat, 18 Jul 2026 21:55:02 +0000 (UTC)
X-Farcaster-Flow-ID: 0aca974a-d9f7-429c-a693-a2e670e44ff1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:55:01 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:54:52 +0000
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
Subject: [RFC PATCH v2 065/137] hw/arm/exynos: Give onboard devices a QOM
 parent
Date: Sat, 18 Jul 2026 21:35:40 +0000
Message-ID: <20260718213652.37673-66-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.245.243.92;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in the hw/arm exynos
board files to the new parented API introduced earlier in this
series, so every onboard device gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/exynos4210.c:522 | qdev_new | parent (threaded) | "pl330[*]" | pl330_create() static helper: added Object *parent as first arg, threaded from exynos4210_realize() with OBJECT(s). Paired sysbus_realize_and_unref -> sysbus_realize.
hw/arm/exynos4210.c:603 | sysbus_create_simple | OBJECT(s) | "l2x0" | SoC realize(); s = Exynos4210State being realized.
hw/arm/exynos4210.c:670 | sysbus_create_simple | OBJECT(s) | "pmu" | SoC realize(); single instance.
hw/arm/exynos4210.c:672 | sysbus_create_simple | OBJECT(s) | "clk" | SoC realize(); single instance.
hw/arm/exynos4210.c:673 | sysbus_create_simple | OBJECT(s) | "rng" | SoC realize(); single instance.
hw/arm/exynos4210.c:676 | sysbus_create_varargs | OBJECT(s) | "pwm" | SoC realize(); single instance.
hw/arm/exynos4210.c:684 | sysbus_create_varargs | OBJECT(s) | "rtc" | SoC realize(); single instance.
hw/arm/exynos4210.c:690 | qdev_new | OBJECT(s) | "mct" | SoC realize(); paired sysbus_realize_and_unref -> sysbus_realize.
hw/arm/exynos4210.c:716 | qdev_new | OBJECT(s) | "i2c[*]" | SoC realize(); loop over EXYNOS4210_I2C_NUMBER, auto-index. Paired sysbus_realize_and_unref -> sysbus_realize.
hw/arm/exynos4210.c:760 | qdev_new | OBJECT(s) | "sdhci[*]" | SoC realize(); loop over EXYNOS4210_SDHCI_NUMBER. Paired sysbus_realize_and_unref -> sysbus_realize.
hw/arm/exynos4210.c:770 | qdev_new | OBJECT(s) | "sd-card[*]" | SoC realize(); SD cards owned by SoC (bus is not parent). Paired qdev_realize_and_unref -> qdev_realize.
hw/arm/exynos4210.c:777 | qdev_new | OBJECT(s) | "fimd" | SoC realize(); single instance. Paired sysbus_realize_and_unref -> sysbus_realize.
hw/arm/exynos4210.c:787 | sysbus_create_simple | OBJECT(s) | "ehci" | SoC realize(); single instance.

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/exynos4210.c | 60 +++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 7d9d87d7ba..74ce36c1e6 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -512,14 +512,15 @@ static uint64_t exynos4210_calc_affinity(int cpu)
     return (0x9 << ARM_AFF1_SHIFT) | cpu;
 }
 
-static DeviceState *pl330_create(uint32_t base, OrIRQState *orgate,
-                                 qemu_irq irq, int nreq, int nevents, int width)
+static DeviceState *pl330_create(Object *parent, uint32_t base,
+                                 OrIRQState *orgate, qemu_irq irq,
+                                 int nreq, int nevents, int width)
 {
     SysBusDevice *busdev;
     DeviceState *dev;
     int i;
 
-    dev = qdev_new_orphan("pl330");
+    dev = qdev_new(parent, "pl330[*]", "pl330");
     object_property_set_link(OBJECT(dev), "memory",
                              OBJECT(get_system_memory()),
                              &error_fatal);
@@ -534,7 +535,7 @@ static DeviceState *pl330_create(uint32_t base, OrIRQState *orgate,
     qdev_prop_set_uint8(dev, "data_width", width);
     qdev_prop_set_uint16(dev, "data_buffer_dep", width);
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, base);
 
     object_property_set_int(OBJECT(orgate), "num-lines", nevents + 1,
@@ -600,7 +601,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     }
 
     /* Cache controller */
-    sysbus_create_simple_orphan("l2x0", EXYNOS4210_L2X0_BASE_ADDR, NULL);
+    sysbus_create_simple(OBJECT(s), "l2x0", "l2x0",
+                         EXYNOS4210_L2X0_BASE_ADDR, NULL);
 
     /* External GIC */
     qdev_prop_set_uint32(DEVICE(&s->ext_gic), "num-cpu", EXYNOS4210_NCPUS);
@@ -667,13 +669,17 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     * The only reason of existence at the moment is that secondary CPU boot
     * loader uses PMU INFORM5 register as a holding pen.
     */
-    sysbus_create_simple_orphan("exynos4210.pmu", EXYNOS4210_PMU_BASE_ADDR, NULL);
+    sysbus_create_simple(OBJECT(s), "pmu", "exynos4210.pmu",
+                         EXYNOS4210_PMU_BASE_ADDR, NULL);
 
-    sysbus_create_simple_orphan("exynos4210.clk", EXYNOS4210_CLK_BASE_ADDR, NULL);
-    sysbus_create_simple_orphan("exynos4210.rng", EXYNOS4210_RNG_BASE_ADDR, NULL);
+    sysbus_create_simple(OBJECT(s), "clk", "exynos4210.clk",
+                         EXYNOS4210_CLK_BASE_ADDR, NULL);
+    sysbus_create_simple(OBJECT(s), "rng", "exynos4210.rng",
+                         EXYNOS4210_RNG_BASE_ADDR, NULL);
 
     /* PWM */
-    sysbus_create_varargs_orphan("exynos4210.pwm", EXYNOS4210_PWM_BASE_ADDR,
+    sysbus_create_varargs(OBJECT(s), "pwm", "exynos4210.pwm",
+                          EXYNOS4210_PWM_BASE_ADDR,
                           s->irq_table[exynos4210_get_irq(22, 0)],
                           s->irq_table[exynos4210_get_irq(22, 1)],
                           s->irq_table[exynos4210_get_irq(22, 2)],
@@ -681,15 +687,16 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
                           s->irq_table[exynos4210_get_irq(22, 4)],
                           NULL);
     /* RTC */
-    sysbus_create_varargs_orphan("exynos4210.rtc", EXYNOS4210_RTC_BASE_ADDR,
+    sysbus_create_varargs(OBJECT(s), "rtc", "exynos4210.rtc",
+                          EXYNOS4210_RTC_BASE_ADDR,
                           s->irq_table[exynos4210_get_irq(23, 0)],
                           s->irq_table[exynos4210_get_irq(23, 1)],
                           NULL);
 
     /* Multi Core Timer */
-    dev = qdev_new_orphan("exynos4210.mct");
+    dev = qdev_new(OBJECT(s), "mct", "exynos4210.mct");
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     for (n = 0; n < 4; n++) {
         /* Connect global timer interrupts to Combiner gpio_in */
         sysbus_connect_irq(busdev, n,
@@ -713,9 +720,9 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
             i2c_irq = s->irq_table[exynos4210_get_irq(EXYNOS4210_HDMI_INTG, 1)];
         }
 
-        dev = qdev_new_orphan("exynos4210.i2c");
+        dev = qdev_new(OBJECT(s), "i2c[*]", "exynos4210.i2c");
         busdev = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(busdev, &error_fatal);
+        sysbus_realize(busdev, &error_fatal);
         sysbus_connect_irq(busdev, 0, i2c_irq);
         sysbus_mmio_map(busdev, 0, addr);
         s->i2c_if[n] = (I2CBus *)qdev_get_child_bus(dev, "i2c");
@@ -757,46 +764,47 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
          * public datasheet which is very similar (implementing
          * MMC Specification Version 4.0 being the only difference noted)
          */
-        dev = qdev_new_orphan(TYPE_S3C_SDHCI);
+        dev = qdev_new(OBJECT(s), "sdhci[*]", TYPE_S3C_SDHCI);
         qdev_prop_set_uint64(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITIES);
 
         busdev = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(busdev, &error_fatal);
+        sysbus_realize(busdev, &error_fatal);
         sysbus_mmio_map(busdev, 0, EXYNOS4210_SDHCI_ADDR(n));
         sysbus_connect_irq(busdev, 0, s->irq_table[exynos4210_get_irq(29, n)]);
 
         di = drive_get(IF_SD, 0, n);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
-        carddev = qdev_new_orphan(TYPE_SD_CARD);
+        carddev = qdev_new(OBJECT(s), "sd-card[*]", TYPE_SD_CARD);
         qdev_prop_set_drive(carddev, "drive", blk);
-        qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"),
-                               &error_fatal);
+        qdev_realize(carddev, qdev_get_child_bus(dev, "sd-bus"),
+                     &error_fatal);
     }
 
     /*** Display controller (FIMD) ***/
-    dev = qdev_new_orphan("exynos4210.fimd");
+    dev = qdev_new(OBJECT(s), "fimd", "exynos4210.fimd");
     object_property_set_link(OBJECT(dev), "framebuffer-memory",
                              OBJECT(system_mem), &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, EXYNOS4210_FIMD0_BASE_ADDR);
     for (n = 0; n < 3; n++) {
         sysbus_connect_irq(busdev, n, s->irq_table[exynos4210_get_irq(11, n)]);
     }
 
-    sysbus_create_simple_orphan(TYPE_EXYNOS4210_EHCI, EXYNOS4210_EHCI_BASE_ADDR,
-            s->irq_table[exynos4210_get_irq(28, 3)]);
+    sysbus_create_simple(OBJECT(s), "ehci", TYPE_EXYNOS4210_EHCI,
+                         EXYNOS4210_EHCI_BASE_ADDR,
+                         s->irq_table[exynos4210_get_irq(28, 3)]);
 
     /*** DMA controllers ***/
-    pl330[0] = pl330_create(EXYNOS4210_PL330_BASE0_ADDR,
+    pl330[0] = pl330_create(OBJECT(s), EXYNOS4210_PL330_BASE0_ADDR,
                             &s->pl330_irq_orgate[0],
                             s->irq_table[exynos4210_get_irq(21, 0)],
                             32, 32, 32);
-    pl330[1] = pl330_create(EXYNOS4210_PL330_BASE1_ADDR,
+    pl330[1] = pl330_create(OBJECT(s), EXYNOS4210_PL330_BASE1_ADDR,
                             &s->pl330_irq_orgate[1],
                             s->irq_table[exynos4210_get_irq(21, 1)],
                             32, 32, 32);
-    pl330[2] = pl330_create(EXYNOS4210_PL330_BASE2_ADDR,
+    pl330[2] = pl330_create(OBJECT(s), EXYNOS4210_PL330_BASE2_ADDR,
                             &s->pl330_irq_orgate[2],
                             s->irq_table[exynos4210_get_irq(20, 1)],
                             1, 31, 64);
-- 
2.47.1


