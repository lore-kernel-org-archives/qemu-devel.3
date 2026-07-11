Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84705C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigl1-0001UL-TA; Sat, 11 Jul 2026 19:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigkx-0001TX-Mb; Sat, 11 Jul 2026 19:05:11 -0400
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.77.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigkv-00035U-Mc; Sat, 11 Jul 2026 19:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811109; x=1815347109;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W9NMUE63sGoBFljEfTdcDeegt56zvHAcCeou8uRTEx4=;
 b=OmlmvqFiFRFfn6+nCgo9QR2CQVtCUzqQIg/OVYmPb04iswc2xLoslINj
 kavBRN7JgwT2QX4qjuXy6e/pn7rp8yDc/PPwGsx5u5vQeYoYSdAbbk7kj
 lrZI/eQX4JeOZW39rKnZAre0WQelXa+fvDAK9BfpRv7AeGWsafrWyNOGd
 9FKnBV7DFDc/DDEG96n/rpGckviEQwqJJHLrVinysQk4ROIrs/Syek2Uf
 yIUqVD7M9/37y3W3HGbaSsMMp39LvWVgx4Lo7xVKuhOdyXtOI29cfMUZ2
 dzYbfV5nOfbs3TxZDDtOjnd56SQRcRfwH9FWdyqv79xXOsS0L3xK3xbxJ Q==;
X-CSE-ConnectionGUID: 7IU69walTnKon8eXDZp++w==
X-CSE-MsgGUID: jQB4ERe0Tu22dq9WaEpJOg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23493370"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:05:06 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:26831]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.68:2525]
 with esmtp (Farcaster)
 id 77b236db-b737-411d-9117-2c00d568d606; Sat, 11 Jul 2026 23:05:05 +0000 (UTC)
X-Farcaster-Flow-ID: 77b236db-b737-411d-9117-2c00d568d606
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:05:05 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:04:57 +0000
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
Subject: [RFC PATCH 106/134] hw/ide: Let ide_init_ioport() take an explicit
 owner
Date: Sat, 11 Jul 2026 22:36:39 +0000
Message-ID: <20260711223707.42139-107-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.77.92;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
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

hw/ide/piix.c calls ide_init_ioport() with a NULL ISADevice because
the PIIX IDE function is a PCI device, not an ISA one.  That NULL
propagates to isa_register_portio_list() and from there to
portio_list_init() as owner==NULL, which the following commit turns
into a hard error.

Change ide_init_ioport() to take an Object *owner directly.  When the
owner is an ISADevice, keep the existing isa_register_portio_list()
path so isa_init_ioport() still records the base I/O port for firmware
paths.  When it is not (the PIIX case), register the port lists with
the given owner directly.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/ide/ide-internal.h |  2 +-
 hw/ide/ioport.c       | 37 ++++++++++++++++++++++++++-----------
 hw/ide/isa.c          |  2 +-
 hw/ide/piix.c         |  2 +-
 4 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/hw/ide/ide-internal.h b/hw/ide/ide-internal.h
index 281d07c9d5..3f48335cdf 100644
--- a/hw/ide/ide-internal.h
+++ b/hw/ide/ide-internal.h
@@ -419,7 +419,7 @@ uint32_t ide_data_readl(void *opaque, uint32_t addr);
 int ide_init_drive(IDEState *s, IDEDevice *dev, IDEDriveKind kind, Error **errp);
 void ide_exit(IDEState *s);
 void ide_bus_init_output_irq(IDEBus *bus, qemu_irq irq_out);
-int ide_init_ioport(IDEBus *bus, ISADevice *isa, int iobase, int iobase2);
+int ide_init_ioport(IDEBus *bus, Object *owner, int iobase, int iobase2);
 void ide_bus_set_irq(IDEBus *bus);
 void ide_bus_register_restart_cb(IDEBus *bus);
 
diff --git a/hw/ide/ioport.c b/hw/ide/ioport.c
index a2f457f0bd..afafe6844c 100644
--- a/hw/ide/ioport.c
+++ b/hw/ide/ioport.c
@@ -1,5 +1,5 @@
 /*
- * QEMU IDE disk and CD/DVD-ROM Emulator
+ * QEMU IDE Emulation: PIO ioport registration.
  *
  * Copyright (c) 2003 Fabrice Bellard
  * Copyright (c) 2006 Openedhand Ltd.
@@ -28,19 +28,34 @@
 #include "ide-internal.h"
 #include "trace.h"
 
-int ide_init_ioport(IDEBus *bus, ISADevice *dev, int iobase, int iobase2)
+int ide_init_ioport(IDEBus *bus, Object *owner, int iobase, int iobase2)
 {
+    ISADevice *isa = ISA_DEVICE(object_dynamic_cast(owner, TYPE_ISA_DEVICE));
     int ret;
 
-    /* ??? Assume only ISA and PCI configurations, and that the PCI-ISA
-       bridge has been setup properly to always register with ISA.  */
-    ret = isa_register_portio_list(dev, &bus->portio_list,
-                                   iobase, ide_portio_list, bus, "ide");
-
-    if (ret == 0 && iobase2) {
-        ret = isa_register_portio_list(dev, &bus->portio2_list,
-                                       iobase2, ide_portio2_list, bus, "ide");
+    if (isa) {
+        ret = isa_register_portio_list(isa, &bus->portio_list,
+                                       iobase, ide_portio_list, bus, "ide");
+        if (ret == 0 && iobase2) {
+            ret = isa_register_portio_list(isa, &bus->portio2_list,
+                                           iobase2, ide_portio2_list, bus,
+                                           "ide");
+        }
+        return ret;
     }
 
-    return ret;
+    /* PIIX3/4: no ISADevice, but ISA I/O space is set up by the PCI-ISA */
+    /* bridge; register the port lists directly with the given owner.   */
+    if (!isa_address_space_io(NULL)) {
+        return -ENODEV;
+    }
+    portio_list_init(&bus->portio_list, owner, ide_portio_list, bus, "ide");
+    portio_list_add(&bus->portio_list, isa_address_space_io(NULL), iobase);
+    if (iobase2) {
+        portio_list_init(&bus->portio2_list, owner,
+                         ide_portio2_list, bus, "ide");
+        portio_list_add(&bus->portio2_list,
+                        isa_address_space_io(NULL), iobase2);
+    }
+    return 0;
 }
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index 37457be035..7949625e00 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -71,7 +71,7 @@ static void isa_ide_realizefn(DeviceState *dev, Error **errp)
     ISAIDEState *s = ISA_IDE(dev);
 
     ide_bus_init(&s->bus, sizeof(s->bus), dev, 0, 2);
-    ide_init_ioport(&s->bus, isadev, s->iobase, s->iobase2);
+    ide_init_ioport(&s->bus, OBJECT(isadev), s->iobase, s->iobase2);
     ide_bus_init_output_irq(&s->bus, isa_get_irq(isadev, s->irqnum));
     vmstate_register_any(VMSTATE_IF(dev), &vmstate_ide_isa, s);
     ide_bus_register_restart_cb(&s->bus);
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index a0f2709c69..5c5b91fa52 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -134,7 +134,7 @@ static bool pci_piix_init_bus(PCIIDEState *d, unsigned i, Error **errp)
     int ret;
 
     ide_bus_init(&d->bus[i], sizeof(d->bus[i]), DEVICE(d), i, 2);
-    ret = ide_init_ioport(&d->bus[i], NULL, port_info[i].iobase,
+    ret = ide_init_ioport(&d->bus[i], OBJECT(d), port_info[i].iobase,
                           port_info[i].iobase2);
     if (ret) {
         error_setg_errno(errp, -ret, "Failed to realize %s port %u",
-- 
2.47.1


