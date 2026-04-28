Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F68FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHfAX-0004rn-Jc; Tue, 28 Apr 2026 05:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wHfAV-0004qw-1Q; Tue, 28 Apr 2026 05:55:51 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wHfAS-00007l-Hw; Tue, 28 Apr 2026 05:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1777370142; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=ul9Uqw2o/70dfkdm0XJFNFDO0BXXKekxzcLmipcqjLU=;
 b=n4ina7L04Z4AnWfPePaQVzX7UuXdmmwVywqPiG4Bc9d+ulOoJO4ehPP++nRvAJAaXie2+Pb4+rMFRXP7XVucU04UZQ53UuE/Xm7omI4pVZcyD6PczyUvgN0hM88nza1AN0quuQFvb4Ojfuhex2sDLSTsgYA6gSIjTdHtrLrFX4w=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R411e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0X1uDvy._1777370135; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X1uDvy._1777370135 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 28 Apr 2026 17:55:41 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 qemu-block@nongnu.org
Subject: [PATCH 2/2] util/aio-posix: avoid allocating ready_list in
 aio_prepare()
Date: Tue, 28 Apr 2026 17:55:34 +0800
Message-ID: <20260428095534.77573-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Now that poll_ready handlers are handled via aio_pending() and
aio_dispatch(), the local ready_list in aio_prepare() serves no
purpose: nodes inserted into it are immediately discarded when the
function returns.

Eliminate the unnecessary list operations by passing NULL as the
ready_list argument to poll_set_started(). Teach poll_set_started()
to handle a NULL ready_list by setting poll_ready=true directly on
the node instead of calling aio_add_poll_ready_handler().

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 util/aio-posix.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 633bffd716..189d692083 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -241,7 +241,11 @@ static bool poll_set_started(AioContext *ctx, AioHandlerList *ready_list,
 
         /* Poll one last time in case ->io_poll_end() raced with the event */
         if (!started && node->io_poll(node->opaque)) {
-            aio_add_poll_ready_handler(ready_list, node);
+            if (ready_list) {
+                aio_add_poll_ready_handler(ready_list, node);
+            } else {
+                node->poll_ready = true;
+            }
             progress = true;
         }
     }
@@ -253,14 +257,12 @@ static bool poll_set_started(AioContext *ctx, AioHandlerList *ready_list,
 
 bool aio_prepare(AioContext *ctx)
 {
-    AioHandlerList ready_list = QLIST_HEAD_INITIALIZER(ready_list);
-
     /*
      * Poll mode cannot be used with glib's event loop, disable it.
      * Any handlers that fire in the last poll are marked poll_ready=true
      * and will be picked up by aio_pending() / aio_dispatch().
      */
-    poll_set_started(ctx, &ready_list, false);
+    poll_set_started(ctx, NULL, false);
 
     ctx->fdmon_ops->gsource_prepare(ctx);
     return false;
-- 
2.50.1 (Apple Git-155)


