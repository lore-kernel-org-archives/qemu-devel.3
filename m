Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D54CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXbA-0002K6-UK; Fri, 22 May 2026 17:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXb5-0001ia-Fg; Fri, 22 May 2026 17:39:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXb1-0003bo-Su; Fri, 22 May 2026 17:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485683; bh=x2sf52vOCDaTwRPKgwaGQSCRz8qp6WLTuolF65ng5SI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UCRAj5ZXBSQNzkepzrHWbWmqxOvA1oNSuODXN8QVCwJikrd4lqUTJxMhaOUll2Goq
 sEip4sq6AjyQz2dUWY40QaDg2ANnB998n2x7ziuhh3C+6dna8cLHoqOfc4PXb4KGdh
 HmeZp2v5TtBefwslfz0epbW0WGV/66UT+qIuiC06ZX2gPBEwbOuu2vxsicOx4zBWhH
 zZzcNa1WEN6vGQGE33QuKvdjGKRbr+/4gojiAyv3bQaAVhBTaTSore/5bQd6KMNTnS
 3nE2vp3RKTlHccjhj34BRqtKQ7CcizFsga6OgK9UxEmTHzeg6vouc7Be/LhwJrTZ89
 Yq+hrEtxATT2A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A7D921AFB0D;
 Sat, 23 May 2026 00:34:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CCD3F3B718D;
 Sat, 23 May 2026 00:34:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 124/136] blkdebug: Add 'delay-ns' option
Date: Sat, 23 May 2026 00:34:32 +0300
Message-ID: <20260522213446.806182-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
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
index 1c1967f8e0..8a46bbb891 100644
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
index 65031a86b5..09059b0a08 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3786,6 +3786,9 @@
 #
 # @errno: error identifier (errno) to be returned; defaults to EIO
 #
+# @delay-ns: request delay before completion in nanoseconds
+#            (default: 0, since: 11.1)
+#
 # @sector: specifies the sector index which has to be affected in
 #     order to actually trigger the event; defaults to "any sector"
 #
@@ -3801,6 +3804,7 @@
             '*state': 'int',
             '*iotype': 'BlkdebugIOType',
             '*errno': 'int',
+            '*delay-ns': 'int',
             '*sector': 'int',
             '*once': 'bool',
             '*immediately': 'bool' } }
-- 
2.47.3


