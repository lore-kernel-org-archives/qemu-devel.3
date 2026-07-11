Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7616C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigZ1-0001ag-Uq; Sat, 11 Jul 2026 18:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigYt-0001RB-Th; Sat, 11 Jul 2026 18:52:46 -0400
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([34.218.115.239])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigYp-00005D-H9; Sat, 11 Jul 2026 18:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810359; x=1815346359;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x64G1LOo/IZxfcfgxloLJYmHOl8JxhgRbwhywuYkk6E=;
 b=QqWPNsJKeJTaFindRYGHWgHKmo6s7d6tZiq8Vg5WaMKYtUFR3+ue/H0h
 qQP9sSviLVRYp44NT1Mp5X49roBISJD+z56gl7RVrnXt+NpyRkbiqXGKS
 7nRzqqph1TJnpf4rHt0HDtX4Va0YQTb0L9Gg9Vae1bIO6Kt/7BdcfP5KN
 3vcQDPl984O1u7YA1o1r+89HzAXH1UW/ttT+ZgKmApkFgRqh6lpgsIfDr
 f3WLV1p5X5gfGP/khMzxHAFzWbgSq1Q0P24RBXgbqmTtXCe68Ro5tMrKt
 NhOsxG1ndQUkhG3T8bkAdRWx+7aKsp3X3yczq7qRryPM9I0+IlFPCcYP5 A==;
X-CSE-ConnectionGUID: JiEGBP5HQDqSVV3+Btndvw==
X-CSE-MsgGUID: QtvTYtU3RQeKfcXZ7HnLCw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23296764"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:52:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:16179]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.135:2525]
 with esmtp (Farcaster)
 id cd9713c6-a5a9-479d-922e-3783c6bc2873; Sat, 11 Jul 2026 22:52:35 +0000 (UTC)
X-Farcaster-Flow-ID: cd9713c6-a5a9-479d-922e-3783c6bc2873
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:52:35 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:52:26 +0000
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
Subject: [RFC PATCH 059/134] hw/arm/xlnx-versal,
 xlnx-zynqmp: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:52 +0000
Message-ID: <20260711223707.42139-60-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
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

Convert the *_orphan() device-creation calls in the hw/arm xlnx-versal, xlnx-zynqmp
board files to the new parented API introduced earlier in this
series, so every onboard device gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/xlnx-versal.c:517 | qdev_new | container | name | SoC realize helper; collapse existing add_child(container,name); drop _and_unref
hw/arm/xlnx-versal.c:565 | qdev_new | container | name | SoC realize helper; collapse existing add_child(container,name); drop _and_unref
hw/arm/xlnx-versal.c:667 | qdev_new | parent | name | helper already receives parent+name; collapse add_child; drop _and_unref
hw/arm/xlnx-versal.c:716 | qdev_new | OBJECT(gic) | "its" | collapse existing add_child(gic,"its"); sysbus_realize
hw/arm/xlnx-versal.c:758 | qdev_new | OBJECT(s) | name | SoC realize; hoist name printf, collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:762 | qdev_new | OBJECT(s) | name | SoC realize; hoist name printf, collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:912 | qdev_new | OBJECT(qemu_cluster) | name | hoist name printf; collapse add_child; qdev_realize
hw/arm/xlnx-versal.c:963 | qdev_new | OBJECT(s) | name | hoist name printf; collapse add_child; qdev_realize
hw/arm/xlnx-versal.c:1031 | qdev_new | OBJECT(s) | "uart[*]" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1070 | qdev_new | OBJECT(s) | "canfd[*]" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1110 | qdev_new | OBJECT(s) | "usb[*]" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1170 | qdev_new | OBJECT(s) | "gem[*]" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1254 | qdev_new | OBJECT(s) | name | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1289 | qdev_new | OBJECT(s) | "sdhci[*]" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1323 | qdev_new | OBJECT(s) | "rtc" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1352 | qdev_new | OBJECT(s) | "trng" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1373 | qdev_new | OBJECT(s) | "xram[*]" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1395 | qdev_new | OBJECT(s) | "bbram" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1418 | qdev_new | OBJECT(s) | "efuse-ctrl" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1419 | qdev_new | OBJECT(s) | "efuse-cache" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1420 | qdev_new | OBJECT(s) | "efuse" | collapse add_child; qdev_realize
hw/arm/xlnx-versal.c:1454 | qdev_new | OBJECT(s) | "pmc-iou-slcr" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1476 | qdev_new | OBJECT(s) | "ospi" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1485 | qdev_new | OBJECT(dev) | "dma-dst-dev" | collapse add_child under ospi; sysbus_realize
hw/arm/xlnx-versal.c:1497 | qdev_new | OBJECT(dev) | "dma-src-dev" | collapse add_child under ospi; sysbus_realize
hw/arm/xlnx-versal.c:1551 | qdev_new | container | "cfu-fdro" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1560 | qdev_new | container | "cframe-bcast" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1564 | qdev_new | container | "cfu-apb" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1568 | qdev_new | container | "cframe-irq-or-gate" | collapse add_child; qdev_realize
hw/arm/xlnx-versal.c:1583 | qdev_new | container | "cframe[*]" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1635 | qdev_new | container | "cfu-sfr" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1679 | qdev_new | OBJECT(s) | "crl" | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1764 | qdev_new | OBJECT(s) | name | collapse add_child; sysbus_realize
hw/arm/xlnx-versal.c:1975 | qdev_new | OBJECT(sdhci) | "card[*]" | collapse add_child; qdev_realize
hw/arm/xlnx-versal.c:2018 | qdev_new | OBJECT(ospi) | "flash[*]" | flash on OSPI SPI bus; parent under ospi; qdev_realize
hw/arm/xlnx-versal-virt.c:146 | qdev_new | OBJECT(s) | "virtio-mmio[*]" | machine init helper; collapse add_child; sysbus_realize
hw/arm/xlnx-zcu102.c:190 | qdev_new | OBJECT(machine) | "sd-card[*]" | board init; qdev_realize
hw/arm/xlnx-zcu102.c:205 | qdev_new | OBJECT(machine) | "spi-flash[*]" | board init; qdev_realize
hw/arm/xlnx-zcu102.c:229 | qdev_new | OBJECT(machine) | "qspi-flash[*]" | board init; qdev_realize
hw/arm/xlnx-zynqmp.c:368 | qdev_new | OBJECT(s) | info->name | SoC realize; collapse add_child; sysbus_realize

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/xlnx-versal-virt.c |   5 +-
 hw/arm/xlnx-versal.c      | 197 ++++++++++++++++----------------------
 hw/arm/xlnx-zcu102.c      |  14 +--
 hw/arm/xlnx-zynqmp.c      |   6 +-
 4 files changed, 98 insertions(+), 124 deletions(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 48f6e6d463..88bebf1f87 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -143,9 +143,8 @@ static void create_virtio_regions(VersalVirt *s)
         qemu_irq pic_irq;
 
         pic_irq = versal_get_reserved_irq(&s->soc, i, &dtb_irq);
-        dev = qdev_new_orphan("virtio-mmio");
-        object_property_add_child(OBJECT(s), "virtio-mmio[*]", OBJECT(dev));
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        dev = qdev_new(OBJECT(s), "virtio-mmio[*]", "virtio-mmio");
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic_irq);
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->soc.mr_ps, base, mr);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 7cb95a4ff8..bf125d6f32 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -514,10 +514,9 @@ static qemu_irq versal_get_gic_irq(Versal *s, int irq_idx)
     if (split == NULL) {
         size_t i;
 
-        split = qdev_new_orphan(TYPE_SPLIT_IRQ);
+        split = qdev_new(container, name, TYPE_SPLIT_IRQ);
         qdev_prop_set_uint16(split, "num-lines", s->intc->len);
-        object_property_add_child(container, name, OBJECT(split));
-        qdev_realize_and_unref(split, NULL, &error_abort);
+        qdev_realize(split, NULL, &error_abort);
 
         for (i = 0; i < s->intc->len; i++) {
             DeviceState *gic;
@@ -562,10 +561,9 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
     dev = DEVICE(object_resolve_path_at(container, name));
 
     if (dev == NULL) {
-        dev = qdev_new_orphan(TYPE_OR_IRQ);
-        object_property_add_child(container, name, OBJECT(dev));
+        dev = qdev_new(container, name, TYPE_OR_IRQ);
         qdev_prop_set_uint16(dev, "num-lines", 1 << R_VERSAL_IRQ_OR_IDX_LENGTH);
-        qdev_realize_and_unref(dev, NULL, &error_abort);
+        qdev_realize(dev, NULL, &error_abort);
         qdev_connect_gpio_out(dev, 0, target_irq);
     }
 
@@ -664,10 +662,9 @@ static inline DeviceState *create_or_gate(Versal *s, Object *parent,
 {
     DeviceState *or;
 
-    or = qdev_new_orphan(TYPE_OR_IRQ);
+    or = qdev_new(parent, name, TYPE_OR_IRQ);
     qdev_prop_set_uint16(or, "num-lines", num_lines);
-    object_property_add_child(parent, name, OBJECT(or));
-    qdev_realize_and_unref(or, NULL, &error_abort);
+    qdev_realize(or, NULL, &error_abort);
     versal_qdev_connect_gpio_out(s, or, 0, irq_idx);
 
     return or;
@@ -713,14 +710,13 @@ static void versal_create_gic_its(Versal *s,
         return;
     }
 
-    dev = qdev_new_orphan(TYPE_ARM_GICV3_ITS);
+    dev = qdev_new(OBJECT(gic), "its", TYPE_ARM_GICV3_ITS);
     sbd = SYS_BUS_DEVICE(dev);
 
-    object_property_add_child(OBJECT(gic), "its", OBJECT(dev));
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(gic),
                              &error_abort);
 
-    sysbus_realize_and_unref(sbd, &error_abort);
+    sysbus_realize(sbd, &error_abort);
 
     memory_region_add_subregion(mr, map->gic.its,
                                 sysbus_mmio_get_region(sbd, 0));
@@ -753,21 +749,21 @@ static DeviceState *versal_create_gic(Versal *s,
     const char gicv3_compat[] = "arm,gic-v3";
     const char gicv2_compat[] = "arm,cortex-a15-gic";
 
+    name = g_strdup_printf("%s-gic[*]", map->name);
+
     switch (map->gic.version) {
     case 2:
-        dev = qdev_new_orphan(gic_class_name());
+        dev = qdev_new(OBJECT(s), name, gic_class_name());
         break;
 
     case 3:
-        dev = qdev_new_orphan(gicv3_class_name());
+        dev = qdev_new(OBJECT(s), name, gicv3_class_name());
         break;
 
     default:
         g_assert_not_reached();
     }
 
-    name = g_strdup_printf("%s-gic[*]", map->name);
-    object_property_add_child(OBJECT(s), name, OBJECT(dev));
     sbd = SYS_BUS_DEVICE(dev);
     qdev_prop_set_uint32(dev, "revision", map->gic.version);
     qdev_prop_set_uint32(dev, "num-cpu", num_cpu);
@@ -787,7 +783,7 @@ static DeviceState *versal_create_gic(Versal *s,
 
     }
 
-    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_realize(sbd, &error_fatal);
 
     memory_region_add_subregion(mr, map->gic.dist,
                                 sysbus_mmio_get_region(sbd, 0));
@@ -909,13 +905,13 @@ static DeviceState *versal_create_cpu(Versal *s,
                                       size_t cluster_idx,
                                       size_t core_idx)
 {
-    DeviceState *cpu = qdev_new_orphan(map->cpu_model);
-    ARMCPU *arm_cpu = ARM_CPU(cpu);
-    Object *obj = OBJECT(cpu);
+    DeviceState *cpu;
+    ARMCPU *arm_cpu;
+    Object *obj;
     uint64_t affinity;
     bool start_off;
     size_t idx = cluster_idx * map->num_core + core_idx;
-    g_autofree char *name;
+    g_autofree char *name = g_strdup_printf("%s[*]", map->name);
     g_autofree char *node = NULL;
 
     affinity = map->mp_affinity.base;
@@ -926,14 +922,15 @@ static DeviceState *versal_create_cpu(Versal *s,
         || ((map->start_powered_off == SPO_SECONDARIES)
             && (cluster_idx || core_idx));
 
-    name = g_strdup_printf("%s[*]", map->name);
-    object_property_add_child(OBJECT(qemu_cluster), name, obj);
+    cpu = qdev_new(OBJECT(qemu_cluster), name, map->cpu_model);
+    arm_cpu = ARM_CPU(cpu);
+    obj = OBJECT(cpu);
     object_property_set_bool(obj, "start-powered-off", start_off,
                              &error_abort);
     qdev_prop_set_uint64(cpu, "mp-affinity", affinity);
     qdev_prop_set_int32(cpu, "core-count",  map->num_core);
     object_property_set_link(obj, "memory", OBJECT(cpu_mr), &error_abort);
-    qdev_realize_and_unref(cpu, NULL, &error_fatal);
+    qdev_realize(cpu, NULL, &error_fatal);
 
     if (!map->dtb_expose) {
         return cpu;
@@ -955,15 +952,13 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
     size_t i, j;
     DeviceState *cluster;
     MemoryRegion *mr;
-    char *name;
+    g_autofree char *name = g_strdup_printf("%s-cluster", map->name);
     g_autofree DeviceState **cpus;
     const char compatible[] = "arm,armv8-timer";
     bool has_gtimer;
 
-    cluster = qdev_new_orphan(TYPE_CPU_CLUSTER);
-    name = g_strdup_printf("%s-cluster", map->name);
-    object_property_add_child(OBJECT(s), name, OBJECT(cluster));
-    g_free(name);
+    cluster = qdev_new(OBJECT(s), name, TYPE_CPU_CLUSTER);
+
     qdev_prop_set_uint32(cluster, "cluster-id", map->qemu_cluster_id);
 
     mr = create_cpu_mr(s, cluster, map);
@@ -989,7 +984,7 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
         }
     }
 
-    qdev_realize_and_unref(cluster, NULL, &error_fatal);
+    qdev_realize(cluster, NULL, &error_fatal);
 
     if (!map->per_cluster_gic) {
         versal_create_and_connect_gic(s, map, mr, cpus,
@@ -1028,10 +1023,9 @@ static void versal_create_uart(Versal *s,
     const char compatible[] = "arm,pl011\0arm,sbsa-uart";
     const char clocknames[] = "uartclk\0apb_pclk";
 
-    dev = qdev_new_orphan(TYPE_PL011);
-    object_property_add_child(OBJECT(s), "uart[*]", OBJECT(dev));
+    dev = qdev_new(OBJECT(s), "uart[*]", TYPE_PL011);
     qdev_prop_set_chr(dev, "chardev", serial_hd(chardev_idx));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
     memory_region_add_subregion(&s->mr_ps, map->addr, mr);
@@ -1067,8 +1061,7 @@ static void versal_create_canfd(Versal *s, const VersalSimplePeriphMap *map,
     const char compatible[] = "xlnx,canfd-2.0";
     const char clocknames[] = "can_clk\0s_axi_aclk";
 
-    sbd = SYS_BUS_DEVICE(qdev_new_orphan(TYPE_XILINX_CANFD));
-    object_property_add_child(OBJECT(s), "canfd[*]", OBJECT(sbd));
+    sbd = SYS_BUS_DEVICE(qdev_new(OBJECT(s), "canfd[*]", TYPE_XILINX_CANFD));
 
     object_property_set_int(OBJECT(sbd), "ext_clk_freq",
                             25 * 1000 * 1000 , &error_abort);
@@ -1076,7 +1069,7 @@ static void versal_create_canfd(Versal *s, const VersalSimplePeriphMap *map,
     object_property_set_link(OBJECT(sbd), "canfdbus", OBJECT(bus),
                              &error_abort);
 
-    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_realize(sbd, &error_fatal);
 
     mr = sysbus_mmio_get_region(sbd, 0);
     memory_region_add_subregion(&s->mr_ps, map->addr, mr);
@@ -1107,15 +1100,14 @@ static void versal_create_usb(Versal *s,
     const char compat_versal_dwc3[] = "xlnx,versal-dwc3";
     const char compat_dwc3[] = "snps,dwc3";
 
-    dev = qdev_new_orphan(TYPE_XILINX_VERSAL_USB2);
-    object_property_add_child(OBJECT(s), "usb[*]", OBJECT(dev));
+    dev = qdev_new(OBJECT(s), "usb[*]", TYPE_XILINX_VERSAL_USB2);
 
     object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
                              &error_abort);
     qdev_prop_set_uint32(dev, "intrs", 1);
     qdev_prop_set_uint32(dev, "slots", 2);
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
     memory_region_add_subregion(&s->mr_ps, map->xhci, mr);
@@ -1167,8 +1159,7 @@ static void versal_create_gem(Versal *s,
     DeviceState *or;
     int i;
 
-    dev = qdev_new_orphan(TYPE_CADENCE_GEM);
-    object_property_add_child(OBJECT(s), "gem[*]", OBJECT(dev));
+    dev = qdev_new(OBJECT(s), "gem[*]", TYPE_CADENCE_GEM);
 
     qemu_configure_nic_device(dev, true, NULL);
     object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
@@ -1177,7 +1168,7 @@ static void versal_create_gem(Versal *s,
 
     object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
                              &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
     memory_region_add_subregion(&s->mr_ps, map->map.addr, mr);
@@ -1251,12 +1242,11 @@ static void versal_create_zdma(Versal *s,
         int irq = map->map.irq + map->irq_stride * i;
         g_autofree char *node;
 
-        dev = qdev_new_orphan(TYPE_XLNX_ZDMA);
-        object_property_add_child(OBJECT(s), name, OBJECT(dev));
+        dev = qdev_new(OBJECT(s), name, TYPE_XLNX_ZDMA);
         object_property_set_int(OBJECT(dev), "bus-width", 128, &error_abort);
         object_property_set_link(OBJECT(dev), "dma",
                                  OBJECT(get_system_memory()), &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->mr_ps, addr, mr);
@@ -1286,15 +1276,14 @@ static void versal_create_sdhci(Versal *s,
     const char compatible[] = "arasan,sdhci-8.9a";
     const char clocknames[] = "clk_xin\0clk_ahb";
 
-    dev = qdev_new_orphan(TYPE_SYSBUS_SDHCI);
-    object_property_add_child(OBJECT(s), "sdhci[*]", OBJECT(dev));
+    dev = qdev_new(OBJECT(s), "sdhci[*]", TYPE_SYSBUS_SDHCI);
 
     object_property_set_uint(OBJECT(dev), "sd-spec-version", 3,
                              &error_fatal);
     object_property_set_uint(OBJECT(dev), "capareg", SDHCI_CAPABILITIES,
                              &error_fatal);
     object_property_set_uint(OBJECT(dev), "uhs", UHS_I, &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
     memory_region_add_subregion(&s->mr_ps, map->addr, mr);
@@ -1320,9 +1309,8 @@ static void versal_create_rtc(Versal *s, const struct VersalRtcMap *map)
     const char compatible[] = "xlnx,zynqmp-rtc";
     const char interrupt_names[] = "alarm\0sec";
 
-    sbd = SYS_BUS_DEVICE(qdev_new_orphan(TYPE_XLNX_ZYNQMP_RTC));
-    object_property_add_child(OBJECT(s), "rtc", OBJECT(sbd));
-    sysbus_realize_and_unref(sbd, &error_abort);
+    sbd = SYS_BUS_DEVICE(qdev_new(OBJECT(s), "rtc", TYPE_XLNX_ZYNQMP_RTC));
+    sysbus_realize(sbd, &error_abort);
 
     mr = sysbus_mmio_get_region(sbd, 0);
     memory_region_add_subregion(&s->mr_ps, map->map.addr, mr);
@@ -1349,9 +1337,8 @@ static void versal_create_trng(Versal *s, const VersalSimplePeriphMap *map)
     SysBusDevice *sbd;
     MemoryRegion *mr;
 
-    sbd = SYS_BUS_DEVICE(qdev_new_orphan(TYPE_XLNX_VERSAL_TRNG));
-    object_property_add_child(OBJECT(s), "trng", OBJECT(sbd));
-    sysbus_realize_and_unref(sbd, &error_abort);
+    sbd = SYS_BUS_DEVICE(qdev_new(OBJECT(s), "trng", TYPE_XLNX_VERSAL_TRNG));
+    sysbus_realize(sbd, &error_abort);
 
     mr = sysbus_mmio_get_region(sbd, 0);
     memory_region_add_subregion(&s->mr_ps, map->addr, mr);
@@ -1370,9 +1357,9 @@ static void versal_create_xrams(Versal *s, const struct VersalXramMap *map)
     for (i = 0; i < map->num; i++) {
         hwaddr ctrl, mem;
 
-        sbd = SYS_BUS_DEVICE(qdev_new_orphan(TYPE_XLNX_XRAM_CTRL));
-        object_property_add_child(OBJECT(s), "xram[*]", OBJECT(sbd));
-        sysbus_realize_and_unref(sbd, &error_fatal);
+        sbd = SYS_BUS_DEVICE(qdev_new(OBJECT(s), "xram[*]",
+                                      TYPE_XLNX_XRAM_CTRL));
+        sysbus_realize(sbd, &error_fatal);
 
         ctrl = map->ctrl + map->ctrl_stride * i;
         mem = map->mem + map->mem_stride * i;
@@ -1392,12 +1379,11 @@ static void versal_create_bbram(Versal *s,
     DeviceState *dev;
     SysBusDevice *sbd;
 
-    dev = qdev_new_orphan(TYPE_XLNX_BBRAM);
+    dev = qdev_new(OBJECT(s), "bbram", TYPE_XLNX_BBRAM);
     sbd = SYS_BUS_DEVICE(dev);
 
-    object_property_add_child(OBJECT(s), "bbram", OBJECT(dev));
     qdev_prop_set_uint32(dev, "crc-zpads", 0);
-    sysbus_realize_and_unref(sbd, &error_abort);
+    sysbus_realize(sbd, &error_abort);
     memory_region_add_subregion(&s->mr_ps, map->addr,
                                 sysbus_mmio_get_region(sbd, 0));
     versal_sysbus_connect_irq(s, sbd, 0, map->irq);
@@ -1415,26 +1401,24 @@ static void versal_create_efuse(Versal *s,
         return;
     }
 
-    ctrl = qdev_new_orphan(TYPE_XLNX_VERSAL_EFUSE_CTRL);
-    cache = qdev_new_orphan(TYPE_XLNX_VERSAL_EFUSE_CACHE);
-    bits = qdev_new_orphan(TYPE_XLNX_EFUSE);
+    ctrl = qdev_new(OBJECT(s), "efuse-ctrl", TYPE_XLNX_VERSAL_EFUSE_CTRL);
+    cache = qdev_new(OBJECT(s), "efuse-cache",
+                     TYPE_XLNX_VERSAL_EFUSE_CACHE);
+    bits = qdev_new(OBJECT(s), "efuse", TYPE_XLNX_EFUSE);
 
     qdev_prop_set_uint32(bits, "efuse-nr", 3);
     qdev_prop_set_uint32(bits, "efuse-size", 8192);
 
-    object_property_add_child(OBJECT(s), "efuse", OBJECT(bits));
-    qdev_realize_and_unref(bits, NULL, &error_abort);
+    qdev_realize(bits, NULL, &error_abort);
 
     object_property_set_link(OBJECT(ctrl), "efuse", OBJECT(bits), &error_abort);
 
     object_property_set_link(OBJECT(cache), "efuse", OBJECT(bits),
                              &error_abort);
 
-    object_property_add_child(OBJECT(s), "efuse-cache", OBJECT(cache));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(cache), &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(cache), &error_abort);
 
-    object_property_add_child(OBJECT(s), "efuse-ctrl", OBJECT(ctrl));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(ctrl), &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(ctrl), &error_abort);
 
     memory_region_add_subregion(&s->mr_ps, map->ctrl,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(ctrl),
@@ -1451,11 +1435,11 @@ static DeviceState *versal_create_pmc_iou_slcr(Versal *s,
     SysBusDevice *sbd;
     DeviceState *dev;
 
-    dev = qdev_new_orphan(TYPE_XILINX_VERSAL_PMC_IOU_SLCR);
-    object_property_add_child(OBJECT(s), "pmc-iou-slcr", OBJECT(dev));
+    dev = qdev_new(OBJECT(s), "pmc-iou-slcr",
+                   TYPE_XILINX_VERSAL_PMC_IOU_SLCR);
 
     sbd = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_realize(sbd, &error_fatal);
 
     memory_region_add_subregion(&s->mr_ps, map->addr,
                                 sysbus_mmio_get_region(sbd, 0));
@@ -1473,8 +1457,7 @@ static DeviceState *versal_create_ospi(Versal *s,
     DeviceState *dev, *dma_dst, *dma_src, *orgate;
     MemoryRegion *linear_mr = g_new(MemoryRegion, 1);
 
-    dev = qdev_new_orphan(TYPE_XILINX_VERSAL_OSPI);
-    object_property_add_child(OBJECT(s), "ospi", OBJECT(dev));
+    dev = qdev_new(OBJECT(s), "ospi", TYPE_XILINX_VERSAL_OSPI);
 
     memory_region_init(linear_mr, OBJECT(dev), "linear-mr", map->dac_sz);
 
@@ -1482,20 +1465,18 @@ static DeviceState *versal_create_ospi(Versal *s,
     memory_region_add_subregion(linear_mr, 0x0, mr_dac);
 
     /* Create the OSPI destination DMA */
-    dma_dst = qdev_new_orphan(TYPE_XLNX_CSU_DMA);
-    object_property_add_child(OBJECT(dev), "dma-dst-dev", OBJECT(dma_dst));
+    dma_dst = qdev_new(OBJECT(dev), "dma-dst-dev", TYPE_XLNX_CSU_DMA);
     object_property_set_link(OBJECT(dma_dst), "dma",
                              OBJECT(get_system_memory()), &error_abort);
 
     sbd = SYS_BUS_DEVICE(dma_dst);
-    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_realize(sbd, &error_fatal);
 
     memory_region_add_subregion(&s->mr_ps, map->dma_dst,
                                 sysbus_mmio_get_region(sbd, 0));
 
     /* Create the OSPI source DMA */
-    dma_src = qdev_new_orphan(TYPE_XLNX_CSU_DMA);
-    object_property_add_child(OBJECT(dev), "dma-src-dev", OBJECT(dma_src));
+    dma_src = qdev_new(OBJECT(dev), "dma-src-dev", TYPE_XLNX_CSU_DMA);
 
     object_property_set_bool(OBJECT(dma_src), "is-dst", false, &error_abort);
 
@@ -1506,7 +1487,7 @@ static DeviceState *versal_create_ospi(Versal *s,
                              OBJECT(dma_dst), &error_abort);
 
     sbd = SYS_BUS_DEVICE(dma_src);
-    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_realize(sbd, &error_fatal);
 
     memory_region_add_subregion(&s->mr_ps, map->dma_src,
                                 sysbus_mmio_get_region(sbd, 0));
@@ -1516,7 +1497,7 @@ static DeviceState *versal_create_ospi(Versal *s,
                              OBJECT(dma_src), &error_abort);
 
     sbd = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_realize(sbd, &error_fatal);
 
     memory_region_add_subregion(&s->mr_ps, map->ctrl,
                                 sysbus_mmio_get_region(sbd, 0));
@@ -1548,28 +1529,24 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
     object_unref(container);
 
     /* CFU FDRO */
-    cfu_fdro = qdev_new_orphan(TYPE_XLNX_VERSAL_CFU_FDRO);
-    object_property_add_child(container, "cfu-fdro", OBJECT(cfu_fdro));
+    cfu_fdro = qdev_new(container, "cfu-fdro", TYPE_XLNX_VERSAL_CFU_FDRO);
     sbd = SYS_BUS_DEVICE(cfu_fdro);
 
-    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_realize(sbd, &error_fatal);
     memory_region_add_subregion(&s->mr_ps, map->cfu_fdro,
                                 sysbus_mmio_get_region(sbd, 0));
 
     /* cframe bcast */
-    cframe_bcast = qdev_new_orphan(TYPE_XLNX_VERSAL_CFRAME_BCAST_REG);
-    object_property_add_child(container, "cframe-bcast", OBJECT(cframe_bcast));
+    cframe_bcast = qdev_new(container, "cframe-bcast",
+                            TYPE_XLNX_VERSAL_CFRAME_BCAST_REG);
 
     /* CFU APB */
-    cfu_apb = qdev_new_orphan(TYPE_XLNX_VERSAL_CFU_APB);
-    object_property_add_child(container, "cfu-apb", OBJECT(cfu_apb));
+    cfu_apb = qdev_new(container, "cfu-apb", TYPE_XLNX_VERSAL_CFU_APB);
 
     /* IRQ or gate for cframes */
-    cframe_irq_or = qdev_new_orphan(TYPE_OR_IRQ);
-    object_property_add_child(container, "cframe-irq-or-gate",
-                              OBJECT(cframe_irq_or));
+    cframe_irq_or = qdev_new(container, "cframe-irq-or-gate", TYPE_OR_IRQ);
     qdev_prop_set_uint16(cframe_irq_or, "num-lines", map->num_cframe);
-    qdev_realize_and_unref(cframe_irq_or, NULL, &error_abort);
+    qdev_realize(cframe_irq_or, NULL, &error_abort);
     versal_qdev_connect_gpio_out(s, cframe_irq_or, 0, map->cframe_irq);
 
     /* cframe reg */
@@ -1580,8 +1557,8 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
         g_autofree char *prop_name;
         size_t j;
 
-        dev = qdev_new_orphan(TYPE_XLNX_VERSAL_CFRAME_REG);
-        object_property_add_child(container, "cframe[*]", OBJECT(dev));
+        dev = qdev_new(container, "cframe[*]",
+                       TYPE_XLNX_VERSAL_CFRAME_REG);
 
         sbd = SYS_BUS_DEVICE(dev);
 
@@ -1597,7 +1574,7 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
         object_property_set_link(OBJECT(dev), "cfu-fdro",
                                  OBJECT(cfu_fdro), &error_abort);
 
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_abort);
 
         reg_base = map->cframe_base + i * map->cframe_stride * 2;
         fdri_base = reg_base + map->cframe_stride;
@@ -1615,14 +1592,14 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
     }
 
     sbd = SYS_BUS_DEVICE(cframe_bcast);
-    sysbus_realize_and_unref(sbd, &error_abort);
+    sysbus_realize(sbd, &error_abort);
     memory_region_add_subregion(&s->mr_ps, map->cframe_bcast_reg,
                                 sysbus_mmio_get_region(sbd, 0));
     memory_region_add_subregion(&s->mr_ps, map->cframe_bcast_fdri,
                                 sysbus_mmio_get_region(sbd, 1));
 
     sbd = SYS_BUS_DEVICE(cfu_apb);
-    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_realize(sbd, &error_fatal);
     memory_region_add_subregion(&s->mr_ps, map->cfu_apb,
                                 sysbus_mmio_get_region(sbd, 0));
     memory_region_add_subregion(&s->mr_ps, map->cfu_stream,
@@ -1632,13 +1609,12 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
     versal_sysbus_connect_irq(s, sbd, 0, map->cfu_apb_irq);
 
     /* CFU SFR */
-    cfu_sfr = qdev_new_orphan(TYPE_XLNX_VERSAL_CFU_SFR);
-    object_property_add_child(container, "cfu-sfr", OBJECT(cfu_sfr));
+    cfu_sfr = qdev_new(container, "cfu-sfr", TYPE_XLNX_VERSAL_CFU_SFR);
     sbd = SYS_BUS_DEVICE(cfu_sfr);
 
     object_property_set_link(OBJECT(cfu_sfr),
                             "cfu", OBJECT(cfu_apb), &error_abort);
-    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_realize(sbd, &error_fatal);
     memory_region_add_subregion(&s->mr_ps, map->cfu_sfr,
                                 sysbus_mmio_get_region(sbd, 0));
 }
@@ -1676,9 +1652,8 @@ static inline void versal_create_crl(Versal *s)
     ver = versal_get_version(s);
 
     crl_class = xlnx_versal_crl_class_name(ver);
-    dev = qdev_new_orphan(crl_class);
+    dev = qdev_new(OBJECT(s), "crl", crl_class);
     obj = OBJECT(dev);
-    object_property_add_child(OBJECT(s), "crl", obj);
 
     /*
      * The 3rd GEM controller on versal2 is in the MMI subsystem.
@@ -1694,7 +1669,7 @@ static inline void versal_create_crl(Versal *s)
     crl_connect_dev_by_name(s, obj, "gem", num_gem);
     crl_connect_dev_by_name(s, obj, "usb", map->num_usb);
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_abort);
 
     memory_region_add_subregion(&s->mr_ps, map->crl.addr,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
@@ -1761,13 +1736,12 @@ static void versal_unimp_area(Versal *s, const char *name,
                                 MemoryRegion *mr,
                                 hwaddr base, hwaddr size)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_UNIMPLEMENTED_DEVICE);
+    DeviceState *dev = qdev_new(OBJECT(s), name, TYPE_UNIMPLEMENTED_DEVICE);
     MemoryRegion *mr_dev;
 
     qdev_prop_set_string(dev, "name", name);
     qdev_prop_set_uint64(dev, "size", size);
-    object_property_add_child(OBJECT(s), name, OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     mr_dev = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
     memory_region_add_subregion(mr, base, mr_dev);
@@ -1972,11 +1946,10 @@ void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
         return;
     }
 
-    card = qdev_new_orphan(TYPE_SD_CARD);
-    object_property_add_child(OBJECT(sdhci), "card[*]", OBJECT(card));
+    card = qdev_new(OBJECT(sdhci), "card[*]", TYPE_SD_CARD);
     qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
-    qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
-                           &error_fatal);
+    qdev_realize(card, qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
+                 &error_fatal);
 }
 
 void versal_efuse_attach_drive(Versal *s, BlockBackend *blk)
@@ -2015,13 +1988,13 @@ void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
     ospi = DEVICE(versal_get_child(s, "ospi"));
     spi_bus = qdev_get_child_bus(ospi, "spi0");
 
-    flash = qdev_new_orphan(flash_mdl);
+    flash = qdev_new(OBJECT(ospi), "flash[*]", flash_mdl);
 
     if (blk) {
         qdev_prop_set_drive_err(flash, "drive", blk, &error_fatal);
     }
     qdev_prop_set_uint8(flash, "cs", flash_idx);
-    qdev_realize_and_unref(flash, spi_bus, &error_fatal);
+    qdev_realize(flash, spi_bus, &error_fatal);
 
     cs_line = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
 
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index adff52eaf6..473acad060 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -187,9 +187,9 @@ static void xlnx_zcu102_init(MachineState *machine)
             error_report("No SD bus found for SD card %d", i);
             exit(1);
         }
-        carddev = qdev_new_orphan(TYPE_SD_CARD);
+        carddev = qdev_new(OBJECT(machine), "sd-card[*]", TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-        qdev_realize_and_unref(carddev, bus, &error_fatal);
+        qdev_realize(carddev, bus, &error_fatal);
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
@@ -202,13 +202,14 @@ static void xlnx_zcu102_init(MachineState *machine)
         spi_bus = qdev_get_child_bus(DEVICE(&s->soc), bus_name);
         g_free(bus_name);
 
-        flash_dev = qdev_new_orphan("sst25wf080");
+        flash_dev = qdev_new(OBJECT(machine), "spi-flash[*]",
+                             "sst25wf080");
         if (dinfo) {
             qdev_prop_set_drive_err(flash_dev, "drive",
                                     blk_by_legacy_dinfo(dinfo), &error_fatal);
         }
         qdev_prop_set_uint8(flash_dev, "cs", i);
-        qdev_realize_and_unref(flash_dev, spi_bus, &error_fatal);
+        qdev_realize(flash_dev, spi_bus, &error_fatal);
 
         cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
 
@@ -226,13 +227,14 @@ static void xlnx_zcu102_init(MachineState *machine)
         spi_bus = qdev_get_child_bus(DEVICE(&s->soc), bus_name);
         g_free(bus_name);
 
-        flash_dev = qdev_new_orphan("n25q512a11");
+        flash_dev = qdev_new(OBJECT(machine), "qspi-flash[*]",
+                             "n25q512a11");
         if (dinfo) {
             qdev_prop_set_drive_err(flash_dev, "drive",
                                     blk_by_legacy_dinfo(dinfo), &error_fatal);
         }
         qdev_prop_set_uint8(flash_dev, "cs", i);
-        qdev_realize_and_unref(flash_dev, spi_bus, &error_fatal);
+        qdev_realize(flash_dev, spi_bus, &error_fatal);
 
         cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
 
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 861ee35839..e4a10861a8 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -365,15 +365,15 @@ static void xlnx_zynqmp_create_unimp_mmio(XlnxZynqMPState *s)
 
     for (nr = 0; nr < ARRAY_SIZE(unimp_areas); nr++) {
         const struct UnimpInfo *info = &unimp_areas[nr];
-        DeviceState *dev = qdev_new_orphan(TYPE_UNIMPLEMENTED_DEVICE);
+        DeviceState *dev = qdev_new(OBJECT(s), info->name,
+                                    TYPE_UNIMPLEMENTED_DEVICE);
         SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
         assert(info->name && info->base && info->size > 0);
         qdev_prop_set_string(dev, "name", info->name);
         qdev_prop_set_uint64(dev, "size", info->size);
-        object_property_add_child(OBJECT(s), info->name, OBJECT(dev));
 
-        sysbus_realize_and_unref(sbd, &error_fatal);
+        sysbus_realize(sbd, &error_fatal);
         sysbus_mmio_map(sbd, 0, info->base);
     }
 }
-- 
2.47.1


