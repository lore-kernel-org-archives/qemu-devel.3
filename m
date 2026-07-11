Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8630C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigP0-0007SB-Fj; Sat, 11 Jul 2026 18:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigOn-0007J3-TY; Sat, 11 Jul 2026 18:42:19 -0400
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.1.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigOl-0006Go-F2; Sat, 11 Jul 2026 18:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809735; x=1815345735;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+t5EqzySplPJ9N7zbCElMsPochR+1J86mJG1fCoxn+8=;
 b=HUpn6saBeSzBur3JXupl438RVecVWnwEcA/gHJ3OmPTLzBU32/E7bWfu
 voKHeTOl9lX9PPZ8+iSOwLrw05Q6veyGybPSFnrBK9aGZDblwQ9Rt+wEB
 W/G4ZmUeq/7qjfdlhvMRlPj9/QOAwMJxb4ZxQbWtsVZ9mGQsUZa9QkRlH
 H8QL4pfTLInEITKvZRxVdPHhZC6bn80P0lxeqkzQdyH+Se0HZDRUdsvwc
 2V5i1FFyc97KsnH68Wr3TW7YtmxglH8/nQbMc0C1hA5+VKY4KNQSHYLyq
 kuD6QzyAWaqvTDEYy6cfbnypiUAdMvN4jstwMShWnr+I/UsQN60sotg5i Q==;
X-CSE-ConnectionGUID: vyCgnje4QJu4A00k6ahqxA==
X-CSE-MsgGUID: pDv8qLWYRUqLmJClqabsgg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23505489"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:42:11 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:13943]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.175:2525]
 with esmtp (Farcaster)
 id 05fab316-0cc3-4779-b2dc-88fa9d38af89; Sat, 11 Jul 2026 22:42:11 +0000 (UTC)
X-Farcaster-Flow-ID: 05fab316-0cc3-4779-b2dc-88fa9d38af89
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:42:11 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:42:02 +0000
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
Subject: [RFC PATCH 019/134] hw/s390x: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:12 +0000
Message-ID: <20260711223707.42139-20-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.1.125;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
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
Assisted-by: Kiro
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


