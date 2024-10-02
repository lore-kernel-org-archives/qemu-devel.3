Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82632CF6D28
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw00p-0003ms-Tz; Wed, 02 Oct 2024 10:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw00Q-0003T6-GH; Wed, 02 Oct 2024 10:07:09 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw00G-000573-8t; Wed, 02 Oct 2024 10:06:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2e8b:0:640:9795:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B971F60A08;
 Wed,  2 Oct 2024 17:06:48 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id S6cR231IXeA0-Cn6zHsDZ; Wed, 02 Oct 2024 17:06:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727878008;
 bh=yLJaDyEAelrXRgY1Ri4RSUibfQW2G7z/Oefqj6dQnvE=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=W+y8xb/7CcVraTiM1V+fhW6+2SRXra+taN7PjOznOOpnbH6K6y8LBuRaOFF3DW8xz
 4p/O0PpE1pDamEPbfQmt0DzgUA461zaLcU514SBQldrUskxmtyKiSUCEGYEQ79W22F
 Y/q53Gwm1vk7kks0j/o6GxjgixnkdEwv+SpJnVpA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, pkrempa@redhat.com
Subject: [PATCH v3 2/7] blockjob: block_job_change_locked(): check job type
Date: Wed,  2 Oct 2024 17:06:11 +0300
Message-Id: <20241002140616.561652-3-vsementsov@yandex-team.ru>
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

User may specify wrong type for the job id. Let's check it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 blockjob.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/blockjob.c b/blockjob.c
index 8cfbb15543..788cb1e07d 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -319,6 +319,12 @@ void block_job_change_locked(BlockJob *job, JobChangeOptions *opts,
 
     GLOBAL_STATE_CODE();
 
+    if (job_type(&job->job) != opts->type) {
+        error_setg(errp, "Job '%s' is '%s' job, not '%s'", job->job.id,
+                   job_type_str(&job->job), JobType_str(opts->type));
+        return;
+    }
+
     if (job_apply_verb_locked(&job->job, JOB_VERB_CHANGE, errp)) {
         return;
     }
-- 
2.34.1


