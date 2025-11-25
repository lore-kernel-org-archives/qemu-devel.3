Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244A4D0EE25
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 20:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNzxH-0007qk-2R; Tue, 25 Nov 2025 15:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzwI-0007CT-3v
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzwF-00031M-FK
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764103621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39vtfy/ykemAPu0lP0oiKmDXg8WxA7OgREWmGs1cs8I=;
 b=ff+fT5X5Ymba2Mtbi1LKLDXBsnqbf1QaxHcr2y9Pfuduozgm+U3kP0IK/lbD60quHOEIiI
 KkhMRj+eT6WDLIIWpbYbkF//RNujMfnlZhuY61YR/HkNaNFFdPCRrl1ImNBJqv0C7B2lna
 nBgrxmUuchvEZzjiPicXOWzwoTTnDWM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-y96qFWz9NnKTFwBP-V2PbQ-1; Tue, 25 Nov 2025 15:47:00 -0500
X-MC-Unique: y96qFWz9NnKTFwBP-V2PbQ-1
X-Mimecast-MFC-AGG-ID: y96qFWz9NnKTFwBP-V2PbQ_1764103619
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b2217a9c60so2228651285a.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 12:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764103619; x=1764708419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39vtfy/ykemAPu0lP0oiKmDXg8WxA7OgREWmGs1cs8I=;
 b=FIpHTDd/4bXOxDzdGAr88UN8/sGhRCbX04KB63tebzcmH9xjTWxL3RO9573hyZHFj7
 wWBZiFBAY6aTZTttN9fvHU4pVZUn9sZsM/4e4RxsDZ0Ll6EEYBSCbZ/5jKHMuuBNEKOo
 bbk9QOXo9Szz4WwsWAkP2/zkOZS9TIQjf2VAtXpTwfWaWqSjWOYah9239BHvsBhL8gKC
 5+VnWEFP45B8XRpmmwJ3GkxxC5avPJeBY4//XidmKZsHsxb3QUeZYBtxhdeajCt2fHON
 PsYVMbuxNFpwg+ozJXGrCEuDjZwbgFUkImCRzZiW7N+TcxWVaYerZxth9YEWtC7BKKCw
 LSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764103619; x=1764708419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=39vtfy/ykemAPu0lP0oiKmDXg8WxA7OgREWmGs1cs8I=;
 b=IINfbksNUyvwS0KUIe1zjcTJQi8DFT0cwQpg34ky24QUEceXmwUyPk5nXzIxisSKrr
 /Zgx3KdyaP4+S8kMyYzHCWJvzbvdN2+kB0ymL4uaDO3GtmdK31wcNYXIiDoRwb0yoNcn
 zer87P+fNu9xiOzDaF3UI07D/OHBijjTgHa2LdAybWhhh5rO6cy81W05j+fec3dSj9tc
 dX1DBSak/4NafhXSvJSs6D4VJbliYYar5eYK3TFRzacqSqikjRxuGHHEeHm/jNcCjl9D
 S90A3TPYOSiXy0Ecg0ZJatDeHvtDPHdrzScdLorf7t1bC0XuT3XeqWqF7M62ikRn1lkA
 PBwg==
X-Gm-Message-State: AOJu0Ywirk+VeCkXYrW4Sgpc5Za8CDjlqTrxbKVCRh+QLrSdjt3qK3pV
 ZR+dMr4Z8cv1HCOjGLiOUwujqPAMO2+HhLM7Xi0I3Hfhn0aU1eYC6Y9x3IlEnvIswGSI3HMpNMu
 g2OIxnPMA7selRuisnXwrcRJssNcckyujvYVdZ9JdbJWhIKfn3NT7rKWr/4IWsLZuvMPXEQl4YU
 pMQizRda7SYoRHtBcm+iTxZXoLm/vmAIUcM6IZ7g==
X-Gm-Gg: ASbGncvRcJHK9qMb60uzDt8Hb+u8uofRMRXEQChWgftrN5T1uFTJ7Lzd01NNPO+2z0s
 KpdQRWLmZARmqDvyWKEdVs41f7CTTANmblfbmYeYf16KeZ8fIVONQ3aocTqjPLnRFDPrE01gq0V
 fy8qhuR3fuRXVYKznDHDKoxLIYRTUAZY/CiB/yjPi74GqlPjRE43AVHi8FsOEus6EgNFqRdkZrT
 wp4auR6oGhF55s+cVMcc2TD9NHPSClr9UlvNwk5SWtRlZNajBMbprDJlrtIe+J9z9ZC9qg5wZS4
 GayeOEgdwCcYv9+aA8vWANoS8MXH7oKyCMlIWLCv05F7ZTCF3UFC+YJm43BkwAkZb396G9S1zTY
 oifs=
X-Received: by 2002:a05:620a:1a05:b0:8b2:6ac7:aa4f with SMTP id
 af79cd13be357-8b33d49b0aamr2279174585a.68.1764103619113; 
 Tue, 25 Nov 2025 12:46:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE78yl5utIRX9MypFDMOTie9OTsAPgZgtTeGqt4QJ/4TyMxDack1FBshaiWQgAjCP8Zz8O4nA==
X-Received: by 2002:a05:620a:1a05:b0:8b2:6ac7:aa4f with SMTP id
 af79cd13be357-8b33d49b0aamr2279167685a.68.1764103618120; 
 Tue, 25 Nov 2025 12:46:58 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295c2276sm1250794085a.30.2025.11.25.12.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 12:46:57 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH for-11.0 6/6] migration: Replace migrate_set_error() with
 migrate_error_propagate()
Date: Tue, 25 Nov 2025 15:46:48 -0500
Message-ID: <20251125204648.857018-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251125204648.857018-1-peterx@redhat.com>
References: <20251125204648.857018-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

migrate_set_error() currently doesn't take ownership of the error being
passed in.  It's not aligned with the error API and meanwhile it also
makes most of the caller free the error explicitly.

Change the API to take the ownership of the Error object instead.  When at
it, remove the first parameter so it's friendly to g_clear_pointer().  It
can be used whenever the caller wants to provide extra safety measure (or
reuse the pointer) to reset the Error* pointer after stolen.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h            |  2 +-
 migration/cpr-exec.c             |  4 +--
 migration/migration.c            | 46 +++++++++++++++-----------------
 migration/multifd-device-state.c |  5 +---
 migration/multifd.c              | 19 +++++++------
 migration/postcopy-ram.c         |  5 ++--
 migration/ram.c                  |  4 +--
 migration/savevm.c               | 15 ++++-------
 8 files changed, 42 insertions(+), 58 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 213b33fe6e..df74f9b14f 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -525,7 +525,7 @@ void migration_incoming_process(void);
 
 bool  migration_has_all_channels(void);
 
-void migrate_set_error(MigrationState *s, const Error *error);
+void migrate_error_propagate(Error *error);
 bool migrate_has_error(MigrationState *s);
 
 void migration_connect(MigrationState *s, Error *error_in);
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index 0b8344a86f..13e6138f56 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -158,9 +158,7 @@ static void cpr_exec_cb(void *opaque)
 
     error_report_err(error_copy(err));
     migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
-    migrate_set_error(s, err);
-    error_free(err);
-    err = NULL;
+    g_clear_pointer(&err, migrate_error_propagate);
 
     /* Note, we can go from state COMPLETED to FAILED */
     migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
diff --git a/migration/migration.c b/migration/migration.c
index 4fe69cc2ef..219d3129cb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -914,9 +914,7 @@ process_incoming_migration_co(void *opaque)
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
-    migrate_set_error(s, local_err);
-    error_free(local_err);
-
+    migrate_error_propagate(local_err);
     migration_incoming_state_destroy();
 
     if (mis->exit_on_error) {
@@ -1548,14 +1546,22 @@ static void migration_cleanup_bh(void *opaque)
     migration_cleanup(opaque);
 }
 
-void migrate_set_error(MigrationState *s, const Error *error)
+/*
+ * Propagate the Error* object to migration core.  The caller mustn't
+ * reference the error pointer after the function returned, because the
+ * Error* object might be freed.
+ */
+void migrate_error_propagate(Error *error)
 {
-    QEMU_LOCK_GUARD(&s->error_mutex);
+    MigrationState *s = migrate_get_current();
 
+    QEMU_LOCK_GUARD(&s->error_mutex);
     trace_migrate_error(error_get_pretty(error));
 
     if (!s->error) {
-        s->error = error_copy(error);
+        s->error = error;
+    } else {
+        error_free(error);
     }
 }
 
@@ -1601,8 +1607,7 @@ static void migration_connect_set_error(MigrationState *s, Error *error)
     }
 
     migrate_set_state(&s->state, current, next);
-    migrate_set_error(s, error);
-    error_free(error);
+    migrate_error_propagate(error);
 }
 
 void migration_cancel(void)
@@ -2014,8 +2019,7 @@ void qmp_migrate_pause(Error **errp)
 
         /* Tell the core migration that we're pausing */
         error_setg(&error, "Postcopy migration is paused by the user");
-        migrate_set_error(ms, error);
-        error_free(error);
+        migrate_error_propagate(error);
 
         qemu_mutex_lock(&ms->qemu_file_lock);
         if (ms->to_dst_file) {
@@ -2647,8 +2651,7 @@ static void *source_return_path_thread(void *opaque)
 
 out:
     if (err) {
-        migrate_set_error(ms, err);
-        error_free(err);
+        migrate_error_propagate(err);
         trace_source_return_path_thread_bad_end();
     }
 
@@ -3094,12 +3097,10 @@ static void migration_completion(MigrationState *s)
 
 fail:
     if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_error_propagate(local_err);
     } else if (ret) {
         error_setg_errno(&local_err, -ret, "Error in migration completion");
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_error_propagate(local_err);
     }
 
     if (s->state != MIGRATION_STATUS_CANCELLING) {
@@ -3326,8 +3327,7 @@ static MigThrError migration_detect_error(MigrationState *s)
     }
 
     if (local_error) {
-        migrate_set_error(s, local_error);
-        error_free(local_error);
+        migrate_error_propagate(local_error);
     }
 
     if (state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret) {
@@ -3522,7 +3522,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
         if (must_precopy <= s->threshold_size &&
             can_switchover && qatomic_read(&s->start_postcopy)) {
             if (postcopy_start(s, &local_err)) {
-                migrate_set_error(s, local_err);
+                migrate_error_propagate(error_copy(local_err));
                 error_report_err(local_err);
             }
             return MIG_ITERATE_SKIP;
@@ -3819,8 +3819,7 @@ static void *migration_thread(void *opaque)
      * devices to unplug. This to preserve migration state transitions.
      */
     if (ret) {
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_error_propagate(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_FAILED);
         goto out;
@@ -3944,8 +3943,7 @@ static void *bg_migration_thread(void *opaque)
      * devices to unplug. This to preserve migration state transitions.
      */
     if (ret) {
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_error_propagate(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_FAILED);
         goto fail_setup;
@@ -4127,7 +4125,7 @@ void migration_connect(MigrationState *s, Error *error_in)
     return;
 
 fail:
-    migrate_set_error(s, local_err);
+    migrate_error_propagate(error_copy(local_err));
     if (s->state != MIGRATION_STATUS_CANCELLING) {
         migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
     }
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index db3239fef5..3040d70872 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -143,8 +143,6 @@ static int multifd_device_state_save_thread(void *opaque)
     Error *local_err = NULL;
 
     if (!data->hdlr(data, &local_err)) {
-        MigrationState *s = migrate_get_current();
-
         /*
          * Can't call abort_device_state_save_threads() here since new
          * save threads could still be in process of being launched
@@ -158,8 +156,7 @@ static int multifd_device_state_save_thread(void *opaque)
          * In case of multiple save threads failing which thread error
          * return we end setting is purely arbitrary.
          */
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_error_propagate(local_err);
     }
 
     return 0;
diff --git a/migration/multifd.c b/migration/multifd.c
index c861b4b557..99717b64e9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -428,8 +428,9 @@ static void multifd_send_set_error(Error *err)
 
     if (err) {
         MigrationState *s = migrate_get_current();
-        migrate_set_error(s, err);
-        error_free(err);
+
+        migrate_error_propagate(err);
+
         if (s->state == MIGRATION_STATUS_SETUP ||
             s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
             s->state == MIGRATION_STATUS_DEVICE ||
@@ -588,8 +589,7 @@ void multifd_send_shutdown(void)
         Error *local_err = NULL;
 
         if (!multifd_send_cleanup_channel(p, &local_err)) {
-            migrate_set_error(migrate_get_current(), local_err);
-            error_free(local_err);
+            migrate_error_propagate(local_err);
         }
     }
 
@@ -962,8 +962,7 @@ bool multifd_send_setup(void)
         p->write_flags = 0;
 
         if (!multifd_new_send_channel_create(p, &local_err)) {
-            migrate_set_error(s, local_err);
-            error_free(local_err);
+            migrate_error_propagate(local_err);
             ret = -1;
         }
     }
@@ -987,8 +986,7 @@ bool multifd_send_setup(void)
 
         ret = multifd_send_state->ops->send_setup(p, &local_err);
         if (ret) {
-            migrate_set_error(s, local_err);
-            error_free(local_err);
+            migrate_error_propagate(local_err);
             goto err;
         }
         assert(p->iov);
@@ -1067,8 +1065,9 @@ static void multifd_recv_terminate_threads(Error *err)
 
     if (err) {
         MigrationState *s = migrate_get_current();
-        migrate_set_error(s, err);
-        error_free(err);
+
+        migrate_error_propagate(err);
+
         if (s->state == MIGRATION_STATUS_SETUP ||
             s->state == MIGRATION_STATUS_ACTIVE) {
             migrate_set_state(&s->state, s->state,
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 7c9fe61041..856366072a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1927,8 +1927,7 @@ postcopy_preempt_send_channel_done(MigrationState *s,
                                    QIOChannel *ioc, Error *local_err)
 {
     if (local_err) {
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_error_propagate(local_err);
     } else {
         migration_ioc_register_yank(ioc);
         s->postcopy_qemufile_src = qemu_file_new_output(ioc);
@@ -2162,7 +2161,7 @@ static void *postcopy_listen_thread(void *opaque)
              * exit depending on if postcopy-exit-on-error is true, but the
              * migration cannot be recovered.
              */
-            migrate_set_error(migr, local_err);
+            migrate_error_propagate(error_copy(local_err));
             error_report_err(local_err);
             migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
             goto out;
diff --git a/migration/ram.c b/migration/ram.c
index 29f016cb25..1d2a47526e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4730,9 +4730,7 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
          * Abort and indicate a proper reason.
          */
         error_setg(&err, "RAM block '%s' resized during precopy.", rb->idstr);
-        migrate_set_error(migrate_get_current(), err);
-        error_free(err);
-
+        migrate_error_propagate(err);
         migration_cancel();
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 638e9b364f..ab9d1e579e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1125,13 +1125,12 @@ void qemu_savevm_send_open_return_path(QEMUFile *f)
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
 {
     uint32_t tmp;
-    MigrationState *ms = migrate_get_current();
     Error *local_err = NULL;
 
     if (len > MAX_VM_CMD_PACKAGED_SIZE) {
         error_setg(&local_err, "%s: Unreasonably large packaged state: %zu",
                      __func__, len);
-        migrate_set_error(ms, local_err);
+        migrate_error_propagate(error_copy(local_err));
         error_report_err(local_err);
         return -1;
     }
@@ -1373,7 +1372,7 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
         if (se->vmsd && se->vmsd->early_setup) {
             ret = vmstate_save(f, se, vmdesc, errp);
             if (ret) {
-                migrate_set_error(ms, *errp);
+                migrate_error_propagate(error_copy(*errp));
                 qemu_file_set_error(f, ret);
                 break;
             }
@@ -1681,7 +1680,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 
         ret = vmstate_save(f, se, vmdesc, &local_err);
         if (ret) {
-            migrate_set_error(ms, local_err);
+            migrate_error_propagate(error_copy(local_err));
             error_report_err(local_err);
             qemu_file_set_error(f, ret);
             return ret;
@@ -1858,7 +1857,6 @@ void qemu_savevm_live_state(QEMUFile *f)
 
 int qemu_save_device_state(QEMUFile *f)
 {
-    MigrationState *ms = migrate_get_current();
     Error *local_err = NULL;
     SaveStateEntry *se;
 
@@ -1876,7 +1874,7 @@ int qemu_save_device_state(QEMUFile *f)
         }
         ret = vmstate_save(f, se, NULL, &local_err);
         if (ret) {
-            migrate_set_error(ms, local_err);
+            migrate_error_propagate(error_copy(local_err));
             error_report_err(local_err);
             return ret;
         }
@@ -2826,8 +2824,6 @@ static int qemu_loadvm_load_thread(void *thread_opaque)
     Error *local_err = NULL;
 
     if (!data->function(data->opaque, &mis->load_threads_abort, &local_err)) {
-        MigrationState *s = migrate_get_current();
-
         /*
          * Can't set load_threads_abort here since processing of main migration
          * channel data could still be happening, resulting in launching of new
@@ -2840,8 +2836,7 @@ static int qemu_loadvm_load_thread(void *thread_opaque)
          * In case of multiple load threads failing which thread error
          * return we end setting is purely arbitrary.
          */
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_error_propagate(local_err);
     }
 
     return 0;
-- 
2.50.1


