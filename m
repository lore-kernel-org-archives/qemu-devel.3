Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE658CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN6Sl-000721-Ja; Wed, 13 May 2026 06:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mengzhuo@iscas.ac.cn>)
 id 1wN6Si-0006yY-Cd; Wed, 13 May 2026 06:05:08 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mengzhuo@iscas.ac.cn>)
 id 1wN6Sf-0007bQ-7u; Wed, 13 May 2026 06:05:07 -0400
Received: from iscas.ac.cn (unknown [113.16.146.186])
 by APP-05 (Coremail) with SMTP id zQCowADXaw+_TARqE8gkEA--.50441S2;
 Wed, 13 May 2026 18:04:48 +0800 (CST)
From: Meng Zhuo <mengzhuo@iscas.ac.cn>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org,
	Meng Zhuo <mengzhuo@iscas.ac.cn>
Subject: [PATCH] target/riscv/kvm: skip FP/Vector sync on KVM_PUT_RUNTIME_STATE
Date: Wed, 13 May 2026 18:04:47 +0800
Message-ID: <20260513100447.2167615-1-mengzhuo@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADXaw+_TARqE8gkEA--.50441S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr13urW7Wr1UCw4UKF1ftFb_yoW8Kr4xpr
 45Ca9xGr1xGrWxC3yIyF4kXF1rWFWxWrZrury2y3y7KF4YkrWYgr1ktFWF9F4DCrW8ur1a
 9F4jyF43u398AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
 MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
 AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
 0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
 v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
 xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-Originating-IP: [113.16.146.186]
X-CM-SenderInfo: pphqw6xkxrqxpvfd2hldfou0/1tbiBwsGEmoES64EdgAAsh
Received-SPF: pass client-ip=159.226.251.25; envelope-from=mengzhuo@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

During KVM exit processing (KVM_PUT_RUNTIME_STATE), QEMU never modifies
FP or Vector registers — only core GPRs/PC and CSRs are potentially
changed.  Re-syncing 32 FP and 32 Vector registers on every KVM exit
wastes 36-68 individual KVM_SET_ONE_REG ioctls per vCPU exit.

Follow the s390x pattern: early return on RUNTIME after syncing core
registers and CSRs.  KVM_PUT_FULL_STATE and KVM_PUT_RESET_STATE continue
to sync everything for correctness during migration and initialization.

Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>
---
 target/riscv/kvm/kvm-cpu.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index b047ffa9c0..12a440971e 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1373,7 +1373,7 @@ int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
 
 int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
-    int ret = 0;
+    int ret;
 
     ret = kvm_riscv_put_regs_core(cs);
     if (ret) {
@@ -1385,6 +1385,17 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
         return ret;
     }
 
+    /*
+     * For RUNTIME_STATE, KVM already has the correct FP and Vector state
+     * from the preceding KVM_RUN exit. QEMU never modifies these registers
+     * during exit handling, so re-syncing is unnecessary.  This saves ~68
+     * KVM_SET_ONE_REG ioctls per vCPU exit.  See also s390x which uses
+     * the same pattern.
+     */
+    if (level == KVM_PUT_RUNTIME_STATE) {
+        return 0;
+    }
+
     ret = kvm_riscv_put_regs_fp(cs);
     if (ret) {
         return ret;
@@ -1395,19 +1406,17 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
         return ret;
     }
 
-    if (KVM_PUT_RESET_STATE == level) {
+    if (level == KVM_PUT_RESET_STATE) {
         RISCVCPU *cpu = RISCV_CPU(cs);
-        if (cs->cpu_index == 0) {
-            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNNABLE);
-        } else {
-            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_STOPPED);
-        }
+        int state = cs->cpu_index == 0 ? KVM_MP_STATE_RUNNABLE
+                                       : KVM_MP_STATE_STOPPED;
+        ret = kvm_riscv_sync_mpstate_to_kvm(cpu, state);
         if (ret) {
             return ret;
         }
     }
 
-    return ret;
+    return 0;
 }
 
 int kvm_arch_release_virq_post(int virq)
-- 
2.47.3


