Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDF5C4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 07:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbbAH-0004fL-QS; Sun, 18 Feb 2024 02:00:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rbbAF-0004et-EW
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 02:00:39 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rbbAB-0007kJ-Ux
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 02:00:38 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxuvAKq9FlBRMOAA--.37757S3;
 Sun, 18 Feb 2024 15:00:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzxMJq9Fli5U6AA--.29360S2; 
 Sun, 18 Feb 2024 15:00:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [RFC PATCH] target/loongarch/kvm: Add software breakpoint support
Date: Sun, 18 Feb 2024 15:00:25 +0800
Message-Id: <20240218070025.218680-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzxMJq9Fli5U6AA--.29360S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw1fXrykGF4rXFyxZw1UArc_yoW5urW8pF
 y7Arn8Gr45J3y3Gw1fJw4DZF43ZrZ7WrsrJ34Sg34SkF17Jr15Ar1kK3yqyFWru348W3WS
 vFs3XFW3u3WqqwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
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

With KVM virtualization, debug exception is passthrough to
to guest kernel rather than host mode. Here hypercall
instruction with special hypercall code is used for sw
breakpoint usage.

Now only software breakpoint is supported, and itt is allowed
to insert/remove software breakpoint. Later hardware  breakpoint
will be added.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/kvm/kvm.c | 77 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index c19978a970..49d02076ad 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -29,6 +29,7 @@
 #include "trace.h"
 
 static bool cap_has_mp_state;
+static unsigned int brk_insn;
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
@@ -675,7 +676,14 @@ static void kvm_loongarch_vm_stage_change(void *opaque, bool running,
 
 int kvm_arch_init_vcpu(CPUState *cs)
 {
+    uint64_t val;
+
     qemu_add_vm_change_state_handler(kvm_loongarch_vm_stage_change, cs);
+
+    if (!kvm_get_one_reg(cs, KVM_REG_LOONGARCH_DEBUG_INST, &val)) {
+        brk_insn = val;
+    }
+
     return 0;
 }
 
@@ -755,6 +763,68 @@ bool kvm_arch_cpu_check_are_resettable(void)
     return true;
 }
 
+
+void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg)
+{
+    if (kvm_sw_breakpoints_active(cpu)) {
+        dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
+    }
+}
+
+int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+{
+    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
+        cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4, 1)) {
+        error_report("%s failed", __func__);
+        return -EINVAL;
+    }
+    return 0;
+}
+
+int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+{
+    static uint32_t brk;
+
+    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk, 4, 0) ||
+        brk != brk_insn ||
+        cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
+        error_report("%s failed", __func__);
+        return -EINVAL;
+    }
+    return 0;
+}
+
+int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
+{
+    return -ENOSYS;
+}
+
+int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
+{
+    return -ENOSYS;
+}
+
+void kvm_arch_remove_all_hw_breakpoints(void)
+{
+}
+
+static bool kvm_loongarch_handle_debug(CPUState *cs, struct kvm_run *run)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+
+    kvm_cpu_synchronize_state(cs);
+    if (cs->singlestep_enabled) {
+        return true;
+    }
+
+    if (kvm_find_sw_breakpoint(cs, env->pc)) {
+        return true;
+    }
+
+    return false;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
@@ -774,6 +844,13 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
                          run->iocsr_io.len,
                          run->iocsr_io.is_write);
         break;
+
+    case KVM_EXIT_DEBUG:
+        if (kvm_loongarch_handle_debug(cs, run)) {
+            ret = EXCP_DEBUG;
+        }
+        break;
+
     default:
         ret = -1;
         warn_report("KVM: unknown exit reason %d", run->exit_reason);

base-commit: 5767815218efd3cbfd409505ed824d5f356044ae
-- 
2.39.3


