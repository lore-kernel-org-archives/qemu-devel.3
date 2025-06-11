Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76606C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPNpW-000172-Tm; Wed, 11 Jun 2025 11:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uPNpT-00011B-SW; Wed, 11 Jun 2025 11:57:32 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uPNpS-0008Rv-1j; Wed, 11 Jun 2025 11:57:31 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bHVf3421Dz6GDnf;
 Wed, 11 Jun 2025 23:56:59 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 0D3561402F4;
 Wed, 11 Jun 2025 23:57:24 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 17:57:23 +0200
To: <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <dapeng1.mi@linux.intel.com>, <eric.auger@redhat.com>,
 <farman@linux.ibm.com>, <gustavo.romero@linaro.org>, <imammedo@redhat.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <maobibo@loongson.cn>, <mtosatti@redhat.com>,
 <peter.maydell@linaro.org>, <philmd@linaro.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <shameerali.kolothum.thodi@huawei.com>,
 <shannon.zhaosl@gmail.com>, <yangyicong@hisilicon.com>, <zhao1.liu@intel.com>
Subject: [PATCH v13 2/7] hw/core/machine: topology functions capabilities added
Date: Wed, 11 Jun 2025 16:56:13 +0100
Message-ID: <20250611155618.351-3-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611155618.351-1-alireza.sanaee@huawei.com>
References: <20250611155618.351-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 hw/core/machine-smp.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h   |  7 ++++++
 2 files changed, 59 insertions(+)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 0be0ac044c..a4d79e0aa4 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -406,3 +406,55 @@ bool machine_check_smp_cache(const MachineState *ms, Error **errp)
 
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
+bool machine_check_cache_at_topo_level(const MachineState *ms,
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
index f424b2b505..b24da305c4 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -55,6 +55,13 @@ void machine_set_cache_topo_level(MachineState *ms, CacheLevelAndType cache,
                                   CpuTopologyLevel level);
 bool machine_check_smp_cache(const MachineState *ms, Error **errp);
 void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
+bool machine_check_cache_at_topo_level(const MachineState *ms,
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


