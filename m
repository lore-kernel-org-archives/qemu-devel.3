Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB2BC5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuTdm-0001R5-If; Thu, 13 Aug 2026 07:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wuTdh-0001Pq-PU
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 07:30:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wuTdb-0004Ed-T5
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 07:30:24 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxYdHAqn1qwOMAAA--.2859S3;
 Thu, 13 Aug 2026 19:30:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxOs6+qn1q5lQDAA--.4396S3;
 Thu, 13 Aug 2026 19:30:08 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	lixianglai@loongson.cn
Subject: [PATCH v4 1/3] target/loongarch: Add kvm support dintc
Date: Thu, 13 Aug 2026 19:09:58 +0800
Message-Id: <20260813111000.446232-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260813111000.446232-1-gaosong@loongson.cn>
References: <20260813111000.446232-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxOs6+qn1q5lQDAA--.4396S3
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch adds Kvm put/get msgint CSRs and check msgint feature.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c     |  5 ++-
 target/loongarch/cpu.h     |  1 +
 target/loongarch/kvm/kvm.c | 74 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fb03424ffa..a241135227 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -450,9 +450,6 @@ static void loongarch_max_initfn(Object *obj)
 
     cpu->ptw = ON_OFF_AUTO_AUTO;
     if (tcg_enabled()) {
-        cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
-        cpu->msgint = ON_OFF_AUTO_AUTO;
-
         uint32_t data = cpu->env.cpucfg[2];
         data = FIELD_DP32(data, CPUCFG2, HPTW, 1);
         /* Enable LA v1.1 instructions */
@@ -467,6 +464,8 @@ static void loongarch_max_initfn(Object *obj)
         data = FIELD_DP32(data, CPUCFG3, DBAR_HINTS, 1);
         cpu->env.cpucfg[3] = data;
     }
+    cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
+    cpu->msgint = ON_OFF_AUTO_AUTO;
 }
 
 #if defined(CONFIG_KVM)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ad30c73167..97db3b453f 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -301,6 +301,7 @@ enum loongarch_features {
     LOONGARCH_FEATURE_PV_IPI,
     LOONGARCH_FEATURE_STEALTIME,
     LOONGARCH_FEATURE_PTW,
+    LOONGARCH_FEATURE_MSGINT,
 };
 
 typedef struct  LoongArchBT {
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 4d0cad5732..15082a01f8 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -36,6 +36,13 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
 
+static bool kvm_cpu_has_msgint(CPUState *cs)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+
+    return FIELD_EX64(cpu->env.cpucfg[1], CPUCFG1, MSG_INT);
+}
+
 static int kvm_get_stealtime(CPUState *cs)
 {
     CPULoongArchState *env = cpu_env(cs);
@@ -362,6 +369,25 @@ static int kvm_loongarch_get_csr(CPUState *cs)
 
     ret |= kvm_loongarch_get_pmu(cs);
 
+    /*
+     * CSR register MSGIS getting must be put after CSR register CSR_ESTAT,
+     * Since register CSR_ESTAT will sync software pending MSGINT status to
+     * hardware register and modify HW CSR MSGIS registers.
+     */
+    if (kvm_cpu_has_msgint(cs)) {
+        ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(0)),
+                               &sys->CSR_MSGIS[0]);
+
+        ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(1)),
+                               &sys->CSR_MSGIS[1]);
+
+        ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(2)),
+                               &sys->CSR_MSGIS[2]);
+
+        ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(3)),
+                               &sys->CSR_MSGIS[3]);
+    }
+
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TVAL),
                            &sys->CSR_TVAL);
 
@@ -538,6 +564,20 @@ static int kvm_loongarch_put_csr(CPUState *cs, KvmPutState level)
 
     ret |= kvm_loongarch_put_pmu(cs);
 
+    if (kvm_cpu_has_msgint(cs)) {
+        ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(0)),
+                               &sys->CSR_MSGIS[0]);
+
+        ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(1)),
+                               &sys->CSR_MSGIS[1]);
+
+        ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(2)),
+                               &sys->CSR_MSGIS[2]);
+
+        ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(3)),
+                               &sys->CSR_MSGIS[3]);
+    }
+
     /*
      * timer cfg must be put at last since it is used to enable
      * guest timer
@@ -993,6 +1033,12 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
         ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
         return (ret == 0);
 
+    case LOONGARCH_FEATURE_MSGINT:
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_MSGINT;
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        return (ret == 0);
+
     default:
         return false;
     }
@@ -1166,6 +1212,28 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
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
@@ -1221,6 +1289,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
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
 
-- 
2.47.3


