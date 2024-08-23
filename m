Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A05C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 19:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shZXo-00038t-2P; Fri, 23 Aug 2024 15:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shZXk-00032G-8w
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 15:01:53 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shZXi-0004Hv-0p
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 15:01:51 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2021c03c13aso18251155ad.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724439708; x=1725044508;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JtrgC4+fHlAa4XAwLJHyCFy+eiQX4gwNZ2q8o9OZBM=;
 b=1yoj9dP7KfL5QysCPtJX90h36hgqoCmRP3Oj2UeyPCquzHSv7Y8u6+iGsj130Zr9JA
 ik9+WMxCVSAQeXDxAxdFN13wgBdCIWRNYGc/qlt23jpHM9/YOH4R53kKr75yQ1KyFZpp
 W0nlG1Y6ztwPtkMQR8Oy10yXTGTY5CmTyotLpGz3PYzOUqjLhoEy7BiGG7rb4As54aVn
 MU1GEO9cyVUEpBJbbOQheKIGAnJnBnLoxewtlWHbIcxZcehP3pj5Qyzocg2phkXKgcx7
 mIEhPYcKu57NU+I82PJL0xDSWiRvnjKmO4StjIAt1CbnFJNY6sLDeP+Tg0NhkNDVJeWE
 RVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724439708; x=1725044508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5JtrgC4+fHlAa4XAwLJHyCFy+eiQX4gwNZ2q8o9OZBM=;
 b=ISBWqPjB0E860TeKdrC7mrnvLS81HYro+VcfQrGuwlfM8g9ZbtAyxi8TBNP7V9tE8t
 dmnsUs8Lku2Cn6dskQ6NIK3dah0x1XX8T29wfsFdIRtMmCkkwsc4jEmfAxWlGy34/Y7N
 kgYr0n1U7wJsOIHUFAMyx2Tm67up30tY/o8gskeoli0SipiU/imQchT598/tHdymQCOy
 krAzNv2m/Irggdy10fwCaNPlQQHPau3S1F4tjymIQBWdVML4Tluo22z0S8K681UDhl9h
 DtuB7vylNuTOuhIzT0nSg2cLDH1lsgnZuvaIa+B/FkqkrDNUuwvgW7+NOSSatppw3G9X
 b95A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHOOF9VQ8XaqmZlzHu/k0m/FEq1WpxH72aj74m89zMR48k6PGm1XOTXhhWWYEJtx0IDGjBrcs24aRB@nongnu.org
X-Gm-Message-State: AOJu0Ywc3VWMwDk8oSq/348xAeq3QUw+oe3y2CQuxpCuIASmQc0XwRvE
 U3jMOuKZnChFiezCQmj5OZQ9Os1aaNoBHcjDbLtHLnofEXXAlqlaF6p26QNrB9g=
X-Google-Smtp-Source: AGHT+IEgOvXW9BChTmsoW+QsGrubu/3JiECN5AW5n/P97ZAvdE0xNDZ1paBTUExTZ8/fNgRlkKZe3A==
X-Received: by 2002:a17:902:cece:b0:201:f2bc:7784 with SMTP id
 d9443c01a7336-2039c44be7amr49332425ad.11.1724439707869; 
 Fri, 23 Aug 2024 12:01:47 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0c37768sm1749885ad.230.2024.08.23.12.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 12:01:47 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 richard.henderson@linaro.org, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v8 03/17] target/riscv: save and restore elp state on priv
 transitions
Date: Fri, 23 Aug 2024 12:01:25 -0700
Message-ID: <20240823190140.4156920-4-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240823190140.4156920-1-debug@rivosinc.com>
References: <20240823190140.4156920-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/riscv/cpu.c        |  5 ++++
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_helper.c | 55 +++++++++++++++++++++++++++++++++++++++
 target/riscv/op_helper.c  | 18 +++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8e1f05e5b1..083d405516 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1022,6 +1022,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->load_res = -1;
     set_default_nan_mode(1, &env->fp_status);
 
+#ifdef CONFIG_USER_ONLY
+    /* qemu-user for riscv, fcfi is off by default */
+    env->ufcfien = false;
+#endif
+
 #ifndef CONFIG_USER_ONLY
     if (cpu->cfg.debug) {
         riscv_trigger_reset_hold(env);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f966c36a31..7be0fa30f7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -226,6 +226,7 @@ struct CPUArchState {
     bool      elp;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
+    bool ufcfien;
 #endif
 
 #ifndef CONFIG_USER_ONLY
@@ -530,6 +531,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
+bool cpu_get_fcfien(CPURISCVState *env);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6709622dd3..12484ca7d2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -33,6 +33,7 @@
 #include "cpu_bits.h"
 #include "debug.h"
 #include "tcg/oversized-guest.h"
+#include "pmp.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -63,6 +64,34 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 #endif
 }
 
+bool cpu_get_fcfien(CPURISCVState *env)
+{
+    /* no cfi extension, return false */
+    if (!env_archcpu(env)->cfg.ext_zicfilp) {
+        return false;
+    }
+#ifdef CONFIG_USER_ONLY
+    return env->ufcfien;
+#else
+    switch (env->priv) {
+    case PRV_U:
+        if (riscv_has_ext(env, RVS)) {
+            return env->senvcfg & MENVCFG_LPE;
+        }
+        return env->menvcfg & MENVCFG_LPE;
+    case PRV_S:
+        if (env->virt_enabled) {
+            return env->henvcfg & HENVCFG_LPE;
+        }
+        return env->menvcfg & MENVCFG_LPE;
+    case PRV_M:
+        return env->mseccfg & MSECCFG_MLPE;
+    default:
+        g_assert_not_reached();
+    }
+#endif
+}
+
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
@@ -546,6 +575,15 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
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
@@ -1754,6 +1792,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
 
@@ -1802,6 +1845,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
@@ -1833,6 +1881,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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


