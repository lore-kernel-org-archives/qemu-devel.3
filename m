Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58256C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulM-0000g9-GG; Wed, 07 Feb 2024 22:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukC-0006ZW-J6
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukA-0004NX-Oe
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmVOlgbKMIZPUpnLNg5089YHM4K2bPynpzFMwVEBTrI=;
 b=J8hLITL2VWZ/V0GzGW8GdZOXA+iS/L3lXzMiPVysK5ziqNIKxY0rej7OzRN/FbvfwSrT8X
 FRGEyVVSehM8Ts9te9m2VUEcihSvNHjDeLTWVJQ6LpmFbF6zHhuUA1vIegr0FSgejbeAct
 D21WiVa+iWiuf9jPo1g03bRl2ZtI+Yg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-qEEz9NggN86I5Niux8CcdQ-1; Wed,
 07 Feb 2024 22:06:23 -0500
X-MC-Unique: qEEz9NggN86I5Niux8CcdQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A91B73806710;
 Thu,  8 Feb 2024 03:06:22 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 673D9492BC7;
 Thu,  8 Feb 2024 03:06:20 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 16/34] migration/multifd: Split multifd_send_terminate_threads()
Date: Thu,  8 Feb 2024 11:05:10 +0800
Message-ID: <20240208030528.368214-17-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

Split multifd_send_terminate_threads() into two functions:

  - multifd_send_set_error(): used when an error happened on the sender
    side, set error and quit state only

  - multifd_send_terminate_threads(): used only by the main thread to kick
    all multifd send threads out of sleep, for the last recycling.

Use multifd_send_set_error() in the three old call sites where only the
error will be set.

Use multifd_send_terminate_threads() in the last one where the main thread
will kick the multifd threads at last in multifd_save_cleanup().

Both helpers will need to set quitting=1.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240202102857.110210-16-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c    | 27 ++++++++++++++++++---------
 migration/trace-events |  2 +-
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 28b54100cd..ba86f9dda5 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -536,10 +536,9 @@ int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
     return 1;
 }
 
-static void multifd_send_terminate_threads(Error *err)
+/* Multifd send side hit an error; remember it and prepare to quit */
+static void multifd_send_set_error(Error *err)
 {
-    int i;
-
     /*
      * We don't want to exit each threads twice.  Depending on where
      * we get the error, or if there are two independent errors in two
@@ -550,8 +549,6 @@ static void multifd_send_terminate_threads(Error *err)
         return;
     }
 
-    trace_multifd_send_terminate_threads(err != NULL);
-
     if (err) {
         MigrationState *s = migrate_get_current();
         migrate_set_error(s, err);
@@ -563,7 +560,19 @@ static void multifd_send_terminate_threads(Error *err)
                               MIGRATION_STATUS_FAILED);
         }
     }
+}
+
+static void multifd_send_terminate_threads(void)
+{
+    int i;
+
+    trace_multifd_send_terminate_threads();
 
+    /*
+     * Tell everyone we're quitting.  No xchg() needed here; we simply
+     * always set it.
+     */
+    qatomic_set(&multifd_send_state->exiting, 1);
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -586,7 +595,7 @@ void multifd_save_cleanup(void)
     if (!migrate_multifd()) {
         return;
     }
-    multifd_send_terminate_threads(NULL);
+    multifd_send_terminate_threads();
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -780,7 +789,7 @@ out:
     if (ret) {
         assert(local_err);
         trace_multifd_send_error(p->id);
-        multifd_send_terminate_threads(local_err);
+        multifd_send_set_error(local_err);
         multifd_send_kick_main(p);
         error_free(local_err);
     }
@@ -816,7 +825,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
 
     trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
 
-    multifd_send_terminate_threads(err);
+    multifd_send_set_error(err);
     multifd_send_kick_main(p);
     error_free(err);
 }
@@ -898,7 +907,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     }
 
     trace_multifd_new_send_channel_async_error(p->id, local_err);
-    multifd_send_terminate_threads(local_err);
+    multifd_send_set_error(local_err);
     multifd_send_kick_main(p);
     object_unref(OBJECT(ioc));
     error_free(local_err);
diff --git a/migration/trace-events b/migration/trace-events
index de4a743c8a..298ad2b0dd 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -141,7 +141,7 @@ multifd_send_error(uint8_t id) "channel %u"
 multifd_send_sync_main(long packet_num) "packet num %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %u"
 multifd_send_sync_main_wait(uint8_t id) "channel %u"
-multifd_send_terminate_threads(bool error) "error %d"
+multifd_send_terminate_threads(void) ""
 multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64
 multifd_send_thread_start(uint8_t id) "%u"
 multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
-- 
2.43.0


