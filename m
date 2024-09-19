Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337BECDD569
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr69F-0005ca-39; Wed, 18 Sep 2024 21:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr69D-0005XQ-58; Wed, 18 Sep 2024 21:39:55 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr69B-0004rv-HH; Wed, 18 Sep 2024 21:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726709994; x=1758245994;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=boVKc/SUSgKzZVCNXF6Ki7YN9fmGZ9ZYevKMMyl1qEI=;
 b=VR0iIhFKWVq1dePxu5em0PIfawiQ09WLyy4QYoTHikd4i5peoxif2Eeg
 sJwhj2OkSQkbPu4HB2IoyfWLn9YixogBV1OT0vJoQXjom8I4Pxl67u0oL
 shHsgSnyqA/ZsPinsq37MKvW2esiCgerkqqgZPwQDFUySWWKvmj5woqtT
 UXSC50E2YZYuvNq/LZ9ODozC6o9JBTK8gEp853yuhsT8oJkiPPF/y+xMm
 D7tLAqATmDrzU/jahZLSs+O2RpXgONab2NBFMZCFiFemVlr16ihjV6hKn
 lQXy8aN2TGkNLEbyQlxz6F0JLSlTB/JtoGILJN+eiZ9jwcFvPB462k4hH w==;
X-CSE-ConnectionGUID: Z1ENhFAsSd2ZU8DFqSpHKw==
X-CSE-MsgGUID: FHX5Y8AoR1OhZKPGLbr0Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25797804"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25797804"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 18:39:51 -0700
X-CSE-ConnectionGUID: j2QDLduuRda1guYfMEBzhA==
X-CSE-MsgGUID: g9MJhIXaQNWqXtJKo1PT6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70058475"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 18 Sep 2024 18:39:45 -0700
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
Subject: [RFC v2 01/15] qdev: Add pointer to BusChild in DeviceState
Date: Thu, 19 Sep 2024 09:55:19 +0800
Message-Id: <20240919015533.766754-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919015533.766754-1-zhao1.liu@intel.com>
References: <20240919015533.766754-1-zhao1.liu@intel.com>
MIME-Version: 1.0
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

The device topology structures based on buses are unidirectional: the
parent device can access the child device through the BusChild within
the bus, but not vice versa.

For the CPU topology tree constructed on the device-bus, it is necessary
for the child device to be able to access the parent device via the
parent bus. To address this, introduce a pointer to the BusChild, named
bus_node.

This pointer also simplifies the logic of bus_remove_child(). Instead of
the parent bus needing to traverse the children list to locate the
corresponding BusChild, it can now directly find it using the bus_node
pointer.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/qdev.c          | 29 ++++++++++++++---------------
 include/hw/qdev-core.h  |  4 ++++
 include/qemu/typedefs.h |  1 +
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index db36f54d914a..4429856eaddd 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -57,25 +57,23 @@ static void bus_free_bus_child(BusChild *kid)
 
 static void bus_remove_child(BusState *bus, DeviceState *child)
 {
-    BusChild *kid;
-
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        if (kid->child == child) {
-            char name[32];
+    BusChild *kid = child->bus_node;
+    char name[32];
 
-            snprintf(name, sizeof(name), "child[%d]", kid->index);
-            QTAILQ_REMOVE_RCU(&bus->children, kid, sibling);
+    if (!kid) {
+        return;
+    }
 
-            bus->num_children--;
+    snprintf(name, sizeof(name), "child[%d]", kid->index);
+    QTAILQ_REMOVE_RCU(&bus->children, kid, sibling);
+    child->bus_node = NULL;
+    bus->num_children--;
 
-            /* This gives back ownership of kid->child back to us.  */
-            object_property_del(OBJECT(bus), name);
+    /* This gives back ownership of kid->child back to us.  */
+    object_property_del(OBJECT(bus), name);
 
-            /* free the bus kid, when it is safe to do so*/
-            call_rcu(kid, bus_free_bus_child, rcu);
-            break;
-        }
-    }
+    /* free the bus kid, when it is safe to do so*/
+    call_rcu(kid, bus_free_bus_child, rcu);
 }
 
 static void bus_add_child(BusState *bus, DeviceState *child)
@@ -86,6 +84,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
     bus->num_children++;
     kid->index = bus->max_index++;
     kid->child = child;
+    child->bus_node = kid;
     object_ref(OBJECT(kid->child));
 
     QTAILQ_INSERT_HEAD_RCU(&bus->children, kid, sibling);
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index aa97c34a4be7..85c7d462dfba 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -253,6 +253,10 @@ struct DeviceState {
      * @parent_bus: bus this device belongs to
      */
     BusState *parent_bus;
+    /**
+     * @bus_node: bus node inserted in parent bus
+     */
+    BusChild *bus_node;
     /**
      * @gpios: QLIST of named GPIOs the device provides.
      */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 9d222dc37628..aef41c4e67ce 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -32,6 +32,7 @@ typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
 typedef struct BlockBackend BlockBackend;
 typedef struct BlockBackendRootState BlockBackendRootState;
 typedef struct BlockDriverState BlockDriverState;
+typedef struct BusChild BusChild;
 typedef struct BusClass BusClass;
 typedef struct BusState BusState;
 typedef struct Chardev Chardev;
-- 
2.34.1


