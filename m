Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D53C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 11:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taZGg-0002aL-AN; Wed, 22 Jan 2025 06:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1taZGd-0002Yh-Uk
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 06:51:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1taZGb-00087S-GM
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 06:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737546687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Vbz0z3fzrn6gURjwRoRl18BXwv5/wFg+/5uraPQpsU=;
 b=V47iCg90qzLcPcbeANIQfG/ftXhPI1S2kl0CeulkaIpU8ZDBB+NmPkv9GJXvrG5CSRL6p+
 pyJ1Et8i13MmXU+MUsjmcqJJND9R5hlY4rS2b8af6rq0wLfEeqln+q28lgh1/p+8U9YzkY
 u984QKTc8trXH61w/LmgocVF1P7yO6A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-DALymUO7PAyZzwCabyjLgg-1; Wed,
 22 Jan 2025 06:51:24 -0500
X-MC-Unique: DALymUO7PAyZzwCabyjLgg-1
X-Mimecast-MFC-AGG-ID: DALymUO7PAyZzwCabyjLgg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA7D61956050; Wed, 22 Jan 2025 11:51:23 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.195])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42C5719560AA; Wed, 22 Jan 2025 11:51:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pkrempa@redhat.com, peterx@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 3/9] block: Support inactive nodes in blk_insert_bs()
Date: Wed, 22 Jan 2025 12:50:40 +0100
Message-ID: <20250122115046.51216-4-kwolf@redhat.com>
In-Reply-To: <20250122115046.51216-1-kwolf@redhat.com>
References: <20250122115046.51216-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Device models have a relatively complex way to set up their block
backends, in which blk_attach_dev() sets blk->disable_perm = true.
We want to support inactive images in exports, too, so that
qemu-storage-daemon can be used with migration. Because they don't use
blk_attach_dev(), they need another way to set this flag. The most
convenient is to do this automatically when an inactive node is attached
to a BlockBackend.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index b610582644..76ec5f0576 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -900,14 +900,24 @@ void blk_remove_bs(BlockBackend *blk)
 int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
 {
     ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
+    uint64_t perm, shared_perm;
 
     GLOBAL_STATE_CODE();
     bdrv_ref(bs);
     bdrv_graph_wrlock();
+
+    if (bs->open_flags & BDRV_O_INACTIVE) {
+        blk->disable_perm = true;
+        perm = 0;
+        shared_perm = BLK_PERM_ALL;
+    } else {
+        perm = blk->perm;
+        shared_perm = blk->shared_perm;
+    }
+
     blk->root = bdrv_root_attach_child(bs, "root", &child_root,
                                        BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
-                                       blk->perm, blk->shared_perm,
-                                       blk, errp);
+                                       perm, shared_perm, blk, errp);
     bdrv_graph_wrunlock();
     if (blk->root == NULL) {
         return -EPERM;
-- 
2.48.1


