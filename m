Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E492AC48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 08:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchqj-000116-8j; Wed, 21 Feb 2024 03:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchqh-00010W-JT; Wed, 21 Feb 2024 03:21:03 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchqf-00027L-9E; Wed, 21 Feb 2024 03:21:03 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E87C34F3BF;
 Wed, 21 Feb 2024 11:21:19 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B48E28609E;
 Wed, 21 Feb 2024 11:20:58 +0300 (MSK)
Received: (nullmailer pid 2141989 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 01/60] migration: Plug memory leak on HMP migrate error
 path
Date: Wed, 21 Feb 2024 11:19:49 +0300
Message-Id: <20240221082058.2141850-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Markus Armbruster <armbru@redhat.com>

hmp_migrate() leaks @caps when qmp_migrate() fails.  Plug the leak
with g_autoptr().

Fixes: 967f2de5c9ec (migration: Implement MigrateChannelList to hmp migration flow.) v8.2.0-rc0
Fixes: CID 1533125
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20240117140722.3979657-1-armbru@redhat.com
[peterx: fix CID number as reported by Peter Maydell]
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 918f620d30a9b0095b7824b8d77a2d6059a439d9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 86ae832176..2faa5cad46 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -762,7 +762,7 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
-    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannelList) caps = NULL;
     g_autoptr(MigrationChannel) channel = NULL;
 
     if (inc) {
@@ -787,8 +787,6 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    qapi_free_MigrationChannelList(caps);
-
     if (!detach) {
         HMPMigrationStatus *status;
 
-- 
2.39.2


