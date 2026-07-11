Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D60C44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigLv-0000st-Ui; Sat, 11 Jul 2026 18:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigLt-0000jX-Mm; Sat, 11 Jul 2026 18:39:17 -0400
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.83.148.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigLr-0005HS-2v; Sat, 11 Jul 2026 18:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809555; x=1815345555;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2/tPB5nK5CCZaejzBkBCaNYV6BU4L3QqHdr1eu5bEZ8=;
 b=nh1K7vJpnaaXzs1Aunh8qRS5WpS+o/8qh7xIpW/8xIqqbBVNXha2PT8h
 ltqA5y6sQKS9NpOcGjW+ednt737ognN74P9j8CbDwFcJR8TeIcY70TTEF
 cGhBgcS1pijVP0vCLPjL5jMl+ljEJCLgC+8Il9d6nB89ghvYbLvokTzbC
 VcfL8/OaQ7xEj/heS+Etkz4+NXFHbPd/t/evyDvI384O2iug4mgaDyIJo
 UQKsGScpEvIS8ApGolIgGBT1th+YtXeZsvFF5BVLFrNlfmnwk1Pbiszix
 vWkJf3fdbKjOg3Jvgjue6wVajVrcOG8rAZCzGQtvQKZSQ4CCNbaBIyMBy w==;
X-CSE-ConnectionGUID: 62CIUt+pSJCdPf2D0bdTSw==
X-CSE-MsgGUID: 3EOhOs2fQdmYloEKAHzm1w==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23287400"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:39:11 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:24725]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.212:2525]
 with esmtp (Farcaster)
 id 538bceb4-5db2-4d0e-aed2-271f3a1daee7; Sat, 11 Jul 2026 22:39:11 +0000 (UTC)
X-Farcaster-Flow-ID: 538bceb4-5db2-4d0e-aed2-271f3a1daee7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:39:10 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:39:02 +0000
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
Subject: [RFC PATCH 008/134] ssi,
 usb: Make bus-layer creators take a QOM parent
Date: Sat, 11 Jul 2026 22:35:01 +0000
Message-ID: <20260711223707.42139-9-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.83.148.184;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Apply the rename-and-reintroduce treatment to the remaining
bus-layer helpers that wrap qdev_new_orphan():

  ssi_create_peripheral()  -> ssi_create_peripheral_orphan()
  usb_create_simple()      -> usb_create_simple_orphan()

and reintroduce the short names with a leading (parent, id, ...)
pair.  Also add a usb_new(parent, id, type) helper for callers that
need to set properties before realize.

sd-bus, apple-desktop-bus, HDA, aux-bus and spapr-vio have no bus-
layer creation wrapper: their onboard devices are open-coded via
qdev_new_orphan() at each call site and will be converted directly
to qdev_new(parent, id, type) in the per-subdirectory conversion
patches.

The mechanical rename part is generated by

  spatch --sp-file scripts/coccinelle/qom-parent/ssi-usb-orphan.cocci \
         --in-place --include-headers --dir .

or equivalently

  git ls-files '*.[ch]' '*.[ch].inc' '*.rst' '*.py' | \
      grep -v '^subprojects/' | \
      xargs sed -i \
          's/\bssi_create_peripheral\b/&_orphan/g;
           s/\busb_create_simple\b/&_orphan/g'

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/stellaris.c                             |  2 +-
 hw/hppa/machine.c                              |  4 ++--
 hw/mips/loongson3_virt.c                       |  4 ++--
 hw/ppc/mac_newworld.c                          |  4 ++--
 hw/ppc/sam460ex.c                              |  4 ++--
 hw/ppc/spapr.c                                 |  4 ++--
 hw/riscv/sifive_u.c                            |  2 +-
 hw/sh4/r2d.c                                   |  2 +-
 hw/ssi/ssi.c                                   | 11 ++++++++++-
 hw/vmapple/vmapple.c                           |  4 ++--
 include/hw/ssi/ssi.h                           |  6 ++++--
 include/hw/usb/usb.h                           | 18 +++++++++++++++++-
 .../coccinelle/qom-parent/ssi-usb-orphan.cocci | 18 ++++++++++++++++++
 13 files changed, 64 insertions(+), 19 deletions(-)
 create mode 100644 scripts/coccinelle/qom-parent/ssi-usb-orphan.cocci

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index f9d2a61f9c..7a18d98477 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1300,7 +1300,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
              *  - Make the ssd0323 OLED controller chipselect active-low
              */
             bus = qdev_get_child_bus(dev, "ssi");
-            sddev = ssi_create_peripheral(bus, "ssi-sd");
+            sddev = ssi_create_peripheral_orphan(bus, "ssi-sd");
 
             dinfo = drive_get(IF_SD, 0, 0);
             blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 91fe4845c4..44dab9225a 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -446,8 +446,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
         pci_create_simple_orphan(pci_bus, -1, "pci-ohci");
         usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                           &error_abort));
-        usb_create_simple(usb_bus, "usb-kbd");
-        usb_create_simple(usb_bus, "usb-mouse");
+        usb_create_simple_orphan(usb_bus, "usb-kbd");
+        usb_create_simple_orphan(usb_bus, "usb-mouse");
     }
 
     /* register power switch emulation */
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 1729eb1c0b..f43c231004 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -468,8 +468,8 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
         pci_create_simple_orphan(pci_bus, -1, "pci-ohci");
         usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                           &error_abort));
-        usb_create_simple(usb_bus, "usb-kbd");
-        usb_create_simple(usb_bus, "usb-tablet");
+        usb_create_simple_orphan(usb_bus, "usb-kbd");
+        usb_create_simple_orphan(usb_bus, "usb-tablet");
     }
 
     pci_init_nic_devices(pci_bus, mc->default_nic);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 0df953b9e1..72baeef60a 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -425,8 +425,8 @@ static void ppc_core99_init(MachineState *machine)
 
             usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                               &error_abort));
-            usb_create_simple(usb_bus, "usb-kbd");
-            usb_create_simple(usb_bus, "usb-mouse");
+            usb_create_simple_orphan(usb_bus, "usb-kbd");
+            usb_create_simple_orphan(usb_bus, "usb-mouse");
         }
     }
 
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 767a5eb596..39e704dfaa 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -398,8 +398,8 @@ static void sam460ex_init(MachineState *machine)
     sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(uic[2], 30));
     usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                       &error_abort));
-    usb_create_simple(usb_bus, "usb-kbd");
-    usb_create_simple(usb_bus, "usb-mouse");
+    usb_create_simple_orphan(usb_bus, "usb-kbd");
+    usb_create_simple_orphan(usb_bus, "usb-mouse");
 
     /* PCIe buses */
     dev = qdev_new_orphan(TYPE_PPC460EX_PCIE_HOST);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4ead6ba664..e09b529ebc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3082,8 +3082,8 @@ static void spapr_machine_init(MachineState *machine)
 
             usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                               &error_abort));
-            usb_create_simple(usb_bus, "usb-kbd");
-            usb_create_simple(usb_bus, "usb-mouse");
+            usb_create_simple_orphan(usb_bus, "usb-kbd");
+            usb_create_simple_orphan(usb_bus, "usb-mouse");
         }
     }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index db6d984f94..47ce75ef11 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -606,7 +606,7 @@ static void sifive_u_machine_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->soc.spi0), 1, flash_cs);
 
     /* Connect an SD card to SPI2 */
-    sd_dev = ssi_create_peripheral(s->soc.spi2.spi, "ssi-sd");
+    sd_dev = ssi_create_peripheral_orphan(s->soc.spi2.spi, "ssi-sd");
 
     sd_cs = qdev_get_gpio_in_named(sd_dev, SSI_GPIO_CS, 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->soc.spi2), 1, sd_cs);
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 0b502ca392..6f8d270fae 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -320,7 +320,7 @@ static void r2d_init(MachineState *machine)
     /* USB keyboard */
     usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                       &error_abort));
-    usb_create_simple(usb_bus, "usb-kbd");
+    usb_create_simple_orphan(usb_bus, "usb-kbd");
 
     /* Todo: register on board registers */
     memset(&boot_params, 0, sizeof(boot_params));
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index b1935271f0..6031cde7b0 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -138,7 +138,16 @@ bool ssi_realize_and_unref(DeviceState *dev, SSIBus *bus, Error **errp)
     return qdev_realize_and_unref(dev, &bus->parent_obj, errp);
 }
 
-DeviceState *ssi_create_peripheral(SSIBus *bus, const char *name)
+DeviceState *ssi_create_peripheral(Object *parent, const char *id,
+                                    SSIBus *bus, const char *type)
+{
+    DeviceState *dev = qdev_new(parent, id, type);
+
+    qdev_realize(dev, BUS(bus), &error_fatal);
+    return dev;
+}
+
+DeviceState *ssi_create_peripheral_orphan(SSIBus *bus, const char *name)
 {
     DeviceState *dev = qdev_new_orphan(name);
 
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index bf19faa04a..4d218748c2 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -425,8 +425,8 @@ static void create_pcie(VMAppleMachineState *vms)
 
         usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                           &error_fatal));
-        usb_create_simple(usb_bus, "usb-kbd");
-        usb_create_simple(usb_bus, "usb-tablet");
+        usb_create_simple_orphan(usb_bus, "usb-kbd");
+        usb_create_simple_orphan(usb_bus, "usb-tablet");
     }
 }
 
diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index 153bf0cb9c..36ed002281 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -81,7 +81,9 @@ extern const VMStateDescription vmstate_ssi_peripheral;
     .offset     = vmstate_offset_value(_state, _field, SSIPeripheral), \
 }
 
-DeviceState *ssi_create_peripheral(SSIBus *bus, const char *name);
+DeviceState *ssi_create_peripheral(Object *parent, const char *id,
+                                    SSIBus *bus, const char *type);
+DeviceState *ssi_create_peripheral_orphan(SSIBus *bus, const char *name);
 /**
  * ssi_realize_and_unref: realize and unref an SSI peripheral
  * @dev: SSI peripheral to realize
@@ -95,7 +97,7 @@ DeviceState *ssi_create_peripheral(SSIBus *bus, const char *name);
  * This function is useful if you have created @dev via qdev_new_orphan()
  * (which takes a reference to the device it returns to you), so that
  * you can set properties on it before realizing it. If you don't need
- * to set properties then ssi_create_peripheral() is probably better (as it
+ * to set properties then ssi_create_peripheral_orphan() is probably better (as it
  * does the create, init and realize in one step).
  *
  * If you are embedding the SSI peripheral into another QOM device and
diff --git a/include/hw/usb/usb.h b/include/hw/usb/usb.h
index 6ef190523f..1ae1f40aa9 100644
--- a/include/hw/usb/usb.h
+++ b/include/hw/usb/usb.h
@@ -584,7 +584,23 @@ static inline bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **er
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
 }
 
-static inline USBDevice *usb_create_simple(USBBus *bus, const char *name)
+static inline USBDevice *usb_new(Object *parent, const char *id,
+                                  const char *type)
+{
+    return USB_DEVICE(qdev_new(parent, id, type));
+}
+
+static inline USBDevice *usb_create_simple(Object *parent, const char *id,
+                                            USBBus *bus, const char *type)
+{
+    USBDevice *dev = usb_new(parent, id, type);
+
+    qdev_realize(DEVICE(dev), BUS(bus), &error_abort);
+    return dev;
+}
+
+static inline USBDevice *usb_create_simple_orphan(USBBus *bus,
+                                                    const char *name)
 {
     USBDevice *dev = USB_DEVICE(qdev_new_orphan(name));
 
diff --git a/scripts/coccinelle/qom-parent/ssi-usb-orphan.cocci b/scripts/coccinelle/qom-parent/ssi-usb-orphan.cocci
new file mode 100644
index 0000000000..7d201536d8
--- /dev/null
+++ b/scripts/coccinelle/qom-parent/ssi-usb-orphan.cocci
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Rename ssi_create_peripheral()/usb_create_simple() to *_orphan()
+// so that the short names can be reintroduced with a mandatory
+// (parent, id, ...) signature.
+//
+// spatch --sp-file scripts/coccinelle/qom-parent/ssi-usb-orphan.cocci \
+//        --in-place --include-headers --dir .
+
+@@
+@@
+- ssi_create_peripheral
++ ssi_create_peripheral_orphan
+
+@@
+@@
+- usb_create_simple
++ usb_create_simple_orphan
-- 
2.47.1


