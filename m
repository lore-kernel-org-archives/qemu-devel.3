Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F0EC4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCnw-0000CN-53; Sat, 18 Jul 2026 17:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCne-0008Pp-HA; Sat, 18 Jul 2026 17:42:26 -0400
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.162.73.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCnc-0002et-7K; Sat, 18 Jul 2026 17:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784410940; x=1815946940;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=em6rgfP+iQqy87v7/SDRTbIww6oaxtM2e2YTN4pPG28=;
 b=LCjeK+ZSwhYTX6IunkgfpOQ4W6msosJextMWBeIO9lToqb+AbFrFp/Z0
 Z20/jwEQO7sTVXyMNxjQd3n+c8ZgbVtYDAYGyn0lQepuwTuTaP3b946By
 U9pj9Tx+QGxH96zooNryaZ0+UOmYFyGY7ZiPYKrVTsXmtx1/Y5h8YDvz9
 5ysI/HhNzZvB8wCcvI4Nxch2Uoqf4Dpr1pyPuTwRXrs7x1t/Jgvap9gcg
 XDfIpBnR3nQCHN7pNt6Icsu5okcDxZcJoB+vpFlcM1q/ULh5ciEyV28F4
 WA3aZomtjWmyNd6OFcU0pAre4WE0KLjqwY/rPCVXo0zKicgSsQ7r7h/yk Q==;
X-CSE-ConnectionGUID: XxjJ5GWbQGCDjC9yAxYWyQ==
X-CSE-MsgGUID: TRur33rHR2SeQZkDUDDh+A==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23715600"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:42:16 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:14236]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.115:2525]
 with esmtp (Farcaster)
 id fc02224a-a538-4c89-902e-222044210a8b; Sat, 18 Jul 2026 21:42:15 +0000 (UTC)
X-Farcaster-Flow-ID: fc02224a-a538-4c89-902e-222044210a8b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:42:15 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:42:06 +0000
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
Subject: [RFC PATCH v2 019/137] hw/s390x: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:34:54 +0000
Message-ID: <20260718213652.37673-20-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
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

Convert the *_orphan() device-creation calls in hw/s390x to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

  file:line              | parent              | name        | rationale
  ap-bridge.c:52         | qdev_get_machine()  | TYPE_AP_BRIDGE | already parented via object_property_add_child(); collapse into qdev_new() and keep the same name for QOM-path stability
  css-bridge.c:95        | qdev_get_machine()  | TYPE_VIRTUAL_CSS_BRIDGE | already parented via object_property_add_child(); collapse into qdev_new()
  s390-pci-bus.c:970     | OBJECT(s)           | "zpci[*]"   | auto-created zPCI companion for a hot-plugged PCI device; the S390pciState host bridge owns it; auto-index name
  s390-virtio-ccw.c:256  | OBJECT(ef)          | type        | already parented to the SCLP event facility; collapse into qdev_new() and keep the type-derived name
  s390-virtio-ccw.c:268  | OBJECT(ef)          | "sclpcpi"   | already parented; collapse into qdev_new()
  s390-virtio-ccw.c:312  | OBJECT(machine)     | TYPE_S390_PCI_HOST_BRIDGE | already parented to machine; collapse into qdev_new() with the same name

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/s390x/ap-bridge.c       |  6 ++----
 hw/s390x/css-bridge.c      |  7 +++----
 hw/s390x/s390-pci-bus.c    |  4 ++--
 hw/s390x/s390-virtio-ccw.c | 17 +++++++----------
 4 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index ce9b09240a..d7b2c4bddc 100644
--- a/hw/s390x/ap-bridge.c
+++ b/hw/s390x/ap-bridge.c
@@ -49,10 +49,8 @@ void s390_init_ap(void)
     }
 
     /* Create bridge device */
-    dev = qdev_new_orphan(TYPE_AP_BRIDGE);
-    object_property_add_child(qdev_get_machine(), TYPE_AP_BRIDGE,
-                              OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(qdev_get_machine(), TYPE_AP_BRIDGE, TYPE_AP_BRIDGE);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Create bus on bridge device */
     bus = qbus_new(TYPE_AP_BUS, dev, TYPE_AP_BUS);
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index c6be24e5cb..8929d47b1b 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -92,9 +92,8 @@ VirtualCssBus *virtual_css_bus_init(void)
     DeviceState *dev;
 
     /* Create bridge device */
-    dev = qdev_new_orphan(TYPE_VIRTUAL_CSS_BRIDGE);
-    object_property_add_child(qdev_get_machine(), TYPE_VIRTUAL_CSS_BRIDGE,
-                              OBJECT(dev));
+    dev = qdev_new(qdev_get_machine(), TYPE_VIRTUAL_CSS_BRIDGE,
+                   TYPE_VIRTUAL_CSS_BRIDGE);
 
     /* Create bus on bridge device */
     bus = qbus_new(TYPE_VIRTUAL_CSS_BUS, dev, "virtual-css");
@@ -102,7 +101,7 @@ VirtualCssBus *virtual_css_bus_init(void)
     /* Enable hotplugging */
     qbus_set_hotplug_handler(bus, OBJECT(dev));
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     css_register_io_adapters(CSS_IO_ADAPTER_VIRTIO, true, false,
                              0, &error_abort);
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index bc335ca883..4f0a8a787b 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -967,7 +967,7 @@ static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
     Error *local_err = NULL;
     DeviceState *dev;
 
-    dev = qdev_try_new_orphan(TYPE_S390_PCI_DEVICE);
+    dev = qdev_try_new(OBJECT(s), "zpci[*]", TYPE_S390_PCI_DEVICE);
     if (!dev) {
         error_setg(errp, "zPCI device could not be created");
         return NULL;
@@ -979,7 +979,7 @@ static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
                                 "zPCI device could not be created: ");
         return NULL;
     }
-    if (!qdev_realize_and_unref(dev, BUS(s->bus), &local_err)) {
+    if (!qdev_realize(dev, BUS(s->bus), &local_err)) {
         object_unparent(OBJECT(dev));
         error_propagate_prepend(errp, local_err,
                                 "zPCI device could not be created: ");
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f9eb6cb411..1848cde0c4 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -253,10 +253,9 @@ static void s390_create_sclpconsole(SCLPDevice *sclp,
     BusState *ev_fac_bus = sclp_get_event_facility_bus(ef);
     DeviceState *dev;
 
-    dev = qdev_new_orphan(type);
-    object_property_add_child(OBJECT(ef), type, OBJECT(dev));
+    dev = qdev_new(OBJECT(ef), type, type);
     qdev_prop_set_chr(dev, "chardev", chardev);
-    qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
+    qdev_realize(dev, ev_fac_bus, &error_fatal);
 }
 
 static void s390_create_sclpcpi(SCLPDevice *sclp)
@@ -265,9 +264,8 @@ static void s390_create_sclpcpi(SCLPDevice *sclp)
     BusState *ev_fac_bus = sclp_get_event_facility_bus(ef);
     DeviceState *dev;
 
-    dev = qdev_new_orphan(TYPE_SCLP_EVENT_CPI);
-    object_property_add_child(OBJECT(ef), "sclpcpi", OBJECT(dev));
-    qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
+    dev = qdev_new(OBJECT(ef), "sclpcpi", TYPE_SCLP_EVENT_CPI);
+    qdev_realize(dev, ev_fac_bus, &error_fatal);
 }
 
 static void ccw_init(MachineState *machine)
@@ -309,10 +307,9 @@ static void ccw_init(MachineState *machine)
                       machine->firmware ?: "s390-ccw.img",
                       true);
 
-    dev = qdev_new_orphan(TYPE_S390_PCI_HOST_BRIDGE);
-    object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
-                              OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(OBJECT(machine), TYPE_S390_PCI_HOST_BRIDGE,
+                   TYPE_S390_PCI_HOST_BRIDGE);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     s390_enable_css_support(s390_cpu_addr2state(0));
 
-- 
2.47.1


