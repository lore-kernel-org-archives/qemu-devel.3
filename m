Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D009C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHMR-00025T-Pp; Fri, 08 Aug 2025 03:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHKr-0006oQ-OO
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHKg-0007Hh-BX
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dp0ss66SXDuo00PuAE5YpQ+W52Yt+0FYOjomzf8l/hg=;
 b=QjAqDupn2gAoo4JglY2HQ73+wnCRwUynRuuUnqs83zAsHTU9gPwm/JF1xLEr6e19RLbpmK
 q0glNg2JZU6mAB3JY0PDQqPIsxclTfDh/qsnxhMQOIDUzhduBs3M1ZbdEm8hH98KgHCX+V
 C2fZXBS9km7Xpo8bP997YW6Qv0E2D2g=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-UuOHk6eQNRKO5oLYaRhq8Q-1; Fri, 08 Aug 2025 03:16:01 -0400
X-MC-Unique: UuOHk6eQNRKO5oLYaRhq8Q-1
X-Mimecast-MFC-AGG-ID: UuOHk6eQNRKO5oLYaRhq8Q_1754637360
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b42a54b7812so383848a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637360; x=1755242160;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dp0ss66SXDuo00PuAE5YpQ+W52Yt+0FYOjomzf8l/hg=;
 b=g25RVkSJvE/YoxyiSelv/48Q3WQ0LUcAHnzIckVt9okUnInZUgpEkVEVrtfN5FOJtO
 M0yzp0bpyHJ8mgeEAS8YU0ZHs+IGtRNN2rSLmxU0ol8XedEdQkjaoAz+GKIfDFn4CQ4R
 8+RRQQ4m4mu2/XLFOpydBnEZMdKAbr5msGpCADNEzajnXKrDjU0dzVXxn6t03wTd8+A9
 dPOUcgl4ZYvAz/Pj1gjOJNZk2ZlvsipJ2qHw8ToVT68X3mD/81wXivKNom+mf1jloYy8
 yYKKp9ZmHoQZher3f+ANsiQFfXqS5vHPaWH2eM+NXqL3NBPDZTI3XW/ppN9d6T0ZmAZz
 26Sg==
X-Gm-Message-State: AOJu0YxwEE9oTPxl43qkvrKtF2foicz1Qtu6UjQub6XoKuDruIUXRWaq
 Mavc0Yrc+W7U733u/k5Tc7yfA79A1pgAfkYulPafj8/+6ZhrR6/sAZu4F0Y0cONYL6sO9/1+Gf9
 EobF+1X0J0ffD1dOEz6K+jgmklWnLz5j+6SfvZ1o/4m1R/gWhXKRo/ih3
X-Gm-Gg: ASbGncuMR34jl2y8F5dDFwP6ge3wg+Imug092lomC4Iu1QKyO9ZpRYKrDReocfJBUxh
 FuAYHHc+Ob8rGMALxMrbGbe4vBJc76jfJgOPIKskMeBLcloI+U5oq/IeceP3BW4/9VR4W76Qo2r
 VeidW6KVPMRuxlOEouE8/RIsiVpHapkPxwdJoX5GzFxMj1Dn+n7jEEpPi6FqZ2zzm3h9BmpABLE
 G3hpHfiEHnUgCyOhOu5p5PkXokRdkYTvZogwOjM4n5X++ixmhSFjMJAY00jVZJlMn/xr5x7eiMJ
 5ULl5HC8ADeD+7+sX9ULyDhHzNq7Mxb45Xk+NIXcUWvfAKbj2IudBA==
X-Received: by 2002:a17:902:ccc9:b0:235:eb8d:7fff with SMTP id
 d9443c01a7336-242c2217723mr23043495ad.28.1754637360321; 
 Fri, 08 Aug 2025 00:16:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+uk6RCG0Wpg1m5meduBVzDnWnP8ollkytwM85pqYi7rMxxkZ/L/1702Xyf7GmC7TbVduAIA==
X-Received: by 2002:a17:902:ccc9:b0:235:eb8d:7fff with SMTP id
 d9443c01a7336-242c2217723mr23043215ad.28.1754637359947; 
 Fri, 08 Aug 2025 00:15:59 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:15:59 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:35 +0530
Subject: [PATCH v10 09/27] migration: push Error **errp into
 qemu_loadvm_state_main()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-9-3e81a1d419b2@redhat.com>
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
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6631; i=armenon@redhat.com;
 h=from:subject:message-id; bh=baBKy11F3HHheVcdcrkjS+nVp29i59ojHE+SmCIy59w=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxVcj9iy8rSzyuPrFF5dsdZb5di7Lp187GLzsrN/J9
 vmLDX7HdZSyMIhxMciKKbI0fA2QbQoojIi0fXkdZg4rE8gQBi5OAZgIix/D/4hfPt8mNGc7H3n7
 evreb/n9/bsarqafr/j4Ynl+/MNAIzaGf1qTyjoEf84tf2NfpbnGdp13ws23+vK/DTIkNrTx/mY
 zZwMA
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
loadvm_process_command also sets the errp object explicitly.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   |  5 +++--
 migration/savevm.c | 32 +++++++++++++++++++-------------
 migration/savevm.h |  3 ++-
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 0ba22ee76a13e313793f653f43a728e3c433bbc1..a96e4dba15516b71d1b315c736c3b4879ff04e58 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)
 static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
                       QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
 {
+    ERRP_GUARD();
     uint64_t total_size;
     uint64_t value;
     Error *local_err = NULL;
@@ -686,11 +687,11 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
 
     bql_lock();
     cpu_synchronize_all_states();
-    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
+    ret = qemu_loadvm_state_main(mis->from_src_file, mis, errp);
     bql_unlock();
 
     if (ret < 0) {
-        error_setg(errp, "Load VM's live state (ram) error");
+        error_prepend(errp, "Load VM's live state (ram) error: ");
         return;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 8557cef35eaf834166ed05ef8b39d79ead47b78f..3df78ac0026c4c098d3fd13f765b54db0eafdc61 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2105,7 +2105,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis);
+    load_res = qemu_loadvm_state_main(f, mis, &error_fatal);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2407,6 +2407,7 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
  */
 static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
 {
+    ERRP_GUARD();
     int ret;
     size_t length;
     QIOChannelBuffer *bioc;
@@ -2456,9 +2457,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
         qemu_coroutine_yield();
     } while (1);
 
-    ret = qemu_loadvm_state_main(packf, mis);
+    ret = qemu_loadvm_state_main(packf, mis, errp);
     if (ret < 0) {
-        error_setg(errp, "VM state load failed: %d", ret);
+        error_prepend(errp, "Loading VM state failed: %d: ", ret);
     }
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
@@ -3076,8 +3077,10 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     return true;
 }
 
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp)
 {
+    ERRP_GUARD();
     uint8_t section_type;
     int ret = 0;
 
@@ -3085,8 +3088,10 @@ retry:
     while (true) {
         section_type = qemu_get_byte(f);
 
-        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, NULL);
+        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, errp);
         if (ret) {
+            error_prepend(errp, "Failed to load device state section ID: %d: ",
+                          ret);
             break;
         }
 
@@ -3107,7 +3112,7 @@ retry:
             }
             break;
         case QEMU_VM_COMMAND:
-            ret = loadvm_process_command(f, &error_warn);
+            ret = loadvm_process_command(f, errp);
             trace_qemu_loadvm_state_section_command(ret);
             if ((ret < 0) || (ret == LOADVM_QUIT)) {
                 goto out;
@@ -3117,7 +3122,7 @@ retry:
             /* This is the end of migration */
             goto out;
         default:
-            error_report("Unknown savevm section type %d", section_type);
+            error_setg(errp, "Unknown savevm section type %d", section_type);
             ret = -EINVAL;
             goto out;
         }
@@ -3125,6 +3130,9 @@ retry:
 
 out:
     if (ret < 0) {
+        if (*errp == NULL) {
+            error_setg(errp, "Loading VM state failed: %d", ret);
+        }
         qemu_file_set_error(f, ret);
 
         /* Cancel bitmaps incoming regardless of recovery */
@@ -3145,6 +3153,7 @@ out:
             migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
             /* Reset f to point to the newly created channel */
             f = mis->from_src_file;
+            error_free_or_abort(errp);
             goto retry;
         }
     }
@@ -3178,10 +3187,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis);
-    if (ret < 0) {
-        error_setg(errp, "Load VM state failed: %d", ret);
-    }
+    ret = qemu_loadvm_state_main(f, mis, errp);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3262,9 +3268,9 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
     int ret;
 
     /* Load QEMU_VM_SECTION_FULL section */
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     if (ret < 0) {
-        error_setg(errp, "Failed to load device state: %d", ret);
+        error_prepend(errp, "Failed to load device state: %d: ", ret);
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
2.50.1


