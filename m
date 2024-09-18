Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF75CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 08:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqpyJ-0005Tr-Mb; Wed, 18 Sep 2024 04:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sqpyG-0005T0-Mm
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 04:23:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sqpyC-0006BU-TT
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 04:23:32 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dxlej6jepmuIgKAA--.22984S3;
 Wed, 18 Sep 2024 16:23:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxHeT5jepmG1oJAA--.53764S2;
 Wed, 18 Sep 2024 16:23:21 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch/kvm: Implement LoongArch PMU extension
Date: Wed, 18 Sep 2024 16:23:15 +0800
Message-Id: <20240918082315.2345034-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHeT5jepmG1oJAA--.53764S2
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement PMU extension for LoongArch kvm mode. Use OnOffAuto type
variable pmu to check the PMU feature. If the PMU Feature is not supported
with KVM host, it reports error if there is pmu=on command line.

If there is no any command line about pmu parameter, it checks whether
KVM host supports the PMU Feature and set the corresponding value in cpucfg.

This patch is based on lbt patch located at
  https://lore.kernel.org/qemu-devel/20240904061859.86615-1-maobibo@loongson.cn

Co-developed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c                | 19 +++++++++++++
 target/loongarch/cpu.h                |  2 ++
 target/loongarch/kvm/kvm.c            | 41 +++++++++++++++++++++++++++
 target/loongarch/loongarch-qmp-cmds.c |  2 +-
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 29577e6b71..57cc4f314b 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -676,6 +676,18 @@ static void loongarch_set_lbt(Object *obj, bool value, Error **errp)
     cpu->lbt = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
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
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
@@ -691,6 +703,13 @@ void loongarch_cpu_post_init(Object *obj)
                                  loongarch_set_lbt);
         object_property_set_description(obj, "lbt",
                                    "Set off to disable Binary Tranlation.");
+
+        cpu->pmu = ON_OFF_AUTO_AUTO;
+        object_property_add_bool(obj, "pmu", loongarch_get_pmu,
+                                 loongarch_set_pmu);
+        object_property_set_description(obj, "pmu",
+                                   "Set off to performance monitor unit.");
+
     } else {
         cpu->lbt = ON_OFF_AUTO_OFF;
     }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 0d0a5a58a8..95336f9e6f 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -284,6 +284,7 @@ typedef struct LoongArchTLB LoongArchTLB;
 
 enum loongarch_features {
     LOONGARCH_FEATURE_LBT, /* loongson binary translation extension */
+    LOONGARCH_FEATURE_PMU,
 };
 
 typedef struct  LoongArchBT {
@@ -399,6 +400,7 @@ struct ArchCPU {
     QEMUTimer timer;
     uint32_t  phy_id;
     OnOffAuto lbt;
+    OnOffAuto pmu;
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 208d090f21..eff9a89af3 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -748,9 +748,18 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
         attr.attr = KVM_LOONGARCH_VM_FEAT_MIPSBT;
         ret |= kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
         return (ret == 0);
+
+    case LOONGARCH_FEATURE_PMU:
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_PMU;
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        return (ret == 0);
+
     default:
         return false;
     }
+
+    return false;
 }
 
 static int kvm_cpu_check_lbt(CPUState *cs, Error **errp)
@@ -774,6 +783,32 @@ static int kvm_cpu_check_lbt(CPUState *cs, Error **errp)
     return 0;
 }
 
+static int kvm_cpu_check_pmu(CPUState *cs, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = cpu_env(cs);
+    bool kvm_supported;
+
+    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PMU);
+    if (cpu->pmu == ON_OFF_AUTO_ON) {
+        if (!kvm_supported) {
+            error_setg(errp, "'pmu' feature not supported by KVM on the host");
+            return -ENOTSUP;
+        }
+    } else if (cpu->pmu != ON_OFF_AUTO_AUTO) {
+        /* disable pmu if ON_OFF_AUTO_OFF is set */
+        kvm_supported = false;
+    }
+
+    if (kvm_supported) {
+        env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMP, 1);
+        env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMNUM, 3);
+        env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMBITS, 63);
+        env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, UPM, 1);
+    }
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     uint64_t val;
@@ -791,6 +826,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (ret < 0) {
         error_report_err(local_err);
     }
+
+    ret = kvm_cpu_check_pmu(cs, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+
     return ret;
 }
 
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index c6f6e1ef85..782fd511fd 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -40,7 +40,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 }
 
 static const char *cpu_model_advertised_features[] = {
-    "lsx", "lasx", "lbt", NULL
+    "lsx", "lasx", "lbt", "pmu", NULL
 };
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,

base-commit: 2b81c046252fbfb375ad30632362fc16e6e22bd5
-- 
2.39.3


