Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F644C3601E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 01:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u32sr-0006Zg-NN; Thu, 10 Apr 2025 21:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u32sB-0006OJ-JH
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 21:08:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u32s8-0004Jh-GC
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 21:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744333675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iq5LHmolf3pV0bK0C03Cx524NrQH75iCgLrGQASdzck=;
 b=Hh5ZcGVBYpU3CAcVq18H5vsnRHlI7ZxE8vP2tgEN0dvS6G6nc1msmqBaQqQeKQmPjyyxHB
 iVgpmYY18Z6mMLK5ovl+R19HfQp3pwO8CuWlGw6YOpKcTS9BeV4nRjCsxFeabZCEBIyMJc
 jNjjkbkWeqECco0q5KJecafBjHLp4y0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-TJtKLOM8P4m0WEZCxAZCVw-1; Thu,
 10 Apr 2025 21:07:52 -0400
X-MC-Unique: TJtKLOM8P4m0WEZCxAZCVw-1
X-Mimecast-MFC-AGG-ID: TJtKLOM8P4m0WEZCxAZCVw_1744333671
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A81418004A9; Fri, 11 Apr 2025 01:07:51 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CC271801A69; Fri, 11 Apr 2025 01:07:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:raw)
Subject: [PATCH 5/6] file-posix: Recognize blockdev-create file as starting
 all zero
Date: Thu, 10 Apr 2025 20:04:55 -0500
Message-ID: <20250411010732.358817-13-eblake@redhat.com>
In-Reply-To: <20250411010732.358817-8-eblake@redhat.com>
References: <20250411010732.358817-8-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There are enough optimizations possible when a file is known to read
as all zero that it is worth taking the extra time during
raw_open_common() to catch more than just 100% sparse files.  In
particular, since our implementation of blockdev-create intentionally
allocates a small all-zero block at the front of a file to make
alignment probing easier, it is well worth the time spent checking
whether that early block reads as all zero if the rest of the file is
still sparse.

I decided to stick the special case lseek and read in open, rather
than in block status; which means the BDRVRawState struct gains
another bool that must be updated anywhere an action can change the
file's contents.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/file-posix.c | 89 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 12 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index dcf906a6a7c..342ade828d7 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -167,6 +167,7 @@ typedef struct BDRVRawState {
     bool force_alignment;
     bool drop_cache;
     bool check_cache_dropped;
+    bool all_zero;
     struct {
         uint64_t discard_nb_ok;
         uint64_t discard_nb_failed;
@@ -543,6 +544,43 @@ static void raw_parse_filename(const char *filename, QDict *options,
     bdrv_parse_filename_strip_prefix(filename, "file:", options);
 }

+static int find_allocation(int fd, off_t start, off_t *data, off_t *hole);
+
+/*
+ * Hueristic to determine if the file reads as all zeroes.  Accounts
+ * for files resulting from raw_co_create, where we intentionally
+ * allocated a small block of zeroes up front to make alignment
+ * probing easier.
+ */
+static bool raw_all_zero(int fd)
+{
+    off_t data, hole;
+    int ret;
+    char *buf;
+    size_t max_align = MAX(MAX_BLOCKSIZE, qemu_real_host_page_size());
+    bool result;
+
+    ret = find_allocation(fd, 0, &data, &hole);
+    if (ret == -ENXIO) {
+        return true;
+    } else if (ret < 0) {
+        return false;
+    }
+    /*
+     * If data is reasonably small, AND if the rest of the file is a
+     * hole, then it is worth reading the data portion to see if it
+     * reads as zero.
+     */
+    if (data != 0 || hole > max_align ||
+        find_allocation(fd, hole, &data, &hole) != -ENXIO) {
+        return false;
+    }
+    buf = qemu_memalign(max_align, max_align);
+    result = pread(fd, buf, hole, 0) == hole && buffer_is_zero(buf, hole);
+    qemu_vfree(buf);
+    return result;
+}
+
 static QemuOptsList raw_runtime_opts = {
     .name = "raw",
     .head = QTAILQ_HEAD_INITIALIZER(raw_runtime_opts.head),
@@ -756,9 +794,9 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
                        bs->drv->format_name, bs->filename);
             ret = -EINVAL;
             goto fail;
-        } else {
-            s->has_fallocate = true;
         }
+        s->has_fallocate = true;
+        s->all_zero = raw_all_zero(s->fd);
     } else {
         if (!(S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode))) {
             error_setg(errp, "'%s' driver requires '%s' to be either "
@@ -1695,9 +1733,13 @@ qemu_pwritev(int fd, const struct iovec *iov, int nr_iov, off_t offset)
 static ssize_t handle_aiocb_rw_vector(RawPosixAIOData *aiocb)
 {
     ssize_t len;
+    BDRVRawState *s = aiocb->bs->opaque;
+    bool do_write = aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND);

-    len = RETRY_ON_EINTR(
-        (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) ?
+    if (do_write) {
+        s->all_zero = false;
+    }
+    len = RETRY_ON_EINTR(do_write ?
             qemu_pwritev(aiocb->aio_fildes,
                            aiocb->io.iov,
                            aiocb->io.niov,
@@ -1724,9 +1766,11 @@ static ssize_t handle_aiocb_rw_linear(RawPosixAIOData *aiocb, char *buf)
 {
     ssize_t offset = 0;
     ssize_t len;
+    BDRVRawState *s = aiocb->bs->opaque;

     while (offset < aiocb->aio_nbytes) {
         if (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
+            s->all_zero = false;
             len = pwrite(aiocb->aio_fildes,
                          (const char *)buf + offset,
                          aiocb->aio_nbytes - offset,
@@ -2171,7 +2215,9 @@ static int handle_aiocb_copy_range(void *opaque)
     uint64_t bytes = aiocb->aio_nbytes;
     off_t in_off = aiocb->aio_offset;
     off_t out_off = aiocb->copy_range.aio_offset2;
+    BDRVRawState *s = aiocb->bs->opaque;

+    s->all_zero = false;
     while (bytes) {
         ssize_t ret = copy_file_range(aiocb->aio_fildes, &in_off,
                                       aiocb->copy_range.aio_fd2, &out_off,
@@ -2208,6 +2254,9 @@ static int handle_aiocb_discard(void *opaque)
     if (!s->has_discard) {
         return -ENOTSUP;
     }
+    if (!s->has_write_zeroes) {
+        s->all_zero = false;
+    }

     if (aiocb->aio_type & QEMU_AIO_BLKDEV) {
 #ifdef BLKDISCARD
@@ -2493,6 +2542,9 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
     int ret;
     uint64_t offset = *offset_ptr;

+    if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
+        s->all_zero = false;
+    }
     if (fd_open(bs) < 0)
         return -EIO;
 #if defined(CONFIG_BLKZONED)
@@ -3103,11 +3155,10 @@ static int coroutine_fn raw_co_delete_file(BlockDriverState *bs,
  * If @start is in a trailing hole or beyond EOF, return -ENXIO.
  * If we can't find out, return a negative errno other than -ENXIO.
  */
-static int find_allocation(BlockDriverState *bs, off_t start,
+static int find_allocation(int fd, off_t start,
                            off_t *data, off_t *hole)
 {
 #if defined SEEK_HOLE && defined SEEK_DATA
-    BDRVRawState *s = bs->opaque;
     off_t offs;

     /*
@@ -3121,7 +3172,7 @@ static int find_allocation(BlockDriverState *bs, off_t start,
      *     Treating like a trailing hole is simplest.
      * D4. offs < 0, errno != ENXIO: we learned nothing
      */
-    offs = lseek(s->fd, start, SEEK_DATA);
+    offs = lseek(fd, start, SEEK_DATA);
     if (offs < 0) {
         return -errno;          /* D3 or D4 */
     }
@@ -3158,7 +3209,7 @@ static int find_allocation(BlockDriverState *bs, off_t start,
      * H4. offs < 0, errno != ENXIO: we learned nothing
      *     Pretend we know nothing at all, i.e. "forget" about D1.
      */
-    offs = lseek(s->fd, start, SEEK_HOLE);
+    offs = lseek(fd, start, SEEK_HOLE);
     if (offs < 0) {
         return -errno;          /* D1 and (H3 or H4) */
     }
@@ -3207,6 +3258,7 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
                                             int64_t *map,
                                             BlockDriverState **file)
 {
+    BDRVRawState *s = bs->opaque;
     off_t data = 0, hole = 0;
     int ret;

@@ -3218,20 +3270,29 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
     }

     /*
-     * If mode != PRECISE, then the caller wants speed over
+     * If mode == ALLOCATED, then the caller wants speed over
      * accuracy, and the only place where SEEK_DATA should be
      * attempted is at the start of the file to learn if the file has
      * any data at all (anywhere else, just blindly claim the entire
-     * file is data).
+     * file is data).  If mode == ZERO, use internal status tracking
+     * to work around thet case where raw_co_block_status calls
+     * allocate_first_block to ease alignment probing but which breaks
+     * lseek hole detection.
      */
-    if (mode != BDRV_BSTAT_PRECISE && offset) {
+    if (mode == BDRV_BSTAT_ALLOCATED && offset) {
         *pnum = bytes;
         *map = offset;
         *file = bs;
         return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
     }
+    if (mode == BDRV_BSTAT_ZERO && s->all_zero) {
+        *pnum = bytes;
+        *map = offset;
+        *file = bs;
+        return BDRV_BLOCK_ZERO;
+    }

-    ret = find_allocation(bs, offset, &data, &hole);
+    ret = find_allocation(s->fd, offset, &data, &hole);
     if (ret == -ENXIO) {
         /* Trailing hole */
         *pnum = bytes;
@@ -3572,6 +3633,9 @@ raw_do_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes,
     RawPosixAIOData acb;
     int ret;

+    if (!s->has_write_zeroes) {
+        s->all_zero = false;
+    }
     acb = (RawPosixAIOData) {
         .bs             = bs,
         .aio_fildes     = s->fd,
@@ -3874,6 +3938,7 @@ raw_co_copy_range_to(BlockDriverState *bs,
     BDRVRawState *s = bs->opaque;
     BDRVRawState *src_s;

+    s->all_zero = false;
     assert(dst->bs == bs);
     if (src->bs->drv->bdrv_co_copy_range_to != raw_co_copy_range_to) {
         return -ENOTSUP;
-- 
2.49.0


