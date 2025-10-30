Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7A4CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUUF-0004iB-Ne; Thu, 30 Oct 2025 11:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vEUU9-0004h6-Nj
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vEUTh-0006VQ-IZ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761837732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIn2kCTSgoGtJeeRn/iR5+f/1Vxi27UBr0nvXmUMNus=;
 b=Jt7b1oKxuXjTqQ4kMngH7ZRFBChjk4emB9dqM+EKWxe3RUijoZ4FCVvaShdVCovzbIJnGc
 OimexNJDbw3DhJSdHiupiy4oiErt3W9HZrF89s/0aBwLAun1SQxBa+Ff6yzMPJ/8I8W0Mf
 OvICE8sc7l4P2I425gtdPwKcCIkxzao=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-GojTKxcUNL6Sd3ByIfFkMA-1; Thu,
 30 Oct 2025 11:22:09 -0400
X-MC-Unique: GojTKxcUNL6Sd3ByIfFkMA-1
X-Mimecast-MFC-AGG-ID: GojTKxcUNL6Sd3ByIfFkMA_1761837728
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31F171809C98; Thu, 30 Oct 2025 15:22:08 +0000 (UTC)
Received: from localhost (unknown [10.2.16.94])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A84F1955BE3; Thu, 30 Oct 2025 15:22:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 hibriansong@gmail.com, eblake@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Subject: [RESEND PATCH v5 10/13] aio-posix: add fdmon_ops->dispatch()
Date: Thu, 30 Oct 2025 11:21:46 -0400
Message-ID: <20251030152150.470170-11-stefanha@redhat.com>
In-Reply-To: <20251030152150.470170-1-stefanha@redhat.com>
References: <20251030152150.470170-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The ppoll and epoll file descriptor monitoring implementations rely on
the event loop's generic file descriptor, timer, and BH dispatch code to
invoke user callbacks.

The io_uring file descriptor monitoring implementation will need
io_uring-specific dispatch logic for CQE handlers for custom SQEs.

Introduce a new FDMonOps ->dispatch() callback that allows file
descriptor monitoring implementations to invoke user callbacks. The next
patch will use this new callback.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v5:
- Add patch to introduce FDMonOps->dispatch() callback [Kevin]
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
2.51.0


