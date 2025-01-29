Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0CEC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAWC-0003z3-4i; Wed, 29 Jan 2025 11:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVO-0003Gg-DD
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:39 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVM-0005G5-6m
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:30 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6D6581F383;
 Wed, 29 Jan 2025 16:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQ7+qLA0aw7vdGQy4ycrp+wsZSMWzujHd/tCqcmiRkA=;
 b=Qs7fPHjyXI8loTJcsTmbVEG7lhd6dRHoZ2UDjzhDfob4Bjpv7Cx/svGJOvbpJAbSQHC4d0
 f6v1dkgCBpKj+RbYvqKi0CLyE1cxWOaVTWwJRl0FFxfw+w+MAVySP2xZ6EPxJBHX/TchxP
 8b1fwMql6reujm/uNvc3pPG6PgVRL5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQ7+qLA0aw7vdGQy4ycrp+wsZSMWzujHd/tCqcmiRkA=;
 b=7HAkjMB58+Ssrpv6IDL78pnzmY1NrRdlMFSOMPafU90dwLJpOFWPfaotw89mrxkAM9Ypdk
 VXeHYwNuLSgo2qAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Qs7fPHjy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7HAkjMB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQ7+qLA0aw7vdGQy4ycrp+wsZSMWzujHd/tCqcmiRkA=;
 b=Qs7fPHjyXI8loTJcsTmbVEG7lhd6dRHoZ2UDjzhDfob4Bjpv7Cx/svGJOvbpJAbSQHC4d0
 f6v1dkgCBpKj+RbYvqKi0CLyE1cxWOaVTWwJRl0FFxfw+w+MAVySP2xZ6EPxJBHX/TchxP
 8b1fwMql6reujm/uNvc3pPG6PgVRL5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQ7+qLA0aw7vdGQy4ycrp+wsZSMWzujHd/tCqcmiRkA=;
 b=7HAkjMB58+Ssrpv6IDL78pnzmY1NrRdlMFSOMPafU90dwLJpOFWPfaotw89mrxkAM9Ypdk
 VXeHYwNuLSgo2qAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2545E137DB;
 Wed, 29 Jan 2025 16:01:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QB7LNdRQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 09/42] physmem: preserve ram blocks for cpr
Date: Wed, 29 Jan 2025 13:00:26 -0300
Message-Id: <20250129160059.6987-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D6581F383
X-Spamd-Result: default: False [-2.86 / 50.00]; BAYES_HAM(-2.85)[99.36%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Save the memfd for ramblocks in CPR state, along with a name that
uniquely identifies it.  The block's idstr is not yet set, so it
cannot be used for this purpose.  Find the saved memfd in new QEMU when
creating a block.  If size of a resizable block is larger in new QEMU,
extend it via the file_ram_alloc truncate parameter, and the extra space
will be usable after a guest reset.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-9-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 system/physmem.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index cb80ce3091..67c9db9daa 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -70,6 +70,7 @@
 
 #include "qemu/pmem.h"
 
+#include "migration/cpr.h"
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
@@ -1661,6 +1662,18 @@ void qemu_ram_unset_idstr(RAMBlock *block)
     }
 }
 
+static char *cpr_name(MemoryRegion *mr)
+{
+    const char *mr_name = memory_region_name(mr);
+    g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
+
+    if (id) {
+        return g_strdup_printf("%s/%s", id, mr_name);
+    } else {
+        return g_strdup(mr_name);
+    }
+}
+
 size_t qemu_ram_pagesize(RAMBlock *rb)
 {
     return rb->page_size;
@@ -2080,15 +2093,25 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
  * shared with another process if CPR is being used.  Use memfd if available
  * because it has no size limits, else use POSIX shm.
  */
-static int qemu_ram_get_shared_fd(const char *name, Error **errp)
+static int qemu_ram_get_shared_fd(const char *name, bool *reused, Error **errp)
 {
-    int fd;
+    int fd = cpr_find_fd(name, 0);
+
+    if (fd >= 0) {
+        *reused = true;
+        return fd;
+    }
 
     if (qemu_memfd_check(0)) {
         fd = qemu_memfd_create(name, 0, 0, 0, 0, errp);
     } else {
         fd = qemu_shm_alloc(0, errp);
     }
+
+    if (fd >= 0) {
+        cpr_save_fd(name, 0, fd);
+    }
+    *reused = false;
     return fd;
 }
 #endif
@@ -2118,8 +2141,9 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
             ram_flags |= RAM_SHARED;
         }
         if (ram_flags & RAM_SHARED) {
-            const char *name = memory_region_name(mr);
-            int fd = qemu_ram_get_shared_fd(name, errp);
+            bool reused;
+            g_autofree char *name = cpr_name(mr);
+            int fd = qemu_ram_get_shared_fd(name, &reused, errp);
 
             if (fd < 0) {
                 return NULL;
@@ -2133,9 +2157,14 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
              * fd is not supported, but previous QEMU versions that called
              * qemu_anon_ram_alloc for anonymous shared memory could have
              * succeeded.  Quietly fail and fall back.
+             *
+             * After cpr-transfer, new QEMU could create a memory region
+             * with a larger max size than old, so pass reused to grow the
+             * region if necessary.  The extra space will be usable after a
+             * guest reset.
              */
             new_block = qemu_ram_alloc_from_fd(size, max_size, resized, mr,
-                                               ram_flags, fd, 0, false, NULL);
+                                               ram_flags, fd, 0, reused, NULL);
             if (new_block) {
                 trace_qemu_ram_alloc_shared(name, new_block->used_length,
                                             new_block->max_length, fd,
@@ -2143,6 +2172,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                 return new_block;
             }
 
+            cpr_delete_fd(name, 0);
             close(fd);
             /* fall back to anon allocation */
         }
@@ -2221,6 +2251,8 @@ static void reclaim_ramblock(RAMBlock *block)
 
 void qemu_ram_free(RAMBlock *block)
 {
+    g_autofree char *name = NULL;
+
     if (!block) {
         return;
     }
@@ -2231,6 +2263,8 @@ void qemu_ram_free(RAMBlock *block)
     }
 
     qemu_mutex_lock_ramlist();
+    name = cpr_name(block->mr);
+    cpr_delete_fd(name, 0);
     QLIST_REMOVE_RCU(block, next);
     ram_list.mru_block = NULL;
     /* Write list before version */
-- 
2.35.3


