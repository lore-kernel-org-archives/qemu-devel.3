Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60404C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQEr-0003ts-Ko; Wed, 13 Mar 2024 11:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEd-0003bZ-G8; Wed, 13 Mar 2024 11:09:40 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEV-0005se-O3; Wed, 13 Mar 2024 11:09:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:8793:0:640:b059:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 3016D60E56;
 Wed, 13 Mar 2024 18:09:30 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 99pZB52GZiE0-6Cfukku8; Wed, 13 Mar 2024 18:09:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710342569;
 bh=z/o77ZBizUBxnCNHSRVifBjl5Rg0JJeqoaiwZHtzozY=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=zBH2HsiKUheV56XqzUCYE/3gnZw506OzWaONG4JJhyRKvXSs6x622Ew2KB/kt8Mpe
 fDHa3neIJmlt2ViIfG2l850PNabShldyOWOobOpRurtZSzxqdkKvMHLtJGNn/LRZE+
 kkvJyUaiiydLWleU5vc5TgrjtfxK5R9XZPmZDBAg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
Subject: [RFC 05/15] qapi: JobChangeOptions: make type member optional and
 deprecated
Date: Wed, 13 Mar 2024 18:08:57 +0300
Message-Id: <20240313150907.623462-6-vsementsov@yandex-team.ru>
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

Now QEMU can understand type directly from the job itself, type is
redundant.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 blockjob.c                           |  2 +-
 docs/about/deprecated.rst            |  6 ++++++
 job-qmp.c                            | 17 +++++++++++++++++
 qapi/block-core.json                 | 10 ++++++++--
 stubs/meson.build                    |  1 +
 stubs/qapi-jobchangeoptions-mapper.c |  8 ++++++++
 6 files changed, 41 insertions(+), 3 deletions(-)
 create mode 100644 stubs/qapi-jobchangeoptions-mapper.c

diff --git a/blockjob.c b/blockjob.c
index 788cb1e07d..33c40e7d25 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -319,7 +319,7 @@ void block_job_change_locked(BlockJob *job, JobChangeOptions *opts,
 
     GLOBAL_STATE_CODE();
 
-    if (job_type(&job->job) != opts->type) {
+    if (opts->has_type && job_type(&job->job) != opts->type) {
         error_setg(errp, "Job '%s' is '%s' job, not '%s'", job->job.id,
                    job_type_str(&job->job), JobType_str(opts->type));
         return;
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dfd681cd02..64981e5e4a 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -142,6 +142,12 @@ accepted incorrect commands will return an error. Users should make sure that
 all arguments passed to ``device_add`` are consistent with the documented
 property types.
 
+
+``block-job-change`` argument ``type`` (since 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''
+
+QEMU can get job type from the job itself (by @id), @type field is redundant.
+
 QEMU Machine Protocol (QMP) events
 ----------------------------------
 
diff --git a/job-qmp.c b/job-qmp.c
index 9e26fa899f..c486df9579 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -26,6 +26,8 @@
 #include "qemu/osdep.h"
 #include "qemu/job.h"
 #include "qapi/qapi-commands-job.h"
+#include "qapi/qapi-types-block-core.h"
+#include "qapi/qapi-visit-block-core.h"
 #include "qapi/error.h"
 #include "trace/trace-root.h"
 
@@ -186,3 +188,18 @@ JobInfoList *qmp_query_jobs(Error **errp)
 
     return head;
 }
+
+bool JobChangeOptions_mapper(JobChangeOptions *opts, JobType *out, Error **errp)
+{
+    Job *job;
+
+    JOB_LOCK_GUARD();
+
+    job = find_job_locked(opts->id, errp);
+    if (!job) {
+        return false;
+    }
+
+    *out = job_type(job);
+    return true;
+}
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6041e7bd8f..3d890dfcd0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3082,11 +3082,17 @@
 #
 # @type: The job type
 #
+# Features:
+#
+# @deprecated: Members @type is deprecated. Qemu can get type from
+#     the job itself, @type is redundant.
+#
 # Since: 8.2
 ##
 { 'union': 'JobChangeOptions',
-  'base': { 'id': 'str', 'type': 'JobType' },
-  'discriminator': 'type',
+  'base': { 'id': 'str',
+            '*type': { 'type': 'JobType', 'features': ['deprecated'] } },
+  'discriminator': 'JobType',
   'data': { 'mirror': 'JobChangeOptionsMirror' } }
 
 ##
diff --git a/stubs/meson.build b/stubs/meson.build
index 0bf25e6ca5..e480400a6c 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -31,6 +31,7 @@ stub_ss.add(files('module-opts.c'))
 stub_ss.add(files('monitor.c'))
 stub_ss.add(files('monitor-core.c'))
 stub_ss.add(files('physmem.c'))
+stub_ss.add(files('qapi-jobchangeoptions-mapper.c'))
 stub_ss.add(files('qemu-timer-notify-cb.c'))
 stub_ss.add(files('memory_device.c'))
 stub_ss.add(files('qmp-command-available.c'))
diff --git a/stubs/qapi-jobchangeoptions-mapper.c b/stubs/qapi-jobchangeoptions-mapper.c
new file mode 100644
index 0000000000..e4acfd91b3
--- /dev/null
+++ b/stubs/qapi-jobchangeoptions-mapper.c
@@ -0,0 +1,8 @@
+#include "qemu/osdep.h"
+#include "qapi/qapi-visit-block-core.h"
+#include "qapi/qapi-types-job.h"
+
+bool JobChangeOptions_mapper(JobChangeOptions *opts, JobType *out, Error **errp)
+{
+    g_assert_not_reached();
+}
-- 
2.34.1


