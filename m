Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5782C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzg0-00044S-Ab; Wed, 16 Jul 2025 06:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzeb-0001C2-1X
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzeZ-0000pt-5X
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+s8VOtQBo1DDT5OJzSaKYdlzOG4iVU4H3ZmsSNzEGcc=;
 b=Pu9ZCSaZv7vUE23fUnm7D5lhesNLm56tcHWoCuT2l6QErAH8iOzfIUi5fwN7xMlbwwwCA7
 NCEGFAase2W90aM/cYM/lDGcVvY6dW50DWf34dQxaCTh00S93Vb+3at/EsqZ1eaCFFLX8Z
 ZXyTqoV7K7bezDKea78PpS/L5Vg+NPc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-BsV97s99MjiW_iJUReE-8g-1; Wed, 16 Jul 2025 06:46:19 -0400
X-MC-Unique: BsV97s99MjiW_iJUReE-8g-1
X-Mimecast-MFC-AGG-ID: BsV97s99MjiW_iJUReE-8g_1752662776
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b31c38d4063so4634517a12.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662776; x=1753267576;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+s8VOtQBo1DDT5OJzSaKYdlzOG4iVU4H3ZmsSNzEGcc=;
 b=UkB0Q/sIxGpOp9HnPIIDb1jmB1wKkuj6Ji7gDxJ0ulh39irg5AQrujztMcjcIDxo19
 z4nIvLXAwdC1xvGXZZQeAjUgCtq6ecRWHIlEHGtWPWF4FVOs4Rc+zas2AGndUSwgJwmp
 FTWtMbJi0FIbw0tYapj/55KQj8zr/1o6CyNkUWfAVeXtTKTulTSyTzmnVhDOhrQxBL+P
 PVufJRwM05W9QU+VVhIHxpgvX42vpqYq3Xh8mDCUlsur13xD/EHiTym2IJLeNUf/vqpv
 4u0pOJJ5HPVdEsU6B47wCfFcCpTBRcmVcxQl9HNg4nYJsMCFyfKi3ZmrI7lbwj4bOVmo
 8xLQ==
X-Gm-Message-State: AOJu0YxKdIYG/FG6xdUkVSXRL+draDnRIrvVSGwFab4dSMgTIVrtCAbi
 8JUjJEvgschZRNALyK+c9y7ONm3ztUQPF4fYvN6w8bT6vBSc0Wrx1tzN9pOuWe5cL9T5Fxk9Z64
 mJQN6d3M+kivIaENpTt2hiDLrixq4WtB8k5k/lJKqyNG4oqvTzK0qD4KD
X-Gm-Gg: ASbGncsEK3wKYiuozCP1yuvadJTbZ9dEyPhCRqsq+Y67JruziVHVaqJPBxrpeTbrG6N
 dIbP0wAatp+PoGngh6mTwEdYw+uZ+sAIqnF69qGiCQBlJJDzAzKZ5HiUG72dLGtvQfx4QIbbcBS
 yUlrmEHwK8ATtniUUVBfTMizJOhBQWAC2g73dzA7Zl9jSsB96a1kDbVwbDG4q8v9knZR4bjq0ua
 eMYETjfwwTX9ljDM393TvcVJc6n3gi0/NjV6p5TFwqjfQFYAmUOPdDbgsE56PZsH+hrWnt6a2A7
 2PazQGGcJytuoMHZy00KkRJBzuGvYjuea9bMhR9hgOsO3kxZFg==
X-Received: by 2002:a17:903:1b66:b0:23d:dcf5:4806 with SMTP id
 d9443c01a7336-23e257660b1mr32960415ad.39.1752662776307; 
 Wed, 16 Jul 2025 03:46:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFruylMfKWUTkVhMLhwaq8Wv3c0tax0Czez8cQh6KwHXnFzKySKXUQPEkQNlLrwUtQQs23OgA==
X-Received: by 2002:a17:903:1b66:b0:23d:dcf5:4806 with SMTP id
 d9443c01a7336-23e257660b1mr32960075ad.39.1752662775889; 
 Wed, 16 Jul 2025 03:46:15 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:46:15 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:13:11 +0530
Subject: [PATCH v4 21/23] migration: Capture error in
 postcopy_ram_listen_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-21-7141902077c0@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2959; i=armenon@redhat.com;
 h=from:subject:message-id; bh=lu7xXVtFHa1noBo1jhpSYKEZ7yIUkmDW0KN3tHXLHsM=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k8PG+1rtkt+vK/2c+KGKyzzVN8p84ufqWWdbdzMeX
 RxaH1vfUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCJKpxkZbtx1L1SaeOFI0stD
 J/0ftNzq437pO9382Fm26uLLBzbrsDD8MzNMTdHSfCQeVO4z583St/su+XIsYJZPOVtgYTCrPO4
 HLwA=
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
postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
to load the vm, and in case of a failure, it should set the error
in the migration object.

When postcopy live migration runs, the device states are loaded by
both the qemu coroutine process_incoming_migration_co() and the
postcopy_ram_listen_thread(). Therefore, it is important that the
coroutine also reports the error in case of failure, with
error_report_err(). Otherwise, the source qemu will not display
any errors before going into the postcopy pause state.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/migration.c |  2 +-
 migration/savevm.c    | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1f0a8bd6ab28ff09bb76919564bdbfbde35c5e42..efd02d917cfe4d1221907123eadd98932b02e8bc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -925,7 +925,7 @@ fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
     migrate_set_error(s, local_err);
-    error_free(local_err);
+    error_report_err(local_err);
 
     migration_incoming_state_destroy();
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 71cf69ffeb754c1657256ed9f025aa257e82c00c..62e7b58b2ed26837580eed804d2ec12ff2e42d6f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2086,6 +2086,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     QEMUFile *f = mis->from_src_file;
     int load_res;
     MigrationState *migr = migrate_get_current();
+    Error *local_err = NULL;
 
     object_ref(OBJECT(migr));
 
@@ -2102,7 +2103,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, NULL);
+    load_res = qemu_loadvm_state_main(f, mis, &local_err);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2128,7 +2129,12 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          __func__, load_res);
             load_res = 0; /* prevent further exit() */
         } else {
-            error_report("%s: loadvm failed: %d", __func__, load_res);
+            if (local_err != NULL) {
+                error_prepend(&local_err, "%s: loadvm failed: %d", __func__,
+                              load_res);
+                migrate_set_error(migr, local_err);
+                error_report_err(local_err);
+            }
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }

-- 
2.50.0


