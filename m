Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AD6CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPTH-0005lp-S2; Wed, 27 Aug 2025 19:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSp-0004Ff-Eu
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:00 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSg-0004Hp-Mx
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:59 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7720f231151so531773b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336905; x=1756941705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zolOYltkv8RezxxcgBErduiyzlKHX3ba4myoc0G9Zok=;
 b=SjbOvKeDprO66bRCGakaxkR4F/qdLaFR0agk/mjr+67PGPCWXQp/AVc8ErleO9//SS
 R0d9Ryd/6XyJA4DZK1zO3KD4W7QVNihxV5GY5wu00KZ+kICRELovEUr6meK+qVOVJc1J
 euo4v+qfgzTZukHEN2MtV/uSJwxeXUx1cMAxwO6cUE2WR/bPPR78FdVWAyVRnkGFYGUE
 s2krZ1q4ekpQ+YVGI1kYkgwEIvrEv560vHyL2tH1nEiIqwiKobZoIutmZTkmYt+CSKh9
 aKJpk8v8JYQupwyi4HB/d0DtaWHnCxIz7fpukr8ZGiYHo1oE8udAXc/akEhs49ap5cKz
 Aijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336905; x=1756941705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zolOYltkv8RezxxcgBErduiyzlKHX3ba4myoc0G9Zok=;
 b=HtnN9jNLvJJPrw3PRgSJd5cbb2gnvWU+jJlTBRQQjygNppmzKzNTJBE2176iRA0o2f
 l4bjSLccoXsAOGT7TIqjzjfH9+qbqJ9dGIlDloaajCb9oATpJYxh8MGLWVdHZezHPA6u
 pJuD/9NFFCwSsorSxMZ8aS24GDb4+mqPa4o2jAHrfqlVTIjJdHU20qOFjucXsmV5aLKE
 sctvs8QQS9Peik/2qJGYQzFsRAJvC6GGsvzB+DETrVWmTqE0Jcu9K47m90LfX+mBporS
 FthOrSTteYXu9zfQ5jDJ55w9m4UWvLebfO9z96B7clVzOhpKAAbiKcEZxC9fpvf4kooY
 ACPQ==
X-Gm-Message-State: AOJu0YzVjw7xCKdr2oVeHpgeaGYwY/HmPwaW2zp1Yw6TFAGm6P2MQz2F
 LEjG2eYKJZbW1YlXV3oOVGYSmtGj352I3AHCm/U9WCaK/hg8XieKIRh/tcUPpEYI+cv83PsqPEm
 kHaS+gRw=
X-Gm-Gg: ASbGnct+UwFCHD56HeYboqxD7A0qA2MgGeq8nlgGMU19qU/rU7qVUmtfgBQLZ71hQLO
 7VL9Ii3GvCDo2EzC97Oa0626DOIjb+5132OFxP3/0RgmXu5QU7/E6RY8+a/QNFCW9PHRMRTLKdt
 5Wyr6Gr6ZZhZ1UAVpLfIPKisbFDN2Ly8ul8mYBbsOTJ/o02v+kLrpecZHxO8G8COjGdnirj+NLi
 293XVbBu8nmGxdO098lYSYrJ1cj9BuZa+IBsoQcgetgL+oAYKtPfwd8QvtfqlOQPkPEcoHiU1uj
 jmpLds2WbfuoJ8qWHxlygK9+G4N14nY8guW4Iv6sXb+ZH1CJFLu+MgXuc9MGKfRxrijRbvkml79
 bedPHTXQTWn9xpMv1RZORfr4Bzg==
X-Google-Smtp-Source: AGHT+IGEN9d8Z1HWeaBkbROoUhKrHOKCFJMONeu3vywGY5ScbeiOxthcc48/6xRk9vfXGKDG/tgMfg==
X-Received: by 2002:a05:6a00:1147:b0:76e:7ae5:ec90 with SMTP id
 d2e1a72fcca58-7702fad63b5mr23534959b3a.26.1756336905438; 
 Wed, 27 Aug 2025 16:21:45 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 26/46] linux-user/i386: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:03 +1000
Message-ID: <20250827232023.50398-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.
Temporarily introduce HAVE_INIT_MAIN_THREAD during conversion.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h          |  1 +
 linux-user/elfload.c       | 29 +++++------------------
 linux-user/i386/cpu_loop.c | 48 +++++++++++++++++---------------------
 3 files changed, 29 insertions(+), 49 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 0c3cfe93a1..8a9500d4f4 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -361,5 +361,6 @@ CPUArchState *cpu_copy(CPUArchState *env);
 
 typedef struct target_pt_regs target_pt_regs;
 void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
+void init_main_thread(CPUState *cs, struct image_info *info);
 
 #endif /* QEMU_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6fce74f45a..89f3972253 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -149,17 +149,12 @@ typedef abi_int         target_pid_t;
 
 #ifdef TARGET_I386
 
+#define HAVE_INIT_MAIN_THREAD
+
 #ifdef TARGET_X86_64
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
 
-static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
-{
-    regs->rax = 0;
-    regs->rsp = infop->start_stack;
-    regs->rip = infop->entry;
-}
-
 #define ELF_NREG    27
 typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
 
@@ -237,22 +232,6 @@ static bool init_guest_commpage(void)
 
 #define EXSTACK_DEFAULT true
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->esp = infop->start_stack;
-    regs->eip = infop->entry;
-
-    /* SVR4/i386 ABI (pages 3-31, 3-32) says that when the program
-       starts %edx contains a pointer to a function which might be
-       registered using `atexit'.  This provides a mean for the
-       dynamic linker to call DT_FINI functions for shared libraries
-       that have been loaded before the code runs.
-
-       A value of 0 tells we have no such handler.  */
-    regs->edx = 0;
-}
-
 #define ELF_NREG    17
 typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
 
@@ -3621,8 +3600,12 @@ static int elf_core_dump(int signr, const CPUArchState *env)
 
 void do_init_main_thread(CPUState *cs, struct image_info *infop)
 {
+#ifdef HAVE_INIT_MAIN_THREAD
+    init_main_thread(cs, infop);
+#else
     target_pt_regs regs = { };
 
     init_thread(&regs, infop);
     target_cpu_copy_regs(cpu_env(cs), &regs);
+#endif
 }
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index d96d5553fa..7b2d8b03d8 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -331,11 +331,10 @@ static void target_cpu_free(void *obj)
     g_free(obj);
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cpu, struct image_info *info)
 {
-    CPUState *cpu = env_cpu(env);
+    CPUArchState *env = cpu_env(cpu);
     bool is64 = (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) != 0;
-    int i;
 
     OBJECT(cpu)->free = target_cpu_free;
     env->cr[0] = CR0_PG_MASK | CR0_WP_MASK | CR0_PE_MASK;
@@ -361,28 +360,25 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
     /* flags setup : we activate the IRQs by default as in user mode */
     env->eflags |= IF_MASK;
 
-    /* linux register setup */
-#ifndef TARGET_ABI32
-    env->regs[R_EAX] = regs->rax;
-    env->regs[R_EBX] = regs->rbx;
-    env->regs[R_ECX] = regs->rcx;
-    env->regs[R_EDX] = regs->rdx;
-    env->regs[R_ESI] = regs->rsi;
-    env->regs[R_EDI] = regs->rdi;
-    env->regs[R_EBP] = regs->rbp;
-    env->regs[R_ESP] = regs->rsp;
-    env->eip = regs->rip;
-#else
-    env->regs[R_EAX] = regs->eax;
-    env->regs[R_EBX] = regs->ebx;
-    env->regs[R_ECX] = regs->ecx;
-    env->regs[R_EDX] = regs->edx;
-    env->regs[R_ESI] = regs->esi;
-    env->regs[R_EDI] = regs->edi;
-    env->regs[R_EBP] = regs->ebp;
-    env->regs[R_ESP] = regs->esp;
-    env->eip = regs->eip;
-#endif
+    /*
+     * Linux register setup.
+     *
+     * SVR4/i386 ABI (pages 3-31, 3-32) says that when the program
+     * starts %edx contains a pointer to a function which might be
+     * registered using `atexit'.  This provides a mean for the
+     * dynamic linker to call DT_FINI functions for shared libraries
+     * that have been loaded before the code runs.
+     * A value of 0 tells we have no such handler.
+     *
+     * This applies to x86_64 as well as i386.
+     *
+     * That said, the kernel's ELF_PLAT_INIT simply zeros all of the general
+     * registers.  Note that x86_cpu_reset_hold will set %edx to cpuid_version;
+     * clear all general registers defensively.
+     */
+    memset(env->regs, 0, sizeof(env->regs));
+    env->regs[R_ESP] = info->start_stack;
+    env->eip = info->entry;
 
     /* linux interrupt setup */
 #ifndef TARGET_ABI32
@@ -394,7 +390,7 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
                                 PROT_READ|PROT_WRITE,
                                 MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
     idt_table = g2h_untagged(env->idt.base);
-    for (i = 0; i < 20; i++) {
+    for (int i = 0; i < 20; i++) {
         set_idt(i, 0, is64);
     }
     set_idt(3, 3, is64);
-- 
2.43.0


