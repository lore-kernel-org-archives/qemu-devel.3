Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA9AC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 13:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Q7k-0005a4-0y; Fri, 10 May 2024 09:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s5Q7a-0005VP-Fc; Fri, 10 May 2024 09:17:12 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s5Q7T-0002AP-PO; Fri, 10 May 2024 09:17:08 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 574FB473F9;
 Fri, 10 May 2024 15:16:52 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com
Subject: [PATCH v3 2/5] block/mirror: replace is_none_mode with sync_mode in
 MirrorBlockJob struct
Date: Fri, 10 May 2024 15:16:44 +0200
Message-Id: <20240510131647.1256467-3-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240510131647.1256467-1-f.ebner@proxmox.com>
References: <20240510131647.1256467-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

It is more flexible and is done in preparation to support specifying a
working bitmap for mirror jobs. In particular, this makes it possible
to assert that @sync_mode=full when a bitmap is used. That assertion
is just to be sure, of course the mirror QMP commands will be made to
fail earlier with a clean error.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

New in v3.

 block/mirror.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index c0597039a5..ca23d6ef65 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -51,7 +51,7 @@ typedef struct MirrorBlockJob {
     BlockDriverState *to_replace;
     /* Used to block operations on the drive-mirror-replace target */
     Error *replace_blocker;
-    bool is_none_mode;
+    MirrorSyncMode sync_mode;
     BlockMirrorBackingMode backing_mode;
     /* Whether the target image requires explicit zero-initialization */
     bool zero_target;
@@ -722,7 +722,8 @@ static int mirror_exit_common(Job *job)
                              &error_abort);
 
     if (!abort && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
-        BlockDriverState *backing = s->is_none_mode ? src : s->base;
+        BlockDriverState *backing;
+        backing = s->sync_mode == MIRROR_SYNC_MODE_NONE ? src : s->base;
         BlockDriverState *unfiltered_target = bdrv_skip_filters(target_bs);
 
         if (bdrv_cow_bs(unfiltered_target) != backing) {
@@ -1015,7 +1016,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
     mirror_free_init(s);
 
     s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    if (!s->is_none_mode) {
+    if (s->sync_mode != MIRROR_SYNC_MODE_NONE) {
         ret = mirror_dirty_init(s);
         if (ret < 0 || job_is_cancelled(&s->common.job)) {
             goto immediate_exit;
@@ -1714,7 +1715,8 @@ static BlockJob *mirror_start_job(
                              BlockCompletionFunc *cb,
                              void *opaque,
                              const BlockJobDriver *driver,
-                             bool is_none_mode, BlockDriverState *base,
+                             MirrorSyncMode sync_mode,
+                             BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name,
                              bool is_mirror, MirrorCopyMode copy_mode,
                              Error **errp)
@@ -1871,7 +1873,7 @@ static BlockJob *mirror_start_job(
     s->replaces = g_strdup(replaces);
     s->on_source_error = on_source_error;
     s->on_target_error = on_target_error;
-    s->is_none_mode = is_none_mode;
+    s->sync_mode = sync_mode;
     s->backing_mode = backing_mode;
     s->zero_target = zero_target;
     qatomic_set(&s->copy_mode, copy_mode);
@@ -2008,20 +2010,18 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   bool unmap, const char *filter_node_name,
                   MirrorCopyMode copy_mode, Error **errp)
 {
-    bool is_none_mode;
     BlockDriverState *base;
 
     GLOBAL_STATE_CODE();
 
     bdrv_graph_rdlock_main_loop();
-    is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
     base = mode == MIRROR_SYNC_MODE_TOP ? bdrv_backing_chain_next(bs) : NULL;
     bdrv_graph_rdunlock_main_loop();
 
     mirror_start_job(job_id, bs, creation_flags, target, replaces,
                      speed, granularity, buf_size, backing_mode, zero_target,
                      on_source_error, on_target_error, unmap, NULL, NULL,
-                     &mirror_job_driver, is_none_mode, base, false,
+                     &mirror_job_driver, mode, base, false,
                      filter_node_name, true, copy_mode, errp);
 }
 
@@ -2049,9 +2049,9 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
                      job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_LEAVE_BACKING_CHAIN, false,
                      on_error, on_error, true, cb, opaque,
-                     &commit_active_job_driver, false, base, auto_complete,
-                     filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
-                     errp);
+                     &commit_active_job_driver, MIRROR_SYNC_MODE_FULL, base,
+                     auto_complete, filter_node_name, false,
+                     MIRROR_COPY_MODE_BACKGROUND, errp);
     if (!job) {
         goto error_restore_flags;
     }
-- 
2.39.2



