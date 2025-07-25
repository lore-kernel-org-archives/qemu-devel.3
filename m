Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E452C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHT0-0003yX-20; Fri, 25 Jul 2025 08:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHR0-0001Xi-Le
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHQx-0000bT-Gu
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tS2o6wRU/YpOroGnJUduyOqkQ8T3sCtzwpbmqTuuu9c=;
 b=cbt9kWYFLTzB7dj5lu9oxNRzUHr9REv26TA0qKCo2N41XUvnV7eUDZL4CLSLqwJC5tgb7b
 HdI0w9DzOphNTpxBSrLdX3M6SCOwW8wIkr8VLsrn1Fnkfo4zAxcHADlvsud4f2dXcVORR/
 TfQ6AnoX1L86z3eCOlyeT8rgfLigO9A=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-Llgk_ILhPm28zWBE2KCfHg-1; Fri, 25 Jul 2025 08:21:51 -0400
X-MC-Unique: Llgk_ILhPm28zWBE2KCfHg-1
X-Mimecast-MFC-AGG-ID: Llgk_ILhPm28zWBE2KCfHg_1753446110
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b3f657b4badso1619785a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446110; x=1754050910;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tS2o6wRU/YpOroGnJUduyOqkQ8T3sCtzwpbmqTuuu9c=;
 b=PYkPquy9qGpduRL7uK4VUHX8tSCf47ndfdMIfu7v4hTDIQ6CAk53NkKU2WXXbdgf2Z
 nLim6jNSlZpk/vwIfy+7ajsA55EI4VfBbhRavfzc3WMIHjbYJ3DsKczw/aW53JwaDy4V
 aq0wOU1hDKyC7YFCtoR5Zwt2UmwX2g6TMJvWPJ0bI9pFdnRu6bgB5POWCO0BcXmNUnpC
 YD93ufPbRmrkFJQ9e0YN++/OJXHmJWWiTey1BLVRuPqqNzfI8719Jtw3o2xAHkJc3zn1
 jtoDKQynQ/lRI74PnA7O4nbK1TRAw1OGMpAb2gYzrBRkFr3gn8l+LOSi2vIr6Owwkrl7
 F0UA==
X-Gm-Message-State: AOJu0Yyl7/1jHUpMOhV3wapYOY5dIY+V4P5Sux6ZacCQJhMbwuccZWnt
 MuaGJabbnxg+uGDS6Z3jOMeLO9itQFe1IGyYocD33zGraZz8pQUU5J+oMa+hhV1RR/hj89oV+Pz
 7/2NZoiu0aJRmwOahtEgqJE5PCFDG2VPFkOmf9e4SflnxMx17gFLP60lk
X-Gm-Gg: ASbGncsw8uATGCBHVV8zO81vupLZqYdf6484wijAyfHN4AzZYNGJ6pDr0SO60bRSVOj
 1/6hRZ36sY+XQAnROWKQzHrR5B92SsMCFA+vr8C8wTD3QLDbLZyCB+spCHVFLoU3Q28lCI/aij/
 Z/vz1DMjDpus6EsBPritdfpRzdx68e8putJyAsdZGhLGtgQgeCB5UATxCzoGBd9DbIiCflfAJ28
 CDcXHP5Di1q8m25cF/FzDQLzcJg+asPM/uZjw5H/hzKPgHo2fQZ8Uo067kgVVLO9xKjALyrWFuF
 bNzZFWGC9/79cxnkMBCi+TCDFEtZY1uZ5PrdOPBG/+StawoPjPyhCg==
X-Received: by 2002:a17:90b:56cb:b0:311:d05c:936 with SMTP id
 98e67ed59e1d1-31e778f2e74mr2963318a91.17.1753446110240; 
 Fri, 25 Jul 2025 05:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUslRurBEAIOrBzXssUUupnWy/NLSJB8z6iV5QBLjCmWmC5abaRrOxCKqGCv+VRI2EZld0lA==
X-Received: by 2002:a17:90b:56cb:b0:311:d05c:936 with SMTP id
 98e67ed59e1d1-31e778f2e74mr2963275a91.17.1753446109806; 
 Fri, 25 Jul 2025 05:21:49 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:21:49 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:58 +0530
Subject: [PATCH v7 19/24] migration: push Error **errp into
 qemu_loadvm_state_main()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250725-propagate_tpm_error-v7-19-d52704443975@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5811; i=armenon@redhat.com;
 h=from:subject:message-id; bh=nDa9qSnueFdP89mMMlo8MG1sliktLeLMMgBGrKg0dB4=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Zzme70b+IM1hUul3t8c2yYSi71iZt/lBY5VMdS/23Sa
 sUjZWs6SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATGT1Xob/OU43Dq5c4KZbVzPD
 an37XCO9OXwrb8bWqvDoZc9ui5/sz8gw02eOIMcfJjG29Xrv/oTkL7u86fLXS+wtp1SmBJj5vLn
 ADwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   |  4 ++--
 migration/savevm.c | 25 ++++++++++++++-----------
 migration/savevm.h |  3 ++-
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 981bd4bf9ced8b45b4c5d494acae119a174ee974..5507dc25da24e0c6b030ac5563d663d70d013671 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -686,11 +686,11 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
 
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
index 6ac121a956f30ee2b1295a1e822395a99a3f6d36..b125f31c1bd5c0d49e07247cb9ce46dfcea5b075 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2111,7 +2111,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis);
+    load_res = qemu_loadvm_state_main(f, mis, NULL);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2461,9 +2461,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
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
@@ -3064,7 +3064,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     return true;
 }
 
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp)
 {
     uint8_t section_type;
     int ret = 0;
@@ -3073,8 +3074,10 @@ retry:
     while (true) {
         section_type = qemu_get_byte(f);
 
-        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, NULL);
+        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, errp);
         if (ret) {
+            error_prepend(errp, "Failed to load device state section ID: %d: ",
+                          ret);
             break;
         }
 
@@ -3082,20 +3085,20 @@ retry:
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
@@ -3105,7 +3108,7 @@ retry:
             /* This is the end of migration */
             goto out;
         default:
-            error_report("Unknown savevm section type %d", section_type);
+            error_setg(errp, "Unknown savevm section type %d", section_type);
             ret = -EINVAL;
             goto out;
         }
@@ -3169,7 +3172,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, NULL);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3243,7 +3246,7 @@ int qemu_load_device_state(QEMUFile *f)
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


