Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1035C25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 19:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s43fp-00030P-Po; Mon, 06 May 2024 15:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s43fa-0002rV-6b
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s43fY-0000B9-FS
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715022395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EaNV6j44T8hFyYd9mWj4JUcAH/rY+FTEpab1tHrtqVI=;
 b=HSeIZAkZ4thSb/KP7ySP5JIoVIj71yHHyqiGoMCJYFq5vs7GA0BpQJf34i3FE9L1ghuYbg
 xvwX/IwY+PUt034e+GdlpVutynVPzpL9DWHSAOvFcfITAOf2ueTykX4HxaOaVl5UDMQ1f/
 DOVQtHMXl+6P1erA0NPm1+69OMkMj/Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-rbqpOyRaMq6o3k0wNx0F8A-1; Mon, 06 May 2024 15:06:31 -0400
X-MC-Unique: rbqpOyRaMq6o3k0wNx0F8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F65818065AB;
 Mon,  6 May 2024 19:06:31 +0000 (UTC)
Received: from localhost (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 568DB40C6DAE;
 Mon,  6 May 2024 19:06:30 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 2/2] aio: warn about iohandler_ctx special casing
Date: Mon,  6 May 2024 15:06:22 -0400
Message-ID: <20240506190622.56095-3-stefanha@redhat.com>
In-Reply-To: <20240506190622.56095-1-stefanha@redhat.com>
References: <20240506190622.56095-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The main loop has two AioContexts: qemu_aio_context and iohandler_ctx.
The main loop runs them both, but nested aio_poll() calls on
qemu_aio_context exclude iohandler_ctx.

Which one should qemu_get_current_aio_context() return when called from
the main loop? Document that it's always qemu_aio_context.

This has subtle effects on functions that use
qemu_get_current_aio_context(). For example, aio_co_reschedule_self()
does not work when moving from iohandler_ctx to qemu_aio_context because
qemu_get_current_aio_context() does not differentiate these two
AioContexts.

Document this in order to reduce the chance of future bugs.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/block/aio.h b/include/block/aio.h
index 8378553eb9..4ee81936ed 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -629,6 +629,9 @@ void aio_co_schedule(AioContext *ctx, Coroutine *co);
  *
  * Move the currently running coroutine to new_ctx. If the coroutine is already
  * running in new_ctx, do nothing.
+ *
+ * Note that this function cannot reschedule from iohandler_ctx to
+ * qemu_aio_context.
  */
 void coroutine_fn aio_co_reschedule_self(AioContext *new_ctx);
 
@@ -661,6 +664,9 @@ void aio_co_enter(AioContext *ctx, Coroutine *co);
  * If called from an IOThread this will be the IOThread's AioContext.  If
  * called from the main thread or with the "big QEMU lock" taken it
  * will be the main loop AioContext.
+ *
+ * Note that the return value is never the main loop's iohandler_ctx and the
+ * return value is the main loop AioContext instead.
  */
 AioContext *qemu_get_current_aio_context(void);
 
-- 
2.45.0


