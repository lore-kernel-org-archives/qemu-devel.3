Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD552CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuOP-000250-0l; Tue, 12 May 2026 17:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuOD-0000IQ-Lh; Tue, 12 May 2026 17:11:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuOA-0004fI-Oa; Tue, 12 May 2026 17:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619303; bh=U45kgYAj+2v7iIaX8tYnrSLqsn7a9J3SNZbV3Nk05YM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DX6Mk9yWjvwJF8n8SnIrg9xjRhBITThmhgHEGu4qX1rddNp3qoQtfVIRj6VpIj2Lg
 +fsCGH6YBZMPfPm2U03XQkbwNHX2pqdB7OOicmAbcgfsMWFZSLb2nZ+Kak5QP14edV
 GAhA2Ud1yzxcuIIpxfxdTDvfX7mLeQmkqh8uzsKkDkQ57c51H4nXBlYri5C3GnrDzS
 UW//7BBPeE5/JO5Ghl5CAOffk57PCmFKmPyUDWeuRlS/7dTGh6YGULX1MjismuOdcc
 RwsTVkHzPkm2Lij28JXIOrTKdvXH/GYtxdP8AOhKUdHoLRSgCnqYvUOSNYhlXjGtap
 MVDyNN5egJP8w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7F03B1AA377;
 Tue, 12 May 2026 23:55:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8A1D43ABCE6;
 Tue, 12 May 2026 23:55:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 057/117] bsd-user,
 linux-user: signal: recursive signal delivery fix
Date: Tue, 12 May 2026 23:53:59 +0300
Message-ID: <20260512205503.361097-57-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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
(cherry picked from commit 7e966ef38f58f91e05a46fdfda4ba63a9a1567d6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.3


