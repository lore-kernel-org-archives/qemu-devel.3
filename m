Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DCAC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 10:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sASWr-0006Rc-PK; Fri, 24 May 2024 06:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sASWn-0006NS-Sg
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:52:01 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sASWl-0007df-J6
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:52:01 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e95a74d51fso11426781fa.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716547916; x=1717152716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKmmum6z28VcY8ouSg3YJA3bHZvP87XkBXtO/hd8PR8=;
 b=IJSqbwhBuXiz4zeiwaZYzUDitgTNinLgSS4bIBNbBCuQdp9HfhThvTnuTQhE93p0ij
 NPR6RnJHzGPTL/Ig/XCaw7Iy3cY5q3PWyH3mO+iFvPCGEPmy1EhKBKiSfc+uYhs1YgKi
 KNAFBXhh7by7Ed0+NRuffvCFgG7n/4HZtoEQpHtaEk035Ya2kji7WDOuQmM+Ox0PaaEy
 hvgaDY2NPAAeNqNvRY62qfkTYXKFmhQuZ3VITpwOm9rkLN6Svbi993xEYJBgKuizEbob
 tRrexuzeV3sUr7ct1oHtTzih0qoi7g2ehEO5o0s8Awccy6jZ/NIYxq99MOmhG0PnhRyp
 8O5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716547916; x=1717152716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oKmmum6z28VcY8ouSg3YJA3bHZvP87XkBXtO/hd8PR8=;
 b=sGMSJ5LWv6sFBCpNHCHQ5RepOy3+a6dd9hUZj04QL6aCgeYiYd0yveo4kYNxZb1MFo
 jfUglJPkDkRdE1lgFBhtKKJZwtV2BFJn6WCjLnghC1dK1NS5SPBHmphq4XBI/NBafXVt
 LFHiMqykwD6sUbN61GoeqZc4XrVJjbL7MHaT3v3A40Q1z7ytA0PlhiHTHMJAmu7egzi+
 oVwN3lnx02kaZ57Caw90/ytdpb09NIWUciQn0qlFdYnLwWsnYSH4YjEsb63HhmTm6CDU
 CxPO77lsts38YOurhnAo4+ZFv/oYt9U/6COGkQSpoEnS/0I3PQ7Ag6gobwymDeNDaYXd
 98gw==
X-Gm-Message-State: AOJu0YwVeJ3ysXpk4KekxKOCT09bnXIkUmz8cJgdBIsTO8StaSEJlM7H
 c82XpGvz5cepHKLpOsVbL8Qs/DHZagepfJ5OnSWRMYmNsZSuCY2yb0WWaay9
X-Google-Smtp-Source: AGHT+IEGg/j9kr5jKj/tv+syV4xN0QPHZQ3VcNTdBVPyyQs2WD0/L2C8QLd0gT/jlHUTsM+RTiWqvg==
X-Received: by 2002:a2e:b784:0:b0:2e0:6313:fe3a with SMTP id
 38308e7fff4ca-2e95b256875mr16230641fa.35.1716547916526; 
 Fri, 24 May 2024 03:51:56 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e95bcd7c20sm1491561fa.33.2024.05.24.03.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 03:51:56 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v7 1/8] xen: mapcache: Make MCACHE_BUCKET_SHIFT runtime
 configurable
Date: Fri, 24 May 2024 12:51:45 +0200
Message-Id: <20240524105152.1301842-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
References: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Make MCACHE_BUCKET_SHIFT runtime configurable per cache instance.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen-mapcache.c | 54 ++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index fa6813b1ad..bc860f4373 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -23,13 +23,10 @@
 
 
 #if HOST_LONG_BITS == 32
-#  define MCACHE_BUCKET_SHIFT 16
 #  define MCACHE_MAX_SIZE     (1UL<<31) /* 2GB Cap */
 #else
-#  define MCACHE_BUCKET_SHIFT 20
 #  define MCACHE_MAX_SIZE     (1UL<<35) /* 32GB Cap */
 #endif
-#define MCACHE_BUCKET_SIZE (1UL << MCACHE_BUCKET_SHIFT)
 
 /* This is the size of the virtual address space reserve to QEMU that will not
  * be use by MapCache.
@@ -65,7 +62,8 @@ typedef struct MapCache {
     /* For most cases (>99.9%), the page address is the same. */
     MapCacheEntry *last_entry;
     unsigned long max_mcache_size;
-    unsigned int mcache_bucket_shift;
+    unsigned int bucket_shift;
+    unsigned long bucket_size;
 
     phys_offset_to_gaddr_t phys_offset_to_gaddr;
     QemuMutex lock;
@@ -95,11 +93,14 @@ static inline int test_bits(int nr, int size, const unsigned long *addr)
 
 static MapCache *xen_map_cache_init_single(phys_offset_to_gaddr_t f,
                                            void *opaque,
+                                           unsigned int bucket_shift,
                                            unsigned long max_size)
 {
     unsigned long size;
     MapCache *mc;
 
+    assert(bucket_shift >= XC_PAGE_SHIFT);
+
     mc = g_new0(MapCache, 1);
 
     mc->phys_offset_to_gaddr = f;
@@ -108,12 +109,14 @@ static MapCache *xen_map_cache_init_single(phys_offset_to_gaddr_t f,
 
     QTAILQ_INIT(&mc->locked_entries);
 
+    mc->bucket_shift = bucket_shift;
+    mc->bucket_size = 1UL << bucket_shift;
     mc->max_mcache_size = max_size;
 
     mc->nr_buckets =
         (((mc->max_mcache_size >> XC_PAGE_SHIFT) +
-          (1UL << (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT)) - 1) >>
-         (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT));
+          (1UL << (bucket_shift - XC_PAGE_SHIFT)) - 1) >>
+         (bucket_shift - XC_PAGE_SHIFT));
 
     size = mc->nr_buckets * sizeof(MapCacheEntry);
     size = (size + XC_PAGE_SIZE - 1) & ~(XC_PAGE_SIZE - 1);
@@ -126,6 +129,13 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
 {
     struct rlimit rlimit_as;
     unsigned long max_mcache_size;
+    unsigned int bucket_shift;
+
+    if (HOST_LONG_BITS == 32) {
+        bucket_shift = 16;
+    } else {
+        bucket_shift = 20;
+    }
 
     if (geteuid() == 0) {
         rlimit_as.rlim_cur = RLIM_INFINITY;
@@ -146,7 +156,9 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
         }
     }
 
-    mapcache = xen_map_cache_init_single(f, opaque, max_mcache_size);
+    mapcache = xen_map_cache_init_single(f, opaque,
+                                         bucket_shift,
+                                         max_mcache_size);
     setrlimit(RLIMIT_AS, &rlimit_as);
 }
 
@@ -195,7 +207,7 @@ static void xen_remap_bucket(MapCache *mc,
     entry->valid_mapping = NULL;
 
     for (i = 0; i < nb_pfn; i++) {
-        pfns[i] = (address_index << (MCACHE_BUCKET_SHIFT-XC_PAGE_SHIFT)) + i;
+        pfns[i] = (address_index << (mc->bucket_shift - XC_PAGE_SHIFT)) + i;
     }
 
     /*
@@ -266,8 +278,8 @@ static uint8_t *xen_map_cache_unlocked(MapCache *mc,
     bool dummy = false;
 
 tryagain:
-    address_index  = phys_addr >> MCACHE_BUCKET_SHIFT;
-    address_offset = phys_addr & (MCACHE_BUCKET_SIZE - 1);
+    address_index  = phys_addr >> mc->bucket_shift;
+    address_offset = phys_addr & (mc->bucket_size - 1);
 
     trace_xen_map_cache(phys_addr);
 
@@ -294,14 +306,14 @@ tryagain:
         return mc->last_entry->vaddr_base + address_offset;
     }
 
-    /* size is always a multiple of MCACHE_BUCKET_SIZE */
+    /* size is always a multiple of mc->bucket_size */
     if (size) {
         cache_size = size + address_offset;
-        if (cache_size % MCACHE_BUCKET_SIZE) {
-            cache_size += MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCKET_SIZE);
+        if (cache_size % mc->bucket_size) {
+            cache_size += mc->bucket_size - (cache_size % mc->bucket_size);
         }
     } else {
-        cache_size = MCACHE_BUCKET_SIZE;
+        cache_size = mc->bucket_size;
     }
 
     entry = &mc->entry[address_index % mc->nr_buckets];
@@ -422,7 +434,7 @@ static ram_addr_t xen_ram_addr_from_mapcache_single(MapCache *mc, void *ptr)
         trace_xen_ram_addr_from_mapcache_not_in_cache(ptr);
         raddr = RAM_ADDR_INVALID;
     } else {
-        raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
+        raddr = (reventry->paddr_index << mc->bucket_shift) +
              ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
     }
     mapcache_unlock(mc);
@@ -585,8 +597,8 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
     hwaddr address_index, address_offset;
     hwaddr test_bit_size, cache_size = size;
 
-    address_index  = old_phys_addr >> MCACHE_BUCKET_SHIFT;
-    address_offset = old_phys_addr & (MCACHE_BUCKET_SIZE - 1);
+    address_index  = old_phys_addr >> mc->bucket_shift;
+    address_offset = old_phys_addr & (mc->bucket_size - 1);
 
     assert(size);
     /* test_bit_size is always a multiple of XC_PAGE_SIZE */
@@ -595,8 +607,8 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
         test_bit_size += XC_PAGE_SIZE - (test_bit_size % XC_PAGE_SIZE);
     }
     cache_size = size + address_offset;
-    if (cache_size % MCACHE_BUCKET_SIZE) {
-        cache_size += MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCKET_SIZE);
+    if (cache_size % mc->bucket_size) {
+        cache_size += mc->bucket_size - (cache_size % mc->bucket_size);
     }
 
     entry = &mc->entry[address_index % mc->nr_buckets];
@@ -609,8 +621,8 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
         return NULL;
     }
 
-    address_index  = new_phys_addr >> MCACHE_BUCKET_SHIFT;
-    address_offset = new_phys_addr & (MCACHE_BUCKET_SIZE - 1);
+    address_index  = new_phys_addr >> mc->bucket_shift;
+    address_offset = new_phys_addr & (mc->bucket_size - 1);
 
     trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
 
-- 
2.40.1


