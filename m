Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AA8CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOv7C-00035U-W0; Mon, 18 May 2026 06:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mengzhuo@iscas.ac.cn>)
 id 1wOv6M-0002tw-Ly; Mon, 18 May 2026 06:21:35 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mengzhuo@iscas.ac.cn>)
 id 1wOv6J-0003zm-Sg; Mon, 18 May 2026 06:21:34 -0400
Received: from iscas.ac.cn (unknown [113.12.18.145])
 by APP-05 (Coremail) with SMTP id zQCowAAHlwof6ApqzvKcEA--.3899S2;
 Mon, 18 May 2026 18:21:19 +0800 (CST)
From: Meng Zhuo <mengzhuo@iscas.ac.cn>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org,
	Meng Zhuo <mengzhuo@iscas.ac.cn>
Subject: [PATCH v3] target/riscv/kvm: skip FP/Vector sync on
 KVM_PUT_RUNTIME_STATE
Date: Mon, 18 May 2026 18:21:18 +0800
Message-ID: <20260518102118.2768383-1-mengzhuo@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAHlwof6ApqzvKcEA--.3899S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr13urW7Wr1UCw4UKF1ftFb_yoW8Zr1fpr
 47Ga9xGr17GrWxCw1SyF1kXFWrWrWfWrWDur9Fyw47Kan0krWYgr1kKFyF9F1DCrW8ArWa
 9F4jyrW3urZ8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
X-Originating-IP: [113.12.18.145]
X-CM-SenderInfo: pphqw6xkxrqxpvfd2hldfou0/1tbiBg0LEmoKqNj-7wAAsS
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
 target/riscv/kvm/kvm-cpu.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index b047ffa9c0..dd4193ea8b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
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
+    if (KVM_PUT_RUNTIME_STATE == level) {
+        return ret;
+    }
+
     ret = kvm_riscv_put_regs_fp(cs);
     if (ret) {
         return ret;
@@ -1397,11 +1408,9 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 
     if (KVM_PUT_RESET_STATE == level) {
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
-- 
2.47.3


