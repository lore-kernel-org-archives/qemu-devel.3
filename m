Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B1AC4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD2N-0000YM-3K; Sat, 18 Jul 2026 17:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD2K-0000UU-VO; Sat, 18 Jul 2026 17:57:32 -0400
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([50.112.246.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD2G-0004iO-D8; Sat, 18 Jul 2026 17:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411848; x=1815947848;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Le9vjnawM0Pqb4yas2OCqQLMlV1EK1sxm3PrVUfZs4A=;
 b=qmRa3gyQl5Ef5SWpjaMuJBauBlsSXok/tSznUv3tGLmy9pRfq5oAm3Bt
 j6LoPjeLg5dB6I/w2ArjQHZGlOtEThw+SeEATKG8uWzHPfHxMj6NnbUT7
 eKOuXvUWyLvjyA5AzmKQt7dCFWAsZJP0n4pENSs2vrfG885vYTczLiUl+
 YAXJJWv4YFQfwjuwq7MX9MVagup1VcT2Z83GavjRjn1CNVl4BWifrNsTj
 2XBqvbYvfwreNcBokqCp9+ehstNgb6DgOLMvlVZM+ZJFM15h2T9rY8AnM
 HZpgddCRQu/CCI10LZCStTFSxdHrSUDAlq/ci1zgJVIGvuP6K6ann+66U Q==;
X-CSE-ConnectionGUID: deCcAM5TTlKaMutLQx33NA==
X-CSE-MsgGUID: uC6MkdSdRButL4zlN97B+A==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23725138"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:57:24 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:10181]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.246:2525]
 with esmtp (Farcaster)
 id 26fa4542-6096-4599-a9be-d99b92839ea1; Sat, 18 Jul 2026 21:57:24 +0000 (UTC)
X-Farcaster-Flow-ID: 26fa4542-6096-4599-a9be-d99b92839ea1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:57:23 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:57:13 +0000
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
Subject: [RFC PATCH v2 073/137] hw/arm/aspeed: Give onboard devices a QOM
 parent (part 2)
Date: Sat, 18 Jul 2026 21:35:48 +0000
Message-ID: <20260718213652.37673-74-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=50.112.246.219;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in the four large
hw/arm/aspeed_ast2600_{anacapa,catalina,fuji,rainier}.c board
files to the new parented API introduced earlier in this series,
so every onboard I2C peripheral gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the machine (AspeedMachineState); the
board's .i2c_init() callback receives it directly.  Names are
derived from the device type and auto-indexed.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/aspeed_ast2600_anacapa.c:240 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | anacapa_bmc_i2c_init(AspeedMachineState *bmc) is amc->i2c_init callback invoked from board init; bmc IS the MachineState. Multiple PCA954x muxes -> auto-index. Local Object *o = OBJECT(bmc) added.
hw/arm/aspeed_ast2600_anacapa.c:246 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_anacapa.c:250 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_anacapa.c:259 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_anacapa.c:264 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; PCA9552 GPIO expander behind mux, many instances -> auto-index.
hw/arm/aspeed_ast2600_anacapa.c:267 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_anacapa.c:275 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_anacapa.c:278 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_anacapa.c:294 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_anacapa.c:298 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_anacapa.c:306 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_anacapa.c:312 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_anacapa.c:320 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:475 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | catalina_bmc_i2c_init(AspeedMachineState *bmc) board i2c_init callback. Local Object *o = OBJECT(bmc) added. Many PCA954x -> auto-index.
hw/arm/aspeed_ast2600_catalina.c:478 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:482 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; PCA9535 GPIO expander -> auto-index.
hw/arm/aspeed_ast2600_catalina.c:489 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:492 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:495 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:499 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:506 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:511 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:528 | i2c_slave_create_simple | OBJECT(bmc) | "tmp75[*]" | Board i2c_init; multiple TMP75 -> auto-index.
hw/arm/aspeed_ast2600_catalina.c:532 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; PCA9554 GPIO expander -> auto-index with other GPIO expanders.
hw/arm/aspeed_ast2600_catalina.c:535 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:546 | i2c_slave_create_simple | OBJECT(bmc) | "tmp75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:550 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:552 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:554 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:562 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:575 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:577 | i2c_slave_create_simple | OBJECT(bmc) | "rtc" | Board i2c_init; single DS1338 RTC.
hw/arm/aspeed_ast2600_catalina.c:581 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:583 | i2c_slave_create_simple | OBJECT(bmc) | "tmp75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:591 | i2c_slave_create_simple | OBJECT(bmc) | "tmp421[*]" | Board i2c_init; two TMP421 -> auto-index.
hw/arm/aspeed_ast2600_catalina.c:618 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:620 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:622 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:624 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:626 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:628 | i2c_slave_create_simple | OBJECT(bmc) | "gpio[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_catalina.c:632 | i2c_slave_create_simple | OBJECT(bmc) | "tmp421[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:30 | i2c_slave_create_simple | parent | "i2c-mux[*]" | get_pca9548_channels() static helper called only from fuji_bmc_i2c_init(); no parent-capable pointer -> add Object *parent as first arg and thread OBJECT(bmc) from all 8 direct + 1 loop callers. 15 muxes total -> auto-index.
hw/arm/aspeed_ast2600_fuji.c:60 | i2c_slave_create_simple | OBJECT(bmc) | "lm75[*]" | fuji_bmc_i2c_init(AspeedMachineState *bmc) board i2c_init. Local Object *o = OBJECT(bmc) added. LM75/TMP75 both alias TYPE_TMP105 but keep source-macro-derived names for readability; auto-index.
hw/arm/aspeed_ast2600_fuji.c:61 | i2c_slave_create_simple | OBJECT(bmc) | "lm75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:71 | i2c_slave_create_simple | OBJECT(bmc) | "lm75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:72 | i2c_slave_create_simple | OBJECT(bmc) | "lm75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:73 | i2c_slave_create_simple | OBJECT(bmc) | "lm75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:74 | i2c_slave_create_simple | OBJECT(bmc) | "tmp422" | Board i2c_init; single TMP422.
hw/arm/aspeed_ast2600_fuji.c:77 | i2c_slave_create_simple | OBJECT(bmc) | "lm75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:79 | i2c_slave_create_simple | OBJECT(bmc) | "lm75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:81 | i2c_slave_create_simple | OBJECT(bmc) | "tmp75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:82 | i2c_slave_create_simple | OBJECT(bmc) | "tmp75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:84 | i2c_slave_create_simple | OBJECT(bmc) | "tmp75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:85 | i2c_slave_create_simple | OBJECT(bmc) | "tmp75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:88 | i2c_slave_create_simple | OBJECT(bmc) | "tmp75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:89 | i2c_slave_create_simple | OBJECT(bmc) | "tmp75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:96 | i2c_slave_create_simple | OBJECT(bmc) | "tmp75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:97 | i2c_slave_create_simple | OBJECT(bmc) | "tmp75[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_fuji.c:106 | i2c_slave_create_simple | OBJECT(bmc) | "tmp75[*]" | Board i2c_init; loop x8 -> auto-index.
hw/arm/aspeed_ast2600_fuji.c:107 | i2c_slave_create_simple | OBJECT(bmc) | "tmp75[*]" | Board i2c_init; loop x8 -> auto-index.
hw/arm/aspeed_ast2600_fuji.c:108 | i2c_slave_create_simple | OBJECT(bmc) | "tmp75[*]" | Board i2c_init; loop x8 -> auto-index.
hw/arm/aspeed_ast2600_rainier.c:76 | i2c_slave_create_simple | OBJECT(bmc) | "tmp105[*]" | rainier_bmc_i2c_init(AspeedMachineState *bmc) board i2c_init. Local Object *o = OBJECT(bmc) added. Many TMP105 -> auto-index.
hw/arm/aspeed_ast2600_rainier.c:78 | i2c_slave_create_simple | OBJECT(bmc) | "tmp105[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:80 | i2c_slave_create_simple | OBJECT(bmc) | "tmp105[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:82 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; multiple PCA9546 -> auto-index.
hw/arm/aspeed_ast2600_rainier.c:89 | i2c_slave_create_simple | OBJECT(bmc) | "tmp105[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:91 | i2c_slave_create_simple | OBJECT(bmc) | "tmp105[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:95 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:100 | i2c_slave_create_simple | OBJECT(bmc) | "tmp105[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:102 | i2c_slave_create_simple | OBJECT(bmc) | "tmp105[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:104 | i2c_slave_create_simple | OBJECT(bmc) | "tmp105[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:106 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:119 | i2c_slave_create_simple | OBJECT(bmc) | "dps310" | Board i2c_init; single dps310 pressure sensor.
hw/arm/aspeed_ast2600_rainier.c:121 | i2c_slave_create_simple | OBJECT(bmc) | "tmp105[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:123 | i2c_slave_create_simple | OBJECT(bmc) | "max31785" | Board i2c_init; single max31785 fan controller.
hw/arm/aspeed_ast2600_rainier.c:127 | i2c_slave_create_simple | OBJECT(bmc) | "tmp105[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:129 | i2c_slave_create_simple | OBJECT(bmc) | "tmp105[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:141 | i2c_slave_create_simple | OBJECT(bmc) | "tmp423[*]" | Board i2c_init; four tmp423 -> auto-index.
hw/arm/aspeed_ast2600_rainier.c:142 | i2c_slave_create_simple | OBJECT(bmc) | "tmp423[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:145 | i2c_slave_create_simple | OBJECT(bmc) | "tmp423[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:146 | i2c_slave_create_simple | OBJECT(bmc) | "tmp423[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:149 | i2c_slave_create_simple | OBJECT(bmc) | "tmp105[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:151 | i2c_slave_create_simple | OBJECT(bmc) | "tmp105[*]" | Board i2c_init; auto-index.
hw/arm/aspeed_ast2600_rainier.c:153 | i2c_slave_create_simple | OBJECT(bmc) | "i2c-mux[*]" | Board i2c_init; auto-index.

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/aspeed_ast2600_anacapa.c  |  31 ++++++----
 hw/arm/aspeed_ast2600_catalina.c |  65 +++++++++++---------
 hw/arm/aspeed_ast2600_fuji.c     |  65 +++++++++++---------
 hw/arm/aspeed_ast2600_rainier.c  | 102 ++++++++++++++++++++-----------
 4 files changed, 155 insertions(+), 108 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index 98395f196b..d6412f5b0c 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -228,6 +228,7 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     AspeedSoCState *soc = bmc->soc;
     I2CBus *i2c[16] = {};
     I2CSlave *i2c_mux;
+    Object *o = OBJECT(bmc);
 
     for (int i = 0; i < ARRAY_SIZE(i2c); i++) {
         i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
@@ -237,17 +238,17 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     /* eeprom@50 */
     at24c_eeprom_init(i2c[0], 0x50, 256 * KiB);
     /* i2c-mux@70 */
-    i2c_slave_create_simple_orphan(i2c[0], TYPE_PCA9546, 0x70);
+    i2c_slave_create_simple(o, "i2c-mux[*]", i2c[0], TYPE_PCA9546, 0x70);
 
     /* &i2c1 */
     /* eeprom@50 */
     at24c_eeprom_init(i2c[1], 0x50, 256 * KiB);
     /* i2c-mux@70 (PCA9546) — 4 channels, empty */
-    i2c_slave_create_simple_orphan(i2c[1], TYPE_PCA9546, 0x70);
+    i2c_slave_create_simple(o, "i2c-mux[*]", i2c[1], TYPE_PCA9546, 0x70);
 
     /* &i2c4 */
     /* i2c-mux@70 (PCA9548) */
-    i2c_slave_create_simple_orphan(i2c[4], TYPE_PCA9548, 0x70);
+    i2c_slave_create_simple(o, "i2c-mux[*]", i2c[4], TYPE_PCA9548, 0x70);
 
     /* &i2c6 */
     /* eeprom@50 */
@@ -256,15 +257,16 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c8 */
     /* i2c-mux@72 (PCA9546) */
-    i2c_mux = i2c_slave_create_simple_orphan(i2c[8], TYPE_PCA9546, 0x72);
+    i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]", i2c[8],
+                                      TYPE_PCA9546, 0x72);
 
     /* i2c8mux ch0 */
     /* adc128d818@1f — no model */
     /* pca9555@22 */
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 0),
+    i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 0),
                             TYPE_PCA9552, 0x22);
     /* pca9555@24 */
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 0),
+    i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 0),
                             TYPE_PCA9552, 0x24);
     /* eeprom@50 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 16 * KiB,
@@ -272,10 +274,10 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* i2c8mux ch1 */
     /* pca9555@22 */
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 1),
+    i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9552, 0x22);
     /* pca9555@24 */
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 1),
+    i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9552, 0x24);
     /* eeprom@50 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 16 * KiB,
@@ -291,11 +293,12 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c10 */
     /* i2c-mux@71 (PCA9548) */
-    i2c_mux = i2c_slave_create_simple_orphan(i2c[10], TYPE_PCA9548, 0x71);
+    i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]", i2c[10],
+                                      TYPE_PCA9548, 0x71);
 
     /* i2c10mux ch5 */
     /* pca9555@22*/
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 5),
+    i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 5),
                             TYPE_PCA9552, 0x22);
     /* eeprom@52 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB,
@@ -303,13 +306,14 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c11 */
     /* i2c-mux@71 (PCA9548) */
-    i2c_mux = i2c_slave_create_simple_orphan(i2c[11], TYPE_PCA9548, 0x71);
+    i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]", i2c[11],
+                                      TYPE_PCA9548, 0x71);
 
     /* i2c11mux ch0-ch4 — empty */
 
     /* i2c11mux ch5 */
     /* pca9555@22 */
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 5),
+    i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 5),
                             TYPE_PCA9552, 0x22);
     /* eeprom@52 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB,
@@ -317,7 +321,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c13 */
     /* i2c-mux@70 (PCA9548) */
-    i2c_mux = i2c_slave_create_simple_orphan(i2c[13], TYPE_PCA9548, 0x70);
+    i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]", i2c[13],
+                                      TYPE_PCA9548, 0x70);
 
     /* i2c13mux ch3 */
     /* adc128d818@1f - no model */
diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index c2c949ace3..59fc0d2437 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -464,6 +464,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     AspeedSoCState *soc = bmc->soc;
     I2CBus *i2c[16] = {};
     I2CSlave *i2c_mux;
+    Object *o = OBJECT(bmc);
 
     /* busses 0-15 are all used. */
     for (int i = 0; i < ARRAY_SIZE(i2c); i++) {
@@ -472,43 +473,46 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c0 */
     /* i2c-mux@71 (PCA9546) on i2c0 */
-    i2c_slave_create_simple_orphan(i2c[0], TYPE_PCA9546, 0x71);
+    i2c_slave_create_simple(o, "i2c-mux[*]", i2c[0], TYPE_PCA9546, 0x71);
 
     /* i2c-mux@72 (PCA9546) on i2c0 */
-    i2c_mux = i2c_slave_create_simple_orphan(i2c[0], TYPE_PCA9546, 0x72);
+    i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]", i2c[0],
+                                      TYPE_PCA9546, 0x72);
 
     /* i2c0mux1ch1 */
     /* io_expander7 - pca9535@20 */
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 1),
+    i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9535, 0x20);
     /* eeprom@50 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
                           gb200io_eeprom, gb200io_eeprom_len);
 
     /* i2c-mux@73 (PCA9546) on i2c0 */
-    i2c_slave_create_simple_orphan(i2c[0], TYPE_PCA9546, 0x73);
+    i2c_slave_create_simple(o, "i2c-mux[*]", i2c[0], TYPE_PCA9546, 0x73);
 
     /* i2c-mux@75 (PCA9546) on i2c0 */
-    i2c_slave_create_simple_orphan(i2c[0], TYPE_PCA9546, 0x75);
+    i2c_slave_create_simple(o, "i2c-mux[*]", i2c[0], TYPE_PCA9546, 0x75);
 
     /* i2c-mux@76 (PCA9546) on i2c0 */
-    i2c_mux = i2c_slave_create_simple_orphan(i2c[0], TYPE_PCA9546, 0x76);
+    i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]", i2c[0],
+                                      TYPE_PCA9546, 0x76);
 
     /* i2c0mux4ch1 */
     /* io_expander8 - pca9535@21 */
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 1),
+    i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9535, 0x21);
     /* eeprom@50 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
                           gb200io_eeprom, gb200io_eeprom_len);
 
     /* i2c-mux@77 (PCA9546) on i2c0 */
-    i2c_slave_create_simple_orphan(i2c[0], TYPE_PCA9546, 0x77);
+    i2c_slave_create_simple(o, "i2c-mux[*]", i2c[0], TYPE_PCA9546, 0x77);
 
 
     /* &i2c1 */
     /* i2c-mux@70 (PCA9548) on i2c1 */
-    i2c_mux = i2c_slave_create_simple_orphan(i2c[1], TYPE_PCA9548, 0x70);
+    i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]", i2c[1],
+                                      TYPE_PCA9548, 0x70);
     /* i2c1mux0ch0 */
     /* ina238@41 - no model */
     /* ina238@42 - no model */
@@ -525,14 +529,15 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x54, 8 * KiB,
                           pdb_eeprom, pdb_eeprom_len);
     /* tpm75@4f */
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 5), TYPE_TMP75, 0x4f);
+    i2c_slave_create_simple(o, "tmp75[*]", pca954x_i2c_get_bus(i2c_mux, 5),
+                            TYPE_TMP75, 0x4f);
 
     /* i2c1mux0ch6 */
     /* io_expander5 - pca9554@27 */
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 6),
+    i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 6),
                             TYPE_PCA9554, 0x27);
     /* io_expander6 - pca9555@25 */
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 6),
+    i2c_slave_create_simple(o, "gpio[*]", pca954x_i2c_get_bus(i2c_mux, 6),
                             TYPE_PCA9552, 0x25);
     /* eeprom@51 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 6), 0x51, 8 * KiB,
@@ -543,15 +548,16 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 7), 0x53, 8 * KiB,
                           fio_eeprom, fio_eeprom_len);
     /* temperature-sensor@4b - tmp75 */
-    i2c_slave_create_simple_orphan(pca954x_i2c_get_bus(i2c_mux, 7), TYPE_TMP75, 0x4b);
+    i2c_slave_create_simple(o, "tmp75[*]", pca954x_i2c_get_bus(i2c_mux, 7),
+                            TYPE_TMP75, 0x4b);
 
     /* &i2c2 */
     /* io_expander0 - pca9555@20 */
-    i2c_slave_create_simple_orphan(i2c[2], TYPE_PCA9552, 0x20);
+    i2c_slave_create_simple(o, "gpio[*]", i2c[2], TYPE_PCA9552, 0x20);
     /* io_expander0 - pca9555@21 */
-    i2c_slave_create_simple_orphan(i2c[2], TYPE_PCA9552, 0x21);
+    i2c_slave_create_simple(o, "gpio[*]", i2c[2], TYPE_PCA9552, 0x21);
     /* io_expander0 - pca9555@27 */
-    i2c_slave_create_simple_orphan(i2c[2], TYPE_PCA9552, 0x27);
+    i2c_slave_create_simple(o, "gpio[*]", i2c[2], TYPE_PCA9552, 0x27);
     /* eeprom@50 */
     at24c_eeprom_init(i2c[2], 0x50, 8 * KiB);
     /* eeprom@51 */
@@ -559,7 +565,8 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c5 */
     /* i2c-mux@70 (PCA9548) on i2c5 */
-    i2c_mux = i2c_slave_create_simple_orphan(i2c[5], TYPE_PCA9548, 0x70);
+    i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]", i2c[5],
+                                      TYPE_PCA9548, 0x70);
     /* i2c5mux0ch6 */
     /* eeprom@52 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 6), 0x52, 8 * KiB,
@@ -572,15 +579,15 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c6 */
     /* io_expander3 - pca9555@21 */
-    i2c_slave_create_simple_orphan(i2c[6], TYPE_PCA9552, 0x21);
+    i2c_slave_create_simple(o, "gpio[*]", i2c[6], TYPE_PCA9552, 0x21);
     /* rtc@6f - nct3018y */
-    i2c_slave_create_simple_orphan(i2c[6], TYPE_DS1338, 0x6f);
+    i2c_slave_create_simple(o, "rtc", i2c[6], TYPE_DS1338, 0x6f);
 
     /* &i2c9 */
     /* io_expander4 - pca9555@4f */
-    i2c_slave_create_simple_orphan(i2c[9], TYPE_PCA9552, 0x4f);
+    i2c_slave_create_simple(o, "gpio[*]", i2c[9], TYPE_PCA9552, 0x4f);
     /* temperature-sensor@4b - tpm75 */
-    i2c_slave_create_simple_orphan(i2c[9], TYPE_TMP75, 0x4b);
+    i2c_slave_create_simple(o, "tmp75[*]", i2c[9], TYPE_TMP75, 0x4b);
     /* eeprom@50 */
     at24c_eeprom_init_rom(i2c[9], 0x50, 8 * KiB, scm_eeprom, scm_eeprom_len);
     /* eeprom@56 */
@@ -588,7 +595,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c10 */
     /* temperature-sensor@1f - tpm421 */
-    i2c_slave_create_simple_orphan(i2c[10], TYPE_TMP421, 0x1f);
+    i2c_slave_create_simple(o, "tmp421[*]", i2c[10], TYPE_TMP421, 0x1f);
     /* eeprom@50 */
     at24c_eeprom_init_rom(i2c[10], 0x50, 8 * KiB, nic_eeprom, nic_eeprom_len);
 
@@ -615,21 +622,21 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c14 */
     /* io_expander9 - pca9555@10 */
-    i2c_slave_create_simple_orphan(i2c[14], TYPE_PCA9552, 0x10);
+    i2c_slave_create_simple(o, "gpio[*]", i2c[14], TYPE_PCA9552, 0x10);
     /* io_expander10 - pca9555@11 */
-    i2c_slave_create_simple_orphan(i2c[14], TYPE_PCA9552, 0x11);
+    i2c_slave_create_simple(o, "gpio[*]", i2c[14], TYPE_PCA9552, 0x11);
     /* io_expander11 - pca9555@12 */
-    i2c_slave_create_simple_orphan(i2c[14], TYPE_PCA9552, 0x12);
+    i2c_slave_create_simple(o, "gpio[*]", i2c[14], TYPE_PCA9552, 0x12);
     /* io_expander12 - pca9555@13 */
-    i2c_slave_create_simple_orphan(i2c[14], TYPE_PCA9552, 0x13);
+    i2c_slave_create_simple(o, "gpio[*]", i2c[14], TYPE_PCA9552, 0x13);
     /* io_expander13 - pca9555@14 */
-    i2c_slave_create_simple_orphan(i2c[14], TYPE_PCA9552, 0x14);
+    i2c_slave_create_simple(o, "gpio[*]", i2c[14], TYPE_PCA9552, 0x14);
     /* io_expander14 - pca9555@15 */
-    i2c_slave_create_simple_orphan(i2c[14], TYPE_PCA9552, 0x15);
+    i2c_slave_create_simple(o, "gpio[*]", i2c[14], TYPE_PCA9552, 0x15);
 
     /* &i2c15 */
     /* temperature-sensor@1f - tmp421 */
-    i2c_slave_create_simple_orphan(i2c[15], TYPE_TMP421, 0x1f);
+    i2c_slave_create_simple(o, "tmp421[*]", i2c[15], TYPE_TMP421, 0x1f);
     /* eeprom@52 */
     at24c_eeprom_init_rom(i2c[15], 0x52, 8 * KiB, nic_eeprom, nic_eeprom_len);
 }
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index 59b2da1ccf..1e681d0090 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -24,10 +24,11 @@
 #define FUJI_BMC_HW_STRAP2    0x00000000
 #define FUJI_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
 
-static void get_pca9548_channels(I2CBus *bus, uint8_t mux_addr,
-                                 I2CBus **channels)
+static void get_pca9548_channels(Object *parent, I2CBus *bus,
+                                 uint8_t mux_addr, I2CBus **channels)
 {
-    I2CSlave *mux = i2c_slave_create_simple_orphan(bus, "pca9548", mux_addr);
+    I2CSlave *mux = i2c_slave_create_simple(parent, "i2c-mux[*]", bus,
+                                            "pca9548", mux_addr);
     for (int i = 0; i < 8; i++) {
         channels[i] = pca954x_i2c_get_bus(mux, i);
     }
@@ -37,6 +38,7 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
     I2CBus *i2c[144] = {};
+    Object *o = OBJECT(bmc);
 
     for (int i = 0; i < 16; i++) {
         i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
@@ -45,20 +47,20 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
     I2CBus *i2c480 = i2c[8];
     I2CBus *i2c600 = i2c[11];
 
-    get_pca9548_channels(i2c180, 0x70, &i2c[16]);
-    get_pca9548_channels(i2c480, 0x70, &i2c[24]);
+    get_pca9548_channels(o, i2c180, 0x70, &i2c[16]);
+    get_pca9548_channels(o, i2c480, 0x70, &i2c[24]);
     /* NOTE: The device tree skips [32, 40) in the alias numbering */
-    get_pca9548_channels(i2c600, 0x77, &i2c[40]);
-    get_pca9548_channels(i2c[24], 0x71, &i2c[48]);
-    get_pca9548_channels(i2c[25], 0x72, &i2c[56]);
-    get_pca9548_channels(i2c[26], 0x76, &i2c[64]);
-    get_pca9548_channels(i2c[27], 0x76, &i2c[72]);
+    get_pca9548_channels(o, i2c600, 0x77, &i2c[40]);
+    get_pca9548_channels(o, i2c[24], 0x71, &i2c[48]);
+    get_pca9548_channels(o, i2c[25], 0x72, &i2c[56]);
+    get_pca9548_channels(o, i2c[26], 0x76, &i2c[64]);
+    get_pca9548_channels(o, i2c[27], 0x76, &i2c[72]);
     for (int i = 0; i < 8; i++) {
-        get_pca9548_channels(i2c[40 + i], 0x76, &i2c[80 + i * 8]);
+        get_pca9548_channels(o, i2c[40 + i], 0x76, &i2c[80 + i * 8]);
     }
 
-    i2c_slave_create_simple_orphan(i2c[17], TYPE_LM75, 0x4c);
-    i2c_slave_create_simple_orphan(i2c[17], TYPE_LM75, 0x4d);
+    i2c_slave_create_simple(o, "lm75[*]", i2c[17], TYPE_LM75, 0x4c);
+    i2c_slave_create_simple(o, "lm75[*]", i2c[17], TYPE_LM75, 0x4d);
 
     /*
      * EEPROM 24c64 size is 64Kbits or 8 Kbytes
@@ -68,33 +70,33 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init(i2c[20], 0x50, 256);
     at24c_eeprom_init(i2c[22], 0x52, 256);
 
-    i2c_slave_create_simple_orphan(i2c[3], TYPE_LM75, 0x48);
-    i2c_slave_create_simple_orphan(i2c[3], TYPE_LM75, 0x49);
-    i2c_slave_create_simple_orphan(i2c[3], TYPE_LM75, 0x4a);
-    i2c_slave_create_simple_orphan(i2c[3], TYPE_TMP422, 0x4c);
+    i2c_slave_create_simple(o, "lm75[*]", i2c[3], TYPE_LM75, 0x48);
+    i2c_slave_create_simple(o, "lm75[*]", i2c[3], TYPE_LM75, 0x49);
+    i2c_slave_create_simple(o, "lm75[*]", i2c[3], TYPE_LM75, 0x4a);
+    i2c_slave_create_simple(o, "tmp422", i2c[3], TYPE_TMP422, 0x4c);
 
     at24c_eeprom_init(i2c[8], 0x51, 8 * KiB);
-    i2c_slave_create_simple_orphan(i2c[8], TYPE_LM75, 0x4a);
+    i2c_slave_create_simple(o, "lm75[*]", i2c[8], TYPE_LM75, 0x4a);
 
-    i2c_slave_create_simple_orphan(i2c[50], TYPE_LM75, 0x4c);
+    i2c_slave_create_simple(o, "lm75[*]", i2c[50], TYPE_LM75, 0x4c);
     at24c_eeprom_init(i2c[50], 0x52, 8 * KiB);
-    i2c_slave_create_simple_orphan(i2c[51], TYPE_TMP75, 0x48);
-    i2c_slave_create_simple_orphan(i2c[52], TYPE_TMP75, 0x49);
+    i2c_slave_create_simple(o, "tmp75[*]", i2c[51], TYPE_TMP75, 0x48);
+    i2c_slave_create_simple(o, "tmp75[*]", i2c[52], TYPE_TMP75, 0x49);
 
-    i2c_slave_create_simple_orphan(i2c[59], TYPE_TMP75, 0x48);
-    i2c_slave_create_simple_orphan(i2c[60], TYPE_TMP75, 0x49);
+    i2c_slave_create_simple(o, "tmp75[*]", i2c[59], TYPE_TMP75, 0x48);
+    i2c_slave_create_simple(o, "tmp75[*]", i2c[60], TYPE_TMP75, 0x49);
 
     at24c_eeprom_init(i2c[65], 0x53, 8 * KiB);
-    i2c_slave_create_simple_orphan(i2c[66], TYPE_TMP75, 0x49);
-    i2c_slave_create_simple_orphan(i2c[66], TYPE_TMP75, 0x48);
+    i2c_slave_create_simple(o, "tmp75[*]", i2c[66], TYPE_TMP75, 0x49);
+    i2c_slave_create_simple(o, "tmp75[*]", i2c[66], TYPE_TMP75, 0x48);
     at24c_eeprom_init(i2c[68], 0x52, 8 * KiB);
     at24c_eeprom_init(i2c[69], 0x52, 8 * KiB);
     at24c_eeprom_init(i2c[70], 0x52, 8 * KiB);
     at24c_eeprom_init(i2c[71], 0x52, 8 * KiB);
 
     at24c_eeprom_init(i2c[73], 0x53, 8 * KiB);
-    i2c_slave_create_simple_orphan(i2c[74], TYPE_TMP75, 0x49);
-    i2c_slave_create_simple_orphan(i2c[74], TYPE_TMP75, 0x48);
+    i2c_slave_create_simple(o, "tmp75[*]", i2c[74], TYPE_TMP75, 0x49);
+    i2c_slave_create_simple(o, "tmp75[*]", i2c[74], TYPE_TMP75, 0x48);
     at24c_eeprom_init(i2c[76], 0x52, 8 * KiB);
     at24c_eeprom_init(i2c[77], 0x52, 8 * KiB);
     at24c_eeprom_init(i2c[78], 0x52, 8 * KiB);
@@ -103,9 +105,12 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
 
     for (int i = 0; i < 8; i++) {
         at24c_eeprom_init(i2c[81 + i * 8], 0x56, 64 * KiB);
-        i2c_slave_create_simple_orphan(i2c[82 + i * 8], TYPE_TMP75, 0x48);
-        i2c_slave_create_simple_orphan(i2c[83 + i * 8], TYPE_TMP75, 0x4b);
-        i2c_slave_create_simple_orphan(i2c[84 + i * 8], TYPE_TMP75, 0x4a);
+        i2c_slave_create_simple(o, "tmp75[*]", i2c[82 + i * 8],
+                                TYPE_TMP75, 0x48);
+        i2c_slave_create_simple(o, "tmp75[*]", i2c[83 + i * 8],
+                                TYPE_TMP75, 0x4b);
+        i2c_slave_create_simple(o, "tmp75[*]", i2c[84 + i * 8],
+                                TYPE_TMP75, 0x4a);
     }
 }
 
diff --git a/hw/arm/aspeed_ast2600_rainier.c b/hw/arm/aspeed_ast2600_rainier.c
index 8ba15aceca..2f5e3daf3b 100644
--- a/hw/arm/aspeed_ast2600_rainier.c
+++ b/hw/arm/aspeed_ast2600_rainier.c
@@ -67,43 +67,55 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
     I2CSlave *i2c_mux;
+    Object *o = OBJECT(bmc);
 
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 0), 0x51, 32 * KiB);
 
     aspeed_create_pca9552(OBJECT(bmc), soc, 3, 0x61);
 
     /* The rainier expects a TMP275 but a TMP105 is compatible */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
-                     0x49);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
-                     0x4a);
-    i2c_mux = i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 4),
+    i2c_slave_create_simple(o, "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 4),
+                            TYPE_TMP105, 0x48);
+    i2c_slave_create_simple(o, "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 4),
+                            TYPE_TMP105, 0x49);
+    i2c_slave_create_simple(o, "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 4),
+                            TYPE_TMP105, 0x4a);
+    i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]",
+                                      aspeed_i2c_get_bus(&soc->i2c, 4),
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x52, 64 * KiB);
     aspeed_create_pca9552(OBJECT(bmc), soc, 4, 0x60);
 
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
-                     0x49);
+    i2c_slave_create_simple(o, "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 5),
+                            TYPE_TMP105, 0x48);
+    i2c_slave_create_simple(o, "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 5),
+                            TYPE_TMP105, 0x49);
     aspeed_create_pca9552(OBJECT(bmc), soc, 5, 0x60);
     aspeed_create_pca9552(OBJECT(bmc), soc, 5, 0x61);
-    i2c_mux = i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 5),
+    i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]",
+                                      aspeed_i2c_get_bus(&soc->i2c, 5),
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
 
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
-                     0x4a);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
-                     0x4b);
-    i2c_mux = i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 6),
+    i2c_slave_create_simple(o, "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 6),
+                            TYPE_TMP105, 0x48);
+    i2c_slave_create_simple(o, "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 6),
+                            TYPE_TMP105, 0x4a);
+    i2c_slave_create_simple(o, "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 6),
+                            TYPE_TMP105, 0x4b);
+    i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]",
+                                      aspeed_i2c_get_bus(&soc->i2c, 6),
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
@@ -116,18 +128,25 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     aspeed_create_pca9552(OBJECT(bmc), soc, 7, 0x33);
     aspeed_create_pca9552(OBJECT(bmc), soc, 7, 0x60);
     aspeed_create_pca9552(OBJECT(bmc), soc, 7, 0x61);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 7), "dps310", 0x76);
+    i2c_slave_create_simple(o, "dps310",
+                            aspeed_i2c_get_bus(&soc->i2c, 7),
+                            "dps310", 0x76);
     /* Bus 7: TODO si7021-a20@20 */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 7), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 7), "max31785", 0x52);
+    i2c_slave_create_simple(o, "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 7),
+                            TYPE_TMP105, 0x48);
+    i2c_slave_create_simple(o, "max31785",
+                            aspeed_i2c_get_bus(&soc->i2c, 7),
+                            "max31785", 0x52);
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x50, 64 * KiB);
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x51, 64 * KiB);
 
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
-                     0x4a);
+    i2c_slave_create_simple(o, "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 8),
+                            TYPE_TMP105, 0x48);
+    i2c_slave_create_simple(o, "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 8),
+                            TYPE_TMP105, 0x4a);
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50,
                           64 * KiB, rainier_bb_fruid, rainier_bb_fruid_len);
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51,
@@ -138,19 +157,30 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     /* Bus 8: ucd90320@b */
     /* Bus 8: ucd90320@c */
 
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4c);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4d);
+    i2c_slave_create_simple(o, "tmp423[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 9),
+                            "tmp423", 0x4c);
+    i2c_slave_create_simple(o, "tmp423[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 9),
+                            "tmp423", 0x4d);
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 9), 0x50, 128 * KiB);
 
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4c);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4d);
+    i2c_slave_create_simple(o, "tmp423[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 10),
+                            "tmp423", 0x4c);
+    i2c_slave_create_simple(o, "tmp423[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 10),
+                            "tmp423", 0x4d);
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 10), 0x50, 128 * KiB);
 
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,
-                     0x49);
-    i2c_mux = i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 11),
+    i2c_slave_create_simple(o, "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 11),
+                            TYPE_TMP105, 0x48);
+    i2c_slave_create_simple(o, "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 11),
+                            TYPE_TMP105, 0x49);
+    i2c_mux = i2c_slave_create_simple(o, "i2c-mux[*]",
+                                      aspeed_i2c_get_bus(&soc->i2c, 11),
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
-- 
2.47.1


