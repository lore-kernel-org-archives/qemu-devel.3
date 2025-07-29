Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A978C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguSv-00042L-F5; Tue, 29 Jul 2025 20:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFP-0001tb-Kj
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:44 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFN-00044K-H3
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:43 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-74b56b1d301so4182363b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833640; x=1754438440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Wa2B38FBrRML3JhfFoL7KoTHohz6g2FLAwLDDbLgVA=;
 b=nBYPhezUHsnVLMn5JqFvUxYg+fNcmamrI1U2VwodtxXd+tAAKVGhcMFFxE/EDC2raE
 vDXGIg0iFDoJKHxIzWWZSnihhHWskXLv/LiiX80lQYrts/iPtLN8tCtzChKcilC2/18o
 fRjiYugYeEe+cDJ9HmlWjnIFjFc5wUwIc+21/T6EuCegyE6Ot+5YnD5nUV3KyZjA7euH
 RyeA1wL3NMUbCbTc50VAHErt5xh5if1tVdhDypBmHWjL23pVs6LQMHanT21g0ujGCgl8
 N1vhH0dXClp/LJzek+B//9tM55J8MnVqal7YLORUEF32evsKUdIS/d8w5KCuY6mni/Z9
 fHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833640; x=1754438440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Wa2B38FBrRML3JhfFoL7KoTHohz6g2FLAwLDDbLgVA=;
 b=j0l1LU8JzlcXvUTElC1j64Qa+VYuW+91JK397/2u4H51HxBhREc1eI2iE4iqb3mdmG
 5KDmObe3LhUUFOwAygDrmInbvGgzu4TbML7mvtK/5cTplWXklqthR6Khd/wsqGiQ+Qfx
 dgQHcbNDYt13/dYGFkJxOgQ+PVg3Pt6Z71JfoIjrPwiqZ+KH5fMWy/xe8jU0pCHmNtFY
 NJILJdxyD6FxNgei4W3WZMznRMOmkKL3x19jSffWN/uS3pnHxUPgu04alpF2NEiCrQLd
 NRCiyVOPd/vnFWkIEKVN4lDiUZa2rn7FFQeKR4V2X2bIbk/YkNJtqeWWpCvneCgBhrWL
 ApPw==
X-Gm-Message-State: AOJu0YyGb/tQwVRhnKqpYZdc/Vr0hqfuhT8L0rKi/pBd0M3i/lY+5lfy
 wgJt53HmZAfyDXEE0WrLucpVdg25lZRdXzyJhPqKy/Ut8J3oaCvzwu8+4nvLiCmAqE3saD6fFm1
 yrKPd
X-Gm-Gg: ASbGncu+mw386cKF0Wk8Xe4hzwfjKKOp4uxOVJDtdE6znxhE1I3LMWE2B08Q/azqAhW
 y6A0BpmZPSYMu3pnmCEQLqNbU0VDA1aLVrOmtUP0ibd3b7IgnsNIXB80u/BEAaA3MAGEYfR4utQ
 pehC3F6UNMelxz2UNVJET0xrBueVY7u/sbmdLIgA9/3qUEZyT98hgR4UkWuWYd9ucc6V1fkfrfg
 cStIPCSCOleYhcO+O5j7kol3TUw3EkrXVR0a4tYdZe3pkiW71I/uw2Ma4JkAvwrIHeOwEFkrBq6
 wjBdoYPGSem/mfcqlfVvPCBzAmrh/Jnp9QLWu2KPERji9cmKz1XwrONlW9ZANwOpVLsE+j+luFA
 AXqkyB5AF/mCLqVhBuzkQTDmjSuuw1t/rjjhox98afDORWGY17Qc3Ixv4EgMkC/X/1+Xs4p8Btm
 r6bDhcUmmR64HNaX427yY1
X-Google-Smtp-Source: AGHT+IHDsn/+AfLXeV7Jf2NjqNgEBCcZ1VmhdXJTDc7EtpF0LQIJqYqLKpkRLW5YTDQzlvf8Tr/HaA==
X-Received: by 2002:a05:6a00:21c5:b0:736:3979:369e with SMTP id
 d2e1a72fcca58-76ab1611ca0mr1897574b3a.9.1753833639422; 
 Tue, 29 Jul 2025 17:00:39 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/89] linux-user: Unify init of semihosting fields in
 TaskState
Date: Tue, 29 Jul 2025 13:58:54 -1000
Message-ID: <20250730000003.599084-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Initialize all 3 fields in main(), rather than in 4 different
target-specific functions.  Adjust the ifdef to be function
rather than target specific.  Include stack_base in the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h             |  4 ++--
 linux-user/aarch64/cpu_loop.c |  8 --------
 linux-user/arm/cpu_loop.c     | 37 +++++++++++++++--------------------
 linux-user/m68k/cpu_loop.c    |  9 ---------
 linux-user/main.c             |  5 +++++
 linux-user/riscv/cpu_loop.c   |  5 -----
 6 files changed, 23 insertions(+), 45 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 6c97ab221f..dff7767bc8 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -122,12 +122,12 @@ struct TaskState {
 #ifdef TARGET_M68K
     abi_ulong tp_value;
 #endif
-#if defined(TARGET_ARM) || defined(TARGET_M68K) || defined(TARGET_RISCV)
+#ifdef CONFIG_SEMIHOSTING
     /* Extra fields for semihosted binaries.  */
     abi_ulong heap_base;
     abi_ulong heap_limit;
-#endif
     abi_ulong stack_base;
+#endif
     int used; /* non zero if used */
     struct image_info *info;
     struct linux_binprm *bprm;
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index fea43cefa6..030a630c93 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -140,9 +140,6 @@ void cpu_loop(CPUARMState *env)
 void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
-    TaskState *ts = get_task_state(cs);
-    struct image_info *info = ts->info;
     int i;
 
     if (!(arm_feature(env, ARM_FEATURE_AARCH64))) {
@@ -167,9 +164,4 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
     if (cpu_isar_feature(aa64_pauth, cpu)) {
         qemu_guest_getrandom_nofail(&env->keys, sizeof(env->keys));
     }
-
-    ts->stack_base = info->start_stack;
-    ts->heap_base = info->brk;
-    /* This will be filled in on the first SYS_HEAPINFO call.  */
-    ts->heap_limit = 0;
 }
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 33f63951a9..1f3bb96484 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -482,30 +482,25 @@ void cpu_loop(CPUARMState *env)
 
 void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
-    CPUState *cpu = env_cpu(env);
-    TaskState *ts = get_task_state(cpu);
-    struct image_info *info = ts->info;
-    int i;
-
     cpsr_write(env, regs->uregs[16], CPSR_USER | CPSR_EXEC,
                CPSRWriteByInstr);
-    for(i = 0; i < 16; i++) {
+    for (int i = 0; i < 16; i++) {
         env->regs[i] = regs->uregs[i];
     }
-#if TARGET_BIG_ENDIAN
-    /* Enable BE8.  */
-    if (EF_ARM_EABI_VERSION(info->elf_flags) >= EF_ARM_EABI_VER4
-        && (info->elf_flags & EF_ARM_BE8)) {
-        env->uncached_cpsr |= CPSR_E;
-        env->cp15.sctlr_el[1] |= SCTLR_E0E;
-    } else {
-        env->cp15.sctlr_el[1] |= SCTLR_B;
-    }
-    arm_rebuild_hflags(env);
-#endif
 
-    ts->stack_base = info->start_stack;
-    ts->heap_base = info->brk;
-    /* This will be filled in on the first SYS_HEAPINFO call.  */
-    ts->heap_limit = 0;
+    if (TARGET_BIG_ENDIAN) {
+        CPUState *cpu = env_cpu(env);
+        TaskState *ts = get_task_state(cpu);
+        struct image_info *info = ts->info;
+
+        /* Enable BE8.  */
+        if (EF_ARM_EABI_VERSION(info->elf_flags) >= EF_ARM_EABI_VER4
+            && (info->elf_flags & EF_ARM_BE8)) {
+            env->uncached_cpsr |= CPSR_E;
+            env->cp15.sctlr_el[1] |= SCTLR_E0E;
+        } else {
+            env->cp15.sctlr_el[1] |= SCTLR_B;
+        }
+        arm_rebuild_hflags(env);
+    }
 }
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 5da91b997a..23693f3358 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -94,10 +94,6 @@ void cpu_loop(CPUM68KState *env)
 
 void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
-    CPUState *cpu = env_cpu(env);
-    TaskState *ts = get_task_state(cpu);
-    struct image_info *info = ts->info;
-
     env->pc = regs->pc;
     env->dregs[0] = regs->d0;
     env->dregs[1] = regs->d1;
@@ -116,9 +112,4 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
     env->aregs[6] = regs->a6;
     env->aregs[7] = regs->usp;
     env->sr = regs->sr;
-
-    ts->stack_base = info->start_stack;
-    ts->heap_base = info->brk;
-    /* This will be filled in on the first SYS_HEAPINFO call.  */
-    ts->heap_limit = 0;
 }
diff --git a/linux-user/main.c b/linux-user/main.c
index 68972f00a1..4def4be1c1 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1050,6 +1050,11 @@ int main(int argc, char **argv, char **envp)
 
 #ifdef CONFIG_SEMIHOSTING
     qemu_semihosting_guestfd_init();
+
+    ts->stack_base = info->start_stack;
+    ts->heap_base = info->brk;
+    /* This will be filled in on the first SYS_HEAPINFO call.  */
+    ts->heap_limit = 0;
 #endif
 
     cpu_loop(env);
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 3ac8bbfec1..2dd30c7b28 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -108,9 +108,4 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
         error_report("Incompatible ELF: RVE cpu requires RVE ABI binary");
         exit(EXIT_FAILURE);
     }
-
-    ts->stack_base = info->start_stack;
-    ts->heap_base = info->brk;
-    /* This will be filled in on the first SYS_HEAPINFO call.  */
-    ts->heap_limit = 0;
 }
-- 
2.43.0


