Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E3BCEE341
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLP7Q-0000kB-NQ; Tue, 18 Nov 2025 12:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP7K-0000hd-Bu
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP7I-0004ql-Gd
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763485423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RE/4zH9RR79g8ij8X4dGR2gR7vQk03dSUvTg97qFcAI=;
 b=Iz0Ksn/oe4zDb6QSLs7ySlq1a/tgMncFSGF+kAhzuSg6mezdFVKn0XK1c7YsIT9mFIPbri
 lvSX1J/oSkZzXM5S7I+As3IsE14C4pFEtDOEsuCGk4Vcig4J8nqJ+MVN2GWgXSjC7IqAhp
 //EQRan0GlGW9mYwXBlLt39UElYx7pM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-vTH9o_mDONOPagyCj6wV2g-1; Tue,
 18 Nov 2025 12:03:39 -0500
X-MC-Unique: vTH9o_mDONOPagyCj6wV2g-1
X-Mimecast-MFC-AGG-ID: vTH9o_mDONOPagyCj6wV2g_1763485418
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73A111800451; Tue, 18 Nov 2025 17:03:38 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEF8B300ABAF; Tue, 18 Nov 2025 17:03:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 16/19] block: Note in which AioContext AIO CBs are called
Date: Tue, 18 Nov 2025 18:02:53 +0100
Message-ID: <20251118170256.272087-17-kwolf@redhat.com>
In-Reply-To: <20251118170256.272087-1-kwolf@redhat.com>
References: <20251118170256.272087-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Hanna Czenczek <hreitz@redhat.com>

This doesn’t seem to be specified anywhere, but is something we probably
want to be clear.  I believe it is reasonable to implicitly assume that
callbacks are run in the current thread (unless explicitly noted
otherwise), so codify that assumption.

Some implementations don’t actually fulfill this contract yet.  The next
patches should rectify that.

Note: I don’t know of any user-visible bugs produced by not running AIO
callbacks in the original context.  AIO functionality is generally
mapped to coroutines through the use of bdrv_co_io_em_complete(), which
can run in any AioContext, and will always wake the yielding coroutine
in its original context.  The only benefit here is that running
bdrv_co_io_em_complete() in the original context will make that
aio_co_wake() most likely a simpler qemu_coroutine_enter() instead of
scheduling the wakeup through AioContext.co_schedule_bh.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-17-hreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index f2a4e863fc..cb0143ea77 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -508,7 +508,12 @@ struct BlockDriver {
         BlockDriverState *bs, BlockdevAmendOptions *opts, bool force,
         Error **errp);
 
-    /* aio */
+    /*
+     * AIO
+     * The given completion callback will be run in the same AioContext as the
+     * one in which the AIO function was called.
+     */
+
     BlockAIOCB * GRAPH_RDLOCK_PTR (*bdrv_aio_preadv)(BlockDriverState *bs,
         int64_t offset, int64_t bytes, QEMUIOVector *qiov,
         BdrvRequestFlags flags, BlockCompletionFunc *cb, void *opaque);
-- 
2.51.1


