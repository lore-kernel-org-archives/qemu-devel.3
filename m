Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA14CF0433
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNGf-0006OE-RV; Tue, 08 Oct 2024 23:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNGd-0006HR-Uu; Tue, 08 Oct 2024 23:21:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNGb-0004Xd-IZ; Tue, 08 Oct 2024 23:21:39 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNdTB75TXz6K98r;
 Wed,  9 Oct 2024 11:21:18 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 9C4D2140447;
 Wed,  9 Oct 2024 11:21:35 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.173.89) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 05:21:16 +0200
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
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH RFC V4 06/33] arm/virt,
 kvm: Pre-create disabled possible vCPUs @machine init
Date: Wed, 9 Oct 2024 04:17:48 +0100
Message-ID: <20241009031815.250096-7-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009031815.250096-1-salil.mehta@huawei.com>
References: <20241009031815.250096-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.173.89]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In the ARMv8 architecture, the GIC must know all the CPUs it is connected to
during its initialization, and this cannot change afterward. This must be
ensured during the initialization of the VGIC in KVM, which requires all vCPUs
to be created and present during its initialization. This is necessary because:

1. The association between GICC and MPIDR must be fixed at VM initialization
   time. This is represented by the register `GIC_TYPER(mp_affinity, proc_num)`.
2. GICC (CPU interfaces), GICR (redistributors), etc., must all be initialized
   at boot time.
3. Memory regions associated with GICR, etc., cannot be changed (added, deleted,
   or modified) after the VM has been initialized.

This patch adds support to pre-create all possible vCPUs within the host using
the KVM interface as part of the virtual machine initialization. These vCPUs can
later be attached to QOM/ACPI when they are actually hot-plugged and made
present.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reported-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
[VP: Identified CPU stall issue & suggested probable fix]
---
 hw/arm/virt.c         | 69 ++++++++++++++++++++++++++++++++++++++-----
 include/hw/core/cpu.h |  1 +
 target/arm/cpu64.c    |  1 +
 target/arm/kvm.c      | 41 ++++++++++++++++++++++++-
 target/arm/kvm_arm.h  | 11 +++++++
 5 files changed, 114 insertions(+), 9 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3db4769289..badde5ed7a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2364,17 +2364,12 @@ static void machvirt_init(MachineState *machine)
 
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
@@ -2386,8 +2381,57 @@ static void machvirt_init(MachineState *machine)
         object_property_set_int(cpuobj, "thread-id",
                                 virt_get_thread_id(machine, n), NULL);
 
-        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
-        object_unref(cpuobj);
+        if (n < smp_cpus) {
+            qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
+            object_unref(cpuobj);
+        } else {
+            /* handling for vCPUs which are yet-to-be hot-plugged */
+            cs->cpu_index = n;
+            cpu_slot = virt_find_cpu_slot(cs);
+
+           /* GICv3 will need `mp-affinity` to derive `gicr_typer` */
+            virt_cpu_set_properties(cpuobj, cpu_slot, &error_fatal);
+
+            /*
+             * For KVM, we shall be pre-creating the now disabled/un-plugged
+             * possbile host vcpus and park them till the time they are
+             * actually hot plugged. This is required to pre-size the host
+             * GICC and GICR with the all possible vcpus for this VM.
+             */
+            if (kvm_enabled()) {
+                kvm_arm_create_host_vcpu(ARM_CPU(cs));
+                /*
+                 * Override the default architecture ID with the one fetched
+                 * from KVM. After initialization, we will destroy the CPUState
+                 * for disabled vCPUs; however, the CPU slot and its association
+                 * with the architecture ID (and consequently the vCPU ID) will
+                 * remain fixed for the entire lifetime of QEMU and cannot be
+                 * altered. This is also an ARM CPU architectural constraint.
+                 */
+                cpu_slot->arch_id = arm_cpu_mp_affinity(ARM_CPU(cs));
+            }
+            /*
+             * Add disabled vCPU to CPU slot during the init phase of the virt
+             * machine
+             * 1. We need this ARMCPU object during the GIC init. This object
+             *    will facilitate in pre-realizing the GIC. Any info like
+             *    mp-affinity(required to derive gicr_type) etc. could still be
+             *    fetched while preserving QOM abstraction akin to realized
+             *    vCPUs.
+             * 2. Now, after initialization of the virt machine is complete we
+             *    could use two approaches to deal with this ARMCPU object:
+             *    (i) re-use this ARMCPU object during hotplug of this vCPU.
+             *                             OR
+             *    (ii) defer release this ARMCPU object after gic has been
+             *         initialized or during pre-plug phase when a vCPU is
+             *         hotplugged.
+             *
+             *    We will use the (ii) approach and release the ARMCPU objects
+             *    after GIC and machine has been fully initialized during
+             *    machine_init_done() phase.
+             */
+             cpu_slot->cpu = cs;
+        }
     }
 
     /* Now we've created the CPUs we can see if they have the hypvirt timer */
@@ -2990,6 +3034,15 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     /* insert the cold/hot-plugged vcpu in the slot */
     cpu_slot = virt_find_cpu_slot(cs);
     cpu_slot->cpu = CPU(dev);
+    if (kvm_enabled()) {
+        /*
+         * Override the default architecture ID with the one fetched from KVM
+         * Currently, KVM derives the architecture ID from the vCPU ID specified
+         * by QEMU. In the future, we might implement a change where the entire
+         * architecture ID can be configured directly by QEMU.
+         */
+        cpu_slot->arch_id = arm_cpu_mp_affinity(ARM_CPU(cs));
+    }
 
     cs->disabled = false;
 }
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 73a4e4cce1..bcc62fbf0c 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -530,6 +530,7 @@ struct CPUState {
     uint64_t dirty_pages;
     int kvm_vcpu_stats_fd;
     bool vcpu_dirty;
+    VMChangeStateEntry *vmcse;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d36d3519df..2a517fdb9f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -793,6 +793,7 @@ static void aarch64_cpu_initfn(Object *obj)
      * explicitly enabled.
      */
     cs->disabled = true;
+    cs->thread_id = 0;
 }
 
 static void aarch64_cpu_finalizefn(Object *obj)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 849e2e21b3..8ed160cbca 100644
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
index cfaa0d9bc7..0be7e896d2 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -96,6 +96,17 @@ void kvm_arm_cpu_post_load(ARMCPU *cpu);
  */
 void kvm_arm_reset_vcpu(ARMCPU *cpu);
 
+/**
+ * kvm_arm_create_host_vcpu:
+ * @cpu: ARMCPU
+ *
+ * Called at to pre create all possible kvm vCPUs within the the host at the
+ * virt machine init time. This will also init this pre-created vCPU and
+ * hence result in vCPU reset at host. These pre created and inited vCPUs
+ * shall be parked for use when ARM vCPUs are actually realized.
+ */
+void kvm_arm_create_host_vcpu(ARMCPU *cpu);
+
 #ifdef CONFIG_KVM
 /**
  * kvm_arm_create_scratch_host_vcpu:
-- 
2.34.1


