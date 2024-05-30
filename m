Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00DAC27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 06:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZbo-0007RF-8U; Thu, 30 May 2024 02:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sCZbl-0007QN-18
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:49:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sCZbi-0000iK-1N
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:49:52 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxFPCJIVhmeYgBAA--.6643S3;
 Thu, 30 May 2024 14:49:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx28aFIVhm5+8NAA--.36650S3; 
 Thu, 30 May 2024 14:49:43 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [RFC v3 1/2] target/loongarch: Add loongson binary translation feature
Date: Thu, 30 May 2024 14:49:40 +0800
Message-Id: <20240530064941.1289573-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240530064941.1289573-1-maobibo@loongson.cn>
References: <20240530064941.1289573-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx28aFIVhm5+8NAA--.36650S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

Loongson Binary Translation (LBT) is used to accelerate binary
translation, which contains 4 scratch registers (scr0 to scr3), x86/ARM
eflags (eflags) and x87 fpu stack pointer (ftop).

Now LBT feature is added in kvm mode, not supported in TCG mode since
it is not emulated. Feature variable lbt is added with OnOffAuto type,
If lbt feature is not supported with KVM host, it reports error if there
is lbt=on command line.

If there is no any command line about lbt parameter, it checks whether
KVM host supports lbt feature and set the corresponding value in cpucfg.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c                | 53 +++++++++++++++++++++++++++
 target/loongarch/cpu.h                |  6 +++
 target/loongarch/kvm/kvm.c            | 26 +++++++++++++
 target/loongarch/kvm/kvm_loongarch.h  | 16 ++++++++
 target/loongarch/loongarch-qmp-cmds.c |  2 +-
 5 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index b5c1ec94af..14265b6667 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -571,6 +571,30 @@ static void loongarch_cpu_disas_set_info(CPUState *s, disassemble_info *info)
     info->print_insn = print_insn_loongarch;
 }
 
+static void loongarch_cpu_check_lbt(CPUState *cs, Error **errp)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    bool kvm_supported;
+
+    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_LBT);
+    if (cpu->lbt == ON_OFF_AUTO_ON) {
+        if (kvm_supported) {
+            env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, LBT_ALL, 7);
+        } else {
+            error_setg(errp, "'lbt' feature not supported by KVM on this host");
+            return;
+        }
+    } else if ((cpu->lbt == ON_OFF_AUTO_AUTO) && kvm_supported) {
+        env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, LBT_ALL, 7);
+    }
+}
+
+static void loongarch_cpu_feature_realize(CPUState *cs, Error **errp)
+{
+    loongarch_cpu_check_lbt(cs, errp);
+}
+
 static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -584,6 +608,11 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     loongarch_cpu_register_gdb_regs_for_features(cs);
+    loongarch_cpu_feature_realize(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     cpu_reset(cs);
     qemu_init_vcpu(cs);
@@ -643,12 +672,36 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
     }
 }
 
+static bool loongarch_get_lbt(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->lbt != ON_OFF_AUTO_OFF;
+}
+
+static void loongarch_set_lbt(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    cpu->lbt = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
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
+    /* lbt is enabled only in kvm mode, not supported in tcg mode */
+    if (kvm_enabled()) {
+        cpu->lbt = ON_OFF_AUTO_AUTO;
+        object_property_add_bool(obj, "lbt", loongarch_get_lbt,
+                                 loongarch_set_lbt);
+        object_property_set_description(obj, "lbt",
+                                   "Set off to disable Binary Tranlation.");
+    } else {
+        cpu->lbt = ON_OFF_AUTO_OFF;
+    }
 }
 
 static void loongarch_cpu_init(Object *obj)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 41b8e6d96d..623b96b184 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -152,6 +152,7 @@ FIELD(CPUCFG2, LLFTP_VER, 15, 3)
 FIELD(CPUCFG2, LBT_X86, 18, 1)
 FIELD(CPUCFG2, LBT_ARM, 19, 1)
 FIELD(CPUCFG2, LBT_MIPS, 20, 1)
+FIELD(CPUCFG2, LBT_ALL, 18, 3)
 FIELD(CPUCFG2, LSPW, 21, 1)
 FIELD(CPUCFG2, LAM, 22, 1)
 
@@ -280,6 +281,10 @@ struct LoongArchTLB {
 typedef struct LoongArchTLB LoongArchTLB;
 #endif
 
+enum loongarch_features {
+    LOONGARCH_FEATURE_LBT, /* loongson binary translation extension */
+};
+
 typedef struct CPUArchState {
     uint64_t gpr[32];
     uint64_t pc;
@@ -380,6 +385,7 @@ struct ArchCPU {
     CPULoongArchState env;
     QEMUTimer timer;
     uint32_t  phy_id;
+    OnOffAuto lbt;
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 8e6e27c8bf..55e85eff15 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -780,6 +780,32 @@ int kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level)
     return kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &intr);
 }
 
+bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
+{
+    int ret;
+    struct kvm_device_attr attr;
+
+    switch (feature) {
+    case LOONGARCH_FEATURE_LBT:
+        /*
+         * Return all if all the LBT features are supported such as:
+         *  KVM_LOONGARCH_VM_FEAT_X86BT
+         *  KVM_LOONGARCH_VM_FEAT_ARMBT
+         *  KVM_LOONGARCH_VM_FEAT_MIPSBT
+         */
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_X86BT;
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        attr.attr = KVM_LOONGARCH_VM_FEAT_ARMBT;
+        ret |= kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        attr.attr = KVM_LOONGARCH_VM_FEAT_MIPSBT;
+        ret |= kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
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
index 8721a5eb13..c6f6e1ef85 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -40,7 +40,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 }
 
 static const char *cpu_model_advertised_features[] = {
-    "lsx", "lasx", NULL
+    "lsx", "lasx", "lbt", NULL
 };
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-- 
2.39.3


