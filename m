Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3B8C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigdh-0002rO-PN; Sat, 11 Jul 2026 18:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigdT-0002kM-ND; Sat, 11 Jul 2026 18:57:28 -0400
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.13.214.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigdR-0001MP-Bc; Sat, 11 Jul 2026 18:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810645; x=1815346645;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jOWQ3MPKNOWbOTZvD1jfyggpxHQg9YeLUu3eSDISNmU=;
 b=LMUGEkfpeGM7UdCSUyMyyMmeZ08rL0jfwj/F8f2UkTHdnGkQZST4EMw3
 sKSVsPuzpByHKJjXTWs3WOgT9JLp3ul81OKCUk3RBMw2JG2zQgeeeh+H6
 m8yrw7kP4nT7LzRkd7Dv0HGaGaK80+Cq/CkCDnBg1jArcufwrriWo2Rhe
 SicIH2JXdjAy61gRruHWpROP6WZsKxQevQuckQnAEIA+1Gy5H17ccm2ap
 OQonhvADI4JHFD34n3KVz9mBIoblXwqC5xwv+JziO/8afwD+BMpLsfRyn
 z0YKHmCzMOZzkPMhID139Zum7tgK93EkNhaGCfoLAe5QTsWCjcSsdrZo1 A==;
X-CSE-ConnectionGUID: qzQbjqiTQWSbTGEt3b6D3Q==
X-CSE-MsgGUID: STEgFdRuR3qcPoDsdwU3VA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23479604"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:57:21 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:12053]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.123:2525]
 with esmtp (Farcaster)
 id 978060d7-e4f5-46cc-a897-f56672c31de4; Sat, 11 Jul 2026 22:57:21 +0000 (UTC)
X-Farcaster-Flow-ID: 978060d7-e4f5-46cc-a897-f56672c31de4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:57:21 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:57:12 +0000
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
Subject: [RFC PATCH 077/134] hw/usb: Give -usbdevice and auto-hub devices a
 QOM parent
Date: Sat, 11 Jul 2026 22:36:10 +0000
Message-ID: <20260711223707.42139-78-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.13.214.179;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

The three remaining orphan-creating sites in hw/usb are all
command-line and hotplug-adjacent code paths that always run after
the machine is up:

  usb_claim_port() auto-hub  -> child of the USB host controller
                                 (bus->qbus.parent)
  usbdevice_create()         -> /machine/peripheral-anon, same as
                                 -device without id=
  usb_braille_init()          -> ditto (a .usbdevice_init callback)

Switch to qdev_new()/qdev_try_new() with an explicit parent and use
plain qdev_realize() since the reference is now held by the parent's
child<> property.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/usb/bus.c        | 15 ++++++++++-----
 hw/usb/dev-serial.c |  3 ++-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index d45cce7666..725b0303b1 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -410,9 +410,10 @@ void usb_claim_port(USBDevice *dev, Error **errp)
     } else {
         if (bus->nfree == 1 && strcmp(object_get_typename(OBJECT(dev)), "usb-hub") != 0) {
             /* Create a new hub and chain it on */
-            hub = USB_DEVICE(qdev_try_new_orphan("usb-hub"));
+            hub = USB_DEVICE(qdev_try_new(OBJECT(bus->qbus.parent),
+                                          "auto-hub[*]", "usb-hub"));
             if (hub) {
-                usb_realize_and_unref(hub, bus, NULL);
+                qdev_realize(DEVICE(hub), &bus->qbus, NULL);
             }
         }
         if (bus->nfree == 0) {
@@ -661,13 +662,17 @@ USBDevice *usbdevice_create(const char *driver)
         return NULL;
     }
 
-    dev = f->usbdevice_init ? f->usbdevice_init()
-                            : USB_DEVICE(qdev_new_orphan(f->name));
+    if (f->usbdevice_init) {
+        dev = f->usbdevice_init();
+    } else {
+        dev = USB_DEVICE(qdev_new(machine_get_container("peripheral-anon"),
+                                  "usbdevice[*]", f->name));
+    }
     if (!dev) {
         error_report("Failed to create USB device '%s'", f->name);
         return NULL;
     }
-    if (!usb_realize_and_unref(dev, bus, &err)) {
+    if (!qdev_realize(DEVICE(dev), &bus->qbus, &err)) {
         error_reportf_err(err, "Failed to initialize USB device '%s': ",
                           f->name);
         object_unparent(OBJECT(dev));
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 81897b2d76..4ae3faf656 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -622,7 +622,8 @@ static USBDevice *usb_braille_init(void)
         return NULL;
     }
 
-    dev = USB_DEVICE(qdev_new_orphan("usb-braille"));
+    dev = USB_DEVICE(qdev_new(machine_get_container("peripheral-anon"),
+                              "usbdevice[*]", "usb-braille"));
     qdev_prop_set_chr(&dev->qdev, "chardev", cdrv);
     return dev;
 }
-- 
2.47.1


