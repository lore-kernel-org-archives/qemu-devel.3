Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2BACD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXXf-00038j-M8; Fri, 22 May 2026 17:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXXK-0000nO-IS; Fri, 22 May 2026 17:36:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXXF-0000MX-Cn; Fri, 22 May 2026 17:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485633; bh=H5WdgFMB60Bqo80lVqOWF9pNexOfOl8eyyX1ZX3PAic=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hF4Y0xvY+f6dGrwwtLRM0kG9CZKfXEkQy+U5RckA5SiKOGfAWmZ8X2SY1P/jdZW8G
 IhtTiRDptrtwiBBEp9fVHC9lV09C5o4wHgo1W0+GOiyIyBxAm1LQCxX6q3z1F8EpG7
 UOATEi34TLU5ZlqXQt43jo7O1rn6S4iZOsLbK2IRAu8oDy3alehRoI5uWM9obLHYmF
 OSBGELlXjAgbVNqMy/RdmQVNlpoxuQ2ClAGS5jr0pyJpQYA/ozFwusMeKNS5VNmFau
 hjCFFcfFy7tMlngVyR4z3KWaXpr7qNGz95gUGkXjO67HAb/4xuvKkGHtwLfwZV8yHh
 vFxAz0dLqDFog==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BC17C1AFAE0;
 Sat, 23 May 2026 00:33:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E07983B7166;
 Sat, 23 May 2026 00:33:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 81/94] blkdebug: Add 'delay-ns' option
Date: Sat, 23 May 2026 00:33:38 +0300
Message-ID: <20260522213356.806058-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Kevin Wolf <kwolf@redhat.com>

Sometimes reproducing a problem for debugging involves slow I/O, so
let's add something to blkdebug to make I/O slow when we need it. This
can be used either together with an error so that the request fails
after the delay, or with errno=0, which allows the request to succeed
after the delay.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260421161132.99878-2-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit d5e4090177ad382e01084a1594a1a60a69f4c1cd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 8a4a8cb85e..b07c67611a 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -95,6 +95,7 @@ typedef struct BlkdebugRule {
             int immediately;
             int once;
             int64_t offset;
+            int64_t delay_ns;
         } inject;
         struct {
             int new_state;
@@ -144,6 +145,10 @@ static QemuOptsList inject_error_opts = {
             .name = "immediately",
             .type = QEMU_OPT_BOOL,
         },
+        {
+            .name = "delay-ns",
+            .type = QEMU_OPT_NUMBER,
+        },
         { /* end of list */ }
     },
 };
@@ -216,6 +221,8 @@ static int add_rule(void *opaque, QemuOpts *opts, Error **errp)
         rule->options.inject.once  = qemu_opt_get_bool(opts, "once", 0);
         rule->options.inject.immediately =
             qemu_opt_get_bool(opts, "immediately", 0);
+        rule->options.inject.delay_ns =
+            qemu_opt_get_number(opts, "delay-ns", 0);
         sector = qemu_opt_get_number(opts, "sector", -1);
         rule->options.inject.offset =
             sector == -1 ? -1 : sector * BDRV_SECTOR_SIZE;
@@ -594,6 +601,7 @@ static int coroutine_fn rule_check(BlockDriverState *bs, uint64_t offset,
     BlkdebugRule *rule = NULL;
     int error;
     bool immediately;
+    int64_t delay_ns;
 
     qemu_mutex_lock(&s->lock);
     QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
@@ -608,13 +616,14 @@ static int coroutine_fn rule_check(BlockDriverState *bs, uint64_t offset,
         }
     }
 
-    if (!rule || !rule->options.inject.error) {
+    if (!rule) {
         qemu_mutex_unlock(&s->lock);
         return 0;
     }
 
     immediately = rule->options.inject.immediately;
     error = rule->options.inject.error;
+    delay_ns  = rule->options.inject.delay_ns;
 
     if (rule->options.inject.once) {
         QSIMPLEQ_REMOVE(&s->active_rules, rule, BlkdebugRule, active_next);
@@ -622,6 +631,10 @@ static int coroutine_fn rule_check(BlockDriverState *bs, uint64_t offset,
     }
 
     qemu_mutex_unlock(&s->lock);
+
+    if (delay_ns) {
+        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, delay_ns);
+    }
     if (!immediately) {
         aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
         qemu_coroutine_yield();
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 508b081ac1..0efd51787b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3919,6 +3919,9 @@
 #
 # @errno: error identifier (errno) to be returned; defaults to EIO
 #
+# @delay-ns: request delay before completion in nanoseconds
+#            (default: 0, since: 11.1)
+#
 # @sector: specifies the sector index which has to be affected in
 #     order to actually trigger the event; defaults to "any sector"
 #
@@ -3934,6 +3937,7 @@
             '*state': 'int',
             '*iotype': 'BlkdebugIOType',
             '*errno': 'int',
+            '*delay-ns': 'int',
             '*sector': 'int',
             '*once': 'bool',
             '*immediately': 'bool' } }
-- 
2.47.3


