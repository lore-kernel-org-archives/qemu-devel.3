Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E20C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQEo-0003nv-DW; Wed, 13 Mar 2024 11:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEg-0003cx-Vu; Wed, 13 Mar 2024 11:09:43 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEf-0005wK-5h; Wed, 13 Mar 2024 11:09:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:8793:0:640:b059:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 8B74B60E6F;
 Wed, 13 Mar 2024 18:09:39 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 99pZB52GZiE0-DuSxYLHO; Wed, 13 Mar 2024 18:09:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710342578;
 bh=uHlV1VxR+xuxKKQhx3yCtAq9mela0KYBVFHBDmPaDZ0=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=f7UwSCrJpI6dcBWdlPH4MBiVJT/daT7Kz2eszmbOrxRKCu16AkYdceGs96XKbLRoW
 ahqYAAET12k9hdkmnbMzgzo99OI0HiGCVFJET46GwCokhA2QCEKiCkIVcnbd6U4t1E
 gQcURW+K6jhRPIJpab2ZyH/HYBED/gGCj1NujlIE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
Subject: [RFC 14/15] qapi: query-job: add block-job specific information
Date: Wed, 13 Mar 2024 18:09:06 +0300
Message-Id: <20240313150907.623462-15-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313150907.623462-1-vsementsov@yandex-team.ru>
References: <20240313150907.623462-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
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

Add io-status and speed, which make sense only for block-jobs. This
allows us to finally deprecate old query-block-jobs API in the next
commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/backup.c           |  6 ++++++
 block/commit.c           |  6 ++++++
 block/mirror.c           |  8 ++++++++
 block/stream.c           |  6 ++++++
 blockjob.c               | 10 ++++++++++
 include/block/blockjob.h |  6 ++++++
 qapi/job.json            | 21 ++++++++++++++++++++-
 7 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/block/backup.c b/block/backup.c
index bf086dc5f9..55bbe85bf6 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -343,6 +343,11 @@ static bool backup_change(Job *job, JobChangeOptions *opts, Error **errp)
     return block_job_change(bjob, &opts->u.backup, errp);
 }
 
+static void backup_query(Job *job, JobInfo *info)
+{
+    block_job_query(job, &info->u.backup);
+}
+
 static const BlockJobDriver backup_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(BackupBlockJob),
@@ -356,6 +361,7 @@ static const BlockJobDriver backup_job_driver = {
         .pause                  = backup_pause,
         .cancel                 = backup_cancel,
         .change                 = backup_change,
+        .query                  = backup_query,
     },
     .set_speed = backup_set_speed,
 };
diff --git a/block/commit.c b/block/commit.c
index ccb6097679..9199a6adc8 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -211,6 +211,11 @@ static bool commit_change(Job *job, JobChangeOptions *opts, Error **errp)
     return block_job_change(bjob, &opts->u.commit, errp);
 }
 
+static void commit_query(Job *job, JobInfo *info)
+{
+    block_job_query(job, &info->u.commit);
+}
+
 static const BlockJobDriver commit_job_driver = {
     .job_driver = {
         .instance_size = sizeof(CommitBlockJob),
@@ -222,6 +227,7 @@ static const BlockJobDriver commit_job_driver = {
         .abort         = commit_abort,
         .clean         = commit_clean,
         .change        = commit_change,
+        .query         = commit_query,
     },
 };
 
diff --git a/block/mirror.c b/block/mirror.c
index 8e672f3309..e8092d56be 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1310,6 +1310,8 @@ static void mirror_query(Job *job, JobInfo *info)
     info->u.mirror = (JobInfoMirror) {
         .actively_synced = qatomic_read(&s->actively_synced),
     };
+
+    block_job_query(job, qapi_JobInfoMirror_base(&info->u.mirror));
 }
 
 static const BlockJobDriver mirror_job_driver = {
@@ -1338,6 +1340,11 @@ static bool commit_active_change(Job *job, JobChangeOptions *opts, Error **errp)
     return block_job_change(bjob, &opts->u.commit, errp);
 }
 
+static void commit_active_query(Job *job, JobInfo *info)
+{
+    block_job_query(job, &info->u.commit);
+}
+
 static const BlockJobDriver commit_active_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(MirrorBlockJob),
@@ -1351,6 +1358,7 @@ static const BlockJobDriver commit_active_job_driver = {
         .complete               = mirror_complete,
         .cancel                 = commit_active_cancel,
         .change                 = commit_active_change,
+        .query                  = commit_active_query,
     },
     .drained_poll           = mirror_drained_poll,
 };
diff --git a/block/stream.c b/block/stream.c
index 34f4588537..e5e4d0bc77 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -246,6 +246,11 @@ static bool stream_change(Job *job, JobChangeOptions *opts, Error **errp)
     return block_job_change(bjob, &opts->u.stream, errp);
 }
 
+static void stream_query(Job *job, JobInfo *info)
+{
+    block_job_query(job, &info->u.stream);
+}
+
 static const BlockJobDriver stream_job_driver = {
     .job_driver = {
         .instance_size = sizeof(StreamBlockJob),
@@ -256,6 +261,7 @@ static const BlockJobDriver stream_job_driver = {
         .clean         = stream_clean,
         .user_resume   = block_job_user_resume,
         .change        = stream_change,
+        .query         = stream_query,
     },
 };
 
diff --git a/blockjob.c b/blockjob.c
index de1dd03b2d..7dd1ed3ff2 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -306,6 +306,16 @@ bool block_job_set_speed_locked(BlockJob *job, int64_t speed, Error **errp)
     return true;
 }
 
+void block_job_query(Job *job, JobInfoBlockJob *info)
+{
+    BlockJob *bjob = container_of(job, BlockJob, job);
+
+    JOB_LOCK_GUARD();
+
+    info->speed = bjob->speed;
+    info->io_status = bjob->iostatus;
+}
+
 static bool block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
 {
     JOB_LOCK_GUARD();
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index fd7ba1a285..bc33c2ba77 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -231,4 +231,10 @@ const BlockJobDriver *block_job_driver(BlockJob *job);
 bool block_job_change(BlockJob *job, JobChangeOptionsBlockJob *opts,
                       Error **errp);
 
+/**
+ * Common part of .query handler for block-jobs.
+ * Adds block-job specific information to @info.
+ */
+void block_job_query(Job *job, JobInfoBlockJob *info);
+
 #endif
diff --git a/qapi/job.json b/qapi/job.json
index 036fec1b57..7bd9f8112c 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -4,6 +4,7 @@
 ##
 # = Background jobs
 ##
+{ 'include': 'common.json' }
 
 ##
 # @JobType:
@@ -251,6 +252,20 @@
 ##
 { 'command': 'job-finalize', 'data': { 'id': 'str' } }
 
+##
+# @JobInfoBlockJob:
+#
+# Information specific to block jobs like mirror and backup.
+#
+# @io-status: the io status of the job
+#
+# @speed: the rate limit, bytes per second
+#
+# Since: 9.1
+##
+{ 'struct': 'JobInfoBlockJob',
+  'data': { 'io-status': 'IoStatus', 'speed': 'uint64' } }
+
 ##
 # @JobInfoMirror:
 #
@@ -263,6 +278,7 @@
 # Since: 9.1
 ##
 { 'struct': 'JobInfoMirror',
+  'base': 'JobInfoBlockJob',
   'data': { 'actively-synced': 'bool' } }
 
 ##
@@ -300,7 +316,10 @@
             'current-progress': 'int', 'total-progress': 'int',
             '*error': 'str' },
   'discriminator': 'type',
-  'data': { 'mirror': 'JobInfoMirror' } }
+  'data': { 'mirror': 'JobInfoMirror',
+            'backup': 'JobInfoBlockJob',
+            'stream': 'JobInfoBlockJob',
+            'commit': 'JobInfoBlockJob' } }
 
 ##
 # @query-jobs:
-- 
2.34.1


