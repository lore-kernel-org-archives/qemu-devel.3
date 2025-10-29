Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF02CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4zA-0004AX-SZ; Wed, 29 Oct 2025 08:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xW-0003H3-K0
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xH-00052K-Bs
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BbIyghYhaD6ACyGNGxhonS1mDxvdithkaleNNsGIw/U=;
 b=ZHILfBfmm8tRgYsN4rezLrEagKZwdTXCnvcmUcQmlQ0sVn6Spok17jRjKAEGUhnWEBV7rV
 bUGunQ6uKf3Tc55Ja0bK9RByDfAgvggL+iGLQx1HTSuqor9WbFnewwaB+7Uj8cD1YyU2/c
 3Bw8OVMKb0dkXh2h0O5LTLhfW9QxCVk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-KdSJxG0aObW3zM-Esd6UGg-1; Wed,
 29 Oct 2025 08:07:01 -0400
X-MC-Unique: KdSJxG0aObW3zM-Esd6UGg-1
X-Mimecast-MFC-AGG-ID: KdSJxG0aObW3zM-Esd6UGg_1761739620
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B787118002E4; Wed, 29 Oct 2025 12:07:00 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78DE0180044F; Wed, 29 Oct 2025 12:06:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 12/18] block: implement 'resize' callback for child_of_bds class
Date: Wed, 29 Oct 2025 13:06:28 +0100
Message-ID: <20251029120634.288467-13-kwolf@redhat.com>
In-Reply-To: <20251029120634.288467-1-kwolf@redhat.com>
References: <20251029120634.288467-1-kwolf@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If a filtered child is resized, the size of the parent node is now
also refreshed (recursively for chains of filtered children).

For filter block drivers that do not implement .bdrv_co_getlength(),
this commit does not change the current behavior, because
bdrv_co_refresh_total_sectors() will used the current size via the
passed-in hint. This is the case for block drivers for (some) block
jobs, as well as copy-before-write.

Block jobs already set up a blocker preventing a QMP block_resize
operation while the job is running. That does not directly cover an
associated 'file' node of a 'raw' node, but resizing such a 'file'
node is already prevented too (backup, commit, mirror and stream were
checked).

The other case is copy-before-write. This commit does not change the
fact that the copy-before-write node still has the same size after its
filtered child is resized.

Block drivers that do implement .bdrv_co_getlength() and where
.is_filter is true, already returned the length of the file child, so
there is no change before and after this commit, with two exceptions:
1. preallocate can return an early data_end and otherwise queries the
   file child, but that special casing is not changed.
2. blkverify returns the length of the test file. This commit does not
   affect that behavior.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250917115509.401015-4-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h |  2 +-
 block.c                          | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 8a3d427356..c55b35da8e 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1023,7 +1023,7 @@ struct BdrvChildClass {
     /*
      * Notifies the parent that the child was resized.
      */
-    void (*resize)(BdrvChild *child);
+    void GRAPH_RDLOCK_PTR (*resize)(BdrvChild *child);
 
     /*
      * Returns a name that is supposedly more useful for human users than the
diff --git a/block.c b/block.c
index 8848e9a7ed..cf08e64add 100644
--- a/block.c
+++ b/block.c
@@ -1497,6 +1497,17 @@ static void GRAPH_WRLOCK bdrv_child_cb_detach(BdrvChild *child)
     }
 }
 
+static void coroutine_fn GRAPH_RDLOCK bdrv_child_cb_resize(BdrvChild *child)
+{
+    BlockDriverState *bs = child->opaque;
+
+    if (child->role & BDRV_CHILD_FILTERED) {
+        /* Best effort, ignore errors. */
+        bdrv_co_refresh_total_sectors(bs, bs->total_sectors);
+        bdrv_co_parent_cb_resize(bs);
+    }
+}
+
 static int bdrv_child_cb_update_filename(BdrvChild *c, BlockDriverState *base,
                                          const char *filename,
                                          bool backing_mask_protocol,
@@ -1529,6 +1540,7 @@ const BdrvChildClass child_of_bds = {
     .detach          = bdrv_child_cb_detach,
     .inactivate      = bdrv_child_cb_inactivate,
     .change_aio_ctx  = bdrv_child_cb_change_aio_ctx,
+    .resize          = bdrv_child_cb_resize,
     .update_filename = bdrv_child_cb_update_filename,
     .get_parent_aio_context = child_of_bds_get_parent_aio_context,
 };
-- 
2.51.0


