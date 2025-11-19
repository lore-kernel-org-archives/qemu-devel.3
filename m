Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884ABCF397E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 17:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLm02-000391-E1; Wed, 19 Nov 2025 12:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzk-000318-1H
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzh-0004OT-Fx
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763573364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8wT+S8nNje4ograkIKse+eEBwmrSCJXCGJeynh6HAo=;
 b=Y0g4uSsZsHixbrfLNomhx0oOJ6efKgjXjjH03BRHD6QcwoCS2KNYWWRPY7z/4P3bUGXTU8
 wxfDACelZMtOz8wrgUx043ksq8bXjnqEfrwC+dmYu7KOPAV+0V3RJMbMdzAqY4w6GzdX86
 zgdVifowSM4lLLgeGrerVBbvqYObSx8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-g-NWF_NhO8KdgNQ3v584KA-1; Wed, 19 Nov 2025 12:29:23 -0500
X-MC-Unique: g-NWF_NhO8KdgNQ3v584KA-1
X-Mimecast-MFC-AGG-ID: g-NWF_NhO8KdgNQ3v584KA_1763573363
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2657cfcdaso878259885a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 09:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763573362; x=1764178162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8wT+S8nNje4ograkIKse+eEBwmrSCJXCGJeynh6HAo=;
 b=e7r6I0M56QlAWUFQt+OKXiL2xFXSUccHq3l5S2YGoWEq03CGbXcysqh+/qcjKPo2en
 YFWGoCUqTrfye5OMwSQYTRkDJa3PLGnABTzf/0JXqMqHDR+eM3PyWKWllbH8XLT5fBSo
 UYPkQUBjHEV/Tayd0EZ3aY8QXAYf4cpfu1ODXFt8xG6bSL1p6z+UuonDU6FMVQje8YsM
 KjRucDKLy0/qPcusU8+vph92IDFQU0yaPXDbK+wD+Ia9S983Qz3JKNVOK10K3E/gixgm
 8zhb1w96sYFq+fdL1ae5UGQ8vx+AGGr9gIkrUMkjSv+FSfvPKJdlO5Lc2lL8oFNpEp3A
 LsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573362; x=1764178162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j8wT+S8nNje4ograkIKse+eEBwmrSCJXCGJeynh6HAo=;
 b=rHpqIU+NEvJEmyV/d6ngtReAWwM7gi6PVDQMUntnlS+iEhQLzRWrJgEaDIjokxijTT
 9+htT3f/9VMT9rEImyGZLQQyz5OwCjeIAm/15jZ7D3sOS7W2FGdcyYWCPYXVDqqr+i/L
 xYKr8SgEPheGrEsahHd6yR6XF4wWdObQQdvl6A4OHZ+oG3czIabr7bPFitGATHj+W/c/
 0ReMqgky2rPstxzXUsWK2u6qCzki6KcDEPnX9ydu/3sTHszh2QG4K2JXkQ54cUdZjqzM
 +Ut3gObeHsuEg9/JHgSxMxIjG/edgMOshWKwUxBZhxpmGn/svXUl6q6DCy2DSmcqktgR
 iqYA==
X-Gm-Message-State: AOJu0YzKMNDEYVE8LM4fLqR1X6Ssu5swiXfBGZevy/KY9Lf2IjDPGZwT
 nF9AvuFc+DOfOKfwCFHGq9I5oHeT9mJv/S/zBaTxbARfsswgDq7Qe5olAkxF4qI8S4nTq7tcRPL
 k6kfmKgI2bqbLxMCHguqZdwXIcubOZdb4rZxrE0VZ7M8rVutOdMi+Gz8Co3O2WF0XWEZ7dEdm7c
 k43SM2lSH+P2fP7plfsex/4wYxSb891g60v+phQA==
X-Gm-Gg: ASbGncu2/GkQF0mZn8a182WYpz5Lt3R+nlk96qx2jetlNqNpaG9oSBB9TNA1CfIsB8A
 lKxA0aQXzg+OOqHa+7gyQKkcJgE9ONmo1suHE1syM8S9u3y6X6zkmCEewU/482mYLqKphA6rIQm
 O10IZfgu3w9cT4hwsJcyu4HhLRsXx4SAIaLqEFEoEaH4ys3iUuHl6IGEtFgVik8ixXrxewosfU8
 X0lChdwneQ5VATJmUXYU5HlXq3GfHQS66TJKbAsKgIP1tR5gQ237WN2kCIisEpDp5EViL8Fsx5R
 t9qt6gY7HkDjcREKsvYoGoMxQVDllPpaSGWT1Mw5qKxiAJQzSl7FKZHrx8g5n0TO6qFc0sHdfLU
 e
X-Received: by 2002:a05:620a:170f:b0:8b2:e633:67cc with SMTP id
 af79cd13be357-8b327310fb4mr22280185a.28.1763573362167; 
 Wed, 19 Nov 2025 09:29:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtKxdAkK8ZAjyhlSaewl9gbzAltKBy4mCMp6A3zsstnA1sdm0ucFABtX9ze9r+TstN4Hidww==
X-Received: by 2002:a05:620a:170f:b0:8b2:e633:67cc with SMTP id
 af79cd13be357-8b327310fb4mr22274785a.28.1763573361511; 
 Wed, 19 Nov 2025 09:29:21 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2af042c9csm1444759485a.46.2025.11.19.09.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 09:29:21 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, peterx@redhat.com,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 5/9] ramblock: Rename guest_memfd to guest_memfd_private
Date: Wed, 19 Nov 2025 12:29:09 -0500
Message-ID: <20251119172913.577392-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119172913.577392-1-peterx@redhat.com>
References: <20251119172913.577392-1-peterx@redhat.com>
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

Rename the field to reflect the fact that the guest_memfd in this case only
backs private portion of the ramblock rather than all of it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h   |  3 ++-
 include/system/ramblock.h |  7 ++++++-
 accel/kvm/kvm-all.c       |  2 +-
 system/memory.c           |  2 +-
 system/physmem.c          | 21 +++++++++++----------
 5 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 4428701a9f..0aca241360 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1826,7 +1826,8 @@ bool memory_region_is_protected(MemoryRegion *mr);
  * memory_region_has_guest_memfd_private: check whether a memory region has
  *     guest_memfd associated
  *
- * Returns %true if a memory region's ram_block has valid guest_memfd assigned.
+ * Returns %true if a memory region's ram_block has guest_memfd_private
+ * assigned.
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
index 320315f50c..5942e17f7e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1603,7 +1603,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->ram_start_offset = ram_start_offset;
         mem->ram = ram;
         mem->flags = kvm_mem_flags(mr);
-        mem->guest_memfd = mr->ram_block->guest_memfd;
+        mem->guest_memfd = mr->ram_block->guest_memfd_private;
         mem->guest_memfd_offset = mem->guest_memfd >= 0 ?
                                   (uint8_t*)ram - mr->ram_block->host : 0;
 
diff --git a/system/memory.c b/system/memory.c
index 15964160ee..d70968c966 100644
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
index 25c800c9d3..d30fd690d1 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2219,7 +2219,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        assert(new_block->guest_memfd < 0);
+        assert(new_block->guest_memfd_private < 0);
 
         ret = ram_block_coordinated_discard_require(true);
         if (ret < 0) {
@@ -2229,9 +2229,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
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
@@ -2248,7 +2248,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         new_block->attributes = ram_block_attributes_create(new_block);
         if (!new_block->attributes) {
             error_setg(errp, "Failed to create ram block attribute");
-            close(new_block->guest_memfd);
+            close(new_block->guest_memfd_private);
             ram_block_coordinated_discard_require(false);
             qemu_mutex_unlock_ramlist();
             goto out_free;
@@ -2385,7 +2385,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     new_block->max_length = max_size;
     new_block->resized = resized;
     new_block->flags = ram_flags;
-    new_block->guest_memfd = -1;
+    new_block->guest_memfd_private = -1;
     new_block->host = file_ram_alloc(new_block, max_size, fd,
                                      file_size < offset + max_size,
                                      offset, errp);
@@ -2558,7 +2558,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->used_length = size;
     new_block->max_length = max_size;
     new_block->fd = -1;
-    new_block->guest_memfd = -1;
+    new_block->guest_memfd_private = -1;
     new_block->page_size = qemu_real_host_page_size();
     new_block->host = host;
     new_block->flags = ram_flags;
@@ -2609,9 +2609,9 @@ static void reclaim_ramblock(RAMBlock *block)
         qemu_anon_ram_free(block->host, block->max_length);
     }
 
-    if (block->guest_memfd >= 0) {
+    if (block->guest_memfd_private >= 0) {
         ram_block_attributes_destroy(block->attributes);
-        close(block->guest_memfd);
+        close(block->guest_memfd_private);
         ram_block_coordinated_discard_require(false);
     }
 
@@ -4222,7 +4222,8 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     /* ignore fd_offset with guest_memfd */
-    ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+    ret = fallocate(rb->guest_memfd_private,
+                    FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                     offset, length);
 
     if (ret) {
-- 
2.50.1


