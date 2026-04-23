Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B57F99362
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 09:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqcS-0007Re-ED; Thu, 23 Apr 2026 05:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prtyagi@redhat.com>)
 id 1wFqcP-0007Pa-6l
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 05:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prtyagi@redhat.com>)
 id 1wFqcM-0006qd-JE
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 05:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776937502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QmkogQDdECBhNaRQBes03dQMuEaKIs7Fl8qVdGf49BI=;
 b=jJD5ifHTzpiuN7QobPdatcGXOwVZ0r4Gshi7xL1Mf0JdPmr/qdwnrVjhrpwlk0DT4wF/3g
 a4FLYUuruu2flf9y7WAgTkUOfDZGcAi79OOf2iv9V8JADUisavRZ33cSGyWDZ6vXkQKE+y
 Vbrhm1AtAZNZpR1YDA34Sn/+umj7neQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-NV_2cQlmNGeL2ZQRewiZvw-1; Thu, 23 Apr 2026 05:44:58 -0400
X-MC-Unique: NV_2cQlmNGeL2ZQRewiZvw-1
X-Mimecast-MFC-AGG-ID: NV_2cQlmNGeL2ZQRewiZvw_1776937498
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c70dd30025fso8103981a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776937497; x=1777542297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QmkogQDdECBhNaRQBes03dQMuEaKIs7Fl8qVdGf49BI=;
 b=lP88nE3BTAZd07uoepU9IDiW+RwdfT09hIZpdAAyr7ZbXz4hgR+paGtWQMcwW78UNH
 quiIGwMDSOgHHRDHPq+5qCS1ENrp58MGHfrNPcT0At5t6krpgK5LlJWMMKUxVYEZW/Ox
 +2+7hUeVQWtd0mfQtCHUAZaW1949HhhFVIjDgqEzM5heTM8NeFd2EbhRfVUTH6Iu3u2x
 3ZIXMB8vdNbZW6DjnmoRcYFJJqCJ53zku2WCTrnv+Nz/CLuUJL0XaqJfHmmdJOAFllrC
 buZGKSGgMLpX94iGXVcL118ajtTb0AiqRSjilVfIp5CKj4BijcvcQfY2xH7CE3gW8Uxo
 hz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776937497; x=1777542297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QmkogQDdECBhNaRQBes03dQMuEaKIs7Fl8qVdGf49BI=;
 b=PRXRM4YV3TqAI8iA1N+pl8QPllayd/95lXv61RTBcAbN6OokJmscbnD45mAfYNxdpP
 5XTnbS1nxJEDJcILMVqoMS0umqqpZ4S05EdW1BsQMYixg3+CS7NRIoYS8xhyjloBb5w8
 8Mktlv42t8Ie1FkmgdrG5QWuJFA6tuX9YtigtRFtlY1DvYRVL6+Ei3WwQSjRSIgDifta
 uPvev4AmfQ92sMUeiTY9yMRM03Ley9nD9qlY4dDuLLUdBstTIAa8/l3iymFtdYihxQwc
 uswZ+4zLpgdmctFAcBwkXJHF373PyKf1rykh6CJ3c8iK+EUI2uyWnEFlBiwAKFAvOg1d
 xcYA==
X-Gm-Message-State: AOJu0YzKL1trHfstfUtC20RNUmuDDdKxhFRRXDLgyrqcNvtfRylESvyw
 wm5h0VL8mNgwYITqPOhIJDgawqGd6BV3hK/UlqdiFY0soS0rRwJoKIbnP2BgR634uV5tNpBc2rs
 AsI40A9vT761gmBUpNiWZAMX1NAhoHQM3azNxez3qnhaoxth62n32eQUYZD1UvNg9FdzNwh2iyi
 tOYxTlNUhV6qxxVtZBFnffAtpDIT9q+zTOkLIV0Vw=
X-Gm-Gg: AeBDieuy/NAdcVaRuS7td1TrDrV2Mj5tvD3y6S+RXqsvRLYjxPvrNal/SC2rgZtrMS1
 7XrknPuUcF7GLwgRiumVQYDSK/GLtE7Q41Zb03unNDmIDeua2Mkj1p1BhNLbnWFQH6Ol8zrczUa
 OxSG8vk/H5nKyiaxMrARyEaqmAg7ARNunxhh+5ij5BsYoWsKtQlppqgh5aOMq08+aTrhasjC3Dn
 Ac4ziVR8cKjOqjf2iOIXOFVGNlTTmjIQq0G0hysDRq8g65+AMLnOuQeYucKrdRcG8InisW27g3u
 5Tj7hwDKw67QK2fX+KVET1uU/qgllaJuJTbNbN2VZNbQDP86rp+5DW96En0Bv5LbJ8el3gwMc0r
 AyveYv97gXmID8+Qc3ZMcz4Xab6dNxSYCK7DagblK4CkcywHDi20BSYMMIUnFPnCBZ6GY
X-Received: by 2002:a05:6a00:17a0:b0:82c:f877:3d13 with SMTP id
 d2e1a72fcca58-82f8c8c905dmr30448290b3a.26.1776937497044; 
 Thu, 23 Apr 2026 02:44:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a0:b0:82c:f877:3d13 with SMTP id
 d2e1a72fcca58-82f8c8c905dmr30448243b3a.26.1776937496446; 
 Thu, 23 Apr 2026 02:44:56 -0700 (PDT)
Received: from prtyagi-thinkpadt14sgen2i.bengluru.csb ([115.110.236.142])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe6439sm19906405b3a.41.2026.04.23.02.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 02:44:54 -0700 (PDT)
From: Pranav Tyagi <prtyagi@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Pranav Tyagi <prtyagi@redhat.com>
Subject: [PATCH v2] migration: Fix blocking in POSTCOPY_DEVICE during package
 load
Date: Thu, 23 Apr 2026 15:14:38 +0530
Message-ID: <20260423094438.43556-1-prtyagi@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=prtyagi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
---
V1: https://lore.kernel.org/all/20260421052227.8278-1-prtyagi@redhat.com/

changed in v2:
- removed postcopy_package_loaded_event and using rp_sem to kick the
  migration thread
- using migration_rp_wait() in place of qemu_event_wait() in the
  migration thread

 migration/migration.c | 48 ++++++++++++++++++++++++++++---------------
 migration/migration.h |  1 -
 2 files changed, 31 insertions(+), 18 deletions(-)

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
diff --git a/migration/migration.h b/migration/migration.h
index b6888daced..9081e6a612 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -512,7 +512,6 @@ struct MigrationState {
     bool rdma_migration;
 
     bool postcopy_package_loaded;
-    QemuEvent postcopy_package_loaded_event;
 
     GSource *hup_source;
 
-- 
2.53.0


