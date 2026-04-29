Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BAACCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9Xr-0002fH-4u; Wed, 29 Apr 2026 14:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI9Xd-0002cW-NA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI9XY-0003he-PU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777486899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6iFIOBsqvi6+k9V427YKtoDvLloAhnlHP+JZ25es5R8=;
 b=U07uF+GiM7s3oB6S2QiwYU2OEds8xXoysnZGD3qmb9RLuP6+tr/fy6av5Baz4ctKeV9gLR
 oZAMn9K128p4uzAy+II5L4ESj01BLcPao1pS997h9pKyBsDFvewA33uvQ6qigEuIYvtavd
 upJESFtIwv3mLoyu54z+317g5EsXAUY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-FgJw67dJMraYE63242TgqA-1; Wed,
 29 Apr 2026 14:21:38 -0400
X-MC-Unique: FgJw67dJMraYE63242TgqA-1
X-Mimecast-MFC-AGG-ID: FgJw67dJMraYE63242TgqA_1777486896
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AF171800652; Wed, 29 Apr 2026 18:21:36 +0000 (UTC)
Received: from localhost (unknown [10.44.33.46])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E759195608E; Wed, 29 Apr 2026 18:21:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PULL 1/3] aio-poll: avoid unnecessary polling time computation
Date: Wed, 29 Apr 2026 14:21:25 -0400
Message-ID: <20260429182127.219776-2-stefanha@redhat.com>
In-Reply-To: <20260429182127.219776-1-stefanha@redhat.com>
References: <20260429182127.219776-1-stefanha@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jaehoon Kim <jhkim@linux.ibm.com>

Nodes are no longer added to poll_aio_handlers when adaptive polling is
disabled, preventing unnecessary try_poll_mode() calls. This avoids
iterating over all nodes to compute max_ns unnecessarily when polling
is disabled.

Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20260423195918.661299-2-jhkim@linux.ibm.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/aio-posix.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 488d964611..351847c6fb 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -307,9 +307,8 @@ static bool aio_dispatch_handler(AioContext *ctx, AioHandler *node)
      * fdmon_supports_polling(), but only until the fd fires for the first
      * time.
      */
-    if (!QLIST_IS_INSERTED(node, node_deleted) &&
-        !QLIST_IS_INSERTED(node, node_poll) &&
-        node->io_poll) {
+    if (ctx->poll_max_ns && !QLIST_IS_INSERTED(node, node_deleted) &&
+        !QLIST_IS_INSERTED(node, node_poll) && node->io_poll) {
         trace_poll_add(ctx, node, node->pfd.fd, revents);
         if (ctx->poll_started && node->io_poll_begin) {
             node->io_poll_begin(node->opaque);
@@ -631,7 +630,7 @@ static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
 bool aio_poll(AioContext *ctx, bool blocking)
 {
     AioHandlerList ready_list = QLIST_HEAD_INITIALIZER(ready_list);
-    bool progress;
+    bool progress = false;
     bool use_notify_me;
     int64_t timeout;
     int64_t start = 0;
@@ -656,7 +655,9 @@ bool aio_poll(AioContext *ctx, bool blocking)
     }
 
     timeout = blocking ? aio_compute_timeout(ctx) : 0;
-    progress = try_poll_mode(ctx, &ready_list, &timeout);
+    if (ctx->poll_max_ns != 0) {
+        progress = try_poll_mode(ctx, &ready_list, &timeout);
+    }
     assert(!(timeout && progress));
 
     /*
-- 
2.54.0


