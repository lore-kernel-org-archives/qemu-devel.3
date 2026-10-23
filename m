Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1BD606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4Om-00064y-He; Thu, 22 Oct 2026 21:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xK4OK-0005xc-OX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:48:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xK4OH-0005pA-2M
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:48:20 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxKvDcvNpqDZsYAA--.6003S3;
 Fri, 23 Oct 2026 09:48:12 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxGs7avNpqxl8vAA--.7626S4;
 Fri, 23 Oct 2026 09:48:11 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 06/10] target/loongarch: Add paravirt preempt feature
Date: Fri, 23 Oct 2026 09:49:26 +0800
Message-ID: <20261023014931.4055823-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023014931.4055823-1-maobibo@loongson.cn>
References: <20261023014931.4055823-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxGs7avNpqxl8vAA--.7626S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1furWrZr43Gr13tr17XFc_yoWrJF4fpF
 W7ZrWS9rWUGws2kanxJ3Z5urn8GF4xGr4xXa4ayr1rAa1UGF4UXr1IyF95KF1DX348XFyS
 qFn5Zr4q9F4fJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UMpBfUUUUU=
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Paravirt preempt feature is OnOffAuto type, it is disabled by default,
also the feature detection is added to check whether it is supported
on KVM host.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>
---
 target/loongarch/cpu.h     |  2 ++
 target/loongarch/kvm/kvm.c | 39 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 77ea8f03f9..4ab81e0f7b 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -302,6 +302,7 @@ enum loongarch_features {
     LOONGARCH_FEATURE_STEALTIME,
     LOONGARCH_FEATURE_PTW,
     LOONGARCH_FEATURE_MSGINT,
+    LOONGARCH_FEATURE_PV_PREEMPT,
 };
 
 typedef struct  LoongArchBT {
@@ -465,6 +466,7 @@ struct ArchCPU {
     OnOffAuto msgint;
     OnOffAuto kvm_pv_ipi;
     OnOffAuto kvm_steal_time;
+    OnOffAuto kvm_pv_preempt;
     int32_t socket_id;  /* socket-id of this CPU */
     int32_t core_id;    /* core-id of this CPU */
     int32_t thread_id;  /* thread-id of this CPU */
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 941142305e..7ca95181a1 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1039,6 +1039,12 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
         ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
         return (ret == 0);
 
+    case LOONGARCH_FEATURE_PV_PREEMPT:
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_PV_PREEMPT,
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        return (ret == 0);
+
     default:
         return false;
     }
@@ -1203,6 +1209,21 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
         env->pv_features |= BIT(KVM_FEATURE_STEAL_TIME);
     }
 
+    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PV_PREEMPT);
+    if (cpu->kvm_pv_preempt == ON_OFF_AUTO_ON) {
+        if (!kvm_supported) {
+            error_setg(errp, "'pv preempt' feature not supported by KVM host");
+            return -ENOTSUP;
+        }
+    } else if (cpu->kvm_pv_preempt != ON_OFF_AUTO_AUTO) {
+        kvm_supported = false;
+    }
+
+    /* Feature preempt_hint depends on steal_time */
+    if (kvm_supported && (cpu->kvm_pv_preempt == ON_OFF_AUTO_ON)) {
+        env->pv_features |= BIT(KVM_FEATURE_PREEMPT);
+     }
+
     if (object_dynamic_cast(OBJECT(ms), TYPE_LOONGARCH_VIRT_MACHINE)) {
         LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
 
@@ -1412,6 +1433,18 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
     cpu->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 }
 
+static bool kvm_pv_preempt_get(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->kvm_pv_preempt != ON_OFF_AUTO_OFF;
+}
+
+static void kvm_pv_preempt_set(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    cpu->kvm_pv_preempt = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+}
+
 void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
 {
     cpu->lbt = ON_OFF_AUTO_AUTO;
@@ -1437,6 +1470,12 @@ void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
                              kvm_steal_time_set);
     object_property_set_description(OBJECT(cpu), "kvm-steal-time",
                                     "Set off to disable KVM steal time.");
+
+    cpu->kvm_pv_preempt = ON_OFF_AUTO_OFF;
+    object_property_add_bool(OBJECT(cpu), "kvm-pv-preempt", kvm_pv_preempt_get,
+                             kvm_pv_preempt_set);
+    object_property_set_description(OBJECT(cpu), "kvm-pv-preempt",
+                                    "Set off to disable KVM paravirt preempt.");
 }
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
-- 
2.54.0


