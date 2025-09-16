Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59611CAC59B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 12:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyV49-0003Uf-Qv; Tue, 16 Sep 2025 08:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uyV3N-0003De-SJ
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:45:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uyV3I-0002J6-MY
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:45:01 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx1tC8W8lot_MKAA--.23530S3;
 Tue, 16 Sep 2025 20:44:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxbMG4W8loS1uZAA--.42126S4;
 Tue, 16 Sep 2025 20:44:43 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v8 02/11] hw/loongarch: add virt feature dmsi support
Date: Tue, 16 Sep 2025 20:21:00 +0800
Message-Id: <20250916122109.749813-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250916122109.749813-1-gaosong@loongson.cn>
References: <20250916122109.749813-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxbMG4W8loS1uZAA--.42126S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

dmsi feature is added in LoongArchVirtMachinState, and it is used
to check whether virt machine supports the directy Message-Interrupts.
and by default set dmsi with ON_OFF_AUTO_AUTO.
LoongArchVirtMachineState adds misc_feature and misc_status for misc
features and status. and set the default dintc feature bit.
Msgint feature is added in LoongArchCPU, and it is used to check
whether th cpu supports the Message-Interrupts and by default set
mesgint with ON_OFF_AUTO_AUTO.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c         | 50 +++++++++++++++++++++++++++++++++++++
 include/hw/loongarch/virt.h | 14 +++++++++++
 target/loongarch/cpu.c      | 27 ++++++++++++++++++++
 target/loongarch/cpu.h      |  1 +
 4 files changed, 92 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 31215b7785..2f64089eac 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -48,6 +48,30 @@
 #include "qemu/error-report.h"
 #include "kvm/kvm_loongarch.h"
 
+static void virt_get_dmsi(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+    OnOffAuto dmsi = lvms->dmsi;
+
+    visit_type_OnOffAuto(v, name, &dmsi, errp);
+
+}
+static void virt_set_dmsi(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+
+    visit_type_OnOffAuto(v, name, &lvms->dmsi, errp);
+
+    if (lvms->dmsi == ON_OFF_AUTO_OFF) {
+        lvms->misc_feature &= ~BIT(IOCSRF_DMSI);
+        lvms->misc_status &= ~BIT(IOCSRM_DMSI_EN);
+    } else if (lvms->dmsi == ON_OFF_AUTO_ON) {
+        lvms->misc_feature = BIT(IOCSRF_DMSI);
+    }
+}
+
 static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -683,6 +707,25 @@ static void fw_cfg_add_memory(MachineState *ms)
     }
 }
 
+static void virt_check_dmsi(MachineState *machine)
+{
+    LoongArchCPU *cpu;
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
+
+    cpu = LOONGARCH_CPU(first_cpu);
+    if (lvms->dmsi == ON_OFF_AUTO_AUTO) {
+        if (cpu->msgint != ON_OFF_AUTO_OFF) {
+            lvms->misc_feature = BIT(IOCSRF_DMSI);
+        }
+    }
+
+    if (lvms->dmsi == ON_OFF_AUTO_ON && cpu->msgint == ON_OFF_AUTO_OFF) {
+        error_report("Fail to enable dmsi , cpu msgint is off "
+                     "pleass add cpu feature mesgint=on.");
+        exit(EXIT_FAILURE);
+    }
+}
+
 static void virt_init(MachineState *machine)
 {
     const char *cpu_model = machine->cpu_type;
@@ -717,6 +760,7 @@ static void virt_init(MachineState *machine)
         }
         qdev_realize_and_unref(DEVICE(cpuobj), NULL, &error_fatal);
     }
+    virt_check_dmsi(machine);
     fw_cfg_add_memory(machine);
 
     /* Node0 memory */
@@ -847,6 +891,8 @@ static void virt_initfn(Object *obj)
     if (tcg_enabled()) {
         lvms->veiointc = ON_OFF_AUTO_OFF;
     }
+
+    lvms->dmsi = ON_OFF_AUTO_AUTO;
     lvms->acpi = ON_OFF_AUTO_AUTO;
     lvms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     lvms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
@@ -1239,6 +1285,10 @@ static void virt_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "v-eiointc",
                             "Enable Virt Extend I/O Interrupt Controller.");
+    object_class_property_add(oc, "dmsi", "OnOffAuto",
+        virt_get_dmsi, virt_set_dmsi, NULL, NULL);
+    object_class_property_set_description(oc, "dmsi",
+                            "Enable direct Message-interrupts Controller.");
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
 #ifdef CONFIG_TPM
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 7120b46714..98e9bf0737 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -23,6 +23,7 @@
 #define IOCSRF_DVFSV1           7
 #define IOCSRF_GMOD             9
 #define IOCSRF_VM               11
+#define IOCSRF_DMSI             15
 
 #define VERSION_REG             0x0
 #define FEATURE_REG             0x8
@@ -31,6 +32,7 @@
 #define MISC_FUNC_REG           0x420
 #define IOCSRM_EXTIOI_EN        48
 #define IOCSRM_EXTIOI_INT_ENCODE 49
+#define IOCSRM_DMSI_EN          51
 
 #define LOONGARCH_MAX_CPUS      256
 
@@ -69,6 +71,7 @@ struct LoongArchVirtMachineState {
     Notifier     powerdown_notifier;
     OnOffAuto    acpi;
     OnOffAuto    veiointc;
+    OnOffAuto    dmsi;
     char         *oem_id;
     char         *oem_table_id;
     DeviceState  *acpi_ged;
@@ -84,6 +87,8 @@ struct LoongArchVirtMachineState {
     DeviceState *extioi;
     struct memmap_entry *memmap_table;
     unsigned int memmap_entries;
+    uint64_t misc_feature;
+    uint64_t misc_status;
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
@@ -91,6 +96,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
 void virt_acpi_setup(LoongArchVirtMachineState *lvms);
 void virt_fdt_setup(LoongArchVirtMachineState *lvms);
 
+static inline bool virt_has_dmsi(LoongArchVirtMachineState *lvms)
+{
+    if (!(lvms->misc_feature & BIT(IOCSRF_DMSI))) {
+        return false;
+    }
+
+    return true;
+}
+
 static inline bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
 {
     if (lvms->veiointc == ON_OFF_AUTO_OFF) {
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 55ee317bf2..e23d2def6c 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -495,6 +495,25 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
     cpu->env.cpucfg[2] = FIELD_DP32(val, CPUCFG2, LASX, value);
 }
 
+static bool loongarch_get_msgint(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->msgint != ON_OFF_AUTO_OFF;
+}
+
+static void loongarch_set_msgint(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    cpu->msgint = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+
+    if (kvm_enabled()) {
+        /* kvm feature detection in function kvm_arch_init_vcpu */
+        return;
+    }
+
+     cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, value);
+}
+
 static void loongarch_cpu_post_init(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
@@ -507,6 +526,8 @@ static void loongarch_cpu_post_init(Object *obj)
                              loongarch_set_lsx);
     object_property_add_bool(obj, "lasx", loongarch_get_lasx,
                              loongarch_set_lasx);
+    object_property_add_bool(obj, "msgint", loongarch_get_msgint,
+                             loongarch_set_msgint);
     /* lbt is enabled only in kvm mode, not supported in tcg mode */
     if (kvm_enabled()) {
         kvm_loongarch_cpu_post_init(cpu);
@@ -614,6 +635,7 @@ static void loongarch_la464_initfn(Object *obj)
     env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
     env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
 
+    cpu->msgint = ON_OFF_AUTO_OFF;
     loongarch_la464_init_csr(obj);
     loongarch_cpu_post_init(obj);
 }
@@ -644,12 +666,17 @@ static void loongarch_la132_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG1, HP, 1);
     data = FIELD_DP32(data, CPUCFG1, CRC, 1);
     env->cpucfg[1] = data;
+    cpu->msgint = ON_OFF_AUTO_OFF;
 }
 
 static void loongarch_max_initfn(Object *obj)
 {
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
     /* '-cpu max' for TCG: we use cpu la464. */
     loongarch_la464_initfn(obj);
+
+    cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
+    cpu->msgint = ON_OFF_AUTO_AUTO;
 }
 
 static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index fd3d94b55a..1e8a9dbef8 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -396,6 +396,7 @@ struct ArchCPU {
     OnOffAuto pmu;
     OnOffAuto lsx;
     OnOffAuto lasx;
+    OnOffAuto msgint;
     OnOffAuto kvm_pv_ipi;
     OnOffAuto kvm_steal_time;
     int32_t socket_id;  /* socket-id of this CPU */
-- 
2.41.0


