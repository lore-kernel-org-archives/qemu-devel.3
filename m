Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A42CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1mB-00019S-9O; Mon, 03 Nov 2025 16:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1m9-00018m-DG
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1ln-0005S6-Ol
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEkjkfuvOhHIY1QnKh8dFMR2whXzjtCTaNgURMh8zm4=;
 b=cUeHMLPROBOxE1pQQ6xWyyW8fVcftPNoS81AVkO91uejXCVlLgWihaNMXW2Jmuv6LCVSu7
 J83NotJJrzGraARfh7irQ9jiXXuED0zJOqxsXQsFIAB3A5T0EXH3Z/dJduhfeIkfhY41Yb
 6DnC58ahs5Ej8xcjsmiSqNqSlQQMXXE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-gzpa3W_pPQCj6yNMF0oShg-1; Mon, 03 Nov 2025 16:07:13 -0500
X-MC-Unique: gzpa3W_pPQCj6yNMF0oShg-1
X-Mimecast-MFC-AGG-ID: gzpa3W_pPQCj6yNMF0oShg_1762204033
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8a65ae81245so1487614085a.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204033; x=1762808833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEkjkfuvOhHIY1QnKh8dFMR2whXzjtCTaNgURMh8zm4=;
 b=hxfr4g9BxQ4BpageouL05dT/KKVVKzemOb0q4PzHIhfM78iJoJJXQMnNPHuXZPbgPR
 yOXqTU0rzEqOc4ENcgpZAmt/DGqfFFjy0kpzsRuznIA+i+damZAkeDRnJuk3/M0+ITHA
 lSCrrYzRFTlnIJJ21CoEVmhVSBrGVIQf7gZhlvv9qEjRxOIWJp1G3nS0/Qb7524wCTuk
 ew02Q6JxKnxhPJ3EdZYywgMQ3nJ137QQIn2ndJWx+OgnkxR5uL2JhTQHms0GW4JIRwmx
 7xWNynrOVcBYTci5SpVUSRr3dtFIclAGaIJ/tZ8VzzR5kAYA35dvnkGqwM8M7ZQhz/Qw
 7pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204033; x=1762808833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nEkjkfuvOhHIY1QnKh8dFMR2whXzjtCTaNgURMh8zm4=;
 b=IthILar+7K6w/reb+ruBQBi+8MrCcssXgSCE6RQzd6YzshTUXq8a9IozmH7LCDqXp3
 1kOYj9OtyEs2B+mpI++TDqR5g6vl6kF05++eAOf1v5ZHIIjSsZv+EA3l/6J5UYmWZq83
 dp4W23lTU/80xTrIGCA9ruiebZwHlu+SKpMOUSgG3+Wb39wPpz0hzAksIE9PJUqgN2gy
 ONqhhPP+Ab3h0S99nk+RcC+M2Z5njaieptaWRbLV8kcR5rKeJSDCP+mJWZBNTBQ+AfCH
 75PHpyVM8TodLspEOYwAKKOLk10lLOOmjOq1EufxiZEIoUKuRKB7Mngf/WBxQmQjoWvm
 1p7g==
X-Gm-Message-State: AOJu0Yz+8wyl9UEPjL/3PPeN57OX4QHxsxaCr0JE6xqJ0kVDSj665t6L
 KgtPwsZkBSItmwCC9mZTc0B8WvhYQ7B/Jag1q/Xc5UrL3KlylQVDzuuUTXo1+TzECPxS4/XhonE
 HEg2SvLw/pOJimz9apmYWcj4VloOyoNMaa5GOtMHs8x/Buydhlnbj9b4OUe4IVVFO4laXcUne4I
 E8SXtti8Xxq8ktWZFdH3GcLXM/kIPkn4m0hM8mOw==
X-Gm-Gg: ASbGncs0Q+T4fUo2AZUpe8S3QggvMVOo+n2JpcXCC52cdbB7cyjR0p1f8a9gtfYe1Zh
 iF7vSHSOCv8nQxmexjefD2SJSjRUMTZzlV3qjy0FBr9WGPtZB2yDE6TRLZAx/wOO8WDB3GgeoEV
 3xFEKkBKlWrj4jPXIBWf2LZdFMUnVx7fvdTeQWhiUQPJEJFhtkbgUIwCb5j5hFKk6C7tv4Hi3x0
 6axO8OmtnmUM00Zzamm9iDhwjVGLcj7Dvd7QzA/SlPPLDonfzyBHNoJxs/sHR5VzZI/nx4IpkXL
 mFyO9oHsUrandxyd+fVDJT9Qzz9f09UX8MOdo7y8HGuer7Y+/dRZR+mTzKuOdR+v
X-Received: by 2002:a05:620a:1a2a:b0:859:a927:e7cf with SMTP id
 af79cd13be357-8ab9997878bmr1772546385a.36.1762204032448; 
 Mon, 03 Nov 2025 13:07:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPey1l+9g+rqRZhiy3qOL5teAswN82GBYBgdZAmKL2hr3wg7l1gvtCo503RchLhZpHnkSbLg==
X-Received: by 2002:a05:620a:1a2a:b0:859:a927:e7cf with SMTP id
 af79cd13be357-8ab9997878bmr1772538185a.36.1762204031663; 
 Mon, 03 Nov 2025 13:07:11 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:07:10 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 31/36] migration: Move postcopy_ram_listen_thread() to
 postcopy-ram.c
Date: Mon,  3 Nov 2025 16:06:20 -0500
Message-ID: <20251103210625.3689448-32-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This patch addresses a TODO about moving postcopy_ram_listen_thread() to
postcopy file.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20251103183301.3840862-4-jmarcin@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.h |   2 +
 migration/postcopy-ram.c | 105 ++++++++++++++++++++++++++++++++++++++
 migration/savevm.c       | 107 ---------------------------------------
 3 files changed, 107 insertions(+), 107 deletions(-)

diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index ca19433b24..3e26db3e6b 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -199,4 +199,6 @@ bool postcopy_is_paused(MigrationStatus status);
 void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
                                    RAMBlock *rb);
 
+void *postcopy_ram_listen_thread(void *opaque);
+
 #endif
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 5471efb4f0..880b11f154 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2077,3 +2077,108 @@ bool postcopy_is_paused(MigrationStatus status)
     return status == MIGRATION_STATUS_POSTCOPY_PAUSED ||
         status == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP;
 }
+
+/*
+ * Triggered by a postcopy_listen command; this thread takes over reading
+ * the input stream, leaving the main thread free to carry on loading the rest
+ * of the device state (from RAM).
+ */
+void *postcopy_ram_listen_thread(void *opaque)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    QEMUFile *f = mis->from_src_file;
+    int load_res;
+    MigrationState *migr = migrate_get_current();
+    Error *local_err = NULL;
+
+    object_ref(OBJECT(migr));
+
+    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
+                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    qemu_event_set(&mis->thread_sync_event);
+    trace_postcopy_ram_listen_thread_start();
+
+    rcu_register_thread();
+    /*
+     * Because we're a thread and not a coroutine we can't yield
+     * in qemu_file, and thus we must be blocking now.
+     */
+    qemu_file_set_blocking(f, true, &error_fatal);
+
+    /* TODO: sanity check that only postcopiable data will be loaded here */
+    load_res = qemu_loadvm_state_main(f, mis, &local_err);
+
+    /*
+     * This is tricky, but, mis->from_src_file can change after it
+     * returns, when postcopy recovery happened. In the future, we may
+     * want a wrapper for the QEMUFile handle.
+     */
+    f = mis->from_src_file;
+
+    /* And non-blocking again so we don't block in any cleanup */
+    qemu_file_set_blocking(f, false, &error_fatal);
+
+    trace_postcopy_ram_listen_thread_exit();
+    if (load_res < 0) {
+        qemu_file_set_error(f, load_res);
+        dirty_bitmap_mig_cancel_incoming();
+        if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
+            !migrate_postcopy_ram() && migrate_dirty_bitmaps())
+        {
+            error_report("%s: loadvm failed during postcopy: %d: %s. All states "
+                         "are migrated except dirty bitmaps. Some dirty "
+                         "bitmaps may be lost, and present migrated dirty "
+                         "bitmaps are correctly migrated and valid.",
+                         __func__, load_res, error_get_pretty(local_err));
+            g_clear_pointer(&local_err, error_free);
+            load_res = 0; /* prevent further exit() */
+        } else {
+            error_prepend(&local_err,
+                          "loadvm failed during postcopy: %d: ", load_res);
+            migrate_set_error(migr, local_err);
+            g_clear_pointer(&local_err, error_report_err);
+            migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                                           MIGRATION_STATUS_FAILED);
+        }
+    }
+    if (load_res >= 0) {
+        /*
+         * This looks good, but it's possible that the device loading in the
+         * main thread hasn't finished yet, and so we might not be in 'RUN'
+         * state yet; wait for the end of the main thread.
+         */
+        qemu_event_wait(&mis->main_thread_load_event);
+    }
+    postcopy_ram_incoming_cleanup(mis);
+
+    if (load_res < 0) {
+        /*
+         * If something went wrong then we have a bad state so exit;
+         * depending how far we got it might be possible at this point
+         * to leave the guest running and fire MCEs for pages that never
+         * arrived as a desperate recovery step.
+         */
+        rcu_unregister_thread();
+        exit(EXIT_FAILURE);
+    }
+
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                                   MIGRATION_STATUS_COMPLETED);
+    /*
+     * If everything has worked fine, then the main thread has waited
+     * for us to start, and we're the last use of the mis.
+     * (If something broke then qemu will have to exit anyway since it's
+     * got a bad migration state).
+     */
+    bql_lock();
+    migration_incoming_state_destroy();
+    bql_unlock();
+
+    rcu_unregister_thread();
+    mis->have_listen_thread = false;
+    postcopy_state_set(POSTCOPY_INCOMING_END);
+
+    object_unref(OBJECT(migr));
+
+    return NULL;
+}
diff --git a/migration/savevm.c b/migration/savevm.c
index fa017378db..2f7ed0db64 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2088,113 +2088,6 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
     return 0;
 }
 
-/*
- * Triggered by a postcopy_listen command; this thread takes over reading
- * the input stream, leaving the main thread free to carry on loading the rest
- * of the device state (from RAM).
- * (TODO:This could do with being in a postcopy file - but there again it's
- * just another input loop, not that postcopy specific)
- */
-static void *postcopy_ram_listen_thread(void *opaque)
-{
-    MigrationIncomingState *mis = migration_incoming_get_current();
-    QEMUFile *f = mis->from_src_file;
-    int load_res;
-    MigrationState *migr = migrate_get_current();
-    Error *local_err = NULL;
-
-    object_ref(OBJECT(migr));
-
-    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    qemu_event_set(&mis->thread_sync_event);
-    trace_postcopy_ram_listen_thread_start();
-
-    rcu_register_thread();
-    /*
-     * Because we're a thread and not a coroutine we can't yield
-     * in qemu_file, and thus we must be blocking now.
-     */
-    qemu_file_set_blocking(f, true, &error_fatal);
-
-    /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, &local_err);
-
-    /*
-     * This is tricky, but, mis->from_src_file can change after it
-     * returns, when postcopy recovery happened. In the future, we may
-     * want a wrapper for the QEMUFile handle.
-     */
-    f = mis->from_src_file;
-
-    /* And non-blocking again so we don't block in any cleanup */
-    qemu_file_set_blocking(f, false, &error_fatal);
-
-    trace_postcopy_ram_listen_thread_exit();
-    if (load_res < 0) {
-        qemu_file_set_error(f, load_res);
-        dirty_bitmap_mig_cancel_incoming();
-        if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
-            !migrate_postcopy_ram() && migrate_dirty_bitmaps())
-        {
-            error_report("%s: loadvm failed during postcopy: %d: %s. All states "
-                         "are migrated except dirty bitmaps. Some dirty "
-                         "bitmaps may be lost, and present migrated dirty "
-                         "bitmaps are correctly migrated and valid.",
-                         __func__, load_res, error_get_pretty(local_err));
-            g_clear_pointer(&local_err, error_free);
-            load_res = 0; /* prevent further exit() */
-        } else {
-            error_prepend(&local_err,
-                          "loadvm failed during postcopy: %d: ", load_res);
-            migrate_set_error(migr, local_err);
-            g_clear_pointer(&local_err, error_report_err);
-            migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                                           MIGRATION_STATUS_FAILED);
-        }
-    }
-    if (load_res >= 0) {
-        /*
-         * This looks good, but it's possible that the device loading in the
-         * main thread hasn't finished yet, and so we might not be in 'RUN'
-         * state yet; wait for the end of the main thread.
-         */
-        qemu_event_wait(&mis->main_thread_load_event);
-    }
-    postcopy_ram_incoming_cleanup(mis);
-
-    if (load_res < 0) {
-        /*
-         * If something went wrong then we have a bad state so exit;
-         * depending how far we got it might be possible at this point
-         * to leave the guest running and fire MCEs for pages that never
-         * arrived as a desperate recovery step.
-         */
-        rcu_unregister_thread();
-        exit(EXIT_FAILURE);
-    }
-
-    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                                   MIGRATION_STATUS_COMPLETED);
-    /*
-     * If everything has worked fine, then the main thread has waited
-     * for us to start, and we're the last use of the mis.
-     * (If something broke then qemu will have to exit anyway since it's
-     * got a bad migration state).
-     */
-    bql_lock();
-    migration_incoming_state_destroy();
-    bql_unlock();
-
-    rcu_unregister_thread();
-    mis->have_listen_thread = false;
-    postcopy_state_set(POSTCOPY_INCOMING_END);
-
-    object_unref(OBJECT(migr));
-
-    return NULL;
-}
-
 /* After this message we must be able to immediately receive postcopy data */
 static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis,
                                          Error **errp)
-- 
2.50.1


