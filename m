Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6A2D6EC04
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 12:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH026-0000rw-6b; Fri, 29 Nov 2024 07:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tH01v-0000rH-2b
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 07:23:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tH01r-0006Fu-55
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 07:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732883001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7+7ViOrPZfMNIol2Yp9dhVv4QfzbaJ+mNQckdUqww0=;
 b=GNbQ5EGG75njscdv2aly2idGI9nhRy2efyktJv3WH89owHFatUkMI5By8qxmQFwdSoklQ9
 +Na03ytrRjEJjR8KVRJ5Tz41Wy0EFPbQ53tZVaYyUYP9NdE7ufD/SvY90PZqEw2ELj58PX
 n/NRKRTfw1M4Xhgu5loVmwwmHihenFE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-IJW__m4qOXWo5tNIlgz_KQ-1; Fri,
 29 Nov 2024 07:23:20 -0500
X-MC-Unique: IJW__m4qOXWo5tNIlgz_KQ-1
X-Mimecast-MFC-AGG-ID: IJW__m4qOXWo5tNIlgz_KQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59574195609F; Fri, 29 Nov 2024 12:23:19 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.141])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41BA11956095; Fri, 29 Nov 2024 12:23:15 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v2 3/3] migration: enable multifd and postcopy together
Date: Fri, 29 Nov 2024 17:52:56 +0530
Message-ID: <20241129122256.96778-4-ppandit@redhat.com>
In-Reply-To: <20241129122256.96778-1-ppandit@redhat.com>
References: <20241129122256.96778-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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
 migration/migration.c      | 90 +++++++++++++++++++++++---------------
 migration/multifd-nocomp.c |  3 +-
 migration/options.c        |  5 ---
 migration/ram.c            |  8 ++--
 4 files changed, 61 insertions(+), 45 deletions(-)

v2: Merge earlier options.c patch into this one. Also make
    !migration_in_postcopy() check in this patch, to separate
    refactoring change from this one.

v1: Avoid using 4-bytes magic value for the Postcopy channel.
    Flush and synchronise Multifd thread before postcopy_start().
 - https://lore.kernel.org/qemu-devel/20241126115748.118683-1-ppandit@redhat.com/T/#u

v0:
 - https://lore.kernel.org/qemu-devel/20241029150908.1136894-1-ppandit@redhat.com/T/#u

diff --git a/migration/migration.c b/migration/migration.c
index 8c5bd0a75c..fa0a6d3b7d 100644
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
@@ -921,26 +924,32 @@ void migration_fd_process_incoming(QEMUFile *f)
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
@@ -948,13 +957,12 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
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
+    if (!migration_should_start_incoming(channel)
+        && qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
         /*
          * With multiple channels, it is possible that we receive channels
          * out of order on destination side, causing incorrect mapping of
@@ -972,35 +980,46 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
             return;
         }
 
-        default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
+        if (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC)) {
+            channel = CH_DEFAULT;
+        } else if (channel_magic == cpu_to_be32(MULTIFD_MAGIC)) {
+            channel = CH_MULTIFD;
+        } else {
+            error_report("%s: could not identify channel, unknown magic: %u",
+                            __func__, channel_magic);
+            return;
+        }
+
     } else {
-        default_channel = !mis->from_src_file;
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
+        }
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    } else if (channel == CH_POSTCOPY) {
+        if (migrate_postcopy()) {
             assert(migrate_postcopy_preempt());
+            assert(!mis->postcopy_qemufile_dst);
             f = qemu_file_new_input(ioc);
             postcopy_preempt_new_channel(mis, f);
         }
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
     }
 
-    if (migration_should_start_incoming(default_channel)) {
+    if (migration_should_start_incoming(channel)) {
         /* If it's a recovery, we're done */
         if (postcopy_try_recover()) {
             return;
@@ -1017,21 +1036,22 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
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
index 55191152f9..e92821e8f6 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -14,6 +14,7 @@
 #include "exec/ramblock.h"
 #include "exec/target_page.h"
 #include "file.h"
+#include "migration.h"
 #include "multifd.h"
 #include "options.h"
 #include "qapi/error.h"
@@ -345,7 +346,7 @@ retry:
 
 int multifd_ram_flush_and_sync(void)
 {
-    if (!migrate_multifd()) {
+    if (!migrate_multifd() || migration_in_postcopy()) {
         return 0;
     }
 
diff --git a/migration/options.c b/migration/options.c
index ad8d6989a8..c498558a85 100644
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
index 5f97dda5f1..7444fa5280 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1316,9 +1316,9 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (migrate_multifd() &&
-                (!migrate_multifd_flush_after_each_section() ||
-                 migrate_mapped_ram())) {
+            if (migrate_multifd() && !migration_in_postcopy()
+                && (!migrate_multifd_flush_after_each_section()
+                    || migrate_mapped_ram())) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
                 int ret = multifd_ram_flush_and_sync();
                 if (ret < 0) {
@@ -1997,7 +1997,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
         }
     }
 
-    if (migrate_multifd()) {
+    if (migrate_multifd() && !migration_in_postcopy()) {
         RAMBlock *block = pss->block;
         return ram_save_multifd_page(block, offset);
     }
-- 
2.47.1


