Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E222C0218F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 17:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdY6M-0000el-KE; Thu, 30 Jan 2025 12:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdY6J-0000dp-Ro
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:13:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdY6I-0003CG-4W
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738257189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2wBYH1nF1e4Gs/jyRNfxVZkd6GU5b6C98eFGtW8FFw=;
 b=ex9JzPEnkiO4VbfnKs8Oe0Wq3VQGcE1mGE4WjzOAzGA1fSDFC+z9WKMBVQRO7BP6Smc88F
 mqIx4gsLImFbG9jv5umzWEV8Wxv7MeAc849qV4h0EtDPOWplkyzX6cjKVosTFBlk99FhA/
 dDt5BtwXGC9Y1N636j7fB8Xi9Pf/Pyg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-bT7oymGEMuCOyrxl3Ru3jg-1; Thu,
 30 Jan 2025 12:13:07 -0500
X-MC-Unique: bT7oymGEMuCOyrxl3Ru3jg-1
X-Mimecast-MFC-AGG-ID: bT7oymGEMuCOyrxl3Ru3jg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB2271801F1C; Thu, 30 Jan 2025 17:13:06 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2705730001BE; Thu, 30 Jan 2025 17:13:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: [PATCH v2 06/15] block: Fix crash on block_resize on inactive node
Date: Thu, 30 Jan 2025 18:12:37 +0100
Message-ID: <20250130171240.286878-7-kwolf@redhat.com>
In-Reply-To: <20250130171240.286878-1-kwolf@redhat.com>
References: <20250130171240.286878-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In order for block_resize to fail gracefully on an inactive node instead
of crashing with an assertion failure in bdrv_co_write_req_prepare()
(called from bdrv_co_truncate()), we need to check for inactive nodes
also when they are attached as a root node and make sure that
BLK_PERM_RESIZE isn't among the permissions allowed for inactive nodes.
To this effect, don't enumerate the permissions that are incompatible
with inactive nodes any more, but allow only BLK_PERM_CONSISTENT_READ
for them.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c               | 7 +++++++
 block/block-backend.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index be6b71c314..fa6198bca3 100644
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


