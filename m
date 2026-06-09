Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01077CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWzTI-0002gZ-Ch; Tue, 09 Jun 2026 12:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWzT9-0002dV-IJ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:38:27 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWzT7-0005Ey-HN
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:38:27 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC9226020B;
 Tue,  9 Jun 2026 16:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60DD1F00893;
 Tue,  9 Jun 2026 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781023104;
 bh=Z1dfaMdDG1BHIABJPuyTvw9aGXsVucAwD1oVosQ69OE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YGUH+ZLkg2KEerfBADfkPXKHO9uvgysBpMHjxUx2mQ5kA3Tqm1jUCp7633Uea0M0/
 h1tdd1k3dULYNBPVX1AcLy2nUf/s1X4GnophSBdHpBZzy2e8D0Kcp5CNDsGvz/fBkO
 pBoVQMTLAOEjqiv7WJa9LwVCrb1YF+K5TPS5PcAqdSK/hb0/0R7TkCK7HfHCW/6Lbj
 8zMLe1jMoXwr9wxCY1vtLy4W14pNpf47zEPlfhnlDfXXFM5Vv5zBNkB6BgkJ4eXmNf
 orLdMAz8puUI405R/2P05efWdvNyJWPOw+LxumtEuJBEEngfG3y+OYZsMwxDZeV9ce
 3IFUgW9ncxY4g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Matt Turner <mattst88@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL v2 6/8] linux-user/sparc: call block_signals() before
 set_sigmask() in setcontext
Date: Tue,  9 Jun 2026 18:38:05 +0200
Message-ID: <20260609163807.6083-7-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609163807.6083-1-deller@kernel.org>
References: <20260609163807.6083-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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

sparc64_set_context() emulates the kernel's `ta 0x6f` trap by calling
set_sigmask() to install the mask supplied via the user's ucontext_t.
The contract of set_sigmask() (see its comment in linux-user/signal.c)
is that the caller must have first called block_signals(), which sets
TaskState::signal_pending.

Without block_signals(), if a guest signal is pending-and-blocked at
the time setcontext is invoked and the new mask unblocks it,
signal_pending stays 0 and the post-trap process_pending_signals()
call in linux-user/sparc/cpu_loop.c never enters its while loop, so
the now-deliverable signal is left undelivered indefinitely.

This affects programs that use getcontext/setcontext to swap signal
masks, including libunwind's unw_resume() out of a signal handler:
without this fix, the test program below loops forever printing
"calling setcontext" instead of delivering the pending SIGUSR2.

  #define _GNU_SOURCE
  #include <ucontext.h>
  #include <signal.h>
  #include <stdio.h>
  #include <unistd.h>
  static int got;
  static void h(int s) { got = 1; }
  int main(void) {
      signal(SIGUSR2, h);
      sigset_t m; sigemptyset(&m); sigaddset(&m, SIGUSR2);
      sigprocmask(SIG_BLOCK, &m, NULL);
      kill(getpid(), SIGUSR2);
      ucontext_t uc;
      getcontext(&uc);
      if (got) return 0;
      uc.uc_sigmask.__val[0] = 0;
      setcontext(&uc);
      return 1;
  }

The 32-bit sparc do_sigreturn / do_rt_sigreturn paths already get
block_signals() from the rt_sigreturn syscall wrapper in
linux-user/syscall.c, so only sparc64_set_context (invoked directly
from cpu_loop) needs the addition.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/sparc/signal.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index fda5508c48..ba692c3123 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -619,6 +619,15 @@ void sparc64_set_context(CPUSPARCState *env)
             }
         }
         target_to_host_sigset_internal(&set, &target_set);
+        /*
+         * set_sigmask() requires the caller to have first called
+         * block_signals() so that process_pending_signals() is guaranteed
+         * to run after the mask change.  Without this, a guest signal that
+         * is pending-and-blocked at setcontext time is left undelivered
+         * even after its mask bit is cleared, because signal_pending stays
+         * 0 and the post-trap process_pending_signals() loop never enters.
+         */
+        block_signals();
         set_sigmask(&set);
     }
     env->pc = pc;
-- 
2.54.0


