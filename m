Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BCEEA4FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 14:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWoE-0004IS-TC; Mon, 23 Feb 2026 09:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vuWo3-0004B6-Gk
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 09:21:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vuWo1-0005YU-EW
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 09:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771856459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gd3OmvsplKIPl813mRZWly59V7xqaiRqqJWFXFoYp/Y=;
 b=gwpKr5WSiypHKV7rViQMdVkiZauhUkInMnkI03i1UDIznm9QYJkDOybWECr2HZOdWLfTyc
 nfo0o057EYHc4SGDzu4j9VbrC2HG6ZLC9Hj2WgEmhla7R11+4m4GIAD1MhEFF5ed3L9Fry
 yFmOKDoJZtiF8l2iYCQMiTd8isjN7dE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-jNruTWd1NHqBBVWbzeKzXg-1; Mon,
 23 Feb 2026 09:20:54 -0500
X-MC-Unique: jNruTWd1NHqBBVWbzeKzXg-1
X-Mimecast-MFC-AGG-ID: jNruTWd1NHqBBVWbzeKzXg_1771856453
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 282401800366; Mon, 23 Feb 2026 14:20:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.160])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B7D41800465; Mon, 23 Feb 2026 14:20:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PULL 2/2] fdmon-io_uring: check CQ ring directly in gsource_check
Date: Mon, 23 Feb 2026 09:20:31 -0500
Message-ID: <20260223142031.1397832-3-stefanha@redhat.com>
In-Reply-To: <20260223142031.1397832-1-stefanha@redhat.com>
References: <20260223142031.1397832-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

From: Jens Axboe <axboe@kernel.dk>

gsource_check() only looks at the ppoll revents for the io_uring fd,
but CQEs can be posted during gsource_prepare()'s io_uring_submit()
call via kernel task_work processing on syscall exit. These completions
are already sitting in the CQ ring but the ring fd may not be signaled
yet, causing gsource_check() to return false.

Add a fallback io_uring_cq_ready() check so completions that arrive
during submission are dispatched immediately rather than waiting for
the next ppoll() cycle.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Message-ID: <20260213143225.161043-3-axboe@kernel.dk>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/fdmon-io_uring.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index d0b56127c6..b81e412402 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -344,7 +344,19 @@ static void fdmon_io_uring_gsource_prepare(AioContext *ctx)
 static bool fdmon_io_uring_gsource_check(AioContext *ctx)
 {
     gpointer tag = ctx->io_uring_fd_tag;
-    return g_source_query_unix_fd(&ctx->source, tag) & G_IO_IN;
+
+    /* Check ppoll revents (normal path) */
+    if (g_source_query_unix_fd(&ctx->source, tag) & G_IO_IN) {
+        return true;
+    }
+
+    /*
+     * Also check for CQEs that may have been posted during prepare's
+     * io_uring_submit() via task_work on syscall exit.  Without this,
+     * the main loop can miss completions and sleep in ppoll() until the
+     * next timer fires.
+     */
+    return io_uring_cq_ready(&ctx->fdmon_io_uring);
 }
 
 /* Dispatch CQE handlers that are ready */
-- 
2.53.0


