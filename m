Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7ECDC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQEp-0003pC-Gx; Wed, 13 Mar 2024 11:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEa-0003aD-3F; Wed, 13 Mar 2024 11:09:37 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEY-0005t4-1i; Wed, 13 Mar 2024 11:09:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:8793:0:640:b059:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4DE6660E2C;
 Wed, 13 Mar 2024 18:09:31 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 99pZB52GZiE0-CsQfF6Nt; Wed, 13 Mar 2024 18:09:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710342570;
 bh=cEJJa7Y2kfX6gm4lD1BYvT1prEfuPN4uHYFH/69RoYA=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=U6bFoIfb3rFVeI1IkmXS9LfHkDm6syRb2JhVYeZplZkiBZUgYDwLt303xjDOBYFhG
 5GuRNJi6CHoGR3O9FUtXp8aTuD2DckmtLDXYhXo71YDzKc08t5baFSe2jxDok5UY70
 k5Q+1akh2xOfrZi515864g5pimqfiszPdqiFJnv8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
Subject: [RFC 06/15] blockjob: move change action implementation to job from
 block-job
Date: Wed, 13 Mar 2024 18:08:58 +0300
Message-Id: <20240313150907.623462-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313150907.623462-1-vsementsov@yandex-team.ru>
References: <20240313150907.623462-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Like for other block-job-* APIs we want have the actual functionality
in job layer and make block-job-change to be a deprecated duplication
of job-change in the following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/mirror.c               |  7 +++----
 blockdev.c                   |  2 +-
 blockjob.c                   | 26 --------------------------
 include/block/blockjob.h     | 11 -----------
 include/block/blockjob_int.h |  7 -------
 include/qemu/job.h           | 12 ++++++++++++
 job-qmp.c                    |  1 +
 job.c                        | 23 +++++++++++++++++++++++
 8 files changed, 40 insertions(+), 49 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 2d0cd22c06..e670d0dd4f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1251,10 +1251,9 @@ static bool commit_active_cancel(Job *job, bool force)
     return force || !job_is_ready(job);
 }
 
-static void mirror_change(BlockJob *job, JobChangeOptions *opts,
-                          Error **errp)
+static void mirror_change(Job *job, JobChangeOptions *opts, Error **errp)
 {
-    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
+    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
     JobChangeOptionsMirror *change_opts = &opts->u.mirror;
     MirrorCopyMode current;
 
@@ -1310,9 +1309,9 @@ static const BlockJobDriver mirror_job_driver = {
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
         .cancel                 = mirror_cancel,
+        .change                 = mirror_change,
     },
     .drained_poll           = mirror_drained_poll,
-    .change                 = mirror_change,
     .query                  = mirror_query,
 };
 
diff --git a/blockdev.c b/blockdev.c
index 7881f6e5a6..7e13213040 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3256,7 +3256,7 @@ void qmp_block_job_change(JobChangeOptions *opts, Error **errp)
         return;
     }
 
-    block_job_change_locked(job, opts, errp);
+    job_change_locked(&job->job, opts, errp);
 }
 
 void qmp_change_backing_file(const char *device,
diff --git a/blockjob.c b/blockjob.c
index 33c40e7d25..2769722b37 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -312,32 +312,6 @@ static bool block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
     return block_job_set_speed_locked(job, speed, errp);
 }
 
-void block_job_change_locked(BlockJob *job, JobChangeOptions *opts,
-                             Error **errp)
-{
-    const BlockJobDriver *drv = block_job_driver(job);
-
-    GLOBAL_STATE_CODE();
-
-    if (opts->has_type && job_type(&job->job) != opts->type) {
-        error_setg(errp, "Job '%s' is '%s' job, not '%s'", job->job.id,
-                   job_type_str(&job->job), JobType_str(opts->type));
-        return;
-    }
-
-    if (job_apply_verb_locked(&job->job, JOB_VERB_CHANGE, errp)) {
-        return;
-    }
-
-    if (drv->change) {
-        job_unlock();
-        drv->change(job, opts, errp);
-        job_lock();
-    } else {
-        error_setg(errp, "Job type does not support change");
-    }
-}
-
 void block_job_ratelimit_processed_bytes(BlockJob *job, uint64_t n)
 {
     IO_CODE();
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 5dd1b08909..72e849a140 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -173,17 +173,6 @@ bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs);
  */
 bool block_job_set_speed_locked(BlockJob *job, int64_t speed, Error **errp);
 
-/**
- * block_job_change_locked:
- * @job: The job to change.
- * @opts: The new options.
- * @errp: Error object.
- *
- * Change the job according to opts.
- */
-void block_job_change_locked(BlockJob *job, JobChangeOptions *opts,
-                             Error **errp);
-
 /**
  * block_job_query_locked:
  * @job: The job to get information about.
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index d9c3b911d0..58bc7a5cea 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -68,13 +68,6 @@ struct BlockJobDriver {
 
     void (*set_speed)(BlockJob *job, int64_t speed);
 
-    /*
-     * Change the @job's options according to @opts.
-     *
-     * Note that this can already be called before the job coroutine is running.
-     */
-    void (*change)(BlockJob *job, JobChangeOptions *opts, Error **errp);
-
     /*
      * Query information specific to this kind of block job.
      */
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 9ea98b5927..d44cdb0cc8 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -27,6 +27,7 @@
 #define JOB_H
 
 #include "qapi/qapi-types-job.h"
+#include "qapi/qapi-types-block-core.h"
 #include "qemu/queue.h"
 #include "qemu/progress_meter.h"
 #include "qemu/coroutine.h"
@@ -307,6 +308,12 @@ struct JobDriver {
      */
     bool (*cancel)(Job *job, bool force);
 
+    /**
+     * Change the @job's options according to @opts.
+     *
+     * Note that this can already be called before the job coroutine is running.
+     */
+    void (*change)(Job *job, JobChangeOptions *opts, Error **errp);
 
     /**
      * Called when the job is freed.
@@ -705,6 +712,11 @@ void job_finalize_locked(Job *job, Error **errp);
  */
 void job_dismiss_locked(Job **job, Error **errp);
 
+/**
+ * Change the job according to opts.
+ */
+void job_change_locked(Job *job, JobChangeOptions *opts, Error **errp);
+
 /**
  * Synchronously finishes the given @job. If @finish is given, it is called to
  * trigger completion or cancellation of the job.
diff --git a/job-qmp.c b/job-qmp.c
index c486df9579..abe9b59487 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -28,6 +28,7 @@
 #include "qapi/qapi-commands-job.h"
 #include "qapi/qapi-types-block-core.h"
 #include "qapi/qapi-visit-block-core.h"
+#include "qapi/qapi-commands-block-core.h"
 #include "qapi/error.h"
 #include "trace/trace-root.h"
 
diff --git a/job.c b/job.c
index 660ce22c56..69630852dc 100644
--- a/job.c
+++ b/job.c
@@ -1262,3 +1262,26 @@ int job_finish_sync_locked(Job *job,
     job_unref_locked(job);
     return ret;
 }
+
+void job_change_locked(Job *job, JobChangeOptions *opts, Error **errp)
+{
+    GLOBAL_STATE_CODE();
+
+    if (opts->has_type && job_type(job) != opts->type) {
+        error_setg(errp, "Job '%s' is '%s' job, not '%s'", job->id,
+                   job_type_str(job), JobType_str(opts->type));
+        return;
+    }
+
+    if (job_apply_verb_locked(job, JOB_VERB_CHANGE, errp)) {
+        return;
+    }
+
+    if (job->driver->change) {
+        job_unlock();
+        job->driver->change(job, opts, errp);
+        job_lock();
+    } else {
+        error_setg(errp, "Job type does not support change");
+    }
+}
-- 
2.34.1


