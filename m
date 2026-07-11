Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C5BC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigPu-0000EY-5F; Sat, 11 Jul 2026 18:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigPj-0008JK-Vk; Sat, 11 Jul 2026 18:43:18 -0400
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([34.218.115.239])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigPf-0006RZ-63; Sat, 11 Jul 2026 18:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809791; x=1815345791;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ipuG9DD/JbTnStr10bTe+gLM1Cmyua+CwvPb3LwRECA=;
 b=EJdGICfHaSs76fbh4ZmYzvYlPtrUkuKOkdO7w/nH0r++Wh0CsawguXAG
 mCJonLIbn2BvlapFZEEaIP22YCKgO4Pep/SlY+jGb0h+dMpnS9MDHLgMK
 QF3M4KlxZqAZsBTnmahZTKxxuQEnYY7SVfO3iK5Tlg9fDKhEH3yt7OmcY
 KIGUm+UCDVl5teO85D4UlQ0AMtCULSaKAlRPtc4rfN/h4WD8MmIaHDJmZ
 kjIFCcHH1/mXCFmktcRIb+Kcr5s5j9j+vWp3VLVRiRC3aWVypCEhPSGaW
 quk1HbdjDg7bO7ROCNaIl+zS/W7t0eBC6tQXbUqrC5dbHmyRyjZB52dlO g==;
X-CSE-ConnectionGUID: R/0HL0xDTuCkliZFlif8eg==
X-CSE-MsgGUID: NE5F6SR3Sbi2rwz5WAN3FA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23296603"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:43:07 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:18710]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525]
 with esmtp (Farcaster)
 id 624545ff-e39f-4163-9dfc-222ea930af4e; Sat, 11 Jul 2026 22:43:07 +0000 (UTC)
X-Farcaster-Flow-ID: 624545ff-e39f-4163-9dfc-222ea930af4e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:43:07 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:42:58 +0000
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
Subject: [RFC PATCH 023/134] hw/pci-host: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:16 +0000
Message-ID: <20260711223707.42139-24-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
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

Convert the *_orphan() device-creation calls in hw/pci-host to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

  hw/pci-host/articia.c:188 | OBJECT(dev) | "host-func" | articia_realize(): PCI-facing host function is composite child of the ArticiaS host bridge
  hw/pci-host/articia.c:191 | OBJECT(dev) | "pci-bridge" | articia_realize(): on-chip PCI bridge is composite child of the ArticiaS host bridge
  hw/pci-host/astro.c:524 | OBJECT(s) | "elroy[*]" | elroy_init() static helper called from astro_realize(); Elroy PCI host is composite child of the Astro chip; thread Object *parent from caller
  hw/pci-host/bonito.c:744 | OBJECT(machine) | "pci-host" | bonito_init() public helper called from board init (fuloong2e); thread Object *parent from caller
  hw/pci-host/bonito.c:750 | OBJECT(pcihost) | "pci" | PCI-facing Bonito function is composite child of the Bonito host-bridge SysBus device
  hw/pci-host/grackle.c:63 | OBJECT(dev) | "pci" | grackle_realize(): PCI-facing grackle function is composite child of the host bridge
  hw/pci-host/gt64120.c:1207 | OBJECT(dev) | "pci" | gt64120_realize(): PCI-facing GT-64120 function is composite child of the host bridge
  hw/pci-host/i440fx.c:285 | OBJECT(dev) | "pci" | i440fx_pcihost_realize(): i440FX PCI function is composite child of the host bridge
  hw/pci-host/mv64361.c:97 | OBJECT(dev) | "pci" | mv64361_pcihost_realize(): PCI-facing MV64361 bridge function is composite child of the host bridge
  hw/pci-host/pnv_phb.c:170 | OBJECT(dev) | "root-port" | pnv_phb_realize(): built-in PHB root port is composite child of the PnvPHB proxy device
  hw/pci-host/pnv_phb4_pec.c:183 | OBJECT(pec) | "phb[*]" | pnv_pec_default_phb_realize() called from pnv_pec_realize(); already parented via object_property_add_child(pec,"phb[*]",...); fold into qdev_new()
  hw/pci-host/ppc4xx_pci.c:335 | OBJECT(dev) | "pci" | ppc4xx_pcihost_realize(): PCI-facing 4xx host bridge function is composite child of the host bridge
  hw/pci-host/ppce500.c:476 | OBJECT(dev) | "pci" | e500_pcihost_realize(): PCI-facing e500 bridge function is composite child of the host bridge
  hw/pci-host/raven.c:284 | OBJECT(d) | "pci" | raven_pcihost_realizefn(DeviceState *d,...): PCI-facing Raven function is composite child of the host bridge
  hw/pci-host/sabre.c:386 | OBJECT(dev) | "pci" | sabre_realize(): PCI-facing Sabre function is composite child of the host bridge
  hw/pci-host/sabre.c:394 | OBJECT(dev) | "bridge-b" | sabre_realize(): on-board Simba PCI bridge B is composite child of the Sabre host bridge
  hw/pci-host/sabre.c:399 | OBJECT(dev) | "bridge-a" | sabre_realize(): on-board Simba PCI bridge A is composite child of the Sabre host bridge
  hw/pci-host/sh_pci.c:145 | OBJECT(dev) | "pci" | sh_pcic_host_realize(): PCI-facing SH host function is composite child of the host bridge
  hw/pci-host/uninorth.c:129 | OBJECT(dev) | "pci" | pci_unin_main_realize(): PCI-facing UniNorth function is composite child of the host bridge
  hw/pci-host/uninorth.c:179 | OBJECT(dev) | "pci" | pci_u3_agp_realize(): PCI-facing U3-AGP function is composite child of the host bridge
  hw/pci-host/uninorth.c:223 | OBJECT(dev) | "pci" | pci_unin_agp_realize(): PCI-facing UniNorth-AGP function is composite child of the host bridge
  hw/pci-host/uninorth.c:256 | OBJECT(dev) | "pci" | pci_unin_internal_realize(): PCI-facing internal-UniNorth function is composite child of the host bridge

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/mips/fuloong2e.c        |  2 +-
 hw/pci-host/articia.c      |  6 ++++--
 hw/pci-host/astro.c        |  8 ++++----
 hw/pci-host/bonito.c       | 10 +++++-----
 hw/pci-host/grackle.c      |  2 +-
 hw/pci-host/gt64120.c      |  3 ++-
 hw/pci-host/i440fx.c       |  2 +-
 hw/pci-host/mv64361.c      |  2 +-
 hw/pci-host/pnv_phb.c      |  5 +++--
 hw/pci-host/pnv_phb4_pec.c |  3 +--
 hw/pci-host/ppc4xx_pci.c   |  2 +-
 hw/pci-host/ppce500.c      |  2 +-
 hw/pci-host/raven.c        |  3 ++-
 hw/pci-host/sabre.c        | 12 +++++++-----
 hw/pci-host/sh_pci.c       |  3 ++-
 hw/pci-host/uninorth.c     | 11 +++++++----
 include/hw/mips/mips.h     |  2 +-
 17 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index e0cbf4df3d..5e5ade46f3 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -283,7 +283,7 @@ static void mips_fuloong2e_init(MachineState *machine)
     cpu_mips_clock_init(cpu);
 
     /* North bridge, Bonito --> IP2 */
-    pci_bus = bonito_init((qemu_irq *)&(env->irq[2]));
+    pci_bus = bonito_init(OBJECT(machine), (qemu_irq *)&(env->irq[2]));
 
     /* South bridge -> IP5 */
     pci_dev = pci_new_multifunction_orphan(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
index 0556c0ccff..5ec0e6a05f 100644
--- a/hw/pci-host/articia.c
+++ b/hw/pci-host/articia.c
@@ -185,10 +185,12 @@ static void articia_realize(DeviceState *dev, Error **errp)
     h->bus = pci_register_root_bus(dev, NULL, articia_pcihost_set_irq,
                                    amigaone_pcihost_bus0_map_irq, dev, &s->mem,
                                    &s->io, PCI_DEVFN(8, 0), 4, TYPE_PCI_BUS);
-    pdev = pci_create_simple_multifunction_orphan(h->bus, PCI_DEVFN(0, 0),
+    pdev = pci_create_simple_multifunction(OBJECT(dev), "host-func", h->bus,
+                                           PCI_DEVFN(0, 0),
                                            TYPE_ARTICIA_PCI_HOST);
     ARTICIA_PCI_HOST(pdev)->as = s;
-    pci_create_simple_orphan(h->bus, PCI_DEVFN(0, 1), TYPE_ARTICIA_PCI_BRIDGE);
+    pci_create_simple(OBJECT(dev), "pci-bridge", h->bus, PCI_DEVFN(0, 1),
+                      TYPE_ARTICIA_PCI_BRIDGE);
 
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->reg);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mem);
diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 1de3960713..61519d1d29 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -517,13 +517,13 @@ static void elroy_register_types(void)
 type_init(elroy_register_types)
 
 
-static ElroyState *elroy_init(int num)
+static ElroyState *elroy_init(Object *parent, int num)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan(TYPE_ELROY_PCI_HOST_BRIDGE);
+    dev = qdev_new(parent, "elroy[*]", TYPE_ELROY_PCI_HOST_BRIDGE);
     dev->id = g_strdup_printf("elroy%d", num);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     return ELROY_PCI_HOST_BRIDGE(dev);
 }
@@ -1015,7 +1015,7 @@ static void astro_realize(DeviceState *obj, Error **errp)
         addr_offset = elroy_hpa_offsets[i];
         rope = elroy_rope_nr[i];
 
-        elroy = elroy_init(i);
+        elroy = elroy_init(OBJECT(s), i);
         s->elroy[i] = elroy;
         elroy->hpa = ASTRO_HPA + addr_offset;
         elroy->pci_bus_num = i;
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 40a62d62b6..83b328840a 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -733,7 +733,7 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
     pci_set_byte(dev->config + PCI_MAX_LAT, 0x00);
 }
 
-PCIBus *bonito_init(qemu_irq *pic)
+PCIBus *bonito_init(Object *parent, qemu_irq *pic)
 {
     DeviceState *dev;
     BonitoState *pcihost;
@@ -741,17 +741,17 @@ PCIBus *bonito_init(qemu_irq *pic)
     PCIBonitoState *s;
     PCIDevice *d;
 
-    dev = qdev_new_orphan(TYPE_BONITO_PCI_HOST_BRIDGE);
+    dev = qdev_new(parent, "pci-host", TYPE_BONITO_PCI_HOST_BRIDGE);
     phb = PCI_HOST_BRIDGE(dev);
     pcihost = BONITO_PCI_HOST_BRIDGE(dev);
     pcihost->pic = pic;
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    d = pci_new_orphan(PCI_DEVFN(0, 0), TYPE_PCI_BONITO);
+    d = pci_new(OBJECT(pcihost), "pci-host", PCI_DEVFN(0, 0), TYPE_PCI_BONITO);
     s = PCI_BONITO(d);
     s->pcihost = pcihost;
     pcihost->pci_dev = s;
-    pci_realize_and_unref(d, phb->bus, &error_fatal);
+    qdev_realize(DEVICE(d), BUS(phb->bus), &error_fatal);
 
     return phb->bus;
 }
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index c76cb61dc9..c4c8dc15e4 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -60,7 +60,7 @@ static void grackle_realize(DeviceState *dev, Error **errp)
                                      &s->pci_io,
                                      0, 4, TYPE_PCI_BUS);
 
-    pci_create_simple_orphan(phb->bus, 0, "grackle");
+    pci_create_simple(OBJECT(dev), "pci-host", phb->bus, 0, "grackle");
 }
 
 static void grackle_init(Object *obj)
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index c1a94a3daa..780c86cd9a 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1204,7 +1204,8 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
                                 get_system_io(),
                                 PCI_DEVFN(18, 0), TYPE_PCI_BUS);
 
-    pci_create_simple_orphan(phb->bus, PCI_DEVFN(0, 0), "gt64120_pci");
+    pci_create_simple(OBJECT(dev), "pci-host", phb->bus, PCI_DEVFN(0, 0),
+                      "gt64120_pci");
     memory_region_init_io(&phb->conf_mem, OBJECT(phb),
                           &pci_host_conf_le_ops,
                           s, "pci-conf-idx", 4);
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index e91ddd5d07..c49b5d5c15 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -282,7 +282,7 @@ static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
                          s->io_memory, 0, TYPE_PCI_BUS);
     phb->bus = b;
 
-    d = pci_create_simple_orphan(b, 0, s->pci_type);
+    d = pci_create_simple(OBJECT(dev), "pci-host", b, 0, s->pci_type);
     f = I440FX_PCI_DEVICE(d);
 
     range_set_bounds(&s->pci_hole, s->below_4g_mem_size,
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index f75951c873..3ef51fef1b 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -94,7 +94,7 @@ static void mv64361_pcihost_realize(DeviceState *dev, Error **errp)
                                    pci_swizzle_map_irq_fn, dev,
                                    &s->mem, &s->io, 0, 4, TYPE_PCI_BUS);
     g_free(name);
-    pci_create_simple_orphan(h->bus, 0, TYPE_MV64361_PCI_BRIDGE);
+    pci_create_simple(OBJECT(dev), "pci-host", h->bus, 0, TYPE_MV64361_PCI_BRIDGE);
     qdev_init_gpio_out(dev, s->irq, ARRAY_SIZE(s->irq));
 }
 
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index fc0b226bef..160aa86c48 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -167,9 +167,10 @@ static void pnv_phb_realize(DeviceState *dev, Error **errp)
     }
 
     if (defaults_enabled()) {
-        PCIDevice *root = pci_new_orphan(PCI_DEVFN(0, 0), TYPE_PNV_PHB_ROOT_PORT);
+        PCIDevice *root = pci_new(OBJECT(dev), "root-port",
+                                  PCI_DEVFN(0, 0), TYPE_PNV_PHB_ROOT_PORT);
 
-        pci_realize_and_unref(root, pci->bus, errp);
+        qdev_realize(DEVICE(root), BUS(pci->bus), errp);
     }
 }
 
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index 54dac5e989..b1af93d49b 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -180,10 +180,9 @@ static PnvPHB *pnv_pec_default_phb_realize(PnvPhb4PecState *pec,
                                            int stack_no,
                                            Error **errp)
 {
-    PnvPHB *phb = PNV_PHB(qdev_new_orphan(TYPE_PNV_PHB));
+    PnvPHB *phb = PNV_PHB(qdev_new(OBJECT(pec), "phb[*]", TYPE_PNV_PHB));
     int phb_id = pnv_phb4_pec_get_phb_id(pec, stack_no);
 
-    object_property_add_child(OBJECT(pec), "phb[*]", OBJECT(phb));
     object_property_set_link(OBJECT(phb), "pec", OBJECT(pec),
                              &error_abort);
     object_property_set_int(OBJECT(phb), "chip-id", pec->chip_id,
diff --git a/hw/pci-host/ppc4xx_pci.c b/hw/pci-host/ppc4xx_pci.c
index cd7b16aa87..223b37354b 100644
--- a/hw/pci-host/ppc4xx_pci.c
+++ b/hw/pci-host/ppc4xx_pci.c
@@ -332,7 +332,7 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
                               TYPE_PCI_BUS);
     h->bus = b;
 
-    pci_create_simple_orphan(b, 0, TYPE_PPC4xx_HOST_BRIDGE);
+    pci_create_simple(OBJECT(dev), "pci-host", b, 0, TYPE_PPC4xx_HOST_BRIDGE);
 
     /* XXX split into 2 memory regions, one for config space, one for regs */
     memory_region_init(&s->container, OBJECT(s), "pci-container", PCI_ALL_SIZE);
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 838a01608c..01576c1a61 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -473,7 +473,7 @@ static void e500_pcihost_realize(DeviceState *dev, Error **errp)
     address_space_init(&s->bm_as, &s->bm, "pci-bm");
     pci_setup_iommu(b, &ppce500_iommu_ops, s);
 
-    pci_create_simple_orphan(b, 0, TYPE_PPC_E500_PCI_BRIDGE);
+    pci_create_simple(OBJECT(dev), "pci-host", b, 0, TYPE_PPC_E500_PCI_BRIDGE);
 
     memory_region_init(&s->container, OBJECT(h), "pci-container", PCIE500_ALL_SIZE);
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_be_ops, h,
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index abcf9b28e1..b6ab686ff5 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -281,7 +281,8 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
                           "pci-intack", 1);
     memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
 
-    pci_create_simple_orphan(h->bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
+    pci_create_simple(OBJECT(d), "pci-host", h->bus, PCI_DEVFN(0, 0),
+                      TYPE_RAVEN_PCI_DEVICE);
 
     address_space_init(&s->bm_as, &s->bm, "raven-bm");
     pci_setup_iommu(h->bus, &raven_iommu_ops, s);
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index d8c815d404..3c52fa2727 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -383,7 +383,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
                                      &s->pci_ioport,
                                      0, 0x40, TYPE_PCI_BUS);
 
-    pci_create_simple_orphan(phb->bus, 0, TYPE_SABRE_PCI_DEVICE);
+    pci_create_simple(OBJECT(dev), "pci-host", phb->bus, 0, TYPE_SABRE_PCI_DEVICE);
 
     /* IOMMU */
     memory_region_add_subregion_overlap(&s->sabre_config, 0x200,
@@ -391,15 +391,17 @@ static void sabre_realize(DeviceState *dev, Error **errp)
     pci_setup_iommu(phb->bus, &sabre_iommu_ops, s->iommu);
 
     /* APB secondary busses */
-    pci_dev = pci_new_multifunction_orphan(PCI_DEVFN(1, 0), TYPE_SIMBA_PCI_BRIDGE);
+    pci_dev = pci_new_multifunction(OBJECT(dev), "bridge-b",
+                                    PCI_DEVFN(1, 0), TYPE_SIMBA_PCI_BRIDGE);
     s->bridgeB = PCI_BRIDGE(pci_dev);
     pci_bridge_map_irq(s->bridgeB, "pciB", pci_simbaB_map_irq);
-    pci_realize_and_unref(pci_dev, phb->bus, &error_fatal);
+    qdev_realize(DEVICE(pci_dev), BUS(phb->bus), &error_fatal);
 
-    pci_dev = pci_new_multifunction_orphan(PCI_DEVFN(1, 1), TYPE_SIMBA_PCI_BRIDGE);
+    pci_dev = pci_new_multifunction(OBJECT(dev), "bridge-a",
+                                    PCI_DEVFN(1, 1), TYPE_SIMBA_PCI_BRIDGE);
     s->bridgeA = PCI_BRIDGE(pci_dev);
     pci_bridge_map_irq(s->bridgeA, "pciA", pci_simbaA_map_irq);
-    pci_realize_and_unref(pci_dev, phb->bus, &error_fatal);
+    qdev_realize(DEVICE(pci_dev), BUS(phb->bus), &error_fatal);
 }
 
 static void sabre_init(Object *obj)
diff --git a/hw/pci-host/sh_pci.c b/hw/pci-host/sh_pci.c
index 749b9d76a1..79ebe36fe1 100644
--- a/hw/pci-host/sh_pci.c
+++ b/hw/pci-host/sh_pci.c
@@ -142,7 +142,8 @@ static void sh_pcic_host_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->memconfig_a7);
     memory_region_add_subregion(get_system_memory(), 0xfe240000, &s->isa);
 
-    s->dev = pci_create_simple_orphan(phb->bus, PCI_DEVFN(0, 0), "sh_pci_host");
+    s->dev = pci_create_simple(OBJECT(dev), "pci-host", phb->bus, PCI_DEVFN(0, 0),
+                               "sh_pci_host");
 }
 
 static void sh_pcic_pci_realize(PCIDevice *d, Error **errp)
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 4590687bd3..ac22f2dd8c 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -126,7 +126,8 @@ static void pci_unin_main_realize(DeviceState *dev, Error **errp)
                                    &s->pci_io,
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
-    pci_create_simple_orphan(h->bus, PCI_DEVFN(11, 0), "uni-north-pci");
+    pci_create_simple(OBJECT(dev), "pci-host", h->bus, PCI_DEVFN(11, 0),
+                      "uni-north-pci");
 
     /*
      * DEC 21154 bridge was unused for many years, this comment is
@@ -176,7 +177,7 @@ static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
                                    &s->pci_io,
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
-    pci_create_simple_orphan(h->bus, PCI_DEVFN(11, 0), "u3-agp");
+    pci_create_simple(OBJECT(dev), "pci-host", h->bus, PCI_DEVFN(11, 0), "u3-agp");
 }
 
 static void pci_u3_agp_init(Object *obj)
@@ -220,7 +221,8 @@ static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
                                    &s->pci_io,
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
-    pci_create_simple_orphan(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
+    pci_create_simple(OBJECT(dev), "pci-host", h->bus, PCI_DEVFN(11, 0),
+                      "uni-north-agp");
 }
 
 static void pci_unin_agp_init(Object *obj)
@@ -253,7 +255,8 @@ static void pci_unin_internal_realize(DeviceState *dev, Error **errp)
                                    &s->pci_io,
                                    PCI_DEVFN(14, 0), 4, TYPE_PCI_BUS);
 
-    pci_create_simple_orphan(h->bus, PCI_DEVFN(14, 0), "uni-north-internal-pci");
+    pci_create_simple(OBJECT(dev), "pci-host", h->bus, PCI_DEVFN(14, 0),
+                      "uni-north-internal-pci");
 }
 
 static void pci_unin_internal_init(Object *obj)
diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
index 1f3672ba5f..cd0ccb4e5d 100644
--- a/include/hw/mips/mips.h
+++ b/include/hw/mips/mips.h
@@ -10,7 +10,7 @@
 #include "system/memory.h"
 
 /* bonito.c */
-PCIBus *bonito_init(qemu_irq *pic);
+PCIBus *bonito_init(Object *parent, qemu_irq *pic);
 
 /* rc4030.c */
 typedef struct rc4030DMAState *rc4030_dma;
-- 
2.47.1


