Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47228C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigri-000751-FM; Sat, 11 Jul 2026 19:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigrg-00073O-8u; Sat, 11 Jul 2026 19:12:08 -0400
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.155.198.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigrd-0004xT-UY; Sat, 11 Jul 2026 19:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811525; x=1815347525;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HUh3AhjbxdYbQQBQLAwLY6e2h8D1o6fDnZPkSJ/q8nk=;
 b=iqeIFU5UMuIKS9hzVXWLVFuaWE2E3RJG8Ci+3/5DGUo1vmCuHfT9BxZq
 j+StDvZQ+KOFXuHVX0a5uPsmqV0g2ZEeT5IQxGTPYvcYxnpYevIGsyvwb
 iMA7Pqec8fUvomkhLsFL8+p4n0QM5sLDG11I8VlDeGXQdrKOdOGRK4ML1
 +M8JTzMTBU8ExCWe53tgaFcpGefGQWfrncCh9Z2DnOXT94lWVD6Md56Mt
 WBTRW6MPhuJdnnTaAYoPoHlugwV8Bmxg/SYEmFkCNdZJhNn4KvOwm4jQE
 8AuTKH6ZDRSa+HRK1/1wZQp4+FEVbht04tfrxiG6un8WPtf0usYqH2K2j w==;
X-CSE-ConnectionGUID: qgxiEoI8TNC22c5uFahBQQ==
X-CSE-MsgGUID: uOgsjy5STk6+3YM4B5PqbA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23390828"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:12:02 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:2822]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.214:2525]
 with esmtp (Farcaster)
 id 45ddd563-d3ea-4aa1-8df6-d144a2cc8f07; Sat, 11 Jul 2026 23:12:02 +0000 (UTC)
X-Farcaster-Flow-ID: 45ddd563-d3ea-4aa1-8df6-d144a2cc8f07
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:12:01 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:11:53 +0000
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
Subject: [RFC PATCH 132/134] qom: Delete /machine/unattached and error on
 unparented realize
Date: Sat, 11 Jul 2026 22:37:05 +0000
Message-ID: <20260711223707.42139-133-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.155.198.111;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

With every board-created device, memory region, IRQ, and singleton
now given an explicit QOM parent, the /machine/unattached container
serves no legitimate purpose.  Remove it and turn the
device_set_realized() fallback into a hard error, so that any
future orphan is caught at realize time rather than silently
adopted into an anonymous bucket.

  hw/core/qdev.c   error out on !obj->parent instead of adopting
  hw/core/qdev-user.c   drop the fake unattached container
  system/vl.c      drop "unattached" from machine container list
  hw/i386/pc.c     search /machine recursively for the FDC instead
                   of the (unattached, peripheral, peripheral-anon)
                   container triple
  tests/unit/      parent test devices explicitly under /machine

After this commit, `info qom-tree` no longer shows
/machine/unattached on any target/machine combination, and
`git grep '"unattached"'` returns zero hits.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/core/qdev-user.c                 |  6 +-----
 hw/core/qdev.c                      | 20 ++++----------------
 hw/i386/pc.c                        | 11 +----------
 include/hw/core/qdev.h              |  2 +-
 system/vl.c                         |  1 -
 tests/unit/test-qdev-global-props.c | 17 +++++++----------
 tests/unit/test-qdev.c              | 12 ++++--------
 7 files changed, 18 insertions(+), 51 deletions(-)

diff --git a/hw/core/qdev-user.c b/hw/core/qdev-user.c
index 051f8fbd02..592a8369a3 100644
--- a/hw/core/qdev-user.c
+++ b/hw/core/qdev-user.c
@@ -11,9 +11,5 @@
 
 void qdev_create_fake_machine(void)
 {
-    Object *fake_machine_obj;
-
-    fake_machine_obj = object_property_add_new_container(object_get_root(),
-                                                         "machine");
-    object_property_add_new_container(fake_machine_obj, "unattached");
+    object_property_add_new_container(object_get_root(), "machine");
 }
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 44a44862fd..7d7d08733d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -485,8 +485,6 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
     BusState *bus;
     NamedClockList *ncl;
     Error *local_err = NULL;
-    bool unattached_parent = false;
-    static int unattached_count;
 
     if (dev->hotplugged && !dc->hotpluggable) {
         error_setg(errp, "Device '%s' does not support hotplugging",
@@ -500,12 +498,10 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         }
 
         if (!obj->parent) {
-            gchar *name = g_strdup_printf("device[%d]", unattached_count++);
-
-            object_property_add_child(machine_get_container("unattached"),
-                                      name, obj);
-            unattached_parent = true;
-            g_free(name);
+            error_setg(errp, "device type '%s' has no QOM parent; "
+                       "use qdev_new() with a parent",
+                       object_get_typename(obj));
+            return;
         }
 
         hotplug_ctrl = qdev_get_hotplug_handler(dev);
@@ -633,14 +629,6 @@ post_realize_fail:
 
 fail:
     error_propagate(errp, local_err);
-    if (unattached_parent) {
-        /*
-         * Beware, this doesn't just revert
-         * object_property_add_child(), it also runs bus_remove()!
-         */
-        object_unparent(OBJECT(dev));
-        unattached_count--;
-    }
 }
 
 static bool device_get_hotpluggable(Object *obj, Error **errp)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 398371ff6f..bab8ee453f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -368,24 +368,15 @@ static int check_fdc(Object *obj, void *opaque)
     return 0;
 }
 
-static const char * const fdc_container_path[] = {
-    "unattached", "peripheral", "peripheral-anon"
-};
-
 /*
  * Locate the FDC at IO address 0x3f0, in order to configure the CMOS registers
  * and ACPI objects.
  */
 static ISADevice *pc_find_fdc0(void)
 {
-    int i;
-    Object *container;
     CheckFdcState state = { 0 };
 
-    for (i = 0; i < ARRAY_SIZE(fdc_container_path); i++) {
-        container = machine_get_container(fdc_container_path[i]);
-        object_child_foreach(container, check_fdc, &state);
-    }
+    object_child_foreach_recursive(qdev_get_machine(), check_fdc, &state);
 
     if (state.multiple) {
         warn_report("multiple floppy disk controllers with "
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 9220e9e3b1..eded1b715d 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -462,7 +462,7 @@ static inline bool qdev_is_realized(DeviceState *dev)
  * initialization.
  * @dev must not be plugged into a bus already.
  * If @bus, plug @dev into @bus.  This takes a reference to @dev.
- * If @dev has no QOM parent, make one up, taking another reference.
+ * @dev must already have a QOM parent (see qdev_new()).
  *
  * If you created @dev via object_new() directly (holding a floating
  * reference), you probably want to use qdev_realize_and_unref() instead.
diff --git a/system/vl.c b/system/vl.c
index b4434839df..e51399d389 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2192,7 +2192,6 @@ static void parse_memory_options(void)
 static void qemu_create_machine_containers(Object *machine)
 {
     static const char *const containers[] = {
-        "unattached",
         "peripheral",
         "peripheral-anon",
     };
diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index 8ea362cbb9..a941774b9d 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -78,25 +78,22 @@ static const TypeInfo subclass_type = {
  * inherit the global states of the parent process) will try to create qdev
  * and realize the device.
  *
- * Realization of such anonymous qdev (with no parent object) requires both
- * the machine object and its "unattached" container to be at least present.
+ * Realization requires that the device already has a QOM parent.
  */
 static void test_init_machine(void)
 {
     /* This is a fake machine - it doesn't need to be a machine object */
-    Object *machine = object_property_add_new_container(
+    object_property_add_new_container(
         object_get_root(), "machine");
 
-    /* This container must exist for anonymous qdevs to realize() */
-    object_property_add_new_container(machine, "unattached");
-}
+    }
 
 /* Test simple static property setting to default value */
 static void test_static_prop_subprocess(void)
 {
     MyType *mt;
 
-    mt = STATIC_TYPE(object_new(TYPE_STATIC_PROPS));
+    mt = STATIC_TYPE(object_new_child(qdev_get_machine(), "dev[*]", TYPE_STATIC_PROPS));
     qdev_realize(DEVICE(mt), NULL, &error_fatal);
 
     g_assert_cmpuint(mt->prop1, ==, PROP_DEFAULT);
@@ -131,7 +128,7 @@ static void test_static_globalprop_subprocess(void)
 
     register_global_properties(props);
 
-    mt = STATIC_TYPE(object_new(TYPE_STATIC_PROPS));
+    mt = STATIC_TYPE(object_new_child(qdev_get_machine(), "dev[*]", TYPE_STATIC_PROPS));
     qdev_realize(DEVICE(mt), NULL, &error_fatal);
 
     g_assert_cmpuint(mt->prop1, ==, 200);
@@ -249,7 +246,7 @@ static void test_dynamic_globalprop_subprocess(void)
 
     register_global_properties(props);
 
-    mt = DYNAMIC_TYPE(object_new(TYPE_DYNAMIC_PROPS));
+    mt = DYNAMIC_TYPE(object_new_child(qdev_get_machine(), "dev[*]", TYPE_DYNAMIC_PROPS));
     qdev_realize(DEVICE(mt), NULL, &error_fatal);
 
     g_assert_cmpuint(mt->prop1, ==, 101);
@@ -295,7 +292,7 @@ static void test_subclass_global_props(void)
 
     register_global_properties(props);
 
-    mt = STATIC_TYPE(object_new(TYPE_SUBCLASS));
+    mt = STATIC_TYPE(object_new_child(qdev_get_machine(), "dev[*]", TYPE_SUBCLASS));
     qdev_realize(DEVICE(mt), NULL, &error_fatal);
 
     g_assert_cmpuint(mt->prop1, ==, 102);
diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
index 20eae38e03..eafffb7175 100644
--- a/tests/unit/test-qdev.c
+++ b/tests/unit/test-qdev.c
@@ -44,24 +44,21 @@ static const TypeInfo my_dev_type_info = {
 /*
  * Initialize a fake machine, being prepared for future tests.
  *
- * Realization of anonymous qdev (with no parent object) requires both
- * the machine object and its "unattached" container to be at least present.
+ * Realization requires that the device already has a QOM parent.
  */
 static void test_init_machine(void)
 {
     /* This is a fake machine - it doesn't need to be a machine object */
-    Object *machine = object_property_add_new_container(
+    object_property_add_new_container(
         object_get_root(), "machine");
 
-    /* This container must exist for anonymous qdevs to realize() */
-    object_property_add_new_container(machine, "unattached");
-}
+    }
 
 static void test_qdev_free_properties(void)
 {
     MyDev *mt;
 
-    mt = STATIC_TYPE(object_new(TYPE_MY_DEV));
+    mt = STATIC_TYPE(object_new_child(qdev_get_machine(), "dev[*]", TYPE_MY_DEV));
     object_set_props(OBJECT(mt), &error_fatal,
                      "string", "something",
                      "array-u32", "12,13",
@@ -75,7 +72,6 @@ static void test_qdev_free_properties(void)
     g_assert_cmpuint(mt->prop_array_u32[1], ==, 13);
 
     object_unparent(OBJECT(mt));
-    object_unref(mt);
 }
 
 
-- 
2.47.1


