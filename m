Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427DBC87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 20:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf2qu-0007R8-Tz; Thu, 24 Jul 2025 16:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uf2qa-0006vs-Gf
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uf2qX-0007WD-Fw
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753390037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54Uyx9v0sUl+tZRKzDaCd1E6kr+H1FTytSmUg5Bty6s=;
 b=NsDYTKc9nW3aUNDZsfPAc0X/l4SdgSvVtVmd4c/F8JVuJsjxxuUJRwvGzRNe5s6wKBusQe
 fUsgYf+eE+A7NCXcU2g33G0AbGZsi0Obsyq0PFWMfZUCBWYWRk1rOwZGWMHou2hcloBFrH
 ypHIIZKrsR9s3Zx/FFlji60rAB48Zt8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-H9uZTvTkOhmESyzTEz0Mig-1; Thu,
 24 Jul 2025 16:47:14 -0400
X-MC-Unique: H9uZTvTkOhmESyzTEz0Mig-1
X-Mimecast-MFC-AGG-ID: H9uZTvTkOhmESyzTEz0Mig_1753390033
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 086F0180034A; Thu, 24 Jul 2025 20:47:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.247])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 048FD18001DB; Thu, 24 Jul 2025 20:47:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Brian Song <hibriansong@gmail.com>,
 qemu-block@nongnu.org, Bernd Schubert <bschubert@ddn.com>,
 Kevin Wolf <kwolf@redhat.com>, h0lyalg0rithm@git.sr.ht,
 Fam Zheng <fam@euphon.net>
Subject: [RFC 3/3] aio-posix: enable IORING_SETUP_COOP_TASKRUN |
 IORING_SETUP_TASKRUN_FLAG
Date: Thu, 24 Jul 2025 16:47:02 -0400
Message-ID: <20250724204702.576637-4-stefanha@redhat.com>
In-Reply-To: <20250724204702.576637-1-stefanha@redhat.com>
References: <20250724204702.576637-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 util/fdmon-io_uring.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 4798439097..649dc18907 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -428,13 +428,16 @@ static int fdmon_io_uring_wait(AioContext *ctx, AioHandlerList *ready_list,
 
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
 
@@ -465,7 +468,7 @@ void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
 {
     int ret;
     /* TODO only enable these flags if they are available in the host's kernel headers */
-    unsigned flags = 0;
+    unsigned flags = IORING_SETUP_COOP_TASKRUN | IORING_SETUP_TASKRUN_FLAG;
 
     ctx->io_uring_fd_tag = NULL;
 
-- 
2.50.1


