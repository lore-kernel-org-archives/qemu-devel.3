Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53170C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguS1-0002aQ-CF; Tue, 29 Jul 2025 20:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFS-0001wp-4O
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:46 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFQ-00044s-1b
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:45 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76a3818eb9bso857827b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833642; x=1754438442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s1q314E+BpLEmsCVDcK29u65d92IGDqMC0sxDATOALA=;
 b=UkkE5yivXBMwfEvtERyJ9w2jwFHSqIL7HCklPEKSMEiK1rCfX4WLpHLF1Ni5O9BSiz
 LA22AvLUZtNVcvFevGGUzJlwMAHSSz5e58Y8E1eUHtD5dEqIm1nVtfdaTTyJsPSxdreq
 RsV7i7QsxJ/HxQBolOLXB2VpR00sCBXZnPJWBe5eNErt2BvZRtRFkkbkfVdSlhlbPGQq
 iheZoyqEALphoxWcbMRfglTqNlTb30Kl1NJ5cBXa7IFFuktYrGGrvnHTmJXDnBpddHD4
 gI/Sb7sCfITlQiJ5X0Xcs5fHcEXwtbeLcPDitspkyseQSneQRK5IiU33CWI8CtUC9ZLy
 yJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833642; x=1754438442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1q314E+BpLEmsCVDcK29u65d92IGDqMC0sxDATOALA=;
 b=RYdHVbnV4lnltR1w1lQSTXSsdSNu4UxvG7SS5sEOIXmUjbcI+3dZi6L1z3xK2TxpMI
 lcqgWa3rQ8hZxYdU3ykr965YtK4uKgre+gqUAWp1RADTJOIajGkrMKfwF9kvFL+e4xbU
 Dgzmsu5hLpUmGHhZMhuGvHJMv6JQ1ondX+vR1239BjibrRgjT+ktn/4BgkJFSMmsExLH
 dnc1qA1C2iGbXDlssgyfYBaMosXHm+T2Go1hFbTgUo4K5uC1XjcL+vpWTkNJQMaK93o3
 3Cf1ZyE4XLtD1vim37U1CW5G7yEiH6+RFJIBBbPhWkjySveNhd8kv8sp3bDIXDlTMGk/
 HAEA==
X-Gm-Message-State: AOJu0YxQ8EKN3R8Z5Aq3It+JgsczLrRpeRcmQ9Kh1tP3L39xVszN1aWh
 59TqmPpX9X8NvIuWRlbrfbvus8m9bgnEJHpScwpx0h57PvmVFSFJ0iXS6CTjKRw4ijpKgSu9qRb
 y+R8p
X-Gm-Gg: ASbGncuYK8Pepvr5QlT8P/fTYjcU1E5By77JXTIsvjmSNjL2KCE5ljivJ/zZ+XK7xka
 avzXb9OAHYWskAERG9A6DiPZp+yb16Ttr+4EyAd4gI44UJRAGcn8dstIXPXmusdETU4ER+5zi/q
 vjW4X2ufCbl5EtwbDqh4xs/5XIGAXWUVzoXtjGHTlXj0MkIJDZqUKQ9Xu3+LAJbysppyQgTY3hK
 72p3QyLdhC38HIaIcnYbTEj/vXxJthK/5W7XzYntkKZUwbFnGANtfrxckuZK9A40L/3p2pi3Vxx
 PWPKoBzPkUAKTmtC4RCwnBPB56rXcG7SExdHR3k5AQT4WMuUm2QJicKhPujLHwzbwm3YXlP935U
 DDze8od2yhMEz5R5MaUZD+JwGrK2GZIYvwdzScCxNfsNHsnBD77QFKOIAppV7Cw0QSpsQjwk7ox
 gIWdPboy429XjOmd8Bs9vWVFh/vf3hctU=
X-Google-Smtp-Source: AGHT+IHBhwmP0uGyDKJzoPAZjMVdiE/KSdgr9+VH6LyNmcHhAYbgLdhCtzZnkAhkj9jT+BDzAWNfDA==
X-Received: by 2002:a05:6a00:4fd0:b0:748:e8c7:5a38 with SMTP id
 d2e1a72fcca58-76ab3309ab0mr1706921b3a.23.1753833642103; 
 Tue, 29 Jul 2025 17:00:42 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/89] linux-user/i386: Create init_main_thread
Date: Tue, 29 Jul 2025 13:58:56 -1000
Message-ID: <20250730000003.599084-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h          |  1 +
 linux-user/elfload.c       | 29 ++++++-----------------------
 linux-user/i386/cpu_loop.c | 31 ++++++-------------------------
 3 files changed, 13 insertions(+), 48 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index dff7767bc8..475b11e4c4 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -367,5 +367,6 @@ CPUArchState *cpu_copy(CPUArchState *env);
 
 typedef struct target_pt_regs target_pt_regs;
 void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
+void init_main_thread(CPUState *cs, struct image_info *info);
 
 #endif /* QEMU_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1d8cc7f6b5..553d632d46 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -155,17 +155,12 @@ typedef abi_int         target_pid_t;
 
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
 
@@ -243,22 +238,6 @@ static bool init_guest_commpage(void)
 
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
 
@@ -3637,8 +3616,12 @@ static int elf_core_dump(int signr, const CPUArchState *env)
 
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
index d96d5553fa..d60462172e 100644
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
@@ -362,27 +361,9 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
     env->eflags |= IF_MASK;
 
     /* linux register setup */
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
+    memset(env->regs, 0, sizeof(env->regs));
+    env->regs[R_ESP] = info->start_stack;
+    env->eip = info->entry;
 
     /* linux interrupt setup */
 #ifndef TARGET_ABI32
@@ -394,7 +375,7 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
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


