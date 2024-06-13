Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD203C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 23:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHu1T-00053x-JM; Thu, 13 Jun 2024 19:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sHu1R-00053Q-4Y; Thu, 13 Jun 2024 19:38:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sHu1P-0002y6-2S; Thu, 13 Jun 2024 19:38:24 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0f2F27fMz67kr9;
 Fri, 14 Jun 2024 07:36:53 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
 by mail.maildlp.com (Postfix) with ESMTPS id B9FA7140594;
 Fri, 14 Jun 2024 07:38:16 +0800 (CST)
Received: from 00293818-MRGF.china.huawei.com (10.195.245.24) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 00:37:54 +0100
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
Subject: [PATCH RFC V3 01/29] arm/virt, target/arm: Add new ARMCPU {socket,
 cluster, core, thread}-id property
Date: Fri, 14 Jun 2024 00:36:11 +0100
Message-ID: <20240613233639.202896-2-salil.mehta@huawei.com>
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

This shall be used to store user specified topology{socket,cluster,core,thread}
and shall be converted to a unique 'vcpu-id' which is used as slot-index during
hot(un)plug of vCPU.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c         | 10 ++++++++++
 include/hw/arm/virt.h | 28 ++++++++++++++++++++++++++++
 target/arm/cpu.c      |  4 ++++
 target/arm/cpu.h      |  4 ++++
 4 files changed, 46 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3c93c0c0a6..11fc7fc318 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2215,6 +2215,14 @@ static void machvirt_init(MachineState *machine)
                           &error_fatal);
 
         aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
+        object_property_set_int(cpuobj, "socket-id",
+                                virt_get_socket_id(machine, n), NULL);
+        object_property_set_int(cpuobj, "cluster-id",
+                                virt_get_cluster_id(machine, n), NULL);
+        object_property_set_int(cpuobj, "core-id",
+                                virt_get_core_id(machine, n), NULL);
+        object_property_set_int(cpuobj, "thread-id",
+                                virt_get_thread_id(machine, n), NULL);
 
         if (!vms->secure) {
             object_property_set_bool(cpuobj, "has_el3", false, NULL);
@@ -2708,6 +2716,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
 {
     int n;
     unsigned int max_cpus = ms->smp.max_cpus;
+    unsigned int smp_threads = ms->smp.threads;
     VirtMachineState *vms = VIRT_MACHINE(ms);
     MachineClass *mc = MACHINE_GET_CLASS(vms);
 
@@ -2721,6 +2730,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     ms->possible_cpus->len = max_cpus;
     for (n = 0; n < ms->possible_cpus->len; n++) {
         ms->possible_cpus->cpus[n].type = ms->cpu_type;
+        ms->possible_cpus->cpus[n].vcpus_count = smp_threads;
         ms->possible_cpus->cpus[n].arch_id =
             virt_cpu_mp_affinity(vms, n);
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index bb486d36b1..6f9a7bb60b 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -209,4 +209,32 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
             vms->highmem_redists) ? 2 : 1;
 }
 
+static inline int virt_get_socket_id(const MachineState *ms, int cpu_index)
+{
+    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
+
+    return ms->possible_cpus->cpus[cpu_index].props.socket_id;
+}
+
+static inline int virt_get_cluster_id(const MachineState *ms, int cpu_index)
+{
+    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
+
+    return ms->possible_cpus->cpus[cpu_index].props.cluster_id;
+}
+
+static inline int virt_get_core_id(const MachineState *ms, int cpu_index)
+{
+    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
+
+    return ms->possible_cpus->cpus[cpu_index].props.core_id;
+}
+
+static inline int virt_get_thread_id(const MachineState *ms, int cpu_index)
+{
+    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
+
+    return ms->possible_cpus->cpus[cpu_index].props.thread_id;
+}
+
 #endif /* QEMU_ARM_VIRT_H */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 77f8c9c748..abc4ed0842 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2582,6 +2582,10 @@ static Property arm_cpu_properties[] = {
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
+    DEFINE_PROP_INT32("socket-id", ARMCPU, socket_id, 0),
+    DEFINE_PROP_INT32("cluster-id", ARMCPU, cluster_id, 0),
+    DEFINE_PROP_INT32("core-id", ARMCPU, core_id, 0),
+    DEFINE_PROP_INT32("thread-id", ARMCPU, thread_id, 0),
     DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
     /* True to default to the backward-compat old CNTFRQ rather than 1Ghz */
     DEFINE_PROP_BOOL("backcompat-cntfrq", ARMCPU, backcompat_cntfrq, false),
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c17264c239..208c719db3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1076,6 +1076,10 @@ struct ArchCPU {
     QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
 
     int32_t node_id; /* NUMA node this CPU belongs to */
+    int32_t socket_id;
+    int32_t cluster_id;
+    int32_t core_id;
+    int32_t thread_id;
 
     /* Used to synchronize KVM and QEMU in-kernel device levels */
     uint8_t device_irq_level;
-- 
2.34.1


