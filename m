Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D656AC54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCK1-0002zn-TH; Wed, 28 Feb 2024 00:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCJd-0001yE-0l
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:17:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCJX-0007rf-51
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SeCXWTc2LOa/udPJdH7J6CxuapLlRBF7PPJgbugBis=;
 b=DYZcu4XE7hIvpWR/qxEQWiuO1e3wKMKNhSEH51TpQLVlaYf3/2oxMo8tsRWgvyaVyXAjZW
 Yah4Zr2ixh3hdEU7dwTH7SSMZOmcV6qOwfh0yDYGdBgsVbYbsi39mcl9T1dFa31R2O6e0X
 lHpEKG9oFFXU7nPggBl5l5sV7ww/YL8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-KlJ5Q3LpOBiI2y1LCimvpQ-1; Wed, 28 Feb 2024 00:17:04 -0500
X-MC-Unique: KlJ5Q3LpOBiI2y1LCimvpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A72951071CE0;
 Wed, 28 Feb 2024 05:17:03 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73DF81C06710;
 Wed, 28 Feb 2024 05:16:55 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 23/25] migration: Fix qmp_query_migrate mbps value
Date: Wed, 28 Feb 2024 13:13:13 +0800
Message-ID: <20240228051315.400759-24-peterx@redhat.com>
In-Reply-To: <20240228051315.400759-1-peterx@redhat.com>
References: <20240228051315.400759-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The QMP command query_migrate might see incorrect throughput numbers
if it runs after we've set the migration completion status but before
migration_calculate_complete() has updated s->total_time and s->mbps.

The migration status would show COMPLETED, but the throughput value
would be the one from the last iteration and not the one from the
whole migration. This will usually be a larger value due to the time
period being smaller (one iteration).

Move migration_calculate_complete() earlier so that the status
MIGRATION_STATUS_COMPLETED is only emitted after the final counters
update. Keep everything under the BQL so the QMP thread sees the
updates as atomic.

Rename migration_calculate_complete to migration_completion_end to
reflect its new purpose of also updating s->state.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240226143335.14282-1-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7652fd4d14..ccb13fa94a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -107,6 +107,7 @@ static int migration_maybe_pause(MigrationState *s,
                                  int new_state);
 static void migrate_fd_cancel(MigrationState *s);
 static bool close_return_path_on_source(MigrationState *s);
+static void migration_completion_end(MigrationState *s);
 
 static void migration_downtime_start(MigrationState *s)
 {
@@ -2787,8 +2788,7 @@ static void migration_completion(MigrationState *s)
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_COLO);
     } else {
-        migrate_set_state(&s->state, current_active_state,
-                          MIGRATION_STATUS_COMPLETED);
+        migration_completion_end(s);
     }
 
     return;
@@ -2825,8 +2825,7 @@ static void bg_migration_completion(MigrationState *s)
         goto fail;
     }
 
-    migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_COMPLETED);
+    migration_completion_end(s);
     return;
 
 fail:
@@ -3028,18 +3027,28 @@ static MigThrError migration_detect_error(MigrationState *s)
     }
 }
 
-static void migration_calculate_complete(MigrationState *s)
+static void migration_completion_end(MigrationState *s)
 {
     uint64_t bytes = migration_transferred_bytes();
     int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t transfer_time;
 
+    /*
+     * Take the BQL here so that query-migrate on the QMP thread sees:
+     * - atomic update of s->total_time and s->mbps;
+     * - correct ordering of s->mbps update vs. s->state;
+     */
+    bql_lock();
     migration_downtime_end(s);
     s->total_time = end_time - s->start_time;
     transfer_time = s->total_time - s->setup_time;
     if (transfer_time) {
         s->mbps = ((double) bytes * 8.0) / transfer_time / 1000;
     }
+
+    migrate_set_state(&s->state, s->state,
+                      MIGRATION_STATUS_COMPLETED);
+    bql_unlock();
 }
 
 static void update_iteration_initial_status(MigrationState *s)
@@ -3186,7 +3195,6 @@ static void migration_iteration_finish(MigrationState *s)
     bql_lock();
     switch (s->state) {
     case MIGRATION_STATUS_COMPLETED:
-        migration_calculate_complete(s);
         runstate_set(RUN_STATE_POSTMIGRATE);
         break;
     case MIGRATION_STATUS_COLO:
@@ -3230,9 +3238,6 @@ static void bg_migration_iteration_finish(MigrationState *s)
     bql_lock();
     switch (s->state) {
     case MIGRATION_STATUS_COMPLETED:
-        migration_calculate_complete(s);
-        break;
-
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_CANCELLED:
-- 
2.43.0


