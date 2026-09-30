Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFFBCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBw0U-0002Ur-8r; Wed, 30 Sep 2026 11:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0L-0002Ti-A7
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0J-0000hG-5J
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AN8FWwbJqRHvFRPAEkIAwjHl7xfg/WsFk2YJV98zyzY=;
 b=aEFztNIXZy4dm4ehG/jcVx9CFdRgPDOIFCfgX4VTv7hpCLpWYBClcoweoFui5aO9TiiXIE
 bOVPjw1zRumK6ccoF0fbHIWDA2CO+9KkdGKw1540eKq71pz40SPqdwc2j4TvMnR4cIgzRD
 V39+dlLcJgCTWiAM49X2+ZnKY1PWPMs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-QXgUaw_yMgG82TikIhe-UA-1; Wed, 30 Sep 2026 11:13:52 -0400
X-MC-Unique: QXgUaw_yMgG82TikIhe-UA-1
X-Mimecast-MFC-AGG-ID: QXgUaw_yMgG82TikIhe-UA_1790781231
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5332841f932so83265891cf.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790781231; x=1791386031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AN8FWwbJqRHvFRPAEkIAwjHl7xfg/WsFk2YJV98zyzY=;
 b=ZCfY/VP7qg6M1HXu1LA5aPb4df87bHfbKFuQvn2Y1aEiSurVzK4ul3gXJqAnC43bUf
 y0tbcIXI2m+M1+0Olefsphv3KQtBQF0aFKO4lj705WBZIEcxnyhOfsbjJs0Sr5zeMEY8
 IrfnUT8/b1KwIorNRFEtMm97ALLLx+gQbj0xApjs8Eah0i7f6AGM0TtgqXwEplmcRWj4
 /KRHRVsgw5wQDgeZqWVL9zzNnokJt7BC7PYHo5hHHGXVg6DzMUfptaOe770wsty1xfmF
 aQS3xwfBUqQ63+KwD6pCeoDy6ifyma+1RPDafAqObgb3y1U8qrVBaZyDLYpY4Ilzo/fs
 tzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781231; x=1791386031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AN8FWwbJqRHvFRPAEkIAwjHl7xfg/WsFk2YJV98zyzY=;
 b=l8eAJ8GBz/oxXnmI6pcGBYDmUl8KwP6AeMGEkssx1XNJOH3dYjfv6XaBydajM4piJQ
 YBPl3Vx/3JnGuTobaNXlNeLbLxDmb5y0HZzepV5h3hQTwKEktFbVIdQl/scn0bhCTk7F
 qSSsPTUn0/YqcsnFS4C2KNIRQh5NxrePzm940f0Ck7pDiteRR9wv2QjBwilTR+8HM7gy
 F73ogMU2zLcg1jutqGz1P280J8uJnveQiqhSG69wiqPEOoxPxxdEHvtl5oTbFxHwrkV6
 VkqIpVQMwDxdLJ6LugQkXgUZ3b2AvIW5ADAMPghUByeDihTZZz+hZEo3WijLx0E17/Mi
 hBbQ==
X-Gm-Message-State: AFuF++lDj7Q1+ek16T5nvtV1ecrPXYc05Gx7bY9RaJsyIQ5FuOk0S3RB
 C/K9fAnJCh5LoVF2T0fplxaDB0xVvQV0tRE+wAVfv9iEq8TeMB9z0yaYkhyhliWbWp+w0LUUDyr
 /grFTBjLa9mGnoqeC2U+6jA8xNGRMo9LjBonJ5iWEqxd56+iZNmVkQdNBippcSi3xDF/aHjZja7
 v0bqTIG5+lIvGiHDYuqFInM8M7bYeLhE6U/1qumpDT
X-Gm-Gg: AYBFou3CSZX7sOfIFJ37CpSzBiWCKFfXMJ0h7SydxHgBTc/yGwE6clxCswQ/eowyzTf
 J3sr+euCNncOqlJS8zTwYK0FOuPHirZENn4YQJI7qd6MIDO7xsoaLuGOFywU0u2vlgJ2XtmyI6y
 hOtjiGYL0E0GHw2hM/iXa7zVHNI97elrcYYo+sST10bdjJvrkn6c5TqGv6cPYUfhRif/IffXusM
 vH0WmsCeWRklxSwSrScmjQTvwgW6rH3Z6SnG8zy15Gi+O6Y5UBWdMMz5BLVXX7o8smru9n4Dlrb
 SJtV7vXdWtOBIu9eynM2o5hyzSDgJYBjxEiXN1ywnyxj8xqBaxNr9K6eF5rxgIHphv1Rk08=
X-Received: by 2002:ac8:598c:0:b0:530:b2e3:86c7 with SMTP id
 d75a77b69052e-53374db3985mr29646721cf.57.1790781231215; 
 Wed, 30 Sep 2026 08:13:51 -0700 (PDT)
X-Received: by 2002:ac8:598c:0:b0:530:b2e3:86c7 with SMTP id
 d75a77b69052e-53374db3985mr29645621cf.57.1790781230236; 
 Wed, 30 Sep 2026 08:13:50 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5338242f8d1sm1395211cf.9.2026.09.30.08.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:13:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PULL 05/12] memory: Rename RAM_GUEST_MEMFD to RAM_GUEST_MEMFD_PRIVATE
Date: Wed, 30 Sep 2026 11:13:33 -0400
Message-ID: <20260930151340.2817042-6-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930151340.2817042-1-peterx@redhat.com>
References: <20260930151340.2817042-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This name is too generic, and can conflict with support for using
guest-memfd for shared memory. Add a _PRIVATE suffix to show what it
really means: it is using guest_memfd specifically for private memory;
whether or not guest_memfd is being used for shared memory is something
to be configured/determined separately.

This also paves way for in-place guest-memfd, which means we can have a
ramblock that allocates pages completely from guest-memfd (private or
shared).

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Link: https://lore.kernel.org/r/20260929235109.1398509-6-michael.roth@amd.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h   |  8 ++++----
 include/system/ramblock.h |  2 +-
 backends/hostmem-file.c   |  2 +-
 backends/hostmem-memfd.c  |  2 +-
 backends/hostmem-ram.c    |  2 +-
 backends/hostmem-shm.c    |  2 +-
 system/memory.c           |  2 +-
 system/physmem.c          | 10 +++++-----
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index aef555af80..932072c631 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -262,7 +262,7 @@ typedef struct IOMMUTLBEvent {
 #define RAM_READONLY_FD (1 << 11)
 
 /* RAM can be private that has kvm guest memfd backend */
-#define RAM_GUEST_MEMFD   (1 << 12)
+#define RAM_GUEST_MEMFD_PRIVATE   (1 << 12)
 
 /*
  * In RAMBlock creation functions, if MAP_SHARED is 0 in the flags parameter,
@@ -1119,7 +1119,7 @@ void memory_region_init_io(MemoryRegion *mr,
  *        must be unique within any device
  * @size: size of the region.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_NORESERVE,
- *             RAM_GUEST_MEMFD.
+ *             RAM_GUEST_MEMFD_PRIVATE.
  * @errp: pointer to Error*, to store an error if it happens.
  *
  * Note that this function does not do anything to cause the data in the
@@ -1181,7 +1181,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
  *         (getpagesize()) will be used.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *             RAM_READONLY_FD, RAM_GUEST_MEMFD
+ *             RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
  * @path: the path in which to allocate the RAM.
  * @offset: offset within the file referenced by path
  * @errp: pointer to Error*, to store an error if it happens.
@@ -1212,7 +1212,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
  * @size: size of the region.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *             RAM_READONLY_FD, RAM_GUEST_MEMFD
+ *             RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
  * @fd: the fd to mmap.
  * @offset: offset within the file referenced by fd
  * @errp: pointer to Error*, to store an error if it happens.
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 0388d6cc6b..1352ec1603 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -257,7 +257,7 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
  *  @resized: callback after calls to qemu_ram_resize
  *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *              RAM_READONLY_FD, RAM_GUEST_MEMFD
+ *              RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
  *  @mem_path or @fd: specify the backing file or device
  *  @offset: Offset into target file
  *  @grow: extend file if necessary (but an empty file is always extended).
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 8cf27ad67e..bb7323d2bf 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -86,7 +86,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
     ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
     ram_flags |= RAM_NAMED_FILE;
     return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index e21c5a3f2e..d917a94d73 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -60,7 +60,7 @@ have_fd:
     backend->aligned = true;
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
                                           backend->size, ram_flags, fd, 0, errp);
 }
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 062b1abb11..96ad29112d 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -30,7 +30,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
     return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
                                                   name, backend->size,
                                                   ram_flags, errp);
diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index 806e2670e0..e86fb2e0aa 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -54,7 +54,7 @@ have_fd:
     /* Let's do the same as memory-backend-ram,share=on would do. */
     ram_flags = RAM_SHARED;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
 
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
                                               backend_name, backend->size,
diff --git a/system/memory.c b/system/memory.c
index b07d5dc542..96e42beb2e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3597,7 +3597,7 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
                                         Error **errp)
 {
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
-                                                RAM_GUEST_MEMFD, errp)) {
+                                                RAM_GUEST_MEMFD_PRIVATE, errp)) {
         return false;
     }
     memory_region_register_ram(mr, owner);
diff --git a/system/physmem.c b/system/physmem.c
index 156853c8db..db3dda563d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2184,7 +2184,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
     }
 
-    if (new_block->flags & RAM_GUEST_MEMFD) {
+    if (new_block->flags & RAM_GUEST_MEMFD_PRIVATE) {
         int ret;
 
         if (!kvm_enabled()) {
@@ -2322,7 +2322,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
-                          RAM_READONLY_FD | RAM_GUEST_MEMFD |
+                          RAM_READONLY_FD | RAM_GUEST_MEMFD_PRIVATE |
                           RAM_RESIZEABLE)) == 0);
     assert(max_size >= size);
 
@@ -2479,7 +2479,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     ram_flags &= ~RAM_PRIVATE;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
-                          RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
+                          RAM_NORESERVE | RAM_GUEST_MEMFD_PRIVATE)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
     assert(max_size >= size);
 
@@ -2562,7 +2562,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
                          MemoryRegion *mr, Error **errp)
 {
-    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD |
+    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD_PRIVATE |
                           RAM_PRIVATE)) == 0);
     return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
 }
@@ -2838,7 +2838,7 @@ int ram_block_rebind(Error **errp)
     qemu_mutex_lock_ramlist();
 
     RAMBLOCK_FOREACH(block) {
-        if (block->flags & RAM_GUEST_MEMFD) {
+        if (block->flags & RAM_GUEST_MEMFD_PRIVATE) {
             if (block->guest_memfd_private >= 0) {
                 close(block->guest_memfd_private);
             }
-- 
2.55.0


