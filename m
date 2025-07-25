Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1239CC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHTY-0004Vw-8A; Fri, 25 Jul 2025 08:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHQl-0000ab-6o
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHQh-0000Xg-5q
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FspvbSMxmYgmZTg1d8IvRS37ohDRe4YLLWTuHbyvRK0=;
 b=Ab6I5oGRTu4hBYcTeaENwo1dFH3zN7sd+/NmZtK9UXCqgal+f39x3zTtY5RTre9iR/DTGV
 aVpvRefywThLM68BeT5K6fPQe+UKmqDW5xuCtzgmnna7n/KvCUQELYTynk7PIz8dnA8/eT
 v4a4fv/qXS8YrnJ/8FpgTjDKR518LxE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-R-01dVFzOtiaT7hShnhMfg-1; Fri, 25 Jul 2025 08:21:37 -0400
X-MC-Unique: R-01dVFzOtiaT7hShnhMfg-1
X-Mimecast-MFC-AGG-ID: R-01dVFzOtiaT7hShnhMfg_1753446096
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-311ef4fb5fdso2448333a91.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446093; x=1754050893;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FspvbSMxmYgmZTg1d8IvRS37ohDRe4YLLWTuHbyvRK0=;
 b=sMdmITVO310CXzDKysPkory4n4hlAYxVV27sN1QTOh4KokwQM5eElgH9kGm8jemV0m
 /Yr2tSF+3mG0I1tMLh6faxlOmEqE8JWg6lr5pDnv1/pMZ6xYYkBUXyRf2plIKgrVCfLT
 9wFdXtdhlnIKLq7+43mhurPGQecHwHEE9Q59wdxRH8c5HDKIg3c65Qv5UQyTYbix729G
 NL1RMRO/N9L5BnfcQi8Dmm0r9SRCRKGxaRD3A2nx/pmv41y/rjGj3eZeGX+3BDSd+jqh
 v67Bsuv1UijSjpGSEmxoFfJZbsI2WlKfSOvtO8blEEtvwQKjd/rsck1LyPtwrL6Zuebi
 zJbw==
X-Gm-Message-State: AOJu0YwXCY3pGf5NiLZqsAIOfBIZjYxoVcbTTNHQHPGafUXdqRhhFmrA
 SW3yicuiyoSvorendJv9d4lX/lP2VnytAnwAPk7eJH0/rt6Yiv5bHULIOJVnowA7rry/PfFwE2T
 ZuDk0BjEuzTCfqPYDxsqmx5Uegb+1fiOF3A7VUsANJQr8h2Rq4CeBhWqo
X-Gm-Gg: ASbGnctcG5zyx/cmoU5AQX371Kfruqd94shKiaJZubyfQHe077mNBAZXLrSJMnvBY9K
 22/X+J7xtrsvqg9orAB2VnO91YcUgYHLPsZL3V/IOOUOiy8WA5ay/0e+Ef+ZKfCFJH2L1MOU0a3
 59+1pxz1Mw8+KE7XDrwKCfLECuW0Hi2FopVGVju/gbw0lLvUpXEorj8cTyaeuu7AuRKtVp6QD8A
 B0Sgap+7kV/3lXp6odqqDTj1MYkfvt+f8esxHIgFoSk7YSd+33py1VpwOafMPqdiyZ1k3xoZwtr
 N5SpaFGjzvrROyvkksNZbyAp9YY8y91+4IbTO0soW5oxXosg6mtGXg==
X-Received: by 2002:a17:90b:4e87:b0:312:639:a06a with SMTP id
 98e67ed59e1d1-31e77a326e6mr2516027a91.31.1753446092439; 
 Fri, 25 Jul 2025 05:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNpbhJm3pxWPz8u72AoT0FNPQ/+ecSutB39p41ZcTIjJtSUYtkV/IGp2Y/OxvZIP0RRT8Qyw==
X-Received: by 2002:a17:90b:4e87:b0:312:639:a06a with SMTP id
 98e67ed59e1d1-31e77a326e6mr2515973a91.31.1753446092047; 
 Fri, 25 Jul 2025 05:21:32 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:21:31 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:56 +0530
Subject: [PATCH v7 17/24] migration: push Error **errp into
 loadvm_process_enable_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-propagate_tpm_error-v7-17-d52704443975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5905; i=armenon@redhat.com;
 h=from:subject:message-id; bh=j0rTumCTd6RPgknWnxv9rI7OR2oTatn+7tqFjPpKtSY=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0ZzmY5IwqywTN/HvXyaFdr9q2c/lkk7LRzZ+CDh4v1Dl
 6T4lfd2lLIwiHExyIopsjR8DZBtCiiMiLR9eR1mDisTyBAGLk4BmEiECyPDPO7yWTJNxrcUP1wJ
 q0gIfSFeoymkOa0z00498fBeuU0XGRl+H1lcrMvSvqAjePbczTfnLUl89GK97befN1/wToi3O27
 GAwA=
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
It is ensured that loadvm_process_enable_colo() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 include/migration/colo.h |  2 +-
 migration/migration.c    | 12 ++++++------
 migration/ram.c          |  8 ++++----
 migration/ram.h          |  2 +-
 migration/savevm.c       | 25 +++++++++++++------------
 5 files changed, 25 insertions(+), 24 deletions(-)

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
index b3bccaeaee806abd01595863f6475057049b0688..d748a02712dc4ebc2de6b0488fb199c92c4d4079 100644
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
index 6a0dcc04f436524a37672c41c38f201f06773374..995431c9e320f443c385c29d664d62e18c1afd90 100644
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
+                error_setg(errp, "Can't alloc memory for COLO cache of "
+                           "block %s, size 0x" RAM_ADDR_FMT,
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
index 68e62163f70e1c2abcff74b3a2f7a5d2ed546b22..e14e2156a4befec44eaaa992c8621a03e499ea76 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2518,15 +2518,20 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
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
+    ret = migration_incoming_enable_colo(errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = colo_init_ram_cache(errp);
+    if (ret) {
+        error_prepend(errp, "failed to init colo RAM cache: %d: ", ret);
+        migration_incoming_disable_colo();
     }
     return ret;
 }
@@ -2646,11 +2651,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_handle_recv_bitmap(mis, len, errp);
 
     case MIG_CMD_ENABLE_COLO:
-        ret = loadvm_process_enable_colo(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
         ret = loadvm_postcopy_handle_switchover_start();

-- 
2.50.0


