Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E995CC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRoop-0000HO-RC; Thu, 11 Jul 2024 04:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sRoof-00082a-9s
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:06:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sRooQ-0001ua-VY
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:06:12 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxL_Fkko9mxC4DAA--.10121S3;
 Thu, 11 Jul 2024 16:05:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxNMVfko9mXttDAA--.13828S8; 
 Thu, 11 Jul 2024 16:05:56 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 6/9] target/loongarch/kvm: Add software breakpoint support
Date: Thu, 11 Jul 2024 15:48:26 +0800
Message-Id: <20240711074829.3338879-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240711074829.3338879-1-gaosong@loongson.cn>
References: <20240711074829.3338879-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxNMVfko9mXttDAA--.13828S8
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

From: Bibo Mao <maobibo@loongson.cn>

With KVM virtualization, debug exception is injected to guest kernel
rather than host for normal break intruction. Here hypercall
instruction with special code is used for sw breakpoint usage,
and detailed instruction comes from kvm kernel with user API
KVM_REG_LOONGARCH_DEBUG_INST.

Now only software breakpoint is supported, and it is allowed to
insert/remove software breakpoint. We can debug guest kernel with gdb
method after kernel is loaded, hardware breakpoint will be added in later.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Tested-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240607035016.2975799-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 configs/targets/loongarch64-softmmu.mak |  1 +
 target/loongarch/kvm/kvm.c              | 76 +++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index 84beb19b90..65b65e0c34 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -1,5 +1,6 @@
 TARGET_ARCH=loongarch64
 TARGET_BASE_ARCH=loongarch
+TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
 # all boards require libfdt
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 8e6e27c8bf..e1be6a6959 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -28,6 +28,7 @@
 #include "trace.h"
 
 static bool cap_has_mp_state;
+static unsigned int brk_insn;
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
@@ -664,7 +665,14 @@ static void kvm_loongarch_vm_stage_change(void *opaque, bool running,
 
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
 
@@ -739,6 +747,67 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
     return true;
 }
 
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
@@ -757,6 +826,13 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
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
-- 
2.34.1


