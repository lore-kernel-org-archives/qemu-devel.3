Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AFAC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHM8-0000mI-4w; Fri, 08 Aug 2025 03:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHKW-0006NO-5N
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHKN-0007Ey-Hm
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=776aUuNNXpBQ/gxLXLFuR/W2j/u8IsZh9hr0NLkKlGo=;
 b=bBjxfLi/z8ubTiO62pCIDRQjr5LPjtiIP3x8SGReK9DTZpIBG4F9HA4GVMB5nybgNe0nhQ
 P8n4hvw0CSPlFq+3OeWT9M31t+RqMUaPwFpRxLE929+p8cCwOzMNHgYpDw+6EsyYOae2Vl
 iLw3N5t1fdmazIynAT7tIRnGUfnfrKY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-G34YodxwO9mCXkUA5tWyOQ-1; Fri, 08 Aug 2025 03:15:44 -0400
X-MC-Unique: G34YodxwO9mCXkUA5tWyOQ-1
X-Mimecast-MFC-AGG-ID: G34YodxwO9mCXkUA5tWyOQ_1754637343
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23fe26e5a33so27458305ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637343; x=1755242143;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=776aUuNNXpBQ/gxLXLFuR/W2j/u8IsZh9hr0NLkKlGo=;
 b=ZZeVs9uMj7/uqGI7QeW7TjAEkUKtyAqzxTdRxjNJ9mX8+KCfAfrY1Pd3k0Q5HVdOKc
 Aj5KLDQElJb0qJgpJjaM74U3a06WsD4mjyQW6fUVcXmFvTyJIe1pIsxUhHz+EmyBpUKi
 JWWdVJqFkz5gZwCs+ApydKvvqcPiQrB7G5PzOjAhmymPzoO8bdRQf6lixx4gSlnBT/dl
 6ZHcrG3ObWz7br1k8dTQrbuqY8PSUK45GaFLLn4VnKhSKdI91UDDXQzj6KGTYyHACGXn
 IlNXsjQtmCWjCyBaRri0xE8i09A+nELFsYKrzq8sQnT9GFz3dwbeRjLU6XEMnSmrFhnS
 NJ3A==
X-Gm-Message-State: AOJu0Ywu/cwb6EmPG6gm2/Pcn35Aj9Yra4QtzLoUMhwtLXuIiDkKpHAB
 CEwXKWYGliq4sVBufSzXAuC1cMTHogHpiayChW/FhAZtpydz8Y2ImdGG8VB2RQkOqNCwAq7wCes
 dxiCHbxh61E065/NkEQmoDsHVmrU/kqTYF5DWRlAlls1PXhhaLuOWZRmC
X-Gm-Gg: ASbGncuY2XiqIobwBCiUTXKn/n1VjY0iUKtGbYGqmVFb+JuTHW+0aAt/OXz8JuKQQeA
 DrItJgE8QGd7GhqsvCLMqI8aIztSa2rO3dK1jqzpz/O4/86WP10GKcUONcQLrDeHPWxZUsqG8C+
 N3/PodK/ryO0r8tr2+PtzSUycNgko5xhhcAkX8peaR+GYKg+ybUbvwXdPvBwIQvoJzi7tUDN6jJ
 YWdRNwqg6DobG7knIZLUERWgvt44yvRkYbACZ8qkb1p/UnVpFqw7fCnSrv4N3TqLO2xvFyF6kSd
 oLXcxLyM699KHrOgalLIVMe2k5hL+PfwFg81xB5hSS9qUR5h3YmlXg==
X-Received: by 2002:a17:903:3bad:b0:234:b743:c7a4 with SMTP id
 d9443c01a7336-242c22c3c1emr29484025ad.38.1754637342942; 
 Fri, 08 Aug 2025 00:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtROQHALO00noWzKJjHS/LKQSLED4y931ir4T3rd7QyJpv/BFkqbu4i3ouUvrUo4mDBnfI3w==
X-Received: by 2002:a17:903:3bad:b0:234:b743:c7a4 with SMTP id
 d9443c01a7336-242c22c3c1emr29483815ad.38.1754637342523; 
 Fri, 08 Aug 2025 00:15:42 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:15:42 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:33 +0530
Subject: [PATCH v10 07/27] migration: push Error **errp into
 qemu_loadvm_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-7-3e81a1d419b2@redhat.com>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
In-Reply-To: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6555; i=armenon@redhat.com;
 h=from:subject:message-id; bh=2BpcOKMH/FVFxTwW0YF1zv6MRi3jFfGw2z/tzd0HdX8=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxVdUjgvuWKom7/zz+oujE1PlvD3vTL38UXjpnW+GC
 am/XywQ6ShlYRDjYpAVU2Rp+Bog2xRQGBFp+/I6zBxWJpAhDFycAjARaxuGf/o2LvoFzvvvuoTl
 GCzcwnYt9NtPecG4SUuMjymWnqzw2cLwV+qPwPJKJdPAe7vWlDz7GnjY4iH/48TPvUfOVUa0FLt
 JcAMA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/migration.c |  9 +++++----
 migration/savevm.c    | 31 +++++++++++++++++++------------
 migration/savevm.h    |  2 +-
 3 files changed, 25 insertions(+), 17 deletions(-)

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
index adc4ca16ebc8deb4efe49ac2088cc20aaf795056..8c107fb5b89dea4d1b9a27466247c5d7c6b63bec 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3151,28 +3151,24 @@ out:
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
 
@@ -3183,6 +3179,9 @@ int qemu_loadvm_state(QEMUFile *f)
     cpu_synchronize_all_pre_loadvm();
 
     ret = qemu_loadvm_state_main(f, mis);
+    if (ret < 0) {
+        error_setg(errp, "Load VM state failed: %d", ret);
+    }
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3200,8 +3199,14 @@ int qemu_loadvm_state(QEMUFile *f)
         if (migrate_has_error(migrate_get_current()) ||
             !qemu_loadvm_thread_pool_wait(s, mis)) {
             ret = -EINVAL;
+            error_setg(errp,
+                       "Error while loading VM state: "
+                       "Migration stream has error");
         } else {
             ret = qemu_file_get_error(f);
+            if (ret < 0) {
+                error_setg(errp, "Error while loading vmstate : %d", ret);
+            }
         }
     }
     /*
@@ -3466,6 +3471,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
 
 void qmp_xen_load_devices_state(const char *filename, Error **errp)
 {
+    ERRP_GUARD();
     QEMUFile *f;
     QIOChannelFile *ioc;
     int ret;
@@ -3487,10 +3493,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
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
@@ -3498,6 +3504,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
 bool load_snapshot(const char *name, const char *vmstate,
                    bool has_devices, strList *devices, Error **errp)
 {
+    ERRP_GUARD();
     BlockDriverState *bs_vm_state;
     QEMUSnapshotInfo sn;
     QEMUFile *f;
@@ -3561,13 +3568,13 @@ bool load_snapshot(const char *name, const char *vmstate,
         ret = -EINVAL;
         goto err_drain;
     }
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, errp);
     migration_incoming_state_destroy();
 
     bdrv_drain_all_end();
 
     if (ret < 0) {
-        error_setg(errp, "Error %d while loading VM state", ret);
+        error_prepend(errp, "Error %d while loading VM state: ", ret);
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
2.50.1


