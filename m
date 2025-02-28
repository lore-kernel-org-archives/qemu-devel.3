Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E21C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 12:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnzK3-0004Uc-Mi; Fri, 28 Feb 2025 07:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tnzK2-0004UN-L0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:18:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tnzK0-0001Ha-Mv
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740745108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ymdbOcFU28t6i+NJy7WqEtgrLRGdGbzIInM2PsVA9IE=;
 b=Yqb4U1P2CPSHZ5pGJ9HMDH3dNGgU+akNbP4rcjWY4Ie5d3gvmDMIDVXbt19wyk3QXG4JLM
 4nn1b+FP2j8/o+ejB1cglhsBLoF/LdeUidHC5zUqgrqxD0s9jJzpTjjLO4oDPZVfxbKVoO
 sHaQoZW5jrqn4RRp4C9S3M6Fq3OC9Wk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-IgV3vDqING-v7uF3k0NgJQ-1; Fri,
 28 Feb 2025 07:18:26 -0500
X-MC-Unique: IgV3vDqING-v7uF3k0NgJQ-1
X-Mimecast-MFC-AGG-ID: IgV3vDqING-v7uF3k0NgJQ_1740745105
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 922AE180036F; Fri, 28 Feb 2025 12:18:25 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.175])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B2F2180087F; Fri, 28 Feb 2025 12:18:21 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
Date: Fri, 28 Feb 2025 17:47:49 +0530
Message-ID: <20250228121749.553184-6-ppandit@redhat.com>
In-Reply-To: <20250228121749.553184-1-ppandit@redhat.com>
References: <20250228121749.553184-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Prasad Pandit <pjp@fedoraproject.org>

When Multifd and Postcopy migration is enabled together,
before starting Postcopy phase, Multifd threads are shutdown.

But before this shutdown, we need to flush the Multifd channels
on the source side and notify the destination migration thread
to synchronise with the Multifd 'recv_x' threads, so that all
the Multifd data is received and processed on the destination
side, before Multifd threads are shutdown.

This synchronisation happens when the main migration thread
waits for all the Multifd threads to receive their data.

Add 'MULTIFD_RECV_SYNC' migration command to notify the
destination side to synchronise with Multifd threads.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/migration.c      |  3 +++
 migration/multifd-nocomp.c | 21 +++++++++++++++------
 migration/multifd.c        |  1 +
 migration/multifd.h        |  1 +
 migration/savevm.c         | 13 +++++++++++++
 migration/savevm.h         |  1 +
 6 files changed, 34 insertions(+), 6 deletions(-)

v6: New patch, not from earlier versions.
- https://lore.kernel.org/qemu-devel/20250215123119.814345-1-ppandit@redhat.com/T/#t

diff --git a/migration/migration.c b/migration/migration.c
index 5db9e18272..65fc4f5eed 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3401,6 +3401,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     if (!in_postcopy && must_precopy <= s->threshold_size
         && can_switchover && qatomic_read(&s->start_postcopy)) {
         if (migrate_multifd()) {
+            multifd_send_flush();
+            multifd_send_sync_main(MULTIFD_SYNC_LOCAL);
+            qemu_savevm_send_multifd_recv_sync(s->to_dst_file);
             multifd_send_shutdown();
         }
         if (postcopy_start(s, &local_err)) {
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index d0edec7cd1..bbe07e4f7e 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -334,7 +334,7 @@ retry:
      * After flush, always retry.
      */
     if (pages->block != block || multifd_queue_full(pages)) {
-        if (!multifd_send(&multifd_ram_send)) {
+        if (multifd_send_flush() < 0) {
             return false;
         }
         goto retry;
@@ -387,6 +387,18 @@ bool multifd_ram_sync_per_round(void)
     return !migrate_multifd_flush_after_each_section();
 }
 
+int multifd_send_flush(void)
+{
+    if (!multifd_payload_empty(multifd_ram_send)) {
+        if (!multifd_send(&multifd_ram_send)) {
+            error_report("%s: multifd_send fail", __func__);
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
 int multifd_ram_flush_and_sync(QEMUFile *f)
 {
     MultiFDSyncReq req;
@@ -396,11 +408,8 @@ int multifd_ram_flush_and_sync(QEMUFile *f)
         return 0;
     }
 
-    if (!multifd_payload_empty(multifd_ram_send)) {
-        if (!multifd_send(&multifd_ram_send)) {
-            error_report("%s: multifd_send fail", __func__);
-            return -1;
-        }
+    if ((ret = multifd_send_flush()) < 0) {
+        return ret;
     }
 
     /* File migrations only need to sync with threads */
diff --git a/migration/multifd.c b/migration/multifd.c
index 2bd8604ca1..8928ca2611 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1265,6 +1265,7 @@ static void *multifd_recv_thread(void *opaque)
 
     rcu_unregister_thread();
     trace_multifd_recv_thread_end(p->id, p->packets_recved);
+    qemu_sem_post(&multifd_recv_state->sem_sync);
 
     return NULL;
 }
diff --git a/migration/multifd.h b/migration/multifd.h
index bff867ca6b..242b923633 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -361,6 +361,7 @@ static inline uint32_t multifd_ram_page_count(void)
 
 void multifd_ram_save_setup(void);
 void multifd_ram_save_cleanup(void);
+int multifd_send_flush(void);
 int multifd_ram_flush_and_sync(QEMUFile *f);
 bool multifd_ram_sync_per_round(void);
 bool multifd_ram_sync_per_section(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 4046faf009..0b71e988ba 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -37,6 +37,7 @@
 #include "migration/register.h"
 #include "migration/global_state.h"
 #include "migration/channel-block.h"
+#include "multifd.h"
 #include "ram.h"
 #include "qemu-file.h"
 #include "savevm.h"
@@ -90,6 +91,7 @@ enum qemu_vm_cmd {
     MIG_CMD_ENABLE_COLO,       /* Enable COLO */
     MIG_CMD_POSTCOPY_RESUME,   /* resume postcopy on dest */
     MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
+    MIG_CMD_MULTIFD_RECV_SYNC, /* Sync multifd recv_x and main threads */
     MIG_CMD_MAX
 };
 
@@ -109,6 +111,7 @@ static struct mig_cmd_args {
     [MIG_CMD_POSTCOPY_RESUME]  = { .len =  0, .name = "POSTCOPY_RESUME" },
     [MIG_CMD_PACKAGED]         = { .len =  4, .name = "PACKAGED" },
     [MIG_CMD_RECV_BITMAP]      = { .len = -1, .name = "RECV_BITMAP" },
+    [MIG_CMD_MULTIFD_RECV_SYNC] = { .len = 0, .name = "MULTIFD_RECV_SYNC" },
     [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
 };
 
@@ -1201,6 +1204,12 @@ void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name)
     qemu_savevm_command_send(f, MIG_CMD_RECV_BITMAP, len + 1, (uint8_t *)buf);
 }
 
+void qemu_savevm_send_multifd_recv_sync(QEMUFile *f)
+{
+    /* TBD: trace_savevm_send_multifd_recv_sync(); */
+    qemu_savevm_command_send(f, MIG_CMD_MULTIFD_RECV_SYNC, 0, NULL);
+}
+
 bool qemu_savevm_state_blocked(Error **errp)
 {
     SaveStateEntry *se;
@@ -2479,6 +2488,10 @@ static int loadvm_process_command(QEMUFile *f)
     case MIG_CMD_RECV_BITMAP:
         return loadvm_handle_recv_bitmap(mis, len);
 
+    case MIG_CMD_MULTIFD_RECV_SYNC:
+        multifd_recv_sync_main();
+        break;
+
     case MIG_CMD_ENABLE_COLO:
         return loadvm_process_enable_colo(mis);
     }
diff --git a/migration/savevm.h b/migration/savevm.h
index 7957460062..91ae703925 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -53,6 +53,7 @@ void qemu_savevm_send_postcopy_listen(QEMUFile *f);
 void qemu_savevm_send_postcopy_run(QEMUFile *f);
 void qemu_savevm_send_postcopy_resume(QEMUFile *f);
 void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name);
+void qemu_savevm_send_multifd_recv_sync(QEMUFile *f);
 
 void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
                                            uint16_t len,
-- 
2.48.1


