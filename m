Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC18C3600B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 01:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txyyE-0002oB-Nz; Thu, 27 Mar 2025 21:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1txyyA-0002nl-Hy
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 21:57:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1txyy7-00010i-2h
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 21:57:14 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxjazuAeZnoeKoAA--.53721S3;
 Fri, 28 Mar 2025 09:57:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMDxPcXqAeZnxeljAA--.34010S3;
 Fri, 28 Mar 2025 09:57:01 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, maobibo@loongson.cn,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 1/1] target/loongarch: Fix the cpu unplug resource leak
Date: Fri, 28 Mar 2025 09:35:16 +0800
Message-Id: <20250328013516.735614-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250328013516.735614-1-gaosong@loongson.cn>
References: <20250328013516.735614-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxPcXqAeZnxeljAA--.34010S3
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

From: Xianglai Li <lixianglai@loongson.cn>

When the cpu is created, qemu_add_vm_change_state_handler
is called in the kvm_arch_init_vcpu function to create
the VMChangeStateEntry resource.

However, the resource is not released when the cpu is destroyed.
This results in a qemu process segment error when the virtual
machine restarts after the cpu is unplugged.

This patch solves the problem by adding the corresponding resource
release process to the kvm_arch_destroy_vcpu function.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20250324123328.518076-1-lixianglai@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.h     | 1 +
 target/loongarch/kvm/kvm.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index eae874c67b..254e4fbdcd 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -426,6 +426,7 @@ struct ArchCPU {
     const char *dtb_compatible;
     /* used by KVM_REG_LOONGARCH_COUNTER ioctl to access guest time counters */
     uint64_t kvm_state_counter;
+    VMChangeStateEntry *vmsentry;
 };
 
 /**
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 7f63e7c8fe..f0e3cfef03 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1080,8 +1080,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
     uint64_t val;
     int ret;
     Error *local_err = NULL;
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
 
-    qemu_add_vm_change_state_handler(kvm_loongarch_vm_stage_change, cs);
+    cpu->vmsentry = qemu_add_vm_change_state_handler(
+                    kvm_loongarch_vm_stage_change, cs);
 
     if (!kvm_get_one_reg(cs, KVM_REG_LOONGARCH_DEBUG_INST, &val)) {
         brk_insn = val;
@@ -1197,6 +1199,9 @@ void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
 {
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+
+    qemu_del_vm_change_state_handler(cpu->vmsentry);
     return 0;
 }
 
-- 
2.34.1


