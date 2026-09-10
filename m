Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF40CC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kRa-0002Wi-59; Thu, 10 Sep 2026 15:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kQH-0002Gh-UN
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:27:09 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kPW-0004d7-G8
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789068348; x=1789673148; i=deller@gmx.de;
 bh=oskPBWWiY60hLX22naFd0lGb37DJ3UAou3Lt6En4Zn4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=fBBMdef+RY0dYwlKFhWZR1Kf/EqcvpYM3OI/NhDPX/zfZ99cDnIxnYv6BLTGdmYS
 I/1e0JXESsY09fYu7nL/vrMy+4k5ZPHE0hyMGd05TNGQNqUf1Xc9OMXOyDhjf4V+o
 OJ+eNnddvEEUKn3XMrzzDKYiQdLE1FG+OGvmsTcomYfJNtCypnx4bVE+WL6RLMa0E
 fMu8H/hgUlRrDuCd+FJVv8/0f+Mt9rwScgtmTCUFCHIKlUxSdbQL76Zbt0gRAB2uy
 xD1H88/N5xZjXL8f65JHOqirUYM8gZKAoWhJEf+4hdQliK+Xhq6ZoBnhQLC6Qu7M9
 Eax48mu81QZmQ3Cndw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26rD-1x6gLK418r-000N9B; Thu, 10
 Sep 2026 21:25:48 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 1/7] linux-user/i386: report the real trap number in
 sigcontext.trapno
Date: Thu, 10 Sep 2026 21:25:38 +0200
Message-ID: <20260910192545.768850-2-deller@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910192545.768850-1-deller@gmx.de>
References: <20260910192545.768850-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7GDjWX7fMpI6XPiezdpQ70zzwlSB3Bkv7RKbTJS6kiYdjUS1xzv
 pKzi4qnLSs9nd3TH0blabUvLzjCjfwPG0hAy525JpLesoWKuvqCUcrtdvmW1Kjiz8uqlbR1
 vKImjIzRh5XHyO787yqH6M5fDUwlPUnFTOWPmp7h40rUHu9qSMgzlix2uuy+O0yGdAqw1Gz
 CIYnrJ2bjX69FVuppxHAQ==
UI-OutboundReport: notjunk:1;M01:P0:3YBLMx4UAws=;1a2qMepbNMmFeRcgX+dqznChfs4
 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
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

From: Nat Brown <natbro@gmail.com>

setup_sigcontext() fills sigcontext.trapno from CPUState::exception_index,=
 but
by the time a signal frame is built that field has already been reset to -=
1:
cpu_exec() copies the exception number into its return value and clears
exception_index before returning to cpu_loop(), which is where the signal =
is
queued.  Guests therefore see trapno =3D=3D -1 for every cpu exception.

  #include <signal.h>
  #include <stdio.h>
  #include <ucontext.h>

  static void h(int sig, siginfo_t *si, void *uc_)
  {
      ucontext_t *uc =3D uc_;
      printf("sig=3D%d trapno=3D%d err=3D%#x\n", sig,
             (int)uc->uc_mcontext.gregs[REG_TRAPNO],
             (unsigned)uc->uc_mcontext.gregs[REG_ERR]);
      fflush(stdout);
      _exit(0);
  }

  int main(void)
  {
      struct sigaction sa =3D { .sa_sigaction =3D h, .sa_flags =3D SA_SIGI=
NFO };
      sigaction(SIGSEGV, &sa, 0);
      *(volatile int *)0 =3D 1;
  }

Natively this prints trapno=3D14 err=3D0x6; under qemu it prints trapno=3D=
-1 err=3D0x6.
A SIGILL likewise reports -1 instead of 6, and SIGFPE -1 instead of 0.  Bo=
th
qemu-i386 and qemu-x86_64 are affected, and both report the expected 14/6/=
0
with this patch applied.  Only trapno is wrong; error_code lives in
CPUX86State and survives.

x86_cpu_record_sigsegv() already notes the coupling, observing that we can=
not
let the caller clobber exception_index "short of inventing a new place to =
store
the trapno".  Invent it: record the exception in env->trap_nr, mirroring l=
inux's
thread.trap_nr, which is exactly what the kernel reports in sigcontext.tra=
pno
and which likewise persists beyond the exception that set it.  Only hardwa=
re
vectors are recorded; the EXCP_* values at 0x100 and above are emulation
internals and never appear in a signal frame.

This matters to wine, whose segv_handler() dispatches on the trap number a=
nd
cannot service a fault it sees as -1, so 32-bit module loading fails under
qemu-i386.  The equivalent 64-bit handler dispatches the same way, so the =
same
failure is expected under qemu-x86_64.  Discussed at
https://gitlab.winehq.org/wine/wine/-/merge_requests/11737 , where the
suggestion was that qemu is the right place to fix this.

Signed-off-by: Nat Brown <natbro@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/i386/cpu_loop.c         |  9 +++++++++
 linux-user/i386/signal.c           |  6 ++----
 target/i386/cpu.h                  | 10 ++++++++++
 target/i386/tcg/user/excp_helper.c |  8 ++++----
 4 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 2f733b0b47..049bae7bc6 100644
=2D-- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -218,6 +218,15 @@ void cpu_loop(CPUX86State *env)
         cpu_exec_end(cs);
         qemu_process_cpu_events(cs);
=20
+        /*
+         * Remember the exception for sigcontext.trapno, as linux does in
+         * thread.trap_nr.  Only hardware exception vectors qualify; the
+         * EXCP_* values at 0x100 and above are emulation internals.
+         */
+        if (trapnr >=3D EXCP00_DIVZ && trapnr <=3D EXCP12_MCHK) {
+            env->trap_nr =3D trapnr;
+        }
+
         switch(trapnr) {
         case 0x80:
 #ifndef TARGET_X86_64
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index b646fde431..9650fac940 100644
=2D-- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -367,8 +367,6 @@ static void setup_sigcontext(CPUX86State *env,
                              abi_ptr fxstate_addr,
                              abi_ptr fpend_addr)
 {
-    CPUState *cs =3D env_cpu(env);
-
 #ifndef TARGET_X86_64
     uint16_t magic;
=20
@@ -385,7 +383,7 @@ static void setup_sigcontext(CPUX86State *env,
     __put_user(env->regs[R_EDX], &sc->edx);
     __put_user(env->regs[R_ECX], &sc->ecx);
     __put_user(env->regs[R_EAX], &sc->eax);
-    __put_user(cs->exception_index, &sc->trapno);
+    __put_user(env->trap_nr, &sc->trapno);
     __put_user(env->error_code, &sc->err);
     __put_user(env->eip, &sc->eip);
     __put_user(env->segs[R_CS].selector, (uint32_t *)&sc->cs);
@@ -416,7 +414,7 @@ static void setup_sigcontext(CPUX86State *env,
     __put_user(env->regs[14], &sc->r14);
     __put_user(env->regs[15], &sc->r15);
=20
-    __put_user(cs->exception_index, &sc->trapno);
+    __put_user(env->trap_nr, &sc->trapno);
     __put_user(env->error_code, &sc->err);
     __put_user(env->eip, &sc->rip);
=20
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9ce8ca0038..e61ccc9e68 100644
=2D-- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2188,6 +2188,16 @@ typedef struct CPUArchState {
=20
     /* exception/interrupt handling */
     int error_code;
+#ifdef CONFIG_USER_ONLY
+    /*
+     * The number of the last cpu exception taken by this thread, mirrori=
ng
+     * linux's thread.trap_nr, which is what the kernel reports in
+     * sigcontext.trapno.  CPUState::exception_index cannot be used for t=
his:
+     * cpu_exec() resets it before returning, long before the signal fram=
e is
+     * built during delivery.
+     */
+    int trap_nr;
+#endif
     int exception_is_int;
     target_ulong exception_next_eip;
     target_ulong dr[8]; /* debug registers; note dr4 and dr5 are unused *=
/
diff --git a/target/i386/tcg/user/excp_helper.c b/target/i386/tcg/user/exc=
p_helper.c
index 0957ad2e9e..26a4c0ef92 100644
=2D-- a/target/i386/tcg/user/excp_helper.c
+++ b/target/i386/tcg/user/excp_helper.c
@@ -31,10 +31,10 @@ void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
=20
     /*
      * The error_code that hw reports as part of the exception frame
-     * is copied to linux sigcontext.err.  The exception_index is
-     * copied to linux sigcontext.trapno.  Short of inventing a new
-     * place to store the trapno, we cannot let our caller raise the
-     * signal and set exception_index to EXCP_INTERRUPT.
+     * is copied to linux sigcontext.err.  The trapno reported in
+     * linux sigcontext.trapno is recorded separately in env->trap_nr
+     * by cpu_loop(), since cpu_exec() clears exception_index before
+     * the signal frame is built.
      */
     env->cr[2] =3D addr;
     env->error_code =3D (maperr ? 0 : PG_ERROR_P_MASK)
=2D-=20
2.55.0


