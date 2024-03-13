Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49464C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQEo-0003m5-4z; Wed, 13 Mar 2024 11:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEc-0003bE-97; Wed, 13 Mar 2024 11:09:38 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEa-0005u8-3B; Wed, 13 Mar 2024 11:09:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:8793:0:640:b059:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6FE6160E62;
 Wed, 13 Mar 2024 18:09:34 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 99pZB52GZiE0-vwBb8tYZ; Wed, 13 Mar 2024 18:09:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710342573;
 bh=WCIpyT0J+TRD9V0WFqJbUQtYMgyzqP59utLlBS1GDpE=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=IBPSb9vUM5Tw8Qsb8Nk4ziMv1+o0O8c8nNqOoY5CGidQ4jph1lO62/aV5YbZ0Bpw8
 3xRJ7kRtBEEVYcWk0oiY15YsYLw1VSwBGuQC4errBhzfp4DidT8kscSo7BxDlW8Cy+
 ZHOGJEaXZgBakNpiESdfiC8uuOdirhTvr6OgPkeM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
Subject: [RFC 09/15] qapi: job-complete: introduce no-block-replace option for
 mirror
Date: Wed, 13 Mar 2024 18:09:01 +0300
Message-Id: <20240313150907.623462-10-vsementsov@yandex-team.ru>
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

That's an alternative to block-job-cancel(hard=false) behavior for
mirror, which exactly is: complete the job, wait for in-flight
requests, but don't do any block graph modifications.

Why:

1. We move to deprecating block-job-* APIs and use job-* APIs instead.
   So we need to port somehow the functionality to job- API.

2. The specified behavior was also a kind of "quirk". It's strange to
   "cancel" something in a normal success path of user scenario. This
   block-job-cancel(hard=false) results in BLOCK_JOB_COMPLETE event, so
   definitely it's just another mode of "complete", not "cancel".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/mirror.c                       |  8 +++++---
 include/qemu/job.h                   |  8 +++++++-
 job-qmp.c                            | 20 +++++++++++++++-----
 job.c                                | 12 ++++++++++--
 qapi/job.json                        | 28 +++++++++++++++++++++++++---
 stubs/qapi-jobchangeoptions-mapper.c |  5 +++++
 tests/unit/test-bdrv-drain.c         |  2 +-
 tests/unit/test-block-iothread.c     |  2 +-
 tests/unit/test-blockjob.c           |  2 +-
 9 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index f474b87079..e95c54fbc6 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -69,6 +69,7 @@ typedef struct MirrorBlockJob {
      */
     bool actively_synced;
     bool should_complete;
+    bool no_block_replace;
     int64_t granularity;
     size_t buf_size;
     int64_t bdev_length;
@@ -740,7 +741,7 @@ static int mirror_exit_common(Job *job)
     }
     bdrv_graph_rdunlock_main_loop();
 
-    if (s->should_complete && !abort) {
+    if (s->should_complete && !abort && !s->no_block_replace) {
         BlockDriverState *to_replace = s->to_replace ?: src;
         bool ro = bdrv_is_read_only(to_replace);
 
@@ -1167,7 +1168,7 @@ immediate_exit:
     return ret;
 }
 
-static void mirror_complete(Job *job, Error **errp)
+static void mirror_complete(Job *job, JobComplete *opts, Error **errp)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
 
@@ -1178,7 +1179,7 @@ static void mirror_complete(Job *job, Error **errp)
     }
 
     /* block all operations on to_replace bs */
-    if (s->replaces) {
+    if (s->replaces && !opts->u.mirror.no_block_replace) {
         s->to_replace = bdrv_find_node(s->replaces);
         if (!s->to_replace) {
             error_setg(errp, "Node name '%s' not found", s->replaces);
@@ -1193,6 +1194,7 @@ static void mirror_complete(Job *job, Error **errp)
     }
 
     s->should_complete = true;
+    s->no_block_replace = opts->u.mirror.no_block_replace;
 
     /* If the job is paused, it will be re-entered when it is resumed */
     WITH_JOB_LOCK_GUARD() {
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 1c9da74a0c..eee1d5b50f 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -254,7 +254,7 @@ struct JobDriver {
      * Optional callback for job types whose completion must be triggered
      * manually.
      */
-    void (*complete)(Job *job, Error **errp);
+    void (*complete)(Job *job, JobComplete *opts, Error **errp);
 
     /**
      * If the callback is not NULL, prepare will be invoked when all the jobs
@@ -634,6 +634,12 @@ void job_early_fail(Job *job);
  */
 void job_transition_to_ready(Job *job);
 
+/**
+ * Asynchronously complete the specified @job.
+ * Called with job lock held, but might release it temporarily.
+ */
+void job_complete_opts_locked(Job *job, JobComplete *opts, Error **errp);
+
 /**
  * Asynchronously complete the specified @job.
  * Called with job lock held, but might release it temporarily.
diff --git a/job-qmp.c b/job-qmp.c
index 011a8736ea..c048e03d9f 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -93,19 +93,19 @@ void qmp_job_resume(const char *id, Error **errp)
     job_user_resume_locked(job, errp);
 }
 
-void qmp_job_complete(const char *id, Error **errp)
+void qmp_job_complete(JobComplete *opts, Error **errp)
 {
     Job *job;
 
     JOB_LOCK_GUARD();
-    job = find_job_locked(id, errp);
+    job = find_job_locked(opts->id, errp);
 
     if (!job) {
         return;
     }
 
     trace_qmp_job_complete(job);
-    job_complete_locked(job, errp);
+    job_complete_opts_locked(job, opts, errp);
 }
 
 void qmp_job_finalize(const char *id, Error **errp)
@@ -204,13 +204,13 @@ JobInfoList *qmp_query_jobs(Error **errp)
     return head;
 }
 
-bool JobChangeOptions_mapper(JobChangeOptions *opts, JobType *out, Error **errp)
+static bool job_mapper(const char *id, JobType *out, Error **errp)
 {
     Job *job;
 
     JOB_LOCK_GUARD();
 
-    job = find_job_locked(opts->id, errp);
+    job = find_job_locked(id, errp);
     if (!job) {
         return false;
     }
@@ -218,3 +218,13 @@ bool JobChangeOptions_mapper(JobChangeOptions *opts, JobType *out, Error **errp)
     *out = job_type(job);
     return true;
 }
+
+bool JobChangeOptions_mapper(JobChangeOptions *opts, JobType *out, Error **errp)
+{
+    return job_mapper(opts->id, out, errp);
+}
+
+bool JobComplete_mapper(JobComplete *opts, JobType *out, Error **errp)
+{
+    return job_mapper(opts->id, out, errp);
+}
diff --git a/job.c b/job.c
index 69630852dc..3726ba2c9e 100644
--- a/job.c
+++ b/job.c
@@ -1214,11 +1214,14 @@ int job_complete_sync_locked(Job *job, Error **errp)
     return job_finish_sync_locked(job, job_complete_locked, errp);
 }
 
-void job_complete_locked(Job *job, Error **errp)
+void job_complete_opts_locked(Job *job, JobComplete *opts, Error **errp)
 {
+    JobComplete local_opts = {};
+
     /* Should not be reachable via external interface for internal jobs */
     assert(job->id);
     GLOBAL_STATE_CODE();
+
     if (job_apply_verb_locked(job, JOB_VERB_COMPLETE, errp)) {
         return;
     }
@@ -1229,10 +1232,15 @@ void job_complete_locked(Job *job, Error **errp)
     }
 
     job_unlock();
-    job->driver->complete(job, errp);
+    job->driver->complete(job, opts ?: &local_opts, errp);
     job_lock();
 }
 
+void job_complete_locked(Job *job, Error **errp)
+{
+    job_complete_opts_locked(job, NULL, errp);
+}
+
 int job_finish_sync_locked(Job *job,
                            void (*finish)(Job *, Error **errp),
                            Error **errp)
diff --git a/qapi/job.json b/qapi/job.json
index b3957207a4..2f1b839cfc 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -182,15 +182,37 @@
 { 'command': 'job-cancel', 'data': { 'id': 'str' } }
 
 ##
-# @job-complete:
+# @JobCompleteMirror:
 #
-# Manually trigger completion of an active job in the READY state.
+# @no-block-replace: Supported only for mirror job. If true, alter
+#     the mirror job completion behavior so that final switch to
+#     target block node is not done. Since 9.1
+#
+# Since: 9.1
+##
+{ 'struct': 'JobCompleteMirror',
+  'data': { '*no-block-replace': 'bool' } }
+
+##
+# @JobComplete:
 #
 # @id: The job identifier.
 #
 # Since: 3.0
 ##
-{ 'command': 'job-complete', 'data': { 'id': 'str' } }
+{ 'union': 'JobComplete',
+  'base': { 'id': 'str' },
+  'discriminator': 'JobType',
+  'data': { 'mirror': 'JobCompleteMirror' } }
+
+##
+# @job-complete:
+#
+# Manually trigger completion of an active job in the READY state.
+#
+# Since: 3.0
+##
+{ 'command': 'job-complete', 'data': 'JobComplete', 'boxed': true }
 
 ##
 # @job-dismiss:
diff --git a/stubs/qapi-jobchangeoptions-mapper.c b/stubs/qapi-jobchangeoptions-mapper.c
index e4acfd91b3..8031a5317c 100644
--- a/stubs/qapi-jobchangeoptions-mapper.c
+++ b/stubs/qapi-jobchangeoptions-mapper.c
@@ -6,3 +6,8 @@ bool JobChangeOptions_mapper(JobChangeOptions *opts, JobType *out, Error **errp)
 {
     g_assert_not_reached();
 }
+
+bool JobComplete_mapper(JobComplete *opts, JobType *out, Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 666880472b..933d3dd990 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -682,7 +682,7 @@ static int coroutine_fn test_job_run(Job *job, Error **errp)
     return s->run_ret;
 }
 
-static void test_job_complete(Job *job, Error **errp)
+static void test_job_complete(Job *job, JobComplete *opts, Error **errp)
 {
     TestBlockJob *s = container_of(job, TestBlockJob, common.job);
     s->should_complete = true;
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 3766d5de6b..dce33a8b9b 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -529,7 +529,7 @@ static int coroutine_fn test_job_run(Job *job, Error **errp)
     return 0;
 }
 
-static void test_job_complete(Job *job, Error **errp)
+static void test_job_complete(Job *job, JobComplete *opts, Error **errp)
 {
     TestBlockJob *s = container_of(job, TestBlockJob, common.job);
     s->should_complete = true;
diff --git a/tests/unit/test-blockjob.c b/tests/unit/test-blockjob.c
index fe3e0d2d38..027a2dd886 100644
--- a/tests/unit/test-blockjob.c
+++ b/tests/unit/test-blockjob.c
@@ -165,7 +165,7 @@ typedef struct CancelJob {
     bool should_complete;
 } CancelJob;
 
-static void cancel_job_complete(Job *job, Error **errp)
+static void cancel_job_complete(Job *job, JobComplete *opts, Error **errp)
 {
     CancelJob *s = container_of(job, CancelJob, common.job);
     s->should_complete = true;
-- 
2.34.1


