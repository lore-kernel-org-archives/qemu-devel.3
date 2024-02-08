Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A972C4829D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulK-0000Mw-AO; Wed, 07 Feb 2024 22:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukn-0007EK-MR
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukl-0004SO-VH
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hM7JTowvoXYGlHo4A15T65Zf4ZTl3CP8XX2SKnb7Lko=;
 b=eUNRtOhLsHeegyLrE4sD8G/oVVYaRYZZvMwYacn5z0DIlkUhb/bKHaeCj9MH8qAcsO13IY
 PyK92zshfEml7QPf2mCWHHuINKZI+LcogMS9r2AjOlyqlDc2vRhnCPLL0tUVkQiItvyWoN
 FxQdskxwNE+oiV5OAangJr8Z8Lv0B7o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-8o_JbMc7PWSf1ec4xamrJQ-1; Wed, 07 Feb 2024 22:07:03 -0500
X-MC-Unique: 8o_JbMc7PWSf1ec4xamrJQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E443D85A58B;
 Thu,  8 Feb 2024 03:07:02 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8939E492BC7;
 Thu,  8 Feb 2024 03:07:00 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 28/34] migration/multifd: Move multifd_send_setup error
 handling in to the function
Date: Thu,  8 Feb 2024 11:05:22 +0800
Message-ID: <20240208030528.368214-29-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
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

From: Fabiano Rosas <farosas@suse.de>

Hide the error handling inside multifd_send_setup to make it cleaner
for the next patch to move the function around.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240206215118.6171-4-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h   |  2 +-
 migration/migration.c |  6 +-----
 migration/multifd.c   | 24 +++++++++++++++++-------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 7881980ee6..8a1cad0996 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -13,7 +13,7 @@
 #ifndef QEMU_MIGRATION_MULTIFD_H
 #define QEMU_MIGRATION_MULTIFD_H
 
-int multifd_send_setup(Error **errp);
+bool multifd_send_setup(void);
 void multifd_send_shutdown(void);
 int multifd_recv_setup(Error **errp);
 void multifd_recv_cleanup(void);
diff --git a/migration/migration.c b/migration/migration.c
index b427be8762..6432a81e8b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3635,11 +3635,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         return;
     }
 
-    if (multifd_send_setup(&local_err) != 0) {
-        migrate_set_error(s, local_err);
-        error_report_err(local_err);
-        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                          MIGRATION_STATUS_FAILED);
+    if (!multifd_send_setup()) {
         migrate_fd_cleanup(s);
         return;
     }
diff --git a/migration/multifd.c b/migration/multifd.c
index e6ac1ad6dc..cf865edba0 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -985,14 +985,16 @@ static void multifd_new_send_channel_create(gpointer opaque)
     socket_send_channel_create(multifd_new_send_channel_async, opaque);
 }
 
-int multifd_send_setup(Error **errp)
+bool multifd_send_setup(void)
 {
-    int thread_count;
+    MigrationState *s = migrate_get_current();
+    Error *local_err = NULL;
+    int thread_count, ret = 0;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     uint8_t i;
 
     if (!migrate_multifd()) {
-        return 0;
+        return true;
     }
 
     thread_count = migrate_multifd_channels();
@@ -1026,14 +1028,22 @@ int multifd_send_setup(Error **errp)
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
-        int ret;
 
-        ret = multifd_send_state->ops->send_setup(p, errp);
+        ret = multifd_send_state->ops->send_setup(p, &local_err);
         if (ret) {
-            return ret;
+            break;
         }
     }
-    return 0;
+
+    if (ret) {
+        migrate_set_error(s, local_err);
+        error_report_err(local_err);
+        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
+                          MIGRATION_STATUS_FAILED);
+        return false;
+    }
+
+    return true;
 }
 
 struct {
-- 
2.43.0


