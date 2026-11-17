Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94E606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H40U7L9A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTMp9-0006ap-0x; Tue, 17 Nov 2026 12:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTMp7-0006Z0-1a
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:18:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTMp4-0006aZ-LV
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794935902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcaOoBTpm7xnV3dARlnzMyGV1Kqy5XZGkQnGPk6b4qs=;
 b=H40U7L9Ak51x9DRqgUPjiqQDDpjXgbxAwLMd3SmCFF/E9V9wcERLqAfOttve2uGaBnbPKo
 07dEFvHw14jNCd5MjcWtM1GvJI1CP/29cEa2YudCA2023f/PUbP5BabCKt2tqYKi3M1R7B
 UNJChkc5m8GFi1djmGv+VoNnpmbJRyI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-kq2837fjNcmKQS_ea9_dYw-1; Tue,
 17 Nov 2026 12:18:19 -0500
X-MC-Unique: kq2837fjNcmKQS_ea9_dYw-1
X-Mimecast-MFC-AGG-ID: kq2837fjNcmKQS_ea9_dYw_1794935897
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAA511955F14; Tue, 17 Nov 2026 17:18:17 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 699E8195B3C5; Tue, 17 Nov 2026 17:18:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 7/8] block: add bdrv_child_notify_resize() to notify a single
 parent
Date: Tue, 17 Nov 2026 18:17:57 +0100
Message-ID: <20261117171758.237462-8-kwolf@redhat.com>
In-Reply-To: <20261117171758.237462-1-kwolf@redhat.com>
References: <20261117171758.237462-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

bdrv_co_parent_cb_resize() calls the resize hook of every parent of a
node. bdrv_replace_child_bs() needs to call it for one BdrvChild, and
from outside a coroutine.

Move the call into bdrv_co_child_notify_resize(), make the loop use it,
and add a co_wrapper for callers outside a coroutine.

No functional change.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261105203752.3169635-3-den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-io.h |  9 +++++++++
 block/io.c                   | 14 +++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 95d0dd7a05f..3cb72fecd4f 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -197,6 +197,15 @@ void bdrv_bsc_fill(BlockDriverState *bs, int64_t offset, int64_t bytes);
 void coroutine_fn GRAPH_RDLOCK
 bdrv_co_parent_cb_resize(BlockDriverState *bs);
 
+/*
+ * Notify the parent behind @c that the size of its child changed.
+ */
+void coroutine_fn GRAPH_RDLOCK
+bdrv_co_child_notify_resize(BdrvChild *c);
+
+void co_wrapper_bdrv_rdlock
+bdrv_child_notify_resize(BdrvChild *c);
+
 void co_wrapper_bdrv_rdlock
 bdrv_parent_cb_resize(BlockDriverState *bs);
 
diff --git a/block/io.c b/block/io.c
index 0f81b7e6bb9..e4568d4d244 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3636,6 +3636,16 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, int64_t src_offset,
                                    bytes, read_flags, write_flags);
 }
 
+void coroutine_fn bdrv_co_child_notify_resize(BdrvChild *c)
+{
+    IO_CODE();
+    assert_bdrv_graph_readable();
+
+    if (c->klass->resize) {
+        c->klass->resize(c);
+    }
+}
+
 void coroutine_fn bdrv_co_parent_cb_resize(BlockDriverState *bs)
 {
     BdrvChild *c;
@@ -3644,9 +3654,7 @@ void coroutine_fn bdrv_co_parent_cb_resize(BlockDriverState *bs)
     assert_bdrv_graph_readable();
 
     QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c->klass->resize) {
-            c->klass->resize(c);
-        }
+        bdrv_co_child_notify_resize(c);
     }
 }
 
-- 
2.56.1


