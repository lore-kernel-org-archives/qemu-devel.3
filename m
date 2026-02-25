Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F395EEFD207
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 08:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvA1y-0000KV-Dj; Wed, 25 Feb 2026 03:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vvA1w-0000IK-Cu
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:14:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vvA1v-0001n0-1y
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772007238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IwK+4U3rA5gsM5s8bZtHt3GmDGzP9xFTquIJLV4EUZ8=;
 b=E9dikzebZt8k4K2mdAj/1rvbCA99blah5dc8jAy0fw+tRN6yvOj3WrwY1q91k3AGH4vZ0/
 vLAqgQi4ExmYtA0p9pdez7ykB5bxTv9ahT85bnGfljhNYYVYeP+5Jhq63WxrFEAx0TeUGn
 d5E6kfNHxwYrEQkI6Omoo2jveLFnii8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-9XxlWmXXM6eZbo-Q3GGWOA-1; Wed,
 25 Feb 2026 03:13:54 -0500
X-MC-Unique: 9XxlWmXXM6eZbo-Q3GGWOA-1
X-Mimecast-MFC-AGG-ID: 9XxlWmXXM6eZbo-Q3GGWOA_1772007233
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 784211800464; Wed, 25 Feb 2026 08:13:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13A331955F43; Wed, 25 Feb 2026 08:13:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 3/4] aio-posix: enable IORING_SETUP_COOP_TASKRUN |
 IORING_SETUP_TASKRUN_FLAG
Date: Wed, 25 Feb 2026 16:13:35 +0800
Message-ID: <20260225081336.1639325-4-stefanha@redhat.com>
In-Reply-To: <20260225081336.1639325-1-stefanha@redhat.com>
References: <20260225081336.1639325-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The IORING_SETUP_COOP_TASKRUN flag reduces interprocessor interrupts
when an io_uring event occurs on a different CPU. The idea is that the
QEMU thread will wait for a CQE anyway, so there is no need to interrupt
the CPU that it is on.

The IORING_SETUP_TASKRUN_FLAG ensures that QEMU's io_uring CQ ring
polling still works with COOP_TASKRUN. The kernel will set a flag in the
SQ ring (this is not a typo, the flag is located in the SQ ring even
though it pertains to the CQ ring) that can be polled from userspace.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/fdmon-io_uring.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index ec056b4818..2e2c0e6785 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -423,13 +423,16 @@ static int fdmon_io_uring_wait(AioContext *ctx, AioHandlerList *ready_list,
 
 static bool fdmon_io_uring_need_wait(AioContext *ctx)
 {
+    struct io_uring *ring = &ctx->fdmon_io_uring;
+
     /* Have io_uring events completed? */
-    if (io_uring_cq_ready(&ctx->fdmon_io_uring)) {
+    if (io_uring_cq_ready(ring) ||
+        IO_URING_READ_ONCE(*ring->sq.kflags) & IORING_SQ_TASKRUN) {
         return true;
     }
 
     /* Are there pending sqes to submit? */
-    if (io_uring_sq_ready(&ctx->fdmon_io_uring)) {
+    if (io_uring_sq_ready(ring)) {
         return true;
     }
 
@@ -459,7 +462,15 @@ static inline bool is_creating_iothread(void)
 
 bool fdmon_io_uring_setup(AioContext *ctx, Error **errp)
 {
-    unsigned flags = 0;
+    /* Enable modern flags supported by the host kernel */
+    unsigned flags =
+#ifdef IORING_SETUP_COOP_TASKRUN
+        IORING_SETUP_COOP_TASKRUN |
+#endif
+#ifdef IORING_SETUP_TASKRUN_FLAG
+        IORING_SETUP_TASKRUN_FLAG |
+#endif
+        0;
     int ret;
 
     /*
-- 
2.53.0


