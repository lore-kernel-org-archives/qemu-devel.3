Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FD3C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCsM-0003Pr-Qb; Sat, 18 Jul 2026 17:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCsL-0003OR-Hd; Sat, 18 Jul 2026 17:47:13 -0400
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([50.112.246.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCsI-0003N4-SR; Sat, 18 Jul 2026 17:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411230; x=1815947230;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fL/yJcxl4RA0CIp3u6PRl8YetVugPVwFHArL8hV4eXA=;
 b=eBuxxnhVgaWl5FDG5B7J9G9z0bbLZtAMO+AEs1dqfvkw8qkiQaKvqqp9
 CQxyHm0BXlo5sWzEJ9AagXI+Yh3rdLSoTgF8Tvgdgh3vSUX5n1vWBmJCO
 N2YzMG+/Wi94+Mnj5UZGP0A2HvrGzjP8omcl5lEkvf1liYKOe1y3n6ALl
 Y/SeGqEegamlSxD/paSQmKmsp/Xd43hc3z2TAPFqWx3wmFujZRtt3GfL2
 KFKPTCSnF698DYdZVDcIpEOy5dseLqjxh+HWVbpqnOQKG2sB19l89eori
 QjBr9I4xfVATdjyTeunYpm8wPyxvmwnANQrQkJjTpqCnbL8+xSVUwSW49 g==;
X-CSE-ConnectionGUID: kCwStPorRsWQ7rJzAZvg6A==
X-CSE-MsgGUID: jwgeimygQxiBXATBA+cTVQ==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23724879"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:47:07 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:29915]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.246:2525]
 with esmtp (Farcaster)
 id b432189c-9f51-4081-ac8f-31b6570ca702; Sat, 18 Jul 2026 21:47:07 +0000 (UTC)
X-Farcaster-Flow-ID: b432189c-9f51-4081-ac8f-31b6570ca702
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:47:06 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:46:57 +0000
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
Subject: [RFC PATCH v2 036/137] hw/misc: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:11 +0000
Message-ID: <20260718213652.37673-37-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
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
 SPF_HELO_NONE=0.001, T_FILL_THIS_FORM_SHORT=0.01, T_SPF_PERMERROR=0.01,
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

Convert the *_orphan() device-creation calls in hw/misc to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/misc/empty_slot.c:61 | qdev_new | parent | name | thread Object *parent as first arg; use existing name arg as child name; 7 callers updated (m68k next-cube, sparc sun4m, gt64120 realize)
hw/misc/led.c:144 | qdev_new | parentobj | name | already receives parentobj; collapse existing object_property_add_child(); compute name before create
hw/misc/sifive_e_prci.c:120 | qdev_new | parent | "prci" | thread Object *parent as first arg; single caller in sifive_e_soc_realize passes OBJECT(dev)
hw/misc/sifive_test.c:100 | qdev_new | parent | "test" | thread Object *parent as first arg; 2 callers (riscv virt, or1k virt) pass machine-state

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/m68k/next-cube.c             |  6 +++---
 hw/misc/empty_slot.c            |  7 ++++---
 hw/misc/led.c                   | 15 ++++++++-------
 hw/misc/sifive_e_prci.c         |  6 +++---
 hw/misc/sifive_test.c           |  6 +++---
 hw/or1k/virt.c                  |  2 +-
 hw/pci-host/gt64120.c           |  2 +-
 hw/riscv/sifive_e.c             |  2 +-
 hw/riscv/virt.c                 |  2 +-
 hw/sparc/sun4m.c                |  7 ++++---
 include/hw/misc/empty_slot.h    |  3 ++-
 include/hw/misc/sifive_e_prci.h |  2 +-
 include/hw/misc/sifive_test.h   |  2 +-
 13 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index d97168d9f3..530dc1ab59 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1292,9 +1292,9 @@ static void next_cube_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02106000);
 
     /* unknown: Brightness control register? */
-    empty_slot_init("next.unknown.0", 0x02110000, 0x10);
+    empty_slot_init(OBJECT(machine), "next.unknown.0", 0x02110000, 0x10);
     /* unknown: Magneto-Optical drive controller? */
-    empty_slot_init("next.unknown.1", 0x02112000, 0x10);
+    empty_slot_init(OBJECT(machine), "next.unknown.1", 0x02112000, 0x10);
 
     /* SCSI */
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 2, 0x02114000);
@@ -1304,7 +1304,7 @@ static void next_cube_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 4, 0x02118000);
 
     /* unknown: Serial clock configuration register? */
-    empty_slot_init("next.unknown.2", 0x02118004, 0x10);
+    empty_slot_init(OBJECT(machine), "next.unknown.2", 0x02118004, 0x10);
 
     /* Timer */
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 5, 0x0211a000);
diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
index 182211fdcc..64764dfd92 100644
--- a/hw/misc/empty_slot.c
+++ b/hw/misc/empty_slot.c
@@ -52,16 +52,17 @@ static const MemoryRegionOps empty_slot_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-void empty_slot_init(const char *name, hwaddr addr, uint64_t slot_size)
+void empty_slot_init(Object *parent, const char *name, hwaddr addr,
+                     uint64_t slot_size)
 {
     if (slot_size > 0) {
         /* Only empty slots larger than 0 byte need handling. */
         DeviceState *dev;
 
-        dev = qdev_new_orphan(TYPE_EMPTY_SLOT);
+        dev = qdev_new(parent, name, TYPE_EMPTY_SLOT);
 
         qdev_prop_set_uint64(dev, "size", slot_size);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
         sysbus_mmio_map_overlap(SYS_BUS_DEVICE(dev), 0, addr, -10000);
     }
diff --git a/hw/misc/led.c b/hw/misc/led.c
index 620284063b..bed85ec3c6 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -141,20 +141,21 @@ LEDState *led_create_simple(Object *parentobj,
     g_autofree char *name = NULL;
     DeviceState *dev;
 
-    dev = qdev_new_orphan(TYPE_LED);
-    qdev_prop_set_bit(dev, "gpio-active-high",
-                      gpio_polarity == GPIO_POLARITY_ACTIVE_HIGH);
-    qdev_prop_set_string(dev, "color", led_color_name[color]);
     if (!description) {
         static unsigned undescribed_led_id;
         name = g_strdup_printf("undescribed-led-#%u", undescribed_led_id++);
     } else {
-        qdev_prop_set_string(dev, "description", description);
         name = g_ascii_strdown(description, -1);
         name = g_strdelimit(name, " #", '-');
     }
-    object_property_add_child(parentobj, name, OBJECT(dev));
-    qdev_realize_and_unref(dev, NULL, &error_fatal);
+    dev = qdev_new(parentobj, name, TYPE_LED);
+    qdev_prop_set_bit(dev, "gpio-active-high",
+                      gpio_polarity == GPIO_POLARITY_ACTIVE_HIGH);
+    qdev_prop_set_string(dev, "color", led_color_name[color]);
+    if (description) {
+        qdev_prop_set_string(dev, "description", description);
+    }
+    qdev_realize(dev, NULL, &error_fatal);
 
     return LED(dev);
 }
diff --git a/hw/misc/sifive_e_prci.c b/hw/misc/sifive_e_prci.c
index 7ac5db5933..a466d37735 100644
--- a/hw/misc/sifive_e_prci.c
+++ b/hw/misc/sifive_e_prci.c
@@ -115,10 +115,10 @@ type_init(sifive_e_prci_register_types)
 /*
  * Create PRCI device.
  */
-DeviceState *sifive_e_prci_create(hwaddr addr)
+DeviceState *sifive_e_prci_create(Object *parent, hwaddr addr)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_SIFIVE_E_PRCI);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    DeviceState *dev = qdev_new(parent, "prci", TYPE_SIFIVE_E_PRCI);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
 }
diff --git a/hw/misc/sifive_test.c b/hw/misc/sifive_test.c
index f861858d9b..81ae00a110 100644
--- a/hw/misc/sifive_test.c
+++ b/hw/misc/sifive_test.c
@@ -95,10 +95,10 @@ type_init(sifive_test_register_types)
 /*
  * Create Test device.
  */
-DeviceState *sifive_test_create(hwaddr addr)
+DeviceState *sifive_test_create(Object *parent, hwaddr addr)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_SIFIVE_TEST);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    DeviceState *dev = qdev_new(parent, "test", TYPE_SIFIVE_TEST);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
 }
diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index 7362433a02..276be32648 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -264,7 +264,7 @@ static void openrisc_virt_test_init(OR1KVirtState *state, hwaddr base,
     char *nodename;
 
     /* SiFive Test MMIO device */
-    sifive_test_create(base);
+    sifive_test_create(OBJECT(state), base);
 
     /* SiFive Test MMIO Reset device FDT */
     nodename = g_strdup_printf("/soc/test@%" HWADDR_PRIx, base);
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 780c86cd9a..0c49e51ad0 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1224,7 +1224,7 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
      * exception when accessing invalid memory. Create an empty slot to
      * emulate this feature.
      */
-    empty_slot_init("GT64120", 0, 0x20000000);
+    empty_slot_init(OBJECT(dev), "GT64120", 0, 0x20000000);
 }
 
 static void gt64120_pci_realize(PCIDevice *d, Error **errp)
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index dfdb7ae4c1..d07edde237 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -233,7 +233,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
         SIFIVE_E_LFCLK_DEFAULT_FREQ, false);
-    sifive_e_prci_create(memmap[SIFIVE_E_DEV_PRCI].base);
+    sifive_e_prci_create(OBJECT(dev), memmap[SIFIVE_E_DEV_PRCI].base);
 
     /* AON */
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0479005437..70e31f6327 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1476,7 +1476,7 @@ static void virt_machine_init(MachineState *machine)
     rom_set_fw(s->fw_cfg);
 
     /* SiFive Test MMIO device */
-    sifive_test_create(s->memmap[VIRT_TEST].base);
+    sifive_test_create(OBJECT(machine), s->memmap[VIRT_TEST].base);
 
     /* VirtIO MMIO devices */
     for (i = 0; i < VIRTIO_COUNT; i++) {
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 80e37555b1..52627dbdec 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -842,7 +842,7 @@ static void sun4m_hw_init(MachineState *machine)
 
     /* models without ECC don't trap when missing ram is accessed */
     if (!hwdef->ecc_base) {
-        empty_slot_init("ecc", machine->ram_size,
+        empty_slot_init(OBJECT(machine), "ecc", machine->ram_size,
                         hwdef->max_mem - machine->ram_size);
     }
 
@@ -875,7 +875,7 @@ static void sun4m_hw_init(MachineState *machine)
            Software shouldn't use aliased addresses, neither should it crash
            when does. Using empty_slot instead of aliasing can help with
            debugging such accesses */
-        empty_slot_init("iommu.alias",
+        empty_slot_init(OBJECT(machine), "iommu.alias",
                         hwdef->iommu_pad_base, hwdef->iommu_pad_len);
     }
 
@@ -937,7 +937,8 @@ static void sun4m_hw_init(MachineState *machine)
         /* vsimm registers probed by OBP */
         if (hwdef->vsimm[i].reg_base) {
             char *name = g_strdup_printf("vsimm[%d]", i);
-            empty_slot_init(name, hwdef->vsimm[i].reg_base, 0x2000);
+            empty_slot_init(OBJECT(machine), name,
+                            hwdef->vsimm[i].reg_base, 0x2000);
             g_free(name);
         }
     }
diff --git a/include/hw/misc/empty_slot.h b/include/hw/misc/empty_slot.h
index dec56e56ae..12f03aa16a 100644
--- a/include/hw/misc/empty_slot.h
+++ b/include/hw/misc/empty_slot.h
@@ -14,6 +14,7 @@
 
 #include "exec/hwaddr.h"
 
-void empty_slot_init(const char *name, hwaddr addr, uint64_t slot_size);
+void empty_slot_init(Object *parent, const char *name, hwaddr addr,
+                     uint64_t slot_size);
 
 #endif
diff --git a/include/hw/misc/sifive_e_prci.h b/include/hw/misc/sifive_e_prci.h
index d0abd59f4b..6221e95d36 100644
--- a/include/hw/misc/sifive_e_prci.h
+++ b/include/hw/misc/sifive_e_prci.h
@@ -69,6 +69,6 @@ struct SiFiveEPRCIState {
     uint32_t plloutdiv;
 };
 
-DeviceState *sifive_e_prci_create(hwaddr addr);
+DeviceState *sifive_e_prci_create(Object *parent, hwaddr addr);
 
 #endif
diff --git a/include/hw/misc/sifive_test.h b/include/hw/misc/sifive_test.h
index 85afd35263..fd079cfd4c 100644
--- a/include/hw/misc/sifive_test.h
+++ b/include/hw/misc/sifive_test.h
@@ -42,6 +42,6 @@ enum {
     FINISHER_RESET = 0x7777
 };
 
-DeviceState *sifive_test_create(hwaddr addr);
+DeviceState *sifive_test_create(Object *parent, hwaddr addr);
 
 #endif
-- 
2.47.1


