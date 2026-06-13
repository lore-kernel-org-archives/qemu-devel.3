Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B75CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUSO-0001CP-8d; Sat, 13 Jun 2026 15:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUSL-0000ml-Vm; Sat, 13 Jun 2026 15:55:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUSJ-0004nP-U4; Sat, 13 Jun 2026 15:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380261; bh=yBluAs/gE8DSO3TfUiji3YFG4b/s0M7RfG8jpYCyV4I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vr7NYSZmZa/AsmSXkMCSgNYvecVtTOZpQcgQnuFvr6qSBZ4K6Up9PJdKweqrd9RVu
 UXIAcoBH5fmEQC0GnbxYEUCxs9SJrNCdK9OXJkex6rIE8q/HpyiY+pzHtRwm2tfrK0
 12dGavwn33cESXBfEfdFmthsu1v6dreXecPtuiOLzpYTc/3lC7nXxChDcaqnDk+6zk
 5kKlaPmjM85PSmvLSVAPxUOvkJc/B4vfGkL3dQZhbXedyjChmHPXCyktEq7POpRASQ
 uPBNkB9tazxDzFLHmNX+wjDjQHSzYgeb+ybXtmwk6f3e9FePc5CTZF6GMreSRAUBBq
 dipXz9ZNp/kQA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 347DE1B6E3F;
 Sat, 13 Jun 2026 22:51:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8E7633CE8B9;
 Sat, 13 Jun 2026 22:51:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 48/56] qemu-io: Add 'aio_discard' command
Date: Sat, 13 Jun 2026 22:51:02 +0300
Message-ID: <20260613195116.1807273-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Kevin Wolf <kwolf@redhat.com>

Testing interactions between multiple requests that include discard
requests require that qemu-io can do the discard asynchronously, like it
already does for reads and writes. To this effect, add an 'aio_discard'
command.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260427170520.101242-3-kwolf@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Tested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 7f8466e2ce620e3c6a6e2f32d616367174d4dbe9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index f6d077908f..de4c1966fe 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2218,6 +2218,120 @@ static int discard_f(BlockBackend *blk, int argc, char **argv)
     return 0;
 }
 
+static void aio_discard_help(void)
+{
+    printf(
+"\n"
+" asynchronously discards a range of bytes from the given offset\n"
+"\n"
+" Example:\n"
+" 'aio_discard 512 1k' - discards 1 kilobyte from 512 bytes into the file\n"
+"\n"
+" Discards a segment of the currently open file.\n"
+" -C, -- report statistics in a machine parsable format\n"
+" -q, -- quiet mode, do not show I/O statistics\n"
+" The discard is performed asynchronously and the aio_flush command must be\n"
+" used to ensure all outstanding aio requests have been completed.\n"
+" Note that due to its asynchronous nature, this command will be\n"
+" considered successful once the request is submitted, independently\n"
+" of potential I/O errors.\n"
+"\n");
+}
+
+static int aio_discard_f(BlockBackend *blk, int argc, char **argv);
+
+static const cmdinfo_t aio_discard_cmd = {
+    .name       = "aio_discard",
+    .cfunc      = aio_discard_f,
+    .perm       = BLK_PERM_WRITE,
+    .argmin     = 2,
+    .argmax     = -1,
+    .args       = "[-Cq] off len",
+    .oneline    = "asynchronously discards a number of bytes",
+    .help       = aio_discard_help,
+};
+
+static void aio_discard_done(void *opaque, int ret)
+{
+    struct aio_ctx *ctx = opaque;
+    struct timespec t2;
+
+    clock_gettime(CLOCK_MONOTONIC, &t2);
+
+    if (ret < 0) {
+        printf("aio_discard failed: %s\n", strerror(-ret));
+        block_acct_failed(blk_get_stats(ctx->blk), &ctx->acct);
+        goto out;
+    }
+
+    block_acct_done(blk_get_stats(ctx->blk), &ctx->acct);
+
+    if (ctx->qflag) {
+        goto out;
+    }
+
+    /* Finally, report back -- -C gives a parsable format */
+    t2 = tsub(t2, ctx->t1);
+    print_report("discarded ", &t2, ctx->offset, ctx->qiov.size,
+                 ctx->qiov.size, 1, ctx->Cflag);
+out:
+    g_free(ctx);
+}
+
+static int aio_discard_f(BlockBackend *blk, int argc, char **argv)
+{
+    int c, ret;
+    int64_t count;
+    struct aio_ctx *ctx = g_new0(struct aio_ctx, 1);
+
+    ctx->blk = blk;
+
+    while ((c = getopt(argc, argv, "Cq")) != -1) {
+        switch (c) {
+        case 'C':
+            ctx->Cflag = true;
+            break;
+        case 'q':
+            ctx->qflag = true;
+            break;
+        default:
+            g_free(ctx);
+            qemuio_command_usage(&aio_discard_cmd);
+            return -EINVAL;
+        }
+    }
+
+    if (optind != argc - 2) {
+        g_free(ctx);
+        qemuio_command_usage(&aio_discard_cmd);
+        return -EINVAL;
+    }
+
+    ctx->offset = cvtnum(argv[optind]);
+    if (ctx->offset < 0) {
+        ret = ctx->offset;
+        print_cvtnum_err(ret, argv[optind]);
+        g_free(ctx);
+        return ret;
+    }
+    optind++;
+
+    count = cvtnum(argv[optind]);
+    if (count < 0) {
+        print_cvtnum_err(count, argv[optind]);
+        g_free(ctx);
+        return count;
+    }
+
+    clock_gettime(CLOCK_MONOTONIC, &ctx->t1);
+    ctx->qiov.size = count;
+    block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,
+                     BLOCK_ACCT_UNMAP);
+    blk_aio_pdiscard(blk, ctx->offset, count, aio_discard_done, ctx);
+
+    return 0;
+}
+
 static int alloc_f(BlockBackend *blk, int argc, char **argv)
 {
     BlockDriverState *bs = blk_bs(blk);
@@ -2800,6 +2914,7 @@ static void __attribute((constructor)) init_qemuio_commands(void)
     qemuio_add_command(&length_cmd);
     qemuio_add_command(&info_cmd);
     qemuio_add_command(&discard_cmd);
+    qemuio_add_command(&aio_discard_cmd);
     qemuio_add_command(&alloc_cmd);
     qemuio_add_command(&map_cmd);
     qemuio_add_command(&reopen_cmd);
-- 
2.47.3


