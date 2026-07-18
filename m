Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4817EC4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCsf-000449-58; Sat, 18 Jul 2026 17:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCse-00043E-BN; Sat, 18 Jul 2026 17:47:32 -0400
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.42.203.116])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCsb-0003OR-US; Sat, 18 Jul 2026 17:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411249; x=1815947249;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DcTiWLcvlC8/abn8hIJ99J45gxy0GpztHbEenjChIKk=;
 b=QY6ntlIsGxkNnRu054/zoDSI+RXb3DUN60GxDxWeRLyIgl1x33Jblx37
 4TlUNr40hpnQtgZ6JJIC/7xquPVyVJBF/OmWBBZAYa6RDHoPqpkRuaWMx
 VAlC65JEORVM6JrxrLhSSvr+HPx4BYgflYWvnc2sBELw8ugMHd+eSZgXN
 hz4J2XIblVR3Hx0Gbj/I0jxn0Om+9qFgBr6HskiB3Jr8KYpWG2189YKBy
 UKnJ8yy171Ph1LctDGCa3fyZN0AgWRlUNAWXpNiw49crMou7aj5ANbBta
 ltb0ZAysDe9+4I41+LXNpIw4idCUgeP5pIhh1W0PnwwpMAj4C044tCUXg w==;
X-CSE-ConnectionGUID: 1DWh0IeFTAaSpNKTd7rI4A==
X-CSE-MsgGUID: jze1tS/VQA+C23vJh5Of4Q==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23939685"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:47:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:21661]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.17:2525]
 with esmtp (Farcaster)
 id c129490f-c337-4623-a7af-cf9e44a9afe6; Sat, 18 Jul 2026 21:47:26 +0000 (UTC)
X-Farcaster-Flow-ID: c129490f-c337-4623-a7af-cf9e44a9afe6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:47:25 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:47:16 +0000
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
Subject: [RFC PATCH v2 038/137] hw/net: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:13 +0000
Message-ID: <20260718213652.37673-39-graf@amazon.com>
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
Received-SPF: pass client-ip=52.42.203.116;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/net to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/net/lan9118.c:1342 | qdev_new | parent | "eth" | thread Object *parent as first arg; 5 board-init callers pass OBJECT(machine)
hw/net/smc91c111.c:957 | qdev_new | parent | "eth" | thread Object *parent as first arg; 3 board-init callers pass OBJECT(machine)
hw/net/spapr_llan.c:374 | qdev_new | parent | "vlan[*]" | thread Object *parent as first arg; single caller in hw/ppc/spapr.c board-init loop passes OBJECT(spapr)
hw/net/xen_nic.c:622 | qdev_new | ORPHAN-JUSTIFIED | - | XenBackendOps.create hotplug callback driven by xenstore watch; dynamic device with no board owner (same pattern as xen-block/xen_console)

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/integratorcp.c      | 2 +-
 hw/arm/kzm.c               | 2 +-
 hw/arm/mps2.c              | 2 +-
 hw/arm/mps3r.c             | 2 +-
 hw/arm/realview.c          | 4 ++--
 hw/arm/versatilepb.c       | 2 +-
 hw/arm/vexpress.c          | 2 +-
 hw/net/lan9118.c           | 6 +++---
 hw/net/smc91c111.c         | 6 +++---
 hw/net/spapr_llan.c        | 6 +++---
 hw/ppc/spapr.c             | 2 +-
 include/hw/net/lan9118.h   | 2 +-
 include/hw/net/smc91c111.h | 2 +-
 include/hw/ppc/spapr_vio.h | 2 +-
 14 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 3df488921a..163012a7bf 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -670,7 +670,7 @@ static void integratorcp_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[25]);
 
     if (qemu_find_nic_info("smc91c111", true, NULL)) {
-        smc91c111_init(0xc8000000, pic[27]);
+        smc91c111_init(OBJECT(machine), 0xc8000000, pic[27]);
     }
 
     dev = qdev_new_orphan("pl110");
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 168ecf35d0..de9919c8cb 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -115,7 +115,7 @@ static void kzm_init(MachineState *machine)
     }
 
     if (qemu_find_nic_info("lan9118", true, NULL)) {
-        lan9118_init(KZM_LAN9118_ADDR,
+        lan9118_init(OBJECT(machine), KZM_LAN9118_ADDR,
                      qdev_get_gpio_in(DEVICE(&s->soc.avic), 52));
     }
 
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 5a0384a412..e646c7c71e 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -461,7 +461,7 @@ static void mps2_common_init(MachineState *machine)
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
      */
-    lan9118_init(mmc->ethernet_base,
+    lan9118_init(OBJECT(machine), mmc->ethernet_base,
                  qdev_get_gpio_in(armv7m,
                                   mmc->fpga_type == FPGA_AN511 ? 47 : 13));
 
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index caad820d3b..8e249c9b9d 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -549,7 +549,7 @@ static void mps3r_common_init(MachineState *machine)
      * In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
      */
-    lan9118_init(0xe0300000,
+    lan9118_init(OBJECT(machine), 0xe0300000,
                  qdev_get_gpio_in(gicdev, 18));
 
     create_unimplemented_device("usb", 0xe0301000, 0x1000);
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index f37ddf8073..f51730c487 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -309,9 +309,9 @@ static void realview_init(MachineState *machine,
 
     if (qemu_find_nic_info(is_pb ? "lan9118" : "smc91c111", true, NULL)) {
         if (is_pb) {
-            lan9118_init(0x4e000000, pic[28]);
+            lan9118_init(OBJECT(machine), 0x4e000000, pic[28]);
         } else {
-            smc91c111_init(0x4e000000, pic[28]);
+            smc91c111_init(OBJECT(machine), 0x4e000000, pic[28]);
         }
     }
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index dcc7b7debd..5de99cb854 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -265,7 +265,7 @@ static void versatile_init(MachineState *machine, int board_id)
     pci_bus = (PCIBus *)qdev_get_child_bus(dev, "pci");
 
     if (qemu_find_nic_info("smc91c111", true, NULL)) {
-        smc91c111_init(0x10010000, sic[25]);
+        smc91c111_init(OBJECT(machine), 0x10010000, sic[25]);
     }
     pci_init_nic_devices(pci_bus, "rtl8139");
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index ffd3c52d4f..5cbb2c44cb 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -694,7 +694,7 @@ static void vexpress_common_init(MachineState *machine)
 
     /* 0x4e000000 LAN9118 Ethernet */
     if (qemu_find_nic_info("lan9118", true, NULL)) {
-        lan9118_init(map[VE_ETHERNET], pic[15]);
+        lan9118_init(OBJECT(machine), map[VE_ETHERNET], pic[15]);
     }
 
     /* VE_USB: not modelled */
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 87213c0d8d..91c3533702 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1334,15 +1334,15 @@ static void lan9118_register_types(void)
 
 /* Legacy helper function.  Should go away when machine config files are
    implemented.  */
-void lan9118_init(uint32_t base, qemu_irq irq)
+void lan9118_init(Object *parent, uint32_t base, qemu_irq irq)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan(TYPE_LAN9118);
+    dev = qdev_new(parent, "eth", TYPE_LAN9118);
     qemu_configure_nic_device(dev, true, NULL);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_mmio_map(s, 0, base);
     sysbus_connect_irq(s, 0, irq);
 }
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 6186d88717..85f3d4d34a 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -949,15 +949,15 @@ static void smc91c111_register_types(void)
 
 /* Legacy helper function.  Should go away when machine config files are
    implemented.  */
-void smc91c111_init(uint32_t base, qemu_irq irq)
+void smc91c111_init(Object *parent, uint32_t base, qemu_irq irq)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan(TYPE_SMC91C111);
+    dev = qdev_new(parent, "eth", TYPE_SMC91C111);
     qemu_configure_nic_device(dev, true, NULL);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_mmio_map(s, 0, base);
     sysbus_connect_irq(s, 0, irq);
 }
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index f10ea64798..1d5637f294 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -367,15 +367,15 @@ static void spapr_vlan_instance_finalize(Object *obj)
     }
 }
 
-void spapr_vlan_create(SpaprVioBus *bus, NICInfo *nd)
+void spapr_vlan_create(Object *parent, SpaprVioBus *bus, NICInfo *nd)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan("spapr-vlan");
+    dev = qdev_new(parent, "vlan[*]", "spapr-vlan");
 
     qdev_set_nic_properties(dev, nd);
 
-    qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
+    qdev_realize(dev, &bus->bus, &error_fatal);
 }
 
 static int spapr_vlan_devnode(SpaprVioDevice *dev, void *fdt, int node_off)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 91f9d873b8..b81db9e8f3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3056,7 +3056,7 @@ static void spapr_machine_init(MachineState *machine)
     phb = spapr_create_default_phb();
 
     while ((nd = qemu_find_nic_info("spapr-vlan", true, "ibmveth"))) {
-        spapr_vlan_create(spapr->vio_bus, nd);
+        spapr_vlan_create(OBJECT(spapr), spapr->vio_bus, nd);
     }
 
     pci_init_nic_devices(phb->bus, NULL);
diff --git a/include/hw/net/lan9118.h b/include/hw/net/lan9118.h
index 4bf9da7a63..b199f1912f 100644
--- a/include/hw/net/lan9118.h
+++ b/include/hw/net/lan9118.h
@@ -15,6 +15,6 @@
 
 #define TYPE_LAN9118 "lan9118"
 
-void lan9118_init(uint32_t, qemu_irq);
+void lan9118_init(Object *parent, uint32_t, qemu_irq);
 
 #endif
diff --git a/include/hw/net/smc91c111.h b/include/hw/net/smc91c111.h
index dba32a233f..788f12678e 100644
--- a/include/hw/net/smc91c111.h
+++ b/include/hw/net/smc91c111.h
@@ -13,6 +13,6 @@
 
 #include "net/net.h"
 
-void smc91c111_init(uint32_t, qemu_irq);
+void smc91c111_init(Object *parent, uint32_t, qemu_irq);
 
 #endif
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 72baef6919..fcb29aebff 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -138,7 +138,7 @@ int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t *crq);
 SpaprVioDevice *vty_lookup(SpaprMachineState *spapr, target_ulong reg);
 void vty_putchars(SpaprVioDevice *sdev, uint8_t *buf, int len);
 void spapr_vty_create(SpaprVioBus *bus, Chardev *chardev);
-void spapr_vlan_create(SpaprVioBus *bus, NICInfo *nd);
+void spapr_vlan_create(Object *parent, SpaprVioBus *bus, NICInfo *nd);
 void spapr_vscsi_create(Object *parent, SpaprVioBus *bus);
 
 SpaprVioDevice *spapr_vty_get_default(SpaprVioBus *bus);
-- 
2.47.1


