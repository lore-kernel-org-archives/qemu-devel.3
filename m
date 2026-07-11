Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC71AC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigZb-0002uM-S4; Sat, 11 Jul 2026 18:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigZZ-0002cu-Ja; Sat, 11 Jul 2026 18:53:25 -0400
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([50.112.246.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigZT-0000Ct-IH; Sat, 11 Jul 2026 18:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810399; x=1815346399;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BLVZUlUyjVn/Tb1g0gLW0Uo0hio6JMI0qfWXwx/6rdI=;
 b=f6OCRSA2pEdSW4rdH72AcEHW7XJSvl9dmxBeDxA83Nsr2OHWu/Gk7o6X
 aMNbCuc0oaexUrEAO/b9XZ4gY2vo3569oRjMvvaWgHOcyxd7voy9fKukr
 t0f+ciOP993LN42nWzvHhQgvavF7kLPHlMB4vYeCoo87Eoj4Z7ye5Qetx
 pOjV41ACFgkZbq3fhVvySi6QF4TLWwafpxQyPD3E14zNu6zjzxq0VxK8Y
 qvftf5LXNOtGakQ7maXOVt2ZsjUGVtDTCd4CCNvn0G/6FFjFtt2P51LZn
 8k+s5aqIeCcVpfWHWnoaUanHBnRV+9CqPhiVWftW0GGO4f8Qw2+DDXnTj g==;
X-CSE-ConnectionGUID: k1Ut2nmORSCR8aEriYh/wA==
X-CSE-MsgGUID: r5O9/Ja0Tcy0UYqJABHfSg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23300043"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:53:15 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:31255]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.115:2525]
 with esmtp (Farcaster)
 id c7513fa4-3f80-48ef-b671-a55a6aa59319; Sat, 11 Jul 2026 22:53:14 +0000 (UTC)
X-Farcaster-Flow-ID: c7513fa4-3f80-48ef-b671-a55a6aa59319
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:53:14 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:53:05 +0000
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
Subject: [RFC PATCH 061/134] hw/arm/npcm: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:54 +0000
Message-ID: <20260711223707.42139-62-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
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

Convert the *_orphan() device-creation calls in the hw/arm npcm
board files to the new parented API introduced earlier in this
series, so every onboard device gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/npcm7xx_boards.c:87 | qdev_new | parent | "flash[*]" | helper: threaded Object *parent from board init; multiple callers/CS → auto-index
hw/arm/npcm7xx_boards.c:116 | qdev_new | parent | "sd-card[*]" | helper: threaded Object *parent from board init; per-unit → auto-index
hw/arm/npcm7xx_boards.c:201 | i2c_slave_create_simple | parent | "tmp105[*]" | helper: threaded Object *parent from board init; 4× tmp105 → auto-index
hw/arm/npcm7xx_boards.c:203 | i2c_slave_create_simple | parent | "tmp105[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:205 | i2c_slave_create_simple | parent | "tmp105[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:207 | i2c_slave_create_simple | parent | "tmp105[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:237 | i2c_slave_create_simple | parent | "tmp105[*]" | helper: threaded Object *parent from board init; 4× tmp105 → auto-index
hw/arm/npcm7xx_boards.c:238 | i2c_slave_create_simple | parent | "tmp105[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:239 | i2c_slave_create_simple | parent | "tmp105[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:240 | i2c_slave_create_simple | parent | "tmp105[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:256 | i2c_slave_create_simple | parent | "pca9548" | helper from board init; single mux
hw/arm/npcm7xx_boards.c:336 | i2c_slave_create_simple | parent | "pca9548[*]" | helper: threaded Object *parent from board init; 4× pca9548 → auto-index
hw/arm/npcm7xx_boards.c:340 | i2c_slave_create_simple | parent | "tmp105[*]" | helper from board init; 8× tmp105 → auto-index
hw/arm/npcm7xx_boards.c:341 | i2c_slave_create_simple | parent | "tmp105[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:342 | i2c_slave_create_simple | parent | "tmp105[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:343 | i2c_slave_create_simple | parent | "tmp105[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:345 | i2c_slave_create_simple | parent | "pca9548[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:347 | i2c_slave_create_simple | parent | "pca9548[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:351 | i2c_slave_create_simple | parent | "pca9548[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:355 | i2c_slave_create_simple | parent | "tmp105[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:356 | i2c_slave_create_simple | parent | "tmp105[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:357 | i2c_slave_create_simple | parent | "tmp105[*]" | helper from board init; auto-index
hw/arm/npcm7xx_boards.c:358 | i2c_slave_create_simple | parent | "tmp105[*]" | helper from board init; auto-index
hw/arm/npcm7xx.c:524 | sysbus_create_simple | OBJECT(dev) | "l2x0" | SoC DeviceClass.realize(dev); single L2 cache ctlr
hw/arm/npcm8xx_boards.c:64 | qdev_new | parent | "flash[*]" | helper: threaded Object *parent from board init; auto-index
hw/arm/npcm8xx_boards.c:162 | i2c_slave_create_simple | parent | "tmp105" | helper: threaded Object *parent from board init; single tmp105

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/npcm7xx.c        |   2 +-
 hw/arm/npcm7xx_boards.c | 107 ++++++++++++++++++++++++----------------
 hw/arm/npcm8xx_boards.c |  19 ++++---
 3 files changed, 77 insertions(+), 51 deletions(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 8363a04f10..a930f7843a 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -521,7 +521,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     }
 
     /* L2 cache controller */
-    sysbus_create_simple_orphan("l2x0", NPCM7XX_L2C_BA, NULL);
+    sysbus_create_simple(OBJECT(dev), "l2x0", "l2x0", NPCM7XX_L2C_BA, NULL);
 
     /* System Global Control Registers (GCR). Can fail due to user input. */
     object_property_set_int(OBJECT(&s->gcr), "disabled-modules",
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 7b5cdd7191..778ef0f232 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -78,17 +78,18 @@ static void npcm7xx_load_bootrom(MachineState *machine, NPCM7xxState *soc)
     }
 }
 
-static void npcm7xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
-                                  const char *flash_type, DriveInfo *dinfo)
+static void npcm7xx_connect_flash(Object *parent, NPCM7xxFIUState *fiu,
+                                  int cs_no, const char *flash_type,
+                                  DriveInfo *dinfo)
 {
     DeviceState *flash;
     qemu_irq flash_cs;
 
-    flash = qdev_new_orphan(flash_type);
+    flash = qdev_new(parent, "flash[*]", flash_type);
     if (dinfo) {
         qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
     }
-    qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
+    qdev_realize(flash, BUS(fiu->spi), &error_fatal);
 
     flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
     qdev_connect_gpio_out_named(DEVICE(fiu), "cs", cs_no, flash_cs);
@@ -102,7 +103,7 @@ static void npcm7xx_connect_dram(NPCM7xxState *soc, MemoryRegion *dram)
                              &error_abort);
 }
 
-static void sdhci_attach_drive(SDHCIState *sdhci, int unit)
+static void sdhci_attach_drive(Object *parent, SDHCIState *sdhci, int unit)
 {
         DriveInfo *di = drive_get(IF_SD, 0, unit);
         BlockBackend *blk = di ? blk_by_legacy_dinfo(di) : NULL;
@@ -113,9 +114,9 @@ static void sdhci_attach_drive(SDHCIState *sdhci, int unit)
             exit(1);
         }
 
-        DeviceState *carddev = qdev_new_orphan(TYPE_SD_CARD);
+        DeviceState *carddev = qdev_new(parent, "sd-card[*]", TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-        qdev_realize_and_unref(carddev, bus, &error_fatal);
+        qdev_realize(carddev, bus, &error_fatal);
 }
 
 static NPCM7xxState *npcm7xx_create_soc(MachineState *machine,
@@ -195,16 +196,20 @@ static void npcm7xx_connect_pwm_fan(NPCM7xxState *soc, SplitIRQ *splitter,
     qdev_connect_gpio_out(DEVICE(splitter), output_no, fan_duty_gpio);
 }
 
-static void npcm750_evb_i2c_init(NPCM7xxState *soc)
+static void npcm750_evb_i2c_init(Object *parent, NPCM7xxState *soc)
 {
     /* lm75 temperature sensor on SVB, tmp105 is compatible */
-    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 0), "tmp105", 0x48);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            npcm7xx_i2c_get_bus(soc, 0), "tmp105", 0x48);
     /* lm75 temperature sensor on EB, tmp105 is compatible */
-    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 1), "tmp105", 0x48);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            npcm7xx_i2c_get_bus(soc, 1), "tmp105", 0x48);
     /* tmp100 temperature sensor on EB, tmp105 is compatible */
-    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 2), "tmp105", 0x48);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            npcm7xx_i2c_get_bus(soc, 2), "tmp105", 0x48);
     /* tmp100 temperature sensor on SVB, tmp105 is compatible */
-    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 6), "tmp105", 0x48);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            npcm7xx_i2c_get_bus(soc, 6), "tmp105", 0x48);
 }
 
 static void npcm750_evb_fan_init(NPCM7xxMachine *machine, NPCM7xxState *soc)
@@ -231,13 +236,17 @@ static void npcm750_evb_fan_init(NPCM7xxMachine *machine, NPCM7xxState *soc)
     npcm7xx_connect_pwm_fan(soc, &splitter[7], 0x0f, 1);
 }
 
-static void quanta_gsj_i2c_init(NPCM7xxState *soc)
+static void quanta_gsj_i2c_init(Object *parent, NPCM7xxState *soc)
 {
     /* GSJ machine have 4 max31725 temperature sensors, tmp105 is compatible. */
-    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 1), "tmp105", 0x5c);
-    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 2), "tmp105", 0x5c);
-    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 3), "tmp105", 0x5c);
-    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 4), "tmp105", 0x5c);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            npcm7xx_i2c_get_bus(soc, 1), "tmp105", 0x5c);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            npcm7xx_i2c_get_bus(soc, 2), "tmp105", 0x5c);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            npcm7xx_i2c_get_bus(soc, 3), "tmp105", 0x5c);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            npcm7xx_i2c_get_bus(soc, 4), "tmp105", 0x5c);
 
     at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 9), 0x55, 8192);
     at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 10), 0x55, 8192);
@@ -253,7 +262,8 @@ static void quanta_gsj_i2c_init(NPCM7xxState *soc)
      * - ucd90160@6b
      */
 
-    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 15), "pca9548", 0x75);
+    i2c_slave_create_simple(parent, "pca9548",
+                            npcm7xx_i2c_get_bus(soc, 15), "pca9548", 0x75);
 }
 
 static void quanta_gsj_fan_init(NPCM7xxMachine *machine, NPCM7xxState *soc)
@@ -329,33 +339,45 @@ static void quanta_gbs_i2c_init(NPCM7xxState *soc)
      */
 }
 
-static void kudo_bmc_i2c_init(NPCM7xxState *soc)
+static void kudo_bmc_i2c_init(Object *parent, NPCM7xxState *soc)
 {
     I2CSlave *i2c_mux;
 
-    i2c_mux = i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 1),
+    i2c_mux = i2c_slave_create_simple(parent, "pca9548[*]",
+                                      npcm7xx_i2c_get_bus(soc, 1),
                                       TYPE_PCA9548, 0x75);
 
     /* tmp105 is compatible with the lm75 */
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105", 0x5c);
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 5), "tmp105", 0x5c);
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 6), "tmp105", 0x5c);
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 7), "tmp105", 0x5c);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            pca954x_i2c_get_bus(i2c_mux, 4), "tmp105", 0x5c);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            pca954x_i2c_get_bus(i2c_mux, 5), "tmp105", 0x5c);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            pca954x_i2c_get_bus(i2c_mux, 6), "tmp105", 0x5c);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            pca954x_i2c_get_bus(i2c_mux, 7), "tmp105", 0x5c);
 
-    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 1), TYPE_PCA9548, 0x77);
+    i2c_slave_create_simple(parent, "pca9548[*]",
+                            npcm7xx_i2c_get_bus(soc, 1), TYPE_PCA9548, 0x77);
 
-    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 4), TYPE_PCA9548, 0x77);
+    i2c_slave_create_simple(parent, "pca9548[*]",
+                            npcm7xx_i2c_get_bus(soc, 4), TYPE_PCA9548, 0x77);
 
     at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 4), 0x50, 8192); /* mbfru */
 
-    i2c_mux = i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 13),
+    i2c_mux = i2c_slave_create_simple(parent, "pca9548[*]",
+                                      npcm7xx_i2c_get_bus(soc, 13),
                                       TYPE_PCA9548, 0x77);
 
     /* tmp105 is compatible with the lm75 */
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 2), "tmp105", 0x48);
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 3), "tmp105", 0x49);
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105", 0x48);
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 5), "tmp105", 0x49);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            pca954x_i2c_get_bus(i2c_mux, 2), "tmp105", 0x48);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            pca954x_i2c_get_bus(i2c_mux, 3), "tmp105", 0x49);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            pca954x_i2c_get_bus(i2c_mux, 4), "tmp105", 0x48);
+    i2c_slave_create_simple(parent, "tmp105[*]",
+                            pca954x_i2c_get_bus(i2c_mux, 5), "tmp105", 0x49);
 
     at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 14), 0x55, 8192); /* bmcfru */
 
@@ -371,8 +393,9 @@ static void npcm750_evb_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     npcm7xx_load_bootrom(machine, soc);
-    npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
-    npcm750_evb_i2c_init(soc);
+    npcm7xx_connect_flash(OBJECT(machine), &soc->fiu[0], 0, "w25q256",
+                          drive_get(IF_MTD, 0, 0));
+    npcm750_evb_i2c_init(OBJECT(machine), soc);
     npcm750_evb_fan_init(NPCM7XX_MACHINE(machine), soc);
     npcm7xx_load_kernel(machine, soc);
 }
@@ -386,9 +409,9 @@ static void quanta_gsj_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     npcm7xx_load_bootrom(machine, soc);
-    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx25l25635e",
+    npcm7xx_connect_flash(OBJECT(machine), &soc->fiu[0], 0, "mx25l25635e",
                           drive_get(IF_MTD, 0, 0));
-    quanta_gsj_i2c_init(soc);
+    quanta_gsj_i2c_init(OBJECT(machine), soc);
     quanta_gsj_fan_init(NPCM7XX_MACHINE(machine), soc);
     npcm7xx_load_kernel(machine, soc);
 }
@@ -403,11 +426,11 @@ static void quanta_gbs_init(MachineState *machine)
 
     npcm7xx_load_bootrom(machine, soc);
 
-    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx66u51235f",
+    npcm7xx_connect_flash(OBJECT(machine), &soc->fiu[0], 0, "mx66u51235f",
                           drive_get(IF_MTD, 0, 0));
 
     quanta_gbs_i2c_init(soc);
-    sdhci_attach_drive(&soc->mmc.sdhci, 0);
+    sdhci_attach_drive(OBJECT(machine), &soc->mmc.sdhci, 0);
     npcm7xx_load_kernel(machine, soc);
 }
 
@@ -420,13 +443,13 @@ static void kudo_bmc_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     npcm7xx_load_bootrom(machine, soc);
-    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx66u51235f",
+    npcm7xx_connect_flash(OBJECT(machine), &soc->fiu[0], 0, "mx66u51235f",
                           drive_get(IF_MTD, 0, 0));
-    npcm7xx_connect_flash(&soc->fiu[1], 0, "mx66u51235f",
+    npcm7xx_connect_flash(OBJECT(machine), &soc->fiu[1], 0, "mx66u51235f",
                           drive_get(IF_MTD, 3, 0));
 
-    kudo_bmc_i2c_init(soc);
-    sdhci_attach_drive(&soc->mmc.sdhci, 0);
+    kudo_bmc_i2c_init(OBJECT(machine), soc);
+    sdhci_attach_drive(OBJECT(machine), &soc->mmc.sdhci, 0);
     npcm7xx_load_kernel(machine, soc);
 }
 
@@ -439,7 +462,7 @@ static void mori_bmc_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     npcm7xx_load_bootrom(machine, soc);
-    npcm7xx_connect_flash(&soc->fiu[1], 0, "mx66u51235f",
+    npcm7xx_connect_flash(OBJECT(machine), &soc->fiu[1], 0, "mx66u51235f",
                           drive_get(IF_MTD, 3, 0));
 
     npcm7xx_load_kernel(machine, soc);
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index eb0248552f..ff2840b409 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -55,17 +55,18 @@ static void npcm8xx_load_bootrom(MachineState *machine, NPCM8xxState *soc)
     }
 }
 
-static void npcm8xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
-                                  const char *flash_type, DriveInfo *dinfo)
+static void npcm8xx_connect_flash(Object *parent, NPCM7xxFIUState *fiu,
+                                  int cs_no, const char *flash_type,
+                                  DriveInfo *dinfo)
 {
     DeviceState *flash;
     qemu_irq flash_cs;
 
-    flash = qdev_new_orphan(flash_type);
+    flash = qdev_new(parent, "flash[*]", flash_type);
     if (dinfo) {
         qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
     }
-    qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
+    qdev_realize(flash, BUS(fiu->spi), &error_fatal);
 
     flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
     qdev_connect_gpio_out_named(DEVICE(fiu), "cs", cs_no, flash_cs);
@@ -156,10 +157,11 @@ static void npcm8xx_connect_pwm_fan(NPCM8xxState *soc, SplitIRQ *splitter,
     qdev_connect_gpio_out(DEVICE(splitter), output_no, fan_duty_gpio);
 }
 
-static void npcm845_evb_i2c_init(NPCM8xxState *soc)
+static void npcm845_evb_i2c_init(Object *parent, NPCM8xxState *soc)
 {
     /* tmp100 temperature sensor on SVB, tmp105 is compatible */
-    i2c_slave_create_simple_orphan(npcm8xx_i2c_get_bus(soc, 6), "tmp105", 0x48);
+    i2c_slave_create_simple(parent, "tmp105",
+                            npcm8xx_i2c_get_bus(soc, 6), "tmp105", 0x48);
 }
 
 static void npcm845_evb_fan_init(NPCM8xxMachine *machine, NPCM8xxState *soc)
@@ -195,8 +197,9 @@ static void npcm845_evb_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     npcm8xx_load_bootrom(machine, soc);
-    npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
-    npcm845_evb_i2c_init(soc);
+    npcm8xx_connect_flash(OBJECT(machine), &soc->fiu[0], 0, "w25q256",
+                          drive_get(IF_MTD, 0, 0));
+    npcm845_evb_i2c_init(OBJECT(machine), soc);
     npcm845_evb_fan_init(NPCM8XX_MACHINE(machine), soc);
     npcm8xx_load_kernel(machine, soc);
 }
-- 
2.47.1


