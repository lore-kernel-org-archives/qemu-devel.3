Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0528BCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRxzL-0004ef-OD; Tue, 26 May 2026 16:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRxz1-0004Yg-HC; Tue, 26 May 2026 16:02:41 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRxz0-0002t8-0E; Tue, 26 May 2026 16:02:35 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E02B7600B0;
 Tue, 26 May 2026 20:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0981F000E9;
 Tue, 26 May 2026 20:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779825751;
 bh=0dQnwUFE5S5dYS/jm+p+iJZyIvrikm45NzygrKgjVW0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ERCiVfbvI/qGlTPvlt+9d+O6Aemwm3gC+XsHiGboOjY8BsaaQ+tOEytgClcyau+W4
 VBZeWPS2OTweU2MLBGZpRWapbPPv2Mx7DoE6dZuZdiOY1/ISSpWTHbgJWaOycu2Foj
 PLfFwGoje2rGWN3VFjIkOdHEk+gwbHgeOfjTnZJihLxfuuPgNR7gquQ3Ado4iKmS5i
 reLML05mlM8eoL7S9LsDegxBUu3J8/3oKi40W6cBEmElNlExgwLTXqcw7f4aOWjahd
 PspeVAe3yhGvYAfZiYmX1pa0v31BybuAKmuou8PlHSgItxIuPtvnNwu0IUpvsta+in
 3dbWJxpZjaWsg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Cornelia Huck <cohuck@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL 05/12] linux-user/sh4: restore FP rounding mode on sigreturn
Date: Tue, 26 May 2026 22:02:00 +0200
Message-ID: <20260526200207.79738-6-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526200207.79738-1-deller@kernel.org>
References: <20260526200207.79738-1-deller@kernel.org>
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

The SH4 FPSCR rounding-mode (RM) and denormal (DN) bits are not held
only in env->fpscr: they are also reflected into the derived
env->fp_status via set_float_rounding_mode()/set_flush_to_zero(). The
guest keeps the two in sync by routing every write to FPSCR through
helper_ld_fpscr().

restore_sigcontext() wrote the saved value straight into env->fpscr and
never touched env->fp_status, so on sigreturn the interrupted code
resumed with whatever FP rounding mode and flush-to-zero setting the
signal handler last installed. (regs->flags = 0 forces the FR/SZ/PR TB
flags to be recomputed, but fp_status is runtime float state, not a TB
flag, so it was left stale.) This is the FP analogue of the T/M/Q bit
problem just fixed for the integer status register.

Factor the FPSCR -> fp_status synchronisation out of helper_ld_fpscr()
into cpu_load_fpscr() and use it from restore_sigcontext() so the
rounding mode round-trips correctly across signal delivery.

Fixes: c3b5bc8ab3 ("SH4: Signal handling for the user space emulator, by Magnus Damm.")
Cc: qemu-stable@nongnu.org
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/sh4/signal.c | 7 ++++++-
 target/sh4/cpu.h        | 3 +++
 target/sh4/op_helper.c  | 7 ++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index cc36425c49..00290d6e40 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -173,7 +173,12 @@ static void restore_sigcontext(CPUSH4State *regs, struct target_sigcontext *sc)
     for (i=0; i<16; i++) {
         __get_user(regs->fregs[i], &sc->sc_fpregs[i]);
     }
-    __get_user(regs->fpscr, &sc->sc_fpscr);
+    /* Resync the derived float_status state, not just env->fpscr. */
+    {
+        uint32_t fpscr;
+        __get_user(fpscr, &sc->sc_fpscr);
+        cpu_load_fpscr(regs, fpscr);
+    }
     __get_user(regs->fpul, &sc->sc_fpul);
 
     regs->tra = -1;         /* disable syscall checks */
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 4b0f3f6d97..3302702376 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -379,4 +379,7 @@ static inline void cpu_write_sr(CPUSH4State *env, uint32_t sr)
     env->sr = sr & ~((1u << SR_M) | (1u << SR_Q) | (1u << SR_T));
 }
 
+/* Set FPSCR and the derived float_status rounding/flush-to-zero state. */
+void cpu_load_fpscr(CPUSH4State *env, uint32_t val);
+
 #endif /* SH4_CPU_H */
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 669bc84cb6..cf0f80e4a5 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -204,7 +204,7 @@ void helper_macw(CPUSH4State *env, int32_t arg0, int32_t arg1)
     }
 }
 
-void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
+void cpu_load_fpscr(CPUSH4State *env, uint32_t val)
 {
     env->fpscr = val & FPSCR_MASK;
     if ((val & FPSCR_RM_MASK) == FPSCR_RM_ZERO) {
@@ -215,6 +215,11 @@ void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
     set_flush_to_zero((val & FPSCR_DN) != 0, &env->fp_status);
 }
 
+void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
+{
+    cpu_load_fpscr(env, val);
+}
+
 static void update_fpscr(CPUSH4State *env, uintptr_t retaddr)
 {
     int xcpt, cause, enable;
-- 
2.54.0


