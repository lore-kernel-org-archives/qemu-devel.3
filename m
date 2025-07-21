Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261A0C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udomK-000753-DL; Mon, 21 Jul 2025 07:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoku-0002tQ-QX
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udokr-0001B7-A8
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zY97o+Xwfk2dW6k8JcNZ/JX64QtBvwhLBKNhHY4zOx0=;
 b=Mxy2XjLUKZ2G7J0HEqm1FuCiUVWUiB6hnjbG8DGmSo6U3cAomUAT7KjdwHvU5kSr0LXEwj
 x3fjXdWdw2uyZ7S3iCR+/NHaKtJmXEfm/9eTAr9QZG8ezyZx1UFAq4B6AGKcf+MEXkvhj3
 TspxgZMXDHrQ/b3HwqxsxtS5ni/1IM0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-N2-CAmNQPkSWoXvGhjVMLw-1; Mon, 21 Jul 2025 07:32:23 -0400
X-MC-Unique: N2-CAmNQPkSWoXvGhjVMLw-1
X-Mimecast-MFC-AGG-ID: N2-CAmNQPkSWoXvGhjVMLw_1753097542
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-23632fd6248so38667045ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097542; x=1753702342;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zY97o+Xwfk2dW6k8JcNZ/JX64QtBvwhLBKNhHY4zOx0=;
 b=fL1lUGuBDvNge7dG07azwe5RqnaB1Aoi/MeKrqzc6btQ5aNDlA7hcCWC/HDTe4NU7x
 Kh1kupdG2laW3cncO4k4+RXh+sflt/FlaGcHQeGXBoqXgAXCG9rC+dbdscwRWdWPI05Z
 WpGHhlfuxDVLcNQ8SEGnhMX66cZb+Rr3iMbUuezCvAZZVcJ5hPawrDMd2m6WvQhgD47N
 jtjODwz8TdI78Q7Nu7Jq5zClPFX1agdrITMlwTiQX6YdUzqQ4SSdH3Fyl4X2iwMZU0yD
 qZzv0Ao51WJHR1Kpr1wUb8H702gdNbxAKxxwXb5K2zdEPj4hZQRwTkCLZBFH36X4L9BG
 8sUg==
X-Gm-Message-State: AOJu0YxArXzi//AxfN/WAXPF0RpYd5LsRuJ7jLRaHUlL/A8ljCMlkUmx
 NyiyABTWHW8AC/3PHS2J+pt4z3VWIUxjTxfIiY3/EJ7mI0dSC9QX47e82CI9ObeVdSdHCwYIAvq
 3V58WzG2dkMHVZFHeJJR6FvXAo/H3QGeHJ2t8Rhal2GSU7Uv7WWCKKH9J
X-Gm-Gg: ASbGnctkHEL0YaV4E3WsHyD0OMMJ5iwfpj4cvxMA85c4M6R9RCLvPwDBKKyUFKnBARG
 Z4pkNMJeYXaIBykb9PweJxmOy1cdL4iz3kYdjYdXjLmkh44UddGF02BiQWd3hASSUgxpadoaDI4
 tYyVefeZGQmTO/eR6zaVZw0N1n/0UJ12jooIQj419WKybAJXA9VOR6lILOtfP+FtD9zfFAptcJw
 Eji/QTLOLp/5noPvmV4xv22L1bsqZKa36yX85O+hT1EPN0XmuEATieJ8m8KzUdz/Pd8an5ZBjnR
 qZjAyQP0cZ7MWcAfLAau5fBerODDZmIJepsTSsmq8TZm6sI+fGmH
X-Received: by 2002:a17:902:b115:b0:235:81c7:3c45 with SMTP id
 d9443c01a7336-23e2578e7a4mr262862245ad.46.1753097542025; 
 Mon, 21 Jul 2025 04:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGckmg+y8la1r6Uk5tFn+OnjpQfpURBbfbTlm4Vb+TX05qbTUugccINNCiaOSyhwfRH9ZimA==
X-Received: by 2002:a17:902:b115:b0:235:81c7:3c45 with SMTP id
 d9443c01a7336-23e2578e7a4mr262861885ad.46.1753097541629; 
 Mon, 21 Jul 2025 04:32:21 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:32:21 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:25 +0530
Subject: [PATCH v6 20/24] migration: push Error **errp into qemu_loadvm_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-20-fef740e15e17@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
In-Reply-To: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
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
 h=from:subject:message-id; bh=lg1aiipEtXIIMdaPEfs5RNRiSQXigd7HC9snbMHPYKs=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adyqTiVe++8fBelHd1/eGV+PNZnyRH07RuDvfPz8PW/
 Oh4xD+xo5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwESq4xgZnrwTa5nbrM8sG73m
 ho6/7bfk6EyL2Z/5li5/fz/5eEjvdkaGfTLlB1cJiFj/+HF0Hd9rXuFFu+yqZ179Hed3+pi2dV4
 kIwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index d748a02712dc4ebc2de6b0488fb199c92c4d4079..09fadf36dbbbd2f68df1e4cafbf3a51b18531978 100644
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
index ba146f91427f2a36880aadeb16b11ab2b7df099a..1261e81c86f836e6b5a155ba1880b5823a779567 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3137,27 +3137,24 @@ out:
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
 
@@ -3167,7 +3164,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis, NULL);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3185,8 +3182,12 @@ int qemu_loadvm_state(QEMUFile *f)
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
@@ -3472,10 +3473,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
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
@@ -3546,13 +3547,13 @@ bool load_snapshot(const char *name, const char *vmstate,
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


