Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77307C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublVD-0005Gb-Ly; Tue, 15 Jul 2025 15:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwM-0003Y9-Jq
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwI-0001Dv-Jw
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7eL5QOt6pRzng8VnrLmY7zeMAa5ne7tpOIThr8pO/xg=;
 b=KUJYYcEzPumOJ8Cbln7USrdxt/xrq9lVSX39GPqqgADVYgiMehgnfAiJI4h3U5JHbo1Em3
 /lzLFJksbxkQ6yQqK3tUVSodGU8M0KY8zYkUQbBfZlxZHQ3Lw/9/MVXm7MQE9375elkRE8
 3SxXgm3wsLneIrxV8w6xH5T/6jMntaQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640--KzGxwDLP62kRAJdLePHxA-1; Tue,
 15 Jul 2025 15:03:39 -0400
X-MC-Unique: -KzGxwDLP62kRAJdLePHxA-1
X-Mimecast-MFC-AGG-ID: -KzGxwDLP62kRAJdLePHxA_1752606219
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04C42180024A; Tue, 15 Jul 2025 19:03:39 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44BF3197702B; Tue, 15 Jul 2025 19:03:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/57] block: never use atomics to access bs->quiesce_counter
Date: Tue, 15 Jul 2025 21:02:34 +0200
Message-ID: <20250715190330.378764-2-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

All accesses of bs->quiesce_counter are in the main thread, either
after a GLOBAL_STATE_CODE() macro or in a function with GRAPH_WRLOCK
annotation.

This is essentially a revert of 414c2ec358 ("block: access
quiesce_counter with atomic ops"). At that time, neither the
GLOBAL_STATE_CODE() macro nor the GRAPH_WRLOCK annotation existed.
Even if the field was only accessed in the main thread back then (did
not check if that is actually the case), it wouldn't have been easy to
verify.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-24-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h | 2 +-
 block/io.c                       | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 925a3e7353..e96c6a6a03 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1253,7 +1253,7 @@ struct BlockDriverState {
     /* do we need to tell the quest if we have a volatile write cache? */
     int enable_write_cache;
 
-    /* Accessed with atomic ops.  */
+    /* Accessed only in the main thread. */
     int quiesce_counter;
 
     unsigned int write_gen;               /* Current data generation */
diff --git a/block/io.c b/block/io.c
index ac5c7174f6..9bd8ba8431 100644
--- a/block/io.c
+++ b/block/io.c
@@ -361,7 +361,7 @@ static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
     GLOBAL_STATE_CODE();
 
     /* Stop things in parent-to-child order */
-    if (qatomic_fetch_inc(&bs->quiesce_counter) == 0) {
+    if (bs->quiesce_counter++ == 0) {
         GRAPH_RDLOCK_GUARD_MAINLOOP();
         bdrv_parent_drained_begin(bs, parent);
         if (bs->drv && bs->drv->bdrv_drain_begin) {
@@ -401,8 +401,6 @@ bdrv_drained_begin(BlockDriverState *bs)
  */
 static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
 {
-    int old_quiesce_counter;
-
     IO_OR_GS_CODE();
 
     if (qemu_in_coroutine()) {
@@ -415,8 +413,7 @@ static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
     assert(bs->quiesce_counter > 0);
 
     /* Re-enable things in child-to-parent order */
-    old_quiesce_counter = qatomic_fetch_dec(&bs->quiesce_counter);
-    if (old_quiesce_counter == 1) {
+    if (--bs->quiesce_counter == 0) {
         GRAPH_RDLOCK_GUARD_MAINLOOP();
         if (bs->drv && bs->drv->bdrv_drain_end) {
             bs->drv->bdrv_drain_end(bs);
-- 
2.50.1


