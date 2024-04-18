Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DC5C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVtm-0008DV-EK; Thu, 18 Apr 2024 13:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVtj-0008Bf-Dr; Thu, 18 Apr 2024 13:50:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVtg-0007WI-L3; Thu, 18 Apr 2024 13:50:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5D4AF5FD65;
 Thu, 18 Apr 2024 20:50:00 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7862DB933B;
 Thu, 18 Apr 2024 20:49:57 +0300 (MSK)
Received: (nullmailer pid 947818 invoked by uid 1000);
 Thu, 18 Apr 2024 17:49:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zack Buhman <zack@buhman.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 092/116] target/sh4: Fix mac.l with saturation enabled
Date: Thu, 18 Apr 2024 20:49:22 +0300
Message-Id: <20240418174955.947730-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The saturation arithmetic logic in helper_macl is not correct.
I tested and verified this behavior on a SH7091.

Signed-off-by: Zack Buhman <zack@buhman.org>
Message-Id: <20240404162641.27528-2-zack@buhman.org>
[rth: Reformat helper_macl, add a test case.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit c97e8977dcacb3fa8362ee28bcee75ceb01fceaa)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sh4/helper.h b/target/sh4/helper.h
index 8d792f6b55..64056e4a39 100644
--- a/target/sh4/helper.h
+++ b/target/sh4/helper.h
@@ -11,7 +11,7 @@ DEF_HELPER_3(movcal, void, env, i32, i32)
 DEF_HELPER_1(discard_movcal_backup, void, env)
 DEF_HELPER_2(ocbi, void, env, i32)
 
-DEF_HELPER_3(macl, void, env, i32, i32)
+DEF_HELPER_3(macl, void, env, s32, s32)
 DEF_HELPER_3(macw, void, env, i32, i32)
 
 DEF_HELPER_2(ld_fpscr, void, env, i32)
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 54d390fe1f..c96c6008a1 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -160,20 +160,23 @@ void helper_ocbi(CPUSH4State *env, uint32_t address)
     }
 }
 
-void helper_macl(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
+void helper_macl(CPUSH4State *env, int32_t arg0, int32_t arg1)
 {
+    const int64_t min = -(1ll << 47);
+    const int64_t max = (1ll << 47) - 1;
+    int64_t mul = (int64_t)arg0 * arg1;
+    int64_t mac = env->mac;
     int64_t res;
 
-    res = ((uint64_t) env->mach << 32) | env->macl;
-    res += (int64_t) (int32_t) arg0 *(int64_t) (int32_t) arg1;
-    env->mach = (res >> 32) & 0xffffffff;
-    env->macl = res & 0xffffffff;
-    if (env->sr & (1u << SR_S)) {
-        if (res < 0)
-            env->mach |= 0xffff0000;
-        else
-            env->mach &= 0x00007fff;
+    if (!(env->sr & (1u << SR_S))) {
+        res = mac + mul;
+    } else if (sadd64_overflow(mac, mul, &res)) {
+        res = mac < 0 ? min : max;
+    } else {
+        res = MIN(MAX(res, min), max);
     }
+
+    env->mac = res;
 }
 
 void helper_macw(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index 47c39a44b6..3c0695c7ca 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -12,3 +12,8 @@ run-signals: signals
 	$(call skip-test, $<, "BROKEN")
 run-plugin-signals-with-%:
 	$(call skip-test, $<, "BROKEN")
+
+VPATH += $(SRC_PATH)/tests/tcg/sh4
+
+test-macl: CFLAGS += -O -g
+TESTS += test-macl
diff --git a/tests/tcg/sh4/test-macl.c b/tests/tcg/sh4/test-macl.c
new file mode 100644
index 0000000000..b66c854365
--- /dev/null
+++ b/tests/tcg/sh4/test-macl.c
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#define MACL_S_MIN  (-(1ll << 47))
+#define MACL_S_MAX  ((1ll << 47) - 1)
+
+int64_t mac_l(int64_t mac, const int32_t *a, const int32_t *b)
+{
+    register uint32_t macl __asm__("macl") = mac;
+    register uint32_t mach __asm__("mach") = mac >> 32;
+
+    asm volatile("mac.l @%0+,@%1+"
+                 : "+r"(a), "+r"(b), "+x"(macl), "+x"(mach));
+
+    return ((uint64_t)mach << 32) | macl;
+}
+
+typedef struct {
+    int64_t mac;
+    int32_t a, b;
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
+    res = mac_l(t->mac, &t->a, &t->b);
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
+        { 0x00007fff12345678ll, INT32_MAX, INT32_MAX,
+          { 0x40007ffe12345679ll, MACL_S_MAX } },
+        { MACL_S_MIN, -1, 1,
+          { 0xffff7fffffffffffll, MACL_S_MIN } },
+        { INT64_MIN, -1, 1,
+          { INT64_MAX, MACL_S_MIN } },
+        { 0x00007fff00000000ll, INT32_MAX, INT32_MAX,
+          { 0x40007ffe00000001ll, MACL_S_MAX } },
+        { 4, 1, 2, { 6, 6 } },
+        { -4, -1, -2, { -2, -2 } },
+    };
+
+    for (int i = 0; i < sizeof(tests) / sizeof(tests[0]); ++i) {
+        for (int j = 0; j < 2; ++j) {
+            test(&tests[i], j);
+        }
+    }
+    return 0;
+}
-- 
2.39.2


