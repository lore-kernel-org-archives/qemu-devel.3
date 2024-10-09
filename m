Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D878CF043B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNKT-0006E9-1f; Tue, 08 Oct 2024 23:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNKQ-0006A9-P0; Tue, 08 Oct 2024 23:25:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNKO-0004wq-75; Tue, 08 Oct 2024 23:25:34 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNdT343p3z6LDBw;
 Wed,  9 Oct 2024 11:21:11 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 4734C140114;
 Wed,  9 Oct 2024 11:25:30 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.173.89) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 05:25:11 +0200
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
Subject: [PATCH RFC V4 18/33] hw/acpi: Simulate *persistent* vCPU presence to
 Guest in ACPI _STA.{PRES, ENA} Bits
Date: Wed, 9 Oct 2024 04:18:00 +0100
Message-ID: <20241009031815.250096-19-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009031815.250096-1-salil.mehta@huawei.com>
References: <20241009031815.250096-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Certain CPU architecture specifications [1][2][3] prohibit changes to the CPUs
*presence* after the kernel has booted. This is because many system
initializations depend on the exact CPU count at boot time and do not expect it
to change afterward. For example, components like interrupt controllers that are
closely coupled with CPUs, or various per-CPU features, may not support
configuration changes once the kernel has been initialized.

This requirement poses a challenge for virtualization features like vCPU
hotplug. To address this, changes to the ACPI AML are necessary to update the
`_STA.PRES` (presence) and `_STA.ENA` (enabled) bits accordingly during guest
initialization, as well as when vCPUs are hot-plugged or hot-unplugged. The
presence of unplugged vCPUs may need to be deliberately *simulated* at the ACPI
level to maintain a *persistent* view of vCPUs for the guest kernel.

Introduce an `acpi_persistent` property, which can be used to initialize the
ACPI vCPU `presence` state accordingly. Architectures that require ACPI to
expose a persistent view of vCPUs can override its default value. Refer to the
subsequent patches for its usage.

References:
[1] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt CPU Hotplug on
    architectures that don’t Support CPU Hotplug (like ARM64)
    a. Kernel Link: https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
    b. Qemu Link:  https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
[2] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU Hotplug on
    SoC Based Systems (like ARM64)
    Link: https://kvmforum2020.sched.com/event/eE4m
[3] Check comment 5 in the bugzilla entry
    Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 cpu-target.c                   |  1 +
 hw/acpi/cpu.c                  | 70 +++++++++++++++++++++++++++++++---
 hw/acpi/generic_event_device.c | 11 ++++++
 include/hw/acpi/cpu.h          | 23 +++++++++++
 include/hw/core/cpu.h          | 10 +++++
 5 files changed, 110 insertions(+), 5 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 499facf774..c8a29ab495 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -200,6 +200,7 @@ static Property cpu_common_props[] = {
      */
     DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
+    DEFINE_PROP_BOOL("acpi-persistent", CPUState, acpi_persistent, false),
 #endif
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 2d6afcfff7..d5d0363d08 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -63,10 +63,11 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
     cdev = &cpu_st->devs[cpu_st->selector];
     switch (addr) {
     case ACPI_CPU_FLAGS_OFFSET_RW: /* pack and return is_* fields */
-        val |= cdev->cpu ? 1 : 0;
+        val |= cdev->is_enabled ? 1 : 0;
         val |= cdev->is_inserting ? 2 : 0;
         val |= cdev->is_removing  ? 4 : 0;
         val |= cdev->fw_remove  ? 16 : 0;
+        val |= cdev->is_present ? 32 : 0;
         trace_cpuhp_acpi_read_flags(cpu_st->selector, val);
         break;
     case ACPI_CPU_CMD_DATA_OFFSET_RW:
@@ -225,7 +226,40 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
     state->dev_count = id_list->len;
     state->devs = g_new0(typeof(*state->devs), state->dev_count);
     for (i = 0; i < id_list->len; i++) {
-        state->devs[i].cpu =  CPU(id_list->cpus[i].cpu);
+        struct CPUState *cpu = CPU(id_list->cpus[i].cpu);
+        /*
+         * In most architectures, CPUs that are marked as ACPI 'present' are
+         * also ACPI 'enabled' by default. These states remain consistent at
+         * both the QOM and ACPI levels.
+         */
+        if (qemu_enabled_cpu(cpu)) {
+            state->devs[i].is_enabled = true;
+            state->devs[i].is_present = true;
+            state->devs[i].cpu = cpu;
+        } else {
+            state->devs[i].is_enabled = false;
+            /*
+             * In some architectures, even 'unplugged' or 'disabled' QOM CPUs
+             * may be exposed as ACPI 'present.' This approach provides a
+             * persistent view of the vCPUs to the guest kernel. This could be
+             * due to an architectural constraint that requires every per-CPU
+             * component to be present at boot time, meaning the exact count of
+             * vCPUs must be known and cannot be altered after the kernel has
+             * booted. As a result, the vCPU states at the QOM and ACPI levels
+             * might become inconsistent. However, in such cases, the presence
+             * of vCPUs has been deliberately simulated at the ACPI level.
+             */
+            if (acpi_persistent_cpu(cpu)) {
+                state->devs[i].is_present = true;
+                /*
+                 * `CPUHotplugState::AcpiCpuStatus::cpu` becomes insignificant
+                 * in this case
+                 */
+            } else {
+                state->devs[i].is_present = qemu_present_cpu(cpu);
+                state->devs[i].cpu = cpu;
+            }
+        }
         state->devs[i].arch_id = id_list->cpus[i].arch_id;
     }
     memory_region_init_io(&state->ctrl_reg, owner, &cpu_hotplug_ops, state,
@@ -258,6 +292,8 @@ void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
     }
 
     cdev->cpu = CPU(dev);
+    cdev->is_present = true;
+    cdev->is_enabled = true;
     if (dev->hotplugged) {
         cdev->is_inserting = true;
         acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
@@ -289,6 +325,11 @@ void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
         return;
     }
 
+    cdev->is_enabled = false;
+    if (!acpi_persistent_cpu(CPU(dev))) {
+        cdev->is_present = false;
+    }
+
     cdev->cpu = NULL;
 }
 
@@ -299,6 +340,8 @@ static const VMStateDescription vmstate_cpuhp_sts = {
     .fields = (const VMStateField[]) {
         VMSTATE_BOOL(is_inserting, AcpiCpuStatus),
         VMSTATE_BOOL(is_removing, AcpiCpuStatus),
+        VMSTATE_BOOL(is_present, AcpiCpuStatus),
+        VMSTATE_BOOL(is_enabled, AcpiCpuStatus),
         VMSTATE_UINT32(ost_event, AcpiCpuStatus),
         VMSTATE_UINT32(ost_status, AcpiCpuStatus),
         VMSTATE_END_OF_LIST()
@@ -336,6 +379,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPU_REMOVE_EVENT  "CRMV"
 #define CPU_EJECT_EVENT   "CEJ0"
 #define CPU_FW_EJECT_EVENT "CEJF"
+#define CPU_PRESENT       "CPRS"
 
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                     build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
@@ -396,7 +440,9 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         aml_append(field, aml_named_field(CPU_EJECT_EVENT, 1));
         /* tell firmware to do device eject, write only */
         aml_append(field, aml_named_field(CPU_FW_EJECT_EVENT, 1));
-        aml_append(field, aml_reserved_field(3));
+        /* 1 if present, read only */
+        aml_append(field, aml_named_field(CPU_PRESENT, 1));
+        aml_append(field, aml_reserved_field(2));
         aml_append(field, aml_named_field(CPU_COMMAND, 8));
         aml_append(cpu_ctrl_dev, field);
 
@@ -426,6 +472,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         Aml *ctrl_lock = aml_name("%s.%s", cphp_res_path, CPU_LOCK);
         Aml *cpu_selector = aml_name("%s.%s", cphp_res_path, CPU_SELECTOR);
         Aml *is_enabled = aml_name("%s.%s", cphp_res_path, CPU_ENABLED);
+        Aml *is_present = aml_name("%s.%s", cphp_res_path, CPU_PRESENT);
         Aml *cpu_cmd = aml_name("%s.%s", cphp_res_path, CPU_COMMAND);
         Aml *cpu_data = aml_name("%s.%s", cphp_res_path, CPU_DATA);
         Aml *ins_evt = aml_name("%s.%s", cphp_res_path, CPU_INSERT_EVENT);
@@ -454,13 +501,26 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         {
             Aml *idx = aml_arg(0);
             Aml *sta = aml_local(0);
+            Aml *ifctx2;
+            Aml *else_ctx;
 
             aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
             aml_append(method, aml_store(idx, cpu_selector));
             aml_append(method, aml_store(zero, sta));
-            ifctx = aml_if(aml_equal(is_enabled, one));
+            ifctx = aml_if(aml_equal(is_present, one));
             {
-                aml_append(ifctx, aml_store(aml_int(0xF), sta));
+                ifctx2 = aml_if(aml_equal(is_enabled, one));
+                {
+                    /* cpu is present and enabled */
+                    aml_append(ifctx2, aml_store(aml_int(0xF), sta));
+                }
+                aml_append(ifctx, ifctx2);
+                else_ctx = aml_else();
+                {
+                    /* cpu is present but disabled */
+                    aml_append(else_ctx, aml_store(aml_int(0xD), sta));
+                }
+                aml_append(ifctx, else_ctx);
             }
             aml_append(method, ifctx);
             aml_append(method, aml_release(ctrl_lock));
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 15b4c3ebbf..a4d78a534c 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -331,6 +331,16 @@ static const VMStateDescription vmstate_memhp_state = {
     }
 };
 
+static const VMStateDescription vmstate_cpuhp_state = {
+    .name = "acpi-ged/cpuhp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_CPU_HOTPLUG(cpuhp_state, AcpiGedState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_ged_state = {
     .name = "acpi-ged-state",
     .version_id = 1,
@@ -379,6 +389,7 @@ static const VMStateDescription vmstate_acpi_ged = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_memhp_state,
+        &vmstate_cpuhp_state,
         &vmstate_ghes_state,
         NULL
     }
diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 4d6ae5453f..1e2147a8ac 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -26,6 +26,8 @@ typedef struct AcpiCpuStatus {
     uint64_t arch_id;
     bool is_inserting;
     bool is_removing;
+    bool is_present;
+    bool is_enabled;
     bool fw_remove;
     uint32_t ost_event;
     uint32_t ost_status;
@@ -93,4 +95,25 @@ static inline uint64_t acpi_get_cpu_archid(int cpu_index)
 
     return possible_cpus->cpus[cpu_index].arch_id;
 }
+
+/**
+ * acpi_persistent_cpu:
+ * @cpu: The vCPU to check
+ *
+ * Checks if the vCPU state should always be reflected as *present* via ACPI
+ * to the Guest. By default, this is False on all architectures and has to be
+ * explicity set during initialization.
+ *
+ * Returns: True if it is ACPI 'persistent' CPU
+ *
+ */
+static inline bool acpi_persistent_cpu(CPUState *cpu)
+{
+    assert(cpu);
+    /*
+     * returns if 'Presence' of the vCPU is persistent and should be simulated
+     * via ACPI even after vCPUs have been unplugged in QOM
+     */
+    return cpu->acpi_persistent;
+}
 #endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fa6f1dbec9..2e62d5f1a5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -552,6 +552,16 @@ struct CPUState {
      * By default, `CPUState` objects are enabled across all architectures.
      */
     bool disabled;
+    /*
+     * On certain architectures, to provide the guest kernel with a persistent
+     * view of vCPU presence, even when the QOM might not have a corresponding
+     * vCPU object, ACPI may need to simulate the presence of vCPUs while
+     * keeping them ACPI-disabled for the guest. This is achieved by returning
+     * `_STA.PRES=True` and `_STA.Ena=False` for unplugged vCPUs in QEMU's QOM.
+     * By default, this flag is set to FALSE and must be explicitly set to TRUE
+     * on architectures like ARM.
+     */
+    bool acpi_persistent;
 
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
-- 
2.34.1


