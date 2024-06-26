Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DE6C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQPU-0007Jr-ED; Wed, 26 Jun 2024 07:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMQPQ-0007HS-KA; Wed, 26 Jun 2024 07:01:52 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMQPO-0003T1-2M; Wed, 26 Jun 2024 07:01:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1c20:0:640:f632:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E487360FFA;
 Wed, 26 Jun 2024 14:01:45 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id P1OLrj0IhSw0-sjZJRBfV; Wed, 26 Jun 2024 14:01:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719399705;
 bh=RAdGbjw8jWaNGlxum2xCcLhksdDMguJMiaah0374otc=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=umpyJzcbEkPy0k06DfeK3SQ4+aCFlcYJ7zJkKNuyrs1tGnp+HktZVW6sKrs4zVhQp
 lzWtOICv3PFrsSKcJkhcJDiSWhgCXDPYCvmWYRA+f778wgbeTYjDMy0KUvgz+OHjBb
 hnazO+WvOdFGTswyGd0m+OQSbtw86mYXp4FDv224=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, pkrempa@redhat.com,
 f.ebner@proxmox.com
Subject: [PATCH v2 5/7] qapi: add job-change
Date: Wed, 26 Jun 2024 14:01:22 +0300
Message-Id: <20240626110124.374336-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626110124.374336-1-vsementsov@yandex-team.ru>
References: <20240626110124.374336-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 job-qmp.c            | 14 ++++++++++++++
 qapi/block-core.json | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/job-qmp.c b/job-qmp.c
index c764bd3801..248e68f554 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -139,6 +139,20 @@ void qmp_job_dismiss(const char *id, Error **errp)
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
index 660c7f4a48..9087ce300c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3104,6 +3104,16 @@
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


