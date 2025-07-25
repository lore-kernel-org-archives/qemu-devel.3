Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32765C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHSu-0003se-IU; Fri, 25 Jul 2025 08:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHR8-0001uG-HD
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHR6-0000dO-67
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IsHleITly2fSWzpbr9+ffWu/xAKzajrAIiX6w2f6lg8=;
 b=hNFnMkGeDAmC+7pPjzNUFVXq8dXVDBY8y39tddo36PgvOiyRUB0VPXcuq9n0DSxlJHtFdV
 62mV0pUvEy15JiVsJo5ejFHlVUY5aWADElh22WjBNcYfqpmdfgy7brJdCHaE2VoZ4w4k9l
 PvgtKXQDtmKhdbsD2S1qGkvrisskit8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-f4WLdUPbNpe5uHn7kI9cew-1; Fri, 25 Jul 2025 08:22:00 -0400
X-MC-Unique: f4WLdUPbNpe5uHn7kI9cew-1
X-Mimecast-MFC-AGG-ID: f4WLdUPbNpe5uHn7kI9cew_1753446119
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-315af08594fso2008320a91.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446119; x=1754050919;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IsHleITly2fSWzpbr9+ffWu/xAKzajrAIiX6w2f6lg8=;
 b=MesLiMmvPr3Smrsx2hN+ZOnKclf9SWAAtedI+INarqTrOchlDKvfI2dKBbcDLg9WVF
 dPvMgqwZ2pzC9BSGQ3Eoo+ArAMZT2BeDrW5XIyC/167uLG/9BTGdeUKsY3m+MIyiECk6
 +1CXlGDdPzEOItMunrTo4GFIWYedmAdtTqAxST7gH5MnQ6v77QWip6W96LxzHkZj7Cit
 AXB3ZNArZG9FcdKIpRGxWFs95Yy6XZhxEWD3lmaKsdYTMjq6klqoVFzrvalEy+arZvtx
 +d3OfdVvLqH1A6kHDbMpf9+pGywPN6WMnUd1v3LXcVHpW80uoPz6dF5IxiOdLFAs2dn8
 tudA==
X-Gm-Message-State: AOJu0YyxRKSpskkWG46oxDXUPx7wvsEbeySeqKwIu3mPi47cAwXsnMKF
 dozXJLCw4mnR1AdoIk3wfutUdOeEygpsYAMT5Lq4Xn2VAWgFthf1Atu0p3pj/aownPaICeJdwOQ
 MPqRRoPvdqnGOdtZD8hkmw3o8UVrJEbBpOMMsp9D8WafGVGJhf16jlJcb
X-Gm-Gg: ASbGncubUHm+5YTnoNMdVKq68DsLcXEWSl8AAjK8wkWIpX65nB8GwJQSB1b8wpomqxz
 JaO+slnNUoD+U67udTQqmXERQEGoE7j/b+pPCXwKlVBKCoRNFPcHFZV5djnExhSetanz3iFy9yT
 19Keh8fW+gpAO53sYU/FKthrqdDIPRwqPUKZPkkaAwF9EMhL0nAUPExdzVrD6rJATGuV2EvzJgR
 yIe0gy4iyJCA4Ru8H4JawpXtjG6gkEI+/m+MwRjKNqdu2/vQz0p95ZNySVsVsg82FEDrWhU7+e3
 h4DCDV+r/hWT8VsCvXb/NgEm996yTsktGcMGIAMdVM8WAXjMTuRmZg==
X-Received: by 2002:a17:90b:55c3:b0:31e:60ac:bf65 with SMTP id
 98e67ed59e1d1-31e77a2040bmr2433024a91.27.1753446119114; 
 Fri, 25 Jul 2025 05:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1sZLFBkf5hjl+sBEhVuWkX0D1mPsauSu8OwzapiIFs7hFnZFCiN988s6nUw3XCg+2yF6yXg==
X-Received: by 2002:a17:90b:55c3:b0:31e:60ac:bf65 with SMTP id
 98e67ed59e1d1-31e77a2040bmr2432960a91.27.1753446118637; 
 Fri, 25 Jul 2025 05:21:58 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:21:58 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:59 +0530
Subject: [PATCH v7 20/24] migration: push Error **errp into qemu_loadvm_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-propagate_tpm_error-v7-20-d52704443975@redhat.com>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4938; i=armenon@redhat.com;
 h=from:subject:message-id; bh=jSGjZon+paavEMzrt0euF2ut2QMTmAsFbC5TCssmvYM=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0ZzmW5pxma2by17A1ZJFG2+p7fL1PLSxdCn7B1fGta7f
 r5w4+LBjlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABP5UMHwT4Oj4+uXfWsr7XMu
 tXJp3jtrVMt/VyNmho3WEjnT5xelZzL891Q9WNy85aifyj/lkEdHD4k6aM3MT9Y7xvdH0Yn97ZH
 XnAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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
 migration/savevm.c    | 27 +++++++++++++++------------
 migration/savevm.h    |  2 +-
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d748a02712dc4ebc2de6b0488fb199c92c4d4079..0a5a8d5948b2b0a3f85163795e84f71903870d25 100644
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
 
diff --git a/migration/savevm.c b/migration/savevm.c
index b125f31c1bd5c0d49e07247cb9ce46dfcea5b075..acdd32159bb303907af64b7970168112fcce2514 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3142,27 +3142,24 @@ out:
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
 
@@ -3172,7 +3169,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis, NULL);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3190,8 +3187,14 @@ int qemu_loadvm_state(QEMUFile *f)
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
@@ -3477,10 +3480,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
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
@@ -3551,13 +3554,13 @@ bool load_snapshot(const char *name, const char *vmstate,
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


