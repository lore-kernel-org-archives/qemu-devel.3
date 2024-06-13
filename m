Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C641C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 23:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHu1s-0005CS-6n; Thu, 13 Jun 2024 19:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sHu1l-00057j-97; Thu, 13 Jun 2024 19:38:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sHu1h-0002zT-No; Thu, 13 Jun 2024 19:38:44 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0f4D540Wz6K6Bt;
 Fri, 14 Jun 2024 07:38:36 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
 by mail.maildlp.com (Postfix) with ESMTPS id 8C601140594;
 Fri, 14 Jun 2024 07:38:39 +0800 (CST)
Received: from 00293818-MRGF.china.huawei.com (10.195.245.24) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 00:38:17 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <rafael@kernel.org>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>
Subject: [PATCH RFC V3 02/29] cpu-common: Add common CPU utility for possible
 vCPUs
Date: Fri, 14 Jun 2024 00:36:12 +0100
Message-ID: <20240613233639.202896-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613233639.202896-1-salil.mehta@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.195.245.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch adds various utility functions that may be required to fetch or check
the state of possible vCPUs. It also introduces the concept of *disabled* vCPUs,
which are part of the *possible* vCPUs but are not enabled. This state will be
used during machine initialization and later during the plugging or unplugging
of vCPUs. We release the QOM CPU objects for all disabled vCPUs.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 cpu-common.c          | 31 +++++++++++++++++++++++++
 include/hw/core/cpu.h | 54 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/cpu-common.c b/cpu-common.c
index ce78273af5..49d2a50835 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -24,6 +24,7 @@
 #include "sysemu/cpus.h"
 #include "qemu/lockable.h"
 #include "trace/trace-root.h"
+#include "hw/boards.h"
 
 QemuMutex qemu_cpu_list_lock;
 static QemuCond exclusive_cond;
@@ -107,6 +108,36 @@ void cpu_list_remove(CPUState *cpu)
     cpu_list_generation_id++;
 }
 
+CPUState *qemu_get_possible_cpu(int index)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const CPUArchIdList *possible_cpus = ms->possible_cpus;
+
+    assert((index >= 0) && (index < possible_cpus->len));
+
+    return CPU(possible_cpus->cpus[index].cpu);
+}
+
+bool qemu_present_cpu(CPUState *cpu)
+{
+    return cpu;
+}
+
+bool qemu_enabled_cpu(CPUState *cpu)
+{
+    return cpu && !cpu->disabled;
+}
+
+uint64_t qemu_get_cpu_archid(int cpu_index)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const CPUArchIdList *possible_cpus = ms->possible_cpus;
+
+    assert((cpu_index >= 0) && (cpu_index < possible_cpus->len));
+
+    return possible_cpus->cpus[cpu_index].arch_id;
+}
+
 CPUState *qemu_get_cpu(int index)
 {
     CPUState *cpu;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 60b160d0b4..60b4778da9 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -528,6 +528,18 @@ struct CPUState {
     CPUPluginState *plugin_state;
 #endif
 
+    /*
+     * Some architectures do not allow the *presence* of vCPUs to be changed
+     * after the guest has booted, based on information specified by the
+     * VMM/firmware via ACPI MADT at boot time. Thus, to enable vCPU hotplug on
+     * these architectures, possible vCPUs can have a CPUState object in a
+     * 'disabled' state or may not have a CPUState object at all. This is
+     * possible when vCPU hotplug is supported, and vCPUs are
+     * 'yet-to-be-plugged' in the QOM or have been hot-unplugged. By default,
+     * every CPUState is enabled across all architectures.
+     */
+    bool disabled;
+
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
     int cluster_index;
@@ -914,6 +926,48 @@ static inline bool cpu_in_exclusive_context(const CPUState *cpu)
  */
 CPUState *qemu_get_cpu(int index);
 
+/**
+ * qemu_get_possible_cpu:
+ * @index: The CPUState@cpu_index value of the CPU to obtain.
+ *         Input index MUST be in range [0, Max Possible CPUs)
+ *
+ * If CPUState object exists,then it gets a CPU matching
+ * @index in the possible CPU array.
+ *
+ * Returns: The possible CPU or %NULL if CPU does not exist.
+ */
+CPUState *qemu_get_possible_cpu(int index);
+
+/**
+ * qemu_present_cpu:
+ * @cpu: The vCPU to check
+ *
+ * Checks if the vCPU is amongst the present possible vcpus.
+ *
+ * Returns: True if it is present possible vCPU else false
+ */
+bool qemu_present_cpu(CPUState *cpu);
+
+/**
+ * qemu_enabled_cpu:
+ * @cpu: The vCPU to check
+ *
+ * Checks if the vCPU is enabled.
+ *
+ * Returns: True if it is 'enabled' else false
+ */
+bool qemu_enabled_cpu(CPUState *cpu);
+
+/**
+ * qemu_get_cpu_archid:
+ * @cpu_index: possible vCPU for which arch-id needs to be retreived
+ *
+ * Fetches the vCPU arch-id from the present possible vCPUs.
+ *
+ * Returns: arch-id of the possible vCPU
+ */
+uint64_t qemu_get_cpu_archid(int cpu_index);
+
 /**
  * cpu_exists:
  * @id: Guest-exposed CPU ID to lookup.
-- 
2.34.1


