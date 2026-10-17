Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BC6CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB6z-0001L5-Bx; Sat, 17 Oct 2026 16:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB60-0007CM-I2; Sat, 17 Oct 2026 16:33:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB5y-0004hY-Fd; Sat, 17 Oct 2026 16:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268900; bh=rLbfHVTP+cmsfgjneSQ/zxI6yD/5xhE6J4NzTt0BkHg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=itLXvYFen5jl+EqZM+yTFvQKw/WhwX9LcmOBi3avxe6vGVWmU1mb5YlK3rlQhZi6Y
 iNURxhumrhNrAQyF6sD4nyIv5d+8eAFfP49QeLG7MSgxIdqpxnZw7A2DSv5tJbDonA
 psisePdtuLof2jGCfkuqMXPiQ3++jKaqy8xLDTRgE7oXjlsWATJVtg7ouzZvjYEEwR
 8V+EUcM83OGV+IXn4jIyeFYzJjXcCi7DvGKdmggVYhNJmIu+z2TDn/EPny1Muw5Y62
 Nl1zt56kP44ruVy2Hq5LjOgmEbruRjz8g78tmPeyFrw4Tq2cWnaEcEE8aiWoxychHk
 CslC8MURg/9wg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DB21D1DE784;
 Sat, 17 Oct 2026 23:28:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9C518443456;
 Sat, 17 Oct 2026 23:28:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xie Bo <xb@ultrarisc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 68/73] target/riscv/kvm: Reject migration with a
 different timer frequency
Date: Sat, 17 Oct 2026 23:26:26 +0300
Message-ID: <20261017202638.728621-68-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Xie Bo <xb@ultrarisc.com>

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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260831074106.1798671-3-xb@ultrarisc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 0f9adcab46c08246f21c290bd0a9382c5b02bd6c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 592cbf3e71..a583f80b58 100644
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
index 45e12216ac..aa19c69dd3 100644
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
2.47.3


