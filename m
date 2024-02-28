Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0954EC54E51
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCJv-0002Kg-23; Wed, 28 Feb 2024 00:17:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCJ7-0001Kb-EY
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:16:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCIv-0007Gs-M9
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dg1ggDXCGJYUq+p4wWurYdu97dbcucxaIdvVX4P1Egk=;
 b=gUa1sEkQ6J+3aVYoXPbZOR8zKdJKbgx5oS0SB2kcmPlIBTvF+9ys6Sw1l/fnGWiveyNeS/
 iZQrL161kms9nHpQ4t9XIMYm6qNKKKOKhdkFVA5NpHrIJTzr842WKcE+ZhE2daNjvhzAHW
 za5Z2/t34mm/kAfZPKcTFGPg3oGdeZg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-NvQZgMmEP4qfaw3A-vC7Vw-1; Wed,
 28 Feb 2024 00:16:25 -0500
X-MC-Unique: NvQZgMmEP4qfaw3A-vC7Vw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76E643C11CC3;
 Wed, 28 Feb 2024 05:16:25 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7093F1C060B1;
 Wed, 28 Feb 2024 05:16:16 +0000 (UTC)
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
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 19/25] migration: notifier error checking
Date: Wed, 28 Feb 2024 13:13:09 +0800
Message-ID: <20240228051315.400759-20-peterx@redhat.com>
In-Reply-To: <20240228051315.400759-1-peterx@redhat.com>
References: <20240228051315.400759-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Check the status returned by migration notifiers for event type
MIG_EVENT_PRECOPY_SETUP, and report errors.  None of the notifiers
return an error status at this time.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1708622920-68779-10-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  8 +++++++-
 migration/migration.c    | 25 ++++++++++++++++---------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 4dc06a92b7..e4933b815b 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -72,6 +72,11 @@ typedef struct MigrationEvent {
     MigrationEventType type;
 } MigrationEvent;
 
+/*
+ * A MigrationNotifyFunc may return an error code and an Error object,
+ * but only when @e->type is MIG_EVENT_PRECOPY_SETUP.  The code is an int
+ * to allow for different failure modes and recovery actions.
+ */
 typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
                                    MigrationEvent *e, Error **errp);
 
@@ -93,7 +98,8 @@ void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode);
 
 void migration_remove_notifier(NotifierWithReturn *notify);
-void migration_call_notifiers(MigrationState *s, MigrationEventType type);
+int migration_call_notifiers(MigrationState *s, MigrationEventType type,
+                             Error **errp);
 bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index 6a115d28b8..37c836b0b0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1376,7 +1376,7 @@ static void migrate_fd_cleanup(MigrationState *s)
     }
     type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
                                      MIG_EVENT_PRECOPY_DONE;
-    migration_call_notifiers(s, type);
+    migration_call_notifiers(s, type, NULL);
     block_cleanup_parameters();
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
@@ -1489,13 +1489,18 @@ void migration_remove_notifier(NotifierWithReturn *notify)
     }
 }
 
-void migration_call_notifiers(MigrationState *s, MigrationEventType type)
+int migration_call_notifiers(MigrationState *s, MigrationEventType type,
+                             Error **errp)
 {
     MigMode mode = s->parameters.mode;
     MigrationEvent e;
+    int ret;
 
     e.type = type;
-    notifier_with_return_list_notify(&migration_state_notifiers[mode], &e, 0);
+    ret = notifier_with_return_list_notify(&migration_state_notifiers[mode],
+                                           &e, errp);
+    assert(!ret || type == MIG_EVENT_PRECOPY_SETUP);
+    return ret;
 }
 
 bool migration_in_setup(MigrationState *s)
@@ -2549,7 +2554,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * at the transition to postcopy and after the device state; in particular
      * spice needs to trigger a transition now
      */
-    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE);
+    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE, NULL);
 
     migration_downtime_end(ms);
 
@@ -2569,11 +2574,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
-        error_setg(errp, "postcopy_start: Migration stream errored");
-        migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                              MIGRATION_STATUS_FAILED);
+        error_setg_errno(errp, -ret, "postcopy_start: Migration stream error");
+        bql_lock();
+        goto fail;
     }
-
     trace_postcopy_preempt_enabled(migrate_postcopy_preempt());
 
     return ret;
@@ -2594,6 +2598,7 @@ fail:
             error_report_err(local_err);
         }
     }
+    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
     return -1;
 }
@@ -3613,7 +3618,9 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         rate_limit = migrate_max_bandwidth();
 
         /* Notify before starting migration thread */
-        migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP);
+        if (migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP, &local_err)) {
+            goto fail;
+        }
     }
 
     migration_rate_set(rate_limit);
-- 
2.43.0


