Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C551094480
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 13:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3wou-0008Ru-EE; Sat, 21 Mar 2026 09:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3wos-0008RM-A2
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 09:56:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3woq-0000VM-J4
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 09:56:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b056b7f783so14094635ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774101406; x=1774706206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbA6YNQSXrCmeEuAYqUodFtq31D0H7TEzGScaa4W5mE=;
 b=ZSLX+7tzOzjJ7su2UE5iY7NiIWB2+skIH5tUgDhJpClsefmDx4j5rS3IqcpO5DdNl0
 /nYprN0Tvdwu/QpmsB8ARkaZjLnCY+rS8oBTJeq46d5jygkmyjyf2g/FdzMbHVBlSd+I
 xnIBRLWHbmUp6+xn2dMau8zYTmxsDXN3NGyjfLZ6WIsZthrA423d2rK3TAWKawbEnxi8
 1DGqhL3KDCzGIX0yrnWOt/a2TdkbkKFCaxpc22n27WIUO36y/5OGd/qpcNRzVBmY/FZm
 51nPQLhHfSVABfNO3tzCdK34hmtPD2K2Dklsl9BrksM/SvUYxpyCamWAqLDuH2caD9r7
 Wq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774101406; x=1774706206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rbA6YNQSXrCmeEuAYqUodFtq31D0H7TEzGScaa4W5mE=;
 b=SEMvZUHrf0J7z2xwTes3+2eVlOPcmj7S4YsQvgS9BAzC4gqsVNAdT3GmOapdYgsKIZ
 Vuu7TV77Y+YGg4sXkJlgaqbA4zFM5S7wbzMFK7Lceq2cVy7kVzPN0Ass+t3hf7mhxf66
 8KMCG+aK07GBhk8ympl/FmJOwK718UobeKdaC2wUfr2MO6blWJy3EpKyfRLzRLKdO0/H
 yiZgc1Gui+b9wvjSfs5w6OOH5D1HVkqS4McUOO7qctHE0meCfY4EZmDR0adG8KhMqSZm
 u1DBGK0cqXYBaSfG77ekjB5khf/W8q4SrEvRn/dD7SnQUgrQl3MIBNSsGEEAriI6buzX
 MkGQ==
X-Gm-Message-State: AOJu0Ywom8Iqhc5uBpYLabAKWUwDKfei1Z+hum485Kr/4mwvmUyoDCi+
 CgrxoMni6pG0FTtflLInTkyCW+Bnzp1kmRtrSoy853pLs6JbLRGNr9OldcbdUA==
X-Gm-Gg: ATEYQzywmVBOAjuKEoK8fBcImKOri4R18glxOWAXA50s0djI+gjv/kCFUe+6bCogbP/
 uBtAO+hw5R+IkfK5i/fzf8TKZYDFaL3vCoTbrG6BGhww+T7NWh9TDfCGuOZSLiajz1tI7e9gzrE
 ozHJw0sC/6yL0eX/JoWQilJkubiDliA7UDSnPvHbqgXzeTBl1DPO5HMRmP2/oiU8DqEjzLfuKX6
 XsXyU7XmJQ4bnsTX3hw8LUGgaR1jztwJtaQPrpE48RU+ZZMNfCeneZcCa7D4N++Wpd5L4j85M/o
 9T1S8FJGkMu9Xg8+ceiBmcESMhfzqVne7yyAjJrKQnJ22Km1qpqPJhbRV2nmcoDt+wdbvo2GsXA
 3cls6ZbHeZ88mIC8b/Zepgl9lEtKxuNvhZB2mMBajzMdWaVPbEoRyRXT5ngcuOuD5cAU1EUYNGc
 HnMPaFVfwBEox9CWbW/SQPKAT1NVQ/fKk+uQrpr3Z0YcUpwAT66psNAkCYK8AAfppjYrHPQqxPh
 SM8bhw=
X-Received: by 2002:a17:902:f54c:b0:2ae:ced7:465f with SMTP id
 d9443c01a7336-2b082735088mr54726515ad.7.1774101406330; 
 Sat, 21 Mar 2026 06:56:46 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08354bce3sm66285675ad.32.2026.03.21.06.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 06:56:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/3] linux-user: sigaltstack lock_user_struct missing unlock
Date: Sat, 21 Mar 2026 23:56:21 +1000
Message-ID: <20260321135624.581398-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321135624.581398-1-npiggin@gmail.com>
References: <20260321135624.581398-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

lock_user_struct is missing a corresponding unlock.

(bsd-user does correctly unlock in the equivalent code.)

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 linux-user/signal.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 804096bd44..e4b8b28bfe 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -292,11 +292,10 @@ void target_save_altstack(target_stack_t *uss, CPUArchState *env)
     __put_user(ts->sigaltstack_used.ss_size, &uss->ss_size);
 }
 
-abi_long target_restore_altstack(target_stack_t *uss, CPUArchState *env)
+abi_long target_restore_altstack(target_stack_t *ss, CPUArchState *env)
 {
     TaskState *ts = get_task_state(thread_cpu);
     size_t minstacksize = TARGET_MINSIGSTKSZ;
-    target_stack_t ss;
 
 #if defined(TARGET_PPC64)
     /* ELF V2 for PPC64 has a 4K minimum stack size for signal handlers */
@@ -306,33 +305,29 @@ abi_long target_restore_altstack(target_stack_t *uss, CPUArchState *env)
     }
 #endif
 
-    __get_user(ss.ss_sp, &uss->ss_sp);
-    __get_user(ss.ss_size, &uss->ss_size);
-    __get_user(ss.ss_flags, &uss->ss_flags);
-
     if (on_sig_stack(get_sp_from_cpustate(env))) {
         return -TARGET_EPERM;
     }
 
-    switch (ss.ss_flags) {
+    switch (ss->ss_flags) {
     default:
         return -TARGET_EINVAL;
 
     case TARGET_SS_DISABLE:
-        ss.ss_size = 0;
-        ss.ss_sp = 0;
+        ss->ss_sp = 0;
+        ss->ss_size = 0;
         break;
 
     case TARGET_SS_ONSTACK:
     case 0:
-        if (ss.ss_size < minstacksize) {
+        if (ss->ss_size < minstacksize) {
             return -TARGET_ENOMEM;
         }
         break;
     }
 
-    ts->sigaltstack_used.ss_sp = ss.ss_sp;
-    ts->sigaltstack_used.ss_size = ss.ss_size;
+    ts->sigaltstack_used.ss_sp = ss->ss_sp;
+    ts->sigaltstack_used.ss_size = ss->ss_size;
     return 0;
 }
 
@@ -1140,11 +1135,17 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr,
 
     if (uss_addr) {
         target_stack_t *uss;
+        target_stack_t ss;
 
         if (!lock_user_struct(VERIFY_READ, uss, uss_addr, 1)) {
             goto out;
         }
-        ret = target_restore_altstack(uss, env);
+        __get_user(ss.ss_sp, &uss->ss_sp);
+        __get_user(ss.ss_size, &uss->ss_size);
+        __get_user(ss.ss_flags, &uss->ss_flags);
+        unlock_user_struct(uss, uss_addr, 0);
+
+        ret = target_restore_altstack(&ss, env);
         if (ret) {
             goto out;
         }
-- 
2.51.0


