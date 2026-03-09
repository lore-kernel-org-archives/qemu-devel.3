Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8BEFCA189
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPJ-0004lc-Ga; Mon, 09 Mar 2026 16:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhPD-0004hQ-RT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhPA-0007or-OM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wLFDlachEI4Q0czjIy+BCK+FfK4yknAlsXlj9QsvgqI=;
 b=AiX/1YjMKJPd52tLFbxQBjIMmLtMZZ6ZKwszPmZzgjU2VMXYmHi1X60zI+fRAshLP75Edz
 8uwjiSOPpb1kDi0tTTAVfs8eSzWspBbZ+F9jUaxCTIldNAP2LP/ujl+EOLrhA/gKRTh5Uu
 yQ1wnv2mpdHN05Ejfl1MAEj4v+62rMw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-Qf8io0T3OoK9061sp40L0g-1; Mon, 09 Mar 2026 16:40:42 -0400
X-MC-Unique: Qf8io0T3OoK9061sp40L0g-1
X-Mimecast-MFC-AGG-ID: Qf8io0T3OoK9061sp40L0g_1773088842
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd84943c76so954916085a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088842; x=1773693642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLFDlachEI4Q0czjIy+BCK+FfK4yknAlsXlj9QsvgqI=;
 b=fyEfShR7j7ZjtH/mKs7wb5l9jQA5ACaopEsgQ4pYAOMXQPKG2AlPoj0MDsGs0CdFM/
 fN8JkgdjOdsUVjNFJM5Hcg0v5/528sYawScT8jxan5QpMuVqCNCLNH2UAfytWa1+AhZh
 sxh0pedHbeG8N6Mh7wCDxme070Vbg0vXB0aljd0jlvNurmu/iMCgfWs+js9muLYDbBlR
 3VX1A3QmdholFm35OWDEvE3tJLFFNYD6IsGKZgHQ/LcZ5VsNjq2XTcdykE2LWHIx2CF+
 Kc/STs/Wr7QLIO+fb0IbjCh9gpzEQ7pk9tcV4AO2nH7/Mhx2e4jEwng3lkQNgWo14ebP
 Bbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088842; x=1773693642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wLFDlachEI4Q0czjIy+BCK+FfK4yknAlsXlj9QsvgqI=;
 b=w30iVuMABp9BTtIWkGUzWOlx+/RFpBDZVaEc02JkfhU7bCTIGjBsqPodhq7j0tjzxH
 2DTU/VJUuVBZgPQZYytl7h2bYH5mNnYofmqgmiX9liGzgXTZUvT71YZJjmpP7LTGeygi
 L31nHyMxP0XGSF8jqgfF61GuqfU0/etz0bmTbgERnhE/30rRJq3Rd7yP6VW1xGT4Aw+m
 9OGqXMIVxSzuNznGc9GnSsqcTkuKyRCCOTpT31KqUi6kvTGRVGn+tuk02bUR7XrWvNVQ
 pycLw2xLTNUl0xW1XCUT0wuTQjcRmOt5cNar3UuWgxmLSx5VwdSHw9nqwKxfAd+vzwFb
 QeNQ==
X-Gm-Message-State: AOJu0YwEWNHV3hFpEmRygbBIgau78ZaulHthC0m8kJwHYbj6evGn8eOC
 k0CTUBwMONb/lgmxzh94MRQX+qdMi2c5pFzoOPjNaNIGMb++bywhopDaPkg2uJC5BehnMIiO/B7
 cu5NEDvBbvofc/MPlfwpLO5MUg2iFSDbIWS/v9tIPFU3D68+FcTHE9ubElGeHOjOvFXzS8SxpJJ
 YZ9GEedKcV1kxlAwYQkoWaARHk1SnMcHIBFyo5iw==
X-Gm-Gg: ATEYQzzfJlsCjDweI8KeJrlEw6Lo4ktqVjEvBk1sLle78saJRvDZ7kvnRPp4/vvJpjx
 RZrECVd1ZexSS+CN6S7KWFR4bO4EUa9+npRO4VKC6PFQiSwXHKvnwzszjML5LJHE9DI3D1Osed3
 IykPJV5CpLACNtwj060+b7qZYPeoXAZNKYd3Jiai8M6KcIrFjBUeAyaeGpGOqUOMUlYyrpPecRU
 tW4174KXgmnYKvl3HRKabhlP+FW5zbuvLn17zURHplZsVQNrkpl5QSwSaxTL3ja8AdBBCvtPPhA
 YvEB5NHp0COsZyELAbpzejBXe0/fBb6qqEkjb+kNsrWW2COinLrN0qfwCUBLbzwSkP7Rb766SXY
 BCOyoQT5Kh3fAZXJa1ePS/GlZ/htDAGuLtiqywkEYXUhCZ3e6Pd+YGlJLn+yPkh7hYZ7c8GFy+d
 EARcxUXw==
X-Received: by 2002:a05:620a:4083:b0:8cd:75a9:eab9 with SMTP id
 af79cd13be357-8cd93b7eb74mr108391685a.14.1773088841654; 
 Mon, 09 Mar 2026 13:40:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4083:b0:8cd:75a9:eab9 with SMTP id
 af79cd13be357-8cd93b7eb74mr108387485a.14.1773088840971; 
 Mon, 09 Mar 2026 13:40:40 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 16/18] system/memory: Constify various MemoryRegion arguments
Date: Mon,  9 Mar 2026 16:40:05 -0400
Message-ID: <20260309204007.1709441-17-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mark the MemoryRegion structure const when is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260309183536.88976-3-philmd@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 38 +++++++++++++++++++-------------------
 system/memory.c         | 38 ++++++++++++++++++++------------------
 system/physmem.c        |  2 +-
 3 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index a9b0e19be8..d7b18b632d 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1690,14 +1690,14 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
  *
  * @mr: the memory region being queried.
  */
-Object *memory_region_owner(MemoryRegion *mr);
+Object *memory_region_owner(const MemoryRegion *mr);
 
 /**
  * memory_region_size: get a memory region's size.
  *
  * @mr: the memory region being queried.
  */
-uint64_t memory_region_size(MemoryRegion *mr);
+uint64_t memory_region_size(const MemoryRegion *mr);
 
 /**
  * memory_region_is_ram: check whether a memory region is random access
@@ -1706,7 +1706,7 @@ uint64_t memory_region_size(MemoryRegion *mr);
  *
  * @mr: the memory region being queried
  */
-static inline bool memory_region_is_ram(MemoryRegion *mr)
+static inline bool memory_region_is_ram(const MemoryRegion *mr)
 {
     return mr->ram;
 }
@@ -1718,7 +1718,7 @@ static inline bool memory_region_is_ram(MemoryRegion *mr)
  *
  * @mr: the memory region being queried
  */
-bool memory_region_is_ram_device(MemoryRegion *mr);
+bool memory_region_is_ram_device(const MemoryRegion *mr);
 
 /**
  * memory_region_is_romd: check whether a memory region is in ROMD mode
@@ -1728,7 +1728,7 @@ bool memory_region_is_ram_device(MemoryRegion *mr);
  *
  * @mr: the memory region being queried
  */
-static inline bool memory_region_is_romd(MemoryRegion *mr)
+static inline bool memory_region_is_romd(const MemoryRegion *mr)
 {
     return mr->rom_device && mr->romd_mode;
 }
@@ -1741,7 +1741,7 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
  *
  * @mr: the memory region being queried
  */
-bool memory_region_is_protected(MemoryRegion *mr);
+bool memory_region_is_protected(const MemoryRegion *mr);
 
 /**
  * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
@@ -1751,7 +1751,7 @@ bool memory_region_is_protected(MemoryRegion *mr);
  *
  * @mr: the memory region being queried
  */
-bool memory_region_has_guest_memfd(MemoryRegion *mr);
+bool memory_region_has_guest_memfd(const MemoryRegion *mr);
 
 /**
  * memory_region_get_iommu: check whether a memory region is an iommu
@@ -1761,7 +1761,7 @@ bool memory_region_has_guest_memfd(MemoryRegion *mr);
  *
  * @mr: the memory region being queried
  */
-static inline IOMMUMemoryRegion *memory_region_get_iommu(MemoryRegion *mr)
+static inline IOMMUMemoryRegion *memory_region_get_iommu(const MemoryRegion *mr)
 {
     if (mr->alias) {
         return memory_region_get_iommu(mr->alias);
@@ -1932,7 +1932,7 @@ const char *memory_region_name(const MemoryRegion *mr);
  * @mr: the memory region being queried
  * @client: the client being queried
  */
-bool memory_region_is_logging(MemoryRegion *mr, uint8_t client);
+bool memory_region_is_logging(const MemoryRegion *mr, uint8_t client);
 
 /**
  * memory_region_get_dirty_log_mask: return the clients for which a
@@ -1943,7 +1943,7 @@ bool memory_region_is_logging(MemoryRegion *mr, uint8_t client);
  *
  * @mr: the memory region being queried
  */
-uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr);
+uint8_t memory_region_get_dirty_log_mask(const MemoryRegion *mr);
 
 /**
  * memory_region_is_rom: check whether a memory region is ROM
@@ -1952,7 +1952,7 @@ uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr);
  *
  * @mr: the memory region being queried
  */
-static inline bool memory_region_is_rom(MemoryRegion *mr)
+static inline bool memory_region_is_rom(const MemoryRegion *mr)
 {
     return mr->ram && mr->readonly;
 }
@@ -1964,7 +1964,7 @@ static inline bool memory_region_is_rom(MemoryRegion *mr)
  *
  * @mr: the memory region being queried
  */
-static inline bool memory_region_is_nonvolatile(MemoryRegion *mr)
+static inline bool memory_region_is_nonvolatile(const MemoryRegion *mr)
 {
     return mr->nonvolatile;
 }
@@ -1977,7 +1977,7 @@ static inline bool memory_region_is_nonvolatile(MemoryRegion *mr)
  *
  * @mr: the RAM or alias memory region being queried.
  */
-int memory_region_get_fd(MemoryRegion *mr);
+int memory_region_get_fd(const MemoryRegion *mr);
 
 /**
  * memory_region_from_host: Convert a pointer into a RAM memory region
@@ -2012,7 +2012,7 @@ MemoryRegion *memory_region_from_host(void *ptr, ram_addr_t *offset);
  *
  * @mr: the memory region being queried.
  */
-void *memory_region_get_ram_ptr(MemoryRegion *mr);
+void *memory_region_get_ram_ptr(const MemoryRegion *mr);
 
 /* memory_region_ram_resize: Resize a RAM region.
  *
@@ -2362,7 +2362,7 @@ void memory_region_add_subregion_overlap(MemoryRegion *mr,
  *
  * @mr: the region to be queried
  */
-ram_addr_t memory_region_get_ram_addr(MemoryRegion *mr);
+ram_addr_t memory_region_get_ram_addr(const MemoryRegion *mr);
 
 uint64_t memory_region_get_alignment(const MemoryRegion *mr);
 /**
@@ -2462,7 +2462,7 @@ bool memory_region_present(MemoryRegion *container, hwaddr addr);
  *
  * @mr: a #MemoryRegion which should be checked if it's mapped
  */
-bool memory_region_is_mapped(MemoryRegion *mr);
+bool memory_region_is_mapped(const MemoryRegion *mr);
 
 /**
  * memory_region_get_ram_discard_manager: get the #RamDiscardManager for a
@@ -2908,7 +2908,7 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
 bool prepare_mmio_access(MemoryRegion *mr);
 
-static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
+static inline bool memory_region_supports_direct_access(const MemoryRegion *mr)
 {
     /* ROM DEVICE regions only allow direct access if in ROMD mode. */
     if (memory_region_is_romd(mr)) {
@@ -2925,8 +2925,8 @@ static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
     return !memory_region_is_ram_device(mr);
 }
 
-static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write,
-                                           MemTxAttrs attrs)
+static inline bool memory_access_is_direct(const MemoryRegion *mr,
+                                           bool is_write, MemTxAttrs attrs)
 {
     if (!memory_region_supports_direct_access(mr)) {
         return false;
diff --git a/system/memory.c b/system/memory.c
index f1db72eb42..fca74ee62b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1750,9 +1750,9 @@ static void memory_region_finalize(Object *obj)
     g_free(mr->ioeventfds);
 }
 
-Object *memory_region_owner(MemoryRegion *mr)
+Object *memory_region_owner(const MemoryRegion *mr)
 {
-    Object *obj = OBJECT(mr);
+    const Object *obj = OBJECT(mr);
     return obj->parent;
 }
 
@@ -1780,7 +1780,7 @@ void memory_region_unref(MemoryRegion *mr)
     }
 }
 
-uint64_t memory_region_size(MemoryRegion *mr)
+uint64_t memory_region_size(const MemoryRegion *mr)
 {
     if (int128_eq(mr->size, int128_2_64())) {
         return UINT64_MAX;
@@ -1797,25 +1797,25 @@ const char *memory_region_name(const MemoryRegion *mr)
     return mr->name;
 }
 
-bool memory_region_is_ram_device(MemoryRegion *mr)
+bool memory_region_is_ram_device(const MemoryRegion *mr)
 {
     return mr->ram_device;
 }
 
-bool memory_region_is_protected(MemoryRegion *mr)
+bool memory_region_is_protected(const MemoryRegion *mr)
 {
     return mr->ram && (mr->ram_block->flags & RAM_PROTECTED);
 }
 
-bool memory_region_has_guest_memfd(MemoryRegion *mr)
+bool memory_region_has_guest_memfd(const MemoryRegion *mr)
 {
     return mr->ram_block && mr->ram_block->guest_memfd >= 0;
 }
 
-uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
+uint8_t memory_region_get_dirty_log_mask(const MemoryRegion *mr)
 {
     uint8_t mask = mr->dirty_log_mask;
-    RAMBlock *rb = mr->ram_block;
+    const RAMBlock *rb = mr->ram_block;
 
     if (global_dirty_tracking && ((rb && qemu_ram_is_migratable(rb)) ||
                              memory_region_is_iommu(mr))) {
@@ -1829,7 +1829,7 @@ uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
     return mask;
 }
 
-bool memory_region_is_logging(MemoryRegion *mr, uint8_t client)
+bool memory_region_is_logging(const MemoryRegion *mr, uint8_t client)
 {
     return memory_region_get_dirty_log_mask(mr) & (1 << client);
 }
@@ -2337,7 +2337,7 @@ void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
         memory_region_get_ram_addr(mr) + addr, size, client, NULL);
 }
 
-int memory_region_get_fd(MemoryRegion *mr)
+int memory_region_get_fd(const MemoryRegion *mr)
 {
     RCU_READ_LOCK_GUARD();
     while (mr->alias) {
@@ -2346,7 +2346,7 @@ int memory_region_get_fd(MemoryRegion *mr)
     return mr->ram_block->fd;
 }
 
-void *memory_region_get_ram_ptr(MemoryRegion *mr)
+void *memory_region_get_ram_ptr(const MemoryRegion *mr)
 {
     uint64_t offset = 0;
 
@@ -2371,7 +2371,7 @@ MemoryRegion *memory_region_from_host(void *ptr, ram_addr_t *offset)
     return block->mr;
 }
 
-ram_addr_t memory_region_get_ram_addr(MemoryRegion *mr)
+ram_addr_t memory_region_get_ram_addr(const MemoryRegion *mr)
 {
     return mr->ram_block ? mr->ram_block->offset : RAM_ADDR_INVALID;
 }
@@ -2737,7 +2737,7 @@ static FlatRange *flatview_lookup(FlatView *view, AddrRange addr)
                    sizeof(FlatRange), cmp_flatrange_addr);
 }
 
-bool memory_region_is_mapped(MemoryRegion *mr)
+bool memory_region_is_mapped(const MemoryRegion *mr)
 {
     return !!mr->container || mr->mapped_via_alias;
 }
@@ -3221,7 +3221,7 @@ void address_space_destroy_free(AddressSpace *as)
     call_rcu(as, do_address_space_destroy_free, rcu);
 }
 
-static const char *memory_region_type(MemoryRegion *mr)
+static const char *memory_region_type(const MemoryRegion *mr)
 {
     if (mr->alias) {
         return memory_region_type(mr->alias);
@@ -3414,7 +3414,6 @@ static void mtree_print_flatview(gpointer key, gpointer value,
     GArray *fv_address_spaces = value;
     struct FlatViewInfo *fvi = user_data;
     FlatRange *range = &view->ranges[0];
-    MemoryRegion *mr;
     int n = view->nr;
     int i;
     AddressSpace *as;
@@ -3441,7 +3440,8 @@ static void mtree_print_flatview(gpointer key, gpointer value,
     }
 
     while (n--) {
-        mr = range->mr;
+        const MemoryRegion *mr = range->mr;
+
         if (range->offset_in_region) {
             qemu_printf(MTREE_INDENT HWADDR_FMT_plx "-" HWADDR_FMT_plx
                         " (prio %d, %s%s): %s @" HWADDR_FMT_plx,
@@ -3614,8 +3614,10 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
 
     /* print aliased regions */
     QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
-        qemu_printf("memory-region: %s\n", memory_region_name(ml->mr));
-        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled);
+        const MemoryRegion *mr = ml->mr;
+
+        qemu_printf("memory-region: %s\n", memory_region_name(mr));
+        mtree_print_mr(mr, 1, 0, &ml_head, owner, disabled);
         qemu_printf("\n");
     }
 
diff --git a/system/physmem.c b/system/physmem.c
index e5390d09be..4a9e076004 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1975,7 +1975,7 @@ void qemu_ram_unset_idstr(RAMBlock *block)
     }
 }
 
-static char *cpr_name(MemoryRegion *mr)
+static char *cpr_name(const MemoryRegion *mr)
 {
     const char *mr_name = memory_region_name(mr);
     g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
-- 
2.50.1


