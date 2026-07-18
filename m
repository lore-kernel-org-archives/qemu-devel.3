Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F69DC4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD4o-0005of-VP; Sat, 18 Jul 2026 18:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD4j-0005k6-Ef; Sat, 18 Jul 2026 18:00:01 -0400
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.12.53.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD4h-0004sg-Dh; Sat, 18 Jul 2026 18:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411999; x=1815947999;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lPfFZQmNAiTWiFduxB5+BIk3GXRmLG9EPVVHGi+6pOM=;
 b=OHDyxTY5Gd5ZEoJ6c/PU1vt9g6zYgY2nTcklXSsXLcBcpIpfsysVw0Z7
 YWLVe+Q5OVR3j1JIcMoFiELmJfanyaRDDTls6ci67J70xspmInM/bzmMS
 /TgyaWVza8wNxi8HD9AiM2mmSbkBeHtyJrdTp+iOqF/4kQ0vQFi0Z4kcY
 VGNAWmdqUbmPS63wJ2JTAW29kE2/pao0UovEaiWSsYUGV5NILrfGc8pR5
 vg2JixzOgbLqIAoGHy1wED/6TTPVdlAb52vzwS7vO619uRBgC2p1iCjgx
 Xz/vMzcGi1kGbeT0wuS+FpUie8YKmiq1p7e89YJ94nZ8kCxKilC+V8eF0 A==;
X-CSE-ConnectionGUID: 3ZldhHdlSfixbSxdETMY8A==
X-CSE-MsgGUID: PZ3u0opQQ+6PWdYkjPM6Rw==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23795474"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:59:55 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:17923]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.115:2525]
 with esmtp (Farcaster)
 id 2ce57dad-369d-44cb-9f3c-ee27edc9cb9d; Sat, 18 Jul 2026 21:59:55 +0000 (UTC)
X-Farcaster-Flow-ID: 2ce57dad-369d-44cb-9f3c-ee27edc9cb9d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:59:55 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:59:45 +0000
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
Subject: [RFC PATCH v2 082/137] hw/isa: Give the isabus-bridge a QOM parent
Date: Sat, 18 Jul 2026 21:35:57 +0000
Message-ID: <20260718213652.37673-83-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.12.53.23;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
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

isa_bus_new(NULL, ...) implicitly created a sysbus "isabus-bridge"
and put the ISA bus on it.  That bridge ended up under
/machine/unattached, which this series is deleting.

Split out an explicit isa_bus_new_bridge(parent, ...) helper for
the five boards that don't already have a south-bridge device to
own the ISA bus, and make plain isa_bus_new() require a non-NULL
device.  Callers own the bridge in the composition tree:

  hw/i386/microvm.c   OBJECT(mms)
  hw/i386/isapc.c     OBJECT(machine)
  hw/mips/jazz.c      OBJECT(machine)
  hw/hppa/machine.c   parent (already threaded)
  hw/ppc/pnv_lpc.c    OBJECT(lpc)   -- the LPC controller

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/hppa/machine.c    |  2 +-
 hw/i386/isapc.c      |  2 +-
 hw/i386/microvm.c    |  2 +-
 hw/isa/isa-bus.c     | 21 +++++++++++----------
 hw/mips/jazz.c       |  2 +-
 hw/ppc/pnv_lpc.c     |  4 ++--
 include/hw/isa/isa.h |  2 ++
 7 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 002f4299cc..d52f27c51c 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -108,7 +108,7 @@ static ISABus *hppa_isa_bus(Object *parent, hwaddr addr)
                           NULL, "isa-io", 0x800);
     memory_region_add_subregion(get_system_memory(), addr, isa_region);
 
-    isa_bus = isa_bus_new(NULL, get_system_memory(), isa_region,
+    isa_bus = isa_bus_new_bridge(parent, get_system_memory(), isa_region,
                           &error_abort);
     isa_irqs = i8259_init(parent, isa_bus, NULL);
     isa_bus_register_input_irqs(isa_bus, isa_irqs);
diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 842ae94acb..e8d5767b80 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -108,7 +108,7 @@ static void pc_init_isa(MachineState *machine)
 
     gsi_state = pc_gsi_create(&x86ms->gsi, false);
 
-    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+    isa_bus = isa_bus_new_bridge(OBJECT(machine), system_memory, system_io,
                           &error_abort);
     isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 8c61106516..aa0e1ef155 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -171,7 +171,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     x86ms->gsi = qemu_allocate_irqs(gsi_handler, gsi_state,
                                     IOAPIC_NUM_PINS * ioapics);
 
-    isa_bus = isa_bus_new(NULL, get_system_memory(), get_system_io(),
+    isa_bus = isa_bus_new_bridge(OBJECT(mms), get_system_memory(), get_system_io(),
                           &error_abort);
     isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index fb20c43869..7a6a595ce7 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -52,28 +52,29 @@ static const TypeInfo isa_bus_info = {
 ISABus *isa_bus_new(DeviceState *dev, MemoryRegion* address_space,
                     MemoryRegion *address_space_io, Error **errp)
 {
-    DeviceState *bridge = NULL;
-
     if (isabus) {
         error_setg(errp, "Can't create a second ISA bus");
         return NULL;
     }
-    if (!dev) {
-        bridge = qdev_new_orphan("isabus-bridge");
-        dev = bridge;
-    }
+    g_assert(dev);
 
     isabus = ISA_BUS(qbus_new(TYPE_ISA_BUS, dev, NULL));
     isabus->address_space = address_space;
     isabus->address_space_io = address_space_io;
 
-    if (bridge) {
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(bridge), &error_fatal);
-    }
-
     return isabus;
 }
 
+ISABus *isa_bus_new_bridge(Object *parent, MemoryRegion *address_space,
+                           MemoryRegion *address_space_io, Error **errp)
+{
+    DeviceState *bridge = qdev_new(parent, "isabus-bridge", "isabus-bridge");
+    ISABus *bus = isa_bus_new(bridge, address_space, address_space_io, errp);
+
+    sysbus_realize(SYS_BUS_DEVICE(bridge), &error_fatal);
+    return bus;
+}
+
 void isa_bus_register_input_irqs(ISABus *bus, qemu_irq *irqs_in)
 {
     bus->irqs_in = irqs_in;
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 23d717d96a..8c52608913 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -283,7 +283,7 @@ static void mips_jazz_init(MachineState *machine,
     memory_region_init(isa_mem, NULL, "isa-mem", 0x01000000);
     memory_region_add_subregion(address_space, 0x90000000, isa_io);
     memory_region_add_subregion(address_space, 0x91000000, isa_mem);
-    isa_bus = isa_bus_new(NULL, isa_mem, isa_io, &error_abort);
+    isa_bus = isa_bus_new_bridge(OBJECT(machine), isa_mem, isa_io, &error_abort);
 
     /* ISA devices */
     i8259 = i8259_init(OBJECT(machine), isa_bus, env->irq[4]);
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d1357dd359..6ae228088f 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -972,11 +972,11 @@ ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error **errp)
     qemu_irq *irqs;
     qemu_irq_handler handler;
 
-    /* let isa_bus_new() create its own bridge on SysBus otherwise
+    /* let isa_bus_new_bridge() create the bridge as a child of the LPC;
      * devices specified on the command line won't find the bus and
      * will fail to create.
      */
-    isa_bus = isa_bus_new(NULL, &lpc->isa_mem, &lpc->isa_io, &local_err);
+    isa_bus = isa_bus_new_bridge(OBJECT(lpc), &lpc->isa_mem, &lpc->isa_io, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return NULL;
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 9e35d88b1e..79bfe16361 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -69,6 +69,8 @@ struct ISADevice {
 
 ISABus *isa_bus_new(DeviceState *dev, MemoryRegion *address_space,
                     MemoryRegion *address_space_io, Error **errp);
+ISABus *isa_bus_new_bridge(Object *parent, MemoryRegion *address_space,
+                           MemoryRegion *address_space_io, Error **errp);
 void isa_bus_register_input_irqs(ISABus *bus, qemu_irq *irqs_in);
 void isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16);
 IsaDma *isa_bus_get_dma(ISABus *bus, int nchan);
-- 
2.47.1


