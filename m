Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E239D64076
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 00:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Z1m-0006cT-IH; Fri, 08 Nov 2024 19:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t9Z1j-0006az-KC; Fri, 08 Nov 2024 19:08:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t9Z1g-0004T3-T0; Fri, 08 Nov 2024 19:08:31 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlbkC6MJWz67D3M;
 Sat,  9 Nov 2024 08:08:19 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 043E6140517;
 Sat,  9 Nov 2024 08:08:26 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.150.69) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 9 Nov 2024 01:08:11 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <imammedo@redhat.com>
CC: <salil.mehta@huawei.com>, <jonathan.cameron@huawei.com>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <anisinha@redhat.com>, <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>,
 <david@redhat.com>, <philmd@linaro.org>, <peterx@redhat.com>,
 <pbonzini@redhat.com>, <gshan@redhat.com>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>, <zhao1.liu@intel.com>, 
 <linuxarm@huawei.com>, <gustavo.romero@linaro.org>
Subject: [PATCH V2 2/3] Fix: CPUs presence logic in _STA for x86 backward
 compatability
Date: Sat, 9 Nov 2024 00:07:27 +0000
Message-ID: <20241109000728.206825-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109000728.206825-1-salil.mehta@huawei.com>
References: <20241109000728.206825-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.150.69]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Checking `is_present` first can break x86 migration from new Qemu
version to old Qemu. This is because CPRS Bit is not defined in the
older Qemu register block and will always be 0 resulting in check always
failing. Remove CPU_PRESENT Bit to preserve older ABI.

-                If ((\_SB.PCI0.PRES.CPEN == One))
-                {
-                    Local0 = 0x0F
+                If ((\_SB.PCI0.PRES.CPRS == One))
+                {
+                    If ((\_SB.PCI0.PRES.CPEN == One))
+                    {
+                        Local0 = 0x0F
+                    }
+                    Else
+                    {
+                        Local0 = 0x0D
+                    }
                 }

Reported-by: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20241106100047.18901c9d@imammedo.users.ipa.redhat.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/acpi/cpu.c         | 49 ++++++++++++++++---------------------------
 include/hw/acpi/cpu.h |  1 +
 include/hw/core/cpu.h |  1 -
 3 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 23443f09a5..7b0badd08a 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -23,6 +23,8 @@ enum {
     CPHP_CMD_MAX
 };
 
+static bool always_present_cpus;
+
 static ACPIOSTInfo *acpi_cpu_device_status(int idx, AcpiCpuStatus *cdev)
 {
     ACPIOSTInfo *info = g_new0(ACPIOSTInfo, 1);
@@ -79,7 +81,6 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
         val |= cdev->is_inserting ? 2 : 0;
         val |= cdev->is_removing  ? 4 : 0;
         val |= cdev->fw_remove  ? 16 : 0;
-        val |= cdev->cpu ? 32 : 0;
         trace_cpuhp_acpi_read_flags(cpu_st->selector, val);
         break;
     case ACPI_CPU_CMD_DATA_OFFSET_RW:
@@ -246,15 +247,9 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
     memory_region_add_subregion(as, base_addr, &state->ctrl_reg);
 }
 
-static bool should_remain_acpi_present(DeviceState *dev)
+static inline bool should_remain_acpi_present(DeviceState *dev)
 {
-    CPUClass *k = CPU_GET_CLASS(dev);
-    /*
-     * A system may contain CPUs that are always present on one die, NUMA node,
-     * or socket, yet may be non-present on another simultaneously. Check from
-     * architecture specific code.
-     */
-    return k->cpu_persistent_status && k->cpu_persistent_status(CPU(dev));
+    return always_present_cpus;
 }
 
 static AcpiCpuStatus *get_cpu_status(CPUHotplugState *cpu_st, DeviceState *dev)
@@ -362,7 +357,6 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPU_REMOVE_EVENT  "CRMV"
 #define CPU_EJECT_EVENT   "CEJ0"
 #define CPU_FW_EJECT_EVENT "CEJF"
-#define CPU_PRESENT       "CPRS"
 
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                     build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
@@ -423,9 +417,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         aml_append(field, aml_named_field(CPU_EJECT_EVENT, 1));
         /* tell firmware to do device eject, write only */
         aml_append(field, aml_named_field(CPU_FW_EJECT_EVENT, 1));
-        /* 1 if present, read only */
-        aml_append(field, aml_named_field(CPU_PRESENT, 1));
-        aml_append(field, aml_reserved_field(2));
+        aml_append(field, aml_reserved_field(3));
         aml_append(field, aml_named_field(CPU_COMMAND, 8));
         aml_append(cpu_ctrl_dev, field);
 
@@ -455,7 +447,6 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         Aml *ctrl_lock = aml_name("%s.%s", cphp_res_path, CPU_LOCK);
         Aml *cpu_selector = aml_name("%s.%s", cphp_res_path, CPU_SELECTOR);
         Aml *is_enabled = aml_name("%s.%s", cphp_res_path, CPU_ENABLED);
-        Aml *is_present = aml_name("%s.%s", cphp_res_path, CPU_PRESENT);
         Aml *cpu_cmd = aml_name("%s.%s", cphp_res_path, CPU_COMMAND);
         Aml *cpu_data = aml_name("%s.%s", cphp_res_path, CPU_DATA);
         Aml *ins_evt = aml_name("%s.%s", cphp_res_path, CPU_INSERT_EVENT);
@@ -482,28 +473,24 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
 
         method = aml_method(CPU_STS_METHOD, 1, AML_SERIALIZED);
         {
-            Aml *idx = aml_arg(0);
+            Aml *default_sta = aml_int(opts.always_present_cpus ? 0xD : 0);
             Aml *sta = aml_local(0);
-            Aml *ifctx2;
-            Aml *else_ctx;
+            Aml *idx = aml_arg(0);
+
+            always_present_cpus = opts.always_present_cpus;
 
             aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
             aml_append(method, aml_store(idx, cpu_selector));
-            aml_append(method, aml_store(zero, sta));
-            ifctx = aml_if(aml_equal(is_present, one));
+            /*
+             * Default case:
+             * _STA(0xD) = cpu is present and disabled OR
+             * _STA(0x0) = cpu is not present (and hence disabled)
+             */
+            aml_append(method, aml_store(default_sta, sta));
+            ifctx = aml_if(aml_equal(is_enabled, one));
             {
-                ifctx2 = aml_if(aml_equal(is_enabled, one));
-                {
-                    /* cpu is present and enabled */
-                    aml_append(ifctx2, aml_store(aml_int(0xF), sta));
-                }
-                aml_append(ifctx, ifctx2);
-                else_ctx = aml_else();
-                {
-                    /* cpu is present but disabled */
-                    aml_append(else_ctx, aml_store(aml_int(0xD), sta));
-                }
-                aml_append(ifctx, else_ctx);
+                /* _STA(0xF) = cpu is present and enabled */
+                aml_append(ifctx, aml_or(aml_int(0xF), sta, sta));
             }
             aml_append(method, ifctx);
             aml_append(method, aml_release(ctrl_lock));
diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 32654dc274..4a3e591120 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -55,6 +55,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
 typedef struct CPUHotplugFeatures {
     bool acpi_1_compatible;
     bool has_legacy_cphp;
+    bool always_present_cpus;
     bool fw_unplugs_cpu;
     const char *smi_path;
 } CPUHotplugFeatures;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index db8a6fbc6e..e936b67675 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -158,7 +158,6 @@ struct CPUClass {
     void (*dump_state)(CPUState *cpu, FILE *, int flags);
     void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
     int64_t (*get_arch_id)(CPUState *cpu);
-    bool (*cpu_persistent_status)(CPUState *cpu);
     bool (*cpu_enabled_status)(CPUState *cpu);
     void (*set_pc)(CPUState *cpu, vaddr value);
     vaddr (*get_pc)(CPUState *cpu);
-- 
2.34.1


