Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D0FD35163
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sC4-0008EJ-Gr; Wed, 01 Apr 2026 05:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7sC2-0008DK-O6
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:48:58 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7sC1-0000MM-7q
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:48:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48704db565eso82329475e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775036936; x=1775641736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mgYPJpXjZl3FWnFp/mDCN39gvvpK4oUEly1SjLxTN7o=;
 b=FlkHXdhp203ViG2d/XZjTh4VCM9jzY4tZjrm4Rzkj2KuaeIxyLli+YINgh3iWrVI3k
 4F0Ev9Vu4m/osqWup8Es1hRY+7G7yZf8pJlh8wSv7CuvSGMkYH57I1YZbdq5u3hS+eY8
 UZjygSIj7l0aIsxnySUHLGGLz7E/uJiRZE0qG3fkNSRXAg4BOC8efqDlJf+Rp8jMcOHi
 qj1GmETsvEBW7IbtFHrZMcxl+by2dxckBuFTmrMWmwWvVeKBYH4AXWIdSGyLmqMYNR9e
 YED/M4V9bxAvlG3dkOiH1sE1i2aa8rYZYeRXwNm1IBW3nQv7Jf6haJa1lYv2yDD2cOD6
 wVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036936; x=1775641736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mgYPJpXjZl3FWnFp/mDCN39gvvpK4oUEly1SjLxTN7o=;
 b=JSb60IGyk8/JGQO6hDaCNfnKeRimjC6SdX1RJzWTvBQ9etDljcQkILqFE6gAoD6p8f
 6mz8hyAMWqppsmrQ6uiMSE12bBDKFwC8Klq9C2Y7MPI8YuMBgX3dfiJFKyo42G7nTQzh
 QtbcMb+xxBW3DKEoPKXiBT5BAX773H0z0+gmSP0R4/Fy/pLsrHaVCgIkflhXbLgf3HvR
 lZjbVZrcg4KWJj/MraN8dP9qOlG8m6xaZMz1eo21aA0iDQ9JZ0rSEsAtT7c5x9RjrrF9
 EsT21alUwZ8vVs3cuOU2wS3C2cYIAdlGotUUVYR1SES/Tz0kD2YQZqnY7RoUKV9ITPkC
 7rEQ==
X-Gm-Message-State: AOJu0Yxj/G0EW9GrXBthmxdb0ziSTC7XeqYVArj/PZPmjWN8hQTC2o+p
 7s8axcI0ByJIMNpA/j8FDV+mmt1FZLDzMXjhUUwRfp/9trKWUUyyp9wqpQHM4maojkLjwWiU5/j
 OZWg3fsg=
X-Gm-Gg: ATEYQzwM2HYrFW0vz8hNxn3yPdsr9CDj4XpBez02prfDJLirkUJaxnAH7M2XgEemrUx
 T0A591ITt8J9YC56glt1tqwI9D7KcoWGMIA1qjGZ+h5tEYjf3fJYU+u37/knG0v0pxhvhsYwxRI
 gWRulB9GT9RYfFaXvVjRyk+kYHEMxL0TZaW/83TjgbE1xgC+71kXQejYoWsnh6N5u9HjdP/4TeX
 qyyJKtmPKzVHM6a6xcts8Q9RmUtHpjGp1bPSpld8OI14u+jkYoq1zPh0CANuimo5JujXuWn/0QD
 J3L1VJdDHaw7R2PQV5CpmHRAsy8UzxZAeuAO198lAxdA4MphoSkpUSTArNK1nJsEuL3RfSLiw+W
 bpzCCB9xwggQpX3WvwD/H3RhJi0aQKkT5BnhTQiZ0eZGnDReV5/R9husXFotwbMVdZY/g2LnDPp
 WJzDB2DuE5OOPY3jBe4fh65q49ZnQSSCxZE2z1bQbJkg+fpmiG7v3bhA8ezDGNwLBOcoFH7AgiR
 PsKGeIUEeA0ZHyfSO593Db+3AX/bYY=
X-Received: by 2002:a05:600c:8b85:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-4888355df3emr49861845e9.3.1775036935589; 
 Wed, 01 Apr 2026 02:48:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887eb5aff3sm146945685e9.15.2026.04.01.02.48.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 02:48:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] bsd-user, linux-user: signal: recursive signal delivery fix
Date: Wed,  1 Apr 2026 10:48:48 +0100
Message-ID: <20260401094848.2661985-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401094848.2661985-1-peter.maydell@linaro.org>
References: <20260401094848.2661985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

Synchronous signals must accommodate a synchronous signal being
raised during delivery, as asynchronous ones do. For example
badframe errors during delivery will cause SIGSEGV to be raised.

Without this fix, cpu_loop() runs process_pending_signals() which
delivers the first synchronous signal (e.g., SIGILL) which fails
to set the handler and forces SIGSEGV, but that is not picked up.
process_pending_signals() returns. Then cpu_loop() runs cpu_exec()
again, which attempts to execute the same instruction, another
SIGILL.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260321135624.581398-3-npiggin@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 bsd-user/signal.c   | 10 ++++++----
 linux-user/signal.c |  9 ++++++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index dadcc037dc..3e5e41e1b1 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -998,7 +998,12 @@ void process_pending_signals(CPUArchState *env)
                 sigdelset(&ts->signal_mask, target_to_host_signal(sig));
                 sigact_table[sig - 1]._sa_handler = TARGET_SIG_DFL;
             }
+            /*
+             * Restart scan from the beginning, as handle_pending_signal
+             * might have resulted in a new synchronous signal (eg SIGSEGV).
+             */
             handle_pending_signal(env, sig, &ts->sync_signal);
+            goto restart_scan;
         }
 
         k = ts->sigtab;
@@ -1008,10 +1013,7 @@ void process_pending_signals(CPUArchState *env)
             if (k->pending &&
                 !sigismember(blocked_set, target_to_host_signal(sig))) {
                 handle_pending_signal(env, sig, k);
-                /*
-                 * Restart scan from the beginning, as handle_pending_signal
-                 * might have resulted in a new synchronous signal (eg SIGSEGV).
-                 */
+                /* Restart scan, explained above. */
                 goto restart_scan;
             }
         }
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 804096bd44..f0a22577e5 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1384,6 +1384,11 @@ void process_pending_signals(CPUArchState *cpu_env)
             }
 
             handle_pending_signal(cpu_env, sig, &ts->sync_signal);
+            /*
+             * Restart scan from the beginning, as handle_pending_signal
+             * might have resulted in a new synchronous signal (eg SIGSEGV).
+             */
+            goto restart_scan;
         }
 
         for (sig = 1; sig <= TARGET_NSIG; sig++) {
@@ -1394,9 +1399,7 @@ void process_pending_signals(CPUArchState *cpu_env)
                 (!sigismember(blocked_set,
                               target_to_host_signal_table[sig]))) {
                 handle_pending_signal(cpu_env, sig, &ts->sigtab[sig - 1]);
-                /* Restart scan from the beginning, as handle_pending_signal
-                 * might have resulted in a new synchronous signal (eg SIGSEGV).
-                 */
+                /* Restart scan, explained above. */
                 goto restart_scan;
             }
         }
-- 
2.43.0


