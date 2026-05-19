Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BA5CD4F5E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNr9-0007zb-U8; Tue, 19 May 2026 13:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNr3-0007xm-8x
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNqw-00045x-Jy
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779210212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EhiDhqiCb7FzuHBnUkHoGrC4DbGr7HjU+ndE2znl4j8=;
 b=aUZMMDaRHcef8HOrfEwFbdbEMLCvme5pJnXLfiAYeoIHA1Y3nyT/sUIGZNPukPPhLG2Xc0
 Y+WL4Jn8JPnS8FcwEIUipgczCU9U41QEDlsXymZTKx4tyF8RmkSrVlAFtGiiOpQaGkRkL/
 UWZkY4UpGS3U05ID8/yIEiGwq2/i810=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-NbqgNeN1OceaTsoiJBSCTw-1; Tue,
 19 May 2026 13:03:31 -0400
X-MC-Unique: NbqgNeN1OceaTsoiJBSCTw-1
X-Mimecast-MFC-AGG-ID: NbqgNeN1OceaTsoiJBSCTw_1779210210
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 363BE1956094; Tue, 19 May 2026 17:03:30 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.113])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7914B1684; Tue, 19 May 2026 17:03:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/18] blkdebug: Add 'delay-ns' option
Date: Tue, 19 May 2026 19:03:00 +0200
Message-ID: <20260519170317.345032-2-kwolf@redhat.com>
In-Reply-To: <20260519170317.345032-1-kwolf@redhat.com>
References: <20260519170317.345032-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Sometimes reproducing a problem for debugging involves slow I/O, so
let's add something to blkdebug to make I/O slow when we need it. This
can be used either together with an error so that the request fails
after the delay, or with errno=0, which allows the request to succeed
after the delay.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260421161132.99878-2-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  4 ++++
 block/blkdebug.c     | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 508b081ac16..0efd51787b4 100644
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
diff --git a/block/blkdebug.c b/block/blkdebug.c
index fdc96d1f45d..78cc03746f0 100644
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
     BlkdebugRule *rule;
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
-- 
2.54.0


