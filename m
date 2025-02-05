Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0528C02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 12:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfeWB-0008Kx-Lr; Wed, 05 Feb 2025 07:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tfeW9-0008Ko-FF
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:28:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tfeW6-0000CG-W7
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738758510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+oj3UPjCsg4irGvyYuyupiETMCteBc/O4crgRx6FAws=;
 b=S/bSle8RAWoJDFkPkg0P9ZpoXX/j6IrUXFMFFfu+oIocLL8VwdDydcEhtv0yc1RTybbpMc
 ZeadK9iNoAufSWWTPoIuNsmQdaKZB/9DwAnPZRhgn3ycH+6j99v/IoHbWYKbH38A0NIg1R
 KJ9Y8nLlYKrG/un/Pn6i5M+p1v9DgvA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-lvEcj5kjP_OOEas6q50zPA-1; Wed,
 05 Feb 2025 07:28:27 -0500
X-MC-Unique: lvEcj5kjP_OOEas6q50zPA-1
X-Mimecast-MFC-AGG-ID: lvEcj5kjP_OOEas6q50zPA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0933C1955D70; Wed,  5 Feb 2025 12:28:26 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.17.174])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD86C19560A3; Wed,  5 Feb 2025 12:28:16 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v5 3/5] migration: enable multifd and postcopy together
Date: Wed,  5 Feb 2025 17:57:10 +0530
Message-ID: <20250205122712.229151-4-ppandit@redhat.com>
In-Reply-To: <20250205122712.229151-1-ppandit@redhat.com>
References: <20250205122712.229151-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Enable Multifd and Postcopy migration together.
The migration_ioc_process_incoming() routine
checks magic value sent on each channel and
helps to properly setup multifd and postcopy
channels.

The Precopy and Multifd threads work during the
initial guest RAM transfer. When migration moves
to the Postcopy phase, the multifd threads are
restrained and Postcopy threads on the destination
request/pull data from the source side.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/migration.c      | 106 +++++++++++++++++++++++--------------
 migration/multifd-nocomp.c |   3 +-
 migration/options.c        |   5 --
 migration/ram.c            |   4 +-
 4 files changed, 70 insertions(+), 48 deletions(-)

v4: no change
- https://lore.kernel.org/qemu-devel/20250127120823.144949-1-ppandit@redhat.com/T/#t

diff --git a/migration/migration.c b/migration/migration.c
index 2d1da917c7..a280722e9e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -92,6 +92,9 @@ enum mig_rp_message_type {
     MIG_RP_MSG_MAX
 };
 
+/* Migration channel types */
+enum { CH_DEFAULT, CH_MULTIFD, CH_POSTCOPY };
+
 /* When we add fault tolerance, we could have several
    migrations at once.  For now we don't need to add
    dynamic creation of migration */
@@ -929,26 +932,33 @@ void migration_fd_process_incoming(QEMUFile *f)
 /*
  * Returns true when we want to start a new incoming migration process,
  * false otherwise.
+ *
+ * All the required channels must be in place before a new incoming
+ * migration process starts.
+ *  - Multifd enabled:
+ *    The main channel and the multifd channels are required.
+ *  - Multifd/Postcopy disabled:
+ *    The main channel is required.
+ *  - Postcopy enabled:
+ *    We don't want to start a new incoming migration when
+ *    the postcopy channel is created. Because it is created
+ *    towards the end of the precopy migration.
+ *
  */
-static bool migration_should_start_incoming(bool main_channel)
+static bool migration_should_start_incoming(uint8_t channel)
 {
-    /* Multifd doesn't start unless all channels are established */
-    if (migrate_multifd()) {
-        return migration_has_all_channels();
-    }
+    bool ret = false;
+
+    if (channel != CH_POSTCOPY) {
+        MigrationIncomingState *mis = migration_incoming_get_current();
+        ret = mis->from_src_file ? true : false;
 
-    /* Preempt channel only starts when the main channel is created */
-    if (migrate_postcopy_preempt()) {
-        return main_channel;
+        if (ret && migrate_multifd()) {
+            ret = multifd_recv_all_channels_created();
+        }
     }
 
-    /*
-     * For all the rest types of migration, we should only reach here when
-     * it's the main channel that's being created, and we should always
-     * proceed with this channel.
-     */
-    assert(main_channel);
-    return true;
+    return ret;
 }
 
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
@@ -956,13 +966,12 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
     QEMUFile *f;
-    bool default_channel = true;
     uint32_t channel_magic = 0;
+    uint8_t channel = CH_DEFAULT;
     int ret = 0;
 
-    if (migrate_multifd() && !migrate_mapped_ram() &&
-        !migrate_postcopy_ram() &&
-        qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
+    if (!migration_should_start_incoming(channel)) {
+        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
         /*
          * With multiple channels, it is possible that we receive channels
          * out of order on destination side, causing incorrect mapping of
@@ -973,42 +982,58 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
          * tls handshake while initializing main channel so with tls this
          * issue is not possible.
          */
-        ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
-                                          sizeof(channel_magic), errp);
+            ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
+                                              sizeof(channel_magic), errp);
+            if (ret != 0) {
+                return;
+            }
 
-        if (ret != 0) {
-            return;
+            if (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC)) {
+                channel = CH_DEFAULT;
+            } else if (channel_magic == cpu_to_be32(MULTIFD_MAGIC)) {
+                channel = CH_MULTIFD;
+            } else if (!mis->from_src_file
+                        && mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+                /* reconnect default channel for postcopy recovery */
+                channel = CH_DEFAULT;
+            } else {
+                error_report("%s: could not identify channel, unknown magic: %u",
+                                __func__, channel_magic);
+                return;
+            }
+        } else if (mis->from_src_file
+            && (!strcmp(ioc->name, "migration-tls-incoming")
+                || !strcmp(ioc->name, "migration-file-incoming"))) {
+            channel = CH_MULTIFD;
         }
-
-        default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
-    } else {
-        default_channel = !mis->from_src_file;
+    } else if (mis->from_src_file) { // && migrate_postcopy_preempt()
+        channel = CH_POSTCOPY;
     }
 
     if (multifd_recv_setup(errp) != 0) {
         return;
     }
 
-    if (default_channel) {
+    if (channel == CH_DEFAULT) {
         f = qemu_file_new_input(ioc);
         migration_incoming_setup(f);
-    } else {
+    } else if (channel == CH_MULTIFD) {
         /* Multiple connections */
-        assert(migration_needs_multiple_sockets());
         if (migrate_multifd()) {
             multifd_recv_new_channel(ioc, &local_err);
-        } else {
-            assert(migrate_postcopy_preempt());
-            f = qemu_file_new_input(ioc);
-            postcopy_preempt_new_channel(mis, f);
         }
         if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
+    } else if (channel == CH_POSTCOPY) {
+        assert(migrate_postcopy_preempt());
+        assert(!mis->postcopy_qemufile_dst);
+        f = qemu_file_new_input(ioc);
+        postcopy_preempt_new_channel(mis, f);
     }
 
-    if (migration_should_start_incoming(default_channel)) {
+    if (migration_should_start_incoming(channel)) {
         /* If it's a recovery, we're done */
         if (postcopy_try_recover()) {
             return;
@@ -1025,21 +1050,22 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
  */
 bool migration_has_all_channels(void)
 {
+    bool ret = false;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     if (!mis->from_src_file) {
-        return false;
+        return ret;
     }
 
     if (migrate_multifd()) {
-        return multifd_recv_all_channels_created();
+        ret = multifd_recv_all_channels_created();
     }
 
-    if (migrate_postcopy_preempt()) {
-        return mis->postcopy_qemufile_dst != NULL;
+    if (ret && migrate_postcopy_preempt()) {
+        ret = mis->postcopy_qemufile_dst != NULL;
     }
 
-    return true;
+    return ret;
 }
 
 int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 1325dba97c..d0edec7cd1 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -16,6 +16,7 @@
 #include "file.h"
 #include "multifd.h"
 #include "options.h"
+#include "migration.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
@@ -391,7 +392,7 @@ int multifd_ram_flush_and_sync(QEMUFile *f)
     MultiFDSyncReq req;
     int ret;
 
-    if (!migrate_multifd()) {
+    if (!migrate_multifd() || migration_in_postcopy()) {
         return 0;
     }
 
diff --git a/migration/options.c b/migration/options.c
index b8d5300326..8c878dea49 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -479,11 +479,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Postcopy is not compatible with ignore-shared");
             return false;
         }
-
-        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
-            error_setg(errp, "Postcopy is not yet compatible with multifd");
-            return false;
-        }
     }
 
     if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
diff --git a/migration/ram.c b/migration/ram.c
index f2326788de..bdba7abe73 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1295,7 +1295,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (multifd_ram_sync_per_round()) {
+            if (multifd_ram_sync_per_round() && !migration_in_postcopy()) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
                 int ret = multifd_ram_flush_and_sync(f);
                 if (ret < 0) {
@@ -1969,7 +1969,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
         }
     }
 
-    if (migrate_multifd()) {
+    if (migrate_multifd() && !migration_in_postcopy()) {
         RAMBlock *block = pss->block;
         return ram_save_multifd_page(block, offset);
     }
-- 
2.48.1


