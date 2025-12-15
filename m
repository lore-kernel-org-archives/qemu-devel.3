Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DFFD5B868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVFYK-0006BT-2u; Mon, 15 Dec 2025 15:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYH-00068P-AM
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYF-0005il-Bk
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765831934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmKusuq6uHMqMtwb2w5nGfEZK05nMZ43+JE7R3KsL48=;
 b=N6Fl2PITJbzSsj6RNeTPD5qrJ4+0+4YfdbNWsh2unT9psVBfv8lRy+GgyRYBm+vI9dyJQl
 zb1WLtnOz6v/l+giiQL39md4MafJgEcMUHSQ7TUGradNUHp66KX0GfuJmtwLHm+HsVn/Es
 Yo1Ukhoo4E8//7DadEV8mC8nBHY0Y5E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-faCWbvdeMSC7NpWZbRfFiQ-1; Mon, 15 Dec 2025 15:52:13 -0500
X-MC-Unique: faCWbvdeMSC7NpWZbRfFiQ-1
X-Mimecast-MFC-AGG-ID: faCWbvdeMSC7NpWZbRfFiQ_1765831933
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a344b86f7so48397396d6.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765831932; x=1766436732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JmKusuq6uHMqMtwb2w5nGfEZK05nMZ43+JE7R3KsL48=;
 b=aIe0c8fcX2UDle1yv6H2NALaXi+syo1KlkiKxqO6iKSqnJyYu9l7fBy502YYQNjHSP
 qL0DLKokvtd19VF/XdoHT+UIt+LCVNSIUR9MiDVuV55sGBZ6W2FprlW5ttZ3it7n12LS
 4gjPya3C/MT6C63xg69QrNX/L4fW+M04f5MoO62/uX/vdxshHckN1Fraf3sFqZQmhHe7
 6DFA6sQzDbF4UAsHAXtL3fdofcsXx7MnaecafmVhomz1Di8MSe8y8VzD6WJ5YZH0rP5M
 GCW3liK0N+xe7zjM/Q/AR/npUofY+n2IgbhFQSJA43vpA3YwYbpNQUvsz7VPvUBkLqxp
 KTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765831932; x=1766436732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JmKusuq6uHMqMtwb2w5nGfEZK05nMZ43+JE7R3KsL48=;
 b=YUbB72BBBLapvLWBiRq/Nxt6ae8BSEPHO+3fat5wnxRIB5Ql9+uQ5LzeABUp/Zzlx8
 9uqbjGfzsk/fLg3TMLu5XGAD6EKEzt7Gu6AWSeko82LPwHsGcVb7GZq44Q4eraFb4cZh
 78bJg+mkahvQFbMP2TvxIz+HhW/GiKyzPfg5F+IGJq3fw2sbiR5yXUOVLuZowTuFBGK8
 oVynAU8EROGziBR3uA/BOq8Xx74gGsnLG7HV3S1lUwZWxAd6HrR7Q3ixlLjB8lEMs6lp
 YLfIIdJcRPA/eoKlgbGfgAB4Sb980LiwZy4sVY/cuAAF24V4CxSf23LeuNXVcqy3ZEwp
 OqbA==
X-Gm-Message-State: AOJu0Yw0bCvuBtCKW7ygNCi7C60tkJWn1ZfH1M/fRiCrAgP0tPCRyfiw
 hbzWmaosUwr+T9CuOKj0GTltZulW66oh/oIb59ySdCzvRqPeZRWYSI78NQGgeCLvjYZtTMGhqzU
 lb6RJX3bC6Dv1VyTdm2PCX/wU9tnExf2/ZYomQ1Lm8R0OyEKN/my8cPUrkPwmuXbWNlpnf3VWcZ
 20SUyAK58T4NUUVP9HWdchxEaGg1mDtnH4QWkfFg==
X-Gm-Gg: AY/fxX4fjWCDGPRM92wFeDeWVS1km93fJWCC9ExcuN2MbrVgrQ8TSTJu4CHsBbfFGu4
 vX9lM9cDpAObALGK7b8IqhqvpWVoKAzzESuZuBk/ZZ+7tOSoTVttxisxUCA1IN1pX2gN1IasJhj
 C440ljdiJOWaUCiQ1FZ1T+AIRV5l0Qf8JRpytvvZ9m/IvQJRK9KhIO9uDbhUzK226JKmt0mrB7V
 bPVtxohhVmEV+kV8eg0M2q84bPVxmH8UKK7CM3RqPl4DVd/S883bj9Dzv/Pg5UN03DRm/3nRp6e
 H/V7/THqs1lbCecVTesIpUuKFUqQj/jvZ0p3SLmfiBdZiFw7A8YTX/2afR531HnpX3Wmz9GnBhQ
 T
X-Received: by 2002:a05:6214:da1:b0:888:5a6a:6413 with SMTP id
 6a1803df08f44-888801a0de7mr163582026d6.34.1765831932476; 
 Mon, 15 Dec 2025 12:52:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG186EHlsPG5y1vqNuLuMktpVSx3h/4JKcPW+SusIquB7ULFhBY1daE0AgPxIBWxFjd1lUSLw==
X-Received: by 2002:a05:6214:da1:b0:888:5a6a:6413 with SMTP id
 6a1803df08f44-888801a0de7mr163581666d6.34.1765831931932; 
 Mon, 15 Dec 2025 12:52:11 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899ea3621bsm58726236d6.36.2025.12.15.12.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:52:11 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Alexey Kardashevskiy <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 04/12] ramblock: Rename guest_memfd to guest_memfd_private
Date: Mon, 15 Dec 2025 15:51:55 -0500
Message-ID: <20251215205203.1185099-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215205203.1185099-1-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
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

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h   |  7 ++++---
 include/system/ramblock.h |  7 ++++++-
 accel/kvm/kvm-all.c       |  2 +-
 system/memory.c           |  2 +-
 system/physmem.c          | 21 +++++++++++----------
 5 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 3bd5ffa5e0..2384575065 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1823,10 +1823,11 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
 bool memory_region_is_protected(MemoryRegion *mr);
 
 /**
- * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
- *     associated
+ * memory_region_has_guest_memfd: check whether a memory region has
+ *     guest_memfd_private associated
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
index c32fbcf9cc..1126b6f477 100644
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
index 8b84661ae3..355b1fa26b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1899,7 +1899,7 @@ bool memory_region_is_protected(MemoryRegion *mr)
 
 bool memory_region_has_guest_memfd(MemoryRegion *mr)
 {
-    return mr->ram_block && mr->ram_block->guest_memfd >= 0;
+    return mr->ram_block && mr->ram_block->guest_memfd_private >= 0;
 }
 
 uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
diff --git a/system/physmem.c b/system/physmem.c
index 3555d2f6f7..c3c7a81310 100644
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


