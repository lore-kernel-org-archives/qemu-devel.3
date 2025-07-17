Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A53C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCjj-0003EX-1l; Wed, 16 Jul 2025 20:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCgw-0005Bp-45
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:41:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCgu-0005Fq-Hd
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5XKbRcRSIPCBZNmfvG6TcJ0FmgcNEAJ0e0/ZYmU+Hw=;
 b=Ied3NSvLSUVf3wOc1fxq23ce2RrDrSgmEErBB8U35COpB9fRvcc7Cat3yT5ZPT8L1see0V
 L4eEQYXp5XF8KCTtJtWLgKnsbNz4rjmvnf799pOeDjrlymDytVB30lK4wFpWZteRKqOYbT
 yI/9uQBrSAxgDIbkmhH6FOke6H9Qi9U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-DPYzVHS-OnKJ-Of1AH9Btg-1; Wed, 16 Jul 2025 20:41:38 -0400
X-MC-Unique: DPYzVHS-OnKJ-Of1AH9Btg-1
X-Mimecast-MFC-AGG-ID: DPYzVHS-OnKJ-Of1AH9Btg_1752712897
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2356ce66d7cso5213665ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712897; x=1753317697;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z5XKbRcRSIPCBZNmfvG6TcJ0FmgcNEAJ0e0/ZYmU+Hw=;
 b=r/U9wswyYuliz2PCDGrVu89arYRpTlUxfWZhrlGTAgqBftO6ssqMnAsiq+x3rAtI9T
 snaEaCznSinCp3PjebMnHUfMXgVStijduDcCOI1NWoC5ABciQ6+TwM/XQrmabKbjRtcA
 HbbfKXdlXJ87862ZQnSMJ15idhYYt/V/wwH5KZCyrtKJkQrlhQx1CpVpXo/XYuactfHb
 8K3aZPZDzE0LWJB9BE1OzxbRsIIhUwQLA4+QmfuGUQNY7upLxtVeA3sOdFc4oPuJ64T6
 nPPpv4bSWlF1Pc/YoMt1lAbx2IIJpkeO6BN3i1sGn1HnInDKENt3M3atKJyI+ywYG58e
 HtVQ==
X-Gm-Message-State: AOJu0Yx2i3ccdDETWTvN8xi+/0fXlityPXBFcCqnAJapxjCQzJJRQo9k
 0VTUAonysomy7SepsIeMdNt3OiSIv/KMh+u/eiZBxMqsfy1ssYBKu0s5jWp6ifPePRM9jHjLskz
 jBDxdxVb/e0mZO+DPx5lUistl/T+gE1HtxRIE+ODAG66YKX7N8u3rw79j
X-Gm-Gg: ASbGncv1VyHoBfN9v3pLMftH2a5Ag05f3Y6Bv0BJycIADg5aio3FsrxJrXPINwinbwJ
 2QWIzKbHK4rYoO2LwUp1bz4piBtj4B1ILzAC09ZDW73NYO2ukZjaZhi92EdAR0aBpeycusS017+
 iBLYW6sDf+W1ZM5w8iX38iEF0asfueSnWv+qEm3j+hIBqN2QN54HwnIOX5WldlV3JeRTztGd+TZ
 tHGO8bnJePOAByFqNyImBegcsHIYTk8j66H+8DwX9+yoAKjngBep/CtduTPxhkG+iT/dCSg/1fe
 nvrFScgn/uJcZn59cGEKwgJPyOE7u5wU4DEqAZVyXplxio3jHg3I
X-Received: by 2002:a17:903:1aec:b0:235:efbb:953c with SMTP id
 d9443c01a7336-23e256b745bmr55392335ad.13.1752712897265; 
 Wed, 16 Jul 2025 17:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGA4FWETPFJustoxpuHyML6tDOdokn2/vIAfMCEAUjHvcCxyneKgsGYQHeYOwDZ/E069jmaA==
X-Received: by 2002:a17:903:1aec:b0:235:efbb:953c with SMTP id
 d9443c01a7336-23e256b745bmr55391965ad.13.1752712896776; 
 Wed, 16 Jul 2025 17:41:36 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:41:36 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:41 +0530
Subject: [PATCH v5 18/23] migration: push Error **errp into
 qemu_loadvm_state_main()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-18-1f406f88ee65@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5659; i=armenon@redhat.com;
 h=from:subject:message-id; bh=huL4+4k5Kd2px2iKHFS0kvTDdFSUkaFe+Dk0aOZFwn8=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm1J8S6vsLo7n1tF1X11Ewhnfyk50F3C2Vz7xWSRRb
 7+Q08mOUhYGMS4GWTFFloavAbJNAYURkbYvr8PMYWUCGcLAxSkAEzGrYGR4xzBn+wUpn735nf+X
 iPR5u7z/kfZ8pcN5q+8mf48bX63OZ2T4MC3zXNBby7bF06O2ePXuOL/zcqmGP9dUl9Saj5+u3jj
 MAgA=
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
index a23c242a5f05f85a8544924c464480810995815e..47c656734248c2b7a6d2001c6ef9b3e83af11bac 100644
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
@@ -3055,7 +3055,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     return true;
 }
 
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp)
 {
     uint8_t section_type;
     int ret = 0;
@@ -3066,6 +3067,8 @@ retry:
 
         ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, NULL);
         if (ret) {
+            error_setg(errp, "Failed to load device state section ID : %d",
+                       ret);
             break;
         }
 
@@ -3073,20 +3076,20 @@ retry:
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
@@ -3096,7 +3099,7 @@ retry:
             /* This is the end of migration */
             goto out;
         default:
-            error_report("Unknown savevm section type %d", section_type);
+            error_setg(errp, "Unknown savevm section type %d", section_type);
             ret = -EINVAL;
             goto out;
         }
@@ -3160,7 +3163,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, NULL);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3234,7 +3237,7 @@ int qemu_load_device_state(QEMUFile *f)
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


