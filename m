Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81064C27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 17:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH5Qv-00007x-4w; Tue, 11 Jun 2024 13:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH5Qt-00006t-Sq
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH5Qs-0008UT-Gr
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718127437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ekDyI0XrbGkORk/+Y7DVMqIWcACoq55sA4lf/J9YDMA=;
 b=RnIB1mEXWpT7SomabiltiMKd2L5cLuvVdal/YvYqEt8tDzEA0T5Yx+AXVVGHNv7gu3V0ra
 UXolKcQunMBIja73cLbCr21Qcmkz2Ni8JjK2E//dlw3r2soon8yxleog8ad/Y73/cmYr08
 aPwnVObMt/doI+UEru9XruWLKg5lorc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-4Nn3CKfaPj-wGpzR5HfSNQ-1; Tue,
 11 Jun 2024 13:37:11 -0400
X-MC-Unique: 4Nn3CKfaPj-wGpzR5HfSNQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E5A619560BD; Tue, 11 Jun 2024 17:37:10 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.130])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2B5619560AB; Tue, 11 Jun 2024 17:37:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 3/8] aio: warn about iohandler_ctx special casing
Date: Tue, 11 Jun 2024 19:36:53 +0200
Message-ID: <20240611173658.231831-4-kwolf@redhat.com>
In-Reply-To: <20240611173658.231831-1-kwolf@redhat.com>
References: <20240611173658.231831-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Message-ID: <20240506190622.56095-3-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.45.2


