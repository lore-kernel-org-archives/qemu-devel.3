Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEB7CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rqa-0003ch-Da; Tue, 30 Sep 2025 00:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3RqI-0003H8-3r
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3RqB-0002Od-Je
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759205989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUA+R539708FFxfB5dfZO0hh0YfJ72dOgIXFASTJiSk=;
 b=MLNCqoKd+54JigZEsKy7QlgnPATmg/0xNuT4Qo3DcBv8YUZlhQx3Gl0cmy/7s0PP6IuQzN
 HUl8LGpeoZPLrvqbfoeVGeLMszmcHqKWLZir5kDgxBiSqJkXTMfxVjR/Z3Oikl1KKlUq/9
 qZv0ykjJWu+tgAh0SPQFpRW0Qqd9t0M=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-6b0Rn9NrPKyqGlX3fQweuQ-1; Tue, 30 Sep 2025 00:19:44 -0400
X-MC-Unique: 6b0Rn9NrPKyqGlX3fQweuQ-1
X-Mimecast-MFC-AGG-ID: 6b0Rn9NrPKyqGlX3fQweuQ_1759205983
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b4f87c691a7so8494450a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205983; x=1759810783;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iUA+R539708FFxfB5dfZO0hh0YfJ72dOgIXFASTJiSk=;
 b=ucuVUTHoyl8FFONSLQVcxzDDAP9GvCgowcy058e+UffULwLPKtCUu8e9AlAFt/actm
 4tJ3xNu5jTlwFmNLE6ueu9807mqVavcge+1AtkbKwA+XHRu0bIR8hThlY+jAo4pSdfim
 o82nJFCC6stxzjnhrvTzQ9fUt22v+/8OUp0mZ0pdfaibACutbwFeMNUj2Vl11xTHQZgQ
 JlrLaMqPpfRQmQui9vIq7YQdEfnCVa5cjQl6AQpdcQe40/uXkCCzBp0BVJ32VZfR1NKp
 uQvL2nOE/PuVo6l6c7XHrCvHo7cJSWL/uidMlw3+Of/PHiE/E9XUelEE/sdhacNJ0vTp
 ot4g==
X-Gm-Message-State: AOJu0YxNEERGewLF37d7OzsP0SeQq9aqCOEl3MSFjjvU+dZrPKOswHQI
 mOHta50cMLlmHPTG3PAYf8YsdUZYgysFA15q1P3tVhauAsJ0kQdy/938pmWsLB98+B+nf6Piv6i
 Eogl4hxVkCIsLD1V/JvTR/YT6T/MzZp81TbkisAh7SqkLoeFsDDFtccJA
X-Gm-Gg: ASbGncufsMy7cu260NbAFIL0c/ZdFB0AGaZ0trsBiu74ywF+2gel3LRQsiVwZSBiYSz
 3Fqzq1QlqoILCnTu9ZHsXjJMnZ2oe7Wt/JivkLZpK3VzkZz4/Zx33RWrE4f085PJKvn1dcWBpGY
 WiWtBB+D505k8d76+awaeFjgKZ2OiQ7qUjenxl+fisMYP/pyGXIVM2+wGymD3rKQ6jPRiUNP2O9
 JsEH5SoJ1ywGRqAh1bxt/Pjv5rlyA9nMcovt4mL6GXFN5tWAg3/SSgd+EhVokbrZuDiBAYAJd5S
 jzbz1DSSxLx38e3w15UyKicNkI8h1iSDg2U/ZYfa8SpjBzV7rfprGOHtrw==
X-Received: by 2002:a05:6a21:32a0:b0:2e5:c9ee:96fb with SMTP id
 adf61e73a8af0-2e7da1802e9mr22503208637.59.1759205983417; 
 Mon, 29 Sep 2025 21:19:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkipZDtzjIyeCS9poGrUxfMy3FEHPmb8KspwSN5K1Nv6ZLe0SFKZUfPoTFJwRfAGqWoKN0sQ==
X-Received: by 2002:a05:6a21:32a0:b0:2e5:c9ee:96fb with SMTP id
 adf61e73a8af0-2e7da1802e9mr22503187637.59.1759205982999; 
 Mon, 29 Sep 2025 21:19:42 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:19:42 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:16 +0530
Subject: [PATCH v15 07/26] migration: push Error **errp into
 qemu_loadvm_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-propagate_tpm_error-v15-7-84afd3af1e47@redhat.com>
References: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
In-Reply-To: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6322; i=armenon@redhat.com;
 h=from:subject:message-id; bh=87ZG1ju10KhMz+1q2wPws3qYo+MRUD5kJ5Si7ECttpE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKAG2iy6pew95zO3ce3Ot5MappUwW+4OP2byYuV4oL
 Zqh4d/ljlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABOJus/wP0r/Qemx7aetsuR9
 8/ZM0WB0F8tJPpazOrHUfc7UHakcnxgZNm9t5zgkq2VzMCDbqala2/LCQr57XS9irGLfcVvIW8z
 mAAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/migration.c | 14 ++++++++++++--
 migration/savevm.c    | 30 ++++++++++++++++++------------
 migration/savevm.h    |  2 +-
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e1ac4d73c2bb09ce5099365ff7161df6049a8032..cba2a393555053bd18d104b78a3c1bad471c3557 100644
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
 
@@ -935,6 +936,15 @@ fail:
         }
 
         exit(EXIT_FAILURE);
+    } else {
+        /*
+         * Report the error here in case that QEMU abruptly exits
+         * when postcopy is enabled.
+         */
+        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
+            error_report_err(s->error);
+            s->error = NULL;
+        }
     }
 out:
     /* Pairs with the refcount taken in qmp_migrate_incoming() */
diff --git a/migration/savevm.c b/migration/savevm.c
index 5e54651652e9562939e61cf488c809a369824edb..88116ed278ae0e5c9b0dd055828ede69b0b876c9 100644
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


