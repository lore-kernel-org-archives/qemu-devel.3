Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2921DC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigPs-0008Qu-My; Sat, 11 Jul 2026 18:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigPR-00083V-NZ; Sat, 11 Jul 2026 18:42:59 -0400
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.35.192.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigPN-0006N2-Q3; Sat, 11 Jul 2026 18:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809773; x=1815345773;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=amUTtS63hZcSlS7OoveApwBcr3wy0b53OLhAMkpFVuY=;
 b=gsR6QgCsFYKQv6FnrtFNwcTpmeP66PjcZ/nn5NN9VFLCpLPJTi7k0CjO
 huzAwYKGLuHHURA1SUurIq1KXu5aJEhfIh6vWnVKYyR23mM6nGUqJNI4M
 9yRh4nSceui2bc5e4/cnnpl1EGde6geaHveTzqOJiOXcdt1P26lCG5ddT
 UIcVs4ILdIYWjN/E4cE/RJBb4xmIgOD1PMHx1pr0RngoiwTnmVUwSERLy
 hFd+qMxekzK2ce3k+4YNBfrpvuNk2PgreUPJ9cVz9MMbpGlC/k9QR/DYY
 Sb0K03HUR2IJgEFnPLajRaRc+yNC1Ow4fyraZSy8hujUTThdZMSh4OcLb w==;
X-CSE-ConnectionGUID: MWq9QtFtQgy8xqEt9S2dPw==
X-CSE-MsgGUID: U34BOxd1Qg6i19uikBh5vg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23269615"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:42:50 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:27198]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.33:2525]
 with esmtp (Farcaster)
 id a184983d-b27e-49e2-acad-b48f7b292003; Sat, 11 Jul 2026 22:42:50 +0000 (UTC)
X-Farcaster-Flow-ID: a184983d-b27e-49e2-acad-b48f7b292003
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:42:49 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:42:41 +0000
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
Subject: [RFC PATCH 021/134] hw/loongarch: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:14 +0000
Message-ID: <20260711223707.42139-22-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.35.192.45;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/loongarch to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

file:line | creator | parent | name | rationale
hw/loongarch/virt.c:153 | qdev_new | OBJECT(lvms) | name | board-init helper already receives lvms + child name; drop redundant object_property_add_child()
hw/loongarch/virt.c:298 | qdev_new | OBJECT(lvms) | "acpi-ged" | board-init helper receives LoongArchVirtMachineState *lvms
hw/loongarch/virt.c:325 | qdev_new | parent | "platform-bus" | static helper w/o parent ptr; add Object *parent first arg, thread OBJECT(lvms) from caller
hw/loongarch/virt.c:403 | qdev_new | OBJECT(lvms) | "pci-host" | board-init helper receives lvms
hw/loongarch/virt.c:488 | sysbus_create_simple | OBJECT(lvms) | "rtc" | board-init helper receives lvms
hw/loongarch/virt.c:604 | qdev_new | OBJECT(lvms) | "ipi" | virt_irq_init() receives lvms
hw/loongarch/virt.c:610 | qdev_new | OBJECT(lvms) | "dintc" | virt_irq_init() receives lvms
hw/loongarch/virt.c:617 | qdev_new | OBJECT(lvms) | "extioi" | virt_irq_init() receives lvms
hw/loongarch/virt.c:625 | qdev_new | OBJECT(lvms) | "pch-pic" | virt_irq_init() receives lvms
hw/loongarch/virt.c:631 | qdev_new | OBJECT(lvms) | "pch-msi" | virt_irq_init() receives lvms

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/loongarch/virt.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 45acdc3ec1..6ba693874f 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -150,7 +150,7 @@ static PFlashCFI01 *virt_flash_create1(LoongArchVirtMachineState *lvms,
                                        const char *name,
                                        const char *alias_prop_name)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(OBJECT(lvms), name, TYPE_PFLASH_CFI01);
 
     qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 4);
@@ -161,7 +161,6 @@ static PFlashCFI01 *virt_flash_create1(LoongArchVirtMachineState *lvms,
     qdev_prop_set_uint16(dev, "id2", 0x00);
     qdev_prop_set_uint16(dev, "id3", 0x00);
     qdev_prop_set_string(dev, "name", name);
-    object_property_add_child(OBJECT(lvms), name, OBJECT(dev));
     object_property_add_alias(OBJECT(lvms), alias_prop_name,
                               OBJECT(dev), "drive");
     return PFLASH_CFI01(dev);
@@ -191,7 +190,7 @@ static void virt_flash_map1(PFlashCFI01 *flash,
     assert(real_size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
 
     qdev_prop_set_uint32(dev, "num-blocks", real_size / VIRT_FLASH_SECTOR_SIZE);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 }
@@ -295,9 +294,9 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic,
         event |= ACPI_GED_CPU_HOTPLUG_EVT;
     }
 
-    dev = qdev_new_orphan(TYPE_ACPI_GED);
+    dev = qdev_new(OBJECT(lvms), "acpi-ged", TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* ged event */
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, VIRT_GED_EVT_ADDR);
@@ -315,18 +314,18 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic,
     return dev;
 }
 
-static DeviceState *create_platform_bus(DeviceState *pch_pic)
+static DeviceState *create_platform_bus(Object *parent, DeviceState *pch_pic)
 {
     DeviceState *dev;
     SysBusDevice *sysbus;
     int i, irq;
     MemoryRegion *sysmem = get_system_memory();
 
-    dev = qdev_new_orphan(TYPE_PLATFORM_BUS_DEVICE);
+    dev = qdev_new(parent, "platform-bus", TYPE_PLATFORM_BUS_DEVICE);
     dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
     qdev_prop_set_uint32(dev, "num_irqs", VIRT_PLATFORM_BUS_NUM_IRQS);
     qdev_prop_set_uint32(dev, "mmio_size", VIRT_PLATFORM_BUS_SIZE);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus = SYS_BUS_DEVICE(dev);
     for (i = 0; i < VIRT_PLATFORM_BUS_NUM_IRQS; i++) {
@@ -400,9 +399,9 @@ static void virt_devices_init(DeviceState *pch_pic,
     hwaddr mmio_base, mmio_size;
     int i, irq;
 
-    gpex_dev = qdev_new_orphan(TYPE_GPEX_HOST);
+    gpex_dev = qdev_new(OBJECT(lvms), "pci-host", TYPE_GPEX_HOST);
     d = SYS_BUS_DEVICE(gpex_dev);
-    sysbus_realize_and_unref(d, &error_fatal);
+    sysbus_realize(d, &error_fatal);
     pci_bus = PCI_HOST_BRIDGE(gpex_dev)->bus;
     lvms->gpex.pio.base = VIRT_PCI_IO_BASE;
     lvms->gpex.pio.size = VIRT_PCI_IO_SIZE;
@@ -485,14 +484,14 @@ static void virt_devices_init(DeviceState *pch_pic,
      * Create some unimplemented devices to emulate this.
      */
     create_unimplemented_device("pci-dma-cfg", 0x1001041c, 0x4);
-    sysbus_create_simple_orphan("ls7a_rtc", VIRT_RTC_REG_BASE,
+    sysbus_create_simple(OBJECT(lvms), "rtc", "ls7a_rtc", VIRT_RTC_REG_BASE,
                          qdev_get_gpio_in(pch_pic,
                          VIRT_RTC_IRQ - VIRT_GSI_BASE));
 
     /* acpi ged */
     lvms->acpi_ged = create_acpi_ged(pch_pic, lvms);
     /* platform bus */
-    lvms->platform_bus_dev = create_platform_bus(pch_pic);
+    lvms->platform_bus_dev = create_platform_bus(OBJECT(lvms), pch_pic);
 }
 
 static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
@@ -601,40 +600,40 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
      */
 
     /* Create IPI device */
-    ipi = qdev_new_orphan(TYPE_LOONGARCH_IPI);
+    ipi = qdev_new(OBJECT(lvms), "ipi", TYPE_LOONGARCH_IPI);
     lvms->ipi = ipi;
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(ipi), &error_fatal);
 
     /* Create DINTC device*/
     if (virt_has_dmsi(lvms)) {
-        dintc = qdev_new_orphan(TYPE_LOONGARCH_DINTC);
+        dintc = qdev_new(OBJECT(lvms), "dintc", TYPE_LOONGARCH_DINTC);
         lvms->dintc = dintc;
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dintc), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(dintc), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dintc), 0, VIRT_DINTC_BASE);
     }
 
     /* Create EXTIOI device */
-    extioi = qdev_new_orphan(TYPE_LOONGARCH_EXTIOI);
+    extioi = qdev_new(OBJECT(lvms), "extioi", TYPE_LOONGARCH_EXTIOI);
     lvms->extioi = extioi;
     if (virt_is_veiointc_enabled(lvms)) {
         qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
     }
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(extioi), &error_fatal);
 
     virt_cpu_irq_init(lvms);
-    pch_pic = qdev_new_orphan(TYPE_LOONGARCH_PIC);
+    pch_pic = qdev_new(OBJECT(lvms), "pch-pic", TYPE_LOONGARCH_PIC);
     num = VIRT_PCH_PIC_IRQ_NUM;
     qdev_prop_set_uint32(pch_pic, "pch_pic_irq_num", num);
     d = SYS_BUS_DEVICE(pch_pic);
-    sysbus_realize_and_unref(d, &error_fatal);
+    sysbus_realize(d, &error_fatal);
 
-    pch_msi = qdev_new_orphan(TYPE_LOONGARCH_PCH_MSI);
+    pch_msi = qdev_new(OBJECT(lvms), "pch-msi", TYPE_LOONGARCH_PCH_MSI);
     start   =  num;
     num = EXTIOI_IRQS - start;
     qdev_prop_set_uint32(pch_msi, "msi_irq_base", start);
     qdev_prop_set_uint32(pch_msi, "msi_irq_num", num);
     d = SYS_BUS_DEVICE(pch_msi);
-    sysbus_realize_and_unref(d, &error_fatal);
+    sysbus_realize(d, &error_fatal);
     sysbus_mmio_map(d, 0, VIRT_PCH_MSI_ADDR_LOW);
 
     if (kvm_irqchip_in_kernel()) {
-- 
2.47.1


