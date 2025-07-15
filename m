Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6112C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublYx-0003uY-MB; Tue, 15 Jul 2025 15:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkx9-00047v-Hj
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkx8-0001Oa-1F
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=85C+bmwGQpnY3yJXrQ56iww5z/nGCdAErB540jMO+p8=;
 b=Sfo8hC+4zWVVBO8Oc1b+eZ36T3UAoOkMcMO5uzo0efUIt0Ew7r6SVsLktwQH34mLw6EBqA
 r+omE2CcJvO25+G4AHGsBK2J3JOYkwXjCj3miN/bbTeCTX/tgfpP6R/8b/F00SLldRGYO4
 Qof78CYuMt/oFf1wqoaxr+oPIzS2RK4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-GbJ6YLJFM9qn9b9yZnePfA-1; Tue,
 15 Jul 2025 15:04:29 -0400
X-MC-Unique: GbJ6YLJFM9qn9b9yZnePfA-1
X-Mimecast-MFC-AGG-ID: GbJ6YLJFM9qn9b9yZnePfA_1752606268
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A40AD19560B2; Tue, 15 Jul 2025 19:04:28 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A872E197702B; Tue, 15 Jul 2025 19:04:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 24/57] block: mark bdrv_close() as GRAPH_UNLOCKED
Date: Tue, 15 Jul 2025 21:02:57 +0200
Message-ID: <20250715190330.378764-25-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

The functions blk_log_writes_close(), blkverify_close(),
quorum_close(), vmdk_close() via vmdk_free_extents(), and other
bdrv_close() implementations call bdrv_graph_wrlock_drained(), which
must be called with the graph unlocked. They are reached via the
BlockDriver's bdrv_close() callback and the bdrv_close() wrapper,
which are also marked as GRAPH_UNLOCKED_PTR and GRAPH_UNLOCKED.

Furthermore, the function bdrv_close() also calls bdrv_drained_begin()
and bdrv_graph_wrlock_drained(), so there are additional reasons for
marking it GRAPH_UNLOCKED.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-47-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h | 2 +-
 block.c                          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index e96c6a6a03..034c0634c8 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -248,7 +248,7 @@ struct BlockDriver {
     int GRAPH_UNLOCKED_PTR (*bdrv_open)(
         BlockDriverState *bs, QDict *options, int flags, Error **errp);
 
-    void (*bdrv_close)(BlockDriverState *bs);
+    void GRAPH_UNLOCKED_PTR (*bdrv_close)(BlockDriverState *bs);
 
     int coroutine_fn GRAPH_UNLOCKED_PTR (*bdrv_co_create)(
         BlockdevCreateOptions *opts, Error **errp);
diff --git a/block.c b/block.c
index fe5aa2e767..8d3dd5a8e3 100644
--- a/block.c
+++ b/block.c
@@ -5146,7 +5146,7 @@ static void GRAPH_UNLOCKED bdrv_reopen_abort(BDRVReopenState *reopen_state)
 }
 
 
-static void bdrv_close(BlockDriverState *bs)
+static void GRAPH_UNLOCKED bdrv_close(BlockDriverState *bs)
 {
     BdrvAioNotifier *ban, *ban_next;
     BdrvChild *child, *next;
-- 
2.50.1


