Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5D5C83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 12:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYksX-0003Dl-6t; Mon, 07 Jul 2025 08:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uYkpl-0002Dr-2v; Mon, 07 Jul 2025 08:20:38 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uYkpf-0002DL-L7; Mon, 07 Jul 2025 08:20:32 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bbNbD0NxVz6GBQr;
 Mon,  7 Jul 2025 20:19:36 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 27EBA140433;
 Mon,  7 Jul 2025 20:20:18 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.45.147.207) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Jul 2025 14:20:16 +0200
To: <qemu-devel@nongnu.org>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <dapeng1.mi@linux.intel.com>, <eric.auger@redhat.com>,
 <farman@linux.ibm.com>, <gustavo.romero@linaro.org>, <imammedo@redhat.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <maobibo@loongson.cn>, <mst@redhat.com>,
 <mtosatti@redhat.com>, <peter.maydell@linaro.org>, <philmd@linaro.org>,
 <qemu-arm@nongnu.org>, <richard.henderson@linaro.org>,
 <shameerali.kolothum.thodi@huawei.com>, <shannon.zhaosl@gmail.com>,
 <yangyicong@hisilicon.com>, <zhao1.liu@intel.com>
Subject: [PATCH v14 2/7] hw/core/machine: topology functions capabilities added
Date: Mon, 7 Jul 2025 13:19:03 +0100
Message-ID: <20250707121908.155-3-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707121908.155-1-alireza.sanaee@huawei.com>
References: <20250707121908.155-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.45.147.207]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add two functions one of which finds the lowest level cache defined in
the cache description input, and the other checks if caches are defined
at a particular level.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/core/machine-smp.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h   |  7 +++++
 2 files changed, 66 insertions(+)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 0be0ac044c..4baf4a878e 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -406,3 +406,62 @@ bool machine_check_smp_cache(const MachineState *ms, Error **errp)
 
     return true;
 }
+
+/*
+ * This function assumes l3 and l2 have unified cache and l1 is split l1d
+ * and l1i, and further prepares the lowest cache level for a topology
+ * level.  The info will be fed to build_caches to create caches at the
+ * right level.
+ */
+bool machine_find_lowest_level_cache_at_topo_level(const MachineState *ms,
+                                                   int *level_found,
+                                                   CpuTopologyLevel topo_level)
+{
+
+    CpuTopologyLevel level;
+
+    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I);
+    if (level == topo_level) {
+        *level_found = 1;
+        return true;
+    }
+
+    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D);
+    if (level == topo_level) {
+        *level_found = 1;
+        return true;
+    }
+
+    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2);
+    if (level == topo_level) {
+        *level_found = 2;
+        return true;
+    }
+
+    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3);
+    if (level == topo_level) {
+        *level_found = 3;
+        return true;
+    }
+
+    return false;
+}
+
+/*
+ * Check if there are caches defined at a particular level.  Currently, we
+ * support only L1, L2 and L3 caches, but this can be extended to more levels
+ * as needed.
+ *
+ * Return True on success, False otherwise.
+ */
+bool machine_defines_cache_at_topo_level(const MachineState *ms,
+                                       CpuTopologyLevel level)
+{
+    if (machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3) == level ||
+        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2) == level ||
+        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I) == level ||
+        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D) == level) {
+        return true;
+    }
+    return false;
+}
diff --git a/include/hw/boards.h b/include/hw/boards.h
index f424b2b505..1713be992a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -55,6 +55,13 @@ void machine_set_cache_topo_level(MachineState *ms, CacheLevelAndType cache,
                                   CpuTopologyLevel level);
 bool machine_check_smp_cache(const MachineState *ms, Error **errp);
 void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
+bool machine_defines_cache_at_topo_level(const MachineState *ms,
+                                       CpuTopologyLevel level);
+
+bool machine_find_lowest_level_cache_at_topo_level(const MachineState *ms,
+                                                   int *level_found,
+                                                   CpuTopologyLevel topo_level);
+
 
 /**
  * machine_class_allow_dynamic_sysbus_dev: Add type to list of valid devices
-- 
2.43.0


