Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42112C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQEm-0003jL-MZ; Wed, 13 Mar 2024 11:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEd-0003bd-UD; Wed, 13 Mar 2024 11:09:40 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEc-0005ub-4U; Wed, 13 Mar 2024 11:09:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:8793:0:640:b059:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 5EFE860DBC;
 Wed, 13 Mar 2024 18:09:35 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 99pZB52GZiE0-c2AmYShI; Wed, 13 Mar 2024 18:09:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710342574;
 bh=liHibTBSkdOt/5J9R1x/HYZXfHhL5kuhxB6+ewel9tw=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=DCMqfg7gL7mJlFm7JH+TGuAacMKjTeOo1wRaid8wLbEsxpXU3dAJhRJtIclFkmDb5
 ISUC1+3fyzVB6Jwh3aNj4GSJBgbA1LQDTiY/FUaM96ZAzXoUxbrscLXvhFlEjdXSMt
 oHVtPbkSIrPBYIopB15DPDzSjk/xosUZCxDGjsaA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
Subject: [RFC 10/15] qapi: query-jobs: add information specific for job type
Date: Wed, 13 Mar 2024 18:09:02 +0300
Message-Id: <20240313150907.623462-11-vsementsov@yandex-team.ru>
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

Duplicate the feature from query-block-jobs. It's a step to finally
deprecate query-block-jobs command and move to query-jobs.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/mirror.c     | 14 ++++++++++++--
 include/qemu/job.h |  5 +++++
 job-qmp.c          |  6 ++++++
 qapi/job.json      | 22 +++++++++++++++++++---
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index e95c54fbc6..96dcbbc3e8 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1294,7 +1294,7 @@ static bool mirror_change(Job *job, JobChangeOptions *opts, Error **errp)
     return true;
 }
 
-static void mirror_query(BlockJob *job, BlockJobInfo *info)
+static void mirror_query_old(BlockJob *job, BlockJobInfo *info)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
 
@@ -1303,6 +1303,15 @@ static void mirror_query(BlockJob *job, BlockJobInfo *info)
     };
 }
 
+static void mirror_query(Job *job, JobInfo *info)
+{
+    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
+
+    info->u.mirror = (JobInfoMirror) {
+        .actively_synced = qatomic_read(&s->actively_synced),
+    };
+}
+
 static const BlockJobDriver mirror_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(MirrorBlockJob),
@@ -1316,9 +1325,10 @@ static const BlockJobDriver mirror_job_driver = {
         .complete               = mirror_complete,
         .cancel                 = mirror_cancel,
         .change                 = mirror_change,
+        .query                  = mirror_query,
     },
     .drained_poll           = mirror_drained_poll,
-    .query                  = mirror_query,
+    .query                  = mirror_query_old,
 };
 
 static bool commit_active_change(Job *job, JobChangeOptions *opts, Error **errp)
diff --git a/include/qemu/job.h b/include/qemu/job.h
index eee1d5b50f..8a238b8658 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -315,6 +315,11 @@ struct JobDriver {
      */
     bool (*change)(Job *job, JobChangeOptions *opts, Error **errp);
 
+    /*
+     * Query information specific to this kind of block job.
+     */
+    void (*query)(Job *job, JobInfo *info);
+
     /**
      * Called when the job is freed.
      */
diff --git a/job-qmp.c b/job-qmp.c
index c048e03d9f..9643c5424d 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -177,6 +177,12 @@ static JobInfo *job_query_single_locked(Job *job, Error **errp)
                               g_strdup(error_get_pretty(job->err)) : NULL,
     };
 
+    if (job->driver->query) {
+        job_unlock();
+        job->driver->query(job, info);
+        job_lock();
+    }
+
     return info;
 }
 
diff --git a/qapi/job.json b/qapi/job.json
index 2f1b839cfc..036fec1b57 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -251,6 +251,20 @@
 ##
 { 'command': 'job-finalize', 'data': { 'id': 'str' } }
 
+##
+# @JobInfoMirror:
+#
+# Information specific to mirror block jobs.
+#
+# @actively-synced: Whether the source is actively synced to the
+#     target, i.e. same data and new writes are done synchronously to
+#     both.
+#
+# Since: 9.1
+##
+{ 'struct': 'JobInfoMirror',
+  'data': { 'actively-synced': 'bool' } }
+
 ##
 # @JobInfo:
 #
@@ -281,10 +295,12 @@
 #
 # Since: 3.0
 ##
-{ 'struct': 'JobInfo',
-  'data': { 'id': 'str', 'type': 'JobType', 'status': 'JobStatus',
+{ 'union': 'JobInfo',
+  'base': { 'id': 'str', 'type': 'JobType', 'status': 'JobStatus',
             'current-progress': 'int', 'total-progress': 'int',
-            '*error': 'str' } }
+            '*error': 'str' },
+  'discriminator': 'type',
+  'data': { 'mirror': 'JobInfoMirror' } }
 
 ##
 # @query-jobs:
-- 
2.34.1


