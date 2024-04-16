Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A298C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk2G-0004us-5w; Tue, 16 Apr 2024 10:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2D-0004sl-3E
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:43:45 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2A-0001yc-5Q
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:43:44 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk1m-0002ca-MS; Tue, 16 Apr 2024 16:43:18 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH RFC 01/26] migration: Add x-channel-header pseudo-capability
Date: Tue, 16 Apr 2024 16:42:40 +0200
Message-ID: <9994e4a41a0c893eec312baf1ef705ac42dafbc0.1713269378.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713269378.git.maciej.szmigiero@oracle.com>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

Add x-channel-header pseudo-capability which indicates that a header
should be sent through migration channels.

The header is the first thing to be sent through a migration channel and
it allows the destination to differentiate between the various channels
(main, multifd and preempt).

This eliminates the need to deduce the channel type by peeking in the
channel's content, which can be done only on a best-effort basis. It
will also allow other devices to create their own channels in the
future.

This patch only adds the pseudo-capability and sets it to false always.
The following patches will add the actual functionality, after which it
will be enabled..

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/core/machine.c     | 1 +
 migration/migration.h | 3 +++
 migration/options.c   | 9 +++++++++
 migration/options.h   | 1 +
 4 files changed, 14 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 37ede0e7d4fd..fa28c49f55b7 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -37,6 +37,7 @@ GlobalProperty hw_compat_8_2[] = {
     { "migration", "zero-page-detection", "legacy"},
     { TYPE_VIRTIO_IOMMU_PCI, "granule", "4k" },
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
+    { "migration", "channel_header", "off" },
 };
 const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
 
diff --git a/migration/migration.h b/migration/migration.h
index 8045e39c26fa..a6114405917f 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -450,6 +450,9 @@ struct MigrationState {
      */
     uint8_t clear_bitmap_shift;
 
+    /* Whether a header is sent in migration channels */
+    bool channel_header;
+
     /*
      * This save hostname when out-going migration starts
      */
diff --git a/migration/options.c b/migration/options.c
index bfd7753b69a5..8fd871cd956d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -100,6 +100,7 @@ Property migration_properties[] = {
                       clear_bitmap_shift, CLEAR_BITMAP_SHIFT_DEFAULT),
     DEFINE_PROP_BOOL("x-preempt-pre-7-2", MigrationState,
                      preempt_pre_7_2, false),
+    DEFINE_PROP_BOOL("x-channel-header", MigrationState, channel_header, true),
 
     /* Migration parameters */
     DEFINE_PROP_UINT8("x-compress-level", MigrationState,
@@ -381,6 +382,14 @@ bool migrate_zero_copy_send(void)
 
 /* pseudo capabilities */
 
+bool migrate_channel_header(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return false;
+    return s->channel_header;
+}
+
 bool migrate_multifd_flush_after_each_section(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index ab8199e20784..1144d72ec0db 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -52,6 +52,7 @@ bool migrate_zero_copy_send(void);
  * check, but they are not a capability.
  */
 
+bool migrate_channel_header(void);
 bool migrate_multifd_flush_after_each_section(void);
 bool migrate_postcopy(void);
 bool migrate_rdma(void);

