Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991AAC44508
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjHQa-0004Wl-Uh; Mon, 13 Jul 2026 10:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjHQZ-0004Wc-Gn
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 10:14:35 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjHQX-0007oG-Ew
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 10:14:35 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47362928f65so3126502f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 07:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783952071; x=1784556871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A9pYJ+Ybcdy45JidsjbXsngA1iRXaiMkr7qWkMK6FG4=;
 b=aXugXNGXV2JI/L/02FtmkrOFqnArWsoo/dliwWeWwDVHvphcOvKLMuChAKGuxHbPbh
 R4UjDaFWe0/n7nWw9e8fxLS83wd4RnYVxD6dVWT7w6irgPiQoAYvmYA9fzR6Ps+Okxav
 u2qmDnno61hWw4fFYIMNHlTTOp5HrCgOwyA7o32uAydto9WXajF9tj1johVuYOeRQsAc
 9thV81RZ8rmX3ql3noRqHUxi19zLhZ5BMuHCIABb90KaqL6NRi3yw8PVTb7kAV5cfxaj
 wGH5U3MEAYAqJcf1gHdmE44QOCwRbLD5wVB6CvxkBnV8CS01qzEok+/vmT81phUxgNPc
 U66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952071; x=1784556871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A9pYJ+Ybcdy45JidsjbXsngA1iRXaiMkr7qWkMK6FG4=;
 b=fXAN9zV6z154zoiQfWFCp8tZENvGe4BZCQkzzvPSBIQwQWDcQJgxNVfP5Dr/PMQPc2
 aa+TWAsi2no66SUOZcAsAffP6+WF7Aj8M8aEuQx2tKg2KAvNkuCP0ZENKW6nnMdIJAu/
 BbZ6x6iD2XA0jmPFrw8pQ3aNtckKDUFYw1hMSZbIIuKfaAqQfXzgPjAj2stXLU57Bg4D
 tGXH5iIPIO3Mp2Nce2/bqwadrZJcc+aGAjcYPJeWCmfSPGaDAvdvuVfIPC6K4nqDLb6f
 NduYMywsBMUc3o3f0sU2zFTfEsKV4mVGFepFhVJ7p4BkLop2rkF/Ay0IazlNr4DXY08p
 uhxg==
X-Gm-Message-State: AOJu0Yz21/g8JaEywBDiFBq3nuVysYeqNLsvbHXtr+200TTq4Moc51Nc
 0ylGdDl3MxtGMv/ZvKJwmLuFuOnc7KKLfT1gCDj1/8gH/5zNC6kaAZOvutmRV79FjpvG0BNA6u8
 IsDnohZeAzw==
X-Gm-Gg: AfdE7cnV8P0n0b8guslyOHFhoiUL4Jme3sO2IcnwTctRaZQd9sgBBma2xNHEO2Pyt4G
 ZYFGFPssdYSV+axyqmzFnISfXmabG2r88z3ijgqEhL5JTD2FPFPGNa2SIByD9XZGd12DpmrC+KJ
 WNWbO/V6bGGqFslnH56EUOGjRto1GwEL2I3v94vQWifvB2lQsoUeSvQgWrXrYhCmK+JV8u2pL6N
 onyVX1kPMwVCAho5jM4HlLZSi5UaHNNfhA70eYiX9d6DBKjlRxg86kxX6PhATQ53N+HCGULiXkC
 AN7eIePY0rCe9Yr29V5ziRrN7A/YhKMGZl6ahvowe5gKKOLgPDT7qqF02Y7R6TJ74esSwsVkr/a
 10jH+cyEIFYfngNu4ZB5HGtoHxC8nHUe69AevfcglAWBwcK81NtMabReUG25vUkLlOt22JIt3E/
 4BZ/3RiXA7bC6gw+nfB0JNIZa10INOy7a/JAwuqRB4vVcr7GW1tFbaT+OqfhwBiAkAnMXZX2IAW
 zW104p5L/49p2FbVrnYpw==
X-Received: by 2002:a5d:59c5:0:b0:475:f0d1:eb6b with SMTP id
 ffacd0b85a97d-47f2dcef1a1mr12995149f8f.56.1783952071024; 
 Mon, 13 Jul 2026 07:14:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b0cesm88314213f8f.22.2026.07.13.07.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 07:14:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH] linux-user/sparc: Take pending signals in
 sparc64_set_context()
Date: Mon, 13 Jul 2026 15:14:29 +0100
Message-ID: <20260713141429.3387066-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
I thought about just adding a comment about why we're OK to ignore
the return value, but eventually decided that consistency with how
other parts of the linux-user code handle setting the signal mask
was better. This was originally flagged up by Coverity, not by any
actual observed problem.

Disclaimer: checked the original repro test case that prompted
e0f0ce88eb9, and ran 'make check-tcg', but no other testing.

---
 linux-user/sparc/cpu_loop.c | 10 ++++++++++
 linux-user/sparc/signal.c   | 30 +++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 0aacda94486..eaf388c1675 100644
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
index ba692c31236..4baf983ed82 100644
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
2.43.0


