Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7621AC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 20:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDUa6-0004PT-8V; Fri, 09 May 2025 16:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uDUZy-0004Kz-HQ
 for qemu-devel@nongnu.org; Fri, 09 May 2025 16:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uDUZu-0000k8-W3
 for qemu-devel@nongnu.org; Fri, 09 May 2025 16:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746823457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2B3sf8r9SacKytPd9bZ4LupIw8n96V+PAtpUrl74fk=;
 b=XfPqzOx9ejJI7WuCSDxTrEHXK0h+EIy93q6H/vddJbMnbBvYIn/tEtU1nKyorRgLf+R9if
 wdpErSyeHSKY+faMJN9QYL4rYtjcHgeXMZT0fZGNB+l182AZpwBtKTMouZhLDXIkVONYwC
 x3EE3soDgjE/MtwlHpuNZY/L4BhO7y0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-zb1FJ8DHOoOoWzwzMGxkPw-1; Fri,
 09 May 2025 16:44:15 -0400
X-MC-Unique: zb1FJ8DHOoOoWzwzMGxkPw-1
X-Mimecast-MFC-AGG-ID: zb1FJ8DHOoOoWzwzMGxkPw_1746823454
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7106218002A5; Fri,  9 May 2025 20:44:14 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.43])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A520F30001A1; Fri,  9 May 2025 20:44:12 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, sunnyzhyy@qq.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 09/13] mirror: Drop redundant zero_target parameter
Date: Fri,  9 May 2025 15:40:26 -0500
Message-ID: <20250509204341.3553601-24-eblake@redhat.com>
In-Reply-To: <20250509204341.3553601-15-eblake@redhat.com>
References: <20250509204341.3553601-15-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The two callers to a mirror job (drive-mirror and blockdev-mirror) set
zero_target precisely when sync mode == FULL, with the one exception
that drive-mirror skips zeroing the target if it was newly created and
reads as zero.  But given the previous patch, that exception is
equally captured by target_is_zero.  And since we recently updated
things to pass the sync mode all the way through to
mirror_dirty_init(), we can now reconstruct the same conditionals
without the redundant parameter.

Signed-off-by: Eric Blake <eblake@redhat.com>

---

v4: new patch
---
 include/block/block_int-global-state.h |  3 +--
 block/mirror.c                         | 13 +++++--------
 blockdev.c                             | 15 ++++-----------
 tests/unit/test-block-iothread.c       |  2 +-
 4 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index 8cf0003ce78..d21bd7fd2f5 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -139,7 +139,6 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
  * @buf_size: The amount of data that can be in flight at one time.
  * @mode: Whether to collapse all images in the chain to the target.
  * @backing_mode: How to establish the target's backing chain after completion.
- * @zero_target: Whether the target should be explicitly zero-initialized
  * @target_is_zero: Whether the target already is zero-initialized.
  * @on_source_error: The action to take upon error reading from the source.
  * @on_target_error: The action to take upon error writing to the target.
@@ -160,7 +159,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
-                  bool zero_target, bool target_is_zero,
+                  bool target_is_zero,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
diff --git a/block/mirror.c b/block/mirror.c
index 4dcb50c81ad..d04db85883d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -53,8 +53,6 @@ typedef struct MirrorBlockJob {
     Error *replace_blocker;
     MirrorSyncMode sync_mode;
     BlockMirrorBackingMode backing_mode;
-    /* Whether the target image requires explicit zero-initialization */
-    bool zero_target;
     /* Whether the target should be assumed to be already zero initialized */
     bool target_is_zero;
     /*
@@ -854,7 +852,9 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
     bs = s->mirror_top_bs->backing->bs;
     bdrv_graph_co_rdunlock();

-    if (s->zero_target && (!s->target_is_zero || punch_holes)) {
+    if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
+        /* In TOP mode, there is no benefit to a pre-zeroing pass.  */
+    } else if (!s->target_is_zero || punch_holes) {
         /*
          * Here, we are in FULL mode; our goal is to avoid writing
          * zeroes if the destination already reads as zero, except
@@ -1730,7 +1730,7 @@ static BlockJob *mirror_start_job(
                              uint32_t granularity, int64_t buf_size,
                              MirrorSyncMode sync_mode,
                              BlockMirrorBackingMode backing_mode,
-                             bool zero_target, bool target_is_zero,
+                             bool target_is_zero,
                              BlockdevOnError on_source_error,
                              BlockdevOnError on_target_error,
                              bool unmap,
@@ -1898,7 +1898,6 @@ static BlockJob *mirror_start_job(
     s->on_target_error = on_target_error;
     s->sync_mode = sync_mode;
     s->backing_mode = backing_mode;
-    s->zero_target = zero_target;
     s->target_is_zero = target_is_zero;
     qatomic_set(&s->copy_mode, copy_mode);
     s->base = base;
@@ -2028,7 +2027,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
-                  bool zero_target, bool target_is_zero,
+                  bool target_is_zero,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
@@ -2051,7 +2050,6 @@ void mirror_start(const char *job_id, BlockDriverState *bs,

     mirror_start_job(job_id, bs, creation_flags, target, replaces,
                      speed, granularity, buf_size, mode, backing_mode,
-                     zero_target,
                      target_is_zero, on_source_error, on_target_error, unmap,
                      NULL, NULL, &mirror_job_driver, base, false,
                      filter_node_name, true, copy_mode, false, errp);
@@ -2080,7 +2078,6 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
     job = mirror_start_job(
                      job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_SYNC_MODE_TOP, MIRROR_LEAVE_BACKING_CHAIN, false,
-                     false,
                      on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
diff --git a/blockdev.c b/blockdev.c
index 2e2fed539ee..7eb1ffb6396 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2798,7 +2798,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    const char *replaces,
                                    enum MirrorSyncMode sync,
                                    BlockMirrorBackingMode backing_mode,
-                                   bool zero_target, bool target_is_zero,
+                                   bool target_is_zero,
                                    bool has_speed, int64_t speed,
                                    bool has_granularity, uint32_t granularity,
                                    bool has_buf_size, int64_t buf_size,
@@ -2910,7 +2910,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
      * and will allow to check whether the node still exist at mirror completion
      */
     mirror_start(job_id, bs, target, replaces, job_flags,
-                 speed, granularity, buf_size, sync, backing_mode, zero_target,
+                 speed, granularity, buf_size, sync, backing_mode,
                  target_is_zero, on_source_error, on_target_error, unmap,
                  filter_node_name, copy_mode, errp);
 }
@@ -2926,7 +2926,6 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     int flags;
     int64_t size;
     const char *format = arg->format;
-    bool zero_target;
     bool target_is_zero;
     int ret;

@@ -3041,9 +3040,6 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     }

     bdrv_graph_rdlock_main_loop();
-    zero_target = (arg->sync == MIRROR_SYNC_MODE_FULL &&
-                   (arg->mode == NEW_IMAGE_MODE_EXISTING ||
-                    !bdrv_has_zero_init(target_bs)));
     target_is_zero = (arg->mode != NEW_IMAGE_MODE_EXISTING &&
                       bdrv_has_zero_init(target_bs));
     bdrv_graph_rdunlock_main_loop();
@@ -3057,7 +3053,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)

     blockdev_mirror_common(arg->job_id, bs, target_bs,
                            arg->replaces, arg->sync,
-                           backing_mode, zero_target, target_is_zero,
+                           backing_mode, target_is_zero,
                            arg->has_speed, arg->speed,
                            arg->has_granularity, arg->granularity,
                            arg->has_buf_size, arg->buf_size,
@@ -3094,7 +3090,6 @@ void qmp_blockdev_mirror(const char *job_id,
     BlockDriverState *target_bs;
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode = MIRROR_LEAVE_BACKING_CHAIN;
-    bool zero_target;
     int ret;

     bs = qmp_get_root_bs(device, errp);
@@ -3107,8 +3102,6 @@ void qmp_blockdev_mirror(const char *job_id,
         return;
     }

-    zero_target = (sync == MIRROR_SYNC_MODE_FULL);
-
     aio_context = bdrv_get_aio_context(bs);

     ret = bdrv_try_change_aio_context(target_bs, aio_context, NULL, errp);
@@ -3118,7 +3111,7 @@ void qmp_blockdev_mirror(const char *job_id,

     blockdev_mirror_common(job_id, bs, target_bs,
                            replaces, sync, backing_mode,
-                           zero_target, has_target_is_zero && target_is_zero,
+                           has_target_is_zero && target_is_zero,
                            has_speed, speed,
                            has_granularity, granularity,
                            has_buf_size, buf_size,
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 54aed8252c0..e26b3be5939 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -755,7 +755,7 @@ static void test_propagate_mirror(void)

     /* Start a mirror job */
     mirror_start("job0", src, target, NULL, JOB_DEFAULT, 0, 0, 0,
-                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN, false, false,
+                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN, false,
                  BLOCKDEV_ON_ERROR_REPORT, BLOCKDEV_ON_ERROR_REPORT,
                  false, "filter_node", MIRROR_COPY_MODE_BACKGROUND,
                  &error_abort);
-- 
2.49.0


