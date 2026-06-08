Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E4ACD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfsd-0008VB-Ir; Mon, 08 Jun 2026 15:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWfsS-0008T5-Or
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:43:17 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWfsR-0006DF-7C
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:43:16 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EDE0040A50;
 Mon,  8 Jun 2026 19:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05EB1F00893;
 Mon,  8 Jun 2026 19:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780947793;
 bh=Z1dfaMdDG1BHIABJPuyTvw9aGXsVucAwD1oVosQ69OE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z6xEbIPto6U+AvHb0dH5/GAOjqih6V4qVuZe+Vs5Z6JvwtHWI05dlDIxXmLXvQ5US
 qG2ULjiTxQ2tw458dczjJbrZTmmKI0U4fxlHv+JK/4zUdN5ozzEa2taFv0jp0KfZSi
 lZak/Bibf+4HEvrV2mMmXtoCga+GFnVE07bBZmrOXBD8DtQvqtElAl4tRks8cqyYm0
 N5ZzpHcStnVkvfae97Z5MRHPtxamKvwSt8YGC3r6GvJ3KgtOvjWwsLBfA9bgjGLO2h
 DmDkfKB7i6g5n6XE7DymUrooYiFTxZqCd4ajeEYFCO6LTolPKjCy7MOuVB9n2kV+dU
 f+HVdUdAC/P6w==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Matt Turner <mattst88@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 6/8] linux-user/sparc: call block_signals() before
 set_sigmask() in setcontext
Date: Mon,  8 Jun 2026 21:42:54 +0200
Message-ID: <20260608194256.13794-7-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608194256.13794-1-deller@kernel.org>
References: <20260608194256.13794-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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


