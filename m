Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3378C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigcc-0001ER-4T; Sat, 11 Jul 2026 18:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigcb-0001Dp-1z; Sat, 11 Jul 2026 18:56:33 -0400
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.42.203.116])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigcX-00017q-6p; Sat, 11 Jul 2026 18:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810589; x=1815346589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6/HiP2U5209DqbHLcR0wHveI0XPE+0XoQXiVz3vr9eY=;
 b=mVNKKC9Hl87BiBboKHrFAi1aYWuuwGP6a0LG6l10ThO0VQr/WOlA3/BN
 jkgxGp+8P8p6EBLTERdGgcaaQceDJxbuGUOan/DCiGZl7NHhrGAi6vvfu
 4RIA3q7BhRXPVoVHm1mrDMINe+3btTufvegRazDZv3B+H4JFH2zYdYFXa
 Uo0ZtOnZ0kJ6aG15g4qSVL51Wh09AbHJNG4e6WdjW86IQV2mv1UcR7KV+
 +y2QjGZk3ZvYHbGbusEa7AbMdOLjKEA/o09lgrs+QqJ9Y5rTBWb55IIQS
 V/tOaABo7e6zFsYHqyNLzSRVUJoJVdBvshXsdfbFLVoCjY/qLx4/D6yY4 w==;
X-CSE-ConnectionGUID: 5trbg/90RLy/RSdZPj42TA==
X-CSE-MsgGUID: sOxVmV04QnuOjhI297S0cg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23517991"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:56:25 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:12609]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.135:2525]
 with esmtp (Farcaster)
 id 7d7e7b5f-58c1-411b-80f2-7792f5c07f0b; Sat, 11 Jul 2026 22:56:25 +0000 (UTC)
X-Farcaster-Flow-ID: 7d7e7b5f-58c1-411b-80f2-7792f5c07f0b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:56:24 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:56:16 +0000
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
Subject: [RFC PATCH 073/134] hw/nvram/at24c: Give at24c_eeprom_init() a QOM
 parent
Date: Sat, 11 Jul 2026 22:36:06 +0000
Message-ID: <20260711223707.42139-74-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.42.203.116;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Now that all callers of at24c_eeprom_init() and
at24c_eeprom_init_rom() live in already-converted hw/arm aspeed and
npcm board files, thread an Object *parent through these two
convenience helpers so that every I2C EEPROM created by an aspeed
or npcm board becomes a proper child of its machine instead of
landing under /machine/unattached.

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/aspeed_ast2500_tiogapass.c  |  4 +--
 hw/arm/aspeed_ast2500_yosemitev2.c |  4 +--
 hw/arm/aspeed_ast2600_anacapa.c    | 20 +++++++-------
 hw/arm/aspeed_ast2600_bletchley.c  |  4 +--
 hw/arm/aspeed_ast2600_catalina.c   | 34 ++++++++++++------------
 hw/arm/aspeed_ast2600_fby35.c      | 10 +++----
 hw/arm/aspeed_ast2600_fuji.c       | 34 ++++++++++++------------
 hw/arm/aspeed_ast2600_gb200nvl.c   |  6 ++---
 hw/arm/aspeed_ast2600_rainier.c    | 42 +++++++++++++++---------------
 hw/arm/npcm7xx_boards.c            |  8 +++---
 hw/nvram/eeprom_at24c.c            | 12 +++++----
 include/hw/nvram/eeprom_at24c.h    |  6 +++--
 12 files changed, 94 insertions(+), 90 deletions(-)

diff --git a/hw/arm/aspeed_ast2500_tiogapass.c b/hw/arm/aspeed_ast2500_tiogapass.c
index 13d1db9cfa..c813fc7301 100644
--- a/hw/arm/aspeed_ast2500_tiogapass.c
+++ b/hw/arm/aspeed_ast2500_tiogapass.c
@@ -51,8 +51,8 @@ static void tiogapass_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
 
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 4), 0x54, 128 * KiB);
-    at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 6), 0x54, 128 * KiB,
+    at24c_eeprom_init(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 4), 0x54, 128 * KiB);
+    at24c_eeprom_init_rom(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 6), 0x54, 128 * KiB,
                           tiogapass_bmc_fruid, tiogapass_bmc_fruid_len);
     /* TMP421 */
     i2c_slave_create_simple(OBJECT(bmc), "tmp421[*]",
diff --git a/hw/arm/aspeed_ast2500_yosemitev2.c b/hw/arm/aspeed_ast2500_yosemitev2.c
index 4e3c19bc07..57c9976051 100644
--- a/hw/arm/aspeed_ast2500_yosemitev2.c
+++ b/hw/arm/aspeed_ast2500_yosemitev2.c
@@ -51,8 +51,8 @@ static void yosemitev2_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
 
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 4), 0x51, 128 * KiB);
-    at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51, 128 * KiB,
+    at24c_eeprom_init(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 4), 0x51, 128 * KiB);
+    at24c_eeprom_init_rom(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 8), 0x51, 128 * KiB,
                           yosemitev2_bmc_fruid, yosemitev2_bmc_fruid_len);
     /* TMP421 */
     i2c_slave_create_simple(OBJECT(bmc), "tmp421[*]",
diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index d6412f5b0c..faf3fc070d 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -236,13 +236,13 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c0 */
     /* eeprom@50 */
-    at24c_eeprom_init(i2c[0], 0x50, 256 * KiB);
+    at24c_eeprom_init(o, i2c[0], 0x50, 256 * KiB);
     /* i2c-mux@70 */
     i2c_slave_create_simple(o, "i2c-mux[*]", i2c[0], TYPE_PCA9546, 0x70);
 
     /* &i2c1 */
     /* eeprom@50 */
-    at24c_eeprom_init(i2c[1], 0x50, 256 * KiB);
+    at24c_eeprom_init(o, i2c[1], 0x50, 256 * KiB);
     /* i2c-mux@70 (PCA9546) — 4 channels, empty */
     i2c_slave_create_simple(o, "i2c-mux[*]", i2c[1], TYPE_PCA9546, 0x70);
 
@@ -252,7 +252,7 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c6 */
     /* eeprom@50 */
-    at24c_eeprom_init_rom(i2c[6], 0x50, 32 * KiB,
+    at24c_eeprom_init_rom(o, i2c[6], 0x50, 32 * KiB,
                           hpm_eeprom, hpm_eeprom_len);
 
     /* &i2c8 */
@@ -269,7 +269,7 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 0),
                             TYPE_PCA9552, 0x24);
     /* eeprom@50 */
-    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 16 * KiB,
+    at24c_eeprom_init_rom(o, pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 16 * KiB,
                           rpdb_eeprom, rpdb_eeprom_len);
 
     /* i2c8mux ch1 */
@@ -280,15 +280,15 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9552, 0x24);
     /* eeprom@50 */
-    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 16 * KiB,
+    at24c_eeprom_init_rom(o, pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 16 * KiB,
                           lpdb_eeprom, lpdb_eeprom_len);
 
     /* &i2c9 */
     /* eeprom@50 */
-    at24c_eeprom_init_rom(i2c[9], 0x50, 16 * KiB,
+    at24c_eeprom_init_rom(o, i2c[9], 0x50, 16 * KiB,
                           scm_eeprom, scm_eeprom_len);
     /* eeprom@56 */
-    at24c_eeprom_init_rom(i2c[9], 0x56, 8 * KiB,
+    at24c_eeprom_init_rom(o, i2c[9], 0x56, 8 * KiB,
                           bsm_eeprom, bsm_eeprom_len);
 
     /* &i2c10 */
@@ -301,7 +301,7 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 5),
                             TYPE_PCA9552, 0x22);
     /* eeprom@52 */
-    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB,
+    at24c_eeprom_init_rom(o, pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB,
                           rbb_eeprom, rbb_eeprom_len);
 
     /* &i2c11 */
@@ -316,7 +316,7 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 5),
                             TYPE_PCA9552, 0x22);
     /* eeprom@52 */
-    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB,
+    at24c_eeprom_init_rom(o, pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB,
                           lbb_eeprom, lbb_eeprom_len);
 
     /* &i2c13 */
@@ -329,7 +329,7 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* i2c13mux ch4 */
     /* eeprom@51 */
-    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 4), 0x51, 32 * KiB,
+    at24c_eeprom_init_rom(o, pca954x_i2c_get_bus(i2c_mux, 4), 0x51, 32 * KiB,
                           hpm_brd_id_eeprom, hpm_brd_id_eeprom_len);
 
     /* i2c13mux ch7 */
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
index 58f0bc89bd..a9ae61f864 100644
--- a/hw/arm/aspeed_ast2600_bletchley.c
+++ b/hw/arm/aspeed_ast2600_bletchley.c
@@ -46,13 +46,13 @@ static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
     }
 
     /* Bus 6 */
-    at24c_eeprom_init(i2c[6], 0x56, 65536);
+    at24c_eeprom_init(OBJECT(bmc), i2c[6], 0x56, 65536);
     /* Missing model: nxp,pcf85263 @ 0x51 , but ds1338 works enough */
     i2c_slave_create_simple(OBJECT(bmc), "rtc", i2c[6], "ds1338", 0x51);
 
 
     /* Bus 7 */
-    at24c_eeprom_init(i2c[7], 0x54, 65536);
+    at24c_eeprom_init(OBJECT(bmc), i2c[7], 0x54, 65536);
 
     /* Bus 9 */
     i2c_slave_create_simple(OBJECT(bmc), "tmp421[*]",
diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 59fc0d2437..e33e40590d 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -484,7 +484,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9535, 0x20);
     /* eeprom@50 */
-    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
+    at24c_eeprom_init_rom(o, pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
                           gb200io_eeprom, gb200io_eeprom_len);
 
     /* i2c-mux@73 (PCA9546) on i2c0 */
@@ -502,7 +502,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9535, 0x21);
     /* eeprom@50 */
-    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
+    at24c_eeprom_init_rom(o, pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
                           gb200io_eeprom, gb200io_eeprom_len);
 
     /* i2c-mux@77 (PCA9546) on i2c0 */
@@ -526,7 +526,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* i2c1mux0ch5 */
     /* eeprom@54 */
-    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x54, 8 * KiB,
+    at24c_eeprom_init_rom(o, pca954x_i2c_get_bus(i2c_mux, 5), 0x54, 8 * KiB,
                           pdb_eeprom, pdb_eeprom_len);
     /* tpm75@4f */
     i2c_slave_create_simple(o, "tmp75[*]", pca954x_i2c_get_bus(i2c_mux, 5),
@@ -540,12 +540,12 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 6),
                             TYPE_PCA9552, 0x25);
     /* eeprom@51 */
-    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 6), 0x51, 8 * KiB,
+    at24c_eeprom_init_rom(o, pca954x_i2c_get_bus(i2c_mux, 6), 0x51, 8 * KiB,
                           osfp_eeprom, osfp_eeprom_len);
 
     /* i2c1mux0ch7 */
     /* eeprom@53 */
-    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 7), 0x53, 8 * KiB,
+    at24c_eeprom_init_rom(o, pca954x_i2c_get_bus(i2c_mux, 7), 0x53, 8 * KiB,
                           fio_eeprom, fio_eeprom_len);
     /* temperature-sensor@4b - tmp75 */
     i2c_slave_create_simple(o, "tmp75[*]", pca954x_i2c_get_bus(i2c_mux, 7),
@@ -559,9 +559,9 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* io_expander0 - pca9555@27 */
     i2c_slave_create_simple(o, "gpio[*]", i2c[2], TYPE_PCA9552, 0x27);
     /* eeprom@50 */
-    at24c_eeprom_init(i2c[2], 0x50, 8 * KiB);
+    at24c_eeprom_init(o, i2c[2], 0x50, 8 * KiB);
     /* eeprom@51 */
-    at24c_eeprom_init(i2c[2], 0x51, 8 * KiB);
+    at24c_eeprom_init(o, i2c[2], 0x51, 8 * KiB);
 
     /* &i2c5 */
     /* i2c-mux@70 (PCA9548) on i2c5 */
@@ -569,7 +569,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
                                       TYPE_PCA9548, 0x70);
     /* i2c5mux0ch6 */
     /* eeprom@52 */
-    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 6), 0x52, 8 * KiB,
+    at24c_eeprom_init_rom(o, pca954x_i2c_get_bus(i2c_mux, 6), 0x52, 8 * KiB,
                           hdd_eeprom, hdd_eeprom_len);
     /* i2c5mux0ch7 */
     /* ina230@40 - no model */
@@ -589,36 +589,36 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* temperature-sensor@4b - tpm75 */
     i2c_slave_create_simple(o, "tmp75[*]", i2c[9], TYPE_TMP75, 0x4b);
     /* eeprom@50 */
-    at24c_eeprom_init_rom(i2c[9], 0x50, 8 * KiB, scm_eeprom, scm_eeprom_len);
+    at24c_eeprom_init_rom(o, i2c[9], 0x50, 8 * KiB, scm_eeprom, scm_eeprom_len);
     /* eeprom@56 */
-    at24c_eeprom_init_rom(i2c[9], 0x56, 8 * KiB, bsm_eeprom, bsm_eeprom_len);
+    at24c_eeprom_init_rom(o, i2c[9], 0x56, 8 * KiB, bsm_eeprom, bsm_eeprom_len);
 
     /* &i2c10 */
     /* temperature-sensor@1f - tpm421 */
     i2c_slave_create_simple(o, "tmp421[*]", i2c[10], TYPE_TMP421, 0x1f);
     /* eeprom@50 */
-    at24c_eeprom_init_rom(i2c[10], 0x50, 8 * KiB, nic_eeprom, nic_eeprom_len);
+    at24c_eeprom_init_rom(o, i2c[10], 0x50, 8 * KiB, nic_eeprom, nic_eeprom_len);
 
     /* &i2c11 */
     /* ssif-bmc@10 - no model */
 
     /* &i2c12 */
     /* eeprom@50 */
-    at24c_eeprom_init_rom(i2c[12], 0x50, 8 * KiB,
+    at24c_eeprom_init_rom(o, i2c[12], 0x50, 8 * KiB,
                           gb200_eeprom, gb200_eeprom_len);
     /* eeprom@54 */
-    at24c_eeprom_init_rom(i2c[12], 0x54, 256,
+    at24c_eeprom_init_rom(o, i2c[12], 0x54, 256,
                           cable_eeprom, cable_eeprom_len);
 
     /* &i2c13 */
     /* eeprom@50 */
-    at24c_eeprom_init_rom(i2c[13], 0x50, 8 * KiB,
+    at24c_eeprom_init_rom(o, i2c[13], 0x50, 8 * KiB,
                           gb200_eeprom, gb200_eeprom_len);
     /* eeprom@54 */
-    at24c_eeprom_init_rom(i2c[13], 0x54, 256,
+    at24c_eeprom_init_rom(o, i2c[13], 0x54, 256,
                           cable_eeprom, cable_eeprom_len);
     /* eeprom@57 */
-    at24c_eeprom_init_rom(i2c[13], 0x57, 256, hmc_eeprom, hmc_eeprom_len);
+    at24c_eeprom_init_rom(o, i2c[13], 0x57, 256, hmc_eeprom, hmc_eeprom_len);
 
     /* &i2c14 */
     /* io_expander9 - pca9555@10 */
@@ -638,7 +638,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* temperature-sensor@1f - tmp421 */
     i2c_slave_create_simple(o, "tmp421[*]", i2c[15], TYPE_TMP421, 0x1f);
     /* eeprom@52 */
-    at24c_eeprom_init_rom(i2c[15], 0x52, 8 * KiB, nic_eeprom, nic_eeprom_len);
+    at24c_eeprom_init_rom(o, i2c[15], 0x52, 8 * KiB, nic_eeprom, nic_eeprom_len);
 }
 
 static void aspeed_machine_catalina_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast2600_fby35.c b/hw/arm/aspeed_ast2600_fby35.c
index dedc273ee3..d7bea13706 100644
--- a/hw/arm/aspeed_ast2600_fby35.c
+++ b/hw/arm/aspeed_ast2600_fby35.c
@@ -109,13 +109,13 @@ static void fby35_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(OBJECT(bmc), "lm75[*]", i2c[12], TYPE_LM75, 0x4e);
     i2c_slave_create_simple(OBJECT(bmc), "lm75[*]", i2c[12], TYPE_LM75, 0x4f);
 
-    at24c_eeprom_init(i2c[4], 0x51, 128 * KiB);
-    at24c_eeprom_init(i2c[6], 0x51, 128 * KiB);
-    at24c_eeprom_init_rom(i2c[8], 0x50, 32 * KiB, fby35_nic_fruid,
+    at24c_eeprom_init(OBJECT(bmc), i2c[4], 0x51, 128 * KiB);
+    at24c_eeprom_init(OBJECT(bmc), i2c[6], 0x51, 128 * KiB);
+    at24c_eeprom_init_rom(OBJECT(bmc), i2c[8], 0x50, 32 * KiB, fby35_nic_fruid,
                           fby35_nic_fruid_len);
-    at24c_eeprom_init_rom(i2c[11], 0x51, 128 * KiB, fby35_bb_fruid,
+    at24c_eeprom_init_rom(OBJECT(bmc), i2c[11], 0x51, 128 * KiB, fby35_bb_fruid,
                           fby35_bb_fruid_len);
-    at24c_eeprom_init_rom(i2c[11], 0x54, 128 * KiB, fby35_bmc_fruid,
+    at24c_eeprom_init_rom(OBJECT(bmc), i2c[11], 0x54, 128 * KiB, fby35_bmc_fruid,
                           fby35_bmc_fruid_len);
 
     /*
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index 1e681d0090..396bd6c8b7 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -66,45 +66,45 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
      * EEPROM 24c64 size is 64Kbits or 8 Kbytes
      *        24c02 size is 2Kbits or 256 bytes
      */
-    at24c_eeprom_init(i2c[19], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[20], 0x50, 256);
-    at24c_eeprom_init(i2c[22], 0x52, 256);
+    at24c_eeprom_init(o, i2c[19], 0x52, 8 * KiB);
+    at24c_eeprom_init(o, i2c[20], 0x50, 256);
+    at24c_eeprom_init(o, i2c[22], 0x52, 256);
 
     i2c_slave_create_simple(o, "lm75[*]", i2c[3], TYPE_LM75, 0x48);
     i2c_slave_create_simple(o, "lm75[*]", i2c[3], TYPE_LM75, 0x49);
     i2c_slave_create_simple(o, "lm75[*]", i2c[3], TYPE_LM75, 0x4a);
     i2c_slave_create_simple(o, "tmp422", i2c[3], TYPE_TMP422, 0x4c);
 
-    at24c_eeprom_init(i2c[8], 0x51, 8 * KiB);
+    at24c_eeprom_init(o, i2c[8], 0x51, 8 * KiB);
     i2c_slave_create_simple(o, "lm75[*]", i2c[8], TYPE_LM75, 0x4a);
 
     i2c_slave_create_simple(o, "lm75[*]", i2c[50], TYPE_LM75, 0x4c);
-    at24c_eeprom_init(i2c[50], 0x52, 8 * KiB);
+    at24c_eeprom_init(o, i2c[50], 0x52, 8 * KiB);
     i2c_slave_create_simple(o, "tmp75[*]", i2c[51], TYPE_TMP75, 0x48);
     i2c_slave_create_simple(o, "tmp75[*]", i2c[52], TYPE_TMP75, 0x49);
 
     i2c_slave_create_simple(o, "tmp75[*]", i2c[59], TYPE_TMP75, 0x48);
     i2c_slave_create_simple(o, "tmp75[*]", i2c[60], TYPE_TMP75, 0x49);
 
-    at24c_eeprom_init(i2c[65], 0x53, 8 * KiB);
+    at24c_eeprom_init(o, i2c[65], 0x53, 8 * KiB);
     i2c_slave_create_simple(o, "tmp75[*]", i2c[66], TYPE_TMP75, 0x49);
     i2c_slave_create_simple(o, "tmp75[*]", i2c[66], TYPE_TMP75, 0x48);
-    at24c_eeprom_init(i2c[68], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[69], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[70], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[71], 0x52, 8 * KiB);
+    at24c_eeprom_init(o, i2c[68], 0x52, 8 * KiB);
+    at24c_eeprom_init(o, i2c[69], 0x52, 8 * KiB);
+    at24c_eeprom_init(o, i2c[70], 0x52, 8 * KiB);
+    at24c_eeprom_init(o, i2c[71], 0x52, 8 * KiB);
 
-    at24c_eeprom_init(i2c[73], 0x53, 8 * KiB);
+    at24c_eeprom_init(o, i2c[73], 0x53, 8 * KiB);
     i2c_slave_create_simple(o, "tmp75[*]", i2c[74], TYPE_TMP75, 0x49);
     i2c_slave_create_simple(o, "tmp75[*]", i2c[74], TYPE_TMP75, 0x48);
-    at24c_eeprom_init(i2c[76], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[77], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[78], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[79], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[28], 0x50, 256);
+    at24c_eeprom_init(o, i2c[76], 0x52, 8 * KiB);
+    at24c_eeprom_init(o, i2c[77], 0x52, 8 * KiB);
+    at24c_eeprom_init(o, i2c[78], 0x52, 8 * KiB);
+    at24c_eeprom_init(o, i2c[79], 0x52, 8 * KiB);
+    at24c_eeprom_init(o, i2c[28], 0x50, 256);
 
     for (int i = 0; i < 8; i++) {
-        at24c_eeprom_init(i2c[81 + i * 8], 0x56, 64 * KiB);
+        at24c_eeprom_init(o, i2c[81 + i * 8], 0x56, 64 * KiB);
         i2c_slave_create_simple(o, "tmp75[*]", i2c[82 + i * 8],
                                 TYPE_TMP75, 0x48);
         i2c_slave_create_simple(o, "tmp75[*]", i2c[83 + i * 8],
diff --git a/hw/arm/aspeed_ast2600_gb200nvl.c b/hw/arm/aspeed_ast2600_gb200nvl.c
index 1cf35f96bd..357f30cf83 100644
--- a/hw/arm/aspeed_ast2600_gb200nvl.c
+++ b/hw/arm/aspeed_ast2600_gb200nvl.c
@@ -68,11 +68,11 @@ static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
     object_property_set_str(OBJECT(dev), "pin1", "high", &error_fatal);
 
     aspeed_create_pca9554(OBJECT(bmc), soc, 9, 0x21);
-    at24c_eeprom_init(i2c[9], 0x50, 64 * KiB);
-    at24c_eeprom_init(i2c[9], 0x51, 64 * KiB);
+    at24c_eeprom_init(OBJECT(bmc), i2c[9], 0x50, 64 * KiB);
+    at24c_eeprom_init(OBJECT(bmc), i2c[9], 0x51, 64 * KiB);
 
     /* Bus 11 */
-    at24c_eeprom_init_rom(i2c[10], 0x50, 256, gb200nvl_bmc_fruid,
+    at24c_eeprom_init_rom(OBJECT(bmc), i2c[10], 0x50, 256, gb200nvl_bmc_fruid,
                           gb200nvl_bmc_fruid_len);
 }
 
diff --git a/hw/arm/aspeed_ast2600_rainier.c b/hw/arm/aspeed_ast2600_rainier.c
index 2f5e3daf3b..4ec36e6129 100644
--- a/hw/arm/aspeed_ast2600_rainier.c
+++ b/hw/arm/aspeed_ast2600_rainier.c
@@ -69,7 +69,7 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     I2CSlave *i2c_mux;
     Object *o = OBJECT(bmc);
 
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 0), 0x51, 32 * KiB);
+    at24c_eeprom_init(o, aspeed_i2c_get_bus(&soc->i2c, 0), 0x51, 32 * KiB);
 
     aspeed_create_pca9552(OBJECT(bmc), soc, 3, 0x61);
 
@@ -86,9 +86,9 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]",
                                       aspeed_i2c_get_bus(&soc->i2c, 4),
                                       "pca9546", 0x70);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x52, 64 * KiB);
+    at24c_eeprom_init(o, pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
+    at24c_eeprom_init(o, pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
+    at24c_eeprom_init(o, pca954x_i2c_get_bus(i2c_mux, 2), 0x52, 64 * KiB);
     aspeed_create_pca9552(OBJECT(bmc), soc, 4, 0x60);
 
     i2c_slave_create_simple(o, "tmp105[*]",
@@ -102,8 +102,8 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]",
                                       aspeed_i2c_get_bus(&soc->i2c, 5),
                                       "pca9546", 0x70);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
+    at24c_eeprom_init(o, pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
+    at24c_eeprom_init(o, pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
 
     i2c_slave_create_simple(o, "tmp105[*]",
                             aspeed_i2c_get_bus(&soc->i2c, 6),
@@ -117,10 +117,10 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]",
                                       aspeed_i2c_get_bus(&soc->i2c, 6),
                                       "pca9546", 0x70);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x50, 64 * KiB);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 3), 0x51, 64 * KiB);
+    at24c_eeprom_init(o, pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
+    at24c_eeprom_init(o, pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
+    at24c_eeprom_init(o, pca954x_i2c_get_bus(i2c_mux, 2), 0x50, 64 * KiB);
+    at24c_eeprom_init(o, pca954x_i2c_get_bus(i2c_mux, 3), 0x51, 64 * KiB);
 
     aspeed_create_pca9552(OBJECT(bmc), soc, 7, 0x30);
     aspeed_create_pca9552(OBJECT(bmc), soc, 7, 0x31);
@@ -138,8 +138,8 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(o, "max31785",
                             aspeed_i2c_get_bus(&soc->i2c, 7),
                             "max31785", 0x52);
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x50, 64 * KiB);
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x51, 64 * KiB);
+    at24c_eeprom_init(o, aspeed_i2c_get_bus(&soc->i2c, 7), 0x50, 64 * KiB);
+    at24c_eeprom_init(o, aspeed_i2c_get_bus(&soc->i2c, 7), 0x51, 64 * KiB);
 
     i2c_slave_create_simple(o, "tmp105[*]",
                             aspeed_i2c_get_bus(&soc->i2c, 8),
@@ -147,9 +147,9 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(o, "tmp105[*]",
                             aspeed_i2c_get_bus(&soc->i2c, 8),
                             TYPE_TMP105, 0x4a);
-    at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50,
+    at24c_eeprom_init_rom(o, aspeed_i2c_get_bus(&soc->i2c, 8), 0x50,
                           64 * KiB, rainier_bb_fruid, rainier_bb_fruid_len);
-    at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51,
+    at24c_eeprom_init_rom(o, aspeed_i2c_get_bus(&soc->i2c, 8), 0x51,
                           64 * KiB, rainier_bmc_fruid, rainier_bmc_fruid_len);
     aspeed_create_pca9552(OBJECT(bmc), soc, 8, 0x60);
     aspeed_create_pca9552(OBJECT(bmc), soc, 8, 0x61);
@@ -163,7 +163,7 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(o, "tmp423[*]",
                             aspeed_i2c_get_bus(&soc->i2c, 9),
                             "tmp423", 0x4d);
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 9), 0x50, 128 * KiB);
+    at24c_eeprom_init(o, aspeed_i2c_get_bus(&soc->i2c, 9), 0x50, 128 * KiB);
 
     i2c_slave_create_simple(o, "tmp423[*]",
                             aspeed_i2c_get_bus(&soc->i2c, 10),
@@ -171,7 +171,7 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(o, "tmp423[*]",
                             aspeed_i2c_get_bus(&soc->i2c, 10),
                             "tmp423", 0x4d);
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 10), 0x50, 128 * KiB);
+    at24c_eeprom_init(o, aspeed_i2c_get_bus(&soc->i2c, 10), 0x50, 128 * KiB);
 
     i2c_slave_create_simple(o, "tmp105[*]",
                             aspeed_i2c_get_bus(&soc->i2c, 11),
@@ -182,18 +182,18 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]",
                                       aspeed_i2c_get_bus(&soc->i2c, 11),
                                       "pca9546", 0x70);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
+    at24c_eeprom_init(o, pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
+    at24c_eeprom_init(o, pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
     aspeed_create_pca9552(OBJECT(bmc), soc, 11, 0x60);
 
 
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 13), 0x50, 64 * KiB);
+    at24c_eeprom_init(o, aspeed_i2c_get_bus(&soc->i2c, 13), 0x50, 64 * KiB);
     aspeed_create_pca9552(OBJECT(bmc), soc, 13, 0x60);
 
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 14), 0x50, 64 * KiB);
+    at24c_eeprom_init(o, aspeed_i2c_get_bus(&soc->i2c, 14), 0x50, 64 * KiB);
     aspeed_create_pca9552(OBJECT(bmc), soc, 14, 0x60);
 
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 15), 0x50, 64 * KiB);
+    at24c_eeprom_init(o, aspeed_i2c_get_bus(&soc->i2c, 15), 0x50, 64 * KiB);
     aspeed_create_pca9552(OBJECT(bmc), soc, 15, 0x60);
 }
 
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 778ef0f232..1862d0d007 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -248,8 +248,8 @@ static void quanta_gsj_i2c_init(Object *parent, NPCM7xxState *soc)
     i2c_slave_create_simple(parent, "tmp105[*]",
                             npcm7xx_i2c_get_bus(soc, 4), "tmp105", 0x5c);
 
-    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 9), 0x55, 8192);
-    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 10), 0x55, 8192);
+    at24c_eeprom_init(parent, npcm7xx_i2c_get_bus(soc, 9), 0x55, 8192);
+    at24c_eeprom_init(parent, npcm7xx_i2c_get_bus(soc, 10), 0x55, 8192);
 
     /*
      * i2c-11:
@@ -363,7 +363,7 @@ static void kudo_bmc_i2c_init(Object *parent, NPCM7xxState *soc)
     i2c_slave_create_simple(parent, "pca9548[*]",
                             npcm7xx_i2c_get_bus(soc, 4), TYPE_PCA9548, 0x77);
 
-    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 4), 0x50, 8192); /* mbfru */
+    at24c_eeprom_init(parent, npcm7xx_i2c_get_bus(soc, 4), 0x50, 8192); /* mbfru */
 
     i2c_mux = i2c_slave_create_simple(parent, "pca9548[*]",
                                       npcm7xx_i2c_get_bus(soc, 13),
@@ -379,7 +379,7 @@ static void kudo_bmc_i2c_init(Object *parent, NPCM7xxState *soc)
     i2c_slave_create_simple(parent, "tmp105[*]",
                             pca954x_i2c_get_bus(i2c_mux, 5), "tmp105", 0x49);
 
-    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 14), 0x55, 8192); /* bmcfru */
+    at24c_eeprom_init(parent, npcm7xx_i2c_get_bus(soc, 14), 0x55, 8192); /* bmcfru */
 
     /* TODO: Add remaining i2c devices. */
 }
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index b6d314447c..036955feee 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -138,17 +138,19 @@ int at24c_eeprom_send(I2CSlave *s, uint8_t data)
     return 0;
 }
 
-I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t rom_size)
+I2CSlave *at24c_eeprom_init(Object *parent, I2CBus *bus, uint8_t address,
+                            uint32_t rom_size)
 {
-    return at24c_eeprom_init_rom(bus, address, rom_size, NULL, 0);
+    return at24c_eeprom_init_rom(parent, bus, address, rom_size, NULL, 0);
 }
 
-I2CSlave *at24c_eeprom_init_rom(I2CBus *bus, uint8_t address, uint32_t rom_size,
+I2CSlave *at24c_eeprom_init_rom(Object *parent, I2CBus *bus, uint8_t address,
+                                uint32_t rom_size,
                                 const uint8_t *init_rom, uint32_t init_rom_size)
 {
     EEPROMState *s;
 
-    s = AT24C_EE(i2c_slave_new_orphan(TYPE_AT24C_EE, address));
+    s = AT24C_EE(i2c_slave_new(parent, "eeprom[*]", TYPE_AT24C_EE, address));
 
     qdev_prop_set_uint32(DEVICE(s), "rom-size", rom_size);
 
@@ -156,7 +158,7 @@ I2CSlave *at24c_eeprom_init_rom(I2CBus *bus, uint8_t address, uint32_t rom_size,
     s->init_rom = init_rom;
     s->init_rom_size = init_rom_size;
 
-    i2c_slave_realize_and_unref(I2C_SLAVE(s), bus, &error_abort);
+    qdev_realize(DEVICE(s), BUS(bus), &error_abort);
 
     return I2C_SLAVE(s);
 }
diff --git a/include/hw/nvram/eeprom_at24c.h b/include/hw/nvram/eeprom_at24c.h
index acb9857b2a..6686c7ff46 100644
--- a/include/hw/nvram/eeprom_at24c.h
+++ b/include/hw/nvram/eeprom_at24c.h
@@ -18,7 +18,8 @@
  * Create the device state structure, initialize it, put it on the specified
  * @bus, and drop the reference to it (the device is realized).
  */
-I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t rom_size);
+I2CSlave *at24c_eeprom_init(Object *parent, I2CBus *bus, uint8_t address,
+                            uint32_t rom_size);
 
 
 /*
@@ -33,7 +34,8 @@ I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t rom_size);
  * @bus, and drop the reference to it (the device is realized). Copies the data
  * from @init_rom to the beginning of the EEPROM memory buffer.
  */
-I2CSlave *at24c_eeprom_init_rom(I2CBus *bus, uint8_t address, uint32_t rom_size,
+I2CSlave *at24c_eeprom_init_rom(Object *parent, I2CBus *bus, uint8_t address,
+                                uint32_t rom_size,
                                 const uint8_t *init_rom, uint32_t init_rom_size);
 
 #endif
-- 
2.47.1


