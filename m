Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E9DC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5gd-0000qy-2h; Tue, 21 Jul 2026 04:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm5gZ-0000iB-Ep; Tue, 21 Jul 2026 04:18:43 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm5gU-0001Zq-67; Tue, 21 Jul 2026 04:18:43 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66L8GsC0050170
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 21 Jul 2026 17:17:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=KdG8UYuPxSjtyAfCgYV2dAyRjnB2kW2wTApGftqXlKQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1784621858; v=1;
 b=hQKvbFAAqK6A0Ipu8R3mBCCxDVdON+lpaxdM9zIgAm2yekhVtzEf+p5H/Z3HpLg5
 lbyZxDeH6u8d764HwYOrap5ZrvvehfjYJDmmsdRsmEQj8ZPZvq+5VwJXX3d2XCBv
 +I4rkoe0vbrBrFxjcyWthk2m/kZ2eTg5ZnTPbSFVUq16S8AXLbI3BEYcpptiHHDi
 HHGzk3I0s6Y2eOqtZSrNlgiQFl92HxCjh1jotmTaZT6gEPE2+nJvD0282/11txrp
 C4bNkiOOPsIZANhS6x0wpb3G9YoMnXvE8Wy6HIL041hi3WzKxzWACWXRoXF38cQs
 HthWigkQKRkBTJcxAxqKig==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 21 Jul 2026 17:17:05 +0900
Subject: [PATCH for-11.2 v3 15/15] hw/qdev: Prevent devices from being
 realized more than once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-qdev-v3-15-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=21879;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=1ve/6whPmh8L1TD3oKRaRGHIJkEEri1ZNlFUN7ibfj8=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1a8tlTC05zH65aderxgckLNp6epv170NCRclmWsnH1j9
 1URxc/ZHaUsDGJcDLJiiiwpRbu5NaJrPxUmxLfAzGFlAhnCwMUpABMR7WJkWLJh04vtwb/OsSdE
 H3UOijh50aoz0ijB3XCCu56a0fSS9Qz/M6ddvy67r6LDk9HuxexVdVeyJqno/Xn/l219o+uGg42
 qzAA=
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

qdev currently permits reentrant realization of the same device. It also
permits another realization attempt after a device has been unrealized
or a previous attempt has failed. Either path can invoke
DeviceClass::realize() more than once. Supporting repeated realization
adds complexity to device implementations. It is untested and likely
broken.

Replace the bool DeviceState::realized field with the enum-valued
DeviceState::phase field. The enum has four values:

- initialized
- realizing
- realized
- retired

Realization can start only in the initialized phase. It moves the device
to the realizing phase before invoking callbacks, preventing another
realization attempt. Successful realization moves it to the realized
phase; failure after realization has started moves it to the retired
phase. Unrealization also moves a realized device to the retired phase.

The QOM realized property is an internal lifecycle property, not for
end users. Replace it with the enum-valued phase property.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 qapi/common.json          |  19 ++++++++
 include/hw/core/qdev.h    |  12 ++---
 hw/core/qdev-clock.c      |   4 +-
 hw/core/qdev-properties.c |   4 +-
 hw/core/qdev.c            |  98 ++++++++++++++++++++++++++--------------
 hw/scsi/scsi-bus.c        |   4 +-
 qom/qom-qmp-cmds.c        |   2 +-
 system/qdev-monitor.c     |   5 ++-
 tests/unit/test-qdev.c    | 112 +++++++++++++++++++++++++++++++++++++++++++++-
 9 files changed, 212 insertions(+), 48 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index af7e3d618a7c..88a308cbd172 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -7,6 +7,25 @@
 # *****************
 ##
 
+##
+# @DevicePhase:
+#
+# An enumeration of the device phases
+#
+# @initialized: the initial phase
+#
+# @realizing: the phase during realization
+#
+# @realized: the phase after realization
+#
+# @retired: the terminal phase entered when unrealization begins or
+#           realization fails after starting
+#
+# Since: 11.1
+##
+{ 'enum': 'DevicePhase',
+  'data': [ 'initialized', 'realizing', 'realized', 'retired' ] }
+
 ##
 # @IoOperationType:
 #
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 3f47ea72c009..c9012155a6ec 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -1,6 +1,7 @@
 #ifndef QDEV_CORE_H
 #define QDEV_CORE_H
 
+#include "qapi/qapi-types-common.h"
 #include "qemu/atomic.h"
 #include "qemu/queue.h"
 #include "qemu/bitmap.h"
@@ -29,8 +30,9 @@
  * 3) device realization
  *
  * #TypeInfo.instance_init may not fail. #DeviceClass.realize can
- * fail, returning error information to the caller. A device realize
- * method should handle being called again after it has failed once.
+ * fail, returning error information to the caller. A device's realize
+ * method is called at most once, even if realization fails or the
+ * device is later unrealized.
  * #TypeInfo.instance_init should add instance properties but must not
  * have any side effect not contained in the instance, since it happens
  * during device introspection already. Any operations without special
@@ -239,9 +241,9 @@ struct DeviceState {
      */
     char *canonical_path;
     /**
-     * @realized: has device been realized?
+     * @phase: the current phase
      */
-    bool realized;
+    DevicePhase phase;
     /**
      * @pending_deleted_event: track pending deletion events during unplug
      */
@@ -445,7 +447,7 @@ DeviceState *qdev_try_new(const char *name);
  */
 static inline bool qdev_is_realized(const DeviceState *dev)
 {
-    return qatomic_load_acquire(&dev->realized);
+    return qatomic_load_acquire(&dev->phase) == DEVICE_PHASE_REALIZED;
 }
 
 /**
diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 861f78f94c64..efb33a3a27e7 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -30,7 +30,7 @@ static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
      * Clock must be added before realize() so that we can compute the
      * clock's canonical path during device_realize().
      */
-    assert(!dev->realized);
+    assert(dev->phase != DEVICE_PHASE_REALIZED);
 
     /*
      * The ncl structure is freed by qdev_finalize_clocklist() which will
@@ -186,6 +186,6 @@ Clock *qdev_alias_clock(DeviceState *dev, const char *name,
 
 void qdev_connect_clock_in(DeviceState *dev, const char *name, Clock *source)
 {
-    assert(!dev->realized);
+    assert(dev->phase != DEVICE_PHASE_REALIZED);
     clock_set_source(qdev_get_clock_in(dev, name), source);
 }
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 34d7b26a7303..66cff4b9338c 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -33,7 +33,7 @@ static bool qdev_prop_allow_set(Object *obj, const char *name,
 {
     DeviceState *dev = DEVICE(obj);
 
-    if (dev->realized && !info->realized_set_allowed) {
+    if (dev->phase == DEVICE_PHASE_REALIZED && !info->realized_set_allowed) {
         qdev_prop_set_after_realize(dev, name, errp);
         return false;
     }
@@ -46,7 +46,7 @@ void qdev_prop_allow_set_link_before_realize(const Object *obj,
 {
     DeviceState *dev = DEVICE(obj);
 
-    if (dev->realized) {
+    if (dev->phase == DEVICE_PHASE_REALIZED) {
         error_setg(errp, "Attempt to set link property '%s' on device '%s' "
                    "(type '%s') after it was realized",
                    name, dev->id, object_get_typename(obj));
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 0b0f2f47fa78..994af2bec4fc 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -134,7 +134,7 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp)
     dev->parent_bus = bus;
     object_ref(OBJECT(bus));
     bus_add_child(bus, dev);
-    if (dev->realized) {
+    if (dev->phase == DEVICE_PHASE_REALIZED) {
         resettable_change_parent(OBJECT(dev), OBJECT(bus),
                                  OBJECT(old_parent_bus));
     }
@@ -230,7 +230,7 @@ bool qdev_should_hide_device(const QDict *opts, bool from_json, Error **errp)
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version)
 {
-    assert(!dev->realized);
+    assert(dev->phase != DEVICE_PHASE_REALIZED);
     dev->instance_id_alias = alias_id;
     dev->alias_required_for_version = required_for_version;
 }
@@ -286,7 +286,7 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
         assert(!DEVICE_GET_CLASS(dev)->bus_type);
     }
 
-    if (object_property_set_bool(OBJECT(dev), "realized", true, errp)) {
+    if (object_property_set_str(OBJECT(dev), "phase", "realized", errp)) {
         return true;
     }
 
@@ -314,7 +314,7 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
 
 void qdev_unrealize(DeviceState *dev)
 {
-    object_property_set_bool(OBJECT(dev), "realized", false, &error_abort);
+    object_property_set_str(OBJECT(dev), "phase", "retired", &error_abort);
 }
 
 static int qdev_assert_realized_properly_cb(Object *obj, void *opaque)
@@ -324,7 +324,7 @@ static int qdev_assert_realized_properly_cb(Object *obj, void *opaque)
 
     if (dev) {
         dc = DEVICE_GET_CLASS(dev);
-        assert(dev->realized);
+        assert(dev->phase == DEVICE_PHASE_REALIZED);
         assert(dev->parent_bus || !dc->bus_type);
     }
     return 0;
@@ -477,10 +477,10 @@ bool qdev_unplug_blocked(DeviceState *dev, Error **errp)
     return false;
 }
 
-static bool device_get_realized(Object *obj, Error **errp)
+static int device_get_phase(Object *obj, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
-    return dev->realized;
+    return dev->phase;
 }
 
 static bool check_only_migratable(Object *obj, Error **errp)
@@ -497,14 +497,29 @@ static bool check_only_migratable(Object *obj, Error **errp)
     return true;
 }
 
-static void device_set_realized(Object *obj, bool value, Error **errp)
+static void device_set_phase(Object *obj, int value, Error **errp)
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
+    if (old_value == DEVICE_PHASE_REALIZING) {
+        error_setg(errp, "The device is currently realizing");
+        return;
+    }
+
+    if (old_value == DEVICE_PHASE_RETIRED) {
+        error_setg(errp, "A device cannot transition from retired to another phase");
+        return;
+    }
 
     if (dev->hotplugged && !dc->hotpluggable) {
         error_setg(errp, "Device '%s' does not support hotplugging",
@@ -512,22 +527,33 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         return;
     }
 
-    if (value && !dev->realized) {
+    switch (value) {
+    case DEVICE_PHASE_INITIALIZED:
+        error_setg(errp, "A device cannot transition from another phase to initialized");
+        return;
+
+    case DEVICE_PHASE_REALIZING:
+        error_setg(errp, "The realizing phase cannot be set via property");
+        return;
+
+    case DEVICE_PHASE_REALIZED:
+       qatomic_set(&dev->phase, DEVICE_PHASE_REALIZING);
+
         if (!check_only_migratable(obj, errp)) {
             goto fail;
         }
 
         hotplug_ctrl = qdev_get_hotplug_handler(dev);
         if (hotplug_ctrl) {
-            hotplug_handler_pre_plug(hotplug_ctrl, dev, &local_err);
-            if (local_err != NULL) {
+            hotplug_handler_pre_plug(hotplug_ctrl, dev, errp);
+            if (*errp) {
                 goto fail;
             }
         }
 
         if (dc->realize) {
-            dc->realize(dev, &local_err);
-            if (local_err != NULL) {
+            dc->realize(dev, errp);
+            if (*errp) {
                 goto fail;
             }
         }
@@ -554,7 +580,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
                                                qdev_get_vmsd(dev), dev,
                                                dev->instance_id_alias,
                                                dev->alias_required_for_version,
-                                               &local_err) < 0) {
+                                               errp) < 0) {
                 goto post_realize_fail;
             }
         }
@@ -583,25 +609,30 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         dev->pending_deleted_event = false;
 
         if (hotplug_ctrl) {
-            hotplug_handler_plug(hotplug_ctrl, dev, &local_err);
-            if (local_err != NULL) {
+            hotplug_handler_plug(hotplug_ctrl, dev, errp);
+            if (*errp) {
                 goto child_realize_fail;
             }
        }
 
-       qatomic_store_release(&dev->realized, value);
-
-    } else if (!value && dev->realized) {
+       qatomic_store_release(&dev->phase, value);
+       return;
 
+    case DEVICE_PHASE_RETIRED:
         /*
          * Change the value so that any concurrent users are aware
-         * that the device is going to be unrealized
+         * that the device is going to be retired
          *
-         * TODO: change .realized property to enum that states
-         * each phase of the device realization/unrealization
+         * TODO: change .phase property to state
+         * each sub-phase of the device realization/unrealization
          */
 
-        qatomic_set(&dev->realized, value);
+        qatomic_set(&dev->phase, value);
+
+        if (old_value == DEVICE_PHASE_INITIALIZED) {
+            return;
+        }
+
         /*
          * Ensure that concurrent users see this update prior to
          * any other changes done by unrealize.
@@ -619,10 +650,11 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
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
@@ -641,7 +673,7 @@ post_realize_fail:
     }
 
 fail:
-    error_propagate(errp, local_err);
+    qatomic_store_release(&dev->phase, DEVICE_PHASE_RETIRED);
 }
 
 static bool device_get_hotpluggable(Object *obj, Error **errp)
@@ -670,7 +702,6 @@ static void device_initfn(Object *obj)
     }
 
     dev->instance_id_alias = -1;
-    dev->realized = false;
     dev->allow_unplug_during_migration = false;
 
     QLIST_INIT(&dev->gpios);
@@ -736,7 +767,7 @@ static void device_unparent(Object *obj)
     DeviceState *dev = DEVICE(obj);
     BusState *bus;
 
-    if (dev->realized) {
+    if (dev->phase == DEVICE_PHASE_REALIZED) {
         qdev_unrealize(dev);
     }
     while (dev->num_child_bus) {
@@ -768,7 +799,7 @@ static void device_class_init(ObjectClass *class, const void *data)
 
     /* by default all devices were considered as hotpluggable,
      * so with intent to check it in generic qdev_unplug() /
-     * device_set_realized() functions make every device
+     * device_set_phase() functions make every device
      * hotpluggable. Devices that shouldn't be hotpluggable,
      * should override it in their class_init()
      */
@@ -786,8 +817,9 @@ static void device_class_init(ObjectClass *class, const void *data)
      */
     dc->legacy_reset = NULL;
 
-    object_class_property_add_bool(class, "realized",
-                                   device_get_realized, device_set_realized);
+    object_class_property_add_enum(class, "phase", "DevicePhase",
+                                   &DevicePhase_lookup,
+                                   device_get_phase, device_set_phase);
     object_class_property_add_bool(class, "hotpluggable",
                                    device_get_hotpluggable, NULL);
     object_class_property_add_bool(class, "hotplugged",
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index dccb2f25b2af..3a83a8457527 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -57,8 +57,8 @@ static SCSIDevice *do_scsi_device_find(SCSIBus *bus,
     /*
      * This function might run on the IO thread and we might race against
      * main thread hot-plugging the device.
-     * We assume that as soon as .realized is set to true we can let
-     * the user access the device.
+     * We assume that as soon as the device is realized we can let
+     * the user access it.
      */
 
     if (retval && !include_unrealized && !qdev_is_realized(&retval->qdev)) {
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 48b38d2b7f73..5acbeac024e4 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -211,7 +211,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
 
         /* Skip Object and DeviceState properties */
         if (strcmp(prop->name, "type") == 0 ||
-            strcmp(prop->name, "realized") == 0 ||
+            strcmp(prop->name, "phase") == 0 ||
             strcmp(prop->name, "hotpluggable") == 0 ||
             strcmp(prop->name, "hotplugged") == 0 ||
             strcmp(prop->name, "parent_bus") == 0) {
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 00fed791cce1..8641f5f72dff 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -596,7 +596,7 @@ const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
 {
     ObjectProperty *prop;
 
-    assert(!dev->id && !dev->realized);
+    assert(!dev->id && dev->phase != DEVICE_PHASE_REALIZED);
 
     /*
      * object_property_[try_]add_child() below will assert the device
@@ -1078,7 +1078,8 @@ static int qdev_add_hotpluggable_device(Object *obj, void *opaque)
         return 0;
     }
 
-    if (dev->realized && object_property_get_bool(obj, "hotpluggable", NULL)) {
+    if (dev->phase == DEVICE_PHASE_REALIZED &&
+        object_property_get_bool(obj, "hotpluggable", NULL)) {
         *list = g_slist_append(*list, dev);
     }
 
diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
index 77c3eee71713..14935f4d3d9e 100644
--- a/tests/unit/test-qdev.c
+++ b/tests/unit/test-qdev.c
@@ -10,6 +10,8 @@ typedef struct MyDev MyDev;
 DECLARE_INSTANCE_CHECKER(MyDev, STATIC_TYPE,
                          TYPE_MY_DEV)
 
+#define TYPE_REENTRANT_REALIZATION "reentrant-realization"
+
 struct MyDev {
     DeviceState parent_obj;
 
@@ -17,6 +19,9 @@ struct MyDev {
     char *prop_string;
     uint32_t *prop_array_u32;
     uint32_t prop_array_u32_nb;
+    uint16_t realization_count;
+    uint16_t unrealization_count;
+    Error *realization_err;
 };
 
 static const Property my_dev_props[] = {
@@ -26,11 +31,25 @@ static const Property my_dev_props[] = {
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
 
@@ -41,6 +60,25 @@ static const TypeInfo my_dev_type_info = {
     .class_init = my_dev_class_init,
 };
 
+static void reentrant_realization_realize(DeviceState *dev, Error **errp)
+{
+    g_assert_false(qdev_realize(dev, NULL, NULL));
+}
+
+static void reentrant_realization_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = reentrant_realization_realize;
+}
+
+static const TypeInfo reentrant_realization_type_info = {
+    .name = TYPE_REENTRANT_REALIZATION,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(DeviceState),
+    .class_init = reentrant_realization_class_init,
+};
+
 /*
  * Initialize a fake machine, being prepared for future tests.
  *
@@ -82,8 +120,64 @@ static void test_qdev_double_realization(void)
 {
     MyDev *mt = STATIC_TYPE(object_new(TYPE_MY_DEV));
 
+    g_assert_cmpint(mt->realization_count, ==, 0);
     qdev_realize(DEVICE(mt), NULL, &error_fatal);
+    g_assert_cmpint(mt->realization_count, ==, 1);
+    qdev_realize(DEVICE(mt), NULL, &error_fatal);
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
+static void test_qdev_reentrant_realization(void)
+{
+    Object *obj = object_new(TYPE_REENTRANT_REALIZATION);
+
+    qdev_realize(DEVICE(obj), NULL, &error_fatal);
+    object_unparent(OBJECT(obj));
+    object_unref(obj);
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
     qdev_realize(DEVICE(mt), NULL, &error_fatal);
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
@@ -95,6 +189,7 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
     type_register_static(&my_dev_type_info);
+    type_register_static(&reentrant_realization_type_info);
     test_init_machine();
 
     g_test_add_func("/qdev/free-properties",
@@ -103,6 +198,21 @@ int main(int argc, char **argv)
     g_test_add_func("/qdev/double-realization",
                     test_qdev_double_realization);
 
+    g_test_add_func("/qdev/realize-after-unrealization",
+                    test_qdev_realize_after_unrealization);
+
+    g_test_add_func("/qdev/reentrant-realization",
+                    test_qdev_reentrant_realization);
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


