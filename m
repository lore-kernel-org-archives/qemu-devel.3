Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B08CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUR4-0005cK-Pv; Sat, 13 Jun 2026 15:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUQr-0005Ha-Kj; Sat, 13 Jun 2026 15:54:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUQp-00044a-Jb; Sat, 13 Jun 2026 15:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380260; bh=nuxwsAgdnZIL6F2A++Fdzh2BbY3cK18S5aJ3r5v1GUA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cp+xpwOu3vadEMO/V15y6vHi4vctPs8yCiCydxVv9rB5kXP738BzGrGKlQzJ8nUP2
 sSk03DpPlP/5SZDCtu0+flNa/crzSuuHooKzAWX1DnDqBvOjdvyoHjPcBN7XHtxGxY
 FvKCtPsziZbE8D+p0L6tOJ0qBDW01uxN1CDzkMNwuUjZdKxZI9SnygSdY94hbSuyD9
 2Oxk9eHgXfRe5fLYe9hJNXqRSFYZnr4izYCg4+L5cResBGWjKf0EqcmnuOUAi8l3Ff
 0Is/5YiuejNTofubThk+KCMK+Jl07W2qRnhQlCGb3+86NRCocjU/FRYoqizlMLz7kA
 93DeHyLuwkX0Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 07E061B6E2F;
 Sat, 13 Jun 2026 22:51:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5D7C43CE8A9;
 Sat, 13 Jun 2026 22:51:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 32/56] linux-user/sh4: restore FP rounding mode on
 sigreturn
Date: Sat, 13 Jun 2026 22:50:46 +0300
Message-ID: <20260613195116.1807273-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
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
(cherry picked from commit a740f17ed0fbc5cd38e3cb12136c58d38aba098d)
(Mjt: context fixup in target/sh4/cpu.h)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
index d536d5d715..2ada25ee00 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -397,4 +397,7 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, vaddr *pc,
 #endif
 }
 
+/* Set FPSCR and the derived float_status rounding/flush-to-zero state. */
+void cpu_load_fpscr(CPUSH4State *env, uint32_t val);
+
 #endif /* SH4_CPU_H */
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 99394b714c..d70587f328 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -202,7 +202,7 @@ void helper_macw(CPUSH4State *env, int32_t arg0, int32_t arg1)
     }
 }
 
-void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
+void cpu_load_fpscr(CPUSH4State *env, uint32_t val)
 {
     env->fpscr = val & FPSCR_MASK;
     if ((val & FPSCR_RM_MASK) == FPSCR_RM_ZERO) {
@@ -213,6 +213,11 @@ void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
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
2.47.3


