Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087E0C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigY1-0000UQ-5P; Sat, 11 Jul 2026 18:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigXs-0000Tp-I7; Sat, 11 Jul 2026 18:51:41 -0400
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.34.181.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigXn-0008OI-8f; Sat, 11 Jul 2026 18:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810295; x=1815346295;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F9UC45a59mdr+HSqM/ygBu9/t6DWDgy9PvcLPT5vSGk=;
 b=TcYsPavCm2k7Kf4RQezjAgA/erp3z1qNaIR7WBGKtaJN6GIxX3ZjE2f0
 TnuctO3g9hLSm4Wxf9gKO2IB9jEaRMHPaw0rSck5PtZW3T7nxy25DjNaN
 /vhosYsj/3yU8Xrd8mRjuNd1zhRpibUheiXXj/UZi1PSdgLWWLNqqC2pu
 GE4acDptL4VVEhsXdxl3Sw6AGGl9eztE1KUSWW5Wni996fsb2W3+GuJS+
 iLn9iAvPK8fq8zyGbpzThw+XBhTMNsG8giU49+mqM3JG0zUEfN+lPKzlk
 OpfLRlLeWvD26iADJBIr4oATa6wPmx659LQnIre2VG/x61FYHpcK+KPC/ w==;
X-CSE-ConnectionGUID: rUpUBYYUQz6MhQrviiSpEA==
X-CSE-MsgGUID: SKu5t2PDQzWHywtmimvCbg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23483434"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:51:31 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:24016]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.115:2525]
 with esmtp (Farcaster)
 id 3132f497-f131-48fc-894b-d8f2ab41e78f; Sat, 11 Jul 2026 22:51:31 +0000 (UTC)
X-Farcaster-Flow-ID: 3132f497-f131-48fc-894b-d8f2ab41e78f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:51:30 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:51:21 +0000
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
Subject: [RFC PATCH 054/134] hw/ppc: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:47 +0000
Message-ID: <20260711223707.42139-55-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.34.181.151;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/ppc to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

pnv_bmc_create() and spapr_vio_bus_init() gain an Object *parent
first argument; the callers are updated in this patch.

Per-site rationale (reviewers: dispute the modeling here):

file:line | creator | parent | name | rationale
hw/ppc/amigaone.c:282 | cpu_create | OBJECT(machine) | "cpu" | board init, single CPU
hw/ppc/amigaone.c:305 | qdev_new | OBJECT(machine) | "nvram" | board init
hw/ppc/amigaone.c:332 | sysbus_create_simple | OBJECT(machine) | "articia" | board init, north bridge
hw/ppc/amigaone.c:358 | pci_create_simple_multifunction | OBJECT(machine) | "via" | board init, south bridge
hw/ppc/e500.c:818 | qdev_new | OBJECT(machine) | "pic" | collapse existing add_child; helper receives PPCE500MachineState
hw/ppc/e500.c:843 | qdev_new | parent | "pic" | thread Object *parent into ppce500_init_mpic_kvm(); drop object_unparent on error
hw/ppc/e500.c:996 | qdev_new | OBJECT(machine) | "e500-ccsr" | collapse existing add_child, keep name
hw/ppc/e500.c:1021 | qdev_new | OBJECT(machine) | "i2c" | board init
hw/ppc/e500.c:1028 | i2c_slave_create_simple | OBJECT(machine) | "rtc" | board init, DS1338 RTC
hw/ppc/e500.c:1032 | qdev_new | OBJECT(machine) | "esdhc-stub" | board init, unimplemented placeholder
hw/ppc/e500.c:1040 | qdev_new | OBJECT(machine) | "esdhc" | board init
hw/ppc/e500.c:1049 | qdev_new | OBJECT(machine) | "guts" | board init
hw/ppc/e500.c:1056 | qdev_new | OBJECT(machine) | "pci-host" | collapse existing add_child, keep name
hw/ppc/e500.c:1079 | sysbus_create_simple | OBJECT(machine) | "spin" | board init
hw/ppc/e500.c:1084 | qdev_new | OBJECT(machine) | "gpio" | board init
hw/ppc/e500.c:1097 | qdev_new | OBJECT(machine) | "platform-bus" | board init
hw/ppc/e500.c:1139 | qdev_new | OBJECT(machine) | "flash" | board init
hw/ppc/mac_newworld.c:162 | cpu_create | OBJECT(machine) | "cpu[*]" | board init, SMP loop
hw/ppc/mac_newworld.c:289 | qdev_new | OBJECT(machine) | "uni-n" | board init, UniNorth main
hw/ppc/mac_newworld.c:298 | qdev_new | OBJECT(machine) | "u3-agp" | board init, U3 AGP host
hw/ppc/mac_newworld.c:313 | qdev_new | OBJECT(machine) | "uni-n-agp" | board init
hw/ppc/mac_newworld.c:320 | qdev_new | OBJECT(machine) | "uni-n-internal" | board init
hw/ppc/mac_newworld.c:328 | qdev_new | OBJECT(machine) | "uni-n-pci" | board init
hw/ppc/mac_newworld.c:351 | pci_new | OBJECT(machine) | "macio" | board init
hw/ppc/mac_newworld.c:411 | qdev_new | OBJECT(machine) | "adb-keyboard" | board init
hw/ppc/mac_newworld.c:414 | qdev_new | OBJECT(machine) | "adb-mouse" | board init
hw/ppc/mac_newworld.c:419 | pci_create_simple | OBJECT(machine) | "ohci" | board init
hw/ppc/mac_newworld.c:428 | usb_create_simple | OBJECT(machine) | "usb-kbd" | board init
hw/ppc/mac_newworld.c:429 | usb_create_simple | OBJECT(machine) | "usb-mouse" | board init
hw/ppc/mac_newworld.c:456 | qdev_new | OBJECT(machine) | "nvram" | board init
hw/ppc/mac_newworld.c:465 | qdev_new | OBJECT(machine) | TYPE_FW_CFG | collapse existing add_child, keep name
hw/ppc/mac_oldworld.c:114 | cpu_create | OBJECT(machine) | "cpu[*]" | board init, SMP loop
hw/ppc/mac_oldworld.c:215 | qdev_new | OBJECT(machine) | "grackle" | board init
hw/ppc/mac_oldworld.c:232 | pci_new | OBJECT(machine) | "macio" | board init
hw/ppc/mac_oldworld.c:282 | qdev_new | OBJECT(machine) | "adb-keyboard" | board init
hw/ppc/mac_oldworld.c:284 | qdev_new | OBJECT(machine) | "adb-mouse" | board init
hw/ppc/mac_oldworld.c:288 | pci_create_simple | OBJECT(machine) | "ohci" | board init
hw/ppc/mac_oldworld.c:306 | qdev_new | OBJECT(machine) | TYPE_FW_CFG | collapse existing add_child, keep name
hw/ppc/pegasos.c:166 | cpu_create | OBJECT(machine) | "cpu" | board init, single CPU
hw/ppc/pegasos.c:221 | sysbus_create_simple | OBJECT(machine) | "articia" | board init, north bridge (Pegasos1 branch)
hw/ppc/pegasos.c:236 | sysbus_create_simple | OBJECT(machine) | "mv64361" | board init, north bridge (Pegasos2 branch)
hw/ppc/pegasos.c:244 | pci_new_multifunction | OBJECT(machine) | "via" | board init, south bridge
hw/ppc/pnv.c:1013 | isa_new | parent | "ipmi-bt" | thread Object *parent into pnv_ipmi_bt_init()
hw/ppc/pnv.c:1130 | qdev_new | OBJECT(machine) | "pnor" | board init
hw/ppc/pnv.c:1272 | qdev_new | OBJECT(pnv) | chip_name | collapse existing add_child; move snprintf before create
hw/ppc/pnv.c:2828 | i2c_slave_create_simple | OBJECT(pnv) | "pca9552[*]" | pnv_rainier_i2c_init receives PnvMachineState; per-chip loop
hw/ppc/pnv.c:2846 | i2c_slave_create_simple | OBJECT(pnv) | "pca9554[*]" | pnv_rainier_i2c_init receives PnvMachineState; per-chip loop
hw/ppc/pnv_bmc.c:302 | qdev_new | parent | "bmc" | thread Object *parent into pnv_bmc_create() (+ header, caller)
hw/ppc/ppc440_bamboo.c:151 | cpu_create | OBJECT(machine) | "cpu" | board init, single CPU
hw/ppc/ppc440_bamboo.c:165 | qdev_new | OBJECT(machine) | "uic" | board init; drop object_unref
hw/ppc/ppc440_bamboo.c:175 | qdev_new | OBJECT(machine) | "sdram" | board init; drop object_unref
hw/ppc/ppc440_bamboo.c:186 | sysbus_create_varargs | OBJECT(machine) | "pci-host" | board init
hw/ppc/prep.c:260 | cpu_create | OBJECT(machine) | "cpu" | board init, single CPU
hw/ppc/prep.c:292 | qdev_new | OBJECT(machine) | "raven" | collapse existing add_child(qdev_get_machine())
hw/ppc/prep.c:303 | pci_new | OBJECT(machine) | "i82378" | board init, ISA bridge
hw/ppc/prep.c:312 | isa_new | OBJECT(machine) | "systemio" | board init
hw/ppc/prep.c:319 | isa_new | OBJECT(machine) | "mc" | board init, memory controller
hw/ppc/prep.c:325 | isa_new | OBJECT(machine) | "rtc" | board init
hw/ppc/prep.c:337 | isa_create_simple | OBJECT(machine) | "m48t59" | board init
hw/ppc/prep.c:339 | isa_new | OBJECT(machine) | "cs4231a" | board init, audio
hw/ppc/prep.c:348 | isa_new | OBJECT(machine) | "pc87312" | board init, superio
hw/ppc/prep.c:353 | pci_create_simple | OBJECT(machine) | "scsi" | board init, LSI SCSI
hw/ppc/prep.c:366 | qdev_new | OBJECT(machine) | TYPE_FW_CFG | collapse existing add_child, keep name
hw/ppc/sam460ex.c:264 | cpu_create | OBJECT(machine) | "cpu" | board init, single CPU
hw/ppc/sam460ex.c:279 | qdev_new | OBJECT(machine) | "plb" | board init; drop object_unref
hw/ppc/sam460ex.c:295 | qdev_new | OBJECT(machine) | "uic[*]" | board init loop; drop object_unref
hw/ppc/sam460ex.c:325 | qdev_new | OBJECT(machine) | "sdram" | board init; drop object_unref
hw/ppc/sam460ex.c:340 | sysbus_create_simple | OBJECT(machine) | "i2c[*]" | board init, first IIC
hw/ppc/sam460ex.c:349 | i2c_slave_create_simple | OBJECT(machine) | "rtc" | board init, M41T80 RTC
hw/ppc/sam460ex.c:351 | sysbus_create_simple | OBJECT(machine) | "i2c[*]" | board init, second IIC
hw/ppc/sam460ex.c:355 | qdev_new | OBJECT(machine) | "ebc" | board init; drop object_unref
hw/ppc/sam460ex.c:369 | qdev_new | OBJECT(machine) | "mal" | board init; drop object_unref
hw/ppc/sam460ex.c:391 | sysbus_create_simple | OBJECT(machine) | "ehci" | board init
hw/ppc/sam460ex.c:393 | qdev_new | OBJECT(machine) | "ohci" | board init
hw/ppc/sam460ex.c:402 | usb_create_simple | OBJECT(machine) | "usb-kbd" | board init
hw/ppc/sam460ex.c:403 | usb_create_simple | OBJECT(machine) | "usb-mouse" | board init
hw/ppc/sam460ex.c:406 | qdev_new | OBJECT(machine) | "pcie-host[*]" | board init, first PCIe
hw/ppc/sam460ex.c:412 | qdev_new | OBJECT(machine) | "pcie-host[*]" | board init, second PCIe
hw/ppc/sam460ex.c:420 | sysbus_create_simple | OBJECT(machine) | "pcix-host" | board init
hw/ppc/sam460ex.c:426 | pci_create_simple | OBJECT(machine) | "sm501" | board init, display
hw/ppc/sam460ex.c:433 | pci_create_simple | OBJECT(machine) | "sata" | board init, SiI3112 SATA
hw/ppc/spapr.c:1888 | qdev_new | OBJECT(spapr) | "nvram" | helper receives SpaprMachineState
hw/ppc/spapr.c:2802 | qdev_new | parent | "phb[*]" | thread Object *parent into spapr_create_default_phb()
hw/ppc/spapr.c:3078 | pci_create_simple | OBJECT(machine) | "xhci" | board init
hw/ppc/spapr.c:3085 | usb_create_simple | OBJECT(machine) | "usb-kbd" | board init
hw/ppc/spapr.c:3086 | usb_create_simple | OBJECT(machine) | "usb-mouse" | board init
hw/ppc/spapr_irq.c:315 | qdev_new | OBJECT(spapr) | "xive" | spapr_irq_init receives SpaprMachineState
hw/ppc/spapr_vio.c:567 | qdev_new | parent | "vio-bridge" | thread Object *parent into spapr_vio_bus_init() (+ header, caller)
hw/ppc/virtex_ml507.c:79 | cpu_create | parent | "cpu" | thread Object *parent into ppc440_init_xilinx()
hw/ppc/virtex_ml507.c:87 | qdev_new | parent | "uic" | ppc440_init_xilinx(); drop object_unref
hw/ppc/virtex_ml507.c:221 | qdev_new | OBJECT(machine) | "intc" | board init
hw/ppc/virtex_ml507.c:236 | qdev_new | OBJECT(machine) | "timer" | board init

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/ppc/amigaone.c          | 12 ++++----
 hw/ppc/e500.c              | 58 +++++++++++++++++++-------------------
 hw/ppc/mac_newworld.c      | 54 +++++++++++++++++++----------------
 hw/ppc/mac_oldworld.c      | 28 +++++++++---------
 hw/ppc/pegasos.c           | 13 +++++----
 hw/ppc/pnv.c               | 29 ++++++++++---------
 hw/ppc/pnv_bmc.c           |  4 +--
 hw/ppc/ppc440_bamboo.c     | 11 ++++----
 hw/ppc/prep.c              | 44 ++++++++++++++---------------
 hw/ppc/sam460ex.c          | 55 +++++++++++++++++-------------------
 hw/ppc/spapr.c             | 21 +++++++-------
 hw/ppc/spapr_irq.c         |  4 +--
 hw/ppc/spapr_vio.c         |  6 ++--
 hw/ppc/virtex_ml507.c      | 18 ++++++------
 include/hw/ppc/pnv.h       |  2 +-
 include/hw/ppc/spapr_vio.h |  2 +-
 16 files changed, 186 insertions(+), 175 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 866e5547d6..faf76f12be 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -279,7 +279,7 @@ static void amigaone_init(MachineState *machine)
     struct boot_info *bi = NULL;
 
     /* init CPU */
-    cpu = POWERPC_CPU(cpu_create_orphan(machine->cpu_type));
+    cpu = POWERPC_CPU(cpu_create(OBJECT(machine), "cpu", machine->cpu_type));
     env = &cpu->env;
     if (PPC_INPUT(env) != PPC_FLAGS_INPUT_6xx) {
         error_report("Incompatible CPU, only 6xx bus supported");
@@ -302,12 +302,12 @@ static void amigaone_init(MachineState *machine)
     }
 
     /* nvram */
-    dev = qdev_new_orphan(TYPE_A1_NVRAM);
+    dev = qdev_new(OBJECT(machine), "nvram", TYPE_A1_NVRAM);
     di = drive_get(IF_MTD, 0, 0);
     if (di) {
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di));
     }
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     memory_region_add_subregion(get_system_memory(), NVRAM_ADDR,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
@@ -329,7 +329,8 @@ static void amigaone_init(MachineState *machine)
     }
 
     /* Articia S */
-    dev = sysbus_create_simple_orphan(TYPE_ARTICIA, ARTICIA_ADDR, NULL);
+    dev = sysbus_create_simple(OBJECT(machine), "articia", TYPE_ARTICIA,
+                               ARTICIA_ADDR, NULL);
 
     i2c_bus = I2C_BUS(qdev_get_child_bus(dev, "smbus"));
     if (machine->ram_size > 512 * MiB) {
@@ -355,7 +356,8 @@ static void amigaone_init(MachineState *machine)
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
 
     /* VIA VT82c686B South Bridge (multifunction PCI device) */
-    via = OBJECT(pci_create_simple_multifunction_orphan(pci_bus, PCI_DEVFN(7, 0),
+    via = OBJECT(pci_create_simple_multifunction(OBJECT(machine), "via",
+                                                 pci_bus, PCI_DEVFN(7, 0),
                                                  TYPE_VT82C686B_ISA));
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(via, "rtc"),
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index f7a7c136da..21e656e87f 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -815,13 +815,12 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
     unsigned int smp_cpus = machine->smp.cpus;
     const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(pms);
 
-    dev = qdev_new_orphan(TYPE_OPENPIC);
-    object_property_add_child(OBJECT(machine), "pic", OBJECT(dev));
+    dev = qdev_new(OBJECT(machine), "pic", TYPE_OPENPIC);
     qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
     qdev_prop_set_uint32(dev, "nb_cpus", smp_cpus);
 
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
 
     k = 0;
     for (i = 0; i < smp_cpus; i++) {
@@ -833,17 +832,18 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
     return dev;
 }
 
-static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
+static DeviceState *ppce500_init_mpic_kvm(Object *parent,
+                                          const PPCE500MachineClass *pmc,
                                           Error **errp)
 {
 #ifdef CONFIG_KVM
     DeviceState *dev;
     CPUState *cs;
 
-    dev = qdev_new_orphan(TYPE_KVM_OPENPIC);
+    dev = qdev_new(parent, "pic", TYPE_KVM_OPENPIC);
     qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
 
-    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp)) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(dev), errp)) {
         object_unparent(OBJECT(dev));
         return NULL;
     }
@@ -874,7 +874,7 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
         Error *err = NULL;
 
         if (kvm_kernel_irqchip_allowed()) {
-            dev = ppce500_init_mpic_kvm(pmc, &err);
+            dev = ppce500_init_mpic_kvm(OBJECT(pms), pmc, &err);
         }
         if (kvm_kernel_irqchip_required() && !dev) {
             error_reportf_err(err,
@@ -993,10 +993,9 @@ void ppce500_init(MachineState *machine)
     /* Register Memory */
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
-    dev = qdev_new_orphan("e500-ccsr");
+    dev = qdev_new(OBJECT(machine), "e500-ccsr", "e500-ccsr");
     s = SYS_BUS_DEVICE(dev);
-    object_property_add_child(OBJECT(machine), "e500-ccsr", OBJECT(dev));
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     ccsr_addr_space = sysbus_mmio_get_region(s, 0);
     memory_region_add_subregion(address_space_mem, pmc->ccsrbar_base,
                                 ccsr_addr_space);
@@ -1018,47 +1017,47 @@ void ppce500_init(MachineState *machine)
     }
 
     /* I2C */
-    dev = qdev_new_orphan("mpc-i2c");
+    dev = qdev_new(OBJECT(machine), "i2c", "mpc-i2c");
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC8544_I2C_IRQ));
     memory_region_add_subregion(ccsr_addr_space, MPC8544_I2C_REGS_OFFSET,
                                 sysbus_mmio_get_region(s, 0));
     i2c = I2C_BUS(qdev_get_child_bus(dev, "i2c"));
-    i2c_slave_create_simple_orphan(i2c, "ds1338", RTC_REGS_OFFSET);
+    i2c_slave_create_simple(OBJECT(machine), "rtc", i2c, "ds1338",
+                            RTC_REGS_OFFSET);
 
     /* eSDHC */
     if (pmc->has_esdhc) {
-        dev = qdev_new_orphan(TYPE_UNIMPLEMENTED_DEVICE);
+        dev = qdev_new(OBJECT(machine), "esdhc-stub", TYPE_UNIMPLEMENTED_DEVICE);
         qdev_prop_set_string(dev, "name", "esdhc");
         qdev_prop_set_uint64(dev, "size", MPC85XX_ESDHC_REGS_SIZE);
         s = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(s, &error_fatal);
+        sysbus_realize(s, &error_fatal);
         memory_region_add_subregion(ccsr_addr_space, MPC85XX_ESDHC_REGS_OFFSET,
                                     sysbus_mmio_get_region(s, 0));
 
-        dev = qdev_new_orphan(TYPE_FSL_ESDHC_BE);
+        dev = qdev_new(OBJECT(machine), "esdhc", TYPE_FSL_ESDHC_BE);
         s = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(s, &error_fatal);
+        sysbus_realize(s, &error_fatal);
         sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC85XX_ESDHC_IRQ));
         memory_region_add_subregion(ccsr_addr_space, MPC85XX_ESDHC_REGS_OFFSET,
                                     sysbus_mmio_get_region(s, 0));
     }
 
     /* General Utility device */
-    dev = qdev_new_orphan("mpc8544-guts");
+    dev = qdev_new(OBJECT(machine), "guts", "mpc8544-guts");
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     memory_region_add_subregion(ccsr_addr_space, MPC8544_UTIL_OFFSET,
                                 sysbus_mmio_get_region(s, 0));
 
     /* PCI */
-    dev = qdev_new_orphan("e500-pcihost");
-    object_property_add_child(OBJECT(machine), "pci-host", OBJECT(dev));
+    dev = qdev_new(OBJECT(machine), "pci-host", "e500-pcihost");
     qdev_prop_set_uint32(dev, "first_slot", pmc->pci_first_slot);
     qdev_prop_set_uint32(dev, "first_pin_irq", pci_irq_nrs[0]);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     for (i = 0; i < PCI_NUM_PINS; i++) {
         sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, pci_irq_nrs[i]));
     }
@@ -1076,14 +1075,15 @@ void ppce500_init(MachineState *machine)
     }
 
     /* Register spinning region */
-    sysbus_create_simple_orphan("e500-spin", pmc->spin_base, NULL);
+    sysbus_create_simple(OBJECT(machine), "spin", "e500-spin",
+                         pmc->spin_base, NULL);
 
     if (pmc->has_mpc8xxx_gpio) {
         qemu_irq poweroff_irq;
 
-        dev = qdev_new_orphan("mpc8xxx_gpio");
+        dev = qdev_new(OBJECT(machine), "gpio", "mpc8xxx_gpio");
         s = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(s, &error_fatal);
+        sysbus_realize(s, &error_fatal);
         sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC8XXX_GPIO_IRQ));
         memory_region_add_subregion(ccsr_addr_space, MPC8XXX_GPIO_OFFSET,
                                     sysbus_mmio_get_region(s, 0));
@@ -1094,11 +1094,11 @@ void ppce500_init(MachineState *machine)
     }
 
     /* Platform Bus Device */
-    dev = qdev_new_orphan(TYPE_PLATFORM_BUS_DEVICE);
+    dev = qdev_new(OBJECT(machine), "platform-bus", TYPE_PLATFORM_BUS_DEVICE);
     dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
     qdev_prop_set_uint32(dev, "num_irqs", pmc->platform_bus_num_irqs);
     qdev_prop_set_uint32(dev, "mmio_size", pmc->platform_bus_size);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     pms->pbus_dev = PLATFORM_BUS_DEVICE(dev);
 
     s = SYS_BUS_DEVICE(pms->pbus_dev);
@@ -1136,7 +1136,7 @@ void ppce500_init(MachineState *machine)
             exit(1);
         }
 
-        dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
+        dev = qdev_new(OBJECT(machine), "flash", TYPE_PFLASH_CFI01);
         qdev_prop_set_drive(dev, "drive", blk);
         qdev_prop_set_uint32(dev, "num-blocks", size / sector_len);
         qdev_prop_set_uint64(dev, "sector-length", sector_len);
@@ -1147,7 +1147,7 @@ void ppce500_init(MachineState *machine)
         qdev_prop_set_uint16(dev, "id2", 0x0000);
         qdev_prop_set_uint16(dev, "id3", 0x0);
         qdev_prop_set_string(dev, "name", "e500.flash");
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
         memory_region_add_subregion(&pms->pbus_dev->mmio, 0,
                                     pflash_cfi01_get_memory(PFLASH_CFI01(dev)));
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 8c46ecd6d1..e9ee44a2f1 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -159,7 +159,8 @@ static void ppc_core99_init(MachineState *machine)
 
     /* init CPUs */
     for (i = 0; i < machine->smp.cpus; i++) {
-        cpu = POWERPC_CPU(cpu_create_orphan(machine->cpu_type));
+        cpu = POWERPC_CPU(cpu_create(OBJECT(machine), "cpu[*]",
+                                     machine->cpu_type));
         env = &cpu->env;
 
         /* Set time-base frequency to 100 Mhz */
@@ -286,8 +287,8 @@ static void ppc_core99_init(MachineState *machine)
     }
 
     /* UniN init */
-    s = SYS_BUS_DEVICE(qdev_new_orphan(TYPE_UNI_NORTH));
-    sysbus_realize_and_unref(s, &error_fatal);
+    s = SYS_BUS_DEVICE(qdev_new(OBJECT(machine), "uni-n", TYPE_UNI_NORTH));
+    sysbus_realize(s, &error_fatal);
     memory_region_add_subregion(get_system_memory(), 0xf8000000,
                                 sysbus_mmio_get_region(s, 0));
 
@@ -295,9 +296,10 @@ static void ppc_core99_init(MachineState *machine)
         machine_arch = ARCH_MAC99_U3;
         /* 970 gets a U3 bus */
         /* Uninorth AGP bus */
-        uninorth_pci_dev = qdev_new_orphan(TYPE_U3_AGP_HOST_BRIDGE);
+        uninorth_pci_dev = qdev_new(OBJECT(machine), "u3-agp",
+                                    TYPE_U3_AGP_HOST_BRIDGE);
         s = SYS_BUS_DEVICE(uninorth_pci_dev);
-        sysbus_realize_and_unref(s, &error_fatal);
+        sysbus_realize(s, &error_fatal);
         sysbus_mmio_map(s, 0, 0xf0800000);
         sysbus_mmio_map(s, 1, 0xf0c00000);
         /* PCI hole */
@@ -310,25 +312,27 @@ static void ppc_core99_init(MachineState *machine)
         machine_arch = ARCH_MAC99;
         /* Use values found on a real PowerMac */
         /* Uninorth AGP bus */
-        uninorth_agp_dev = qdev_new_orphan(TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
+        uninorth_agp_dev = qdev_new(OBJECT(machine), "uni-n-agp",
+                                    TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
         s = SYS_BUS_DEVICE(uninorth_agp_dev);
-        sysbus_realize_and_unref(s, &error_fatal);
+        sysbus_realize(s, &error_fatal);
         sysbus_mmio_map(s, 0, 0xf0800000);
         sysbus_mmio_map(s, 1, 0xf0c00000);
 
         /* Uninorth internal bus */
-        uninorth_internal_dev = qdev_new_orphan(
+        uninorth_internal_dev = qdev_new(OBJECT(machine), "uni-n-internal",
                                 TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE);
         s = SYS_BUS_DEVICE(uninorth_internal_dev);
-        sysbus_realize_and_unref(s, &error_fatal);
+        sysbus_realize(s, &error_fatal);
         sysbus_mmio_map(s, 0, 0xf4800000);
         sysbus_mmio_map(s, 1, 0xf4c00000);
 
         /* Uninorth main bus - this must be last to make it the default */
-        uninorth_pci_dev = qdev_new_orphan(TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
+        uninorth_pci_dev = qdev_new(OBJECT(machine), "uni-n-pci",
+                                    TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
         qdev_prop_set_uint32(uninorth_pci_dev, "ofw-addr", 0xf2000000);
         s = SYS_BUS_DEVICE(uninorth_pci_dev);
-        sysbus_realize_and_unref(s, &error_fatal);
+        sysbus_realize(s, &error_fatal);
         sysbus_mmio_map(s, 0, 0xf2800000);
         sysbus_mmio_map(s, 1, 0xf2c00000);
         /* PCI hole */
@@ -348,7 +352,8 @@ static void ppc_core99_init(MachineState *machine)
     pci_bus = PCI_HOST_BRIDGE(uninorth_pci_dev)->bus;
 
     /* MacIO */
-    macio = OBJECT(pci_new_orphan(-1, TYPE_NEWWORLD_MACIO));
+    macio = OBJECT(pci_new(OBJECT(machine), "macio", -1,
+                           TYPE_NEWWORLD_MACIO));
     dev = DEVICE(macio);
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
     qdev_prop_set_bit(dev, "has-pmu", has_pmu);
@@ -358,7 +363,7 @@ static void ppc_core99_init(MachineState *machine)
     qdev_prop_set_chr(dev, "chrA", serial_hd(0));
     qdev_prop_set_chr(dev, "chrB", serial_hd(1));
 
-    pci_realize_and_unref(PCI_DEVICE(macio), pci_bus, &error_fatal);
+    qdev_realize(DEVICE(macio), BUS(pci_bus), &error_fatal);
 
     pic_dev = DEVICE(object_resolve_path_component(macio, "pic"));
     for (i = 0; i < 4; i++) {
@@ -408,15 +413,15 @@ static void ppc_core99_init(MachineState *machine)
         }
 
         adb_bus = qdev_get_child_bus(dev, "adb.0");
-        dev = qdev_new_orphan(TYPE_ADB_KEYBOARD);
-        qdev_realize_and_unref(dev, adb_bus, &error_fatal);
+        dev = qdev_new(OBJECT(machine), "adb-keyboard", TYPE_ADB_KEYBOARD);
+        qdev_realize(dev, adb_bus, &error_fatal);
 
-        dev = qdev_new_orphan(TYPE_ADB_MOUSE);
-        qdev_realize_and_unref(dev, adb_bus, &error_fatal);
+        dev = qdev_new(OBJECT(machine), "adb-mouse", TYPE_ADB_MOUSE);
+        qdev_realize(dev, adb_bus, &error_fatal);
     }
 
     if (machine->usb) {
-        pci_create_simple_orphan(pci_bus, -1, "pci-ohci");
+        pci_create_simple(OBJECT(machine), "ohci", pci_bus, -1, "pci-ohci");
 
         /* U3 needs to use USB for input because Linux doesn't support via-cuda
         on PPC64 */
@@ -425,8 +430,8 @@ static void ppc_core99_init(MachineState *machine)
 
             usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                               &error_abort));
-            usb_create_simple_orphan(usb_bus, "usb-kbd");
-            usb_create_simple_orphan(usb_bus, "usb-mouse");
+            usb_create_simple(OBJECT(machine), "usb-kbd", usb_bus, "usb-kbd");
+            usb_create_simple(OBJECT(machine), "usb-mouse", usb_bus, "usb-mouse");
         }
     }
 
@@ -453,22 +458,21 @@ static void ppc_core99_init(MachineState *machine)
            move the NVRAM out of ROM again for KVM */
         nvram_addr = 0xFFE00000;
     }
-    dev = qdev_new_orphan(TYPE_MACIO_NVRAM);
+    dev = qdev_new(OBJECT(machine), "nvram", TYPE_MACIO_NVRAM);
     qdev_prop_set_uint32(dev, "size", MACIO_NVRAM_SIZE);
     qdev_prop_set_uint32(dev, "it_shift", 1);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, nvram_addr);
     nvr = MACIO_NVRAM(dev);
     pmac_format_nvram_partition(nvr, MACIO_NVRAM_SIZE);
     /* No PCI init: the BIOS will do it */
 
-    dev = qdev_new_orphan(TYPE_FW_CFG_MEM);
+    dev = qdev_new(OBJECT(machine), TYPE_FW_CFG, TYPE_FW_CFG_MEM);
     fw_cfg = FW_CFG(dev);
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
-    object_property_add_child(OBJECT(machine), TYPE_FW_CFG, OBJECT(fw_cfg));
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_mmio_map(s, 0, CFG_ADDR);
     sysbus_mmio_map(s, 1, CFG_ADDR + 2);
 
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 4c5746b754..6ef8207f96 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -111,7 +111,8 @@ static void ppc_heathrow_init(MachineState *machine)
 
     /* init CPUs */
     for (i = 0; i < machine->smp.cpus; i++) {
-        cpu = POWERPC_CPU(cpu_create_orphan(machine->cpu_type));
+        cpu = POWERPC_CPU(cpu_create(OBJECT(machine), "cpu[*]",
+                                     machine->cpu_type));
         env = &cpu->env;
 
         /* Set time-base frequency to 16.6 Mhz */
@@ -212,10 +213,11 @@ static void ppc_heathrow_init(MachineState *machine)
     }
 
     /* Grackle PCI host bridge */
-    grackle_dev = qdev_new_orphan(TYPE_GRACKLE_PCI_HOST_BRIDGE);
+    grackle_dev = qdev_new(OBJECT(machine), "grackle",
+                           TYPE_GRACKLE_PCI_HOST_BRIDGE);
     qdev_prop_set_uint32(grackle_dev, "ofw-addr", 0x80000000);
     s = SYS_BUS_DEVICE(grackle_dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
 
     sysbus_mmio_map(s, 0, GRACKLE_BASE);
     sysbus_mmio_map(s, 1, GRACKLE_BASE + 0x200000);
@@ -229,7 +231,8 @@ static void ppc_heathrow_init(MachineState *machine)
     pci_bus = PCI_HOST_BRIDGE(grackle_dev)->bus;
 
     /* MacIO */
-    macio = OBJECT(pci_new_orphan(PCI_DEVFN(16, 0), TYPE_OLDWORLD_MACIO));
+    macio = OBJECT(pci_new(OBJECT(machine), "macio", PCI_DEVFN(16, 0),
+                           TYPE_OLDWORLD_MACIO));
     qdev_prop_set_uint64(DEVICE(macio), "frequency", tbfreq);
 
     dev = DEVICE(object_resolve_path_component(macio, "escc"));
@@ -242,7 +245,7 @@ static void ppc_heathrow_init(MachineState *machine)
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
     }
 
-    pci_realize_and_unref(PCI_DEVICE(macio), pci_bus, &error_fatal);
+    qdev_realize(DEVICE(macio), BUS(pci_bus), &error_fatal);
 
     pic_dev = DEVICE(object_resolve_path_component(macio, "pic"));
     for (i = 0; i < 4; i++) {
@@ -279,13 +282,13 @@ static void ppc_heathrow_init(MachineState *machine)
     /* MacIO CUDA/ADB */
     dev = DEVICE(object_resolve_path_component(macio, "cuda"));
     adb_bus = qdev_get_child_bus(dev, "adb.0");
-    dev = qdev_new_orphan(TYPE_ADB_KEYBOARD);
-    qdev_realize_and_unref(dev, adb_bus, &error_fatal);
-    dev = qdev_new_orphan(TYPE_ADB_MOUSE);
-    qdev_realize_and_unref(dev, adb_bus, &error_fatal);
+    dev = qdev_new(OBJECT(machine), "adb-keyboard", TYPE_ADB_KEYBOARD);
+    qdev_realize(dev, adb_bus, &error_fatal);
+    dev = qdev_new(OBJECT(machine), "adb-mouse", TYPE_ADB_MOUSE);
+    qdev_realize(dev, adb_bus, &error_fatal);
 
     if (machine_usb(machine)) {
-        pci_create_simple_orphan(pci_bus, -1, "pci-ohci");
+        pci_create_simple(OBJECT(machine), "ohci", pci_bus, -1, "pci-ohci");
     }
 
     if (!graphic_width) {
@@ -303,13 +306,12 @@ static void ppc_heathrow_init(MachineState *machine)
 
     /* No PCI init: the BIOS will do it */
 
-    dev = qdev_new_orphan(TYPE_FW_CFG_MEM);
+    dev = qdev_new(OBJECT(machine), TYPE_FW_CFG, TYPE_FW_CFG_MEM);
     fw_cfg = FW_CFG(dev);
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
-    object_property_add_child(OBJECT(machine), TYPE_FW_CFG, OBJECT(fw_cfg));
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_mmio_map(s, 0, CFG_ADDR);
     sysbus_mmio_map(s, 1, CFG_ADDR + 2);
 
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 2974625f1c..6ce1e3f174 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -163,7 +163,7 @@ static void pegasos_init(MachineState *machine)
     uint8_t *spd_data;
 
     /* init CPU */
-    pm->cpu = POWERPC_CPU(cpu_create_orphan(machine->cpu_type));
+    pm->cpu = POWERPC_CPU(cpu_create(OBJECT(machine), "cpu", machine->cpu_type));
     env = &pm->cpu->env;
     if (PPC_INPUT(env) != PPC_FLAGS_INPUT_6xx) {
         error_report("Incompatible CPU, only 6xx bus supported");
@@ -218,7 +218,8 @@ static void pegasos_init(MachineState *machine)
         MemoryRegion *pci_mem, *mr;
 
         /* Articia S */
-        pm->nb = DEVICE(sysbus_create_simple_orphan(TYPE_ARTICIA, 0xfe000000, NULL));
+        pm->nb = DEVICE(sysbus_create_simple(OBJECT(machine), "articia",
+                                             TYPE_ARTICIA, 0xfe000000, NULL));
         pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->nb), 1);
         mr = g_new(MemoryRegion, 1);
         memory_region_init_alias(mr, OBJECT(pm->nb), "pci-mem-low", pci_mem,
@@ -233,7 +234,8 @@ static void pegasos_init(MachineState *machine)
     }
     case PEGASOS2:
         /* Marvell Discovery II system controller */
-        pm->nb = DEVICE(sysbus_create_simple_orphan(TYPE_MV64361, -1,
+        pm->nb = DEVICE(sysbus_create_simple(OBJECT(machine), "mv64361",
+                        TYPE_MV64361, -1,
                         qdev_get_gpio_in(DEVICE(pm->cpu), PPC6xx_INPUT_INT)));
         pci_bus = mv64361_get_pci_bus(pm->nb, 1);
         break;
@@ -241,7 +243,8 @@ static void pegasos_init(MachineState *machine)
 
     /* VIA VT8231 South Bridge (multifunction PCI device) */
     devfn = PCI_DEVFN(pm->type == PEGASOS1 ? 7 : 12, 0);
-    pm->sb = DEVICE(pci_new_multifunction_orphan(devfn, TYPE_VT8231_ISA));
+    pm->sb = DEVICE(pci_new_multifunction(OBJECT(machine), "via", devfn,
+                                          TYPE_VT8231_ISA));
     via = OBJECT(pm->sb);
 
     /* Set properties on individual devices before realizing the south bridge */
@@ -250,7 +253,7 @@ static void pegasos_init(MachineState *machine)
         qdev_prop_set_string(DEVICE(dev), "audiodev", machine->audiodev);
     }
 
-    pci_realize_and_unref(PCI_DEVICE(via), pci_bus, &error_abort);
+    qdev_realize(DEVICE(via), BUS(pci_bus), &error_abort);
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(via, "rtc"),
                               "date");
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 40a7559528..a53eab1d4f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1008,13 +1008,14 @@ static bool pnv_match_cpu(const char *default_type, const char *cpu_type)
     return ppc_default->pvr_match(ppc_default, ppc->pvr, false);
 }
 
-static void pnv_ipmi_bt_init(ISABus *bus, IPMIBmc *bmc, uint32_t irq)
+static void pnv_ipmi_bt_init(Object *parent, ISABus *bus, IPMIBmc *bmc,
+                             uint32_t irq)
 {
-    ISADevice *dev = isa_new_orphan("isa-ipmi-bt");
+    ISADevice *dev = isa_new(parent, "ipmi-bt", "isa-ipmi-bt");
 
     object_property_set_link(OBJECT(dev), "bmc", OBJECT(bmc), &error_fatal);
     object_property_set_int(OBJECT(dev), "irq", irq, &error_fatal);
-    isa_realize_and_unref(dev, bus, &error_fatal);
+    qdev_realize(DEVICE(dev), BUS(bus), &error_fatal);
 }
 
 static void pnv_chip_power10_pic_print_info(PnvChip *chip, GString *buf)
@@ -1127,7 +1128,7 @@ static void pnv_init(MachineState *machine)
     /*
      * Create our simple PNOR device
      */
-    dev = qdev_new_orphan(TYPE_PNV_PNOR);
+    dev = qdev_new(OBJECT(machine), "pnor", TYPE_PNV_PNOR);
     pnor = drive_get(IF_MTD, 0, 0);
     if (!pnor && defaults_enabled()) {
         fw_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, PNOR_FILE_NAME);
@@ -1143,7 +1144,7 @@ static void pnv_init(MachineState *machine)
     if (pnor) {
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(pnor));
     }
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     pnv->pnor = PNV_PNOR(dev);
 
     /* load skiboot firmware  */
@@ -1269,9 +1270,11 @@ static void pnv_init(MachineState *machine)
     pnv->chips = g_new0(PnvChip *, pnv->num_chips);
     for (i = 0; i < pnv->num_chips; i++) {
         char chip_name[32];
-        Object *chip = OBJECT(qdev_new_orphan(chip_typename));
+        Object *chip;
         uint64_t chip_ram_size =  pnv_chip_get_ram_size(pnv, i);
 
+        snprintf(chip_name, sizeof(chip_name), "chip[%d]", i);
+        chip = OBJECT(qdev_new(OBJECT(pnv), chip_name, chip_typename));
         pnv->chips[i] = PNV_CHIP(chip);
 
         /* Distribute RAM among the chips  */
@@ -1281,8 +1284,6 @@ static void pnv_init(MachineState *machine)
                                 &error_fatal);
         chip_ram_start += chip_ram_size;
 
-        snprintf(chip_name, sizeof(chip_name), "chip[%d]", i);
-        object_property_add_child(OBJECT(pnv), chip_name, chip);
         object_property_set_int(chip, "chip-id", i, &error_fatal);
         object_property_set_int(chip, "nr-cores", machine->smp.cores,
                                 &error_fatal);
@@ -1303,7 +1304,7 @@ static void pnv_init(MachineState *machine)
             object_property_set_link(chip, "xive-fabric", OBJECT(pnv),
                                      &error_abort);
         }
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(chip), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(chip), &error_fatal);
     }
     g_free(chip_typename);
 
@@ -1321,8 +1322,8 @@ static void pnv_init(MachineState *machine)
      * communication with the BMC
      */
     if (defaults_enabled()) {
-        pnv->bmc = pnv_bmc_create(pnv->pnor);
-        pnv_ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
+        pnv->bmc = pnv_bmc_create(OBJECT(machine), pnv->pnor);
+        pnv_ipmi_bt_init(OBJECT(machine), pnv->isa_bus, pnv->bmc, 10);
     }
 
     /*
@@ -2825,7 +2826,8 @@ static void pnv_rainier_i2c_init(PnvMachineState *pnv)
          * Add a PCA9552 I2C device for PCIe hotplug control
          * to engine 2, bus 1, address 0x63
          */
-        I2CSlave *dev = i2c_slave_create_simple_orphan(chip10->i2c[2].busses[1],
+        I2CSlave *dev = i2c_slave_create_simple(OBJECT(pnv), "pca9552[*]",
+                                                chip10->i2c[2].busses[1],
                                                 "pca9552", 0x63);
 
         /*
@@ -2843,7 +2845,8 @@ static void pnv_rainier_i2c_init(PnvMachineState *pnv)
          * Add a PCA9554 I2C device for cable card presence detection
          * to engine 2, bus 1, address 0x25
          */
-        i2c_slave_create_simple_orphan(chip10->i2c[2].busses[1], "pca9554", 0x25);
+        i2c_slave_create_simple(OBJECT(pnv), "pca9554[*]",
+                                chip10->i2c[2].busses[1], "pca9554", 0x25);
     }
 }
 
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 6f65984f2e..dd4fd20f21 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -295,11 +295,11 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor)
  * Instantiate the machine BMC. PowerNV uses the QEMU internal
  * simulator but it could also be external.
  */
-IPMIBmc *pnv_bmc_create(PnvPnor *pnor)
+IPMIBmc *pnv_bmc_create(Object *parent, PnvPnor *pnor)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan(TYPE_IPMI_BMC_SIMULATOR);
+    dev = qdev_new(parent, "bmc", TYPE_IPMI_BMC_SIMULATOR);
     qdev_realize(dev, NULL, &error_fatal);
     pnv_bmc_set_pnor(IPMI_BMC(dev), pnor);
 
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 499949bfdf..2d9efeba77 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -148,7 +148,7 @@ static void bamboo_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    cpu = POWERPC_CPU(cpu_create_orphan(machine->cpu_type));
+    cpu = POWERPC_CPU(cpu_create(OBJECT(machine), "cpu", machine->cpu_type));
     env = &cpu->env;
 
     if (env->mmu_model != POWERPC_MMU_BOOKE) {
@@ -162,9 +162,8 @@ static void bamboo_init(MachineState *machine)
     ppc_dcr_init(env, NULL, NULL);
 
     /* interrupt controller */
-    uicdev = qdev_new_orphan(TYPE_PPC_UIC);
+    uicdev = qdev_new(OBJECT(machine), "uic", TYPE_PPC_UIC);
     ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(uicdev), cpu, &error_fatal);
-    object_unref(OBJECT(uicdev));
     uicsbd = SYS_BUS_DEVICE(uicdev);
     sysbus_connect_irq(uicsbd, PPCUIC_OUTPUT_INT,
                        qdev_get_gpio_in(DEVICE(cpu), PPC40x_INPUT_INT));
@@ -172,18 +171,18 @@ static void bamboo_init(MachineState *machine)
                        qdev_get_gpio_in(DEVICE(cpu), PPC40x_INPUT_CINT));
 
     /* SDRAM controller */
-    dev = qdev_new_orphan(TYPE_PPC4xx_SDRAM_DDR);
+    dev = qdev_new(OBJECT(machine), "sdram", TYPE_PPC4xx_SDRAM_DDR);
     object_property_set_link(OBJECT(dev), "dram", OBJECT(machine->ram),
                              &error_abort);
     ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(dev), cpu, &error_fatal);
-    object_unref(OBJECT(dev));
     /* XXX 440EP's ECC interrupts are on UIC1, but we've only created UIC0. */
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(uicdev, 14));
     /* Enable SDRAM memory regions, this should be done by the firmware */
     ppc4xx_sdram_ddr_enable(PPC4xx_SDRAM_DDR(dev));
 
     /* PCI */
-    dev = sysbus_create_varargs_orphan(TYPE_PPC4xx_PCI_HOST, PPC440EP_PCI_CONFIG,
+    dev = sysbus_create_varargs(OBJECT(machine), "pci-host",
+                                TYPE_PPC4xx_PCI_HOST, PPC440EP_PCI_CONFIG,
                                 qdev_get_gpio_in(uicdev, pci_irq_nrs[0]),
                                 qdev_get_gpio_in(uicdev, pci_irq_nrs[1]),
                                 qdev_get_gpio_in(uicdev, pci_irq_nrs[2]),
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index c861e022f0..ff85a4e64b 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -257,7 +257,7 @@ static void ibm_40p_init(MachineState *machine)
     }
 
     /* init CPU */
-    cpu = POWERPC_CPU(cpu_create_orphan(machine->cpu_type));
+    cpu = POWERPC_CPU(cpu_create(OBJECT(machine), "cpu", machine->cpu_type));
     env = &cpu->env;
     if (PPC_INPUT(env) != PPC_FLAGS_INPUT_6xx) {
         error_report("only 6xx bus is supported on this machine");
@@ -289,10 +289,9 @@ static void ibm_40p_init(MachineState *machine)
     g_free(filename);
 
     /* PCI host */
-    dev = qdev_new_orphan("raven-pcihost");
+    dev = qdev_new(OBJECT(machine), "raven", "raven-pcihost");
     pcihost = SYS_BUS_DEVICE(dev);
-    object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev));
-    sysbus_realize_and_unref(pcihost, &error_fatal);
+    sysbus_realize(pcihost, &error_fatal);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
     if (!pci_bus) {
         error_report("could not create PCI host controller");
@@ -300,8 +299,9 @@ static void ibm_40p_init(MachineState *machine)
     }
 
     /* PCI -> ISA bridge */
-    i82378_dev = DEVICE(pci_new_orphan(PCI_DEVFN(11, 0), "i82378"));
-    qdev_realize_and_unref(i82378_dev, BUS(pci_bus), &error_fatal);
+    i82378_dev = DEVICE(pci_new(OBJECT(machine), "i82378",
+                                PCI_DEVFN(11, 0), "i82378"));
+    qdev_realize(i82378_dev, BUS(pci_bus), &error_fatal);
     qdev_connect_gpio_out(i82378_dev, 0,
                           qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
 
@@ -309,23 +309,23 @@ static void ibm_40p_init(MachineState *machine)
     isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
 
     /* system control ports */
-    isa_dev = isa_new_orphan("prep-systemio");
+    isa_dev = isa_new(OBJECT(machine), "systemio", "prep-systemio");
     dev = DEVICE(isa_dev);
     qdev_prop_set_uint32(dev, "ibm-planar-id", 0xfc);
     qdev_prop_set_uint32(dev, "equipment", 0xc0);
-    isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
+    qdev_realize(DEVICE(isa_dev), BUS(isa_bus), &error_fatal);
 
     /* Memory controller */
-    isa_dev = isa_new_orphan("rs6000-mc");
+    isa_dev = isa_new(OBJECT(machine), "mc", "rs6000-mc");
     dev = DEVICE(isa_dev);
     qdev_prop_set_uint32(dev, "ram-size", machine->ram_size);
-    isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
+    qdev_realize(DEVICE(isa_dev), BUS(isa_bus), &error_fatal);
 
     /* RTC */
-    isa_dev = isa_new_orphan(TYPE_MC146818_RTC);
+    isa_dev = isa_new(OBJECT(machine), "rtc", TYPE_MC146818_RTC);
     dev = DEVICE(isa_dev);
     qdev_prop_set_int32(dev, "base_year", 1900);
-    isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
+    qdev_realize(DEVICE(isa_dev), BUS(isa_bus), &error_fatal);
 
     /* initialize CMOS checksums */
     cmos_checksum = 0x6aa9;
@@ -334,23 +334,25 @@ static void ibm_40p_init(MachineState *machine)
 
     /* add some more devices */
     if (defaults_enabled()) {
-        m48t59 = NVRAM(isa_create_simple_orphan(isa_bus, "isa-m48t59"));
+        m48t59 = NVRAM(isa_create_simple(OBJECT(machine), "m48t59",
+                                         isa_bus, "isa-m48t59"));
 
-        isa_dev = isa_new_orphan("cs4231a");
+        isa_dev = isa_new(OBJECT(machine), "cs4231a", "cs4231a");
         dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "iobase", 0x830);
         qdev_prop_set_uint32(dev, "irq", 10);
         if (machine->audiodev) {
             qdev_prop_set_string(dev, "audiodev", machine->audiodev);
         }
-        isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
+        qdev_realize(DEVICE(isa_dev), BUS(isa_bus), &error_fatal);
 
-        isa_dev = isa_new_orphan("pc87312");
+        isa_dev = isa_new(OBJECT(machine), "pc87312", "pc87312");
         dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "config", 12);
-        isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
+        qdev_realize(DEVICE(isa_dev), BUS(isa_bus), &error_fatal);
 
-        dev = DEVICE(pci_create_simple_orphan(pci_bus, PCI_DEVFN(1, 0), "lsi53c810"));
+        dev = DEVICE(pci_create_simple(OBJECT(machine), "scsi", pci_bus,
+                                       PCI_DEVFN(1, 0), "lsi53c810"));
         lsi53c8xx_handle_legacy_cmdline(dev);
         qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in(i82378_dev, 13));
 
@@ -363,14 +365,12 @@ static void ibm_40p_init(MachineState *machine)
     }
 
     /* Prepare firmware configuration for OpenBIOS */
-    dev = qdev_new_orphan(TYPE_FW_CFG_MEM);
+    dev = qdev_new(OBJECT(machine), TYPE_FW_CFG, TYPE_FW_CFG_MEM);
     fw_cfg = FW_CFG(dev);
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
-    object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
-                              OBJECT(fw_cfg));
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_mmio_map(s, 0, CFG_ADDR);
     sysbus_mmio_map(s, 1, CFG_ADDR + 2);
 
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index be506b02f2..59c217e2b2 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -261,7 +261,7 @@ static void sam460ex_init(MachineState *machine)
     uint8_t *spd_data;
     int success;
 
-    cpu = POWERPC_CPU(cpu_create_orphan(machine->cpu_type));
+    cpu = POWERPC_CPU(cpu_create(OBJECT(machine), "cpu", machine->cpu_type));
     env = &cpu->env;
     if (env->mmu_model != POWERPC_MMU_BOOKE) {
         error_report("Only MMU model BookE is supported by this machine.");
@@ -276,9 +276,8 @@ static void sam460ex_init(MachineState *machine)
     ppc_dcr_init(env, NULL, NULL);
 
     /* PLB arbitrer */
-    dev = qdev_new_orphan(TYPE_PPC4xx_PLB);
+    dev = qdev_new(OBJECT(machine), "plb", TYPE_PPC4xx_PLB);
     ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(dev), cpu, &error_fatal);
-    object_unref(OBJECT(dev));
 
     /* interrupt controllers */
     for (i = 0; i < ARRAY_SIZE(uic); i++) {
@@ -292,10 +291,9 @@ static void sam460ex_init(MachineState *machine)
          */
         const int input_ints[] = { -1, 30, 10, 16 };
 
-        uic[i] = qdev_new_orphan(TYPE_PPC_UIC);
+        uic[i] = qdev_new(OBJECT(machine), "uic[*]", TYPE_PPC_UIC);
         qdev_prop_set_uint32(uic[i], "dcr-base", 0xc0 + i * 0x10);
         ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(uic[i]), cpu, &error_fatal);
-        object_unref(OBJECT(uic[i]));
 
         sbdev = SYS_BUS_DEVICE(uic[i]);
         if (i == 0) {
@@ -322,7 +320,7 @@ static void sam460ex_init(MachineState *machine)
         error_report("Memory below 64 MiB is not supported");
         exit(1);
     }
-    dev = qdev_new_orphan(TYPE_PPC4xx_SDRAM_DDR2);
+    dev = qdev_new(OBJECT(machine), "sdram", TYPE_PPC4xx_SDRAM_DDR2);
     object_property_set_link(OBJECT(dev), "dram", OBJECT(machine->ram),
                              &error_abort);
     /*
@@ -331,14 +329,13 @@ static void sam460ex_init(MachineState *machine)
      */
     object_property_set_int(OBJECT(dev), "nbanks", 1, &error_abort);
     ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(dev), cpu, &error_fatal);
-    object_unref(OBJECT(dev));
     /* FIXME: does 460EX have ECC interrupts? */
     /* Enable SDRAM memory regions as we may boot without firmware */
     ppc4xx_sdram_ddr2_enable(PPC4xx_SDRAM_DDR2(dev));
 
     /* IIC controllers and devices */
-    dev = sysbus_create_simple_orphan(TYPE_PPC4xx_I2C, 0x4ef600700,
-                               qdev_get_gpio_in(uic[0], 2));
+    dev = sysbus_create_simple(OBJECT(machine), "i2c[*]", TYPE_PPC4xx_I2C,
+                               0x4ef600700, qdev_get_gpio_in(uic[0], 2));
     i2c = PPC4xx_I2C(dev)->bus;
     /* SPD EEPROM on RAM module */
     spd_data = spd_data_generate(machine->ram_size < 128 * MiB ? DDR : DDR2,
@@ -346,15 +343,14 @@ static void sam460ex_init(MachineState *machine)
     spd_data[20] = 4; /* SO-DIMM module */
     smbus_eeprom_init_one(OBJECT(machine), i2c, 0x50, spd_data);
     /* RTC */
-    i2c_slave_create_simple_orphan(i2c, "m41t80", 0x68);
+    i2c_slave_create_simple(OBJECT(machine), "rtc", i2c, "m41t80", 0x68);
 
-    dev = sysbus_create_simple_orphan(TYPE_PPC4xx_I2C, 0x4ef600800,
-                               qdev_get_gpio_in(uic[0], 3));
+    dev = sysbus_create_simple(OBJECT(machine), "i2c[*]", TYPE_PPC4xx_I2C,
+                               0x4ef600800, qdev_get_gpio_in(uic[0], 3));
 
     /* External bus controller */
-    dev = qdev_new_orphan(TYPE_PPC4xx_EBC);
+    dev = qdev_new(OBJECT(machine), "ebc", TYPE_PPC4xx_EBC);
     ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(dev), cpu, &error_fatal);
-    object_unref(OBJECT(dev));
 
     /* CPR */
     ppc4xx_cpr_init(env);
@@ -366,11 +362,10 @@ static void sam460ex_init(MachineState *machine)
     ppc4xx_sdr_init(env);
 
     /* MAL */
-    dev = qdev_new_orphan(TYPE_PPC4xx_MAL);
+    dev = qdev_new(OBJECT(machine), "mal", TYPE_PPC4xx_MAL);
     qdev_prop_set_uint8(dev, "txc-num", 4);
     qdev_prop_set_uint8(dev, "rxc-num", 16);
     ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(dev), cpu, &error_fatal);
-    object_unref(OBJECT(dev));
     sbdev = SYS_BUS_DEVICE(dev);
     for (i = 0; i < ARRAY_SIZE(PPC4xx_MAL(dev)->irqs); i++) {
         sysbus_connect_irq(sbdev, i, qdev_get_gpio_in(uic[2], 3 + i));
@@ -388,49 +383,51 @@ static void sam460ex_init(MachineState *machine)
                                 l2cache_ram);
 
     /* USB */
-    sysbus_create_simple_orphan(TYPE_PPC4xx_EHCI, 0x4bffd0400,
-                         qdev_get_gpio_in(uic[2], 29));
-    dev = qdev_new_orphan("sysbus-ohci");
+    sysbus_create_simple(OBJECT(machine), "ehci", TYPE_PPC4xx_EHCI,
+                         0x4bffd0400, qdev_get_gpio_in(uic[2], 29));
+    dev = qdev_new(OBJECT(machine), "ohci", "sysbus-ohci");
     qdev_prop_set_string(dev, "masterbus", "usb-bus.0");
     qdev_prop_set_uint32(dev, "num-ports", 6);
     sbdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sbdev, &error_fatal);
+    sysbus_realize(sbdev, &error_fatal);
     sysbus_mmio_map(sbdev, 0, 0x4bffd0000);
     sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(uic[2], 30));
     usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                       &error_abort));
-    usb_create_simple_orphan(usb_bus, "usb-kbd");
-    usb_create_simple_orphan(usb_bus, "usb-mouse");
+    usb_create_simple(OBJECT(machine), "usb-kbd", usb_bus, "usb-kbd");
+    usb_create_simple(OBJECT(machine), "usb-mouse", usb_bus, "usb-mouse");
 
     /* PCIe buses */
-    dev = qdev_new_orphan(TYPE_PPC460EX_PCIE_HOST);
+    dev = qdev_new(OBJECT(machine), "pcie-host[*]", TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "busnum", 0);
     qdev_prop_set_int32(dev, "dcrn-base", PCIE0_DCRN_BASE);
     object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    dev = qdev_new_orphan(TYPE_PPC460EX_PCIE_HOST);
+    dev = qdev_new(OBJECT(machine), "pcie-host[*]", TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "busnum", 1);
     qdev_prop_set_int32(dev, "dcrn-base", PCIE1_DCRN_BASE);
     object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* PCI bus */
     /* All PCI irqs are connected to the same UIC pin (cf. UBoot source) */
-    dev = sysbus_create_simple_orphan(TYPE_PPC440_PCIX_HOST, 0xc0ec00000,
+    dev = sysbus_create_simple(OBJECT(machine), "pcix-host",
+                               TYPE_PPC440_PCIX_HOST, 0xc0ec00000,
                                qdev_get_gpio_in(uic[1], 0));
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, 0xc08000000);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
 
     /* PCI devices */
-    pci_create_simple_orphan(pci_bus, PCI_DEVFN(6, 0), "sm501");
+    pci_create_simple(OBJECT(machine), "sm501", pci_bus, PCI_DEVFN(6, 0), "sm501");
     /*
      * SoC has a single SATA port but we don't emulate that
      * However, firmware and usual clients have driver for SiI311x
      * PCI SATA card so add one for convenience by default
      */
     if (defaults_enabled()) {
-        PCIIDEState *s = PCI_IDE(pci_create_simple_orphan(pci_bus, -1, "sii3112"));
+        PCIIDEState *s = PCI_IDE(pci_create_simple(OBJECT(machine), "sata",
+                                                   pci_bus, -1, "sii3112"));
         DriveInfo *di;
 
         di = drive_get_by_index(IF_IDE, 0);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 969f821aca..fbf6c59516 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1885,7 +1885,7 @@ static void spapr_machine_reset(MachineState *machine, ResetType type)
 
 static void spapr_create_nvram(SpaprMachineState *spapr)
 {
-    DeviceState *dev = qdev_new_orphan("spapr-nvram");
+    DeviceState *dev = qdev_new(OBJECT(spapr), "nvram", "spapr-nvram");
     DriveInfo *dinfo = drive_get(IF_PFLASH, 0, 0);
 
     if (dinfo) {
@@ -1893,7 +1893,7 @@ static void spapr_create_nvram(SpaprMachineState *spapr)
                                 &error_fatal);
     }
 
-    qdev_realize_and_unref(dev, &spapr->vio_bus->bus, &error_fatal);
+    qdev_realize(dev, &spapr->vio_bus->bus, &error_fatal);
 
     spapr->nvram = (struct SpaprNvram *)dev;
 }
@@ -2795,13 +2795,13 @@ static void spapr_init_cpus(SpaprMachineState *spapr)
     }
 }
 
-static PCIHostState *spapr_create_default_phb(void)
+static PCIHostState *spapr_create_default_phb(Object *parent)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan(TYPE_SPAPR_PCI_HOST_BRIDGE);
+    dev = qdev_new(parent, "phb[*]", TYPE_SPAPR_PCI_HOST_BRIDGE);
     qdev_prop_set_uint32(dev, "index", 0);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     return PCI_HOST_BRIDGE(dev);
 }
@@ -3030,7 +3030,7 @@ static void spapr_machine_init(MachineState *machine)
     spapr_rtc_create(spapr);
 
     /* Set up VIO bus */
-    spapr->vio_bus = spapr_vio_bus_init();
+    spapr->vio_bus = spapr_vio_bus_init(OBJECT(machine));
 
     for (i = 0; serial_hd(i); i++) {
         spapr_vty_create(OBJECT(machine), spapr->vio_bus, serial_hd(i));
@@ -3053,7 +3053,7 @@ static void spapr_machine_init(MachineState *machine)
     /* Set up PCI */
     spapr_pci_rtas_init();
 
-    phb = spapr_create_default_phb();
+    phb = spapr_create_default_phb(OBJECT(machine));
 
     while ((nd = qemu_find_nic_info("spapr-vlan", true, "ibmveth"))) {
         spapr_vlan_create(OBJECT(spapr), spapr->vio_bus, nd);
@@ -3075,15 +3075,16 @@ static void spapr_machine_init(MachineState *machine)
     }
 
     if (machine->usb) {
-        pci_create_simple_orphan(phb->bus, -1, "nec-usb-xhci");
+        pci_create_simple(OBJECT(machine), "xhci", phb->bus, -1,
+                          "nec-usb-xhci");
 
         if (has_vga) {
             USBBus *usb_bus;
 
             usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                               &error_abort));
-            usb_create_simple_orphan(usb_bus, "usb-kbd");
-            usb_create_simple_orphan(usb_bus, "usb-mouse");
+            usb_create_simple(OBJECT(machine), "usb-kbd", usb_bus, "usb-kbd");
+            usb_create_simple(OBJECT(machine), "usb-mouse", usb_bus, "usb-mouse");
         }
     }
 
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 76ae80d16e..b9e5f5d710 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -312,7 +312,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         DeviceState *dev;
         int i;
 
-        dev = qdev_new_orphan(TYPE_SPAPR_XIVE);
+        dev = qdev_new(OBJECT(spapr), "xive", TYPE_SPAPR_XIVE);
         qdev_prop_set_uint32(dev, "nr-irqs", SPAPR_NR_XIRQS + SPAPR_IRQ_NR_IPIS);
         /*
          * 8 XIVE END structures per CPU. One for each available
@@ -321,7 +321,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
         object_property_set_link(OBJECT(dev), "xive-fabric", OBJECT(spapr),
                                  &error_abort);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
         spapr->xive = SPAPR_XIVE(dev);
 
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 0f22fa61a4..1e9cbf99ea 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -557,21 +557,21 @@ static target_ulong h_vio_signal(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
-SpaprVioBus *spapr_vio_bus_init(void)
+SpaprVioBus *spapr_vio_bus_init(Object *parent)
 {
     SpaprVioBus *bus;
     BusState *qbus;
     DeviceState *dev;
 
     /* Create bridge device */
-    dev = qdev_new_orphan(TYPE_SPAPR_VIO_BRIDGE);
+    dev = qdev_new(parent, "vio-bridge", TYPE_SPAPR_VIO_BRIDGE);
 
     /* Create bus on bridge device */
     qbus = qbus_new(TYPE_SPAPR_VIO_BUS, dev, "spapr-vio");
     bus = SPAPR_VIO_BUS(qbus);
     bus->next_reg = SPAPR_VIO_REG_BASE;
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* hcall-vio */
     spapr_register_hypercall(H_VIO_SIGNAL, h_vio_signal);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 8f4b8965a9..d268ce4987 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -69,14 +69,15 @@ static struct boot_info
     void *vfdt;
 } boot_info;
 
-static PowerPCCPU *ppc440_init_xilinx(const char *cpu_type, uint32_t sysclk)
+static PowerPCCPU *ppc440_init_xilinx(Object *parent, const char *cpu_type,
+                                      uint32_t sysclk)
 {
     PowerPCCPU *cpu;
     CPUPPCState *env;
     DeviceState *uicdev;
     SysBusDevice *uicsbd;
 
-    cpu = POWERPC_CPU(cpu_create_orphan(cpu_type));
+    cpu = POWERPC_CPU(cpu_create(parent, "cpu", cpu_type));
     env = &cpu->env;
 
     ppc_booke_timers_init(cpu, sysclk, 0/* no flags */);
@@ -84,9 +85,8 @@ static PowerPCCPU *ppc440_init_xilinx(const char *cpu_type, uint32_t sysclk)
     ppc_dcr_init(env, NULL, NULL);
 
     /* interrupt controller */
-    uicdev = qdev_new_orphan(TYPE_PPC_UIC);
+    uicdev = qdev_new(parent, "uic", TYPE_PPC_UIC);
     ppc4xx_dcr_realize(PPC4xx_DCR_DEVICE(uicdev), cpu, &error_fatal);
-    object_unref(OBJECT(uicdev));
     uicsbd = SYS_BUS_DEVICE(uicdev);
     sysbus_connect_irq(uicsbd, PPCUIC_OUTPUT_INT,
                        qdev_get_gpio_in(DEVICE(cpu), PPC40x_INPUT_INT));
@@ -199,7 +199,7 @@ static void virtex_init(MachineState *machine)
     int i;
 
     /* init CPUs */
-    cpu = ppc440_init_xilinx(machine->cpu_type, 400000000);
+    cpu = ppc440_init_xilinx(OBJECT(machine), machine->cpu_type, 400000000);
     env = &cpu->env;
 
     if (env->mmu_model != POWERPC_MMU_BOOKE) {
@@ -218,10 +218,10 @@ static void virtex_init(MachineState *machine)
                           64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
 
     cpu_irq = qdev_get_gpio_in(DEVICE(cpu), PPC40x_INPUT_INT);
-    dev = qdev_new_orphan("xlnx.xps-intc");
+    dev = qdev_new(OBJECT(machine), "intc", "xlnx.xps-intc");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_BIG);
     qdev_prop_set_uint32(dev, "kind-of-intr", 0);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irq);
     for (i = 0; i < 32; i++) {
@@ -233,11 +233,11 @@ static void virtex_init(MachineState *machine)
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
-    dev = qdev_new_orphan("xlnx.xps-timer");
+    dev = qdev_new(OBJECT(machine), "timer", "xlnx.xps-timer");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_BIG);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 60e902d9c5..6bf8d57972 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -122,7 +122,7 @@ void pnv_cpu_do_nmi_resume(CPUState *cs);
  */
 void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
 void pnv_bmc_powerdown(IPMIBmc *bmc);
-IPMIBmc *pnv_bmc_create(PnvPnor *pnor);
+IPMIBmc *pnv_bmc_create(Object *parent, PnvPnor *pnor);
 IPMIBmc *pnv_bmc_find(Error **errp);
 void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
 
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 3ca0c9d261..b834a963da 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -76,7 +76,7 @@ struct SpaprVioBus {
     uint32_t next_reg;
 };
 
-SpaprVioBus *spapr_vio_bus_init(void);
+SpaprVioBus *spapr_vio_bus_init(Object *parent);
 SpaprVioDevice *spapr_vio_find_by_reg(SpaprVioBus *bus, uint32_t reg);
 void spapr_dt_vdevice(SpaprVioBus *bus, void *fdt);
 gchar *spapr_vio_stdout_path(SpaprVioBus *bus);
-- 
2.47.1


