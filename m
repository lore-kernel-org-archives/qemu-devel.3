Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB95A1094478
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 13:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3wox-0008SZ-SJ; Sat, 21 Mar 2026 09:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3wow-0008SR-Oz
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 09:56:54 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3wov-0000Vp-4Z
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 09:56:54 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2adbfab4501so6355055ad.2
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774101411; x=1774706211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33bK0g5AvUfHWijJiI0bLgMdG2DgEQ/sawsGLjJgXd8=;
 b=kAmUAsG2ATmIheurfLDKt++ncy3ogCjJe/0rylLEd2wytRyq0ecfMMxPg8oNjpvoMu
 oR+Ai5U4yR8TqStVWexZ5nWpHv01jE7GcC9FG7//yFl/TrpNVRl7Nvkw4I/4Vc2oXzcD
 ymxNuMSwhtKw+BnzlE7u9ZX+pMz5LIG7z7UkGPUe4TnuJHS55dXxwECSYouOcfKRI5Zm
 N3GMgLy9aUsPReQlO9N3xn2nu8Uqo6qbV1XscFXeBBwxfwAA/gmopHJzkWCgZ31ZHaS7
 QYvhePoEcb1XzRqtBoLZwJHK5+/Baqtpf1YOPRiqv6JfZGFfu1sGoeFMtdrdJFJG76R3
 TpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774101411; x=1774706211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=33bK0g5AvUfHWijJiI0bLgMdG2DgEQ/sawsGLjJgXd8=;
 b=prmYnK8zjXeJX39BUVBjC5eLPzer+49TMRqTkczpKdXNdG39RPc/Fv0DbsSLtUC1jW
 3eXSDORQJvZKVHNhMOLLvBwUGbEpPRZjLLe6Zat4zgQAgZijrgVsCyacgNEUNkCT+IUL
 TaQtwRJ7TzXBiTevo0ixuT6k9GNcPTn33bAnDNuqV5MYRRdOADAm1IvihKm3XEnzmQLf
 3n1eYB7SseNlmNW5UwxYeLIq6J6IZkGjV+FMIkVHqsV33lBnjsUXT0gFumcroSSEQanv
 chDXeUjR4oP+SJGOBA6qPBEsg8N+A5J582rPxQZKQRGK1KqfbAcNNtX/dVxvN4T1mRWB
 6yAw==
X-Gm-Message-State: AOJu0YzPYeQG71C5DgEfPNEkvO8qnWU2Y9/b9Icd3lnHQXwzwa4DOW//
 MDfFrU61qX1nHNi5ZcDbedrGZM5Ok5EIoD3iDUi0GuCpUFWOz+oEvwauuufdZg==
X-Gm-Gg: ATEYQzxBXNAWtaV/cWxMChMeJNVQ+x1zK7KjQXsbYLHuRB0mm8YNSoxo3GkRzy2HXSA
 IfOqVGQBvvnR7/su0uYThAKGWCzbFsf7R1lzXAVcCM/6GgW3e9rcmU/DihQ+rHJGXXBF9z3vFKT
 uJy84wGd+YHUT/fAxV6focwiRSWM1sX4MU9F+UGBJIqJ4IE3LsDXzPH+WlnER14msO/2AEGTfRg
 deVLPfEALXF63LfG6Z93UQpHULDcep8CLrbltSJtDouzwymzWn0zZ58WO0u6BvKk4XPazYc2lTD
 w4OhfWVkFNxgCQd1Bc40v2Z7jBK8wgBJnUGNECyrsUy6erHIPp7Z+Dc9uGvgpkke/ypVMWoXz7L
 00Aw71IGdE3i5IdXPgmX1p/bBCZvACo8u0Xl5TVxvfettoMQMKGj7fOe1Jr8mrmV4WgQf0IpCak
 dteFqpa23QngYMgf7oJh46mtECYB4lkyeLBExKQf2SiPLmJVxXEX+JPZPcP1zWAQ9jI/Luf+40M
 PZ+7r0=
X-Received: by 2002:a17:902:ccd2:b0:2b0:5682:6973 with SMTP id
 d9443c01a7336-2b08273d0d4mr58134035ad.19.1774101411065; 
 Sat, 21 Mar 2026 06:56:51 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08354bce3sm66285675ad.32.2026.03.21.06.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 06:56:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/3] bsd-user,
 linux-user: signal: recursive signal delivery fix
Date: Sat, 21 Mar 2026 23:56:22 +1000
Message-ID: <20260321135624.581398-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321135624.581398-1-npiggin@gmail.com>
References: <20260321135624.581398-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
index e4b8b28bfe..9d43e080ce 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1385,6 +1385,11 @@ void process_pending_signals(CPUArchState *cpu_env)
             }
 
             handle_pending_signal(cpu_env, sig, &ts->sync_signal);
+            /*
+             * Restart scan from the beginning, as handle_pending_signal
+             * might have resulted in a new synchronous signal (eg SIGSEGV).
+             */
+            goto restart_scan;
         }
 
         for (sig = 1; sig <= TARGET_NSIG; sig++) {
@@ -1395,9 +1400,7 @@ void process_pending_signals(CPUArchState *cpu_env)
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
2.51.0


