Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE7FD11101
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 15:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7cSk-0000z0-0v; Sun, 03 Nov 2024 10:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t7cSh-0000yg-St; Sun, 03 Nov 2024 10:24:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t7cSe-00024Q-Vv; Sun, 03 Nov 2024 10:24:19 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XhJGl2gXYz67Kdt;
 Sun,  3 Nov 2024 23:21:35 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 57A99140B67;
 Sun,  3 Nov 2024 23:24:13 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.146.9) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 16:23:55 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <richard.henderson@linaro.org>, <peter.maydell@linaro.org>
CC: <salil.mehta@huawei.com>, <jonathan.cameron@huawei.com>,
 <alex.bennee@linaro.org>, <imammedo@redhat.com>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <maz@kernel.org>, <will@kernel.org>,
 <oliver.upton@linux.dev>, <jean-philippe@linaro.org>,
 <lpieralisi@kernel.org>, <david@redhat.com>, <philmd@linaro.org>,
 <andrew.jones@linux.dev>, <eric.auger@redhat.com>, <npiggin@gmail.com>,
 <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH] hw/arm/virt: Move common vCPU properties in a function
Date: Sun, 3 Nov 2024 15:22:56 +0000
Message-ID: <20241103152256.202444-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.146.9]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Refactor vCPU properties code from the `machvirt_init()` main loop with
the following goals:

1. Enable code reuse in future patch sets.
2. Improve code readability.
3. Separate out the one-time initialization of (secure-)Tagged memory,
   handling potential failures early.

Note: This is a cosmetic change only; *no* functional changes are
      intended here.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c         | 238 +++++++++++++++++++++++++-----------------
 include/hw/arm/virt.h |   4 +
 2 files changed, 147 insertions(+), 95 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1a381e9a2b..a0d3bef875 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2091,16 +2091,126 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
     }
 }
 
+static void virt_cpu_set_properties(Object *cpuobj, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    VirtMachineState *vms = VIRT_MACHINE(ms);
+    const CPUArchIdList *possible_cpus;
+    Error *local_err = NULL;
+    VirtMachineClass *vmc;
+
+    vmc = VIRT_MACHINE_GET_CLASS(ms);
+
+    possible_cpus = mc->possible_cpu_arch_ids(ms);
+    object_property_set_int(cpuobj, "mp-affinity",
+                            possible_cpus->cpus[CPU(cpuobj)->cpu_index].arch_id,
+                            NULL);
+
+    numa_cpu_pre_plug(&possible_cpus->cpus[CPU(cpuobj)->cpu_index],
+                      DEVICE(cpuobj), &local_err);
+    if (local_err) {
+        goto out;
+    }
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
+        if (tcg_enabled()) {
+            /*
+             * The property exists only if MemTag is supported.
+             * If it is, we must allocate the ram to back that up.
+             */
+            if (!object_property_find(cpuobj, "tag-memory")) {
+                error_report("MTE requested, but not supported "
+                             "by the guest CPU");
+                exit(1);
+            }
+
+            object_property_set_link(cpuobj, "tag-memory",
+                                     OBJECT(vms->tag_sysmem), &local_err);
+            if (local_err) {
+                goto out;
+            }
+
+            if (vms->secure) {
+                object_property_set_link(cpuobj, "secure-tag-memory",
+                                         OBJECT(vms->secure_tag_sysmem),
+                                         &local_err);
+                if (local_err) {
+                    goto out;
+                }
+            }
+        } else if (kvm_enabled()) {
+            kvm_arm_enable_mte(cpuobj, &local_err);
+            if (local_err) {
+                goto out;
+            }
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
@@ -2140,6 +2250,8 @@ static void machvirt_init(MachineState *machine)
      */
     finalize_gic_version(vms);
 
+    sysmem = vms->sysmem = get_system_memory();
+
     if (vms->secure) {
         /*
          * The Secure view of the world is the same as the NonSecure,
@@ -2147,7 +2259,7 @@ static void machvirt_init(MachineState *machine)
          * containing the system memory at low priority; any secure-only
          * devices go in at higher priority and take precedence.
          */
-        secure_sysmem = g_new(MemoryRegion, 1);
+        secure_sysmem = vms->secure_sysmem = g_new(MemoryRegion, 1);
         memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
                            UINT64_MAX);
         memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
@@ -2220,6 +2332,33 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
+    if (vms->mte && !kvm_enabled() && !tcg_enabled()) {
+        error_report("MTE requested, but not supported ");
+        exit(1);
+    }
+
+    if (vms->mte && kvm_enabled() && !kvm_arm_mte_supported()) {
+        error_report("MTE requested, but not supported by KVM");
+        exit(1);
+    }
+
+    if (vms->mte && tcg_enabled()) {
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
@@ -2232,104 +2371,13 @@ static void machvirt_init(MachineState *machine)
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
-            if (tcg_enabled()) {
-                /* Create the memory region only once, but link to all cpus. */
-                if (!tag_sysmem) {
-                    /*
-                     * The property exists only if MemTag is supported.
-                     * If it is, we must allocate the ram to back that up.
-                     */
-                    if (!object_property_find(cpuobj, "tag-memory")) {
-                        error_report("MTE requested, but not supported "
-                                     "by the guest CPU");
-                        exit(1);
-                    }
-
-                    tag_sysmem = g_new(MemoryRegion, 1);
-                    memory_region_init(tag_sysmem, OBJECT(machine),
-                                       "tag-memory", UINT64_MAX / 32);
-
-                    if (vms->secure) {
-                        secure_tag_sysmem = g_new(MemoryRegion, 1);
-                        memory_region_init(secure_tag_sysmem, OBJECT(machine),
-                                           "secure-tag-memory",
-                                           UINT64_MAX / 32);
-
-                        /* As with ram, secure-tag takes precedence over tag. */
-                        memory_region_add_subregion_overlap(secure_tag_sysmem,
-                                                            0, tag_sysmem, -1);
-                    }
-                }
-
-                object_property_set_link(cpuobj, "tag-memory",
-                                         OBJECT(tag_sysmem), &error_abort);
-                if (vms->secure) {
-                    object_property_set_link(cpuobj, "secure-tag-memory",
-                                             OBJECT(secure_tag_sysmem),
-                                             &error_abort);
-                }
-            } else if (kvm_enabled()) {
-                if (!kvm_arm_mte_supported()) {
-                    error_report("MTE requested, but not supported by KVM");
-                    exit(1);
-                }
-                kvm_arm_enable_mte(cpuobj, &error_abort);
-            } else {
-                    error_report("MTE requested, but not supported ");
-                    exit(1);
-            }
-        }
+        virt_cpu_set_properties(cpuobj, &error_abort);
 
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
         object_unref(cpuobj);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index aca4f8061b..239f3678af 100644
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


