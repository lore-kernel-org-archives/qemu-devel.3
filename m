Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F95BC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAVf-0003GY-4w; Wed, 29 Jan 2025 11:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVI-0003EZ-Kf
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:24 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVG-0005Dy-5v
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:24 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 57D2B1F383;
 Wed, 29 Jan 2025 16:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiWS/v9aBvqhMwPeKHcbWpDGcX9OWIYP0ZFp+WqIcW8=;
 b=OTMj8gwR19x3p1L8t1iEtNLzkn/H3fMnGvo0/6ZQXQXtWMMAB3V2atMYMsBUDp0cZDPoa9
 Uv7YZLwwqNlYKxpQr0p+PpiPz5tPWkjHY15LGaqyNaIsvEXCKgy0QZq6wDdXscXW8Y7vWg
 +yaWqy6Eo1YcMEVx4HjUUNrgWl/11Zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiWS/v9aBvqhMwPeKHcbWpDGcX9OWIYP0ZFp+WqIcW8=;
 b=6PbpIMP+X6ZHbtYX10LhkgqiUPCmWoYZv/e7jpeHYWjBe5Phh+0srGRfM4La5hJy4k00jw
 KtM1ermJ6Iqv7mCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiWS/v9aBvqhMwPeKHcbWpDGcX9OWIYP0ZFp+WqIcW8=;
 b=OTMj8gwR19x3p1L8t1iEtNLzkn/H3fMnGvo0/6ZQXQXtWMMAB3V2atMYMsBUDp0cZDPoa9
 Uv7YZLwwqNlYKxpQr0p+PpiPz5tPWkjHY15LGaqyNaIsvEXCKgy0QZq6wDdXscXW8Y7vWg
 +yaWqy6Eo1YcMEVx4HjUUNrgWl/11Zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiWS/v9aBvqhMwPeKHcbWpDGcX9OWIYP0ZFp+WqIcW8=;
 b=6PbpIMP+X6ZHbtYX10LhkgqiUPCmWoYZv/e7jpeHYWjBe5Phh+0srGRfM4La5hJy4k00jw
 KtM1ermJ6Iqv7mCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 109A8137DB;
 Wed, 29 Jan 2025 16:01:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KHzaMM1QmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 05/42] physmem: fd-based shared memory
Date: Wed, 29 Jan 2025 13:00:22 -0300
Message-Id: <20250129160059.6987-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Create MAP_SHARED RAMBlocks by mmap'ing a file descriptor rather than using
MAP_ANON, so the memory can be accessed in another process by passing and
mmap'ing the fd.  This will allow CPR to support memory-backend-ram and
memory-backend-shm objects, provided the user creates them with share=on.

Use memfd_create if available because it has no constraints.  If not, use
POSIX shm_open.  However, allocation on the opened fd may fail if the shm
mount size is too small, even if the system has free memory, so for backwards
compatibility fall back to qemu_anon_ram_alloc/MAP_ANON on failure.

For backwards compatibility on Windows, always use MAP_ANON.  share=on has
no purpose there, but the syntax is accepted, and must continue to work.

Lastly, quietly fall back to MAP_ANON if the system does not support
qemu_ram_alloc_from_fd.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-5-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 system/physmem.c    | 57 ++++++++++++++++++++++++++++++++++++++++++++-
 system/trace-events |  1 +
 util/memfd.c        | 16 ++++++++++---
 3 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 4d13761329..e4355649e9 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -48,6 +48,7 @@
 #include "qemu/qemu-print.h"
 #include "qemu/log.h"
 #include "qemu/memalign.h"
+#include "qemu/memfd.h"
 #include "exec/memory.h"
 #include "exec/ioport.h"
 #include "system/dma.h"
@@ -1948,6 +1949,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
                                  bool grow,
                                  Error **errp)
 {
+    ERRP_GUARD();
     RAMBlock *new_block;
     Error *local_err = NULL;
     int64_t file_size, file_align;
@@ -2068,6 +2070,25 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
 }
 #endif
 
+#ifdef CONFIG_POSIX
+/*
+ * Create MAP_SHARED RAMBlocks by mmap'ing a file descriptor, so it can be
+ * shared with another process if CPR is being used.  Use memfd if available
+ * because it has no size limits, else use POSIX shm.
+ */
+static int qemu_ram_get_shared_fd(const char *name, Error **errp)
+{
+    int fd;
+
+    if (qemu_memfd_check(0)) {
+        fd = qemu_memfd_create(name, 0, 0, 0, 0, errp);
+    } else {
+        fd = qemu_shm_alloc(0, errp);
+    }
+    return fd;
+}
+#endif
+
 static
 RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                                   qemu_ram_resize_cb resized,
@@ -2081,6 +2102,41 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
                           RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
+    assert(max_size >= size);
+
+#ifdef CONFIG_POSIX         /* ignore RAM_SHARED for Windows */
+    if (!host) {
+        if (ram_flags & RAM_SHARED) {
+            const char *name = memory_region_name(mr);
+            int fd = qemu_ram_get_shared_fd(name, errp);
+
+            if (fd < 0) {
+                return NULL;
+            }
+
+            /* Use same alignment as qemu_anon_ram_alloc */
+            mr->align = QEMU_VMALLOC_ALIGN;
+
+            /*
+             * This can fail if the shm mount size is too small, or alloc from
+             * fd is not supported, but previous QEMU versions that called
+             * qemu_anon_ram_alloc for anonymous shared memory could have
+             * succeeded.  Quietly fail and fall back.
+             */
+            new_block = qemu_ram_alloc_from_fd(size, max_size, resized, mr,
+                                               ram_flags, fd, 0, false, NULL);
+            if (new_block) {
+                trace_qemu_ram_alloc_shared(name, new_block->used_length,
+                                            new_block->max_length, fd,
+                                            new_block->host);
+                return new_block;
+            }
+
+            close(fd);
+            /* fall back to anon allocation */
+        }
+    }
+#endif
 
     align = qemu_real_host_page_size();
     align = MAX(align, TARGET_PAGE_SIZE);
@@ -2092,7 +2148,6 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->resized = resized;
     new_block->used_length = size;
     new_block->max_length = max_size;
-    assert(max_size >= size);
     new_block->fd = -1;
     new_block->guest_memfd = -1;
     new_block->page_size = qemu_real_host_page_size();
diff --git a/system/trace-events b/system/trace-events
index 5bbc3fbffa..be12ebfb41 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -33,6 +33,7 @@ address_space_map(void *as, uint64_t addr, uint64_t len, bool is_write, uint32_t
 find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
 find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
 ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
+qemu_ram_alloc_shared(const char *name, size_t size, size_t max_size, int fd, void *host) "%s size %zu max_size %zu fd %d host %p"
 
 # cpus.c
 vm_stop_flush_all(int ret) "ret %d"
diff --git a/util/memfd.c b/util/memfd.c
index 8a2e906962..07beab174d 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -194,17 +194,27 @@ bool qemu_memfd_alloc_check(void)
 /**
  * qemu_memfd_check():
  *
- * Check if host supports memfd.
+ * Check if host supports memfd.  Cache the answer for the common case flags=0.
  */
 bool qemu_memfd_check(unsigned int flags)
 {
 #ifdef CONFIG_LINUX
-    int mfd = memfd_create("test", flags | MFD_CLOEXEC);
+    int mfd;
+    static int memfd_check = MEMFD_TODO;
 
+    if (!flags && memfd_check != MEMFD_TODO) {
+        return memfd_check;
+    }
+
+    mfd = memfd_create("test", flags | MFD_CLOEXEC);
     if (mfd >= 0) {
         close(mfd);
-        return true;
     }
+    if (!flags) {
+        memfd_check = (mfd >= 0) ? MEMFD_OK : MEMFD_KO;
+    }
+    return (mfd >= 0);
+
 #endif
 
     return false;
-- 
2.35.3


