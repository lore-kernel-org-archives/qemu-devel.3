Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB1FCF6D2E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw00l-0003dK-8o; Wed, 02 Oct 2024 10:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw00Q-0003Sz-CR; Wed, 02 Oct 2024 10:07:09 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw00G-000574-8q; Wed, 02 Oct 2024 10:06:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2e8b:0:640:9795:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6FC7160B9C;
 Wed,  2 Oct 2024 17:06:49 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id S6cR231IXeA0-DlNHdJfF; Wed, 02 Oct 2024 17:06:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727878008;
 bh=mdEa2j58UIbdesA3CTO4zNSQT7yI9v8F+lGAJ+trbtM=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=RmXZxyEYY3tFDGkpe+nUYAJ/Va2sS8yZizOyFSF7Jk1jiwoYt02swn3LreTpEQAa1
 BUfZBhqKcPmD3jeDgSMUmRzyO6rRpQ35MVbNqXB1Sct5MMRjYqqyDWfohO3ECAhbYI
 AZ7teN6xL6AB0ly6MJmEV86CLaz6XIG/7xxTyRso=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, pkrempa@redhat.com
Subject: [PATCH v3 3/7] qapi: block-job-change: make copy-mode parameter
 optional
Date: Wed,  2 Oct 2024 17:06:12 +0300
Message-Id: <20241002140616.561652-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002140616.561652-1-vsementsov@yandex-team.ru>
References: <20241002140616.561652-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We are going to add more parameters to change. We want to make possible
to change only one or any subset of available options. So all the
options should be optional.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 block/mirror.c       | 4 ++++
 qapi/block-core.json | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index 2816bb1042..60e8d83e4f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1272,6 +1272,10 @@ static void mirror_change(BlockJob *job, JobChangeOptions *opts,
 
     GLOBAL_STATE_CODE();
 
+    if (!change_opts->has_copy_mode) {
+        return;
+    }
+
     if (qatomic_read(&s->copy_mode) == change_opts->copy_mode) {
         return;
     }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0156762024..f370593037 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3072,11 +3072,12 @@
 #
 # @copy-mode: Switch to this copy mode.  Currently, only the switch
 #     from 'background' to 'write-blocking' is implemented.
+#     If absent, copy mode remains the same.  (optional since 9.2)
 #
 # Since: 8.2
 ##
 { 'struct': 'JobChangeOptionsMirror',
-  'data': { 'copy-mode' : 'MirrorCopyMode' } }
+  'data': { '*copy-mode' : 'MirrorCopyMode' } }
 
 ##
 # @JobChangeOptions:
-- 
2.34.1


