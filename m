Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEA6CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 20:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vECtd-0003cJ-Ma; Wed, 29 Oct 2025 16:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vECtG-0003VU-So
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 16:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vECsc-00057L-Ah
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 16:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761770078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIn2kCTSgoGtJeeRn/iR5+f/1Vxi27UBr0nvXmUMNus=;
 b=VRHhKyX/qx3HZEQhhWGNwjuz9MiihZVvSlSfvT2snQHTgYOH0XJjPC8jzHYgJ3ep+iK/Hx
 kSdIoUbw49a89YcMW/F+PitLi+tBe+SOcJ5KKpnfVIIP17j6VR8bcKfvouHSi6IP/gg4Bs
 C+K4gsvVct7MfGwcKpn0vSRcr0kBVmc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-ucemEca8PiaJ_fHyC6ApUA-1; Wed,
 29 Oct 2025 16:34:35 -0400
X-MC-Unique: ucemEca8PiaJ_fHyC6ApUA-1
X-Mimecast-MFC-AGG-ID: ucemEca8PiaJ_fHyC6ApUA_1761770074
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54FC31800743; Wed, 29 Oct 2025 20:34:34 +0000 (UTC)
Received: from localhost (unknown [10.2.17.43])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D12DB30001A2; Wed, 29 Oct 2025 20:34:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, hibriansong@gmail.com,
 qemu-block@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 eblake@redhat.com
Subject: [PATCH v5 10/12] aio-posix: add fdmon_ops->dispatch()
Date: Wed, 29 Oct 2025 16:34:09 -0400
Message-ID: <20251029203411.445852-11-stefanha@redhat.com>
In-Reply-To: <20251029203411.445852-1-stefanha@redhat.com>
References: <20251029203411.445852-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


