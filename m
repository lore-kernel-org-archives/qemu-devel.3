Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A189AC4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCvW-0000YU-To; Sat, 18 Jul 2026 17:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCuz-0008Vq-09; Sat, 18 Jul 2026 17:50:02 -0400
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.162.73.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCuu-0003Wp-9w; Sat, 18 Jul 2026 17:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411392; x=1815947392;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gHss29LrdlLZd2aMouPNycGZXE1FbMFs6OsrTsLCpP8=;
 b=WFDfxZGvjtRoDuPm0LPmZRrdSxF2CQ5PzmaJIEoZVpCEzLjNTp5gUjhk
 7QAEGYb7lYPBHKlA8KIPGCq1WtZ2VjSPB47QFjun9kk8YJybp6ziRxoCY
 QFe7IOUbA6ku6yx6SZGDCa1AiRtz8PKAJT+MmgJO9yuTOIqyH0f2+LvI/
 P4K+w3DxaSOOy1kxt/HrlM5AFqod53qVqgLn585KkkpVeQFf/DKS1XPn/
 W/KYK8WAs8OFBBLkEbBAAdFrM5G+Re4QwIT47do/vR9HIZcFxHvSX2tn6
 yv5Q2rfi1GNaOhfODQFw6GqcWvi29pMGt/ADm1vlnn1taIKFhssDeiTKh A==;
X-CSE-ConnectionGUID: 7FAjPNYrSPCPtmUHKoFWeA==
X-CSE-MsgGUID: 1Isr4iXvSOez6rHPXMwvYg==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23715795"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:49:48 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:7180]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.34:2525]
 with esmtp (Farcaster)
 id cd1471d7-579e-41a0-b0ae-3c6526346a60; Sat, 18 Jul 2026 21:49:48 +0000 (UTC)
X-Farcaster-Flow-ID: cd1471d7-579e-41a0-b0ae-3c6526346a60
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:49:48 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:49:38 +0000
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
Subject: [RFC PATCH v2 046/137] hw/rtc: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:21 +0000
Message-ID: <20260718213652.37673-47-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.162.73.231;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/rtc to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/rtc/mc146818rtc.c:933 | isa_new | parent | "rtc" | helper called from board init; thread Object *parent through mc146818_rtc_init() and its 4 callers (microvm, pnv, jazz, dp264)
hw/rtc/sun4v-rtc.c:60 | qdev_new | parent | "rtc" | helper called from niagara board init; thread Object *parent through sun4v_rtc_init()

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/alpha/dp264.c             | 2 +-
 hw/i386/microvm.c            | 3 ++-
 hw/mips/jazz.c               | 2 +-
 hw/ppc/pnv.c                 | 2 +-
 hw/rtc/mc146818rtc.c         | 6 +++---
 hw/rtc/sun4v-rtc.c           | 6 +++---
 hw/sparc64/niagara.c         | 2 +-
 include/hw/rtc/mc146818rtc.h | 2 +-
 include/hw/rtc/sun4v-rtc.h   | 2 +-
 9 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 9cd448cff1..40dee88f2d 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -119,7 +119,7 @@ static void clipper_init(MachineState *machine)
     qdev_connect_gpio_out(i82378_dev, 0, isa_irq);
 
     /* Since we have an SRM-compatible PALcode, use the SRM epoch.  */
-    mc146818_rtc_init(isa_bus, 1900, rtc_irq);
+    mc146818_rtc_init(mo, isa_bus, 1900, rtc_irq);
 
     /* VGA setup.  Don't bother loading the bios.  */
     pci_vga_init(pci_bus);
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 16bd885541..d13036bd73 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -268,7 +268,8 @@ static void microvm_devices_init(MicrovmMachineState *mms)
 
     if (mms->rtc == ON_OFF_AUTO_ON ||
         (mms->rtc == ON_OFF_AUTO_AUTO && !kvm_enabled())) {
-        microvm_set_rtc(mms, mc146818_rtc_init(isa_bus, 2000, NULL));
+        microvm_set_rtc(mms, mc146818_rtc_init(OBJECT(mms), isa_bus,
+                                               2000, NULL));
     }
 
     if (mms->isa_serial) {
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 62f2350d36..938aaf3fe1 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -354,7 +354,7 @@ static void mips_jazz_init(MachineState *machine,
     fdctrl_init_sysbus(qdev_get_gpio_in(rc4030, 1), 0x80003000, fds);
 
     /* Real time clock */
-    mc146818_rtc_init(isa_bus, 1980, NULL);
+    mc146818_rtc_init(OBJECT(machine), isa_bus, 1980, NULL);
     memory_region_init_io(rtc, NULL, &rtc_ops, NULL, "rtc", 0x1000);
     memory_region_add_subregion(address_space, 0x80004000, rtc);
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0a22d854d7..1eb3c09672 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1314,7 +1314,7 @@ static void pnv_init(MachineState *machine)
     serial_hds_isa_init(pnv->isa_bus, 0, MAX_ISA_SERIAL_PORTS);
 
     /* Create an RTC ISA device too */
-    mc146818_rtc_init(pnv->isa_bus, 2000, NULL);
+    mc146818_rtc_init(OBJECT(machine), pnv->isa_bus, 2000, NULL);
 
     /*
      * Create the machine BMC simulator and the IPMI BT device for
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index b9e5ec6ff6..a4d6d59502 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -923,18 +923,18 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(dev, &s->irq, 1);
 }
 
-MC146818RtcState *mc146818_rtc_init(ISABus *bus, int base_year,
+MC146818RtcState *mc146818_rtc_init(Object *parent, ISABus *bus, int base_year,
                                     qemu_irq intercept_irq)
 {
     DeviceState *dev;
     ISADevice *isadev;
     MC146818RtcState *s;
 
-    isadev = isa_new_orphan(TYPE_MC146818_RTC);
+    isadev = isa_new(parent, "rtc[*]", TYPE_MC146818_RTC);
     dev = DEVICE(isadev);
     s = MC146818_RTC(isadev);
     qdev_prop_set_int32(dev, "base_year", base_year);
-    isa_realize_and_unref(isadev, bus, &error_fatal);
+    qdev_realize(dev, BUS(bus), &error_fatal);
     if (intercept_irq) {
         qdev_connect_gpio_out(dev, 0, intercept_irq);
     } else {
diff --git a/hw/rtc/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
index 257f70885d..ee07b7a979 100644
--- a/hw/rtc/sun4v-rtc.c
+++ b/hw/rtc/sun4v-rtc.c
@@ -52,15 +52,15 @@ static const MemoryRegionOps sun4v_rtc_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-void sun4v_rtc_init(hwaddr addr)
+void sun4v_rtc_init(Object *parent, hwaddr addr)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan(TYPE_SUN4V_RTC);
+    dev = qdev_new(parent, "rtc", TYPE_SUN4V_RTC);
     s = SYS_BUS_DEVICE(dev);
 
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
 
     sysbus_mmio_map(s, 0, addr);
 }
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 1211ecb82d..d47d62dac7 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -154,7 +154,7 @@ static void niagara_init(MachineState *machine)
     serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL,
                    115200, serial_hd(0), DEVICE_BIG_ENDIAN);
     create_unimplemented_device("sun4v-iob", NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
-    sun4v_rtc_init(NIAGARA_RTC_BASE);
+    sun4v_rtc_init(OBJECT(machine), NIAGARA_RTC_BASE);
 }
 
 static void niagara_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
index 64893be151..1bdd63cf5c 100644
--- a/include/hw/rtc/mc146818rtc.h
+++ b/include/hw/rtc/mc146818rtc.h
@@ -51,7 +51,7 @@ struct MC146818RtcState {
 
 #define RTC_ISA_IRQ 8
 
-MC146818RtcState *mc146818_rtc_init(ISABus *bus, int base_year,
+MC146818RtcState *mc146818_rtc_init(Object *parent, ISABus *bus, int base_year,
                                     qemu_irq intercept_irq);
 void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val);
 int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
diff --git a/include/hw/rtc/sun4v-rtc.h b/include/hw/rtc/sun4v-rtc.h
index 26a9eb6196..9152a0082f 100644
--- a/include/hw/rtc/sun4v-rtc.h
+++ b/include/hw/rtc/sun4v-rtc.h
@@ -14,6 +14,6 @@
 
 #include "exec/hwaddr.h"
 
-void sun4v_rtc_init(hwaddr addr);
+void sun4v_rtc_init(Object *parent, hwaddr addr);
 
 #endif
-- 
2.47.1


