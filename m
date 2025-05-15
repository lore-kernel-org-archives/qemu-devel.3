Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55873C3ABDA
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 02:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFOMj-0007tq-Ui; Wed, 14 May 2025 22:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFOLs-0007G8-2x
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFOLp-00046s-Ka
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747276176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qS6MTRFKqVySiDPTpylw4YikS1MZFF82/1zVsQkJN94=;
 b=Brt2L0das3uWH3iyncHBpKDNpa+T/FkiHOEny5HYM1HFr3sBKP7dmxDFgl3CeZZiWqKlrV
 l/4m7EBYFXvnaBlrmC26tqcnDud0uzk3BzseBTv0/g32+ZbSWornVBl2kQFht+zy0ypZeJ
 3Vau1zu96nbNlXd4oykzRsEjXu+2egI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-VfkNmDVeMeGijSgcvDMXmA-1; Wed,
 14 May 2025 22:29:33 -0400
X-MC-Unique: VfkNmDVeMeGijSgcvDMXmA-1
X-Mimecast-MFC-AGG-ID: VfkNmDVeMeGijSgcvDMXmA_1747276172
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E4A7195608B; Thu, 15 May 2025 02:29:32 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.66])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C79481953B80; Thu, 15 May 2025 02:29:29 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Sunny Zhu <sunnyzhyy@qq.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: [PULL 08/14] mirror: Allow QMP override to declare target already zero
Date: Wed, 14 May 2025 21:28:51 -0500
Message-ID: <20250515022904.575509-24-eblake@redhat.com>
In-Reply-To: <20250515022904.575509-16-eblake@redhat.com>
References: <20250515022904.575509-16-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

QEMU has an optimization for a just-created drive-mirror destination
that is not possible for blockdev-mirror (which can't create the
destination) - any time we know the destination starts life as all
zeroes, we can skip a pre-zeroing pass on the destination.  Recent
patches have added an improved heuristic for detecting if a file
contains all zeroes, and we plan to use that heuristic in upcoming
patches.  But since a heuristic cannot quickly detect all scenarios,
and there may be cases where the caller is aware of information that
QEMU cannot learn quickly, it makes sense to have a way to tell QEMU
to assume facts about the destination that can make the mirror
operation faster.  Given our existing example of "qemu-img convert
--target-is-zero", it is time to expose this override in QMP for
blockdev-mirror as well.

This patch results in some slight redundancy between the older
s->zero_target (set any time mode==FULL and the destination image was
not just created - ie. clear if drive-mirror is asking to skip the
pre-zero pass) and the newly-introduced s->target_is_zero (in addition
to the QMP override, it is set when drive-mirror creates the
destination image); this will be cleaned up in the next patch.

There is also a subtlety that we must consider.  When drive-mirror is
passing target_is_zero on behalf of a just-created image, we know the
image is sparse (skipping the pre-zeroing keeps it that way), so it
doesn't matter whether the destination also has "discard":"unmap" and
"detect-zeroes":"unmap".  But now that we are letting the user set the
knob for target-is-zero, if the user passes a pre-existing file that
is fully allocated, it is fine to leave the file fully allocated under
"detect-zeroes":"on", but if the file is open with
"detect-zeroes":"unmap", we should really be trying harder to punch
holes in the destination for every region of zeroes copied from the
source.  The easiest way to do this is to still run the pre-zeroing
pass (turning the entire destination file sparse before populating
just the allocated portions of the source), even though that currently
results in double I/O to the portions of the file that are allocated.
A later patch will add further optimizations to reduce redundant
zeroing I/O during the mirror operation.

Since "target-is-zero":true is designed for optimizations, it is okay
to silently ignore the parameter rather than erroring if the user ever
sets the parameter in a scenario where the mirror job can't exploit it
(for example, when doing "sync":"top" instead of "sync":"full", we
can't pre-zero, so setting the parameter won't make a speed
difference).

Signed-off-by: Eric Blake <eblake@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250509204341.3553601-23-eblake@redhat.com>
Reviewed-by: Sunny Zhu <sunnyzhyy@qq.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/block-core.json                   |  8 +++++++-
 include/block/block_int-global-state.h |  3 ++-
 block/mirror.c                         | 27 ++++++++++++++++++++++----
 blockdev.c                             | 18 ++++++++++-------
 tests/unit/test-block-iothread.c       |  2 +-
 5 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 91c70e24a7a..b4115113d4c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2542,6 +2542,11 @@
 #     disappear from the query list without user intervention.
 #     Defaults to true.  (Since 3.1)
 #
+# @target-is-zero: Assume the destination reads as all zeroes before
+#     the mirror started.  Setting this to true can speed up the
+#     mirror.  Setting this to true when the destination is not
+#     actually all zero can corrupt the destination.  (Since 10.1)
+#
 # Since: 2.6
 #
 # .. qmp-example::
@@ -2561,7 +2566,8 @@
             '*on-target-error': 'BlockdevOnError',
             '*filter-node-name': 'str',
             '*copy-mode': 'MirrorCopyMode',
-            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' },
+            '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
+            '*target-is-zero': 'bool'},
   'allow-preconfig': true }

 ##
diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index 0d93783763b..62a6c7e8e25 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -140,6 +140,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
  * @mode: Whether to collapse all images in the chain to the target.
  * @backing_mode: How to establish the target's backing chain after completion.
  * @zero_target: Whether the target should be explicitly zero-initialized
+ * @target_is_zero: Whether the target already is zero-initialized.
  * @on_source_error: The action to take upon error reading from the source.
  * @on_target_error: The action to take upon error writing to the target.
  * @unmap: Whether to unmap target where source sectors only contain zeroes.
@@ -159,7 +160,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
-                  bool zero_target,
+                  bool zero_target, bool target_is_zero,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
diff --git a/block/mirror.c b/block/mirror.c
index 2599b75d092..4dcb50c81ad 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -55,6 +55,8 @@ typedef struct MirrorBlockJob {
     BlockMirrorBackingMode backing_mode;
     /* Whether the target image requires explicit zero-initialization */
     bool zero_target;
+    /* Whether the target should be assumed to be already zero initialized */
+    bool target_is_zero;
     /*
      * To be accesssed with atomics. Written only under the BQL (required by the
      * current implementation of mirror_change()).
@@ -844,12 +846,26 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
     BlockDriverState *target_bs = blk_bs(s->target);
     int ret = -EIO;
     int64_t count;
+    bool punch_holes =
+        target_bs->detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP &&
+        bdrv_can_write_zeroes_with_unmap(target_bs);

     bdrv_graph_co_rdlock();
     bs = s->mirror_top_bs->backing->bs;
     bdrv_graph_co_rdunlock();

-    if (s->zero_target) {
+    if (s->zero_target && (!s->target_is_zero || punch_holes)) {
+        /*
+         * Here, we are in FULL mode; our goal is to avoid writing
+         * zeroes if the destination already reads as zero, except
+         * when we are trying to punch holes.  This is possible if
+         * zeroing happened externally (s->target_is_zero) or if we
+         * have a fast way to pre-zero the image (the dirty bitmap
+         * will be populated later by the non-zero portions, the same
+         * as for TOP mode).  If pre-zeroing is not fast, or we need
+         * to punch holes, then our only recourse is to write the
+         * entire image.
+         */
         if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
             bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
             return 0;
@@ -1714,7 +1730,7 @@ static BlockJob *mirror_start_job(
                              uint32_t granularity, int64_t buf_size,
                              MirrorSyncMode sync_mode,
                              BlockMirrorBackingMode backing_mode,
-                             bool zero_target,
+                             bool zero_target, bool target_is_zero,
                              BlockdevOnError on_source_error,
                              BlockdevOnError on_target_error,
                              bool unmap,
@@ -1883,6 +1899,7 @@ static BlockJob *mirror_start_job(
     s->sync_mode = sync_mode;
     s->backing_mode = backing_mode;
     s->zero_target = zero_target;
+    s->target_is_zero = target_is_zero;
     qatomic_set(&s->copy_mode, copy_mode);
     s->base = base;
     s->base_overlay = bdrv_find_overlay(bs, base);
@@ -2011,7 +2028,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
-                  bool zero_target,
+                  bool zero_target, bool target_is_zero,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
@@ -2034,7 +2051,8 @@ void mirror_start(const char *job_id, BlockDriverState *bs,

     mirror_start_job(job_id, bs, creation_flags, target, replaces,
                      speed, granularity, buf_size, mode, backing_mode,
-                     zero_target, on_source_error, on_target_error, unmap,
+                     zero_target,
+                     target_is_zero, on_source_error, on_target_error, unmap,
                      NULL, NULL, &mirror_job_driver, base, false,
                      filter_node_name, true, copy_mode, false, errp);
 }
@@ -2062,6 +2080,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
     job = mirror_start_job(
                      job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_SYNC_MODE_TOP, MIRROR_LEAVE_BACKING_CHAIN, false,
+                     false,
                      on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
diff --git a/blockdev.c b/blockdev.c
index 818ec425117..97128feb270 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2804,7 +2804,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    const char *replaces,
                                    enum MirrorSyncMode sync,
                                    BlockMirrorBackingMode backing_mode,
-                                   bool zero_target,
+                                   bool zero_target, bool target_is_zero,
                                    bool has_speed, int64_t speed,
                                    bool has_granularity, uint32_t granularity,
                                    bool has_buf_size, int64_t buf_size,
@@ -2915,11 +2915,10 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
     /* pass the node name to replace to mirror start since it's loose coupling
      * and will allow to check whether the node still exist at mirror completion
      */
-    mirror_start(job_id, bs, target,
-                 replaces, job_flags,
+    mirror_start(job_id, bs, target, replaces, job_flags,
                  speed, granularity, buf_size, sync, backing_mode, zero_target,
-                 on_source_error, on_target_error, unmap, filter_node_name,
-                 copy_mode, errp);
+                 target_is_zero, on_source_error, on_target_error, unmap,
+                 filter_node_name, copy_mode, errp);
 }

 void qmp_drive_mirror(DriveMirror *arg, Error **errp)
@@ -2934,6 +2933,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     int64_t size;
     const char *format = arg->format;
     bool zero_target;
+    bool target_is_zero;
     int ret;

     bs = qmp_get_root_bs(arg->device, errp);
@@ -3050,6 +3050,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     zero_target = (arg->sync == MIRROR_SYNC_MODE_FULL &&
                    (arg->mode == NEW_IMAGE_MODE_EXISTING ||
                     !bdrv_has_zero_init(target_bs)));
+    target_is_zero = (arg->mode != NEW_IMAGE_MODE_EXISTING &&
+                      bdrv_has_zero_init(target_bs));
     bdrv_graph_rdunlock_main_loop();


@@ -3061,7 +3063,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)

     blockdev_mirror_common(arg->job_id, bs, target_bs,
                            arg->replaces, arg->sync,
-                           backing_mode, zero_target,
+                           backing_mode, zero_target, target_is_zero,
                            arg->has_speed, arg->speed,
                            arg->has_granularity, arg->granularity,
                            arg->has_buf_size, arg->buf_size,
@@ -3091,6 +3093,7 @@ void qmp_blockdev_mirror(const char *job_id,
                          bool has_copy_mode, MirrorCopyMode copy_mode,
                          bool has_auto_finalize, bool auto_finalize,
                          bool has_auto_dismiss, bool auto_dismiss,
+                         bool has_target_is_zero, bool target_is_zero,
                          Error **errp)
 {
     BlockDriverState *bs;
@@ -3121,7 +3124,8 @@ void qmp_blockdev_mirror(const char *job_id,

     blockdev_mirror_common(job_id, bs, target_bs,
                            replaces, sync, backing_mode,
-                           zero_target, has_speed, speed,
+                           zero_target, has_target_is_zero && target_is_zero,
+                           has_speed, speed,
                            has_granularity, granularity,
                            has_buf_size, buf_size,
                            has_on_source_error, on_source_error,
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index e26b3be5939..54aed8252c0 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -755,7 +755,7 @@ static void test_propagate_mirror(void)

     /* Start a mirror job */
     mirror_start("job0", src, target, NULL, JOB_DEFAULT, 0, 0, 0,
-                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN, false,
+                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN, false, false,
                  BLOCKDEV_ON_ERROR_REPORT, BLOCKDEV_ON_ERROR_REPORT,
                  false, "filter_node", MIRROR_COPY_MODE_BACKGROUND,
                  &error_abort);
-- 
2.49.0


