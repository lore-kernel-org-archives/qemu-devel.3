Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D65CC27C79
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 17:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJzIY-00010u-18; Wed, 19 Jun 2024 13:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sJzIU-0000zO-Je
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sJzIS-00064M-Jb
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718818835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RWTnPBXoi7xBZUVizuCq79T+SAn4e0qAr8xVuG97KVA=;
 b=Nn/26l/NX+p15w5kcW7zOBcZmmpT2HH+KO1ml+17HGIuc+5Z9bsP2aClkzaNTGVse0gB5w
 TD0WLJcRGpXUpRqoKc1d5lvbrFeUtLT4xYt0ZoNFtwctiwGFxGAqkxSJtv5vScckdWQElD
 XkOzxljhS0Vx0UfuEKnlhuJ7AO48t4I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-cuOuFmIxOO2hEd6WIn0uvQ-1; Wed,
 19 Jun 2024 13:40:31 -0400
X-MC-Unique: cuOuFmIxOO2hEd6WIn0uvQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43DE21956088; Wed, 19 Jun 2024 17:40:28 +0000 (UTC)
Received: from sparse.local (unknown [10.47.238.15])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD4C41956087; Wed, 19 Jun 2024 17:40:23 +0000 (UTC)
From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>
Subject: [PATCH v2] Consider discard option when writing zeros
Date: Wed, 19 Jun 2024 20:40:22 +0300
Message-ID: <20240619174022.1298578-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

When opening an image with discard=off, we punch hole in the image when
writing zeroes, making the image sparse. This breaks users that want to
ensure that writes cannot fail with ENOSPACE by using fully allocated
images.

bdrv_co_pwrite_zeroes() correctly disable BDRV_REQ_MAY_UNMAP if we
opened the child without discard=unmap or discard=on. But we don't go
through this function when accessing the top node. Move the check down
to bdrv_co_do_pwrite_zeroes() which seems to be used in all code paths.

Issues:
- We don't punch hole by default, so images are kept allocated. Before
  this change we punched holes by default. I'm not sure this is a good
  change in behavior.
- Need to run all block tests
- Not sure that we have tests covering unmapping, we may need new tests
- We may need new tests to cover this change

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---

Changes since v1:
- Replace the incorrect has_discard change with the right fix

v1 was here:
https://lists.nongnu.org/archive/html/qemu-block/2024-06/msg00198.html

 block/io.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index 7217cf811b..301514c880 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1860,10 +1860,15 @@ bdrv_co_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
     /* By definition there is no user buffer so this flag doesn't make sense */
     if (flags & BDRV_REQ_REGISTERED_BUF) {
         return -EINVAL;
     }
 
+    /* If opened with discard=off we should never unmap. */
+    if (!(bs->open_flags & BDRV_O_UNMAP)) {
+        flags &= ~BDRV_REQ_MAY_UNMAP;
+    }
+
     /* Invalidate the cached block-status data range if this write overlaps */
     bdrv_bsc_invalidate_range(bs, offset, bytes);
 
     assert(alignment % bs->bl.request_alignment == 0);
     head = offset % alignment;
@@ -2313,14 +2318,10 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
 {
     IO_CODE();
     trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
     assert_bdrv_graph_readable();
 
-    if (!(child->bs->open_flags & BDRV_O_UNMAP)) {
-        flags &= ~BDRV_REQ_MAY_UNMAP;
-    }
-
     return bdrv_co_pwritev(child, offset, bytes, NULL,
                            BDRV_REQ_ZERO_WRITE | flags);
 }
 
 /*
-- 
2.45.1


