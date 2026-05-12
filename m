Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFD6CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuGl-0003Wq-Hh; Tue, 12 May 2026 17:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuEO-0007FI-M5; Tue, 12 May 2026 17:01:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuEL-0006ca-MH; Tue, 12 May 2026 17:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619277; bh=RI10+5zPGhJ/aOzuzHvVJ9FNHtrl/IeqoVNJcNULtVs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BndFA9Fm0HBwyBMwkNLLZznFAODHXqJv0c6xeQnLWLyt43tHptLaMxYulhAfIkpUo
 KlpAgjxGFQVBTzYaiTiQtw98fyu2LP5l8KjFHM6VZwI2uk5NkKYiG3mswO4ebnnYSV
 tIGcKLDrhFk20mgg9TFrrDTqKxnK9WFQe0NGSxsmgWX79kpDrQ7qHnVwRU8NwrkP5v
 sYzwbtfQYZS5vWPaKVg4OI0hkof4Q63NgYR+ixnl8GJJ1fEEn61C9QU4MajL+MmhK3
 DWh2abS0+ZKMcPpBGOosKOVYDLauiHL4C38c55Px3RHKSWedIRc7qxwGu3jAo8qDRb
 UnZio+LUc46PA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ED53C1AA311;
 Tue, 12 May 2026 23:54:37 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0391B3ABC82;
 Tue, 12 May 2026 23:54:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 069/107] linux-user/ppc: Fix ppc64 rt_sigframe stack
 offset
Date: Tue, 12 May 2026 23:53:56 +0300
Message-ID: <20260512205437.360850-69-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

The kernel's 64-bit signal delivery (signal_64.c) uses:

    newsp = frame - __SIGNAL_FRAMESIZE

while the 32-bit path (signal_32.c) uses:

    newsp = frame - (__SIGNAL_FRAMESIZE + 16)

The extra 16 bytes in the 32-bit case is to place siginfo and ucontext
at the same offsets as older kernels (see the comment in signal_32.c).
The 64-bit rt_sigframe starts with ucontext directly and does not need
this adjustment.

QEMU's setup_rt_frame() unconditionally used (SIGNAL_FRAMESIZE + 16)
for both 32-bit and 64-bit, placing the handler's SP 16 bytes too low
on ppc64. Signal delivery and return still worked because do_rt_sigreturn
had the matching wrong offset, but the vDSO DWARF unwind info encodes
the correct kernel offset. This caused any DWARF unwinder (libunwind,
libgcc, etc.) to compute a CFA that is 16 bytes off, reading garbage
register values from the signal frame.

Define RT_SIGFRAME_ADJUST (0 on ppc64, 16 on ppc32) and use it in both
setup_rt_frame and do_rt_sigreturn to match the kernel.

This was verified by A/B testing with libunwind's test suite:

  ppc64le: Gtest-bt, Ltest-bt, Gtest-concurrent, Ltest-concurrent,
           and Ltest-sig-context all change from FAIL to PASS.
  ppc64be: Gtest-bt, Ltest-bt, and Ltest-sig-context all change
           from FAIL to PASS.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: qemu-stable@nongnu.org
(cherry picked from commit 654dce6c523612d38e8d53818dbc7c03cbe535a3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 24e5a02a78..a9c10e0987 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -210,6 +210,18 @@ QEMU_BUILD_BUG_ON(offsetof(struct target_rt_sigframe, uc.tuc_mcontext)
 
 #endif
 
+#ifdef TARGET_PPC64
+#define RT_SIGFRAME_ADJUST 0
+#else
+/*
+ * For 32-bit rt sigframes we have an extra 16 bytes of gap
+ * on top of __SIGNAL_FRAMESIZE; this is to get the siginfo
+ * and ucontext in the same positions as in older kernels.
+ * See Linux's arch/powerpc/kernel/signal_32.c.
+ */
+#define RT_SIGFRAME_ADJUST 16
+#endif
+
 #if defined(TARGET_PPC64)
 
 struct target_func_ptr {
@@ -525,7 +537,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     env->fpscr = 0;
 
     /* Create a stack frame for the caller of the handler.  */
-    newsp = rt_sf_addr - (SIGNAL_FRAMESIZE + 16);
+    newsp = rt_sf_addr - (SIGNAL_FRAMESIZE + RT_SIGFRAME_ADJUST);
     err |= put_user(env->gpr[1], newsp, target_ulong);
 
     if (err)
@@ -641,7 +653,7 @@ long do_rt_sigreturn(CPUPPCState *env)
     struct target_rt_sigframe *rt_sf = NULL;
     target_ulong rt_sf_addr;
 
-    rt_sf_addr = env->gpr[1] + SIGNAL_FRAMESIZE + 16;
+    rt_sf_addr = env->gpr[1] + SIGNAL_FRAMESIZE + RT_SIGFRAME_ADJUST;
     if (!lock_user_struct(VERIFY_READ, rt_sf, rt_sf_addr, 1))
         goto sigsegv;
 
-- 
2.47.3


