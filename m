Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD86AC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xdM-00086M-VN; Mon, 06 May 2024 08:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdK-0007qD-IT
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xd5-0002Cr-8c
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55e8so11241215e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999177; x=1715603977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5u2rheGkOka+/vzLNLtDhnD9hQYgNI374jkL3ZGkPc=;
 b=FZ+BtUvJPefmr+BMqwJ1EnSz3CGn0xq5QgeJhWeYSaWUGkWVY5cjYBIIxAun97ALYm
 hvKTKpNrZ6J2SWk7DkQtWKd84tT//bEloJDgIlj9mXlxgyybRxhDrVhGOBD7cV4CBLIv
 zMO70Kl6zJJXopDnwflMS2vvoGLP7tS9ZHfMTEQN86NLgatENIs4gs9W33FHXTi5gS8Y
 UJTjqL1DcposzVt9dFia8AmrmHznLkIFd9J2/TSF4pG32qneQNRalTyNPq6j68MKazFi
 ASvZTAd0QDrCXb/Yv+KRZ5qcDmz9INve7/cDU/waK9I4fEPQW/RIRZJOmjNQ8hH0++i+
 CdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999177; x=1715603977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5u2rheGkOka+/vzLNLtDhnD9hQYgNI374jkL3ZGkPc=;
 b=ei09O9qv9XK/k7jlfp48Bx6Bset609aq6fCkvjQ1Qh04EeacuwoBglL+4C2YX6d1Zz
 6PH1RZnnoWjzP8wR8LKn2RtFTFGliiuitfVc/P/Xzvj4DtJJuFJqeVL+pG9r0keL2B0H
 XygcYqeiLB5zhTGZPa6vVis2Lfec3Sq/jZpTvx6oyS/YmV4vqY0hSbro15GJRlibvtK6
 nQ/H6gGLKNytTo9RonFsCmG2wHDtxXXI0reBKxyxUawFDCKpaZm5PVaja+O2qb6GM1x7
 g1NPre5Uy01MNeeu3J+vk73+Sf4XXFDI9uLTvQKGkIfUeySAvQ0KRCoJ4K40x9laU2OU
 m66Q==
X-Gm-Message-State: AOJu0YxhVrESxIhu6KuzqXDk69q+Alzq5lrvd2e03jeO14jjljcQbJZp
 Yf7/KDv5TZsXWYNDyNdfb77HKxdeW5SRJPvzorqjyXkAIijluYgOKVLJuBGmqVYyP0rT+noYONH
 x
X-Google-Smtp-Source: AGHT+IGLz2ZAUAXBGxzk59Qi/pFWQGF4bvX4V1r7EYcJjsqxyYUKqVqIeHYv8Csis1DoITvakX8xiQ==
X-Received: by 2002:a05:600c:4446:b0:41b:4de0:7bff with SMTP id
 v6-20020a05600c444600b0041b4de07bffmr7626181wmn.35.1714999177047; 
 Mon, 06 May 2024 05:39:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 i16-20020a05600c355000b0041b61504565sm16142382wmq.28.2024.05.06.05.39.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:39:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>
Subject: [PULL 18/28] xen: mapcache: Refactor lock functions for multi-instance
Date: Mon,  6 May 2024 14:37:18 +0200
Message-ID: <20240506123728.65278-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Make the lock functions take MapCache * as argument. This is
in preparation for supporting multiple caches.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <20240430164939.925307-4-edgar.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-mapcache.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 7771c6cb91..c27be6abee 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -74,14 +74,14 @@ typedef struct MapCache {
 
 static MapCache *mapcache;
 
-static inline void mapcache_lock(void)
+static inline void mapcache_lock(MapCache *mc)
 {
-    qemu_mutex_lock(&mapcache->lock);
+    qemu_mutex_lock(&mc->lock);
 }
 
-static inline void mapcache_unlock(void)
+static inline void mapcache_unlock(MapCache *mc)
 {
-    qemu_mutex_unlock(&mapcache->lock);
+    qemu_mutex_unlock(&mc->lock);
 }
 
 static inline int test_bits(int nr, int size, const unsigned long *addr)
@@ -369,9 +369,9 @@ uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
 {
     uint8_t *p;
 
-    mapcache_lock();
+    mapcache_lock(mapcache);
     p = xen_map_cache_unlocked(phys_addr, size, lock, dma);
-    mapcache_unlock();
+    mapcache_unlock(mapcache);
     return p;
 }
 
@@ -384,7 +384,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
     ram_addr_t raddr;
     int found = 0;
 
-    mapcache_lock();
+    mapcache_lock(mapcache);
     QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
         if (reventry->vaddr_req == ptr) {
             paddr_index = reventry->paddr_index;
@@ -395,7 +395,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
     }
     if (!found) {
         trace_xen_ram_addr_from_mapcache_not_found(ptr);
-        mapcache_unlock();
+        mapcache_unlock(mapcache);
         return RAM_ADDR_INVALID;
     }
 
@@ -410,7 +410,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
         raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
              ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
     }
-    mapcache_unlock();
+    mapcache_unlock(mapcache);
     return raddr;
 }
 
@@ -481,9 +481,9 @@ static void xen_invalidate_map_cache_entry_bh(void *opaque)
 {
     XenMapCacheData *data = opaque;
 
-    mapcache_lock();
+    mapcache_lock(mapcache);
     xen_invalidate_map_cache_entry_unlocked(data->buffer);
-    mapcache_unlock();
+    mapcache_unlock(mapcache);
 
     aio_co_wake(data->co);
 }
@@ -499,9 +499,9 @@ void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
                                 xen_invalidate_map_cache_entry_bh, &data);
         qemu_coroutine_yield();
     } else {
-        mapcache_lock();
+        mapcache_lock(mapcache);
         xen_invalidate_map_cache_entry_unlocked(buffer);
-        mapcache_unlock();
+        mapcache_unlock(mapcache);
     }
 }
 
@@ -513,7 +513,7 @@ void xen_invalidate_map_cache(void)
     /* Flush pending AIO before destroying the mapcache */
     bdrv_drain_all();
 
-    mapcache_lock();
+    mapcache_lock(mapcache);
 
     QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
         if (!reventry->dma) {
@@ -547,7 +547,7 @@ void xen_invalidate_map_cache(void)
 
     mapcache->last_entry = NULL;
 
-    mapcache_unlock();
+    mapcache_unlock(mapcache);
 }
 
 static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
@@ -607,8 +607,8 @@ uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
 {
     uint8_t *p;
 
-    mapcache_lock();
+    mapcache_lock(mapcache);
     p = xen_replace_cache_entry_unlocked(old_phys_addr, new_phys_addr, size);
-    mapcache_unlock();
+    mapcache_unlock(mapcache);
     return p;
 }
-- 
2.41.0


