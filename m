Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33959CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXhY-0001Nb-S6; Thu, 14 Aug 2025 09:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXhO-0000uE-DS
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:08:54 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXhC-0005yA-Cw
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:08:49 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2445818eb6eso6464095ad.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176920; x=1755781720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SotLYLgeVo+CKYkDdlihGsrrJawGkZPr42hZuKBjr+k=;
 b=DyQvJ0HZe1/BIDPY+w66ShdVbberqsodrCbffej9jlwhrs86bRkM/cCt/ZRf2TgMRp
 SabyI9CPMgRwA6OXsSqYL1Lk4+imeiT31rqN7gyaXUKWvDzaQDz7gJSmi59Uptz0gLrj
 tDTu41lSXdKxCGhS8kSQuGc/AvGWJcXvOOKvcb1S010VCHUunfeCBd/3S4NFajj+8cry
 bRKbLqBnTCdfggPmTVlVOaIWP8ZhBUEOWUZezehlzFNJBV7d7QRyxRToBsJna9Z/XjFQ
 LVRp14p+ah+iB+rAq4U+w1qY/IJQ5NHkqPmPz425fCNDZ8wJKF2PeyGjcWJ0t1YUBY8l
 XhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176920; x=1755781720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SotLYLgeVo+CKYkDdlihGsrrJawGkZPr42hZuKBjr+k=;
 b=IbTcWb7Vv4LM2eACqWhKha2/T7QIB15Pl12lSKhObIa+bkdWx+c2yKCbeMDd8r5Dm1
 2G3lY4QHVhNojDlO7tOhwP1rzlrVJDOroy40Ha0rKoUJ15hRfEKUweoyRyklIGeHtIIw
 luiMsLYTRJLRw/O8jGoUuY3a1f7al2DgSm9pb6lTo21hiUf9QEKWXyFq+njAjkA0VphJ
 O22fBAzAuR+EMvzjv9xtnnhiE9rNWTErKxHK0GzAj+aNMCGkR1lBaopQRVCtAwnuhNnZ
 oukH1UkLbVzgmVLnS404hUVjn+bcfGpvZRzZ9r70h5NmgAwfnmeIqLSMJjEFb7N4zZJR
 1RXA==
X-Gm-Message-State: AOJu0Yy9w6XEd62YmyRHTH2QAwbe1pz0kCiZGsfSsxQGa3PXQDJ5qL0p
 /cAekEEvysPW+1PHtncN1cW/ZHterfrkRDvMwTxFilqCt/okeDCmI8MJpt24EjMFKZfhVNyAl3s
 cbvX92V4=
X-Gm-Gg: ASbGncuitu5Ymgou6Zb9yUJb3t9F8jRyQ2ThMYMmU0Bi2maZT1K9eWdckgBF0jgmMbw
 KkRj+O/AMlO8q3fuxWpue/bz/Ex0CXPEe5CXYqGuDqLCFXTReTl3/XHXj8/T8LnuU7gWnl03Zgh
 5yTdUqeySeK0g0jyrPgwhXZpEvtcngI2PU5n7Arr9DILQC7n6zf303m2+l0LsLjmqWS9L7bXmXD
 uW+OoHuPCHDVMiYKFd7zQBlJk9ub5ttFiSjmD28IV0tkJW3u4QxGHke4oI2BDxZMoUlVuRIf5Hc
 dq4zYGsojzW2k478O/OdW2j3Pk45ZlSiE+XXgnfxWwqJ6HX82m1mPzgiyNRoPqJP6K56yh0vuUt
 3xX5uFBtyPTxNP2uMLToAZYPxJdv8RCZQ+U00Prjnd1+fQG4=
X-Google-Smtp-Source: AGHT+IHPMQ37RESdZkKcbeLTTR+tYZ2/ePRnBdXQSbqyT5zDTKWX9Fg406xDSVLsDgHldxHoMPx3YA==
X-Received: by 2002:a17:903:2c8:b0:243:7cf:9bca with SMTP id
 d9443c01a7336-244586ed222mr38606435ad.55.1755176920293; 
 Thu, 14 Aug 2025 06:08:40 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24304c2943asm64438335ad.30.2025.08.14.06.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:08:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 84/85] tests/tcg/aarch64: Add gcspushm
Date: Thu, 14 Aug 2025 22:57:51 +1000
Message-ID: <20250814125752.164107-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Validate successful and trapped executions of GCSPUSHM, GCSPOPM.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/gcspushm.c      | 71 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 2 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/gcspushm.c

diff --git a/tests/tcg/aarch64/gcspushm.c b/tests/tcg/aarch64/gcspushm.c
new file mode 100644
index 0000000000..c330417a2f
--- /dev/null
+++ b/tests/tcg/aarch64/gcspushm.c
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "gcs.h"
+
+
+#define GCSPUSHM  "sys #3, c7, c7, #0, %[push]"
+#define GCSPOPM   "sysl %[pop], #3, c7, c7, #1"
+
+static void test_sigsegv(int sig, siginfo_t *info, void *vuc)
+{
+    ucontext_t *uc = vuc;
+    uint64_t inst_sigsegv;
+
+    __asm__("adr %0, inst_sigsegv" : "=r"(inst_sigsegv));
+    assert(uc->uc_mcontext.pc == inst_sigsegv);
+    assert(info->si_code == SEGV_CPERR);
+    /* TODO: Dig for ESR and verify syndrome. */
+    uc->uc_mcontext.pc += 4;
+}
+
+static void test_sigill(int sig, siginfo_t *info, void *vuc)
+{
+    ucontext_t *uc = vuc;
+    uint64_t inst_sigill;
+
+    __asm__("adr %0, inst_sigill" : "=r"(inst_sigill));
+    assert(uc->uc_mcontext.pc == inst_sigill);
+    assert(info->si_code == ILL_ILLOPC);
+    uc->uc_mcontext.pc += 4;
+}
+
+int main()
+{
+    struct sigaction sa = { .sa_flags = SA_SIGINFO };
+    uint64_t old, new;
+
+    sa.sa_sigaction = test_sigsegv;
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        exit(1);
+    }
+
+    sa.sa_sigaction = test_sigill;
+    if (sigaction(SIGILL, &sa, NULL) < 0) {
+        perror("sigaction");
+        exit(1);
+    }
+
+    /* Pushm is disabled -- SIGILL via EC_SYSTEMREGISTERTRAP */
+    asm volatile("inst_sigill:\t" GCSPUSHM
+                 : : [push] "r" (1));
+
+    enable_gcs(PR_SHADOW_STACK_PUSH);
+
+    /* Valid value -- low 2 bits clear */
+    old = 0xdeadbeeffeedcaec;
+    asm volatile(GCSPUSHM "\n\t" GCSPOPM
+                 : [pop] "=r" (new)
+                 : [push] "r" (old)
+                 : "memory");
+    assert(old == new);
+
+    /* Invalid value -- SIGSEGV via EC_GCS */
+    asm volatile(GCSPUSHM "\n"
+                 "inst_sigsegv:\t" GCSPOPM
+                 : [pop] "=r" (new)
+                 : [push] "r" (1)
+                 : "memory");
+
+    exit(0);
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 0347a36e8d..c6f401c317 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -76,7 +76,7 @@ $(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
 endif
 
 # GCS Tests
-GCS_TESTS += gcsstr
+GCS_TESTS += gcsstr gcspushm
 AARCH64_TESTS += $(GCS_TESTS)
 $(GCS_TESTS): gcs.h
 
-- 
2.43.0


