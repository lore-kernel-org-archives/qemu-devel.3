Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA510CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNra-0008C5-VW; Tue, 19 May 2026 13:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrP-00088x-IO
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrM-0004Mj-TH
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779210239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljPMsHaTOASelJyrTH89CAlt54Pd7Kc2MO3sIPNTZf0=;
 b=QxHdVyx0ODLH53CrMMGyoYcgwDQnJge98NCicuJ8wW5Mq+T+85qjK+0egEM9TB0CTG9eDh
 M9P69R9gUJillDiXCqpaKESPBYL2Me2F9V/xe1F7pDvfWFKObyQv+1owsylkDOCCrwlhSy
 jhl8vmS/oAEWH2+/EBu8FDBQNQQAtIw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-dpEr_eqPN0y5b5LeGVuukA-1; Tue,
 19 May 2026 13:03:55 -0400
X-MC-Unique: dpEr_eqPN0y5b5LeGVuukA-1
X-Mimecast-MFC-AGG-ID: dpEr_eqPN0y5b5LeGVuukA_1779210235
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA1F618005B2; Tue, 19 May 2026 17:03:54 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.113])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 988791681; Tue, 19 May 2026 17:03:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 14/18] qemu-io: Add 'aio_discard' command
Date: Tue, 19 May 2026 19:03:13 +0200
Message-ID: <20260519170317.345032-15-kwolf@redhat.com>
In-Reply-To: <20260519170317.345032-1-kwolf@redhat.com>
References: <20260519170317.345032-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Testing interactions between multiple requests that include discard
requests require that qemu-io can do the discard asynchronously, like it
already does for reads and writes. To this effect, add an 'aio_discard'
command.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260427170520.101242-3-kwolf@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Tested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-io-cmds.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index f6d077908f2..de4c1966fea 100644
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
2.54.0


