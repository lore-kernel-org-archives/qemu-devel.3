Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0280C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDPB-0003cN-55; Sun, 11 May 2025 16:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP7-0003ab-Dz
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:09 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP5-0006NM-IT
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:09 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-af5085f7861so2548131a12.3
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995766; x=1747600566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhebvcCenIsTy/MycdkDWsoVv1Q1HWhIQtMjE6FLOCY=;
 b=h8UOBEdzvgbykOyvd8zIkA1bLFdmEUA4Qx9Aq8D0IIxIsmSuLa5Ck+CAx20BJaGHRx
 PzJWXMAwpoYL3tttTHwBMCuIQyhkPnKydi3FSa6ufRzdPIG0/u4AlUW931+BJp0PSlwq
 EPSKjnM1+EWMXUwEbbWwO2PvPKEeLC4cOCKd/aWUcUSRslyt/yIwtg0TlUMnu9O5nfle
 p1fklaS2jjAZ4Yf6sCYKhev/E7t/cr8P3kkBw85ydIk5A5eVPRqU08NpBwgipj6SUDNz
 ZK9AuV8f9IkP9nHPKAkY0nHAfEWlTyDr6FOxQZMzcus1vAX6PWQS4IxesRWihGGxVaoJ
 CbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995766; x=1747600566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhebvcCenIsTy/MycdkDWsoVv1Q1HWhIQtMjE6FLOCY=;
 b=dXjjstUrmF3iIxFV0ziZCirzunz/nzxoPxwPOTw96QpvTZTf4qKRjlWz3Lx+/z4dTT
 ZK9dWGwLrhCA1CM3x9MfokN8pyxPB92rnfXZDFJZOg4N8bdqb2nwUd60V/nvPQ4f1LzY
 fSy+rCWMWJsZNbMmOkHg6i6VdeUoDZorXjKlBqaSPIdK8C14YmWGPXBNxgzSzb74b7D3
 DR0aPZqX0d1sH/+4ylWLNVVYvEwqvf4hTj8zgRoJBgU+XzxFqOs1+rX3wN53JmV2m3h8
 KaT5oeSGCKJneown5/rB+HkamUmZOGjFNialprKdA/VJGAuLryvMdcYt+ozGbkR2XqoX
 U9IQ==
X-Gm-Message-State: AOJu0YyopIy561XnmZsLHV2vi/uKxqnSYHk9/qJOUKFZVabMWCskasF9
 N0YFyFbVlDbkSWRpXdk58TmS4/XDMB8yvzTJaoEBWHSlwpdbnqPbF0N8H/4kZ9gDWYNmhBFkZcr
 u
X-Gm-Gg: ASbGnctksRDg6TEp2VUgOKoQJfw4HisYbARPhSETr4gX9j3czca6S7smMOhPOx/zjMr
 6kF0YNP0Kg/3/vYs0vwmN+4/1wMnMFaqSNSh4FkoUsLwHsUF1A4yuYAXtGo9n+VeQjDNCLmy0Ho
 y8KFwywGCObDKjNfhhb0L9CdnS1mpP/VlB2F6fvgkYPs3RZoJXrO5OyFI8UXTl0NoYyFdZNDc1I
 0J0jhqfIvbrlNxLoEGYvJ2PjY8pILlmvONjTpAqmPTzk6hJaVwt0qycVDc8t+OTa8TE/DH9SZ8V
 SDkofNjGL/HmX1WSdFr0JXY1TiEml1aFdzSjhT7ytWgKcAmIFjEjwqH/b8WkP2ZVjHfCJvxf6uy
 glGajgVoonw==
X-Google-Smtp-Source: AGHT+IGH/eGN3QMC/RCqr1DvkezM8IZEvEi5zlilgs4II5Ta0DVItCz0+PtHKm4rQ5gl0hUg+tVBYA==
X-Received: by 2002:a17:903:2349:b0:224:10a2:cae7 with SMTP id
 d9443c01a7336-22fc8e95bf0mr178894245ad.40.1746995766149; 
 Sun, 11 May 2025 13:36:06 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:36:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 22/24] tests/tcg/m68k: Add packed decimal tests
Date: Sun, 11 May 2025 13:35:44 -0700
Message-ID: <20250511203546.139788-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
 tests/tcg/m68k/packeddecimal-1.c | 46 ++++++++++++++++++++++++++
 tests/tcg/m68k/packeddecimal-2.c | 55 ++++++++++++++++++++++++++++++++
 tests/tcg/m68k/Makefile.target   |  4 ++-
 3 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/m68k/packeddecimal-1.c
 create mode 100644 tests/tcg/m68k/packeddecimal-2.c

diff --git a/tests/tcg/m68k/packeddecimal-1.c b/tests/tcg/m68k/packeddecimal-1.c
new file mode 100644
index 0000000000..cd5759fff7
--- /dev/null
+++ b/tests/tcg/m68k/packeddecimal-1.c
@@ -0,0 +1,46 @@
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
+#define PDR(SMEY, EXP, INT, M1, M2) \
+    { (0b##SMEY << 28) | (0x##EXP << 16) | INT, 0x##M1, 0x##M2 }
+
+static const struct T tests[] = {
+    { PDR(0000, 000, 1, 00000000, 00000000), 1.0e0l },
+    { PDR(0000, 001, 1, 00000000, 00000000), 1.0e1l },
+    { PDR(0000, 010, 1, 00000000, 00000000), 1.0e10l },
+    { PDR(0000, 000, 0, 10000000, 00000000), 0.1e0l },
+    { PDR(0100, 001, 1, 00000000, 00000000), 1.0e-1l },
+    { PDR(1000, 005, 5, 55550000, 00000000), -5.5555e5l },
+    { PDR(0000, 999, 9, 99999999, 99999999), 9.9999999999999999e999l },
+    { PDR(0000, 123, 1, 23456789, 12345678), 1.2345678912345678e123l },
+    { PDR(0000, 000, 0, 00000000, 00000000), 0.0l },
+    { PDR(1000, 000, 0, 00000000, 00000000), -0.0l },
+    { PDR(0000, 999, 0, 00000000, 00000000), 0.0e999l },
+    { PDR(0111, FFF, 0, 00000000, 00000000), __builtin_infl() },
+    { PDR(1111, FFF, 0, 00000000, 00000000), -__builtin_infl() },
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
index 0000000000..5b956440bc
--- /dev/null
+++ b/tests/tcg/m68k/packeddecimal-2.c
@@ -0,0 +1,55 @@
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
+#define PDR(SMEY, EXP, I, M1, M2) \
+    { (0b##SMEY << 28) | ((0x##EXP & 0xfff) << 16) | (0x##EXP & 0xf000) | I, \
+      0x##M1, 0x##M2 }
+
+static const struct T tests[] = {
+    { PDR(0000, 0000, 1, 00000000, 00000000), 1.0e0l, 0 },
+    { PDR(0000, 0010, 1, 00000000, 00000000), 1.0e10l, 0 },
+    { PDR(0100, 0001, 1, 00000000, 00000000), 1.0e-1l, 0 },
+    { PDR(1000, 0005, 5, 55550000, 00000000), -5.5555e5l, 5 },
+    { PDR(0100, 0005, 5, 55550000, 00000000), 5.5555e-5l, 5 },
+    { PDR(0000, 0005, 2, 22222222, 22222222), 2.2222222222222222e5l, 17 },
+    { PDR(0000, 0005, 2, 22220000, 00000000), 2.2222222222222222e5l, 5 },
+    { PDR(0000, 0005, 2, 20000000, 00000000), 2.2222222222222222e5l, 2 },
+    { PDR(0000, 0005, 6, 66670000, 00000000), 6.6666666666666666e5l, 5 },
+    { PDR(0000, 4932, 1, 18973149, 53572318), LDBL_MAX, 17 },
+    { PDR(0100, 4932, 1, 68105157, 15560468), LDBL_MIN, 17 },
+    { PDR(0100, 4951, 1, 82259976, 59412373), LDBL_TRUE_MIN, 17 },
+    { PDR(0000, 0000, 0, 00000000, 00000000), 0.0l },
+    { PDR(1000, 0000, 0, 00000000, 00000000), -0.0l },
+    { PDR(0111, 0FFF, 0, 00000000, 00000000), __builtin_infl() },
+    { PDR(1111, 0FFF, 0, 00000000, 00000000), -__builtin_infl() },
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


