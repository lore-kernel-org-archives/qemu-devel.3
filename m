Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C98CCF2D1
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB8Z-0004oR-Jp; Sat, 17 Oct 2026 16:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB60-0007CK-IA; Sat, 17 Oct 2026 16:33:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB5y-0004hW-OQ; Sat, 17 Oct 2026 16:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268899; bh=0vz3JjyOyVXzcyGZDNmzXnomvFWB7T9+ag5ndgoLWAk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MOdR9hU5VwEadwJymLgDP7eVH0SlGDMkaPZOkngfAIPPY5RiBY+vdp0KCrH1EmcXu
 YKaYNyAGTIHHQUj9KQ3lDvL23/4n2gCu6rHMsbtiFmqLxVdbXuxqVt0NzgIw36md85
 nvWwoChFco/Nyw6FI+yjZsMLK8ZUpmHEoYuqUpTyMvSYcHu/DpI1ZjoGtKIwo399T3
 94cI1ZDVkcIBwnE+3De5exBMUqjTuupIvKCTSLBSxVWVFURaS7+7J0eTFVBSTm5bqM
 F/MdLPhMv7+wUSEcPjOuHYby790GN3BPMZb00xHbRexG8VOoURpGQIQzdrclQukmzy
 /NyUqcn5KE3Dg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 64ADB1DE783;
 Sat, 17 Oct 2026 23:28:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 86B71443455;
 Sat, 17 Oct 2026 23:28:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xie Bo <xb@ultrarisc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 67/73] target/riscv/kvm: Preserve FCSR across migration
Date: Sat, 17 Oct 2026 23:26:25 +0300
Message-ID: <20261017202638.728621-67-mjt@tls.msk.ru>
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

kvm_riscv_get_regs_fp() and kvm_riscv_put_regs_fp() handle f0-f31
but not FCSR.  KVM exposes FCSR as a separate 32-bit register in both
the F and D register groups, so frm and fflags are lost after migration.

Read and write FCSR together with the FP registers and save it in a
KVM-only subsection.  Older streams do not contain the subsection; in
that case the destination keeps its reset value.

Fixes: 937f0b45120b ("target/riscv: Implement kvm_arch_get_registers")
Fixes: 9997cc1e19d1 ("target/riscv: Implement kvm_arch_put_registers")
Signed-off-by: Xie Bo <xb@ultrarisc.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260831074106.1798671-2-xb@ultrarisc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit e52de6b65f5fa584209a8c147d6170d8370ffdee)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e980b5964d..592cbf3e71 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -532,6 +532,9 @@ struct CPUArchState {
     hwaddr fdt_addr;
 
 #ifdef CONFIG_KVM
+    /* KVM floating-point state */
+    uint32_t kvm_fcsr;
+
     /* kvm timer */
     bool kvm_timer_dirty;
     uint64_t kvm_timer_time;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index cc5655d46d..45e12216ac 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -111,6 +111,14 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
 
 #define RISCV_FP_D_REG(idx)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_FP_D, idx)
 
+#define RISCV_FP_F_FCSR_REG \
+    KVM_RISCV_REG_ID_U32(KVM_REG_RISCV_FP_F, \
+                         KVM_REG_RISCV_FP_F_REG(fcsr))
+
+#define RISCV_FP_D_FCSR_REG \
+    KVM_RISCV_REG_ID_U32(KVM_REG_RISCV_FP_D, \
+                         KVM_REG_RISCV_FP_D_REG(fcsr))
+
 #define RISCV_VECTOR_CSR_REG(name) \
     KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_VECTOR, \
                            KVM_REG_RISCV_VECTOR_CSR_REG(name))
@@ -743,7 +751,8 @@ static int kvm_riscv_get_regs_fp(CPUState *cs)
             }
             env->fpr[i] = reg;
         }
-        return ret;
+        return kvm_get_one_reg(cs, RISCV_FP_D_FCSR_REG,
+                               &env->kvm_fcsr);
     }
 
     if (riscv_has_ext(env, RVF)) {
@@ -755,7 +764,8 @@ static int kvm_riscv_get_regs_fp(CPUState *cs)
             }
             env->fpr[i] = reg;
         }
-        return ret;
+        return kvm_get_one_reg(cs, RISCV_FP_F_FCSR_REG,
+                               &env->kvm_fcsr);
     }
 
     return ret;
@@ -776,7 +786,8 @@ static int kvm_riscv_put_regs_fp(CPUState *cs)
                 return ret;
             }
         }
-        return ret;
+        return kvm_set_one_reg(cs, RISCV_FP_D_FCSR_REG,
+                               &env->kvm_fcsr);
     }
 
     if (riscv_has_ext(env, RVF)) {
@@ -788,7 +799,8 @@ static int kvm_riscv_put_regs_fp(CPUState *cs)
                 return ret;
             }
         }
-        return ret;
+        return kvm_set_one_reg(cs, RISCV_FP_F_FCSR_REG,
+                               &env->kvm_fcsr);
     }
 
     return ret;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 31c49ca3e6..2685338901 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -198,6 +198,32 @@ static const VMStateDescription vmstate_rv128 = {
 };
 
 #ifdef CONFIG_KVM
+static bool kvm_fcsr_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+
+    return kvm_enabled() &&
+           (riscv_has_ext(env, RVF) || riscv_has_ext(env, RVD));
+}
+
+static int kvm_fcsr_post_load(void *opaque, int version_id)
+{
+    return kvm_enabled() ? 0 : -ENOTSUP;
+}
+
+static const VMStateDescription vmstate_kvm_fcsr = {
+    .name = "cpu/kvm-fcsr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = kvm_fcsr_needed,
+    .post_load = kvm_fcsr_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(env.kvm_fcsr, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool kvmtimer_needed(void *opaque)
 {
     return kvm_enabled();
@@ -565,6 +591,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_pointermasking,
         &vmstate_rv128,
 #ifdef CONFIG_KVM
+        &vmstate_kvm_fcsr,
         &vmstate_kvmtimer,
         &vmstate_kvm_mp_state,
 #endif
-- 
2.47.3


