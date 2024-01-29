Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84787C47258
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 03:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHxB-0004U1-HT; Sun, 28 Jan 2024 22:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHxA-0004PH-2N
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHx8-0002dv-C1
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706497493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nwPQaFncawh6LoHnuw9aCaruCaalCFdEX19mUZAGe+Q=;
 b=e4mr1Jwb0MbVND5L7PgMBDc2PU+A5k1w+wxQTiYvaO28YlZQWr+b3S1vhBczUzDdqbxt+N
 9idB6S5g/Qd2bUCmO+zgtgzUa1qCRKPl0vatz4mCJ0WuqIPEs6nNHHjA/nDsQQFWTOZkQk
 r2eu/zmlHDJZtHln0b4TMaTmj5OdpQM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-Z72gn10jMwKitbCHqErP8Q-1; Sun,
 28 Jan 2024 22:04:51 -0500
X-MC-Unique: Z72gn10jMwKitbCHqErP8Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E4131C05AD3;
 Mon, 29 Jan 2024 03:04:51 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE3F81121306;
 Mon, 29 Jan 2024 03:04:48 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	peterx@redhat.com
Subject: [PULL 12/14] migration: Add a wrapper to qemu_bh_schedule
Date: Mon, 29 Jan 2024 11:04:03 +0800
Message-ID: <20240129030405.177100-13-peterx@redhat.com>
In-Reply-To: <20240129030405.177100-1-peterx@redhat.com>
References: <20240129030405.177100-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Fabiano Rosas <farosas@suse.de>

Wrap qemu_bh_schedule() to ensure we always hold a reference to the
current_migration object.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240119233922.32588-5-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b1213b59ce..0e7f101d64 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -199,6 +199,16 @@ void migration_object_init(void)
     dirty_bitmap_mig_init();
 }
 
+static void migration_bh_schedule(MigrationState *s, QEMUBH *bh)
+{
+    /*
+     * Ref the state for bh, because it may be called when
+     * there're already no other refs
+     */
+    object_ref(OBJECT(s));
+    qemu_bh_schedule(bh);
+}
+
 void migration_cancel(const Error *error)
 {
     if (error) {
@@ -714,8 +724,7 @@ process_incoming_migration_co(void *opaque)
     }
 
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
-    object_ref(OBJECT(migrate_get_current()));
-    qemu_bh_schedule(mis->bh);
+    migration_bh_schedule(migrate_get_current(), mis->bh);
     return;
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
@@ -1332,16 +1341,6 @@ static void migrate_fd_cleanup(MigrationState *s)
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
-static void migrate_fd_cleanup_schedule(MigrationState *s)
-{
-    /*
-     * Ref the state for bh, because it may be called when
-     * there're already no other refs
-     */
-    object_ref(OBJECT(s));
-    qemu_bh_schedule(s->cleanup_bh);
-}
-
 static void migrate_fd_cleanup_bh(void *opaque)
 {
     MigrationState *s = opaque;
@@ -3140,7 +3139,7 @@ static void migration_iteration_finish(MigrationState *s)
         error_report("%s: Unknown ending state %d", __func__, s->state);
         break;
     }
-    migrate_fd_cleanup_schedule(s);
+    migration_bh_schedule(s, s->cleanup_bh);
     bql_unlock();
 }
 
@@ -3171,7 +3170,7 @@ static void bg_migration_iteration_finish(MigrationState *s)
         break;
     }
 
-    migrate_fd_cleanup_schedule(s);
+    migration_bh_schedule(s, s->cleanup_bh);
     bql_unlock();
 }
 
@@ -3487,9 +3486,7 @@ static void *bg_migration_thread(void *opaque)
      * writes to virtio VQs memory which is in write-protected region.
      */
     s->vm_start_bh = qemu_bh_new(bg_migration_vm_start_bh, s);
-    object_ref(OBJECT(s));
-    qemu_bh_schedule(s->vm_start_bh);
-
+    migration_bh_schedule(s, s->vm_start_bh);
     bql_unlock();
 
     while (migration_is_active(s)) {
-- 
2.43.0


