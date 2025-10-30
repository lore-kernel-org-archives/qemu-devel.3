Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD445CCFA02
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 21:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEaWv-0006nY-KI; Thu, 30 Oct 2025 17:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vEaWq-0006mW-98
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 17:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vEaWd-0000au-3k
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 17:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761860980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IuZ7wefnnYr02Da6Q6UYgXoyQkAcXJIfUpdX+fPhoSk=;
 b=TA448DjyH5D54NhH271/OifnPZDWvBCY2KcyD6o3TxzIuJBiKb5yeO17BvX4ZdPW+YkiS2
 ma6an/X9NmaGXxrhPfdo3N0M9I08rA8jeog6l35TJk1o/A1jUwOS3f1wXz9YiTlTnPJeFx
 S+7xqFVJ/ArAJavEkhezQ7k8FxM7rIw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-Q9UmRYkSMsuLePEp0JFvAw-1; Thu,
 30 Oct 2025 17:49:37 -0400
X-MC-Unique: Q9UmRYkSMsuLePEp0JFvAw-1
X-Mimecast-MFC-AGG-ID: Q9UmRYkSMsuLePEp0JFvAw_1761860976
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D320E1809A02; Thu, 30 Oct 2025 21:49:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.58])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACA3F1800587; Thu, 30 Oct 2025 21:49:33 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 3/7] migration: Introduce postcopy incoming setup and
 cleanup functions
Date: Thu, 30 Oct 2025 22:49:07 +0100
Message-ID: <20251030214915.1411860-4-jmarcin@redhat.com>
In-Reply-To: <20251030214915.1411860-1-jmarcin@redhat.com>
References: <20251030214915.1411860-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

After moving postcopy_ram_listen_thread() to postcopy file, this patch
introduces a pair of functions, postcopy_incoming_setup() and
postcopy_incoming_cleanup(). These functions encapsulate setup and
cleanup of all incoming postcopy resources, postcopy-ram and postcopy
listen thread.

Furthermore, this patch also renames the postcopy_ram_listen_thread to
postcopy_listen_thread, as this thread handles not only postcopy-ram,
but also dirty-bitmaps and in the future it could handle other
postcopiable devices.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.c    |  2 +-
 migration/postcopy-ram.c | 46 ++++++++++++++++++++++++++++++++++++----
 migration/postcopy-ram.h |  3 ++-
 migration/savevm.c       | 25 ++--------------------
 4 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6e647c7c4a..9a367f717e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -892,7 +892,7 @@ process_incoming_migration_co(void *opaque)
              * but managed to complete within the precopy period, we can use
              * the normal exit.
              */
-            postcopy_ram_incoming_cleanup(mis);
+            postcopy_incoming_cleanup(mis);
         } else if (ret >= 0) {
             /*
              * Postcopy was started, cleanup should happen at the end of the
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 36d5415554..b47c955763 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2082,10 +2082,8 @@ bool postcopy_is_paused(MigrationStatus status)
  * Triggered by a postcopy_listen command; this thread takes over reading
  * the input stream, leaving the main thread free to carry on loading the rest
  * of the device state (from RAM).
- * (TODO:This could do with being in a postcopy file - but there again it's
- * just another input loop, not that postcopy specific)
  */
-void *postcopy_ram_listen_thread(void *opaque)
+static void *postcopy_listen_thread(void *opaque)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     QEMUFile *f = mis->from_src_file;
@@ -2151,7 +2149,7 @@ void *postcopy_ram_listen_thread(void *opaque)
          */
         qemu_event_wait(&mis->main_thread_load_event);
     }
-    postcopy_ram_incoming_cleanup(mis);
+    postcopy_incoming_cleanup(mis);
 
     if (load_res < 0) {
         /*
@@ -2184,3 +2182,43 @@ void *postcopy_ram_listen_thread(void *opaque)
 
     return NULL;
 }
+
+int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp)
+{
+    /*
+     * Sensitise RAM - can now generate requests for blocks that don't exist
+     * However, at this point the CPU shouldn't be running, and the IO
+     * shouldn't be doing anything yet so don't actually expect requests
+     */
+    if (migrate_postcopy_ram()) {
+        if (postcopy_ram_incoming_setup(mis)) {
+            postcopy_ram_incoming_cleanup(mis);
+            error_setg(errp, "Failed to setup incoming postcopy RAM blocks");
+            return -1;
+        }
+    }
+
+    trace_loadvm_postcopy_handle_listen("after uffd");
+
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, errp)) {
+        return -1;
+    }
+
+    mis->have_listen_thread = true;
+    postcopy_thread_create(mis, &mis->listen_thread,
+                           MIGRATION_THREAD_DST_LISTEN,
+                           postcopy_listen_thread, QEMU_THREAD_DETACHED);
+
+    return 0;
+}
+
+int postcopy_incoming_cleanup(MigrationIncomingState *mis)
+{
+    int rc = 0;
+
+    if (migrate_postcopy_ram()) {
+        rc = postcopy_ram_incoming_cleanup(mis);
+    }
+
+    return rc;
+}
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 3e26db3e6b..a080dd65a7 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -199,6 +199,7 @@ bool postcopy_is_paused(MigrationStatus status);
 void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
                                    RAMBlock *rb);
 
-void *postcopy_ram_listen_thread(void *opaque);
+int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp);
+int postcopy_incoming_cleanup(MigrationIncomingState *mis);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 97fdd08c08..6ae3f740b5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2112,32 +2112,11 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis,
 
     trace_loadvm_postcopy_handle_listen("after discard");
 
-    /*
-     * Sensitise RAM - can now generate requests for blocks that don't exist
-     * However, at this point the CPU shouldn't be running, and the IO
-     * shouldn't be doing anything yet so don't actually expect requests
-     */
-    if (migrate_postcopy_ram()) {
-        if (postcopy_ram_incoming_setup(mis)) {
-            postcopy_ram_incoming_cleanup(mis);
-            error_setg(errp, "Failed to setup incoming postcopy RAM blocks");
-            return -1;
-        }
-    }
+    int rc = postcopy_incoming_setup(mis, errp);
 
-    trace_loadvm_postcopy_handle_listen("after uffd");
-
-    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, errp)) {
-        return -1;
-    }
-
-    mis->have_listen_thread = true;
-    postcopy_thread_create(mis, &mis->listen_thread,
-                           MIGRATION_THREAD_DST_LISTEN,
-                           postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
     trace_loadvm_postcopy_handle_listen("return");
 
-    return 0;
+    return rc;
 }
 
 static void loadvm_postcopy_handle_run_bh(void *opaque)
-- 
2.51.0


