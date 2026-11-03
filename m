Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5912606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mr+mhBhQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5cb-0006VO-EL; Mon, 02 Nov 2026 22:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5ca-0006Ug-65
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cY-0000d6-0K
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793678137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sjqfj2wzoXejfi4liZUWjd6OlZpf96usT4utaYmK6A=;
 b=Mr+mhBhQH4O2b9NJ6ji/bcDDMa7MIliIpYZ1WyKt/HPjAT7rjDeJLfIkCS5LyRPzu3JFfR
 twMfiJE3ujmtJGJavxyhWP29wpcMv+H/Am1FGPxFcGCUhSWuWa64cHcMV0gpammWauWYzD
 X+GDNtX8nDMESCl61aU/QErLJfJUVS0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-IAaa0IZ2M96gWXTgzuV9gw-1; Mon,
 02 Nov 2026 22:55:36 -0500
X-MC-Unique: IAaa0IZ2M96gWXTgzuV9gw-1
X-Mimecast-MFC-AGG-ID: IAaa0IZ2M96gWXTgzuV9gw_1793678135
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B69AC1955E92; Tue,  3 Nov 2026 03:55:34 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A0FF7E5; Tue,  3 Nov 2026 03:55:33 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: [PULL 12/16] block/block-copy: rename
 block_copy_is_cluster_allocated()
Date: Mon,  2 Nov 2026 21:54:23 -0600
Message-ID: <20261103035506.2688772-30-eblake@redhat.com>
In-Reply-To: <20261103035506.2688772-18-eblake@redhat.com>
References: <20261103035506.2688772-18-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Denis V. Lunev" <den@openvz.org>

Since it started filling zero_bitmap, the function does more than its
name says: it is the scan's block-status query, reporting allocation and
recording zeroes. Rename it to block_copy_scan_status() and say so in
its comment. No behavior change.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20261030010613.1612771-9-den@openvz.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/block-copy.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 4f128a0ebdc..ad358f4d2f1 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -708,13 +708,13 @@ static void block_copy_mark_zero_prefix(BlockCopyState *s, int64_t offset,
 }

 /*
- * Check if the cluster starting at offset is allocated or not.
- * return via pnum the number of contiguous clusters sharing this allocation.
- * Also marks the zero prefix of the range in zero_bitmap.
+ * One block-status query of the scan at @offset: return 1 if the cluster
+ * there is allocated, 0 if not, -errno on failure, and via @pnum the number
+ * of contiguous clusters sharing that allocation. Their zero prefix goes
+ * into zero_bitmap.
  */
 static int coroutine_fn GRAPH_RDLOCK
-block_copy_is_cluster_allocated(BlockCopyState *s, int64_t offset,
-                                int64_t *pnum)
+block_copy_scan_status(BlockCopyState *s, int64_t offset, int64_t *pnum)
 {
     BlockDriverState *bs = s->source->bs;
     BlockDriverState *base = block_copy_status_base(s);
@@ -793,7 +793,7 @@ int64_t coroutine_fn block_copy_reset_unallocated(BlockCopyState *s,
     int ret;
     int64_t clusters, bytes;

-    ret = block_copy_is_cluster_allocated(s, offset, &clusters);
+    ret = block_copy_scan_status(s, offset, &clusters);
     if (ret < 0) {
         return ret;
     }
@@ -837,7 +837,7 @@ block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
     if (*cached_end < dirty_end) {
         int64_t clusters;
         int64_t query_offset = MAX(dirty_offset, *cached_end);
-        int ret = block_copy_is_cluster_allocated(s, query_offset, &clusters);
+        int ret = block_copy_scan_status(s, query_offset, &clusters);

         if (ret >= 0) {
             *cached_end = query_offset + clusters * s->cluster_size;
-- 
2.56.0


