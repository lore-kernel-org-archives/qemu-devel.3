Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0C91125875
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PON-0006oE-JS; Wed, 11 Mar 2026 15:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0POM-0006kH-Cn; Wed, 11 Mar 2026 15:38:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0POK-0000ek-Rl; Wed, 11 Mar 2026 15:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257669; bh=jQENt2AgbC8mZlxJWiyfg+ZVOWKHlOxsAGIiAZSIphk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=X3SVdkPzeuTkqxA5h2CHpjXHl1QRSB5JDGLQaqRxJzvvMzoFj+5UYSmaRHmdu3c2z
 IMivtLFhkeuCYV9DScEsFYp3ezxMAw6kodL3wd24avngKEDO5SigDyf957J1owg/A1
 Xo7zP8ByP4nen595S/Pcxh0rLn4hOgAy4ThEzxhBaN0hXpt0yfngvrBSFQW3Xk6/hO
 GlmryJ5VucAHVNNQt4UJVQ4J7HJbJLKZDOWHMLsBMH8uV7uw5rPtDur2lOTpNaahhz
 zmZf4Z4r0syzXaANtGUgFJl5r56eLwhOjP6KaxfXcGx6wxvYGHOO/iDJaUt8q8+fsu
 12xOpoWcVeS5A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A24B9192112;
 Wed, 11 Mar 2026 22:34:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E63E337C477;
 Wed, 11 Mar 2026 22:35:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jens Axboe <axboe@kernel.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 42/53] fdmon-io_uring: check CQ ring directly in
 gsource_check
Date: Wed, 11 Mar 2026 22:34:35 +0300
Message-ID: <20260311193449.1096110-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
(cherry picked from commit 961fcc0f22768e7c3432fc645b93dc7cd4932fae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.3


