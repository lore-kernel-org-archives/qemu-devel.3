Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67DECD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT57U-000636-Ai; Fri, 29 May 2026 17:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57S-00062f-NM; Fri, 29 May 2026 17:51:54 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57Q-0007W8-N9; Fri, 29 May 2026 17:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780091501; x=1780696301; i=deller@gmx.de;
 bh=yWj4xfI21hAF7hx/PxKNj42DxCD1V6gQuobYl06oyYI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Sb6mE6frxZ6sk/6oglvQxg3GOl3Xz2ek4jv+Jf4bOKx/fH0fsdiIBPWDXOLclgUK
 31G2GssFg6n4z3gohmCLgxwDA/9AOUZaJtggW9GQ20Xm7oLqZCCkr6SICRNLFc06a
 xJMeE+cKzEGw7eo0Iunt1bZqeRNKQy2LLKQ+67+H1sYCobnoQQq4EzrivdCQLrPid
 2kgtCKaMi84fD+nOYhK4r7xKdDeioNTv5rv3vYn/blKycLj4TQN+z9UdeXZjxVHw7
 CF+TI/V6wEjt+oVMnp+b/NCxZ2E6T++/KyzRinKGItMqafuB2+iiQxWKGWlAf3L+G
 mRcnN8GmNX4lc1xGWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f5T-1wRhXG154B-006F8W; Fri, 29
 May 2026 23:51:41 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@kernel.org>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Matt Turner <mattst88@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PULL v3 04/10] linux-user/sh4: restore FP rounding mode on sigreturn
Date: Fri, 29 May 2026 23:51:13 +0200
Message-ID: <20260529215119.73244-5-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529215119.73244-1-deller@gmx.de>
References: <20260529215119.73244-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YQKipO2YpHRl6yR+/4yDrRLO61PxjXF6P2b9Mf+CWdUq1+gfMXu
 Czu4E4sKoy4ep34K59gGOZvcsE4JGyhzFbXTVi/BpUMh49NiIIG6jnAMCKLXx2Uu+JsA0Fz
 HVyD0aVMIuLSUh62XpmVFjfJjUQcRHQIP1uQ4GxTpaIPAiowgVeMrZQTH8MriGpxMw5r8wN
 yEBvoouvl7JnAG449UP/A==
UI-OutboundReport: notjunk:1;M01:P0:DS6ObCQznjg=;1R76kZ9jCw9ZUbnCU+4rUsy9MN0
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
signal handler last installed. (regs->flags =3D 0 forces the FR/SZ/PR TB
flags to be recomputed, but fp_status is runtime float state, not a TB
flag, so it was left stale.) This is the FP analogue of the T/M/Q bit
problem just fixed for the integer status register.

Factor the FPSCR -> fp_status synchronisation out of helper_ld_fpscr()
into cpu_load_fpscr() and use it from restore_sigcontext() so the
rounding mode round-trips correctly across signal delivery.

Fixes: c3b5bc8ab3 ("SH4: Signal handling for the user space emulator, by M=
agnus Damm.")
Cc: qemu-stable@nongnu.org
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/sh4/signal.c | 7 ++++++-
 target/sh4/cpu.h        | 3 +++
 target/sh4/op_helper.c  | 7 ++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index cc36425c49..00290d6e40 100644
=2D-- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -173,7 +173,12 @@ static void restore_sigcontext(CPUSH4State *regs, str=
uct target_sigcontext *sc)
     for (i=3D0; i<16; i++) {
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
=20
     regs->tra =3D -1;         /* disable syscall checks */
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 4b0f3f6d97..3302702376 100644
=2D-- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -379,4 +379,7 @@ static inline void cpu_write_sr(CPUSH4State *env, uint=
32_t sr)
     env->sr =3D sr & ~((1u << SR_M) | (1u << SR_Q) | (1u << SR_T));
 }
=20
+/* Set FPSCR and the derived float_status rounding/flush-to-zero state. *=
/
+void cpu_load_fpscr(CPUSH4State *env, uint32_t val);
+
 #endif /* SH4_CPU_H */
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 669bc84cb6..cf0f80e4a5 100644
=2D-- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -204,7 +204,7 @@ void helper_macw(CPUSH4State *env, int32_t arg0, int32=
_t arg1)
     }
 }
=20
-void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
+void cpu_load_fpscr(CPUSH4State *env, uint32_t val)
 {
     env->fpscr =3D val & FPSCR_MASK;
     if ((val & FPSCR_RM_MASK) =3D=3D FPSCR_RM_ZERO) {
@@ -215,6 +215,11 @@ void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
     set_flush_to_zero((val & FPSCR_DN) !=3D 0, &env->fp_status);
 }
=20
+void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
+{
+    cpu_load_fpscr(env, val);
+}
+
 static void update_fpscr(CPUSH4State *env, uintptr_t retaddr)
 {
     int xcpt, cause, enable;
=2D-=20
2.54.0


