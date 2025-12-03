Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF12D12696
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 09:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjHa-0000A1-It; Wed, 03 Dec 2025 04:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjHZ-00009R-7Y; Wed, 03 Dec 2025 04:36:21 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjHX-00073M-IV; Wed, 03 Dec 2025 04:36:20 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B21B1708AD;
 Wed, 03 Dec 2025 12:35:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2450A32B5A4;
 Wed, 03 Dec 2025 12:36:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Zhang Chen <zhangckid@gmail.com>, Peter Xu <peterx@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 78/96] migration: Fix transition to COLO state from
 precopy
Date: Wed,  3 Dec 2025 12:35:11 +0300
Message-ID: <20251203093612.2370716-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Li Zhijian <lizhijian@fujitsu.com>

Commit 4881411136 ("migration: Always set DEVICE state") set a new DEVICE
state before completed during migration, which broke the original transition
to COLO. The migration flow for precopy has changed to:
active -> pre-switchover -> device -> completed.

This patch updates the transition state to ensure that the Pre-COLO
state corresponds to DEVICE state correctly.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: 4881411136 ("migration: Always set DEVICE state")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Tested-by: Zhang Chen <zhangckid@gmail.com>
Link: https://lore.kernel.org/r/20251104013606.1937764-1-lizhijian@fujitsu.com
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 0b5bf4ea76205a93386c5e02fbb519871a62e677)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration.c b/migration/migration.c
index 32b8ce5613..e806481456 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3047,9 +3047,9 @@ static void migration_completion(MigrationState *s)
         goto fail;
     }
 
-    if (migrate_colo() && s->state == MIGRATION_STATUS_ACTIVE) {
+    if (migrate_colo() && s->state == MIGRATION_STATUS_DEVICE) {
         /* COLO does not support postcopy */
-        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+        migrate_set_state(&s->state, MIGRATION_STATUS_DEVICE,
                           MIGRATION_STATUS_COLO);
     } else {
         migration_completion_end(s);
-- 
2.47.3


