Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D98C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigVm-0003HY-CN; Sat, 11 Jul 2026 18:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigVg-0002wm-0b; Sat, 11 Jul 2026 18:49:27 -0400
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([50.112.246.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigVc-0007nk-MM; Sat, 11 Jul 2026 18:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810160; x=1815346160;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uTqgR4UdH4oJzbAyZN9Bzv3ttav7Q2A0k359yMiyx7Q=;
 b=pzSipITh7PhF0bw1nivMucxA+pCGOhU2Ombv4LshjtuJ0N5f37WrhRv4
 ju7dNVN0U1KuiLRt/+nSHP+MM0axtWYYxSXDOgULkuLqFyj/G4LejsKky
 rYX++zRGqFD/9SNvWgaXetD5Nl1jMZMcrlSrIuk2NUFldQ1JZSsZvTAMp
 Jv4ONpC1F16cY8UaC7YcyZ8bltwgvi2QNKjfFWX6w+paoYqV5vdSTzdk2
 YfV2saLffkwvwygOJ3ajS7XGEQWUP6kpdSsjNg33IbgX+svQvy7ShNQe9
 oeR3G29TKItd7w1kmR6iGFFqfNLXMHSQ4WMiyiwtVhrSNWAST+UPigImM A==;
X-CSE-ConnectionGUID: IGt1uzYMR8aZ+gt+cFdLlA==
X-CSE-MsgGUID: zOrW5ybxTCGTFFCgl3hj5Q==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23299967"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:49:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:31314]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.115:2525]
 with esmtp (Farcaster)
 id 6d5a7054-6e9e-4248-a3f0-90d5232929f7; Sat, 11 Jul 2026 22:49:16 +0000 (UTC)
X-Farcaster-Flow-ID: 6d5a7054-6e9e-4248-a3f0-90d5232929f7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:49:16 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:49:08 +0000
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
Subject: [RFC PATCH 046/134] hw/i2c: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:39 +0000
Message-ID: <20260711223707.42139-47-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
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

Convert the *_orphan() device-creation calls in hw/i2c to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/i2c/aspeed_i2c.c:1521 | i2c_slave_create_simple | OBJECT(s) | "slave" | inside AspeedI2CBus DeviceClass.realize(); slave belongs to the bus device
hw/i2c/core.c:367 | - | ORPHAN-JUSTIFIED | - | i2c_slave_new_orphan() is the orphan-API implementation itself; parented sibling already exists at :376
hw/i2c/core.c:371 | - | ORPHAN-JUSTIFIED | - | body of i2c_slave_new_orphan(); intentional orphan wrapper
hw/i2c/core.c:401 | - | ORPHAN-JUSTIFIED | - | i2c_slave_create_simple_orphan() is the orphan-API implementation itself; parented sibling already exists at :386
hw/i2c/core.c:403 | - | ORPHAN-JUSTIFIED | - | body of i2c_slave_create_simple_orphan(); intentional orphan wrapper
hw/i2c/smbus_eeprom.c:167 | qdev_new | parent | "eeprom[*]" | helper called from many board inits; thread Object *parent through smbus_eeprom_init_one() and smbus_eeprom_init() and update all 17 callers

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/aspeed_ast1040_evb.c               |  3 ++-
 hw/arm/aspeed_ast10x0_evb.c               |  3 ++-
 hw/arm/aspeed_ast2400_palmetto.c          |  2 +-
 hw/arm/aspeed_ast2400_supermicrox11.c     |  2 +-
 hw/arm/aspeed_ast2500_evb.c               |  2 +-
 hw/arm/aspeed_ast2500_g220a.c             |  2 +-
 hw/arm/aspeed_ast2500_supermicro-x11spi.c |  2 +-
 hw/arm/aspeed_ast2500_witherspoon.c       |  2 +-
 hw/arm/aspeed_ast2600_evb.c               |  2 +-
 hw/i2c/aspeed_i2c.c                       |  4 ++--
 hw/i2c/smbus_eeprom.c                     | 11 ++++++-----
 hw/i386/pc_piix.c                         |  2 +-
 hw/i386/pc_q35.c                          |  2 +-
 hw/mips/fuloong2e.c                       |  2 +-
 hw/mips/malta.c                           |  2 +-
 hw/ppc/amigaone.c                         |  4 ++--
 hw/ppc/pegasos.c                          |  2 +-
 hw/ppc/sam460ex.c                         |  2 +-
 include/hw/i2c/smbus_eeprom.h             |  5 +++--
 19 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c
index d0326d39f9..fb83087b13 100644
--- a/hw/arm/aspeed_ast1040_evb.c
+++ b/hw/arm/aspeed_ast1040_evb.c
@@ -54,7 +54,8 @@ static void ast1040_evb_i2c_init(AspeedMachineState *bmc)
     AspeedSoCState *soc = bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(256);
 
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50, eeprom_buf);
+    smbus_eeprom_init_one(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
+                          eeprom_buf);
     i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4d);
 }
 
diff --git a/hw/arm/aspeed_ast10x0_evb.c b/hw/arm/aspeed_ast10x0_evb.c
index 52ead37bc7..dc134b555c 100644
--- a/hw/arm/aspeed_ast10x0_evb.c
+++ b/hw/arm/aspeed_ast10x0_evb.c
@@ -70,7 +70,8 @@ static void ast1030_evb_i2c_init(AspeedMachineState *bmc)
 
     /* U10 24C08 connects to SDA/SCL Group 1 by default */
     uint8_t *eeprom_buf = g_malloc0(32 * 1024);
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50, eeprom_buf);
+    smbus_eeprom_init_one(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
+                          eeprom_buf);
 
     /* U11 LM75 connects to SDA/SCL Group 2 by default */
     i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4d);
diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
index d89d042ce2..80f9c911b8 100644
--- a/hw/arm/aspeed_ast2400_palmetto.c
+++ b/hw/arm/aspeed_ast2400_palmetto.c
@@ -39,7 +39,7 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
      */
     i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
 
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
+    smbus_eeprom_init_one(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
 
     /* add a TMP423 temperature sensor */
diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
index 9c90998754..b18adf3981 100644
--- a/hw/arm/aspeed_ast2400_supermicrox11.c
+++ b/hw/arm/aspeed_ast2400_supermicrox11.c
@@ -39,7 +39,7 @@ static void supermicrox11_bmc_i2c_init(AspeedMachineState *bmc)
      */
     i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
 
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
+    smbus_eeprom_init_one(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
 
     /* add a TMP423 temperature sensor */
diff --git a/hw/arm/aspeed_ast2500_evb.c b/hw/arm/aspeed_ast2500_evb.c
index e46ce4a5aa..ba8a56bafd 100644
--- a/hw/arm/aspeed_ast2500_evb.c
+++ b/hw/arm/aspeed_ast2500_evb.c
@@ -30,7 +30,7 @@ static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
     AspeedSoCState *soc = bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
 
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 3), 0x50,
+    smbus_eeprom_init_one(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 3), 0x50,
                           eeprom_buf);
 
     /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
diff --git a/hw/arm/aspeed_ast2500_g220a.c b/hw/arm/aspeed_ast2500_g220a.c
index 577ee0aff4..27c9dc436a 100644
--- a/hw/arm/aspeed_ast2500_g220a.c
+++ b/hw/arm/aspeed_ast2500_g220a.c
@@ -59,7 +59,7 @@ static void g220a_bmc_i2c_init(AspeedMachineState *bmc)
             0x46, 0x46, 0xc4, 0x48, 0x48, 0x47, 0x47, 0xc1,
             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa7,
     };
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 4), 0x57,
+    smbus_eeprom_init_one(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 4), 0x57,
                           eeprom_buf);
 }
 
diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
index 9e95d26901..bea459eeaa 100644
--- a/hw/arm/aspeed_ast2500_supermicro-x11spi.c
+++ b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
@@ -35,7 +35,7 @@ static void supermicro_x11spi_bmc_i2c_init(AspeedMachineState *bmc)
      */
     i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
 
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
+    smbus_eeprom_init_one(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
 
     /* add a TMP423 temperature sensor */
diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
index cb57cb421a..dda090ab60 100644
--- a/hw/arm/aspeed_ast2500_witherspoon.c
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -73,7 +73,7 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
      */
     i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
 
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
+    smbus_eeprom_init_one(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
                           eeprom_buf);
     dev = DEVICE(i2c_slave_new_orphan(TYPE_PCA9552, 0x60));
     qdev_prop_set_string(dev, "description", "pca0");
diff --git a/hw/arm/aspeed_ast2600_evb.c b/hw/arm/aspeed_ast2600_evb.c
index cf1e2b006c..ab7667da75 100644
--- a/hw/arm/aspeed_ast2600_evb.c
+++ b/hw/arm/aspeed_ast2600_evb.c
@@ -23,7 +23,7 @@ static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
     AspeedSoCState *soc = bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
 
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 7), 0x50,
+    smbus_eeprom_init_one(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 7), 0x50,
                           eeprom_buf);
 
     /* LM75 is compatible with TMP105 driver */
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index ac09e5f706..c58ecea011 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1518,8 +1518,8 @@ static void aspeed_i2c_bus_realize(DeviceState *dev, Error **errp)
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 
     s->bus = i2c_init_bus(dev, s->name);
-    s->slave = i2c_slave_create_simple_orphan(s->bus, TYPE_ASPEED_I2C_BUS_SLAVE,
-                                       0xff);
+    s->slave = i2c_slave_create_simple(OBJECT(s), "slave", s->bus,
+                                       TYPE_ASPEED_I2C_BUS_SLAVE, 0xff);
 
     memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i2c_bus_ops,
                           s, s->name, aic->reg_size);
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 59fe07b16b..aaf90a10da 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -160,18 +160,19 @@ static const TypeInfo smbus_eeprom_types[] = {
 
 DEFINE_TYPES(smbus_eeprom_types)
 
-void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
+void smbus_eeprom_init_one(Object *parent, I2CBus *smbus, uint8_t address,
+                           uint8_t *eeprom_buf)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan(TYPE_SMBUS_EEPROM);
+    dev = qdev_new(parent, "eeprom[*]", TYPE_SMBUS_EEPROM);
     qdev_prop_set_uint8(dev, "address", address);
     /* FIXME: use an array of byte or block backend property? */
     SMBUS_EEPROM(dev)->init_data = eeprom_buf;
-    qdev_realize_and_unref(dev, (BusState *)smbus, &error_fatal);
+    qdev_realize(dev, (BusState *)smbus, &error_fatal);
 }
 
-void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
+void smbus_eeprom_init(Object *parent, I2CBus *smbus, int nb_eeprom,
                        const uint8_t *eeprom_spd, int eeprom_spd_size)
 {
     int i;
@@ -184,7 +185,7 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
     }
 
     for (i = 0; i < nb_eeprom; i++) {
-        smbus_eeprom_init_one(smbus, 0x50 + i,
+        smbus_eeprom_init_one(parent, smbus, 0x50 + i,
                               eeprom_buf + (i * SMBUS_EEPROM_SIZE));
     }
 }
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3f361c8396..44ce592ea2 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -304,7 +304,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
         pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
         /* TODO: Populate SPD eeprom data.  */
-        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
+        smbus_eeprom_init(OBJECT(machine), pcms->smbus, 8, NULL, 0);
 
         object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                                  TYPE_HOTPLUG_HANDLER,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a4a7169398..bfea390825 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -317,7 +317,7 @@ static void pc_q35_init(MachineState *machine)
                                               TYPE_ICH9_SMB_DEVICE);
         pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(smb), "i2c"));
 
-        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
+        smbus_eeprom_init(OBJECT(machine), pcms->smbus, 8, NULL, 0);
     }
 
     /* the rest devices to which pci devfn is automatically assigned */
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 5e5ade46f3..0046423d40 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -322,7 +322,7 @@ static void mips_fuloong2e_init(MachineState *machine)
 
     /* Populate SPD eeprom data */
     spd_data = spd_data_generate(DDR, machine->ram_size);
-    smbus_eeprom_init_one(smbus, 0x50, spd_data);
+    smbus_eeprom_init_one(OBJECT(machine), smbus, 0x50, spd_data);
 
     /* Network card: RTL8139D */
     network_init(pci_bus);
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index da6dd15a59..52aae144da 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1249,7 +1249,7 @@ void mips_malta_init(MachineState *machine)
     smbus = I2C_BUS(qdev_get_child_bus(dev, "i2c"));
     generate_eeprom_spd(&smbus_eeprom_buf[0 * 256], ram_size);
     generate_eeprom_serial(&smbus_eeprom_buf[6 * 256]);
-    smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
+    smbus_eeprom_init(OBJECT(machine), smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
     g_free(smbus_eeprom_buf);
 
     /* Super I/O: SMS FDC37M817 */
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 80802d42c6..866e5547d6 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -338,9 +338,9 @@ static void amigaone_init(MachineState *machine)
         spd_data = spd_data_generate(SDR, machine->ram_size);
     }
     fix_spd_data(spd_data);
-    smbus_eeprom_init_one(i2c_bus, 0x51, spd_data);
+    smbus_eeprom_init_one(OBJECT(machine), i2c_bus, 0x51, spd_data);
     if (machine->ram_size > 512 * MiB) {
-        smbus_eeprom_init_one(i2c_bus, 0x52, spd_data);
+        smbus_eeprom_init_one(OBJECT(machine), i2c_bus, 0x52, spd_data);
     }
 
     pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index bba73f60c8..2974625f1c 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -261,7 +261,7 @@ static void pegasos_init(MachineState *machine)
     dev = PCI_DEVICE(object_resolve_path_component(via, "pm"));
     i2c_bus = I2C_BUS(qdev_get_child_bus(DEVICE(dev), "i2c"));
     spd_data = spd_data_generate(DDR, machine->ram_size);
-    smbus_eeprom_init_one(i2c_bus, 0x57, spd_data);
+    smbus_eeprom_init_one(OBJECT(machine), i2c_bus, 0x57, spd_data);
 
     /* other PC hardware */
     pci_vga_init(pci_bus);
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index d23d2c2bd8..8623848633 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -343,7 +343,7 @@ static void sam460ex_init(MachineState *machine)
     spd_data = spd_data_generate(machine->ram_size < 128 * MiB ? DDR : DDR2,
                                  machine->ram_size);
     spd_data[20] = 4; /* SO-DIMM module */
-    smbus_eeprom_init_one(i2c, 0x50, spd_data);
+    smbus_eeprom_init_one(OBJECT(machine), i2c, 0x50, spd_data);
     /* RTC */
     i2c_slave_create_simple_orphan(i2c, "m41t80", 0x68);
 
diff --git a/include/hw/i2c/smbus_eeprom.h b/include/hw/i2c/smbus_eeprom.h
index 61a54cda76..f3aefada42 100644
--- a/include/hw/i2c/smbus_eeprom.h
+++ b/include/hw/i2c/smbus_eeprom.h
@@ -26,8 +26,9 @@
 #include "system/ram_addr.h"
 #include "hw/i2c/i2c.h"
 
-void smbus_eeprom_init_one(I2CBus *bus, uint8_t address, uint8_t *eeprom_buf);
-void smbus_eeprom_init(I2CBus *bus, int nb_eeprom,
+void smbus_eeprom_init_one(Object *parent, I2CBus *bus, uint8_t address,
+                           uint8_t *eeprom_buf);
+void smbus_eeprom_init(Object *parent, I2CBus *bus, int nb_eeprom,
                        const uint8_t *eeprom_spd, int size);
 
 enum sdram_type { SDR = 0x4, DDR = 0x7, DDR2 = 0x8 };
-- 
2.47.1


