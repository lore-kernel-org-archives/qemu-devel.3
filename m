Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C827DC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 20:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf2r3-0008CG-8X; Thu, 24 Jul 2025 16:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uf2qa-0006vn-Bo
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uf2qX-0007W1-F1
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753390036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yw5wu0Bvtn1lGx974paDUSobpem7+N41X/8z4DQO0zY=;
 b=hlelHWjR4MqBx82LFrhMPT6m0Iw2dnfOC+vfLDQO9XUMobgfSlXs3PgJY32YftevNv0EU6
 f2Thd/8koaqKRG4CIt/eBK01E4ohMvDWrMzNGEdws8ko7rXheB4GeB7QsyDMYmOa9Cbx7f
 d7wapr+qNmdcaxyoifJktXS4xWxOmSo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-zpkpmTvyPo6-XBMwd0zDPQ-1; Thu,
 24 Jul 2025 16:47:12 -0400
X-MC-Unique: zpkpmTvyPo6-XBMwd0zDPQ-1
X-Mimecast-MFC-AGG-ID: zpkpmTvyPo6-XBMwd0zDPQ_1753390031
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B9191955BC5; Thu, 24 Jul 2025 20:47:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.247])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 624451800298; Thu, 24 Jul 2025 20:47:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Brian Song <hibriansong@gmail.com>,
 qemu-block@nongnu.org, Bernd Schubert <bschubert@ddn.com>,
 Kevin Wolf <kwolf@redhat.com>, h0lyalg0rithm@git.sr.ht,
 Fam Zheng <fam@euphon.net>
Subject: [RFC 2/3] aio-posix: enable IORING_SETUP_SINGLE_ISSUER
Date: Thu, 24 Jul 2025 16:47:01 -0400
Message-ID: <20250724204702.576637-3-stefanha@redhat.com>
In-Reply-To: <20250724204702.576637-1-stefanha@redhat.com>
References: <20250724204702.576637-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

IORING_SETUP_SINGLE_ISSUER enables optimizations in the host Linux
kernel's io_uring code when the io_uring context is only used from a
single thread. This is true is QEMU because io_uring SQEs are submitted
from the same thread that processes the CQEs.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/fdmon-io_uring.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 28b93c8ab9..4798439097 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -456,13 +456,30 @@ static const FDMonOps fdmon_io_uring_ops = {
     .add_sqe = fdmon_io_uring_add_sqe,
 };
 
+static inline bool is_creating_iothread(void)
+{
+    return qemu_get_thread_id() != getpid();
+}
+
 void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
 {
     int ret;
+    /* TODO only enable these flags if they are available in the host's kernel headers */
+    unsigned flags = 0;
 
     ctx->io_uring_fd_tag = NULL;
 
-    ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, 0);
+    /*
+     * The main thread's AioContexts are created from the main loop thread but
+     * may be accessed from multiple threads (e.g. vCPUs or the migration
+     * thread). IOThread AioContexts are only accessed from the IOThread
+     * itself.
+     */
+    if (is_creating_iothread()) {
+        flags = IORING_SETUP_SINGLE_ISSUER;
+    }
+
+    ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, flags);
     if (ret != 0) {
         error_setg_errno(errp, -ret, "Failed to initialize io_uring");
         return;
-- 
2.50.1


