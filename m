Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390FCC624C2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0weX-0003k2-50; Mon, 31 Aug 2026 03:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1x0weV-0003jQ-Vt; Mon, 31 Aug 2026 03:42:00 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1x0weT-00052i-Ur; Mon, 31 Aug 2026 03:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=hzQGgmdUEimuLT4PLlaAK7STMI5+FWdCII
 0k4o9DR9I=; b=Rk81FYsVuOAnkdLapGac5GqD8pKAV5n437Abpyes+JZ2G+h1VH
 jW1ir6gl5SDL0ss9HlsUCZUOfZOt85OGqsKgP8Q28Wep8/5rgRVxE2pXtjpzHuLD
 jLgfzeOYYGpDp3CEIGOr2OnTXZi04fHiJnV+GURABvXrkucNWmTjP63Xo=
Received: from ur-dp1000 (unknown [192.168.100.1])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAfwDHQAceMJVq4BUAAA--.112S3; 
 Mon, 31 Aug 2026 15:41:56 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-stable@nongnu.org,
 Xie Bo <xb@ultrarisc.com>
Subject: [PATCH 1/3] target/riscv/kvm: Preserve FCSR across migration
Date: Mon, 31 Aug 2026 15:41:04 +0800
Message-ID: <20260831074106.1798671-2-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831074106.1798671-1-xb@ultrarisc.com>
References: <20260831074106.1798671-1-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHQAceMJVq4BUAAA--.112S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur4kZFyUJF1fWF17Gr15Arb_yoWrXFy5pF
 s5CFZIkrn5JFZ7X3yfJF1DXr45Wr4rGws8Aws7u3yIya15GrWYqFs7tay2yr1rJFyrWr4S
 9F4rAr15CF4jyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
 v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCF
 s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
 1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
 JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
 1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 YxBIdaVFxhVjvjDU0xZFpf9x0JUa0PDUUUUU=
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAMB2qOWvsAQwANsB
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
---
 target/riscv/cpu.h         |  3 +++
 target/riscv/kvm/kvm-cpu.c | 20 ++++++++++++++++----
 target/riscv/machine.c     | 27 +++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 718b66487a..a5ec69c3cc 100644
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
index 68e1501b21..c8ccd9124e 100644
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
2.17.1


