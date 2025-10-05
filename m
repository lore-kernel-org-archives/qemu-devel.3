Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD169CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 16:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Rvp-0001l8-92; Sun, 05 Oct 2025 12:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Rvm-0001hJ-Oq; Sun, 05 Oct 2025 12:49:54 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Rvl-00077x-0z; Sun, 05 Oct 2025 12:49:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E1F3E15AA3E;
 Sun, 05 Oct 2025 19:49:25 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E918E2996F6;
 Sun,  5 Oct 2025 19:49:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 77/81] migration: Fix state transition in
 postcopy_start() error handling
Date: Sun,  5 Oct 2025 19:47:57 +0300
Message-ID: <20251005164822.442861-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

Commit 48814111366b ("migration: Always set DEVICE state") introduced
DEVICE state to postcopy, which moved the actual state transition that
leads to POSTCOPY_ACTIVE.

However, the error handling part of the postcopy_start() function still
expects the state POSTCOPY_ACTIVE, but depending on where an error
happens, now the state can be either ACTIVE, DEVICE or CANCELLING, but
never POSTCOPY_ACTIVE, as this transition now happens just before a
successful return from the function.

Instead, accept any state except CANCELLING when transitioning to FAILED
state.

Cc: qemu-stable@nongnu.org
Fixes: 48814111366b ("migration: Always set DEVICE state")
Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250826115145.871272-1-jmarcin@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 725a9e5f7885a3c0d0cd82022d6eb5a758ac9d47)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25d..32b8ce5613 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2872,8 +2872,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 fail_closefb:
     qemu_fclose(fb);
 fail:
-    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
+    if (ms->state != MIGRATION_STATUS_CANCELLING) {
+        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
+    }
     migration_block_activate(NULL);
     migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
-- 
2.47.3


