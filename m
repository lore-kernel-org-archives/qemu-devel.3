Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16EEC54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx7B-0001Pu-LB; Sun, 03 Mar 2024 20:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx77-0001Kg-HO
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx75-0002L7-Bt
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEJkd+Fnu0BaUcq09pzXPOnzQP5japOLAZGZ/W8ckog=;
 b=RYLPwtnEyc9eP5MWCCDL0IqoJYEpnHUS3C6OWnBn6RBHl7j0Bwj6U3R0ppxduh8TxCxmy3
 ShF6jZiXm/NSopJUr/uT1v3JP+C0PjNW0Hcu7AY5G+9QE7JV7uPZBUImYhJUnlLM0TS4Go
 kWNeUQ2yrngfKR5vsd6rRzQDMz+Hcuo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-s7lfNDJSPjyM0yrpLAutNA-1; Sun, 03 Mar 2024 20:27:26 -0500
X-MC-Unique: s7lfNDJSPjyM0yrpLAutNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33B611064DA2;
 Mon,  4 Mar 2024 01:27:26 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E86440C94A7;
 Mon,  4 Mar 2024 01:27:21 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 10/27] migration/ram: Introduce 'mapped-ram' migration
 capability
Date: Mon,  4 Mar 2024 09:26:17 +0800
Message-ID: <20240304012634.95520-11-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Add a new migration capability 'mapped-ram'.

The core of the feature is to ensure that RAM pages are mapped
directly to offsets in the resulting migration file instead of being
streamed at arbitrary points.

The reasons why we'd want such behavior are:

 - The resulting file will have a bounded size, since pages which are
   dirtied multiple times will always go to a fixed location in the
   file, rather than constantly being added to a sequential
   stream. This eliminates cases where a VM with, say, 1G of RAM can
   result in a migration file that's 10s of GBs, provided that the
   workload constantly redirties memory.

 - It paves the way to implement O_DIRECT-enabled save/restore of the
   migration stream as the pages are ensured to be written at aligned
   offsets.

 - It allows the usage of multifd so we can write RAM pages to the
   migration file in parallel.

For now, enabling the capability has no effect. The next couple of
patches implement the core functionality.

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-8-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/features.rst   |   1 +
 docs/devel/migration/mapped-ram.rst | 138 ++++++++++++++++++++++++++++
 qapi/migration.json                 |   6 +-
 migration/options.h                 |   1 +
 migration/migration.c               |   7 ++
 migration/options.c                 |  34 +++++++
 migration/savevm.c                  |   1 +
 7 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 docs/devel/migration/mapped-ram.rst

diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index a9acaf618e..9d1abd2587 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -10,3 +10,4 @@ Migration has plenty of features to support different use cases.
    dirty-limit
    vfio
    virtio
+   mapped-ram
diff --git a/docs/devel/migration/mapped-ram.rst b/docs/devel/migration/mapped-ram.rst
new file mode 100644
index 0000000000..fa4cefd9fc
--- /dev/null
+++ b/docs/devel/migration/mapped-ram.rst
@@ -0,0 +1,138 @@
+Mapped-ram
+==========
+
+Mapped-ram is a new stream format for the RAM section designed to
+supplement the existing ``file:`` migration and make it compatible
+with ``multifd``. This enables parallel migration of a guest's RAM to
+a file.
+
+The core of the feature is to ensure that RAM pages are mapped
+directly to offsets in the resulting migration file. This enables the
+``multifd`` threads to write exclusively to those offsets even if the
+guest is constantly dirtying pages (i.e. live migration). Another
+benefit is that the resulting file will have a bounded size, since
+pages which are dirtied multiple times will always go to a fixed
+location in the file, rather than constantly being added to a
+sequential stream. Having the pages at fixed offsets also allows the
+usage of O_DIRECT for save/restore of the migration stream as the
+pages are ensured to be written respecting O_DIRECT alignment
+restrictions (direct-io support not yet implemented).
+
+Usage
+-----
+
+On both source and destination, enable the ``multifd`` and
+``mapped-ram`` capabilities:
+
+    ``migrate_set_capability multifd on``
+
+    ``migrate_set_capability mapped-ram on``
+
+Use a ``file:`` URL for migration:
+
+    ``migrate file:/path/to/migration/file``
+
+Mapped-ram migration is best done non-live, i.e. by stopping the VM on
+the source side before migrating.
+
+Use-cases
+---------
+
+The mapped-ram feature was designed for use cases where the migration
+stream will be directed to a file in the filesystem and not
+immediately restored on the destination VM [#]_. These could be
+thought of as snapshots. We can further categorize them into live and
+non-live.
+
+- Non-live snapshot
+
+If the use case requires a VM to be stopped before taking a snapshot,
+that's the ideal scenario for mapped-ram migration. Not having to
+track dirty pages, the migration will write the RAM pages to the disk
+as fast as it can.
+
+Note: if a snapshot is taken of a running VM, but the VM will be
+stopped after the snapshot by the admin, then consider stopping it
+right before the snapshot to take benefit of the performance gains
+mentioned above.
+
+- Live snapshot
+
+If the use case requires that the VM keeps running during and after
+the snapshot operation, then mapped-ram migration can still be used,
+but will be less performant. Other strategies such as
+background-snapshot should be evaluated as well. One benefit of
+mapped-ram in this scenario is portability since background-snapshot
+depends on async dirty tracking (KVM_GET_DIRTY_LOG) which is not
+supported outside of Linux.
+
+.. [#] While this same effect could be obtained with the usage of
+       snapshots or the ``file:`` migration alone, mapped-ram provides
+       a performance increase for VMs with larger RAM sizes (10s to
+       100s of GiBs), specially if the VM has been stopped beforehand.
+
+RAM section format
+------------------
+
+Instead of having a sequential stream of pages that follow the
+RAMBlock headers, the dirty pages for a RAMBlock follow its header
+instead. This ensures that each RAM page has a fixed offset in the
+resulting migration file.
+
+A bitmap is introduced to track which pages have been written in the
+migration file. Pages are written at a fixed location for every
+ramblock. Zero pages are ignored as they'd be zero in the destination
+migration as well.
+
+::
+
+ Without mapped-ram:                  With mapped-ram:
+
+ ---------------------               --------------------------------
+ | ramblock 1 header |               | ramblock 1 header            |
+ ---------------------               --------------------------------
+ | ramblock 2 header |               | ramblock 1 mapped-ram header |
+ ---------------------               --------------------------------
+ | ...               |               | padding to next 1MB boundary |
+ ---------------------               | ...                          |
+ | ramblock n header |               --------------------------------
+ ---------------------               | ramblock 1 pages             |
+ | RAM_SAVE_FLAG_EOS |               | ...                          |
+ ---------------------               --------------------------------
+ | stream of pages   |               | ramblock 2 header            |
+ | (iter 1)          |               --------------------------------
+ | ...               |               | ramblock 2 mapped-ram header |
+ ---------------------               --------------------------------
+ | RAM_SAVE_FLAG_EOS |               | padding to next 1MB boundary |
+ ---------------------               | ...                          |
+ | stream of pages   |               --------------------------------
+ | (iter 2)          |               | ramblock 2 pages             |
+ | ...               |               | ...                          |
+ ---------------------               --------------------------------
+ | ...               |               | ...                          |
+ ---------------------               --------------------------------
+                                     | RAM_SAVE_FLAG_EOS            |
+                                     --------------------------------
+                                     | ...                          |
+                                     --------------------------------
+
+where:
+ - ramblock header: the generic information for a ramblock, such as
+   idstr, used_len, etc.
+
+ - ramblock mapped-ram header: the information added by this feature:
+   bitmap of pages written, bitmap size and offset of pages in the
+   migration file.
+
+Restrictions
+------------
+
+Since pages are written to their relative offsets and out of order
+(due to the memory dirtying patterns), streaming channels such as
+sockets are not supported. A seekable channel such as a file is
+required. This can be verified in the QIOChannel by the presence of
+the QIO_CHANNEL_FEATURE_SEEKABLE.
+
+The improvements brought by this feature apply only to guest physical
+RAM. Other types of memory such as VRAM are migrated as part of device
+states.
diff --git a/qapi/migration.json b/qapi/migration.json
index b603aa6f25..62acc834af 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -531,6 +531,10 @@
 #     and can result in more stable read performance.  Requires KVM
 #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
 #
+# @mapped-ram: Migrate using fixed offsets in the migration file for
+#     each RAM page.  Requires a migration URI that supports seeking,
+#     such as a file.  (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block is deprecated.  Use blockdev-mirror with
@@ -555,7 +559,7 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit'] }
+           'dirty-limit', 'mapped-ram'] }
 
 ##
 # @MigrationCapabilityStatus:
diff --git a/migration/options.h b/migration/options.h
index 246c160aee..6ddd8dad9b 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -31,6 +31,7 @@ bool migrate_compress(void);
 bool migrate_dirty_bitmaps(void);
 bool migrate_dirty_limit(void);
 bool migrate_events(void);
+bool migrate_mapped_ram(void);
 bool migrate_ignore_shared(void);
 bool migrate_late_block_activate(void);
 bool migrate_multifd(void);
diff --git a/migration/migration.c b/migration/migration.c
index bab68bcbef..69f68f940d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1950,6 +1950,13 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         return false;
     }
 
+    if (migrate_mapped_ram()) {
+        if (migrate_tls()) {
+            error_setg(errp, "Cannot use TLS with mapped-ram");
+            return false;
+        }
+    }
+
     if (migrate_mode_is_cpr(s)) {
         const char *conflict = NULL;
 
diff --git a/migration/options.c b/migration/options.c
index 1cd3cc7c33..5df89820fd 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -204,6 +204,7 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-switchover-ack",
                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
+    DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -263,6 +264,13 @@ bool migrate_events(void)
     return s->capabilities[MIGRATION_CAPABILITY_EVENTS];
 }
 
+bool migrate_mapped_ram(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
@@ -645,6 +653,32 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
+    if (new_caps[MIGRATION_CAPABILITY_MAPPED_RAM]) {
+        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
+            error_setg(errp,
+                       "Mapped-ram migration is incompatible with multifd");
+            return false;
+        }
+
+        if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
+            error_setg(errp,
+                       "Mapped-ram migration is incompatible with xbzrle");
+            return false;
+        }
+
+        if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
+            error_setg(errp,
+                       "Mapped-ram migration is incompatible with compression");
+            return false;
+        }
+
+        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+            error_setg(errp,
+                       "Mapped-ram migration is incompatible with postcopy");
+            return false;
+        }
+    }
+
     return true;
 }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index d612c8a902..dc1fb9c0d3 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -245,6 +245,7 @@ static bool should_validate_capability(int capability)
     /* Validate only new capabilities to keep compatibility. */
     switch (capability) {
     case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
+    case MIGRATION_CAPABILITY_MAPPED_RAM:
         return true;
     default:
         return false;
-- 
2.44.0


