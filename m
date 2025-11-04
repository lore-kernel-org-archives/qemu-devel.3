Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4295CCFA03
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 02:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG6o2-000700-Ic; Mon, 03 Nov 2025 21:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6o0-0006zG-Hj
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:29:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6ny-0003vM-5e
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762223393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRTdLyxKxJkVcnKSS/x409aZoU9Yvqy0aKNN6YyPVZE=;
 b=XUahF7j/rjNQcofxVblShDQ7JRlCoC+cRpAQTYug6gpW9hpsGPgrfbC6Nd9rfcSw0PR5mK
 vpIuRQnI1rrxyJDgMWxnEQYoHK33tWpQ+8BnBAFbpqiWR6lrNgXgmskgBUARuyXHY3YSty
 5Wl4UFv0fJHiNE46VhmyddUNolBsGQ8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-8d7CR2_NP6qJWmY_GBpr6A-1; Mon,
 03 Nov 2025 21:29:49 -0500
X-MC-Unique: 8d7CR2_NP6qJWmY_GBpr6A-1
X-Mimecast-MFC-AGG-ID: 8d7CR2_NP6qJWmY_GBpr6A_1762223388
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52C23180035A; Tue,  4 Nov 2025 02:29:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4740719560A2; Tue,  4 Nov 2025 02:29:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 eblake@redhat.com, Hanna Czenczek <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, hibriansong@gmail.com,
 Chao Gao <chao.gao@intel.com>
Subject: [PATCH v6 04/15] aio-posix: keep polling enabled with fdmon-io_uring.c
Date: Mon,  3 Nov 2025 21:29:22 -0500
Message-ID: <20251104022933.618123-5-stefanha@redhat.com>
In-Reply-To: <20251104022933.618123-1-stefanha@redhat.com>
References: <20251104022933.618123-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 816a430c517e ("util/aio: Defer disabling poll mode as long as
possible") kept polling enabled when the event loop timeout is 0. Since
there is no timeout the event loop will continue immediately and the
overhead of disabling and re-enabling polling can be avoided.

fdmon-io_uring.c is unable to take advantage of this optimization
because its ->need_wait() function returns true whenever there are new
io_uring SQEs to submit:

  if (timeout || ctx->fdmon_ops->need_wait(ctx)) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Polling will be disabled even when timeout == 0.

Extend the optimization to handle the case when need_wait() returns true
and timeout == 0.

Cc: Chao Gao <chao.gao@intel.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 util/aio-posix.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 2e0a5dadc4..824fdc34cc 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -559,7 +559,14 @@ static bool run_poll_handlers(AioContext *ctx, AioHandlerList *ready_list,
         elapsed_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time;
         max_ns = qemu_soonest_timeout(*timeout, max_ns);
         assert(!(max_ns && progress));
-    } while (elapsed_time < max_ns && !ctx->fdmon_ops->need_wait(ctx));
+
+        if (ctx->fdmon_ops->need_wait(ctx)) {
+            if (fdmon_supports_polling(ctx)) {
+                *timeout = 0; /* stay in polling mode */
+            }
+            break;
+        }
+    } while (elapsed_time < max_ns);
 
     if (remove_idle_poll_handlers(ctx, ready_list,
                                   start_time + elapsed_time)) {
@@ -722,7 +729,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
          * up IO threads when some work becomes pending. It is essential to
          * avoid hangs or unnecessary latency.
          */
-        if (poll_set_started(ctx, &ready_list, false)) {
+        if (timeout && poll_set_started(ctx, &ready_list, false)) {
             timeout = 0;
             progress = true;
         }
-- 
2.51.1


