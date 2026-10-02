Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B92CCA5FE2
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCdDb-0002C3-D9; Fri, 02 Oct 2026 09:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xCdD2-00027V-2f
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xCdCx-0001el-Rv
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790947310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsaqrLfIpI/5y25hzh0QXelKvpxkNsJrSdHoyKbVvDM=;
 b=XapEZUVTzFI3vT4DN6fty6lUHaxCgXDXx4pCOVylo+AgUNlSDKB554Xpr0qswwPnnLst6e
 PRU4feN97/OvcsMkLEGsahNjKtLFzeVtvtyf47uFmFPAMjegU73ls2wMHAgr8d1IjJ33i7
 mp9GA1EVh1cFwoQAud+wv9MuucYH6Og=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-rPgSELmmMgeLQRFTd_COSg-1; Fri,
 02 Oct 2026 09:21:49 -0400
X-MC-Unique: rPgSELmmMgeLQRFTd_COSg-1
X-Mimecast-MFC-AGG-ID: rPgSELmmMgeLQRFTd_COSg_1790947308
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F33A195D00C; Fri,  2 Oct 2026 13:21:48 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.48.157])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E38D3000229; Fri,  2 Oct 2026 13:21:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH 2/2] block: Remove now redundant
 bdrv_wait_serialising_requests() calls
Date: Fri,  2 Oct 2026 15:21:35 +0200
Message-ID: <20261002132135.93345-3-kwolf@redhat.com>
In-Reply-To: <20261002132135.93345-1-kwolf@redhat.com>
References: <20261002132135.93345-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

All callers of bdrv_wait_serialising_requests() (as opposed to
bdrv_wait_serialising_requests_locked()) are just duplicating the check
that tracked_request_begin() already performs now. After removing them,
bdrv_wait_serialising_requests() has no callers left and can go as well.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/block/io.c b/block/io.c
index bd562d472fd..1c05dd106d6 100644
--- a/block/io.c
+++ b/block/io.c
@@ -802,20 +802,6 @@ void bdrv_dec_in_flight(BlockDriverState *bs)
     bdrv_wakeup(bs);
 }
 
-static void coroutine_fn
-bdrv_wait_serialising_requests(BdrvTrackedRequest *self)
-{
-    BlockDriverState *bs = self->bs;
-
-    if (!qatomic_read(&bs->serialising_in_flight)) {
-        return;
-    }
-
-    qemu_mutex_lock(&bs->reqs_lock);
-    bdrv_wait_serialising_requests_locked(self);
-    qemu_mutex_unlock(&bs->reqs_lock);
-}
-
 void coroutine_fn bdrv_make_request_serialising(BdrvTrackedRequest *req,
                                                 uint64_t align)
 {
@@ -1383,8 +1369,6 @@ bdrv_aligned_preadv(BdrvChild *child, BdrvTrackedRequest *req,
          * it ensures that the CoR read and write operations are atomic and
          * guest writes cannot interleave between them. */
         bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
-    } else {
-        bdrv_wait_serialising_requests(req);
     }
 
     if (flags & BDRV_REQ_COPY_ON_READ) {
@@ -2021,8 +2005,6 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, int64_t bytes,
         }
 
         bdrv_wait_serialising_requests_locked(req);
-    } else {
-        bdrv_wait_serialising_requests(req);
     }
 
     assert(req->overlap_offset <= offset);
@@ -3530,7 +3512,6 @@ static int coroutine_fn GRAPH_RDLOCK bdrv_co_copy_range_internal(
 
         /* BDRV_REQ_SERIALISING is only for write operation */
         assert(!(read_flags & BDRV_REQ_SERIALISING));
-        bdrv_wait_serialising_requests(&req);
 
         ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
                                                     src, src_offset,
-- 
2.55.0


