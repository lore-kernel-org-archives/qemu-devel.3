Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E53C982DA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 02:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8TMN-00040u-Fl; Sun, 20 Sep 2026 22:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x8TML-00040b-CJ
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 22:02:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x8TMI-0007a7-OP
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 22:02:21 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxQNEkkLBqWgsOAA--.41380S3;
 Mon, 21 Sep 2026 10:02:12 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJAxlMwikLBqhisjAA--.47516S2;
 Mon, 21 Sep 2026 10:02:10 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch: Add paravirt preempt feature
Date: Mon, 21 Sep 2026 10:03:33 +0800
Message-ID: <20260921020333.570784-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxlMwikLBqhisjAA--.47516S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAry3CF13Zr1kCw1xuw1fKrX_yoWrJFyrpF
 W7ArWSkrWUGwsakanxJ3Z5urn8GF4xGr4xXa43Ar4rAa1UGFWUZryIyF95KF1DX348XFyS
 qFn5Zr4q9F4fJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Paravirt preempt feature is OnOffAuto type, it is disabled by default,
also the feature detection is added to check whether it is supported
on KVM host.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.h     |  2 ++
 target/loongarch/kvm/kvm.c | 39 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index c592f69885..c6dad2417c 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -302,6 +302,7 @@ enum loongarch_features {
     LOONGARCH_FEATURE_STEALTIME,
     LOONGARCH_FEATURE_PTW,
     LOONGARCH_FEATURE_MSGINT,
+    LOONGARCH_FEATURE_PV_PREEMPT,
 };
 
 typedef struct  LoongArchBT {
@@ -464,6 +465,7 @@ struct ArchCPU {
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

base-commit: c1c18d1e640b64292859ce9f30f3c344edfb0294
-- 
2.54.0


