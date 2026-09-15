Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BD3C88E72
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 01:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6IAn-0007vi-BM; Mon, 14 Sep 2026 21:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6IAl-0007uY-SY
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 21:41:23 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6IAj-0003ZJ-Vu
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 21:41:23 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso4167826a91.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789436480; x=1790041280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MTqvBlEdbcDqKk+fC43xO2LCg7KVbS59qcAWR+HYP6E=;
 b=Yjsb3RGHDnSBtgYG/Q3fn87GJ7OIyz3pw8j/cWAjuOC757ycXaE+BsYlDFwM3ZJuHV
 LO5FY8J8OKvQKV3RQ8+uVJ0YxE1OvIdi1O3pPX38NusxsbWNGFaISgFnNzWcXz5ZP/OB
 Jz7JZv1wtMXuLRaSs21zzWp3lh7FVIfSpA8r+d0hqqpb1ZQm6gIBsHNpksKVnzfDhMxD
 oAShjWWepzDasVKQqMaH/gUh3kwoZfj6ie1kjmXm1p5xdOzbmvGbWPgM0zcATgzbDCh6
 NLI9xBdXnCW8q6cdDlnAhfF/Iw698kyV1KhLUcYfUW6hEbab0sPrr6elqJBJjkZ7zoZV
 sCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789436480; x=1790041280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MTqvBlEdbcDqKk+fC43xO2LCg7KVbS59qcAWR+HYP6E=;
 b=HWdxK4F3+VY1Y91BvxbxU9dldOdfeHzrAQxXl7Q/y0W/E3/INFYElqXrHjJ5rTZcTo
 XI/z81TveXWR4WgyaBBPX9zdIkl05opyYeVzNewQDzOp5Qs3Twdl1ufj5teRgoMaayFc
 KhqVW6lRnlkmFlq3hDIwE4k9tIyrS4Grogu4W5w3w4kfEr+aD0Bz6dpSExQtPUQHyhpT
 8jVrimpkyHSAto9+DdRhnx601Vn8XE7el7UtggjgLwp/PNd/0HW8TkT+v2EJAgf59OXi
 KfPWUzBuo+HGcEqMmFajnzfMj2cWDZtqgzIiq1iuzidiBfYfduIeqXiO2/rXzvfY0B1P
 qkmw==
X-Gm-Message-State: AFuF++k0GIWbSZUnuHJNsNDjDAfzC6XH7Y4d1hP8PQz+gBFVgFlWEtms
 oJoqZu93rUgapeHR0s6rSQhMA8VHTw3DBfj/tCGN7LaFBLKp79H0C9G0AU2CRbHQzawLfmXVvI0
 KnbKbtY8=
X-Gm-Gg: AYBFou1LxYH0wodjIY9MoLg6TZAPYPShFkLfgd4k1qstxlUlWNnIp+QLvSBIgaJ1vrK
 wHZoXTspPPQ8Wkr/6cwSvYhShZAqedqXET+Uahj6dIUoC0lgVLaxJUhn2yeKID+gG7SGNn+5OBE
 NWuV7oN0jftzfSeYHShb/abcvk+fpYPJbJ3TwaiIG2mOzclEK1FM95sl3nVZWRoOcolSPb6DClJ
 ES1QXfJ13k3PWRR5x/+3j//7EThNvV9AfQyHm4hFr/K2T+vzTTCi6RtzXhdQdr++7Zb/+lyhG97
 cNO5bWvvDNi8VnrgnpjxdW/ygp8ZP2nA4Orb8ly0ur7cIsqqtgTua/CtGN2xDg7pDnHxZjI5RHF
 9A82aezS3ZIUXRRxAgm63wjkcgJcznVCRoTLAVGB1XbRgu+s3Izbucbcma3W5nwGKyto4y5idVt
 3qRs7N12AECKIgajYGXd/Emfr9iaf5BxhIkQiqFyMGGsxy2wCjIX3r9/w9Au7lTn7H6bfzDUjlK
 qZIbA==
X-Received: by 2002:a17:90b:2809:b0:396:d27b:89b9 with SMTP id
 98e67ed59e1d1-39debfa956bmr11362318a91.10.1789436480462; 
 Mon, 14 Sep 2026 18:41:20 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:c119:8717:353:53c6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm26351702eec.30.2026.09.14.18.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 18:41:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 2/2] tests/tcg/arm: Add regression test for #4448
Date: Mon, 14 Sep 2026 15:41:15 -1000
Message-ID: <20260915014115.1809286-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915014115.1809286-1-richard.henderson@linaro.org>
References: <20260915014115.1809286-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 tests/tcg/arm/issue4448.c | 51 +++++++++++++++++++++++++++++++++++++++
 tests/tcg/arm/meson.build |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 tests/tcg/arm/issue4448.c

diff --git a/tests/tcg/arm/issue4448.c b/tests/tcg/arm/issue4448.c
new file mode 100644
index 00000000000..180ff4029a2
--- /dev/null
+++ b/tests/tcg/arm/issue4448.c
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <assert.h>
+#include <stdint.h>
+
+/* Signed 64-bit product, constant operand first then second. */
+#define SMULL_CONST_LHS(k, x, lo, hi) \
+    __asm__("mov r0, #" #k "\n\tsmull %0, %1, r0, %2" \
+            : "=&r"(lo), "=&r"(hi) : "r"(x) : "r0", "cc")
+
+#define SMULL_CONST_RHS(k, x, lo, hi) \
+    __asm__("mov r0, #" #k "\n\tsmull %0, %1, %2, r0" \
+	    : "=&r"(lo), "=&r"(hi) : "r"(x) : "r0", "cc")
+
+/* Unsigned 64-bit product, for contrast: this one is folded correctly. */
+#define UMULL_CONST_LHS(k, x, lo, hi) \
+    __asm__("mov r0, #" #k "\n\tumull %0, %1, r0, %2" \
+	    : "=&r"(lo), "=&r"(hi) : "r"(x) : "r0", "cc")
+
+static int64_t s64(int32_t hi, int32_t lo)
+{
+    return ((int64_t)hi << 32) | (uint32_t)lo;
+}
+
+static uint64_t u64(int32_t hi, int32_t lo)
+{
+    return ((uint64_t)(uint32_t)hi << 32) | (uint32_t)lo;
+}
+
+int main(void)
+{
+    static const int32_t values[] = { 1961612, -1479053948, -7, 0 };
+
+    for (unsigned i = 0; i < sizeof(values) / sizeof(values[0]); i++) {
+        int32_t x = values[i];
+        int32_t lo, hi;
+
+        SMULL_CONST_LHS(1, x, lo, hi);
+        assert(x == s64(hi, lo));
+
+        SMULL_CONST_RHS(1, x, lo, hi);
+        assert(x == s64(hi, lo));
+
+        UMULL_CONST_LHS(1, x, lo, hi);
+        assert((uint32_t)x == u64(hi, lo));
+
+        SMULL_CONST_LHS(0, x, lo, hi);
+        assert(0 == u64(hi, lo));
+    }
+    return 0;
+}
diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
index 1b491cea026..5c2af2189c5 100644
--- a/tests/tcg/arm/meson.build
+++ b/tests/tcg/arm/meson.build
@@ -39,6 +39,7 @@ tests += {
     'expected_output': 'fcvt.ref',
   },
   'pcalign-a32.c': {'cflags': ['-marm']},
+  'issue4448.c': {},
 }
 
 # Vector SHA1
-- 
2.53.0


