Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E999FD3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nqv-0006Yv-5n; Tue, 29 Oct 2024 11:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t5nqt-0006YI-UA
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:09:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t5nqs-0007Lf-2C
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730214584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oRa6uy1hrBS+4vNzMUBzGk1+RdEP5lh5kmw7SH2VOJQ=;
 b=IJkna4X7U06z9W9EimFE4ESWXeAncP7hg0QIsGJIyKXtvuAo+/OiiQmfAow4/3b3hdBb7q
 54jmfEofn5FJYLM5wvSxtaqsLTem5ppHT+Ugj782h8bNGDBsMQBZuCQlXAgHBBy7kzeBEI
 LIq7U7IyvRLplOmTt2zRGff35npu05A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-1WJIZWvMOVCBXMCNWAwBGg-1; Tue,
 29 Oct 2024 11:09:41 -0400
X-MC-Unique: 1WJIZWvMOVCBXMCNWAwBGg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 720C419560A3; Tue, 29 Oct 2024 15:09:40 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.130])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF7321956086; Tue, 29 Oct 2024 15:09:37 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH 5/5] migration: enable multifd and postcopy together
Date: Tue, 29 Oct 2024 20:39:08 +0530
Message-ID: <20241029150908.1136894-6-ppandit@redhat.com>
In-Reply-To: <20241029150908.1136894-1-ppandit@redhat.com>
References: <20241029150908.1136894-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
to the Postcopy phase, the source guest is
paused, so the Precopy and Multifd threads stop
sending data on their channels. Postcopy threads
on the destination request/pull data from the
source side.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/migration.c | 73 ++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 021faee2f3..11fcc1e012 100644
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
@@ -919,16 +922,15 @@ void migration_fd_process_incoming(QEMUFile *f)
  * Returns true when we want to start a new incoming migration process,
  * false otherwise.
  */
-static bool migration_should_start_incoming(bool main_channel)
+static bool migration_should_start_incoming(uint8_t channel)
 {
+    if (channel == CH_POSTCOPY) {
+        return false;
+    }
+
     /* Multifd doesn't start unless all channels are established */
     if (migrate_multifd()) {
-        return migration_has_all_channels();
-    }
-
-    /* Preempt channel only starts when the main channel is created */
-    if (migrate_postcopy_preempt()) {
-        return main_channel;
+        return multifd_recv_all_channels_created();
     }
 
     /*
@@ -936,7 +938,7 @@ static bool migration_should_start_incoming(bool main_channel)
      * it's the main channel that's being created, and we should always
      * proceed with this channel.
      */
-    assert(main_channel);
+    assert(channel == CH_DEFAULT);
     return true;
 }
 
@@ -945,13 +947,11 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
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
+    if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
         /*
          * With multiple channels, it is possible that we receive channels
          * out of order on destination side, causing incorrect mapping of
@@ -969,35 +969,49 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
             return;
         }
 
-        default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
-    } else {
-        default_channel = !mis->from_src_file;
+        if (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC)) {
+            channel = CH_DEFAULT;
+        } else if (channel_magic == cpu_to_be32(MULTIFD_MAGIC)) {
+            channel = CH_MULTIFD;
+        } else if (channel_magic == cpu_to_be32(POSTCOPY_MAGIC)) {
+            if (qio_channel_read_all(ioc, (char *)&channel_magic,
+                                sizeof(channel_magic), &local_err)) {
+                error_report_err(local_err);
+                return;
+            }
+            channel = CH_POSTCOPY;
+        } else {
+            error_report("%s: could not identify channel, unknown magic: %u",
+                           __func__, channel_magic);
+            return;
+        }
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
@@ -1014,21 +1028,22 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
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
-- 
2.47.0


