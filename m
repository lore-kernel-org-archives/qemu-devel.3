Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB009C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm5Q-0006Il-7W; Wed, 07 May 2025 17:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4y-0006Cv-F7
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:26 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4w-0006Fj-GG
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so407501b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652401; x=1747257201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJE3DAs7T3oH0GbJsFZTv8MmDA7pEO0/Bzfp6DqKShg=;
 b=A9Srlu3MhpKR+BqQ3Mbm3gIq9invYhAc7O5MseK8DQcMUgc8TBsR4cZpmHbKEaw9dz
 8gZs8RpgHBW/UhjuaZ9KkjCQY03XZD4V0PD1vD+t0CE+DU5umYmxLo4WiJtrSjuGxGvE
 uEviZX8sA/6jd3CWL1Fq5zXG924nmY67cWQCnYq3C5GcrHzB+r965dIpzPUk1PxVnXNi
 CqtPCK9C9GDfuBJCU/LFfKGCL6QBIr3tv4BNLAAkGz/6un6xUjeOpBR5P6YDz3elbMOq
 5vieAp+2py47Y9GGo/sl4mRni5jJqa9oKYUDMpmnm+XWsKcS0zzwSpWq5nhmzWHKt6h+
 U/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652401; x=1747257201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJE3DAs7T3oH0GbJsFZTv8MmDA7pEO0/Bzfp6DqKShg=;
 b=EfvEGWHTQTpYUwMopq9a2zytpQXlONR8t/Qfn5JgFQmsyFnhYuADAQ2IyZL4W1JI3F
 XHPqN2FR/wJyWRIVPwM1IQRhJ85rx7uZXELKBgsRhc6HPVZ0JK6m6BcW743SfnqKMFyk
 wueJ4KQETnTIJZpcMqodlNmaFe8W/ypv5H18P1aqqnRp8DPauCbPUVmtgkI5Pq+7rg4j
 RKvrkLVQXePsPx7ZG72fZWsj+4FXuojyv1ffsOjakclOqITRZbuMTO38P3pukyyhX4UL
 I8K481vpU2YLE5jBXongo1Gumj0ghBc5pCzS2wtMoKlSHFbEGJertYcEkquBaIABLFrD
 F9jg==
X-Gm-Message-State: AOJu0Ywmr8Xd7Xy0O5yEwYbKqnruJ9xAnlGkDyQRvIrKw/1kD3DDCKUP
 s2wCJB3D3tidXsp7tnzN8SQh/hBHoaRpF9Gs7i3GxHZ7WyRgKo3sgB7i9fxOjLu1/eS2/Ipdh5z
 P
X-Gm-Gg: ASbGncsmkjsCysun0E4u48zKtizxDTvzSsRpmbD1LwLt48jo/DI1QU2XC5btzo9SHtW
 IPJrdAp16CBJCaFEhAQhgcLgpN9JWbwqLxR3/1wzdopGuDpRI+pCLZ86RZ0xRGzBg5Z1aS6o0+M
 DGgrv9E2bOTpyjQhklzfuMZN+IBGkv3F8T48S6Kki6sTDFgpsgSfJxve4oOnQaF8jA/68l6Crpb
 IsIOP6ZUGOhWSZcbVP5Sw0jYvqTt7N4tWCXB/3t/it0ABsT2rOhfnteOYUhyMBiUUcsGzgtCjDB
 g+UiUfEzA9kEL6LZHQUhJtxZjjPX5UjjvedUu7SF+ynnIaam1SCgpvh28xer0l10EYrH8Pgkp08
 =
X-Google-Smtp-Source: AGHT+IEeHpmEzlwIwWL+69tumMFd7hPCdKB7fXdk/h/SsRk5+z/J8qXHZ28CQ6PWMjxccj6sh0Gn3g==
X-Received: by 2002:a05:6a20:c991:b0:1ee:d8c8:4b82 with SMTP id
 adf61e73a8af0-2148d31217cmr7404062637.31.1746652401037; 
 Wed, 07 May 2025 14:13:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 22/24] tests/tcg/m68k: Add packed decimal tests
Date: Wed,  7 May 2025 14:12:57 -0700
Message-ID: <20250507211300.9735-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/m68k/packeddecimal-1.c | 41 ++++++++++++++++++++++++++++
 tests/tcg/m68k/packeddecimal-2.c | 46 ++++++++++++++++++++++++++++++++
 tests/tcg/m68k/Makefile.target   |  4 ++-
 3 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/m68k/packeddecimal-1.c
 create mode 100644 tests/tcg/m68k/packeddecimal-2.c

diff --git a/tests/tcg/m68k/packeddecimal-1.c b/tests/tcg/m68k/packeddecimal-1.c
new file mode 100644
index 0000000000..5433acd17b
--- /dev/null
+++ b/tests/tcg/m68k/packeddecimal-1.c
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Test packed decimal real conversion to long double. */
+
+#include <stdio.h>
+
+struct T {
+    unsigned int d[3];
+    long double f;
+};
+
+static const struct T tests[] = {
+    { { 0x00000001, 0x00000000, 0x00000000 }, 1.0e0l },
+    { { 0x01000001, 0x00000000, 0x00000000 }, 1.0e1l },
+    { { 0x00100001, 0x00000000, 0x00000000 }, 1.0e10l },
+    { { 0x00000000, 0x10000000, 0x00000000 }, 0.1e0l },
+    { { 0x41000001, 0x00000000, 0x00000000 }, 1.0e-1l },
+    { { 0x85000005, 0x55550000, 0x00000000 }, -5.5555e5l },
+    { { 0x09990009, 0x99999999, 0x99999999 }, 9.9999999999999999e999l },
+    { { 0x03210001, 0x23456789, 0x12345678 }, 1.2345678912345678e123l },
+    { { 0x00000000, 0x00000000, 0x00000000 }, 0.0l },
+    { { 0x80000000, 0x00000000, 0x00000000 }, -0.0l },
+    { { 0x09990000, 0x00000000, 0x00000000 }, 0.0e999l },
+};
+
+int main()
+{
+    int ret = 0;
+
+    for (int i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+        const struct T *t = &tests[i];
+        long double f;
+
+        asm("fmove.p (%1),%0" : "=f"(f) : "a"(t->d));
+
+        if (f != t->f) {
+            fprintf(stderr, "Mismatch at %d: %.17Le != %.17Le\n", i, f, t->f);
+            ret = 1;
+        }
+    }
+    return ret;
+}
diff --git a/tests/tcg/m68k/packeddecimal-2.c b/tests/tcg/m68k/packeddecimal-2.c
new file mode 100644
index 0000000000..448e97ce89
--- /dev/null
+++ b/tests/tcg/m68k/packeddecimal-2.c
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Test packed decimal real conversion from long double, dynamic k-factor */
+
+#include <stdio.h>
+#include <float.h>
+
+struct T {
+    unsigned int d[3];
+    long double lf;
+    int kfactor;
+};
+
+static const struct T tests[] = {
+    { { 0x00000001, 0x00000000, 0x00000000 }, 1.0e0l, 0 },
+    { { 0x00100001, 0x00000000, 0x00000000 }, 1.0e10l, 0 },
+    { { 0x41000001, 0x00000000, 0x00000000 }, 1.0e-1l, 0 },
+    { { 0x85000005, 0x55550000, 0x00000000 }, -5.5555e5l, 5 },
+    { { 0x45000005, 0x55550000, 0x00000000 }, 5.5555e-5l, 5 },
+    { { 0x05000002, 0x22220000, 0x00000000 }, 2.2222e5, 99 },
+    { { 0x05000002, 0x22220000, 0x00000000 }, 2.2222e5, 5 },
+    { { 0x05000002, 0x20000000, 0x00000000 }, 2.2222e5, 2 },
+    { { 0x02394001, 0x18973149, 0x53572318 }, LDBL_MAX, 17 },
+    { { 0x42394001, 0x68105157, 0x15560468 }, LDBL_MIN, 17 },
+    { { 0x41594001, 0x82259976, 0x59412373 }, LDBL_TRUE_MIN, 17 },
+};
+
+int main()
+{
+    int ret = 0;
+
+    for (int i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+        const struct T *t = &tests[i];
+        unsigned int out[3];
+
+        asm("fmove.p %1,(%0),%2"
+            : : "a"(out), "f"(t->lf), "d"(t->kfactor) : "memory");
+
+        if (out[0] != t->d[0] || out[1] != t->d[1] || out[2] != t->d[2]) {
+            fprintf(stderr, "Mismatch at %d: %08x%08x%08x != %08x%08x%08x\n",
+                    i, out[0], out[1], out[2],
+                    t->d[0], t->d[1], t->d[2]);
+            ret = 1;
+        }
+    }
+    return ret;
+}
diff --git a/tests/tcg/m68k/Makefile.target b/tests/tcg/m68k/Makefile.target
index 33f7b1b127..b505260b79 100644
--- a/tests/tcg/m68k/Makefile.target
+++ b/tests/tcg/m68k/Makefile.target
@@ -4,4 +4,6 @@
 #
 
 VPATH += $(SRC_PATH)/tests/tcg/m68k
-TESTS += trap denormal
+TESTS += trap denormal packeddecimal-1 packeddecimal-2
+
+run-packeddecimal-%: QEMU_OPTS += -cpu m68020
-- 
2.43.0


