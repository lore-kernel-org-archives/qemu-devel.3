Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CA7C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQEs-0003uo-7W; Wed, 13 Mar 2024 11:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEb-0003bC-Jy; Wed, 13 Mar 2024 11:09:39 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEZ-0005td-G5; Wed, 13 Mar 2024 11:09:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:8793:0:640:b059:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 5E81960DBA;
 Wed, 13 Mar 2024 18:09:33 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 99pZB52GZiE0-Jw55lBFV; Wed, 13 Mar 2024 18:09:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710342572;
 bh=oAmIBIVRoPB9IV/Df1MWhYDzUX/APDm0FauUKs5ntZ8=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=F7Dsbg1ACHRopfkwf282Lw4tAvMlupvlIwO62Q46ggJKqyTl68bHUNbbMXTHEVX8T
 VU43j/4RUOjl1f4dOEGDeVFECMbimayUX/9Y77RMRquMqfFCh5/SjPv3Nllvu2Bv9x
 CITx2MkucSZz09IdybfZQFJceDep1qf1y5sRved8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
Subject: [RFC 08/15] qapi: job-change: support speed parameter
Date: Wed, 13 Mar 2024 18:09:00 +0300
Message-Id: <20240313150907.623462-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313150907.623462-1-vsementsov@yandex-team.ru>
References: <20240313150907.623462-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

Allow change job speed through job-change command. Old
block-job-set-speed would be deprecated soon.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/backup.c           |  8 ++++++
 block/commit.c           | 10 ++++++-
 block/mirror.c           | 60 ++++++++++++++++++++++++----------------
 block/stream.c           |  8 ++++++
 blockjob.c               | 13 +++++++++
 include/block/blockjob.h |  7 +++++
 include/qemu/job.h       |  2 +-
 qapi/block-core.json     | 23 +++++++++++++--
 8 files changed, 103 insertions(+), 28 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index ec29d6b810..bf086dc5f9 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -336,6 +336,13 @@ static bool backup_cancel(Job *job, bool force)
     return true;
 }
 
+static bool backup_change(Job *job, JobChangeOptions *opts, Error **errp)
+{
+    BlockJob *bjob = container_of(job, BlockJob, job);
+
+    return block_job_change(bjob, &opts->u.backup, errp);
+}
+
 static const BlockJobDriver backup_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(BackupBlockJob),
@@ -348,6 +355,7 @@ static const BlockJobDriver backup_job_driver = {
         .clean                  = backup_clean,
         .pause                  = backup_pause,
         .cancel                 = backup_cancel,
+        .change                 = backup_change,
     },
     .set_speed = backup_set_speed,
 };
diff --git a/block/commit.c b/block/commit.c
index 7c3fdcb0ca..ccb6097679 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -204,6 +204,13 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
     return 0;
 }
 
+static bool commit_change(Job *job, JobChangeOptions *opts, Error **errp)
+{
+    BlockJob *bjob = container_of(job, BlockJob, job);
+
+    return block_job_change(bjob, &opts->u.commit, errp);
+}
+
 static const BlockJobDriver commit_job_driver = {
     .job_driver = {
         .instance_size = sizeof(CommitBlockJob),
@@ -213,7 +220,8 @@ static const BlockJobDriver commit_job_driver = {
         .run           = commit_run,
         .prepare       = commit_prepare,
         .abort         = commit_abort,
-        .clean         = commit_clean
+        .clean         = commit_clean,
+        .change        = commit_change,
     },
 };
 
diff --git a/block/mirror.c b/block/mirror.c
index e670d0dd4f..f474b87079 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1251,41 +1251,45 @@ static bool commit_active_cancel(Job *job, bool force)
     return force || !job_is_ready(job);
 }
 
-static void mirror_change(Job *job, JobChangeOptions *opts, Error **errp)
+static bool mirror_change(Job *job, JobChangeOptions *opts, Error **errp)
 {
+    BlockJob *bjob = container_of(job, BlockJob, job);
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
     JobChangeOptionsMirror *change_opts = &opts->u.mirror;
-    MirrorCopyMode current;
-
-    /*
-     * The implementation relies on the fact that copy_mode is only written
-     * under the BQL. Otherwise, further synchronization would be required.
-     */
+    MirrorCopyMode old_mode;
 
     GLOBAL_STATE_CODE();
 
-    if (!change_opts->has_copy_mode) {
-        /* Nothing to do */
-        return;
-    }
+    if (change_opts->has_copy_mode) {
+        old_mode = qatomic_read(&s->copy_mode);
 
-    if (qatomic_read(&s->copy_mode) == change_opts->copy_mode) {
-        return;
-    }
+        if (old_mode != change_opts->copy_mode) {
+            if (change_opts->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING) {
+                error_setg(errp, "Change to copy mode '%s' is not implemented",
+                           MirrorCopyMode_str(change_opts->copy_mode));
+                return false;
+            }
 
-    if (change_opts->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING) {
-        error_setg(errp, "Change to copy mode '%s' is not implemented",
-                   MirrorCopyMode_str(change_opts->copy_mode));
-        return;
+            if (old_mode != MIRROR_COPY_MODE_BACKGROUND) {
+                error_setg(errp, "Expected current copy mode '%s', got '%s'",
+                           MirrorCopyMode_str(MIRROR_COPY_MODE_BACKGROUND),
+                           MirrorCopyMode_str(old_mode));
+                return false;
+            }
+        }
     }
 
-    current = qatomic_cmpxchg(&s->copy_mode, MIRROR_COPY_MODE_BACKGROUND,
-                              change_opts->copy_mode);
-    if (current != MIRROR_COPY_MODE_BACKGROUND) {
-        error_setg(errp, "Expected current copy mode '%s', got '%s'",
-                   MirrorCopyMode_str(MIRROR_COPY_MODE_BACKGROUND),
-                   MirrorCopyMode_str(current));
+    if (!block_job_change(bjob, qapi_JobChangeOptionsMirror_base(change_opts),
+                          errp))
+    {
+        return false;
     }
+
+    old_mode = qatomic_cmpxchg(&s->copy_mode, MIRROR_COPY_MODE_BACKGROUND,
+                               change_opts->copy_mode);
+    assert(old_mode == MIRROR_COPY_MODE_BACKGROUND);
+
+    return true;
 }
 
 static void mirror_query(BlockJob *job, BlockJobInfo *info)
@@ -1315,6 +1319,13 @@ static const BlockJobDriver mirror_job_driver = {
     .query                  = mirror_query,
 };
 
+static bool commit_active_change(Job *job, JobChangeOptions *opts, Error **errp)
+{
+    BlockJob *bjob = container_of(job, BlockJob, job);
+
+    return block_job_change(bjob, &opts->u.commit, errp);
+}
+
 static const BlockJobDriver commit_active_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(MirrorBlockJob),
@@ -1327,6 +1338,7 @@ static const BlockJobDriver commit_active_job_driver = {
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
         .cancel                 = commit_active_cancel,
+        .change                 = commit_active_change,
     },
     .drained_poll           = mirror_drained_poll,
 };
diff --git a/block/stream.c b/block/stream.c
index 7031eef12b..34f4588537 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -239,6 +239,13 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     return error;
 }
 
+static bool stream_change(Job *job, JobChangeOptions *opts, Error **errp)
+{
+    BlockJob *bjob = container_of(job, BlockJob, job);
+
+    return block_job_change(bjob, &opts->u.stream, errp);
+}
+
 static const BlockJobDriver stream_job_driver = {
     .job_driver = {
         .instance_size = sizeof(StreamBlockJob),
@@ -248,6 +255,7 @@ static const BlockJobDriver stream_job_driver = {
         .prepare       = stream_prepare,
         .clean         = stream_clean,
         .user_resume   = block_job_user_resume,
+        .change        = stream_change,
     },
 };
 
diff --git a/blockjob.c b/blockjob.c
index 2769722b37..d3cd4f4fbf 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -312,6 +312,19 @@ static bool block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
     return block_job_set_speed_locked(job, speed, errp);
 }
 
+bool block_job_change(BlockJob *job, JobChangeOptionsBlockJob *opts,
+                      Error **errp)
+{
+    GLOBAL_STATE_CODE();
+
+    if (!opts->has_speed) {
+        /* Nothing to do */
+        return true;
+    }
+
+    return block_job_set_speed(job, opts->speed, errp);
+}
+
 void block_job_ratelimit_processed_bytes(BlockJob *job, uint64_t n)
 {
     IO_CODE();
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 72e849a140..fe433c8d35 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -224,4 +224,11 @@ bool block_job_is_internal(BlockJob *job);
  */
 const BlockJobDriver *block_job_driver(BlockJob *job);
 
+/**
+ * Common part of .change handler for block-jobs.
+ * Applies changes described in opts to the job.
+ */
+bool block_job_change(BlockJob *job, JobChangeOptionsBlockJob *opts,
+                      Error **errp);
+
 #endif
diff --git a/include/qemu/job.h b/include/qemu/job.h
index d44cdb0cc8..1c9da74a0c 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -313,7 +313,7 @@ struct JobDriver {
      *
      * Note that this can already be called before the job coroutine is running.
      */
-    void (*change)(Job *job, JobChangeOptions *opts, Error **errp);
+    bool (*change)(Job *job, JobChangeOptions *opts, Error **errp);
 
     /**
      * Called when the job is freed.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index f5cefa441b..93f96e747e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3062,6 +3062,17 @@
 { 'command': 'block-job-finalize', 'data': { 'id': 'str' },
   'allow-preconfig': true }
 
+##
+# @JobChangeOptionsBlockJob:
+#
+# @speed: Change job speed (in bytes per second).  Supported for
+#     for backup, mirror, commit and stream jobs.
+#
+# Since: 9.1
+##
+{ 'struct': 'JobChangeOptionsBlockJob',
+  'data': { '*speed' : 'uint64' } }
+
 ##
 # @JobChangeOptionsMirror:
 #
@@ -3071,12 +3082,17 @@
 # Since: 8.2
 ##
 { 'struct': 'JobChangeOptionsMirror',
+  'base': 'JobChangeOptionsBlockJob',
   'data': { '*copy-mode' : 'MirrorCopyMode' } }
 
+
 ##
 # @JobChangeOptions:
 #
-# Block job options that can be changed after job creation.
+# Job options that can be changed after job creation. When option is
+# not specified the corresponding job parameter remains unchanged.
+# The change is transactional: on success all changes are applied
+# successfully, on failure nothing is changed.
 #
 # @id: The job identifier
 #
@@ -3093,7 +3109,10 @@
   'base': { 'id': 'str',
             '*type': { 'type': 'JobType', 'features': ['deprecated'] } },
   'discriminator': 'JobType',
-  'data': { 'mirror': 'JobChangeOptionsMirror' } }
+  'data': { 'mirror': 'JobChangeOptionsMirror',
+            'backup': 'JobChangeOptionsBlockJob',
+            'stream': 'JobChangeOptionsBlockJob',
+            'commit': 'JobChangeOptionsBlockJob' } }
 
 ##
 # @block-job-change:
-- 
2.34.1


