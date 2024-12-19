Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91C4E7718D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGa-00036e-SU; Thu, 19 Dec 2024 11:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tOG2y-0005ec-EM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:54:32 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tOG2v-0007zd-JF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:54:32 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxieGBF2RnDY9YAA--.45876S3;
 Thu, 19 Dec 2024 20:54:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxXceAF2Rn72gCAA--.14917S3;
 Thu, 19 Dec 2024 20:54:24 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] target/loongarch: Use auto method with LSX feature
Date: Thu, 19 Dec 2024 20:54:23 +0800
Message-Id: <20241219125424.3220321-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241219125424.3220321-1-maobibo@loongson.cn>
References: <20241219125424.3220321-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXceAF2Rn72gCAA--.14917S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Like LBT feature, add type OnOffAuto for LSX feature setting. Also
add LSX feature detection with new VM ioctl command, fallback to old
method if it is not supported.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c     | 38 +++++++++++++++------------
 target/loongarch/cpu.h     |  2 ++
 target/loongarch/kvm/kvm.c | 54 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 57cc4f314b..09dc923f45 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -378,6 +378,7 @@ static void loongarch_la464_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
     CPULoongArchState *env = &cpu->env;
+    uint32_t data = 0;
     int i;
 
     for (i = 0; i < 21; i++) {
@@ -387,7 +388,6 @@ static void loongarch_la464_initfn(Object *obj)
     cpu->dtb_compatible = "loongarch,Loongson-3A5000";
     env->cpucfg[0] = 0x14c010;  /* PRID */
 
-    uint32_t data = 0;
     data = FIELD_DP32(data, CPUCFG1, ARCH, 2);
     data = FIELD_DP32(data, CPUCFG1, PGMMU, 1);
     data = FIELD_DP32(data, CPUCFG1, IOCSR, 1);
@@ -476,7 +476,7 @@ static void loongarch_la132_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
     CPULoongArchState *env = &cpu->env;
-
+    uint32_t data = 0;
     int i;
 
     for (i = 0; i < 21; i++) {
@@ -486,7 +486,6 @@ static void loongarch_la132_initfn(Object *obj)
     cpu->dtb_compatible = "loongarch,Loongson-1C103";
     env->cpucfg[0] = 0x148042;  /* PRID */
 
-    uint32_t data = 0;
     data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
     data = FIELD_DP32(data, CPUCFG1, PGMMU, 1);
     data = FIELD_DP32(data, CPUCFG1, IOCSR, 1);
@@ -614,27 +613,30 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static bool loongarch_get_lsx(Object *obj, Error **errp)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-    bool ret;
-
-    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LSX)) {
-        ret = true;
-    } else {
-        ret = false;
-    }
-    return ret;
+    return LOONGARCH_CPU(obj)->lsx != ON_OFF_AUTO_OFF;
 }
 
 static void loongarch_set_lsx(Object *obj, bool value, Error **errp)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    uint32_t val;
 
-    if (value) {
-        cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LSX, 1);
-    } else {
-        cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LSX, 0);
-        cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LASX, 0);
+    cpu->lsx = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+    if (kvm_enabled()) {
+        /* kvm feature detection in function kvm_arch_init_vcpu */
+        return;
     }
+
+    /* LSX feature detection in TCG mode */
+    val = cpu->env.cpucfg[2];
+    if (cpu->lsx == ON_OFF_AUTO_ON) {
+        if (FIELD_EX32(val, CPUCFG2, LSX) == 0) {
+            error_setg(errp, "Failed to enable LSX in TCG mode");
+            return;
+        }
+    }
+
+    cpu->env.cpucfg[2] = FIELD_DP32(val, CPUCFG2, LSX, value);
 }
 
 static bool loongarch_get_lasx(Object *obj, Error **errp)
@@ -692,6 +694,7 @@ void loongarch_cpu_post_init(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
 
+    cpu->lsx = ON_OFF_AUTO_AUTO;
     object_property_add_bool(obj, "lsx", loongarch_get_lsx,
                              loongarch_set_lsx);
     object_property_add_bool(obj, "lasx", loongarch_get_lasx,
@@ -712,6 +715,7 @@ void loongarch_cpu_post_init(Object *obj)
 
     } else {
         cpu->lbt = ON_OFF_AUTO_OFF;
+        cpu->pmu = ON_OFF_AUTO_OFF;
     }
 }
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 86c86c6c95..5bddf72c22 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -283,6 +283,7 @@ typedef struct LoongArchTLB LoongArchTLB;
 #endif
 
 enum loongarch_features {
+    LOONGARCH_FEATURE_LSX,
     LOONGARCH_FEATURE_LBT, /* loongson binary translation extension */
     LOONGARCH_FEATURE_PMU,
 };
@@ -404,6 +405,7 @@ struct ArchCPU {
     uint32_t  phy_id;
     OnOffAuto lbt;
     OnOffAuto pmu;
+    OnOffAuto lsx;
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index ff81806ca3..390828ef78 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -798,8 +798,35 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
 {
     int ret;
     struct kvm_device_attr attr;
+    uint64_t val;
 
     switch (feature) {
+    case LOONGARCH_FEATURE_LSX:
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_LSX;
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        if (ret == 0) {
+            return true;
+        }
+
+        /* Fallback to old kernel detect interface */
+        val = 0;
+        attr.group = KVM_LOONGARCH_VCPU_CPUCFG;
+        /* Cpucfg2 */
+        attr.attr  = 2;
+        attr.addr = (uint64_t)&val;
+        ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
+        if (!ret) {
+            ret = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
+            if (ret) {
+                return false;
+            }
+
+            ret = FIELD_EX32((uint32_t)val, CPUCFG2, LSX);
+            return (ret != 0);
+        }
+        return false;
+
     case LOONGARCH_FEATURE_LBT:
         /*
          * Return all if all the LBT features are supported such as:
@@ -829,6 +856,28 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
     return false;
 }
 
+static int kvm_cpu_check_lsx(CPUState *cs, Error **errp)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    bool kvm_supported;
+
+    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_LSX);
+    env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, LSX, 0);
+    if (cpu->lsx == ON_OFF_AUTO_ON) {
+        if (kvm_supported) {
+            env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, LSX, 1);
+        } else {
+            error_setg(errp, "'lsx' feature not supported by KVM on this host");
+            return -ENOTSUP;
+        }
+    } else if ((cpu->lsx == ON_OFF_AUTO_AUTO) && kvm_supported) {
+        env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, LSX, 1);
+    }
+
+    return 0;
+}
+
 static int kvm_cpu_check_lbt(CPUState *cs, Error **errp)
 {
     CPULoongArchState *env = cpu_env(cs);
@@ -889,6 +938,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
         brk_insn = val;
     }
 
+    ret = kvm_cpu_check_lsx(cs, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+
     ret = kvm_cpu_check_lbt(cs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
-- 
2.39.3


