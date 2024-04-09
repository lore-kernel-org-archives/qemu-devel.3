Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8DFCD129A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGY-0000aA-6U; Tue, 09 Apr 2024 15:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGW-0000Zt-IJ
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:20 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGU-0004e1-QW
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:20 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e3ca4fe4cfso24517255ad.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691377; x=1713296177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/A33LtPdfhd6ZXxcd3sa54LWhQX38sygsNQTelB9lyU=;
 b=msmHIh8/wnogAEyQ61lxKBxfhYiEUJj8nyaXWfPJwbB3C3gZAxHaysnLjqcM7m8qwg
 xd5ZAuLKjwnQeZhkZyrKeQz7kgmUjYVjfdDotEvdc+6fjtVkQHedeovKQeYJGxsP8rXi
 LrjEnyiYgT7sYASfoM5RVYP6OZkVAcxPXifNAWHGRjVVDxlqvsGk4B15jJPUQVxdh7kU
 zbOiwdhYTox3LDwMuL0v4g4akm8l/60telfHshbJeF7mIrOReC4K/amiyOaEQRuYINo9
 tryJx1Qo6B5Q4z8MjVXaGp5T+XEjJf0AFRrquX/6+vaF8qzQ1KqhMuKZ7O7uFAHlcIHy
 oZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691377; x=1713296177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/A33LtPdfhd6ZXxcd3sa54LWhQX38sygsNQTelB9lyU=;
 b=RNy2mVky6YbEYuG/AgSPpFGfH+Wf5rMjDiFhBTFzM/bEkIB2ovapiBUBt3fsrkaV4L
 EQBRoMTCEevnvRffY8pTARm5TV+oNwU5doApAejI6IyMsGIJPopf0PGJCmJJWB8slEHJ
 A2Rm2bMjy5GxpbB6SuCKx30cRUAdvtDN5wnJdoZcBlx9/eC11haKvLaz4PZ41UdD9iZO
 g8lbiFujBZcSxc5oy2ylnorKIc3xx3rUz0aElN1cfA0rmGBJXHRIj+zyMKxiwn24eAZV
 +X9Sqdebn2FHd5XGcRkogX2F/kzASdbmfOOoo12zv6Z65LglWMjPJRbVi9+bQLxchILD
 LpWQ==
X-Gm-Message-State: AOJu0YwRIOS8fOXYrzVIiqNWvzpGsjUJbg4h5BCqkB+7rjAwFGDCLtuc
 /OuMFwumjwUUZKWBNabl5N1nFdh+98WftuL5DF18F/qsV9GP75irAyuE5OxhAMN+B0LICqyEBXR
 p
X-Google-Smtp-Source: AGHT+IEg1xMYMeICU+/DfeX+EmGvqmwzh2xBiMAetrmY+oovA/JcK8PHy48VZAYeB19BMqloik8ARA==
X-Received: by 2002:a17:902:ee46:b0:1e4:970e:37a7 with SMTP id
 6-20020a170902ee4600b001e4970e37a7mr735831plo.60.1712691377298; 
 Tue, 09 Apr 2024 12:36:17 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zack Buhman <zack@buhman.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 08/20] target/sh4: Fix mac.w with saturation enabled
Date: Tue,  9 Apr 2024 09:35:51 -1000
Message-Id: <20240409193603.1703216-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

From: Zack Buhman <zack@buhman.org>

The saturation arithmetic logic in helper_macw is not correct.
I tested and verified this behavior on a SH7091.

Reviewd-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Zack Buhman <zack@buhman.org>
Message-Id: <20240405233802.29128-3-zack@buhman.org>
[rth: Reformat helper_macw, add a test case.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/helper.h           |  2 +-
 target/sh4/op_helper.c        | 28 +++++++++-------
 tests/tcg/sh4/test-macw.c     | 61 +++++++++++++++++++++++++++++++++++
 tests/tcg/sh4/Makefile.target |  3 ++
 4 files changed, 82 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/sh4/test-macw.c

diff --git a/target/sh4/helper.h b/target/sh4/helper.h
index 64056e4a39..29011d3dbb 100644
--- a/target/sh4/helper.h
+++ b/target/sh4/helper.h
@@ -12,7 +12,7 @@ DEF_HELPER_1(discard_movcal_backup, void, env)
 DEF_HELPER_2(ocbi, void, env, i32)
 
 DEF_HELPER_3(macl, void, env, s32, s32)
-DEF_HELPER_3(macw, void, env, i32, i32)
+DEF_HELPER_3(macw, void, env, s32, s32)
 
 DEF_HELPER_2(ld_fpscr, void, env, i32)
 
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index d0bae0cc00..99394b714c 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -177,22 +177,28 @@ void helper_macl(CPUSH4State *env, int32_t arg0, int32_t arg1)
     env->mac = res;
 }
 
-void helper_macw(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
+void helper_macw(CPUSH4State *env, int32_t arg0, int32_t arg1)
 {
-    int64_t res;
+    /* Inputs are already sign-extended from 16 bits. */
+    int32_t mul = arg0 * arg1;
 
-    res = ((uint64_t) env->mach << 32) | env->macl;
-    res += (int64_t) (int16_t) arg0 *(int64_t) (int16_t) arg1;
-    env->mach = (res >> 32) & 0xffffffff;
-    env->macl = res & 0xffffffff;
     if (env->sr & (1u << SR_S)) {
-        if (res < -0x80000000) {
+        /*
+         * In saturation arithmetic mode, the accumulator is 32-bit
+         * with carry. MACH is not considered during the addition
+         * operation nor the 32-bit saturation logic.
+         */
+        int32_t res, macl = env->macl;
+
+        if (sadd32_overflow(macl, mul, &res)) {
+            res = macl < 0 ? INT32_MIN : INT32_MAX;
+            /* If overflow occurs, the MACH register is set to 1. */
             env->mach = 1;
-            env->macl = 0x80000000;
-        } else if (res > 0x000000007fffffff) {
-            env->mach = 1;
-            env->macl = 0x7fffffff;
         }
+        env->macl = res;
+    } else {
+        /* In non-saturation arithmetic mode, the accumulator is 64-bit */
+        env->mac += mul;
     }
 }
 
diff --git a/tests/tcg/sh4/test-macw.c b/tests/tcg/sh4/test-macw.c
new file mode 100644
index 0000000000..4eceec8634
--- /dev/null
+++ b/tests/tcg/sh4/test-macw.c
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+int64_t mac_w(int64_t mac, const int16_t *a, const int16_t *b)
+{
+    register uint32_t macl __asm__("macl") = mac;
+    register uint32_t mach __asm__("mach") = mac >> 32;
+
+    asm volatile("mac.w @%0+,@%1+"
+                 : "+r"(a), "+r"(b), "+x"(macl), "+x"(mach));
+
+    return ((uint64_t)mach << 32) | macl;
+}
+
+typedef struct {
+    int64_t mac;
+    int16_t a, b;
+    int64_t res[2];
+} Test;
+
+__attribute__((noinline))
+void test(const Test *t, int sat)
+{
+    int64_t res;
+
+    if (sat) {
+        asm volatile("sets");
+    } else {
+        asm volatile("clrs");
+    }
+    res = mac_w(t->mac, &t->a, &t->b);
+
+    if (res != t->res[sat]) {
+        fprintf(stderr, "%#llx + (%#x * %#x) = %#llx -- got %#llx\n",
+                t->mac, t->a, t->b, t->res[sat], res);
+        abort();
+    }
+}
+
+int main()
+{
+    static const Test tests[] = {
+        { 0, 2, 3, { 6, 6 } },
+        { 0x123456787ffffffell, 2, -3,
+          { 0x123456787ffffff8ll, 0x123456787ffffff8ll } },
+        { 0xabcdef127ffffffall, 2, 3,
+          { 0xabcdef1280000000ll, 0x000000017fffffffll } },
+        { 0xfffffffffll, INT16_MAX, INT16_MAX,
+          { 0x103fff0000ll, 0xf3fff0000ll } },
+    };
+
+    for (int i = 0; i < sizeof(tests) / sizeof(tests[0]); ++i) {
+        for (int j = 0; j < 2; ++j) {
+            test(&tests[i], j);
+        }
+    }
+    return 0;
+}
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index 9a11c10924..4d09291c0c 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -14,3 +14,6 @@ VPATH += $(SRC_PATH)/tests/tcg/sh4
 
 test-macl: CFLAGS += -O -g
 TESTS += test-macl
+
+test-macw: CFLAGS += -O -g
+TESTS += test-macw
-- 
2.34.1


