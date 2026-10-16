Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51974CCA463
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWMH-0000MM-MM; Thu, 15 Oct 2026 21:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLp-0000Jx-VC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:17 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLm-0004Eg-4O
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:13 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2e5fb79ce82so33917775ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112588; x=1792717388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ae/F+1F479Gr7OFX9NWEPgT7rC5OzvDZ2GzLfQE5Bs8=;
 b=WcKRyTrELEHcIBAMOMvwdmhr+vGEJ5veqEUXZ8JNB+GQ+WFbufjQeGhW0NpbG8HSc8
 lWqEuZMN/GyCpySd74wXtOR0cAU7eIB05ztmgVpRdkeqoS6+0JtRAjZNnxngX22ho0q8
 4hxTfJS6waqCRTo+WcaJIW4jIUURVcYW6dSkaWm0YACq7omVFftO/8e4/Kb4WtPgfSm+
 4FKl1h3Fu7KZThpS7c+McA+WH+zQeuw1lVzfSRy5DwGVgBrFyy4TJbEYj+RrYFKaxj6O
 TCkcTEpVCh80z9Fjlh/GeLzkQkT4xJ7KqN5ekc0zKMUF2adpPx+RGLorAH5IOeTAsooi
 627w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112588; x=1792717388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ae/F+1F479Gr7OFX9NWEPgT7rC5OzvDZ2GzLfQE5Bs8=;
 b=S3Oghy0z3HThFUSXoxtAOXVPSUTy6FjtEDF3O0I/so+akYx4WY5Qp6sf/Eug/xdm1o
 bwtVzOkNXXDtAMaqZfHNa2A+yBab9QBk725ek3CD7NIr0ptyt+xdYn/YcNjVKxrnY3Is
 AeTLo6g2a9s1pNa/GUMTHyg2eeRddiKeN40lLLVIQ7dcl9Ka1TxPiNfNv8qruIUwgRmR
 krvXGcwWltiSVekDHM5zHAJeiZOjHzwVMVALgHlEUI9WlbuQHtGSwqFcGGzGUNLfJzr/
 I+mYXJIduHt3mZGGSS9ev7uvXc8vBvr5G/g2FnqpY2qha0kOZ9f1A66g+to3GTRXcSg6
 hRBQ==
X-Gm-Message-State: AFq9FYIQfpN4XY4pEebt5yn3woDjWJMl1GayBebPqB/c1kXzOSOM+pJN
 Kd4YOmjFydj2dKQPTg0t9Z+XMct8DR2E73tpC5ezaFweA/lN7FHLAavqyPfFMg==
X-Gm-Gg: AYBFou1E1So83RkTl6QVIVacRMR6DgpMpQJLj52z15ObfPBfuv5cQPdXehHG0DYtYGs
 589HyAwnZu+fzrd7yNxGN6kMnN2TDYHKJ+PYHmZqcqEX7ls8Cj8WKJxIPVOinwLE24Q1Sfkwn8X
 wXpzUl7kjizjh5sFy0AMCVXbI4l9XAtRLcGjL3nWM+BZUKXSq4bTyZkUB7J1lRLC4S0TdwGzCoe
 XLUEtKgYM/wpdmsK20W9zzUztLQwiqVEa735/5l7bixPbUP3wUQgv4cPRMj8zvxYnQ0NeuZtHDj
 2aymtBUimG00el5J5lMFPnqmtVBYHs4voFrdJi8qnu4rTBZ3fDkUKClG0gOOs6PjNV8LNrAVolE
 ysX49vI+zCplmZJY0cfi5Dck7kDJ9j19VDKuv+ZQa3q3myAJTMUGcZuTFWcXnCKDm3aC2SmyjFW
 ZGhto7LRTKXvSsX7RCZqHxOPRT2+kMGVTSviUOH+tCji5ATZevZZ0DnNI3fOiYFHZuPjFFTmlwj
 G5Csxo2+lezrFdB
X-Received: by 2002:a17:902:d492:b0:2e9:3d96:7e83 with SMTP id
 d9443c01a7336-2e93d9680b3mr66544025ad.50.1792112587981; 
 Thu, 15 Oct 2026 18:03:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Xie Bo <xb@ultrarisc.com>, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 07/50] target/riscv/kvm: Reject migration with a different
 timer frequency
Date: Fri, 16 Oct 2026 11:01:54 +1000
Message-ID: <20261016010237.1102834-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
---
 target/riscv/cpu.h           |  1 +
 target/riscv/kvm/kvm_riscv.h |  1 +
 target/riscv/kvm/kvm-cpu.c   | 40 +++++++++++++++++++++++-------------
 target/riscv/machine.c       | 31 ++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 25f8ec00a9..5489c564ae 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -544,6 +544,7 @@ struct CPUArchState {
     uint64_t kvm_timer_compare;
     uint64_t kvm_timer_state;
     uint64_t kvm_timer_frequency;
+    bool kvm_timer_frequency_loaded;
 
     /* KVM multiprocessor state */
     uint32_t kvm_mp_state;
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
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 3238912b63..ed10e65259 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -197,6 +197,35 @@ static const VMStateDescription vmstate_rv128 = {
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
@@ -255,6 +284,7 @@ static int riscv_cpu_kvm_pre_load(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
+    cpu->env.kvm_timer_frequency_loaded = false;
     cpu->env.kvm_mp_state_loaded = false;
     return 0;
 }
@@ -591,6 +621,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_rv128,
 #ifdef CONFIG_KVM
         &vmstate_kvm_fcsr,
+        &vmstate_kvm_timer_frequency,
         &vmstate_kvmtimer,
         &vmstate_kvm_mp_state,
 #endif
-- 
2.55.0


