Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB49C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 13:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0LPW-0002yQ-VK; Fri, 26 Apr 2024 09:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0LPP-0002x4-7f
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:14:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0LPH-0001cZ-2N
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:14:33 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B80625D100;
 Fri, 26 Apr 2024 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714137264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTQG1cFxvanNzUlidRjbCSEgx/ocpLizFpvQp7vbwI8=;
 b=IJ9AdB/7BZh7ZFfgMJwcMYftpvHPyGjKoRfkC+uohQFd4oSjr7XUvi4otg9WzI5IyV0BK4
 3gC4I46UsRmVWMVKI2ZeQG6PpqFZ00DHDRNljs1ksdvIUPHc+rmPkpfRWwr9VD4H4IGg+S
 F/ysNXA4fWrTBQCEHtFHBFhWHqmFKUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714137264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTQG1cFxvanNzUlidRjbCSEgx/ocpLizFpvQp7vbwI8=;
 b=3fJIJYCaQblgW0BlikuInQ4oru+oDVDzx2fWhSk5cQ3RydiHA3ypMn1GtBxZtNDZQOxpqJ
 U8PvgIWT3UvJ9VDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="IJ9AdB/7";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3fJIJYCa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714137264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTQG1cFxvanNzUlidRjbCSEgx/ocpLizFpvQp7vbwI8=;
 b=IJ9AdB/7BZh7ZFfgMJwcMYftpvHPyGjKoRfkC+uohQFd4oSjr7XUvi4otg9WzI5IyV0BK4
 3gC4I46UsRmVWMVKI2ZeQG6PpqFZ00DHDRNljs1ksdvIUPHc+rmPkpfRWwr9VD4H4IGg+S
 F/ysNXA4fWrTBQCEHtFHBFhWHqmFKUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714137264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTQG1cFxvanNzUlidRjbCSEgx/ocpLizFpvQp7vbwI8=;
 b=3fJIJYCaQblgW0BlikuInQ4oru+oDVDzx2fWhSk5cQ3RydiHA3ypMn1GtBxZtNDZQOxpqJ
 U8PvgIWT3UvJ9VDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 847D01398B;
 Fri, 26 Apr 2024 13:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IA/XEq2oK2bcXQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Apr 2024 13:14:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 4/6] migration: Remove block migration
Date: Fri, 26 Apr 2024 10:14:06 -0300
Message-Id: <20240426131408.25410-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240426131408.25410-1-farosas@suse.de>
References: <20240426131408.25410-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B80625D100
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The block migration has been considered obsolete since QEMU 8.2 in
favor of the more flexible storage migration provided by the
blockdev-mirror driver. Two releases have passed so now it's time to
remove it.

Deprecation commit 66db46ca83 ("migration: Deprecate block
migration").

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 MAINTAINERS                     |    1 -
 docs/about/deprecated.rst       |   10 -
 docs/about/removed-features.rst |   14 +
 docs/devel/migration/main.rst   |    2 +-
 include/migration/misc.h        |    6 -
 meson.build                     |    2 -
 meson_options.txt               |    2 -
 migration/block.c               | 1018 -------------------------------
 migration/block.h               |   52 --
 migration/colo.c                |    1 -
 migration/meson.build           |    3 -
 migration/migration-hmp-cmds.c  |   25 -
 migration/migration.c           |   17 -
 migration/options.c             |   36 --
 migration/ram.c                 |   15 -
 migration/savevm.c              |    5 -
 qapi/migration.json             |   61 +-
 scripts/meson-buildoptions.sh   |    4 -
 18 files changed, 26 insertions(+), 1248 deletions(-)
 delete mode 100644 migration/block.c
 delete mode 100644 migration/block.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 96411e6adf..048d68ad5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2865,7 +2865,6 @@ F: util/aio-*.h
 F: util/defer-call.c
 F: util/fdmon-*.c
 F: block/io.c
-F: migration/block*
 F: include/block/aio.h
 F: include/block/aio-wait.h
 F: include/qemu/defer-call.h
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d739358bb1..3b9b5ba6ef 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -468,16 +468,6 @@ option).
 Migration
 ---------
 
-block migration (since 8.2)
-'''''''''''''''''''''''''''
-
-Block migration is too inflexible.  It needs to migrate all block
-devices or none.
-
-Please see "QMP invocation for live storage migration with
-``blockdev-mirror`` + NBD" in docs/interop/live-block-operations.rst
-for a detailed explanation.
-
 old compression method (since 8.2)
 ''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index a491c66660..9e7d8ee4ff 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -634,6 +634,13 @@ Use blockdev-mirror with NBD instead. See "QMP invocation for live
 storage migration with ``blockdev-mirror`` + NBD" in
 docs/interop/live-block-operations.rst for a detailed explanation.
 
+``migrate-set-capabilities`` ``block`` option (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Block migration has been removed. For a replacement, see "QMP
+invocation for live storage migration with ``blockdev-mirror`` + NBD"
+in docs/interop/live-block-operations.rst.
+
 Human Monitor Protocol (HMP) commands
 -------------------------------------
 
@@ -708,6 +715,13 @@ Use blockdev-mirror with NBD instead. See "QMP invocation for live
 storage migration with ``blockdev-mirror`` + NBD" in
 docs/interop/live-block-operations.rst for a detailed explanation.
 
+``migrate_set_capability`` ``block`` option (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Block migration has been removed. For a replacement, see "QMP
+invocation for live storage migration with ``blockdev-mirror`` + NBD"
+in docs/interop/live-block-operations.rst.
+
 Host Architectures
 ------------------
 
diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 54385a23e5..495cdcb112 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -454,7 +454,7 @@ Examples of such API functions are:
 Iterative device migration
 --------------------------
 
-Some devices, such as RAM, Block storage or certain platform devices,
+Some devices, such as RAM or certain platform devices,
 have large amounts of data that would mean that the CPUs would be
 paused for too long if they were sent in one section.  For these
 devices an *iterative* approach is taken.
diff --git a/include/migration/misc.h b/include/migration/misc.h
index c9e200f4eb..bf7339cc1e 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -45,12 +45,6 @@ bool migrate_ram_is_ignored(RAMBlock *block);
 
 /* migration/block.c */
 
-#ifdef CONFIG_LIVE_BLOCK_MIGRATION
-void blk_mig_init(void);
-#else
-static inline void blk_mig_init(void) {}
-#endif
-
 AnnounceParameters *migrate_announce_params(void);
 /* migration/savevm.c */
 
diff --git a/meson.build b/meson.build
index 553b940999..8c99187582 100644
--- a/meson.build
+++ b/meson.build
@@ -2351,7 +2351,6 @@ config_host_data.set('CONFIG_DEBUG_MUTEX', get_option('debug_mutex'))
 config_host_data.set('CONFIG_DEBUG_STACK_USAGE', get_option('debug_stack_usage'))
 config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
 config_host_data.set('CONFIG_DEBUG_REMAP', get_option('debug_remap'))
-config_host_data.set('CONFIG_LIVE_BLOCK_MIGRATION', get_option('live_block_migration').allowed())
 config_host_data.set('CONFIG_QOM_CAST_DEBUG', get_option('qom_cast_debug'))
 config_host_data.set('CONFIG_REPLICATION', get_option('replication').allowed())
 
@@ -4300,7 +4299,6 @@ if have_block
   summary_info += {'Use block whitelist in tools': get_option('block_drv_whitelist_in_tools')}
   summary_info += {'VirtFS (9P) support':    have_virtfs}
   summary_info += {'VirtFS (9P) Proxy Helper support (deprecated)': have_virtfs_proxy_helper}
-  summary_info += {'Live block migration': config_host_data.get('CONFIG_LIVE_BLOCK_MIGRATION')}
   summary_info += {'replication support': config_host_data.get('CONFIG_REPLICATION')}
   summary_info += {'bochs support':     get_option('bochs').allowed()}
   summary_info += {'cloop support':     get_option('cloop').allowed()}
diff --git a/meson_options.txt b/meson_options.txt
index adc77bae0c..4c1583eb40 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -314,8 +314,6 @@ option('fdt', type: 'combo', value: 'auto',
 
 option('selinux', type: 'feature', value: 'auto',
        description: 'SELinux support in qemu-nbd')
-option('live_block_migration', type: 'feature', value: 'auto',
-       description: 'block migration in the main migration stream')
 option('replication', type: 'feature', value: 'auto',
        description: 'replication support')
 option('colo_proxy', type: 'feature', value: 'auto',
diff --git a/migration/block.c b/migration/block.c
deleted file mode 100644
index 87ec1a7e68..0000000000
--- a/migration/block.c
+++ /dev/null
@@ -1,1018 +0,0 @@
-/*
- * QEMU live block migration
- *
- * Copyright IBM, Corp. 2009
- *
- * Authors:
- *  Liran Schour   <lirans@il.ibm.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "qemu/error-report.h"
-#include "qemu/main-loop.h"
-#include "qemu/cutils.h"
-#include "qemu/queue.h"
-#include "block.h"
-#include "block/dirty-bitmap.h"
-#include "migration/misc.h"
-#include "migration.h"
-#include "migration-stats.h"
-#include "migration/register.h"
-#include "qemu-file.h"
-#include "migration/vmstate.h"
-#include "sysemu/block-backend.h"
-#include "trace.h"
-#include "options.h"
-
-#define BLK_MIG_BLOCK_SIZE           (1ULL << 20)
-#define BDRV_SECTORS_PER_DIRTY_CHUNK (BLK_MIG_BLOCK_SIZE >> BDRV_SECTOR_BITS)
-
-#define BLK_MIG_FLAG_DEVICE_BLOCK       0x01
-#define BLK_MIG_FLAG_EOS                0x02
-#define BLK_MIG_FLAG_PROGRESS           0x04
-#define BLK_MIG_FLAG_ZERO_BLOCK         0x08
-
-#define MAX_IS_ALLOCATED_SEARCH (65536 * BDRV_SECTOR_SIZE)
-
-#define MAX_IO_BUFFERS 512
-#define MAX_PARALLEL_IO 16
-
-typedef struct BlkMigDevState {
-    /* Written during setup phase.  Can be read without a lock.  */
-    BlockBackend *blk;
-    char *blk_name;
-    int shared_base;
-    int64_t total_sectors;
-    QSIMPLEQ_ENTRY(BlkMigDevState) entry;
-    Error *blocker;
-
-    /* Only used by migration thread.  Does not need a lock.  */
-    int bulk_completed;
-    int64_t cur_sector;
-    int64_t cur_dirty;
-
-    /* Data in the aio_bitmap is protected by block migration lock.
-     * Allocation and free happen during setup and cleanup respectively.
-     */
-    unsigned long *aio_bitmap;
-
-    /* Protected by block migration lock.  */
-    int64_t completed_sectors;
-
-    /* During migration this is protected by bdrv_dirty_bitmap_lock().
-     * Allocation and free happen during setup and cleanup respectively.
-     */
-    BdrvDirtyBitmap *dirty_bitmap;
-} BlkMigDevState;
-
-typedef struct BlkMigBlock {
-    /* Only used by migration thread.  */
-    uint8_t *buf;
-    BlkMigDevState *bmds;
-    int64_t sector;
-    int nr_sectors;
-    QEMUIOVector qiov;
-    BlockAIOCB *aiocb;
-
-    /* Protected by block migration lock.  */
-    int ret;
-    QSIMPLEQ_ENTRY(BlkMigBlock) entry;
-} BlkMigBlock;
-
-typedef struct BlkMigState {
-    QSIMPLEQ_HEAD(, BlkMigDevState) bmds_list;
-    int64_t total_sector_sum;
-    bool zero_blocks;
-
-    /* Protected by lock.  */
-    QSIMPLEQ_HEAD(, BlkMigBlock) blk_list;
-    int submitted;
-    int read_done;
-
-    /* Only used by migration thread.  Does not need a lock.  */
-    int transferred;
-    int prev_progress;
-    int bulk_completed;
-
-    /* Lock must be taken _inside_ the BQL.  */
-    QemuMutex lock;
-} BlkMigState;
-
-static BlkMigState block_mig_state;
-
-static void blk_mig_lock(void)
-{
-    qemu_mutex_lock(&block_mig_state.lock);
-}
-
-static void blk_mig_unlock(void)
-{
-    qemu_mutex_unlock(&block_mig_state.lock);
-}
-
-/* Must run outside of the BQL during the bulk phase,
- * or the VM will stall.
- */
-
-static void blk_send(QEMUFile *f, BlkMigBlock * blk)
-{
-    int len;
-    uint64_t flags = BLK_MIG_FLAG_DEVICE_BLOCK;
-
-    if (block_mig_state.zero_blocks &&
-        buffer_is_zero(blk->buf, BLK_MIG_BLOCK_SIZE)) {
-        flags |= BLK_MIG_FLAG_ZERO_BLOCK;
-    }
-
-    /* sector number and flags */
-    qemu_put_be64(f, (blk->sector << BDRV_SECTOR_BITS)
-                     | flags);
-
-    /* device name */
-    len = strlen(blk->bmds->blk_name);
-    qemu_put_byte(f, len);
-    qemu_put_buffer(f, (uint8_t *) blk->bmds->blk_name, len);
-
-    /* if a block is zero we need to flush here since the network
-     * bandwidth is now a lot higher than the storage device bandwidth.
-     * thus if we queue zero blocks we slow down the migration */
-    if (flags & BLK_MIG_FLAG_ZERO_BLOCK) {
-        qemu_fflush(f);
-        return;
-    }
-
-    qemu_put_buffer(f, blk->buf, BLK_MIG_BLOCK_SIZE);
-}
-
-int blk_mig_active(void)
-{
-    return !QSIMPLEQ_EMPTY(&block_mig_state.bmds_list);
-}
-
-int blk_mig_bulk_active(void)
-{
-    return blk_mig_active() && !block_mig_state.bulk_completed;
-}
-
-uint64_t blk_mig_bytes_transferred(void)
-{
-    BlkMigDevState *bmds;
-    uint64_t sum = 0;
-
-    blk_mig_lock();
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        sum += bmds->completed_sectors;
-    }
-    blk_mig_unlock();
-    return sum << BDRV_SECTOR_BITS;
-}
-
-uint64_t blk_mig_bytes_remaining(void)
-{
-    return blk_mig_bytes_total() - blk_mig_bytes_transferred();
-}
-
-uint64_t blk_mig_bytes_total(void)
-{
-    BlkMigDevState *bmds;
-    uint64_t sum = 0;
-
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        sum += bmds->total_sectors;
-    }
-    return sum << BDRV_SECTOR_BITS;
-}
-
-
-/* Called with migration lock held.  */
-
-static int bmds_aio_inflight(BlkMigDevState *bmds, int64_t sector)
-{
-    int64_t chunk = sector / (int64_t)BDRV_SECTORS_PER_DIRTY_CHUNK;
-
-    if (sector < bmds->total_sectors) {
-        return !!(bmds->aio_bitmap[chunk / (sizeof(unsigned long) * 8)] &
-            (1UL << (chunk % (sizeof(unsigned long) * 8))));
-    } else {
-        return 0;
-    }
-}
-
-/* Called with migration lock held.  */
-
-static void bmds_set_aio_inflight(BlkMigDevState *bmds, int64_t sector_num,
-                             int nb_sectors, int set)
-{
-    int64_t start, end;
-    unsigned long val, idx, bit;
-
-    start = sector_num / BDRV_SECTORS_PER_DIRTY_CHUNK;
-    end = (sector_num + nb_sectors - 1) / BDRV_SECTORS_PER_DIRTY_CHUNK;
-
-    for (; start <= end; start++) {
-        idx = start / (sizeof(unsigned long) * 8);
-        bit = start % (sizeof(unsigned long) * 8);
-        val = bmds->aio_bitmap[idx];
-        if (set) {
-            val |= 1UL << bit;
-        } else {
-            val &= ~(1UL << bit);
-        }
-        bmds->aio_bitmap[idx] = val;
-    }
-}
-
-static void alloc_aio_bitmap(BlkMigDevState *bmds)
-{
-    int64_t bitmap_size;
-
-    bitmap_size = bmds->total_sectors + BDRV_SECTORS_PER_DIRTY_CHUNK * 8 - 1;
-    bitmap_size /= BDRV_SECTORS_PER_DIRTY_CHUNK * 8;
-
-    bmds->aio_bitmap = g_malloc0(bitmap_size);
-}
-
-/* Never hold migration lock when yielding to the main loop!  */
-
-static void blk_mig_read_cb(void *opaque, int ret)
-{
-    BlkMigBlock *blk = opaque;
-
-    blk_mig_lock();
-    blk->ret = ret;
-
-    QSIMPLEQ_INSERT_TAIL(&block_mig_state.blk_list, blk, entry);
-    bmds_set_aio_inflight(blk->bmds, blk->sector, blk->nr_sectors, 0);
-
-    block_mig_state.submitted--;
-    block_mig_state.read_done++;
-    assert(block_mig_state.submitted >= 0);
-    blk_mig_unlock();
-}
-
-/* Called with no lock taken.  */
-
-static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
-{
-    int64_t total_sectors = bmds->total_sectors;
-    int64_t cur_sector = bmds->cur_sector;
-    BlockBackend *bb = bmds->blk;
-    BlkMigBlock *blk;
-    int nr_sectors;
-    int64_t count;
-
-    if (bmds->shared_base) {
-        bql_lock();
-        /* Skip unallocated sectors; intentionally treats failure or
-         * partial sector as an allocated sector */
-        while (cur_sector < total_sectors &&
-               !bdrv_is_allocated(blk_bs(bb), cur_sector * BDRV_SECTOR_SIZE,
-                                  MAX_IS_ALLOCATED_SEARCH, &count)) {
-            if (count < BDRV_SECTOR_SIZE) {
-                break;
-            }
-            cur_sector += count >> BDRV_SECTOR_BITS;
-        }
-        bql_unlock();
-    }
-
-    if (cur_sector >= total_sectors) {
-        bmds->cur_sector = bmds->completed_sectors = total_sectors;
-        return 1;
-    }
-
-    bmds->completed_sectors = cur_sector;
-
-    cur_sector &= ~((int64_t)BDRV_SECTORS_PER_DIRTY_CHUNK - 1);
-
-    /* we are going to transfer a full block even if it is not allocated */
-    nr_sectors = BDRV_SECTORS_PER_DIRTY_CHUNK;
-
-    if (total_sectors - cur_sector < BDRV_SECTORS_PER_DIRTY_CHUNK) {
-        nr_sectors = total_sectors - cur_sector;
-    }
-
-    blk = g_new(BlkMigBlock, 1);
-    blk->buf = g_malloc(BLK_MIG_BLOCK_SIZE);
-    blk->bmds = bmds;
-    blk->sector = cur_sector;
-    blk->nr_sectors = nr_sectors;
-
-    qemu_iovec_init_buf(&blk->qiov, blk->buf, nr_sectors * BDRV_SECTOR_SIZE);
-
-    blk_mig_lock();
-    block_mig_state.submitted++;
-    blk_mig_unlock();
-
-    /*
-     * The migration thread does not have an AioContext. Lock the BQL so that
-     * I/O runs in the main loop AioContext (see
-     * qemu_get_current_aio_context()).
-     */
-    bql_lock();
-    bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, cur_sector * BDRV_SECTOR_SIZE,
-                            nr_sectors * BDRV_SECTOR_SIZE);
-    blk->aiocb = blk_aio_preadv(bb, cur_sector * BDRV_SECTOR_SIZE, &blk->qiov,
-                                0, blk_mig_read_cb, blk);
-    bql_unlock();
-
-    bmds->cur_sector = cur_sector + nr_sectors;
-    return (bmds->cur_sector >= total_sectors);
-}
-
-/* Called with the BQL taken.  */
-
-static int set_dirty_tracking(void)
-{
-    BlkMigDevState *bmds;
-    int ret;
-
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        bmds->dirty_bitmap = bdrv_create_dirty_bitmap(blk_bs(bmds->blk),
-                                                      BLK_MIG_BLOCK_SIZE,
-                                                      NULL, NULL);
-        if (!bmds->dirty_bitmap) {
-            ret = -errno;
-            goto fail;
-        }
-    }
-    return 0;
-
-fail:
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        if (bmds->dirty_bitmap) {
-            bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
-        }
-    }
-    return ret;
-}
-
-/* Called with the BQL taken.  */
-
-static void unset_dirty_tracking(void)
-{
-    BlkMigDevState *bmds;
-
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        if (bmds->dirty_bitmap) {
-            bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
-        }
-    }
-}
-
-static int init_blk_migration(QEMUFile *f, Error **errp)
-{
-    BlockDriverState *bs;
-    BlkMigDevState *bmds;
-    int64_t sectors;
-    BdrvNextIterator it;
-    int i, num_bs = 0;
-    struct {
-        BlkMigDevState *bmds;
-        BlockDriverState *bs;
-    } *bmds_bs;
-    int ret;
-
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
-
-    block_mig_state.submitted = 0;
-    block_mig_state.read_done = 0;
-    block_mig_state.transferred = 0;
-    block_mig_state.total_sector_sum = 0;
-    block_mig_state.prev_progress = -1;
-    block_mig_state.bulk_completed = 0;
-    block_mig_state.zero_blocks = migrate_zero_blocks();
-
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        num_bs++;
-    }
-    bmds_bs = g_malloc0(num_bs * sizeof(*bmds_bs));
-
-    for (i = 0, bs = bdrv_first(&it); bs; bs = bdrv_next(&it), i++) {
-        if (bdrv_is_read_only(bs)) {
-            continue;
-        }
-
-        sectors = bdrv_nb_sectors(bs);
-        if (sectors == 0) {
-            continue;
-        }
-        if (sectors < 0) {
-            error_setg(errp, "Error getting length of block device %s",
-                       bdrv_get_device_name(bs));
-            ret = sectors;
-            bdrv_next_cleanup(&it);
-            goto out;
-        }
-
-        bmds = g_new0(BlkMigDevState, 1);
-        bmds->blk = blk_new(qemu_get_aio_context(),
-                            BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
-        bmds->blk_name = g_strdup(bdrv_get_device_name(bs));
-        bmds->bulk_completed = 0;
-        bmds->total_sectors = sectors;
-        bmds->completed_sectors = 0;
-
-        assert(i < num_bs);
-        bmds_bs[i].bmds = bmds;
-        bmds_bs[i].bs = bs;
-
-        block_mig_state.total_sector_sum += sectors;
-
-        if (bmds->shared_base) {
-            trace_migration_block_init_shared(bdrv_get_device_name(bs));
-        } else {
-            trace_migration_block_init_full(bdrv_get_device_name(bs));
-        }
-
-        QSIMPLEQ_INSERT_TAIL(&block_mig_state.bmds_list, bmds, entry);
-    }
-
-    /* Can only insert new BDSes now because doing so while iterating block
-     * devices may end up in a deadlock (iterating the new BDSes, too). */
-    for (i = 0; i < num_bs; i++) {
-        bmds = bmds_bs[i].bmds;
-        bs = bmds_bs[i].bs;
-
-        if (bmds) {
-            ret = blk_insert_bs(bmds->blk, bs, errp);
-            if (ret < 0) {
-                goto out;
-            }
-
-            alloc_aio_bitmap(bmds);
-            error_setg(&bmds->blocker, "block device is in use by migration");
-            bdrv_op_block_all(bs, bmds->blocker);
-        }
-    }
-
-    ret = 0;
-out:
-    g_free(bmds_bs);
-    return ret;
-}
-
-/* Called with no lock taken.  */
-
-static int blk_mig_save_bulked_block(QEMUFile *f)
-{
-    int64_t completed_sector_sum = 0;
-    BlkMigDevState *bmds;
-    int progress;
-    int ret = 0;
-
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        if (bmds->bulk_completed == 0) {
-            if (mig_save_device_bulk(f, bmds) == 1) {
-                /* completed bulk section for this device */
-                bmds->bulk_completed = 1;
-            }
-            completed_sector_sum += bmds->completed_sectors;
-            ret = 1;
-            break;
-        } else {
-            completed_sector_sum += bmds->completed_sectors;
-        }
-    }
-
-    if (block_mig_state.total_sector_sum != 0) {
-        progress = completed_sector_sum * 100 /
-                   block_mig_state.total_sector_sum;
-    } else {
-        progress = 100;
-    }
-    if (progress != block_mig_state.prev_progress) {
-        block_mig_state.prev_progress = progress;
-        qemu_put_be64(f, (progress << BDRV_SECTOR_BITS)
-                         | BLK_MIG_FLAG_PROGRESS);
-        trace_migration_block_progression(progress);
-    }
-
-    return ret;
-}
-
-static void blk_mig_reset_dirty_cursor(void)
-{
-    BlkMigDevState *bmds;
-
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        bmds->cur_dirty = 0;
-    }
-}
-
-/* Called with the BQL taken.  */
-
-static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
-                                 int is_async)
-{
-    BlkMigBlock *blk;
-    int64_t total_sectors = bmds->total_sectors;
-    int64_t sector;
-    int nr_sectors;
-    int ret = -EIO;
-
-    for (sector = bmds->cur_dirty; sector < bmds->total_sectors;) {
-        blk_mig_lock();
-        if (bmds_aio_inflight(bmds, sector)) {
-            blk_mig_unlock();
-            blk_drain(bmds->blk);
-        } else {
-            blk_mig_unlock();
-        }
-        bdrv_dirty_bitmap_lock(bmds->dirty_bitmap);
-        if (bdrv_dirty_bitmap_get_locked(bmds->dirty_bitmap,
-                                         sector * BDRV_SECTOR_SIZE)) {
-            if (total_sectors - sector < BDRV_SECTORS_PER_DIRTY_CHUNK) {
-                nr_sectors = total_sectors - sector;
-            } else {
-                nr_sectors = BDRV_SECTORS_PER_DIRTY_CHUNK;
-            }
-            bdrv_reset_dirty_bitmap_locked(bmds->dirty_bitmap,
-                                           sector * BDRV_SECTOR_SIZE,
-                                           nr_sectors * BDRV_SECTOR_SIZE);
-            bdrv_dirty_bitmap_unlock(bmds->dirty_bitmap);
-
-            blk = g_new(BlkMigBlock, 1);
-            blk->buf = g_malloc(BLK_MIG_BLOCK_SIZE);
-            blk->bmds = bmds;
-            blk->sector = sector;
-            blk->nr_sectors = nr_sectors;
-
-            if (is_async) {
-                qemu_iovec_init_buf(&blk->qiov, blk->buf,
-                                    nr_sectors * BDRV_SECTOR_SIZE);
-
-                blk->aiocb = blk_aio_preadv(bmds->blk,
-                                            sector * BDRV_SECTOR_SIZE,
-                                            &blk->qiov, 0, blk_mig_read_cb,
-                                            blk);
-
-                blk_mig_lock();
-                block_mig_state.submitted++;
-                bmds_set_aio_inflight(bmds, sector, nr_sectors, 1);
-                blk_mig_unlock();
-            } else {
-                ret = blk_pread(bmds->blk, sector * BDRV_SECTOR_SIZE,
-                                nr_sectors * BDRV_SECTOR_SIZE, blk->buf, 0);
-                if (ret < 0) {
-                    goto error;
-                }
-                blk_send(f, blk);
-
-                g_free(blk->buf);
-                g_free(blk);
-            }
-
-            sector += nr_sectors;
-            bmds->cur_dirty = sector;
-            break;
-        }
-
-        bdrv_dirty_bitmap_unlock(bmds->dirty_bitmap);
-        sector += BDRV_SECTORS_PER_DIRTY_CHUNK;
-        bmds->cur_dirty = sector;
-    }
-
-    return (bmds->cur_dirty >= bmds->total_sectors);
-
-error:
-    trace_migration_block_save_device_dirty(sector);
-    g_free(blk->buf);
-    g_free(blk);
-    return ret;
-}
-
-/* Called with the BQL taken.
- *
- * return value:
- * 0: too much data for max_downtime
- * 1: few enough data for max_downtime
-*/
-static int blk_mig_save_dirty_block(QEMUFile *f, int is_async)
-{
-    BlkMigDevState *bmds;
-    int ret = 1;
-
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        ret = mig_save_device_dirty(f, bmds, is_async);
-        if (ret <= 0) {
-            break;
-        }
-    }
-
-    return ret;
-}
-
-/* Called with no locks taken.  */
-
-static int flush_blks(QEMUFile *f)
-{
-    BlkMigBlock *blk;
-    int ret = 0;
-
-    trace_migration_block_flush_blks("Enter", block_mig_state.submitted,
-                                     block_mig_state.read_done,
-                                     block_mig_state.transferred);
-
-    blk_mig_lock();
-    while ((blk = QSIMPLEQ_FIRST(&block_mig_state.blk_list)) != NULL) {
-        if (migration_rate_exceeded(f)) {
-            break;
-        }
-        if (blk->ret < 0) {
-            ret = blk->ret;
-            break;
-        }
-
-        QSIMPLEQ_REMOVE_HEAD(&block_mig_state.blk_list, entry);
-        blk_mig_unlock();
-        blk_send(f, blk);
-        blk_mig_lock();
-
-        g_free(blk->buf);
-        g_free(blk);
-
-        block_mig_state.read_done--;
-        block_mig_state.transferred++;
-        assert(block_mig_state.read_done >= 0);
-    }
-    blk_mig_unlock();
-
-    trace_migration_block_flush_blks("Exit", block_mig_state.submitted,
-                                     block_mig_state.read_done,
-                                     block_mig_state.transferred);
-    return ret;
-}
-
-/* Called with the BQL taken.  */
-
-static int64_t get_remaining_dirty(void)
-{
-    BlkMigDevState *bmds;
-    int64_t dirty = 0;
-
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        bdrv_dirty_bitmap_lock(bmds->dirty_bitmap);
-        dirty += bdrv_get_dirty_count(bmds->dirty_bitmap);
-        bdrv_dirty_bitmap_unlock(bmds->dirty_bitmap);
-    }
-
-    return dirty;
-}
-
-
-
-/* Called with the BQL taken.  */
-static void block_migration_cleanup_bmds(void)
-{
-    BlkMigDevState *bmds;
-    BlockDriverState *bs;
-
-    unset_dirty_tracking();
-
-    while ((bmds = QSIMPLEQ_FIRST(&block_mig_state.bmds_list)) != NULL) {
-        QSIMPLEQ_REMOVE_HEAD(&block_mig_state.bmds_list, entry);
-
-        bs = blk_bs(bmds->blk);
-        if (bs) {
-            bdrv_op_unblock_all(bs, bmds->blocker);
-        }
-        error_free(bmds->blocker);
-        blk_unref(bmds->blk);
-        g_free(bmds->blk_name);
-        g_free(bmds->aio_bitmap);
-        g_free(bmds);
-    }
-}
-
-/* Called with the BQL taken.  */
-static void block_migration_cleanup(void *opaque)
-{
-    BlkMigBlock *blk;
-
-    bdrv_drain_all();
-
-    block_migration_cleanup_bmds();
-
-    blk_mig_lock();
-    while ((blk = QSIMPLEQ_FIRST(&block_mig_state.blk_list)) != NULL) {
-        QSIMPLEQ_REMOVE_HEAD(&block_mig_state.blk_list, entry);
-        g_free(blk->buf);
-        g_free(blk);
-    }
-    blk_mig_unlock();
-}
-
-static int block_save_setup(QEMUFile *f, void *opaque, Error **errp)
-{
-    int ret;
-
-    trace_migration_block_save("setup", block_mig_state.submitted,
-                               block_mig_state.transferred);
-
-    warn_report("block migration is deprecated;"
-                " use blockdev-mirror with NBD instead");
-
-    ret = init_blk_migration(f, errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    /* start track dirty blocks */
-    ret = set_dirty_tracking();
-    if (ret) {
-        error_setg_errno(errp, -ret, "Failed to start block dirty tracking");
-        return ret;
-    }
-
-    ret = flush_blks(f);
-    if (ret) {
-        error_setg_errno(errp, -ret, "Flushing block failed");
-        return ret;
-    }
-    blk_mig_reset_dirty_cursor();
-    qemu_put_be64(f, BLK_MIG_FLAG_EOS);
-
-    return ret;
-}
-
-static int block_save_iterate(QEMUFile *f, void *opaque)
-{
-    int ret;
-    uint64_t last_bytes = qemu_file_transferred(f);
-
-    trace_migration_block_save("iterate", block_mig_state.submitted,
-                               block_mig_state.transferred);
-
-    ret = flush_blks(f);
-    if (ret) {
-        return ret;
-    }
-
-    blk_mig_reset_dirty_cursor();
-
-    /* control the rate of transfer */
-    blk_mig_lock();
-    while (block_mig_state.read_done * BLK_MIG_BLOCK_SIZE <
-           migration_rate_get() &&
-           block_mig_state.submitted < MAX_PARALLEL_IO &&
-           (block_mig_state.submitted + block_mig_state.read_done) <
-           MAX_IO_BUFFERS) {
-        blk_mig_unlock();
-        if (block_mig_state.bulk_completed == 0) {
-            /* first finish the bulk phase */
-            if (blk_mig_save_bulked_block(f) == 0) {
-                /* finished saving bulk on all devices */
-                block_mig_state.bulk_completed = 1;
-            }
-            ret = 0;
-        } else {
-            /* Always called with the BQL taken for
-             * simplicity, block_save_complete also calls it.
-             */
-            bql_lock();
-            ret = blk_mig_save_dirty_block(f, 1);
-            bql_unlock();
-        }
-        if (ret < 0) {
-            return ret;
-        }
-        blk_mig_lock();
-        if (ret != 0) {
-            /* no more dirty blocks */
-            break;
-        }
-    }
-    blk_mig_unlock();
-
-    ret = flush_blks(f);
-    if (ret) {
-        return ret;
-    }
-
-    qemu_put_be64(f, BLK_MIG_FLAG_EOS);
-    uint64_t delta_bytes = qemu_file_transferred(f) - last_bytes;
-    return (delta_bytes > 0);
-}
-
-/* Called with the BQL taken.  */
-
-static int block_save_complete(QEMUFile *f, void *opaque)
-{
-    int ret;
-
-    trace_migration_block_save("complete", block_mig_state.submitted,
-                               block_mig_state.transferred);
-
-    ret = flush_blks(f);
-    if (ret) {
-        return ret;
-    }
-
-    blk_mig_reset_dirty_cursor();
-
-    /* we know for sure that save bulk is completed and
-       all async read completed */
-    blk_mig_lock();
-    assert(block_mig_state.submitted == 0);
-    blk_mig_unlock();
-
-    do {
-        ret = blk_mig_save_dirty_block(f, 0);
-        if (ret < 0) {
-            return ret;
-        }
-    } while (ret == 0);
-
-    /* report completion */
-    qemu_put_be64(f, (100 << BDRV_SECTOR_BITS) | BLK_MIG_FLAG_PROGRESS);
-
-    trace_migration_block_save_complete();
-
-    qemu_put_be64(f, BLK_MIG_FLAG_EOS);
-
-    /* Make sure that our BlockBackends are gone, so that the block driver
-     * nodes can be inactivated. */
-    block_migration_cleanup_bmds();
-
-    return 0;
-}
-
-static void block_state_pending(void *opaque, uint64_t *must_precopy,
-                                uint64_t *can_postcopy)
-{
-    /* Estimate pending number of bytes to send */
-    uint64_t pending;
-
-    bql_lock();
-    pending = get_remaining_dirty();
-    bql_unlock();
-
-    blk_mig_lock();
-    pending += block_mig_state.submitted * BLK_MIG_BLOCK_SIZE +
-               block_mig_state.read_done * BLK_MIG_BLOCK_SIZE;
-    blk_mig_unlock();
-
-    /* Report at least one block pending during bulk phase */
-    if (!pending && !block_mig_state.bulk_completed) {
-        pending = BLK_MIG_BLOCK_SIZE;
-    }
-
-    trace_migration_block_state_pending(pending);
-    /* We don't do postcopy */
-    *must_precopy += pending;
-}
-
-static int block_load(QEMUFile *f, void *opaque, int version_id)
-{
-    static int banner_printed;
-    int len, flags;
-    char device_name[256];
-    int64_t addr;
-    BlockBackend *blk, *blk_prev = NULL;
-    Error *local_err = NULL;
-    uint8_t *buf;
-    int64_t total_sectors = 0;
-    int nr_sectors;
-    int ret;
-    BlockDriverInfo bdi;
-    int cluster_size = BLK_MIG_BLOCK_SIZE;
-
-    do {
-        addr = qemu_get_be64(f);
-
-        flags = addr & (BDRV_SECTOR_SIZE - 1);
-        addr >>= BDRV_SECTOR_BITS;
-
-        if (flags & BLK_MIG_FLAG_DEVICE_BLOCK) {
-            /* get device name */
-            len = qemu_get_byte(f);
-            qemu_get_buffer(f, (uint8_t *)device_name, len);
-            device_name[len] = '\0';
-
-            blk = blk_by_name(device_name);
-            if (!blk) {
-                fprintf(stderr, "Error unknown block device %s\n",
-                        device_name);
-                return -EINVAL;
-            }
-
-            if (blk != blk_prev) {
-                blk_prev = blk;
-                total_sectors = blk_nb_sectors(blk);
-                if (total_sectors <= 0) {
-                    error_report("Error getting length of block device %s",
-                                 device_name);
-                    return -EINVAL;
-                }
-
-                blk_activate(blk, &local_err);
-                if (local_err) {
-                    error_report_err(local_err);
-                    return -EINVAL;
-                }
-
-                ret = bdrv_get_info(blk_bs(blk), &bdi);
-                if (ret == 0 && bdi.cluster_size > 0 &&
-                    bdi.cluster_size <= BLK_MIG_BLOCK_SIZE &&
-                    BLK_MIG_BLOCK_SIZE % bdi.cluster_size == 0) {
-                    cluster_size = bdi.cluster_size;
-                } else {
-                    cluster_size = BLK_MIG_BLOCK_SIZE;
-                }
-            }
-
-            if (total_sectors - addr < BDRV_SECTORS_PER_DIRTY_CHUNK) {
-                nr_sectors = total_sectors - addr;
-            } else {
-                nr_sectors = BDRV_SECTORS_PER_DIRTY_CHUNK;
-            }
-
-            if (flags & BLK_MIG_FLAG_ZERO_BLOCK) {
-                ret = blk_pwrite_zeroes(blk, addr * BDRV_SECTOR_SIZE,
-                                        nr_sectors * BDRV_SECTOR_SIZE,
-                                        BDRV_REQ_MAY_UNMAP);
-            } else {
-                int i;
-                int64_t cur_addr;
-                uint8_t *cur_buf;
-
-                buf = g_malloc(BLK_MIG_BLOCK_SIZE);
-                qemu_get_buffer(f, buf, BLK_MIG_BLOCK_SIZE);
-                for (i = 0; i < BLK_MIG_BLOCK_SIZE / cluster_size; i++) {
-                    cur_addr = addr * BDRV_SECTOR_SIZE + i * cluster_size;
-                    cur_buf = buf + i * cluster_size;
-
-                    if ((!block_mig_state.zero_blocks ||
-                        cluster_size < BLK_MIG_BLOCK_SIZE) &&
-                        buffer_is_zero(cur_buf, cluster_size)) {
-                        ret = blk_pwrite_zeroes(blk, cur_addr,
-                                                cluster_size,
-                                                BDRV_REQ_MAY_UNMAP);
-                    } else {
-                        ret = blk_pwrite(blk, cur_addr, cluster_size, cur_buf,
-                                         0);
-                    }
-                    if (ret < 0) {
-                        break;
-                    }
-                }
-                g_free(buf);
-            }
-
-            if (ret < 0) {
-                return ret;
-            }
-        } else if (flags & BLK_MIG_FLAG_PROGRESS) {
-            if (!banner_printed) {
-                printf("Receiving block device images\n");
-                banner_printed = 1;
-            }
-            printf("Completed %d %%%c", (int)addr,
-                   (addr == 100) ? '\n' : '\r');
-            fflush(stdout);
-        } else if (!(flags & BLK_MIG_FLAG_EOS)) {
-            fprintf(stderr, "Unknown block migration flags: 0x%x\n", flags);
-            return -EINVAL;
-        }
-        ret = qemu_file_get_error(f);
-        if (ret != 0) {
-            return ret;
-        }
-    } while (!(flags & BLK_MIG_FLAG_EOS));
-
-    return 0;
-}
-
-static bool block_is_active(void *opaque)
-{
-    return migrate_block();
-}
-
-static SaveVMHandlers savevm_block_handlers = {
-    .save_setup = block_save_setup,
-    .save_live_iterate = block_save_iterate,
-    .save_live_complete_precopy = block_save_complete,
-    .state_pending_exact = block_state_pending,
-    .state_pending_estimate = block_state_pending,
-    .load_state = block_load,
-    .save_cleanup = block_migration_cleanup,
-    .is_active = block_is_active,
-};
-
-void blk_mig_init(void)
-{
-    QSIMPLEQ_INIT(&block_mig_state.bmds_list);
-    QSIMPLEQ_INIT(&block_mig_state.blk_list);
-    qemu_mutex_init(&block_mig_state.lock);
-
-    register_savevm_live("block", 0, 1, &savevm_block_handlers,
-                         &block_mig_state);
-}
diff --git a/migration/block.h b/migration/block.h
deleted file mode 100644
index 3178609dbd..0000000000
--- a/migration/block.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * QEMU live block migration
- *
- * Copyright IBM, Corp. 2009
- *
- * Authors:
- *  Liran Schour   <lirans@il.ibm.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- */
-
-#ifndef MIGRATION_BLOCK_H
-#define MIGRATION_BLOCK_H
-
-#ifdef CONFIG_LIVE_BLOCK_MIGRATION
-int blk_mig_active(void);
-int blk_mig_bulk_active(void);
-uint64_t blk_mig_bytes_transferred(void);
-uint64_t blk_mig_bytes_remaining(void);
-uint64_t blk_mig_bytes_total(void);
-
-#else
-static inline int blk_mig_active(void)
-{
-    return false;
-}
-
-static inline int blk_mig_bulk_active(void)
-{
-    return false;
-}
-
-static inline uint64_t blk_mig_bytes_transferred(void)
-{
-    return 0;
-}
-
-static inline uint64_t blk_mig_bytes_remaining(void)
-{
-    return 0;
-}
-
-static inline uint64_t blk_mig_bytes_total(void)
-{
-    return 0;
-}
-#endif /* CONFIG_LIVE_BLOCK_MIGRATION */
-
-void migrate_set_block_enabled(bool value, Error **errp);
-#endif /* MIGRATION_BLOCK_H */
diff --git a/migration/colo.c b/migration/colo.c
index 5600a43d78..e2b450c132 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -18,7 +18,6 @@
 #include "qemu-file.h"
 #include "savevm.h"
 #include "migration/colo.h"
-#include "block.h"
 #include "io/channel-buffer.h"
 #include "trace.h"
 #include "qemu/error-report.h"
diff --git a/migration/meson.build b/migration/meson.build
index f76b1ba328..d7e118f584 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -39,9 +39,6 @@ else
 endif
 
 system_ss.add(when: rdma, if_true: files('rdma.c'))
-if get_option('live_block_migration').allowed()
-  system_ss.add(files('block.c'))
-endif
 system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 5ab204d91d..8040f1a46f 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -145,15 +145,6 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
         }
     }
 
-    if (info->disk) {
-        monitor_printf(mon, "transferred disk: %" PRIu64 " kbytes\n",
-                       info->disk->transferred >> 10);
-        monitor_printf(mon, "remaining disk: %" PRIu64 " kbytes\n",
-                       info->disk->remaining >> 10);
-        monitor_printf(mon, "total disk: %" PRIu64 " kbytes\n",
-                       info->disk->total >> 10);
-    }
-
     if (info->xbzrle_cache) {
         monitor_printf(mon, "cache size: %" PRIu64 " bytes\n",
                        info->xbzrle_cache->cache_size);
@@ -726,24 +717,8 @@ static void hmp_migrate_status_cb(void *opaque)
     info = qmp_query_migrate(NULL);
     if (!info->has_status || info->status == MIGRATION_STATUS_ACTIVE ||
         info->status == MIGRATION_STATUS_SETUP) {
-        if (info->disk) {
-            int progress;
-
-            if (info->disk->remaining) {
-                progress = info->disk->transferred * 100 / info->disk->total;
-            } else {
-                progress = 100;
-            }
-
-            monitor_printf(status->mon, "Completed %d %%\r", progress);
-            monitor_flush(status->mon);
-        }
-
         timer_mod(status->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 1000);
     } else {
-        if (migrate_block()) {
-            monitor_printf(status->mon, "\n");
-        }
         if (info->error_desc) {
             error_report("%s", info->error_desc);
         }
diff --git a/migration/migration.c b/migration/migration.c
index 33e6504752..26017c9a2c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -46,7 +46,6 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qnull.h"
 #include "qemu/rcu.h"
-#include "block.h"
 #include "postcopy-ram.h"
 #include "qemu/thread.h"
 #include "trace.h"
@@ -236,7 +235,6 @@ void migration_object_init(void)
 
     migration_object_check(current_migration, &error_fatal);
 
-    blk_mig_init();
     ram_mig_init();
     dirty_bitmap_mig_init();
 }
@@ -1199,16 +1197,6 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     }
 }
 
-static void populate_disk_info(MigrationInfo *info)
-{
-    if (blk_mig_active()) {
-        info->disk = g_malloc0(sizeof(*info->disk));
-        info->disk->transferred = blk_mig_bytes_transferred();
-        info->disk->remaining = blk_mig_bytes_remaining();
-        info->disk->total = blk_mig_bytes_total();
-    }
-}
-
 static void fill_source_migration_info(MigrationInfo *info)
 {
     MigrationState *s = migrate_get_current();
@@ -1251,7 +1239,6 @@ static void fill_source_migration_info(MigrationInfo *info)
         /* TODO add some postcopy stats */
         populate_time_info(info, s);
         populate_ram_info(info, s);
-        populate_disk_info(info);
         migration_populate_vfio_info(info);
         break;
     case MIGRATION_STATUS_COLO:
@@ -1407,7 +1394,6 @@ static void migrate_fd_cleanup(MigrationState *s)
     type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
                                      MIG_EVENT_PRECOPY_DONE;
     migration_call_notifiers(s, type, NULL);
-    block_cleanup_parameters();
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
@@ -1997,8 +1983,6 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
         }
     }
 
-    s->must_remove_block_options = true;
-
     if (migrate_init(s, errp)) {
         return false;
     }
@@ -2080,7 +2064,6 @@ void qmp_migrate(const char *uri, bool has_channels,
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
-        block_cleanup_parameters();
     }
 
     if (local_err) {
diff --git a/migration/options.c b/migration/options.c
index be5bc03853..cc2599ae4a 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -195,7 +195,6 @@ Property migration_properties[] = {
                         MIGRATION_CAPABILITY_POSTCOPY_PREEMPT),
     DEFINE_PROP_MIG_CAP("x-colo", MIGRATION_CAPABILITY_X_COLO),
     DEFINE_PROP_MIG_CAP("x-release-ram", MIGRATION_CAPABILITY_RELEASE_RAM),
-    DEFINE_PROP_MIG_CAP("x-block", MIGRATION_CAPABILITY_BLOCK),
     DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PATH),
     DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_MULTIFD),
     DEFINE_PROP_MIG_CAP("x-background-snapshot",
@@ -225,13 +224,6 @@ bool migrate_background_snapshot(void)
     return s->capabilities[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT];
 }
 
-bool migrate_block(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->capabilities[MIGRATION_CAPABILITY_BLOCK];
-}
-
 bool migrate_colo(void)
 {
     MigrationState *s = migrate_get_current();
@@ -484,18 +476,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     ERRP_GUARD();
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-#ifndef CONFIG_LIVE_BLOCK_MIGRATION
-    if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
-        error_setg(errp, "QEMU compiled without old-style block migration");
-        error_append_hint(errp, "Use blockdev-mirror with NBD instead.\n");
-        return false;
-    }
-#endif
-    if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
-        warn_report("block migration is deprecated;"
-                    " use blockdev-mirror with NBD instead");
-    }
-
     if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
         warn_report("old compression method is deprecated;"
                     " use multifd compression methods instead");
@@ -706,11 +686,6 @@ MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
     int i;
 
     for (i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-#ifndef CONFIG_LIVE_BLOCK_MIGRATION
-        if (i == MIGRATION_CAPABILITY_BLOCK) {
-            continue;
-        }
-#endif
         caps = g_malloc0(sizeof(*caps));
         caps->capability = i;
         caps->state = s->capabilities[i];
@@ -942,17 +917,6 @@ ZeroPageDetection migrate_zero_page_detection(void)
 
 /* parameters helpers */
 
-void block_cleanup_parameters(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    if (s->must_remove_block_options) {
-        /* setting to false can never fail */
-        migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, false, &error_abort);
-        s->must_remove_block_options = false;
-    }
-}
-
 AnnounceParameters *migrate_announce_params(void)
 {
     static AnnounceParameters ap;
diff --git a/migration/ram.c b/migration/ram.c
index a975c5af16..5debb2e455 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -53,7 +53,6 @@
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
-#include "block.h"
 #include "sysemu/cpu-throttle.h"
 #include "savevm.h"
 #include "qemu/iov.h"
@@ -1025,13 +1024,6 @@ static void migration_trigger_throttle(RAMState *rs)
     uint64_t bytes_dirty_period = rs->num_dirty_pages_period * TARGET_PAGE_SIZE;
     uint64_t bytes_dirty_threshold = bytes_xfer_period * threshold / 100;
 
-    /* During block migration the auto-converge logic incorrectly detects
-     * that ram migration makes no progress. Avoid this by disabling the
-     * throttling logic during the bulk phase of block migration. */
-    if (blk_mig_bulk_active()) {
-        return;
-    }
-
     /*
      * The following detection logic can be refined later. For now:
      * Check to see if the ratio between dirtied bytes and the approx.
@@ -3230,13 +3222,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     int64_t t0;
     int done = 0;
 
-    if (blk_mig_bulk_active()) {
-        /* Avoid transferring ram during bulk phase of block migration as
-         * the bulk phase will usually take a long time and transferring
-         * ram updates during that time is pointless. */
-        goto out;
-    }
-
     /*
      * We'll take this lock a little bit long, but it's okay for two reasons.
      * Firstly, the only possible other thread to take it is who calls
diff --git a/migration/savevm.c b/migration/savevm.c
index 4509482ec4..6c789bd54b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1711,11 +1711,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
         return -EINVAL;
     }
 
-    if (migrate_block()) {
-        error_setg(errp, "Block migration and snapshots are incompatible");
-        return -EINVAL;
-    }
-
     ret = migrate_init(ms, errp);
     if (ret) {
         return ret;
diff --git a/qapi/migration.json b/qapi/migration.json
index 1523ad0e12..10e13d0b17 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -193,9 +193,6 @@
 # @ram: @MigrationStats containing detailed migration status, only
 #     returned if status is 'active' or 'completed'(since 1.2)
 #
-# @disk: @MigrationStats containing detailed disk migration status,
-#     only returned if status is 'active' and it is a block migration
-#
 # @xbzrle-cache: @XBZRLECacheStats containing detailed XBZRLE
 #     migration statistics, only returned if XBZRLE feature is on and
 #     status is 'active' or 'completed' (since 1.2)
@@ -262,17 +259,15 @@
 #
 # Features:
 #
-# @deprecated: Member @disk is deprecated because block migration is.
-#     Member @compression is deprecated because it is unreliable and
-#     untested.  It is recommended to use multifd migration, which
-#     offers an alternative compression implementation that is
-#     reliable and tested.
+# @deprecated: Member @compression is deprecated because it is
+#     unreliable and untested.  It is recommended to use multifd
+#     migration, which offers an alternative compression
+#     implementation that is reliable and tested.
 #
 # Since: 0.14
 ##
 { 'struct': 'MigrationInfo',
   'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
-           '*disk': { 'type': 'MigrationStats', 'features': [ 'deprecated' ] },
            '*vfio': 'VfioStats',
            '*xbzrle-cache': 'XBZRLECacheStats',
            '*total-time': 'int',
@@ -294,8 +289,7 @@
 #
 # Returns information about current migration process.  If migration
 # is active there will be another json-object with RAM migration
-# status and if block migration is active another one with block
-# migration status.
+# status.
 #
 # Returns: @MigrationInfo
 #
@@ -333,7 +327,7 @@
 #     -> { "execute": "query-migrate" }
 #     <- { "return": { "status": "failed" } }
 #
-#     4. Migration is being performed and is not a block migration:
+#     4. Migration is being performed:
 #
 #     -> { "execute": "query-migrate" }
 #     <- {
@@ -354,33 +348,7 @@
 #           }
 #        }
 #
-#     5. Migration is being performed and is a block migration:
-#
-#     -> { "execute": "query-migrate" }
-#     <- {
-#           "return":{
-#              "status":"active",
-#              "total-time":12345,
-#              "setup-time":12345,
-#              "expected-downtime":12345,
-#              "ram":{
-#                 "total":1057024,
-#                 "remaining":1053304,
-#                 "transferred":3720,
-#                 "duplicate":123,
-#                 "normal":123,
-#                 "normal-bytes":123456,
-#                 "dirty-sync-count":15
-#              },
-#              "disk":{
-#                 "total":20971520,
-#                 "remaining":20880384,
-#                 "transferred":91136
-#              }
-#           }
-#        }
-#
-#     6. Migration is being performed and XBZRLE is active:
+#     5. Migration is being performed and XBZRLE is active:
 #
 #     -> { "execute": "query-migrate" }
 #     <- {
@@ -460,11 +428,6 @@
 # @release-ram: if enabled, qemu will free the migrated ram pages on
 #     the source during postcopy-ram migration.  (since 2.9)
 #
-# @block: If enabled, QEMU will also migrate the contents of all block
-#     devices.  Default is disabled.  A possible alternative uses
-#     mirror jobs to a builtin NBD server on the destination, which
-#     offers more flexibility.  (Since 2.10)
-#
 # @return-path: If enabled, migration will use the return path even
 #     for precopy.  (since 2.10)
 #
@@ -528,11 +491,10 @@
 #
 # Features:
 #
-# @deprecated: Member @block is deprecated.  Use blockdev-mirror with
-#     NBD instead.  Member @compress is deprecated because it is
-#     unreliable and untested.  It is recommended to use multifd
-#     migration, which offers an alternative compression
-#     implementation that is reliable and tested.
+# @deprecated: Member @compress is deprecated because it is unreliable
+#     and untested.  It is recommended to use multifd migration, which
+#     offers an alternative compression implementation that is
+#     reliable and tested.
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
 #
@@ -544,7 +506,6 @@
            'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
-           { 'name': 'block', 'features': [ 'deprecated' ] },
            'return-path', 'pause-before-switchover', 'multifd',
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 0a29d35fdb..6ce5a8b72a 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -143,8 +143,6 @@ meson_options_help() {
   printf "%s\n" '  libvduse        build VDUSE Library'
   printf "%s\n" '  linux-aio       Linux AIO support'
   printf "%s\n" '  linux-io-uring  Linux io_uring support'
-  printf "%s\n" '  live-block-migration'
-  printf "%s\n" '                  block migration in the main migration stream'
   printf "%s\n" '  lzfse           lzfse support for DMG images'
   printf "%s\n" '  lzo             lzo compression support'
   printf "%s\n" '  malloc-trim     enable libc malloc_trim() for memory optimization'
@@ -382,8 +380,6 @@ _meson_option_parse() {
     --disable-linux-aio) printf "%s" -Dlinux_aio=disabled ;;
     --enable-linux-io-uring) printf "%s" -Dlinux_io_uring=enabled ;;
     --disable-linux-io-uring) printf "%s" -Dlinux_io_uring=disabled ;;
-    --enable-live-block-migration) printf "%s" -Dlive_block_migration=enabled ;;
-    --disable-live-block-migration) printf "%s" -Dlive_block_migration=disabled ;;
     --localedir=*) quote_sh "-Dlocaledir=$2" ;;
     --localstatedir=*) quote_sh "-Dlocalstatedir=$2" ;;
     --enable-lzfse) printf "%s" -Dlzfse=enabled ;;
-- 
2.35.3


