Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBDCCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCsi-0005zx-NK; Thu, 18 Jun 2026 09:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1waCsg-0005zI-E5
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:34:06 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1waCse-0000UQ-L0
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:34:06 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-662d484ff3bso1140968d50.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 06:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781789643; x=1782394443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HflSwLhhHhLqdJU/yngYyzyHzq4rZCGqbgjTj+XX7OI=;
 b=KLXSKRAbEOIcJ3GwlXeaeAOwQvuN/iKl2FzjfVLYdWnjd0T2xqJbdOA1k3avS4XJyS
 uZF8wlCRnbF44kcltMVzmwpe290pI5C3U32WtaMmHW26EDwHO5XeERO9rJme54o42aqG
 PhoAAFvC6x/1BdTSpngGEPnDh4Q7+tXfyqbqCIklP7vHjGpH0NFq41WbuXdFB2fKs3Gb
 NDTLrQSy7I8gCjFZPMhnVN50xcL7jS8+QZeibvXWNtCYq0Xq3rUJ+O0AsZPP820Qf2TY
 /ZJuGWLQD1JaxDAkJbprIerM6kt49DFRAELU020MO+1a17rIYKpWt175KbIW1mAydlQe
 C+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781789643; x=1782394443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HflSwLhhHhLqdJU/yngYyzyHzq4rZCGqbgjTj+XX7OI=;
 b=h7JXPTOS0FNffKqu81MPzHyj2cEyzLg9fzhP7QPpT8raL9TiEu7xQpD/qfSvM0oBes
 yVojv3nvSvtGG7jPnoKEWW5CadocZxk1f7GYBEBYiCzZIRkZy92ZJFoxHiD6dJBOw/+3
 yIq8GG84+jUIbacx/A8LkkBPOtUTe6qY4GiKZmPJ3cV7kUUpxut6/8EaAgFRf5N4MsEU
 YARd7uf+v0rEufSiC2kD7asM/y03UyOlKaZ/vErU3pnYJNklQ14t3TOs4jUv8OBfs8JJ
 rQem1ATXzVk3HSZeakS54xowGHiUtHLdlHPONa7VOn7V/W+yShCZj0unMkzj6WwRlXFd
 Nlaw==
X-Gm-Message-State: AOJu0Yx3R2dSTLVJVNS1pidtMPT9+ECwk76Ldgx7xOPM5e+yd7YlDAc+
 70mbyS7y6KiEDHv06gWwzoapnwSjOg0z4ZA89OzKRBFjf0/GKzeAmhQjY8G8sQ==
X-Gm-Gg: AfdE7cmF2WkwzeklFWItIF7lE+CWwPJn2K9Z73ZGD83Zh8vp75EDmCcDw1kvFFRhxZ4
 5U3lihgdL7/hbUbAvmgpczUwOX3dkuTTHnu33JPzwyFH7rcUS+p75hWIPs8JPY/+nP4Nqs21lob
 MBAcM8cQeFuTgHQszrrKkFX5mYXawXnnvJpUMIpo917T+WBsSA0A4sob63DGYzLp2S565SCXZGG
 rSjesyILg6wrXE9487h9qoeg1KJh5256FU09YukEtxWJQBReDSu3IGuaO/LonmfqbmqAztz2zpp
 ZN9XEz8iWbdG1LrXCN/GRcdDIoq67IyRC/JQQCKnqY+6tyqpQVn2S4Vu/L353TwTvxPOqCNsix5
 bcjucPiHuXQsjdgFG8ncnfkYKONDo1jXq92KtxBKNJqznMaXSFGw6EdgXKvW/5ITw6rWmHsnhzV
 RQXQ9eEkBJz4wB
X-Received: by 2002:a05:690e:11c9:b0:660:580f:67f with SMTP id
 956f58d0204a3-662cbdd5298mr7488007d50.64.1781789643251; 
 Thu, 18 Jun 2026 06:34:03 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66274c417b4sm12418905d50.3.2026.06.18.06.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 06:34:02 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 2/2] linux-user/xtensa: save/restore FP registers across
 signal delivery
Date: Thu, 18 Jun 2026 09:33:54 -0400
Message-ID: <20260618133354.3369437-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618133354.3369437-1-mattst88@gmail.com>
References: <20260618133354.3369437-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb12a.google.com
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

Add support for saving and restoring f0-f15 across signal delivery.
The target_xtensa_xtregs_fp struct carries 32-bit f-regs for cores
with XTENSA_OPTION_FP_COPROCESSOR; target_xtensa_xtregs_dfp carries
64-bit f-regs for cores with XTENSA_OPTION_DFP_COPROCESSOR.

Lock the xtregs region via lock_user before reading on sigreturn,
since sc_xtregs is a user-space pointer that may lie outside the
locked sigframe.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/xtensa/signal.c | 96 ++++++++++++++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 8 deletions(-)

diff --git ./linux-user/xtensa/signal.c ./linux-user/xtensa/signal.c
index ef8b0c3a27..e3f9da322b 100644
--- ./linux-user/xtensa/signal.c
+++ ./linux-user/xtensa/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "target/xtensa/cpu.h"
 
 struct target_sigcontext {
     abi_ulong sc_pc;
@@ -43,10 +44,25 @@ struct target_ucontext {
     target_sigset_t tuc_sigmask;
 };
 
+struct target_xtensa_xtregs_fp {
+    uint32_t f[16];
+    uint32_t fcr;
+    uint32_t fsr;
+};
+
+struct target_xtensa_xtregs_dfp {
+    uint64_t f[16];
+    uint32_t fcr;
+    uint32_t fsr;
+};
+
 struct target_rt_sigframe {
     target_siginfo_t info;
     struct target_ucontext uc;
-    /* TODO: xtregs */
+    union {
+        struct target_xtensa_xtregs_fp fp;
+        struct target_xtensa_xtregs_dfp dfp;
+    } xtregs;
     uint8_t retcode[6];
     abi_ulong window[4];
 };
@@ -107,6 +123,7 @@ static int flush_window_regs(CPUXtensaState *env)
 }
 
 static int setup_sigcontext(struct target_rt_sigframe *frame,
+                            abi_ulong frame_addr,
                             CPUXtensaState *env)
 {
     struct target_sigcontext *sc = &frame->uc.tuc_mcontext;
@@ -123,8 +140,25 @@ static int setup_sigcontext(struct target_rt_sigframe *frame,
     for (i = 0; i < 16; ++i) {
         __put_user(env->regs[i], sc->sc_a + i);
     }
-    __put_user(0, &sc->sc_xtregs);
-    /* TODO: xtregs */
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_DFP_COPROCESSOR)) {
+        for (i = 0; i < 16; ++i) {
+            __put_user(env->fregs[i].f64, &frame->xtregs.dfp.f[i]);
+        }
+        __put_user(env->uregs[FCR], &frame->xtregs.dfp.fcr);
+        __put_user(cpu_get_fsr(env), &frame->xtregs.dfp.fsr);
+        __put_user(frame_addr + offsetof(struct target_rt_sigframe, xtregs),
+                   &sc->sc_xtregs);
+    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_FP_COPROCESSOR)) {
+        for (i = 0; i < 16; ++i) {
+            __put_user(env->fregs[i].f32[FP_F32_LOW], &frame->xtregs.fp.f[i]);
+        }
+        __put_user(env->uregs[FCR], &frame->xtregs.fp.fcr);
+        __put_user(cpu_get_fsr(env), &frame->xtregs.fp.fsr);
+        __put_user(frame_addr + offsetof(struct target_rt_sigframe, xtregs),
+                   &sc->sc_xtregs);
+    } else {
+        __put_user(0, &sc->sc_xtregs);
+    }
     return 1;
 }
 
@@ -190,7 +224,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
     target_save_altstack(&frame->uc.tuc_stack, env);
-    if (!setup_sigcontext(frame, env)) {
+    if (!setup_sigcontext(frame, frame_addr, env)) {
         unlock_user_struct(frame, frame_addr, 0);
         goto give_sigsegv;
     }
@@ -243,8 +277,8 @@ give_sigsegv:
     force_sigsegv(sig);
 }
 
-static void restore_sigcontext(CPUXtensaState *env,
-                               struct target_rt_sigframe *frame)
+static int restore_sigcontext(CPUXtensaState *env,
+                              struct target_rt_sigframe *frame)
 {
     struct target_sigcontext *sc = &frame->uc.tuc_mcontext;
     uint32_t ps;
@@ -266,7 +300,51 @@ static void restore_sigcontext(CPUXtensaState *env,
     for (i = 0; i < 16; ++i) {
         __get_user(env->regs[i], sc->sc_a + i);
     }
-    /* TODO: xtregs */
+    {
+        abi_ulong xtregs_addr;
+
+        __get_user(xtregs_addr, &sc->sc_xtregs);
+        if (xtregs_addr) {
+            if (xtensa_option_enabled(env->config,
+                                      XTENSA_OPTION_DFP_COPROCESSOR)) {
+                struct target_xtensa_xtregs_dfp *xtregs;
+                uint32_t fcr, fsr;
+
+                xtregs = lock_user(VERIFY_READ, xtregs_addr,
+                                   sizeof(*xtregs), 1);
+                if (!xtregs) {
+                    return 0;
+                }
+                for (i = 0; i < 16; ++i) {
+                    __get_user(env->fregs[i].f64, &xtregs->f[i]);
+                }
+                __get_user(fcr, &xtregs->fcr);
+                __get_user(fsr, &xtregs->fsr);
+                unlock_user(xtregs, xtregs_addr, 0);
+                cpu_set_fcr(env, fcr);
+                cpu_set_fsr(env, fsr);
+            } else if (xtensa_option_enabled(env->config,
+                                             XTENSA_OPTION_FP_COPROCESSOR)) {
+                struct target_xtensa_xtregs_fp *xtregs;
+                uint32_t fcr, fsr;
+
+                xtregs = lock_user(VERIFY_READ, xtregs_addr,
+                                   sizeof(*xtregs), 1);
+                if (!xtregs) {
+                    return 0;
+                }
+                for (i = 0; i < 16; ++i) {
+                    __get_user(env->fregs[i].f32[FP_F32_LOW], &xtregs->f[i]);
+                }
+                __get_user(fcr, &xtregs->fcr);
+                __get_user(fsr, &xtregs->fsr);
+                unlock_user(xtregs, xtregs_addr, 0);
+                cpu_set_fcr(env, fcr);
+                cpu_set_fsr(env, fsr);
+            }
+        }
+    }
+    return 1;
 }
 
 long do_rt_sigreturn(CPUXtensaState *env)
@@ -282,7 +360,9 @@ long do_rt_sigreturn(CPUXtensaState *env)
     target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
     set_sigmask(&set);
 
-    restore_sigcontext(env, frame);
+    if (!restore_sigcontext(env, frame)) {
+        goto badframe;
+    }
     target_restore_altstack(&frame->uc.tuc_stack, env);
 
     unlock_user_struct(frame, frame_addr, 0);
-- 
2.53.0


