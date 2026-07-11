Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1EAC44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigUL-0000hh-8s; Sat, 11 Jul 2026 18:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigU1-0000Yz-Fc; Sat, 11 Jul 2026 18:47:43 -0400
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.26.1.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigTx-0007Td-IH; Sat, 11 Jul 2026 18:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810057; x=1815346057;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zLaJZbstl8kCaT47m5gOMY1Yj7cW3tZOc71HipZg02k=;
 b=BEgVXP6CUp9JzgDnM/L9BleklE+aLt9bsTIZRM3VpgOHc3H32F4qmI1B
 CQrn0KMG2xlVIraHhKaBmMPlgqEzepHkgAaqHHFsSN55wVErvx7mWv7fZ
 00P8WiKrj/KIvYJuF7yr4SM6vvo0UlxQ6Uz3ndFHdAwkGT0fpSrWdPLxM
 q8kZthShfhKZuB7Q23S4PV747gfI9B0IuwQxMDoO0mByRhjPLzQdSkzzY
 XZveXF5CrQZ/FLxuxKNMPZxSfzB8Ex+Pvlv+uNoF0bmNVc3qXR7EuPD9J
 ASi+kkLAewLTrm3ygNWAUyUYH6DqNatfJ6HMlqLcs5VJC+kl/vG6N8opk g==;
X-CSE-ConnectionGUID: BMLkUgHzSReyuYV8Q3q0dQ==
X-CSE-MsgGUID: Z0LYEda1Qz2xFcxbk7MKXA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23522210"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:47:34 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:17375]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.115:2525]
 with esmtp (Farcaster)
 id 9086ab23-efe1-4c8d-a00a-cedf7874375c; Sat, 11 Jul 2026 22:47:33 +0000 (UTC)
X-Farcaster-Flow-ID: 9086ab23-efe1-4c8d-a00a-cedf7874375c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:47:33 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:47:25 +0000
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
Subject: [RFC PATCH 039/134] hw/ide: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:32 +0000
Message-ID: <20260711223707.42139-40-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.26.1.71;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/ide to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/ide/ide-bus.c:78 | qdev_new | OBJECT(bus->qbus.parent) | "drive[*]" | drive is child of the IDE controller device that owns the bus; helper called from many controllers so use bus->qbus.parent
hw/ide/isa.c:87 | isa_new | parent | "ide[*]" | helper called from isapc board init loop; thread Object *parent through isa_ide_init()

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/i386/isapc.c      | 3 ++-
 hw/ide/ide-bus.c     | 5 +++--
 hw/ide/isa.c         | 7 ++++---
 include/hw/ide/isa.h | 3 ++-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 655ec599b5..c2a3f23f2c 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -142,7 +142,8 @@ static void pc_init_isa(MachineState *machine)
     for (i = 0; i < MAX_IDE_BUS; i++) {
         ISADevice *dev;
         char busname[] = "ide.0";
-        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+        dev = isa_ide_init(OBJECT(machine), isa_bus,
+                            ide_iobase[i], ide_iobase2[i],
                             ide_irq[i],
                             hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
         /*
diff --git a/hw/ide/ide-bus.c b/hw/ide/ide-bus.c
index 40ba94235f..4473709a04 100644
--- a/hw/ide/ide-bus.c
+++ b/hw/ide/ide-bus.c
@@ -75,11 +75,12 @@ IDEDevice *ide_bus_create_drive(IDEBus *bus, int unit, DriveInfo *drive)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan(drive->media_cd ? "ide-cd" : "ide-hd");
+    dev = qdev_new(OBJECT(bus->qbus.parent), "drive[*]",
+                   drive->media_cd ? "ide-cd" : "ide-hd");
     qdev_prop_set_uint32(dev, "unit", unit);
     qdev_prop_set_drive_err(dev, "drive", blk_by_legacy_dinfo(drive),
                             &error_fatal);
-    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
+    qdev_realize(dev, &bus->qbus, &error_fatal);
     return DO_UPCAST(IDEDevice, qdev, dev);
 }
 
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index c9c997344b..37457be035 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -77,19 +77,20 @@ static void isa_ide_realizefn(DeviceState *dev, Error **errp)
     ide_bus_register_restart_cb(&s->bus);
 }
 
-ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int irqnum,
+ISADevice *isa_ide_init(Object *parent, ISABus *bus,
+                        int iobase, int iobase2, int irqnum,
                         DriveInfo *hd0, DriveInfo *hd1)
 {
     DeviceState *dev;
     ISADevice *isadev;
     ISAIDEState *s;
 
-    isadev = isa_new_orphan(TYPE_ISA_IDE);
+    isadev = isa_new(parent, "ide[*]", TYPE_ISA_IDE);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "iobase",  iobase);
     qdev_prop_set_uint32(dev, "iobase2", iobase2);
     qdev_prop_set_uint32(dev, "irq",     irqnum);
-    isa_realize_and_unref(isadev, bus, &error_fatal);
+    qdev_realize(dev, BUS(bus), &error_fatal);
 
     s = ISA_IDE(dev);
     if (hd0) {
diff --git a/include/hw/ide/isa.h b/include/hw/ide/isa.h
index 1cd0ff1fa6..18fe363a1a 100644
--- a/include/hw/ide/isa.h
+++ b/include/hw/ide/isa.h
@@ -14,7 +14,8 @@
 #define TYPE_ISA_IDE "isa-ide"
 OBJECT_DECLARE_SIMPLE_TYPE(ISAIDEState, ISA_IDE)
 
-ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int irqnum,
+ISADevice *isa_ide_init(Object *parent, ISABus *bus,
+                        int iobase, int iobase2, int irqnum,
                         DriveInfo *hd0, DriveInfo *hd1);
 
 #endif
-- 
2.47.1


