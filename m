Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64676ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniC9-0005q4-A9; Mon, 09 Sep 2024 13:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniC4-0005K2-29
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:52 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniC2-00064k-Br
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:51 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2055136b612so55186765ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902928; x=1726507728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJE3DAs7T3oH0GbJsFZTv8MmDA7pEO0/Bzfp6DqKShg=;
 b=BYDooAgt3WoJOXtetuCfHdnbbpYQep5CtShOaoZPfk8lIs3Lfql9miWvZDF80akOuI
 E7oT38XB44KtHUpiTeGmlFlNghdGQ8prILUHk8FArQLUksA4H8oKY0s7HgwyOnXNtMG4
 +HDJxdOomHiQ6T7VHgVfDugTp0c13Qh+LEZcSq/OVK3+jWI2W5Q2FSCJHhyJVcT2dlQW
 uWsyajk0mFMLdSktMd7/32KqFVxFi4CN4dFdjWjaDN2byKsQL2Ii7oGjJF51QTz6l118
 Xk3pYzHIvSGfNr4Iw3GqYH+yLs52SvOzSKMmhzWUR2iaQEvHl+xxx7Fe1fx+K0b25q93
 kA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902928; x=1726507728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJE3DAs7T3oH0GbJsFZTv8MmDA7pEO0/Bzfp6DqKShg=;
 b=gSHg7uVEZJ6T++1IUXOd0Nf+elj0l94jSsjIrxggSB8L7MlVZuK5zTiCGBO06nMigh
 grHRh3Vekeh3w4lQNWXTpU+SuT6WQ0oZZ3pOfGSYxSMHiWOztjwWcUXCc4nYTJj+AEoW
 xY7Z41GPR1AqtlmQD3jYhgo9ao7+Mx029859xqzCoEY+TjGyRYRjNR6nh0Kl6NWashHe
 TwKNrmwlpm+xNZG2yU1PuH7Tl2vOhvJ9u7XqcRaTfrg0BqnKgYf1qQ6Y4IlFpS4mF0uc
 pbhs6VHkxQZq8qmQIsF/12Xusl5Krx+zQ2HsskNasvlisPQlm8nxJbXTal9ERgYR/Bgb
 lpqg==
X-Gm-Message-State: AOJu0YyUINHFUByspxf0S31yhDRbv/CiutpuesyO5LKOWm8VMdtom45y
 l6/KkpU1QGfYavyuZS2JVedXlJBwQQADz54SwUymVZxD7gsjAMPBPM4iqNZep5mVQHyHrieUcOW
 T
X-Google-Smtp-Source: AGHT+IHlKA7VTr6+FrQP+jO+P4xcY+N9cH13zMrlmYvvVn8v7W3nsm4Mkf+HH4Vak2BGQwwVjKdCtw==
X-Received: by 2002:a17:902:c941:b0:205:7835:38dc with SMTP id
 d9443c01a7336-206f0654f62mr137132475ad.60.1725902927920; 
 Mon, 09 Sep 2024 10:28:47 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 24/26] tests/tcg/m68k: Add packed decimal tests
Date: Mon,  9 Sep 2024 10:28:21 -0700
Message-ID: <20240909172823.649837-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


