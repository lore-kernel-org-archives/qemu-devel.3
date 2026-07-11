Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7BBC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigcJ-0000h6-Oq; Sat, 11 Jul 2026 18:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigcC-0000b1-MG; Sat, 11 Jul 2026 18:56:08 -0400
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([34.218.115.239])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigc6-00013E-SA; Sat, 11 Jul 2026 18:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810562; x=1815346562;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5ViCkmhLCdaLrt9KJaf520Q+/hnnwvkZfg8J/csG4Zg=;
 b=dTPtAzTzmkboAow/E0PruY+mmPgWi/iD6HHqlHNf0u9bp+GL4kYuMscF
 DH6Sk8iTuiMmXhDoVbxR3AlW78MxP/wqzgDPcLJTqUqcKt7i6D6SELP+x
 bXhqdnLVi4m+0B3mtmBeiQVBrqhmOomfQmnkV9xvsl7FH70nrJzWDm2xh
 Z9WDlrIFrhLG/wYBi8CSjtjWmPOEZiJG/wwGcajuHtSnN6DWRfbt+l4x1
 GTKRuc7aLHE054T9djp5ftWYlePQU/LzRUo3x8poVz4gxPazQtSr/fonn
 ny4idHrgwTJLqCFsE0zMUgPpkghrnBuY1/GtiP9WMvPUjZO9+L0k0+q0d Q==;
X-CSE-ConnectionGUID: hkhwxQfoRQepV2q9W9KurQ==
X-CSE-MsgGUID: TXesh5j+RXexMXrj5xS4KQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23296810"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:55:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:15765]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.175:2525]
 with esmtp (Farcaster)
 id e0a60f8d-8342-477b-822c-5a84b286d60a; Sat, 11 Jul 2026 22:55:45 +0000 (UTC)
X-Farcaster-Flow-ID: e0a60f8d-8342-477b-822c-5a84b286d60a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:55:45 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:55:36 +0000
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
Subject: [RFC PATCH 071/134] hw/arm/aspeed: Give onboard devices a QOM parent
 (part 1)
Date: Sat, 11 Jul 2026 22:36:04 +0000
Message-ID: <20260711223707.42139-72-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
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

Convert the *_orphan() device-creation calls in the smaller
hw/arm/aspeed_* board files and the shared aspeed helpers to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine (AspeedMachineState) for board-created I2C peripherals, the
containing SoC device for composite children.  Names follow existing
QOM conventions.

The shared helpers aspeed_create_pca9552(), aspeed_create_pca9554()
and aspeed_soc_uart_realize() gain an Object *parent first argument;
callers in the four large aspeed board files are updated here so
this commit builds standalone, but the direct *_orphan() calls in
those four files are converted in the next commit.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/aspeed_* boards — per-callsite rationale (62 sites)
============================================================

Common context: all *_i2c_init(AspeedMachineState *bmc) callbacks are invoked
from aspeed_machine_init() (mc->init) via amc->i2c_init(bmc). bmc is the
MachineState → parent = OBJECT(bmc). i2c_slave_create_simple realizes
internally, so no realize-call change needed. i2c_slave_new pairs with
qdev_realize (i2c_slave_realize does not exist).

File:Line                                Old call                              Parent          Name          Notes
---------------------------------------  ------------------------------------  --------------  ------------  ------------------------------------------
aspeed_ast1040_evb.c:59                  i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp105"      board i2c_init callback
aspeed_ast10x0_evb.c:77                  i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp105"      board i2c_init callback
aspeed_ast2400_palmetto.c:40             i2c_slave_create_simple_orphan        OBJECT(bmc)     "rtc"         ds1338 RTC
aspeed_ast2400_palmetto.c:46             i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp423"      single instance
aspeed_ast2400_quanta-q71l.c:36          i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp105[*]"   3× tmp105 → auto-index
aspeed_ast2400_quanta-q71l.c:37          i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp105[*]"
aspeed_ast2400_quanta-q71l.c:38          i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp105[*]"
aspeed_ast2400_quanta-q71l.c:44          i2c_slave_create_simple_orphan        OBJECT(bmc)     "i2c-mux[*]"  pca954x muxes
aspeed_ast2400_quanta-q71l.c:45          i2c_slave_create_simple_orphan        OBJECT(bmc)     "i2c-mux[*]"
aspeed_ast2400_quanta-q71l.c:50          i2c_slave_create_simple_orphan        OBJECT(bmc)     "i2c-mux[*]"
aspeed_ast2400_supermicrox11.c:40        i2c_slave_create_simple_orphan        OBJECT(bmc)     "rtc"         ds1338
aspeed_ast2400_supermicrox11.c:46        i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp423"
aspeed_ast2500_evb.c:37                  i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp105"
aspeed_ast2500_g220a.c:35                i2c_slave_create_simple_orphan        OBJECT(bmc)     "emc1413[*]"  3× emc1413
aspeed_ast2500_g220a.c:41                i2c_slave_create_simple_orphan        OBJECT(bmc)     "emc1413[*]"
aspeed_ast2500_g220a.c:47                i2c_slave_create_simple_orphan        OBJECT(bmc)     "emc1413[*]"
aspeed_ast2500_romulus.c:33              i2c_slave_create_simple_orphan        OBJECT(bmc)     "rtc"         ds1338
aspeed_ast2500_supermicro-x11spi.c:36    i2c_slave_create_simple_orphan        OBJECT(bmc)     "rtc"         ds1338
aspeed_ast2500_supermicro-x11spi.c:42    i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp423"
aspeed_ast2500_tiogapass.c:58            i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp421[*]"   3× tmp421
aspeed_ast2500_tiogapass.c:59            i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp421[*]"
aspeed_ast2500_tiogapass.c:60            i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp421[*]"
aspeed_ast2500_witherspoon.c:47          i2c_slave_new_orphan                  OBJECT(bmc)     "pca9552[*]"  → i2c_slave_new; realize_and_unref → qdev_realize(dev, BUS(bus), ...)
aspeed_ast2500_witherspoon.c:61          i2c_slave_create_simple_orphan        OBJECT(bmc)     "dps310"
aspeed_ast2500_witherspoon.c:62          i2c_slave_create_simple_orphan        OBJECT(bmc)     "max31785"
aspeed_ast2500_witherspoon.c:63          i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp423[*]"   2× tmp423
aspeed_ast2500_witherspoon.c:64          i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp423[*]"
aspeed_ast2500_witherspoon.c:67          i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp105"
aspeed_ast2500_witherspoon.c:74          i2c_slave_create_simple_orphan        OBJECT(bmc)     "rtc"         ds1338
aspeed_ast2500_witherspoon.c:78          i2c_slave_new_orphan                  OBJECT(bmc)     "pca9552[*]"  → i2c_slave_new; realize_and_unref → qdev_realize
aspeed_ast2500_yosemitev2.c:58           i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp421[*]"   3× tmp421
aspeed_ast2500_yosemitev2.c:59           i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp421[*]"
aspeed_ast2500_yosemitev2.c:60           i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp421[*]"
aspeed_ast2600_bletchley.c:38            i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp421[*]"   loop 0..5
aspeed_ast2600_bletchley.c:40            i2c_slave_create_simple_orphan        OBJECT(bmc)     "pca9552[*]"  loop 0..5
aspeed_ast2600_bletchley.c:41            i2c_slave_create_simple_orphan        OBJECT(bmc)     "pca9552[*]"  loop 0..5
aspeed_ast2600_bletchley.c:48            i2c_slave_create_simple_orphan        OBJECT(bmc)     "rtc"         ds1338
aspeed_ast2600_bletchley.c:55            i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp421[*]"
aspeed_ast2600_bletchley.c:58            i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp421[*]"
aspeed_ast2600_bletchley.c:60            i2c_slave_create_simple_orphan        OBJECT(bmc)     "pca9552[*]"
aspeed_ast2600_bletchley.c:64            i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp421[*]"
aspeed_ast2600_bletchley.c:65            i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp421[*]"
aspeed_ast2600_bletchley.c:66            i2c_slave_create_simple_orphan        OBJECT(bmc)     "pca9552[*]"
aspeed_ast2600_evb.c:30                  i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp105"
aspeed_ast2600_fby35.c:105               i2c_slave_create_simple_orphan        OBJECT(bmc)     "lm75[*]"     3× LM75 total
aspeed_ast2600_fby35.c:106               i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp421"
aspeed_ast2600_fby35.c:108               i2c_slave_create_simple_orphan        OBJECT(bmc)     "adm1272"
aspeed_ast2600_fby35.c:109               i2c_slave_create_simple_orphan        OBJECT(bmc)     "lm75[*]"
aspeed_ast2600_fby35.c:110               i2c_slave_create_simple_orphan        OBJECT(bmc)     "lm75[*]"
aspeed_ast2600_gb200nvl.c:57             i2c_slave_create_simple_orphan        OBJECT(bmc)     "i2c-mux[*]"  6× pca9546
aspeed_ast2600_gb200nvl.c:58             i2c_slave_create_simple_orphan        OBJECT(bmc)     "i2c-mux[*]"
aspeed_ast2600_gb200nvl.c:59             i2c_slave_create_simple_orphan        OBJECT(bmc)     "i2c-mux[*]"
aspeed_ast2600_gb200nvl.c:60             i2c_slave_create_simple_orphan        OBJECT(bmc)     "i2c-mux[*]"
aspeed_ast2600_gb200nvl.c:61             i2c_slave_create_simple_orphan        OBJECT(bmc)     "i2c-mux[*]"
aspeed_ast2600_gb200nvl.c:62             i2c_slave_create_simple_orphan        OBJECT(bmc)     "i2c-mux[*]"
aspeed_ast27x0_evb.c:27                  i2c_slave_create_simple_orphan        OBJECT(bmc)     "tmp105"
aspeed_ast27x0-fc.c:112                  i2c_slave_create_simple_orphan        OBJECT(machine) "tmp105"      ast2700fc_ca35_init(MachineState *machine)
aspeed.c:93                              qdev_new_orphan                       parent          "sd-card[*]"  static helper sdhci_attach_drive(): threaded
                                                                                                             Object *parent as first arg; callers pass
                                                                                                             OBJECT(bmc) from aspeed_machine_init.
                                                                                                             qdev_realize_and_unref → qdev_realize.
aspeed.c:256                             i2c_slave_create_simple_orphan        parent          "pca9552[*]"  aspeed_create_pca9552(): threaded Object *parent
                                                                                                             first arg. Prototype in include/hw/arm/aspeed.h
                                                                                                             updated. Callers in rainier.c, gb200nvl.c updated
                                                                                                             to pass OBJECT(bmc).
aspeed.c:262                             i2c_slave_create_simple_orphan        parent          "pca9554[*]"  aspeed_create_pca9554(): threaded Object *parent
                                                                                                             first arg. Prototype updated. Callers in
                                                                                                             gb200nvl.c updated to pass OBJECT(bmc).
aspeed_soc_common.c:84                   qdev_new_orphan                       OBJECT(s)       "ram-empty"   aspeed_soc_dram_init(AspeedSoCState *s) called
                                                                                                             from SoC realize (ast2400/2600). Parent = SoC.
                                                                                                             sysbus_realize_and_unref → sysbus_realize.
aspeed_soc_common.c:131                  qdev_new_orphan                       parent          "flash[*]"    aspeed_board_init_flashes(): threaded Object
                                                                                                             *parent first arg. Called from board init
                                                                                                             (aspeed.c, ast10x0_evb.c, ast27x0-fc.c) — all
                                                                                                             callers pass OBJECT(bmc)/OBJECT(machine).
                                                                                                             Prototype in include/hw/arm/aspeed_soc.h updated.
                                                                                                             qdev_realize_and_unref → qdev_realize.

Threaded-parent helper changes (all callers updated in same diff):
  sdhci_attach_drive()        hw/arm/aspeed.c (static)     — 2 callers in aspeed.c
  aspeed_create_pca9552()     hw/arm/aspeed.c + aspeed.h   — 16 callers in aspeed_ast2600_rainier.c
  aspeed_create_pca9554()     hw/arm/aspeed.c + aspeed.h   — 3 callers in aspeed_ast2600_gb200nvl.c
  aspeed_board_init_flashes() hw/arm/aspeed_soc_common.c + aspeed_soc.h — 8 callers
                              (aspeed.c ×3, ast10x0_evb.c ×3, ast27x0-fc.c ×2)

Not touched (per instructions): at24c_eeprom_init*(), smbus_eeprom_init*().

orphan_justified = 0

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/aspeed.c                           | 37 +++++++++++++----------
 hw/arm/aspeed_ast1040_evb.c               |  3 +-
 hw/arm/aspeed_ast10x0_evb.c               |  9 +++---
 hw/arm/aspeed_ast2400_palmetto.c          |  6 ++--
 hw/arm/aspeed_ast2400_quanta-q71l.c       | 18 +++++++----
 hw/arm/aspeed_ast2400_supermicrox11.c     |  6 ++--
 hw/arm/aspeed_ast2500_evb.c               |  5 +--
 hw/arm/aspeed_ast2500_g220a.c             |  9 ++++--
 hw/arm/aspeed_ast2500_romulus.c           |  3 +-
 hw/arm/aspeed_ast2500_supermicro-x11spi.c |  6 ++--
 hw/arm/aspeed_ast2500_tiogapass.c         |  9 ++++--
 hw/arm/aspeed_ast2500_witherspoon.c       | 32 +++++++++++---------
 hw/arm/aspeed_ast2500_yosemitev2.c        |  9 ++++--
 hw/arm/aspeed_ast2600_bletchley.c         | 29 ++++++++++++------
 hw/arm/aspeed_ast2600_evb.c               |  5 +--
 hw/arm/aspeed_ast2600_fby35.c             | 10 +++---
 hw/arm/aspeed_ast2600_gb200nvl.c          | 18 +++++------
 hw/arm/aspeed_ast2600_rainier.c           | 32 ++++++++++----------
 hw/arm/aspeed_ast27x0-fc.c                |  9 ++++--
 hw/arm/aspeed_ast27x0_evb.c               |  3 +-
 hw/arm/aspeed_soc_common.c                | 12 +++++---
 include/hw/arm/aspeed.h                   | 10 +++---
 include/hw/arm/aspeed_soc.h               |  3 +-
 23 files changed, 167 insertions(+), 116 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 4a4c1f1556..2e76e09f8f 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -82,15 +82,16 @@ static void aspeed_reset_secondary(ARMCPU *cpu,
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
-static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
-                               bool boot_emmc)
+static void sdhci_attach_drive(Object *parent, SDHCIState *sdhci,
+                               DriveInfo *dinfo, bool emmc, bool boot_emmc)
 {
         DeviceState *card;
 
         if (!dinfo) {
             return;
         }
-        card = qdev_new_orphan(emmc ? TYPE_EMMC : TYPE_SD_CARD);
+        card = qdev_new(parent, "sd-card[*]",
+                        emmc ? TYPE_EMMC : TYPE_SD_CARD);
 
         /*
          * Force the boot properties of the eMMC device only when the
@@ -108,9 +109,8 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
         }
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
-        qdev_realize_and_unref(card,
-                               qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
-                               &error_fatal);
+        qdev_realize(card, qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
+                     &error_fatal);
 }
 
 void aspeed_connect_serial_hds_to_uarts(AspeedMachineState *bmc)
@@ -188,13 +188,13 @@ static void aspeed_machine_init(MachineState *machine)
     qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
 
     if (defaults_enabled()) {
-        aspeed_board_init_flashes(&bmc->soc->fmc,
+        aspeed_board_init_flashes(OBJECT(bmc), &bmc->soc->fmc,
                               bmc->fmc_model ? bmc->fmc_model : amc->fmc_model,
                               amc->num_cs, 0);
-        aspeed_board_init_flashes(&bmc->soc->spi[0],
+        aspeed_board_init_flashes(OBJECT(bmc), &bmc->soc->spi[0],
                               bmc->spi_model ? bmc->spi_model : amc->spi_model,
                               1, amc->num_cs);
-        aspeed_board_init_flashes(&bmc->soc->spi[1],
+        aspeed_board_init_flashes(OBJECT(bmc), &bmc->soc->spi[1],
                                   amc->spi2_model, 1, amc->num_cs2);
     }
 
@@ -219,7 +219,7 @@ static void aspeed_machine_init(MachineState *machine)
     }
 
     for (i = 0; i < bmc->soc->sdhci.num_slots && defaults_enabled(); i++) {
-        sdhci_attach_drive(&bmc->soc->sdhci.slots[i],
+        sdhci_attach_drive(OBJECT(bmc), &bmc->soc->sdhci.slots[i],
                            drive_get(IF_SD, 0, i), false, false);
     }
 
@@ -227,7 +227,8 @@ static void aspeed_machine_init(MachineState *machine)
 
     if (bmc->soc->emmc.num_slots && defaults_enabled()) {
         emmc0 = drive_get(IF_SD, 0, bmc->soc->sdhci.num_slots);
-        sdhci_attach_drive(&bmc->soc->emmc.slots[0], emmc0, true, boot_emmc);
+        sdhci_attach_drive(OBJECT(bmc), &bmc->soc->emmc.slots[0], emmc0,
+                           true, boot_emmc);
     }
 
     if (!bmc->mmio_exec) {
@@ -251,16 +252,20 @@ static void aspeed_machine_init(MachineState *machine)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
 }
 
-void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
+void aspeed_create_pca9552(Object *parent, AspeedSoCState *soc, int bus_id,
+                           int addr)
 {
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, bus_id),
+    i2c_slave_create_simple(parent, "pca9552[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, bus_id),
                             TYPE_PCA9552, addr);
 }
 
-I2CSlave *aspeed_create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
+I2CSlave *aspeed_create_pca9554(Object *parent, AspeedSoCState *soc,
+                                int bus_id, int addr)
 {
-    return i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, bus_id),
-                            TYPE_PCA9554, addr);
+    return i2c_slave_create_simple(parent, "pca9554[*]",
+                                   aspeed_i2c_get_bus(&soc->i2c, bus_id),
+                                   TYPE_PCA9554, addr);
 }
 
 static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c
index fb83087b13..bbb1ebb104 100644
--- a/hw/arm/aspeed_ast1040_evb.c
+++ b/hw/arm/aspeed_ast1040_evb.c
@@ -56,7 +56,8 @@ static void ast1040_evb_i2c_init(AspeedMachineState *bmc)
 
     smbus_eeprom_init_one(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4d);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp105",
+                            aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4d);
 }
 
 static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast10x0_evb.c b/hw/arm/aspeed_ast10x0_evb.c
index dc134b555c..5153cf7c55 100644
--- a/hw/arm/aspeed_ast10x0_evb.c
+++ b/hw/arm/aspeed_ast10x0_evb.c
@@ -40,16 +40,16 @@ static void aspeed_minibmc_machine_init(MachineState *machine)
     qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
 
     if (defaults_enabled()) {
-        aspeed_board_init_flashes(&bmc->soc->fmc,
+        aspeed_board_init_flashes(OBJECT(bmc), &bmc->soc->fmc,
                             bmc->fmc_model ? bmc->fmc_model : amc->fmc_model,
                             amc->num_cs,
                             0);
 
-        aspeed_board_init_flashes(&bmc->soc->spi[0],
+        aspeed_board_init_flashes(OBJECT(bmc), &bmc->soc->spi[0],
                             bmc->spi_model ? bmc->spi_model : amc->spi_model,
                             amc->num_cs, amc->num_cs);
 
-        aspeed_board_init_flashes(&bmc->soc->spi[1],
+        aspeed_board_init_flashes(OBJECT(bmc), &bmc->soc->spi[1],
                             bmc->spi_model ? bmc->spi_model : amc->spi_model,
                             amc->num_cs, (amc->num_cs * 2));
     }
@@ -74,7 +74,8 @@ static void ast1030_evb_i2c_init(AspeedMachineState *bmc)
                           eeprom_buf);
 
     /* U11 LM75 connects to SDA/SCL Group 2 by default */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4d);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp105",
+                            aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4d);
 }
 
 static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
index 80f9c911b8..3ca52cc7a5 100644
--- a/hw/arm/aspeed_ast2400_palmetto.c
+++ b/hw/arm/aspeed_ast2400_palmetto.c
@@ -37,13 +37,15 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
      * The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing
      */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
+    i2c_slave_create_simple(OBJECT(bmc), "rtc",
+                            aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
 
     smbus_eeprom_init_one(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
 
     /* add a TMP423 temperature sensor */
-    dev = DEVICE(i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 2),
+    dev = DEVICE(i2c_slave_create_simple(OBJECT(bmc), "tmp423",
+                                         aspeed_i2c_get_bus(&soc->i2c, 2),
                                          "tmp423", 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
diff --git a/hw/arm/aspeed_ast2400_quanta-q71l.c b/hw/arm/aspeed_ast2400_quanta-q71l.c
index 802ae49604..cc358b9ecf 100644
--- a/hw/arm/aspeed_ast2400_quanta-q71l.c
+++ b/hw/arm/aspeed_ast2400_quanta-q71l.c
@@ -33,21 +33,27 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
      * The quanta-q71l platform expects tmp75s which are compatible with
      * tmp105s.
      */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4c);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4e);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4f);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4c);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4e);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp105[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4f);
 
     /* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */
     /* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */
     /* TODO: Add Memory Riser i2c mux and eeproms. */
 
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546", 0x74);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548", 0x77);
+    i2c_slave_create_simple(OBJECT(bmc), "i2c-mux[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546", 0x74);
+    i2c_slave_create_simple(OBJECT(bmc), "i2c-mux[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548", 0x77);
 
     /* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */
 
     /* i2c-7 */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546", 0x70);
+    i2c_slave_create_simple(OBJECT(bmc), "i2c-mux[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546", 0x70);
     /*        - i2c@0: pmbus@59 */
     /*        - i2c@1: pmbus@58 */
     /*        - i2c@2: pmbus@58 */
diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
index b18adf3981..cabeb951f9 100644
--- a/hw/arm/aspeed_ast2400_supermicrox11.c
+++ b/hw/arm/aspeed_ast2400_supermicrox11.c
@@ -37,13 +37,15 @@ static void supermicrox11_bmc_i2c_init(AspeedMachineState *bmc)
      * The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing
      */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
+    i2c_slave_create_simple(OBJECT(bmc), "rtc",
+                            aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
 
     smbus_eeprom_init_one(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
 
     /* add a TMP423 temperature sensor */
-    dev = DEVICE(i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 2),
+    dev = DEVICE(i2c_slave_create_simple(OBJECT(bmc), "tmp423",
+                                         aspeed_i2c_get_bus(&soc->i2c, 2),
                                          "tmp423", 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
diff --git a/hw/arm/aspeed_ast2500_evb.c b/hw/arm/aspeed_ast2500_evb.c
index ba8a56bafd..933ffa087a 100644
--- a/hw/arm/aspeed_ast2500_evb.c
+++ b/hw/arm/aspeed_ast2500_evb.c
@@ -34,8 +34,9 @@ static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
                           eeprom_buf);
 
     /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 7),
-                     TYPE_TMP105, 0x4d);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp105",
+                            aspeed_i2c_get_bus(&soc->i2c, 7),
+                            TYPE_TMP105, 0x4d);
 }
 
 static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast2500_g220a.c b/hw/arm/aspeed_ast2500_g220a.c
index 27c9dc436a..c7c3e3efd3 100644
--- a/hw/arm/aspeed_ast2500_g220a.c
+++ b/hw/arm/aspeed_ast2500_g220a.c
@@ -32,19 +32,22 @@ static void g220a_bmc_i2c_init(AspeedMachineState *bmc)
     AspeedSoCState *soc = bmc->soc;
     DeviceState *dev;
 
-    dev = DEVICE(i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 3),
+    dev = DEVICE(i2c_slave_create_simple(OBJECT(bmc), "emc1413[*]",
+                                         aspeed_i2c_get_bus(&soc->i2c, 3),
                                          "emc1413", 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
 
-    dev = DEVICE(i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 12),
+    dev = DEVICE(i2c_slave_create_simple(OBJECT(bmc), "emc1413[*]",
+                                         aspeed_i2c_get_bus(&soc->i2c, 12),
                                          "emc1413", 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
 
-    dev = DEVICE(i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 13),
+    dev = DEVICE(i2c_slave_create_simple(OBJECT(bmc), "emc1413[*]",
+                                         aspeed_i2c_get_bus(&soc->i2c, 13),
                                          "emc1413", 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
diff --git a/hw/arm/aspeed_ast2500_romulus.c b/hw/arm/aspeed_ast2500_romulus.c
index 1bbd2802f1..9abb69d6a1 100644
--- a/hw/arm/aspeed_ast2500_romulus.c
+++ b/hw/arm/aspeed_ast2500_romulus.c
@@ -30,7 +30,8 @@ static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
      * The romulus board expects Epson RX8900 I2C RTC but a ds1338 is
      * good enough
      */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
+    i2c_slave_create_simple(OBJECT(bmc), "rtc",
+                            aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
 }
 
 static void aspeed_machine_romulus_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
index bea459eeaa..f20b2d5efb 100644
--- a/hw/arm/aspeed_ast2500_supermicro-x11spi.c
+++ b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
@@ -33,13 +33,15 @@ static void supermicro_x11spi_bmc_i2c_init(AspeedMachineState *bmc)
      * The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing
      */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
+    i2c_slave_create_simple(OBJECT(bmc), "rtc",
+                            aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
 
     smbus_eeprom_init_one(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
 
     /* add a TMP423 temperature sensor */
-    dev = DEVICE(i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 2),
+    dev = DEVICE(i2c_slave_create_simple(OBJECT(bmc), "tmp423",
+                                         aspeed_i2c_get_bus(&soc->i2c, 2),
                                          "tmp423", 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
diff --git a/hw/arm/aspeed_ast2500_tiogapass.c b/hw/arm/aspeed_ast2500_tiogapass.c
index a6b3c0d051..13d1db9cfa 100644
--- a/hw/arm/aspeed_ast2500_tiogapass.c
+++ b/hw/arm/aspeed_ast2500_tiogapass.c
@@ -55,9 +55,12 @@ static void tiogapass_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 6), 0x54, 128 * KiB,
                           tiogapass_bmc_fruid, tiogapass_bmc_fruid_len);
     /* TMP421 */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 8), "tmp421", 0x1f);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", 0x4f);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", 0x4e);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp421[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 8), "tmp421", 0x1f);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp421[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", 0x4f);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp421[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", 0x4e);
 }
 
 static void aspeed_machine_tiogapass_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
index dda090ab60..2ba7ebb461 100644
--- a/hw/arm/aspeed_ast2500_witherspoon.c
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -44,11 +44,9 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
     LEDState *led;
 
     /* Bus 3: TODO bmp280@77 */
-    dev = DEVICE(i2c_slave_new_orphan(TYPE_PCA9552, 0x60));
+    dev = DEVICE(i2c_slave_new(OBJECT(bmc), "pca9552[*]", TYPE_PCA9552, 0x60));
     qdev_prop_set_string(dev, "description", "pca1");
-    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
-                                aspeed_i2c_get_bus(&soc->i2c, 3),
-                                &error_fatal);
+    qdev_realize(dev, BUS(aspeed_i2c_get_bus(&soc->i2c, 3)), &error_fatal);
 
     for (size_t i = 0; i < ARRAY_SIZE(pca1_leds); i++) {
         led = led_create_simple(OBJECT(bmc),
@@ -58,28 +56,32 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
         qdev_connect_gpio_out(dev, pca1_leds[i].gpio_id,
                               qdev_get_gpio_in(DEVICE(led), 0));
     }
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 3), "dps310", 0x76);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 3), "max31785", 0x52);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
+    i2c_slave_create_simple(OBJECT(bmc), "dps310",
+                            aspeed_i2c_get_bus(&soc->i2c, 3), "dps310", 0x76);
+    i2c_slave_create_simple(OBJECT(bmc), "max31785",
+                            aspeed_i2c_get_bus(&soc->i2c, 3), "max31785", 0x52);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp423[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp423[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
 
     /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
-                     0x4a);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp105",
+                            aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
+                            0x4a);
 
     /*
      * The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
      * good enough
      */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
+    i2c_slave_create_simple(OBJECT(bmc), "rtc",
+                            aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
 
     smbus_eeprom_init_one(OBJECT(bmc), aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
                           eeprom_buf);
-    dev = DEVICE(i2c_slave_new_orphan(TYPE_PCA9552, 0x60));
+    dev = DEVICE(i2c_slave_new(OBJECT(bmc), "pca9552[*]", TYPE_PCA9552, 0x60));
     qdev_prop_set_string(dev, "description", "pca0");
-    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
-                                aspeed_i2c_get_bus(&soc->i2c, 11),
-                                &error_fatal);
+    qdev_realize(dev, BUS(aspeed_i2c_get_bus(&soc->i2c, 11)), &error_fatal);
     /* Bus 11: TODO ucd90160@64 */
 }
 
diff --git a/hw/arm/aspeed_ast2500_yosemitev2.c b/hw/arm/aspeed_ast2500_yosemitev2.c
index 905758c345..4e3c19bc07 100644
--- a/hw/arm/aspeed_ast2500_yosemitev2.c
+++ b/hw/arm/aspeed_ast2500_yosemitev2.c
@@ -55,9 +55,12 @@ static void yosemitev2_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51, 128 * KiB,
                           yosemitev2_bmc_fruid, yosemitev2_bmc_fruid_len);
     /* TMP421 */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 11), "tmp421", 0x1f);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", 0x4e);
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", 0x4f);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp421[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 11), "tmp421", 0x1f);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp421[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", 0x4e);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp421[*]",
+                            aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", 0x4f);
 
 }
 
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
index 4930bddb39..58f0bc89bd 100644
--- a/hw/arm/aspeed_ast2600_bletchley.c
+++ b/hw/arm/aspeed_ast2600_bletchley.c
@@ -35,35 +35,44 @@ static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
     for (int i = 0; i < 6; i++) {
         /* Missing model: ti,ina230 @ 0x45 */
         /* Missing model: mps,mp5023 @ 0x40 */
-        i2c_slave_create_simple_orphan(i2c[i], TYPE_TMP421, 0x4f);
+        i2c_slave_create_simple(OBJECT(bmc), "tmp421[*]",
+                                i2c[i], TYPE_TMP421, 0x4f);
         /* Missing model: nxp,pca9539 @ 0x76, but PCA9552 works enough */
-        i2c_slave_create_simple_orphan(i2c[i], TYPE_PCA9552, 0x76);
-        i2c_slave_create_simple_orphan(i2c[i], TYPE_PCA9552, 0x67);
+        i2c_slave_create_simple(OBJECT(bmc), "pca9552[*]",
+                                i2c[i], TYPE_PCA9552, 0x76);
+        i2c_slave_create_simple(OBJECT(bmc), "pca9552[*]",
+                                i2c[i], TYPE_PCA9552, 0x67);
         /* Missing model: fsc,fusb302 @ 0x22 */
     }
 
     /* Bus 6 */
     at24c_eeprom_init(i2c[6], 0x56, 65536);
     /* Missing model: nxp,pcf85263 @ 0x51 , but ds1338 works enough */
-    i2c_slave_create_simple_orphan(i2c[6], "ds1338", 0x51);
+    i2c_slave_create_simple(OBJECT(bmc), "rtc", i2c[6], "ds1338", 0x51);
 
 
     /* Bus 7 */
     at24c_eeprom_init(i2c[7], 0x54, 65536);
 
     /* Bus 9 */
-    i2c_slave_create_simple_orphan(i2c[9], TYPE_TMP421, 0x4f);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp421[*]",
+                            i2c[9], TYPE_TMP421, 0x4f);
 
     /* Bus 10 */
-    i2c_slave_create_simple_orphan(i2c[10], TYPE_TMP421, 0x4f);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp421[*]",
+                            i2c[10], TYPE_TMP421, 0x4f);
     /* Missing model: ti,hdc1080 @ 0x40 */
-    i2c_slave_create_simple_orphan(i2c[10], TYPE_PCA9552, 0x67);
+    i2c_slave_create_simple(OBJECT(bmc), "pca9552[*]",
+                            i2c[10], TYPE_PCA9552, 0x67);
 
     /* Bus 12 */
     /* Missing model: adi,adm1278 @ 0x11 */
-    i2c_slave_create_simple_orphan(i2c[12], TYPE_TMP421, 0x4c);
-    i2c_slave_create_simple_orphan(i2c[12], TYPE_TMP421, 0x4d);
-    i2c_slave_create_simple_orphan(i2c[12], TYPE_PCA9552, 0x67);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp421[*]",
+                            i2c[12], TYPE_TMP421, 0x4c);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp421[*]",
+                            i2c[12], TYPE_TMP421, 0x4d);
+    i2c_slave_create_simple(OBJECT(bmc), "pca9552[*]",
+                            i2c[12], TYPE_PCA9552, 0x67);
 }
 
 static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast2600_evb.c b/hw/arm/aspeed_ast2600_evb.c
index ab7667da75..8e389dbe80 100644
--- a/hw/arm/aspeed_ast2600_evb.c
+++ b/hw/arm/aspeed_ast2600_evb.c
@@ -27,8 +27,9 @@ static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
                           eeprom_buf);
 
     /* LM75 is compatible with TMP105 driver */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 8),
-                     TYPE_TMP105, 0x4d);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp105",
+                            aspeed_i2c_get_bus(&soc->i2c, 8),
+                            TYPE_TMP105, 0x4d);
 }
 
 static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast2600_fby35.c b/hw/arm/aspeed_ast2600_fby35.c
index fcd1acdc17..dedc273ee3 100644
--- a/hw/arm/aspeed_ast2600_fby35.c
+++ b/hw/arm/aspeed_ast2600_fby35.c
@@ -102,12 +102,12 @@ static void fby35_i2c_init(AspeedMachineState *bmc)
         i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
     }
 
-    i2c_slave_create_simple_orphan(i2c[2], TYPE_LM75, 0x4f);
-    i2c_slave_create_simple_orphan(i2c[8], TYPE_TMP421, 0x1f);
+    i2c_slave_create_simple(OBJECT(bmc), "lm75[*]", i2c[2], TYPE_LM75, 0x4f);
+    i2c_slave_create_simple(OBJECT(bmc), "tmp421", i2c[8], TYPE_TMP421, 0x1f);
     /* Hotswap controller is actually supposed to be mp5920 or ltc4282. */
-    i2c_slave_create_simple_orphan(i2c[11], "adm1272", 0x44);
-    i2c_slave_create_simple_orphan(i2c[12], TYPE_LM75, 0x4e);
-    i2c_slave_create_simple_orphan(i2c[12], TYPE_LM75, 0x4f);
+    i2c_slave_create_simple(OBJECT(bmc), "adm1272", i2c[11], "adm1272", 0x44);
+    i2c_slave_create_simple(OBJECT(bmc), "lm75[*]", i2c[12], TYPE_LM75, 0x4e);
+    i2c_slave_create_simple(OBJECT(bmc), "lm75[*]", i2c[12], TYPE_LM75, 0x4f);
 
     at24c_eeprom_init(i2c[4], 0x51, 128 * KiB);
     at24c_eeprom_init(i2c[6], 0x51, 128 * KiB);
diff --git a/hw/arm/aspeed_ast2600_gb200nvl.c b/hw/arm/aspeed_ast2600_gb200nvl.c
index 2c1c513674..1cf35f96bd 100644
--- a/hw/arm/aspeed_ast2600_gb200nvl.c
+++ b/hw/arm/aspeed_ast2600_gb200nvl.c
@@ -51,23 +51,23 @@ static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
     }
 
     /* Bus 5 Expander */
-    aspeed_create_pca9554(soc, 4, 0x21);
+    aspeed_create_pca9554(OBJECT(bmc), soc, 4, 0x21);
 
     /* Mux I2c Expanders */
-    i2c_slave_create_simple_orphan(i2c[5], "pca9546", 0x71);
-    i2c_slave_create_simple_orphan(i2c[5], "pca9546", 0x72);
-    i2c_slave_create_simple_orphan(i2c[5], "pca9546", 0x73);
-    i2c_slave_create_simple_orphan(i2c[5], "pca9546", 0x75);
-    i2c_slave_create_simple_orphan(i2c[5], "pca9546", 0x76);
-    i2c_slave_create_simple_orphan(i2c[5], "pca9546", 0x77);
+    i2c_slave_create_simple(OBJECT(bmc), "i2c-mux[*]", i2c[5], "pca9546", 0x71);
+    i2c_slave_create_simple(OBJECT(bmc), "i2c-mux[*]", i2c[5], "pca9546", 0x72);
+    i2c_slave_create_simple(OBJECT(bmc), "i2c-mux[*]", i2c[5], "pca9546", 0x73);
+    i2c_slave_create_simple(OBJECT(bmc), "i2c-mux[*]", i2c[5], "pca9546", 0x75);
+    i2c_slave_create_simple(OBJECT(bmc), "i2c-mux[*]", i2c[5], "pca9546", 0x76);
+    i2c_slave_create_simple(OBJECT(bmc), "i2c-mux[*]", i2c[5], "pca9546", 0x77);
 
     /* Bus 10 */
-    dev = DEVICE(aspeed_create_pca9554(soc, 9, 0x20));
+    dev = DEVICE(aspeed_create_pca9554(OBJECT(bmc), soc, 9, 0x20));
 
     /* Set FPGA_READY */
     object_property_set_str(OBJECT(dev), "pin1", "high", &error_fatal);
 
-    aspeed_create_pca9554(soc, 9, 0x21);
+    aspeed_create_pca9554(OBJECT(bmc), soc, 9, 0x21);
     at24c_eeprom_init(i2c[9], 0x50, 64 * KiB);
     at24c_eeprom_init(i2c[9], 0x51, 64 * KiB);
 
diff --git a/hw/arm/aspeed_ast2600_rainier.c b/hw/arm/aspeed_ast2600_rainier.c
index 0495c2880c..8ba15aceca 100644
--- a/hw/arm/aspeed_ast2600_rainier.c
+++ b/hw/arm/aspeed_ast2600_rainier.c
@@ -70,7 +70,7 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
 
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 0), 0x51, 32 * KiB);
 
-    aspeed_create_pca9552(soc, 3, 0x61);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 3, 0x61);
 
     /* The rainier expects a TMP275 but a TMP105 is compatible */
     i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
@@ -84,14 +84,14 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x52, 64 * KiB);
-    aspeed_create_pca9552(soc, 4, 0x60);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 4, 0x60);
 
     i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
                      0x48);
     i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
                      0x49);
-    aspeed_create_pca9552(soc, 5, 0x60);
-    aspeed_create_pca9552(soc, 5, 0x61);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 5, 0x60);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 5, 0x61);
     i2c_mux = i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 5),
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
@@ -110,12 +110,12 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 3), 0x51, 64 * KiB);
 
-    aspeed_create_pca9552(soc, 7, 0x30);
-    aspeed_create_pca9552(soc, 7, 0x31);
-    aspeed_create_pca9552(soc, 7, 0x32);
-    aspeed_create_pca9552(soc, 7, 0x33);
-    aspeed_create_pca9552(soc, 7, 0x60);
-    aspeed_create_pca9552(soc, 7, 0x61);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 7, 0x30);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 7, 0x31);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 7, 0x32);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 7, 0x33);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 7, 0x60);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 7, 0x61);
     i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 7), "dps310", 0x76);
     /* Bus 7: TODO si7021-a20@20 */
     i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 7), TYPE_TMP105,
@@ -132,8 +132,8 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
                           64 * KiB, rainier_bb_fruid, rainier_bb_fruid_len);
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51,
                           64 * KiB, rainier_bmc_fruid, rainier_bmc_fruid_len);
-    aspeed_create_pca9552(soc, 8, 0x60);
-    aspeed_create_pca9552(soc, 8, 0x61);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 8, 0x60);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 8, 0x61);
     /* Bus 8: ucd90320@11 */
     /* Bus 8: ucd90320@b */
     /* Bus 8: ucd90320@c */
@@ -154,17 +154,17 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
                                       "pca9546", 0x70);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
     at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
-    aspeed_create_pca9552(soc, 11, 0x60);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 11, 0x60);
 
 
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 13), 0x50, 64 * KiB);
-    aspeed_create_pca9552(soc, 13, 0x60);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 13, 0x60);
 
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 14), 0x50, 64 * KiB);
-    aspeed_create_pca9552(soc, 14, 0x60);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 14, 0x60);
 
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 15), 0x50, 64 * KiB);
-    aspeed_create_pca9552(soc, 15, 0x60);
+    aspeed_create_pca9552(OBJECT(bmc), soc, 15, 0x60);
 }
 
 static void aspeed_machine_rainier_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index f21c842315..74626973bc 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -109,10 +109,13 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
     /*
      * AST2700 EVB has a LM75 temperature sensor on I2C bus 0 at address 0x4d.
      */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 0), "tmp105", 0x4d);
+    i2c_slave_create_simple(OBJECT(machine), "tmp105",
+                            aspeed_i2c_get_bus(&soc->i2c, 0), "tmp105", 0x4d);
 
-    aspeed_board_init_flashes(&soc->fmc, AST2700FC_FMC_MODEL, 2, 0);
-    aspeed_board_init_flashes(&soc->spi[0], AST2700FC_SPI_MODEL, 1, 2);
+    aspeed_board_init_flashes(OBJECT(machine), &soc->fmc,
+                              AST2700FC_FMC_MODEL, 2, 0);
+    aspeed_board_init_flashes(OBJECT(machine), &soc->spi[0],
+                              AST2700FC_SPI_MODEL, 1, 2);
 
     ast2700fc_board_info.ram_size = machine->ram_size;
     ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index a59714372d..1892a59cce 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -24,7 +24,8 @@ static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
     AspeedSoCState *soc = bmc->soc;
 
     /* LM75 is compatible with TMP105 driver */
-    i2c_slave_create_simple_orphan(aspeed_i2c_get_bus(&soc->i2c, 0),
+    i2c_slave_create_simple(OBJECT(bmc), "tmp105",
+                            aspeed_i2c_get_bus(&soc->i2c, 0),
                             TYPE_TMP105, 0x4d);
 }
 
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 33f7f10531..780a9659cc 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -81,11 +81,12 @@ bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp)
      * SoC has.
      */
     if (ram_size < max_ram_size) {
-        DeviceState *dev = qdev_new_orphan(TYPE_UNIMPLEMENTED_DEVICE);
+        DeviceState *dev = qdev_new(OBJECT(s), "ram-empty",
+                                    TYPE_UNIMPLEMENTED_DEVICE);
 
         qdev_prop_set_string(dev, "name", "ram-empty");
         qdev_prop_set_uint64(dev, "size", max_ram_size  - ram_size);
-        if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp)) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(dev), errp)) {
             return false;
         }
 
@@ -115,7 +116,8 @@ void aspeed_mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
                                         sysbus_mmio_get_region(dev, 0), -1000);
 }
 
-void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
+void aspeed_board_init_flashes(Object *parent, AspeedSMCState *s,
+                               const char *flashtype,
                                unsigned int count, int unit0)
 {
     int i;
@@ -128,12 +130,12 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
         DriveInfo *dinfo = drive_get(IF_MTD, 0, unit0 + i);
         DeviceState *dev;
 
-        dev = qdev_new_orphan(flashtype);
+        dev = qdev_new(parent, "flash[*]", flashtype);
         if (dinfo) {
             qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
         }
         qdev_prop_set_uint8(dev, "cs", i);
-        qdev_realize_and_unref(dev, BUS(s->spi), &error_fatal);
+        qdev_realize(dev, BUS(s->spi), &error_fatal);
     }
 }
 
diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index e1c0323cb6..743f7282ae 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -83,9 +83,10 @@ void aspeed_machine_class_init_cpus_defaults(MachineClass *mc);
  *
  * Create and attach a PCA9552 LED controller device to the specified I2C bus
  * of the given Aspeed SoC. The device is instantiated using
- * i2c_slave_create_simple_orphan() with the PCA9552 device type.
+ * i2c_slave_create_simple() with the PCA9552 device type.
  */
-void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr);
+void aspeed_create_pca9552(Object *parent, AspeedSoCState *soc, int bus_id,
+                           int addr);
 
 /*
  * aspeed_create_pca9554:
@@ -95,11 +96,12 @@ void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr);
  *
  * Create and attach a PCA9554 I/O expander to the specified I2C bus
  * of the given Aspeed SoC. The device is created via
- * i2c_slave_create_simple_orphan() and returned as an #I2CSlave pointer.
+ * i2c_slave_create_simple() and returned as an #I2CSlave pointer.
  *
  * Returns: a pointer to the newly created #I2CSlave instance.
  */
-I2CSlave *aspeed_create_pca9554(AspeedSoCState *soc, int bus_id, int addr);
+I2CSlave *aspeed_create_pca9554(Object *parent, AspeedSoCState *soc,
+                                int bus_id, int addr);
 
 /*
  * aspeed_machine_ast2600_class_emmc_init:
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 41dc04e293..d1ad82e00a 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -311,7 +311,8 @@ void aspeed_mmio_map(MemoryRegion *memory, SysBusDevice *dev, int n,
 void aspeed_mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
                                    const char *name, hwaddr addr,
                                    uint64_t size);
-void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
+void aspeed_board_init_flashes(Object *parent, AspeedSMCState *s,
+                               const char *flashtype,
                                unsigned int count, int unit0);
 void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
                            Error **errp);
-- 
2.47.1


