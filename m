Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D49EC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigTP-0008Ia-Ag; Sat, 11 Jul 2026 18:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigTN-0008Fr-3j; Sat, 11 Jul 2026 18:47:01 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigTK-0007Nw-Qc; Sat, 11 Jul 2026 18:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810018; x=1815346018;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mdOsMUFO/NU8q1XiktFg86KqJ+PNpvF4Jt1vctgje9g=;
 b=ObryqyVo8GEJ3cOwN26wJ40kDjRNdoLU4jr5ztoK9Qzb+OJO0qbAsPNZ
 BDyR7sxXDxYA0EE+UFDQjVGHE47NbNsd9md8V/fFHyLCcrMjsCaD1k0C3
 Gk1pBxLOvmt8VSXdmXdZsMBR/mwRV+gFnLg0b/HlFe7IOe30oVgxI/Aa9
 dBDNsTwduD8ynNNXzTn7K60FFqLLNAm8e7o6HHGVn0g2z+E/6JWw9+7BL
 R1VLD0hSAfunVQEdkCIWBzxvE0exn5ZFLgVdaMioHc50Xwn6HH+PE3joc
 gkdiwgVT4+rPA3GDd4CJLUYxHAaZ/weoVExqkfuGBjRu/89H43IXLIsfM Q==;
X-CSE-ConnectionGUID: 0qfZ9PztQ1Wo4RbpC6xzmw==
X-CSE-MsgGUID: wxTjDXMFTPOf4o53CSElRw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="22997502"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:46:55 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:24563]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.175:2525]
 with esmtp (Farcaster)
 id 1c2cdcaf-e3c4-4985-b77a-d079dffc5609; Sat, 11 Jul 2026 22:46:55 +0000 (UTC)
X-Farcaster-Flow-ID: 1c2cdcaf-e3c4-4985-b77a-d079dffc5609
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:46:54 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:46:46 +0000
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
Subject: [RFC PATCH 037/134] hw/scsi: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:30 +0000
Message-ID: <20260711223707.42139-38-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.245.243.92;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/scsi to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/scsi/lasi_ncr710.c:234 | qdev_new | parent | "scsi" | thread Object *parent as first arg; single caller in hw/hppa/machine.c board init passes OBJECT(machine)
hw/scsi/ncr53c710.c:2379 | qdev_new | parent | "scsi" | thread Object *parent as first arg; no in-tree callers, header updated
hw/scsi/ncr53c710.c:2397 | qdev_new | parent | "scsi" | thread Object *parent as first arg; no in-tree callers, header updated
hw/scsi/scsi-bus.c:448 | qdev_new | OBJECT(bus) | name | collapse existing object_property_add_child(OBJECT(bus), name, dev); keep dynamic legacy[%d] name
hw/scsi/spapr_vscsi.c:1238 | qdev_new | parent | "vscsi[*]" | thread Object *parent as first arg; single caller in hw/ppc/spapr.c board init loop passes OBJECT(spapr)

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/hppa/machine.c          |  2 +-
 hw/ppc/spapr.c             |  2 +-
 hw/scsi/lasi_ncr710.c      |  8 ++++----
 hw/scsi/lasi_ncr710.h      |  4 ++--
 hw/scsi/ncr53c710.c        | 15 ++++++++-------
 hw/scsi/ncr53c710.h        |  7 ++++---
 hw/scsi/scsi-bus.c         |  5 ++---
 hw/scsi/spapr_vscsi.c      |  6 +++---
 include/hw/ppc/spapr_vio.h |  2 +-
 9 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index e50f9adf41..e3c9053bf2 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -631,7 +631,7 @@ static void machine_HP_715_init(MachineState *machine)
                                                        1));
     /* SCSI disk setup. */
     if (drive_get_max_bus(IF_SCSI) >= 0) {
-        dev = lasi_ncr710_init(addr_space,
+        dev = lasi_ncr710_init(OBJECT(machine), addr_space,
                                translate(NULL, LASI_HPA_715 + 0x6000),
                                qdev_get_gpio_in(lasi_dev, LASI_IRQ_SCSI_HPA));
         assert(dev);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e09b529ebc..91f9d873b8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3062,7 +3062,7 @@ static void spapr_machine_init(MachineState *machine)
     pci_init_nic_devices(phb->bus, NULL);
 
     for (i = 0; i <= drive_get_max_bus(IF_SCSI); i++) {
-        spapr_vscsi_create(spapr->vio_bus);
+        spapr_vscsi_create(OBJECT(spapr), spapr->vio_bus);
     }
 
     /* Graphics */
diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index e1a1f68aaa..d40bc62157 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -224,18 +224,18 @@ void lasi_ncr710_handle_legacy_cmdline(DeviceState *lasi_dev)
     }
 }
 
-DeviceState *lasi_ncr710_init(MemoryRegion *addr_space, hwaddr hpa,
-                               qemu_irq irq)
+DeviceState *lasi_ncr710_init(Object *parent, MemoryRegion *addr_space,
+                              hwaddr hpa, qemu_irq irq)
 {
     DeviceState *dev;
     LasiNCR710State *s;
     SysBusDevice *sbd;
 
-    dev = qdev_new_orphan(TYPE_LASI_NCR710);
+    dev = qdev_new(parent, "scsi", TYPE_LASI_NCR710);
     s = LASI_NCR710(dev);
     sbd = SYS_BUS_DEVICE(dev);
     s->lasi_irq = irq;
-    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_realize(sbd, &error_fatal);
     memory_region_add_subregion(addr_space, hpa,
                                sysbus_mmio_get_region(sbd, 0));
     return dev;
diff --git a/hw/scsi/lasi_ncr710.h b/hw/scsi/lasi_ncr710.h
index 450fb7e1c3..e963a6511f 100644
--- a/hw/scsi/lasi_ncr710.h
+++ b/hw/scsi/lasi_ncr710.h
@@ -48,8 +48,8 @@ typedef struct LasiNCR710State {
     NCR710State ncr710;
 } LasiNCR710State;
 
-DeviceState *lasi_ncr710_init(MemoryRegion *addr_space, hwaddr hpa,
-                               qemu_irq irq);
+DeviceState *lasi_ncr710_init(Object *parent, MemoryRegion *addr_space,
+                              hwaddr hpa, qemu_irq irq);
 void lasi_ncr710_handle_legacy_cmdline(DeviceState *lasi_dev);
 
 #endif
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 54ce2df641..633a76c70b 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -2371,22 +2371,23 @@ static const VMStateDescription vmstate_sysbus_ncr710 = {
     }
 };
 
-DeviceState *ncr710_device_create_sysbus(hwaddr addr, qemu_irq irq)
+DeviceState *ncr710_device_create_sysbus(Object *parent, hwaddr addr,
+                                          qemu_irq irq)
 {
     DeviceState *dev;
     SysBusDevice *sysbus;
 
-    dev = qdev_new_orphan(TYPE_SYSBUS_NCR710_SCSI);
+    dev = qdev_new(parent, "scsi", TYPE_SYSBUS_NCR710_SCSI);
     sysbus = SYS_BUS_DEVICE(dev);
 
-    qdev_realize_and_unref(dev, NULL, &error_abort);
+    qdev_realize(dev, NULL, &error_abort);
     sysbus_mmio_map(sysbus, 0, addr);
     sysbus_connect_irq(sysbus, 0, irq);
     return dev;
 }
 
-DeviceState *ncr53c710_init(MemoryRegion *address_space, hwaddr addr,
-                             qemu_irq irq)
+DeviceState *ncr53c710_init(Object *parent, MemoryRegion *address_space,
+                            hwaddr addr, qemu_irq irq)
 {
     DeviceState *dev;
     SysBusDevice *sysbus;
@@ -2394,10 +2395,10 @@ DeviceState *ncr53c710_init(MemoryRegion *address_space, hwaddr addr,
 
     /* trace_ncr710_device_init(addr); */
 
-    dev = qdev_new_orphan(TYPE_SYSBUS_NCR710_SCSI);
+    dev = qdev_new(parent, "scsi", TYPE_SYSBUS_NCR710_SCSI);
     sysbus = SYS_BUS_DEVICE(dev);
 
-    qdev_realize_and_unref(dev, NULL, &error_abort);
+    qdev_realize(dev, NULL, &error_abort);
     sysbus_mmio_map(sysbus, 0, addr);
     sysbus_connect_irq(sysbus, 0, irq);
 
diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 00b6a01577..6e466d6a36 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -229,9 +229,10 @@ static inline SysBusNCR710State *sysbus_from_ncr710(NCR710State *s)
     return container_of(s, SysBusNCR710State, ncr710);
 }
 
-DeviceState *ncr53c710_init(MemoryRegion *address_space, hwaddr addr,
-                             qemu_irq irq);
-DeviceState *ncr710_device_create_sysbus(hwaddr addr, qemu_irq irq);
+DeviceState *ncr53c710_init(Object *parent, MemoryRegion *address_space,
+                            hwaddr addr, qemu_irq irq);
+DeviceState *ncr710_device_create_sysbus(Object *parent, hwaddr addr,
+                                          qemu_irq irq);
 void ncr710_reg_write(void *opaque, hwaddr addr, uint64_t val, unsigned size);
 uint64_t ncr710_reg_read(void *opaque, hwaddr addr, unsigned size);
 void ncr710_soft_reset(NCR710State *s);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 806a20baee..bc7cfea6ed 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -445,9 +445,8 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
             driver = "scsi-hd";
         }
     }
-    dev = qdev_new_orphan(driver);
     name = g_strdup_printf("legacy[%d]", unit);
-    object_property_add_child(OBJECT(bus), name, OBJECT(dev));
+    dev = qdev_new(OBJECT(bus), name, driver);
     g_free(name);
 
     s = SCSI_DEVICE(dev);
@@ -473,7 +472,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
         return NULL;
     }
 
-    if (!qdev_realize_and_unref(dev, &bus->qbus, errp)) {
+    if (!qdev_realize(dev, &bus->qbus, errp)) {
         object_unparent(OBJECT(dev));
         return NULL;
     }
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 492d7d18a2..95cd21ffbb 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1231,13 +1231,13 @@ static void spapr_vscsi_realize(SpaprVioDevice *dev, Error **errp)
     qbus_set_hotplug_handler(BUS(&s->bus), NULL);
 }
 
-void spapr_vscsi_create(SpaprVioBus *bus)
+void spapr_vscsi_create(Object *parent, SpaprVioBus *bus)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan("spapr-vscsi");
+    dev = qdev_new(parent, "vscsi[*]", "spapr-vscsi");
 
-    qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
+    qdev_realize(dev, &bus->bus, &error_fatal);
     scsi_bus_legacy_handle_cmdline(&VIO_SPAPR_VSCSI_DEVICE(dev)->bus);
 }
 
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 0ea0dbae8b..72baef6919 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -139,7 +139,7 @@ SpaprVioDevice *vty_lookup(SpaprMachineState *spapr, target_ulong reg);
 void vty_putchars(SpaprVioDevice *sdev, uint8_t *buf, int len);
 void spapr_vty_create(SpaprVioBus *bus, Chardev *chardev);
 void spapr_vlan_create(SpaprVioBus *bus, NICInfo *nd);
-void spapr_vscsi_create(SpaprVioBus *bus);
+void spapr_vscsi_create(Object *parent, SpaprVioBus *bus);
 
 SpaprVioDevice *spapr_vty_get_default(SpaprVioBus *bus);
 
-- 
2.47.1


