Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED1DCD6E60
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUoPl-0003KS-Sy; Wed, 03 Jun 2026 12:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUoPk-0003Jo-8g
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:25:56 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUoPh-0004Jv-TP
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:25:55 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-660323f7b27so7861795d50.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780503953; x=1781108753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+sfxavDMc6RNVc/ukGYez/ngS8C6eILna6B+srDg10=;
 b=WGdtNCwLq+XPAvTyLQM2greSMfXo9KsatleeqDiLTixUDeJYo3b5tY1e5lBt99/d5S
 I1dSuMkEfGIdc9taN5iYKkBGY+NogQGkuQlv757aovIrrw+eONlYC41q9NqjKPlWYXG7
 vPSvREuupcC4OU6quYBfqxI2YqAzIELOpO70PmvGIhSZd+qiNZ2BzA6VPythWFaDZ8VH
 L5DL92vda3euk2gZ/xXHopkBuZBAPqhnl785umnlUnuIU6rggN1Xmtp88zb6MwyKKvHo
 MWCqbirJdOjatLGBoSZek4OtSSVxzuX8Vh7Tg8cGZYtajf7YhqSEBNyiraBlMdfaljVc
 OCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503953; x=1781108753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T+sfxavDMc6RNVc/ukGYez/ngS8C6eILna6B+srDg10=;
 b=raRDF+dprTAj7tII2Kr3nH6lrlJkkuJQ8x9r1PKlodh4HXG/PmIW08foiYB0lrJ2oE
 If7kvihT/+wsdr49Hy0paKLHB8Qz+g+wyrVcY+vPCWkF5xYwp8CLRYsLfSYyIiZlkoyu
 +gua8L6Doa56QtNYY1YhQ/ZNbhGBn0xobkq73rksgZZpbeTHp46I5rXoY1FLaalldfNw
 lYTzIP5Cc9a7v4LCn0NJhsx1yq3Op8mrqTeD3UPFvIGeL3aH5bIHP/eSWuyoykmyqJP6
 /YKvmtb/6FLKBRgCvu99cEqApCQoe2qn0TVeae0kJ50xsOSiiLY4r6LSnpu5Rm4K8xGL
 Ahrw==
X-Gm-Message-State: AOJu0YzcUUQJLkQ/7j1Yx7E5LTcmd0fBfXW+LYNvxV5IDdkVdzgU8zYL
 MZf/z/5Y3ZMpchqXDD80iWGIohqaBcNuI0O25f7Ugp4rIH2pmECrf0OLRWgInps05Ek=
X-Gm-Gg: Acq92OFWm2q5DL+6i7kEjim8giPf6E72xyoEdqBvdwyWYfkDKLkZwed/pIiL3YMr3C+
 VqFTv2ppEXpdrPBic8QYWqvKpByn+WoooDBSHh3bSnVEwk3oSAkWX0gwm1LOPd0uio5mlH/Q9nv
 954rwOqxnAuyWAGQKU5cnq7D/Wu8Gt9XRQEBdXQtBDmddFLkQHBuh44MRFSV6kfccyXGRe2HolD
 JnnPoU2+DrIrzJYtKrzKNxKMuiKOBe2Es57bTvZKWGYrJDUV/Z+5bGjMAUGp0BjYcCVT6pzdKTt
 UG+AAhNtu0fOtsoVTHIDmw1/rubcHVEbm1CbJVgFi3cWB5g1LmoAygQNkhBYxgdbxgcfmVviR9O
 E/zIT7FyH2uQBjztoPeA61nN1hE+o8qaW5g9M3m0C+kMkTQNWANmS2XEsGPEUxeDqOtvEV25fd3
 3vSrU3SocKY30YsslnLpz5NBmPTJeVpx3qYQ==
X-Received: by 2002:a53:c043:0:10b0:660:5c38:8f3b with SMTP id
 956f58d0204a3-660dc51be3amr3058669d50.53.1780503952553; 
 Wed, 03 Jun 2026 09:25:52 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d64409e9sm2154721d50.15.2026.06.03.09.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 09:25:51 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 2/2] linux-user/xtensa: restore FP rounding mode on sigreturn
Date: Wed,  3 Jun 2026 12:25:44 -0400
Message-ID: <20260603162545.1835769-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603162545.1835769-1-mattst88@gmail.com>
References: <20260603162545.1835769-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb129.google.com
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
---
 linux-user/xtensa/signal.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git ./linux-user/xtensa/signal.c ./linux-user/xtensa/signal.c
index ef8b0c3a27..fef23952b7 100644
--- ./linux-user/xtensa/signal.c
+++ ./linux-user/xtensa/signal.c
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
2.53.0


