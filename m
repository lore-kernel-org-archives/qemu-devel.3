Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321F9D3C91A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTLWa-0007HN-Iz; Wed, 10 Dec 2025 09:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vTLWG-0007DX-8z
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:50:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vTLWD-0003Cr-3D
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:50:20 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso59973075e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 06:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765378214; x=1765983014; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7aOWTRiqUHiXIPgTQ0LjDGl3N7exU0erok9Ml327P8A=;
 b=w+CXp/dhrF7LaEb8Kq8Y+5xAbmEdwkv+ZXgRLb66DCCLV+hxtOw4dJ3g783L020lWA
 6cNBhlncDBcqADrcY9PEiDZGveocRYkswpXxPHZFOj09R/SQlFK1iIiUbDTfGSJD4n3T
 9ckc+fggZgTyj/cvPkjlFBagOSqAptH4WjK1IJ1TRlLQ4LF5hEeXu2LI+/dIm2ENvn1T
 ZaVwGWEKX4wse1EeMzWA8pfbcYavp/+QDUDdVDI4aQlqhindKVAjcZbWmpup+EIZlMYu
 sFonEdPmYNrCLDz/n2z2Kfm04djYfu1/CPAGA9+6SiLFSFxn68KKPInC/S47pNRM7yab
 dfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765378214; x=1765983014;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7aOWTRiqUHiXIPgTQ0LjDGl3N7exU0erok9Ml327P8A=;
 b=OCbQO/W6bque+P2dWxL/n4TIs/bKoaDsv7CAHNjQMJ+yOcvhuBvXlOajyQ2wnKGM6N
 Tpo21CtqI1/3Y6tj/+6okrQk7IlWIXy9+nYGTbLDYdHDSkJwktthpnEeZ+PJHMAW+ldh
 WtX6Wa6lZjE5fjptoO1ZewwZ7sjXfVsB4/OqTAC9gjUv7Z38X2SwJmzsfZzGPcT9taMa
 B1aof0hbYbmmyXq8TRCvLZw+Ay1+n0Dy9jImqcjjH3gR2zV3q9f2YbDyApGwFs8wxQTl
 a9YDsEoDwmsyqRvrxsODlOLOFuXJnnqdhgQUaWTEvBKv53KLcXmTrWMaxA21HOqXMfXR
 vKMg==
X-Gm-Message-State: AOJu0Yzt6cujtiudt6yoj0AZ+K8WFWWA7dHbA/hM3hheY30eBv2jY8Ws
 7tYmvjcKXcpc+HF7DFYxVsKnyNgGWDxAGBsDtgZL6nWWwqgu/KCovTDU5hyuWplLMc4=
X-Gm-Gg: ASbGncvun705lpgC/bXXZhofP75xXeyho7o7zNgsIBNkBv2qDLptcdDyLx6bs7DxdxQ
 17XfVFagN4GWDbVbeJte8VNgp7FAe6LEd1zpndd7vv//VXZwJ99WN4q7zxd1nI56YipjInM5TJh
 GhNKFQI7Oglos0ayYig2ym2PhamEsMbR9i6leXZmR/objw8CyPijTsSy70w4rlPa3yLe1ZttdpZ
 9AWf2+c8RJPl1hBeG82lfGMVgb57K2GLnG64AtHFVV32ciQWzKB0Nafq7FLs6c9rIGxJW6JkAr9
 8rtMWjmfqCb6czrqdfJHzt1MYwWUhcMBjhufQw54r72LgK0/4LiVyVekYcsKSIVRqF0pFzvpnof
 8uhg53vFML1N0CSMLImgUwMmjBkwJ3OyocuaMIsui5Xwu+PtaU1XHvUkVK6TBNgXo9H51i2hHMm
 8wOKQZ3SneKk9RSQ==
X-Google-Smtp-Source: AGHT+IGdOYsE+ov9xNHgL/iU5//0vXomMkv2q6fga5S2Nx5xdVUZgFoskCaEj3lrkGjh1V++ha3glA==
X-Received: by 2002:a05:600c:444f:b0:477:7a78:3016 with SMTP id
 5b1f17b1804b1-47a8374ce6bmr27835065e9.8.1765378214313; 
 Wed, 10 Dec 2025 06:50:14 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:62e8:705f:f7a:c7b0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d7f778sm56595235e9.11.2025.12.10.06.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:50:14 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Wed, 10 Dec 2025 14:50:14 +0000
Subject: [PATCH v6 4/4] tests: Add test for ASID2 and write/read of feature
 bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251210-jmac-asid2-v6-4-d3b3acab98c7@linaro.org>
References: <20251210-jmac-asid2-v6-0-d3b3acab98c7@linaro.org>
In-Reply-To: <20251210-jmac-asid2-v6-0-d3b3acab98c7@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32a.google.com
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

Test for presence of ASID2; if it is, check FNG1, FNG0, and A2 are
writable, and read value shows the update. If not present, check these
read as RES0.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 tests/tcg/aarch64/system/asid2.c | 76 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tests/tcg/aarch64/system/asid2.c b/tests/tcg/aarch64/system/asid2.c
new file mode 100644
index 0000000000..7d5466af34
--- /dev/null
+++ b/tests/tcg/aarch64/system/asid2.c
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ * ASID2 Feature presence and enabled TCR2_EL1 bits test
+ *
+ * Copyright (c) 2025 Linaro Ltd
+ *
+ */
+
+#include <stdint.h>
+#include <minilib.h>
+
+#define ID_AA64MMFR3_EL1 "S3_0_C0_C7_3"
+#define ID_AA64MMFR4_EL1 "S3_0_C0_C7_4"
+#define TCR2_EL1 "S3_0_C2_C0_3"
+
+int main()
+{
+    /*
+     * Test for presence of ASID2 and three feature bits enabled by it:
+     * https://developer.arm.com/documentation/109697/2025_09/Feature-descriptions/The-Armv9-5-architecture-extension
+     * Bits added are FNG1, FNG0, and A2. These should be RES0 if A2 is
+     * not enabled and read as the written value if A2 is enabled.
+     */
+
+    uint64_t out;
+    uint64_t idreg3;
+    uint64_t idreg4;
+    int tcr2_present;
+    int asid2_present;
+
+    /* Mask is FNG1, FNG0, and A2 */
+    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
+    const uint64_t in = feature_mask;
+
+    asm("mrs %[idreg3], " ID_AA64MMFR3_EL1 "\n\t"
+        : [idreg3] "=r" (idreg3));
+
+    tcr2_present = ((idreg3 & 0xF) != 0);
+
+    if (!tcr2_present) {
+        ml_printf("TCR2 is not present, cannot perform test");
+        return 0;
+    }
+
+    asm("mrs %[idreg4], " ID_AA64MMFR4_EL1 "\n\t"
+        : [idreg4] "=r" (idreg4));
+
+    asid2_present = ((idreg4 & 0xF00) != 0);
+
+    asm("msr " TCR2_EL1 ", %[x0]\n\t"
+        "mrs %[x1], " TCR2_EL1 "\n\t"
+        : [x1] "=r" (out)
+        : [x0] "r" (in));
+
+    if (asid2_present) {
+        if ((out & feature_mask) == in) {
+            ml_printf("OK\n");
+            return 0;
+        } else {
+            ml_printf("FAIL: ASID2 present, but read value %lx != "
+                      "written value %lx\n",
+                      out & feature_mask, in);
+            return 1;
+        }
+    } else {
+        if (out == 0) {
+            ml_printf("TCR2_EL1 reads as RES0 as expected\n");
+            return 0;
+        } else {
+            ml_printf("FAIL: ASID2, missing but read value %lx != 0\n",
+                      out & feature_mask, in);
+            return 1;
+        }
+    }
+}

-- 
2.43.0


