Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC4BC0218E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 11:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taZHw-0003qV-M8; Wed, 22 Jan 2025 06:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1taZHa-0003D1-TY
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 06:52:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1taZHY-0000vp-1D
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 06:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737546747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bpGQXazZRTs7fXzsCi2gPR/wNSY6kSjuxkw2BiXV7oA=;
 b=bokufthJjs2mVB3tk/EV/aM3X+DmRAsp77rVt4myd68bxgit9GVFOea3VTPfUc6QE/JjEH
 KIHEaoXsRb81ZuZlZyPQhif5lt1dxFULvNcYhno4wX2mbHKwAfCmYYel1zptqkpT1elW2T
 ukVT9JDVb8Z2dOspsjFLUV7zr0sWb9c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-fcet-vwSN1qP4gPSCpqiWQ-1; Wed,
 22 Jan 2025 06:51:20 -0500
X-MC-Unique: fcet-vwSN1qP4gPSCpqiWQ-1
X-Mimecast-MFC-AGG-ID: fcet-vwSN1qP4gPSCpqiWQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 931AF1955DC9; Wed, 22 Jan 2025 11:51:19 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.195])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16E9B1956053; Wed, 22 Jan 2025 11:51:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pkrempa@redhat.com, peterx@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 1/9] block: Allow inactivating already inactive nodes
Date: Wed, 22 Jan 2025 12:50:38 +0100
Message-ID: <20250122115046.51216-2-kwolf@redhat.com>
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

What we wanted to catch with the assertion is cases where the recursion
finds that a child was inactive before its parent. This should never
happen. But if the user tries to inactivate an image that is already
inactive, that's harmless and we don't want to fail the assertion.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index f60606f242..43ed632a7a 100644
--- a/block.c
+++ b/block.c
@@ -6955,7 +6955,8 @@ bdrv_has_bds_parent(BlockDriverState *bs, bool only_active)
     return false;
 }
 
-static int GRAPH_RDLOCK bdrv_inactivate_recurse(BlockDriverState *bs)
+static int GRAPH_RDLOCK
+bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
 {
     BdrvChild *child, *parent;
     int ret;
@@ -6973,7 +6974,14 @@ static int GRAPH_RDLOCK bdrv_inactivate_recurse(BlockDriverState *bs)
         return 0;
     }
 
-    assert(!(bs->open_flags & BDRV_O_INACTIVE));
+    /*
+     * Inactivating an already inactive node on user request is harmless, but if
+     * a child is already inactive before its parent, that's bad.
+     */
+    if (bs->open_flags & BDRV_O_INACTIVE) {
+        assert(top_level);
+        return 0;
+    }
 
     /* Inactivate this node */
     if (bs->drv->bdrv_inactivate) {
@@ -7010,7 +7018,7 @@ static int GRAPH_RDLOCK bdrv_inactivate_recurse(BlockDriverState *bs)
 
     /* Recursively inactivate children */
     QLIST_FOREACH(child, &bs->children, next) {
-        ret = bdrv_inactivate_recurse(child->bs);
+        ret = bdrv_inactivate_recurse(child->bs, false);
         if (ret < 0) {
             return ret;
         }
@@ -7035,7 +7043,7 @@ int bdrv_inactivate_all(void)
         if (bdrv_has_bds_parent(bs, false)) {
             continue;
         }
-        ret = bdrv_inactivate_recurse(bs);
+        ret = bdrv_inactivate_recurse(bs, true);
         if (ret < 0) {
             bdrv_next_cleanup(&it);
             break;
-- 
2.48.1


