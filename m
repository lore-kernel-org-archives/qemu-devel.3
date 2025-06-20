Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B572FC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 00:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSPLs-0000l0-CX; Thu, 19 Jun 2025 20:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uSPLn-0000k9-NZ
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 20:11:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uSPLm-0004si-4i
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 20:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750378268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+qfxH0nENqSDmAclKj0H0C2iaEV2EfBZ0CFkQEd0UE=;
 b=K7uz2WkwDEHXMdcMyZcoBOua2ST3SsgK6EZ54HTwIuSb6ojoq+BBGdNyUj56tvLE1Uzpky
 XwlQ1pn18jr2IXPm6ATUmeTtGFEbUQASmeYhApQC7L4YiBIQ3QZxSyGqOYE5tUpufyRTcp
 jRc4xBinz/jbzGxs39mPq/CJZ2oN2ME=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-StdrGVkGPW2npmHikJOHOg-1; Thu,
 19 Jun 2025 20:11:06 -0400
X-MC-Unique: StdrGVkGPW2npmHikJOHOg-1
X-Mimecast-MFC-AGG-ID: StdrGVkGPW2npmHikJOHOg_1750378265
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DBB81956086; Fri, 20 Jun 2025 00:11:05 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E77E180035E; Fri, 20 Jun 2025 00:11:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, eblake@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, hibriansong@gmail.com
Subject: [PATCH v2 10/12] aio-posix: avoid EventNotifier for cqe_handler_bh
Date: Thu, 19 Jun 2025 20:08:26 -0400
Message-ID: <20250620000829.1426291-11-stefanha@redhat.com>
In-Reply-To: <20250620000829.1426291-1-stefanha@redhat.com>
References: <20250620000829.1426291-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

fdmon_ops->wait() is called with notify_me enabled. This makes it an
expensive place to call qemu_bh_schedule() because aio_notify() invokes
write(2) on the EventNotifier.

Moving qemu_bh_schedule() after notify_me is reset improves IOPS from
270k to 300k IOPS with --blockdev file,aio=io_uring.

I considered alternatives:
1. Introducing a variant of qemu_bh_schedule() that skips aio_notify().
   This only makes sense within the AioContext and fdmon implementation
   itself and is therefore a specialized internal API. I don't like
   that.
2. Changing fdmon_ops->wait() so implementors can reset notify_me
   themselves. This makes things complex and the other fdmon
   implementations don't need it, so it doesn't seem like a good
   solution.

So in the end I moved the qemu_bh_schedule() call from fdmon-io_uring.c
to aio-posix.c. It's ugly but straightforward.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 util/aio-posix.c      | 11 +++++++++++
 util/fdmon-io_uring.c | 11 ++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index df945312b3..20b11e5650 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -700,6 +700,17 @@ bool aio_poll(AioContext *ctx, bool blocking)
                              qatomic_read(&ctx->notify_me) - 2);
     }
 
+#ifdef CONFIG_LINUX_IO_URING
+    /*
+     * This is part of fdmon-io_uring.c but it's more efficient to do it here
+     * after notify_me has been reset. That way qemu_bh_schedule() ->
+     * aio_notify() does not write the EventNotifier.
+     */
+    if (!QSIMPLEQ_EMPTY(&ctx->cqe_handler_ready_list)) {
+        qemu_bh_schedule(ctx->cqe_handler_bh);
+    }
+#endif
+
     aio_notify_accept(ctx);
 
     /* Calculate blocked time for adaptive polling */
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 6d4f33d2de..91e1a2de5d 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -327,8 +327,12 @@ static bool process_cqe(AioContext *ctx,
     }
 
     cqe_handler->cqe = *cqe;
+
+    /*
+     * aio_poll() and fdmon_io_uring_gsource_dispatch() schedule cqe_handler_bh
+     * when the list is non-empty.
+     */
     QSIMPLEQ_INSERT_TAIL(&ctx->cqe_handler_ready_list, cqe_handler, next);
-    qemu_bh_schedule(ctx->cqe_handler_bh);
     return false;
 }
 
@@ -379,6 +383,11 @@ static void fdmon_io_uring_gsource_dispatch(AioContext *ctx,
                                             AioHandlerList *ready_list)
 {
     process_cq_ring(ctx, ready_list);
+
+    /* Ensure CqeHandlers enqueued by process_cq_ring() will run */
+    if (!QSIMPLEQ_EMPTY(&ctx->cqe_handler_ready_list)) {
+        qemu_bh_schedule(ctx->cqe_handler_bh);
+    }
 }
 
 static int fdmon_io_uring_wait(AioContext *ctx, AioHandlerList *ready_list,
-- 
2.49.0


