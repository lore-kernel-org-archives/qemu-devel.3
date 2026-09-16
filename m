Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658C5C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n1o-0005V7-0z; Wed, 16 Sep 2026 06:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n1X-0005Dx-SC; Wed, 16 Sep 2026 06:37:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n1V-0001qF-Gb; Wed, 16 Sep 2026 06:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789554955; bh=+k1yhBCR1nk8SoUZ24wonPZaHK/iOA6hVVS7ZkYFQ7c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=b5evcfNDjEQ+0lWHLbRb11ZC/JkqotdDpQ4/mcigS/tGTPZvmU3axygQhmpRf78fF
 UXqKCnK1aakneg8NbLQ9rwPvqd415Z640wSOB59kkwnwUupBTUu8g262Ktlula4plW
 YlV5M6qI+xH94Qvlflyuwq+AWQsyaFxcIp+qnfLcy6qwafCheqeebNEBMJa/bHmRTx
 ysKUjOZKbeGqI7xpOg7ZT7Zwc36acTuCHhrtAll0w2kx6669LCW7bOz5PXqaVy4DwG
 AHfmGCGCMXVdMn5y4noFLNT9++rmctGgp1R9wHDI/w05lB/bJ3FHvxJ9af67SoFs8Z
 y1F22y326my2g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F06CD1D5805;
 Wed, 16 Sep 2026 13:35:55 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BB53C429F64;
 Wed, 16 Sep 2026 13:36:38 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8E1F95A805; Wed, 16 Sep 2026 13:36:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xie Bo <xb@ultrarisc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 18/56] target/riscv/kvm: Preserve MP state across
 migration
Date: Wed, 16 Sep 2026 13:35:36 +0300
Message-ID: <20260916103622.684817-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
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

RISC-V KVM initializes secondary vCPUs in KVM_MP_STATE_STOPPED, but QEMU
does not save their runtime MP state. A destination therefore retains reset
MP state after migration and cannot reliably resume all vCPUs.

Save KVM_GET_MP_STATE in a capability-gated KVM VMState subsection and
restore it on KVM_PUT_FULL_STATE. Keep the existing reset initialization
path unchanged. Track whether the subsection was loaded so streams where
the subsection is absent retain the destination reset behavior.

Bump the RISC-V CPU VMState version and minimum version to 12 for the new
pre_load hook and KVM MP-state subsection. Keep the subsection out of KVM
migration streams when the host does not support the MP-state capability.

Signed-off-by: Xie Bo <xb@ultrarisc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260808125157.1220511-3-xb@ultrarisc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit ddac7cfb00ad771f6ef3450fff2d09e749fdbaf9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c9dfa7daff2..e980b5964dd 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -538,6 +538,10 @@ struct CPUArchState {
     uint64_t kvm_timer_compare;
     uint64_t kvm_timer_state;
     uint64_t kvm_timer_frequency;
+
+    /* KVM multiprocessor state */
+    uint32_t kvm_mp_state;
+    bool kvm_mp_state_loaded;
 #endif /* CONFIG_KVM */
 };
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 8218832fbeb..cc5655d46d2 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1374,25 +1374,35 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
         return ret;
     }
 
+    if (cap_has_mp_state) {
+        struct kvm_mp_state mp_state;
+
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_MP_STATE, &mp_state);
+        if (ret) {
+            return ret;
+        }
+        RISCV_CPU(cs)->env.kvm_mp_state = mp_state.mp_state;
+    }
+
     return ret;
 }
 
-int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
+bool kvm_riscv_has_mp_state(void)
 {
-    if (cap_has_mp_state) {
-        struct kvm_mp_state mp_state = {
-            .mp_state = state
-        };
+    return cap_has_mp_state;
+}
 
-        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
-        if (ret) {
-            fprintf(stderr, "%s: failed to sync MP_STATE %d/%s\n",
-                    __func__, ret, strerror(-ret));
-            return -1;
-        }
+static int kvm_riscv_put_mp_state(CPUState *cs)
+{
+    struct kvm_mp_state mp_state = {
+        .mp_state = RISCV_CPU(cs)->env.kvm_mp_state,
+    };
+
+    if (!cap_has_mp_state) {
+        return 0;
     }
 
-    return 0;
+    return kvm_vcpu_ioctl(cs, KVM_SET_MP_STATE, &mp_state);
 }
 
 int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
@@ -1431,10 +1441,18 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
     }
 
     if (KVM_PUT_RESET_STATE == level) {
-        RISCVCPU *cpu = RISCV_CPU(cs);
-        int state = cs->cpu_index == 0 ? KVM_MP_STATE_RUNNABLE
-                                       : KVM_MP_STATE_STOPPED;
-        ret = kvm_riscv_sync_mpstate_to_kvm(cpu, state);
+        CPURISCVState *env = &RISCV_CPU(cs)->env;
+
+        env->kvm_mp_state = cs->cpu_index == 0 ? KVM_MP_STATE_RUNNABLE
+                                               : KVM_MP_STATE_STOPPED;
+        env->kvm_mp_state_loaded = false;
+        ret = kvm_riscv_put_mp_state(cs);
+        if (ret) {
+            return ret;
+        }
+    } else if (KVM_PUT_FULL_STATE == level &&
+               RISCV_CPU(cs)->env.kvm_mp_state_loaded) {
+        ret = kvm_riscv_put_mp_state(cs);
         if (ret) {
             return ret;
         }
diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index b2bcd1041f6..61eaa12443e 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -28,7 +28,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num);
 void riscv_kvm_aplic_request(void *opaque, int irq, int level);
-int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
+bool kvm_riscv_has_mp_state(void);
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu);
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 0ab613a2980..31c49ca3e6a 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -25,6 +25,9 @@
 #include "exec/icount.h"
 #include "target/riscv/tcg/debug.h"
 #include "hw/riscv/machines-qom.h"
+#ifdef CONFIG_KVM
+#include "kvm/kvm_riscv.h"
+#endif
 
 static bool pmp_needed(void *opaque)
 {
@@ -222,6 +225,44 @@ static const VMStateDescription vmstate_kvmtimer = {
         VMSTATE_END_OF_LIST()
     }
 };
+
+static int riscv_cpu_kvm_pre_load(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    cpu->env.kvm_mp_state_loaded = false;
+    return 0;
+}
+
+static bool kvm_mp_state_needed(void *opaque)
+{
+    return kvm_enabled() && kvm_riscv_has_mp_state();
+}
+
+static int kvm_mp_state_post_load(void *opaque, int version_id)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+
+    if (!kvm_enabled() || !kvm_riscv_has_mp_state()) {
+        return -ENOTSUP;
+    }
+
+    env->kvm_mp_state_loaded = true;
+    return 0;
+}
+
+static const VMStateDescription vmstate_kvm_mp_state = {
+    .name = "cpu/kvm-mp-state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = kvm_mp_state_needed,
+    .post_load = kvm_mp_state_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(env.kvm_mp_state, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
 #endif
 
 static bool debug_needed(void *opaque)
@@ -457,8 +498,11 @@ static const VMStateDescription vmstate_mseccfg = {
 
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
-    .version_id = 11,
-    .minimum_version_id = 11,
+    .version_id = 12,
+    .minimum_version_id = 12,
+#ifdef CONFIG_KVM
+    .pre_load = riscv_cpu_kvm_pre_load,
+#endif
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.gpr, RISCVCPU, 32),
@@ -522,6 +566,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_rv128,
 #ifdef CONFIG_KVM
         &vmstate_kvmtimer,
+        &vmstate_kvm_mp_state,
 #endif
         &vmstate_envcfg,
         &vmstate_debug,
-- 
2.47.3


