Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AED8CF6D28
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw00m-0003hW-G9; Wed, 02 Oct 2024 10:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw00Q-0003Sy-C5; Wed, 02 Oct 2024 10:07:09 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw00G-00058H-9M; Wed, 02 Oct 2024 10:07:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2e8b:0:640:9795:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0BC5560A06;
 Wed,  2 Oct 2024 17:06:51 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id S6cR231IXeA0-5zxLI8J4; Wed, 02 Oct 2024 17:06:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727878010;
 bh=AEIEJcUayiK4Dtv6JDzHo0D8qPCjlxBTkSwFSQDwgAA=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=y9GWCS3DYInhcxJjxhkP1vrI3dVBdv0ORlVQyFGf41c78sbvYIsGBvnZkWTzx225P
 sy6sQgIJBRNWp38nprG+r4clRO85sUdxs6Ri0RKbaBCubdNxt7dmaSUJNYngBaQhAC
 d1fKxxf0Dp7KUFbVcES/e8+7LOff9UXkAONU+hlc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, pkrempa@redhat.com
Subject: [PATCH v3 5/7] qapi: add job-change
Date: Wed,  2 Oct 2024 17:06:14 +0300
Message-Id: <20241002140616.561652-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002140616.561652-1-vsementsov@yandex-team.ru>
References: <20241002140616.561652-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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
index f370593037..e314734b53 100644
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
+# Since: 9.2
+##
+{ 'command': 'job-change',
+  'data': 'JobChangeOptions', 'boxed': true }
+
 ##
 # @BlockdevDiscardOptions:
 #
-- 
2.34.1


