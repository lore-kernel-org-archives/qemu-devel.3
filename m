Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5642FC44520
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCkc-0002Aj-Lv; Sat, 18 Jul 2026 17:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCkT-00021q-Qd; Sat, 18 Jul 2026 17:39:07 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCkO-000244-O9; Sat, 18 Jul 2026 17:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784410740; x=1815946740;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+cp5UBuFCU/6+q4YL/3HEtApJtGX3GrviM3GZkm3jxA=;
 b=npEQZe3Yim+gFyuv4Q27TIcnxpNXY/mIUFrC9fxTZjKpBHhCw7C1D9dH
 jLEwhwfx1JiToLY6iwfPebTgYfDtM5FcHVMAXA3zBrANXIDsEpo1TRzV6
 cXxd0Fxunq/Sv0yELUVqgZfbPZwSsq9lNQnp7U0JYVgvc3M5f6EOz7/Id
 BwxxA23NgvTNk5RILi4SYQDWjzZ/Mcz0nwVWWVIL7MlsPCx0LzwhBYEzd
 wfKYq4GZC3GeBlSQmoRJ3d6aI6jAtTSaupA+UyAiWMqn8L8nzz1wr/Es9
 cf7ws0i4PO5aTqDcAkODiL4+kz/XltpuxTM2AuLz6/ptCeh9WM6HnJEre Q==;
X-CSE-ConnectionGUID: zHxtl/CIRNOnap7lmp1q6g==
X-CSE-MsgGUID: ka5Xf88PTj+w93cS0XIHrw==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23422500"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:38:56 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:24211]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.151:2525]
 with esmtp (Farcaster)
 id 9e184146-dcf1-489a-8e53-b67ba13a36b1; Sat, 18 Jul 2026 21:38:56 +0000 (UTC)
X-Farcaster-Flow-ID: 9e184146-dcf1-489a-8e53-b67ba13a36b1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:38:55 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:38:45 +0000
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
Subject: [RFC PATCH v2 007/137] i2c: Make
 i2c_slave_new()/i2c_slave_create_simple() take a QOM parent
Date: Sat, 18 Jul 2026 21:34:42 +0000
Message-ID: <20260718213652.37673-8-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
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

Same rename-and-reintroduce treatment as the qdev, sysbus, PCI and
ISA layers: mechanically rename the two I2C-slave creation helpers
to *_orphan() and reintroduce the short names with a leading
(parent, id, ...) pair.

The parented i2c_slave_create_simple() calls qdev_realize() (not
i2c_slave_realize_and_unref()) since the child<> property already
holds the sole reference.

The mechanical rename part is generated by

  spatch --sp-file \
      scripts/coccinelle/qom-parent/i2c-slave-new-orphan.cocci \
      --in-place --include-headers --dir .

or equivalently

  git ls-files '*.[ch]' '*.[ch].inc' '*.rst' '*.py' | \
      grep -v '^subprojects/' | \
      xargs sed -i \
          's/\bi2c_slave_create_simple\b/&_orphan/g;
           s/\bi2c_slave_new\b/&_orphan/g'

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/aspeed.c                               |  4 +-
 hw/arm/aspeed_ast1040_evb.c                   |  2 +-
 hw/arm/aspeed_ast10x0_evb.c                   |  2 +-
 hw/arm/aspeed_ast2400_palmetto.c              |  4 +-
 hw/arm/aspeed_ast2400_quanta-q71l.c           | 12 ++--
 hw/arm/aspeed_ast2400_supermicrox11.c         |  4 +-
 hw/arm/aspeed_ast2500_evb.c                   |  2 +-
 hw/arm/aspeed_ast2500_g220a.c                 |  6 +-
 hw/arm/aspeed_ast2500_romulus.c               |  2 +-
 hw/arm/aspeed_ast2500_supermicro-x11spi.c     |  4 +-
 hw/arm/aspeed_ast2500_tiogapass.c             |  6 +-
 hw/arm/aspeed_ast2500_witherspoon.c           | 16 ++---
 hw/arm/aspeed_ast2500_yosemitev2.c            |  6 +-
 hw/arm/aspeed_ast2600_anacapa.c               | 26 ++++-----
 hw/arm/aspeed_ast2600_bletchley.c             | 20 +++----
 hw/arm/aspeed_ast2600_catalina.c              | 58 +++++++++----------
 hw/arm/aspeed_ast2600_evb.c                   |  2 +-
 hw/arm/aspeed_ast2600_fby35.c                 | 10 ++--
 hw/arm/aspeed_ast2600_fuji.c                  | 40 ++++++-------
 hw/arm/aspeed_ast2600_gb200nvl.c              | 12 ++--
 hw/arm/aspeed_ast2600_rainier.c               | 46 +++++++--------
 hw/arm/aspeed_ast27x0-fc.c                    |  2 +-
 hw/arm/aspeed_ast27x0_evb.c                   |  2 +-
 hw/arm/bananapi_m2u.c                         |  2 +-
 hw/arm/cubieboard.c                           |  2 +-
 hw/arm/musicpal.c                             |  2 +-
 hw/arm/npcm7xx_boards.c                       | 42 +++++++-------
 hw/arm/npcm8xx_boards.c                       |  2 +-
 hw/arm/realview.c                             |  2 +-
 hw/arm/stellaris.c                            |  2 +-
 hw/arm/versatilepb.c                          |  2 +-
 hw/arm/vexpress.c                             |  2 +-
 hw/display/sii9022.c                          |  2 +-
 hw/i2c/aspeed_i2c.c                           |  2 +-
 hw/i2c/core.c                                 | 26 ++++++++-
 hw/i3c/core.c                                 |  2 +-
 hw/nvram/eeprom_at24c.c                       |  2 +-
 hw/ppc/e500.c                                 |  2 +-
 hw/ppc/pnv.c                                  |  4 +-
 hw/ppc/sam460ex.c                             |  2 +-
 hw/riscv/tt_atlantis.c                        |  4 +-
 include/hw/arm/aspeed.h                       |  4 +-
 include/hw/i2c/i2c.h                          | 38 ++++++++++--
 .../qom-parent/i2c-slave-new-orphan.cocci     | 18 ++++++
 44 files changed, 260 insertions(+), 192 deletions(-)
 create mode 100644 scripts/coccinelle/qom-parent/i2c-slave-new-orphan.cocci

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 531e3ce276..4a4c1f1556 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -253,13 +253,13 @@ static void aspeed_machine_init(MachineState *machine)
 
 void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
 {
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, bus_id),
                             TYPE_PCA9552, addr);
 }
 
 I2CSlave *aspeed_create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
 {
-    return i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
+    return i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, bus_id),
                             TYPE_PCA9554, addr);
 }
 
diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c
index 2b93d4dfbc..d0326d39f9 100644
--- a/hw/arm/aspeed_ast1040_evb.c
+++ b/hw/arm/aspeed_ast1040_evb.c
@@ -55,7 +55,7 @@ static void ast1040_evb_i2c_init(AspeedMachineState *bmc)
     uint8_t *eeprom_buf = g_malloc0(256);
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50, eeprom_buf);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4d);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4d);
 }
 
 static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast10x0_evb.c b/hw/arm/aspeed_ast10x0_evb.c
index c19563d1f0..52ead37bc7 100644
--- a/hw/arm/aspeed_ast10x0_evb.c
+++ b/hw/arm/aspeed_ast10x0_evb.c
@@ -73,7 +73,7 @@ static void ast1030_evb_i2c_init(AspeedMachineState *bmc)
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50, eeprom_buf);
 
     /* U11 LM75 connects to SDA/SCL Group 2 by default */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4d);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4d);
 }
 
 static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
index 776aa43a45..d89d042ce2 100644
--- a/hw/arm/aspeed_ast2400_palmetto.c
+++ b/hw/arm/aspeed_ast2400_palmetto.c
@@ -37,13 +37,13 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
      * The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing
      */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
 
     /* add a TMP423 temperature sensor */
-    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
+    dev = DEVICE(i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 2),
                                          "tmp423", 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
diff --git a/hw/arm/aspeed_ast2400_quanta-q71l.c b/hw/arm/aspeed_ast2400_quanta-q71l.c
index 42ad2a2303..802ae49604 100644
--- a/hw/arm/aspeed_ast2400_quanta-q71l.c
+++ b/hw/arm/aspeed_ast2400_quanta-q71l.c
@@ -33,21 +33,21 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
      * The quanta-q71l platform expects tmp75s which are compatible with
      * tmp105s.
      */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4e);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4f);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4c);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4e);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4f);
 
     /* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */
     /* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */
     /* TODO: Add Memory Riser i2c mux and eeproms. */
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546", 0x74);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548", 0x77);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546", 0x74);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548", 0x77);
 
     /* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */
 
     /* i2c-7 */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546", 0x70);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546", 0x70);
     /*        - i2c@0: pmbus@59 */
     /*        - i2c@1: pmbus@58 */
     /*        - i2c@2: pmbus@58 */
diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
index 88cdb01fc7..9c90998754 100644
--- a/hw/arm/aspeed_ast2400_supermicrox11.c
+++ b/hw/arm/aspeed_ast2400_supermicrox11.c
@@ -37,13 +37,13 @@ static void supermicrox11_bmc_i2c_init(AspeedMachineState *bmc)
      * The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing
      */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
 
     /* add a TMP423 temperature sensor */
-    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
+    dev = DEVICE(i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 2),
                                          "tmp423", 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
diff --git a/hw/arm/aspeed_ast2500_evb.c b/hw/arm/aspeed_ast2500_evb.c
index 8b5cb67be9..e46ce4a5aa 100644
--- a/hw/arm/aspeed_ast2500_evb.c
+++ b/hw/arm/aspeed_ast2500_evb.c
@@ -34,7 +34,7 @@ static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
                           eeprom_buf);
 
     /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 7),
                      TYPE_TMP105, 0x4d);
 }
 
diff --git a/hw/arm/aspeed_ast2500_g220a.c b/hw/arm/aspeed_ast2500_g220a.c
index 3f979a78e5..577ee0aff4 100644
--- a/hw/arm/aspeed_ast2500_g220a.c
+++ b/hw/arm/aspeed_ast2500_g220a.c
@@ -32,19 +32,19 @@ static void g220a_bmc_i2c_init(AspeedMachineState *bmc)
     AspeedSoCState *soc = bmc->soc;
     DeviceState *dev;
 
-    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
+    dev = DEVICE(i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 3),
                                          "emc1413", 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
 
-    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 12),
+    dev = DEVICE(i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 12),
                                          "emc1413", 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
 
-    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 13),
+    dev = DEVICE(i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 13),
                                          "emc1413", 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
diff --git a/hw/arm/aspeed_ast2500_romulus.c b/hw/arm/aspeed_ast2500_romulus.c
index 91b660e74b..1bbd2802f1 100644
--- a/hw/arm/aspeed_ast2500_romulus.c
+++ b/hw/arm/aspeed_ast2500_romulus.c
@@ -30,7 +30,7 @@ static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
      * The romulus board expects Epson RX8900 I2C RTC but a ds1338 is
      * good enough
      */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
 }
 
 static void aspeed_machine_romulus_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
index a2450aa962..9e95d26901 100644
--- a/hw/arm/aspeed_ast2500_supermicro-x11spi.c
+++ b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
@@ -33,13 +33,13 @@ static void supermicro_x11spi_bmc_i2c_init(AspeedMachineState *bmc)
      * The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing
      */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
 
     /* add a TMP423 temperature sensor */
-    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
+    dev = DEVICE(i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 2),
                                          "tmp423", 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
diff --git a/hw/arm/aspeed_ast2500_tiogapass.c b/hw/arm/aspeed_ast2500_tiogapass.c
index 186dbc1da3..a6b3c0d051 100644
--- a/hw/arm/aspeed_ast2500_tiogapass.c
+++ b/hw/arm/aspeed_ast2500_tiogapass.c
@@ -55,9 +55,9 @@ static void tiogapass_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 6), 0x54, 128 * KiB,
                           tiogapass_bmc_fruid, tiogapass_bmc_fruid_len);
     /* TMP421 */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), "tmp421", 0x1f);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", 0x4f);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", 0x4e);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 8), "tmp421", 0x1f);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", 0x4f);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", 0x4e);
 }
 
 static void aspeed_machine_tiogapass_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
index 28d437fec0..cb57cb421a 100644
--- a/hw/arm/aspeed_ast2500_witherspoon.c
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -44,7 +44,7 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
     LEDState *led;
 
     /* Bus 3: TODO bmp280@77 */
-    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
+    dev = DEVICE(i2c_slave_new_orphan(TYPE_PCA9552, 0x60));
     qdev_prop_set_string(dev, "description", "pca1");
     i2c_slave_realize_and_unref(I2C_SLAVE(dev),
                                 aspeed_i2c_get_bus(&soc->i2c, 3),
@@ -58,24 +58,24 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
         qdev_connect_gpio_out(dev, pca1_leds[i].gpio_id,
                               qdev_get_gpio_in(DEVICE(led), 0));
     }
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "dps310", 0x76);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "max31785", 0x52);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 3), "dps310", 0x76);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 3), "max31785", 0x52);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
 
     /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
                      0x4a);
 
     /*
      * The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
      * good enough
      */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
                           eeprom_buf);
-    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
+    dev = DEVICE(i2c_slave_new_orphan(TYPE_PCA9552, 0x60));
     qdev_prop_set_string(dev, "description", "pca0");
     i2c_slave_realize_and_unref(I2C_SLAVE(dev),
                                 aspeed_i2c_get_bus(&soc->i2c, 11),
diff --git a/hw/arm/aspeed_ast2500_yosemitev2.c b/hw/arm/aspeed_ast2500_yosemitev2.c
index eaa75bcccb..905758c345 100644
--- a/hw/arm/aspeed_ast2500_yosemitev2.c
+++ b/hw/arm/aspeed_ast2500_yosemitev2.c
@@ -55,9 +55,9 @@ static void yosemitev2_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51, 128 * KiB,
                           yosemitev2_bmc_fruid, yosemitev2_bmc_fruid_len);
     /* TMP421 */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "tmp421", 0x1f);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", 0x4e);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", 0x4f);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 11), "tmp421", 0x1f);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", 0x4e);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", 0x4f);
 
 }
 
diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index a1c8111a93..98395f196b 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -237,17 +237,17 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     /* eeprom@50 */
     at24c_eeprom_init(i2c[0], 0x50, 256 * KiB);
     /* i2c-mux@70 */
-    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x70);
+    i2c_slave_create_simple_orphan(i2c[0], TYPE_PCA9546, 0x70);
 
     /* &i2c1 */
     /* eeprom@50 */
     at24c_eeprom_init(i2c[1], 0x50, 256 * KiB);
     /* i2c-mux@70 (PCA9546) — 4 channels, empty */
-    i2c_slave_create_simple(i2c[1], TYPE_PCA9546, 0x70);
+    i2c_slave_create_simple_orphan(i2c[1], TYPE_PCA9546, 0x70);
 
     /* &i2c4 */
     /* i2c-mux@70 (PCA9548) */
-    i2c_slave_create_simple(i2c[4], TYPE_PCA9548, 0x70);
+    i2c_slave_create_simple_orphan(i2c[4], TYPE_PCA9548, 0x70);
 
     /* &i2c6 */
     /* eeprom@50 */
@@ -256,15 +256,15 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c8 */
     /* i2c-mux@72 (PCA9546) */
-    i2c_mux = i2c_slave_create_simple(i2c[8], TYPE_PCA9546, 0x72);
+    i2c_mux = i2c_slave_create_simple_orphan(i2c[8], TYPE_PCA9546, 0x72);
 
     /* i2c8mux ch0 */
     /* adc128d818@1f — no model */
     /* pca9555@22 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 0),
                             TYPE_PCA9552, 0x22);
     /* pca9555@24 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 0),
                             TYPE_PCA9552, 0x24);
     /* eeprom@50 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 16 * KiB,
@@ -272,10 +272,10 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* i2c8mux ch1 */
     /* pca9555@22 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9552, 0x22);
     /* pca9555@24 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9552, 0x24);
     /* eeprom@50 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 16 * KiB,
@@ -291,11 +291,11 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c10 */
     /* i2c-mux@71 (PCA9548) */
-    i2c_mux = i2c_slave_create_simple(i2c[10], TYPE_PCA9548, 0x71);
+    i2c_mux = i2c_slave_create_simple_orphan(i2c[10], TYPE_PCA9548, 0x71);
 
     /* i2c10mux ch5 */
     /* pca9555@22*/
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 5),
                             TYPE_PCA9552, 0x22);
     /* eeprom@52 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB,
@@ -303,13 +303,13 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c11 */
     /* i2c-mux@71 (PCA9548) */
-    i2c_mux = i2c_slave_create_simple(i2c[11], TYPE_PCA9548, 0x71);
+    i2c_mux = i2c_slave_create_simple_orphan(i2c[11], TYPE_PCA9548, 0x71);
 
     /* i2c11mux ch0-ch4 — empty */
 
     /* i2c11mux ch5 */
     /* pca9555@22 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 5),
                             TYPE_PCA9552, 0x22);
     /* eeprom@52 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB,
@@ -317,7 +317,7 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c13 */
     /* i2c-mux@70 (PCA9548) */
-    i2c_mux = i2c_slave_create_simple(i2c[13], TYPE_PCA9548, 0x70);
+    i2c_mux = i2c_slave_create_simple_orphan(i2c[13], TYPE_PCA9548, 0x70);
 
     /* i2c13mux ch3 */
     /* adc128d818@1f - no model */
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
index b7e84db143..4930bddb39 100644
--- a/hw/arm/aspeed_ast2600_bletchley.c
+++ b/hw/arm/aspeed_ast2600_bletchley.c
@@ -35,35 +35,35 @@ static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
     for (int i = 0; i < 6; i++) {
         /* Missing model: ti,ina230 @ 0x45 */
         /* Missing model: mps,mp5023 @ 0x40 */
-        i2c_slave_create_simple(i2c[i], TYPE_TMP421, 0x4f);
+        i2c_slave_create_simple_orphan(i2c[i], TYPE_TMP421, 0x4f);
         /* Missing model: nxp,pca9539 @ 0x76, but PCA9552 works enough */
-        i2c_slave_create_simple(i2c[i], TYPE_PCA9552, 0x76);
-        i2c_slave_create_simple(i2c[i], TYPE_PCA9552, 0x67);
+        i2c_slave_create_simple_orphan(i2c[i], TYPE_PCA9552, 0x76);
+        i2c_slave_create_simple_orphan(i2c[i], TYPE_PCA9552, 0x67);
         /* Missing model: fsc,fusb302 @ 0x22 */
     }
 
     /* Bus 6 */
     at24c_eeprom_init(i2c[6], 0x56, 65536);
     /* Missing model: nxp,pcf85263 @ 0x51 , but ds1338 works enough */
-    i2c_slave_create_simple(i2c[6], "ds1338", 0x51);
+    i2c_slave_create_simple_orphan(i2c[6], "ds1338", 0x51);
 
 
     /* Bus 7 */
     at24c_eeprom_init(i2c[7], 0x54, 65536);
 
     /* Bus 9 */
-    i2c_slave_create_simple(i2c[9], TYPE_TMP421, 0x4f);
+    i2c_slave_create_simple_orphan(i2c[9], TYPE_TMP421, 0x4f);
 
     /* Bus 10 */
-    i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x4f);
+    i2c_slave_create_simple_orphan(i2c[10], TYPE_TMP421, 0x4f);
     /* Missing model: ti,hdc1080 @ 0x40 */
-    i2c_slave_create_simple(i2c[10], TYPE_PCA9552, 0x67);
+    i2c_slave_create_simple_orphan(i2c[10], TYPE_PCA9552, 0x67);
 
     /* Bus 12 */
     /* Missing model: adi,adm1278 @ 0x11 */
-    i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4c);
-    i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4d);
-    i2c_slave_create_simple(i2c[12], TYPE_PCA9552, 0x67);
+    i2c_slave_create_simple_orphan(i2c[12], TYPE_TMP421, 0x4c);
+    i2c_slave_create_simple_orphan(i2c[12], TYPE_TMP421, 0x4d);
+    i2c_slave_create_simple_orphan(i2c[12], TYPE_PCA9552, 0x67);
 }
 
 static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 65495a524e..c2c949ace3 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -472,43 +472,43 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c0 */
     /* i2c-mux@71 (PCA9546) on i2c0 */
-    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x71);
+    i2c_slave_create_simple_orphan(i2c[0], TYPE_PCA9546, 0x71);
 
     /* i2c-mux@72 (PCA9546) on i2c0 */
-    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x72);
+    i2c_mux = i2c_slave_create_simple_orphan(i2c[0], TYPE_PCA9546, 0x72);
 
     /* i2c0mux1ch1 */
     /* io_expander7 - pca9535@20 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9535, 0x20);
     /* eeprom@50 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
                           gb200io_eeprom, gb200io_eeprom_len);
 
     /* i2c-mux@73 (PCA9546) on i2c0 */
-    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x73);
+    i2c_slave_create_simple_orphan(i2c[0], TYPE_PCA9546, 0x73);
 
     /* i2c-mux@75 (PCA9546) on i2c0 */
-    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x75);
+    i2c_slave_create_simple_orphan(i2c[0], TYPE_PCA9546, 0x75);
 
     /* i2c-mux@76 (PCA9546) on i2c0 */
-    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x76);
+    i2c_mux = i2c_slave_create_simple_orphan(i2c[0], TYPE_PCA9546, 0x76);
 
     /* i2c0mux4ch1 */
     /* io_expander8 - pca9535@21 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9535, 0x21);
     /* eeprom@50 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
                           gb200io_eeprom, gb200io_eeprom_len);
 
     /* i2c-mux@77 (PCA9546) on i2c0 */
-    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x77);
+    i2c_slave_create_simple_orphan(i2c[0], TYPE_PCA9546, 0x77);
 
 
     /* &i2c1 */
     /* i2c-mux@70 (PCA9548) on i2c1 */
-    i2c_mux = i2c_slave_create_simple(i2c[1], TYPE_PCA9548, 0x70);
+    i2c_mux = i2c_slave_create_simple_orphan(i2c[1], TYPE_PCA9548, 0x70);
     /* i2c1mux0ch0 */
     /* ina238@41 - no model */
     /* ina238@42 - no model */
@@ -525,14 +525,14 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x54, 8 * KiB,
                           pdb_eeprom, pdb_eeprom_len);
     /* tpm75@4f */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), TYPE_TMP75, 0x4f);
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 5), TYPE_TMP75, 0x4f);
 
     /* i2c1mux0ch6 */
     /* io_expander5 - pca9554@27 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 6),
                             TYPE_PCA9554, 0x27);
     /* io_expander6 - pca9555@25 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 6),
                             TYPE_PCA9552, 0x25);
     /* eeprom@51 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 6), 0x51, 8 * KiB,
@@ -543,15 +543,15 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 7), 0x53, 8 * KiB,
                           fio_eeprom, fio_eeprom_len);
     /* temperature-sensor@4b - tmp75 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), TYPE_TMP75, 0x4b);
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 7), TYPE_TMP75, 0x4b);
 
     /* &i2c2 */
     /* io_expander0 - pca9555@20 */
-    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x20);
+    i2c_slave_create_simple_orphan(i2c[2], TYPE_PCA9552, 0x20);
     /* io_expander0 - pca9555@21 */
-    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x21);
+    i2c_slave_create_simple_orphan(i2c[2], TYPE_PCA9552, 0x21);
     /* io_expander0 - pca9555@27 */
-    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x27);
+    i2c_slave_create_simple_orphan(i2c[2], TYPE_PCA9552, 0x27);
     /* eeprom@50 */
     at24c_eeprom_init(i2c[2], 0x50, 8 * KiB);
     /* eeprom@51 */
@@ -559,7 +559,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c5 */
     /* i2c-mux@70 (PCA9548) on i2c5 */
-    i2c_mux = i2c_slave_create_simple(i2c[5], TYPE_PCA9548, 0x70);
+    i2c_mux = i2c_slave_create_simple_orphan(i2c[5], TYPE_PCA9548, 0x70);
     /* i2c5mux0ch6 */
     /* eeprom@52 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 6), 0x52, 8 * KiB,
@@ -572,15 +572,15 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c6 */
     /* io_expander3 - pca9555@21 */
-    i2c_slave_create_simple(i2c[6], TYPE_PCA9552, 0x21);
+    i2c_slave_create_simple_orphan(i2c[6], TYPE_PCA9552, 0x21);
     /* rtc@6f - nct3018y */
-    i2c_slave_create_simple(i2c[6], TYPE_DS1338, 0x6f);
+    i2c_slave_create_simple_orphan(i2c[6], TYPE_DS1338, 0x6f);
 
     /* &i2c9 */
     /* io_expander4 - pca9555@4f */
-    i2c_slave_create_simple(i2c[9], TYPE_PCA9552, 0x4f);
+    i2c_slave_create_simple_orphan(i2c[9], TYPE_PCA9552, 0x4f);
     /* temperature-sensor@4b - tpm75 */
-    i2c_slave_create_simple(i2c[9], TYPE_TMP75, 0x4b);
+    i2c_slave_create_simple_orphan(i2c[9], TYPE_TMP75, 0x4b);
     /* eeprom@50 */
     at24c_eeprom_init_rom(i2c[9], 0x50, 8 * KiB, scm_eeprom, scm_eeprom_len);
     /* eeprom@56 */
@@ -588,7 +588,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c10 */
     /* temperature-sensor@1f - tpm421 */
-    i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x1f);
+    i2c_slave_create_simple_orphan(i2c[10], TYPE_TMP421, 0x1f);
     /* eeprom@50 */
     at24c_eeprom_init_rom(i2c[10], 0x50, 8 * KiB, nic_eeprom, nic_eeprom_len);
 
@@ -615,21 +615,21 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c14 */
     /* io_expander9 - pca9555@10 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x10);
+    i2c_slave_create_simple_orphan(i2c[14], TYPE_PCA9552, 0x10);
     /* io_expander10 - pca9555@11 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x11);
+    i2c_slave_create_simple_orphan(i2c[14], TYPE_PCA9552, 0x11);
     /* io_expander11 - pca9555@12 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x12);
+    i2c_slave_create_simple_orphan(i2c[14], TYPE_PCA9552, 0x12);
     /* io_expander12 - pca9555@13 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x13);
+    i2c_slave_create_simple_orphan(i2c[14], TYPE_PCA9552, 0x13);
     /* io_expander13 - pca9555@14 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x14);
+    i2c_slave_create_simple_orphan(i2c[14], TYPE_PCA9552, 0x14);
     /* io_expander14 - pca9555@15 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x15);
+    i2c_slave_create_simple_orphan(i2c[14], TYPE_PCA9552, 0x15);
 
     /* &i2c15 */
     /* temperature-sensor@1f - tmp421 */
-    i2c_slave_create_simple(i2c[15], TYPE_TMP421, 0x1f);
+    i2c_slave_create_simple_orphan(i2c[15], TYPE_TMP421, 0x1f);
     /* eeprom@52 */
     at24c_eeprom_init_rom(i2c[15], 0x52, 8 * KiB, nic_eeprom, nic_eeprom_len);
 }
diff --git a/hw/arm/aspeed_ast2600_evb.c b/hw/arm/aspeed_ast2600_evb.c
index c43d2687c1..cf1e2b006c 100644
--- a/hw/arm/aspeed_ast2600_evb.c
+++ b/hw/arm/aspeed_ast2600_evb.c
@@ -27,7 +27,7 @@ static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
                           eeprom_buf);
 
     /* LM75 is compatible with TMP105 driver */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 8),
                      TYPE_TMP105, 0x4d);
 }
 
diff --git a/hw/arm/aspeed_ast2600_fby35.c b/hw/arm/aspeed_ast2600_fby35.c
index f624427070..fcd1acdc17 100644
--- a/hw/arm/aspeed_ast2600_fby35.c
+++ b/hw/arm/aspeed_ast2600_fby35.c
@@ -102,12 +102,12 @@ static void fby35_i2c_init(AspeedMachineState *bmc)
         i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
     }
 
-    i2c_slave_create_simple(i2c[2], TYPE_LM75, 0x4f);
-    i2c_slave_create_simple(i2c[8], TYPE_TMP421, 0x1f);
+    i2c_slave_create_simple_orphan(i2c[2], TYPE_LM75, 0x4f);
+    i2c_slave_create_simple_orphan(i2c[8], TYPE_TMP421, 0x1f);
     /* Hotswap controller is actually supposed to be mp5920 or ltc4282. */
-    i2c_slave_create_simple(i2c[11], "adm1272", 0x44);
-    i2c_slave_create_simple(i2c[12], TYPE_LM75, 0x4e);
-    i2c_slave_create_simple(i2c[12], TYPE_LM75, 0x4f);
+    i2c_slave_create_simple_orphan(i2c[11], "adm1272", 0x44);
+    i2c_slave_create_simple_orphan(i2c[12], TYPE_LM75, 0x4e);
+    i2c_slave_create_simple_orphan(i2c[12], TYPE_LM75, 0x4f);
 
     at24c_eeprom_init(i2c[4], 0x51, 128 * KiB);
     at24c_eeprom_init(i2c[6], 0x51, 128 * KiB);
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index 37db252e27..59b2da1ccf 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -27,7 +27,7 @@
 static void get_pca9548_channels(I2CBus *bus, uint8_t mux_addr,
                                  I2CBus **channels)
 {
-    I2CSlave *mux = i2c_slave_create_simple(bus, "pca9548", mux_addr);
+    I2CSlave *mux = i2c_slave_create_simple_orphan(bus, "pca9548", mux_addr);
     for (int i = 0; i < 8; i++) {
         channels[i] = pca954x_i2c_get_bus(mux, i);
     }
@@ -57,8 +57,8 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
         get_pca9548_channels(i2c[40 + i], 0x76, &i2c[80 + i * 8]);
     }
 
-    i2c_slave_create_simple(i2c[17], TYPE_LM75, 0x4c);
-    i2c_slave_create_simple(i2c[17], TYPE_LM75, 0x4d);
+    i2c_slave_create_simple_orphan(i2c[17], TYPE_LM75, 0x4c);
+    i2c_slave_create_simple_orphan(i2c[17], TYPE_LM75, 0x4d);
 
     /*
      * EEPROM 24c64 size is 64Kbits or 8 Kbytes
@@ -68,33 +68,33 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init(i2c[20], 0x50, 256);
     at24c_eeprom_init(i2c[22], 0x52, 256);
 
-    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x48);
-    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x49);
-    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x4a);
-    i2c_slave_create_simple(i2c[3], TYPE_TMP422, 0x4c);
+    i2c_slave_create_simple_orphan(i2c[3], TYPE_LM75, 0x48);
+    i2c_slave_create_simple_orphan(i2c[3], TYPE_LM75, 0x49);
+    i2c_slave_create_simple_orphan(i2c[3], TYPE_LM75, 0x4a);
+    i2c_slave_create_simple_orphan(i2c[3], TYPE_TMP422, 0x4c);
 
     at24c_eeprom_init(i2c[8], 0x51, 8 * KiB);
-    i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x4a);
+    i2c_slave_create_simple_orphan(i2c[8], TYPE_LM75, 0x4a);
 
-    i2c_slave_create_simple(i2c[50], TYPE_LM75, 0x4c);
+    i2c_slave_create_simple_orphan(i2c[50], TYPE_LM75, 0x4c);
     at24c_eeprom_init(i2c[50], 0x52, 8 * KiB);
-    i2c_slave_create_simple(i2c[51], TYPE_TMP75, 0x48);
-    i2c_slave_create_simple(i2c[52], TYPE_TMP75, 0x49);
+    i2c_slave_create_simple_orphan(i2c[51], TYPE_TMP75, 0x48);
+    i2c_slave_create_simple_orphan(i2c[52], TYPE_TMP75, 0x49);
 
-    i2c_slave_create_simple(i2c[59], TYPE_TMP75, 0x48);
-    i2c_slave_create_simple(i2c[60], TYPE_TMP75, 0x49);
+    i2c_slave_create_simple_orphan(i2c[59], TYPE_TMP75, 0x48);
+    i2c_slave_create_simple_orphan(i2c[60], TYPE_TMP75, 0x49);
 
     at24c_eeprom_init(i2c[65], 0x53, 8 * KiB);
-    i2c_slave_create_simple(i2c[66], TYPE_TMP75, 0x49);
-    i2c_slave_create_simple(i2c[66], TYPE_TMP75, 0x48);
+    i2c_slave_create_simple_orphan(i2c[66], TYPE_TMP75, 0x49);
+    i2c_slave_create_simple_orphan(i2c[66], TYPE_TMP75, 0x48);
     at24c_eeprom_init(i2c[68], 0x52, 8 * KiB);
     at24c_eeprom_init(i2c[69], 0x52, 8 * KiB);
     at24c_eeprom_init(i2c[70], 0x52, 8 * KiB);
     at24c_eeprom_init(i2c[71], 0x52, 8 * KiB);
 
     at24c_eeprom_init(i2c[73], 0x53, 8 * KiB);
-    i2c_slave_create_simple(i2c[74], TYPE_TMP75, 0x49);
-    i2c_slave_create_simple(i2c[74], TYPE_TMP75, 0x48);
+    i2c_slave_create_simple_orphan(i2c[74], TYPE_TMP75, 0x49);
+    i2c_slave_create_simple_orphan(i2c[74], TYPE_TMP75, 0x48);
     at24c_eeprom_init(i2c[76], 0x52, 8 * KiB);
     at24c_eeprom_init(i2c[77], 0x52, 8 * KiB);
     at24c_eeprom_init(i2c[78], 0x52, 8 * KiB);
@@ -103,9 +103,9 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
 
     for (int i = 0; i < 8; i++) {
         at24c_eeprom_init(i2c[81 + i * 8], 0x56, 64 * KiB);
-        i2c_slave_create_simple(i2c[82 + i * 8], TYPE_TMP75, 0x48);
-        i2c_slave_create_simple(i2c[83 + i * 8], TYPE_TMP75, 0x4b);
-        i2c_slave_create_simple(i2c[84 + i * 8], TYPE_TMP75, 0x4a);
+        i2c_slave_create_simple_orphan(i2c[82 + i * 8], TYPE_TMP75, 0x48);
+        i2c_slave_create_simple_orphan(i2c[83 + i * 8], TYPE_TMP75, 0x4b);
+        i2c_slave_create_simple_orphan(i2c[84 + i * 8], TYPE_TMP75, 0x4a);
     }
 }
 
diff --git a/hw/arm/aspeed_ast2600_gb200nvl.c b/hw/arm/aspeed_ast2600_gb200nvl.c
index ad9a10110b..2c1c513674 100644
--- a/hw/arm/aspeed_ast2600_gb200nvl.c
+++ b/hw/arm/aspeed_ast2600_gb200nvl.c
@@ -54,12 +54,12 @@ static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
     aspeed_create_pca9554(soc, 4, 0x21);
 
     /* Mux I2c Expanders */
-    i2c_slave_create_simple(i2c[5], "pca9546", 0x71);
-    i2c_slave_create_simple(i2c[5], "pca9546", 0x72);
-    i2c_slave_create_simple(i2c[5], "pca9546", 0x73);
-    i2c_slave_create_simple(i2c[5], "pca9546", 0x75);
-    i2c_slave_create_simple(i2c[5], "pca9546", 0x76);
-    i2c_slave_create_simple(i2c[5], "pca9546", 0x77);
+    i2c_slave_create_simple_orphan(i2c[5], "pca9546", 0x71);
+    i2c_slave_create_simple_orphan(i2c[5], "pca9546", 0x72);
+    i2c_slave_create_simple_orphan(i2c[5], "pca9546", 0x73);
+    i2c_slave_create_simple_orphan(i2c[5], "pca9546", 0x75);
+    i2c_slave_create_simple_orphan(i2c[5], "pca9546", 0x76);
+    i2c_slave_create_simple_orphan(i2c[5], "pca9546", 0x77);
 
     /* Bus 10 */
     dev = DEVICE(aspeed_create_pca9554(soc, 9, 0x20));
diff --git a/hw/arm/aspeed_ast2600_rainier.c b/hw/arm/aspeed_ast2600_rainier.c
index 8f0a412ddc..0495c2880c 100644
--- a/hw/arm/aspeed_ast2600_rainier.c
+++ b/hw/arm/aspeed_ast2600_rainier.c
@@ -73,37 +73,37 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     aspeed_create_pca9552(soc, 3, 0x61);
 
     /* The rainier expects a TMP275 but a TMP105 is compatible */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
                      0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
                      0x49);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
                      0x4a);
-    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
+    i2c_mux = i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 4),
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x52, 64 * KiB);
     aspeed_create_pca9552(soc, 4, 0x60);
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
                      0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
                      0x49);
     aspeed_create_pca9552(soc, 5, 0x60);
     aspeed_create_pca9552(soc, 5, 0x61);
-    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
+    i2c_mux = i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 5),
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
                      0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
                      0x4a);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
                      0x4b);
-    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
+    i2c_mux = i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 6),
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
@@ -116,17 +116,17 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     aspeed_create_pca9552(soc, 7, 0x33);
     aspeed_create_pca9552(soc, 7, 0x60);
     aspeed_create_pca9552(soc, 7, 0x61);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "dps310", 0x76);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 7), "dps310", 0x76);
     /* Bus 7: TODO si7021-a20@20 */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), TYPE_TMP105,
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 7), TYPE_TMP105,
                      0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "max31785", 0x52);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 7), "max31785", 0x52);
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x50, 64 * KiB);
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x51, 64 * KiB);
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
                      0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
                      0x4a);
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50,
                           64 * KiB, rainier_bb_fruid, rainier_bb_fruid_len);
@@ -138,19 +138,19 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     /* Bus 8: ucd90320@b */
     /* Bus 8: ucd90320@c */
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4d);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4c);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4d);
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 9), 0x50, 128 * KiB);
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4d);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4c);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4d);
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 10), 0x50, 128 * KiB);
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,
                      0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,
                      0x49);
-    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
+    i2c_mux = i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 11),
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 7d9fade68d..f21c842315 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -109,7 +109,7 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
     /*
      * AST2700 EVB has a LM75 temperature sensor on I2C bus 0 at address 0x4d.
      */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "tmp105", 0x4d);
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 0), "tmp105", 0x4d);
 
     aspeed_board_init_flashes(&soc->fmc, AST2700FC_FMC_MODEL, 2, 0);
     aspeed_board_init_flashes(&soc->spi[0], AST2700FC_SPI_MODEL, 1, 2);
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 0ff1bebeb0..a59714372d 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -24,7 +24,7 @@ static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
     AspeedSoCState *soc = bmc->soc;
 
     /* LM75 is compatible with TMP105 driver */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0),
+    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 0),
                             TYPE_TMP105, 0x4d);
 }
 
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 748db26d41..809c8bbc43 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -114,7 +114,7 @@ static void bpim2u_init(MachineState *machine)
 
     /* Connect AXP221 */
     i2c = I2C_BUS(qdev_get_child_bus(DEVICE(&r40->i2c0), "i2c"));
-    i2c_slave_create_simple(i2c, "axp221_pmu", 0x34);
+    i2c_slave_create_simple_orphan(i2c, "axp221_pmu", 0x34);
 
     /* SDRAM */
     memory_region_add_subregion(get_system_memory(),
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 215741a194..7ce5179345 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -81,7 +81,7 @@ static void cubieboard_init(MachineState *machine)
 
     /* Connect AXP 209 */
     i2c = I2C_BUS(qdev_get_child_bus(DEVICE(&a10->i2c0), "i2c"));
-    i2c_slave_create_simple(i2c, "axp209_pmu", 0x34);
+    i2c_slave_create_simple_orphan(i2c, "axp209_pmu", 0x34);
 
     /* Retrieve SD bus */
     di = drive_get(IF_SD, 0, 0);
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 3bcdea7db8..baab159bfd 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1327,7 +1327,7 @@ static void musicpal_init(MachineState *machine)
         qdev_connect_gpio_out(key_dev, i, qdev_get_gpio_in(dev, i + 15));
     }
 
-    wm8750_dev = i2c_slave_new(TYPE_WM8750, MP_WM_ADDR);
+    wm8750_dev = i2c_slave_new_orphan(TYPE_WM8750, MP_WM_ADDR);
     if (machine->audiodev) {
         qdev_prop_set_string(DEVICE(wm8750_dev), "audiodev", machine->audiodev);
     }
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 9e5d5f08f9..7b5cdd7191 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -198,13 +198,13 @@ static void npcm7xx_connect_pwm_fan(NPCM7xxState *soc, SplitIRQ *splitter,
 static void npcm750_evb_i2c_init(NPCM7xxState *soc)
 {
     /* lm75 temperature sensor on SVB, tmp105 is compatible */
-    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 0), "tmp105", 0x48);
+    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 0), "tmp105", 0x48);
     /* lm75 temperature sensor on EB, tmp105 is compatible */
-    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1), "tmp105", 0x48);
+    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 1), "tmp105", 0x48);
     /* tmp100 temperature sensor on EB, tmp105 is compatible */
-    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 2), "tmp105", 0x48);
+    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 2), "tmp105", 0x48);
     /* tmp100 temperature sensor on SVB, tmp105 is compatible */
-    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 6), "tmp105", 0x48);
+    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 6), "tmp105", 0x48);
 }
 
 static void npcm750_evb_fan_init(NPCM7xxMachine *machine, NPCM7xxState *soc)
@@ -234,10 +234,10 @@ static void npcm750_evb_fan_init(NPCM7xxMachine *machine, NPCM7xxState *soc)
 static void quanta_gsj_i2c_init(NPCM7xxState *soc)
 {
     /* GSJ machine have 4 max31725 temperature sensors, tmp105 is compatible. */
-    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1), "tmp105", 0x5c);
-    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 2), "tmp105", 0x5c);
-    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 3), "tmp105", 0x5c);
-    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 4), "tmp105", 0x5c);
+    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 1), "tmp105", 0x5c);
+    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 2), "tmp105", 0x5c);
+    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 3), "tmp105", 0x5c);
+    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 4), "tmp105", 0x5c);
 
     at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 9), 0x55, 8192);
     at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 10), 0x55, 8192);
@@ -253,7 +253,7 @@ static void quanta_gsj_i2c_init(NPCM7xxState *soc)
      * - ucd90160@6b
      */
 
-    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 15), "pca9548", 0x75);
+    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 15), "pca9548", 0x75);
 }
 
 static void quanta_gsj_fan_init(NPCM7xxMachine *machine, NPCM7xxState *soc)
@@ -333,29 +333,29 @@ static void kudo_bmc_i2c_init(NPCM7xxState *soc)
 {
     I2CSlave *i2c_mux;
 
-    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1),
+    i2c_mux = i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 1),
                                       TYPE_PCA9548, 0x75);
 
     /* tmp105 is compatible with the lm75 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105", 0x5c);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), "tmp105", 0x5c);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6), "tmp105", 0x5c);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), "tmp105", 0x5c);
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105", 0x5c);
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 5), "tmp105", 0x5c);
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 6), "tmp105", 0x5c);
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 7), "tmp105", 0x5c);
 
-    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1), TYPE_PCA9548, 0x77);
+    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 1), TYPE_PCA9548, 0x77);
 
-    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 4), TYPE_PCA9548, 0x77);
+    i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 4), TYPE_PCA9548, 0x77);
 
     at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 4), 0x50, 8192); /* mbfru */
 
-    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 13),
+    i2c_mux = i2c_slave_create_simple_orphan(npcm7xx_i2c_get_bus(soc, 13),
                                       TYPE_PCA9548, 0x77);
 
     /* tmp105 is compatible with the lm75 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), "tmp105", 0x48);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 3), "tmp105", 0x49);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105", 0x48);
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), "tmp105", 0x49);
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 2), "tmp105", 0x48);
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 3), "tmp105", 0x49);
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105", 0x48);
+    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 5), "tmp105", 0x49);
 
     at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 14), 0x55, 8192); /* bmcfru */
 
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 10df2d614c..eb0248552f 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -159,7 +159,7 @@ static void npcm8xx_connect_pwm_fan(NPCM8xxState *soc, SplitIRQ *splitter,
 static void npcm845_evb_i2c_init(NPCM8xxState *soc)
 {
     /* tmp100 temperature sensor on SVB, tmp105 is compatible */
-    i2c_slave_create_simple(npcm8xx_i2c_get_bus(soc, 6), "tmp105", 0x48);
+    i2c_slave_create_simple_orphan(npcm8xx_i2c_get_bus(soc, 6), "tmp105", 0x48);
 }
 
 static void npcm845_evb_fan_init(NPCM8xxMachine *machine, NPCM8xxState *soc)
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 0642e35dd2..f37ddf8073 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -321,7 +321,7 @@ static void realview_init(MachineState *machine,
 
     dev = sysbus_create_simple_orphan(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
-    i2c_slave_create_simple(i2c, "ds1338", 0x68);
+    i2c_slave_create_simple_orphan(i2c, "ds1338", 0x68);
 
     /* Memory map for RealView Emulation Baseboard:  */
     /* 0x10000000 System registers.  */
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 3f72cedf2e..f9d2a61f9c 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1209,7 +1209,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     if (board->peripherals & BP_OLED_I2C) {
         I2CBus *bus = (I2CBus *)qdev_get_child_bus(i2c_dev[0], "i2c");
 
-        i2c_slave_create_simple(bus, "ssd0303", 0x3d);
+        i2c_slave_create_simple_orphan(bus, "ssd0303", 0x3d);
     }
 
     for (i = 0; i < NUM_UART; i++) {
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 81bd397b5d..dcc7b7debd 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -341,7 +341,7 @@ static void versatile_init(MachineState *machine, int board_id)
 
     dev = sysbus_create_simple_orphan(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
-    i2c_slave_create_simple(i2c, "ds1338", 0x68);
+    i2c_slave_create_simple_orphan(i2c, "ds1338", 0x68);
 
     /* Add PL041 AACI Interface to the LM4549 codec */
     pl041 = qdev_new_orphan("pl041");
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 5a0012cb4f..ffd3c52d4f 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -653,7 +653,7 @@ static void vexpress_common_init(MachineState *machine)
 
     dev = sysbus_create_simple_orphan(TYPE_ARM_SBCON_I2C, map[VE_SERIALDVI], NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
-    i2c_slave_create_simple(i2c, "sii9022", 0x39);
+    i2c_slave_create_simple_orphan(i2c, "sii9022", 0x39);
 
     sysbus_create_simple_orphan("pl031", map[VE_RTC], pic[4]); /* RTC */
 
diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
index d00d3e9fc5..0bf49195d7 100644
--- a/hw/display/sii9022.c
+++ b/hw/display/sii9022.c
@@ -164,7 +164,7 @@ static void sii9022_realize(DeviceState *dev, Error **errp)
     I2CBus *bus;
 
     bus = I2C_BUS(qdev_get_parent_bus(dev));
-    i2c_slave_create_simple(bus, TYPE_I2CDDC, 0x50);
+    i2c_slave_create_simple_orphan(bus, TYPE_I2CDDC, 0x50);
 }
 
 static void sii9022_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 27afcaecee..ac09e5f706 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1518,7 +1518,7 @@ static void aspeed_i2c_bus_realize(DeviceState *dev, Error **errp)
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 
     s->bus = i2c_init_bus(dev, s->name);
-    s->slave = i2c_slave_create_simple(s->bus, TYPE_ASPEED_I2C_BUS_SLAVE,
+    s->slave = i2c_slave_create_simple_orphan(s->bus, TYPE_ASPEED_I2C_BUS_SLAVE,
                                        0xff);
 
     memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i2c_bus_ops,
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 7803f6113c..fba21fdfad 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -364,7 +364,7 @@ const VMStateDescription vmstate_i2c_slave = {
     }
 };
 
-I2CSlave *i2c_slave_new(const char *name, uint8_t addr)
+I2CSlave *i2c_slave_new_orphan(const char *name, uint8_t addr)
 {
     DeviceState *dev;
 
@@ -373,14 +373,34 @@ I2CSlave *i2c_slave_new(const char *name, uint8_t addr)
     return I2C_SLAVE(dev);
 }
 
+I2CSlave *i2c_slave_new(Object *parent, const char *id,
+                        const char *type, uint8_t addr)
+{
+    DeviceState *dev;
+
+    dev = qdev_new(parent, id, type);
+    qdev_prop_set_uint8(dev, "address", addr);
+    return I2C_SLAVE(dev);
+}
+
+I2CSlave *i2c_slave_create_simple(Object *parent, const char *id,
+                                  I2CBus *bus, const char *type,
+                                  uint8_t addr)
+{
+    I2CSlave *dev = i2c_slave_new(parent, id, type, addr);
+
+    qdev_realize(DEVICE(dev), BUS(bus), &error_abort);
+    return dev;
+}
+
 bool i2c_slave_realize_and_unref(I2CSlave *dev, I2CBus *bus, Error **errp)
 {
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
 }
 
-I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr)
+I2CSlave *i2c_slave_create_simple_orphan(I2CBus *bus, const char *name, uint8_t addr)
 {
-    I2CSlave *dev = i2c_slave_new(name, addr);
+    I2CSlave *dev = i2c_slave_new_orphan(name, addr);
 
     i2c_slave_realize_and_unref(dev, bus, &error_abort);
 
diff --git a/hw/i3c/core.c b/hw/i3c/core.c
index 2fb865490e..469d66f1fb 100644
--- a/hw/i3c/core.c
+++ b/hw/i3c/core.c
@@ -623,7 +623,7 @@ void legacy_i2c_end_transfer(I3CBus *bus)
 I2CSlave *legacy_i2c_device_create_simple(I3CBus *bus, const char *name,
                                           uint8_t addr)
 {
-    I2CSlave *dev = i2c_slave_new(name, addr);
+    I2CSlave *dev = i2c_slave_new_orphan(name, addr);
 
     i2c_slave_realize_and_unref(dev, bus->i2c_bus, &error_abort);
     return dev;
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 8b7f2dc13f..b6d314447c 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -148,7 +148,7 @@ I2CSlave *at24c_eeprom_init_rom(I2CBus *bus, uint8_t address, uint32_t rom_size,
 {
     EEPROMState *s;
 
-    s = AT24C_EE(i2c_slave_new(TYPE_AT24C_EE, address));
+    s = AT24C_EE(i2c_slave_new_orphan(TYPE_AT24C_EE, address));
 
     qdev_prop_set_uint32(DEVICE(s), "rom-size", rom_size);
 
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 05c305b72c..85977c8b69 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1025,7 +1025,7 @@ void ppce500_init(MachineState *machine)
     memory_region_add_subregion(ccsr_addr_space, MPC8544_I2C_REGS_OFFSET,
                                 sysbus_mmio_get_region(s, 0));
     i2c = I2C_BUS(qdev_get_child_bus(dev, "i2c"));
-    i2c_slave_create_simple(i2c, "ds1338", RTC_REGS_OFFSET);
+    i2c_slave_create_simple_orphan(i2c, "ds1338", RTC_REGS_OFFSET);
 
     /* eSDHC */
     if (pmc->has_esdhc) {
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8346613a68..0a22d854d7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2825,7 +2825,7 @@ static void pnv_rainier_i2c_init(PnvMachineState *pnv)
          * Add a PCA9552 I2C device for PCIe hotplug control
          * to engine 2, bus 1, address 0x63
          */
-        I2CSlave *dev = i2c_slave_create_simple(chip10->i2c[2].busses[1],
+        I2CSlave *dev = i2c_slave_create_simple_orphan(chip10->i2c[2].busses[1],
                                                 "pca9552", 0x63);
 
         /*
@@ -2843,7 +2843,7 @@ static void pnv_rainier_i2c_init(PnvMachineState *pnv)
          * Add a PCA9554 I2C device for cable card presence detection
          * to engine 2, bus 1, address 0x25
          */
-        i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9554", 0x25);
+        i2c_slave_create_simple_orphan(chip10->i2c[2].busses[1], "pca9554", 0x25);
     }
 }
 
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 0c4c6f6256..767a5eb596 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -345,7 +345,7 @@ static void sam460ex_init(MachineState *machine)
     spd_data[20] = 4; /* SO-DIMM module */
     smbus_eeprom_init_one(i2c, 0x50, spd_data);
     /* RTC */
-    i2c_slave_create_simple(i2c, "m41t80", 0x68);
+    i2c_slave_create_simple_orphan(i2c, "m41t80", 0x68);
 
     dev = sysbus_create_simple_orphan(TYPE_PPC4xx_I2C, 0x4ef600800,
                                qdev_get_gpio_in(uic[0], 3));
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index d808bcc11c..9c63ec7e29 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -574,8 +574,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
     }
 
     /* I2C peripherals: qemu specific */
-    i2c_slave_create_simple(i2c_get_bus(s, 0), "ds1338", 0x6f);
-    i2c_slave_create_simple(i2c_get_bus(s, 4), "tmp105", 0x48);
+    i2c_slave_create_simple_orphan(i2c_get_bus(s, 0), "ds1338", 0x6f);
+    i2c_slave_create_simple_orphan(i2c_get_bus(s, 4), "tmp105", 0x48);
 
     /* Load or create device tree */
     if (machine->dtb) {
diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index a00238ed74..e1c0323cb6 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -83,7 +83,7 @@ void aspeed_machine_class_init_cpus_defaults(MachineClass *mc);
  *
  * Create and attach a PCA9552 LED controller device to the specified I2C bus
  * of the given Aspeed SoC. The device is instantiated using
- * i2c_slave_create_simple() with the PCA9552 device type.
+ * i2c_slave_create_simple_orphan() with the PCA9552 device type.
  */
 void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr);
 
@@ -95,7 +95,7 @@ void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr);
  *
  * Create and attach a PCA9554 I/O expander to the specified I2C bus
  * of the given Aspeed SoC. The device is created via
- * i2c_slave_create_simple() and returned as an #I2CSlave pointer.
+ * i2c_slave_create_simple_orphan() and returned as an #I2CSlave pointer.
  *
  * Returns: a pointer to the newly created #I2CSlave instance.
  */
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index bcdc4f21a9..0bba1a7c20 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -163,7 +163,20 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address, bool broadcast,
  * properties to be set. Type @name must exist. The device still
  * needs to be realized. See qdev-core.h.
  */
-I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
+I2CSlave *i2c_slave_new_orphan(const char *name, uint8_t addr);
+
+/**
+ * Create a parented I2C slave device on the heap.
+ * @parent: the QOM parent
+ * @id: child<> property name
+ * @type: I2C slave device type name
+ * @addr: I2C address of the slave when put on a bus
+ *
+ * Like i2c_slave_new_orphan(), but the returned device is owned by
+ * @parent's child<> property.  Pair with qdev_realize().
+ */
+I2CSlave *i2c_slave_new(Object *parent, const char *id,
+                        const char *type, uint8_t addr);
 
 /**
  * Create and realize an I2C slave device on the heap.
@@ -174,7 +187,24 @@ I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
  * Create the device state structure, initialize it, put it on the
  * specified @bus, and drop the reference to it (the device is realized).
  */
-I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
+I2CSlave *i2c_slave_create_simple_orphan(I2CBus *bus, const char *name,
+                                         uint8_t addr);
+
+/**
+ * Create, parent and realize an I2C slave device on the heap.
+ * @parent: the QOM parent
+ * @id: child<> property name
+ * @bus: I2C bus to put it on
+ * @type: I2C slave device type name
+ * @addr: I2C address of the slave when put on a bus
+ *
+ * Create the device state structure, add it as a child of @parent,
+ * put it on the specified @bus and realize it.  The returned device
+ * is owned by @parent.
+ */
+I2CSlave *i2c_slave_create_simple(Object *parent, const char *id,
+                                  I2CBus *bus, const char *type,
+                                  uint8_t addr);
 
 /**
  * Realize and drop a reference an I2C slave device
@@ -189,10 +219,10 @@ I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
  * reference to it.
  *
  * This function is useful if you have created @dev via qdev_new_orphan(),
- * i2c_slave_new() or i2c_slave_try_new() (which take a reference to
+ * i2c_slave_new_orphan() or i2c_slave_try_new() (which take a reference to
  * the device it returns to you), so that you can set properties on it
  * before realizing it. If you don't need to set properties then
- * i2c_slave_create_simple() is probably better (as it does the create,
+ * i2c_slave_create_simple_orphan() is probably better (as it does the create,
  * init and realize in one step).
  *
  * If you are embedding the I2C slave into another QOM device and
diff --git a/scripts/coccinelle/qom-parent/i2c-slave-new-orphan.cocci b/scripts/coccinelle/qom-parent/i2c-slave-new-orphan.cocci
new file mode 100644
index 0000000000..fdfb6a84c8
--- /dev/null
+++ b/scripts/coccinelle/qom-parent/i2c-slave-new-orphan.cocci
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Rename i2c_slave_new()/i2c_slave_create_simple() to *_orphan()
+// so that the short names can be reintroduced with a mandatory
+// (parent, id, ...) signature.
+//
+// spatch --sp-file scripts/coccinelle/qom-parent/i2c-slave-new-orphan.cocci \
+//        --in-place --include-headers --dir .
+
+@@
+@@
+- i2c_slave_new
++ i2c_slave_new_orphan
+
+@@
+@@
+- i2c_slave_create_simple
++ i2c_slave_create_simple_orphan
-- 
2.47.1


