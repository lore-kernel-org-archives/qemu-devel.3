Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2883C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigdS-0002hb-VW; Sat, 11 Jul 2026 18:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigdB-0002aq-Mj; Sat, 11 Jul 2026 18:57:10 -0400
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([50.112.246.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigd9-0001Fr-Hx; Sat, 11 Jul 2026 18:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810627; x=1815346627;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OO6yXSKC58/UPbvW+GAf53gwJmQKZhKW0kpIYk87aRU=;
 b=SGCwKBgs8HuimWn3Qg1hoVEImGNbDKECqY7u3Y5vZtNl6H6v40fgQg70
 Pno8eI65hRlgy4biYTw8Qf+IPAlWqd2KJrx/90NaqSsexSK7zPgjMwSbF
 A8QoJszBs8nsCtrOjk4ROOlssa0IiYsYua607bG/Jd3H1nea/MJr9Hvp8
 kd4h9Fk7v076z9Pl8pmtNR7imRTHdXIDklYkxbPKy+/5l/31IysCngsUO
 49Ag6nSNot955NQDWO0c0JWfizDt7JT7B+Q9Wj2CF9TmfTFJD1LclRjNf
 C6VOKW8xxUOweFWkL9yORD8V5VI5euErmZWGoKVZFyte0Of1luQI12U2O Q==;
X-CSE-ConnectionGUID: i6W972XZT8WspPdW0SfU/Q==
X-CSE-MsgGUID: mNEw2CBARWmFnQyMJs6pbw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23300155"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:57:04 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:22710]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525]
 with esmtp (Farcaster)
 id 8f3d552b-ee0b-406a-9880-0449d8d6c057; Sat, 11 Jul 2026 22:57:04 +0000 (UTC)
X-Farcaster-Flow-ID: 8f3d552b-ee0b-406a-9880-0449d8d6c057
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:57:03 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:56:54 +0000
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
Subject: [RFC PATCH 075/134] hw/timer,
 hw/net: Give i8254 and isa-ne2000 helpers a QOM parent
Date: Sat, 11 Jul 2026 22:36:08 +0000
Message-ID: <20260711223707.42139-76-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=50.112.246.219;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

The i8254_pit_init(), kvm_pit_init() and isa_ne2000_init() inline
helpers still created their ISA device as an orphan.  Thread an
Object *parent through and switch to isa_new()/isa_try_new() with
qdev_realize().

While at it, drop the dead vmport_init() inline: it has had no
callers since vmmouse got a proper board-level creator, and it was
the last user of isa_create_simple_orphan() outside the ISA layer
itself.

Callers pick the composition-tree owner:

  hw/i386/pc.c        pcms (board)
  hw/i386/microvm.c   mms  (board)
  hw/isa/piix.c       d    (south-bridge realize)
  hw/isa/i82378.c     dev  (bridge realize)
  hw/isa/vt82c686.c   d    (super-io realize)
  hw/mips/jazz.c      machine (board)

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/i386/microvm.c           |  4 ++--
 hw/i386/pc.c                |  6 +++---
 hw/isa/i82378.c             |  2 +-
 hw/isa/piix.c               |  2 +-
 hw/isa/vt82c686.c           |  2 +-
 hw/mips/jazz.c              |  2 +-
 include/hw/i386/vmport.h    |  5 -----
 include/hw/net/ne2000-isa.h |  8 ++++----
 include/hw/timer/i8254.h    | 13 +++++++------
 9 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index d701672c1a..8c61106516 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -261,9 +261,9 @@ static void microvm_devices_init(MicrovmMachineState *mms)
 
     if (x86ms->pit == ON_OFF_AUTO_ON || x86ms->pit == ON_OFF_AUTO_AUTO) {
         if (kvm_pit_in_kernel()) {
-            kvm_pit_init(isa_bus, 0x40);
+            kvm_pit_init(OBJECT(mms), isa_bus, 0x40);
         } else {
-            i8254_pit_init(isa_bus, 0x40, 0, NULL);
+            i8254_pit_init(OBJECT(mms), isa_bus, 0x40, 0, NULL);
         }
     }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a00d53b582..e505391985 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -505,7 +505,7 @@ static gboolean pc_init_ne2k_isa(ISABus *bus, NICInfo *nd, Error **errp)
                    "maximum number of ISA NE2000 devices exceeded");
         return false;
     }
-    isa_ne2000_init(bus, ne2000_io[nb_ne2k],
+    isa_ne2000_init(qdev_get_machine(), bus, ne2000_io[nb_ne2k],
                     ne2000_irq[nb_ne2k], nd);
     nb_ne2k++;
     return true;
@@ -1118,9 +1118,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     if (!xen_enabled() &&
         (x86ms->pit == ON_OFF_AUTO_AUTO || x86ms->pit == ON_OFF_AUTO_ON)) {
         if (kvm_pit_in_kernel()) {
-            pit = kvm_pit_init(isa_bus, 0x40);
+            pit = kvm_pit_init(OBJECT(pcms), isa_bus, 0x40);
         } else {
-            pit = i8254_pit_init(isa_bus, 0x40, pit_isa_irq, pit_alt_irq);
+            pit = i8254_pit_init(OBJECT(pcms), isa_bus, 0x40, pit_isa_irq, pit_alt_irq);
         }
         if (hpet) {
             /* connect PIT to output control line of the HPET */
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 1c0a6ad779..995d1eaa53 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -100,7 +100,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     isa_bus_register_input_irqs(isabus, s->isa_irqs_in);
 
     /* 1 82C54 (pit) */
-    pit = i8254_pit_init(isabus, 0x40, 0, NULL);
+    pit = i8254_pit_init(OBJECT(dev), isabus, 0x40, 0, NULL);
 
     /* speaker */
     pcspk = isa_new(OBJECT(s), "pcspk", TYPE_PC_SPEAKER);
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 6b2946d82c..d96bc3a873 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -334,7 +334,7 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
 
     /* PIT */
     if (d->has_pit) {
-        i8254_pit_init(isa_bus, 0x40, 0, NULL);
+        i8254_pit_init(OBJECT(d), isa_bus, 0x40, 0, NULL);
     }
 
     i8257_dma_init(OBJECT(dev), isa_bus, 0);
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index de9006bd95..2337c3115b 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -732,7 +732,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
 
     s->isa_irqs_in = i8259_init(OBJECT(d), isa_bus, &s->i8259_irq);
     isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
-    i8254_pit_init(isa_bus, 0x40, 0, NULL);
+    i8254_pit_init(OBJECT(d), isa_bus, 0x40, 0, NULL);
     i8257_dma_init(OBJECT(d), isa_bus, 0);
 
     /* RTC */
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 208e59fbeb..23d717d96a 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -289,7 +289,7 @@ static void mips_jazz_init(MachineState *machine,
     i8259 = i8259_init(OBJECT(machine), isa_bus, env->irq[4]);
     isa_bus_register_input_irqs(isa_bus, i8259);
     i8257_dma_init(OBJECT(rc4030), isa_bus, 0);
-    pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
+    pit = i8254_pit_init(OBJECT(machine), isa_bus, 0x40, 0, NULL);
     pcspk = isa_new(OBJECT(machine), "pcspk", TYPE_PC_SPEAKER);
     object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_fatal);
     qdev_realize(DEVICE(pcspk), BUS(isa_bus), &error_fatal);
diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
index 22dd3645d2..02e422029d 100644
--- a/include/hw/i386/vmport.h
+++ b/include/hw/i386/vmport.h
@@ -18,11 +18,6 @@ typedef enum {
     VMPORT_ENTRIES
 } VMPortCommand;
 
-static inline void vmport_init(ISABus *bus)
-{
-    isa_create_simple_orphan(bus, TYPE_VMPORT);
-}
-
 void vmport_register(VMPortCommand command, VMPortReadFunc *func, void *opaque);
 
 #endif
diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
index ef8b3334d7..f504a03db7 100644
--- a/include/hw/net/ne2000-isa.h
+++ b/include/hw/net/ne2000-isa.h
@@ -17,19 +17,19 @@
 
 #define TYPE_ISA_NE2000 "ne2k_isa"
 
-static inline ISADevice *isa_ne2000_init(ISABus *bus, int base, int irq,
-                                         NICInfo *nd)
+static inline ISADevice *isa_ne2000_init(Object *parent, ISABus *bus,
+                                          int base, int irq, NICInfo *nd)
 {
     ISADevice *d;
 
-    d = isa_try_new_orphan(TYPE_ISA_NE2000);
+    d = isa_try_new(parent, "ne2k[*]", TYPE_ISA_NE2000);
     if (d) {
         DeviceState *dev = DEVICE(d);
 
         qdev_prop_set_uint32(dev, "iobase", base);
         qdev_prop_set_uint32(dev, "irq",    irq);
         qdev_set_nic_properties(dev, nd);
-        isa_realize_and_unref(d, bus, &error_fatal);
+        qdev_realize(dev, BUS(bus), &error_fatal);
     }
     return d;
 }
diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
index 38f896063e..b7bc98b688 100644
--- a/include/hw/timer/i8254.h
+++ b/include/hw/timer/i8254.h
@@ -45,16 +45,17 @@ OBJECT_DECLARE_TYPE(PITCommonState, PITCommonClass, PIT_COMMON)
 #define TYPE_I8254 "isa-pit"
 #define TYPE_KVM_I8254 "kvm-pit"
 
-static inline ISADevice *i8254_pit_init(ISABus *bus, int base, int isa_irq,
+static inline ISADevice *i8254_pit_init(Object *parent, ISABus *bus,
+                                        int base, int isa_irq,
                                         qemu_irq alt_irq)
 {
     DeviceState *dev;
     ISADevice *d;
 
-    d = isa_new_orphan(TYPE_I8254);
+    d = isa_new(parent, "pit[*]", TYPE_I8254);
     dev = DEVICE(d);
     qdev_prop_set_uint32(dev, "iobase", base);
-    isa_realize_and_unref(d, bus, &error_fatal);
+    qdev_realize(dev, BUS(bus), &error_fatal);
     qdev_connect_gpio_out(dev, 0,
                           isa_irq >= 0 ? isa_bus_get_irq(bus, isa_irq)
                                        : alt_irq);
@@ -62,15 +63,15 @@ static inline ISADevice *i8254_pit_init(ISABus *bus, int base, int isa_irq,
     return d;
 }
 
-static inline ISADevice *kvm_pit_init(ISABus *bus, int base)
+static inline ISADevice *kvm_pit_init(Object *parent, ISABus *bus, int base)
 {
     DeviceState *dev;
     ISADevice *d;
 
-    d = isa_new_orphan(TYPE_KVM_I8254);
+    d = isa_new(parent, "pit[*]", TYPE_KVM_I8254);
     dev = DEVICE(d);
     qdev_prop_set_uint32(dev, "iobase", base);
-    isa_realize_and_unref(d, bus, &error_fatal);
+    qdev_realize(dev, BUS(bus), &error_fatal);
 
     return d;
 }
-- 
2.47.1


