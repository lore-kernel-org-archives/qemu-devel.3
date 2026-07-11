Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C264C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigVq-0003bH-VL; Sat, 11 Jul 2026 18:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigVo-0003SQ-B3; Sat, 11 Jul 2026 18:49:32 -0400
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.42.203.116])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigVl-0007ps-4q; Sat, 11 Jul 2026 18:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810169; x=1815346169;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hLNkfsJafq9PSdTKHfm6ySTJYjE9YwrZGJM3/ZyitbE=;
 b=VZsVQ/0o76160tYXilbxMyoRtaUPrPLBsqr9ejSaOp/aT3MDCXoV/LsN
 ybuA75UIvXqV126JgyZIhfPNZFMqP6x9bhrIAqVzI25PpjSu4qoeswye7
 CnNFXdNhT4rl+mY+0hHBEhwVZdc1otBSynjAaWU6QfHJl6AlmSeZMsNJK
 cSE9ggJv9KDOaHyYHRKnQtiDmf9oQnmKKnXcKSz+EpxV5LOG0yHYtFEL1
 qkeNb9L8Uwtp4Ma9C2Wp4bAGeWRIbAuXHJw/1C8owX5Cf5JP50xGCiz2m
 pkfR122snqzwoqAFAFkW017LOq7knWBpKPr0sakPmmTNJwR4gYEZ7zBLo A==;
X-CSE-ConnectionGUID: H1kVl1n7QUWStXDbDunXEg==
X-CSE-MsgGUID: wotJJSSGSDKWLnKOY/siJA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23517846"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:49:25 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:21950]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.214:2525]
 with esmtp (Farcaster)
 id 22e9e83d-65ae-40fa-9789-fb68e231249c; Sat, 11 Jul 2026 22:49:25 +0000 (UTC)
X-Farcaster-Flow-ID: 22e9e83d-65ae-40fa-9789-fb68e231249c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:49:25 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:49:16 +0000
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
Subject: [RFC PATCH 047/134] hw/block: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:40 +0000
Message-ID: <20260711223707.42139-48-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
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

Convert the *_orphan() device-creation calls in hw/block to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/block/fdc-sysbus.c:105 | qdev_new | parent | "fdc" | helper called from mips_jazz board init; thread Object *parent through fdctrl_init_sysbus()
hw/block/fdc-sysbus.c:121 | qdev_new | parent | "fdc" | helper called from sun4m board init; thread Object *parent through sun4m_fdctrl_init()
hw/block/fdc.c:2332 | qdev_new | OBJECT(bus->bus.parent) | "floppy[*]" | drive is child of the FDC device that owns the FloppyBus
hw/block/pflash_cfi01.c:961 | qdev_new | parent | name | helper already receives QOM name; thread Object *parent through pflash_cfi01_register() and its 9 board callers
hw/block/pflash_cfi02.c:1008 | qdev_new | parent | name | helper already receives QOM name; thread Object *parent through pflash_cfi02_register() and its 4 board callers
hw/block/xen-block.c:1077 | qdev_new_orphan | ORPHAN-JUSTIFIED | - | XenBackend .create() callback; hotplugged device analogous to qdev_device_add() path, parented later on realize into xenbus

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/collie.c                          |  2 +-
 hw/arm/digic_boards.c                    |  2 +-
 hw/arm/musicpal.c                        |  3 ++-
 hw/arm/omap_sx1.c                        |  4 ++--
 hw/arm/versatilepb.c                     |  2 +-
 hw/arm/xilinx_zynq.c                     |  2 +-
 hw/block/fdc-sysbus.c                    | 13 +++++++------
 hw/block/fdc.c                           |  4 ++--
 hw/block/pflash_cfi01.c                  |  6 +++---
 hw/block/pflash_cfi02.c                  |  6 +++---
 hw/microblaze/petalogix_ml605_mmu.c      |  3 ++-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
 hw/mips/jazz.c                           |  3 ++-
 hw/mips/malta.c                          |  2 +-
 hw/ppc/sam460ex.c                        |  7 ++++---
 hw/ppc/virtex_ml507.c                    |  2 +-
 hw/sh4/r2d.c                             |  2 +-
 hw/sparc/sun4m.c                         |  2 +-
 include/hw/block/fdc.h                   |  5 +++--
 include/hw/block/flash.h                 |  4 ++--
 20 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 81bc019460..b3646daa3b 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -58,7 +58,7 @@ static void collie_init(MachineState *machine)
 
     for (unsigned i = 0; i < 2; i++) {
         DriveInfo *dinfo = drive_get(IF_PFLASH, 0, i);
-        pflash_cfi01_register(i ? SA_CS1 : SA_CS0,
+        pflash_cfi01_register(OBJECT(machine), i ? SA_CS1 : SA_CS0,
                               i ? "collie.fl2" : "collie.fl1", FLASH_SIZE,
                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                               FLASH_SECTOR_SIZE, 4, 0x00, 0x00, 0x00, 0x00, 0);
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index ed12f54200..92b66f34f7 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -117,7 +117,7 @@ static void digic4_add_k8p3215uqb_rom(DigicState *s, hwaddr addr,
 #define FLASH_K8P3215UQB_SIZE (4 * 1024 * 1024)
 #define FLASH_K8P3215UQB_SECTOR_SIZE (64 * 1024)
 
-    pflash_cfi02_register(addr, "pflash", FLASH_K8P3215UQB_SIZE,
+    pflash_cfi02_register(OBJECT(s), addr, "pflash", FLASH_K8P3215UQB_SIZE,
                           NULL, FLASH_K8P3215UQB_SECTOR_SIZE,
                           DIGIC4_ROM_MAX_SIZE / FLASH_K8P3215UQB_SIZE,
                           4,
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index a07359813e..43e15a4e48 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1279,7 +1279,8 @@ static void musicpal_init(MachineState *machine)
          * 0xFF800000 (if there is 8 MB flash). So remap flash access if the
          * image is smaller than 32 MB.
          */
-        pflash_cfi02_register(0x100000000ULL - MP_FLASH_SIZE_MAX,
+        pflash_cfi02_register(OBJECT(machine),
+                              0x100000000ULL - MP_FLASH_SIZE_MAX,
                               "musicpal.flash", flash_size,
                               blk, FLASH_SECTOR_SIZE,
                               MP_FLASH_SIZE_MAX / flash_size,
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index bcb7105323..a468b045d4 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -150,7 +150,7 @@ static void sx1_init(MachineState *machine, const int version)
 
     fl_idx = 0;
     if ((dinfo = drive_get(IF_PFLASH, 0, fl_idx)) != NULL) {
-        pflash_cfi01_register(OMAP_CS0_BASE,
+        pflash_cfi01_register(OBJECT(machine), OMAP_CS0_BASE,
                               "omap_sx1.flash0-1", flash_size,
                               blk_by_legacy_dinfo(dinfo),
                               SECTOR_SIZE, 4, 0, 0, 0, 0, 0);
@@ -169,7 +169,7 @@ static void sx1_init(MachineState *machine, const int version)
         memory_region_add_subregion(address_space,
                                 OMAP_CS1_BASE + FLASH1_SIZE, &cs[1]);
 
-        pflash_cfi01_register(OMAP_CS1_BASE,
+        pflash_cfi01_register(OBJECT(machine), OMAP_CS1_BASE,
                               "omap_sx1.flash1-1", FLASH1_SIZE,
                               blk_by_legacy_dinfo(dinfo),
                               SECTOR_SIZE, 4, 0, 0, 0, 0, 0);
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 5de99cb854..59bb2d1346 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -391,7 +391,7 @@ static void versatile_init(MachineState *machine, int board_id)
     /* 0x34000000 NOR Flash */
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
-    pflash_cfi01_register(VERSATILE_FLASH_ADDR, "versatile.flash",
+    pflash_cfi01_register(OBJECT(machine), VERSATILE_FLASH_ADDR, "versatile.flash",
                           VERSATILE_FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           VERSATILE_FLASH_SECT_SIZE,
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 7f31cd6088..ba00c5a3aa 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -242,7 +242,7 @@ static void zynq_init(MachineState *machine)
     DriveInfo *dinfo = drive_get(IF_PFLASH, 0, 0);
 
     /* AMD */
-    pflash_cfi02_register(0xe2000000, "zynq.pflash", FLASH_SIZE,
+    pflash_cfi02_register(OBJECT(machine), 0xe2000000, "zynq.pflash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           FLASH_SECTOR_SIZE, 1,
                           1, 0x0066, 0x0022, 0x0000, 0x0000, 0x0555, 0x2aa,
diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
index 4050750e65..955abb9c4c 100644
--- a/hw/block/fdc-sysbus.c
+++ b/hw/block/fdc-sysbus.c
@@ -96,30 +96,31 @@ static void fdctrl_handle_tc(void *opaque, int irq, int level)
     trace_fdctrl_tc_pulse(level);
 }
 
-void fdctrl_init_sysbus(qemu_irq irq, hwaddr mmio_base, DriveInfo **fds)
+void fdctrl_init_sysbus(Object *parent, qemu_irq irq, hwaddr mmio_base,
+                        DriveInfo **fds)
 {
     DeviceState *dev;
     SysBusDevice *sbd;
     FDCtrlSysBus *sys;
 
-    dev = qdev_new_orphan("sysbus-fdc");
+    dev = qdev_new(parent, "fdc", "sysbus-fdc");
     sys = SYSBUS_FDC(dev);
     sbd = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_realize(sbd, &error_fatal);
     sysbus_connect_irq(sbd, 0, irq);
     sysbus_mmio_map(sbd, 0, mmio_base);
 
     fdctrl_init_drives(&sys->state.bus, fds);
 }
 
-void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
+void sun4m_fdctrl_init(Object *parent, qemu_irq irq, hwaddr io_base,
                        DriveInfo **fds, qemu_irq *fdc_tc)
 {
     DeviceState *dev;
     FDCtrlSysBus *sys;
 
-    dev = qdev_new_orphan("sun-fdtwo");
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(parent, "fdc", "sun-fdtwo");
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sys = SYSBUS_FDC(dev);
     sysbus_connect_irq(SYS_BUS_DEVICE(sys), 0, irq);
     sysbus_mmio_map(SYS_BUS_DEVICE(sys), 0, io_base);
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index baac5f3c19..02508c79aa 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2329,12 +2329,12 @@ void fdctrl_init_drives(FloppyBus *bus, DriveInfo **fds)
 
     for (i = 0; i < MAX_FD; i++) {
         if (fds[i]) {
-            dev = qdev_new_orphan("floppy");
+            dev = qdev_new(OBJECT(bus->bus.parent), "floppy[*]", "floppy");
             qdev_prop_set_uint32(dev, "unit", i);
             qdev_prop_set_enum(dev, "drive-type", FLOPPY_DRIVE_TYPE_AUTO);
             qdev_prop_set_drive_err(dev, "drive", blk_by_legacy_dinfo(fds[i]),
                                     &error_fatal);
-            qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
+            qdev_realize(dev, &bus->bus, &error_fatal);
         }
     }
 }
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 0466682ca8..d584d7ea9f 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -948,7 +948,7 @@ static const TypeInfo pflash_cfi01_types[] = {
 
 DEFINE_TYPES(pflash_cfi01_types)
 
-PFlashCFI01 *pflash_cfi01_register(hwaddr base,
+PFlashCFI01 *pflash_cfi01_register(Object *parent, hwaddr base,
                                    const char *name,
                                    hwaddr size,
                                    BlockBackend *blk,
@@ -958,7 +958,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
                                    uint16_t id2, uint16_t id3,
                                    int be)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(parent, name, TYPE_PFLASH_CFI01);
 
     if (blk) {
         qdev_prop_set_drive(dev, "drive", blk);
@@ -973,7 +973,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
     qdev_prop_set_uint16(dev, "id2", id2);
     qdev_prop_set_uint16(dev, "id3", id3);
     qdev_prop_set_string(dev, "name", name);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     return PFLASH_CFI01(dev);
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index a22bdc5830..0dbd173be0 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -993,7 +993,7 @@ static void pflash_cfi02_register_types(void)
 
 type_init(pflash_cfi02_register_types)
 
-PFlashCFI02 *pflash_cfi02_register(hwaddr base,
+PFlashCFI02 *pflash_cfi02_register(Object *parent, hwaddr base,
                                    const char *name,
                                    hwaddr size,
                                    BlockBackend *blk,
@@ -1005,7 +1005,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
                                    uint16_t unlock_addr1,
                                    int be)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI02);
+    DeviceState *dev = qdev_new(parent, name, TYPE_PFLASH_CFI02);
 
     if (blk) {
         qdev_prop_set_drive(dev, "drive", blk);
@@ -1023,7 +1023,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
     qdev_prop_set_uint16(dev, "unlock-addr0", unlock_addr0);
     qdev_prop_set_uint16(dev, "unlock-addr1", unlock_addr1);
     qdev_prop_set_string(dev, "name", name);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     return PFLASH_CFI02(dev);
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 031de37cec..b77df1132b 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -105,7 +105,8 @@ petalogix_ml605_init(MachineState *machine)
     dinfo = drive_get(IF_PFLASH, 0, 0);
     /* 5th parameter 2 means bank-width
      * 10th parameter 0 means little-endian */
-    pflash_cfi01_register(FLASH_BASEADDR, "petalogix_ml605.flash", FLASH_SIZE,
+    pflash_cfi01_register(OBJECT(machine), FLASH_BASEADDR,
+                          "petalogix_ml605.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           64 * KiB, 2, 0x89, 0x18, 0x0000, 0x0, 0);
 
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index b4327ad493..0979d3632b 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -102,7 +102,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     memory_region_add_subregion(sysmem, ddr_base, phys_ram);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
-    pflash_cfi01_register(FLASH_BASEADDR,
+    pflash_cfi01_register(OBJECT(machine), FLASH_BASEADDR,
                           "petalogix_s3adsp1800.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 938aaf3fe1..13eaa2d2ec 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -351,7 +351,8 @@ static void mips_jazz_init(MachineState *machine,
         fds[n] = drive_get(IF_FLOPPY, 0, n);
     }
     /* FIXME: we should enable DMA with a custom IsaDma device */
-    fdctrl_init_sysbus(qdev_get_gpio_in(rc4030, 1), 0x80003000, fds);
+    fdctrl_init_sysbus(OBJECT(machine), qdev_get_gpio_in(rc4030, 1),
+                       0x80003000, fds);
 
     /* Real time clock */
     mc146818_rtc_init(OBJECT(machine), isa_bus, 1980, NULL);
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 52aae144da..8dc7429ac9 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1137,7 +1137,7 @@ void mips_malta_init(MachineState *machine)
 
     /* Load firmware in flash / BIOS. */
     dinfo = drive_get(IF_PFLASH, 0, fl_idx);
-    fl = pflash_cfi01_register(FLASH_ADDRESS, "mips_malta.bios",
+    fl = pflash_cfi01_register(OBJECT(machine), FLASH_ADDRESS, "mips_malta.bios",
                                FLASH_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                65536,
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 8623848633..41d4670fa8 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -83,7 +83,7 @@ struct boot_info {
     uint32_t entry;
 };
 
-static int sam460ex_load_uboot(void)
+static int sam460ex_load_uboot(Object *parent)
 {
     /*
      * This first creates 1MiB of flash memory mapped at the end of
@@ -106,7 +106,8 @@ static int sam460ex_load_uboot(void)
     DriveInfo *dinfo;
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
-    if (!pflash_cfi01_register(FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32),
+    if (!pflash_cfi01_register(parent,
+                               FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32),
                                "sam460ex.flash", FLASH_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1)) {
@@ -459,7 +460,7 @@ static void sam460ex_init(MachineState *machine)
 
     /* Load U-Boot image. */
     if (!machine->kernel_filename) {
-        success = sam460ex_load_uboot();
+        success = sam460ex_load_uboot(OBJECT(machine));
         if (success < 0) {
             error_report("could not load firmware");
             exit(1);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 9163d8acf8..1379c168d3 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -213,7 +213,7 @@ static void virtex_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, ram_base, machine->ram);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
-    pflash_cfi01_register(PFLASH_BASEADDR, "virtex.flash", FLASH_SIZE,
+    pflash_cfi01_register(OBJECT(machine), PFLASH_BASEADDR, "virtex.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
 
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index c0f8cad335..c03df91aca 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -309,7 +309,7 @@ static void r2d_init(MachineState *machine)
      * addressable in words of 16bit.
      */
     dinfo = drive_get(IF_PFLASH, 0, 0);
-    pflash_cfi02_register(0x0, "r2d.flash", FLASH_SIZE,
+    pflash_cfi02_register(OBJECT(machine), 0x0, "r2d.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           64 * KiB, 1, 2, 0x0001, 0x227e, 0x2220, 0x2200,
                           0x555, 0x2aa, 0);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index b0f018a3c5..144345d46a 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -1015,7 +1015,7 @@ static void sun4m_hw_init(MachineState *machine)
         /* there is zero or one floppy drive */
         memset(fd, 0, sizeof(fd));
         fd[0] = drive_get(IF_FLOPPY, 0, 0);
-        sun4m_fdctrl_init(slavio_irq[22], hwdef->fd_base, fd,
+        sun4m_fdctrl_init(OBJECT(machine), slavio_irq[22], hwdef->fd_base, fd,
                           &fdc_tc);
     } else {
         fdc_tc = qemu_allocate_irq(dummy_fdc_tc, NULL, 0);
diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index c367c5efea..7ff6681835 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -10,8 +10,9 @@
 #define TYPE_ISA_FDC "isa-fdc"
 
 void isa_fdc_init_drives(ISADevice *fdc, DriveInfo **fds);
-void fdctrl_init_sysbus(qemu_irq irq, hwaddr mmio_base, DriveInfo **fds);
-void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
+void fdctrl_init_sysbus(Object *parent, qemu_irq irq, hwaddr mmio_base,
+                        DriveInfo **fds);
+void sun4m_fdctrl_init(Object *parent, qemu_irq irq, hwaddr io_base,
                        DriveInfo **fds, qemu_irq *fdc_tc);
 
 void isa_fdc_set_iobase(ISADevice *fdc, hwaddr iobase);
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 3671f0174d..c005b707b2 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -12,7 +12,7 @@
 OBJECT_DECLARE_SIMPLE_TYPE(PFlashCFI01, PFLASH_CFI01)
 
 
-PFlashCFI01 *pflash_cfi01_register(hwaddr base,
+PFlashCFI01 *pflash_cfi01_register(Object *parent, hwaddr base,
                                    const char *name,
                                    hwaddr size,
                                    BlockBackend *blk,
@@ -31,7 +31,7 @@ void pflash_cfi01_legacy_drive(PFlashCFI01 *dev, DriveInfo *dinfo);
 OBJECT_DECLARE_SIMPLE_TYPE(PFlashCFI02, PFLASH_CFI02)
 
 
-PFlashCFI02 *pflash_cfi02_register(hwaddr base,
+PFlashCFI02 *pflash_cfi02_register(Object *parent, hwaddr base,
                                    const char *name,
                                    hwaddr size,
                                    BlockBackend *blk,
-- 
2.47.1


