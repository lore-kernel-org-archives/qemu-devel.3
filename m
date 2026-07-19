Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9CCC44512
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 18:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlWOQ-0004Q0-VW; Sun, 19 Jul 2026 14:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wlWOP-0004Pr-02
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 14:37:37 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wlWON-0008Dc-8q
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 14:37:36 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4B6C60120;
 Sun, 19 Jul 2026 18:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C395B1F000E9;
 Sun, 19 Jul 2026 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784486246;
 bh=Baus3szB4pl1/YdwNIX8jXaDqUTwkJNzRjkGxgRYLfQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=J83c7m28Fu2PZL6Dt3mxZO50PNmT2pesrTY0tQx8qXuN8v98/eSdQPGviJPHcqnUO
 U3lrellmDdaxbWD8fY69B7ziCYeOqeC9DUQXNIsobt9BeFTX7oMwYxCgzpRFKmXY8r
 HG6fZ6AkX0IeFLIrC68mYxkSpMnV1DwQe+cb1WuuuLPE2zgHYKp0f8bCxmbeBUuBjC
 3QclE3VVmepttL4LnkkoyYLq6t1qhZy+lBailiggO7r49lQOOUQMFZopMoYDyvisCf
 DKhnt86YKwjVmVT/Jv1YPwZwAJa11NlIi88pjqYKBgvNtb+l3mNGNk5veRFe8zDuJ2
 2DPxWnIDMU3wA==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>
Subject: [PULL 1/1] linux-user/sparc: Take pending signals in
 sparc64_set_context()
Date: Sun, 19 Jul 2026 20:37:21 +0200
Message-ID: <20260719183721.3035-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260719183721.3035-1-deller@kernel.org>
References: <20260719183721.3035-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

Every callsite of block_signals() checks its return value, except
the one in sparc64_set_context(). Generally you need to check,
because the standard pattern is:

    if (block_signals()) {
        return -QEMU_ERESTARTSYS;
    }
    /* do some blocking syscall */

and we need to take any pending signal before we do the blocking
operation, not afterwards.

The use in sparc64_set_context() doesn't do this.  It doesn't have to
because the operations it is doing aren't blocking, so it won't get
into "we didn't take the signal that we should have" races that
blocking syscalls do.  But it does make this way of updating the
signal mask inconsistent with how we do it in do_sigprocmask().
do_sigprocmask() does the usual "return -QEMU_ERESTARTSYS", so a
pending signal that was not blocked by the old signal mask and which
will be blocked by the new mask we're about to install will be taken
before we change the mask.  sparc64_set_context() doesn't check the
return value, so we won't take that pending signal.  That's not
wrong, because it just means the signal lost the race with the
executing code.  But it seems clearer to behave the same way as
do_sigprocmask(), not differently.

Make sparc64_set_context() check the return value of block_signals()
and return early if there's a pending signal to take.  We don't need
to return a separate return code to indicate this because the main
loop handles it the same either way.

Coverity CID: 1660058

Fixes: e0f0ce88eb9 ("linux-user/sparc: call block_signals() before set_sigmask() in setcontext")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/sparc/cpu_loop.c | 10 ++++++++++
 linux-user/sparc/signal.c   | 30 +++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 0aacda9448..eaf388c167 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -282,6 +282,16 @@ void cpu_loop (CPUSPARCState *env)
             break;
         case TT_TRAP + 0x6f:
             flush_windows(env);
+            /*
+             * If we have a pending signal, sparc64_set_context() may
+             * return early without changing register state (like a
+             * syscall that returns -QEMU_ERESTARTSYS). We will then
+             * take the pending signal via process_pending_signals()
+             * below and eventually re-execute the trap. We don't need
+             * the function to return a different value for the
+             * "restart" case because this main loop code does the
+             * same thing in both cases.
+             */
             sparc64_set_context(env);
             break;
 #endif
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index ba692c3123..4baf983ed8 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -594,6 +594,27 @@ void sparc64_set_context(CPUSPARCState *env)
     unsigned int i;
     unsigned char fenab;
 
+    if (env->regwptr[WREG_O1]) {
+        /*
+         * We're going to set the signal mask; we need to call
+         * block_signals() first, so that process_pending_signals() is
+         * guaranteed to run after the mask change.  Without this, a
+         * guest signal that is pending-and-blocked at setcontext time
+         * is left undelivered even after its mask bit is cleared,
+         * because signal_pending stays 0 and the post-trap
+         * process_pending_signals() loop never enters.
+         *
+         * If block_signals() returns true, this means we have a
+         * pending signal that we could take now; we return early so
+         * the cpu_loop takes that signal.  Eventually the guest will
+         * re-execute the trap insn and we'll come back here to have
+         * another go at set_context. This is the same way that
+         * do_sigprocmask() handles setting the signal mask.
+         */
+        if (block_signals()) {
+            return;
+        }
+    }
     ucp_addr = env->regwptr[WREG_O0];
     if (!lock_user_struct(VERIFY_READ, ucp, ucp_addr, 1)) {
         goto do_sigsegv;
@@ -619,15 +640,6 @@ void sparc64_set_context(CPUSPARCState *env)
             }
         }
         target_to_host_sigset_internal(&set, &target_set);
-        /*
-         * set_sigmask() requires the caller to have first called
-         * block_signals() so that process_pending_signals() is guaranteed
-         * to run after the mask change.  Without this, a guest signal that
-         * is pending-and-blocked at setcontext time is left undelivered
-         * even after its mask bit is cleared, because signal_pending stays
-         * 0 and the post-trap process_pending_signals() loop never enters.
-         */
-        block_signals();
         set_sigmask(&set);
     }
     env->pc = pc;
-- 
2.54.0


