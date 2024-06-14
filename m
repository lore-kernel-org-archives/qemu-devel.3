Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C75C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 01:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHwAs-0007h6-1b; Thu, 13 Jun 2024 21:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sHwAp-0007eG-SG
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 21:56:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sHwAm-0001tW-1c
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 21:56:15 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxFPAxo2tmX70GAA--.27376S3;
 Fri, 14 Jun 2024 09:56:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxRcUwo2tmE5cfAA--.700S2; 
 Fri, 14 Jun 2024 09:56:00 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, pbonzini@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org, zhaotianrui@loongson.cn
Subject: [RFC PATCH v3] target/loongarch/kvm: Implement LoongArch PMU
 extension.
Date: Fri, 14 Jun 2024 09:38:48 +0800
Message-Id: <20240614013848.53474-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxRcUwo2tmE5cfAA--.700S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement PMU extension for LoongArch kvm mode. Use OnOffAuto type
variable pmu to check the PMU feature. If the PMU Feature is not supported
with KVM host, it reports error if there is pmu=on command line.

If there is no any command line about pmu parameter, it checks whether
KVM host supports the PMU Feature and set the corresponding value in cpucfg.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
v3:
 - Use OnOffAuto type variable pmu to check the PMU feature.
 - Link to v2: https://patchew.org/QEMU/20240515040611.998507-1-gaosong@loongson.cn/

v2:
 - Drop the property 'pmnum'.
 - Link to v1: https://patchew.org/QEMU/20240514094630.988617-1-gaosong@loongson.cn/

This patch adds the 'RFC' heading because it requires
the kernel to merge into patch[1] first

[1]:https://lore.kernel.org/all/20240613120539.41021-1-gaosong@loongson.cn/

 linux-headers/asm-loongarch/kvm.h     |  3 ++
 target/loongarch/cpu.c                | 56 +++++++++++++++++++++++++++
 target/loongarch/cpu.h                |  5 +++
 target/loongarch/kvm/kvm.c            | 16 ++++++++
 target/loongarch/kvm/kvm_loongarch.h  | 16 ++++++++
 target/loongarch/loongarch-qmp-cmds.c |  2 +-
 6 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-loongarch/kvm.h b/linux-headers/asm-loongarch/kvm.h
index f9abef3823..afe604d301 100644
--- a/linux-headers/asm-loongarch/kvm.h
+++ b/linux-headers/asm-loongarch/kvm.h
@@ -83,6 +83,9 @@ struct kvm_fpu {
 #define KVM_IOC_CPUCFG(REG)		LOONGARCH_REG_64(KVM_REG_LOONGARCH_CPUCFG, REG)
 #define KVM_LOONGARCH_VCPU_CPUCFG	0
 
+#define KVM_LOONGARCH_VM_FEAT_CTRL 	0
+#define  KVM_LOONGARCH_VM_FEAT_PMU 	0
+
 struct kvm_debug_exit_arch {
 };
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 270f711f11..e973f611e5 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -571,6 +571,35 @@ static void loongarch_cpu_disas_set_info(CPUState *s, disassemble_info *info)
     info->print_insn = print_insn_loongarch;
 }
 
+static void loongarch_cpu_check_pmu(CPUState *cs, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    bool kvm_supported;
+
+    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PMU);
+    if (cpu->pmu == ON_OFF_AUTO_ON) {
+        if (kvm_supported) {
+            cpu->env.cpucfg[6] = FIELD_DP32(cpu->env.cpucfg[6], CPUCFG6, PMP, 1);
+            cpu->env.cpucfg[6] = FIELD_DP32(cpu->env.cpucfg[6], CPUCFG6, PMNUM, 3);
+            cpu->env.cpucfg[6] = FIELD_DP32(cpu->env.cpucfg[6], CPUCFG6, PMBITS, 63);
+            cpu->env.cpucfg[6] = FIELD_DP32(cpu->env.cpucfg[6], CPUCFG6, UPM, 1);
+        } else {
+            error_setg(errp, "'pmu' feature not supported by KVM on this host.");
+            return;
+        }
+    } else if ((cpu->pmu == ON_OFF_AUTO_AUTO) && kvm_supported) {
+        cpu->env.cpucfg[6] = FIELD_DP32(cpu->env.cpucfg[6], CPUCFG6, PMP, 1);
+        cpu->env.cpucfg[6] = FIELD_DP32(cpu->env.cpucfg[6], CPUCFG6, PMNUM, 3);
+        cpu->env.cpucfg[6] = FIELD_DP32(cpu->env.cpucfg[6], CPUCFG6, PMBITS, 63);
+        cpu->env.cpucfg[6] = FIELD_DP32(cpu->env.cpucfg[6], CPUCFG6, UPM, 1);
+    }
+}
+
+static void loongarch_cpu_feature_realize(CPUState *cs, Error **errp)
+{
+    loongarch_cpu_check_pmu(cs, errp);
+}
+
 static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -584,6 +613,11 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     loongarch_cpu_register_gdb_regs_for_features(cs);
+    loongarch_cpu_feature_realize(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     cpu_reset(cs);
     qemu_init_vcpu(cs);
@@ -643,12 +677,34 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
     }
 }
 
+static bool loongarch_get_pmu(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->pmu != ON_OFF_AUTO_OFF;
+}
+
+static void loongarch_set_pmu(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    cpu->pmu = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+}
+
 void loongarch_cpu_post_init(Object *obj)
 {
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
     object_property_add_bool(obj, "lsx", loongarch_get_lsx,
                              loongarch_set_lsx);
     object_property_add_bool(obj, "lasx", loongarch_get_lasx,
                              loongarch_set_lasx);
+
+    if (kvm_enabled()) {
+        cpu->pmu = ON_OFF_AUTO_AUTO;
+        object_property_add_bool(obj, "pmu", loongarch_get_pmu,
+                                 loongarch_set_pmu);
+    } else {
+        cpu->pmu = ON_OFF_AUTO_OFF;
+    }
 }
 
 static void loongarch_cpu_init(Object *obj)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 6c41fafb70..cfc87f7f09 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -281,6 +281,10 @@ struct LoongArchTLB {
 typedef struct LoongArchTLB LoongArchTLB;
 #endif
 
+enum loongarch_features {
+    LOONGARCH_FEATURE_PMU,
+};
+
 typedef struct CPUArchState {
     uint64_t gpr[32];
     uint64_t pc;
@@ -381,6 +385,7 @@ struct ArchCPU {
     CPULoongArchState env;
     QEMUTimer timer;
     uint32_t  phy_id;
+    OnOffAuto pmu;
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 8e6e27c8bf..89f438ec95 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -780,6 +780,22 @@ int kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level)
     return kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &intr);
 }
 
+bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
+{
+    struct kvm_device_attr attr;
+    int ret;
+
+    switch (feature) {
+    case LOONGARCH_FEATURE_PMU:
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_PMU;
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        return (ret == 0);
+    default:
+        return false;
+    }
+}
+
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
diff --git a/target/loongarch/kvm/kvm_loongarch.h b/target/loongarch/kvm/kvm_loongarch.h
index d945b6bb82..bdb4f180eb 100644
--- a/target/loongarch/kvm/kvm_loongarch.h
+++ b/target/loongarch/kvm/kvm_loongarch.h
@@ -13,4 +13,20 @@
 int  kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level);
 void kvm_arch_reset_vcpu(CPULoongArchState *env);
 
+#ifdef CONFIG_KVM
+/*
+ * kvm_feature_supported:
+ *
+ * Returns: true if KVM supports specified feature
+ * and false otherwise.
+ */
+bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature);
+#else
+static inline bool kvm_feature_supported(CPUState *cs,
+                                         enum loongarch_features feature)
+{
+    return false;
+}
+#endif
+
 #endif
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 8721a5eb13..7e1a6fd734 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -40,7 +40,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 }
 
 static const char *cpu_model_advertised_features[] = {
-    "lsx", "lasx", NULL
+    "lsx", "lasx", "pmu", NULL
 };
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-- 
2.33.0


