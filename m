Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F458C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xeo-0004N8-2d; Mon, 06 May 2024 08:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdz-0003dN-6k
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xds-0002Xd-54
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:34 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34e0d8b737eso2432816f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999226; x=1715604026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTcAtz5StyXLlO/6Yq7APKphEf7fSpnGIrEv/+Ejp0A=;
 b=zcXuc+d44REnIMs7+ZijoVPHYqQQxUkkiimrrYQ/dy/MzEO6tQl2Ar2q89qJxauvzC
 EJsH9sV77Zd9vMDRMjqQJ2z8RaQ14IJM9NG4uP0txUOI9XF7ZNCsv2UBLGtv+GtTfvQG
 CD5Spi6sKlSJx+2sZWregBrKIhct48mLUnq4F/9yA5GNCsKl+RdFBllzwkW+F4JCjfW5
 uYkmt3nqPsWribNJ8IeaQEG3YXGiBfOtgDifmXnqq53g7Z1afE4XUbztDNZ3+jfL8AMq
 d+QyNLjRckT29qOGsBQBNxejkfQ1lQCfUXgm5sl1NdWHdNfQy9190PV0WaFrCksu4i5p
 u8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999226; x=1715604026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WTcAtz5StyXLlO/6Yq7APKphEf7fSpnGIrEv/+Ejp0A=;
 b=jWN8OwnMF1i8l3T9+plgpC0a/splqhYFwVZI7xpD7KR51CAdgURIqN+8EgaunhqL0A
 jjxazze8ZIdLZ0qbjlZ3A8mANNtM62skiIp/VwbKoX55pQkOlCpjmzkaM8G4eEbEHauP
 M8KL9V7tnyDFtojxqLM2EVWvk/m79O8kZ4GBtqV24aZyEbEzY2gcj/BssNdbPfYgn14h
 P5Jroaw8EahlDjb2axRjrlDJEDQjVoLSOM8zLmLOAmuDtZb/fPTUte106VifpaiYctYt
 mn4DaiwLBfLE6RRse4TQxAn6GEfifPDb9PDB6YaJG9B3GRaSqRBI/q7/j8zSNczPXaez
 g12g==
X-Gm-Message-State: AOJu0YwjoSr5BHNQrydCgVPnE14EJkAAba+BtGHJPDojzSgJkFpH6Whs
 zamWdEMdPJ7v34KtJvlBAbdGMXIe/GRzwZ9bjC8cuGLo6TtBC1ZKTRv/CJPBN94XlL8fVEET6MM
 5
X-Google-Smtp-Source: AGHT+IG8CEk6cAZ17u5/C9BWLnvBnCrgmHQ1youI/loJRGlXRyNQFPnKuBKjS4tlwzyDbpyMrERjiQ==
X-Received: by 2002:a05:6000:188:b0:34d:c4c7:7ca with SMTP id
 p8-20020a056000018800b0034dc4c707camr11471080wrx.20.1714999226077; 
 Mon, 06 May 2024 05:40:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 g4-20020a5d5404000000b0034ca136f0e9sm10608838wrv.88.2024.05.06.05.40.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:40:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 26/28] softmmu: Pass RAM MemoryRegion and is_write in
 xen_map_cache()
Date: Mon,  6 May 2024 14:37:26 +0200
Message-ID: <20240506123728.65278-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Propagate MR and is_write to xen_map_cache().
This is in preparation for adding support for grant mappings.

No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20240430164939.925307-14-edgar.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/xen-mapcache.h | 11 +++++++----
 hw/xen/xen-mapcache.c         | 10 ++++++----
 system/physmem.c              | 31 +++++++++++++++++++++++--------
 3 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index 10c2e3082a..1ec9e66752 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -18,8 +18,9 @@ typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
 
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
-uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
-                       uint8_t lock, bool dma);
+uint8_t *xen_map_cache(MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
+                       uint8_t lock, bool dma,
+                       bool is_write);
 ram_addr_t xen_ram_addr_from_mapcache(void *ptr);
 void xen_invalidate_map_cache_entry(uint8_t *buffer);
 void xen_invalidate_map_cache(void);
@@ -33,10 +34,12 @@ static inline void xen_map_cache_init(phys_offset_to_gaddr_t f,
 {
 }
 
-static inline uint8_t *xen_map_cache(hwaddr phys_addr,
+static inline uint8_t *xen_map_cache(MemoryRegion *mr,
+                                     hwaddr phys_addr,
                                      hwaddr size,
                                      uint8_t lock,
-                                     bool dma)
+                                     bool dma,
+                                     bool is_write)
 {
     abort();
 }
diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 6fb2db2612..fa6813b1ad 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -254,7 +254,7 @@ static void xen_remap_bucket(MapCache *mc,
 
 static uint8_t *xen_map_cache_unlocked(MapCache *mc,
                                        hwaddr phys_addr, hwaddr size,
-                                       uint8_t lock, bool dma)
+                                       uint8_t lock, bool dma, bool is_write)
 {
     MapCacheEntry *entry, *pentry = NULL,
                   *free_entry = NULL, *free_pentry = NULL;
@@ -377,13 +377,15 @@ tryagain:
     return mc->last_entry->vaddr_base + address_offset;
 }
 
-uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
-                       uint8_t lock, bool dma)
+uint8_t *xen_map_cache(MemoryRegion *mr,
+                       hwaddr phys_addr, hwaddr size,
+                       uint8_t lock, bool dma,
+                       bool is_write)
 {
     uint8_t *p;
 
     mapcache_lock(mapcache);
-    p = xen_map_cache_unlocked(mapcache, phys_addr, size, lock, dma);
+    p = xen_map_cache_unlocked(mapcache, phys_addr, size, lock, dma, is_write);
     mapcache_unlock(mapcache);
     return p;
 }
diff --git a/system/physmem.c b/system/physmem.c
index 8278e31c1a..79d46054c5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2191,11 +2191,22 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
 
 /*
  * Return a host pointer to guest's ram.
+ * For Xen, foreign mappings get created if they don't already exist.
+ *
+ * @block: block for the RAM to lookup (optional and may be NULL).
+ * @addr: address within the memory region.
+ * @size: pointer to requested size (optional and may be NULL).
+ *        size may get modified and return a value smaller than
+ *        what was requested.
+ * @lock: wether to lock the mapping in xen-mapcache until invalidated.
+ * @is_write: hint wether to map RW or RO in the xen-mapcache.
+ *            (optional and may always be set to true).
  *
  * Called within RCU critical section.
  */
 static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
-                                 hwaddr *size, bool lock)
+                                 hwaddr *size, bool lock,
+                                 bool is_write)
 {
     hwaddr len = 0;
 
@@ -2218,10 +2229,13 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * In that case just map the requested area.
          */
         if (block->offset == 0) {
-            return xen_map_cache(addr, len, lock, lock);
+            return xen_map_cache(block->mr, addr, len, lock, lock,
+                                 is_write);
         }
 
-        block->host = xen_map_cache(block->offset, block->max_length, 1, lock);
+        block->host = xen_map_cache(block->mr, block->offset,
+                                    block->max_length, 1,
+                                    lock, is_write);
     }
 
     return ramblock_ptr(block, addr);
@@ -2237,7 +2251,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
  */
 void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
 {
-    return qemu_ram_ptr_length(ram_block, addr, NULL, false);
+    return qemu_ram_ptr_length(ram_block, addr, NULL, false, true);
 }
 
 /* Return the offset of a hostpointer within a ramblock */
@@ -2747,7 +2761,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
     } else {
         /* RAM case */
         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
-                                               false);
+                                               false, true);
 
         memmove(ram_ptr, buf, *l);
         invalidate_and_set_dirty(mr, mr_addr, *l);
@@ -2840,7 +2854,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
     } else {
         /* RAM case */
         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
-                                               false);
+                                               false, false);
 
         memcpy(buf, ram_ptr, *l);
 
@@ -3234,7 +3248,7 @@ void *address_space_map(AddressSpace *as,
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
                                         l, is_write, attrs);
     fuzz_dma_read_cb(addr, *plen, mr);
-    return qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
+    return qemu_ram_ptr_length(mr->ram_block, xlat, plen, true, is_write);
 }
 
 /* Unmaps a memory region previously mapped by address_space_map().
@@ -3330,7 +3344,8 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
         l = flatview_extend_translation(cache->fv, addr, len, mr,
                                         cache->xlat, l, is_write,
                                         MEMTXATTRS_UNSPECIFIED);
-        cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l, true);
+        cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l, true,
+                                         is_write);
     } else {
         cache->ptr = NULL;
     }
-- 
2.41.0


