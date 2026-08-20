Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E94C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtiV-00075s-C7; Wed, 19 Aug 2026 23:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtiU-00075e-L0
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:22 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtiS-0003pT-LJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:22 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so2168159a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197519; x=1787802319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xsIv20ka3W9n/PovKdbA0aIXZvkmbBl4/VeH5qj6NKc=;
 b=Eb16+JGidMleOFqUazQLwb2C40/D03mODrEc/bMSoBxKssst2x0IB2JHoPIP26Y9X5
 r8lEA6IDjSC4EGoJz3ps7r1GfhOUWeUb59gGXtsZd5ctHmUUf3+JXNwNDqinKJLrCCZl
 fes9FuTGhJrbJuonXek9E+L8e3jZhVjhd3ERiRR2Z/U2dyNZLHS2RkoJ+vCjIsBQU1F5
 xB2ghbXIZaeSAW9oAyhUqC8NanFvN03YBVi4sYFYNK3qVh24Kgde7Ay4fdR5VB/367Cb
 HlE546tOSNlUMy+Aep1clKLdOKXacesBSpF5Ai4x7zQloXy0jhaIrUy7Iait9Zasx7qs
 cYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197519; x=1787802319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xsIv20ka3W9n/PovKdbA0aIXZvkmbBl4/VeH5qj6NKc=;
 b=sgLiwlBcePKlArB1JSSwj1fKCE0xK8mu4vf9ajFIryDHHKDN5YWHAzo5l1N6JeNoBJ
 c0k2cKFAYWQNDeN1QIb6kngQ98U2SkmFdhYnCHZUhU5U9suiYzhyN4R47NCLVCcZqJru
 Uq0WCWMGi//mXuKrTvcU/54XPmZi1BbW3GamkkML0NHvLcNmFgBy60PHFc4trTrAgzDo
 uz/YWCApNn+fX9z34joROFyE4U1XnfIlDkDaUUTA/CbG20uuNicPaP/QDGnhhlKbvuev
 GNUH8FSTu1pQB/RShg+yeFLjKo6yVL1MSnmW7ByTn9NsHhtDWAG79hM6PwWL0/Dp2Yvy
 ziqQ==
X-Gm-Message-State: AFuF++l2+HkLtaqymz/UMzy+paTrbMr1dm5w5wZ4+RII7Ehem9Ex5kbb
 OzGs3yEJnBz1OvRUmMgM0+b5WCSmX7LLgqe+2RXw4O+OQAqXZ6vx15ePz1rV6Q==
X-Gm-Gg: AR+sD101Znq0MDMGzwWk+cxwFIwcTWsvvWH7hyokS2OXt6kxs6BQJvd/8NNVamFwYwf
 BlmqrZ/Su8oAVr+5041/KyhoYPNz/G5amuMmHNc3DoiO8hgg3dbmKnBEjbNKHTAkAfZGqCTTgGL
 HcoXP+4eh7S4Cmb4iwRCyyp5wlIlr5Mc25ZP5KlEJ3I8N7JB8PNxahAPJMH6FEOXVCff1jOuHzU
 zdZ5f/hoQU55BJXoQYql/l8C9utCyyKZs9qGqnmC+lBFCPPKGM6Qu5t8DVTkmH2zf6Di9Q03YL7
 uWyDzcgerdfcwmCiWj+wZJXf1uRSqEwOhnwL+/8rZQ4zuyTMn3aS2NJelTECtBfAzRlziqiXaE0
 3D0NfTKztHZ1z7bzotbxb04IkS68Z/03kcAb8jbsj18Se4wXmY3/iR5vXwvKcd4Zbg+vLyCoYHD
 bTtkUgxXnVZTusflp8Jy6Bu9PSCOBki0RUfKIpKW/u3cNJTbpCRyy7GJQP18m8qs3VrIG1fhlJY
 wHi4fU62xI/eHBodQ==
X-Received: by 2002:a17:90b:524e:b0:37f:be6c:f3f2 with SMTP id
 98e67ed59e1d1-39580ecefcbmr16496015a91.2.1787197519087; 
 Wed, 19 Aug 2026 20:45:19 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:45:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Xie Bo <xb@ultrarisc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/93] target/riscv/kvm: Preserve MP state across migration
Date: Thu, 20 Aug 2026 13:43:09 +1000
Message-ID: <20260820034430.1186695-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
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
---
 target/riscv/cpu.h           |  4 +++
 target/riscv/kvm/kvm_riscv.h |  2 +-
 target/riscv/kvm/kvm-cpu.c   | 50 ++++++++++++++++++++++++------------
 target/riscv/machine.c       | 49 +++++++++++++++++++++++++++++++++--
 4 files changed, 86 insertions(+), 19 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 376cff656f..718b66487a 100644
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
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index f6ddd0db9b..68e1501b21 100644
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
2.54.0


