Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35A2CA5FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxW8-0007xj-OR; Wed, 30 Sep 2026 12:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVd-0006Zd-BN
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:24 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVZ-0003Xs-1o
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:21 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so42046725e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790787015; x=1791391815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ROdqnZ/nLMN3k6AxZtOjR0wy51FmT8iu0mjenz/VUAk=;
 b=f1FoLtbdcM5bjyPdAQ6PH4sZHClkMu/UMVtmfX4mrr3powxCc6WMbYbyhCmIiqLpN8
 E7fs5DFuNXvAkCe8wdu6JyjRXZ3Z2+agt2W8lNXBVfD7yzpu6MDOEgxxRpbcyfDn+lqL
 vsqWGFmjD3cOBE5MFx5ry7pDwnPr0gw8HMfFJUPijVAUJ825CtPt3Gxg29mZBWD9od+c
 Qqm2LHsXpKqg4eke5/YJuP/cogX5WjPdmkLkT/KXAsWnhIfcykcUXITZsBuZS45kkhKz
 AndOoiPjxo6iFTvpQSWeNai3rrLla7cT3uB78TNPJz2IbLnPXoQq1yVBnZku8LaOR4Uu
 hp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787015; x=1791391815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ROdqnZ/nLMN3k6AxZtOjR0wy51FmT8iu0mjenz/VUAk=;
 b=0EVnWRoKBXE+pOdhYIDjp2CpxnJog+KNDlOZM8SK/Gb5tdndMrdclIXqcxNrJSX7ZB
 a37ji0QAJw+xlNyInmLT8UbHR5JwAEiPiPGQxhMIXhZMaFEJZ6LuCqYyTQ8yKf87ETcZ
 qVXbDEKkKzBb9tBJXd3Wp5Fd1t4obbkOmWRR5LstN8jGU+zHBeBbhqhaq1W092XiVmD7
 /YQiejxmss9G1E29kfdHF0QMMJFnnQuW8DPIPUVcV5XceaifFBip92u7c3hj4QOq0S6i
 sXu7yPGNZd9kf9gGku1xeuj5YfCWdZMmp+r86qn8Tvw2WsUYG9TRZdCNdb5yixnh4tTr
 E7cA==
X-Gm-Message-State: AFuF++kBNDSQAIvNU5sRGnQkNcLYlEA2JXMP9cQ45AfIUyoZkjjSTBB4
 2cJ2UHJfIPK6fCESNlwQRca5S6zQgoVz6e6acC7CX8l1+YJmQJ14jn5i3xHMWSBMNtmF2La5Se/
 Mr9wI
X-Gm-Gg: AYBFou2zxlRIa0NqMZJgSZbxAq+0ZHmmrUAzDqxBOFx3MwuNmmUWT5TvDKsVb8YZ4cv
 +oUYdgCYYJAt/1r06gRiKYTvrmXu/2A6ObFF3L34uEKvtjOhu7BHbGlCe2tAWzVGJmiwn/UlAoR
 iLvBy8npHVjxrhctS9HtfjrFuN3D5ubZlMoFvQzNq0rBdOWh63PrcPB6HqnBDjZreIc0cVLjevB
 3CoaQuW3SkXePPNNlx6MAWaL61c8j48DjT9RWjaasFyWWYZB2V0BhOEaMJgEjA/yh6AlK78PS8i
 B6FezkXcprl2PCb2g1jdTWMTADaIGUKnmkrBHkxClR/sxCqAVhSl2VHJOOHkj+Gs1X1Zs4elye5
 BPRe122RL94kxssGHJA/b0Q2bwGvUqqGUGmd1Ze+gZA+XSju9ZbKn90sKYVoBJK1p95OFzOJA/P
 Et6hsGXsY8nFktulgShukViG0kYAww2+Mn2F+a4wRWYEZoGOri/6lxxYyOaU5Ciu8UEmw=
X-Received: by 2002:a05:600c:4e8f:b0:4a0:1eb0:1ab9 with SMTP id
 5b1f17b1804b1-4a01eb01b1bmr4389885e9.16.1790787015513; 
 Wed, 30 Sep 2026 09:50:15 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c6b8:98e2:93f0:2de6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb71d57sm4144535e9.9.2026.09.30.09.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:50:15 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 09/13] qemu-io: add -t to run an aio request in a named
 iothread
Date: Wed, 30 Sep 2026 18:49:55 +0200
Message-ID: <20260930165000.303236-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930165000.303236-1-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

A multiqueue virtio-blk drives one node from several AioContexts at
once, and nothing in the test tools could reproduce that shape: every
qemu-io request ran in the main loop. Filters and drivers that cache
state across a yield have therefore never been exercised the way
production runs them.

blk_aio_preadv() and friends enter the request coroutine in the
caller's context, so submitting from a bottom half scheduled on an
iothread is all it takes to put the request on that thread. The node
itself stays where it is, which is what virtio-blk does with the
queues it maps to iothreads other than the first.

aio_read and aio_write promise their caller that the request has been
submitted by the time they return, so wait for the bottom half to run
before returning. That also makes a test deterministic: entering a
coroutine from its own context runs it until it yields, so by the time
the command returns the request has reached, or blocked at, whatever
the test set up for it.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qemu-io-cmds.c | 111 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 101 insertions(+), 10 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index aa795fd87a..ce5bb53f4e 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -22,6 +22,8 @@
 #include "qemu/timer.h"
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
+#include "system/iothread.h"
+#include "qemu/aio-wait.h"
 
 #define CMD_NOFILE_OK   0x01
 
@@ -1367,8 +1369,84 @@ struct aio_ctx {
     int pattern;
     BdrvRequestFlags flags;
     struct timespec t1;
+    AioContext *aio_context;
 };
 
+enum aio_submit_type {
+    AIO_SUBMIT_READ,
+    AIO_SUBMIT_WRITE,
+    AIO_SUBMIT_WRITE_ZEROES,
+};
+
+struct aio_submit {
+    struct aio_ctx *ctx;
+    enum aio_submit_type type;
+    int64_t bytes;
+    BlockCompletionFunc *cb;
+    bool submitted;
+};
+
+static AioContext *aio_context_by_iothread_id(const char *id)
+{
+    IOThread *iothread = iothread_by_id(id);
+
+    if (!iothread) {
+        printf("iothread \"%s\" not found\n", id);
+        return NULL;
+    }
+
+    return iothread_get_aio_context(iothread);
+}
+
+static void aio_submit_bh(void *opaque)
+{
+    struct aio_submit *s = opaque;
+    struct aio_ctx *ctx = s->ctx;
+
+    switch (s->type) {
+    case AIO_SUBMIT_READ:
+        blk_aio_preadv(ctx->blk, ctx->offset, &ctx->qiov, ctx->flags,
+                       s->cb, ctx);
+        break;
+    case AIO_SUBMIT_WRITE:
+        blk_aio_pwritev(ctx->blk, ctx->offset, &ctx->qiov, ctx->flags,
+                        s->cb, ctx);
+        break;
+    case AIO_SUBMIT_WRITE_ZEROES:
+        blk_aio_pwrite_zeroes(ctx->blk, ctx->offset, s->bytes, ctx->flags,
+                              s->cb, ctx);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    qatomic_set(&s->submitted, true);
+    aio_wait_kick();
+}
+
+/*
+ * blk_aio_*() runs the request in the caller's AioContext, so submitting from
+ * a bottom half is what puts it on another thread.
+ */
+static void aio_submit(struct aio_ctx *ctx, enum aio_submit_type type,
+                       int64_t bytes, BlockCompletionFunc *cb)
+{
+    struct aio_submit s = {
+        .ctx = ctx,
+        .type = type,
+        .bytes = bytes,
+        .cb = cb,
+    };
+
+    if (!ctx->aio_context) {
+        aio_submit_bh(&s);
+        return;
+    }
+
+    aio_bh_schedule_oneshot(ctx->aio_context, aio_submit_bh, &s);
+    AIO_WAIT_WHILE_UNLOCKED(NULL, !qatomic_read(&s.submitted));
+}
+
 static void aio_write_done(void *opaque, int ret)
 {
     struct aio_ctx *ctx = opaque;
@@ -1468,6 +1546,7 @@ static void aio_read_help(void)
 " -P, -- use a pattern to verify read data\n"
 " -q, -- quiet mode, do not show I/O statistics\n"
 " -r, -- register I/O buffer\n"
+" -t, -- run the request in the named iothread\n"
 " -v, -- dump buffer to standard output\n"
 "\n");
 }
@@ -1479,7 +1558,7 @@ static const cmdinfo_t aio_read_cmd = {
     .cfunc      = aio_read_f,
     .argmin     = 2,
     .argmax     = -1,
-    .args       = "[-Ciqrv] [-P pattern] off len [len..]",
+    .args       = "[-Ciqrv] [-P pattern] [-t iothread] off len [len..]",
     .oneline    = "asynchronously reads a number of bytes",
     .help       = aio_read_help,
 };
@@ -1490,7 +1569,7 @@ static int aio_read_f(BlockBackend *blk, int argc, char **argv, Error **errp)
     struct aio_ctx *ctx = g_new0(struct aio_ctx, 1);
 
     ctx->blk = blk;
-    while ((c = getopt(argc, argv, "CiP:qrv")) != -1) {
+    while ((c = getopt(argc, argv, "CiP:qrt:v")) != -1) {
         switch (c) {
         case 'C':
             ctx->Cflag = true;
@@ -1514,6 +1593,13 @@ static int aio_read_f(BlockBackend *blk, int argc, char **argv, Error **errp)
         case 'r':
             ctx->flags |= BDRV_REQ_REGISTERED_BUF;
             break;
+        case 't':
+            ctx->aio_context = aio_context_by_iothread_id(optarg);
+            if (!ctx->aio_context) {
+                g_free(ctx);
+                return -EINVAL;
+            }
+            break;
         case 'v':
             ctx->vflag = true;
             break;
@@ -1551,8 +1637,7 @@ static int aio_read_f(BlockBackend *blk, int argc, char **argv, Error **errp)
     clock_gettime(CLOCK_MONOTONIC, &ctx->t1);
     block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,
                      BLOCK_ACCT_READ);
-    blk_aio_preadv(blk, ctx->offset, &ctx->qiov, ctx->flags, aio_read_done,
-                   ctx);
+    aio_submit(ctx, AIO_SUBMIT_READ, 0, aio_read_done);
     return 0;
 }
 
@@ -1579,6 +1664,7 @@ static void aio_write_help(void)
 " -P, -- use different pattern to fill file\n"
 " -q, -- quiet mode, do not show I/O statistics\n"
 " -r, -- register I/O buffer\n"
+" -t, -- run the request in the named iothread\n"
 " -u, -- with -z, allow unmapping\n"
 " -z, -- write zeroes using blk_aio_pwrite_zeroes\n"
 "\n");
@@ -1592,7 +1678,7 @@ static const cmdinfo_t aio_write_cmd = {
     .perm       = BLK_PERM_WRITE,
     .argmin     = 2,
     .argmax     = -1,
-    .args       = "[-Cfiqruz] [-P pattern] off len [len..]",
+    .args       = "[-Cfiqruz] [-P pattern] [-t iothread] off len [len..]",
     .oneline    = "asynchronously writes a number of bytes",
     .help       = aio_write_help,
 };
@@ -1604,7 +1690,7 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv, Error **errp)
     struct aio_ctx *ctx = g_new0(struct aio_ctx, 1);
 
     ctx->blk = blk;
-    while ((c = getopt(argc, argv, "CfiP:qruz")) != -1) {
+    while ((c = getopt(argc, argv, "CfiP:qrt:uz")) != -1) {
         switch (c) {
         case 'C':
             ctx->Cflag = true;
@@ -1618,6 +1704,13 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv, Error **errp)
         case 'r':
             ctx->flags |= BDRV_REQ_REGISTERED_BUF;
             break;
+        case 't':
+            ctx->aio_context = aio_context_by_iothread_id(optarg);
+            if (!ctx->aio_context) {
+                g_free(ctx);
+                return -EINVAL;
+            }
+            break;
         case 'u':
             ctx->flags |= BDRV_REQ_MAY_UNMAP;
             break;
@@ -1692,8 +1785,7 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv, Error **errp)
         }
 
         ctx->qiov.size = count;
-        blk_aio_pwrite_zeroes(blk, ctx->offset, count, ctx->flags,
-                              aio_write_done, ctx);
+        aio_submit(ctx, AIO_SUBMIT_WRITE_ZEROES, count, aio_write_done);
     } else {
         nr_iov = argc - optind;
         ctx->buf = create_iovec(blk, &ctx->qiov, &argv[optind], nr_iov,
@@ -1709,8 +1801,7 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv, Error **errp)
         block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,
                          BLOCK_ACCT_WRITE);
 
-        blk_aio_pwritev(blk, ctx->offset, &ctx->qiov, ctx->flags,
-                        aio_write_done, ctx);
+        aio_submit(ctx, AIO_SUBMIT_WRITE, 0, aio_write_done);
     }
 
     return 0;
-- 
2.53.0


