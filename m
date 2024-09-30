Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D010CF6491
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 07:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svAYJ-0005jn-9u; Mon, 30 Sep 2024 03:10:44 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1svAY6-0005iS-Vz
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:10:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1svAXM-0006iX-J6
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:10:14 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxhbDpR_pm_HIEAA--.4289S3;
 Mon, 30 Sep 2024 14:40:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxHeToR_pms+wVAA--.59376S2;
 Mon, 30 Sep 2024 14:40:40 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2] target/loongarch: Add steal time support on migration
Date: Mon, 30 Sep 2024 14:40:40 +0800
Message-Id: <20240930064040.753929-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHeToR_pms+wVAA--.59376S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
of each vcpu and notify new host during migration. Here two
functions kvm_get_stealtime/kvm_set_stealtime, and guest steal time
physical address is only updated on KVM_PUT_FULL_STATE stage.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
v1 ... v2:
  1. Call function kvm_set_stealtime() at kvm_arch_put_registers()
     rather than new added cpu_post_load() interface

---
 target/loongarch/cpu.h     |  3 ++
 target/loongarch/kvm/kvm.c | 65 ++++++++++++++++++++++++++++++++++++++
 target/loongarch/machine.c |  6 ++--
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 6c41fafb70..c99b72ae16 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -346,6 +346,9 @@ typedef struct CPUArchState {
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
+    struct {
+        uint64_t guest_addr;
+    } stealtime;
 
 #ifdef CONFIG_TCG
     float_status fp_status;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 4786cd5efa..27d4a2783b 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -33,6 +33,55 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
 
+static int kvm_get_stealtime(CPUState *cs)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    int err;
+    struct kvm_device_attr attr = {
+        .group = KVM_LOONGARCH_VCPU_PVTIME_CTRL,
+        .attr = KVM_LOONGARCH_VCPU_PVTIME_GPA,
+        .addr = (uint64_t)&env->stealtime.guest_addr,
+    };
+
+    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
+    if (err) {
+        return 0;
+    }
+
+    err = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, attr);
+    if (err) {
+        error_report("PVTIME: KVM_GET_DEVICE_ATTR: %s", strerror(errno));
+        return err;
+    }
+
+    return 0;
+}
+
+static int kvm_set_stealtime(CPUState *cs)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    int err;
+    struct kvm_device_attr attr = {
+        .group = KVM_LOONGARCH_VCPU_PVTIME_CTRL,
+        .attr = KVM_LOONGARCH_VCPU_PVTIME_GPA,
+        .addr = (uint64_t)&env->stealtime.guest_addr,
+    };
+
+    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
+    if (err) {
+        return 0;
+    }
+
+    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
+    if (err) {
+        error_report("PVTIME: KVM_SET_DEVICE_ATTR %s with gpa "TARGET_FMT_lx,
+                      strerror(errno), env->stealtime.guest_addr);
+        return err;
+    }
+
+    return 0;
+}
+
 static int kvm_loongarch_get_regs_core(CPUState *cs)
 {
     int ret = 0;
@@ -612,6 +661,11 @@ int kvm_arch_get_registers(CPUState *cs)
         return ret;
     }
 
+    ret = kvm_get_stealtime(cs);
+    if (ret) {
+        return ret;
+    }
+
     ret = kvm_loongarch_get_mpstate(cs);
     return ret;
 }
@@ -640,6 +694,17 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
+    if (level >= KVM_PUT_FULL_STATE) {
+        /*
+         * only KVM_PUT_FULL_STATE is required, kvm kernel will clear
+         * guest_addr for KVM_PUT_RESET_STATE
+         */
+        ret = kvm_set_stealtime(cs);
+        if (ret) {
+            return ret;
+        }
+    }
+
     ret = kvm_loongarch_put_mpstate(cs);
     return ret;
 }
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 08a7fa5370..0b6f4f5551 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -145,8 +145,8 @@ static const VMStateDescription vmstate_tlb = {
 /* LoongArch CPU state */
 const VMStateDescription vmstate_loongarch_cpu = {
     .name = "cpu",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
         VMSTATE_UINTTL(env.pc, LoongArchCPU),
@@ -209,6 +209,8 @@ const VMStateDescription vmstate_loongarch_cpu = {
         VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
 
         VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
+        /* PV steal time */
+        VMSTATE_UINT64(env.stealtime.guest_addr, LoongArchCPU),
 
         VMSTATE_END_OF_LIST()
     },

base-commit: 3b14a767eaca3df5534a162851f04787b363670e
-- 
2.39.3


