Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61861C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCtE-0005Vd-Tn; Sat, 18 Jul 2026 17:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCtA-0005SZ-5W; Sat, 18 Jul 2026 17:48:04 -0400
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.77.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCt7-0003QN-W5; Sat, 18 Jul 2026 17:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411282; x=1815947282;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A0uhA2TQ/67sNL6YBQLGMXY3oNdmgpneOPifszqrkYM=;
 b=mVU1zFJwfusnLMZV27Hdzd9aDg0qQePyQ7QSy1Yg6vfRz8/LFQVkpHGb
 sGgfI8hGzaV4e1VGCIRpcfj9Uws1O62dTnRIQtORuJUhVI21c5+Sf24KU
 a7umPFZdNpHfXLoJ4X4VkSUor5lF4pdR0PRqmQz19TzGYu35pUfGjF3LE
 O5fwOoabxc6un2dLp8UlPcR+DLSmOBSILZvixCKlfNkc8Ilm9TPeI46mD
 1Iebm42LksEQ3uque2ivsHFy1NDP0r++9CwU58R9hICHxp4Y0y7Ksorgk
 9f6o6OiT0Vyxve+d/hDQ44uF85d3yGxWzen8gqLeNICWMy/nSpixnMDjb Q==;
X-CSE-ConnectionGUID: I7ClZN3cSJOtUP2c4KKkLQ==
X-CSE-MsgGUID: 7AITlsgPT+SPTMg/pkYSgQ==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23917268"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:47:57 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:23502]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.199:2525]
 with esmtp (Farcaster)
 id 1c6d06f7-c4d4-4a78-aa21-e3d85774003b; Sat, 18 Jul 2026 21:47:57 +0000 (UTC)
X-Farcaster-Flow-ID: 1c6d06f7-c4d4-4a78-aa21-e3d85774003b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:47:57 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:47:47 +0000
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
Subject: [RFC PATCH v2 039/137] hw/ide: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:14 +0000
Message-ID: <20260718213652.37673-40-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.77.92;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
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
AI-used-for: code (refactoring)
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


