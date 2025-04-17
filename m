Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7EAC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UBf-00045E-G5; Thu, 17 Apr 2025 14:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5UBa-000440-3h
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5UBX-0002uG-P4
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744915323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dakir4L3nktKnN6Yme7bev8PnDnH2GQk65lKvpaop5E=;
 b=a6jzrTOpAmJvhrdxJeppuu7FqLE8OkvXAmLOadwuIByrxRyzvEBizLxbfhW4RpcAaFDUzY
 S9V+0IbBmS9A1kLkPJ59v04qjXKkfP4LmcJ800mFpPPx3j9ItcWN3SQzeSyibHePEkoShq
 z+HhTUY0JKNLblhOmwsPql/OxnpqyMY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-ft3T3zqCMUGyzLSKHzjHYA-1; Thu,
 17 Apr 2025 14:42:00 -0400
X-MC-Unique: ft3T3zqCMUGyzLSKHzjHYA-1
X-Mimecast-MFC-AGG-ID: ft3T3zqCMUGyzLSKHzjHYA_1744915319
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09D341956086; Thu, 17 Apr 2025 18:41:59 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.121])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1ED651956095; Thu, 17 Apr 2025 18:41:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 04/11] block: Add new bdrv_co_is_all_zeroes() function
Date: Thu, 17 Apr 2025 13:39:09 -0500
Message-ID: <20250417184133.105746-17-eblake@redhat.com>
In-Reply-To: <20250417184133.105746-13-eblake@redhat.com>
References: <20250417184133.105746-13-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

There are some optimizations that require knowing if an image starts
out as reading all zeroes, such as making blockdev-mirror faster by
skipping the copying of source zeroes to the destination.  The
existing bdrv_co_is_zero_fast() is a good building block for answering
this question, but it tends to give an answer of 0 for a file we just
created via QMP 'blockdev-create' or similar (such as 'qemu-img create
-f raw').  Why?  Because file-posix.c insists on allocating a tiny
header to any file rather than leaving it 100% sparse, due to some
filesystems that are unable to answer alignment probes on a hole.  But
teaching file-posix.c to read the tiny header doesn't scale - the
problem of a small header is also visible when libvirt sets up an NBD
client to a just-created file on a migration destination host.

So, we need a wrapper function that handles a bit more complexity in a
common manner for all block devices - when the BDS is mostly a hole,
but has a small non-hole header, it is still worth the time to read
that header and check if it reads as all zeroes before giving up and
returning a pessimistic answer.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block-io.h |  2 ++
 block/io.c               | 58 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index b49e0537dd4..b99cc98d265 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -161,6 +161,8 @@ bdrv_is_allocated_above(BlockDriverState *bs, BlockDriverState *base,

 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset, int64_t bytes);
+int coroutine_fn GRAPH_RDLOCK
+bdrv_co_is_all_zeroes(BlockDriverState *bs);

 int GRAPH_RDLOCK
 bdrv_apply_auto_read_only(BlockDriverState *bs, const char *errmsg,
diff --git a/block/io.c b/block/io.c
index 6ef78070915..dc1341e4029 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2778,6 +2778,64 @@ int coroutine_fn bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset,
     return 1;
 }

+/*
+ * Check @bs (and its backing chain) to see if the entire image is known
+ * to read as zeroes.
+ * Return 1 if that is the case, 0 otherwise and -errno on error.
+ * This test is meant to be fast rather than accurate so returning 0
+ * does not guarantee non-zero data; however, it can report 1 in more
+ * cases than bdrv_co_is_zero_fast.
+ */
+int coroutine_fn bdrv_co_is_all_zeroes(BlockDriverState *bs)
+{
+    int ret;
+    int64_t pnum, bytes;
+    char *buf;
+    QEMUIOVector local_qiov;
+    IO_CODE();
+
+    bytes = bdrv_co_getlength(bs);
+    if (bytes < 0) {
+        return bytes;
+    }
+
+    /* First probe - see if the entire image reads as zero */
+    ret = bdrv_co_common_block_status_above(bs, NULL, false, BDRV_BSTAT_ZERO,
+                                            0, bytes, &pnum, NULL, NULL,
+                                            NULL);
+    if (ret < 0) {
+        return ret;
+    }
+    if (ret & BDRV_BLOCK_ZERO) {
+        return bdrv_co_is_zero_fast(bs, pnum, bytes - pnum);
+    }
+
+    /*
+     * Because of the way 'blockdev-create' works, raw files tend to
+     * be created with a non-sparse region at the front to make
+     * alignment probing easier.  If the block starts with only a
+     * small allocated region, it is still worth the effort to see if
+     * the rest of the image is still sparse, coupled with manually
+     * reading the first region to see if it reads zero after all.
+     */
+    if (pnum > qemu_real_host_page_size()) {
+        return 0;
+    }
+    ret = bdrv_co_is_zero_fast(bs, pnum, bytes - pnum);
+    if (ret <= 0) {
+        return ret;
+    }
+    /* Only the head of the image is unknown, and it's small.  Read it.  */
+    buf = qemu_blockalign(bs, pnum);
+    qemu_iovec_init_buf(&local_qiov, buf, pnum);
+    ret = bdrv_driver_preadv(bs, 0, pnum, &local_qiov, 0, 0);
+    if (ret >= 0) {
+        ret = buffer_is_zero(buf, pnum);
+    }
+    qemu_vfree(buf);
+    return ret;
+}
+
 int coroutine_fn bdrv_co_is_allocated(BlockDriverState *bs, int64_t offset,
                                       int64_t bytes, int64_t *pnum)
 {
-- 
2.49.0


