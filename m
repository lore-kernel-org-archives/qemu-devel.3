Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF30FC88E73
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6NzF-0003xc-VI; Tue, 15 Sep 2026 03:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x6Nz7-0003xP-7G
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:53:46 -0400
Received: from [115.124.30.119] (helo=out30-119.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x6Nyz-0007vW-RN
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1789458795; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=gkDP1p+sPlcMiUYpDg1Kyzxe4uBqFDm4tGonTaD+Ho8=;
 b=SmzckmI68X931bp+a7QdAqd9DhhTUv4c0q2FwQRq9mhfdwnTaEv8whe6P96NSWjHGR8h/zNPkaQBIb+n1VZSpMcBVgHZNYLS0UvzSJq3z5+wTFxxR2fqQr8JLrMrwOT1Sdj7FHCZG0fqcets6+8NTmfbmZ/twvQ+0hjL4dJkayA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0XB0i4D-_1789458793; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0XB0i4D-_1789458793 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 15 Sep 2026 15:53:13 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: "Dr . David Alan Gilbert" <dave@treblig.org>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] monitor/hmp: detect signed integer overflow in expression
 evaluator
Date: Tue, 15 Sep 2026 15:53:12 +0800
Message-ID: <20260915075312.50612-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.119 (deferred)
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

The HMP expression evaluator performed *, +, - and unary - on int64_t
values without checking for overflow.  A malformed expression such as
"0x7fffffffffffffff + 1" would silently wrap around to INT64_MIN and
could then be passed as a physical address to the "xp" command.

Use the checked-arithmetic helpers from host-utils.h:
- smul64_overflow() for "*"
- sadd64_overflow()/ssub64_overflow() for "+"/"-"
- ssub64_overflow(0, n) for unary "-"
- an explicit check for INT64_MIN / -1 and INT64_MIN % -1

Also check the "M" (MiB) suffix multiplier used by commands such as
"balloon".

Overflow now raises an "integer overflow" error via expr_error() or
monitor_hmp_printf()/goto fail instead of propagating a wrapped value.

Add a qtest that verifies the evaluator reports "integer overflow" for
the classic overflow cases and still accepts non-overflowing values.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4463
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 monitor/hmp.c                        | 26 +++++++--
 tests/qtest/hmp-expr-overflow-test.c | 81 ++++++++++++++++++++++++++++
 tests/qtest/meson.build              |  1 +
 3 files changed, 103 insertions(+), 5 deletions(-)
 create mode 100644 tests/qtest/hmp-expr-overflow-test.c

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 488ec23937..e6be921770 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -35,6 +35,7 @@
 #include "qemu/config-file.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
+#include "qemu/host-utils.h"
 #include "qemu/log.h"
 #include "qemu/option.h"
 #include "qemu/base-arch-defs.h"
@@ -480,7 +481,10 @@ static int64_t expr_unary(MonitorHMP *mon)
         break;
     case '-':
         next();
-        n = -expr_unary(mon);
+        n = expr_unary(mon);
+        if (ssub64_overflow(0, n, &n)) {
+            expr_error(mon, "integer overflow");
+        }
         break;
     case '~':
         next();
@@ -571,13 +575,18 @@ static int64_t expr_prod(MonitorHMP *mon)
         switch (op) {
         default:
         case '*':
-            val *= val2;
+            if (smul64_overflow(val, val2, &val)) {
+                expr_error(mon, "integer overflow");
+            }
             break;
         case '/':
         case '%':
             if (val2 == 0) {
                 expr_error(mon, "division by zero");
             }
+            if (val == INT64_MIN && val2 == -1) {
+                expr_error(mon, "integer overflow");
+            }
             if (op == '/') {
                 val /= val2;
             } else {
@@ -632,9 +641,13 @@ static int64_t expr_sum(MonitorHMP *mon)
         next();
         val2 = expr_logic(mon);
         if (op == '+') {
-            val += val2;
+            if (sadd64_overflow(val, val2, &val)) {
+                expr_error(mon, "integer overflow");
+            }
         } else {
-            val -= val2;
+            if (ssub64_overflow(val, val2, &val)) {
+                expr_error(mon, "integer overflow");
+            }
         }
     }
     return val;
@@ -1028,7 +1041,10 @@ static QDict *monitor_parse_arguments(MonitorHMP *mon,
                         monitor_hmp_printf(mon, "enter a positive value\n");
                         goto fail;
                     }
-                    val *= MiB;
+                    if (smul64_overflow(val, MiB, &val)) {
+                        monitor_hmp_printf(mon, "integer overflow\n");
+                        goto fail;
+                    }
                 }
                 qdict_put_int(qdict, key, val);
             }
diff --git a/tests/qtest/hmp-expr-overflow-test.c b/tests/qtest/hmp-expr-overflow-test.c
new file mode 100644
index 0000000000..29ef880993
--- /dev/null
+++ b/tests/qtest/hmp-expr-overflow-test.c
@@ -0,0 +1,81 @@
+/*
+ * QTest regression test for HMP expression evaluator overflow.
+ *
+ * Copyright (c) 2026 Bin Guo
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+static void assert_overflow_response(QTestState *qts, const char *cmd)
+{
+    g_autofree char *resp = qtest_hmp(qts, "%s", cmd);
+
+    g_assert(strstr(resp, "integer overflow") != NULL);
+}
+
+static void assert_ok_response(QTestState *qts, const char *cmd)
+{
+    g_autofree char *resp = qtest_hmp(qts, "%s", cmd);
+
+    g_assert(strstr(resp, "integer overflow") == NULL);
+    g_assert(strstr(resp, "error") == NULL);
+}
+
+static void test_expr_overflow(void)
+{
+    QTestState *qts = qtest_init("-M none -m 2");
+
+    /* Addition overflow */
+    assert_overflow_response(qts, "print 0x7fffffffffffffff + 1");
+
+    /* Subtraction overflow */
+    assert_overflow_response(qts, "print -0x8000000000000000 - 1");
+
+    /* Multiplication overflow */
+    assert_overflow_response(qts, "print 0x4000000000000000 * 2");
+
+    /* Unary negation of INT64_MIN */
+    assert_overflow_response(qts, "print -0x8000000000000000");
+
+    /* Division overflow */
+    assert_overflow_response(qts, "print -0x8000000000000000 / -1");
+    assert_overflow_response(qts, "print -0x8000000000000000 % -1");
+
+    /* Sanity: non-overflowing expressions still work */
+    assert_ok_response(qts, "print 1 + 1");
+    assert_ok_response(qts, "print 0x7fffffffffffffff");
+    assert_ok_response(qts, "print -0x7fffffffffffffff");
+
+    qtest_quit(qts);
+}
+
+static void test_balloon_m_overflow(void)
+{
+    QTestState *qts;
+
+    /* q35 is x86-only; skip this test on other architectures. */
+    if (!qtest_has_machine("q35")) {
+        return;
+    }
+
+    /* Balloon command takes an 'M' suffix size argument in MB. */
+    qts = qtest_init("-M q35 -m 128 -device virtio-balloon-pci");
+
+    /* 0x7fffffffffffffff is positive as int64_t, but * MiB overflows. */
+    assert_overflow_response(qts, "balloon 0x7fffffffffffffff");
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("hmp/expr-overflow", test_expr_overflow);
+    qtest_add_func("hmp/balloon-m-overflow", test_balloon_m_overflow);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c3593f7530..89172ac45b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -30,6 +30,7 @@ qtests_generic = [
 if have_hmp
   qtests_generic += [
     'test-hmp',
+    'hmp-expr-overflow-test',
   ]
 endif
 qtests_generic += [
-- 
2.50.1 (Apple Git-155)


