Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F84CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNcg-00009K-0S; Sat, 30 Aug 2025 11:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5Kv-0005MC-H7
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5Ks-0004ih-D6
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756497873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UTHY4yYhUKE3D/jL5Fi7j9W8F5eZAPi88KnU28ha278=;
 b=aHtT7HPoKdlhCZ0Bc/1AiMpst8RsK+EaxvLgPgnP9/lcT8gn67NrIuaRBLzyrHb/jemTHj
 +o6Gzmwb7C80fGVVBwuo6YwCH2+Ue//4HI7az97pAveNG1j95nt07Ylx6qdXVe3FkUfa5W
 U9kSyDO4TsHUW9e3cJFTL/n+Vx6AvSs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-71DpL8ZWNqqpQZU5vCSo5Q-1; Fri, 29 Aug 2025 16:04:32 -0400
X-MC-Unique: 71DpL8ZWNqqpQZU5vCSo5Q-1
X-Mimecast-MFC-AGG-ID: 71DpL8ZWNqqpQZU5vCSo5Q_1756497871
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-32811874948so13939a91.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756497871; x=1757102671;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UTHY4yYhUKE3D/jL5Fi7j9W8F5eZAPi88KnU28ha278=;
 b=iQiGiR5aVm2tOlVzkV/MYAu1FW04bE/NxBcQYQBh9rassTh1ggzl73J6CEVcHOaflU
 VcLY4WflnfJqBHszaMR7fYR8E8uvEPWZo84xzfJ2hJoJXim0hoZ+MXg7V+MgmDLD7A4F
 J5sO6tnuiX9AiuaDAIKx1CKwuf2ddMDh/4Fb9XhYNpm8zRNyeIRe1tGc/yfjMBCV16Pa
 EokA62khbw1OcxqXuMs7Af0W8ubPgjnWcYlJS5WEL1p/EoxbFGBG/FPqxy83o4nzjqhs
 rPdZYWhoDnbJkVVxayA94MbmXxOS+NLHSm1l7rBhCZXKOz8nBXyEtNbgbR6jmei+jGFK
 oRbA==
X-Gm-Message-State: AOJu0YzRMrh8g2GZtb7Vt5Yz4vimqqZFFCSBRNqEw88y42ak9E3IBqkp
 HPukipJ0OP3CvPgYW0SDWSVQUgWenOwS3dSBMJzuUeyuktQaH+saxpWd0TotWzoZ6Ljgen34WXw
 HjWXuS2Cz52B5ZSRSARTVKblSd1vYNVk4pdwCjjD1ftWO+TFNXhHyj3AT
X-Gm-Gg: ASbGncuySv6NqJA+q2dPw7wlDSk5lKnnif1FNDKSbnHck26WWRB9L5UKqLth/jtXVv2
 W8iVQgi7sGsK/9By3SKVqGeakezu9/5+XO8YzRQ5m/m7imeZp6A9EGl0akqBYZh3HP+U8GULPuD
 ucQNpK+By9cgTOsX9BG1Q44DzkBKG8Zs2w9kM5PZaYF6hG+g7DSGFvtRV3DhRY0JjYE3ODI3MrZ
 8qVuEH8yAus8uSFddaxo0oxK0xHFNhyD/gNL7Bo17MzjaqeJC0LeUhXhiLGPB4+2wpHsPGgmohG
 D1KBZbSCHFexf2pw5GXuiHDodlm4euVNz80bOXU5aB8LbDcsaOpfag==
X-Received: by 2002:a17:90a:da86:b0:31e:3f7f:d4b1 with SMTP id
 98e67ed59e1d1-32515eaedcdmr40026850a91.24.1756497871004; 
 Fri, 29 Aug 2025 13:04:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGelJva5c5otfsIn61RpE3WdkMDE2+BG1i5oIhnSuHzqYQlqhjb6YRpmb1cNb9hrht9ztaGkQ==
X-Received: by 2002:a17:90a:da86:b0:31e:3f7f:d4b1 with SMTP id
 98e67ed59e1d1-32515eaedcdmr40026810a91.24.1756497870615; 
 Fri, 29 Aug 2025 13:04:30 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:04:30 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:31:49 +0530
Subject: [PATCH v13 09/27] migration: push Error **errp into
 qemu_loadvm_state_main()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250830-propagate_tpm_error-v13-9-a4e777b7eb2c@redhat.com>
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
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6326; i=armenon@redhat.com;
 h=from:subject:message-id; bh=CbE6WDTGoaxyx+hpN6RrbB5sFr/ZitwM6OvQ3jqdjKk=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdt+rKzzV3Av+BwTWH0jf1OybtPb/rYVtZ60OKsx9K
 /XiCve2jlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABPZM4/hn6X9Hcl03yXbf9xv
 fHuS7ew22Qu2GaKc94r+8pQusLe+9Inhf1HNYYFrfr6fMrWFWjZ0TzvXwGsgfGL6zq9VeyzZ9on
 ysQIA
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
It is ensured that qemu_loadvm_state_main() must report an error
in errp, in case of failure.

Set errp explicitly if it is NULL in case of failure in the out
section. This will be removed in the subsequent patch when all of
the calls are converted to passing errp.

The error message in the default case of qemu_loadvm_state_main()
has the word "savevm". This is removed because it can confuse the
user while reading destination side error logs.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   |  3 +--
 migration/savevm.c | 36 +++++++++++++++++-------------------
 migration/savevm.h |  3 ++-
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 2f524b19e6a79dcfe3861f1dfb768222f65a718a..642d17487d92c0a9508e599ca3bf524e80b6fd46 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -686,11 +686,10 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
 
     bql_lock();
     cpu_synchronize_all_states();
-    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
+    ret = qemu_loadvm_state_main(mis->from_src_file, mis, errp);
     bql_unlock();
 
     if (ret < 0) {
-        error_setg(errp, "Load VM's live state (ram) error");
         return;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 5462eaff0dcec1fa207c08da6124fe91656201ac..eccb3f63f8dfc070263a1d19ec3415684e8fa60e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2105,7 +2105,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis);
+    load_res = qemu_loadvm_state_main(f, mis, &error_fatal);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2456,10 +2456,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
         qemu_coroutine_yield();
     } while (1);
 
-    ret = qemu_loadvm_state_main(packf, mis);
-    if (ret < 0) {
-        error_setg(errp, "VM state load failed: %d", ret);
-    }
+    ret = qemu_loadvm_state_main(packf, mis, errp);
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
     object_unref(OBJECT(bioc));
@@ -3080,18 +3077,22 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     return true;
 }
 
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp)
 {
+    ERRP_GUARD();
     uint8_t section_type;
     int ret = 0;
-    Error *local_err = NULL;
 
 retry:
     while (true) {
         section_type = qemu_get_byte(f);
 
-        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, NULL);
+        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, errp);
         if (ret) {
+            error_prepend(errp,
+                          "Failed to load section ID: stream error: %d: ",
+                          ret);
             break;
         }
 
@@ -3112,10 +3113,7 @@ retry:
             }
             break;
         case QEMU_VM_COMMAND:
-            ret = loadvm_process_command(f, &local_err);
-            if (ret < 0) {
-                error_report_err(local_err);
-            }
+            ret = loadvm_process_command(f, errp);
             trace_qemu_loadvm_state_section_command(ret);
             if ((ret < 0) || (ret == LOADVM_QUIT)) {
                 goto out;
@@ -3125,7 +3123,7 @@ retry:
             /* This is the end of migration */
             goto out;
         default:
-            error_report("Unknown savevm section type %d", section_type);
+            error_setg(errp, "Unknown section type %d", section_type);
             ret = -EINVAL;
             goto out;
         }
@@ -3133,6 +3131,9 @@ retry:
 
 out:
     if (ret < 0) {
+        if (*errp == NULL) {
+            error_setg(errp, "Loading VM state failed: %d", ret);
+        }
         qemu_file_set_error(f, ret);
 
         /* Cancel bitmaps incoming regardless of recovery */
@@ -3153,6 +3154,7 @@ out:
             migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
             /* Reset f to point to the newly created channel */
             f = mis->from_src_file;
+            error_free_or_abort(errp);
             goto retry;
         }
     }
@@ -3186,10 +3188,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis);
-    if (ret < 0) {
-        error_setg(errp, "Load VM state failed: %d", ret);
-    }
+    ret = qemu_loadvm_state_main(f, mis, errp);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3270,9 +3269,8 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
     int ret;
 
     /* Load QEMU_VM_SECTION_FULL section */
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     if (ret < 0) {
-        error_setg(errp, "Failed to load device state: %d", ret);
         return ret;
     }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index b12681839f0b1afa3255e45215d99c13a224b19f..c337e3e3d111a7f28a57b90f61e8f70b71803d4e 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -66,7 +66,8 @@ int qemu_save_device_state(QEMUFile *f);
 
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,

-- 
2.51.0


