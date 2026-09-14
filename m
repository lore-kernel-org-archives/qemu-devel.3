Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FC2C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x634r-0000s6-VI; Mon, 14 Sep 2026 05:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x634T-0000i0-MM; Mon, 14 Sep 2026 05:33:55 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x634M-0000S0-TT; Mon, 14 Sep 2026 05:33:51 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68E9WXEY020350
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 14 Sep 2026 18:32:39 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=n9BWWfE0dQa97OtsMBDqaxa96143zTTodhNiQMz+voA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789378359; v=1;
 b=NhKF2pog4wmir/D/gQysVSaZxemR8yaKACfGtJ7fO2Wv/AZxj6fCNpEUZHZtqRyC
 /uLBH69H9NBhrLCeLd7N4Uv1A0utWAaw/QNF2+RxaSNJfy6rfbdIDKxS0JwxmaTz
 3SSJx1xD72xeARN9aF4lgc2LGzAjXn6yozvc5O+t8u9jU1jp9KQRhBjJKR+D8JxW
 LDcAqw2w8rVXLQ9R+ilacwi/RKd85nHGuEJMUmAMZge8aESlW9qWwiv2U+3Cys8J
 M9RJqeYNM5v2ddkV5W7AQHshsDMtRoOLoLHCeM4DAc+IIQ64Rl3UUGWG7wdSh77e
 PhlP9kxR8wk65v18pv0MBQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 14 Sep 2026 18:31:51 +0900
Subject: [PATCH v4 3/4] hw/qdev: Introduce the initialized and retired phases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-qdev-v4-3-93f849b4865c@rsg.ci.i.u-tokyo.ac.jp>
References: <20260914-qdev-v4-0-93f849b4865c@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260914-qdev-v4-0-93f849b4865c@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10749;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=3i74lwjzvE2YCcOnqcK5z/mmWwz3jiRm5sw61tECvh8=;
 b=kA0DAAoWKJ19aUZYEjEByyZiAGqnvy/IM/hlLzcBPLvpdcE40rJRvEPAg0fJeWvYB3e3nd1wG
 Yh1BAAWCgAdFiEEZHK7CyhbffJxYF+EKJ19aUZYEjEFAmqnvy8ACgkQKJ19aUZYEjH6twD/cBtZ
 ur5RTBjtgp7tXqW8YmsnS21ltwcIm04yhOK5P8UBAIFano5DiEhqg57wwV3u0MJmB6lnD1uRuCV
 Mv4HgZPgL
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qdev currently permits another realization attempt after a device has
been unrealized or a previous attempt has failed, which can invoke
DeviceClass::realize() more than once. Supporting repeated realization
adds complexity to device implementations. It is untested and likely
broken.

Replace the unrealized phase with two finer phases: initialized and
retired. Realization can start only in the initialized phase. Successful
realization moves it to the realized phase; failure after realization
has started moves it to the retired phase. Unrealization also moves a
device to the retired phase.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 qapi/common.json       |  7 +++--
 include/hw/core/qdev.h |  3 +-
 hw/core/qdev.c         | 53 +++++++++++++++++++++++-----------
 tests/unit/test-qdev.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 121 insertions(+), 20 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index 415a2722fc1a..f3218b846ce8 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -12,14 +12,17 @@
 #
 # An enumeration of the device phases
 #
-# @unrealized: the initial phase
+# @initialized: the initial phase
 #
 # @realized: the phase after realization
 #
+# @retired: the phase entered when unrealization begins or
+#           realization fails after starting
+#
 # Since: 11.2
 ##
 { 'enum': 'DevicePhase',
-  'data': [ 'unrealized', 'realized' ] }
+  'data': [ 'initialized', 'realized', 'retired' ] }
 
 ##
 # @IoOperationType:
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index ff367b2a5f98..a0aa7e3f6e35 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -32,7 +32,8 @@
  *
  * #TypeInfo.instance_init may not fail. #DeviceClass.realize can
  * fail, returning error information to the caller, and must be re-entrant.
- *
+ * A device's realize method will not be called after realization, even
+ * if realization fails or the device is later unrealized.
  * #TypeInfo.instance_init should add instance properties but must not
  * have any side effect not contained in the instance, since it happens
  * during device introspection already. Any operations without special
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 3623fbf69e78..ca150ecad023 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -314,7 +314,7 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
 
 void qdev_unrealize(DeviceState *dev)
 {
-    object_property_set_str(OBJECT(dev), "phase", "unrealized", &error_abort);
+    object_property_set_str(OBJECT(dev), "phase", "retired", &error_abort);
 }
 
 static int qdev_assert_realized_properly_cb(Object *obj, void *opaque)
@@ -499,12 +499,22 @@ static bool check_only_migratable(Object *obj, Error **errp)
 
 static void device_set_phase(Object *obj, int value, Error **errp)
 {
+    ERRP_GUARD();
     DeviceState *dev = DEVICE(obj);
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
+    DevicePhase old_value = dev->phase;
     HotplugHandler *hotplug_ctrl;
     BusState *bus;
     NamedClockList *ncl;
-    Error *local_err = NULL;
+
+    if (value == old_value) {
+        return;
+    }
+
+    if (old_value == DEVICE_PHASE_RETIRED) {
+        error_setg(errp, "A device cannot transition from retired to another phase");
+        return;
+    }
 
     if (dev->hotplugged && !dc->hotpluggable) {
         error_setg(errp, "Device '%s' does not support hotplugging",
@@ -512,7 +522,12 @@ static void device_set_phase(Object *obj, int value, Error **errp)
         return;
     }
 
-    if (value == DEVICE_PHASE_REALIZED && dev->phase != DEVICE_PHASE_REALIZED) {
+    switch (value) {
+    case DEVICE_PHASE_INITIALIZED:
+        error_setg(errp, "A device cannot transition from another phase to initialized");
+        return;
+
+    case DEVICE_PHASE_REALIZED:
         if (!check_only_migratable(obj, errp)) {
             goto fail;
         }
@@ -526,8 +541,8 @@ static void device_set_phase(Object *obj, int value, Error **errp)
         }
 
         if (dc->realize) {
-            dc->realize(dev, &local_err);
-            if (local_err != NULL) {
+            dc->realize(dev, errp);
+            if (*errp) {
                 goto fail;
             }
         }
@@ -554,7 +569,7 @@ static void device_set_phase(Object *obj, int value, Error **errp)
                                                qdev_get_vmsd(dev), dev,
                                                dev->instance_id_alias,
                                                dev->alias_required_for_version,
-                                               &local_err) < 0) {
+                                               errp) < 0) {
                 goto post_realize_fail;
             }
         }
@@ -583,25 +598,30 @@ static void device_set_phase(Object *obj, int value, Error **errp)
         dev->pending_deleted_event = false;
 
         if (hotplug_ctrl) {
-            hotplug_handler_plug(hotplug_ctrl, dev, &local_err);
-            if (local_err != NULL) {
+            hotplug_handler_plug(hotplug_ctrl, dev, errp);
+            if (*errp) {
                 goto child_realize_fail;
             }
        }
 
        qatomic_store_release(&dev->phase, value);
+       return;
 
-    } else if (value != DEVICE_PHASE_REALIZED &&
-               dev->phase == DEVICE_PHASE_REALIZED) {
+    case DEVICE_PHASE_RETIRED:
         /*
          * Change the value so that any concurrent users are aware
-         * that the device is going to be unrealized
+         * that the device is going to be retired
          *
          * TODO: change .phase property to state
          * each sub-phase of the device realization/unrealization
          */
 
         qatomic_set(&dev->phase, value);
+
+        if (old_value == DEVICE_PHASE_INITIALIZED) {
+            return;
+        }
+
         /*
          * Ensure that concurrent users see this update prior to
          * any other changes done by unrealize.
@@ -619,10 +639,11 @@ static void device_set_phase(Object *obj, int value, Error **errp)
         }
         dev->pending_deleted_event = true;
         DEVICE_LISTENER_CALL(unrealize, Reverse, dev);
-    }
+        return;
 
-    assert(local_err == NULL);
-    return;
+    default:
+        g_assert_not_reached();
+    }
 
 child_realize_fail:
     QLIST_FOREACH(bus, &dev->child_bus, sibling) {
@@ -641,7 +662,7 @@ post_realize_fail:
     }
 
 fail:
-    error_propagate(errp, local_err);
+    qatomic_store_release(&dev->phase, DEVICE_PHASE_RETIRED);
 }
 
 static bool device_get_hotpluggable(Object *obj, Error **errp)
@@ -670,7 +691,7 @@ static void device_initfn(Object *obj)
     }
 
     dev->instance_id_alias = -1;
-    dev->phase = DEVICE_PHASE_UNREALIZED;
+    dev->phase = DEVICE_PHASE_INITIALIZED;
     dev->allow_unplug_during_migration = false;
 
     QLIST_INIT(&dev->gpios);
diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
index 77c3eee71713..bb1049fa9919 100644
--- a/tests/unit/test-qdev.c
+++ b/tests/unit/test-qdev.c
@@ -17,6 +17,9 @@ struct MyDev {
     char *prop_string;
     uint32_t *prop_array_u32;
     uint32_t prop_array_u32_nb;
+    uint16_t realization_count;
+    uint16_t unrealization_count;
+    Error *realization_err;
 };
 
 static const Property my_dev_props[] = {
@@ -26,11 +29,25 @@ static const Property my_dev_props[] = {
                      qdev_prop_uint32, uint32_t),
 };
 
+static void my_dev_realize(DeviceState *dev, Error **errp)
+{
+    MyDev *mt = STATIC_TYPE(dev);
+    mt->realization_count++;
+    error_propagate(errp, g_steal_pointer(&mt->realization_err));
+}
+
+static void my_dev_unrealize(DeviceState *dev)
+{
+    MyDev *mt = STATIC_TYPE(dev);
+    mt->unrealization_count++;
+}
+
 static void my_dev_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->realize = NULL;
+    dc->realize = my_dev_realize;
+    dc->unrealize = my_dev_unrealize;
     device_class_set_props(dc, my_dev_props);
 }
 
@@ -82,8 +99,55 @@ static void test_qdev_double_realization(void)
 {
     MyDev *mt = STATIC_TYPE(object_new(TYPE_MY_DEV));
 
+    g_assert_cmpint(mt->realization_count, ==, 0);
     qdev_realize(DEVICE(mt), NULL, &error_fatal);
+    g_assert_cmpint(mt->realization_count, ==, 1);
     qdev_realize(DEVICE(mt), NULL, &error_fatal);
+    g_assert_cmpint(mt->realization_count, ==, 1);
+    object_unparent(OBJECT(mt));
+    object_unref(OBJECT(mt));
+}
+
+static void test_qdev_realize_after_unrealization(void)
+{
+    Object *mt = object_new(TYPE_MY_DEV);
+
+    qdev_unrealize(DEVICE(mt));
+    g_assert_false(qdev_realize(DEVICE(mt), NULL, NULL));
+    object_unparent(mt);
+    object_unref(mt);
+}
+
+static void test_qdev_retry_realization(void)
+{
+    MyDev *mt = STATIC_TYPE(object_new(TYPE_MY_DEV));
+
+    error_setg(&mt->realization_err, "error");
+    g_assert_false(qdev_realize(DEVICE(mt), NULL, NULL));
+    g_assert_false(qdev_realize(DEVICE(mt), NULL, NULL));
+    object_unparent(OBJECT(mt));
+    object_unref(OBJECT(mt));
+}
+
+static void test_qdev_unrealize_after_realization(void)
+{
+    MyDev *mt = STATIC_TYPE(object_new(TYPE_MY_DEV));
+
+    qdev_realize(DEVICE(mt), NULL, &error_fatal);
+    g_assert_cmpint(mt->unrealization_count, ==, 0);
+    qdev_unrealize(DEVICE(mt));
+    g_assert_cmpint(mt->unrealization_count, ==, 1);
+    object_unparent(OBJECT(mt));
+    object_unref(OBJECT(mt));
+}
+
+static void test_qdev_unrealize_without_realization(void)
+{
+    MyDev *mt = STATIC_TYPE(object_new(TYPE_MY_DEV));
+
+    g_assert_cmpint(mt->unrealization_count, ==, 0);
+    qdev_unrealize(DEVICE(mt));
+    g_assert_cmpint(mt->unrealization_count, ==, 0);
     object_unparent(OBJECT(mt));
     object_unref(OBJECT(mt));
 }
@@ -103,6 +167,18 @@ int main(int argc, char **argv)
     g_test_add_func("/qdev/double-realization",
                     test_qdev_double_realization);
 
+    g_test_add_func("/qdev/realize-after-unrealization",
+                    test_qdev_realize_after_unrealization);
+
+    g_test_add_func("/qdev/retry-realization",
+                    test_qdev_retry_realization);
+
+    g_test_add_func("/qdev/unrealize-after-realization",
+                    test_qdev_unrealize_after_realization);
+
+    g_test_add_func("/qdev/unrealize-without-realization",
+                    test_qdev_unrealize_without_realization);
+
     g_test_run();
 
     return 0;

-- 
2.55.0


