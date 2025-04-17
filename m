Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B95BC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UC4-0004TN-RN; Thu, 17 Apr 2025 14:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5UBb-00044p-Kr
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:42:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5UBX-0002td-Da
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744915321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SEEczVSQ8XxMy3TXTJCROAGAwA6Jyx1FD/YAkL3ooOk=;
 b=VH75kUm9KtXA45m5DaRbppKeve152FcKn8hFmnhPJn1FTzCITD9fZpaNJF9DIDWIzflXgs
 GBHGNIxfggzbr46uLXlMhtxcfsGW0l5rq7CM7L+1RQta5KdfIW49Y9s+RIxgr6aN0CIGm/
 qqSc6NaS61LplGAbEvBORHIqCApTwgs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-LKl-i6VDOgCmc-aodh99Wg-1; Thu,
 17 Apr 2025 14:41:57 -0400
X-MC-Unique: LKl-i6VDOgCmc-aodh99Wg-1
X-Mimecast-MFC-AGG-ID: LKl-i6VDOgCmc-aodh99Wg_1744915316
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74D1419560A5; Thu, 17 Apr 2025 18:41:50 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.121])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC8ED1956095; Thu, 17 Apr 2025 18:41:39 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@dlhnet.de>,
 "Denis V. Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>,
 Ilya Dryomov <idryomov@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 integration@gluster.org (open list:GLUSTER)
Subject: [PATCH v2 01/11] block: Expand block status mode from bool to enum
Date: Thu, 17 Apr 2025 13:39:06 -0500
Message-ID: <20250417184133.105746-14-eblake@redhat.com>
In-Reply-To: <20250417184133.105746-13-eblake@redhat.com>
References: <20250417184133.105746-13-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

This patch is purely mechanical, changing bool want_zero into a new
enum BlockStatusMode.  As of this patch, all implementations are
unchanged (the old want_zero==true is now mode==BDRV_BSTAT_PRECISE),
but the callers in io.c are set up so that future patches will be able
to differente between whether the caller cares more about allocation
or about reads-as-zero, for driver implementations that will actually
want to behave differently for those more-specific hints.

As for the background why this patch is useful: right now, the
file-posix driver recognizes that if allocation is being queried, the
entire image can be reported as allocated (there is no backing file to
refer to) - but this throws away information on whether the entire
image reads as zero (trivially true if lseek(SEEK_HOLE) at offset 0
returns -ENXIO, a bit more complicated to prove if the raw file was
created with 'qemu-img create' since we intentionally allocate a small
chunk of all-zero data to help with alignment probing).  The next
patches will add a generic algorithm for seeing if an entire file
reads as zeroes, as well as tweak the file-posix driver to react to
the new hints.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/coroutines.h               |  4 +--
 include/block/block-common.h     | 26 ++++++++++++++++
 include/block/block_int-common.h | 25 +++++++++-------
 include/block/block_int-io.h     |  4 +--
 block/io.c                       | 51 ++++++++++++++++----------------
 block/blkdebug.c                 |  6 ++--
 block/copy-before-write.c        |  4 +--
 block/file-posix.c               |  4 +--
 block/gluster.c                  |  4 +--
 block/iscsi.c                    |  6 ++--
 block/nbd.c                      |  4 +--
 block/null.c                     |  6 ++--
 block/parallels.c                |  6 ++--
 block/qcow.c                     |  2 +-
 block/qcow2.c                    |  6 ++--
 block/qed.c                      |  6 ++--
 block/quorum.c                   |  4 +--
 block/raw-format.c               |  4 +--
 block/rbd.c                      |  6 ++--
 block/snapshot-access.c          |  4 +--
 block/vdi.c                      |  4 +--
 block/vmdk.c                     |  2 +-
 block/vpc.c                      |  2 +-
 block/vvfat.c                    |  6 ++--
 tests/unit/test-block-iothread.c |  2 +-
 25 files changed, 114 insertions(+), 84 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index 79e5efbf752..c8323aa67e6 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -47,7 +47,7 @@ int coroutine_fn GRAPH_RDLOCK
 bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   BlockDriverState *base,
                                   bool include_base,
-                                  bool want_zero,
+                                  enum BlockStatusMode mode,
                                   int64_t offset,
                                   int64_t bytes,
                                   int64_t *pnum,
@@ -78,7 +78,7 @@ int co_wrapper_mixed_bdrv_rdlock
 bdrv_common_block_status_above(BlockDriverState *bs,
                                BlockDriverState *base,
                                bool include_base,
-                               bool want_zero,
+                               enum BlockStatusMode mode,
                                int64_t offset,
                                int64_t bytes,
                                int64_t *pnum,
diff --git a/include/block/block-common.h b/include/block/block-common.h
index 0b831ef87b1..619e75b9c8d 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -508,6 +508,32 @@ enum BdrvChildRoleBits {
                               | BDRV_CHILD_PRIMARY,
 };

+/* Modes for block status calls */
+enum BlockStatusMode {
+    /*
+     * Status should be as accurate as possible: _OFFSET_VALID
+     * and_OFFSET_ZERO should each be set where efficiently possible,
+     * extents may be smaller, and iteration through the entire block
+     * device may take more calls.
+     */
+    BDRV_BSTAT_PRECISE,
+
+    /*
+     * The caller is primarily concerned about overall allocation:
+     * favor larger *pnum, perhaps by coalescing extents and reporting
+     * _DATA instead of _ZERO, and without needing to read data or
+     * bothering with _OFFSET_VALID.
+     */
+    BDRV_BSTAT_ALLOCATED,
+
+    /*
+     * The caller is primarily concerned about whether the device
+     * reads as zero: favor a result of _ZERO, even if it requires
+     * reading a few sectors to verify, without needing _OFFSET_VALID.
+     */
+    BDRV_BSTAT_ZERO,
+};
+
 /* Mask of BdrvChildRoleBits values */
 typedef unsigned int BdrvChildRole;

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index ebb4e56a503..1fd94b2b568 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -610,13 +610,16 @@ struct BlockDriver {
      * and/or BDRV_BLOCK_RAW; if the current layer defers to a backing
      * layer, the result should be 0 (and not BDRV_BLOCK_ZERO).  See
      * block.h for the overall meaning of the bits.  As a hint, the
-     * flag want_zero is true if the caller cares more about precise
-     * mappings (favor accurate _OFFSET_VALID/_ZERO) or false for
-     * overall allocation (favor larger *pnum, perhaps by reporting
-     * _DATA instead of _ZERO).  The block layer guarantees input
-     * clamped to bdrv_getlength() and aligned to request_alignment,
-     * as well as non-NULL pnum, map, and file; in turn, the driver
-     * must return an error or set pnum to an aligned non-zero value.
+     * flag @mode is BDRV_BSTAT_PRECISE if the caller cares more about
+     * precise mappings (favor accurate _OFFSET_VALID/_ZERO),
+     * BDRV_BSTAT_ALLOCATED for overall allocation (favor larger
+     * *pnum, perhaps by reporting _DATA instead of _ZERO), or
+     * BDRV_BSTAT_ZERO for overall reads-as-zero (favor _ZERO, even if
+     * it requires reading a few sectors to verify).  The block layer
+     * guarantees input clamped to bdrv_getlength() and aligned to
+     * request_alignment, as well as non-NULL pnum, map, and file; in
+     * turn, the driver must return an error or set pnum to an aligned
+     * non-zero value.
      *
      * Note that @bytes is just a hint on how big of a region the
      * caller wants to inspect.  It is not a limit on *pnum.
@@ -628,8 +631,8 @@ struct BlockDriver {
      * to clamping *pnum for return to its caller.
      */
     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_block_status)(
-        BlockDriverState *bs,
-        bool want_zero, int64_t offset, int64_t bytes, int64_t *pnum,
+        BlockDriverState *bs, enum BlockStatusMode mode,
+        int64_t offset, int64_t bytes, int64_t *pnum,
         int64_t *map, BlockDriverState **file);

     /*
@@ -653,8 +656,8 @@ struct BlockDriver {
         QEMUIOVector *qiov, size_t qiov_offset);

     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_snapshot_block_status)(
-        BlockDriverState *bs, bool want_zero, int64_t offset, int64_t bytes,
-        int64_t *pnum, int64_t *map, BlockDriverState **file);
+        BlockDriverState *bs, enum BlockStatusMode mode, int64_t offset,
+        int64_t bytes, int64_t *pnum, int64_t *map, BlockDriverState **file);

     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_pdiscard_snapshot)(
         BlockDriverState *bs, int64_t offset, int64_t bytes);
diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 4a7cf2b4fdc..e019e81fa0c 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -38,8 +38,8 @@
 int coroutine_fn GRAPH_RDLOCK bdrv_co_preadv_snapshot(BdrvChild *child,
     int64_t offset, int64_t bytes, QEMUIOVector *qiov, size_t qiov_offset);
 int coroutine_fn GRAPH_RDLOCK bdrv_co_snapshot_block_status(
-    BlockDriverState *bs, bool want_zero, int64_t offset, int64_t bytes,
-    int64_t *pnum, int64_t *map, BlockDriverState **file);
+    BlockDriverState *bs, enum BlockStatusMode mode, int64_t offset,
+    int64_t bytes, int64_t *pnum, int64_t *map, BlockDriverState **file);
 int coroutine_fn GRAPH_RDLOCK bdrv_co_pdiscard_snapshot(BlockDriverState *bs,
     int64_t offset, int64_t bytes);

diff --git a/block/io.c b/block/io.c
index 1ba8d1aeea1..73c96084e62 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2364,10 +2364,8 @@ int bdrv_flush_all(void)
  * Drivers not implementing the functionality are assumed to not support
  * backing files, hence all their sectors are reported as allocated.
  *
- * If 'want_zero' is true, the caller is querying for mapping
- * purposes, with a focus on valid BDRV_BLOCK_OFFSET_VALID, _DATA, and
- * _ZERO where possible; otherwise, the result favors larger 'pnum',
- * with a focus on accurate BDRV_BLOCK_ALLOCATED.
+ * 'mode' serves as a hint as to which results are favored; see enum
+ * BlockStatusMode for details of the supported modes.
  *
  * If 'offset' is beyond the end of the disk image the return value is
  * BDRV_BLOCK_EOF and 'pnum' is set to 0.
@@ -2387,7 +2385,7 @@ int bdrv_flush_all(void)
  * set to the host mapping and BDS corresponding to the guest offset.
  */
 static int coroutine_fn GRAPH_RDLOCK
-bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
+bdrv_co_do_block_status(BlockDriverState *bs, enum BlockStatusMode mode,
                         int64_t offset, int64_t bytes,
                         int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
@@ -2476,7 +2474,7 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
             local_file = bs;
             local_map = aligned_offset;
         } else {
-            ret = bs->drv->bdrv_co_block_status(bs, want_zero, aligned_offset,
+            ret = bs->drv->bdrv_co_block_status(bs, mode, aligned_offset,
                                                 aligned_bytes, pnum, &local_map,
                                                 &local_file);

@@ -2488,10 +2486,10 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
              * the cache requires an RCU update, so double check here to avoid
              * such an update if possible.
              *
-             * Check want_zero, because we only want to update the cache when we
+             * Check mode, because we only want to update the cache when we
              * have accurate information about what is zero and what is data.
              */
-            if (want_zero &&
+            if (mode == BDRV_BSTAT_PRECISE &&
                 ret == (BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID) &&
                 QLIST_EMPTY(&bs->children))
             {
@@ -2548,7 +2546,7 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,

     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
-        ret = bdrv_co_do_block_status(local_file, want_zero, local_map,
+        ret = bdrv_co_do_block_status(local_file, mode, local_map,
                                       *pnum, pnum, &local_map, &local_file);
         goto out;
     }
@@ -2560,7 +2558,7 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,

         if (!cow_bs) {
             ret |= BDRV_BLOCK_ZERO;
-        } else if (want_zero) {
+        } else if (mode == BDRV_BSTAT_PRECISE) {
             int64_t size2 = bdrv_co_getlength(cow_bs);

             if (size2 >= 0 && offset >= size2) {
@@ -2569,14 +2567,14 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
         }
     }

-    if (want_zero && ret & BDRV_BLOCK_RECURSE &&
+    if (mode == BDRV_BSTAT_PRECISE && ret & BDRV_BLOCK_RECURSE &&
         local_file && local_file != bs &&
         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
         (ret & BDRV_BLOCK_OFFSET_VALID)) {
         int64_t file_pnum;
         int ret2;

-        ret2 = bdrv_co_do_block_status(local_file, want_zero, local_map,
+        ret2 = bdrv_co_do_block_status(local_file, mode, local_map,
                                        *pnum, &file_pnum, NULL, NULL);
         if (ret2 >= 0) {
             /* Ignore errors.  This is just providing extra information, it
@@ -2627,7 +2625,7 @@ int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   BlockDriverState *base,
                                   bool include_base,
-                                  bool want_zero,
+                                  enum BlockStatusMode mode,
                                   int64_t offset,
                                   int64_t bytes,
                                   int64_t *pnum,
@@ -2654,7 +2652,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
         return 0;
     }

-    ret = bdrv_co_do_block_status(bs, want_zero, offset, bytes, pnum,
+    ret = bdrv_co_do_block_status(bs, mode, offset, bytes, pnum,
                                   map, file);
     ++*depth;
     if (ret < 0 || *pnum == 0 || ret & BDRV_BLOCK_ALLOCATED || bs == base) {
@@ -2671,7 +2669,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     for (p = bdrv_filter_or_cow_bs(bs); include_base || p != base;
          p = bdrv_filter_or_cow_bs(p))
     {
-        ret = bdrv_co_do_block_status(p, want_zero, offset, bytes, pnum,
+        ret = bdrv_co_do_block_status(p, mode, offset, bytes, pnum,
                                       map, file);
         ++*depth;
         if (ret < 0) {
@@ -2734,7 +2732,8 @@ int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
                                             BlockDriverState **file)
 {
     IO_CODE();
-    return bdrv_co_common_block_status_above(bs, base, false, true, offset,
+    return bdrv_co_common_block_status_above(bs, base, false,
+                                             BDRV_BSTAT_PRECISE, offset,
                                              bytes, pnum, map, file, NULL);
 }

@@ -2765,8 +2764,9 @@ int coroutine_fn bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset,
         return 1;
     }

-    ret = bdrv_co_common_block_status_above(bs, NULL, false, false, offset,
-                                            bytes, &pnum, NULL, NULL, NULL);
+    ret = bdrv_co_common_block_status_above(bs, NULL, false, BDRV_BSTAT_ZERO,
+                                            offset, bytes, &pnum, NULL, NULL,
+                                            NULL);

     if (ret < 0) {
         return ret;
@@ -2782,9 +2782,9 @@ int coroutine_fn bdrv_co_is_allocated(BlockDriverState *bs, int64_t offset,
     int64_t dummy;
     IO_CODE();

-    ret = bdrv_co_common_block_status_above(bs, bs, true, false, offset,
-                                            bytes, pnum ? pnum : &dummy, NULL,
-                                            NULL, NULL);
+    ret = bdrv_co_common_block_status_above(bs, bs, true, BDRV_BSTAT_ALLOCATED,
+                                            offset, bytes, pnum ? pnum : &dummy,
+                                            NULL, NULL, NULL);
     if (ret < 0) {
         return ret;
     }
@@ -2817,7 +2817,8 @@ int coroutine_fn bdrv_co_is_allocated_above(BlockDriverState *bs,
     int ret;
     IO_CODE();

-    ret = bdrv_co_common_block_status_above(bs, base, include_base, false,
+    ret = bdrv_co_common_block_status_above(bs, base, include_base,
+                                            BDRV_BSTAT_ALLOCATED,
                                             offset, bytes, pnum, NULL, NULL,
                                             &depth);
     if (ret < 0) {
@@ -3709,8 +3710,8 @@ bdrv_co_preadv_snapshot(BdrvChild *child, int64_t offset, int64_t bytes,
 }

 int coroutine_fn
-bdrv_co_snapshot_block_status(BlockDriverState *bs,
-                              bool want_zero, int64_t offset, int64_t bytes,
+bdrv_co_snapshot_block_status(BlockDriverState *bs, enum BlockStatusMode mode,
+                              int64_t offset, int64_t bytes,
                               int64_t *pnum, int64_t *map,
                               BlockDriverState **file)
 {
@@ -3728,7 +3729,7 @@ bdrv_co_snapshot_block_status(BlockDriverState *bs,
     }

     bdrv_inc_in_flight(bs);
-    ret = drv->bdrv_co_snapshot_block_status(bs, want_zero, offset, bytes,
+    ret = drv->bdrv_co_snapshot_block_status(bs, mode, offset, bytes,
                                              pnum, map, file);
     bdrv_dec_in_flight(bs);

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 1c1967f8e0a..f3eba9e6f27 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -751,9 +751,9 @@ blkdebug_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
 }

 static int coroutine_fn GRAPH_RDLOCK
-blkdebug_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
-                         int64_t bytes, int64_t *pnum, int64_t *map,
-                         BlockDriverState **file)
+blkdebug_co_block_status(BlockDriverState *bs, enum BlockStatusMode mode,
+                         int64_t offset, int64_t bytes, int64_t *pnum,
+                         int64_t *map, BlockDriverState **file)
 {
     int err;

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index fd470f5f926..e75e6925e50 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -291,8 +291,8 @@ cbw_co_preadv_snapshot(BlockDriverState *bs, int64_t offset, int64_t bytes,
 }

 static int coroutine_fn GRAPH_RDLOCK
-cbw_co_snapshot_block_status(BlockDriverState *bs,
-                             bool want_zero, int64_t offset, int64_t bytes,
+cbw_co_snapshot_block_status(BlockDriverState *bs, enum BlockStatusMode mode,
+                             int64_t offset, int64_t bytes,
                              int64_t *pnum, int64_t *map,
                              BlockDriverState **file)
 {
diff --git a/block/file-posix.c b/block/file-posix.c
index 56d1972d156..30129ec9b37 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3201,7 +3201,7 @@ static int find_allocation(BlockDriverState *bs, off_t start,
  * well exceed it.
  */
 static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
-                                            bool want_zero,
+                                            enum BlockStatusMode mode,
                                             int64_t offset,
                                             int64_t bytes, int64_t *pnum,
                                             int64_t *map,
@@ -3217,7 +3217,7 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
         return ret;
     }

-    if (!want_zero) {
+    if (mode != BDRV_BSTAT_PRECISE) {
         *pnum = bytes;
         *map = offset;
         *file = bs;
diff --git a/block/gluster.c b/block/gluster.c
index c6d25ae7335..f5ee3cdcc1f 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1465,7 +1465,7 @@ exit:
  * (Based on raw_co_block_status() from file-posix.c.)
  */
 static int coroutine_fn qemu_gluster_co_block_status(BlockDriverState *bs,
-                                                     bool want_zero,
+                                                     enum BlockStatusMode mode,
                                                      int64_t offset,
                                                      int64_t bytes,
                                                      int64_t *pnum,
@@ -1482,7 +1482,7 @@ static int coroutine_fn qemu_gluster_co_block_status(BlockDriverState *bs,
         return ret;
     }

-    if (!want_zero) {
+    if (mode != BDRV_BSTAT_PRECISE) {
         *pnum = bytes;
         *map = offset;
         *file = bs;
diff --git a/block/iscsi.c b/block/iscsi.c
index 2f0f4dac097..c7b425597f0 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -694,9 +694,9 @@ out_unlock:


 static int coroutine_fn iscsi_co_block_status(BlockDriverState *bs,
-                                              bool want_zero, int64_t offset,
-                                              int64_t bytes, int64_t *pnum,
-                                              int64_t *map,
+                                              enum BlockStatusMode mode,
+                                              int64_t offset, int64_t bytes,
+                                              int64_t *pnum, int64_t *map,
                                               BlockDriverState **file)
 {
     IscsiLun *iscsilun = bs->opaque;
diff --git a/block/nbd.c b/block/nbd.c
index 887841bc813..591dedde62e 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1397,8 +1397,8 @@ nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
 }

 static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
-        BlockDriverState *bs, bool want_zero, int64_t offset, int64_t bytes,
-        int64_t *pnum, int64_t *map, BlockDriverState **file)
+        BlockDriverState *bs, enum BlockStatusMode mode, int64_t offset,
+        int64_t bytes, int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
     int ret, request_ret;
     NBDExtent64 extent = { 0 };
diff --git a/block/null.c b/block/null.c
index dc0b1fdbd9b..66470787cfd 100644
--- a/block/null.c
+++ b/block/null.c
@@ -227,9 +227,9 @@ static int null_reopen_prepare(BDRVReopenState *reopen_state,
 }

 static int coroutine_fn null_co_block_status(BlockDriverState *bs,
-                                             bool want_zero, int64_t offset,
-                                             int64_t bytes, int64_t *pnum,
-                                             int64_t *map,
+                                             enum BlockStatusMode mode,
+                                             int64_t offset, int64_t bytes,
+                                             int64_t *pnum, int64_t *map,
                                              BlockDriverState **file)
 {
     BDRVNullState *s = bs->opaque;
diff --git a/block/parallels.c b/block/parallels.c
index 347ca127f34..93b42b47239 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -416,9 +416,9 @@ parallels_co_flush_to_os(BlockDriverState *bs)
 }

 static int coroutine_fn GRAPH_RDLOCK
-parallels_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
-                          int64_t bytes, int64_t *pnum, int64_t *map,
-                          BlockDriverState **file)
+parallels_co_block_status(BlockDriverState *bs, enum BlockStatusMode mode,
+                          int64_t offset, int64_t bytes, int64_t *pnum,
+                          int64_t *map, BlockDriverState **file)
 {
     BDRVParallelsState *s = bs->opaque;
     int count;
diff --git a/block/qcow.c b/block/qcow.c
index da8ad4d2430..de7fb42c51c 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -530,7 +530,7 @@ get_cluster_offset(BlockDriverState *bs, uint64_t offset, int allocate,
 }

 static int coroutine_fn GRAPH_RDLOCK
-qcow_co_block_status(BlockDriverState *bs, bool want_zero,
+qcow_co_block_status(BlockDriverState *bs, enum BlockStatusMode mode,
                      int64_t offset, int64_t bytes, int64_t *pnum,
                      int64_t *map, BlockDriverState **file)
 {
diff --git a/block/qcow2.c b/block/qcow2.c
index 7774e7f0909..14fa1c00df1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2141,9 +2141,9 @@ static void qcow2_join_options(QDict *options, QDict *old_options)
 }

 static int coroutine_fn GRAPH_RDLOCK
-qcow2_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
-                      int64_t count, int64_t *pnum, int64_t *map,
-                      BlockDriverState **file)
+qcow2_co_block_status(BlockDriverState *bs, enum BlockStatusMode mode,
+                      int64_t offset, int64_t count, int64_t *pnum,
+                      int64_t *map, BlockDriverState **file)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t host_offset;
diff --git a/block/qed.c b/block/qed.c
index ac24449ffb3..6e57859d05f 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -833,9 +833,9 @@ fail:
 }

 static int coroutine_fn GRAPH_RDLOCK
-bdrv_qed_co_block_status(BlockDriverState *bs, bool want_zero, int64_t pos,
-                         int64_t bytes, int64_t *pnum, int64_t *map,
-                         BlockDriverState **file)
+bdrv_qed_co_block_status(BlockDriverState *bs, enum BlockStatusMode mode,
+                         int64_t pos, int64_t bytes, int64_t *pnum,
+                         int64_t *map, BlockDriverState **file)
 {
     BDRVQEDState *s = bs->opaque;
     size_t len = MIN(bytes, SIZE_MAX);
diff --git a/block/quorum.c b/block/quorum.c
index 30747a6df93..97091136fcb 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1226,7 +1226,7 @@ static void quorum_child_perm(BlockDriverState *bs, BdrvChild *c,
  * region contains zeroes, and BDRV_BLOCK_DATA otherwise.
  */
 static int coroutine_fn GRAPH_RDLOCK
-quorum_co_block_status(BlockDriverState *bs, bool want_zero,
+quorum_co_block_status(BlockDriverState *bs, enum BlockStatusMode mode,
                        int64_t offset, int64_t count,
                        int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
@@ -1238,7 +1238,7 @@ quorum_co_block_status(BlockDriverState *bs, bool want_zero,
     for (i = 0; i < s->num_children; i++) {
         int64_t bytes;
         ret = bdrv_co_common_block_status_above(s->children[i]->bs, NULL, false,
-                                                want_zero, offset, count,
+                                                mode, offset, count,
                                                 &bytes, NULL, NULL, NULL);
         if (ret < 0) {
             quorum_report_bad(QUORUM_OP_TYPE_READ, offset, count,
diff --git a/block/raw-format.c b/block/raw-format.c
index e08526e2eca..0ff5367123b 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -283,8 +283,8 @@ fail:
 }

 static int coroutine_fn GRAPH_RDLOCK
-raw_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
-                    int64_t bytes, int64_t *pnum, int64_t *map,
+raw_co_block_status(BlockDriverState *bs, enum BlockStatusMode mode,
+                    int64_t offset, int64_t bytes, int64_t *pnum, int64_t *map,
                     BlockDriverState **file)
 {
     BDRVRawState *s = bs->opaque;
diff --git a/block/rbd.c b/block/rbd.c
index af984fb7db4..abcdd5e4e76 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1504,9 +1504,9 @@ static int qemu_rbd_diff_iterate_cb(uint64_t offs, size_t len,
 }

 static int coroutine_fn qemu_rbd_co_block_status(BlockDriverState *bs,
-                                                 bool want_zero, int64_t offset,
-                                                 int64_t bytes, int64_t *pnum,
-                                                 int64_t *map,
+                                                 enum BlockStatusMode mode,
+                                                 int64_t offset, int64_t bytes,
+                                                 int64_t *pnum, int64_t *map,
                                                  BlockDriverState **file)
 {
     BDRVRBDState *s = bs->opaque;
diff --git a/block/snapshot-access.c b/block/snapshot-access.c
index 71ac83c01f0..1d91b6df5d7 100644
--- a/block/snapshot-access.c
+++ b/block/snapshot-access.c
@@ -41,11 +41,11 @@ snapshot_access_co_preadv_part(BlockDriverState *bs,

 static int coroutine_fn GRAPH_RDLOCK
 snapshot_access_co_block_status(BlockDriverState *bs,
-                                bool want_zero, int64_t offset,
+                                enum BlockStatusMode mode, int64_t offset,
                                 int64_t bytes, int64_t *pnum,
                                 int64_t *map, BlockDriverState **file)
 {
-    return bdrv_co_snapshot_block_status(bs->file->bs, want_zero, offset,
+    return bdrv_co_snapshot_block_status(bs->file->bs, mode, offset,
                                          bytes, pnum, map, file);
 }

diff --git a/block/vdi.c b/block/vdi.c
index a2da6ecab01..9a9d402c946 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -523,8 +523,8 @@ static int vdi_reopen_prepare(BDRVReopenState *state,
 }

 static int coroutine_fn GRAPH_RDLOCK
-vdi_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
-                    int64_t bytes, int64_t *pnum, int64_t *map,
+vdi_co_block_status(BlockDriverState *bs, enum BlockStatusMode mode,
+                    int64_t offset, int64_t bytes, int64_t *pnum, int64_t *map,
                     BlockDriverState **file)
 {
     BDRVVdiState *s = (BDRVVdiState *)bs->opaque;
diff --git a/block/vmdk.c b/block/vmdk.c
index 2adec499122..6e2fd8d16ef 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1777,7 +1777,7 @@ static inline uint64_t vmdk_find_offset_in_cluster(VmdkExtent *extent,
 }

 static int coroutine_fn GRAPH_RDLOCK
-vmdk_co_block_status(BlockDriverState *bs, bool want_zero,
+vmdk_co_block_status(BlockDriverState *bs, enum BlockStatusMode mode,
                      int64_t offset, int64_t bytes, int64_t *pnum,
                      int64_t *map, BlockDriverState **file)
 {
diff --git a/block/vpc.c b/block/vpc.c
index 0309e319f60..4eac32fd1c4 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -726,7 +726,7 @@ fail:
 }

 static int coroutine_fn GRAPH_RDLOCK
-vpc_co_block_status(BlockDriverState *bs, bool want_zero,
+vpc_co_block_status(BlockDriverState *bs, enum BlockStatusMode mode,
                     int64_t offset, int64_t bytes,
                     int64_t *pnum, int64_t *map,
                     BlockDriverState **file)
diff --git a/block/vvfat.c b/block/vvfat.c
index 91d69b3cc83..336679cac12 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3134,9 +3134,9 @@ vvfat_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
 }

 static int coroutine_fn vvfat_co_block_status(BlockDriverState *bs,
-                                              bool want_zero, int64_t offset,
-                                              int64_t bytes, int64_t *n,
-                                              int64_t *map,
+                                              enum BlockStatusMode mode,
+                                              int64_t offset, int64_t bytes,
+                                              int64_t *n, int64_t *map,
                                               BlockDriverState **file)
 {
     *n = bytes;
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 2b358eaaa82..8189b32fd52 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -63,7 +63,7 @@ bdrv_test_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
 }

 static int coroutine_fn bdrv_test_co_block_status(BlockDriverState *bs,
-                                                  bool want_zero,
+                                                  enum BlockStatusMode mode,
                                                   int64_t offset, int64_t count,
                                                   int64_t *pnum, int64_t *map,
                                                   BlockDriverState **file)
-- 
2.49.0


