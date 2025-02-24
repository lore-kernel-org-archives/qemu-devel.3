Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22054C021BC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc3Q-0007aW-0V; Mon, 24 Feb 2025 12:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc38-00075s-0U
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:24 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc36-0005o0-1A
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:21 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220c4159f87so65450215ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417318; x=1741022118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJE3DAs7T3oH0GbJsFZTv8MmDA7pEO0/Bzfp6DqKShg=;
 b=pC/unZYfYRbANXe6X9Q1iO0saNijEjnSFriTncBpvEQM7eJkyFALW906OKOz0X6u50
 QMrF5yBLPe6rKdc1jFG9k8ECcU7oQwxaW1Yz/kLp1VCq8RCtFlT0gE510Ah00tymGesi
 9vVzXXeW2dCfdvjF5dyBmCzurRAT5khHgvo5RyLQynM6r2hTX4609lKSXRudqkSFP2dN
 0fiaDio0lbpj7CdYFy9D+TPf8H8ihFN4ypFIwv/OEmE/ZtvUsSn6zdbtVn0qLhVwB9o0
 QduciPqF1n4pO0tQSit8a6T/KS9xFbdcWqt1Z7uvzyPe/SUqjLhAfJhn/DZzZM/g/GkF
 oa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417318; x=1741022118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJE3DAs7T3oH0GbJsFZTv8MmDA7pEO0/Bzfp6DqKShg=;
 b=XlDWn6xSa1gXAeA7Oz+r7VD9xz4gGFTJDEftzh/XFGhIm0wiXHPiV1/Kxak4voyijv
 Qh38KBNIR9ou0Uzy7/ZKCCmQ8pEl+T6xiLlNj+DO59ynhw9V5OIALVgVzdD6RA+s4eJ2
 2FHnygg82mkQG7qEMf88mtbcREo9noyKe41Zn8puC0WQ7BSJxzzh0ZPB7VW+tCXqyc68
 xiD+qZbZitdvNO1mQKpySvUhpwFL3oyzZ9mwYLW7FAda/fa1efDPOaWdJbGtguRKCNq9
 EzAqwS2orE/slSh7n8H7GUD949tk9xztKVDhLzdekSKgRQ9SSeZ9MQ8eMcBo2sG88wMO
 P6wg==
X-Gm-Message-State: AOJu0YzDsO9beJb8Ua4/1MDhSxx8gtbSbobidcw6jmUjwK6z9iOKnxsF
 zxx0SUboNJnlESpGmoTmGebiS+MEnCy6iKMEJXXOeqTEuOIV4M43angGFj7SUvihHdb4fJ1TJeC
 h
X-Gm-Gg: ASbGnct29rkITMX7KDsD1uaZnjj82NyCedeJxQBgc7bggF9jH/PqKoevsOG+xic2h+K
 e73r0Ag1jaswlrZOA+xDyPLg2ageMYSEAcdFE/VkrZUfLkMBieVpyjtk99smBEc6BACsPYT0zdN
 K3JrE2To6qtO/3laJoOp29QsuWvOO+ncfQaXD1JFVDuZ4Y5nL7Co27TcC+lgu0DGZFH+AU7NNRM
 KoJJFHGcSQAF9HKG1wV3ZjqxwChma1mySyFwC7lHWoksjkWUFiem6NnupnsOkmHSdBNsAU0pQi5
 l33ZnxWAtm84aHwhJTabHxCZoTvhxoQdbNw=
X-Google-Smtp-Source: AGHT+IEnWdABwHbYDEfUXoOcQMNP4/34mec3F0YdjP+zgQMcnoxCmsAwo9BfhRcfhY1EAlVhyfx4Ug==
X-Received: by 2002:a05:6a00:1399:b0:732:623d:f5cd with SMTP id
 d2e1a72fcca58-734790a0bdcmr23626b3a.5.1740417318439; 
 Mon, 24 Feb 2025 09:15:18 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:15:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 22/24] tests/tcg/m68k: Add packed decimal tests
Date: Mon, 24 Feb 2025 09:14:42 -0800
Message-ID: <20250224171444.440135-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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


