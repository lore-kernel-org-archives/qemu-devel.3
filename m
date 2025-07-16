Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CF1C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzfK-0002Sv-Ln; Wed, 16 Jul 2025 06:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubze9-0000pG-Ds
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubze6-0000lh-7e
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Eulyyn+2otse9TUi4QH4UwFKsK7ykiSxsaBtB448HY=;
 b=G5cvrpbDZkXDSoaHnQx5iqBZRywHEH77vy62mNGlRggSUoNccaTLmz3sfzfwKCckYksf7P
 vSG+8ul7j9kbat3acYvXQcR6xbx/GhVB56b1YajXR9U7BdlRO119TlKeBwfPIEsUTe+2TM
 Yzjjx+mMeUVYBQD4x2X9AogYJxq5vos=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-dkqR6IfbOfaq721fnXUFpA-1; Wed, 16 Jul 2025 06:45:52 -0400
X-MC-Unique: dkqR6IfbOfaq721fnXUFpA-1
X-Mimecast-MFC-AGG-ID: dkqR6IfbOfaq721fnXUFpA_1752662751
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b2c36d3f884so5169600a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662751; x=1753267551;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Eulyyn+2otse9TUi4QH4UwFKsK7ykiSxsaBtB448HY=;
 b=as2BF6E/vIPbWFeQESiQIYb/dKBwplnzMPY0vbLxZYz1fasFAleWnSUkf82y5P9ENh
 6RxiEhRf6tcHzd/fxkxAp0t9ZLvkjqaDpj0M7zWFYVFbQCSYt1MtIamqJli3Iu5x8u1z
 BgKghq8iVpRtrBQ/wxWqPYz+V+9pw9r/f4aJcaB4boxnZvT3/vIos+lR+02UUUykV/Dw
 yb/4NnhGST4pj5wdmj/5imfn/yq51GcvYYBIdhGNIcFHjYpE6j3fuoOS18nUe3KvtL23
 +z74Gvklx2zK0bJZcQOcKRXtQANcyZWax6FnSAUchDYHJk9fZOUM0fnxVZ7ikaYf8/Ix
 KEow==
X-Gm-Message-State: AOJu0YxxbfLPvyGpwHoUrOxFoqu6gVAldkd9iA0kqY3H3wXHLZg6GHap
 HtXJGuhAxR6Bo44sdb5RCZOF/1UsmD8ljwebxpLo1g/jqpOCsZSThF0mUvoA2S6SPu5y9D8U3AX
 SW6PegkDYKMvJnKj3aRQDg1s1LlQN4iqJfnJhIhQJdL3uHgeHy+M0IvFf
X-Gm-Gg: ASbGnctQo4rWS6cTnwzkJItHYO3dZG41KIRqGMBUMIKItNqhhTXrPx5YXEBz8eYa6yw
 FTGE5v3NIJ50mOxUH5gIchm57rsjhnbplH1qog+3vz9OBT53FAj+RzIjwVXtEdDTTZL5UO6jX+u
 8SLy5kGXy0nqBmEBt7JOAA7VZP5tq0ZwU1AYIKP5aCLpx5V9yyJT/lzrLHlj3SwIyEMS2VNpEqn
 A2q5BhoK23nnVGDmgx3HANiKNkKqqHaxGlLmrRc5iXBCAFfWn7F72CPG++G0GtGbKu3cDVJ3omo
 HIFw8t8FO3diTX0fSc8z0gQBdBdXLkeE/8DHV2feOpVSwiwlAQ==
X-Received: by 2002:a17:902:f602:b0:234:d2fb:2d13 with SMTP id
 d9443c01a7336-23e256c7a2dmr27263845ad.18.1752662751280; 
 Wed, 16 Jul 2025 03:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVVMO8orcya5GvtroxOq/dqGf6AG4KVNY5mvVx3XkLbS8xTyPx3vf9K+zSrJMSBglDpYoNmg==
X-Received: by 2002:a17:902:f602:b0:234:d2fb:2d13 with SMTP id
 d9443c01a7336-23e256c7a2dmr27263455ad.18.1752662750909; 
 Wed, 16 Jul 2025 03:45:50 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:45:50 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:13:08 +0530
Subject: [PATCH v4 18/23] migration: push Error **errp into
 qemu_loadvm_state_main()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-18-7141902077c0@redhat.com>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
In-Reply-To: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5659; i=armenon@redhat.com;
 h=from:subject:message-id; bh=8Rieh1unsscatlf5bdJzyn5v7vl9e6b6H7ZJQZUsVdk=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k0PQpe8m80U4THnPNLwvYTQWbzP5t+fLm5TZmv8Sh
 IU53Gd2lLIwiHExyIopsjR8DZBtCiiMiLR9eR1mDisTyBAGLk4BmMjxnYwMhxdPW/U6LsLMMdxX
 QCFxZ31s7bb735NKG0uOFKs6/VbgZfgf99/y+a3NEaEbVnGaxN+92iVuvP/azWaHZXvD3ayLMs7
 yAgA=
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
It is ensured that qemu_loadvm_state_main() must report an error
in errp, in case of failure.
loadvm_process_command also sets the errp object explicitly.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   |  5 +++--
 migration/savevm.c | 23 +++++++++++++----------
 migration/savevm.h |  3 ++-
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index e0f713c837f5da25d67afbd02ceb6c54024ca3af..ddc628cab4194b3cb82388c5e878286c820004b2 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -686,11 +686,12 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
 
     bql_lock();
     cpu_synchronize_all_states();
-    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
+    ret = qemu_loadvm_state_main(mis->from_src_file, mis, &local_err);
     bql_unlock();
 
     if (ret < 0) {
-        error_setg(errp, "Load VM's live state (ram) error");
+        error_propagate_prepend(errp, local_err,
+                                "Load VM's live state (ram) error");
         return;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 2df266129f24d3d0d24ee84c3a8d2f494e50d03f..9752fad6e1aa2d677b68cb6ae9180d1059d54019 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2102,7 +2102,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis);
+    load_res = qemu_loadvm_state_main(f, mis, NULL);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2453,9 +2453,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
         qemu_coroutine_yield();
     } while (1);
 
-    ret = qemu_loadvm_state_main(packf, mis);
+    ret = qemu_loadvm_state_main(packf, mis, errp);
     if (ret < 0) {
-        error_setg(errp, "VM state load failed: %d", ret);
+        error_prepend(errp, "Loading VM state failed: %d ", ret);
     }
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
@@ -3057,7 +3057,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     return true;
 }
 
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp)
 {
     uint8_t section_type;
     int ret = 0;
@@ -3068,6 +3069,8 @@ retry:
 
         ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, NULL);
         if (ret) {
+            error_setg(errp, "Failed to load device state section ID : %d",
+                       ret);
             break;
         }
 
@@ -3075,20 +3078,20 @@ retry:
         switch (section_type) {
         case QEMU_VM_SECTION_START:
         case QEMU_VM_SECTION_FULL:
-            ret = qemu_loadvm_section_start_full(f, section_type, NULL);
+            ret = qemu_loadvm_section_start_full(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }
             break;
         case QEMU_VM_SECTION_PART:
         case QEMU_VM_SECTION_END:
-            ret = qemu_loadvm_section_part_end(f, section_type, NULL);
+            ret = qemu_loadvm_section_part_end(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }
             break;
         case QEMU_VM_COMMAND:
-            ret = loadvm_process_command(f, NULL);
+            ret = loadvm_process_command(f, errp);
             trace_qemu_loadvm_state_section_command(ret);
             if ((ret < 0) || (ret == LOADVM_QUIT)) {
                 goto out;
@@ -3098,7 +3101,7 @@ retry:
             /* This is the end of migration */
             goto out;
         default:
-            error_report("Unknown savevm section type %d", section_type);
+            error_setg(errp, "Unknown savevm section type %d", section_type);
             ret = -EINVAL;
             goto out;
         }
@@ -3162,7 +3165,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, NULL);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3236,7 +3239,7 @@ int qemu_load_device_state(QEMUFile *f)
     int ret;
 
     /* Load QEMU_VM_SECTION_FULL section */
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, NULL);
     if (ret < 0) {
         error_report("Failed to load device state: %d", ret);
         return ret;
diff --git a/migration/savevm.h b/migration/savevm.h
index 2d5e9c716686f06720325e82fe90c75335ced1de..fd7419e6ff90062970ed246b3ea71e6d49a6e372 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -66,7 +66,8 @@ int qemu_save_device_state(QEMUFile *f);
 
 int qemu_loadvm_state(QEMUFile *f);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp);
 int qemu_load_device_state(QEMUFile *f);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,

-- 
2.50.0


