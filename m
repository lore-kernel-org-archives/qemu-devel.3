Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A46CAC592
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 08:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwcnU-0007Kc-1X; Thu, 11 Sep 2025 04:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1uwcnQ-0007Ia-HD; Thu, 11 Sep 2025 04:36:48 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1uwcnL-0003IY-Gb; Thu, 11 Sep 2025 04:36:48 -0400
Received: from ur-dp1000.. (unknown [192.168.100.1])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAfwBn1M5IisJoPP4sAA--.40469S4; 
 Thu, 11 Sep 2025 16:37:40 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, qemu-riscv@nongnu.org, mjt@tls.msk.ru,
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com,
 rkrcmar@ventanamicro.com, palmer@dabbelt.com, xiamy@ultrarisc.com,
 Xie Bo <xb@ultrarisc.com>
Subject: [PATCH v7 for v10.0.0 2/2] Fix VM resume after QEMU+KVM migration
Date: Thu, 11 Sep 2025 16:36:16 +0800
Message-ID: <20250911083617.1173094-3-xb@ultrarisc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911083617.1173094-1-xb@ultrarisc.com>
References: <20250911083617.1173094-1-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBn1M5IisJoPP4sAA--.40469S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4kZw1rKF4rWw1kJr4xJFb_yoW7Ww13pr
 s8CFZ8CryxGrWxXw1fJ34DXFn5Gw47GanxC3y09r4SkF45GrZ09r1kKay2yrs5G348Ar12
 9F45AFy3ua15tFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
 w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
 C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
 7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxc
 IEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI
 7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
 Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
 6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
 AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
 1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjmL9UUUUUU==
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQACB2jCKHAAJgAAsQ
X-Host-Lookup-Failed: Reverse DNS lookup failed for 218.76.62.146 (failed)
Received-SPF: pass client-ip=218.76.62.146; envelope-from=xb@ultrarisc.com;
 helo=ultrarisc.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fix two migration issues for virtual machines in KVM mode:
1.It saves and restores the vCPU's privilege mode to ensure that the 
vCPU's privilege mode is correct after migration.
2.It saves and restores the vCPU's mp_state (runnable or stopped) and 
includes this state in the migration sequence, upgrading the vmstate 
version to ensure that the vCPU's mp_state is correct after migration.

KVM_PUT_RUNTIME_STATE only synchronizes the vCPU’s runtime-modified 
state (such as registers), whereas mp_state is related to system boot, 
multi-core initialization, and is not modified during normal operation. 
Therefore, mp_state is only synchronized to KVM during KVM_PUT_RESET_STATE 
and KVM_PUT_FULL_STATE.

Signed-off-by: Xie Bo <xb@ultrarisc.com>
---
 target/riscv/kvm/kvm-cpu.c   | 60 ++++++++++++++++++++++++++++--------
 target/riscv/kvm/kvm_riscv.h |  3 +-
 target/riscv/machine.c       |  5 +--
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 0f4997a918..1434dd1c51 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -576,6 +576,12 @@ static int kvm_riscv_get_regs_core(CPUState *cs)
     }
     env->pc = reg;
 
+    ret = kvm_get_one_reg(cs, RISCV_CORE_REG(env, mode), &reg);
+    if (ret) {
+        return ret;
+    }
+    env->priv = reg;
+
     for (i = 1; i < 32; i++) {
         uint64_t id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, i);
         ret = kvm_get_one_reg(cs, id, &reg);
@@ -601,6 +607,12 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
         return ret;
     }
 
+    reg = env->priv;
+    ret = kvm_set_one_reg(cs, RISCV_CORE_REG(env, mode), &reg);
+    if (ret) {
+        return ret;
+    }
+
     for (i = 1; i < 32; i++) {
         uint64_t id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, i);
         reg = env->gpr[i];
@@ -1244,25 +1256,52 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
         return ret;
     }
 
+    ret = kvm_riscv_sync_mpstate_to_qemu(cs);
+    if (ret) {
+        return ret;
+    }
+
     return ret;
 }
 
-int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
+int kvm_riscv_sync_mpstate_to_kvm(CPUState *cs)
 {
+    int ret = 0;
+    CPURISCVState *env = &RISCV_CPU(cs)->env;
+
     if (cap_has_mp_state) {
         struct kvm_mp_state mp_state = {
-            .mp_state = state
+            .mp_state = env->mp_state
         };
 
-        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
+        ret = kvm_vcpu_ioctl(cs, KVM_SET_MP_STATE, &mp_state);
         if (ret) {
-            fprintf(stderr, "%s: failed to sync MP_STATE %d/%s\n",
+            fprintf(stderr, "%s: failed to sync MP_STATE to KVM %d/%s\n",
                     __func__, ret, strerror(-ret));
-            return -1;
         }
     }
 
-    return 0;
+    return ret;
+}
+
+int kvm_riscv_sync_mpstate_to_qemu(CPUState *cs)
+{
+    int ret = 0;
+    CPURISCVState *env = &RISCV_CPU(cs)->env;
+
+    if (cap_has_mp_state) {
+        struct kvm_mp_state mp_state;
+
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_MP_STATE, &mp_state);
+        if (ret) {
+            fprintf(stderr, "%s: failed to sync MP_STATE to QEMU %d/%s\n",
+                    __func__, ret, strerror(-ret));
+            return ret;
+        }
+        env->mp_state = mp_state.mp_state;
+    }
+
+    return ret;
 }
 
 int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
@@ -1289,13 +1328,8 @@ int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
         return ret;
     }
 
-    if (KVM_PUT_RESET_STATE == level) {
-        RISCVCPU *cpu = RISCV_CPU(cs);
-        if (cs->cpu_index == 0) {
-            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNNABLE);
-        } else {
-            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_STOPPED);
-        }
+    if (level >= KVM_PUT_RESET_STATE) {
+        ret = kvm_riscv_sync_mpstate_to_kvm(cs);
         if (ret) {
             return ret;
         }
diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index b2bcd1041f..953db94160 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -28,7 +28,8 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num);
 void riscv_kvm_aplic_request(void *opaque, int irq, int level);
-int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
+int kvm_riscv_sync_mpstate_to_kvm(CPUState *cs);
+int kvm_riscv_sync_mpstate_to_qemu(CPUState *cs);
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu);
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 889e2b6570..8562a0a1d6 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -401,8 +401,8 @@ static const VMStateDescription vmstate_ssp = {
 
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
-    .version_id = 10,
-    .minimum_version_id = 10,
+    .version_id = 11,
+    .minimum_version_id = 11,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
@@ -422,6 +422,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UNUSED(4),
         VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
         VMSTATE_UINTTL(env.priv, RISCVCPU),
+        VMSTATE_UINT32(env.mp_state, RISCVCPU),
         VMSTATE_BOOL(env.virt_enabled, RISCVCPU),
         VMSTATE_UINT64(env.resetvec, RISCVCPU),
         VMSTATE_UINTTL(env.mhartid, RISCVCPU),
-- 
2.43.0


