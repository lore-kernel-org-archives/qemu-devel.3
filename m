Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E249C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMPJ-0007Jr-2X; Tue, 05 Aug 2025 14:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMPE-0007CF-H6
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMPA-00043L-Fc
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GCEiIKB3RFQebr2N6OH+Z/58y6tNmqZwLsj+/7Bl7aU=;
 b=IzTlaQ3VWv2k0i8t9dAfsMHl4Gq1csirEJc7dcMxvKc0S5FMwNZ8R8UKL0uM88u83FMhlz
 /Dc/3wFyrCr+mY9VHGehjmZGAx3cPC+kO88rnhr/dkp4MdIC2xvbFQEyxac3RX2pMMwAig
 P1nO0+WrafYPLSjhIwWIXwc8FCWLyxw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-fOdatFo_Nxy2G_uJEOl7Sg-1; Tue, 05 Aug 2025 14:28:54 -0400
X-MC-Unique: fOdatFo_Nxy2G_uJEOl7Sg-1
X-Mimecast-MFC-AGG-ID: fOdatFo_Nxy2G_uJEOl7Sg_1754418533
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2400117dd80so41431925ad.2
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418533; x=1755023333;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCEiIKB3RFQebr2N6OH+Z/58y6tNmqZwLsj+/7Bl7aU=;
 b=Ww0fHS6IurkAxkGcLMFIMP7IEvYrJEfgguNx4ygwP3ApdU8p3hm+ioejG/z070B3VB
 0GBgXjVF1+suNY/hb3YSPB1ELmyA+Ue4KzuoahfiGi8SjiHbQF4jPDpHcStjZZA9pGMR
 eQo1y/5GYttxKIgk2miOENUTR1YXZKeY4UKfT7tsLoBbsbNdUTVqvW/XdWblTKTXeq7A
 u0z8i+kMAyGE8XExQ0aYQA0AAfNd50mEpOKowq5N2qNKtg4ijkk1R95pUweNgS4LA0U8
 B+07rQQzAHbZeCYwHqnE4dMQu6q5XMUxhqppDLkHD3RabpMzZAHD7EZ1CdVTBZIAOL3K
 0NIw==
X-Gm-Message-State: AOJu0Yy4EuAIEJ5s2arRdJ555hnpTA4gZkHodJ8A+I/q3Xh9aBniV2b1
 /ple7Qquz92PiQNgR5VccESmtRHw5Y5eYPcPNPAej0s2XmKfOvUhRmYfIG6xJPYJ4mk1uHh5XSr
 1xHHZAA30D/EisBqQAe34E7WUpFnvdZmXK5sppPcas/Am0v7FE545JUUO
X-Gm-Gg: ASbGncuslqkrWTVC0otjEz3bkcPqKU30vTNqQYS7BmFld7rXSSpPY+/WW39eVOTuScf
 2HhVhAJvrxqKk8wVcAa1NuFlspob486Ehb8PNvv0oN9QaJeLQ/R8tNNnS/XW3FUr0wQLiLqEaHP
 C9raMr6NPwk5b9fHf+DRiqt1MI8n4UKPJ1XyMd5lrPcigZtAYS1DspDSLw33gwpe/hhiTt+TXMp
 6bq1d6dAxhAwKZP6Huemo0ofdboWAUrpnR0R+WhErWFQNRqmrIVsyrZHNkxqbD7pVo2dRsS7pYY
 s0oq0BpW9i/ZVmUDHAc2ARtHp6nBiMw4EFH1WjGguF4upRi4qw==
X-Received: by 2002:a17:902:da8c:b0:23f:df55:cf7b with SMTP id
 d9443c01a7336-2429f1e2b27mr1442975ad.4.1754418533450; 
 Tue, 05 Aug 2025 11:28:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5hEVRm0opjS7baaFH2ax4iTlE5QO1p3eUwrHDz8ih7X8DgH7lLoLnfzV23zTNTS1E01Kx4g==
X-Received: by 2002:a17:902:da8c:b0:23f:df55:cf7b with SMTP id
 d9443c01a7336-2429f1e2b27mr1442625ad.4.1754418533036; 
 Tue, 05 Aug 2025 11:28:53 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:28:52 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:14 +0530
Subject: [PATCH v9 07/27] migration: push Error **errp into qemu_loadvm_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-propagate_tpm_error-v9-7-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6282; i=armenon@redhat.com;
 h=from:subject:message-id; bh=rcUfoQhEPXRdNa1M6WSd0P0agDN/fEPUtowfs4dweg4=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX+kHkjOMD9UejXJYNPtrWtQnKdezO49GBk3sLnaPj
 pfYfDKqo5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwET++DD8j9+y1PrNmZL6kpVi
 ohPZdDXkGF5/mGg+Qdxuyu+3RaFHVzEyLGTWUTlv/alD7cAtucKq46Z2nhz/9EwyfUtX7Srla5z
 MCwA=
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/migration.c |  7 ++++---
 migration/savevm.c    | 31 +++++++++++++++++++------------
 migration/savevm.h    |  2 +-
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25dec01f206eacad2edd24d21f00e614c..bb7d5e1dee52692cbea1d2c8fdca541e6a75bedb 100644
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
 
@@ -924,7 +925,7 @@ fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
     migrate_set_error(s, local_err);
-    error_free(local_err);
+    error_report_err(local_err);
 
     migration_incoming_state_destroy();
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 1bd27efe437d4d911728d776e995490d0a45dcf5..ca166ebd397ad80836ed2f9cb20a92f704fd4ed5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3149,28 +3149,24 @@ out:
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
 
@@ -3181,6 +3177,9 @@ int qemu_loadvm_state(QEMUFile *f)
     cpu_synchronize_all_pre_loadvm();
 
     ret = qemu_loadvm_state_main(f, mis);
+    if (ret < 0) {
+        error_setg(errp, "Load VM state failed: %d", ret);
+    }
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3198,8 +3197,14 @@ int qemu_loadvm_state(QEMUFile *f)
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
@@ -3464,6 +3469,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
 
 void qmp_xen_load_devices_state(const char *filename, Error **errp)
 {
+    ERRP_GUARD();
     QEMUFile *f;
     QIOChannelFile *ioc;
     int ret;
@@ -3485,10 +3491,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
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
@@ -3496,6 +3502,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
 bool load_snapshot(const char *name, const char *vmstate,
                    bool has_devices, strList *devices, Error **errp)
 {
+    ERRP_GUARD();
     BlockDriverState *bs_vm_state;
     QEMUSnapshotInfo sn;
     QEMUFile *f;
@@ -3559,13 +3566,13 @@ bool load_snapshot(const char *name, const char *vmstate,
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


