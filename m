Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08603C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCj1-0000Ac-HA; Wed, 16 Jul 2025 20:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucChv-0006W3-Lc
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucChu-0005Qk-3h
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PacmK3nktLw/dOt2en/sm4JJ0fUUCRH4QiuWUXDRJc0=;
 b=O5aE/13/v984P1FC/78WaE+sWDyx96gfFjp34hjjzajoyPoNyNP3ZSxU+RQkzHfZrY2Yvj
 4GxCj4sK3Rf+xgWR7gIQoYQqgP65ugHnsh+KGlCgY0INMp72LWuTgug4L+2Yte0S3JsEmZ
 n7eCslKOXudKXDEglNGJAqSsu1vj0OY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-2qdeio7nMzGiNMCD7SafrQ-1; Wed, 16 Jul 2025 20:41:46 -0400
X-MC-Unique: 2qdeio7nMzGiNMCD7SafrQ-1
X-Mimecast-MFC-AGG-ID: 2qdeio7nMzGiNMCD7SafrQ_1752712905
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-313fab41f4bso505974a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712905; x=1753317705;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PacmK3nktLw/dOt2en/sm4JJ0fUUCRH4QiuWUXDRJc0=;
 b=de5R5X2kcmrIL0oD6kQGnJsfLdbNZjsj6WEp8N88MNgt81pAIbwVl+m5QfK/p3fWFx
 0efj7U9uQ/uPs8bPJ6gD4kZo8OiguA1jd9IM3T9pTEgJvdlNKHNt6DILEzGC4Vhmgkzw
 3lbwY+loQPc/hZnR31iKSYYygbafqznF2DAORl7ddfXeyIvV7HZ9YUfcv3quLszvAGd6
 9eyS2QfiLyMTSlfE2Dp0ASmhwO9mNbFvvlESdXOKwI8iv6XxYylhBJVXBhFEx0wWDhtf
 TO4ybDk00tAsqvdTKXlG2jPf/FQaDQ5FapNMwZqohoFrsPpV7uy+/dnY5nJ2RE4FhHll
 uwIQ==
X-Gm-Message-State: AOJu0Yzfp4C0R7TUf+O2kL7YujhDqWIDcEr4asJHgyifbUK59W3nfv/e
 3IYv0MGC4szTb1kU4Y8CrpG5dtjE3pJcFM/f4uGKGVOunlSLmWphJKn6Tf+GXe/0KFz4w6H07FM
 vN4EFCoLD8gmED8KxJicbMVi69C3YT+qxzMqH9pJNXJ/rMcTBTWPTBwYE
X-Gm-Gg: ASbGnctWwPfzlPIimIqx7b4rCYqhqdqLOeT9/blJPgLRvI5O2EJbb6M9BoW7TMe+T1O
 GSWlADeSKnSq28cs4UC9FmhQi+3FVvLPv+d9XSiaY+GQcNwxjhi4Cd3WAp65T2xbpvhcl/Orjyz
 2rfGKFJ2DZ8OK7Xvz6P6xv+sSygHG/dW2SKJI8IJ5K2AT8NYm517jm+3h46Xs33zq8wmLy3U4WE
 PwrhfE16FHIdJj0Q/3vsdiB7+AoD/mG9mVc6vDlCeD+afxDFMBKDjpJORKZ12IKK3hO99wMQQ9f
 l+YHJl7wesluqZXZd71o5gswngR/4xYUYhXzj+l3/zPk6Pb7EG7+
X-Received: by 2002:a17:90b:2682:b0:311:b5ac:6f63 with SMTP id
 98e67ed59e1d1-31caf8db5aemr1157477a91.21.1752712905331; 
 Wed, 16 Jul 2025 17:41:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/AGU0AkHC3JsDsDztHQxtWQCknSKRzifAq9ibOMH7Vbss/oB56OPtYw9uY1JzYBF1FCbBFw==
X-Received: by 2002:a17:90b:2682:b0:311:b5ac:6f63 with SMTP id
 98e67ed59e1d1-31caf8db5aemr1157459a91.21.1752712904929; 
 Wed, 16 Jul 2025 17:41:44 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:41:44 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:42 +0530
Subject: [PATCH v5 19/23] migration: push Error **errp into qemu_loadvm_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-19-1f406f88ee65@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
In-Reply-To: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4861; i=armenon@redhat.com;
 h=from:subject:message-id; bh=5HGSLUPUo3rERZveK6G5D5oQLN1hltjUPDDQFU4fF5k=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm1Lsqur/6WGWajZtV/jVv7wIlbZbP8M3OdVoufsHi
 4/eZWs6SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATCT3ByPDrLaeayWlXxe8idVe
 I7wxcK/Rw2nZPHkWkSx1TwKtLfTiGf476m+sXpL20iZXdfo3vRn7C/bselE0O+n5ESa7yVJWnVf
 5AQ==
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

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/migration.c |  5 +++--
 migration/savevm.c    | 25 +++++++++++++------------
 migration/savevm.h    |  2 +-
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 326487882c8d41e2f89f99f69df0d9d4d42705e4..1f0a8bd6ab28ff09bb76919564bdbfbde35c5e42 100644
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
+        error_prepend(&local_err, "load of migration failed: %s ",
+                      strerror(-ret));
         goto fail;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 47c656734248c2b7a6d2001c6ef9b3e83af11bac..ea64603b75ead17bcc21aebfa49ede3991387fb7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3133,27 +3133,24 @@ out:
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
 
-    ret = qemu_loadvm_state_header(f, NULL);
+    ret = qemu_loadvm_state_header(f, errp);
     if (ret) {
         return ret;
     }
 
-    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
-        error_report_err(local_err);
+    if (qemu_loadvm_state_setup(f, errp) != 0) {
         return -EINVAL;
     }
 
@@ -3163,7 +3160,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis, NULL);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3181,8 +3178,12 @@ int qemu_loadvm_state(QEMUFile *f)
         if (migrate_has_error(migrate_get_current()) ||
             !qemu_loadvm_thread_pool_wait(s, mis)) {
             ret = -EINVAL;
+            error_setg(errp, "Error while loading vmstate : %d", ret);
         } else {
             ret = qemu_file_get_error(f);
+            if (ret < 0) {
+                error_setg(errp, "Error while loading vmstate : %d", ret);
+            }
         }
     }
     /*
@@ -3468,10 +3469,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     f = qemu_file_new_input(QIO_CHANNEL(ioc));
     object_unref(OBJECT(ioc));
 
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, errp);
     qemu_fclose(f);
     if (ret < 0) {
-        error_setg(errp, "loading Xen device state failed");
+        error_prepend(errp, "loading Xen device state failed ");
     }
     migration_incoming_state_destroy();
 }
@@ -3542,13 +3543,13 @@ bool load_snapshot(const char *name, const char *vmstate,
         ret = -EINVAL;
         goto err_drain;
     }
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, errp);
     migration_incoming_state_destroy();
 
     bdrv_drain_all_end();
 
     if (ret < 0) {
-        error_setg(errp, "Error %d while loading VM state", ret);
+        error_prepend(errp, "Error %d while loading VM state ", ret);
         return false;
     }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index fd7419e6ff90062970ed246b3ea71e6d49a6e372..a6df5198f3fe1a39fc0e6ce3e79cf7a5d8e032db 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,7 +64,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
 void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
 
-int qemu_loadvm_state(QEMUFile *f);
+int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);

-- 
2.50.0


