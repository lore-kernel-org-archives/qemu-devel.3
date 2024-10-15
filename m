Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D5CCFC27F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0eNi-0008UA-6C; Tue, 15 Oct 2024 06:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0eNU-0008Em-TE; Tue, 15 Oct 2024 06:02:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0eNS-0000sG-S8; Tue, 15 Oct 2024 06:02:08 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSV2y5Z9Vz6FGxQ;
 Tue, 15 Oct 2024 18:00:26 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id D6A20140451;
 Tue, 15 Oct 2024 18:02:03 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.146.149) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 12:01:44 +0200
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <peterx@redhat.com>, <eric.auger@redhat.com>,
 <will@kernel.org>, <ardb@kernel.org>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <gshan@redhat.com>, <rafael@kernel.org>,
 <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>, <npiggin@gmail.com>,
 <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH RFC V5 03/30] hw/arm/virt: Move setting of common vCPU
 properties in a function
Date: Tue, 15 Oct 2024 10:59:45 +0100
Message-ID: <20241015100012.254223-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015100012.254223-1-salil.mehta@huawei.com>
References: <20241015100012.254223-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.146.149]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Factor out vCPU properties code common for {hot,cold}-plugged vCPUs in the
machvirt_init(). This allows code reuse.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c         | 219 ++++++++++++++++++++++++++----------------
 include/hw/arm/virt.h |   4 +
 2 files changed, 139 insertions(+), 84 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 827a796ed6..a64d028ec4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2091,16 +2091,129 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
     }
 }
 
+static void virt_cpu_set_properties(Object *cpuobj, const CPUArchId *cpu_slot,
+                                    Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    VirtMachineState *vms = VIRT_MACHINE(ms);
+    Error *local_err = NULL;
+    VirtMachineClass *vmc;
+
+    vmc = VIRT_MACHINE_GET_CLASS(ms);
+
+    /* now, set the cpu object property values */
+    numa_cpu_pre_plug(cpu_slot, DEVICE(cpuobj), &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    object_property_set_int(cpuobj, "mp-affinity", cpu_slot->arch_id, NULL);
+
+    if (!vms->secure) {
+        object_property_set_bool(cpuobj, "has_el3", false, NULL);
+    }
+
+    if (!vms->virt && object_property_find(cpuobj, "has_el2")) {
+        object_property_set_bool(cpuobj, "has_el2", false, NULL);
+    }
+
+    if (vmc->kvm_no_adjvtime &&
+        object_property_find(cpuobj, "kvm-no-adjvtime")) {
+        object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
+    }
+
+    if (vmc->no_kvm_steal_time &&
+        object_property_find(cpuobj, "kvm-steal-time")) {
+        object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
+    }
+
+    if (vmc->no_pmu && object_property_find(cpuobj, "pmu")) {
+        object_property_set_bool(cpuobj, "pmu", false, NULL);
+    }
+
+    if (vmc->no_tcg_lpa2 && object_property_find(cpuobj, "lpa2")) {
+        object_property_set_bool(cpuobj, "lpa2", false, NULL);
+    }
+
+    if (object_property_find(cpuobj, "reset-cbar")) {
+        object_property_set_int(cpuobj, "reset-cbar",
+                                vms->memmap[VIRT_CPUPERIPHS].base,
+                                &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
+
+    /* link already initialized {secure,tag}-memory regions to this cpu */
+    object_property_set_link(cpuobj, "memory", OBJECT(vms->sysmem), &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    if (vms->secure) {
+        object_property_set_link(cpuobj, "secure-memory",
+                                 OBJECT(vms->secure_sysmem), &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
+
+    if (vms->mte) {
+        if (!object_property_find(cpuobj, "tag-memory")) {
+            error_setg(&local_err, "MTE requested, but not supported "
+                       "by the guest CPU");
+            if (local_err) {
+                goto out;
+            }
+        }
+
+        object_property_set_link(cpuobj, "tag-memory", OBJECT(vms->tag_sysmem),
+                                 &local_err);
+        if (local_err) {
+            goto out;
+        }
+
+        if (vms->secure) {
+            object_property_set_link(cpuobj, "secure-tag-memory",
+                                     OBJECT(vms->secure_tag_sysmem),
+                                     &local_err);
+            if (local_err) {
+                goto out;
+            }
+        }
+    }
+
+    /*
+     * RFC: Question: this must only be called for the hotplugged cpus. For the
+     * cold booted secondary cpus this is being taken care in arm_load_kernel()
+     * in boot.c. Perhaps we should remove that code now?
+     */
+    if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
+        object_property_set_int(cpuobj, "psci-conduit", vms->psci_conduit,
+                                NULL);
+
+        /* Secondary CPUs start in PSCI powered-down state */
+        if (CPU(cpuobj)->cpu_index > 0) {
+            object_property_set_bool(cpuobj, "start-powered-off", true, NULL);
+        }
+    }
+
+out:
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *possible_cpus;
-    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *secure_tag_sysmem = NULL;
     MemoryRegion *secure_sysmem = NULL;
     MemoryRegion *tag_sysmem = NULL;
-    MemoryRegion *secure_tag_sysmem = NULL;
+    MemoryRegion *sysmem;
     int n, virt_max_cpus;
     bool firmware_loaded;
     bool aarch64 = true;
@@ -2175,6 +2288,8 @@ static void machvirt_init(MachineState *machine)
     /* uses smp.max_cpus to initialize all possible vCPUs */
     possible_cpus = mc->possible_cpu_arch_ids(machine);
 
+    sysmem = vms->sysmem = get_system_memory();
+
     if (vms->secure) {
         /*
          * The Secure view of the world is the same as the NonSecure,
@@ -2182,7 +2297,7 @@ static void machvirt_init(MachineState *machine)
          * containing the system memory at low priority; any secure-only
          * devices go in at higher priority and take precedence.
          */
-        secure_sysmem = g_new(MemoryRegion, 1);
+        secure_sysmem = vms->secure_sysmem = g_new(MemoryRegion, 1);
         memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
                            UINT64_MAX);
         memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
@@ -2230,6 +2345,23 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
+    if (vms->mte) {
+        /* Create the memory region only once, but link to all cpus later */
+        tag_sysmem = vms->tag_sysmem = g_new(MemoryRegion, 1);
+        memory_region_init(tag_sysmem, OBJECT(machine),
+                           "tag-memory", UINT64_MAX / 32);
+
+        if (vms->secure) {
+            secure_tag_sysmem = vms->secure_tag_sysmem = g_new(MemoryRegion, 1);
+            memory_region_init(secure_tag_sysmem, OBJECT(machine),
+                               "secure-tag-memory", UINT64_MAX / 32);
+
+            /* As with ram, secure-tag takes precedence over tag.  */
+            memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
+                                                tag_sysmem, -1);
+        }
+    }
+
     create_fdt(vms);
 
     assert(possible_cpus->len == max_cpus);
@@ -2242,15 +2374,10 @@ static void machvirt_init(MachineState *machine)
         }
 
         cpuobj = object_new(possible_cpus->cpus[n].type);
-        object_property_set_int(cpuobj, "mp-affinity",
-                                possible_cpus->cpus[n].arch_id, NULL);
 
         cs = CPU(cpuobj);
         cs->cpu_index = n;
 
-        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
-                          &error_fatal);
-
         aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
         object_property_set_int(cpuobj, "socket-id",
                                 virt_get_socket_id(machine, n), NULL);
@@ -2261,82 +2388,6 @@ static void machvirt_init(MachineState *machine)
         object_property_set_int(cpuobj, "thread-id",
                                 virt_get_thread_id(machine, n), NULL);
 
-        if (!vms->secure) {
-            object_property_set_bool(cpuobj, "has_el3", false, NULL);
-        }
-
-        if (!vms->virt && object_property_find(cpuobj, "has_el2")) {
-            object_property_set_bool(cpuobj, "has_el2", false, NULL);
-        }
-
-        if (vmc->kvm_no_adjvtime &&
-            object_property_find(cpuobj, "kvm-no-adjvtime")) {
-            object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
-        }
-
-        if (vmc->no_kvm_steal_time &&
-            object_property_find(cpuobj, "kvm-steal-time")) {
-            object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
-        }
-
-        if (vmc->no_pmu && object_property_find(cpuobj, "pmu")) {
-            object_property_set_bool(cpuobj, "pmu", false, NULL);
-        }
-
-        if (vmc->no_tcg_lpa2 && object_property_find(cpuobj, "lpa2")) {
-            object_property_set_bool(cpuobj, "lpa2", false, NULL);
-        }
-
-        if (object_property_find(cpuobj, "reset-cbar")) {
-            object_property_set_int(cpuobj, "reset-cbar",
-                                    vms->memmap[VIRT_CPUPERIPHS].base,
-                                    &error_abort);
-        }
-
-        object_property_set_link(cpuobj, "memory", OBJECT(sysmem),
-                                 &error_abort);
-        if (vms->secure) {
-            object_property_set_link(cpuobj, "secure-memory",
-                                     OBJECT(secure_sysmem), &error_abort);
-        }
-
-        if (vms->mte) {
-            /* Create the memory region only once, but link to all cpus. */
-            if (!tag_sysmem) {
-                /*
-                 * The property exists only if MemTag is supported.
-                 * If it is, we must allocate the ram to back that up.
-                 */
-                if (!object_property_find(cpuobj, "tag-memory")) {
-                    error_report("MTE requested, but not supported "
-                                 "by the guest CPU");
-                    exit(1);
-                }
-
-                tag_sysmem = g_new(MemoryRegion, 1);
-                memory_region_init(tag_sysmem, OBJECT(machine),
-                                   "tag-memory", UINT64_MAX / 32);
-
-                if (vms->secure) {
-                    secure_tag_sysmem = g_new(MemoryRegion, 1);
-                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
-                                       "secure-tag-memory", UINT64_MAX / 32);
-
-                    /* As with ram, secure-tag takes precedence over tag.  */
-                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
-                                                        tag_sysmem, -1);
-                }
-            }
-
-            object_property_set_link(cpuobj, "tag-memory", OBJECT(tag_sysmem),
-                                     &error_abort);
-            if (vms->secure) {
-                object_property_set_link(cpuobj, "secure-tag-memory",
-                                         OBJECT(secure_tag_sysmem),
-                                         &error_abort);
-            }
-        }
-
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
         object_unref(cpuobj);
     }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index db3e2aebb9..5300e8d2bc 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -143,6 +143,10 @@ struct VirtMachineState {
     DeviceState *platform_bus_dev;
     FWCfgState *fw_cfg;
     PFlashCFI01 *flash[2];
+    MemoryRegion *sysmem;
+    MemoryRegion *secure_sysmem;
+    MemoryRegion *tag_sysmem;
+    MemoryRegion *secure_tag_sysmem;
     bool secure;
     bool highmem;
     bool highmem_compact;
-- 
2.34.1


