Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D881DC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQFu-0005Hd-Ur; Tue, 04 Feb 2025 16:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfQFq-0005G8-Q4
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:14:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfQFp-0005hW-Bo
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738703684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8aCNIt2pD+/KrmOoFOO+d3k8jR1zf8jUCX283RWN5Kg=;
 b=LWbdqbWFMeghuBQpC6AS/rgOsk6IxWJFg1B33+hcBHLpqU3+S9s8RzDVRlBmQMA/IZLqZI
 JJ2AV2dR54xa4u3j3UFGFhtqM6YO8sFDWPL1TQsJWIYArqR6uX/YIMGwo3cYDefVISir2+
 789Zp4pHqQXycZUUNS9D2RHSvLsnwYQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-y7-cSdfRMyOsBbjT-L84Cw-1; Tue,
 04 Feb 2025 16:14:41 -0500
X-MC-Unique: y7-cSdfRMyOsBbjT-L84Cw-1
X-Mimecast-MFC-AGG-ID: y7-cSdfRMyOsBbjT-L84Cw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B1B219560AA; Tue,  4 Feb 2025 21:14:40 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E19AC1800365; Tue,  4 Feb 2025 21:14:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: [PATCH v3 06/16] block: Fix crash on block_resize on inactive node
Date: Tue,  4 Feb 2025 22:13:57 +0100
Message-ID: <20250204211407.381505-7-kwolf@redhat.com>
In-Reply-To: <20250204211407.381505-1-kwolf@redhat.com>
References: <20250204211407.381505-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

In order for block_resize to fail gracefully on an inactive node instead
of crashing with an assertion failure in bdrv_co_write_req_prepare()
(called from bdrv_co_truncate()), we need to check for inactive nodes
also when they are attached as a root node and make sure that
BLK_PERM_RESIZE isn't among the permissions allowed for inactive nodes.
To this effect, don't enumerate the permissions that are incompatible
with inactive nodes any more, but allow only BLK_PERM_CONSISTENT_READ
for them.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block.c               | 7 +++++++
 block/block-backend.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 66a99e87c5..73d0de12cf 100644
--- a/block.c
+++ b/block.c
@@ -3077,6 +3077,13 @@ bdrv_attach_child_common(BlockDriverState *child_bs,
     assert(child_class->get_parent_desc);
     GLOBAL_STATE_CODE();
 
+    if (bdrv_is_inactive(child_bs) && (perm & ~BLK_PERM_CONSISTENT_READ)) {
+        g_autofree char *perm_names = bdrv_perm_names(perm);
+        error_setg(errp, "Permission '%s' unavailable on inactive node",
+                   perm_names);
+        return NULL;
+    }
+
     new_child = g_new(BdrvChild, 1);
     *new_child = (BdrvChild) {
         .bs             = NULL,
diff --git a/block/block-backend.c b/block/block-backend.c
index d093f01f89..cc6f58ae78 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -253,7 +253,7 @@ static bool blk_can_inactivate(BlockBackend *blk)
      * guest.  For block job BBs that satisfy this, we can just allow
      * it.  This is the case for mirror job source, which is required
      * by libvirt non-shared block migration. */
-    if (!(blk->perm & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED))) {
+    if (!(blk->perm & ~BLK_PERM_CONSISTENT_READ)) {
         return true;
     }
 
-- 
2.48.1


