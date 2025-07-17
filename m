Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D379C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCjY-000243-Ho; Wed, 16 Jul 2025 20:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCgi-0004p1-De
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCgg-0005Cx-Qo
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDj/wtayEVOjkCSsF9x+nokVDf08/XjnCG/dG5JwO4A=;
 b=NF5VE01wALWojQyDDjJsYwSPW1owXGUAbQEcgGy3/pMBb2u+SrjpCCfxIyLJugnvMxcwVc
 PlY9XsIvmVf9kM1YHnABAsYtFAIc1nHv2fbEwijqB2807I/TubU1UvBMeL+1l4APi00L++
 gT+7sRV1Ha4JI0DoH3P1ZHxLUm1o+2g=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-fTYDJzOyPgmw6vttHC7MKg-1; Wed, 16 Jul 2025 20:41:21 -0400
X-MC-Unique: fTYDJzOyPgmw6vttHC7MKg-1
X-Mimecast-MFC-AGG-ID: fTYDJzOyPgmw6vttHC7MKg_1752712881
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31327b2f8e4so369697a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712881; x=1753317681;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDj/wtayEVOjkCSsF9x+nokVDf08/XjnCG/dG5JwO4A=;
 b=xA66ld1mfW6UsG6AA6SYG0ICmYN9L3pT2C6wJIsMGLbLLkV6G4L4JAiD3MYRPAB/SL
 QNByuLhLHQVY85j8Tm1fJqqOB4ksVSxHeUce15LLbxQH2yYk8p/ZDgn2dQ3lgQm4HHkl
 /2K+VRAlFfWUr/4c3GEe7qWrOon3asaxu+xooNspERXJdcujLeNjYsEMgiM2j7qIwuCw
 pJlq4p22WTcOIxvdiHEXo3Irq2JhMNsR/OHD2bDX/9HmI+P5dT1vuXykL1FxsSazQUGg
 O2lA3K3NgV2pgFiplAvRYY4AWMkqr3I1+2rd34mUDv1Wwd5ls5kYt28NPSdRYwp6V+Ni
 q/Wg==
X-Gm-Message-State: AOJu0Yxxat7/Zw2PksGGm3Xkl3G841yZh0KKswE1Dxrz3PaDFzXbslyP
 uqhRTIaPn5hJyDuNr5mjSFsbITS7682ATyeMFVDS9Q5ip6bwFACfMp/O6LdVmpkN6U4IAMNb+mu
 32fyL1h7dJJPXVWOmklEz9m39rf66GkUWTG5FXi7iLXl3fF06gxg34Ql0
X-Gm-Gg: ASbGnct9fGqHtq+wPx2zDvLy8MhUANECtPwtCo0FsK5zXZ7y66Q3F/mysVZR4ZcO5ee
 4d8mtoWipyf/OdFUO5H9S/7rGPqPgkKnu7gSl+Ri1P1hmhcEdax5Q1CsMhAHwez8E1RpYzK8Glz
 1gwLrNUA7256tCkjBVJQb/YnA4vbZ4e2Lge1Z6jffLYvTJLX9gvf5KrmsvZcqhRf89Dw+xrODHy
 gfwP6qTeCeQbKu+KjVok9IlPlZ4W8qY3WN7Y0ji4ziMNmiZ2+VZgD1rQiklvLDgJ2d6g681RObZ
 HVCWO7aEZmzTKG7V74a7knVnSuj0KAAE9nTrla+J81bVZIFS3THv
X-Received: by 2002:a17:90b:58c7:b0:312:ec:412f with SMTP id
 98e67ed59e1d1-31c9f3df46fmr7458194a91.14.1752712880774; 
 Wed, 16 Jul 2025 17:41:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw+lasrN7QYCyqOgSiyDcvmdmT2lr1I9gXu0TRH75yYPPuQuz/WOxAcJ0r7bygF6BzsCkz9Q==
X-Received: by 2002:a17:90b:58c7:b0:312:ec:412f with SMTP id
 98e67ed59e1d1-31c9f3df46fmr7458168a91.14.1752712880404; 
 Wed, 16 Jul 2025 17:41:20 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:41:20 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:39 +0530
Subject: [PATCH v5 16/23] migration: push Error **errp into
 loadvm_process_enable_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-16-1f406f88ee65@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5924; i=armenon@redhat.com;
 h=from:subject:message-id; bh=XTF8YhWTohyOlAIQAVl80eGdE/tvsmYDAEuXU2hlVR8=;
 b=kA0DAAoWanolONkPMo4ByyZiAGh4RiGimX19HdPuM9nrQVq+BLW2N3Lei5mQxm18i9gxYHLLf
 Ih1BAAWCgAdFiEEgPVQHYJQcVhZPenXanolONkPMo4FAmh4RiEACgkQanolONkPMo6xWgEA7Qtk
 kNjziq0nwZCla/I2EYWu0THtCvqHLsrtBjUBGEoA/RttWjjm6FoX33QPq3D6JFbIkm1wji8DPG+
 qrcTUvsMM
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
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
It is ensured that loadvm_process_enable_colo() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 include/migration/colo.h |  2 +-
 migration/migration.c    | 12 ++++++------
 migration/ram.c          |  8 ++++----
 migration/ram.h          |  2 +-
 migration/savevm.c       | 25 ++++++++++++-------------
 5 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 43222ef5ae6adc3f7d8aa6a48bef79af33d09208..d4fe422e4d335d3bef4f860f56400fcd73287a0e 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -25,7 +25,7 @@ void migrate_start_colo_process(MigrationState *s);
 bool migration_in_colo_state(void);
 
 /* loadvm */
-int migration_incoming_enable_colo(void);
+int migration_incoming_enable_colo(Error **errp);
 void migration_incoming_disable_colo(void);
 bool migration_incoming_colo_enabled(void);
 bool migration_incoming_in_colo_state(void);
diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25dec01f206eacad2edd24d21f00e614c..326487882c8d41e2f89f99f69df0d9d4d42705e4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -623,22 +623,22 @@ void migration_incoming_disable_colo(void)
     migration_colo_enabled = false;
 }
 
-int migration_incoming_enable_colo(void)
+int migration_incoming_enable_colo(Error **errp)
 {
 #ifndef CONFIG_REPLICATION
-    error_report("ENABLE_COLO command come in migration stream, but the "
-                 "replication module is not built in");
+    error_setg(errp, "ENABLE_COLO command come in migration stream, but the "
+               "replication module is not built in");
     return -ENOTSUP;
 #endif
 
     if (!migrate_colo()) {
-        error_report("ENABLE_COLO command come in migration stream, but x-colo "
-                     "capability is not set");
+        error_setg(errp, "ENABLE_COLO command come in migration stream"
+                   ", but x-colo capability is not set");
         return -EINVAL;
     }
 
     if (ram_block_discard_disable(true)) {
-        error_report("COLO: cannot disable RAM discard");
+        error_setg(errp, "COLO: cannot disable RAM discard");
         return -EBUSY;
     }
     migration_colo_enabled = true;
diff --git a/migration/ram.c b/migration/ram.c
index 8223183132dc0f558f45fbae3f4f832845730bd3..607c979cc15a3d321e5e3e380ac7613d80d86fc9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3576,7 +3576,7 @@ static void colo_init_ram_state(void)
  * memory of the secondary VM, it is need to hold the global lock
  * to call this helper.
  */
-int colo_init_ram_cache(void)
+int colo_init_ram_cache(Error **errp)
 {
     RAMBlock *block;
 
@@ -3585,9 +3585,9 @@ int colo_init_ram_cache(void)
             block->colo_cache = qemu_anon_ram_alloc(block->used_length,
                                                     NULL, false, false);
             if (!block->colo_cache) {
-                error_report("%s: Can't alloc memory for COLO cache of block %s,"
-                             "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
-                             block->used_length);
+                error_setg(errp, "%s: Can't alloc memory for COLO cache of "
+                           "block %s, size 0x" RAM_ADDR_FMT, __func__,
+                           block->idstr, block->used_length);
                 RAMBLOCK_FOREACH_NOT_IGNORED(block) {
                     if (block->colo_cache) {
                         qemu_anon_ram_free(block->colo_cache, block->used_length);
diff --git a/migration/ram.h b/migration/ram.h
index 275709a99187f9429ccb4111e05281ec268ba0db..24cd0bf585762cfa1e86834dc03c6baeea2f0627 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -109,7 +109,7 @@ void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset,
                                    bool set);
 
 /* ram cache */
-int colo_init_ram_cache(void);
+int colo_init_ram_cache(Error **errp);
 void colo_flush_ram_cache(void);
 void colo_release_ram_cache(void);
 void colo_incoming_start_dirty_log(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 1cbc44a5314043a403d983511066cf137681a18d..755ba7e4504d377a4649da191ad9875d9fd66f69 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2510,15 +2510,19 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
     return 0;
 }
 
-static int loadvm_process_enable_colo(MigrationIncomingState *mis)
+static int loadvm_process_enable_colo(MigrationIncomingState *mis,
+                                      Error **errp)
 {
-    int ret = migration_incoming_enable_colo();
+    int ret;
 
-    if (!ret) {
-        ret = colo_init_ram_cache();
-        if (ret) {
-            migration_incoming_disable_colo();
-        }
+    if (migration_incoming_enable_colo(errp) < 0) {
+        return -1;
+    }
+
+    ret = colo_init_ram_cache(errp);
+    if (ret) {
+        error_prepend(errp, "failed to init colo RAM cache: %d", ret);
+        migration_incoming_disable_colo();
     }
     return ret;
 }
@@ -2641,12 +2645,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_handle_recv_bitmap(mis, len, errp);
 
     case MIG_CMD_ENABLE_COLO:
-        ret = loadvm_process_enable_colo(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
         ret = loadvm_postcopy_handle_switchover_start();

-- 
2.50.0


