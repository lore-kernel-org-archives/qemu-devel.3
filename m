Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8102C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0Gb-0003FI-KS; Tue, 12 Mar 2024 07:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GY-00035U-Q4
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GH-0000h2-J9
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:52 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4132a89a351so11664565e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710242734; x=1710847534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+xs9VKQ31Vzn5Jc/bXAKp8ECjk5CZR3EsmvuC0rZMY=;
 b=JWOLMqFpxVVtyU+dbsT7ir+4aZ+w7eoBX/G0Q/FDGottridcf8b8MTfOeg+2kq1Bgg
 gKegqsjvYeXuXz8b4EOLAJClsFW5d8mghAcjryEMNa27J1b4QqcZuyBLZA5rIFDVTOnw
 BcZxs0yql0wpwKkUz7E0WhEGa3sIwhNSyldn8sIcq1Vj5/uuUE4ToQ2fu9g+gpXUHUyD
 ULBnVicuNTm0+9bJadMjnFikhNiWOP9jrej+8lhSS27WSbFipOWG9+qCMLj038IN1NaA
 zaKzPUc1BIJ0ER00yh6xbt7SFtVvtMTsvUobHGLtRGnvCmEDhgMTl5BPxDBfSAJbfA8X
 JMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710242734; x=1710847534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+xs9VKQ31Vzn5Jc/bXAKp8ECjk5CZR3EsmvuC0rZMY=;
 b=h+jC2hBp3eJoBtsM2t63501M2MSGL4ghDtiEt1UjhosZXmk6lOmFG6bNK9ON0V80WR
 LWmBCEX0PlChoHhfVEQibdgnTsyV/Cn7pgRWBCuZu+2d1Nu7yIKB85cuSYpw0hgwj7c4
 ijKnEcxw2zvDFxbcH0RKZyiodyjNVSAN8fOyoMOb4fvUlL7VqEFgPxt7mBBSI48jxDRf
 +TGx+kh7ZU6fCndc0vuTVXFW2N+fHhLLn9ny2yJ2IaZ8o77JoXrqIAcSpvlO/gRA9NJz
 JZqsDmJStVvikd5s1nwYnRMupx5PP6CWhfpPabWWXvsigj0FVmOTdP3Y7G1rz8qq39Kh
 WVDg==
X-Gm-Message-State: AOJu0Yz3cGJJXqBgnuAHKRkMbHj/HFVGzp1vZOr+Vh3mzPNYa2eq8xpi
 AiRY2R/gc/Fap0bEMIZIjpT3g5PAOA1wlPK4twyvBa4aDFgqMyXc1PYZ5TBx9EA=
X-Google-Smtp-Source: AGHT+IEa/Zwi5st7epjbZUA9KrZlxInVwT5rKYiP/SdbD7fYjFvKJSr9gci4vT1IcOv8hxd4ZFX2fg==
X-Received: by 2002:a5d:67d0:0:b0:33d:746b:f360 with SMTP id
 n16-20020a5d67d0000000b0033d746bf360mr1237583wrw.51.1710242734107; 
 Tue, 12 Mar 2024 04:25:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a17-20020adffad1000000b0033dc7e50488sm8770842wrs.96.2024.03.12.04.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 04:25:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0BADA5F8DF;
 Tue, 12 Mar 2024 11:25:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain <bcain@quicinc.com>
Subject: [PULL 4/8] linux-user: Move tswap_siginfo out of target code
Date: Tue, 12 Mar 2024 11:25:28 +0000
Message-Id: <20240312112532.1558319-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312112532.1558319-1-alex.bennee@linaro.org>
References: <20240312112532.1558319-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Move tswap_siginfo from target code to handle_pending_signal. This will
allow some cleanups and having the siginfo ready to be used in gdbstub.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240309030901.1726211-3-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index a7df12fc44..f4cbe6185e 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -43,8 +43,6 @@ void host_to_target_sigset_internal(target_sigset_t *d,
                                     const sigset_t *s);
 void target_to_host_sigset_internal(sigset_t *d,
                                     const target_sigset_t *s);
-void tswap_siginfo(target_siginfo_t *tinfo,
-                   const target_siginfo_t *info);
 void set_sigmask(const sigset_t *set);
 void force_sig(int sig);
 void force_sigsegv(int oldsig);
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index a1e22d526d..bc7a13800d 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -670,7 +670,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     aarch64_set_svcr(env, 0, R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
 
     if (info) {
-        tswap_siginfo(&frame->info, info);
+        frame->info = *info;
         env->xregs[1] = frame_addr + offsetof(struct target_rt_sigframe, info);
         env->xregs[2] = frame_addr + offsetof(struct target_rt_sigframe, uc);
     }
diff --git a/linux-user/alpha/signal.c b/linux-user/alpha/signal.c
index 4ec42994d4..896c2c148a 100644
--- a/linux-user/alpha/signal.c
+++ b/linux-user/alpha/signal.c
@@ -173,7 +173,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         goto give_sigsegv;
     }
 
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index 59806335f5..8db1c4b233 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -357,7 +357,7 @@ void setup_rt_frame(int usig, struct target_sigaction *ka,
 
     info_addr = frame_addr + offsetof(struct rt_sigframe, info);
     uc_addr = frame_addr + offsetof(struct rt_sigframe, sig.uc);
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     setup_sigframe(&frame->sig.uc, set, env);
 
diff --git a/linux-user/hexagon/signal.c b/linux-user/hexagon/signal.c
index 60fa7e1bce..492b51f155 100644
--- a/linux-user/hexagon/signal.c
+++ b/linux-user/hexagon/signal.c
@@ -162,7 +162,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     }
 
     setup_ucontext(&frame->uc, env, set);
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
     /*
      * The on-stack signal trampoline is no longer executed;
      * however, the libgcc signal frame unwinding code checks
diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index c84557e906..682ba25922 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -127,7 +127,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         goto give_sigsegv;
     }
 
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
     frame->uc.tuc_flags = 0;
     frame->uc.tuc_link = 0;
 
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index bc5d45302e..cfe70fc5cf 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -430,7 +430,7 @@ void setup_frame(int sig, struct target_sigaction *ka,
     setup_sigcontext(&frame->sc, &frame->fpstate, env, set->sig[0],
             frame_addr + offsetof(struct sigframe, fpstate));
 
-    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
+    for (i = 1; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &frame->extramask[i - 1]);
     }
 
@@ -490,7 +490,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     __put_user(addr, &frame->puc);
 #endif
     if (ka->sa_flags & TARGET_SA_SIGINFO) {
-        tswap_siginfo(&frame->info, info);
+        frame->info = *info;
     }
 
     /* Create the ucontext.  */
@@ -504,7 +504,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     setup_sigcontext(&frame->uc.tuc_mcontext, &frame->fpstate, env,
             set->sig[0], frame_addr + offsetof(struct rt_sigframe, fpstate));
 
-    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
     }
 
diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index 39ea82c814..1a322f9697 100644
--- a/linux-user/loongarch64/signal.c
+++ b/linux-user/loongarch64/signal.c
@@ -376,7 +376,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         extctx.end.haddr = (void *)frame + (extctx.end.gaddr - frame_addr);
     }
 
-    tswap_siginfo(&frame->rs_info, info);
+    frame->rs_info = *info;
 
     __put_user(0, &frame->rs_uc.tuc_flags);
     __put_user(0, &frame->rs_uc.tuc_link);
diff --git a/linux-user/m68k/signal.c b/linux-user/m68k/signal.c
index 5f35354487..77555781aa 100644
--- a/linux-user/m68k/signal.c
+++ b/linux-user/m68k/signal.c
@@ -295,7 +295,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     uc_addr = frame_addr + offsetof(struct target_rt_sigframe, uc);
     __put_user(uc_addr, &frame->puc);
 
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     /* Create the ucontext */
 
@@ -307,7 +307,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     if (err)
         goto give_sigsegv;
 
-    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
     }
 
diff --git a/linux-user/microblaze/signal.c b/linux-user/microblaze/signal.c
index 5188d74025..f6d47d76ff 100644
--- a/linux-user/microblaze/signal.c
+++ b/linux-user/microblaze/signal.c
@@ -147,7 +147,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         return;
     }
 
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
index 58a9d7a8a3..d69a5d73dd 100644
--- a/linux-user/mips/signal.c
+++ b/linux-user/mips/signal.c
@@ -303,7 +303,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         goto give_sigsegv;
     }
 
-    tswap_siginfo(&frame->rs_info, info);
+    frame->rs_info = *info;
 
     __put_user(0, &frame->rs_uc.tuc_flags);
     __put_user(0, &frame->rs_uc.tuc_link);
@@ -311,7 +311,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 
     setup_sigcontext(env, &frame->rs_uc.tuc_mcontext);
 
-    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &frame->rs_uc.tuc_sigmask.sig[i]);
     }
 
diff --git a/linux-user/nios2/signal.c b/linux-user/nios2/signal.c
index 32b3dc99c6..64c345f409 100644
--- a/linux-user/nios2/signal.c
+++ b/linux-user/nios2/signal.c
@@ -157,7 +157,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         return;
     }
 
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     /* Create the ucontext.  */
     __put_user(0, &frame->uc.tuc_flags);
diff --git a/linux-user/openrisc/signal.c b/linux-user/openrisc/signal.c
index be8b68784a..cb74a9fe5e 100644
--- a/linux-user/openrisc/signal.c
+++ b/linux-user/openrisc/signal.c
@@ -103,7 +103,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     }
 
     if (ka->sa_flags & SA_SIGINFO) {
-        tswap_siginfo(&frame->info, info);
+        frame->info = *info;
     }
 
     __put_user(0, &frame->uc.tuc_flags);
diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index c232424c1e..652038a53c 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -493,7 +493,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     if (!lock_user_struct(VERIFY_WRITE, rt_sf, rt_sf_addr, 1))
         goto sigsegv;
 
-    tswap_siginfo(&rt_sf->info, info);
+    rt_sf->info = *info;
 
     __put_user(0, &rt_sf->uc.tuc_flags);
     __put_user(0, &rt_sf->uc.tuc_link);
@@ -502,7 +502,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     __put_user(h2g (&rt_sf->uc.tuc_mcontext),
                &rt_sf->uc.tuc_regs);
 #endif
-    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &rt_sf->uc.tuc_sigmask.sig[i]);
     }
 
diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index 941eadce87..358fa1d82d 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -125,7 +125,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     }
 
     setup_ucontext(&frame->uc, env, set);
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     env->pc = ka->_sa_handler;
     env->gpr[xSP] = frame_addr;
diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
index b40f738a70..df49c24708 100644
--- a/linux-user/s390x/signal.c
+++ b/linux-user/s390x/signal.c
@@ -267,7 +267,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     }
 
     /* Create siginfo on the signal stack. */
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     /* Create ucontext on the signal stack. */
     uc_flags = 0;
diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index c16c2c2d57..9ecc026fae 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -233,7 +233,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         goto give_sigsegv;
     }
 
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     /* Create the ucontext.  */
     __put_user(0, &frame->uc.tuc_flags);
diff --git a/linux-user/signal.c b/linux-user/signal.c
index bca44c295d..c769675e68 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -409,8 +409,8 @@ static inline void host_to_target_siginfo_noswap(target_siginfo_t *tinfo,
     tinfo->si_code = deposit32(si_code, 16, 16, si_type);
 }
 
-void tswap_siginfo(target_siginfo_t *tinfo,
-                   const target_siginfo_t *info)
+static void tswap_siginfo(target_siginfo_t *tinfo,
+                          const target_siginfo_t *info)
 {
     int si_type = extract32(info->si_code, 16, 16);
     int si_code = sextract32(info->si_code, 0, 16);
@@ -1180,6 +1180,12 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
     /* dequeue signal */
     k->pending = 0;
 
+    /*
+     * Writes out siginfo values byteswapped, accordingly to the target. It also
+     * cleans the si_type from si_code making it correct for the target.
+     */
+    tswap_siginfo(&k->info, &k->info);
+
     sig = gdb_handlesig(cpu, sig, NULL);
     if (!sig) {
         sa = NULL;
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index c2dc1000e2..f164b74032 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -333,7 +333,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 
     __put_user(0, &sf->rwin_save);  /* TODO: save_rwin_state */
 
-    tswap_siginfo(&sf->info, info);
+    sf->info = *info;
     tswap_sigset(&sf->mask, set);
     target_save_altstack(&sf->stack, env);
 
diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index 003208a916..6514b8dd57 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -184,7 +184,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     }
 
     if (ka->sa_flags & SA_SIGINFO) {
-        tswap_siginfo(&frame->info, info);
+        frame->info = *info;
     }
 
     __put_user(0, &frame->uc.tuc_flags);
-- 
2.39.2


