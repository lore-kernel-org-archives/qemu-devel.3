Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D980CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNby-0006nx-FN; Sat, 30 Aug 2025 11:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5KQ-0005BH-FF
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5KN-0004fN-Sh
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756497842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hzdNOf8zzxvjomLYvsuCU0Lt7DcL5gQpQtfllQdQY4w=;
 b=Le1dup9jwX9MboCmSdf7cgzfZcEVu7rIQK5EUrR9vw16K1ZNBtKjQrnGY2ITnAEMUK9KKW
 M9HQ8z9D2z1wOdNY1IvYDA0LzEECIJVBmLyzHWWReB+jhdyYqnAZdG7JonVV4rZawymSOH
 Jm8e/qqbaL8lBgwp447t27z/8Wp9k54=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-THAkC7D2M-yCeyJcHqDU-g-1; Fri, 29 Aug 2025 16:04:01 -0400
X-MC-Unique: THAkC7D2M-yCeyJcHqDU-g-1
X-Mimecast-MFC-AGG-ID: THAkC7D2M-yCeyJcHqDU-g_1756497840
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2445803f0cfso32546995ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756497840; x=1757102640;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzdNOf8zzxvjomLYvsuCU0Lt7DcL5gQpQtfllQdQY4w=;
 b=okCIJHlBhoFMAQpCnIWziwGBeHBbW5iSPPmpQ22tDJ3OREhNA9MmJiyArWXmH0cwgt
 TJjbKi2ino9pjywNZtgoNGFfMBcz73xdSuVwqow44DFG7EsyWmPuyoKBdW2T9r1HXD3K
 eaDPO1HDP5QCsJiraBblpPIoiTP7Djc5UotakYAGsKZsmBBwPNsTH7fTvEBMCPQHGwHF
 HLj6CM/mEah79HQH4KxCqr99HkN7m8+0R4B2o6MwltDBgY2TaHqsyCIjR07kFdLBEKZX
 GzY3uTbWX8Ez5gtBZXXwkGkXMXUxLdIOiC0DtOp5luHH3Nu9MZ5xvA/u6PjwIuVVVw13
 3rDw==
X-Gm-Message-State: AOJu0YwD4fjWN4wpYWxe9SXepR0RVLAC9gmUmK4afHEztYJb951spc0O
 5TqZlAwwSfzi0F+1mydTZyGcsx1c1OcRsYDSTARZ2nsoAQj029quYfz5p8N+r/sY5GroZGnmBcx
 u/NKQ5Fv0vY7iks2pEmNNanjcqjoFlAdZpiyeS9ecC8Vm7bZpXuIuKMXt
X-Gm-Gg: ASbGnctDeRgGNqmkQUtvf9tnIGyXlUnL0QAIDYU9UOKLgIH/XeBZzh7PUuQ+TvqMaB0
 VIDzJRzmVWEOxDydntIw/f5WisY1znjcGKqx5hShB9Go9cSbLv8l4hw6xz+8C38OVOy+Jlhyjqt
 L25eOt5MRXB5yVO3/UtwIHl3MRiC54rq6C5WrahzVaDtlNvKFKOJvlsBqme7qlzIuQLqhyyrzBs
 bS66RJYqx0IAaBxmHRmzrGcEhpkjFT3R7p/iV22JuRmVGrJ9VG9LLqHp+cqGQ7/2ZLGqg56fnM1
 ORQ0idmIeFp/1SLWSTPRpVRYS6iJy8WriLNhDiQa6t3+hW4MWIUBKA==
X-Received: by 2002:a17:903:1a08:b0:246:a8ad:3f24 with SMTP id
 d9443c01a7336-246a8ad4130mr289475855ad.7.1756497840289; 
 Fri, 29 Aug 2025 13:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIdBfEhqde6egTrP85UhZ19uWsBqeHUQq0a7BHCgN9dqKu1f+7ga0vRMZV5fg0G3pUMM0ESw==
X-Received: by 2002:a17:903:1a08:b0:246:a8ad:3f24 with SMTP id
 d9443c01a7336-246a8ad4130mr289475045ad.7.1756497839716; 
 Fri, 29 Aug 2025 13:03:59 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:03:59 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:31:47 +0530
Subject: [PATCH v13 07/27] migration: push Error **errp into
 qemu_loadvm_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250830-propagate_tpm_error-v13-7-a4e777b7eb2c@redhat.com>
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
In-Reply-To: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6212; i=armenon@redhat.com;
 h=from:subject:message-id; bh=dyNvSpvRJq2Ak2gyyk/K9PCSOAs1pmbL+bOe9B+V1/g=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdh/f3xmF6+9lfXMqid/+9lL0o5DCafzOL5bopVnez
 vleW6zSUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCKfTjH8D5mxsuYId9m7nBlW
 WSGCBhmeu3x8DnT1LnXO3n3vtQHHckaGCeaTskXMzx6PONweUOA08ZTwvGXfRNkX6rGoijsfm3S
 HBwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that qemu_loadvm_state() must report an error
in errp, in case of failure.

When postcopy live migration runs, the device states are loaded by
both the qemu coroutine process_incoming_migration_co() and the
postcopy_ram_listen_thread(). Therefore, it is important that the
coroutine also reports the error in case of failure, with
error_report_err(). Otherwise, the source qemu will not display
any errors before going into the postcopy pause state.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/migration.c |  9 +++++----
 migration/savevm.c    | 30 ++++++++++++++++++------------
 migration/savevm.h    |  2 +-
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25dec01f206eacad2edd24d21f00e614c..c6768d88f45c870c7fad9b9957300766ff69effc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -881,7 +881,7 @@ process_incoming_migration_co(void *opaque)
                       MIGRATION_STATUS_ACTIVE);
 
     mis->loadvm_co = qemu_coroutine_self();
-    ret = qemu_loadvm_state(mis->from_src_file);
+    ret = qemu_loadvm_state(mis->from_src_file, &local_err);
     mis->loadvm_co = NULL;
 
     trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
@@ -908,7 +908,8 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
-        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
+        error_prepend(&local_err, "load of migration failed: %s: ",
+                      strerror(-ret));
         goto fail;
     }
 
@@ -924,13 +925,13 @@ fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
     migrate_set_error(s, local_err);
-    error_free(local_err);
+    error_report_err(local_err);
 
     migration_incoming_state_destroy();
 
     if (mis->exit_on_error) {
         WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
-            error_report_err(s->error);
+            error_free(s->error);
             s->error = NULL;
         }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index de5671ffd1cd06e728227a3056c3f895d3a6e6f3..0087fca15ce108685667d3808350d80d37b807b1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3159,28 +3159,24 @@ out:
     return ret;
 }
 
-int qemu_loadvm_state(QEMUFile *f)
+int qemu_loadvm_state(QEMUFile *f, Error **errp)
 {
     MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
-    Error *local_err = NULL;
     int ret;
 
-    if (qemu_savevm_state_blocked(&local_err)) {
-        error_report_err(local_err);
+    if (qemu_savevm_state_blocked(errp)) {
         return -EINVAL;
     }
 
     qemu_loadvm_thread_pool_create(mis);
 
-    ret = qemu_loadvm_state_header(f, &local_err);
+    ret = qemu_loadvm_state_header(f, errp);
     if (ret) {
-        error_report_err(local_err);
         return ret;
     }
 
-    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
-        error_report_err(local_err);
+    if (qemu_loadvm_state_setup(f, errp) != 0) {
         return -EINVAL;
     }
 
@@ -3191,6 +3187,9 @@ int qemu_loadvm_state(QEMUFile *f)
     cpu_synchronize_all_pre_loadvm();
 
     ret = qemu_loadvm_state_main(f, mis);
+    if (ret < 0) {
+        error_setg(errp, "Load VM state failed: %d", ret);
+    }
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3208,8 +3207,15 @@ int qemu_loadvm_state(QEMUFile *f)
         if (migrate_has_error(migrate_get_current()) ||
             !qemu_loadvm_thread_pool_wait(s, mis)) {
             ret = -EINVAL;
+            error_setg(errp,
+                       "Error while loading vmstate");
         } else {
             ret = qemu_file_get_error(f);
+            if (ret < 0) {
+                error_setg(errp,
+                           "Error while loading vmstate: stream error: %d",
+                           ret);
+            }
         }
     }
     /*
@@ -3474,6 +3480,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
 
 void qmp_xen_load_devices_state(const char *filename, Error **errp)
 {
+    ERRP_GUARD();
     QEMUFile *f;
     QIOChannelFile *ioc;
     int ret;
@@ -3495,10 +3502,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     f = qemu_file_new_input(QIO_CHANNEL(ioc));
     object_unref(OBJECT(ioc));
 
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, errp);
     qemu_fclose(f);
     if (ret < 0) {
-        error_setg(errp, "loading Xen device state failed");
+        error_prepend(errp, "loading Xen device state failed: ");
     }
     migration_incoming_state_destroy();
 }
@@ -3569,13 +3576,12 @@ bool load_snapshot(const char *name, const char *vmstate,
         ret = -EINVAL;
         goto err_drain;
     }
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, errp);
     migration_incoming_state_destroy();
 
     bdrv_drain_all_end();
 
     if (ret < 0) {
-        error_setg(errp, "Error %d while loading VM state", ret);
         return false;
     }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index 2d5e9c716686f06720325e82fe90c75335ced1de..b80770b7461a60e2ad6ba5e24a7baeae73d90955 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,7 +64,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
 void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
 
-int qemu_loadvm_state(QEMUFile *f);
+int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);

-- 
2.51.0


