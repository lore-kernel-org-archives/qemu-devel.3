Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CBBC5AC67
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 12:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsgXT-0000bU-9R; Sat, 08 Aug 2026 08:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1wsgXK-0000aH-JN; Sat, 08 Aug 2026 08:52:27 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1wsgXH-00069Z-6K; Sat, 08 Aug 2026 08:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=RG1Do0XFo3/EFfxE7sET0v3r+mS+mnC1m4
 mZ/+FlRy4=; b=UoOGu1APaJDjREcuVj73OVHaay6Zgy0m66fVAkX7phfwdKSZb6
 Y/p4HhLQq8cgEKUnxq0V//igQJZkRNB5cTvht4BXTboELiPN6swBxDSO2o3IwHTq
 02ax0Wv9LfUo/cdxA/vRIo7iEKJttJgup4PqsaQBYxkGhd1YjWhKf4AdQ=
Received: from ur-dp1000 (unknown [192.168.100.1])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAfwDXEEKHJndqI3UWAA--.18312S4; 
 Sat, 08 Aug 2026 20:52:39 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, qemu-riscv@nongnu.org, alistair23@gmail.com,
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com,
 rkrcmar@ventanamicro.com, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com, xb@ultrarisc.com
Subject: [PATCH v11 2/2] target/riscv/kvm: Preserve MP state across migration
Date: Sat,  8 Aug 2026 20:51:57 +0800
Message-ID: <20260808125157.1220511-3-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808125157.1220511-1-xb@ultrarisc.com>
References: <20260730051926.7322-1-xb@ultrarisc.com>
 <20260808125157.1220511-1-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXEEKHJndqI3UWAA--.18312S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKr18WF4rur4rCr48Ww1xZrb_yoWxXr4fpF
 s8GrW3CrZ5J3s3Xw1fJ34DWFn8Wr4kGr45A3yxCrWIkF45KrW5urWkKrW2yrs8Ja48JrWa
 93WUAr9xCa10y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
 v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCF
 s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
 1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
 JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
 1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 YxBIdaVFxhVjvjDU0xZFpf9x0JUl9a9UUUUU=
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAMB2p1VlUAFAAFsH
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
---
 target/riscv/cpu.h           |  4 +++
 target/riscv/kvm/kvm-cpu.c   | 50 ++++++++++++++++++++++++------------
 target/riscv/kvm/kvm_riscv.h |  2 +-
 target/riscv/machine.c       | 49 +++++++++++++++++++++++++++++++++--
 4 files changed, 86 insertions(+), 19 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c9dfa7daff..e980b5964d 100644
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
index 8218832fbe..cc5655d46d 100644
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
index b2bcd1041f..61eaa12443 100644
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
index 0ab613a298..31c49ca3e6 100644
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
2.17.1


