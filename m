Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6843CCA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0xE-0004p7-Is; Thu, 21 Aug 2025 04:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0vr-00032B-FX
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0vl-000159-Cj
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755765953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ihk6l9pkQDnhZzHNM0n+KZNjEFke5EPI+S18lkDPtBE=;
 b=dUJ0bPwQ5NbnO4sirDd9HAfOq/FPu4qp7GyG6oi9LsaIDOGMWC08P5sLv3yYAjiDWPbQII
 0+bqTgW8d9XtSssIKC+a9BZ3uI97zQYL6PtjZCUd3QaTcFzvJJPtf2I24E83P+9HAzCODt
 dbOFMwOW8XyKId28WuD7LB25sWvv6u4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-28foPqeEO5GKRi34tILkCQ-1; Thu, 21 Aug 2025 04:45:52 -0400
X-MC-Unique: 28foPqeEO5GKRi34tILkCQ-1
X-Mimecast-MFC-AGG-ID: 28foPqeEO5GKRi34tILkCQ_1755765951
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-24458345f5dso9343305ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755765951; x=1756370751;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ihk6l9pkQDnhZzHNM0n+KZNjEFke5EPI+S18lkDPtBE=;
 b=geq0/4l30l0dP6ji7jT3RiDiV+u93/8Kf9JBk0n0/XyjiuYxMJJlwHgSDgLIANFP0y
 qUfOb8e4Zs43SqnWxQ8PuCUKpBhHfs7/POwGHMhUxy2PloLbg6ZcKJNGy+hWXnrfLt/C
 M9TjYMkpbIFkPUlD6ErhceRk2Ly0Jt9hiso6cYueSjB7w4eu6Dyplcy6MomqO1+Ta62L
 1bRivnlfDzKN23ln/jUxtrHFvi5wzmWP1uv3RBf2H/+2uzpHZDbEZ3Pf+V9F8bWsdeMG
 Hh+6Rd2TiaSZL2jyvTiK0LrzW9gE0iigItjuVGRYBwXQZZwUyc11g/YQAEmsJZ0B7m5U
 cn7Q==
X-Gm-Message-State: AOJu0Yx3kup8R2W+Kc2xCdDU3+kwspDbVoSFa18OkDcPN1k8wK9P4dz5
 sOVU9/+K+qg9W1qk8jPCqqYoVIBOdmc1kBPyHCAODOwfE5aX5Vv+O40dq2C7Rm8QIddyB5jlfr1
 /bCO1uqUKM4AuRJ+c646FmtX3hWWoOo1Lj+MoHb9fOkyJSOpv7q/L9hYN
X-Gm-Gg: ASbGncuTPe/e902EHnsAWnjrf1knPlJtkarWms4h+lbpuVuwLihy1rGj16it0upz019
 J9TNFksPQcFVFdzMPeEAUwyItFxClE8f16x6hkh6A+0m3pucnAM/9uG+E5+RGDVFkrGKzPfEmi4
 h0+T1vClbggDvzD61nNLl1Jl9ZmUZfql+mVzbEOtHN5KdNrAS5Bv5MjlOHr1qSY6dXKgmITHx2W
 WQF7ZN4ZUBJfvNARo0vEVrmQKDzBlvIvcjT0tfJPn4m9dLRnNkl+Ikh+/OmsQc653f55OdkjYce
 wxsdR+bp6CRU8PyJ0vXPNMankWHghPhyFtjdd4Sc4F4KlNvOtF0f
X-Received: by 2002:a17:903:2f0c:b0:240:a53:dd37 with SMTP id
 d9443c01a7336-245febff389mr23659085ad.21.1755765951167; 
 Thu, 21 Aug 2025 01:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaLZWBQB1w092XmkT9ahW3rNYHnJjovPCV+qye6bZNZXd0Dsshe+JAzoxEp9TVrTX50HJxYA==
X-Received: by 2002:a17:903:2f0c:b0:240:a53:dd37 with SMTP id
 d9443c01a7336-245febff389mr23658465ad.21.1755765950353; 
 Thu, 21 Aug 2025 01:45:50 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:45:49 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:14:01 +0530
Subject: [PATCH v12 07/27] migration: push Error **errp into
 qemu_loadvm_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-7-72b803e707dc@redhat.com>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
In-Reply-To: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6166; i=armenon@redhat.com;
 h=from:subject:message-id; bh=2GPGf4Sq7y6kiBRdOroq30uHxsa4iqqhvb39fHUhlZ4=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayO8mtBXnvnthdnuWoOp91wk+JeczfTzw4k3Jp8fat0
 T59EkviOkpZGMS4GGTFFFkavgbINgUURkTavrwOM4eVCWQIAxenAExk9WNGhonfJocoOrJ8LV0c
 W/Gm8eTuJ4G3P2+cp89UEvvfw4ZT9AIjQ1fxiyKdxNVdO26oiL+dO39eyotFLde2b5inOG8Z33q
 XWE4A
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
index 5793bbfdda593c984bd2230f4052c3e68808acf1..b4d21a4814d3b706e6b89b39528ca269559e2e0d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3161,28 +3161,24 @@ out:
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
 
@@ -3193,6 +3189,9 @@ int qemu_loadvm_state(QEMUFile *f)
     cpu_synchronize_all_pre_loadvm();
 
     ret = qemu_loadvm_state_main(f, mis);
+    if (ret < 0) {
+        error_setg(errp, "Load VM state failed: %d", ret);
+    }
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3210,8 +3209,15 @@ int qemu_loadvm_state(QEMUFile *f)
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
@@ -3476,6 +3482,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
 
 void qmp_xen_load_devices_state(const char *filename, Error **errp)
 {
+    ERRP_GUARD();
     QEMUFile *f;
     QIOChannelFile *ioc;
     int ret;
@@ -3497,10 +3504,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
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
@@ -3571,13 +3578,12 @@ bool load_snapshot(const char *name, const char *vmstate,
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
2.50.1


