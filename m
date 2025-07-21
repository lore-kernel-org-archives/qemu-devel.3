Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F14C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udonB-0000cG-9B; Mon, 21 Jul 2025 07:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udokn-0002nO-Vw
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udokk-0001A2-Fn
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4QzxpgcLnGLas7DvgDqYZQjE07sC2RqyIhjhZQGHIg=;
 b=fr0qMTHVubQbP/2ZhmL0+K9TRIz29+AKuzMfAcEF0jwWNGn8o/Usi7AOVOHzWDRz6FzPvW
 uNdUW/Lt/wKPg/wJy/QKDSSKjwwDKjmhlBnW8QrMnBWSzOAK51GOBVPh7ojyLxtVRNUPjm
 BIPP/8xG1Qmf8IiRZYlHykfd4PPFsGQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-nlxZ1FMaN6e3LVrVeM-6oQ-1; Mon, 21 Jul 2025 07:32:15 -0400
X-MC-Unique: nlxZ1FMaN6e3LVrVeM-6oQ-1
X-Mimecast-MFC-AGG-ID: nlxZ1FMaN6e3LVrVeM-6oQ_1753097534
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235dd77d11fso42007935ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097534; x=1753702334;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f4QzxpgcLnGLas7DvgDqYZQjE07sC2RqyIhjhZQGHIg=;
 b=rZb1VaH2HJ9ALhIEmgO8WAZ/xikO4UvuqZItYSwJmDV606zbLP4MoaXbNm0+zc1YpV
 66xwiKOcpI56/QOBChREUdhLukgxM/jIC2EhFm5PN3b0Ut74uosp47F88KPhne8LM8ZC
 vh9i35GEdYIYmRM4ZQKbI8JNPw3322yRb/+9zLBMiy+nTdIQ4qbaIYunSee/gtwx7K6H
 498qpEah9T5w8SwIlOfI0+MBeUSDY+6IUra6HE6kKQKNmOk/fdeM5mMehe/00IY5Joth
 6OX6jl/ssQygl+7gxVULOHBAdQQ6L1WaFnoOmh8e96DxIVL/5gua2hXrsQd1GF/Da8NZ
 ZTsA==
X-Gm-Message-State: AOJu0YyvRScER54T1etB09mpyLkdNH3QJytP0ulg2SRDmx5ET3qwj1HR
 AZUT/CPBW9dsd4heWPs5k1jiFxdBmOSBl28OjEKOHpJ0NZtCbddmP8QymMntST7pbbFL2z9jHQ1
 Au7pcweZfDexLpZvq4EvNTtpMOkXMbmYgP4QSfYU9NUaK8sDP73GLlXKJ
X-Gm-Gg: ASbGncvZcQvMZXFfGhMtL/YeIuahjo+NjSt6nwbPVAsyUDmgiBnfZjzinGytKbnapyk
 x4SoSOcjwFTv3A+QFM608+lPCxPdUCK6r2f0BzbMmqfJuPjLT/u/0+n4k01N5G0lWJ85jn9x//b
 1jHbWmNiQt7ecV06SKjaAqbY2mCOZ6BEH8U7tghu7EizcBfVf3oHIUGZX7J9Xam1eqh6qCRg0da
 cZ82QN1X4xpwp/E49FFzKAJnwz+c0tamQOarN0+NWb4D7obTLLClXiGvWcJEGwM1VEcLzFBqUO3
 LTFDeS7ouiFRRGMcfL2e0Dw3eNe82pjGkl/TT2XjctGFQsTHRz9o
X-Received: by 2002:a17:902:f68d:b0:23d:ddf0:c908 with SMTP id
 d9443c01a7336-23e25685226mr238406265ad.6.1753097533846; 
 Mon, 21 Jul 2025 04:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFW2BAE9+vDqDZBfRzC14BjyQ78PF8Efb1MQb9Fggpr/yFAn6LfcBzmxQ72UDtXzlDZdSJSw==
X-Received: by 2002:a17:902:f68d:b0:23d:ddf0:c908 with SMTP id
 d9443c01a7336-23e25685226mr238405675ad.6.1753097533363; 
 Mon, 21 Jul 2025 04:32:13 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:32:13 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:24 +0530
Subject: [PATCH v6 19/24] migration: push Error **errp into
 qemu_loadvm_state_main()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250721-propagate_tpm_error-v6-19-fef740e15e17@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5809; i=armenon@redhat.com;
 h=from:subject:message-id; bh=ie8KesUjIS+qK5YWhLytK+ngB39vKddEIpiUnWjtDA4=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adyqTqdfZBc1p+8Cz3rPpooTO/jFtKfo/nxJSA5Kmb1
 TKWnpXsKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMBHzqwy/mE4971+9OiQ7cKWx
 2b6rC8TsrnWWSnu43nzVHbAjzCJhISPDWi7/PcbbKq7ekjj343KTz7FFwm/mswWsbtjWWd2cm27
 LDwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
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
index 981bd4bf9ced8b45b4c5d494acae119a174ee974..03edf870e2bc9c724fc27e26e7ba54a40c13399e 100644
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
+        error_prepend(errp, "Load VM's live state (ram) error");
         return;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 679abf7c668ea7990da10ca8caba09fbb7bdd2ea..ba146f91427f2a36880aadeb16b11ab2b7df099a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2108,7 +2108,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis);
+    load_res = qemu_loadvm_state_main(f, mis, NULL);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2459,9 +2459,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
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
@@ -3059,7 +3059,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     return true;
 }
 
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp)
 {
     uint8_t section_type;
     int ret = 0;
@@ -3068,8 +3069,10 @@ retry:
     while (true) {
         section_type = qemu_get_byte(f);
 
-        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, NULL);
+        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, errp);
         if (ret) {
+            error_prepend(errp, "Failed to load device state section ID : %d ",
+                          ret);
             break;
         }
 
@@ -3077,20 +3080,20 @@ retry:
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
@@ -3100,7 +3103,7 @@ retry:
             /* This is the end of migration */
             goto out;
         default:
-            error_report("Unknown savevm section type %d", section_type);
+            error_setg(errp, "Unknown savevm section type %d", section_type);
             ret = -EINVAL;
             goto out;
         }
@@ -3164,7 +3167,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, NULL);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3238,7 +3241,7 @@ int qemu_load_device_state(QEMUFile *f)
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


