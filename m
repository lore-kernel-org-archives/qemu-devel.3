Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7449C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt84-00022T-4l; Mon, 08 Apr 2024 13:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7y-000203-5W
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:54 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7w-0003eD-EW
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:53 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so3810946a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598591; x=1713203391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/A33LtPdfhd6ZXxcd3sa54LWhQX38sygsNQTelB9lyU=;
 b=Pub0Ka1bBmoTMN8gYNWU8cZuP1sW5EytI37CJPrlNg0gj1BrgwWzSc4X8IzgCeLtXo
 rdymg94ESqe7+pcKOqRF7NOJSg8M4Oogl6FxqKAhFYLQL1iL8t5dOlJ2EV4eE8Mjzk9m
 cOexCGDpyeYpscqvrF8ThqayPFgORLlFY5eSW3s+cuUwv2z8qPR5NVeBNUBme586zrP8
 C2p3UZiktj8cdTsjohI840IT4F8OZzFJ9zwzRiwlxtq0LZiSIMFelIPWaXEauPOJK8Xp
 hZCIEJNKCBWlQHpU0gK25dN8/3jpnhRHcHRfC5mP/Duu+ysLT2Xn0eimkZuPNxHuDDM6
 K9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598591; x=1713203391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/A33LtPdfhd6ZXxcd3sa54LWhQX38sygsNQTelB9lyU=;
 b=cyWaHQEzd0Id8qurdEySv+yVPh9c166a5mgZO9gLKZrh3LfF1UTRjJle7r9pBLHvu9
 Or2hPZaWFTPIEtpZySy/DhQRC/tU7sDMEhLWEz5wKRLa77EIwdv7eYA35ue7Gmo3n3vm
 LURM1Xj1ohGqgiikAMv/Us9dFu0y4e7L8v8rbIc6qlYhEfYZz3cTLVhcBmUo7tPPiaG5
 RRJoyCm29EhKnSbllAO4BDy9WDAjN+XvuGSwucax5QhbA1x00VsGadrp6dq/mxFvzwju
 POLZOeW3ceKD0rgrcdufcA70pMWpRNjQy+/DjRZn0CyJzeF+pPO5M3XJTqpUf9AfmBYN
 fcFA==
X-Gm-Message-State: AOJu0YwEwfWlm0y/f8IK8nBrzi22c0m6tI6XGG8WZf31pnHz6Fycm7x2
 Yf6fQZDDvnGXLlt7OeXsjqeNNGycOMciYDghEwN9vqQu8K0szwGTgvGrYHQRCKv2Hth7fjh+mFv
 /
X-Google-Smtp-Source: AGHT+IFft8cs0XDe8I/eqqEZZvK7sfanR+9vc3nsqp6O8KPU62QvhKjNyRAjmJhlrRDgaA/GUf/UrQ==
X-Received: by 2002:a17:90a:3904:b0:2a2:bbdb:c4aa with SMTP id
 y4-20020a17090a390400b002a2bbdbc4aamr8015375pjb.30.1712598590798; 
 Mon, 08 Apr 2024 10:49:50 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zack Buhman <zack@buhman.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/35] target/sh4: Fix mac.w with saturation enabled
Date: Mon,  8 Apr 2024 07:49:07 -1000
Message-Id: <20240408174929.862917-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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


