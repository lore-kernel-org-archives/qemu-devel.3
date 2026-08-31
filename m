Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEBBC624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0weU-0003hI-FK; Mon, 31 Aug 2026 03:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1x0weS-0003eL-TV; Mon, 31 Aug 2026 03:41:56 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1x0weQ-00052o-H0; Mon, 31 Aug 2026 03:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=QHWoB8L1QdgmjIJacxbVgFVoXkhd0BIYoM
 pVj7+RDWg=; b=mxPKdlP91ZPeUfrirR4LyBYl4H1nMJfoo3Jn43L7aDtxJfSMGf
 vK9h8Z/AKwJqwAzXksdq1Nclp7adWz0arCn3L3vsPFOoDszakEzo+rEmCvQFJQd7
 PsNiFw2HKFdV4MZTniOqnWrZ9nKXV8IJJeJf7DBX2CSm2JaUEaIWTHjno=
Received: from ur-dp1000 (unknown [192.168.100.1])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAfwDHQAceMJVq4BUAAA--.112S4; 
 Mon, 31 Aug 2026 15:41:59 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-stable@nongnu.org,
 Xie Bo <xb@ultrarisc.com>
Subject: [PATCH 2/3] target/riscv/kvm: Reject migration with a different timer
 frequency
Date: Mon, 31 Aug 2026 15:41:05 +0800
Message-ID: <20260831074106.1798671-3-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831074106.1798671-1-xb@ultrarisc.com>
References: <20260831074106.1798671-1-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHQAceMJVq4BUAAA--.112S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtryfJw47XrW7uryfGrykZrb_yoW7WF4xpF
 s5G3y3Crn8Xr93tw1fJr1DGry5Crs5uFnxC348Cr4Iva13JrWDXFZ2ga47ZF4fAFWDGwnx
 uFn5uFnI9F45ZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUml14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
 0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
 IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
 Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
 xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E
 4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
 WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
 Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
 WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
 JbIYCTnIWIevJa73UjIFyTuYvjfUbfO7UUUUU
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAMB2qOWvsAQwAPsD
X-Host-Lookup-Failed: Reverse DNS lookup failed for 218.76.62.146 (failed)
Received-SPF: pass client-ip=218.76.62.146; envelope-from=xb@ultrarisc.com;
 helo=ultrarisc.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The timer frequency check is currently in kvm_riscv_put_regs_timer()
and guarded by migration_is_running().  That condition is false on the
incoming side, and the source frequency is not part of the migration
stream, so migration between hosts with different frequencies completes.

Add the source frequency to a KVM-only subsection.  Its post_load checks
the destination frequency before the timer registers are restored and
rejects a mismatch.  When loading an older stream without the subsection,
skip the check and retain the old behavior.

Fixes: 27abe66f31ef ("target/riscv: Add kvm_riscv_get/put_regs_timer")
Signed-off-by: Xie Bo <xb@ultrarisc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/cpu.h           |  1 +
 target/riscv/kvm/kvm-cpu.c   | 40 +++++++++++++++++++++++-------------
 target/riscv/kvm/kvm_riscv.h |  1 +
 target/riscv/machine.c       | 31 ++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a5ec69c3cc..193f81f00d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -541,6 +541,7 @@ struct CPUArchState {
     uint64_t kvm_timer_compare;
     uint64_t kvm_timer_state;
     uint64_t kvm_timer_frequency;
+    bool kvm_timer_frequency_loaded;
 
     /* KVM multiprocessor state */
     uint32_t kvm_mp_state;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c8ccd9124e..1993bd446b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -45,7 +45,6 @@
 #include "kvm_riscv.h"
 #include "sbi_ecall_interface.h"
 #include "chardev/char-fe.h"
-#include "migration/misc.h"
 #include "system/runstate.h"
 #include "hw/riscv/numa.h"
 
@@ -822,9 +821,34 @@ static void kvm_riscv_get_regs_timer(CPUState *cs)
     env->kvm_timer_dirty = true;
 }
 
+int kvm_riscv_check_timer_frequency(RISCVCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    CPURISCVState *env = &cpu->env;
+    int ret;
+    uint64_t frequency;
+
+    if (!env->kvm_timer_frequency_loaded) {
+        return 0;
+    }
+
+    ret = kvm_get_one_reg(cs, RISCV_TIMER_REG(frequency), &frequency);
+    if (ret) {
+        return ret;
+    }
+
+    if (frequency != env->kvm_timer_frequency) {
+        error_report("KVM timer frequency mismatch: source %" PRIu64
+                     " Hz, destination %" PRIu64 " Hz",
+                     env->kvm_timer_frequency, frequency);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static void kvm_riscv_put_regs_timer(CPUState *cs)
 {
-    uint64_t reg;
     CPURISCVState *env = &RISCV_CPU(cs)->env;
 
     if (!env->kvm_timer_dirty) {
@@ -844,18 +868,6 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
         KVM_RISCV_SET_TIMER(cs, state, env->kvm_timer_state);
     }
 
-    /*
-     * For now, migration will not work between Hosts with different timer
-     * frequency. Therefore, we should check whether they are the same here
-     * during the migration.
-     */
-    if (migration_is_running()) {
-        KVM_RISCV_GET_TIMER(cs, frequency, reg);
-        if (reg != env->kvm_timer_frequency) {
-            error_report("Dst Hosts timer frequency != Src Hosts");
-        }
-    }
-
     env->kvm_timer_dirty = false;
 }
 
diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index 61eaa12443..0e27ce8bf3 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -29,6 +29,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t guest_num);
 void riscv_kvm_aplic_request(void *opaque, int irq, int level);
 bool kvm_riscv_has_mp_state(void);
+int kvm_riscv_check_timer_frequency(RISCVCPU *cpu);
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu);
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 2685338901..14a50f1d33 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -198,6 +198,35 @@ static const VMStateDescription vmstate_rv128 = {
 };
 
 #ifdef CONFIG_KVM
+static bool kvm_timer_frequency_needed(void *opaque)
+{
+    return kvm_enabled();
+}
+
+static int kvm_timer_frequency_post_load(void *opaque, int version_id)
+{
+    RISCVCPU *cpu = opaque;
+
+    if (!kvm_enabled()) {
+        return -ENOTSUP;
+    }
+
+    cpu->env.kvm_timer_frequency_loaded = true;
+    return kvm_riscv_check_timer_frequency(cpu);
+}
+
+static const VMStateDescription vmstate_kvm_timer_frequency = {
+    .name = "cpu/kvm-timer-frequency",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = kvm_timer_frequency_needed,
+    .post_load = kvm_timer_frequency_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.kvm_timer_frequency, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool kvm_fcsr_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
@@ -256,6 +285,7 @@ static int riscv_cpu_kvm_pre_load(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
+    cpu->env.kvm_timer_frequency_loaded = false;
     cpu->env.kvm_mp_state_loaded = false;
     return 0;
 }
@@ -592,6 +622,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_rv128,
 #ifdef CONFIG_KVM
         &vmstate_kvm_fcsr,
+        &vmstate_kvm_timer_frequency,
         &vmstate_kvmtimer,
         &vmstate_kvm_mp_state,
 #endif
-- 
2.17.1


