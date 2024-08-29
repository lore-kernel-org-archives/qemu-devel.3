Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B066CCA0ECA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjofF-0003o8-HH; Thu, 29 Aug 2024 19:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjofE-0003jf-5M
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:52 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjoez-00038y-HN
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:51 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7cf6641765dso948246a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724974475; x=1725579275;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hiY0e11LdWr0yJ4C1u8dpw2Ti4FucCf21GJ5876Fq1k=;
 b=hxIKP9Rv1i7HLPfHlhEETgEMPLkyEGKIPlj8P007nu5k9I6SNLvr+RF2X10YHmQ5gs
 77KnNrEbD8+oCbq2UmafkXo3uBk4FfPMQvtJSnS43OvpX5HZdtd3MdX1zV3F7k4SK1rh
 6rraA1vgtbL5zbr0Ks4t8/0ttcueKCzfzs9HkOzbkqTx4CmVD7oe8QKhIxTAsa+O56UR
 Crr7WHHwPHhxrtOuH8CrBTTGhYvDNnTyW4Yf5aKHS6O11M9wgfU335PRTdJqhjWjvM1Y
 z+qCETvZgBpSaGARHNX2aILsqdz2ghQSB8Fdn1gVSQ9yJ0xJCzoZTzWisBP6zfuYDlbd
 VgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724974475; x=1725579275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hiY0e11LdWr0yJ4C1u8dpw2Ti4FucCf21GJ5876Fq1k=;
 b=h4TLP95xDiRkicQEXEEYLQnVApfuQ6+ultZkQ7Eheo20w+R1DWANeUk5iwBPwVkU82
 EBjre0lmQq4skr8sqSVR0zPJlCKMwI58bqOF9rRdrVhXRa6meLu8LEgLa/lDOYuJA+Rw
 C2EiDGOkxTUYBB0+6IqycxDzmFIP85Omuq44OzGulP8cYuClNpa9sj4cejlQ5VpvQUpr
 t1EVij09TJoV7LldJfK0Hpc3UT/GqslvHFe+TyGIIvfRaWF/Ru490+an4KbWAEL9zkvc
 dyOSU4kxKLLfvdnLVbNCQ+7KSkSj46OtD/BBwki5DucwT4SwSx4hplf1qozSwEYDxKiK
 +hVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1tnxyaltYc21goQT4MOeq2mF+uKt0Sg6tKAeNoX5EgReKn6ka8dw3euqG5EX4zvaRZ4EvTNXuCs2u@nongnu.org
X-Gm-Message-State: AOJu0YxYO3wUAKJsCJUDMJGBor9Qg5qPUAGQWVbqAGFlRpm7BrOoi4Py
 0cz4698d5PYDUD2zwM7L9KGe3BtMROGsonXLNRo/a70hAz3vghJ5fOVf5bnR6rs=
X-Google-Smtp-Source: AGHT+IF4MreH+9n1N6kM1364tMI/r9cI0dmVfrmFhBflK8uvfFpvo/BnTGyn2uBw/j/xuy9qdAvY8A==
X-Received: by 2002:a17:90a:6fa3:b0:2cd:55be:785a with SMTP id
 98e67ed59e1d1-2d85617baa9mr5486095a91.1.1724974474838; 
 Thu, 29 Aug 2024 16:34:34 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d85b13df55sm2331074a91.27.2024.08.29.16.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 16:34:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 04/20] target/riscv: save and restore elp state on priv
 transitions
Date: Thu, 29 Aug 2024 16:34:08 -0700
Message-ID: <20240829233425.1005029-5-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240829233425.1005029-1-debug@rivosinc.com>
References: <20240829233425.1005029-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

elp state is recorded in *status on trap entry (less privilege to higher
privilege) and restored in elp from *status on trap exit (higher to less
privilege).

Additionally this patch introduces a forward cfi helper function to
determine if current privilege has forward cfi is enabled or not based on
*envcfg (for U, VU, S, VU, HS) or mseccfg csr (for M). For qemu-user, a
new field `ufcfien` is introduced which is by default set to false and
helper function returns value deposited in `ufcfien` for qemu-user.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_helper.c | 54 +++++++++++++++++++++++++++++++++++++++
 target/riscv/op_helper.c  | 18 +++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b2dc419ad0..a7c970e70c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -531,6 +531,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
+bool cpu_get_fcfien(CPURISCVState *env);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6709622dd3..5f38969aa6 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -33,6 +33,7 @@
 #include "cpu_bits.h"
 #include "debug.h"
 #include "tcg/oversized-guest.h"
+#include "pmp.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -63,6 +64,33 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 #endif
 }
 
+bool cpu_get_fcfien(CPURISCVState *env)
+{
+    /* no cfi extension, return false */
+    if (!env_archcpu(env)->cfg.ext_zicfilp) {
+        return false;
+    }
+
+    switch (env->priv) {
+    case PRV_U:
+        if (riscv_has_ext(env, RVS)) {
+            return env->senvcfg & SENVCFG_LPE;
+        }
+        return env->menvcfg & MENVCFG_LPE;
+#ifndef CONFIG_USER_ONLY
+    case PRV_S:
+        if (env->virt_enabled) {
+            return env->henvcfg & HENVCFG_LPE;
+        }
+        return env->menvcfg & MENVCFG_LPE;
+    case PRV_M:
+        return env->mseccfg & MSECCFG_MLPE;
+#endif
+    default:
+        g_assert_not_reached();
+    }
+}
+
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
@@ -546,6 +574,15 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
     bool current_virt = env->virt_enabled;
 
+    /*
+     * If zicfilp extension available and henvcfg.LPE = 1,
+     * then apply SPELP mask on mstatus
+     */
+    if (env_archcpu(env)->cfg.ext_zicfilp &&
+        get_field(env->henvcfg, HENVCFG_LPE)) {
+        mstatus_mask |= SSTATUS_SPELP;
+    }
+
     g_assert(riscv_has_ext(env, RVH));
 
     if (current_virt) {
@@ -1754,6 +1791,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     if (env->priv <= PRV_S && cause < 64 &&
         (((deleg >> cause) & 1) || s_injected || vs_injected)) {
         /* handle the trap in S-mode */
+        /* save elp status */
+        if (cpu_get_fcfien(env)) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_SPELP, env->elp);
+        }
+
         if (riscv_has_ext(env, RVH)) {
             uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
 
@@ -1802,6 +1844,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_S);
     } else {
         /* handle the trap in M-mode */
+        /* save elp status */
+        if (cpu_get_fcfien(env)) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
+        }
+
         if (riscv_has_ext(env, RVH)) {
             if (env->virt_enabled) {
                 riscv_cpu_swap_hypervisor_regs(env);
@@ -1833,6 +1880,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_M);
     }
 
+    /*
+     * Interrupt/exception/trap delivery is asynchronous event and as per
+     * zicfilp spec CPU should clear up the ELP state. No harm in clearing
+     * unconditionally.
+     */
+    env->elp = false;
+
     /*
      * NOTE: it is not necessary to yield load reservations here. It is only
      * necessary for an SC from "another hart" to cause a load reservation
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 2baf5bc3ca..5848aaf437 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -313,6 +313,15 @@ target_ulong helper_sret(CPURISCVState *env)
 
     riscv_cpu_set_mode(env, prev_priv);
 
+    /*
+     * If forward cfi enabled for new priv, restore elp status
+     * and clear spelp in mstatus
+     */
+    if (cpu_get_fcfien(env)) {
+        env->elp = get_field(env->mstatus, MSTATUS_SPELP);
+    }
+    env->mstatus = set_field(env->mstatus, MSTATUS_SPELP, 0);
+
     return retpc;
 }
 
@@ -357,6 +366,15 @@ target_ulong helper_mret(CPURISCVState *env)
         riscv_cpu_set_virt_enabled(env, prev_virt);
     }
 
+    /*
+     * If forward cfi enabled for new priv, restore elp status
+     * and clear mpelp in mstatus
+     */
+    if (cpu_get_fcfien(env)) {
+        env->elp = get_field(env->mstatus, MSTATUS_MPELP);
+    }
+    env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, 0);
+
     return retpc;
 }
 
-- 
2.44.0


