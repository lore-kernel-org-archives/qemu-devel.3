Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD92C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcF6-0000j9-3w; Fri, 07 Mar 2025 13:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqcF4-0000iw-NC
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:16:14 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqcF2-0004eQ-9X
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:16:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D7A9A21190;
 Fri,  7 Mar 2025 18:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741371360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1i7apSn15jQatTnXZMO4odm/liOMWciUMfs5vbKW9dY=;
 b=RuQ4stkppMwavXpTMBnvtB5+b0qZW80xdYeleRh1OqaH6TTonJTHPOCRy/EnruEZHNSnT/
 HQPoKYq9ZHMZnD94n1fFSibIG14KeX7HuiHb35lmmpolZaPCMYd32hETdrcOJedLelyVIM
 eJefTtzJEVy86SLXWzD/X2vr8Uu7WM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741371360;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1i7apSn15jQatTnXZMO4odm/liOMWciUMfs5vbKW9dY=;
 b=VLyRGyoS0zGkuyi8gMxSXpbUQ6VJv6UlNOZX0GtILB+1dJXhV9R/DCQTcv6l1ca7KnslGh
 qCsXKD+UpgqpiLCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ePiWN5bn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BiFB5SZG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741371359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1i7apSn15jQatTnXZMO4odm/liOMWciUMfs5vbKW9dY=;
 b=ePiWN5bnkK/Uguev+iO2d/FL9AWXx00iTSk8ydLhmSWKwoW1L3G73JRTM9oAkh/uYmi6qi
 DB270YjOaKjHhYBjs2kH0/EyVw6jXlwQ9xdkt8x6vV+mGOn0ZA5hcy+6OYg6PzLNA1yybq
 QxcanPUk6TgQ1i01b9t5sshhJOMyteM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741371359;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1i7apSn15jQatTnXZMO4odm/liOMWciUMfs5vbKW9dY=;
 b=BiFB5SZGuBt+aEjkbZVpx2q0tt3sh5WsdkB9Y2I/jQIT+Jxzy7tW8woQ0DYS47IW1HXVyH
 8yixcjQMT02uRPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 359E513A22;
 Fri,  7 Mar 2025 18:15:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qNMOOd03y2dNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Mar 2025 18:15:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 2/8] migration: ram block cpr blockers
Date: Fri,  7 Mar 2025 15:15:45 -0300
Message-Id: <20250307181551.19887-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250307181551.19887-1-farosas@suse.de>
References: <20250307181551.19887-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D7A9A21190
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Unlike cpr-reboot mode, cpr-transfer mode cannot save volatile ram blocks
in the migration stream file and recreate them later, because the physical
memory for the blocks is pinned and registered for vfio.  Add a blocker
for volatile ram blocks.

Also add a blocker for RAM_GUEST_MEMFD.  Preserving guest_memfd may be
sufficient for CPR, but it has not been tested yet.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <1740667681-257312-1-git-send-email-steven.sistare@oracle.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/exec/memory.h   |  3 ++
 include/exec/ramblock.h |  1 +
 migration/savevm.c      |  2 ++
 system/physmem.c        | 66 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 78c4e0aec8..d09af58c97 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3203,6 +3203,9 @@ bool ram_block_discard_is_disabled(void);
  */
 bool ram_block_discard_is_required(void);
 
+void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp);
+void ram_block_del_cpr_blocker(RAMBlock *rb);
+
 #endif
 
 #endif
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 0babd105c0..64484cd821 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -39,6 +39,7 @@ struct RAMBlock {
     /* RCU-enabled, writes protected by the ramlist lock */
     QLIST_ENTRY(RAMBlock) next;
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
+    Error *cpr_blocker;
     int fd;
     uint64_t fd_offset;
     int guest_memfd;
diff --git a/migration/savevm.c b/migration/savevm.c
index 5c4fdfd95e..ce158c3512 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3514,12 +3514,14 @@ void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
     qemu_ram_set_idstr(mr->ram_block,
                        memory_region_name(mr), dev);
     qemu_ram_set_migratable(mr->ram_block);
+    ram_block_add_cpr_blocker(mr->ram_block, &error_fatal);
 }
 
 void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
 {
     qemu_ram_unset_idstr(mr->ram_block);
     qemu_ram_unset_migratable(mr->ram_block);
+    ram_block_del_cpr_blocker(mr->ram_block);
 }
 
 void vmstate_register_ram_global(MemoryRegion *mr)
diff --git a/system/physmem.c b/system/physmem.c
index 8c1736f84e..445981a1b4 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -70,7 +70,10 @@
 
 #include "qemu/pmem.h"
 
+#include "qapi/qapi-types-migration.h"
+#include "migration/blocker.h"
 #include "migration/cpr.h"
+#include "migration/options.h"
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
@@ -1903,6 +1906,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             qemu_mutex_unlock_ramlist();
             goto out_free;
         }
+
+        error_setg(&new_block->cpr_blocker,
+                   "Memory region %s uses guest_memfd, "
+                   "which is not supported with CPR.",
+                   memory_region_name(new_block->mr));
+        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
+                                  MIG_MODE_CPR_TRANSFER,
+                                  -1);
     }
 
     ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
@@ -4094,3 +4105,58 @@ bool ram_block_discard_is_required(void)
     return qatomic_read(&ram_block_discard_required_cnt) ||
            qatomic_read(&ram_block_coordinated_discard_required_cnt);
 }
+
+/*
+ * Return true if ram is compatible with CPR.  Do not exclude rom,
+ * because the rom file could change in new QEMU.
+ */
+static bool ram_is_cpr_compatible(RAMBlock *rb)
+{
+    MemoryRegion *mr = rb->mr;
+
+    if (!mr || !memory_region_is_ram(mr)) {
+        return true;
+    }
+
+    /* Ram device is remapped in new QEMU */
+    if (memory_region_is_ram_device(mr)) {
+        return true;
+    }
+
+    /*
+     * A file descriptor is passed to new QEMU and remapped, or its backing
+     * file is reopened and mapped.  It must be shared to avoid COW.
+     */
+    if (rb->fd >= 0 && qemu_ram_is_shared(rb)) {
+        return true;
+    }
+
+    return false;
+}
+
+/*
+ * Add a blocker for each volatile ram block.  This function should only be
+ * called after we know that the block is migratable.  Non-migratable blocks
+ * are either re-created in new QEMU, or are handled specially, or are covered
+ * by a device-level CPR blocker.
+ */
+void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp)
+{
+    assert(qemu_ram_is_migratable(rb));
+
+    if (ram_is_cpr_compatible(rb)) {
+        return;
+    }
+
+    error_setg(&rb->cpr_blocker,
+               "Memory region %s is not compatible with CPR. share=on is "
+               "required for memory-backend objects, and aux-ram-share=on is "
+               "required.", memory_region_name(rb->mr));
+    migrate_add_blocker_modes(&rb->cpr_blocker, errp, MIG_MODE_CPR_TRANSFER,
+                              -1);
+}
+
+void ram_block_del_cpr_blocker(RAMBlock *rb)
+{
+    migrate_del_blocker(&rb->cpr_blocker);
+}
-- 
2.35.3


