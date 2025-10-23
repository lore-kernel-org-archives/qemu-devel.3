Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E21ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC0X7-0006YN-KH; Thu, 23 Oct 2025 14:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0X5-0006Xm-KH
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0X3-0003Dp-Qv
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761245969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ddoI5PUvCOx89l9nf1b26NK5AXWAmqNwKGvoCyq2LJc=;
 b=FGCw81jqYIUx6ShsX/n/Ldxmt3HY/+/gVdQiW4ETPQ/lZyqKSeN7AJAHibRKBm/6ruq/iV
 37EdUWQDRJO/sO7LkRolKroYY4VTIhsD7nsWJdzhjaFq0jyWnXu3fIg5hgUCC9Fys9/uRh
 0Ba0apKctK8vr+pQv12OIMg1lmPXLlA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-ya9LWEylOYSK5wDDXpmEag-1; Thu, 23 Oct 2025 14:59:27 -0400
X-MC-Unique: ya9LWEylOYSK5wDDXpmEag-1
X-Mimecast-MFC-AGG-ID: ya9LWEylOYSK5wDDXpmEag_1761245967
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-891504015e5so345979985a.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761245967; x=1761850767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ddoI5PUvCOx89l9nf1b26NK5AXWAmqNwKGvoCyq2LJc=;
 b=VT8xZ/hg0a9dhN5A7kc9ctmpU+087SNk4BRSz8LyysbxtUUa6Z2dczfEsWAs12MIkO
 0j+P5tMT1qYgZfKsEFy0eKvBBEtGbBrFcVoBfdVShw4qz0nIAeDjYpGAjU7XvOdaUcha
 1YHhId8mnAsPovKhEid5K6EYqoy7b3McyBLLUiERr4oMLrPRooAn4KrgbQV2qtOM1JSz
 SvzPRi6ZLMAJNofgdZXccJEKrK538CM4NvVmSK6V21yC0IOxPP/geUTKqIV3aGs5eKjj
 ISTiAl8iZSRoxKESwjdICsBR9SF+vWIz3voXle67U1KZlc+AG89x8h0qymLFEhorkF9a
 mOiA==
X-Gm-Message-State: AOJu0Yz50CHxTwi6jjnouCpMyAbQssQ9mZga4mhAQFJkwe7CrZe0oyka
 /DmFbhgzTyR5S846Vp3Eo7kAnKSokJUnz1fD8nwEd9Z6WRYXZ844etY+br+i+EXdIjXv2iYpVAh
 SU38UIlDC8aRe4Pe/duZoPM0OfzYoSLeoB3L5FmC/HYT7tgIYY0nN0degQ9kk3If9JAPJtxQuGa
 07n1P6zRflRgshY5dJwDW/vVF/GY6pWuofxJYSoQ==
X-Gm-Gg: ASbGnctfijTJc8In6FxstjrJ/t2BiJxotpCpEz6kqnM1C+LXqfJokuFMjWIDalErw9A
 0hsgbHFfRv5bMAeRLkCZmQz3gpVJH4WSF1NWK4U5RQo2C9lM4v1XUPEVXhPq61Mmu5O8160VWkU
 DsxcIakWPV8PG8Mh3fl24FEcBwwbZ3JMvD8OCv9xjaeGx3Npg3APmfSB4fetabjQ5JLpKIQPaeO
 doJQKQSY3zygwSxUJFc5Vdj9C5Bmrr6VffqXp43qVq88TCmaWrWibKwp7WGNkXqA9Z7x4LGVuCG
 Ix7Dn2nCJtlfnD3s0j193xKv5Q6bGZwAkTeMKzZf53q1/w68/HnHCVVWM6Q1HGHd
X-Received: by 2002:a05:620a:2683:b0:891:a32a:c4d1 with SMTP id
 af79cd13be357-891a32ac4e4mr2818461385a.75.1761245966569; 
 Thu, 23 Oct 2025 11:59:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaJb2Es24fbMyfm6wO2b3LNNq1JtBztxno9536w3X4l+OAZWTECeYI5vHnG9yL7Q0rEOJDaA==
X-Received: by 2002:a05:620a:2683:b0:891:a32a:c4d1 with SMTP id
 af79cd13be357-891a32ac4e4mr2818456085a.75.1761245965660; 
 Thu, 23 Oct 2025 11:59:25 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c0ec61770sm213940585a.26.2025.10.23.11.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 11:59:24 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 6/8] ramblock: Rename guest_memfd to guest_memfd_private
Date: Thu, 23 Oct 2025 14:59:11 -0400
Message-ID: <20251023185913.2923322-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251023185913.2923322-1-peterx@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Rename the field to reflect the fact that the guest_memfd in this case only
backs private portion of the ramblock rather than all of it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h   |  2 +-
 include/system/ramblock.h |  7 ++++++-
 accel/kvm/kvm-all.c       |  2 +-
 system/memory.c           |  2 +-
 system/physmem.c          | 21 +++++++++++----------
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 4428701a9f..5c38018f4a 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1826,7 +1826,7 @@ bool memory_region_is_protected(MemoryRegion *mr);
  * memory_region_has_guest_memfd_private: check whether a memory region has
  *     guest_memfd associated
  *
- * Returns %true if a memory region's ram_block has valid guest_memfd assigned.
+ * Returns %true if a memory region's ram_block has guest_memfd_private assigned.
  *
  * @mr: the memory region being queried
  */
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 76694fe1b5..9ecf7f970c 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -40,7 +40,12 @@ struct RAMBlock {
     Error *cpr_blocker;
     int fd;
     uint64_t fd_offset;
-    int guest_memfd;
+    /*
+     * When RAM_GUEST_MEMFD_PRIVATE flag is set, this ramblock can have
+     * private pages backed by guest_memfd_private specified, while shared
+     * pages are backed by the ramblock on its own.
+     */
+    int guest_memfd_private;
     RamBlockAttributes *attributes;
     size_t page_size;
     /* dirty bitmap used during migration */
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 6521648ce9..687f33a2bb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1598,7 +1598,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->ram_start_offset = ram_start_offset;
         mem->ram = ram;
         mem->flags = kvm_mem_flags(mr);
-        mem->guest_memfd = mr->ram_block->guest_memfd;
+        mem->guest_memfd = mr->ram_block->guest_memfd_private;
         mem->guest_memfd_offset = mem->guest_memfd >= 0 ?
                                   (uint8_t*)ram - mr->ram_block->host : 0;
 
diff --git a/system/memory.c b/system/memory.c
index 5f05e5d73e..dadcc21d0e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1899,7 +1899,7 @@ bool memory_region_is_protected(MemoryRegion *mr)
 
 bool memory_region_has_guest_memfd_private(MemoryRegion *mr)
 {
-    return mr->ram_block && mr->ram_block->guest_memfd >= 0;
+    return mr->ram_block && mr->ram_block->guest_memfd_private >= 0;
 }
 
 uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
diff --git a/system/physmem.c b/system/physmem.c
index 1a186739a8..66fa4c7b6a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2211,7 +2211,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                        object_get_typename(OBJECT(current_machine->cgs)));
             goto out_free;
         }
-        assert(new_block->guest_memfd < 0);
+        assert(new_block->guest_memfd_private < 0);
 
         ret = ram_block_coordinated_discard_require(true);
         if (ret < 0) {
@@ -2221,9 +2221,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
-                                                        0, errp);
-        if (new_block->guest_memfd < 0) {
+        new_block->guest_memfd_private =
+            kvm_create_guest_memfd(new_block->max_length, 0, errp);
+        if (new_block->guest_memfd_private < 0) {
             qemu_mutex_unlock_ramlist();
             goto out_free;
         }
@@ -2240,7 +2240,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         new_block->attributes = ram_block_attributes_create(new_block);
         if (!new_block->attributes) {
             error_setg(errp, "Failed to create ram block attribute");
-            close(new_block->guest_memfd);
+            close(new_block->guest_memfd_private);
             ram_block_coordinated_discard_require(false);
             qemu_mutex_unlock_ramlist();
             goto out_free;
@@ -2377,7 +2377,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     new_block->max_length = max_size;
     new_block->resized = resized;
     new_block->flags = ram_flags;
-    new_block->guest_memfd = -1;
+    new_block->guest_memfd_private = -1;
     new_block->host = file_ram_alloc(new_block, max_size, fd,
                                      file_size < offset + max_size,
                                      offset, errp);
@@ -2550,7 +2550,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->used_length = size;
     new_block->max_length = max_size;
     new_block->fd = -1;
-    new_block->guest_memfd = -1;
+    new_block->guest_memfd_private = -1;
     new_block->page_size = qemu_real_host_page_size();
     new_block->host = host;
     new_block->flags = ram_flags;
@@ -2601,9 +2601,9 @@ static void reclaim_ramblock(RAMBlock *block)
         qemu_anon_ram_free(block->host, block->max_length);
     }
 
-    if (block->guest_memfd >= 0) {
+    if (block->guest_memfd_private >= 0) {
         ram_block_attributes_destroy(block->attributes);
-        close(block->guest_memfd);
+        close(block->guest_memfd_private);
         ram_block_coordinated_discard_require(false);
     }
 
@@ -4211,7 +4211,8 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     /* ignore fd_offset with guest_memfd */
-    ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+    ret = fallocate(rb->guest_memfd_private,
+                    FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                     offset, length);
 
     if (ret) {
-- 
2.50.1


