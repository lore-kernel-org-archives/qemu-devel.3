Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8323DCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFoz-0000eV-IO; Wed, 24 Jun 2026 01:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFon-0007zm-AA; Wed, 24 Jun 2026 01:06:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFok-0005ed-Tz; Wed, 24 Jun 2026 01:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277476; bh=BJg6yYSOIkZ9haWeoQiGVGiLT3hNMNgNX/+hlHo72/8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TmC7uPBL0Ca03i1Reat0SeFZtKO3kslKFTpDnlFy6tJJ8yA508O3J00zYrNYGPuuQ
 f/Xzv1R53k6f0usXAYYfyGzqV9NRUc+wMeOU+vLDtxA/2rDXhLE3Eho+JqbqSRXhiZ
 VsQ0SkWstw8YonXKBvj45JYO2UVdQq9YjU4smOh2P5uJQO4dV6rOeBiJlGgZoUOaRM
 ujn2hUiwZyIgB/W1zVau6yuGGGnmGriItzVHEVbE36KKgUw3f+BmrG7YBVju+moJVL
 LgJzESGQY2b0OOV9Z/ehlcRjTyabsCxnsJyn8CvwXU7rKOBpMLoMkRJc0vLF5HDLy1
 9rcg7WaEt1M3w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CE1EF1BA648;
 Wed, 24 Jun 2026 08:04:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B51CD3DDAD0;
 Wed, 24 Jun 2026 08:04:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 82/86] linux-user/xtensa: save/restore FP registers
 across signal delivery
Date: Wed, 24 Jun 2026 08:02:53 +0300
Message-ID: <20260624050404.394225-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Matt Turner <mattst88@gmail.com>

Add support for saving and restoring f0-f15 across signal delivery.
The target_xtensa_xtregs_fp struct carries 32-bit f-regs for cores
with XTENSA_OPTION_FP_COPROCESSOR; target_xtensa_xtregs_dfp carries
64-bit f-regs for cores with XTENSA_OPTION_DFP_COPROCESSOR.

Lock the xtregs region via lock_user before reading on sigreturn,
since sc_xtregs is a user-space pointer that may lie outside the
locked sigframe.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 6858e3a71cc41510937bec0950eb4e42e33ba5f2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index 6514b8dd57..fb1a3b86c1 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
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
@@ -244,8 +278,8 @@ give_sigsegv:
     return;
 }
 
-static void restore_sigcontext(CPUXtensaState *env,
-                               struct target_rt_sigframe *frame)
+static int restore_sigcontext(CPUXtensaState *env,
+                              struct target_rt_sigframe *frame)
 {
     struct target_sigcontext *sc = &frame->uc.tuc_mcontext;
     uint32_t ps;
@@ -267,7 +301,51 @@ static void restore_sigcontext(CPUXtensaState *env,
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
@@ -283,7 +361,9 @@ long do_rt_sigreturn(CPUXtensaState *env)
     target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
     set_sigmask(&set);
 
-    restore_sigcontext(env, frame);
+    if (!restore_sigcontext(env, frame)) {
+        goto badframe;
+    }
     target_restore_altstack(&frame->uc.tuc_stack, env);
 
     unlock_user_struct(frame, frame_addr, 0);
-- 
2.47.3


