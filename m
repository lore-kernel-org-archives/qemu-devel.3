Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C683AC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJyA-0006An-6g; Wed, 29 May 2024 10:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCJy8-00069V-4N
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:07:56 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCJy4-0005iq-S3
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:07:54 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52aea6067c8so855947e87.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716991670; x=1717596470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Zme5MAc1tBIih0t7wrm5r256IXDIRT3xxgBybd+OME=;
 b=aWGF1Tv4HortAShVViVBI4CV/6Z5Lc0yT26f3Ahwwy3yRozBIu8qQohoqnpsZn2Y07
 TJeO8UpoMuA03yeDpX2F066A8IA38sh458eXJdS6sZPbeNXI5rUNS0AFam24PhBKb/q2
 qUEZV9F/+W+iaGkLtXc+Nx86Em7tXHhgwE1UmBo9De24OYyCiZgkBQWpfazizKRzKBFZ
 cYlK0iIglNGWHrZ9smUE88UGhhJIHtVXxS2ycOaSJnC9UqErEHdbjButfbu2jVOv/b5J
 Oj2bzT04KalGkb7tw0sTz4zck44NJAVK5bsy9h9qrqmvThlqExrE0TV9CEBxxA4VSUO8
 Vgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716991670; x=1717596470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Zme5MAc1tBIih0t7wrm5r256IXDIRT3xxgBybd+OME=;
 b=lR2jpfNM2IZaRYo4gMg6X2D6NsGQLpSuPouQ6TwaLUi9vTQ5SlOvbFXJrYZqYqgBpn
 j8xpgRjvwONWWgpk7ZvzZDCI0haoxbxlx+sqOf1AWyWlnOuBv/+vzCFQLBSv7MY64fUg
 ZcDtsmcJu2o2xLGITqn3DRUuKUfPHTPcDN1voIfyymFNGs/fFzXcIpfcVSX1mxdxFAgf
 yIKeUqdN35n5QqedCPHKp9NcJqSxhGBziOwOB0AUkwOWeJwU/awI6YBTULxDEj3+O16/
 rbXIDT0hE/mezCHr9mUKGkJQ+34VH+tl75BtD1BP9B1MWRK3gHCR0JoCVDm30+sUMudM
 5xQQ==
X-Gm-Message-State: AOJu0YwjzWz3F3rcefxNg2omw0KWkISCKzgonIBprV8dJTNDl+uvdXdy
 77HZTMF44DBjibKvj2XgKGinFplQDj4XWQprnq/fu4GzN1Nj6WncjBa2+cv6
X-Google-Smtp-Source: AGHT+IG4vbZH58aNNCx5WtguQ+wygMZh32hk2g0EZYP53A4we56wYQmUuGwtdGe8zRPUZLd0GfJq8g==
X-Received: by 2002:a05:6512:3194:b0:51f:3fea:cbcf with SMTP id
 2adb3069b0e04-529664dac0cmr11284687e87.52.1716991669796; 
 Wed, 29 May 2024 07:07:49 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-529b712e856sm736822e87.197.2024.05.29.07.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:07:48 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v8 6/8] xen: mapcache: Pass the ram_addr offset to
 xen_map_cache()
Date: Wed, 29 May 2024 16:07:37 +0200
Message-Id: <20240529140739.1387692-7-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
References: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Pass the ram_addr offset to xen_map_cache.
This is in preparation for adding grant mappings that need
to compute the address within the RAMBlock.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-mapcache.c         | 16 +++++++++++-----
 include/sysemu/xen-mapcache.h |  2 ++
 system/physmem.c              |  9 +++++----
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index ec95445696..a07c47b0b1 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -167,7 +167,8 @@ static void xen_remap_bucket(MapCache *mc,
                              void *vaddr,
                              hwaddr size,
                              hwaddr address_index,
-                             bool dummy)
+                             bool dummy,
+                             ram_addr_t ram_offset)
 {
     uint8_t *vaddr_base;
     xen_pfn_t *pfns;
@@ -266,6 +267,7 @@ static void xen_remap_bucket(MapCache *mc,
 
 static uint8_t *xen_map_cache_unlocked(MapCache *mc,
                                        hwaddr phys_addr, hwaddr size,
+                                       ram_addr_t ram_offset,
                                        uint8_t lock, bool dma, bool is_write)
 {
     MapCacheEntry *entry, *pentry = NULL,
@@ -337,14 +339,16 @@ tryagain:
     if (!entry) {
         entry = g_new0(MapCacheEntry, 1);
         pentry->next = entry;
-        xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy);
+        xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy,
+                         ram_offset);
     } else if (!entry->lock) {
         if (!entry->vaddr_base || entry->paddr_index != address_index ||
                 entry->size != cache_size ||
                 !test_bits(address_offset >> XC_PAGE_SHIFT,
                     test_bit_size >> XC_PAGE_SHIFT,
                     entry->valid_mapping)) {
-            xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy);
+            xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy,
+                             ram_offset);
         }
     }
 
@@ -391,13 +395,15 @@ tryagain:
 
 uint8_t *xen_map_cache(MemoryRegion *mr,
                        hwaddr phys_addr, hwaddr size,
+                       ram_addr_t ram_addr_offset,
                        uint8_t lock, bool dma,
                        bool is_write)
 {
     uint8_t *p;
 
     mapcache_lock(mapcache);
-    p = xen_map_cache_unlocked(mapcache, phys_addr, size, lock, dma, is_write);
+    p = xen_map_cache_unlocked(mapcache, phys_addr, size, ram_addr_offset,
+                               lock, dma, is_write);
     mapcache_unlock(mapcache);
     return p;
 }
@@ -632,7 +638,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
     trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
 
     xen_remap_bucket(mc, entry, entry->vaddr_base,
-                     cache_size, address_index, false);
+                     cache_size, address_index, false, old_phys_addr);
     if (!test_bits(address_offset >> XC_PAGE_SHIFT,
                 test_bit_size >> XC_PAGE_SHIFT,
                 entry->valid_mapping)) {
diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index 1ec9e66752..b5e3ea1bc0 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -19,6 +19,7 @@ typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
 uint8_t *xen_map_cache(MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
+                       ram_addr_t ram_addr_offset,
                        uint8_t lock, bool dma,
                        bool is_write);
 ram_addr_t xen_ram_addr_from_mapcache(void *ptr);
@@ -37,6 +38,7 @@ static inline void xen_map_cache_init(phys_offset_to_gaddr_t f,
 static inline uint8_t *xen_map_cache(MemoryRegion *mr,
                                      hwaddr phys_addr,
                                      hwaddr size,
+                                     ram_addr_t ram_addr_offset,
                                      uint8_t lock,
                                      bool dma,
                                      bool is_write)
diff --git a/system/physmem.c b/system/physmem.c
index b7847db1a2..33d09f7571 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2231,13 +2231,14 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          */
         if (xen_mr_is_memory(block->mr)) {
             return xen_map_cache(block->mr, block->offset + addr,
-                                 len, lock, lock,
-                                 is_write);
+                                 len, block->offset,
+                                 lock, lock, is_write);
         }
 
         block->host = xen_map_cache(block->mr, block->offset,
-                                    block->max_length, 1,
-                                    lock, is_write);
+                                    block->max_length,
+                                    block->offset,
+                                    1, lock, is_write);
     }
 
     return ramblock_ptr(block, addr);
-- 
2.40.1


