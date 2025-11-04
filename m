Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13C3CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 18:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLKr-0006Er-0A; Tue, 04 Nov 2025 13:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLF7-00018f-LD
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:54:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLF6-0006nZ-2U
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762278891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4+2iCvF+RO9DOq8pSlESPbwebWDAyRF/8PReG589wU=;
 b=TuyMRiflCiRTT1GUQOppIfz2Qq9r7ajn8VUZ5J/sI5uV8Di1Xti3iOUvBwTTpJ3P95tvB3
 MKIB8ODc0YF1GhrlKvQQHYEzEijaXQx47JJx2B4XDkyrtf1FQIEMjp3/pNvl55yJmHylW8
 v6P7IWhKKNbtTyMlJNyhGOP4BfbNnVE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-whhrAXHOMOaok1E-UXtBsQ-1; Tue,
 04 Nov 2025 12:54:46 -0500
X-MC-Unique: whhrAXHOMOaok1E-UXtBsQ-1
X-Mimecast-MFC-AGG-ID: whhrAXHOMOaok1E-UXtBsQ_1762278886
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CB811800675; Tue,  4 Nov 2025 17:54:46 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD0EC1800451; Tue,  4 Nov 2025 17:54:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 12/27] aio-posix: add fdmon_ops->dispatch()
Date: Tue,  4 Nov 2025 18:54:00 +0100
Message-ID: <20251104175415.525388-13-kwolf@redhat.com>
In-Reply-To: <20251104175415.525388-1-kwolf@redhat.com>
References: <20251104175415.525388-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The ppoll and epoll file descriptor monitoring implementations rely on
the event loop's generic file descriptor, timer, and BH dispatch code to
invoke user callbacks.

The io_uring file descriptor monitoring implementation will need
io_uring-specific dispatch logic for CQE handlers for custom SQEs.

Introduce a new FDMonOps ->dispatch() callback that allows file
descriptor monitoring implementations to invoke user callbacks. The next
patch will use this new callback.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20251104022933.618123-13-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/aio.h | 19 +++++++++++++++++++
 util/aio-posix.c    |  9 +++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/block/aio.h b/include/block/aio.h
index 9562733fa7..b266daa58f 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -107,6 +107,25 @@ typedef struct {
      */
     bool (*need_wait)(AioContext *ctx);
 
+    /*
+     * dispatch:
+     * @ctx: the AioContext
+     *
+     * Dispatch any work that is specific to this file descriptor monitoring
+     * implementation. Usually the event loop's generic file descriptor
+     * monitoring, BH, and timer dispatching code is sufficient, but file
+     * descriptor monitoring implementations offering additional functionality
+     * may need to implement this function for custom behavior. Called at a
+     * point in the event loop when it is safe to invoke user-defined
+     * callbacks.
+     *
+     * This function is optional and may be NULL.
+     *
+     * Returns: true if progress was made (see aio_poll()'s return value),
+     * false otherwise.
+     */
+    bool (*dispatch)(AioContext *ctx);
+
     /*
      * gsource_prepare:
      * @ctx: the AioContext
diff --git a/util/aio-posix.c b/util/aio-posix.c
index c0285a26a3..6ff36b6e51 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -385,10 +385,15 @@ void aio_dispatch(AioContext *ctx)
     AioHandlerList ready_list = QLIST_HEAD_INITIALIZER(ready_list);
 
     qemu_lockcnt_inc(&ctx->list_lock);
+
     aio_bh_poll(ctx);
 
     ctx->fdmon_ops->gsource_dispatch(ctx, &ready_list);
 
+    if (ctx->fdmon_ops->dispatch) {
+        ctx->fdmon_ops->dispatch(ctx);
+    }
+
     /* block_ns is 0 because polling is disabled in the glib event loop */
     aio_dispatch_ready_handlers(ctx, &ready_list, 0);
 
@@ -707,6 +712,10 @@ bool aio_poll(AioContext *ctx, bool blocking)
         block_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start;
     }
 
+    if (ctx->fdmon_ops->dispatch) {
+        progress |= ctx->fdmon_ops->dispatch(ctx);
+    }
+
     progress |= aio_bh_poll(ctx);
     progress |= aio_dispatch_ready_handlers(ctx, &ready_list, block_ns);
 
-- 
2.51.1


