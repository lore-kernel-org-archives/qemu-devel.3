Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2BCC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQEo-0003m4-47; Wed, 13 Mar 2024 11:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEa-0003aF-Kp; Wed, 13 Mar 2024 11:09:37 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEY-0005tH-UA; Wed, 13 Mar 2024 11:09:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:8793:0:640:b059:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 3D55C60E5E;
 Wed, 13 Mar 2024 18:09:32 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 99pZB52GZiE0-V6VFz6Zt; Wed, 13 Mar 2024 18:09:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710342571;
 bh=16JngrqjP5XAtrooYiWvEZEPUpXmd7+20izMNFPD9Ag=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=XB1SBurYH07eZZOo/h3uIgUN5sIwBLt7qQQFrAn6mfAMsqaAdki2KbOZDNXtduKQp
 R2n+4bSjIxWJmgXeZNRB1XXCD4rXG3FI/gX37LfrtfpNGoOcKMNEfeqNbtKhIY2h8s
 BwxkMzs8tAN2kDKiGGUjI+wCMuGjgfjMzrSHSR3g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
Subject: [RFC 07/15] qapi: add job-change
Date: Wed, 13 Mar 2024 18:08:59 +0300
Message-Id: <20240313150907.623462-8-vsementsov@yandex-team.ru>
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

Add a new-style command job-change, doing same thing as
block-job-change. The aim is finally deprecate block-job-* APIs and
move to job-* APIs.

We add a new command to qapi/block-core.json, not to
qapi/job.json to avoid resolving json file including loops for now.
This all would be a lot simple to refactor when we finally drop
deprecated block-job-* APIs.

@type argument of the new command immediately becomes deprecated.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 docs/about/deprecated.rst |  4 ++--
 job-qmp.c                 | 14 ++++++++++++++
 qapi/block-core.json      | 10 ++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 64981e5e4a..5ff98ef95f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -143,8 +143,8 @@ all arguments passed to ``device_add`` are consistent with the documented
 property types.
 
 
-``block-job-change`` argument ``type`` (since 9.1)
-''''''''''''''''''''''''''''''''''''''''''''''''''
+``block-job-change`` and ``job-change``  argument ``type`` (since 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 QEMU can get job type from the job itself (by @id), @type field is redundant.
 
diff --git a/job-qmp.c b/job-qmp.c
index abe9b59487..011a8736ea 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -141,6 +141,20 @@ void qmp_job_dismiss(const char *id, Error **errp)
     job_dismiss_locked(&job, errp);
 }
 
+void qmp_job_change(JobChangeOptions *opts, Error **errp)
+{
+    Job *job;
+
+    JOB_LOCK_GUARD();
+    job = find_job_locked(opts->id, errp);
+
+    if (!job) {
+        return;
+    }
+
+    job_change_locked(job, opts, errp);
+}
+
 /* Called with job_mutex held. */
 static JobInfo *job_query_single_locked(Job *job, Error **errp)
 {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3d890dfcd0..f5cefa441b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3105,6 +3105,16 @@
 { 'command': 'block-job-change',
   'data': 'JobChangeOptions', 'boxed': true }
 
+##
+# @job-change:
+#
+# Change the block job's options.
+#
+# Since: 9.1
+##
+{ 'command': 'job-change',
+  'data': 'JobChangeOptions', 'boxed': true }
+
 ##
 # @BlockdevDiscardOptions:
 #
-- 
2.34.1


