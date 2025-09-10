Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41621CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 18:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPEW-0005R8-RL; Wed, 10 Sep 2025 14:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwPDh-0004Un-DZ
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwPDe-00055Y-LE
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757527616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8G9SH3P4RQbLnkpw+zUh6T+aeJe+fBgecMc4c5oGF3w=;
 b=HV2rZ/wrXK1mFUVHvHJe4BDXYGCAYX5NLg4FKyxkMayChxcyE87igOa3rleRQ03BH9l6M7
 xo2wKuwn+oiqVf+unkjqaVCzV+IcFurHUAXDGVKouuuo74nHra44of5SBfg6DFUA6pHI6I
 V0JiFR6861bxV+sJof4PmjfmEkgqMT0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-2cWktSxrO6OO4eEfmFKceA-1; Wed,
 10 Sep 2025 14:06:53 -0400
X-MC-Unique: 2cWktSxrO6OO4eEfmFKceA-1
X-Mimecast-MFC-AGG-ID: 2cWktSxrO6OO4eEfmFKceA_1757527610
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C51E618002C6; Wed, 10 Sep 2025 18:06:50 +0000 (UTC)
Received: from localhost (unknown [10.2.17.66])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D5C21955F24; Wed, 10 Sep 2025 18:06:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Aarushi Mehta <mehta.aaru20@gmail.com>, Fam Zheng <fam@euphon.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, hibriansong@gmail.com, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 07/12] aio: add errp argument to aio_context_setup()
Date: Wed, 10 Sep 2025 13:56:58 -0400
Message-ID: <20250910175703.374499-8-stefanha@redhat.com>
In-Reply-To: <20250910175703.374499-1-stefanha@redhat.com>
References: <20250910175703.374499-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When aio_context_new() -> aio_context_setup() fails at startup it
doesn't really matter whether errors are returned to the caller or the
process terminates immediately.

However, it is not acceptable to terminate when hotplugging --object
iothread at runtime. Refactor aio_context_setup() so that errors can be
propagated. The next commit will set errp when fdmon_io_uring_setup()
fails.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/aio.h | 3 ++-
 util/aio-posix.c    | 2 +-
 util/aio-win32.c    | 2 +-
 util/async.c        | 7 ++++++-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 2760f308f5..d919d7c8f4 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -718,10 +718,11 @@ void qemu_set_current_aio_context(AioContext *ctx);
 /**
  * aio_context_setup:
  * @ctx: the aio context
+ * @errp: error pointer
  *
  * Initialize the aio context.
  */
-void aio_context_setup(AioContext *ctx);
+void aio_context_setup(AioContext *ctx, Error **errp);
 
 /**
  * aio_context_destroy:
diff --git a/util/aio-posix.c b/util/aio-posix.c
index bebd9ce3a2..bbe470c145 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -718,7 +718,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
     return progress;
 }
 
-void aio_context_setup(AioContext *ctx)
+void aio_context_setup(AioContext *ctx, Error **errp)
 {
     ctx->fdmon_ops = &fdmon_poll_ops;
     ctx->epollfd = -1;
diff --git a/util/aio-win32.c b/util/aio-win32.c
index 34c4074133..4ba401ff92 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -419,7 +419,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
     return progress;
 }
 
-void aio_context_setup(AioContext *ctx)
+void aio_context_setup(AioContext *ctx, Error **errp)
 {
 }
 
diff --git a/util/async.c b/util/async.c
index 34aaab4e9e..2bb7e1f3c1 100644
--- a/util/async.c
+++ b/util/async.c
@@ -577,6 +577,7 @@ static void co_schedule_bh_cb(void *opaque)
 
 AioContext *aio_context_new(Error **errp)
 {
+    ERRP_GUARD();
     int ret;
     AioContext *ctx;
 
@@ -590,7 +591,11 @@ AioContext *aio_context_new(Error **errp)
         goto fail;
     }
 
-    aio_context_setup(ctx);
+    aio_context_setup(ctx, errp);
+    if (*errp) {
+        event_notifier_cleanup(&ctx->notifier);
+        goto fail;
+    }
 
     g_source_set_can_recurse(&ctx->source, true);
     qemu_lockcnt_init(&ctx->list_lock);
-- 
2.51.0


