Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0674EEFD206
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 08:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvA1u-0000HT-1M; Wed, 25 Feb 2026 03:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vvA1s-0000Gx-9W
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:13:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vvA1q-0001ma-RE
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772007234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L83tmmVEdGQV/uGUec+kZ4/BaRD7oWY0T8JaJvvXus0=;
 b=TFFU/G+cHAhvqZs+43nCf8+kK4RFEPAcXhq3/tOjuXhVXldyQCimWaJxkZTlB9XpCIdBb5
 gemDkss0n4njhD8aGHzBSc3tMz7gPksIkc5fE6GbjOIYCZMJ0SRnaRX+yl3ZhoY/f2Ztv3
 yCPuXapzKZfvi1OeWGS2WDLplawH2Fw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-nPinB27OO16c3e1UBhRgvA-1; Wed,
 25 Feb 2026 03:13:50 -0500
X-MC-Unique: nPinB27OO16c3e1UBhRgvA-1
X-Mimecast-MFC-AGG-ID: nPinB27OO16c3e1UBhRgvA_1772007229
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0771B19560AD; Wed, 25 Feb 2026 08:13:49 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C6E71800348; Wed, 25 Feb 2026 08:13:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 2/4] aio-posix: enable IORING_SETUP_SINGLE_ISSUER
Date: Wed, 25 Feb 2026 16:13:34 +0800
Message-ID: <20260225081336.1639325-3-stefanha@redhat.com>
In-Reply-To: <20260225081336.1639325-1-stefanha@redhat.com>
References: <20260225081336.1639325-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

IORING_SETUP_SINGLE_ISSUER enables optimizations in the host Linux
kernel's io_uring code when the io_uring context is only used from a
single thread. This is true is QEMU because io_uring SQEs are submitted
from the same thread that processes the CQEs.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/fdmon-io_uring.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index d0b56127c6..ec056b4818 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -452,13 +452,31 @@ static const FDMonOps fdmon_io_uring_ops = {
     .add_sqe = fdmon_io_uring_add_sqe,
 };
 
+static inline bool is_creating_iothread(void)
+{
+    return qemu_get_thread_id() != getpid();
+}
+
 bool fdmon_io_uring_setup(AioContext *ctx, Error **errp)
 {
+    unsigned flags = 0;
     int ret;
 
+    /*
+     * The main thread's AioContexts are created from the main loop thread but
+     * may be accessed from multiple threads (e.g. vCPUs or the migration
+     * thread). IOThread AioContexts are only accessed from the IOThread
+     * itself.
+     */
+#if IORING_SETUP_SINGLE_ISSUER
+    if (is_creating_iothread()) {
+        flags |= IORING_SETUP_SINGLE_ISSUER;
+    }
+#endif
+
     ctx->io_uring_fd_tag = NULL;
 
-    ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, 0);
+    ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, flags);
     if (ret != 0) {
         error_setg_errno(errp, -ret, "Failed to initialize io_uring");
         return false;
-- 
2.53.0


