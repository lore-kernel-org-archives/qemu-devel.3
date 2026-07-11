Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1909C44509
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigKs-0006zs-1g; Sat, 11 Jul 2026 18:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigKq-0006wE-BH; Sat, 11 Jul 2026 18:38:12 -0400
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([50.112.246.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigKo-000561-8q; Sat, 11 Jul 2026 18:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809490; x=1815345490;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pMDhFLVLe52iFEESjI2BUOdg87f0qHOEgA7LeqYFsI0=;
 b=OitS5fysu80s7Oj5ZyR1n2d+mA0HxQaG3zaAvCXX6LfJVNTjm9BBq95K
 zChocXqLKZokCT0sMtim0WWS0Ux46XUb4CyI6bTB7kpekXNOo13NXgJMf
 38hJMQBlCldm37UtDT/p0gwGOSXN0qL6ifIn/WXNTBK3Jd7N9T0Z6KQJW
 2DWMT6UOipP0xir8ahJ1qTkgFdWQ4KUwt2E3qAMQEClG+fU0IIoibm7LG
 HYUf8rcHcuzq4L/zxkW5JH3WJ0TV/qYss7BlUDHiOZWb+Z8ZKr5MKw4FS
 VgMXPG8w7t8Y5CHKjdRwJAeb0F7IjOX+T/VB+cbd/jfDcwiPDrRPWEvp6 A==;
X-CSE-ConnectionGUID: rpgzi9FzT9+qmJm9aCagdw==
X-CSE-MsgGUID: 9DjULvmqR7+TXJ0ERc1IAg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23299817"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:38:06 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:8399]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.212:2525]
 with esmtp (Farcaster)
 id 794e71ce-3ff5-4ebc-83aa-c88d04de0714; Sat, 11 Jul 2026 22:38:05 +0000 (UTC)
X-Farcaster-Flow-ID: 794e71ce-3ff5-4ebc-83aa-c88d04de0714
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:38:05 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:37:56 +0000
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
Subject: [RFC PATCH 003/134] qdev: Reintroduce qdev_new() with a mandatory QOM
 parent
Date: Sat, 11 Jul 2026 22:34:56 +0000
Message-ID: <20260711223707.42139-4-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
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

The previous commit vacated the qdev_new()/qdev_try_new() names.
Reintroduce them with the signature we actually want:

  DeviceState *qdev_new(Object *parent, const char *id,
                        const char *type);

which is the qdev-layer, heap-allocated dual of
object_initialize_child(): the returned device is created and
immediately added to the QOM composition tree as a child of @parent
under @id.

Refcount contract: the initial reference is transferred to the
child<> property of @parent, so on return the caller does not hold a
reference.  Pair with qdev_realize() (not qdev_realize_and_unref()),
matching object_initialize_child()'s convention.

qdev_new_orphan() remains for callers that set the parent themselves
before realize (notably qdev_device_add(), which parents under
/machine/peripheral via qdev_set_id()).  Later patches convert the
remaining orphan callers subsystem by subsystem.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/core/qdev.c         | 19 +++++++++++++++++++
 include/hw/core/qdev.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 8a8d206a02..d2c89d0310 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -145,6 +145,25 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp)
     return true;
 }
 
+DeviceState *qdev_new(Object *parent, const char *id, const char *type)
+{
+    return DEVICE(object_new_child(parent, id, type));
+}
+
+DeviceState *qdev_try_new(Object *parent, const char *id, const char *type)
+{
+    ObjectClass *oc = module_object_class_by_name(type);
+    Object *obj;
+
+    if (!oc) {
+        return NULL;
+    }
+    obj = object_new_with_class(oc);
+    object_property_add_child(parent, id, obj);
+    object_unref(obj);
+    return DEVICE(obj);
+}
+
 DeviceState *qdev_new_orphan(const char *name)
 {
     return DEVICE(object_new(name));
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 839c1b4147..e692a1d48e 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -406,6 +406,40 @@ struct BusState {
 
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
+/**
+ * qdev_new: Create a device and parent it in the QOM composition tree
+ * @parent: the QOM parent (usually the machine or containing device)
+ * @id: child<> property name; the device's canonical QOM path becomes
+ *      @parent's path plus "/" plus @id
+ * @type: device type to create (we assert() that this type exists)
+ *
+ * Heap-allocated counterpart to object_initialize_child().  This
+ * allocates and initializes the device state and immediately adds it
+ * as a child of @parent, ready for the caller to set properties and
+ * then realize.
+ *
+ * The reference count of the returned device is 1, held by @parent's
+ * child<> property.  The caller therefore does not hold a reference
+ * and pairs this with qdev_realize() (NOT qdev_realize_and_unref()).
+ *
+ * Return: a derived DeviceState, owned by @parent.
+ */
+DeviceState *qdev_new(Object *parent, const char *id, const char *type);
+
+/**
+ * qdev_try_new: Try to create a parented device on the heap
+ * @parent: the QOM parent
+ * @id: child<> property name
+ * @type: device type to create
+ *
+ * This is like qdev_new(), except it returns %NULL when @type does
+ * not exist, rather than asserting.
+ *
+ * Return: a derived DeviceState owned by @parent, or NULL if @type
+ * does not exist.
+ */
+DeviceState *qdev_try_new(Object *parent, const char *id, const char *type);
+
 /**
  * qdev_new_orphan: Create a device on the heap
  * @name: device type to create (we assert() that this type exists)
-- 
2.47.1


