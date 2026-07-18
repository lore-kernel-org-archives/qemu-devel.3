Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691EBC4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDHn-0001hb-No; Sat, 18 Jul 2026 18:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDHm-0001fM-My; Sat, 18 Jul 2026 18:13:30 -0400
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.162.73.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDHk-000727-FQ; Sat, 18 Jul 2026 18:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412808; x=1815948808;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2rUYyvp0yoC0czB99xFILg02Yh5zYj/aKfGpiYZESzM=;
 b=ZaN9SDnCTDSPHH0m7TunTz5E67MosXvxErJO92gZfIQU90o3G7dGpgVh
 a3yqtHAxLHt6JLT28Ph4sU/asWtFoVsZUFxwNC4bmZFoAQv0Ej018J63+
 dyI+mYqec1RqYkgsIvMNAwIt10CgGh0xcLFEfLdNGEv3gRtAtvyZ5ae8L
 Bpd+t6djYCkvvda9yu7mUdzHg2c0NxEbVPm0QGcl4yjxrQyqkYUBNq/c7
 gOn3hgP4xf3y9KQRXAaMmKyff/fUnyITvhime3Jcva//AUKkube18S7y/
 A/FMLLlYkTYkVdcyaPQBfx3KLCgThFSzHaUb5n0xEXdnO1y94Euuvqz4H g==;
X-CSE-ConnectionGUID: KYZX85irQVyYxz7Sek0jjQ==
X-CSE-MsgGUID: yEX/J5Y7QmeM8bn6IbxGTw==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23716960"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:13:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:2751]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.34:2525]
 with esmtp (Farcaster)
 id cd0c56f9-b413-413d-a759-4da03a24c6ff; Sat, 18 Jul 2026 22:13:20 +0000 (UTC)
X-Farcaster-Flow-ID: cd0c56f9-b413-413d-a759-4da03a24c6ff
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:13:20 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:13:10 +0000
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
Subject: [RFC PATCH v2 130/137] hw: Pair object_initialize_child() with plain
 realize()
Date: Sat, 18 Jul 2026 21:36:45 +0000
Message-ID: <20260718213652.37673-131-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
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

A number of composite devices and boards create embedded children
via object_initialize_child() (or object_new_with_props()) and
then realize them via *_realize_and_unref().  The child<> property
already holds the sole reference; the extra unref drops it and the
object survives only because bus_add_child() takes a reference of
its own.  Use plain sysbus_realize()/qdev_realize() so the parent's
child<> keeps the reference it is documented to hold.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/imx8mm-evk.c          | 2 +-
 hw/arm/imx8mp-evk.c          | 2 +-
 hw/arm/mps2.c                | 2 +-
 hw/display/sm501.c           | 2 +-
 hw/m68k/q800.c               | 6 +++---
 hw/misc/macio/macio.c        | 2 +-
 hw/net/imx_fec.c             | 2 +-
 hw/net/lan9118.c             | 2 +-
 hw/nubus/nubus-virtio-mmio.c | 2 +-
 hw/pci-host/mv64361.c        | 2 +-
 hw/xen/xen-pvh-common.c      | 2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 72fa1930ae..84a1ae6aa4 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -80,7 +80,7 @@ static void imx8mm_evk_init(MachineState *machine)
     s = FSL_IMX8MM(object_new_with_props(TYPE_FSL_IMX8MM, OBJECT(machine),
                                          "soc", &error_fatal, NULL));
     object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(s), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MM_RAM_START,
                                 machine->ram);
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 6116e6e9dc..776aa22b9a 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -93,7 +93,7 @@ static void imx8mp_evk_init(MachineState *machine)
         object_property_set_link(OBJECT(&s->soc), bus_name,
                                  OBJECT(s->canbus[i]), &error_fatal);
     }
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->soc), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
                                 machine->ram);
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 1032f47cb8..3de11b19a9 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -379,7 +379,7 @@ static void mps2_common_init(MachineState *machine)
                                 TYPE_CMSDK_APB_TIMER);
         sbd = SYS_BUS_DEVICE(&mms->timer[i]);
         qdev_connect_clock_in(DEVICE(&mms->timer[i]), "pclk", mms->sysclk);
-        sysbus_realize_and_unref(sbd, &error_fatal);
+        sysbus_realize(sbd, &error_fatal);
         sysbus_mmio_map(sbd, 0, base);
         sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(armv7m, irqno));
     }
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 56075a0303..4256ee0318 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -2091,7 +2091,7 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->state.mmio_region);
 
     /* bridge to usb host emulation module */
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->ohci), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ohci), &error_fatal);
     memory_region_add_subregion(&s->state.mmio_region, SM501_USB_HOST,
                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ohci), 0));
     sysbus_pass_irq(sbd, SYS_BUS_DEVICE(&s->ohci));
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 677dc4ad80..9fc186737b 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -324,14 +324,14 @@ static void q800_machine_init(MachineState *machine)
     object_initialize_child(OBJECT(machine), "djmemc", &m->djmemc,
                             TYPE_DJMEMC);
     sysbus = SYS_BUS_DEVICE(&m->djmemc);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus_realize(sysbus, &error_fatal);
     memory_region_add_subregion(&m->macio, DJMEMC_BASE - IO_BASE,
                                 sysbus_mmio_get_region(sysbus, 0));
 
     /* IOSB subsystem */
     object_initialize_child(OBJECT(machine), "iosb", &m->iosb, TYPE_IOSB);
     sysbus = SYS_BUS_DEVICE(&m->iosb);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus_realize(sysbus, &error_fatal);
     memory_region_add_subregion(&m->macio, IOSB_BASE - IO_BASE,
                                 sysbus_mmio_get_region(sysbus, 0));
 
@@ -497,7 +497,7 @@ static void q800_machine_init(MachineState *machine)
         qdev_prop_set_string(DEVICE(&m->asc), "audiodev", machine->audiodev);
     }
     sysbus = SYS_BUS_DEVICE(&m->asc);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus_realize(sysbus, &error_fatal);
     memory_region_add_subregion(&m->macio, ASC_BASE - IO_BASE,
                                 sysbus_mmio_get_region(sysbus, 0));
     sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(DEVICE(&m->glue),
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 2813705c03..a26babfbc2 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -274,7 +274,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
     /* OpenPIC */
     qdev_prop_set_uint32(pic_dev, "model", OPENPIC_MODEL_KEYLARGO);
     sbd = SYS_BUS_DEVICE(&ns->pic);
-    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_realize(sbd, &error_fatal);
     memory_region_add_subregion(&s->bar, 0x40000,
                                 sysbus_mmio_get_region(sbd, 0));
 
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 38e0f64462..fddb0bbba3 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1207,7 +1207,7 @@ static void imx_eth_realize(DeviceState *dev, Error **errp)
 
     qemu_init_irq_child(OBJECT(s), "mii-irq", &s->mii_irq, imx_phy_update_irq, s, 0);
     object_initialize_child(OBJECT(s), "mii", &s->mii, TYPE_LAN9118_PHY);
-    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->mii), errp)) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mii), errp)) {
         return;
     }
     qdev_connect_gpio_out(DEVICE(&s->mii), 0, &s->mii_irq);
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 2003280fc4..fa425bb5bb 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1276,7 +1276,7 @@ static void lan9118_realize(DeviceState *dev, Error **errp)
 
     qemu_init_irq_child(OBJECT(s), "mii-irq", &s->mii_irq, lan9118_update_irq, s, 0);
     object_initialize_child(OBJECT(s), "mii", &s->mii, TYPE_LAN9118_PHY);
-    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->mii), errp)) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mii), errp)) {
         return;
     }
     qdev_connect_gpio_out(DEVICE(&s->mii), 0, &s->mii_irq);
diff --git a/hw/nubus/nubus-virtio-mmio.c b/hw/nubus/nubus-virtio-mmio.c
index 63aeca5b12..29008ea6c2 100644
--- a/hw/nubus/nubus-virtio-mmio.c
+++ b/hw/nubus/nubus-virtio-mmio.c
@@ -51,7 +51,7 @@ static void nubus_virtio_mmio_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < NUBUS_VIRTIO_MMIO_NUM_DEVICES; i++) {
         sbd = SYS_BUS_DEVICE(&s->virtio_mmio[i]);
         qdev_prop_set_bit(DEVICE(sbd), "force-legacy", false);
-        if (!sysbus_realize_and_unref(sbd, errp)) {
+        if (!sysbus_realize(sbd, errp)) {
             return;
         }
 
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index 3ef51fef1b..8c3dadd490 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -874,7 +874,7 @@ static void mv64361_realize(DeviceState *dev, Error **errp)
                                 TYPE_MV64361_PCI);
         DeviceState *pci = DEVICE(&s->pci[i]);
         qdev_prop_set_uint8(pci, "index", i);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(pci), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(pci), &error_fatal);
     }
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->cpu_irq);
     qdev_init_gpio_in_named(dev, mv64361_gpp_irq, "gpp", 32);
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 76893c8fcf..9ced68afea 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -230,7 +230,7 @@ static inline void xenpvh_gpex_init(XenPVHMachineState *s,
     object_initialize_child(OBJECT(s), "gpex", &s->pci.gpex,
                             TYPE_GPEX_HOST);
     dev = DEVICE(&s->pci.gpex);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
     memory_region_add_subregion(sysmem, s->cfg.pci_ecam.base, ecam_reg);
-- 
2.47.1


