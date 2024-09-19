Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25020CDD569
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr69j-0007OM-3r; Wed, 18 Sep 2024 21:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr69f-00075p-RY; Wed, 18 Sep 2024 21:40:24 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr69d-0004sM-0M; Wed, 18 Sep 2024 21:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726710021; x=1758246021;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=573w2DHmYSHZ5HLG8xM/Ws3MSekemg/qhlyIWizCQb0=;
 b=k89lWRCUwm+9dH3RLxrLPrP0k4+RvNnRCTSt2oTw826HwLnAEr8m3K7c
 hL2tRI++Ysx1Xpgtz8gnBP0tyAmi4NdeSNqj0R95d/afxYP7fTZl3z1Rm
 qITLEskfCj9OcOYLRvY1EzzdJtVAGr6oI8G9yxv+rt8/IHtsEkZqofE6G
 nt+J4qMd5C44IYtfglNP4rSTKvcW0FQ2E6ewe5obDgaZVj88b5DIby+8n
 yAU56Pn1/JFtw8ihUhxIXzIqs5fG5mFu41DAJ/t1lNy3gjYLBhJv1oPZz
 sUYquDAz9ZxUycVKpfAOMU2eFwLDFZNLBcbBCBtJojL6axVzEAsqBAaaz A==;
X-CSE-ConnectionGUID: rBlcq/lUT62CwOLPTV1Q+g==
X-CSE-MsgGUID: 7Mx2LXU0TsaCe21LUGTSmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25797873"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25797873"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 18:40:18 -0700
X-CSE-ConnectionGUID: VTAf9j9wSdmPPMQUWsdetg==
X-CSE-MsgGUID: O69kmvrZS0GmljFMm/GWdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70058690"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 18 Sep 2024 18:40:12 -0700
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
Subject: [RFC v2 05/15] qdev: Add method in BusClass to customize device index
Date: Thu, 19 Sep 2024 09:55:23 +0800
Message-Id: <20240919015533.766754-6-zhao1.liu@intel.com>
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

Currently, when the bus assigns an index to a child device, it relies on
a monotonically increasing max_index.

However, when a device is removed from the bus, its index is not
reassigned to new devices, leading to "holes" in child indices.

For topology devices, such as CPUs/cores, arches define custom
sub-topology IDs. Some of these IDs are global (e.g., core-id for core
devices), while others are local (e.g., thread-id/core-id/module-id for
x86 CPUs).

Local IDs are indexes under the same parent device and align with
BusChild's index meaning. Therefore, local IDs in a topology context
should use BusChild.index.

Considering that topology devices support hot-plug and local IDs often
have range constraints, add a new method (BusClass.assign_free_index) to
allow the bus to customize index assignment.

Based on this method, the CPU bus will search for free index "holes"
created by unplugging and assign these free indices to newly inserted
devices.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/qdev.c                |  8 +++++++-
 hw/cpu/cpu-topology.c         | 37 +++++++++++++++++++++++++++++++++++
 include/hw/cpu/cpu-topology.h |  1 +
 include/hw/qdev-core.h        |  2 ++
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index ff073cbff56d..e3e9f0f303d6 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -78,11 +78,17 @@ static void bus_remove_child(BusState *bus, DeviceState *child)
 
 static void bus_add_child(BusState *bus, DeviceState *child)
 {
+    BusClass *bc = BUS_GET_CLASS(bus);
     char name[32];
     BusChild *kid = g_malloc0(sizeof(*kid));
 
+    if (bc->assign_free_index) {
+        kid->index = bc->assign_free_index(bus);
+    } else {
+        kid->index = bus->max_index++;
+    }
+
     bus->num_children++;
-    kid->index = bus->max_index++;
     kid->child = child;
     child->bus_node = kid;
     object_ref(OBJECT(kid->child));
diff --git a/hw/cpu/cpu-topology.c b/hw/cpu/cpu-topology.c
index e68c06132e7d..3e8982ff7e6c 100644
--- a/hw/cpu/cpu-topology.c
+++ b/hw/cpu/cpu-topology.c
@@ -49,11 +49,40 @@ static bool cpu_bus_check_address(BusState *bus, DeviceState *dev,
     return cpu_parent_check_topology(bus->parent, dev, errp);
 }
 
+static int cpu_bus_assign_free_index(BusState *bus)
+{
+    BusChild *kid;
+    int index;
+
+    if (bus->num_children == bus->max_index) {
+        return bus->max_index++;
+    }
+
+    assert(bus->num_children < bus->max_index);
+    /* TODO: Introduce the list sorted by index */
+    for (index = 0; index < bus->num_children; index++) {
+        bool existed = false;
+
+        QTAILQ_FOREACH(kid, &bus->children, sibling) {
+            if (kid->index == index) {
+                existed = true;
+                break;
+            }
+        }
+
+        if (!existed) {
+            break;
+        }
+    }
+    return index;
+}
+
 static void cpu_bus_class_init(ObjectClass *oc, void *data)
 {
     BusClass *bc = BUS_CLASS(oc);
 
     bc->check_address = cpu_bus_check_address;
+    bc->assign_free_index = cpu_bus_assign_free_index;
 }
 
 static const TypeInfo cpu_bus_type_info = {
@@ -177,3 +206,11 @@ int cpu_topo_get_instances_num(CPUTopoState *topo)
 
     return bus ? bus->num_children : 1;
 }
+
+int cpu_topo_get_index(CPUTopoState *topo)
+{
+    BusChild *node = DEVICE(topo)->bus_node;
+
+    assert(node);
+    return node->index;
+}
diff --git a/include/hw/cpu/cpu-topology.h b/include/hw/cpu/cpu-topology.h
index 7a447ad16ee7..80aeff18baa3 100644
--- a/include/hw/cpu/cpu-topology.h
+++ b/include/hw/cpu/cpu-topology.h
@@ -64,5 +64,6 @@ struct CPUTopoState {
 #define GET_CPU_TOPO_LEVEL(topo)    (CPU_TOPO_GET_CLASS(topo)->level)
 
 int cpu_topo_get_instances_num(CPUTopoState *topo);
+int cpu_topo_get_index(CPUTopoState *topo);
 
 #endif /* CPU_TOPO_H */
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 7cbc5fb97298..77223b28c788 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -342,6 +342,8 @@ struct BusClass {
      */
     bool (*check_address)(BusState *bus, DeviceState *dev, Error **errp);
 
+    int (*assign_free_index)(BusState *bus);
+
     BusRealize realize;
     BusUnrealize unrealize;
 
-- 
2.34.1


