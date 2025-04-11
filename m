Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C7CC369A9
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 11:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Cpo-0007E1-Lv; Fri, 11 Apr 2025 07:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u3Cpc-0007As-3X
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u3CpZ-0001RY-54
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744371956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+aCLtnXGmdYsqAtyifRbhfV/4qWUWuGWVS/lxW1noic=;
 b=SuIM4BA1dRquhUjv63wWjioevu5rU0O/7RFH9bGMhHZk72g5hEwI/sT5F9CRAW9eaBoGLd
 dUH/pWFbaZ2z1JNotjesv3buDhxg5kOzJ7Qj5hz+Y4N0jKbsAypZTL/p0YSordv+4plCAG
 fxNUwOXeHBy6MaKr0bt574aIiZQGH6k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-ccZg8fsJMVeyb_hGJSjyRg-1; Fri,
 11 Apr 2025 07:45:55 -0400
X-MC-Unique: ccZg8fsJMVeyb_hGJSjyRg-1
X-Mimecast-MFC-AGG-ID: ccZg8fsJMVeyb_hGJSjyRg_1744371954
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D8181955DC6; Fri, 11 Apr 2025 11:45:54 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.160])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ABF7180886A; Fri, 11 Apr 2025 11:45:49 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v9 2/7] migration: refactor channel discovery mechanism
Date: Fri, 11 Apr 2025 17:15:29 +0530
Message-ID: <20250411114534.3370816-3-ppandit@redhat.com>
In-Reply-To: <20250411114534.3370816-1-ppandit@redhat.com>
References: <20250411114534.3370816-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 migration/migration.c | 132 +++++++++++++++++++++++-------------------
 1 file changed, 71 insertions(+), 61 deletions(-)

v8: remove else if (!mis->from_src_file) checks and add assert(3) check
- https://lore.kernel.org/qemu-devel/20250318123846.1370312-1-ppandit@redhat.com/T/#t

diff --git a/migration/migration.c b/migration/migration.c
index d46e776e24..64f4f40ae3 100644
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
@@ -931,9 +934,8 @@ static void migration_incoming_setup(QEMUFile *f)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (!mis->from_src_file) {
-        mis->from_src_file = f;
-    }
+    assert(!mis->from_src_file);
+    mis->from_src_file = f;
     qemu_file_set_blocking(f, false);
 }
 
@@ -985,28 +987,19 @@ void migration_fd_process_incoming(QEMUFile *f)
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
 
@@ -1015,59 +1008,81 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
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
+                assert(migrate_multifd());
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
     } else {
-        default_channel = !mis->from_src_file;
+        assert(migrate_postcopy_preempt());
+        channel = CH_POSTCOPY;
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
-        if (migrate_multifd()) {
-            multifd_recv_new_channel(ioc, &local_err);
-        } else {
-            assert(migrate_postcopy_preempt());
-            f = qemu_file_new_input(ioc);
-            postcopy_preempt_new_channel(mis, f);
-        }
+        multifd_recv_new_channel(ioc, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
+    } else if (channel == CH_POSTCOPY) {
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
@@ -1084,20 +1099,15 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
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
2.49.0


