Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA56EC4829B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulE-0007tR-Vo; Wed, 07 Feb 2024 22:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukS-0006it-79
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukQ-0004On-0d
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9gCdiOaSnuVcgNHNR30uoRO4+oGuDwrWMxfdOknJjo=;
 b=Hfpr3meujD3fWcEwyPLs50djqI4apptq5RrjgKvMxJrJbg2V/ZpmScHRszKyQk74wZPd2n
 8NY+QdZMzkCcj48742jXJhpfr3UkZdkWwFoW5jq930Zy/FFqiB4jRDpkHFY7M8ppk6mDB+
 Umrqj0Sz7nESLJi0aQkTYi+tVdEIUWc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-K5T8cWuMOhW9IHzV11thKQ-1; Wed,
 07 Feb 2024 22:06:41 -0500
X-MC-Unique: K5T8cWuMOhW9IHzV11thKQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 690A53806710;
 Thu,  8 Feb 2024 03:06:41 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28A51492BC7;
 Thu,  8 Feb 2024 03:06:38 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 22/34] migration/multifd: Stick with send/recv on function names
Date: Thu,  8 Feb 2024 11:05:16 +0800
Message-ID: <20240208030528.368214-23-peterx@redhat.com>
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

From: Peter Xu <peterx@redhat.com>

Most of the multifd code uses send/recv to represent the two sides, but
some rare cases use save/load.

Since send/recv is the majority, replacing the save/load use cases to use
send/recv globally.  Now we reach a consensus on the naming.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240202102857.110210-22-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h   | 10 +++++-----
 migration/migration.c | 12 ++++++------
 migration/multifd.c   | 10 +++++-----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index a320c53a6f..9b40a53cb6 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -13,11 +13,11 @@
 #ifndef QEMU_MIGRATION_MULTIFD_H
 #define QEMU_MIGRATION_MULTIFD_H
 
-int multifd_save_setup(Error **errp);
-void multifd_save_cleanup(void);
-int multifd_load_setup(Error **errp);
-void multifd_load_cleanup(void);
-void multifd_load_shutdown(void);
+int multifd_send_setup(Error **errp);
+void multifd_send_shutdown(void);
+int multifd_recv_setup(Error **errp);
+void multifd_recv_cleanup(void);
+void multifd_recv_shutdown(void);
 bool multifd_recv_all_channels_created(void);
 void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 void multifd_recv_sync_main(void);
diff --git a/migration/migration.c b/migration/migration.c
index b574e66f7b..9b695685b1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -312,7 +312,7 @@ void migration_incoming_state_destroy(void)
 {
     struct MigrationIncomingState *mis = migration_incoming_get_current();
 
-    multifd_load_cleanup();
+    multifd_recv_cleanup();
     compress_threads_load_cleanup();
 
     if (mis->to_src_file) {
@@ -663,7 +663,7 @@ static void process_incoming_migration_bh(void *opaque)
 
     trace_vmstate_downtime_checkpoint("dst-precopy-bh-announced");
 
-    multifd_load_shutdown();
+    multifd_recv_shutdown();
 
     dirty_bitmap_mig_before_vm_start();
 
@@ -760,7 +760,7 @@ fail:
                       MIGRATION_STATUS_FAILED);
     qemu_fclose(mis->from_src_file);
 
-    multifd_load_cleanup();
+    multifd_recv_cleanup();
     compress_threads_load_cleanup();
 
     exit(EXIT_FAILURE);
@@ -886,7 +886,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
         default_channel = !mis->from_src_file;
     }
 
-    if (multifd_load_setup(errp) != 0) {
+    if (multifd_recv_setup(errp) != 0) {
         return;
     }
 
@@ -1332,7 +1332,7 @@ static void migrate_fd_cleanup(MigrationState *s)
         }
         bql_lock();
 
-        multifd_save_cleanup();
+        multifd_send_shutdown();
         qemu_mutex_lock(&s->qemu_file_lock);
         tmp = s->to_dst_file;
         s->to_dst_file = NULL;
@@ -3630,7 +3630,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         return;
     }
 
-    if (multifd_save_setup(&local_err) != 0) {
+    if (multifd_send_setup(&local_err) != 0) {
         migrate_set_error(s, local_err);
         error_report_err(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
diff --git a/migration/multifd.c b/migration/multifd.c
index e2dd2f6e04..130f86a1fb 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -663,7 +663,7 @@ static void multifd_send_cleanup_state(void)
     multifd_send_state = NULL;
 }
 
-void multifd_save_cleanup(void)
+void multifd_send_shutdown(void)
 {
     int i;
 
@@ -965,7 +965,7 @@ static void multifd_new_send_channel_create(gpointer opaque)
     socket_send_channel_create(multifd_new_send_channel_async, opaque);
 }
 
-int multifd_save_setup(Error **errp)
+int multifd_send_setup(Error **errp)
 {
     int thread_count;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
@@ -1063,7 +1063,7 @@ static void multifd_recv_terminate_threads(Error *err)
     }
 }
 
-void multifd_load_shutdown(void)
+void multifd_recv_shutdown(void)
 {
     if (migrate_multifd()) {
         multifd_recv_terminate_threads(NULL);
@@ -1098,7 +1098,7 @@ static void multifd_recv_cleanup_state(void)
     multifd_recv_state = NULL;
 }
 
-void multifd_load_cleanup(void)
+void multifd_recv_cleanup(void)
 {
     int i;
 
@@ -1213,7 +1213,7 @@ static void *multifd_recv_thread(void *opaque)
     return NULL;
 }
 
-int multifd_load_setup(Error **errp)
+int multifd_recv_setup(Error **errp)
 {
     int thread_count;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
-- 
2.43.0


