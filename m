Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E55C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigWg-0005nJ-6I; Sat, 11 Jul 2026 18:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigWR-0005R4-Si; Sat, 11 Jul 2026 18:50:13 -0400
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.42.203.116])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigWP-0007vt-9N; Sat, 11 Jul 2026 18:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810209; x=1815346209;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e/+oVKVnFPvuy98Os0TSLL/uzjUiQRAzF10kGyfO4jY=;
 b=UzPGwkTmx1N9f5vYgwIYRGU6sAi1+ECPbRmxayhaaH78wmWlUJpyjQZf
 n27WKQOAxI7vXs2Z2nDsiK9cCJ8uIxCAk98sDYP8zYCuTmgIPk+jL9wkg
 lJBu+Ye+883fZaiUdQVloWsyBNXjcmRkXaTAWX2fJFav/ipW3fRdaHzK5
 KwkmnaFU0v+wL/DgE192BJYeofMv4Egb6x1jqrOjacl5epAlKbM0/dt1K
 B9J1+DlQx8mjiPnh7By6eycxXm+0KTbdC6JOrokVBjOJDQxaQlCyWbP8U
 piVI9SFRx3u8xR6HFkAeSfEgetVuQWi+F9x8mSjAIXTH8vjeQb+C8XXXv w==;
X-CSE-ConnectionGUID: Y2FKpcY1RwaJr775IL9OhQ==
X-CSE-MsgGUID: SwDp2GMRQai/bFveInTDZA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23517860"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:50:04 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:21842]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.123:2525]
 with esmtp (Farcaster)
 id c69c34a3-8f3b-4b8c-b151-e1c2aa6a38c3; Sat, 11 Jul 2026 22:50:04 +0000 (UTC)
X-Farcaster-Flow-ID: c69c34a3-8f3b-4b8c-b151-e1c2aa6a38c3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:50:04 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:49:55 +0000
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
Subject: [RFC PATCH 049/134] hw/isa: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:42 +0000
Message-ID: <20260711223707.42139-50-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.42.203.116;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/isa to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/isa/i82378.c:106 | isa_new | OBJECT(s) | "pcspk" | i82378_realize() creates ISA children of the i82378 PCI-ISA bridge
hw/isa/i82378.c:113 | isa_create_simple | OBJECT(s) | "dma" | i82378_realize() creates ISA children of the i82378 PCI-ISA bridge
hw/isa/isa-bus.c:62 | qdev_new_orphan | ORPHAN-JUSTIFIED | - | fallback isabus-bridge when caller passes dev==NULL; parenting requires isa_bus_new() signature change across many callers, deferred
hw/isa/isa-bus.c:174 | isa_new_orphan | ORPHAN-JUSTIFIED | - | API definition (transitional _orphan wrapper)
hw/isa/isa-bus.c:176 | qdev_new_orphan | ORPHAN-JUSTIFIED | - | API definition body of isa_new_orphan()
hw/isa/isa-bus.c:179 | isa_try_new_orphan | ORPHAN-JUSTIFIED | - | API definition (transitional _orphan wrapper)
hw/isa/isa-bus.c:181 | qdev_try_new_orphan | ORPHAN-JUSTIFIED | - | API definition body of isa_try_new_orphan()
hw/isa/isa-bus.c:184 | isa_create_simple_orphan | ORPHAN-JUSTIFIED | - | API definition (transitional _orphan wrapper)
hw/isa/isa-bus.c:188 | isa_new_orphan | ORPHAN-JUSTIFIED | - | API definition body of isa_create_simple_orphan()
hw/isa/isa-bus.c:208 | isa_create_simple_orphan | ORPHAN-JUSTIFIED | - | isa_vga_init() is a public helper called from board code (hw/i386/pc.c); needs Object *parent threaded through include/hw/isa/isa.h; deferred to caller-side patch
hw/isa/isa-bus.c:213 | isa_create_simple_orphan | ORPHAN-JUSTIFIED | - | isa_vga_init() is a public helper called from board code; deferred to caller-side patch
hw/isa/isa-superio.c:57 | isa_new | OBJECT(dev) | name | isa_superio_realize(); collapse existing object_property_add_child(OBJECT(dev), name, ...) keeping dynamic per-index name
hw/isa/isa-superio.c:96 | isa_new | OBJECT(dev) | name | isa_superio_realize(); collapse existing object_property_add_child(OBJECT(dev), name, ...) keeping dynamic per-index name
hw/isa/isa-superio.c:123 | isa_new | OBJECT(sio) | "isa-fdc" | isa_superio_realize(); collapse existing object_property_add_child(OBJECT(sio), "isa-fdc", ...)
hw/isa/isa-superio.c:147 | isa_new | OBJECT(sio) | TYPE_I8042 | isa_superio_realize(); collapse existing object_property_add_child(OBJECT(sio), TYPE_I8042, ...)
hw/isa/isa-superio.c:154 | isa_new | OBJECT(sio) | "isa-ide" | isa_superio_realize(); collapse existing object_property_add_child(OBJECT(sio), "isa-ide", ...)

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/isa/i82378.c      |  6 +++---
 hw/isa/isa-superio.c | 25 ++++++++++---------------
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index da09d869f5..1c0a6ad779 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -103,14 +103,14 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     pit = i8254_pit_init(isabus, 0x40, 0, NULL);
 
     /* speaker */
-    pcspk = isa_new_orphan(TYPE_PC_SPEAKER);
+    pcspk = isa_new(OBJECT(s), "pcspk", TYPE_PC_SPEAKER);
     object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_fatal);
-    if (!isa_realize_and_unref(pcspk, isabus, errp)) {
+    if (!qdev_realize(DEVICE(pcspk), BUS(isabus), errp)) {
         return;
     }
 
     /* 2 82C37 (dma) */
-    isa_create_simple_orphan(isabus, "i82374");
+    isa_create_simple(OBJECT(s), "dma", isabus, "i82374");
 }
 
 static void i82378_init(Object *obj)
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 2d65255f34..d0c3c1dbd3 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -54,7 +54,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             } else {
                 name = g_strdup_printf("parallel%d", i);
             }
-            isa = isa_new_orphan(TYPE_ISA_PARALLEL);
+            isa = isa_new(OBJECT(dev), name, TYPE_ISA_PARALLEL);
             d = DEVICE(isa);
             qdev_prop_set_uint32(d, "index", i);
             if (k->parallel.get_iobase) {
@@ -65,8 +65,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
                 qdev_prop_set_uint32(d, "irq", k->parallel.get_irq(sio, i));
             }
             qdev_prop_set_chr(d, "chardev", chr);
-            object_property_add_child(OBJECT(dev), name, OBJECT(isa));
-            isa_realize_and_unref(isa, bus, &error_fatal);
+            qdev_realize(DEVICE(isa), BUS(bus), &error_fatal);
             sio->parallel[i] = isa;
             trace_superio_create_parallel(i,
                                           k->parallel.get_iobase ?
@@ -93,7 +92,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             } else {
                 name = g_strdup_printf("serial%d", i);
             }
-            isa = isa_new_orphan(TYPE_ISA_SERIAL);
+            isa = isa_new(OBJECT(dev), name, TYPE_ISA_SERIAL);
             d = DEVICE(isa);
             qdev_prop_set_uint32(d, "index", i);
             if (k->serial.get_iobase) {
@@ -104,8 +103,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
                 qdev_prop_set_uint32(d, "irq", k->serial.get_irq(sio, i));
             }
             qdev_prop_set_chr(d, "chardev", chr);
-            object_property_add_child(OBJECT(dev), name, OBJECT(isa));
-            isa_realize_and_unref(isa, bus, &error_fatal);
+            qdev_realize(DEVICE(isa), BUS(bus), &error_fatal);
             sio->serial[i] = isa;
             trace_superio_create_serial(i,
                                         k->serial.get_iobase ?
@@ -120,7 +118,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
     assert(k->floppy.count <= 1);
     if (k->floppy.count &&
         (!k->floppy.is_enabled || k->floppy.is_enabled(sio, 0))) {
-        isa = isa_new_orphan(TYPE_ISA_FDC);
+        isa = isa_new(OBJECT(sio), "isa-fdc", TYPE_ISA_FDC);
         d = DEVICE(isa);
         if (k->floppy.get_iobase) {
             qdev_prop_set_uint32(d, "iobase", k->floppy.get_iobase(sio, 0));
@@ -132,8 +130,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
         for (i = 0; i < MAX_FD; i++) {
             fd[i] = drive_get(IF_FLOPPY, 0, i);
         }
-        object_property_add_child(OBJECT(sio), "isa-fdc", OBJECT(isa));
-        isa_realize_and_unref(isa, bus, &error_fatal);
+        qdev_realize(DEVICE(isa), BUS(bus), &error_fatal);
         isa_fdc_init_drives(isa, fd);
         sio->floppy = isa;
         trace_superio_create_floppy(0,
@@ -144,14 +141,13 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
     }
 
     /* Keyboard, mouse */
-    isa = isa_new_orphan(TYPE_I8042);
-    object_property_add_child(OBJECT(sio), TYPE_I8042, OBJECT(isa));
-    isa_realize_and_unref(isa, bus, &error_fatal);
+    isa = isa_new(OBJECT(sio), TYPE_I8042, TYPE_I8042);
+    qdev_realize(DEVICE(isa), BUS(bus), &error_fatal);
     sio->kbc = isa;
 
     /* IDE */
     if (k->ide.count && (!k->ide.is_enabled || k->ide.is_enabled(sio, 0))) {
-        isa = isa_new_orphan("isa-ide");
+        isa = isa_new(OBJECT(sio), "isa-ide", "isa-ide");
         d = DEVICE(isa);
         if (k->ide.get_iobase) {
             qdev_prop_set_uint32(d, "iobase", k->ide.get_iobase(sio, 0));
@@ -162,8 +158,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
         if (k->ide.get_irq) {
             qdev_prop_set_uint32(d, "irq", k->ide.get_irq(sio, 0));
         }
-        object_property_add_child(OBJECT(sio), "isa-ide", OBJECT(isa));
-        isa_realize_and_unref(isa, bus, &error_fatal);
+        qdev_realize(DEVICE(isa), BUS(bus), &error_fatal);
         sio->ide = isa;
         trace_superio_create_ide(0,
                                  k->ide.get_iobase ?
-- 
2.47.1


