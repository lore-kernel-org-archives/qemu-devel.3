Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F106CC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYoY-0003GU-7M; Tue, 20 Feb 2024 17:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoV-0003FR-Bz
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:12 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoT-0006Kn-3p
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:11 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F16AF1FB40;
 Tue, 20 Feb 2024 22:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rMZwnsxGPC46xABnLIzuiIVK2s50sf9Lrt0fRlj+Nw=;
 b=vG0C7tfs5Cuw7i4mRTM/xLtP5V/TZayTbcYktw0jYYrjLEJpGgwByLHY8IGLyK7FjtDGdg
 0f6CetfdKuA6/0KuqH+OAf4psRHAINIZwy50PXPbnDpEnHQmmgVjyf1MHJImGITlj3tPW2
 HwwJQ4mX3KNtGbgxxYd1k1ZO6R16hpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rMZwnsxGPC46xABnLIzuiIVK2s50sf9Lrt0fRlj+Nw=;
 b=6GEy2wyY7K9U9vv2sdM3nfeCs73dMrJRaj1J5oeiK34WoiCNDIE2vAw5tE5w0mLhu6EUQw
 QejuQcO2VDwk0NDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rMZwnsxGPC46xABnLIzuiIVK2s50sf9Lrt0fRlj+Nw=;
 b=Vge+bEPz4hsNC2A7GJ/MBbZvDhzBtzgVE++y5BnFmNJwMkC7c+9LTUtVFbYmFjhyx/wLS6
 NHrOIoH2bdxHps8mMbZskG/5Rfn14ebBBCOdJOCl9tRlF6kd3wYHGFn4uoDiTotUY9b4RX
 VPMGWCp8mzcFzEscOKuxPsyX8M342JI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rMZwnsxGPC46xABnLIzuiIVK2s50sf9Lrt0fRlj+Nw=;
 b=EOp35z02SsxbRyuCUDPgEg+WYWAmNnqUtVlAjOsTnmBYsrS1U9TDh45YL9aMkHJiEGKJAY
 APacNNBwUgUpQwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C4F6139D0;
 Tue, 20 Feb 2024 22:42:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eAo0Nb0q1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v4 11/34] migration/ram: Introduce 'fixed-ram' migration
 capability
Date: Tue, 20 Feb 2024 19:41:15 -0300
Message-Id: <20240220224138.24759-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add a new migration capability 'fixed-ram'.

The core of the feature is to ensure that each RAM page has a specific
offset in the resulting migration stream. The reasons why we'd want
such behavior are:

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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- update migration.json to 9.0 and improve wording
- move docs to a separate file and add use cases information
---
 docs/devel/migration/features.rst  |   1 +
 docs/devel/migration/fixed-ram.rst | 137 +++++++++++++++++++++++++++++
 migration/options.c                |  34 +++++++
 migration/options.h                |   1 +
 migration/savevm.c                 |   1 +
 qapi/migration.json                |   6 +-
 6 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 docs/devel/migration/fixed-ram.rst

diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index a9acaf618e..4c708b679a 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -10,3 +10,4 @@ Migration has plenty of features to support different use cases.
    dirty-limit
    vfio
    virtio
+   fixed-ram
diff --git a/docs/devel/migration/fixed-ram.rst b/docs/devel/migration/fixed-ram.rst
new file mode 100644
index 0000000000..a6c0e5a360
--- /dev/null
+++ b/docs/devel/migration/fixed-ram.rst
@@ -0,0 +1,137 @@
+Fixed-ram
+=========
+
+Fixed-ram is a new stream format for the RAM section designed to
+supplement the existing ``file:`` migration and make it compatible
+with ``multifd``. This enables parallel migration of a guest's RAM to
+a file.
+
+The core of the feature is to ensure that each RAM page has a specific
+offset in the resulting migration file. This enables the ``multifd``
+threads to write exclusively to those offsets even if the guest is
+constantly dirtying pages (i.e. live migration). Another benefit is
+that the resulting file will have a bounded size, since pages which
+are dirtied multiple times will always go to a fixed location in the
+file, rather than constantly being added to a sequential
+stream. Having the pages at fixed offsets also allows the usage of
+O_DIRECT for save/restore of the migration stream as the pages are
+ensured to be written respecting O_DIRECT alignment restrictions.
+
+Usage
+-----
+
+On both source and destination, enable the ``multifd`` and
+``fixed-ram`` capabilities:
+
+    ``migrate_set_capability multifd on``
+
+    ``migrate_set_capability fixed-ram on``
+
+Use a ``file:`` URL for migration:
+
+    ``migrate file:/path/to/migration/file``
+
+Fixed-ram migration is best done non-live, i.e. by stopping the VM on
+the source side before migrating.
+
+For best performance enable the ``direct-io`` capability as well:
+
+    ``migrate_set_capability direct-io on``
+
+Use-cases
+---------
+
+The fixed-ram feature was designed for use cases where the migration
+stream will be directed to a file in the filesystem and not
+immediately restored on the destination VM [#]_. These could be
+thought of as snapshots. We can further categorize them into live and
+non-live.
+
+- Non-live snapshot
+
+If the use case requires a VM to be stopped before taking a snapshot,
+that's the ideal scenario for fixed-ram migration. Not having to track
+dirty pages, the migration will write the RAM pages to the disk as
+fast as it can.
+
+Note: if a snapshot is taken of a running VM, but the VM will be
+stopped after the snapshot by the admin, then consider stopping it
+right before the snapshot to take benefit of the performance gains
+mentioned above.
+
+- Live snapshot
+
+If the use case requires that the VM keeps running during and after
+the snapshot operation, then fixed-ram migration can still be used,
+but will be less performant. Other strategies such as
+background-snapshot should be evaluated as well. One benefit of
+fixed-ram in this scenario is portability since background-snapshot
+depends on async dirty tracking (KVM_GET_DIRTY_LOG) which is not
+supported outside of Linux.
+
+.. [#] While this same effect could be obtained with the usage of
+       snapshots or the ``file:`` migration alone, fixed-ram provides
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
+ Without fixed-ram:                  With fixed-ram:
+
+ ---------------------               --------------------------------
+ | ramblock 1 header |               | ramblock 1 header            |
+ ---------------------               --------------------------------
+ | ramblock 2 header |               | ramblock 1 fixed-ram header  |
+ ---------------------               --------------------------------
+ | ...               |               | padding to next 1MB boundary |
+ ---------------------               | ...                          |
+ | ramblock n header |               --------------------------------
+ ---------------------               | ramblock 1 pages             |
+ | RAM_SAVE_FLAG_EOS |               | ...                          |
+ ---------------------               --------------------------------
+ | stream of pages   |               | ramblock 2 header            |
+ | (iter 1)          |               --------------------------------
+ | ...               |               | ramblock 2 fixed-ram header  |
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
+ where:
+  - ramblock header: the generic information for a ramblock, such as
+    idstr, used_len, etc.
+
+  - ramblock fixed-ram header: the information added by this feature:
+    bitmap of pages written, bitmap size and offset of pages in the
+    migration file.
+
+Restrictions
+------------
+
+Since pages are written to their relative offsets and out of order
+(due to the memory dirtying patterns), streaming channels such as
+sockets are not supported. A seekable channel such as a file is
+required. This can be verified in the QIOChannel by the presence of
+the QIO_CHANNEL_FEATURE_SEEKABLE.
diff --git a/migration/options.c b/migration/options.c
index 3e3e0b93b4..4909e5c72a 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -204,6 +204,7 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-switchover-ack",
                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
+    DEFINE_PROP_MIG_CAP("x-fixed-ram", MIGRATION_CAPABILITY_FIXED_RAM),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -263,6 +264,13 @@ bool migrate_events(void)
     return s->capabilities[MIGRATION_CAPABILITY_EVENTS];
 }
 
+bool migrate_fixed_ram(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_FIXED_RAM];
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
@@ -645,6 +653,32 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
+    if (new_caps[MIGRATION_CAPABILITY_FIXED_RAM]) {
+        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
+            error_setg(errp,
+                       "Fixed-ram migration is incompatible with multifd");
+            return false;
+        }
+
+        if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
+            error_setg(errp,
+                       "Fixed-ram migration is incompatible with xbzrle");
+            return false;
+        }
+
+        if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
+            error_setg(errp,
+                       "Fixed-ram migration is incompatible with compression");
+            return false;
+        }
+
+        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+            error_setg(errp,
+                       "Fixed-ram migration is incompatible with postcopy ram");
+            return false;
+        }
+    }
+
     return true;
 }
 
diff --git a/migration/options.h b/migration/options.h
index 246c160aee..8680a10b79 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -31,6 +31,7 @@ bool migrate_compress(void);
 bool migrate_dirty_bitmaps(void);
 bool migrate_dirty_limit(void);
 bool migrate_events(void);
+bool migrate_fixed_ram(void);
 bool migrate_ignore_shared(void);
 bool migrate_late_block_activate(void);
 bool migrate_multifd(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index d612c8a902..4b928dd6bb 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -245,6 +245,7 @@ static bool should_validate_capability(int capability)
     /* Validate only new capabilities to keep compatibility. */
     switch (capability) {
     case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
+    case MIGRATION_CAPABILITY_FIXED_RAM:
         return true;
     default:
         return false;
diff --git a/qapi/migration.json b/qapi/migration.json
index 5a565d9b8d..3fce5fe53e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -531,6 +531,10 @@
 #     and can result in more stable read performance.  Requires KVM
 #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
 #
+# @fixed-ram: Migrate using fixed offsets in the migration file for
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
+           'dirty-limit', 'fixed-ram'] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.35.3


