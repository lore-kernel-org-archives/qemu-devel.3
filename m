Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CA9C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 17:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdY6N-0000en-2P; Thu, 30 Jan 2025 12:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdY6J-0000do-Ra
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:13:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdY6I-0003C7-63
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738257188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bybbmbp4o3dm/8LvP5Lj7D6zru5NTPZT+ktuCm9LAKE=;
 b=ZPu9WA+rllL+3kYFWkJ0xwiqqUEQoJkezWYWj5wtCpViVUyLS/ysq3abPQVeCqUxalT6CK
 Luag/QwCW/kdvRCE+8Ixbbnay3I1hWpZhcl7fImCD/PJCrhymOo1CRFDfk8MnHL3dyIxT+
 hXxAqGr8iOJXNfehsNOk8KGKlHOAnxQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-Ljjwrv_tOZqs4wdk1OkJwA-1; Thu,
 30 Jan 2025 12:13:04 -0500
X-MC-Unique: Ljjwrv_tOZqs4wdk1OkJwA-1
X-Mimecast-MFC-AGG-ID: Ljjwrv_tOZqs4wdk1OkJwA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1BDC1955F67; Thu, 30 Jan 2025 17:13:03 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C1BC30001BE; Thu, 30 Jan 2025 17:13:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: [PATCH v2 05/15] block: Allow inactivating already inactive nodes
Date: Thu, 30 Jan 2025 18:12:36 +0100
Message-ID: <20250130171240.286878-6-kwolf@redhat.com>
In-Reply-To: <20250130171240.286878-1-kwolf@redhat.com>
References: <20250130171240.286878-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 94368a200e..be6b71c314 100644
--- a/block.c
+++ b/block.c
@@ -6960,7 +6960,8 @@ bdrv_has_bds_parent(BlockDriverState *bs, bool only_active)
     return false;
 }
 
-static int GRAPH_RDLOCK bdrv_inactivate_recurse(BlockDriverState *bs)
+static int GRAPH_RDLOCK
+bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
 {
     BdrvChild *child, *parent;
     int ret;
@@ -6978,7 +6979,14 @@ static int GRAPH_RDLOCK bdrv_inactivate_recurse(BlockDriverState *bs)
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
@@ -7015,7 +7023,7 @@ static int GRAPH_RDLOCK bdrv_inactivate_recurse(BlockDriverState *bs)
 
     /* Recursively inactivate children */
     QLIST_FOREACH(child, &bs->children, next) {
-        ret = bdrv_inactivate_recurse(child->bs);
+        ret = bdrv_inactivate_recurse(child->bs, false);
         if (ret < 0) {
             return ret;
         }
@@ -7040,7 +7048,7 @@ int bdrv_inactivate_all(void)
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


