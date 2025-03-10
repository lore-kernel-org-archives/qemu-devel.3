Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B95C35FF1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 22:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trliB-0003sq-Kb; Mon, 10 Mar 2025 18:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1trli9-0003sf-F4
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 18:35:01 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1trli7-0001iR-Iq
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 18:35:01 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3995B1F387;
 Mon, 10 Mar 2025 22:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741646088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v4uFGsx80hZqWFWzwJZpTRsesyR37SbMYmMlBn4jo7k=;
 b=1k3Mq1FyUyj3nwUcy0iwyOgdOt2guPclRUARkXYKepujaexaXIjjWOwaTMNwU5MFxvqrT0
 LU9eg9dVp+KwncWZVbYZHL0PgLHm41/QcSCYlTKsDj3wxJSaJzTqNAedOe+ZoftbMaNpkc
 WYx/yFwnCybB7kEagrAlj5pmm/g7VO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741646088;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v4uFGsx80hZqWFWzwJZpTRsesyR37SbMYmMlBn4jo7k=;
 b=RZvWQMm5OKVKr3g9DvprYWNOa4Aa0F+Y1E1O8/cy27NeFlczye9KCYF8JqvM0/k5iMnCIY
 oG2o+SjlcZ7YHYDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1k3Mq1Fy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RZvWQMm5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741646088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v4uFGsx80hZqWFWzwJZpTRsesyR37SbMYmMlBn4jo7k=;
 b=1k3Mq1FyUyj3nwUcy0iwyOgdOt2guPclRUARkXYKepujaexaXIjjWOwaTMNwU5MFxvqrT0
 LU9eg9dVp+KwncWZVbYZHL0PgLHm41/QcSCYlTKsDj3wxJSaJzTqNAedOe+ZoftbMaNpkc
 WYx/yFwnCybB7kEagrAlj5pmm/g7VO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741646088;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v4uFGsx80hZqWFWzwJZpTRsesyR37SbMYmMlBn4jo7k=;
 b=RZvWQMm5OKVKr3g9DvprYWNOa4Aa0F+Y1E1O8/cy27NeFlczye9KCYF8JqvM0/k5iMnCIY
 oG2o+SjlcZ7YHYDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B2AD1399F;
 Mon, 10 Mar 2025 22:34:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UNQLFgZpz2dzRAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 10 Mar 2025 22:34:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL v2 2/3] migration: ram block cpr blockers
Date: Mon, 10 Mar 2025 19:34:39 -0300
Message-Id: <20250310223440.31328-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250310223440.31328-1-farosas@suse.de>
References: <20250310223440.31328-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3995B1F387
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,oracle.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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
index a6af555f4b..e97de3ef65 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -71,7 +71,10 @@
 
 #include "qemu/pmem.h"
 
+#include "qapi/qapi-types-migration.h"
+#include "migration/blocker.h"
 #include "migration/cpr.h"
+#include "migration/options.h"
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
@@ -1904,6 +1907,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
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
@@ -4095,3 +4106,58 @@ bool ram_block_discard_is_required(void)
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


