Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17794CCF9F7
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 02:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEIhW-00023j-1l; Wed, 29 Oct 2025 22:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vEIhP-000225-US
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 22:47:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vEIhD-0001z2-JS
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 22:47:39 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Cxf9Ov0QJpSXAcAA--.61282S3;
 Thu, 30 Oct 2025 10:47:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxocKn0QJpWSIbAQ--.26243S4;
 Thu, 30 Oct 2025 10:47:11 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 2/2] target/loongarch: Add PTW feature support in KVM mode
Date: Thu, 30 Oct 2025 10:47:03 +0800
Message-Id: <20251030024703.3730929-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251030024703.3730929-1-maobibo@loongson.cn>
References: <20251030024703.3730929-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxocKn0QJpWSIbAQ--.26243S4
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Implement Hardware page table walker(PTW for short) feature in KVM mode.
Use OnOffAuto type variable ptw to check the PTW feature. If the PTW
feature is not supported on KVM host, there is error reported with ptw=on
option.

By default PTW feature is disabled on la464 CPU type, and auto detected
on max CPU type.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c     |  6 +++---
 target/loongarch/cpu.h     |  1 +
 target/loongarch/kvm/kvm.c | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index e80a92fb2e..d74c3c3766 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -236,7 +236,7 @@ static void loongarch_set_ptw(Object *obj, bool value, Error **errp)
     cpu->ptw = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 
     if (kvm_enabled()) {
-        /* PTW feature is only support in TCG mode now */
+        /* kvm feature detection in function kvm_arch_init_vcpu */
         return;
     }
 
@@ -406,14 +406,14 @@ static void loongarch_la132_initfn(Object *obj)
 static void loongarch_max_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-    /* '-cpu max' for TCG: we use cpu la464. */
+    /* '-cpu max': use it for max supported CPU features */
     loongarch_la464_initfn(obj);
 
+    cpu->ptw = ON_OFF_AUTO_AUTO;
     if (tcg_enabled()) {
         cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
         cpu->msgint = ON_OFF_AUTO_AUTO;
         cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, HPTW, 1);
-        cpu->ptw = ON_OFF_AUTO_AUTO;
     }
 }
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index b1d6799222..1a14469b3b 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -279,6 +279,7 @@ enum loongarch_features {
     LOONGARCH_FEATURE_PMU,
     LOONGARCH_FEATURE_PV_IPI,
     LOONGARCH_FEATURE_STEALTIME,
+    LOONGARCH_FEATURE_PTW,
 };
 
 typedef struct  LoongArchBT {
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 4e4f4e79f6..26e40c9bdc 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -931,6 +931,12 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
         ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
         return (ret == 0);
 
+    case LOONGARCH_FEATURE_PTW:
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_PTW;
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        return (ret == 0);
+
     default:
         return false;
     }
@@ -1029,6 +1035,29 @@ static int kvm_cpu_check_pmu(CPUState *cs, Error **errp)
     return 0;
 }
 
+static int kvm_cpu_check_ptw(CPUState *cs, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = cpu_env(cs);
+    bool kvm_supported;
+
+    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PTW);
+    if (cpu->ptw == ON_OFF_AUTO_ON) {
+        if (!kvm_supported) {
+            error_setg(errp, "'ptw' feature not supported by KVM on the host");
+            return -ENOTSUP;
+        }
+    } else if (cpu->ptw != ON_OFF_AUTO_AUTO) {
+        /* disable pmu if ON_OFF_AUTO_OFF is set */
+        kvm_supported = false;
+    }
+
+    if (kvm_supported) {
+        env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, HPTW, 1);
+    }
+    return 0;
+}
+
 static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -1123,6 +1152,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
 
+    ret = kvm_cpu_check_ptw(cs, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        return ret;
+    }
+
     return 0;
 }
 
-- 
2.47.0


