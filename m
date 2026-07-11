Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B667EC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigf6-0006t4-JD; Sat, 11 Jul 2026 18:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigf5-0006ie-0k; Sat, 11 Jul 2026 18:59:07 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigex-0001b6-9I; Sat, 11 Jul 2026 18:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810739; x=1815346739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5wJX8HTlMWOp+CthdhWDxuxqwHRCoNy4439GbPHkYpo=;
 b=LptMTme+m0VP3RaEsLxStA1JAYk5FIRr0Bh3hbGA6zgBiIUeuPXuaaSe
 EN14Yp7ND6xqaCn3ZrVxuOo8w5/rD0MSUunatCeiAbXoJlG0zFyVIDpyx
 hTyn1m+VaF4sPEJ6sU25b+ru2ShS0kjjo/Ny56/U9BGGMhlogOZ1xRjio
 FE53JbN5A2AnNaUiz9jKVWCX7ZTdGcnO1i4Lt74E/xNPuWTIIHy/MIEsh
 IzeVj7a1Ltd837wMIGTFy/S1ASL5W3GtvYx0GwYqxpifPcrLSQbQuznlm
 /qy7uq+BYFyS6HgTC5PNkpCLbU/xFnKRa3yDtaJQS8b6pQ1P3xvuSeJFB g==;
X-CSE-ConnectionGUID: tyYwmJWCSuS6lTSk5SivTw==
X-CSE-MsgGUID: p/V0nDvLSw+97JVEWtpETg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="22997678"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:58:55 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:5669]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525]
 with esmtp (Farcaster)
 id 3046c674-944c-4dc9-9a2e-17595cc7fb99; Sat, 11 Jul 2026 22:58:55 +0000 (UTC)
X-Farcaster-Flow-ID: 3046c674-944c-4dc9-9a2e-17595cc7fb99
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:58:55 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:58:46 +0000
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
Subject: [RFC PATCH 083/134] usb, ssi, i2c: Remove *_orphan() creator variants
Date: Sat, 11 Jul 2026 22:36:16 +0000
Message-ID: <20260711223707.42139-84-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.245.243.92;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

All external callers now go through the parented usb_new()/
usb_create_simple(), ssi_create_peripheral(), i2c_slave_new()/
i2c_slave_create_simple() introduced earlier in the series.
Remove the transitional *_orphan() spellings.

The corresponding *_realize_and_unref() helpers stay for now: they
are still valid for callers that reach for object_new() directly
and hold a floating reference (qdev_device_add() being the primary
example one layer down).

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/i2c/core.c        | 18 ------------------
 hw/ssi/ssi.c         |  8 --------
 include/hw/i2c/i2c.h | 31 ++++---------------------------
 include/hw/ssi/ssi.h |  5 ++---
 include/hw/usb/usb.h |  9 ---------
 5 files changed, 6 insertions(+), 65 deletions(-)

diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index fba21fdfad..f333df3760 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -364,15 +364,6 @@ const VMStateDescription vmstate_i2c_slave = {
     }
 };
 
-I2CSlave *i2c_slave_new_orphan(const char *name, uint8_t addr)
-{
-    DeviceState *dev;
-
-    dev = qdev_new_orphan(name);
-    qdev_prop_set_uint8(dev, "address", addr);
-    return I2C_SLAVE(dev);
-}
-
 I2CSlave *i2c_slave_new(Object *parent, const char *id,
                         const char *type, uint8_t addr)
 {
@@ -398,15 +389,6 @@ bool i2c_slave_realize_and_unref(I2CSlave *dev, I2CBus *bus, Error **errp)
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
 }
 
-I2CSlave *i2c_slave_create_simple_orphan(I2CBus *bus, const char *name, uint8_t addr)
-{
-    I2CSlave *dev = i2c_slave_new_orphan(name, addr);
-
-    i2c_slave_realize_and_unref(dev, bus, &error_abort);
-
-    return dev;
-}
-
 static bool i2c_slave_match(I2CSlave *candidate, uint8_t address,
                             bool broadcast, I2CNodeList *current_devs)
 {
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 6031cde7b0..07188d87bb 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -147,14 +147,6 @@ DeviceState *ssi_create_peripheral(Object *parent, const char *id,
     return dev;
 }
 
-DeviceState *ssi_create_peripheral_orphan(SSIBus *bus, const char *name)
-{
-    DeviceState *dev = qdev_new_orphan(name);
-
-    ssi_realize_and_unref(dev, bus, &error_fatal);
-    return dev;
-}
-
 SSIBus *ssi_create_bus(DeviceState *parent, const char *name)
 {
     BusState *bus;
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 0bba1a7c20..c0829edf8f 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -154,17 +154,6 @@ uint8_t i2c_recv(I2CBus *bus);
 bool i2c_scan_bus(I2CBus *bus, uint8_t address, bool broadcast,
                   I2CNodeList *current_devs);
 
-/**
- * Create an I2C slave device on the heap.
- * @name: a device type name
- * @addr: I2C address of the slave when put on a bus
- *
- * This only initializes the device state structure and allows
- * properties to be set. Type @name must exist. The device still
- * needs to be realized. See qdev-core.h.
- */
-I2CSlave *i2c_slave_new_orphan(const char *name, uint8_t addr);
-
 /**
  * Create a parented I2C slave device on the heap.
  * @parent: the QOM parent
@@ -172,24 +161,12 @@ I2CSlave *i2c_slave_new_orphan(const char *name, uint8_t addr);
  * @type: I2C slave device type name
  * @addr: I2C address of the slave when put on a bus
  *
- * Like i2c_slave_new_orphan(), but the returned device is owned by
+ * Like i2c_slave_new(), but the returned device is owned by
  * @parent's child<> property.  Pair with qdev_realize().
  */
 I2CSlave *i2c_slave_new(Object *parent, const char *id,
                         const char *type, uint8_t addr);
 
-/**
- * Create and realize an I2C slave device on the heap.
- * @bus: I2C bus to put it on
- * @name: I2C slave device type name
- * @addr: I2C address of the slave when put on a bus
- *
- * Create the device state structure, initialize it, put it on the
- * specified @bus, and drop the reference to it (the device is realized).
- */
-I2CSlave *i2c_slave_create_simple_orphan(I2CBus *bus, const char *name,
-                                         uint8_t addr);
-
 /**
  * Create, parent and realize an I2C slave device on the heap.
  * @parent: the QOM parent
@@ -218,11 +195,11 @@ I2CSlave *i2c_slave_create_simple(Object *parent, const char *id,
  * Call 'realize' on @dev, put it on the specified @bus, and drop the
  * reference to it.
  *
- * This function is useful if you have created @dev via qdev_new_orphan(),
- * i2c_slave_new_orphan() or i2c_slave_try_new() (which take a reference to
+ * This function is useful if you have created @dev via qdev_new(),
+ * i2c_slave_new() or i2c_slave_try_new() (which take a reference to
  * the device it returns to you), so that you can set properties on it
  * before realizing it. If you don't need to set properties then
- * i2c_slave_create_simple_orphan() is probably better (as it does the create,
+ * i2c_slave_create_simple() is probably better (as it does the create,
  * init and realize in one step).
  *
  * If you are embedding the I2C slave into another QOM device and
diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index 36ed002281..b2a264bb55 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -83,7 +83,6 @@ extern const VMStateDescription vmstate_ssi_peripheral;
 
 DeviceState *ssi_create_peripheral(Object *parent, const char *id,
                                     SSIBus *bus, const char *type);
-DeviceState *ssi_create_peripheral_orphan(SSIBus *bus, const char *name);
 /**
  * ssi_realize_and_unref: realize and unref an SSI peripheral
  * @dev: SSI peripheral to realize
@@ -94,10 +93,10 @@ DeviceState *ssi_create_peripheral_orphan(SSIBus *bus, const char *name);
  * reference to it. Errors are reported via @errp and by returning
  * false.
  *
- * This function is useful if you have created @dev via qdev_new_orphan()
+ * This function is useful if you have created @dev via qdev_new()
  * (which takes a reference to the device it returns to you), so that
  * you can set properties on it before realizing it. If you don't need
- * to set properties then ssi_create_peripheral_orphan() is probably better (as it
+ * to set properties then ssi_create_peripheral() is probably better (as it
  * does the create, init and realize in one step).
  *
  * If you are embedding the SSI peripheral into another QOM device and
diff --git a/include/hw/usb/usb.h b/include/hw/usb/usb.h
index 1ae1f40aa9..d2e59bc83b 100644
--- a/include/hw/usb/usb.h
+++ b/include/hw/usb/usb.h
@@ -599,13 +599,4 @@ static inline USBDevice *usb_create_simple(Object *parent, const char *id,
     return dev;
 }
 
-static inline USBDevice *usb_create_simple_orphan(USBBus *bus,
-                                                    const char *name)
-{
-    USBDevice *dev = USB_DEVICE(qdev_new_orphan(name));
-
-    usb_realize_and_unref(dev, bus, &error_abort);
-    return dev;
-}
-
 #endif
-- 
2.47.1


