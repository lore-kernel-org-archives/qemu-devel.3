Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A213EC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texdg-0003x4-Dq; Mon, 03 Feb 2025 09:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdV-0003jf-KM
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:18 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdF-0002RV-53
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:17 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ab2aea81cd8so804170766b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738593659; x=1739198459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ss1s/z8UDnfCDTK92VTNTdO4MGHnAPeMCWUHdvvh61s=;
 b=DbSFy5BJSGk1sOPzs6PdLDs66WCZqVowkG5tqGqmpwLzzLD45pn0Pq3+UTbwqLhhx3
 Qq1VJX5MOkYyuV+5slr2vUCLj0qPIqMckhPjdc0A3gvZqsvF5r+yjbYlbx9M8KP5uEeP
 uVvRQU7wm8ZIvzHvltWccd7scYeJXtZf7Mxh73erhOf9o4kvEmBs/vZDAyW8i5ZZc1dZ
 B/TzJlAf1BceBfxg/YOJvFDpq1bFei1ox7/FNW/5TjVXViZRNHnpV2IA+ochi24bGxRX
 4mWe4yvOhfAZ6LS1KFCHbF1ENrvPP4x2/Rr4CYTcLSjUMQ8pbqNdZmDW7KaAfzEdKXuh
 b0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738593659; x=1739198459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ss1s/z8UDnfCDTK92VTNTdO4MGHnAPeMCWUHdvvh61s=;
 b=t+rh0gCABALKjCHRiE7uHQfRFAENWvao2zRY3JbQ7Fn0AftONRkWk/o6fF+Blk5dsg
 lS249d1iYNM9PH4PRzsyELuHS0pdY9pB+DRagFxrN9LlOYnWKMTeUyeBdVWI6lBXkuyQ
 US/Iu4Fz80Nh/ybuLAmEfcuChVs9NGe72X4ppzKxbj83Th8mUN8zLHunycfrxgYx4Iub
 10Nlub1vHcXSKLro+QKwo+QXdaYOwcxfdE7vBRqUDUK+tXN2cOwvo7cLrXrMBN68jtDZ
 ujLgm4d9vrZByWc9sAVqhl8cFaJ0Nhf/zr+nMUs07zmcEwofviuS+J/434Ar7SZirdjT
 6jHQ==
X-Gm-Message-State: AOJu0Yy8E6YEZ6+OhxhNqKB+IQpmFIjp0FDipKpySbuPYqECU0+ez9cb
 s8kMNaAQJXUryJPBPuUs3Fv46BjtVmunAqQEn/lSfMvPJrBJkuk8GPScbTAEDH8=
X-Gm-Gg: ASbGncu4deYZK9Kf+Xegc3bYOlFfgp+s4Z2PkiON1tPtbRAsAoX0gqu3mFJDSvGbx1r
 9nCsx9rFF7dE0IwnoOi6lKgAxVmCQNf+CI02XbxrbyjeGdkoFIRXGWauLM888UZtDSkF/4IclyS
 lI8hCbH0/uiAff+agHu6KenGUf+WFtwCFDMn3hiKTXr6NMPf1qWX9LuADkFD/UCBsMq4LwyFXxi
 jkak5IRpVv/LSyh7Y30Z0jeKrTzhTvBk9pIR14Wgddn0UcGd8d2H0WB32vseJTkLO/+88XtLjuJ
 1iRQ9iAjW7mOXrgxSw==
X-Google-Smtp-Source: AGHT+IGLhAFbzQY2pFe/kg0025PEjjmxOgO9AynPb22U4Zw0Hsiysc+IvnDM1lEEoIfJjXLYZF0q2A==
X-Received: by 2002:a17:907:9452:b0:ab6:f99f:45e0 with SMTP id
 a640c23a62f3a-ab6f99f5410mr1861994166b.37.1738593659460; 
 Mon, 03 Feb 2025 06:40:59 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a5a26bsm762985066b.183.2025.02.03.06.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:40:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D836C6099F;
 Mon,  3 Feb 2025 14:40:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hao Wu <wuhaotsh@google.com>, Peter Xu <peterx@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-rust@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 12/18] user: Introduce user/signal.h
Date: Mon,  3 Feb 2025 14:40:42 +0000
Message-Id: <20250203144048.2131117-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203144048.2131117-1-alex.bennee@linaro.org>
References: <20250203144048.2131117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 bsd-user/signal-common.h   |  1 -
 include/user/signal.h      | 23 +++++++++++++++++++++++
 linux-user/signal-common.h |  1 -
 bsd-user/signal.c          |  1 +
 linux-user/signal.c        |  1 +
 linux-user/syscall.c       |  1 +
 6 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 include/user/signal.h

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


