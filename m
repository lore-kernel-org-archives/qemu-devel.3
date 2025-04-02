Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE896C36014
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 08:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tztbg-0007mB-Iu; Wed, 02 Apr 2025 04:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tztbd-0007lJ-4i; Wed, 02 Apr 2025 04:37:53 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tztba-00040S-7A; Wed, 02 Apr 2025 04:37:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:4c7:0:640:d178:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9EDB260D0B;
 Wed,  2 Apr 2025 11:37:43 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:1217::1:23])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GbS62e0FfSw0-oHQ83bpd; Wed, 02 Apr 2025 11:37:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1743583062;
 bh=36RVsYFyKLJiicOkswSaefCUCT8yqe5Nqads0M2um8s=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=r6tZ4qZi6f0sF15GdDhZoE0j87q+tv+vthmQpe5bVHURSHfdIyTjLs6a46SX/8z1T
 93PFdfb9fdiJM5bdZ2j1pMjoHgSjU33EZEcOxUaGQabu1bqpDaivgidrwLQc/z9nIq
 IrfzDigWpAxKu36XPYB3VdvOlDocr7f/hDAL7tmA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, den@openvz.org
Subject: [PATCH v3] [for-10.1] block-jobs: add final flush
Date: Wed,  2 Apr 2025 11:37:15 +0300
Message-ID: <20250402083715.391059-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Actually block job is not completed without the final flush. It's
rather unexpected to have broken target when job was successfully
completed long ago and now we fail to flush or process just
crashed/killed.

Mirror job already has mirror_flush() for this. So, it's OK.

Do this for stream, commit and backup jobs too.

Note that jobs behave a bit different around IGNORE action:
backup and commit just retry the operation, when stream skip
failed operation and store the error to report later. Keep
these different behaviors for final flush too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

v2 was old "[PATCH v2 0/3] block-jobs: add final flush"[1]
v3: follow Kevin's suggestion to introduce block_job_handle_error()
   (still, it's not obvious how to rewrite commit and stream operation
   loops reusing this helper, not making things more complicated..
   I decided too keep them as is, using new helper only for final flush.)

[1] https://patchew.org/QEMU/20240626145038.458709-1-vsementsov@yandex-team.ru/
Supersedes: <20240626145038.458709-1-vsementsov@yandex-team.ru>

 block/backup.c           |  8 ++++++++
 block/commit.c           |  6 +++++-
 block/stream.c           |  8 ++++++--
 blockjob.c               | 34 ++++++++++++++++++++++++++++++++++
 include/block/blockjob.h |  9 +++++++++
 5 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 79652bf57b..13fcdaa320 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -221,6 +221,14 @@ static int coroutine_fn backup_loop(BackupBlockJob *job)
     }
 
 out:
+    if (ret == 0) {
+        do {
+            WITH_GRAPH_RDLOCK_GUARD() {
+                ret = bdrv_co_flush(job->target_bs);
+            }
+        } while (block_job_handle_error(&job->common, ret, job->on_target_error,
+                                        true, true));
+    }
     block_copy_call_free(s);
     job->bg_bcs_call = NULL;
     return ret;
diff --git a/block/commit.c b/block/commit.c
index 5df3d05346..711093504f 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -201,7 +201,11 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
         }
     }
 
-    return 0;
+    do {
+        ret = blk_co_flush(s->base);
+    } while (block_job_handle_error(&s->common, ret, s->on_error, true, true));
+
+    return ret;
 }
 
 static const BlockJobDriver commit_job_driver = {
diff --git a/block/stream.c b/block/stream.c
index 999d9e56d4..3d374094f5 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -160,6 +160,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     int64_t offset = 0;
     int error = 0;
     int64_t n = 0; /* bytes */
+    int ret = -1;
 
     WITH_GRAPH_RDLOCK_GUARD() {
         unfiltered_bs = bdrv_skip_filters(s->target_bs);
@@ -177,7 +178,6 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
 
     for ( ; offset < len; offset += n) {
         bool copy;
-        int ret = -1;
 
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
@@ -235,8 +235,12 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         }
     }
 
+    do {
+        ret = blk_co_flush(s->blk);
+    } while (block_job_handle_error(&s->common, ret, s->on_error, true, false));
+
     /* Do not remove the backing file if an error was there but ignored. */
-    return error;
+    return error ?: ret;
 }
 
 static const BlockJobDriver stream_job_driver = {
diff --git a/blockjob.c b/blockjob.c
index 32007f31a9..70a7af2077 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -626,3 +626,37 @@ AioContext *block_job_get_aio_context(BlockJob *job)
     GLOBAL_STATE_CODE();
     return job->job.aio_context;
 }
+
+bool coroutine_fn
+block_job_handle_error(BlockJob *job, int ret, BlockdevOnError on_err,
+                       bool is_read, bool retry_on_ignore)
+{
+    assert(ret >= 0);
+
+    if (ret == 0) {
+        return false;
+    }
+
+    if (job_is_cancelled(&job->job)) {
+        return false;
+    }
+
+    BlockErrorAction action =
+        block_job_error_action(job, on_err, is_read, -ret);
+    switch (action) {
+    case BLOCK_ERROR_ACTION_REPORT:
+        return false;
+    case BLOCK_ERROR_ACTION_IGNORE:
+        if (!retry_on_ignore) {
+            return false;
+        }
+        /* fallthrough */
+    case BLOCK_ERROR_ACTION_STOP:
+        job_pause_point(&job->job);
+        break;
+    default:
+        abort();
+    }
+
+    return true;
+}
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 7061ab7201..8362143ed7 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -235,4 +235,13 @@ bool block_job_is_internal(BlockJob *job);
  */
 const BlockJobDriver *block_job_driver(BlockJob *job);
 
+/**
+ * block_job_handle_error:
+ *
+ * Return, wherter the operation should be retried.
+ */
+bool coroutine_fn
+block_job_handle_error(BlockJob *job, int ret, BlockdevOnError on_err,
+                       bool is_read, bool retry_on_ignore);
+
 #endif
-- 
2.48.1


