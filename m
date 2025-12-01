Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027D7D116F6
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 19:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ9q1-0000oc-9B; Mon, 01 Dec 2025 14:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9px-0000nQ-Oq
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9pv-0005IN-8x
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764618326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RoDaNpM4TafGzT5nSjPHRGmwylMI4NGchjvtmGIjALo=;
 b=CjA5/2U6rBY7VxvA1qU0LwiFuzoxdXicurdbsUmY5ezf/Q2LCvjGqtvnMJ/GiATDC5SIN+
 6ciFqZNB8PlCQmp7Uz7hU60wh5AnpgzUKOt+3qSMkc2ZgPP2gFGrOh1la8epvWrjCk3eJR
 7XDEh0nqGYgT8CDWmy9ZAS9p39VsNm8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-cgKhyUFlMpipJXbRT37uWQ-1; Mon, 01 Dec 2025 14:45:25 -0500
X-MC-Unique: cgKhyUFlMpipJXbRT37uWQ-1
X-Mimecast-MFC-AGG-ID: cgKhyUFlMpipJXbRT37uWQ_1764618325
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ed82af96faso89733761cf.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 11:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764618324; x=1765223124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RoDaNpM4TafGzT5nSjPHRGmwylMI4NGchjvtmGIjALo=;
 b=I984VwgTS2L7kmAlXMdbTCY3wSxvoyy/f81wiitwDgvuoSQb2F6YS11jIUHm4Kx9y9
 KcsSSzK2t8QmCqU3npaRTZ48esw4o6sV8B3ED5hHIITlUlOqUeU0d7iaQdvTtM1BLhqy
 AIb7HP5UfhLyiWslEKvxJuBkSpjzo5R5pKMscvuzaFeHId5tp+Vbtav1UHquebiyaYAq
 utik7cEL2wNdRu0OJecd+8sNpf4GxiQX4VKSf92jmFDWTqqWTKHxuHEsobJIeXqVN38t
 5FPER8tFkeyO4BFYPzXeOzffcduvGQMjtZAftT/oROUI7JF5KL8yfqzicgpS8kDV/M7n
 bTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764618324; x=1765223124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RoDaNpM4TafGzT5nSjPHRGmwylMI4NGchjvtmGIjALo=;
 b=pbr+gE1zewa1go2/+FCeVEuKmIIT7vZqkgOrxZvU9eFL/0WzFF8eZBxPG3lA8VpQlM
 4qj2oFxNdxVGr+gjUF+HlRNCMjLp4JTh1B3B2AXIJdjmg8JjjHFcBgtDShNAgV1mC5Vh
 Dhz2fq2hRkN0pcx4dY15/JHanqs90Z4gHHYOZ2hiI4i5ln3rWl1J3PAd8IYPZbTG2Ji5
 I+9RuQarvXfaXZDOxwY0XPRfeYjUiwT9qCLmiZeqLva7E/cMhd65czjxmGd/udA7cGrc
 Q2V2/QzUfBxDe0Ycfzdg4BrsBxr1vXCgC1ZaDlRezUdlfm9Eyd1Qz6JNOreNxHBvuNXi
 3b8Q==
X-Gm-Message-State: AOJu0YwZfoDznk7iUl0iHMKK2wGOCjG5CUYZwF26Tpifv9N5LiAe7W4E
 0BCVYdzAAaU850fbBuMEwUPCYwe7FOkscLkcYiM5tHbxjU4ExFXLIqxIPlgayHMr2hKyWxPH9Eg
 APj9yWIloFiDIQbfihMultdu6vKsHIX0aSEgfglDSqIiTrO6H/z4Y/gg9NQaxu9ei1PyMVWI+Ge
 bwbvqPQmWvEtbR+bZuMWKU1pk8zyKXKgALECOC8A==
X-Gm-Gg: ASbGncsw65g8McWR9z4fG3rdXA1kBfXSLITM4aDUNZSweItkdwlWme7MREuI4r6Ous5
 VlcKlBu9n4JJf0vWN8XbaxB62PzRAOioy3k9O21grLJ6Www+xQ5j6OAt9MShqhVh2sXaa1FgIen
 B09/Q4VXkEsE+k56TIIXBh4rrR73gcxH1lvZAm4bIRr8+27xtdE5AM9E/t9nGqh/rQ9bUlP+Eh0
 RAIHXsyoYRRuPQaMIKCTryI16JDNB4W3Tmr+PT9c/zdbemIIjYe7PYqF+HBklD9NbEgu1oS3/ij
 99sAUYI0mqFQ6BFOhOemQE/pUrF3mH0osR3IhGI1DFOUb/KNlCLG7oS/tKDn9xs7w4OkD+YFOad
 x
X-Received: by 2002:a05:622a:5ca:b0:4ee:18eb:feb6 with SMTP id
 d75a77b69052e-4ee58a44091mr540362551cf.11.1764618324190; 
 Mon, 01 Dec 2025 11:45:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJnGQzm9H4rtAPPumNah8aBbBfYbPL5L6WcP4/tPmV6D9VWEpUs3nljqJslQH2zEyF2zl7MA==
X-Received: by 2002:a05:622a:5ca:b0:4ee:18eb:feb6 with SMTP id
 d75a77b69052e-4ee58a44091mr540361301cf.11.1764618323418; 
 Mon, 01 Dec 2025 11:45:23 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b91ba3sm88835156d6.53.2025.12.01.11.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 11:45:23 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH for-11.0 v2 7/7] migration: Replace migrate_set_error() with
 migrate_error_propagate()
Date: Mon,  1 Dec 2025 14:45:10 -0500
Message-ID: <20251201194510.1121221-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201194510.1121221-1-peterx@redhat.com>
References: <20251201194510.1121221-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Change the API to take the ownership of the Error object instead.  This
should save a lot of error_copy() invocations.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h            |  2 +-
 migration/cpr-exec.c             |  5 ++--
 migration/migration.c            | 44 +++++++++++++++-----------------
 migration/multifd-device-state.c |  5 +---
 migration/multifd.c              | 19 +++++++-------
 migration/postcopy-ram.c         |  5 ++--
 migration/ram.c                  |  4 +--
 migration/savevm.c               | 16 +++++-------
 8 files changed, 43 insertions(+), 57 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 213b33fe6e..e4b4f25deb 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -525,7 +525,7 @@ void migration_incoming_process(void);
 
 bool  migration_has_all_channels(void);
 
-void migrate_set_error(MigrationState *s, const Error *error);
+void migrate_error_propagate(MigrationState *s, Error *error);
 bool migrate_has_error(MigrationState *s);
 
 void migration_connect(MigrationState *s, Error *error_in);
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index 0b8344a86f..da287d8031 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -158,8 +158,9 @@ static void cpr_exec_cb(void *opaque)
 
     error_report_err(error_copy(err));
     migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
-    migrate_set_error(s, err);
-    error_free(err);
+
+    migrate_error_propagate(s, err);
+    /* We must reset the error because it'll be reused later */
     err = NULL;
 
     /* Note, we can go from state COMPLETED to FAILED */
diff --git a/migration/migration.c b/migration/migration.c
index 0ff8b31a88..70813e5006 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -914,9 +914,7 @@ process_incoming_migration_co(void *opaque)
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
-    migrate_set_error(s, local_err);
-    error_free(local_err);
-
+    migrate_error_propagate(s, local_err);
     migration_incoming_state_destroy();
 
     if (mis->exit_on_error) {
@@ -1548,14 +1546,20 @@ static void migration_cleanup_bh(void *opaque)
     migration_cleanup(opaque);
 }
 
-void migrate_set_error(MigrationState *s, const Error *error)
+/*
+ * Propagate the Error* object to migration core.  The caller mustn't
+ * reference the error pointer after the function returned, because the
+ * Error* object might be freed.
+ */
+void migrate_error_propagate(MigrationState *s, Error *error)
 {
     QEMU_LOCK_GUARD(&s->error_mutex);
-
     trace_migrate_error(error_get_pretty(error));
 
     if (!s->error) {
-        s->error = error_copy(error);
+        s->error = error;
+    } else {
+        error_free(error);
     }
 }
 
@@ -1601,8 +1605,7 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
     }
 
     migrate_set_state(&s->state, current, next);
-    migrate_set_error(s, error);
-    error_free(error);
+    migrate_error_propagate(s, error);
 }
 
 void migration_cancel(void)
@@ -2014,8 +2017,7 @@ void qmp_migrate_pause(Error **errp)
 
         /* Tell the core migration that we're pausing */
         error_setg(&error, "Postcopy migration is paused by the user");
-        migrate_set_error(ms, error);
-        error_free(error);
+        migrate_error_propagate(ms, error);
 
         qemu_mutex_lock(&ms->qemu_file_lock);
         if (ms->to_dst_file) {
@@ -2647,8 +2649,7 @@ static void *source_return_path_thread(void *opaque)
 
 out:
     if (err) {
-        migrate_set_error(ms, err);
-        error_free(err);
+        migrate_error_propagate(ms, err);
         trace_source_return_path_thread_bad_end();
     }
 
@@ -3094,12 +3095,10 @@ static void migration_completion(MigrationState *s)
 
 fail:
     if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_error_propagate(s, local_err);
     } else if (ret) {
         error_setg_errno(&local_err, -ret, "Error in migration completion");
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_error_propagate(s, local_err);
     }
 
     if (s->state != MIGRATION_STATUS_CANCELLING) {
@@ -3326,8 +3325,7 @@ static MigThrError migration_detect_error(MigrationState *s)
     }
 
     if (local_error) {
-        migrate_set_error(s, local_error);
-        error_free(local_error);
+        migrate_error_propagate(s, local_error);
     }
 
     if (state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret) {
@@ -3522,7 +3520,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
         if (must_precopy <= s->threshold_size &&
             can_switchover && qatomic_read(&s->start_postcopy)) {
             if (postcopy_start(s, &local_err)) {
-                migrate_set_error(s, local_err);
+                migrate_error_propagate(s, error_copy(local_err));
                 error_report_err(local_err);
             }
             return MIG_ITERATE_SKIP;
@@ -3819,8 +3817,7 @@ static void *migration_thread(void *opaque)
      * devices to unplug. This to preserve migration state transitions.
      */
     if (ret) {
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_error_propagate(s, local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_FAILED);
         goto out;
@@ -3944,8 +3941,7 @@ static void *bg_migration_thread(void *opaque)
      * devices to unplug. This to preserve migration state transitions.
      */
     if (ret) {
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_error_propagate(s, local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_FAILED);
         goto fail_setup;
@@ -4127,7 +4123,7 @@ void migration_connect(MigrationState *s, Error *error_in)
     return;
 
 fail:
-    migrate_set_error(s, local_err);
+    migrate_error_propagate(s, error_copy(local_err));
     if (s->state != MIGRATION_STATUS_CANCELLING) {
         migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
     }
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index db3239fef5..91d5d81556 100644
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
+        migrate_error_propagate(migrate_get_current(), local_err);
     }
 
     return 0;
diff --git a/migration/multifd.c b/migration/multifd.c
index 52e4d25857..bf6da85af8 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -428,8 +428,9 @@ static void multifd_send_error_propagate(Error *err)
 
     if (err) {
         MigrationState *s = migrate_get_current();
-        migrate_set_error(s, err);
-        error_free(err);
+
+        migrate_error_propagate(s, err);
+
         if (s->state == MIGRATION_STATUS_SETUP ||
             s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
             s->state == MIGRATION_STATUS_DEVICE ||
@@ -588,8 +589,7 @@ void multifd_send_shutdown(void)
         Error *local_err = NULL;
 
         if (!multifd_send_cleanup_channel(p, &local_err)) {
-            migrate_set_error(migrate_get_current(), local_err);
-            error_free(local_err);
+            migrate_error_propagate(migrate_get_current(), local_err);
         }
     }
 
@@ -962,8 +962,7 @@ bool multifd_send_setup(void)
         p->write_flags = 0;
 
         if (!multifd_new_send_channel_create(p, &local_err)) {
-            migrate_set_error(s, local_err);
-            error_free(local_err);
+            migrate_error_propagate(s, local_err);
             ret = -1;
         }
     }
@@ -987,8 +986,7 @@ bool multifd_send_setup(void)
 
         ret = multifd_send_state->ops->send_setup(p, &local_err);
         if (ret) {
-            migrate_set_error(s, local_err);
-            error_free(local_err);
+            migrate_error_propagate(s, local_err);
             goto err;
         }
         assert(p->iov);
@@ -1067,8 +1065,9 @@ static void multifd_recv_terminate_threads(Error *err)
 
     if (err) {
         MigrationState *s = migrate_get_current();
-        migrate_set_error(s, err);
-        error_free(err);
+
+        migrate_error_propagate(s, err);
+
         if (s->state == MIGRATION_STATUS_SETUP ||
             s->state == MIGRATION_STATUS_ACTIVE) {
             migrate_set_state(&s->state, s->state,
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 7c9fe61041..dd8e31f5ae 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1927,8 +1927,7 @@ postcopy_preempt_send_channel_done(MigrationState *s,
                                    QIOChannel *ioc, Error *local_err)
 {
     if (local_err) {
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_error_propagate(s, local_err);
     } else {
         migration_ioc_register_yank(ioc);
         s->postcopy_qemufile_src = qemu_file_new_output(ioc);
@@ -2162,7 +2161,7 @@ static void *postcopy_listen_thread(void *opaque)
              * exit depending on if postcopy-exit-on-error is true, but the
              * migration cannot be recovered.
              */
-            migrate_set_error(migr, local_err);
+            migrate_error_propagate(migr, error_copy(local_err));
             error_report_err(local_err);
             migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
             goto out;
diff --git a/migration/ram.c b/migration/ram.c
index 29f016cb25..a2f456d858 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4730,9 +4730,7 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
          * Abort and indicate a proper reason.
          */
         error_setg(&err, "RAM block '%s' resized during precopy.", rb->idstr);
-        migrate_set_error(migrate_get_current(), err);
-        error_free(err);
-
+        migrate_error_propagate(migrate_get_current(), err);
         migration_cancel();
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 638e9b364f..67f10a5dbe 100644
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
+        migrate_error_propagate(migrate_get_current(), error_copy(local_err));
         error_report_err(local_err);
         return -1;
     }
@@ -1373,7 +1372,7 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
         if (se->vmsd && se->vmsd->early_setup) {
             ret = vmstate_save(f, se, vmdesc, errp);
             if (ret) {
-                migrate_set_error(ms, *errp);
+                migrate_error_propagate(ms, error_copy(*errp));
                 qemu_file_set_error(f, ret);
                 break;
             }
@@ -1681,7 +1680,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 
         ret = vmstate_save(f, se, vmdesc, &local_err);
         if (ret) {
-            migrate_set_error(ms, local_err);
+            migrate_error_propagate(ms, error_copy(local_err));
             error_report_err(local_err);
             qemu_file_set_error(f, ret);
             return ret;
@@ -1858,7 +1857,6 @@ void qemu_savevm_live_state(QEMUFile *f)
 
 int qemu_save_device_state(QEMUFile *f)
 {
-    MigrationState *ms = migrate_get_current();
     Error *local_err = NULL;
     SaveStateEntry *se;
 
@@ -1876,7 +1874,8 @@ int qemu_save_device_state(QEMUFile *f)
         }
         ret = vmstate_save(f, se, NULL, &local_err);
         if (ret) {
-            migrate_set_error(ms, local_err);
+            migrate_error_propagate(migrate_get_current(),
+                                    error_copy(local_err));
             error_report_err(local_err);
             return ret;
         }
@@ -2826,8 +2825,6 @@ static int qemu_loadvm_load_thread(void *thread_opaque)
     Error *local_err = NULL;
 
     if (!data->function(data->opaque, &mis->load_threads_abort, &local_err)) {
-        MigrationState *s = migrate_get_current();
-
         /*
          * Can't set load_threads_abort here since processing of main migration
          * channel data could still be happening, resulting in launching of new
@@ -2840,8 +2837,7 @@ static int qemu_loadvm_load_thread(void *thread_opaque)
          * In case of multiple load threads failing which thread error
          * return we end setting is purely arbitrary.
          */
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_error_propagate(migrate_get_current(), local_err);
     }
 
     return 0;
-- 
2.50.1


