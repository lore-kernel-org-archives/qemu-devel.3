Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB74C47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 04:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTDfi-0002IM-5E; Thu, 25 Jan 2024 23:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rTDfU-000230-Qd
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 23:18:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rTDfR-000508-UL
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 23:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706242693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nwPQaFncawh6LoHnuw9aCaruCaalCFdEX19mUZAGe+Q=;
 b=M725+GOyXVV/DTLZYBa81/gikauJ8lTLz8ic1XYDGyvjzAMDtxrvTWUeBbNd8IxMUplPsI
 AFPy3ulj/B3lAOHn6n/UXlX2mYNOgXAsdIviNmhKOBMRTH1VxIQoXQLoU66G15NtThf2bg
 kQ2UUQnwpRMRKeLu3kEf8oi1x3qtbr8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-LnfpJD83PmiwHonQn2F1yg-1; Thu, 25 Jan 2024 23:18:09 -0500
X-MC-Unique: LnfpJD83PmiwHonQn2F1yg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00E1283DE27;
 Fri, 26 Jan 2024 04:18:09 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0ADE6492BC6;
 Fri, 26 Jan 2024 04:18:06 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	peterx@redhat.com
Subject: [PULL 13/15] migration: Add a wrapper to qemu_bh_schedule
Date: Fri, 26 Jan 2024 12:17:23 +0800
Message-ID: <20240126041725.124562-14-peterx@redhat.com>
In-Reply-To: <20240126041725.124562-1-peterx@redhat.com>
References: <20240126041725.124562-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


