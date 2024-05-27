Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ED1C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 09:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBWoX-00017m-7B; Mon, 27 May 2024 05:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sBWoQ-00016d-Gn
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:38:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sBWoN-0005TF-Qj
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:38:38 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxcPCWVFRm5SwAAA--.896S3;
 Mon, 27 May 2024 17:38:31 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxXceWVFRmof4KAA--.29396S2; 
 Mon, 27 May 2024 17:38:30 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [RFC ] target/loongarch: Add steal time physical address in vmstate
Date: Mon, 27 May 2024 17:38:30 +0800
Message-Id: <20240527093830.846000-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXceWVFRmof4KAA--.29396S2
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

With pv steal time supported, VM machine needs get physical address
of each vcpu and notify to new host during migration. Here two
functions kvm_loongarch_get_stealtime/kvm_loongarch_put_stealtime
are provided and they are called in cpu_pre_save/cpu_post_load
separately.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.h               |  3 ++
 target/loongarch/kvm/kvm.c           | 49 ++++++++++++++++++++++++++++
 target/loongarch/kvm/kvm_loongarch.h | 12 +++++++
 target/loongarch/machine.c           | 24 +++++++++++++-
 4 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 8fc99b8ee8..66e9dd227e 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -390,6 +390,9 @@ typedef struct CPUArchState {
 
     struct loongarch_boot_info *boot_info;
 #endif
+    struct {
+        uint64_t guest_addr;
+    } st;
 } CPULoongArchState;
 
 /**
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index c9c240a573..c7f1b262dd 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -626,6 +626,55 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
     return ret;
 }
 
+int kvm_loongarch_get_stealtime(LoongArchCPU *cpu)
+{
+    CPULoongArchState *env = &cpu->env;
+    int err;
+    struct kvm_device_attr attr = {
+        .group = KVM_LOONGARCH_VCPU_PVTIME_CTRL,
+        .attr = KVM_LOONGARCH_VCPU_PVTIME_GPA,
+        .addr = (uint64_t)&env->st.guest_addr,
+    };
+
+    err = kvm_vcpu_ioctl(CPU(cpu), KVM_HAS_DEVICE_ATTR, attr);
+    if (err) {
+        return 0;
+    }
+
+    err = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_DEVICE_ATTR, attr);
+    if (err) {
+        error_report("PVTIME: KVM_GET_DEVICE_ATTR: %s", strerror(errno));
+        return err;
+    }
+
+    return 0;
+}
+
+int kvm_loongarch_put_stealtime(LoongArchCPU *cpu)
+{
+    CPULoongArchState *env = &cpu->env;
+    int err;
+    struct kvm_device_attr attr = {
+        .group = KVM_LOONGARCH_VCPU_PVTIME_CTRL,
+        .attr = KVM_LOONGARCH_VCPU_PVTIME_GPA,
+        .addr = (uint64_t)&env->st.guest_addr,
+    };
+
+    err = kvm_vcpu_ioctl(CPU(cpu), KVM_HAS_DEVICE_ATTR, attr);
+    if (err) {
+        return 0;
+    }
+
+    err = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_DEVICE_ATTR, attr);
+    if (err) {
+        error_report("PVTIME: KVM_SET_DEVICE_ATTR %s with gpa "TARGET_FMT_lx,
+                      strerror(errno), env->st.guest_addr);
+        return err;
+    }
+
+    return 0;
+}
+
 int kvm_arch_get_registers(CPUState *cs)
 {
     int ret;
diff --git a/target/loongarch/kvm/kvm_loongarch.h b/target/loongarch/kvm/kvm_loongarch.h
index bdb4f180eb..d34a16515f 100644
--- a/target/loongarch/kvm/kvm_loongarch.h
+++ b/target/loongarch/kvm/kvm_loongarch.h
@@ -12,6 +12,8 @@
 
 int  kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level);
 void kvm_arch_reset_vcpu(CPULoongArchState *env);
+int  kvm_loongarch_get_stealtime(LoongArchCPU *cpu);
+int  kvm_loongarch_put_stealtime(LoongArchCPU *cpu);
 
 #ifdef CONFIG_KVM
 /*
@@ -27,6 +29,16 @@ static inline bool kvm_feature_supported(CPUState *cs,
 {
     return false;
 }
+
+static inline int kvm_loongarch_get_stealtime(LoongArchCPU *cpu)
+{
+    return 0;
+}
+
+static inline int kvm_loongarch_put_stealtime(LoongArchCPU *cpu)
+{
+    return 0;
+}
 #endif
 
 #endif
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index a371d5a2ab..344913703b 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -7,7 +7,9 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "kvm/kvm_loongarch.h"
 #include "migration/cpu.h"
+#include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
 #include "vec.h"
 
@@ -165,11 +167,29 @@ static const VMStateDescription vmstate_tlb = {
 };
 #endif
 
+static int cpu_post_load(void *opaque, int version_id)
+{
+    LoongArchCPU *cpu = opaque;
+
+    kvm_loongarch_put_stealtime(cpu);
+    return 0;
+}
+
+static int cpu_pre_save(void *opaque)
+{
+    LoongArchCPU *cpu = opaque;
+
+    kvm_loongarch_get_stealtime(cpu);
+    return 0;
+}
+
 /* LoongArch CPU state */
 const VMStateDescription vmstate_loongarch_cpu = {
     .name = "cpu",
-    .version_id = 2,
+    .version_id = 3,
     .minimum_version_id = 2,
+    .post_load = cpu_post_load,
+    .pre_save = cpu_pre_save,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
         VMSTATE_UINTTL(env.pc, LoongArchCPU),
@@ -232,6 +252,8 @@ const VMStateDescription vmstate_loongarch_cpu = {
         VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
 
         VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
+        /* PV steal time */
+        VMSTATE_UINT64(env.st.guest_addr, LoongArchCPU),
 
         VMSTATE_END_OF_LIST()
     },

base-commit: ffdd099a782556b9ead26551a6f1d070a595306d
-- 
2.39.3


