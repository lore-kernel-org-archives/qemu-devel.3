Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8E4CFC281
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0eOW-0001FW-95; Tue, 15 Oct 2024 06:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0eO9-0000kW-66; Tue, 15 Oct 2024 06:02:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0eO6-0000wm-WB; Tue, 15 Oct 2024 06:02:48 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSV3k5NW4z6FGmc;
 Tue, 15 Oct 2024 18:01:06 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id E3F2D1404F9;
 Tue, 15 Oct 2024 18:02:43 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.146.149) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 12:02:24 +0200
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
Subject: [PATCH RFC V5 05/30] arm/virt,
 kvm: Pre-create KVM vCPUs for all unplugged QOM vCPUs @machine init
Date: Tue, 15 Oct 2024 10:59:47 +0100
Message-ID: <20241015100012.254223-6-salil.mehta@huawei.com>
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

ARM CPU architecture does not allows CPU to be plugged after system has
initialized. This is an constraint. Hence, Kernel must know all the CPUs being
booted during its initialization. This applies to the Guest Kernel as well and
therefore, number of KVM vCPUs need to be fixed at the VM initialization time.

Also, The GIC must know all the CPUs it is connected to during its
initialization, and this cannot change afterward. This must also be ensured
during the initialization of the VGIC in KVM. This is necessary because:

1. The association between GICR and MPIDR must be fixed at VM initialization
   time. This is represented by the register `GICR_TYPER(mp_affinity, proc_num)`
2. Memory regions associated with GICR, etc., cannot be changed (added, deleted,
   or modified) after the VM has been initialized. This is not an ARM
   architectural constraint but rather invites a difficult and messy change in
   VGIC data structures.

This patch adds support to pre-create all possible vCPUs within the KVM host
as part of the virtual machine initialization. These vCPUs can later be unparked
and attached to the hotplugged QOM vCPU.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reported-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
[VP: Identified CPU stall issue & suggested probable fix]
---
 hw/arm/virt.c         | 74 ++++++++++++++++++++++++++++++++++++++-----
 include/hw/core/cpu.h |  1 +
 target/arm/cpu64.c    |  9 ++++++
 target/arm/kvm.c      | 41 +++++++++++++++++++++++-
 target/arm/kvm_arm.h  | 10 ++++++
 5 files changed, 126 insertions(+), 9 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 48102d5a4c..858a19bc8b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2366,17 +2366,12 @@ static void machvirt_init(MachineState *machine)
 
     assert(possible_cpus->len == max_cpus);
     for (n = 0; n < possible_cpus->len; n++) {
+        CPUArchId *cpu_slot;
         Object *cpuobj;
         CPUState *cs;
 
-        if (n >= smp_cpus) {
-            break;
-        }
-
         cpuobj = object_new(possible_cpus->cpus[n].type);
-
         cs = CPU(cpuobj);
-        cs->cpu_index = n;
 
         aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
         object_property_set_int(cpuobj, "socket-id",
@@ -2388,8 +2383,61 @@ static void machvirt_init(MachineState *machine)
         object_property_set_int(cpuobj, "thread-id",
                                 virt_get_thread_id(machine, n), NULL);
 
-        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
-        object_unref(cpuobj);
+        if (n < smp_cpus) {
+            qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
+            object_unref(cpuobj);
+        } else {
+            /*
+             * Handling vCPUs that are yet to be hot-plugged requires the
+             * unrealized `ARMCPU` object for the following purposes:
+             *
+             * 1. To create the corresponding host KVM vCPU.
+             * 2. During the GICv3 realization phase, the `GICR_TYPER` value is
+             *    derived using the fetched MPIDR/mp-affinity. It's worth
+             *    considering modifying the GICv3 realization code to directly
+             *    fetch the `arch-id`/mp-affinity from the possible vCPUs.
+             * 3. Additionally, the `ARMCPU` object must be retained until
+             *    `virt_cpu_post_init`, as there may be late per-vCPU
+             *    initializations.
+             *
+             * Once these tasks are completed, the initialized `ARMCPU` object
+             * can be safely released as those are not required and will be
+             * recreated when they are {hot,cold}-plugged later.
+             */
+            cs->cpu_index = n;
+            cpu_slot = virt_find_cpu_slot(cs);
+
+            /*
+             * We will pre-create the KVM vCPUs corresponding to the currently
+             * unplugged but possible QOM vCPUs and park them until they are
+             * actually hot-plugged. The ARM architecture does not allow new
+             * CPUs to be plugged after the system has been initialized, and
+             * this constraint is also reflected in KVM.
+             */
+            if (kvm_enabled()) {
+                kvm_arm_create_host_vcpu(ARM_CPU(cs));
+                /*
+                 * Override the default architecture ID with the one fetched
+                 * from KVM. After initialization, we will destroy the CPUState
+                 * for disabled vCPUs; however, the CPU slot and its association
+                 * with the architecture ID (and consequently the vCPU ID) will
+                 * remain fixed for the entire lifetime of QEMU.
+                 */
+                cpu_slot->arch_id = arm_cpu_mp_affinity(ARM_CPU(cs));
+            }
+
+           /*
+            * GICv3 realization will need `mp-affinity` to derive `gicr_typer`
+            */
+            object_property_set_int(cpuobj, "mp-affinity", cpu_slot->arch_id,
+                                    NULL);
+
+            /*
+             * Add the unplugged vCPU to the vCPU slot temporarily. It will be
+             * released later in the virt_post_init_cpu() function
+             */
+            cpu_slot->cpu = cs;
+        }
     }
 
     /* Now we've created the CPUs we can see if they have the hypvirt timer */
@@ -2992,6 +3040,16 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     /* insert the cold/hot-plugged vcpu in the slot */
     cpu_slot = virt_find_cpu_slot(cs);
     cpu_slot->cpu = CPU(dev);
+
+    if (kvm_enabled()) {
+        /*
+         * Override the default architecture ID with the one fetched from KVM
+         * Currently, KVM derives the architecture ID from the vCPU ID specified
+         * by QEMU. In the future, we might implement a change where the entire
+         * architecture ID can be configured directly by QEMU.
+         */
+        cpu_slot->arch_id = arm_cpu_mp_affinity(ARM_CPU(cs));
+    }
 }
 
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 299e96c45b..4e0cb325a0 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -534,6 +534,7 @@ struct CPUState {
     uint64_t dirty_pages;
     int kvm_vcpu_stats_fd;
     bool vcpu_dirty;
+    VMChangeStateEntry *vmcse;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0e217f827e..d2f4624d61 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -791,6 +791,14 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
     }
 }
 
+static void aarch64_cpu_initfn(Object *obj)
+{
+    CPUState *cs = CPU(obj);
+
+    /* TODO: re-check if this is necessary still */
+    cs->thread_id = 0;
+}
+
 static void aarch64_cpu_finalizefn(Object *obj)
 {
 }
@@ -850,6 +858,7 @@ void aarch64_cpu_register(const ARMCPUInfo *info)
 static const TypeInfo aarch64_cpu_type_info = {
     .name = TYPE_AARCH64_CPU,
     .parent = TYPE_ARM_CPU,
+    .instance_init = aarch64_cpu_initfn,
     .instance_finalize = aarch64_cpu_finalizefn,
     .abstract = true,
     .class_init = aarch64_cpu_class_init,
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f1f1b5b375..e82cb2aa8b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1003,6 +1003,38 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
     write_list_to_cpustate(cpu);
 }
 
+void kvm_arm_create_host_vcpu(ARMCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    unsigned long vcpu_id = cs->cpu_index;
+    int ret;
+
+    ret = kvm_create_vcpu(cs);
+    if (ret < 0) {
+        error_report("Failed to create host vcpu %ld", vcpu_id);
+        abort();
+    }
+
+    /*
+     * Initialize the vCPU in the host. This will reset the sys regs
+     * for this vCPU and related registers like MPIDR_EL1 etc. also
+     * gets programmed during this call to host. These are referred
+     * later while setting device attributes of the GICR during GICv3
+     * reset
+     */
+    ret = kvm_arch_init_vcpu(cs);
+    if (ret < 0) {
+        error_report("Failed to initialize host vcpu %ld", vcpu_id);
+        abort();
+    }
+
+    /*
+     * park the created vCPU. shall be used during kvm_get_vcpu() when
+     * threads are created during realization of ARM vCPUs.
+     */
+    kvm_park_vcpu(cs);
+}
+
 /*
  * Update KVM's MP_STATE based on what QEMU thinks it is
  */
@@ -1874,7 +1906,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return -EINVAL;
     }
 
-    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
+    /*
+     * Install VM change handler only when vCPU thread has been spawned
+     * i.e. vCPU is being realized
+     */
+    if (cs->thread_id) {
+        cs->vmcse = qemu_add_vm_change_state_handler(kvm_arm_vm_state_change,
+                                                     cpu);
+    }
 
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index cfaa0d9bc7..93d12eeb74 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -96,6 +96,16 @@ void kvm_arm_cpu_post_load(ARMCPU *cpu);
  */
 void kvm_arm_reset_vcpu(ARMCPU *cpu);
 
+/**
+ * kvm_arm_create_host_vcpu:
+ * @cpu: ARMCPU
+ *
+ * Called to pre-create possible KVM vCPU within the host during the
+ * `virt_machine` initialization phase. This pre-created vCPU will be parked and
+ * will be reused when ARM QOM vCPU is actually hotplugged.
+ */
+void kvm_arm_create_host_vcpu(ARMCPU *cpu);
+
 #ifdef CONFIG_KVM
 /**
  * kvm_arm_create_scratch_host_vcpu:
-- 
2.34.1


