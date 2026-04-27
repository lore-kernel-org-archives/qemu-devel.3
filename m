Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85394FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 17:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHPP4-0007Zm-Fp; Mon, 27 Apr 2026 13:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wHPP3-0007Yh-3m
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 13:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wHPP1-0006Rm-Mc
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 13:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777309547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNf7Qtsfx36oLLaeD/N/V5PatsHP0UT/LP0p18adqyc=;
 b=dyUA6vP5yOuy1t9xK/acm8c79iojvmzZQJeoKSuzR3r8x3t1B1l9Ws9wIFjUdtXzaE3LI1
 CXmMVQ6aEYtyXSEi0aa+BF2bv+XboYLW8ByyBVOLuTMi9Hph9b712qVfW63L41zn0kJKgl
 TYkEEqL3EI2xqUTjTlOSYKHvMdMrJUo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-xeNFhFwbOXqFn5IM-6mYQQ-1; Mon,
 27 Apr 2026 13:05:43 -0400
X-MC-Unique: xeNFhFwbOXqFn5IM-6mYQQ-1
X-Mimecast-MFC-AGG-ID: xeNFhFwbOXqFn5IM-6mYQQ_1777309542
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF1251800609; Mon, 27 Apr 2026 17:05:41 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 951A5180047F; Mon, 27 Apr 2026 17:05:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, den@openvz.org, stefanha@redhat.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 1/4] commit: Drain nodes across all of bdrv_commit()
Date: Mon, 27 Apr 2026 19:05:17 +0200
Message-ID: <20260427170520.101242-2-kwolf@redhat.com>
In-Reply-To: <20260427170520.101242-1-kwolf@redhat.com>
References: <20260427170520.101242-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The whole implementation of bdrv_commit() is only correct if no new
writes come in while it's running: It has only a single loop checking
the allocation status for each block and finally calls bdrv_make_empty()
without checking if that throws away any new changes.

We already have to drain while taking the graph write lock. Just extend
the drained section to all of bdrv_commit() to make sure that we don't
get any inconsistencies.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 0d9e1a16d7a..c5e3ef03a21 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -518,6 +518,7 @@ int bdrv_commit(BlockDriverState *bs)
     if (!drv)
         return -ENOMEDIUM;
 
+    bdrv_drain_all_begin();
     bdrv_graph_rdlock_main_loop();
 
     backing_file_bs = bdrv_cow_bs(bs);
@@ -549,6 +550,10 @@ int bdrv_commit(BlockDriverState *bs)
                   BLK_PERM_ALL);
     backing = blk_new(ctx, BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
 
+    /* We drained all nodes, but still make requests through BlockBackends */
+    blk_set_disable_request_queuing(src, true);
+    blk_set_disable_request_queuing(backing, true);
+
     ret = blk_insert_bs(src, bs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
@@ -565,7 +570,7 @@ int bdrv_commit(BlockDriverState *bs)
 
     bdrv_graph_rdunlock_main_loop();
 
-    bdrv_graph_wrlock_drained();
+    bdrv_graph_wrlock();
     bdrv_set_backing_hd(commit_top_bs, backing_file_bs, &error_abort);
     bdrv_set_backing_hd(bs, commit_top_bs, &error_abort);
     bdrv_graph_wrunlock();
@@ -647,7 +652,7 @@ ro_cleanup:
     blk_unref(backing);
 
     bdrv_graph_rdunlock_main_loop();
-    bdrv_graph_wrlock_drained();
+    bdrv_graph_wrlock();
     if (bdrv_cow_bs(bs) != backing_file_bs) {
         bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
     }
@@ -663,6 +668,7 @@ ro_cleanup:
 
 out:
     bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
 
     return ret;
 }
-- 
2.53.0


