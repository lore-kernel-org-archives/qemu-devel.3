Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D724D68BD5
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 21:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3PC-0007Wc-8c; Fri, 15 Nov 2024 15:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P8-0007Vf-W5
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:58:59 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P7-0004NG-7h
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:58:58 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ea08667b23so1813523a91.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704336; x=1732309136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQ2OtP14Y6YgrVCa1qLJ59lo8Li0ZXwEANDkZj5mi5k=;
 b=a/dFTf/hFe+csNMZdAvRLxuZY4xiI6QByn/LZEfp8Q4pp35EdeBV+K83Y5+INiW9d0
 hvERvJBvzD3PHz+MGkimOPS6qiWkjBU6Hb4PhPoNd7XP+psC/sqJHKyko3CQebOHi2QA
 MYcDOgpKBgK6egxt/2u285LUE6PA7YRmsGFdzHpH7yjZK0AmeEOGX3S4Sosxh+8anaFB
 90qDLFVRCWyyoBPTEx1js+NSJO4ZgPct5/e7Yf1lAFyV6+gmyInTX1NLKH0rkwcUp4qm
 pn+HMvV9TXpC8zYn4c303NWvlEVoRY8INK7ub5jHex141w/QL1ZmbjX7wsV2GLXk+UcC
 Gr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704336; x=1732309136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQ2OtP14Y6YgrVCa1qLJ59lo8Li0ZXwEANDkZj5mi5k=;
 b=DjkkD8YDSGqavlhGqRd/ube7SUtl+vKb80PCQ/OfPNe3Qtdq8cnD1puKqpOKBUqvpl
 lGbFL6Cg5FIt3yPNoTtiyah/TO3dEM8itOFyz6+uYuqpzb+nDbF/30OIDklM4iLz8qiZ
 4yCunSVrB3rIlsATiMJcDYTguHgPJwF0i/ch9r194hYQAI+tamo2G2DU3BEGgLWHuRmE
 mqLXR9JslgHr6mPCttx0+8lNPSkEh08M1Eqxt5n6/4kQH8pG6sqsjDr4Jsfdpv3P2nf+
 nZLefzY+kRk73tZLQFf7kmLly5M3TNnvA56jJ3DEiWy7bBvSGUkEls9Rk0l+0s9iLVYD
 N9aA==
X-Gm-Message-State: AOJu0YwEM0MEKelv6AyeqHw2VVD2OXfGODaCHt9GhlyGCHpAAQOTN6oi
 5Icoi5ZN2OQZaeNVYDCoM+0uNJBLlncQXWHffr0KnClyjIrJhenAVRt7peesAdrSz2bhKOr3zG8
 w
X-Google-Smtp-Source: AGHT+IHfrFOavw5vCQVaYJWP26JW53q7bEk5KttzooPPBU4uBif8zb3pMzPenRREomjmPiJWBsNO+A==
X-Received: by 2002:a17:90b:4c84:b0:2e2:a097:bb02 with SMTP id
 98e67ed59e1d1-2ea154f5eabmr4577431a91.11.1731704335638; 
 Fri, 15 Nov 2024 12:58:55 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a49a8sm3362274a91.23.2024.11.15.12.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:58:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 04/14] tests/tcg: Test that sigreturn() does not corrupt the
 signal mask
Date: Fri, 15 Nov 2024 12:58:39 -0800
Message-ID: <20241115205849.266094-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115205849.266094-1-richard.henderson@linaro.org>
References: <20241115205849.266094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20241108145237.37377-2-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/sigreturn-sigmask.c | 51 +++++++++++++++++++++++++
 tests/tcg/multiarch/Makefile.target     |  3 ++
 2 files changed, 54 insertions(+)
 create mode 100644 tests/tcg/multiarch/sigreturn-sigmask.c

diff --git a/tests/tcg/multiarch/sigreturn-sigmask.c b/tests/tcg/multiarch/sigreturn-sigmask.c
new file mode 100644
index 0000000000..e6cc904898
--- /dev/null
+++ b/tests/tcg/multiarch/sigreturn-sigmask.c
@@ -0,0 +1,51 @@
+/*
+ * Test that sigreturn() does not corrupt the signal mask.
+ * Block SIGUSR2 and handle SIGUSR1.
+ * Then sigwait() SIGUSR2, which relies on it remaining blocked.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+int seen_sig = -1;
+
+static void signal_func(int sig)
+{
+    seen_sig = sig;
+}
+
+static void *thread_func(void *arg)
+{
+    kill(getpid(), SIGUSR2);
+    return NULL;
+}
+
+int main(void)
+{
+    struct sigaction act = {
+        .sa_handler = signal_func,
+    };
+    pthread_t thread;
+    sigset_t set;
+    int sig;
+
+    assert(sigaction(SIGUSR1, &act, NULL) == 0);
+
+    assert(sigemptyset(&set) == 0);
+    assert(sigaddset(&set, SIGUSR2) == 0);
+    assert(sigprocmask(SIG_BLOCK, &set, NULL) == 0);
+
+    kill(getpid(), SIGUSR1);
+    assert(seen_sig == SIGUSR1);
+
+    assert(pthread_create(&thread, NULL, thread_func, NULL) == 0);
+    assert(sigwait(&set, &sig) == 0);
+    assert(sig == SIGUSR2);
+    assert(pthread_join(thread, NULL) == 0);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 78b83d5575..18d3cf4ae0 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -42,6 +42,9 @@ munmap-pthread: LDFLAGS+=-pthread
 vma-pthread: CFLAGS+=-pthread
 vma-pthread: LDFLAGS+=-pthread
 
+sigreturn-sigmask: CFLAGS+=-pthread
+sigreturn-sigmask: LDFLAGS+=-pthread
+
 # The vma-pthread seems very sensitive on gitlab and we currently
 # don't know if its exposing a real bug or the test is flaky.
 ifneq ($(GITLAB_CI),)
-- 
2.43.0


