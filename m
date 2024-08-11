Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D26C52D7B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 06:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sd1g9-0002Ko-0D; Sun, 11 Aug 2024 02:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sd1g7-0002GZ-87
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 02:03:43 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sd1g5-0003M1-EI
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 02:03:42 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3db1eb76702so2605755b6e.0
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2024 23:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723356220; x=1723961020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bj++j3YgBBTATBUE1Ix26t7YFSKIT6F98qGvdazeStQ=;
 b=VjRQ6HQRu7smSUrpFOQbuTRBdh3YRNlAeUwSSIhJjt+fp82PA/OqgehEbcqsd4pkuF
 cyAQA/xZqZzPwZHnNtyBUd6D/xlC7qauebNlFBT1IhrZ5DrABh9BkJ4WsUjUaGG3rawj
 AlBKmcNTYbnnTDbRL6hZC5N1IA0DRexSF9UB4u2DlkFXsDxaUnYOzmEwworsmwi5+Tbx
 X8TIPpQeA/3b3jqDl+aFC74BOapBkYhR5hgTAfsjIyv/LYWF59F8Zz2Io6Z/vHsBJr/L
 4Ko4p4PUsysmoKwJDyY2YpHxFyc29lVPneAArEhiRnVlCNt/DMKPdFldNi+Ji7tIst22
 fmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723356220; x=1723961020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bj++j3YgBBTATBUE1Ix26t7YFSKIT6F98qGvdazeStQ=;
 b=tQYstqvGXFA85Nw7zFzIWiC46f047NkfmYPQ1y207Qn92wMU66I+LnU45bp186Spau
 FoGrtLHtVuAGDoRmGqGZQdq15qga6Q+NRhQI13qQKMu8WNEcAdVUoSthJ8nRk+r2pcJM
 A7KYIO/qPeud4IkE8usdkQQ58frxiXGNJdR5BMV2yQEfhQQPNK8rdMMIcKOaxLWphPp1
 VBNvZ/7Umn4J/dv1k4pWq95W1SkL6MefneS4J6dW6IYVxc2lS9J82GW/EIlwPvmEOLhZ
 4/0gDYAE89GPr/tUQCrIfwczipMFXaOJD3v43209cdJrAdyNqA1exj8YjyJUMRfRC7rV
 CFlw==
X-Gm-Message-State: AOJu0YwEC7jAmkmXp/zshXALI06cz0JkO9b3wVA06fy8EcVB9Mc9OZP0
 GTw4/3Kf5DIueeTebctNKAb4bMkA/ZrnuHson/DwzFAPIKgOFBboF0TRVEogacrW7M7svd/bxkN
 SItYApw==
X-Google-Smtp-Source: AGHT+IFGOZ8/K9FmmTuT6vBBzBl0I04ufZq1jfNwdXYaStsBDjU2jrhyiypDLqwYSoCpdOrZ5sVIaA==
X-Received: by 2002:a05:6808:1a15:b0:3db:2afc:ad6 with SMTP id
 5614622812f47-3dc416dd0e9mr8715951b6e.38.1723356220138; 
 Sat, 10 Aug 2024 23:03:40 -0700 (PDT)
Received: from stoup.. ([172.58.106.160]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd060b5388sm835591b6e.43.2024.08.10.23.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 23:03:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 4/4] tests/tcg/m68k: Add packed decimal tests
Date: Sun, 11 Aug 2024 16:03:13 +1000
Message-ID: <20240811060313.730410-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240811060313.730410-1-richard.henderson@linaro.org>
References: <20240811060313.730410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/m68k/packeddecimal-1.c | 45 ++++++++++++++++++++++++++++++++
 tests/tcg/m68k/packeddecimal-2.c | 42 +++++++++++++++++++++++++++++
 tests/tcg/m68k/Makefile.target   |  2 +-
 3 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/m68k/packeddecimal-1.c
 create mode 100644 tests/tcg/m68k/packeddecimal-2.c

diff --git a/tests/tcg/m68k/packeddecimal-1.c b/tests/tcg/m68k/packeddecimal-1.c
new file mode 100644
index 0000000000..812307402a
--- /dev/null
+++ b/tests/tcg/m68k/packeddecimal-1.c
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Test packed decimal real conversion to long double. */
+
+#include <stdio.h>
+
+struct T {
+    unsigned int d[3];
+    double f;
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
+        long double lf;
+        volatile double f;
+
+        asm("fmove.p (%1),%0" : "=f"(lf) : "a"(t->d));
+
+        /* Round to double; as yet we cannot promise perfect rounding. */
+        f = lf;
+
+        if (f != t->f) {
+            fprintf(stderr, "Mismatch at %d: %.17e != %.17e\n", i, f, t->f);
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
index 33f7b1b127..7587b8f249 100644
--- a/tests/tcg/m68k/Makefile.target
+++ b/tests/tcg/m68k/Makefile.target
@@ -4,4 +4,4 @@
 #
 
 VPATH += $(SRC_PATH)/tests/tcg/m68k
-TESTS += trap denormal
+TESTS += trap denormal packeddecimal-1 packeddecimal-2
-- 
2.43.0


