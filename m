Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B974AC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 04:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyMDy-0002UN-5T; Mon, 24 Aug 2026 00:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <natbro@gmail.com>) id 1wyKC7-0006vl-Jt
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 22:13:51 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <natbro@gmail.com>) id 1wyKC5-0004hN-Qz
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 22:13:51 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-8eeadbc5e21so16020416d6.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 19:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787537628; x=1788142428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l3X5rNIf1UfQ0IIw6bW1Wyj23dwgSoSse1V8rHtHgGE=;
 b=mB+mG+Ja6qoIXzgKEo9eNY74gDB1j/KZy0rnHebneQwhbbmIsZEVvVo49qYNu+CWYH
 9GsTnT4eDKdBga9U6pqX/QDN4zv3zKGMl+4B6NQLVGF6kD5jYer1mcY9mYu9KAIXBmnN
 oNMXnz6Y5QrNzxQ4nQF1JzJkmSzM9/D36/LV25HmPyjXh84fNS8dejOIj3R6TCffRrlh
 BKLYDzJofHjs+wBPZ+iFkhyVTH1TEUtOsKVxwL9IGt/s77YAf6atK2ZgcpuzLNqp5xZB
 eqduydEp6n/3ObZlT8MyOx64oLMjn4oU7Zh8rPL2HSewnK1UkJMBu3KL97bl6gh/n8Ck
 MgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787537628; x=1788142428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l3X5rNIf1UfQ0IIw6bW1Wyj23dwgSoSse1V8rHtHgGE=;
 b=L9pHAfU/uQfnQINN2kRJqTamiluVm9e6BVPCc9WLMkokFQoko+p+6umIZZfLhID8Dg
 9+Zp0Ee7I19i0NRnqFJpv72oBnruEVFkZ5piAyN+K/7MG8V4pLaojhRJcKgz3cSypUxB
 V2bKwc5Hz/6W8rk5M6AwyVuFnqMTW0xFN0OprWxsZYawuGeSnuqru1AK7tamnPvOL5sr
 L1bi7eF+ub4m0UMM2Oq5syvIDQdzMhn0Tk7qtGb5cGpZeAC+Cxm0nmriXbBNExaqhNlA
 N8PG816lKvcI7g8Z/UBJy4OOBEvbz+vjolhubFcp/vXvETzwh0IXwWLksL89fbKmp5b3
 pyVg==
X-Gm-Message-State: AFuF++n1Sm+CUMk8DLpWGvr4ZLVJAMw982QscmjfW2ttZWIX0XQzl2fw
 bJu+u2hQ6kvrO9uPJR4V+JGGn9hMdo/M4esrUTvgkvvnqTS6OU3jDWgBhuwGyyWS
X-Gm-Gg: AR+sD10sBrF4Wz69pgyusBCHah9XQVGXVrlelHfwvByO7euxRvz+1mZU7j9nLZ37DlS
 ldpV2HRMdDp8uYBS8unPx8aSyA3lCDNeF9pIkhzrhh70JMncf/d+9Kvv+LXUGo0qlNtBarh6fSR
 /XXu1Haqb/hLGR1Lw+d7Cs074Af2F5GlJB/zqkUgKvBfAAwkNkal8cJN9c+ErtGv97ZjyZWR8Wg
 B4fuxRiJjvKiGvTLMLX1qDoMKzSdLASINZQ6JMx/rTX4Jlwh6SehUIaBqT6/fSImGKwyg2uFnIg
 XbX3SLsq2gaoW3Hg5KuMHzgQTFiOAjOX/kXQ5sesoWc5ryVAsqxw7xEQEQ1ifp2uCSebcEIPVeJ
 7rfgPqopMkXHKkLt13QLn/TFSr01gz6qBcUPy4WD0Bq43uYXIYm2Wyjys5JhBpLCbkx3YzbWooh
 hGTBa0T+r7JDRaJBjONQBnsP5+ofEGH7eTZ6jLzYvhTgC2u/tTlErbLerfVtLu8SLoJyfHL1G1i
 SmhdzIXyxBcmEwf8I3AcrM=
X-Received: by 2002:a0c:f004:0:b0:90c:94c0:e852 with SMTP id
 6a1803df08f44-90c94c0e916mr140670216d6.24.1787537628077; 
 Sun, 23 Aug 2026 19:13:48 -0700 (PDT)
Received: from localhost.localdomain
 ([2600:4040:5546:f500:e01b:e6e9:7dad:7e9c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c9361720bsm49907706d6.21.2026.08.23.19.13.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Aug 2026 19:13:47 -0700 (PDT)
From: Nat Brown <natbro@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nat Brown <natbro@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] linux-user/i386: report the real trap number in
 sigcontext.trapno
Date: Sun, 23 Aug 2026 22:13:08 -0400
Message-ID: <20260824021308.26600-1-natbro@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=natbro@gmail.com; helo=mail-qv1-xf32.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 24 Aug 2026 00:23:49 -0400
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

setup_sigcontext() fills sigcontext.trapno from CPUState::exception_index, but
by the time a signal frame is built that field has already been reset to -1:
cpu_exec() copies the exception number into its return value and clears
exception_index before returning to cpu_loop(), which is where the signal is
queued.  Guests therefore see trapno == -1 for every cpu exception.

  #include <signal.h>
  #include <stdio.h>
  #include <ucontext.h>

  static void h(int sig, siginfo_t *si, void *uc_)
  {
      ucontext_t *uc = uc_;
      printf("sig=%d trapno=%d err=%#x\n", sig,
             (int)uc->uc_mcontext.gregs[REG_TRAPNO],
             (unsigned)uc->uc_mcontext.gregs[REG_ERR]);
      fflush(stdout);
      _exit(0);
  }

  int main(void)
  {
      struct sigaction sa = { .sa_sigaction = h, .sa_flags = SA_SIGINFO };
      sigaction(SIGSEGV, &sa, 0);
      *(volatile int *)0 = 1;
  }

Natively this prints trapno=14 err=0x6; under qemu it prints trapno=-1 err=0x6.
A SIGILL likewise reports -1 instead of 6, and SIGFPE -1 instead of 0.  Both
qemu-i386 and qemu-x86_64 are affected, and both report the expected 14/6/0
with this patch applied.  Only trapno is wrong; error_code lives in
CPUX86State and survives.

x86_cpu_record_sigsegv() already notes the coupling, observing that we cannot
let the caller clobber exception_index "short of inventing a new place to store
the trapno".  Invent it: record the exception in env->trap_nr, mirroring linux's
thread.trap_nr, which is exactly what the kernel reports in sigcontext.trapno
and which likewise persists beyond the exception that set it.  Only hardware
vectors are recorded; the EXCP_* values at 0x100 and above are emulation
internals and never appear in a signal frame.

This matters to wine, whose segv_handler() dispatches on the trap number and
cannot service a fault it sees as -1, so 32-bit module loading fails under
qemu-i386.  The equivalent 64-bit handler dispatches the same way, so the same
failure is expected under qemu-x86_64.  Discussed at
https://gitlab.winehq.org/wine/wine/-/merge_requests/11737 , where the
suggestion was that qemu is the right place to fix this.

Signed-off-by: Nat Brown <natbro@gmail.com>
---
 linux-user/i386/cpu_loop.c         |  9 +++++++++
 linux-user/i386/signal.c           |  6 ++----
 target/i386/cpu.h                  | 10 ++++++++++
 target/i386/tcg/user/excp_helper.c |  8 ++++----
 4 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index fe922fceb5..24fdcc9b24 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -218,6 +218,15 @@ void cpu_loop(CPUX86State *env)
         cpu_exec_end(cs);
         qemu_process_cpu_events(cs);
 
+        /*
+         * Remember the exception for sigcontext.trapno, as linux does in
+         * thread.trap_nr.  Only hardware exception vectors qualify; the
+         * EXCP_* values at 0x100 and above are emulation internals.
+         */
+        if (trapnr >= EXCP00_DIVZ && trapnr <= EXCP12_MCHK) {
+            env->trap_nr = trapnr;
+        }
+
         switch(trapnr) {
         case 0x80:
 #ifndef TARGET_X86_64
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index b646fde431..9650fac940 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -367,8 +367,6 @@ static void setup_sigcontext(CPUX86State *env,
                              abi_ptr fxstate_addr,
                              abi_ptr fpend_addr)
 {
-    CPUState *cs = env_cpu(env);
-
 #ifndef TARGET_X86_64
     uint16_t magic;
 
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
 
-    __put_user(cs->exception_index, &sc->trapno);
+    __put_user(env->trap_nr, &sc->trapno);
     __put_user(env->error_code, &sc->err);
     __put_user(env->eip, &sc->rip);
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 641f3ee5c2..cf727b2a56 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2188,6 +2188,16 @@ typedef struct CPUArchState {
 
     /* exception/interrupt handling */
     int error_code;
+#ifdef CONFIG_USER_ONLY
+    /*
+     * The number of the last cpu exception taken by this thread, mirroring
+     * linux's thread.trap_nr, which is what the kernel reports in
+     * sigcontext.trapno.  CPUState::exception_index cannot be used for this:
+     * cpu_exec() resets it before returning, long before the signal frame is
+     * built during delivery.
+     */
+    int trap_nr;
+#endif
     int exception_is_int;
     target_ulong exception_next_eip;
     target_ulong dr[8]; /* debug registers; note dr4 and dr5 are unused */
diff --git a/target/i386/tcg/user/excp_helper.c b/target/i386/tcg/user/excp_helper.c
index 0957ad2e9e..26a4c0ef92 100644
--- a/target/i386/tcg/user/excp_helper.c
+++ b/target/i386/tcg/user/excp_helper.c
@@ -31,10 +31,10 @@ void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
 
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
     env->cr[2] = addr;
     env->error_code = (maperr ? 0 : PG_ERROR_P_MASK)
-- 
2.50.1 (Apple Git-155)


