Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16396C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigbg-0008CZ-NY; Sat, 11 Jul 2026 18:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigbf-00089m-1R; Sat, 11 Jul 2026 18:55:35 -0400
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.155.198.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigbc-0000oF-LQ; Sat, 11 Jul 2026 18:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810532; x=1815346532;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lQU7Pqv5BEyEBZMur78N9gmhRUgMQYfgLuXugUnzrlw=;
 b=VpHrB4mCufNL4sa7UKClZ3l1BoCZg41QJzPLpMAzlxTS3/6jcpdK485Q
 b0D0yI1mbjINqa1ve9frzY7kpYoH7hwG4R/2yD0lUc98tP02TJMX94E9J
 G9baXvSn5ht/EVr2c6Jeopnw1RZfpwbOiPvn3qPX2f0Q8fqdJSAcq5EAo
 4zOGil++5bqKkZ/UAkppERIvGAvlw4UgzGNQW+WJKtS95DGcxvrHr9KhJ
 rL7SK0SeoK8ZK0E76OawBvcDmNlFoY1jDREbXSOrQ4OCOm2bMaAGYIFsr
 LHgQ7BCRJyxEv9ampOgpEpTG9s+QTfBUQY/uObhPeRr5SFS9mdFfL60DQ g==;
X-CSE-ConnectionGUID: FNOToU6FTzejBL/BtwFkVg==
X-CSE-MsgGUID: Cn1LriflQ32Vd5/cL5kUHg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23390577"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:55:28 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:20358]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.68:2525]
 with esmtp (Farcaster)
 id ba66bd41-fa63-49b8-ac5b-11e015e0ef0d; Sat, 11 Jul 2026 22:55:28 +0000 (UTC)
X-Farcaster-Flow-ID: ba66bd41-fa63-49b8-ac5b-11e015e0ef0d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:55:28 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:55:19 +0000
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
Subject: [RFC PATCH 069/134] hw/arm/imx: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:36:02 +0000
Message-ID: <20260711223707.42139-70-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.155.198.111;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in the hw/arm imx
board files to the new parented API introduced earlier in this
series, so every onboard device gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/fsl-imx6.c:171 | sysbus_create_simple_orphan | OBJECT(dev) | "l2x0" | SoC DeviceClass.realize(DeviceState *dev); parent is the SoC device being realized; single instance
hw/arm/imx25_pdk.c:130 | qdev_new_orphan | OBJECT(machine) | "sd-card[*]" | board init(MachineState *machine); loop over ESDHC slots; auto-index; drop _and_unref
hw/arm/imx8mm-evk.c:100 | qdev_new_orphan | OBJECT(machine) | "sd-card[*]" | board init; loop over USDHC slots; auto-index; drop _and_unref
hw/arm/imx8mp-evk.c:113 | qdev_new_orphan | OBJECT(machine) | "sd-card[*]" | board init; loop over USDHC slots; auto-index; drop _and_unref
hw/arm/mcimx6ul-evk.c:62 | qdev_new_orphan | OBJECT(machine) | "sd-card[*]" | board init; loop over USDHC slots; auto-index; drop _and_unref
hw/arm/mcimx7d-sabre.c:62 | qdev_new_orphan | OBJECT(machine) | "sd-card[*]" | board init; loop over USDHC slots; auto-index; drop _and_unref
hw/arm/sabrelite.c:99 | qdev_new_orphan | OBJECT(machine) | "spi-flash" | board init; single NOR flash on SPI bus; drop _and_unref

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/fsl-imx6.c      | 3 ++-
 hw/arm/imx25_pdk.c     | 4 ++--
 hw/arm/imx8mm-evk.c    | 4 ++--
 hw/arm/imx8mp-evk.c    | 4 ++--
 hw/arm/mcimx6ul-evk.c  | 4 ++--
 hw/arm/mcimx7d-sabre.c | 4 ++--
 hw/arm/sabrelite.c     | 5 +++--
 7 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 103adcc2bd..44046953be 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -168,7 +168,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     }
 
     /* L2 cache controller */
-    sysbus_create_simple_orphan("l2x0", FSL_IMX6_PL310_ADDR, NULL);
+    sysbus_create_simple(OBJECT(dev), "l2x0", "l2x0", FSL_IMX6_PL310_ADDR,
+                         NULL);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
         return;
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 6976652370..9351d53850 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -127,9 +127,9 @@ static void imx25_pdk_init(MachineState *machine)
         di = drive_get(IF_SD, 0, i);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
         bus = qdev_get_child_bus(DEVICE(&s->soc.esdhc[i]), "sd-bus");
-        carddev = qdev_new_orphan(TYPE_SD_CARD);
+        carddev = qdev_new(OBJECT(machine), "sd-card[*]", TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-        qdev_realize_and_unref(carddev, bus, &error_fatal);
+        qdev_realize(carddev, bus, &error_fatal);
     }
 
     /*
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index ce7693ca7a..72fa1930ae 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -97,9 +97,9 @@ static void imx8mm_evk_init(MachineState *machine)
 
         blk = blk_by_legacy_dinfo(di);
         bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
-        carddev = qdev_new_orphan(TYPE_SD_CARD);
+        carddev = qdev_new(OBJECT(machine), "sd-card[*]", TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-        qdev_realize_and_unref(carddev, bus, &error_fatal);
+        qdev_realize(carddev, bus, &error_fatal);
     }
 
     if (!qtest_enabled()) {
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 90cda63b49..6116e6e9dc 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -110,9 +110,9 @@ static void imx8mp_evk_init(MachineState *machine)
 
         blk = blk_by_legacy_dinfo(di);
         bus = qdev_get_child_bus(DEVICE(&s->soc.usdhc[i]), "sd-bus");
-        carddev = qdev_new_orphan(TYPE_SD_CARD);
+        carddev = qdev_new(OBJECT(machine), "sd-card[*]", TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-        qdev_realize_and_unref(carddev, bus, &error_fatal);
+        qdev_realize(carddev, bus, &error_fatal);
     }
 
     if (!qtest_enabled()) {
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 96309e1bfc..be4c4ca316 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -59,9 +59,9 @@ static void mcimx6ul_evk_init(MachineState *machine)
         di = drive_get(IF_SD, 0, i);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
         bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
-        carddev = qdev_new_orphan(TYPE_SD_CARD);
+        carddev = qdev_new(OBJECT(machine), "sd-card[*]", TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-        qdev_realize_and_unref(carddev, bus, &error_fatal);
+        qdev_realize(carddev, bus, &error_fatal);
     }
 
     if (!qtest_enabled()) {
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index be9d0d6993..d8b1e7fc7e 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -59,9 +59,9 @@ static void mcimx7d_sabre_init(MachineState *machine)
         di = drive_get(IF_SD, 0, i);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
         bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
-        carddev = qdev_new_orphan(TYPE_SD_CARD);
+        carddev = qdev_new(OBJECT(machine), "sd-card[*]", TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-        qdev_realize_and_unref(carddev, bus, &error_fatal);
+        qdev_realize(carddev, bus, &error_fatal);
     }
 
     if (!qtest_enabled()) {
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index af4dfef7f2..04c764f82f 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -96,13 +96,14 @@ static void sabrelite_init(MachineState *machine)
                 qemu_irq cs_line;
                 DriveInfo *dinfo = drive_get(IF_MTD, 0, 0);
 
-                flash_dev = qdev_new_orphan("sst25vf016b");
+                flash_dev = qdev_new(OBJECT(machine), "spi-flash",
+                                     "sst25vf016b");
                 if (dinfo) {
                     qdev_prop_set_drive_err(flash_dev, "drive",
                                             blk_by_legacy_dinfo(dinfo),
                                             &error_fatal);
                 }
-                qdev_realize_and_unref(flash_dev, BUS(spi_bus), &error_fatal);
+                qdev_realize(flash_dev, BUS(spi_bus), &error_fatal);
 
                 cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
                 qdev_connect_gpio_out(DEVICE(&s->soc.gpio[2]), 19, cs_line);
-- 
2.47.1


