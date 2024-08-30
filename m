Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB91CA0EFD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 16:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk4nR-0001Bt-Fs; Fri, 30 Aug 2024 12:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nP-00015F-KA
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:23 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nN-0006zT-A0
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:23 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7cd8afc9ff3so2264905a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725036500; x=1725641300;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TO9RVM4qqMXpCQILe87S+EfpkoSRJY+r41oxKhyYDDw=;
 b=ZXaRH+QScWC1KbrYHgGMRRWIGnQd/+97gEhh0JJlSuSTon1MVrBWxNn0f726rT8VEr
 HPYSrAUlLrsFGyzy+8FkFjSZls3PbtZVUK46UWjbRYkj98sI0zggaJ7VvINdx+d5wWwd
 0EZwIyLoVu5yLQ6URwHo6HVb7ERQMQP+bdUAwm2kDDRqNjGoAcsChMHp/CNd1QJUQbMr
 aGApspcOBGUG2R2LqRn56+sMLDF4MHHbtKUQRPCOq+xCpIwxN8TWbTlD7BBBFUEb9ZTc
 cAVJE1xmw3M2ilQDtD4XhjRoZjwry0hXgevlMf+RWDhAT9/5+A16DEjTroOJ4pWBU4ik
 OeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725036500; x=1725641300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TO9RVM4qqMXpCQILe87S+EfpkoSRJY+r41oxKhyYDDw=;
 b=f0UYpZbiQMXwg0BotYvP4iaGbCYuOxX/pn7wLB7gSD2rJV2XvP2YxVwcSIy/pFGbDG
 x7zmRhKnTVArWLWv2UBJbhaPJuuc7hN7evT7PoFDTMRr8UiZYzfNGx9GLSBPZvveW0g8
 JnAES+KnSp4f+c6Q9hGGllx/l6qs6+z7N1ngWYHatHlYB9LEpzims3P9oiD516wgVtHx
 rPZB/3AXkPH/OsWsS/ah6YPa2h83XT9SsIeORLzfvY+Y/ptQDG0jAdkbUnvrk5RcXrL1
 kSAQjbkt+++E0vl2r2IphbkdHLuHa6lf+Dw/Ky092pBqRnS2qGRIvnrVhRltZA34N2/d
 jw6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmJh1QEMU/6b7lHxKMVpbP96zK0vDw4X3wKiwWVKfPby1N2eGeHwyPWq3QnxdeqFB6kXxUCwmhx6C9@nongnu.org
X-Gm-Message-State: AOJu0YwhmQO3mU2X4Y3+F5Dtd3WnHvi/ypi3APdQF/N+ltDfZoJW3ngt
 Uq1Lv78z7OZKhKlIXuMR5ZSt0J6NU7fuxZqXhkGV44KgbfGU/hQ0UMSTzT69QQc=
X-Google-Smtp-Source: AGHT+IFpFXgyH30aRbSYMb7Ru8iOC0jzrEByjd/GFTG+Nerx7JE40TzHB89kQ9grD5vuvUNQdOlMnA==
X-Received: by 2002:a17:90a:d310:b0:2cf:f860:f13b with SMTP id
 98e67ed59e1d1-2d86b04e9eemr4642353a91.17.1725036499753; 
 Fri, 30 Aug 2024 09:48:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8445e813dsm6591257a91.17.2024.08.30.09.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 09:48:19 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v13 11/20] target/riscv: introduce ssp and enabling controls
 for zicfiss
Date: Fri, 30 Aug 2024 09:47:47 -0700
Message-ID: <20240830164756.1154517-12-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240830164756.1154517-1-debug@rivosinc.com>
References: <20240830164756.1154517-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x52f.google.com
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

zicfiss introduces a new state ssp ("shadow stack register") in cpu.
ssp is expressed as a new unprivileged csr (CSR_SSP=0x11) and holds
virtual address for shadow stack as programmed by software.

Shadow stack (for each mode) is enabled via bit3 in *envcfg CSRs.
Shadow stack can be enabled for a mode only if it's higher privileged
mode had it enabled for itself. M mode doesn't need enabling control,
it's always available if extension is available on cpu.

This patch also implements helper bcfi function which determines if bcfi
is enabled at current privilege or not.

Adds ssp to migration state as well.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c        |  2 ++
 target/riscv/cpu.h        |  3 +++
 target/riscv/cpu_bits.h   |  6 +++++
 target/riscv/cpu_helper.c | 29 ++++++++++++++++++++++
 target/riscv/csr.c        | 52 +++++++++++++++++++++++++++++++++++++++
 target/riscv/machine.c    | 19 ++++++++++++++
 6 files changed, 111 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 29b4bdb40a..c5ebcefeb5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1021,6 +1021,8 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 
     /* on reset elp is clear */
     env->elp = false;
+    /* on reset ssp is set to 0 */
+    env->ssp = 0;
 
     env->xl = riscv_cpu_mxl(env);
     riscv_cpu_update_mask(env);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f372a4074b..4ace54a2eb 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,6 +224,8 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     bool      elp;
+    /* shadow stack register for zicfiss extension */
+    target_ulong ssp;
     /* sw check code for sw check exception */
     target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
@@ -534,6 +536,7 @@ bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
 bool cpu_get_fcfien(CPURISCVState *env);
+bool cpu_get_bcfien(CPURISCVState *env);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 900769ce60..48ce24dc32 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -34,6 +34,9 @@
 
 /* Control and Status Registers */
 
+/* zicfiss user ssp csr */
+#define CSR_SSP             0x011
+
 /* User Trap Setup */
 #define CSR_USTATUS         0x000
 #define CSR_UIE             0x004
@@ -754,6 +757,7 @@ typedef enum RISCVException {
 /* Execution environment configuration bits */
 #define MENVCFG_FIOM                       BIT(0)
 #define MENVCFG_LPE                        BIT(2) /* zicfilp */
+#define MENVCFG_SSE                        BIT(3) /* zicfiss */
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
@@ -768,12 +772,14 @@ typedef enum RISCVException {
 
 #define SENVCFG_FIOM                       MENVCFG_FIOM
 #define SENVCFG_LPE                        MENVCFG_LPE
+#define SENVCFG_SSE                        MENVCFG_SSE
 #define SENVCFG_CBIE                       MENVCFG_CBIE
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
 #define HENVCFG_LPE                        MENVCFG_LPE
+#define HENVCFG_SSE                        MENVCFG_SSE
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c3820eff8f..460b471387 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -91,6 +91,35 @@ bool cpu_get_fcfien(CPURISCVState *env)
     }
 }
 
+bool cpu_get_bcfien(CPURISCVState *env)
+{
+    /* no cfi extension, return false */
+    if (!env_archcpu(env)->cfg.ext_zicfiss) {
+        return false;
+    }
+
+    switch (env->priv) {
+    case PRV_U:
+        /*
+         * If S is not implemented then shadow stack for U can't be turned on
+         * It is checked in `riscv_cpu_validate_set_extensions`, so no need to
+         * check here or assert here
+         */
+        return env->senvcfg & SENVCFG_SSE;
+#ifndef CONFIG_USER_ONLY
+    case PRV_S:
+        if (env->virt_enabled) {
+            return env->henvcfg & HENVCFG_SSE;
+        }
+        return env->menvcfg & MENVCFG_SSE;
+    case PRV_M: /* M-mode shadow stack is always off */
+        return false;
+#endif
+    default:
+        g_assert_not_reached();
+    }
+}
+
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a5a969a377..ec04b2b32b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -185,6 +185,25 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException cfi_ss(CPURISCVState *env, int csrno)
+{
+    if (!env_archcpu(env)->cfg.ext_zicfiss) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    /* if bcfi not active for current env, access to csr is illegal */
+    if (!cpu_get_bcfien(env)) {
+#if !defined(CONFIG_USER_ONLY)
+        if (env->debugger) {
+            return RISCV_EXCP_NONE;
+        }
+#endif
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static RISCVException mctr(CPURISCVState *env, int csrno)
 {
@@ -596,6 +615,19 @@ static RISCVException seed(CPURISCVState *env, int csrno)
 #endif
 }
 
+/* zicfiss CSR_SSP read and write */
+static int read_ssp(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->ssp;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_ssp(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->ssp = val;
+    return RISCV_EXCP_NONE;
+}
+
 /* User Floating-Point CSRs */
 static RISCVException read_fflags(CPURISCVState *env, int csrno,
                                   target_ulong *val)
@@ -2111,6 +2143,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         if (env_archcpu(env)->cfg.ext_zicfilp) {
             mask |= MENVCFG_LPE;
         }
+
+        if (env_archcpu(env)->cfg.ext_zicfiss) {
+            mask |= MENVCFG_SSE;
+        }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
@@ -2167,6 +2203,13 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
         mask |= SENVCFG_LPE;
     }
 
+    /* Higher mode SSE must be ON for next-less mode SSE to be ON */
+    if (env_archcpu(env)->cfg.ext_zicfiss &&
+        get_field(env->menvcfg, MENVCFG_SSE) &&
+        (env->virt_enabled ? get_field(env->henvcfg, HENVCFG_SSE) : true)) {
+        mask |= SENVCFG_SSE;
+    }
+
     env->senvcfg = (env->senvcfg & ~mask) | (val & mask);
     return RISCV_EXCP_NONE;
 }
@@ -2208,6 +2251,12 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         if (env_archcpu(env)->cfg.ext_zicfilp) {
             mask |= HENVCFG_LPE;
         }
+
+        /* H can light up SSE for VS only if HS had it from menvcfg */
+        if (env_archcpu(env)->cfg.ext_zicfiss &&
+            get_field(env->menvcfg, MENVCFG_SSE)) {
+            mask |= HENVCFG_SSE;
+        }
     }
 
     env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
@@ -4663,6 +4712,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Zcmt Extension */
     [CSR_JVT] = {"jvt", zcmt, read_jvt, write_jvt},
 
+    /* zicfiss Extension, shadow stack register */
+    [CSR_SSP]  = { "ssp", cfi_ss, read_ssp, write_ssp },
+
 #if !defined(CONFIG_USER_ONLY)
     /* Machine Timers and Counters */
     [CSR_MCYCLE]    = { "mcycle",    any,   read_hpmcounter,
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 873957c4ab..84d5ecf436 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -369,6 +369,24 @@ static const VMStateDescription vmstate_elp = {
     }
 };
 
+static bool ssp_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    return cpu->cfg.ext_zicfiss;
+}
+
+static const VMStateDescription vmstate_ssp = {
+    .name = "cpu/ssp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ssp_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINTTL(env.ssp, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 10,
@@ -442,6 +460,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_smstateen,
         &vmstate_jvt,
         &vmstate_elp,
+        &vmstate_ssp,
         NULL
     }
 };
-- 
2.44.0


