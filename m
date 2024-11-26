Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D7FD3B988
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFuD9-0004VY-AS; Tue, 26 Nov 2024 06:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tFuD2-0004T6-3I
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:58:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tFuD0-00035G-8I
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732622301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+x3ENjUhRiva2abHkGcGR3LzYAAPFZO+unc9uE8PLSU=;
 b=Q65nxQGrZ32NM/E5iZRWpzLeZRF/q9eh1j+Cmpn5rGoOQTi9BrQnNbRB9zblHb0CPxXLcE
 P6iR6pyKguHhf1kzQr9sHKJ8mKxrwF3V7SiZeDiXRtwXLxG2dqo8XhLhekLLWisCRhMp0T
 5Y01R/T7HHOSyFZrZSaHzi9UmqLMsNQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-mvG99paGOaWb8jgaU07K_w-1; Tue,
 26 Nov 2024 06:58:17 -0500
X-MC-Unique: mvG99paGOaWb8jgaU07K_w-1
X-Mimecast-MFC-AGG-ID: mvG99paGOaWb8jgaU07K_w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B337119560AF; Tue, 26 Nov 2024 11:58:15 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.158])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 340EB19560A3; Tue, 26 Nov 2024 11:58:11 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v1 4/4] migration: enable multifd and postcopy together
Date: Tue, 26 Nov 2024 17:27:48 +0530
Message-ID: <20241126115748.118683-5-ppandit@redhat.com>
In-Reply-To: <20241126115748.118683-1-ppandit@redhat.com>
References: <20241126115748.118683-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Idea is to take advantage of the multifd threads
to accelerate transfer of large guest RAM to the
destination and switch to postcopy mode sooner.

The Precopy and Multifd threads work during the
initial guest RAM transfer. When migration moves
to the Postcopy phase, the multifd threads are
restrained and Postcopy threads on the destination
request/pull data from the source side.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/migration.c | 95 +++++++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 35 deletions(-)

v1: Avoid using 4-bytes magic value for the Postcopy channel.
    Flush and synchronise Multifd thread before postcopy_start().

v0: https://lore.kernel.org/qemu-devel/20241029150908.1136894-1-ppandit@redhat.com/T/#u

diff --git a/migration/migration.c b/migration/migration.c
index 8c5bd0a75c..eee7078106 100644
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
@@ -3239,6 +3259,11 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     /* Still a significant amount to transfer */
     if (!in_postcopy && must_precopy <= s->threshold_size && can_switchover &&
         qatomic_read(&s->start_postcopy)) {
+
+        if (migrate_multifd()) {
+            multifd_send_sync_main();
+        }
+
         if (postcopy_start(s, &local_err)) {
             migrate_set_error(s, local_err);
             error_report_err(local_err);
-- 
2.47.0


