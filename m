Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E0BCD8C88
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWE6y-0004MX-1y; Sun, 07 Jun 2026 10:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWE6w-0004MP-Ir
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:04:22 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWE6u-00087J-TF
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:04:22 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 45E5160018;
 Sun,  7 Jun 2026 14:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF3C1F00893;
 Sun,  7 Jun 2026 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780841060;
 bh=7LLRWlYl4f50tTS2x2GJ/eFkVK++jmXZ/i6kKIARBlk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=i+htPQebVybQqK5/xMve51dnxXppeqheHJ0LhRbOJIfvP2/g1DeQGSmJ3Spz4KLso
 J7ZR48V+9re+nA2seLz1df7Q/rg1u6oNHJjRyb60q3WnACDsp9tHgZmeqMOUOi1d8g
 ew8YNYmEYUvbo0hZ+xAALPctEKX+ELrNwgKWpCK3DosCsr0fPdToq4dnHIflLcs9TJ
 X19BnA9SeQ2XxBEMAg4HEn4ofdW2CTSjJkE+OeZ1O6xOtVq+bWuKJFZex6yFy7adVl
 oV6SCOvNAlrOyFpaS85YnkldRsFV/I/vqATTYtuZYTBivACmTFMqAm0LgoCe1udd2O
 mOvnuV+7MOL/g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Helge Deller <deller@gmx.de>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH 09/10] linux-user/xtensa: restore FP rounding mode on sigreturn
Date: Sun,  7 Jun 2026 16:03:55 +0200
Message-ID: <20260607140356.10702-10-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607140356.10702-1-deller@kernel.org>
References: <20260607140356.10702-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Xtensa FCR rounding-mode (RM) bits are not held only in
env->uregs[FCR]: they are also reflected into env->fp_status via
set_float_rounding_mode().  Similarly, FSR exception flags are mirrored
into env->fp_status.  Every write to FCR/FSR goes through
helper_wur_fpu{2k,}_fcr / helper_wur_fpu_fsr which keep the two in sync.

restore_sigcontext() previously wrote nothing back for xtregs, leaving
env->fp_status with whatever rounding mode and exception flags the
signal handler last installed.  Any FP instruction in the interrupted
code could then operate with the wrong mode.

Add a minimal target_xtensa_xtregs sub-frame carrying FCR and FSR.
setup_sigcontext() saves the current values and points sc_xtregs at the
sub-frame when XTENSA_OPTION_FP_COPROCESSOR or
XTENSA_OPTION_DFP_COPROCESSOR is present (both use env->fp_status driven
by FCR/FSR). restore_sigcontext() reads sc_xtregs; if non-zero it
restores FCR and FSR through cpu_set_fcr()/cpu_set_fsr() so fp_status
round-trips correctly across signal delivery.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/xtensa/signal.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index ef8b0c3a27..fef23952b7 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "target/xtensa/cpu.h"
 
 struct target_sigcontext {
     abi_ulong sc_pc;
@@ -43,10 +44,15 @@ struct target_ucontext {
     target_sigset_t tuc_sigmask;
 };
 
+struct target_xtensa_xtregs {
+    uint32_t fcr;
+    uint32_t fsr;
+};
+
 struct target_rt_sigframe {
     target_siginfo_t info;
     struct target_ucontext uc;
-    /* TODO: xtregs */
+    struct target_xtensa_xtregs xtregs;
     uint8_t retcode[6];
     abi_ulong window[4];
 };
@@ -107,6 +113,7 @@ static int flush_window_regs(CPUXtensaState *env)
 }
 
 static int setup_sigcontext(struct target_rt_sigframe *frame,
+                            abi_ulong frame_addr,
                             CPUXtensaState *env)
 {
     struct target_sigcontext *sc = &frame->uc.tuc_mcontext;
@@ -123,8 +130,15 @@ static int setup_sigcontext(struct target_rt_sigframe *frame,
     for (i = 0; i < 16; ++i) {
         __put_user(env->regs[i], sc->sc_a + i);
     }
-    __put_user(0, &sc->sc_xtregs);
-    /* TODO: xtregs */
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_FP_COPROCESSOR) ||
+        xtensa_option_enabled(env->config, XTENSA_OPTION_DFP_COPROCESSOR)) {
+        __put_user(env->uregs[FCR], &frame->xtregs.fcr);
+        __put_user(cpu_get_fsr(env), &frame->xtregs.fsr);
+        __put_user(frame_addr + offsetof(struct target_rt_sigframe, xtregs),
+                   &sc->sc_xtregs);
+    } else {
+        __put_user(0, &sc->sc_xtregs);
+    }
     return 1;
 }
 
@@ -190,7 +204,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
     target_save_altstack(&frame->uc.tuc_stack, env);
-    if (!setup_sigcontext(frame, env)) {
+    if (!setup_sigcontext(frame, frame_addr, env)) {
         unlock_user_struct(frame, frame_addr, 0);
         goto give_sigsegv;
     }
@@ -266,7 +280,19 @@ static void restore_sigcontext(CPUXtensaState *env,
     for (i = 0; i < 16; ++i) {
         __get_user(env->regs[i], sc->sc_a + i);
     }
-    /* TODO: xtregs */
+    {
+        abi_ulong xtregs_addr;
+
+        __get_user(xtregs_addr, &sc->sc_xtregs);
+        if (xtregs_addr) {
+            uint32_t fcr, fsr;
+
+            __get_user(fcr, &frame->xtregs.fcr);
+            __get_user(fsr, &frame->xtregs.fsr);
+            cpu_set_fcr(env, fcr);
+            cpu_set_fsr(env, fsr);
+        }
+    }
 }
 
 long do_rt_sigreturn(CPUXtensaState *env)
-- 
2.54.0


