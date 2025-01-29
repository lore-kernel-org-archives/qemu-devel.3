Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD3DC02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAVo-0003Is-3v; Wed, 29 Jan 2025 11:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVI-0003Ea-LQ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:24 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVG-0005Do-5E
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:24 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8EFED21108;
 Wed, 29 Jan 2025 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4K3cJYXvduQesKYhBn3uPc2PLLhekaZC/e7mZc37iA=;
 b=0E3LsHVkIq4h0t4OBl6VUFttvfoxNUIUsPeql1WiJGU6vHnuGMr977cxOS5OrZPhrfNsz0
 L7NklIJ85X7tbqHZCItS7iXQDtL3ONFjwDb4ZCUhwHghGasnOozNor9GyYW+j1YPptkElW
 t3pKUFgxBVH/f5W1PKQJt/eZInc9TOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4K3cJYXvduQesKYhBn3uPc2PLLhekaZC/e7mZc37iA=;
 b=QUo3zltEnbnU+IWSFcKa1foxn05qL7R9+uOWsCtRgZz9HGVPrtYJf/Khd2LWoFjz7G4cl1
 lK6CT76vZIqJB7Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0E3LsHVk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QUo3zltE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4K3cJYXvduQesKYhBn3uPc2PLLhekaZC/e7mZc37iA=;
 b=0E3LsHVkIq4h0t4OBl6VUFttvfoxNUIUsPeql1WiJGU6vHnuGMr977cxOS5OrZPhrfNsz0
 L7NklIJ85X7tbqHZCItS7iXQDtL3ONFjwDb4ZCUhwHghGasnOozNor9GyYW+j1YPptkElW
 t3pKUFgxBVH/f5W1PKQJt/eZInc9TOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4K3cJYXvduQesKYhBn3uPc2PLLhekaZC/e7mZc37iA=;
 b=QUo3zltEnbnU+IWSFcKa1foxn05qL7R9+uOWsCtRgZz9HGVPrtYJf/Khd2LWoFjz7G4cl1
 lK6CT76vZIqJB7Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48390137DB;
 Wed, 29 Jan 2025 16:01:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id APibAsxQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 04/42] physmem: qemu_ram_alloc_from_fd extensions
Date: Wed, 29 Jan 2025 13:00:21 -0300
Message-Id: <20250129160059.6987-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8EFED21108
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,oracle.com:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Extend qemu_ram_alloc_from_fd to support resizable ram, and define
qemu_ram_resize_cb to clean up the API.

Add a grow parameter to extend the file if necessary.  However, if
grow is false, a zero-sized file is always extended.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1736967650-129648-4-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/exec/ram_addr.h | 13 +++++++++----
 system/memory.c         |  4 ++--
 system/physmem.c        | 35 ++++++++++++++++++++---------------
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index ff157c1f42..94bb3ccbe4 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -111,23 +111,30 @@ long qemu_maxrampagesize(void);
  *
  * Parameters:
  *  @size: the size in bytes of the ram block
+ *  @max_size: the maximum size of the block after resizing
  *  @mr: the memory region where the ram block is
+ *  @resized: callback after calls to qemu_ram_resize
  *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
  *              RAM_READONLY_FD, RAM_GUEST_MEMFD
  *  @mem_path or @fd: specify the backing file or device
  *  @offset: Offset into target file
+ *  @grow: extend file if necessary (but an empty file is always extended).
  *  @errp: pointer to Error*, to store an error if it happens
  *
  * Return:
  *  On success, return a pointer to the ram block.
  *  On failure, return NULL.
  */
+typedef void (*qemu_ram_resize_cb)(const char *, uint64_t length, void *host);
+
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    uint32_t ram_flags, const char *mem_path,
                                    off_t offset, Error **errp);
-RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
+RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
+                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd, off_t offset,
+                                 bool grow,
                                  Error **errp);
 
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
@@ -135,9 +142,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags, MemoryRegion *mr,
                          Error **errp);
 RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
-                                    void (*resized)(const char*,
-                                                    uint64_t length,
-                                                    void *host),
+                                    qemu_ram_resize_cb resized,
                                     MemoryRegion *mr, Error **errp);
 void qemu_ram_free(RAMBlock *block);
 
diff --git a/system/memory.c b/system/memory.c
index b17b5538ff..4c829793a0 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1680,8 +1680,8 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
     mr->readonly = !!(ram_flags & RAM_READONLY);
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset,
-                                           &err);
+    mr->ram_block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
+                                           offset, false, &err);
     if (err) {
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
diff --git a/system/physmem.c b/system/physmem.c
index 792844d5a5..4d13761329 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1942,8 +1942,10 @@ out_free:
 }
 
 #ifdef CONFIG_POSIX
-RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
+RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
+                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd, off_t offset,
+                                 bool grow,
                                  Error **errp)
 {
     RAMBlock *new_block;
@@ -1953,7 +1955,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
-                          RAM_READONLY_FD | RAM_GUEST_MEMFD)) == 0);
+                          RAM_READONLY_FD | RAM_GUEST_MEMFD |
+                          RAM_RESIZEABLE)) == 0);
+    assert(max_size >= size);
 
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
@@ -1968,13 +1972,15 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 
     size = TARGET_PAGE_ALIGN(size);
     size = REAL_HOST_PAGE_ALIGN(size);
+    max_size = TARGET_PAGE_ALIGN(max_size);
+    max_size = REAL_HOST_PAGE_ALIGN(max_size);
 
     file_size = get_file_size(fd);
-    if (file_size && file_size < offset + size) {
+    if (file_size && file_size < offset + max_size && !grow) {
         error_setg(errp, "%s backing store size 0x%" PRIx64
                    " is too small for 'size' option 0x" RAM_ADDR_FMT
                    " plus 'offset' option 0x%" PRIx64,
-                   memory_region_name(mr), file_size, size,
+                   memory_region_name(mr), file_size, max_size,
                    (uint64_t)offset);
         return NULL;
     }
@@ -1990,11 +1996,13 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block = g_malloc0(sizeof(*new_block));
     new_block->mr = mr;
     new_block->used_length = size;
-    new_block->max_length = size;
+    new_block->max_length = max_size;
+    new_block->resized = resized;
     new_block->flags = ram_flags;
     new_block->guest_memfd = -1;
-    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
-                                     errp);
+    new_block->host = file_ram_alloc(new_block, max_size, fd,
+                                     file_size < offset + max_size,
+                                     offset, errp);
     if (!new_block->host) {
         g_free(new_block);
         return NULL;
@@ -2046,7 +2054,8 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset, errp);
+    block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, offset,
+                                   false, errp);
     if (!block) {
         if (created) {
             unlink(mem_path);
@@ -2061,9 +2070,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
 
 static
 RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
-                                  void (*resized)(const char*,
-                                                  uint64_t length,
-                                                  void *host),
+                                  qemu_ram_resize_cb resized,
                                   void *host, uint32_t ram_flags,
                                   MemoryRegion *mr, Error **errp)
 {
@@ -2115,10 +2122,8 @@ RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
 }
 
 RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t maxsz,
-                                     void (*resized)(const char*,
-                                                     uint64_t length,
-                                                     void *host),
-                                     MemoryRegion *mr, Error **errp)
+                                    qemu_ram_resize_cb resized,
+                                    MemoryRegion *mr, Error **errp)
 {
     return qemu_ram_alloc_internal(size, maxsz, resized, NULL,
                                    RAM_RESIZEABLE, mr, errp);
-- 
2.35.3


