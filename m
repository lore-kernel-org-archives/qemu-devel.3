Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C437DC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWO7-0006oj-0t; Mon, 10 Feb 2025 11:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNU-0006XE-N4
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNS-00012w-QV
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mG17zIFEwIBP/X2MDBAVqNtNnNNiu1UyO+iPBwh/g/w=;
 b=bv7zdhJrhqro5AZDnP5sk1O06AzxMS8MlreCdc7pq8WKWiP+FLAH3D2o1oY8L8dzQ3HjBC
 PXWLPV5beMUDWfWz5nTmfVo7OZzKLl21uiG8WQcs7NFFwiA9BBcxaLchMm/GklGCO1uaBa
 YXQAkKS8L1Y8ueg7qyA5Z8+U/YYCBAY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-n3uWW2I5NUKjDfytWUH1JA-1; Mon,
 10 Feb 2025 11:11:14 -0500
X-MC-Unique: n3uWW2I5NUKjDfytWUH1JA-1
X-Mimecast-MFC-AGG-ID: n3uWW2I5NUKjDfytWUH1JA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CB17180087D; Mon, 10 Feb 2025 16:11:13 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 457B3195608D; Mon, 10 Feb 2025 16:11:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 12/25] migration/block-active: Remove global active flag
Date: Mon, 10 Feb 2025 17:10:21 +0100
Message-ID: <20250210161034.76494-13-kwolf@redhat.com>
In-Reply-To: <20250210161034.76494-1-kwolf@redhat.com>
References: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Block devices have an individual active state, a single global flag
can't cover this correctly. This becomes more important as we allow
users to manually manage which nodes are active or inactive.

Now that it's allowed to call bdrv_inactivate_all() even when some
nodes are already inactive, we can remove the flag and just
unconditionally call bdrv_inactivate_all() and, more importantly,
bdrv_activate_all() before we make use of the nodes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20250204211407.381505-5-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 migration/migration.h    |  3 ---
 migration/block-active.c | 46 ----------------------------------------
 migration/migration.c    |  8 -------
 3 files changed, 57 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 4c1fafc2b5..8b24cbedd1 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -554,7 +554,4 @@ void migration_bitmap_sync_precopy(bool last_stage);
 void dirty_bitmap_mig_init(void);
 bool should_send_vmdesc(void);
 
-/* migration/block-active.c */
-void migration_block_active_setup(bool active);
-
 #endif
diff --git a/migration/block-active.c b/migration/block-active.c
index d477cf8182..40e986aade 100644
--- a/migration/block-active.c
+++ b/migration/block-active.c
@@ -12,51 +12,12 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 
-/*
- * Migration-only cache to remember the block layer activation status.
- * Protected by BQL.
- *
- * We need this because..
- *
- * - Migration can fail after block devices are invalidated (during
- *   switchover phase).  When that happens, we need to be able to recover
- *   the block drive status by re-activating them.
- *
- * - Currently bdrv_inactivate_all() is not safe to be invoked on top of
- *   invalidated drives (even if bdrv_activate_all() is actually safe to be
- *   called any time!).  It means remembering this could help migration to
- *   make sure it won't invalidate twice in a row, crashing QEMU.  It can
- *   happen when we migrate a PAUSED VM from host1 to host2, then migrate
- *   again to host3 without starting it.  TODO: a cleaner solution is to
- *   allow safe invoke of bdrv_inactivate_all() at anytime, like
- *   bdrv_activate_all().
- *
- * For freshly started QEMU, the flag is initialized to TRUE reflecting the
- * scenario where QEMU owns block device ownerships.
- *
- * For incoming QEMU taking a migration stream, the flag is initialized to
- * FALSE reflecting that the incoming side doesn't own the block devices,
- * not until switchover happens.
- */
-static bool migration_block_active;
-
-/* Setup the disk activation status */
-void migration_block_active_setup(bool active)
-{
-    migration_block_active = active;
-}
-
 bool migration_block_activate(Error **errp)
 {
     ERRP_GUARD();
 
     assert(bql_locked());
 
-    if (migration_block_active) {
-        trace_migration_block_activation("active-skipped");
-        return true;
-    }
-
     trace_migration_block_activation("active");
 
     bdrv_activate_all(errp);
@@ -65,7 +26,6 @@ bool migration_block_activate(Error **errp)
         return false;
     }
 
-    migration_block_active = true;
     return true;
 }
 
@@ -75,11 +35,6 @@ bool migration_block_inactivate(void)
 
     assert(bql_locked());
 
-    if (!migration_block_active) {
-        trace_migration_block_activation("inactive-skipped");
-        return true;
-    }
-
     trace_migration_block_activation("inactive");
 
     ret = bdrv_inactivate_all();
@@ -89,6 +44,5 @@ bool migration_block_inactivate(void)
         return false;
     }
 
-    migration_block_active = false;
     return true;
 }
diff --git a/migration/migration.c b/migration/migration.c
index 74c50cc72c..95e05bbc3b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1895,12 +1895,6 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
         return;
     }
 
-    /*
-     * Newly setup incoming QEMU.  Mark the block active state to reflect
-     * that the src currently owns the disks.
-     */
-    migration_block_active_setup(false);
-
     once = false;
 }
 
@@ -3992,8 +3986,6 @@ static void migration_instance_init(Object *obj)
     ms->state = MIGRATION_STATUS_NONE;
     ms->mbps = -1;
     ms->pages_per_second = -1;
-    /* Freshly started QEMU owns all the block devices */
-    migration_block_active_setup(true);
     qemu_sem_init(&ms->pause_sem, 0);
     qemu_mutex_init(&ms->error_mutex);
 
-- 
2.48.1


