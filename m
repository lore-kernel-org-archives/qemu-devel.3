Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D0CC52D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 00:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdJBU-0004IL-Bg; Sun, 11 Aug 2024 20:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdJBS-0004BP-DT
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 20:45:14 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdJBQ-0001qN-DV
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 20:45:14 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fc56fd4de1so24526655ad.0
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 17:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723423511; x=1724028311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mp0XkpG61PtXDqfyfYbuypiIVu7oZ1X7in7htVkQn/E=;
 b=FXdmnbFZgIBDWjXY+1McpZQAUkJpZXIGM+C142iBF8bHv7NEG3wLAKRy0eTR1t9csn
 fcih4XZJJXlMJpBZwTPkbot8LTgxuJ7a1CCiN3iiQsqbk6v6w9l7SIr+KpyzU2EI7IXb
 wXzvlULOZGbYytCj/xJoW2hTY1Td0El049go1B2/vuemDXLXDFEap7RvY+sUzKTHsIoQ
 d9hlpx4PQlC35ljL9VAfmovRvmMl+oSdkW2q4SzJoh6uhCe/3MR5NkE0S64dfoAkH7Qa
 KuGbNOvZeQdt13b/68dPr3pu9r57tHoQCdNyWkBKUeVkCKuWOyZ2rB7fVQ0OrwwtIurs
 6yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723423511; x=1724028311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mp0XkpG61PtXDqfyfYbuypiIVu7oZ1X7in7htVkQn/E=;
 b=XuyJumSmJ7g9g8poZFAyC0Ohao1WyspHMU4Xu8PQuJR3Oaa0k8NvoXL3qxMW+tJKSv
 qDnS8ArLeqfERKhnML9+9ykXozQ5oGDGmctl1r/I0Emj7ufnFKmXjYXy/TrM+Hyhovtf
 MMUJRNCR8iSAhoxdx5kHp3c9GDKuAt9mXZ8vj34zUM23CWmgpH0jZUPspb8HBSxUi5AP
 8NdEAMjL1jwNVSmFKuvT/fMPA060SnvBzukhKdU/BrjY1QfJS8hPiHKqzhDytYfhdLkH
 Um77BrK4K+ejRZpHbGgcsiPYBjQ1qXhJqbAgc4+Owuaw9fIdobc01pE352TzRenzOmQ+
 z8ig==
X-Gm-Message-State: AOJu0YzfXRMNKNEkp9eu3tmcI3m48kM3Sc0QIp7CKN2gQCKUer6hBr7O
 cfumXCejv4wHUsbvH+nfQnJBd7knymdJt4MtQAvQV3MewLqvdJTRG5JRbun+Wu6aJ4/m4F+o5D2
 4qH0=
X-Google-Smtp-Source: AGHT+IH+HKZYycDwUv9rOXZjx6v3l4YYv7P71cU5fvxc6yWzmyp5oIaChPElXkz1ZAqDzm2QzMbwUQ==
X-Received: by 2002:a17:902:e845:b0:1f9:e2c0:d962 with SMTP id
 d9443c01a7336-20096baa066mr168650355ad.31.1723423510915; 
 Sun, 11 Aug 2024 17:45:10 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bbb3b758sm27089435ad.257.2024.08.11.17.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 17:45:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH v2 4/4] tests/tcg/m68k: Add packed decimal tests
Date: Mon, 12 Aug 2024 10:44:51 +1000
Message-ID: <20240812004451.13711-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812004451.13711-1-richard.henderson@linaro.org>
References: <20240812004451.13711-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/m68k/packeddecimal-1.c | 41 +++++++++++++++++++++++++++++++
 tests/tcg/m68k/packeddecimal-2.c | 42 ++++++++++++++++++++++++++++++++
 tests/tcg/m68k/Makefile.target   |  4 ++-
 3 files changed, 86 insertions(+), 1 deletion(-)
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
index 0000000000..3547dc7b84
--- /dev/null
+++ b/tests/tcg/m68k/packeddecimal-2.c
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Test packed decimal real conversion from long double, dynamic k-factor */
+
+#include <stdio.h>
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


