Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB24FCCD190
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 07:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8wIY-0004RA-LU; Wed, 15 Oct 2025 03:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v8wIV-0004QW-DY
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 03:51:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v8wIP-00056B-C1
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 03:51:47 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxK9KGUu9oH1UWAA--.46304S3;
 Wed, 15 Oct 2025 15:51:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJBxpeSFUu9oUBrlAA--.45820S2;
 Wed, 15 Oct 2025 15:51:33 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [RFC PATCH] target/loongarch: Add kvm support dintc
Date: Wed, 15 Oct 2025 15:27:45 +0800
Message-Id: <20251015072745.3921106-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpeSFUu9oUBrlAA--.45820S2
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

This patch adds set/get msgint CSRs and check msgint feature.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
RFC: this patch need update linux-headers and 
the linux kernel kvm support avec(not merged).

 linux-headers/asm-loongarch/kvm.h |  1 +
 target/loongarch/cpu.h            |  1 +
 target/loongarch/kvm/kvm.c        | 59 ++++++++++++++++++++++++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-loongarch/kvm.h b/linux-headers/asm-loongarch/kvm.h
index 5f354f5c68..20e69561bf 100644
--- a/linux-headers/asm-loongarch/kvm.h
+++ b/linux-headers/asm-loongarch/kvm.h
@@ -103,6 +103,7 @@ struct kvm_fpu {
 #define  KVM_LOONGARCH_VM_FEAT_PMU		5
 #define  KVM_LOONGARCH_VM_FEAT_PV_IPI		6
 #define  KVM_LOONGARCH_VM_FEAT_PV_STEALTIME	7
+#define  KVM_LOONGARCH_VM_FEAT_MSGINT           8
 
 /* Device Control API on vcpu fd */
 #define KVM_LOONGARCH_VCPU_CPUCFG	0
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index b8e3b46c3a..e714b4252e 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -278,6 +278,7 @@ enum loongarch_features {
     LOONGARCH_FEATURE_PMU,
     LOONGARCH_FEATURE_PV_IPI,
     LOONGARCH_FEATURE_STEALTIME,
+    LOONGARCH_FEATURE_MSGINT,
 };
 
 typedef struct  LoongArchBT {
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 4e4f4e79f6..7c48787d97 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -316,6 +316,18 @@ static int kvm_loongarch_get_csr(CPUState *cs)
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(3)),
                            &env->CSR_DMW[3]);
 
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(0)),
+                           &env->CSR_MSGIS[0]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(1)),
+                           &env->CSR_MSGIS[1]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(2)),
+                           &env->CSR_MSGIS[2]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(3)),
+                           &env->CSR_MSGIS[3]);
+
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TVAL),
                            &env->CSR_TVAL);
 
@@ -488,6 +500,19 @@ static int kvm_loongarch_put_csr(CPUState *cs, KvmPutState level)
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(3)),
                            &env->CSR_DMW[3]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(0)),
+                           &env->CSR_MSGIS[0]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(1)),
+                           &env->CSR_MSGIS[1]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(2)),
+                           &env->CSR_MSGIS[2]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(3)),
+                           &env->CSR_MSGIS[3]);
+
     /*
      * timer cfg must be put at last since it is used to enable
      * guest timer
@@ -930,7 +955,11 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
         attr.attr = KVM_LOONGARCH_VM_FEAT_PV_STEALTIME;
         ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
         return (ret == 0);
-
+    case LOONGARCH_FEATURE_MSGINT:
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_MSGINT;
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        return (ret == 0);
     default:
         return false;
     }
@@ -1074,6 +1103,28 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
     return 0;
 }
 
+static int kvm_cpu_check_msgint(CPUState *cs, Error **errp)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    bool kvm_supported;
+
+    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_MSGINT);
+    env->cpucfg[1] = FIELD_DP32(env->cpucfg[1], CPUCFG1, MSG_INT, 0);
+    if (cpu->msgint == ON_OFF_AUTO_ON) {
+        if (kvm_supported) {
+            env->cpucfg[1] = FIELD_DP32(env->cpucfg[1], CPUCFG1, MSG_INT, 1);
+        } else {
+            error_setg(errp, "'msgint' feature not supported by KVM on this host");
+            return -ENOTSUP;
+        }
+    } else if ((cpu->msgint == ON_OFF_AUTO_AUTO) && kvm_supported) {
+        env->cpucfg[1] = FIELD_DP32(env->cpucfg[1], CPUCFG1, MSG_INT, 1);
+    }
+
+    return 0;
+}
+
 int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
 {
     return 0;
@@ -1123,6 +1174,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
 
+    ret = kvm_cpu_check_msgint(cs, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        return ret;
+    }
+
     return 0;
 }
 

base-commit: 3bf5c57a11827d9fa706524d57ee3e5af68a429e
-- 
2.41.0


