Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDE4D5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVFYM-0006EG-A1; Mon, 15 Dec 2025 15:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYJ-0006Aj-Hf
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYH-0005kQ-Hu
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765831936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OyW0lUuue+oSxUUag6YkBCN6AuGW/vwp0tgBJvbr4UA=;
 b=ASRdnyZmg4yctXueMYvJUKpLJEqX87WYIumN1LKEVQ1HxEiocaMtjTJRU8cpZVURX+rC2e
 6+yFbA0XgaXh6QHk8VaeRgYwY+7tObAADOcpOv4r+D/vKtmg3U8X1PFXIoBwyuaXRDx2eq
 k+AizMcJk8Gi46A/7eAViZCs+Hu+X0A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-7ryC7a9fNaKKb2cniWTWQA-1; Mon, 15 Dec 2025 15:52:15 -0500
X-MC-Unique: 7ryC7a9fNaKKb2cniWTWQA-1
X-Mimecast-MFC-AGG-ID: 7ryC7a9fNaKKb2cniWTWQA_1765831935
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b51db8ebd9so1362345285a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765831934; x=1766436734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OyW0lUuue+oSxUUag6YkBCN6AuGW/vwp0tgBJvbr4UA=;
 b=CB4awTsa+XbX169e9Zhm2BLOHNzTt/BjrHaG6WsYisX2zT5ix5lStbR4DZMV9ZkQpn
 zHupMqvkXuttasmNm0de0VYjSEzA3R68cDf2H4pvsgwCAVJEZhGd/NGT57tfXt3z6A2S
 ERpdvFnpMZdMNf6pfX5QN1dy2kKH9qn0l5SnSfx0nW8+h2NS3WS9wDVL/0fPG/9dJUSU
 oLTYOUlzPYrhOwbYzo4dBOj3CzrjX2EXEVagh0Shz52IdDREzrdarS9EkVOm3dzacPof
 Cx7blenPveIl0W7rHq5Ww/V8JfofcuNOCHJzmMGtF88f0koQ/Nu1LVy4rlwYjjpEKsI2
 ++Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765831934; x=1766436734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OyW0lUuue+oSxUUag6YkBCN6AuGW/vwp0tgBJvbr4UA=;
 b=PE+n5ieMJs1NYPGYqJmRku3sDZlYtlFN4SzWRptJ5m89/sFxgGTOuqzJ01NvxqtIbZ
 yp1X3bvfK8qgwUKCALnrJKUMIKBEHKJrHHejqkaRn+tuULpq1Pc8eZNcNfUIxHTEZx72
 Ul2FcGZGBCgtEfICQAfOJfvdDKLQqDRaFoh75bLEzojNeYpwfygNAKpMqZX8o3Dj6Mmq
 FCMAfLPyr/bbtjGX95J7x+XQZDWwpFFPDVtkHAgqjFRQPjjuNSPB/6nRaxyGrVk5X62y
 /U4DrkjzlIC6K8VGwrmp3klexNc97mfPsdAfPgGKnHapcOsczFelU3PntVsxDqXDk/7r
 DHaw==
X-Gm-Message-State: AOJu0YzfsRPdcrJx7MtzpKHQRk9CAnlOkriXVxWvUdbchOvi24x/eMD2
 Yq9WiTHUR0sKDoIbJYz24JFAKzbJ01iC+LAh45U2Nv4xEI6pw/m1KP6rOa3LIJh9zb61EmiBFFc
 UgqC8zAPa69s7EJkZkJW6ITYTuynj7Kh8Dd+/VKeea5NeC1xmviHsyjf34rB0hZNtihSKJTgbaI
 Q/PcSEEtiV3oaJVnyDVEf7v/CpC1aT6J7HilhKlw==
X-Gm-Gg: AY/fxX71I5DDXwYwRdJbYkrISdU9+CvgQ1u8jqwYxD+/AhIbfBZuMOnL3OswSH4MJOJ
 R0hEHXG5lSnNBzP+88CHWjS0I5AdQkMQDPFI7OPM6bNDk+xhaGvUplBbd9bMZMxJInmldMh0OQk
 bNK+ayfay7f+ioM+OZjqL9sNUPA+g/idIMp7OecqbyOuOuSAK8d1RUCIcmTODGV2dNS9S0jA42N
 T/m2BE68CEkQp5/BnNgbDj7kGRfaTdaAizDVuyfHbXW4Qv+68UYi1bvkF8hEkzBzSYkH14f9hns
 ndp9kBKtQ8z4gTWxNzeuX4I+/EZLKmTbZ0WKYSlsLyzKSWFfXFFHRTLtbZGBT+FeG0Q7gR2vNds
 q
X-Received: by 2002:a05:620a:7105:b0:8b2:effe:b4d4 with SMTP id
 af79cd13be357-8bb3a38fab0mr1677233485a.78.1765831934273; 
 Mon, 15 Dec 2025 12:52:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdvWDdcpQ6hbL7d8lE245Plli67+G16QO0j/Z+l2xDYXRsoNvyIiYzZ6exHq/s6PjRoOEUMg==
X-Received: by 2002:a05:620a:7105:b0:8b2:effe:b4d4 with SMTP id
 af79cd13be357-8bb3a38fab0mr1677229085a.78.1765831933552; 
 Mon, 15 Dec 2025 12:52:13 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899ea3621bsm58726236d6.36.2025.12.15.12.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:52:12 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Alexey Kardashevskiy <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 05/12] memory: Rename RAM_GUEST_MEMFD to
 RAM_GUEST_MEMFD_PRIVATE
Date: Mon, 15 Dec 2025 15:51:56 -0500
Message-ID: <20251215205203.1185099-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215205203.1185099-1-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This name is too generic, and can conflict with in-place guest-memfd
support.  Add a _PRIVATE suffix to show what it really means: it is always
silently using an internal guest-memfd to back a shared host backend,
rather than used in-place.

This paves way for in-place guest-memfd, which means we can have a ramblock
that allocates pages completely from guest-memfd (private or shared).

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h   | 8 ++++----
 include/system/ram_addr.h | 2 +-
 backends/hostmem-file.c   | 2 +-
 backends/hostmem-memfd.c  | 2 +-
 backends/hostmem-ram.c    | 2 +-
 backends/hostmem-shm.c    | 2 +-
 system/memory.c           | 3 ++-
 system/physmem.c          | 8 ++++----
 8 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 2384575065..1f49f9a0ff 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -263,7 +263,7 @@ typedef struct IOMMUTLBEvent {
 #define RAM_READONLY_FD (1 << 11)
 
 /* RAM can be private that has kvm guest memfd backend */
-#define RAM_GUEST_MEMFD   (1 << 12)
+#define RAM_GUEST_MEMFD_PRIVATE   (1 << 12)
 
 /*
  * In RAMBlock creation functions, if MAP_SHARED is 0 in the flags parameter,
@@ -1401,7 +1401,7 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
  *        must be unique within any device
  * @size: size of the region.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_NORESERVE,
- *             RAM_GUEST_MEMFD.
+ *             RAM_GUEST_MEMFD_PRIVATE.
  * @errp: pointer to Error*, to store an error if it happens.
  *
  * Note that this function does not do anything to cause the data in the
@@ -1463,7 +1463,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
  *         (getpagesize()) will be used.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *             RAM_READONLY_FD, RAM_GUEST_MEMFD
+ *             RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
  * @path: the path in which to allocate the RAM.
  * @offset: offset within the file referenced by path
  * @errp: pointer to Error*, to store an error if it happens.
@@ -1493,7 +1493,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
  * @size: size of the region.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *             RAM_READONLY_FD, RAM_GUEST_MEMFD
+ *             RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
  * @fd: the fd to mmap.
  * @offset: offset within the file referenced by fd
  * @errp: pointer to Error*, to store an error if it happens.
diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 683485980c..930d3824d7 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -92,7 +92,7 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
  *  @resized: callback after calls to qemu_ram_resize
  *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *              RAM_READONLY_FD, RAM_GUEST_MEMFD
+ *              RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
  *  @mem_path or @fd: specify the backing file or device
  *  @offset: Offset into target file
  *  @grow: extend file if necessary (but an empty file is always extended).
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 8e3219c061..1f20cd8fd6 100644
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
index 923239f9cf..3f3e485709 100644
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
index 355b1fa26b..e8c6d484e6 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3755,7 +3755,8 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
     DeviceState *owner_dev;
 
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
-                                                RAM_GUEST_MEMFD, errp)) {
+                                                RAM_GUEST_MEMFD_PRIVATE,
+                                                errp)) {
         return false;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
diff --git a/system/physmem.c b/system/physmem.c
index c3c7a81310..d30fd690d1 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2203,7 +2203,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
     }
 
-    if (new_block->flags & RAM_GUEST_MEMFD) {
+    if (new_block->flags & RAM_GUEST_MEMFD_PRIVATE) {
         int ret;
 
         if (!kvm_enabled()) {
@@ -2341,7 +2341,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
-                          RAM_READONLY_FD | RAM_GUEST_MEMFD |
+                          RAM_READONLY_FD | RAM_GUEST_MEMFD_PRIVATE |
                           RAM_RESIZEABLE)) == 0);
     assert(max_size >= size);
 
@@ -2498,7 +2498,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     ram_flags &= ~RAM_PRIVATE;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
-                          RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
+                          RAM_NORESERVE | RAM_GUEST_MEMFD_PRIVATE)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
     assert(max_size >= size);
 
@@ -2581,7 +2581,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
                          MemoryRegion *mr, Error **errp)
 {
-    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD |
+    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD_PRIVATE |
                           RAM_PRIVATE)) == 0);
     return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
 }
-- 
2.50.1


