Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E20CDD566
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr69N-00064U-47; Wed, 18 Sep 2024 21:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr69K-0005x4-4H; Wed, 18 Sep 2024 21:40:02 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr69I-0004sM-3g; Wed, 18 Sep 2024 21:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726710000; x=1758246000;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GTUQ019BfwQpkrJFj+VNn+W9sPDXxvfUxmbaNbsBlZw=;
 b=C0jJCw9WKbkHzOASivXqT+4eZm5sqekIhSPUVBI5Y+K2BfJ+Cb3yCJVl
 RWF3zxV+segrfSa9Aqf2ahQ6K9+dmgMlkYDsqazdSAKZOEcjlKJ6Es7tE
 M21BudHHUIZpmfmwRJ0ICFTG/TmxcXtJO6cVwOQnFXRJzOVm+7pxXCF6M
 p8Pg0QqUgYjCi1h0Zr6S3vwCKePGe8DX7ZFYaTRnzVw51lOrgVmCbr6ds
 77L4hEwBELzU/OmwRyZJj8j27tiQLgL7T5NHvqg3/7ezBLpQ8qg6yQN5X
 VKDFEe+VRuyF913azQXoUEmuILa3soB4Ecmo0WVpEFUnMLciam/VS2g2i A==;
X-CSE-ConnectionGUID: 3FakcqtQQ+Ou7Jw6wTgq0w==
X-CSE-MsgGUID: K/yh6/ktRDK8Px3mTrwsAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25797823"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25797823"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 18:39:58 -0700
X-CSE-ConnectionGUID: I3knkL/jSee7aLywlolMUQ==
X-CSE-MsgGUID: yWAY1M6kTXWufBZ8mK+FLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70058495"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 18 Sep 2024 18:39:52 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 02/15] qdev: Add the interface to reparent the device
Date: Thu, 19 Sep 2024 09:55:20 +0800
Message-Id: <20240919015533.766754-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919015533.766754-1-zhao1.liu@intel.com>
References: <20240919015533.766754-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

User created devices may need to adjust their default object parent or
parent bus.

User created devices are QOM parented to one of the peripheral
containers ("/peripheral" or "/peripheral-anon") in qdev_set_id() by
default. Sometimes, it is necessary to reparent a device to another
object to express the more accurate child<> relationship, as in the
cases of the PnvPHBRootPort device or subsequent topology devices.

The current pnv_phb_user_get_parent() implements such reparenting logic.
To allow it to be used by topology devices as well, transform it into a
generic qdev interface with custom device id ("default_id" parameter).

And add the code to handle the failure of object_property_add_child().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/qdev.c         | 52 +++++++++++++++++++++++++++++++++++++
 hw/pci-host/pnv_phb.c  | 59 +++++++++---------------------------------
 include/hw/qdev-core.h |  3 +++
 3 files changed, 67 insertions(+), 47 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 4429856eaddd..ff073cbff56d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -143,6 +143,58 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp)
     return true;
 }
 
+/*
+ * Set the QOM parent and parent bus of an object child. If the device
+ * state associated with the child has an id, use it as QOM id.
+ * Otherwise use default_id as QOM id.
+ *
+ * This helper does both operations at the same time because setting
+ * a new QOM child will erase the bus parent of the device. This happens
+ * because object_unparent() will call object_property_del_child(),
+ * which in turn calls the property release callback prop->release if
+ * it's defined. In our case this callback is set to
+ * object_finalize_child_property(), which was assigned during the
+ * first object_property_add_child() call. This callback will end up
+ * calling device_unparent(), and this function removes the device
+ * from its parent bus.
+ *
+ * The QOM and parent bus to be set aren't necessarily related, so
+ * let's receive both as arguments.
+ */
+bool qdev_set_parent(DeviceState *dev, BusState *bus, Object *parent,
+                     char *default_id, Error **errp)
+{
+    Object *child = OBJECT(dev);
+    ObjectProperty *prop;
+
+    if (!dev->id && !default_id) {
+        error_setg(errp, "unknown device id");
+        return false;
+    }
+
+    if (child->parent == parent) {
+        return true;
+    }
+
+    object_ref(child);
+    object_unparent(child);
+    prop =  object_property_add_child(parent,
+                                      dev->id ? dev->id : default_id,
+                                      child);
+    object_unref(child);
+
+    if (!prop) {
+        error_setg(errp, "couldn't change parent");
+        return false;
+    }
+
+    if (!qdev_set_parent_bus(dev, bus, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
 DeviceState *qdev_new(const char *name)
 {
     ObjectClass *oc = object_class_by_name(name);
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index d4c118d44362..a26e7b7aec5c 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -19,49 +19,6 @@
 #include "qom/object.h"
 #include "sysemu/sysemu.h"
 
-
-/*
- * Set the QOM parent and parent bus of an object child. If the device
- * state associated with the child has an id, use it as QOM id.
- * Otherwise use object_typename[index] as QOM id.
- *
- * This helper does both operations at the same time because setting
- * a new QOM child will erase the bus parent of the device. This happens
- * because object_unparent() will call object_property_del_child(),
- * which in turn calls the property release callback prop->release if
- * it's defined. In our case this callback is set to
- * object_finalize_child_property(), which was assigned during the
- * first object_property_add_child() call. This callback will end up
- * calling device_unparent(), and this function removes the device
- * from its parent bus.
- *
- * The QOM and parent bus to be set aren´t necessarily related, so
- * let's receive both as arguments.
- */
-static bool pnv_parent_fixup(Object *parent, BusState *parent_bus,
-                             Object *child, int index,
-                             Error **errp)
-{
-    g_autofree char *default_id =
-        g_strdup_printf("%s[%d]", object_get_typename(child), index);
-    const char *dev_id = DEVICE(child)->id;
-
-    if (child->parent == parent) {
-        return true;
-    }
-
-    object_ref(child);
-    object_unparent(child);
-    object_property_add_child(parent, dev_id ? dev_id : default_id, child);
-    object_unref(child);
-
-    if (!qdev_set_parent_bus(DEVICE(child), parent_bus, errp)) {
-        return false;
-    }
-
-    return true;
-}
-
 static Object *pnv_phb_user_get_parent(PnvChip *chip, PnvPHB *phb, Error **errp)
 {
     if (phb->version == 3) {
@@ -82,6 +39,7 @@ static bool pnv_phb_user_device_init(PnvPHB *phb, Error **errp)
     PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
     PnvChip *chip = pnv_get_chip(pnv, phb->chip_id);
     Object *parent = NULL;
+    g_autofree char *default_id = NULL;
 
     if (!chip) {
         error_setg(errp, "invalid chip id: %d", phb->chip_id);
@@ -98,8 +56,11 @@ static bool pnv_phb_user_device_init(PnvPHB *phb, Error **errp)
      * correctly the device tree. pnv_xscom_dt() needs every
      * PHB to be a child of the chip to build the DT correctly.
      */
-    if (!pnv_parent_fixup(parent, qdev_get_parent_bus(DEVICE(chip)),
-                          OBJECT(phb), phb->phb_id, errp)) {
+    default_id = g_strdup_printf("%s[%d]",
+                                 object_get_typename(OBJECT(phb)),
+                                 phb->phb_id);
+    if (!qdev_set_parent(DEVICE(phb), qdev_get_parent_bus(DEVICE(chip)),
+                         parent, default_id, errp)) {
         return false;
     }
 
@@ -246,6 +207,7 @@ static void pnv_phb_root_port_realize(DeviceState *dev, Error **errp)
     uint16_t device_id = 0;
     Error *local_err = NULL;
     int chip_id, index;
+    g_autofree char *default_id = NULL;
 
     /*
      * 'index' will be used both as a PCIE slot value and to calculate
@@ -273,8 +235,11 @@ static void pnv_phb_root_port_realize(DeviceState *dev, Error **errp)
      * parent bus. Change the QOM parent to be the same as the
      * parent bus it's already assigned to.
      */
-    if (!pnv_parent_fixup(OBJECT(bus), BUS(bus), OBJECT(dev),
-                          index, errp)) {
+    default_id = g_strdup_printf("%s[%d]",
+                                 object_get_typename(OBJECT(dev)),
+                                 index);
+    if (!qdev_set_parent(dev, BUS(bus), OBJECT(bus),
+                         default_id, errp)) {
         return;
     }
 
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 85c7d462dfba..7cbc5fb97298 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -1011,6 +1011,9 @@ char *qdev_get_human_name(DeviceState *dev);
 /* FIXME: make this a link<> */
 bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
 
+bool qdev_set_parent(DeviceState *dev, BusState *bus, Object *parent,
+                     char *default_id, Error **errp);
+
 extern bool qdev_hot_removed;
 
 char *qdev_get_dev_path(DeviceState *dev);
-- 
2.34.1


