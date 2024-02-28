Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D7DC54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCJm-0001yi-4b; Wed, 28 Feb 2024 00:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCIv-0001Ay-Nq
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCIr-0007EB-QW
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7NsovfeF8cfD7pP93qcBb8PC0+ZjoQaPnIIVHkuGSPY=;
 b=XAqbjspupbjCup1UvEJDqfSYAaEj9uq8vmd4RqrazQi7z7VohXvMPLWoiSBSq+QOOZF/je
 2TF173PcNnsxAbxhWTrfOptoYR643VfVSRs/wpOz8r53kpHjpqTrIf7fsOTC3d5ahghQLZ
 7Go899G/yf1Uxdv5niMzMPERD1ToUd0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-SeGDnQN8Mmq_0OI9E0p8PA-1; Wed,
 28 Feb 2024 00:16:22 -0500
X-MC-Unique: SeGDnQN8Mmq_0OI9E0p8PA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20DA23C11CC4;
 Wed, 28 Feb 2024 05:16:06 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0430B1C060B1;
 Wed, 28 Feb 2024 05:15:56 +0000 (UTC)
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
Subject: [PULL 17/25] migration: per-mode notifiers
Date: Wed, 28 Feb 2024 13:13:07 +0800
Message-ID: <20240228051315.400759-18-peterx@redhat.com>
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

Keep a separate list of migration notifiers for each migration mode.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/1708622920-68779-8-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  6 ++++++
 migration/migration.c    | 22 +++++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e36a1f3ec4..4dc06a92b7 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -86,6 +86,12 @@ typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
 void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func);
 
+/*
+ * Same as migration_add_notifier, but applies to be specified @mode.
+ */
+void migration_add_notifier_mode(NotifierWithReturn *notify,
+                                 MigrationNotifyFunc func, MigMode mode);
+
 void migration_remove_notifier(NotifierWithReturn *notify);
 void migration_call_notifiers(MigrationState *s, MigrationEventType type);
 bool migration_in_setup(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index 33149c462c..925103b61a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -69,8 +69,13 @@
 #include "qemu/sockets.h"
 #include "sysemu/kvm.h"
 
-static NotifierWithReturnList migration_state_notifiers =
-    NOTIFIER_WITH_RETURN_LIST_INITIALIZER(migration_state_notifiers);
+#define NOTIFIER_ELEM_INIT(array, elem)    \
+    [elem] = NOTIFIER_WITH_RETURN_LIST_INITIALIZER((array)[elem])
+
+static NotifierWithReturnList migration_state_notifiers[] = {
+    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
+    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
+};
 
 /* Messages sent on the return path from destination to source */
 enum mig_rp_message_type {
@@ -1463,11 +1468,17 @@ static void migrate_fd_cancel(MigrationState *s)
     }
 }
 
+void migration_add_notifier_mode(NotifierWithReturn *notify,
+                                 MigrationNotifyFunc func, MigMode mode)
+{
+    notify->notify = (NotifierWithReturnFunc)func;
+    notifier_with_return_list_add(&migration_state_notifiers[mode], notify);
+}
+
 void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func)
 {
-    notify->notify = (NotifierWithReturnFunc)func;
-    notifier_with_return_list_add(&migration_state_notifiers, notify);
+    migration_add_notifier_mode(notify, func, MIG_MODE_NORMAL);
 }
 
 void migration_remove_notifier(NotifierWithReturn *notify)
@@ -1480,10 +1491,11 @@ void migration_remove_notifier(NotifierWithReturn *notify)
 
 void migration_call_notifiers(MigrationState *s, MigrationEventType type)
 {
+    MigMode mode = s->parameters.mode;
     MigrationEvent e;
 
     e.type = type;
-    notifier_with_return_list_notify(&migration_state_notifiers, &e, 0);
+    notifier_with_return_list_notify(&migration_state_notifiers[mode], &e, 0);
 }
 
 bool migration_in_setup(MigrationState *s)
-- 
2.43.0


