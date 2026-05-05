Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B23FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMM1-0004Mh-Cn; Tue, 05 May 2026 16:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMLz-0004MG-Oz
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMLx-0002ZV-9e
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuOw5wi626TK+F1PhtvnlgO8EB6xWCZ2vQsoxWAJJRo=;
 b=RY2cdt8G37nzNk4U+kKXf7kRWmpz5eV3026N2D/Ed8kyYbgG5vKdmCLpHQulTXmdfPApNs
 DOYvpYftSO43WBQOS9UuV5keth+sNoJ+qAxwuHU/izzJhvAK3VA2QVGw8xYelgUEccejEc
 TtMhA/jWyEut2A+uhEKPcb2GwaNMa2U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-xlykXANvMiWEnLvXX42xqA-1; Tue, 05 May 2026 16:26:46 -0400
X-MC-Unique: xlykXANvMiWEnLvXX42xqA-1
X-Mimecast-MFC-AGG-ID: xlykXANvMiWEnLvXX42xqA_1778012806
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b552610488so80551246d6.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012806; x=1778617606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cuOw5wi626TK+F1PhtvnlgO8EB6xWCZ2vQsoxWAJJRo=;
 b=mG2GN8G6WX9raPPUTRsh5YP+Cov9NaUiZoufpWhFXcLN8quN/RM4jwSv58GTv6iCTW
 WZe929D0852XLWDo7ZC+BuwkMZHHBKrqFkCgdT0zPo9L5ASJuGpc1RC6a7fsoGQG8IQZ
 0QVDmL4kPtt+LmK6uUJVtat0YVl0mbKnPP1X+9O+TQ/udqJD/3Ympg6+jWjEwA7mfbt+
 U3iB9rwhX3TL2bjGxTTXGMGiNYtx6ZNXsXbt4hGrVcCJXKOJSifmCyLlvx1Lk0rdTtfq
 2DhIJFCqnH/yjH81gQZ6sg76gaGDBQ24sSFRaLj5xhIOUeHmp7Iy2YzutibZY8zUxIv5
 jH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012806; x=1778617606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cuOw5wi626TK+F1PhtvnlgO8EB6xWCZ2vQsoxWAJJRo=;
 b=HNTmnXpQWJn3UgiesMqEg8N+sF95ZoNYTaZ3rgZ0OKAZRJfe2gm8YkIX8zK+NMrciQ
 1imDLa9a3DoK93Vm4oV+ZnYO0S4iYpmSaIlOSU3SKCxLmzN/CXbrZFpmaPxz2/fex+m4
 5xXDKk6jb+/9RM4+g8D5+fRdXhFgItMQiPXJPEnEA9AVgta4wz48qnOO3m67oZ/LDK+/
 2VPMoq0oiedbIzXq6cRxClkc5I9u1RCMORjfWYSloE6jLNezTB4S9kzrIlbRVfkw543T
 JZEdG79YqusUCa1cwPAnLu5uaymNnQfE+F4++ZNLRJcrk8p3V9Ws5pXDT3OlADn7y6wG
 MhhQ==
X-Gm-Message-State: AOJu0Yw0da5O33hlR9T6mdYcqOckZ/6kdA7sziz7rVq4Z8XTbnv+OBph
 M2xB3DpHBnkkTiXuJoPZMp8CIiqRyJfi9BPoLKQtcP+jpGMDUxp0Z61jPHs9Sj2EBOAZKTPBOCO
 eO2XelpjLR5gjgsjxvrVlMDCvrrkQKDcpdpgbqSQo/RRkC+yBbTjzFegDPcoWJBSFzldYf3utfU
 HlmQugHg8+kD3B2a1PodUbi0YRytv98V6FSjmzPw==
X-Gm-Gg: AeBDiesiXnZEmA2w0V0IcRhIl7g5ZDuSTTo24QvIO2THcaIHspqRshdnh58vT/fDBpp
 pJx356LYnMWi5k2Tct4xbDC7mwE8e7q9H1J4mTR0q0aMvVBbiddQ5tsMiMkoTbJCFNQWETvInFD
 /lyGU1F0syUu+s7cWXjFFgxobEc5j78mtgiagupVzTP5NIS+kqNJ/cyxDk9uG0AqUkrat8rf0O4
 jeQ7JBOpxEthercy+ub4vb0P+tp020KAL3vo2tUOGPxItr4fjh0y/esJBO6mVZQxRif7zGWI7/L
 GhZEkeb8u1sY4U7ddesY7hVk0PMVALMhXc335bfIQVUabPm0AcK/vNe3YENsIPCwM9MmwnCWXwS
 6MTDW6qy27OynJYvYDCgMJ6tRjXgXYY34ewg+5/pPo83Mtw5rmov7gUA=
X-Received: by 2002:a05:6214:19c6:b0:8ae:62aa:665a with SMTP id
 6a1803df08f44-8bc442dbca6mr4401546d6.28.1778012805746; 
 Tue, 05 May 2026 13:26:45 -0700 (PDT)
X-Received: by 2002:a05:6214:19c6:b0:8ae:62aa:665a with SMTP id
 6a1803df08f44-8bc442dbca6mr4400786d6.28.1778012805050; 
 Tue, 05 May 2026 13:26:45 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:26:44 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Pranav Tyagi <prtyagi@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 01/23] migration: Fix blocking in POSTCOPY_DEVICE during
 package load
Date: Tue,  5 May 2026 16:26:18 -0400
Message-ID: <20260505202640.1011006-2-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pranav Tyagi <prtyagi@redhat.com>

The package_loaded event is not set in case MIG_RP_MSG_PONG does not
arrive on the source from the destination in the return path thread. The
migration thread would then be blocked waiting for package_loaded event
indefinitely in POSTCOPY_DEVICE state. Where as, in such a condition the
source VM can safely resume as the destination has not yet started. The
pong message can get lost in case of a network failure or destination
crash before sending the pong.

This patch removes the package_loaded event and uses rp_sem, instead of
kicking multiple events. The error is detected in case of network
failure or destination crash and rp_sem is set in the out path of the
return path thread. This will kick the migration thread out from a
condition of indefinitely waiting for rp_sem. The migration thread then
fails early and breaks from the migration loop to resume the vm on the
source side.

Fixes: 7b842fe354c6 ("migration: Introduce POSTCOPY_DEVICE state")
Signed-off-by: Pranav Tyagi <prtyagi@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260423094438.43556-1-prtyagi@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  1 -
 migration/migration.c | 48 ++++++++++++++++++++++++++++---------------
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index b6888daced..9081e6a612 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -512,7 +512,6 @@ struct MigrationState {
     bool rdma_migration;
 
     bool postcopy_package_loaded;
-    QemuEvent postcopy_package_loaded_event;
 
     GSource *hup_source;
 
diff --git a/migration/migration.c b/migration/migration.c
index 5c9aaa6e58..6e4988a590 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1661,7 +1661,6 @@ int migrate_init(MigrationState *s, Error **errp)
     migration_reset_vfio_bytes_transferred();
 
     s->postcopy_package_loaded = false;
-    qemu_event_reset(&s->postcopy_package_loaded_event);
 
     return 0;
 }
@@ -2317,7 +2316,7 @@ static void *source_return_path_thread(void *opaque)
             if (tmp32 == QEMU_VM_PING_PACKAGED_LOADED) {
                 trace_source_return_path_thread_postcopy_package_loaded();
                 ms->postcopy_package_loaded = true;
-                qemu_event_set(&ms->postcopy_package_loaded_event);
+                migration_rp_kick(ms);
             }
             break;
 
@@ -2388,16 +2387,21 @@ out:
         trace_source_return_path_thread_bad_end();
     }
 
-    if (ms->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
+    if (ms->state == MIGRATION_STATUS_POSTCOPY_RECOVER ||
+        ms->state == MIGRATION_STATUS_POSTCOPY_DEVICE) {
         /*
-         * this will be extremely unlikely: that we got yet another network
-         * issue during recovering of the 1st network failure.. during this
-         * period the main migration thread can be waiting on rp_sem for
-         * this thread to sync with the other side.
+         * The migration thread can get stuck waiting for rp_sem if the
+         * return path fails to sync with the destination. This handles
+         * two specific cases:
          *
-         * When this happens, explicitly kick the migration thread out of
-         * RECOVER stage and back to PAUSED, so the admin can try
-         * everything again.
+         * POSTCOPY_RECOVER: A failure occurs during a recovery attempt.
+         * We kick the migration thread back to PAUSED so the admin can
+         * retry.
+         *
+         * POSTCOPY_DEVICE: The MIG_RP_MSG_PONG is lost due to a
+         * network failure or destination crash. We kick the migration
+         * thread out of its wait so it can fail the migration and safely
+         * resume the VM on the source.
          */
         migration_rp_kick(ms);
     }
@@ -3226,12 +3230,24 @@ static MigIterateState migration_iteration_run(MigrationState *s)
         if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE &&
             (s->postcopy_package_loaded || complete_ready)) {
             /*
-             * If package has been loaded, the event is set and we will
-             * immediatelly transition to POSTCOPY_ACTIVE. If we are ready for
-             * completion, we need to wait for destination to load the postcopy
-             * package before actually completing.
+             * We will immediately transition to POSTCOPY_ACTIVE.
+             * If we are ready for completion, we need to wait for
+             * destination to load the postcopy package before actually
+             * completing.
              */
-            qemu_event_wait(&s->postcopy_package_loaded_event);
+            while (!s->postcopy_package_loaded) {
+                if (migration_rp_wait(s)) {
+                    /*
+                     * Error happened. Migration thread was stuck waiting in
+                     * POSTCOPY_DEVICE for rp_sem which was never set.
+                     */
+                    migrate_set_state(&s->state,
+                                    MIGRATION_STATUS_POSTCOPY_DEVICE,
+                                    MIGRATION_STATUS_FAILING);
+                    return MIG_ITERATE_BREAK;
+                }
+            }
+            /* Acknowledgement received from the destination */
             migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
                               MIGRATION_STATUS_POSTCOPY_ACTIVE);
         }
@@ -3863,7 +3879,6 @@ static void migration_instance_finalize(Object *obj)
     qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
     qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
     error_free(ms->error);
-    qemu_event_destroy(&ms->postcopy_package_loaded_event);
 }
 
 static void migration_instance_init(Object *obj)
@@ -3885,7 +3900,6 @@ static void migration_instance_init(Object *obj)
     qemu_sem_init(&ms->wait_unplug_sem, 0);
     qemu_sem_init(&ms->postcopy_qemufile_src_sem, 0);
     qemu_mutex_init(&ms->qemu_file_lock);
-    qemu_event_init(&ms->postcopy_package_loaded_event, 0);
 }
 
 /*
-- 
2.53.0


