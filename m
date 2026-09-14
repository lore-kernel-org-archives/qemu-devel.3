Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C27C88E66
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x634q-0000pW-KL; Mon, 14 Sep 2026 05:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x634T-0000hz-MH; Mon, 14 Sep 2026 05:33:55 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x634M-0000S3-U7; Mon, 14 Sep 2026 05:33:51 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68E9WXEX020350
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 14 Sep 2026 18:32:38 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=pNDWp1wjDVxMJm/uJywo6dRmA13XDrmoXUjAwLN19uU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789378359; v=1;
 b=KS/3EtfE9+kWhN+Ty6lLnn3hJdJa5pDtFe4S9ONW797jTVED2UnkHtnmm97rgC6m
 L7ko4Fi9gphWLUbkeDeTwyXSYDrpHiHckNq7ALvA/GwYRYR5wK/uMtW+aHxdBedo
 FdpV5tc8yvClYN3Gi226/sOLqUkwbZsEAR3qLDxqo467NKt2AJMfA0SVa826oFkw
 cp8HSy+GInbNonZurw2VVKhnJY2xFfU2/plZqTIwkvYvyhHU+M3YsPf1JsV+DnsM
 5zFrhZFsbsnt3RZPDc3X2AdAj2BAT7JU7mP/Y42/+gqKAbkmSOjWRU0T1mpaA2Cq
 bWaPSksrEQSs8URC3vFnXg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 14 Sep 2026 18:31:50 +0900
Subject: [PATCH v4 2/4] hw/qdev: Introduce DevicePhase
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-qdev-v4-2-93f849b4865c@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12149;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=sovqxL/01FU2H2HTkQTqy4GMeDyj8MX23w6O2PdfADA=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9by/XpGq95pChkvzj3I3W0WtDXiv8mmzH1cO/kTu1tZp
 vPmuG7uKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmMgBe4Z/+idr30ywanRRrLQW
 X3Pwt8/1VPcVrncrVKt9mT8nTjx0gOF/Uo3DwfoOvUV7zyzb/SyyhWnf8zvPMg2mLVaqmeCU42X
 DDgA=
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

Replace the bool DeviceState::realized field with the enum-valued
DeviceState::phase field to express finer phases in following changes.

The QOM realized property is an internal lifecycle property, not for
end users. Replace it with the enum-valued phase property.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 qapi/common.json          | 14 ++++++++++++++
 include/hw/core/qdev.h    |  7 ++++---
 hw/core/qdev-clock.c      |  4 ++--
 hw/core/qdev-properties.c |  4 ++--
 hw/core/qdev.c            | 45 +++++++++++++++++++++++----------------------
 hw/scsi/scsi-bus.c        |  4 ++--
 qom/qom-qmp-cmds.c        |  2 +-
 system/qdev-monitor.c     |  5 +++--
 8 files changed, 51 insertions(+), 34 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index af7e3d618a7c..415a2722fc1a 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -7,6 +7,20 @@
 # *****************
 ##
 
+##
+# @DevicePhase:
+#
+# An enumeration of the device phases
+#
+# @unrealized: the initial phase
+#
+# @realized: the phase after realization
+#
+# Since: 11.2
+##
+{ 'enum': 'DevicePhase',
+  'data': [ 'unrealized', 'realized' ] }
+
 ##
 # @IoOperationType:
 #
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index b1c5f4780a90..ff367b2a5f98 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -1,6 +1,7 @@
 #ifndef QDEV_CORE_H
 #define QDEV_CORE_H
 
+#include "qapi/qapi-types-common.h"
 #include "qemu/atomic.h"
 #include "qemu/queue.h"
 #include "qemu/bitmap.h"
@@ -232,9 +233,9 @@ struct DeviceState {
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
@@ -440,7 +441,7 @@ DeviceState *qdev_try_new(const char *name);
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
index 0b0f2f47fa78..3623fbf69e78 100644
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
+    object_property_set_str(OBJECT(dev), "phase", "unrealized", &error_abort);
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
@@ -497,7 +497,7 @@ static bool check_only_migratable(Object *obj, Error **errp)
     return true;
 }
 
-static void device_set_realized(Object *obj, bool value, Error **errp)
+static void device_set_phase(Object *obj, int value, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
@@ -512,15 +512,15 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         return;
     }
 
-    if (value && !dev->realized) {
+    if (value == DEVICE_PHASE_REALIZED && dev->phase != DEVICE_PHASE_REALIZED) {
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
@@ -589,19 +589,19 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             }
        }
 
-       qatomic_store_release(&dev->realized, value);
-
-    } else if (!value && dev->realized) {
+       qatomic_store_release(&dev->phase, value);
 
+    } else if (value != DEVICE_PHASE_REALIZED &&
+               dev->phase == DEVICE_PHASE_REALIZED) {
         /*
          * Change the value so that any concurrent users are aware
          * that the device is going to be unrealized
          *
-         * TODO: change .realized property to enum that states
-         * each phase of the device realization/unrealization
+         * TODO: change .phase property to state
+         * each sub-phase of the device realization/unrealization
          */
 
-        qatomic_set(&dev->realized, value);
+        qatomic_set(&dev->phase, value);
         /*
          * Ensure that concurrent users see this update prior to
          * any other changes done by unrealize.
@@ -670,7 +670,7 @@ static void device_initfn(Object *obj)
     }
 
     dev->instance_id_alias = -1;
-    dev->realized = false;
+    dev->phase = DEVICE_PHASE_UNREALIZED;
     dev->allow_unplug_during_migration = false;
 
     QLIST_INIT(&dev->gpios);
@@ -736,7 +736,7 @@ static void device_unparent(Object *obj)
     DeviceState *dev = DEVICE(obj);
     BusState *bus;
 
-    if (dev->realized) {
+    if (dev->phase == DEVICE_PHASE_REALIZED) {
         qdev_unrealize(dev);
     }
     while (dev->num_child_bus) {
@@ -768,7 +768,7 @@ static void device_class_init(ObjectClass *class, const void *data)
 
     /* by default all devices were considered as hotpluggable,
      * so with intent to check it in generic qdev_unplug() /
-     * device_set_realized() functions make every device
+     * device_set_phase() functions make every device
      * hotpluggable. Devices that shouldn't be hotpluggable,
      * should override it in their class_init()
      */
@@ -786,8 +786,9 @@ static void device_class_init(ObjectClass *class, const void *data)
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
index aa02ff631b71..612f272deb2a 100644
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
index 330895361d47..4d2db574144a 100644
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
index 5c87fda50939..586c9aaac9c3 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -596,7 +596,7 @@ const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
 {
     ObjectProperty *prop;
 
-    assert(!dev->id && !dev->realized);
+    assert(!dev->id && dev->phase != DEVICE_PHASE_REALIZED);
 
     /*
      * object_property_[try_]add_child() below will assert the device
@@ -1083,7 +1083,8 @@ static int qdev_add_hotpluggable_device(Object *obj, void *opaque)
         return 0;
     }
 
-    if (dev->realized && object_property_get_bool(obj, "hotpluggable", NULL)) {
+    if (dev->phase == DEVICE_PHASE_REALIZED &&
+        object_property_get_bool(obj, "hotpluggable", NULL)) {
         *list = g_slist_append(*list, dev);
     }
 

-- 
2.55.0


