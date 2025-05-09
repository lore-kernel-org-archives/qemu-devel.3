Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3257C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 20:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDUZw-0004KP-Oj; Fri, 09 May 2025 16:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uDUZs-0004Je-1A
 for qemu-devel@nongnu.org; Fri, 09 May 2025 16:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uDUZq-0000jm-4Y
 for qemu-devel@nongnu.org; Fri, 09 May 2025 16:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746823452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bt9ciO9xtC+P6dAwJEo8ZFWr16xXyTlX5io0AQHbKGQ=;
 b=K/S9q23XPXdemvuVQzHavk8w+bB4nmIZDZ5xfPILGboAQUcmg6pdf209PSSUe/nzKduNSn
 GFe8WeiNUjtp7dfWuFbnGJaEHLXeTxpazDxYo3NIp/Te9+4f6rFOuHJ7qvmuydjIICqJLa
 c+jrjUklyMdpuk/ByO548hq3+isiNgY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-BdWtDiO2Ns6JsiDKO176cA-1; Fri,
 09 May 2025 16:44:09 -0400
X-MC-Unique: BdWtDiO2Ns6JsiDKO176cA-1
X-Mimecast-MFC-AGG-ID: BdWtDiO2Ns6JsiDKO176cA_1746823448
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A700A1956089; Fri,  9 May 2025 20:44:08 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.43])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDFA230001A1; Fri,  9 May 2025 20:44:06 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, sunnyzhyy@qq.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 07/13] mirror: Pass full sync mode rather than bool to
 internals
Date: Fri,  9 May 2025 15:40:24 -0500
Message-ID: <20250509204341.3553601-22-eblake@redhat.com>
In-Reply-To: <20250509204341.3553601-15-eblake@redhat.com>
References: <20250509204341.3553601-15-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Out of the five possible values for MirrorSyncMode, INCREMENTAL and
BITMAP are already rejected up front in mirror_start, leaving NONE,
TOP, and FULL as the remaining values that the code was collapsing
into a single bool is_none_mode.  Furthermore, mirror_dirty_init() is
only reachable for modes TOP and FULL, as further guided by
s->zero_target.  However, upcoming patches want to further optimize
the pre-zeroing pass of a sync=full mirror in mirror_dirty_init(),
while avoiding that pass on a sync=top action.  Instead of throwing
away context by collapsing these two values into
s->is_none_mode=false, it is better to pass s->sync_mode throughout
the entire operation.  For active commit, the desired semantics match
sync mode TOP.

Signed-off-by: Eric Blake <eblake@redhat.com>

---

v4: new patch
---
 block/mirror.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 34c6c5252e1..2599b75d092 100644
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
@@ -723,9 +723,10 @@ static int mirror_exit_common(Job *job)
                              &error_abort);

     if (!abort && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
-        BlockDriverState *backing = s->is_none_mode ? src : s->base;
+        BlockDriverState *backing;
         BlockDriverState *unfiltered_target = bdrv_skip_filters(target_bs);

+        backing = s->sync_mode == MIRROR_SYNC_MODE_NONE ? src : s->base;
         if (bdrv_cow_bs(unfiltered_target) != backing) {
             bdrv_set_backing_hd(unfiltered_target, backing, &local_err);
             if (local_err) {
@@ -1020,7 +1021,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
     mirror_free_init(s);

     s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    if (!s->is_none_mode) {
+    if (s->sync_mode != MIRROR_SYNC_MODE_NONE) {
         ret = mirror_dirty_init(s);
         if (ret < 0 || job_is_cancelled(&s->common.job)) {
             goto immediate_exit;
@@ -1711,6 +1712,7 @@ static BlockJob *mirror_start_job(
                              int creation_flags, BlockDriverState *target,
                              const char *replaces, int64_t speed,
                              uint32_t granularity, int64_t buf_size,
+                             MirrorSyncMode sync_mode,
                              BlockMirrorBackingMode backing_mode,
                              bool zero_target,
                              BlockdevOnError on_source_error,
@@ -1719,7 +1721,7 @@ static BlockJob *mirror_start_job(
                              BlockCompletionFunc *cb,
                              void *opaque,
                              const BlockJobDriver *driver,
-                             bool is_none_mode, BlockDriverState *base,
+                             BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name,
                              bool is_mirror, MirrorCopyMode copy_mode,
                              bool base_ro,
@@ -1878,7 +1880,7 @@ static BlockJob *mirror_start_job(
     s->replaces = g_strdup(replaces);
     s->on_source_error = on_source_error;
     s->on_target_error = on_target_error;
-    s->is_none_mode = is_none_mode;
+    s->sync_mode = sync_mode;
     s->backing_mode = backing_mode;
     s->zero_target = zero_target;
     qatomic_set(&s->copy_mode, copy_mode);
@@ -2015,7 +2017,6 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   bool unmap, const char *filter_node_name,
                   MirrorCopyMode copy_mode, Error **errp)
 {
-    bool is_none_mode;
     BlockDriverState *base;

     GLOBAL_STATE_CODE();
@@ -2028,14 +2029,13 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
     }

     bdrv_graph_rdlock_main_loop();
-    is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
     base = mode == MIRROR_SYNC_MODE_TOP ? bdrv_backing_chain_next(bs) : NULL;
     bdrv_graph_rdunlock_main_loop();

     mirror_start_job(job_id, bs, creation_flags, target, replaces,
-                     speed, granularity, buf_size, backing_mode, zero_target,
-                     on_source_error, on_target_error, unmap, NULL, NULL,
-                     &mirror_job_driver, is_none_mode, base, false,
+                     speed, granularity, buf_size, mode, backing_mode,
+                     zero_target, on_source_error, on_target_error, unmap,
+                     NULL, NULL, &mirror_job_driver, base, false,
                      filter_node_name, true, copy_mode, false, errp);
 }

@@ -2061,9 +2061,9 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,

     job = mirror_start_job(
                      job_id, bs, creation_flags, base, NULL, speed, 0, 0,
-                     MIRROR_LEAVE_BACKING_CHAIN, false,
+                     MIRROR_SYNC_MODE_TOP, MIRROR_LEAVE_BACKING_CHAIN, false,
                      on_error, on_error, true, cb, opaque,
-                     &commit_active_job_driver, false, base, auto_complete,
+                     &commit_active_job_driver, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
                      base_read_only, errp);
     if (!job) {
-- 
2.49.0


