Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA68CC6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKai-00057e-Hj; Fri, 29 Mar 2024 18:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKah-000578-6B
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:51 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKaf-0001pg-BU
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:50 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e6b3dc3564so1993113b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711750848; x=1712355648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dondGlVn7Nspk+b15ZO4C68ipaZNt0/1iWHRvOdtfQ=;
 b=OI4rJQbdxIVAbSx4eeo2MEJTvpoQR3eUpSVzIO3au2bpnntTqCb9ra1X0iyT3ossu1
 IFSQF+jXkUTUV0JdlwDLVaY6Dod/hnYZZBFJOehUccd+rbE1wDc2uc3tkcXDWBWS8Vo9
 Y76TVb/cvWsX3tCpVt2GSgG7DPdp2Y+V1ofT+9r824CU/85oAu292AW5u01O5HIrCOKQ
 zxH7Jn5e1g+OsOR2JX7OMLv8MPeeHOksHt2EENdD3u0XhtLgyRAt7BMwcvccP7xtvLTc
 eyNq4p+kDUxmWTm9YITQugMmslJRWOJXd677kH7HN6QMbig8pqn0w1v5UJ56Qf6GTosY
 YN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711750848; x=1712355648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dondGlVn7Nspk+b15ZO4C68ipaZNt0/1iWHRvOdtfQ=;
 b=csePmz6DPygQPAUHSB2NM5EFc44f6sEN8rRARGZ1iNciry6lAIHKBjdE8OKOsQ8CkM
 nU9YfZvScmXFnemQBpb4oCKAP+DFWZm2yrp4KaoVw77x41NgGZQvpP9951UqxybywAqw
 5Gcc5aV6nNLym1uSGA9ymY5JUUCuawWF/ixSw+fu6wlo145mX0ZrUwG+VoebscQimk6T
 H+JtxSZ2T50iwexAb3EdWR4Qm7KqoA3Pxn/iPsjuu5pwFZ+p9FITvyUmkW/eDJ7r73GC
 LNBg/HFJl9l9DorGdTLX7dHngGgqLNTUV+TkaO+KgLSTaCJyvWu3jRGQV4T/pmzMzeyU
 wzXg==
X-Gm-Message-State: AOJu0YyXWW8QDkW81xIwS3++rnf1M5V7NDYwQdlJfu8uxyg0B+KPSAuj
 pFcn09/z4v3cp11hUx8M/Jcmvc88SXCwR4UszIy4dhSM2EB5qB2gaYdrysfl4KqBVMeVWUcTJNw
 Y
X-Google-Smtp-Source: AGHT+IGeX5GRebwui29cyYkcdUNHVjR1I4j0jmsgX5pZdTMA6305JtVxbijAhRVWLgdURj9ED3v/Qg==
X-Received: by 2002:a05:6a00:4fc6:b0:6ea:ab48:5dd9 with SMTP id
 le6-20020a056a004fc600b006eaab485dd9mr3564600pfb.6.1711750847953; 
 Fri, 29 Mar 2024 15:20:47 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 lc24-20020a056a004f5800b006eaacc63435sm3579811pfb.173.2024.03.29.15.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:20:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/7] tcg/optimize: Fix sign_mask for logical right-shift
Date: Fri, 29 Mar 2024 12:20:35 -1000
Message-Id: <20240329222037.1735350-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329222037.1735350-1-richard.henderson@linaro.org>
References: <20240329222037.1735350-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The 'sign' computation is attempting to locate the sign bit that has
been repeated, so that we can test if that bit is known zero.  That
computation can be zero if there are no known sign repetitions.

Cc: qemu-stable@nongnu.org
Fixes: 93a967fbb57 ("tcg/optimize: Propagate sign info for shifting")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2248
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/optimize.c                    |  2 +-
 tests/tcg/aarch64/test-2248.c     | 28 ++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  1 +
 3 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/test-2248.c

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 752cc5c56b..275db77b42 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2376,7 +2376,7 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
          * will not reduced the number of input sign repetitions.
          */
         sign = (s_mask & -s_mask) >> 1;
-        if (!(z_mask & sign)) {
+        if (sign && !(z_mask & sign)) {
             ctx->s_mask = s_mask;
         }
         break;
diff --git a/tests/tcg/aarch64/test-2248.c b/tests/tcg/aarch64/test-2248.c
new file mode 100644
index 0000000000..aac2e17836
--- /dev/null
+++ b/tests/tcg/aarch64/test-2248.c
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* See https://gitlab.com/qemu-project/qemu/-/issues/2248 */
+
+#include <assert.h>
+
+__attribute__((noinline))
+long test(long x, long y, long sh)
+{
+    long r;
+    asm("cmp   %1, %2\n\t"
+        "cset  x12, lt\n\t"
+        "and   w11, w12, #0xff\n\t"
+        "cmp   w11, #0\n\t"
+        "csetm x14, ne\n\t"
+        "lsr   x13, x14, %3\n\t"
+        "sxtb  %0, w13"
+        : "=r"(r)
+        : "r"(x), "r"(y), "r"(sh)
+        : "x11", "x12", "x13", "x14");
+    return r;
+}
+
+int main()
+{
+    long r = test(0, 1, 2);
+    assert(r == -1);
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index ea3e232e65..0efd565f05 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -10,6 +10,7 @@ VPATH 		+= $(AARCH64_SRC)
 
 # Base architecture tests
 AARCH64_TESTS=fcvt pcalign-a64 lse2-fault
+AARCH64_TESTS += test-2248
 
 fcvt: LDFLAGS+=-lm
 
-- 
2.34.1


