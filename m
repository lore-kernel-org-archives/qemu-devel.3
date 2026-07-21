Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71781C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5hE-0001c5-Dn; Tue, 21 Jul 2026 04:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm5h9-0001Fr-8V; Tue, 21 Jul 2026 04:19:19 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm5h5-0001Zj-Ny; Tue, 21 Jul 2026 04:19:18 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66L8GsBx050170
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 21 Jul 2026 17:17:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=fHYL5P1BOJ9TV/JCQGzQIxAFP6FUfhC05vOo19O9zcA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1784621857; v=1;
 b=BQvDy7O2SP31uLNa8PTieTvwzRWd1q+DQeDoAqwvPhhrO0sHfHue921tHtgExXkg
 W7pYKx0A6VW9zkgfXzwCGrKRvFSRrwFWH/iDSaax/8GKKmefLinqD4bwRL04/8y5
 WhNFCO2SPncDUQAZrdpvbAWEE3J8K9MH96/1ywv8bWDvzo4iwoNWnDqxe9aIIFSh
 SkT8HvsEObRwo/DR2LsNEfjbyceF8NE0mxECID3kI8tv3iygsBEgsJV57w2C4Bwp
 4YM8/tzIH7TC7UOpE0Kc+3EQ4EQXyvFFHMtodM8rVXfffkOLXiYr07cnX1TVEXBs
 8OwOFWZ6Jn5HHUsQWDe2WQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 21 Jul 2026 17:17:04 +0900
Subject: [PATCH for-11.2 v3 14/15] hw/qdev: Parent device before setting
 parent bus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-qdev-v3-14-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5472;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=QNg0Y4Mcg/1wVq3yfR6imXwr9ak2ks5bgpXU1rSTWws=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1a8tmSTa1510ZTGda3lDZf+LNZbVWKbMDczs2tpss4Hd
 wX7pzIdpSwMYlwMsmKKLClFu7k1oms/FSbEt8DMYWUCGcLAxSkAE2mZyvBXML7/++nIWysyLjgk
 cNQ4a3HxHO27c19kqRD3+sL/76q6GRnmZhT4/lqrf0LMRn1zd0RpwaUdG58xaHeXbYl8YVR4PpU
 LAA==
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

Commit 9940b2cfbc05 ("qdev: New qdev_new(), qdev_realize(), etc.") says
"device state 'no QOM parent, but plugged into bus' is dangerous". In
such a case, unrealizing the bus will hang in bus_unparent():

    while ((kid = QTAILQ_FIRST(&bus->children)) != NULL) {
        DeviceState *dev = kid->child;
        object_unparent(OBJECT(dev));
    }

object_unparent() does nothing when its argument has no QOM parent,
and the loop spins forever.

However, that commit did not completely eliminate such a situation.
When the device is not parented, device_set_realized() lets
/machine/unattached parent it, but it happens after setting parent bus.
Therefore, any failure between the two operations can leave the device
in a dangerous state.

qdev_realize() at least asserts that the device is not already realized
and prevents one realization failure pattern, but it is not
comprehensive. Besides, it will trip with a command line like the
following:

    qemu-system-x86_64 -M none -nodefaults -nographic \
        -device ipmi-bmc-sim,realized=on

Eliminate the dangerous state by ensuring that the device is parented
before calling qdev_set_parent_bus(). Also, stop asserting that the
device is not already realized in qdev_realize(); it is broken and
no longer serves any purpose.

Fixes: 9940b2cfbc05 ("qdev: New qdev_new(), qdev_realize(), etc.")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/core/qdev.c         | 51 ++++++++++++++++++++++++++++----------------------
 tests/unit/test-qdev.c | 13 +++++++++++++
 2 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index e2aab3d1fc61..0b0f2f47fa78 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -264,17 +264,43 @@ static void device_reset_child_foreach(Object *obj, ResettableChildCallback cb,
 
 bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
 {
-    assert(!dev->realized && !dev->parent_bus);
+    static int unattached_count;
+    bool unattached_parent = false;
+
+    assert(!dev->parent_bus);
+
+    if (!OBJECT(dev)->parent) {
+        gchar *name = g_strdup_printf("device[%d]", unattached_count++);
+
+        object_property_add_child(machine_get_container("unattached"),
+                                  name, OBJECT(dev));
+        unattached_parent = true;
+        g_free(name);
+    }
 
     if (bus) {
         if (!qdev_set_parent_bus(dev, bus, errp)) {
-            return false;
+            goto fail;
         }
     } else {
         assert(!DEVICE_GET_CLASS(dev)->bus_type);
     }
 
-    return object_property_set_bool(OBJECT(dev), "realized", true, errp);
+    if (object_property_set_bool(OBJECT(dev), "realized", true, errp)) {
+        return true;
+    }
+
+fail:
+    if (unattached_parent) {
+        /*
+         * Beware, this doesn't just revert
+         * object_property_add_child(), it also runs bus_remove()!
+         */
+        object_unparent(OBJECT(dev));
+        unattached_count--;
+    }
+
+    return false;
 }
 
 bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
@@ -479,8 +505,6 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
     BusState *bus;
     NamedClockList *ncl;
     Error *local_err = NULL;
-    bool unattached_parent = false;
-    static int unattached_count;
 
     if (dev->hotplugged && !dc->hotpluggable) {
         error_setg(errp, "Device '%s' does not support hotplugging",
@@ -493,15 +517,6 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             goto fail;
         }
 
-        if (!obj->parent) {
-            gchar *name = g_strdup_printf("device[%d]", unattached_count++);
-
-            object_property_add_child(machine_get_container("unattached"),
-                                      name, obj);
-            unattached_parent = true;
-            g_free(name);
-        }
-
         hotplug_ctrl = qdev_get_hotplug_handler(dev);
         if (hotplug_ctrl) {
             hotplug_handler_pre_plug(hotplug_ctrl, dev, &local_err);
@@ -627,14 +642,6 @@ post_realize_fail:
 
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
diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
index 20eae38e03f4..77c3eee71713 100644
--- a/tests/unit/test-qdev.c
+++ b/tests/unit/test-qdev.c
@@ -78,6 +78,16 @@ static void test_qdev_free_properties(void)
     object_unref(mt);
 }
 
+static void test_qdev_double_realization(void)
+{
+    MyDev *mt = STATIC_TYPE(object_new(TYPE_MY_DEV));
+
+    qdev_realize(DEVICE(mt), NULL, &error_fatal);
+    qdev_realize(DEVICE(mt), NULL, &error_fatal);
+    object_unparent(OBJECT(mt));
+    object_unref(OBJECT(mt));
+}
+
 
 int main(int argc, char **argv)
 {
@@ -90,6 +100,9 @@ int main(int argc, char **argv)
     g_test_add_func("/qdev/free-properties",
                     test_qdev_free_properties);
 
+    g_test_add_func("/qdev/double-realization",
+                    test_qdev_double_realization);
+
     g_test_run();
 
     return 0;

-- 
2.55.0


