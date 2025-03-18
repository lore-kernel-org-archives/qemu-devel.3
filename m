Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061EEC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWEX-00038T-Kk; Tue, 18 Mar 2025 08:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tuWE1-0002QR-Cd
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tuWDx-0007Kr-CD
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742301552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMSs1AHIZSRqdKg/kg4Cc10x0NxpoPBnKMn3+G8D0aw=;
 b=e4cSL3WQ1AOyVrO5fefDheooT5fmj10d/uMp+bNXhUln49e1lWHHjJhPq1gbKA3fe8iIef
 YSKq3nY2QmjQUfyGT1WgT4b2jaKafMQqtuk/w3nt0hb2VMuDmarjPUhNhHdc3pA94peJ6b
 pHBhvQZSTvtvcF3wjzQ126eAQ0eQ5EE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-pWcMo-mINCCNnCBXS9fXWQ-1; Tue,
 18 Mar 2025 08:39:09 -0400
X-MC-Unique: pWcMo-mINCCNnCBXS9fXWQ-1
X-Mimecast-MFC-AGG-ID: pWcMo-mINCCNnCBXS9fXWQ_1742301548
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5FDD180034D; Tue, 18 Mar 2025 12:39:08 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.234])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0BC3180094A; Tue, 18 Mar 2025 12:39:04 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v8 2/7] migration: Refactor channel discovery mechanism
Date: Tue, 18 Mar 2025 18:08:41 +0530
Message-ID: <20250318123846.1370312-3-ppandit@redhat.com>
In-Reply-To: <20250318123846.1370312-1-ppandit@redhat.com>
References: <20250318123846.1370312-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

The various logical migration channels don't have a
standardized way of advertising themselves and their
connections may be seen out of order by the migration
destination. When a new connection arrives, the incoming
migration currently make use of heuristics to determine
which channel it belongs to.

The next few patches will need to change how the multifd
and postcopy capabilities interact and that affects the
channel discovery heuristic.

Refactor the channel discovery heuristic to make it less
opaque and simplify the subsequent patches.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/migration.c | 124 +++++++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 55 deletions(-)

v8:
 - Separate this patch out from earlier patch-2

v7:
- https://lore.kernel.org/qemu-devel/20250228121749.553184-1-ppandit@redhat.com/T/#t

diff --git a/migration/migration.c b/migration/migration.c
index d46e776e24..f97bb2777f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -95,6 +95,9 @@ enum mig_rp_message_type {
     MIG_RP_MSG_MAX
 };
 
+/* Migration channel types */
+enum { CH_MAIN, CH_MULTIFD, CH_POSTCOPY };
+
 /* When we add fault tolerance, we could have several
    migrations at once.  For now we don't need to add
    dynamic creation of migration */
@@ -985,28 +988,19 @@ void migration_fd_process_incoming(QEMUFile *f)
     migration_incoming_process();
 }
 
-/*
- * Returns true when we want to start a new incoming migration process,
- * false otherwise.
- */
-static bool migration_should_start_incoming(bool main_channel)
+static bool migration_has_main_and_multifd_channels(void)
 {
-    /* Multifd doesn't start unless all channels are established */
-    if (migrate_multifd()) {
-        return migration_has_all_channels();
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    if (!mis->from_src_file) {
+        /* main channel not established */
+        return false;
     }
 
-    /* Preempt channel only starts when the main channel is created */
-    if (migrate_postcopy_preempt()) {
-        return main_channel;
+    if (migrate_multifd() && !multifd_recv_all_channels_created()) {
+        return false;
     }
 
-    /*
-     * For all the rest types of migration, we should only reach here when
-     * it's the main channel that's being created, and we should always
-     * proceed with this channel.
-     */
-    assert(main_channel);
+    /* main and all multifd channels are established */
     return true;
 }
 
@@ -1015,59 +1009,84 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
     QEMUFile *f;
-    bool default_channel = true;
+    uint8_t channel;
     uint32_t channel_magic = 0;
     int ret = 0;
 
-    if (migrate_multifd() && !migrate_mapped_ram() &&
-        !migrate_postcopy_ram() &&
-        qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
-        /*
-         * With multiple channels, it is possible that we receive channels
-         * out of order on destination side, causing incorrect mapping of
-         * source channels on destination side. Check channel MAGIC to
-         * decide type of channel. Please note this is best effort, postcopy
-         * preempt channel does not send any magic number so avoid it for
-         * postcopy live migration. Also tls live migration already does
-         * tls handshake while initializing main channel so with tls this
-         * issue is not possible.
-         */
-        ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
-                                          sizeof(channel_magic), errp);
+    if (!migration_has_main_and_multifd_channels()) {
+        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
+            /*
+             * With multiple channels, it is possible that we receive channels
+             * out of order on destination side, causing incorrect mapping of
+             * source channels on destination side. Check channel MAGIC to
+             * decide type of channel. Please note this is best effort,
+             * postcopy preempt channel does not send any magic number so
+             * avoid it for postcopy live migration. Also tls live migration
+             * already does tls handshake while initializing main channel so
+             * with tls this issue is not possible.
+             */
+            ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
+                                              sizeof(channel_magic), errp);
+            if (ret != 0) {
+                return;
+            }
 
-        if (ret != 0) {
+            channel_magic = be32_to_cpu(channel_magic);
+            if (channel_magic == QEMU_VM_FILE_MAGIC) {
+                channel = CH_MAIN;
+            } else if (channel_magic == MULTIFD_MAGIC) {
+                channel = CH_MULTIFD;
+            } else if (!mis->from_src_file &&
+                        mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+                /* reconnect main channel for postcopy recovery */
+                channel = CH_MAIN;
+            } else {
+                error_setg(errp, "unknown channel magic: %u", channel_magic);
+                return;
+            }
+        } else if (mis->from_src_file && migrate_multifd()) {
+            /*
+             * Non-peekable channels like tls/file are processed as
+             * multifd channels when multifd is enabled.
+             */
+            channel = CH_MULTIFD;
+        } else if (!mis->from_src_file) {
+            channel = CH_MAIN;
+        } else {
+            error_setg(errp, "non-peekable channel used without multifd");
             return;
         }
-
-        default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
+    } else if (mis->from_src_file) {
+        channel = CH_POSTCOPY;
     } else {
-        default_channel = !mis->from_src_file;
+        channel = CH_MAIN;
     }
 
     if (multifd_recv_setup(errp) != 0) {
         return;
     }
 
-    if (default_channel) {
+    if (channel == CH_MAIN) {
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
+        return;
     }
 
-    if (migration_should_start_incoming(default_channel)) {
+    if (migration_has_main_and_multifd_channels()) {
         /* If it's a recovery, we're done */
         if (postcopy_try_recover()) {
             return;
@@ -1084,20 +1103,15 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
  */
 bool migration_has_all_channels(void)
 {
+    if (!migration_has_main_and_multifd_channels()) {
+        return false;
+    }
+
     MigrationIncomingState *mis = migration_incoming_get_current();
-
-    if (!mis->from_src_file) {
+    if (migrate_postcopy_preempt() && !mis->postcopy_qemufile_dst) {
         return false;
     }
 
-    if (migrate_multifd()) {
-        return multifd_recv_all_channels_created();
-    }
-
-    if (migrate_postcopy_preempt()) {
-        return mis->postcopy_qemufile_dst != NULL;
-    }
-
     return true;
 }
 
-- 
2.48.1


