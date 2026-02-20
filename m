Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1DBC531FB
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 14:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtRFR-0002Tp-Ha; Fri, 20 Feb 2026 09:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vtRFQ-0002Px-GV; Fri, 20 Feb 2026 09:12:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vtRFO-0006ET-Ja; Fri, 20 Feb 2026 09:12:47 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fHXHw5ZfjzHnH6Y;
 Fri, 20 Feb 2026 22:12:12 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id E9BFA40571;
 Fri, 20 Feb 2026 22:12:44 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.73.243) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Feb 2026 14:12:36 +0000
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <dapeng1.mi@linux.intel.com>, <eric.auger@redhat.com>,
 <farman@linux.ibm.com>, <gustavo.romero@linaro.org>, <imammedo@redhat.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <maobibo@loongson.cn>, <mtosatti@redhat.com>,
 <peter.maydell@linaro.org>, <philmd@linaro.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <shannon.zhaosl@gmail.com>,
 <zhao1.liu@intel.com>
Subject: [PATCH v18 2/8] hw/core/machine: topology functions capabilities added
Date: Fri, 20 Feb 2026 14:11:21 +0000
Message-ID: <20260220141128.789-3-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260220141128.789-1-alireza.sanaee@huawei.com>
References: <20260220141128.789-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.73.243]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add two functions one of which finds the lowest cache level defined in
the cache description input, and the other checks if a given cache
topology is defined at a particular cache level

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/core/machine-smp.c    | 52 ++++++++++++++++++++++++++++++++++++++++
 include/hw/core/boards.h |  5 ++++
 2 files changed, 57 insertions(+)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 189c70015f..bef04aa2d7 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -406,3 +406,55 @@ bool machine_check_smp_cache(const MachineState *ms, Error **errp)
 
     return true;
 }
+
+/*
+ * This function assumes L3 and L2 have unified cache and L1 is split L1d and
+ * L1i.
+ */
+bool machine_find_lowest_level_cache_at_topo_level(const MachineState *ms,
+                                                   int *lowest_cache_level,
+                                                   CpuTopologyLevel topo_level)
+{
+    enum CacheLevelAndType cache_level;
+    enum CpuTopologyLevel t;
+
+    for (cache_level = CACHE_LEVEL_AND_TYPE_L1D;
+         cache_level < CACHE_LEVEL_AND_TYPE__MAX; cache_level++) {
+        t = machine_get_cache_topo_level(ms, cache_level);
+        if (t == topo_level) {
+            /* Assume L1 is split into L1d and L1i caches. */
+            if (cache_level == CACHE_LEVEL_AND_TYPE_L1D ||
+                cache_level == CACHE_LEVEL_AND_TYPE_L1I) {
+                *lowest_cache_level = 1; /* L1 */
+            } else {
+                /* Assume the other caches are unified. */
+                *lowest_cache_level = cache_level;
+            }
+
+            return true;
+        }
+    }
+
+    return false;
+}
+
+/*
+ * Check if there are caches defined at a particular level. It supports only
+ * L1, L2 and L3 caches, but this can be extended to more levels as needed.
+ *
+ * Return True on success, False otherwise.
+ */
+bool machine_defines_cache_at_topo_level(const MachineState *ms,
+                                         CpuTopologyLevel topology)
+{
+    enum CacheLevelAndType cache_level;
+
+    for (cache_level = CACHE_LEVEL_AND_TYPE_L1D;
+         cache_level < CACHE_LEVEL_AND_TYPE__MAX; cache_level++) {
+        if (machine_get_cache_topo_level(ms, cache_level) == topology) {
+            return true;
+        }
+    }
+
+    return false;
+}
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index edbe8d03e5..af5fd9f3cd 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -60,6 +60,11 @@ void machine_set_cache_topo_level(MachineState *ms, CacheLevelAndType cache,
                                   CpuTopologyLevel level);
 bool machine_check_smp_cache(const MachineState *ms, Error **errp);
 void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
+bool machine_defines_cache_at_topo_level(const MachineState *ms,
+                                         CpuTopologyLevel level);
+bool machine_find_lowest_level_cache_at_topo_level(const MachineState *ms,
+                                                   int *level_found,
+                                                   CpuTopologyLevel topo_level);
 
 /**
  * machine_class_allow_dynamic_sysbus_dev: Add type to list of valid devices
-- 
2.43.0


