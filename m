Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A6EC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWSc-0008N2-JB; Mon, 10 Feb 2025 11:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWRD-0004U9-AG
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:14 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWRB-0001YO-6y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:10 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5de47cf9329so5406379a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204106; x=1739808906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LwehABNpz+elHyUtu6V8SdPZXAtvSq5keb1F8SzdXM=;
 b=D2d6BZ7hD6gYCrk/Cz+T6xy3mO5H1wOofwV5xkMyuZUi7fhPUg0MD23H3fOo4BowTb
 7nIBdHC5D+PkISjymsKThnELhJpwnA9Hyw6lUcqWXWfclJKPM0tibaIdoOneySzF6VYL
 D99jEMAEci3RREB8TEwhKusB/QJnjj4gC4dtugjMIW34XfeFmttQsyk3IMNyJobkPXNB
 LnZU6EUoqE52iT8kf9x12knGQSPeVGer1E/UwlPOkLHjbtT8BkxiUH34wC6tf+VJrqxJ
 o0RfLD5CkcJ/IpQYbfwBHCSJro6LMHQ+qOyNihjr0Ul/7jpxwUjPm6/Fc0khVbFtfA5J
 1q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204106; x=1739808906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2LwehABNpz+elHyUtu6V8SdPZXAtvSq5keb1F8SzdXM=;
 b=ThfanZYauaOFLPO2NYormwuWeEZSBaF2NjIxnHJ/3koTw7XuG5AI6wY3UMDVb7FGu0
 FISh/IzjpHlgimB9+zjbcGsucn6UR9aGSOFv8qxE94VUi9zjvpAUDX+BEfVE7n1yiHjQ
 TklMp6VWsnPmvgsbzaT9fejvYzHCba3/2wn0gFkUABLeZzucmqjZtJhkX8LIBvkT1vUO
 G201kn8XLKReetZpf7DBg9T9jb6bmRDHGgN/wHP3ki9WJCO6htQovplGk85tljJvdyiF
 ReVX7EsJ74AuvqvebhUUPDI9BF/KV6KhWkRU5jYxRjF6uRF3KkwU8pNcb1HT6L6Gl1So
 KNjw==
X-Gm-Message-State: AOJu0Yzn9w/uxL1Juh1oJMED/5dMUl2vIG8OocLEUnrECvjAESN8Elme
 +/SLqqKOhGbDTeiulBeA1xgFbH619Jeyvv44t1pvysKxeDmlCiZLn/TY8AFgxo4=
X-Gm-Gg: ASbGncufk4dPE9g3btMt2GQpuE6JrcLOTHtSu5NrMMhNhgRroyMmf5wHNlWxz0gUdpw
 AM/vAVmYQRVOg4n3iIaENzpvNPCL0Ur3xRxRfe0aa9Xupf0j4Xw4wo6DXpjxcCSQmmPEmqbZ07/
 w143YjswF1YkddgY1l0Y4iV96e9HsVbGzWtW9i1PGIBEaxv/1zlRVFMlcmRdquKIsTcUiVJv2Qe
 dAnJc37GxIc3itjUl3eifTi0FivACn0XAgnHPtCdGc9UmfS/NwiKVlRbpPpxdTV2E4YgSjwBgbt
 J4pqksfBxApz6YE0zg==
X-Google-Smtp-Source: AGHT+IFOwSSx7A2I4US7tcl8+SmC6mwVYsew2ms96Muhvxz4xciy4wJngym67uJ3E2Mr17d6Tu5RtQ==
X-Received: by 2002:a05:6402:358e:b0:5db:731d:4456 with SMTP id
 4fb4d7f45d1cf-5de9a4c86cbmr248743a12.28.1739204106312; 
 Mon, 10 Feb 2025 08:15:06 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de5ef7029asm4934287a12.58.2025.02.10.08.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:15:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E0D096037E;
 Mon, 10 Feb 2025 16:14:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 12/17] user: Introduce user/signal.h
Date: Mon, 10 Feb 2025 16:14:46 +0000
Message-Id: <20250210161451.3273284-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

gdbstub needs target_to_host_signal(), so move its declaration to a
public header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20250117001542.8290-4-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207153112.3939799-13-alex.bennee@linaro.org>

diff --git a/bsd-user/signal-common.h b/bsd-user/signal-common.h
index 77d7c7a78b..4e634e04a3 100644
--- a/bsd-user/signal-common.h
+++ b/bsd-user/signal-common.h
@@ -42,7 +42,6 @@ void process_pending_signals(CPUArchState *env);
 void queue_signal(CPUArchState *env, int sig, int si_type,
                   target_siginfo_t *info);
 void signal_init(void);
-int target_to_host_signal(int sig);
 void target_to_host_sigset(sigset_t *d, const target_sigset_t *s);
 
 /*
diff --git a/include/user/signal.h b/include/user/signal.h
new file mode 100644
index 0000000000..19b6b9e5dd
--- /dev/null
+++ b/include/user/signal.h
@@ -0,0 +1,23 @@
+/*
+ * Signal-related declarations.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef USER_SIGNAL_H
+#define USER_SIGNAL_H
+
+#ifndef CONFIG_USER_ONLY
+#error Cannot include this header from system emulation
+#endif
+
+/**
+ * target_to_host_signal:
+ * @sig: target signal.
+ *
+ * On success, return the host signal between 0 (inclusive) and NSIG
+ * (exclusive) corresponding to the target signal @sig. Return any other value
+ * on failure.
+ */
+int target_to_host_signal(int sig);
+
+#endif
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index 8584d9ecc2..196d2406f8 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -61,7 +61,6 @@ void queue_signal(CPUArchState *env, int sig, int si_type,
                   target_siginfo_t *info);
 void host_to_target_siginfo(target_siginfo_t *tinfo, const siginfo_t *info);
 void target_to_host_siginfo(siginfo_t *info, const target_siginfo_t *tinfo);
-int target_to_host_signal(int sig);
 int host_to_target_signal(int sig);
 long do_sigreturn(CPUArchState *env);
 long do_rt_sigreturn(CPUArchState *env);
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index b4e1458237..8c51f6ce65 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -24,6 +24,7 @@
 #include "user/cpu_loop.h"
 #include "exec/page-protection.h"
 #include "user/page-protection.h"
+#include "user/signal.h"
 #include "user/tswap-target.h"
 #include "gdbstub/user.h"
 #include "signal-common.h"
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 087c4d270e..bffbef235c 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -36,6 +36,7 @@
 #include "user/cpu_loop.h"
 #include "user/page-protection.h"
 #include "user/safe-syscall.h"
+#include "user/signal.h"
 #include "tcg/tcg.h"
 
 /* target_siginfo_t must fit in gdbstub's siginfo save area. */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6ee02383da..90afaa4426 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -138,6 +138,7 @@
 #include "user-mmap.h"
 #include "user/page-protection.h"
 #include "user/safe-syscall.h"
+#include "user/signal.h"
 #include "qemu/guest-random.h"
 #include "qemu/selfmap.h"
 #include "user/syscall-trace.h"
-- 
2.39.5


