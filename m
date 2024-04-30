Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF50C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qgm-00070i-4d; Tue, 30 Apr 2024 12:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgP-0006D7-H3
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:23 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgM-00061B-LF
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:20 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2dae975d0dcso72618391fa.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495816; x=1715100616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIVDaUdlQrWMVCAAwSwRQuE7c0313SXxgYK41vL15nU=;
 b=WGHc1IOHdKp6ljtNS/SNsLAJGk6Qb8uw7+EnTkqeppp6fqRXtdb4ZnMtwN4oZQa6kx
 JNEndBQiXcUYtHXrpeabUa7FOMYzdg7+9wPfHsFaZ1EuCMJCZcgZP/pywqSpZIZJNm5R
 fRzXPfpJsgI6q8jb3sp3csDdaBGJ0nqxVNzamOXPX1/G4IFNYJpqVhXEP2mM7DkVkcw2
 zz6SgTtyRAcgVjI5/V/q0CUNY50PdZ7zLjqLiy7HoVZ/d3W5qDMBG4TCUeE2IJGf86Lh
 2ytuCJc5kOxZW9wvYSe8ooscOHjKfvVrGdXBinMzk1dzc/PKK+FcNIju9wZduU8j3pQ2
 ZJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495816; x=1715100616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIVDaUdlQrWMVCAAwSwRQuE7c0313SXxgYK41vL15nU=;
 b=hT6PhfiuM5b+qK3HuOcT4Rvhy3+LpmUtrQwCWuL4tV1UhNU5Ipv4bdd98tB7fr20jH
 HZmLfTzYkvZLkUvzdYaeXG2OiVcSW0Xb/NSC3CQBiwKUnrQ2aJbcm32Kbfyp9nbtkSJW
 ygimL5oAbf6/iOivKYXAdIq7YkSHpbWkBwYWgQwhlq+Wg8HrpmITYSyZqYkzd+ORIhCi
 WGG2awPxYnkRoJma9C2XUTIGmcQJQNEkPrvine0jiPo1/7v2mjfzOeuM611AnV1hSWRr
 vIRNsho/wGYwM+uXc02akYPUnlfx0Fpy4qge4DoR2juobLotOfFj15I0upVpizxsXpxR
 g7ZQ==
X-Gm-Message-State: AOJu0YylP1xqEbQR4xOlMObFivTMbwyWqEIKhhYGsbGzhoJBgsFS9F3Q
 k39BtpKseVTXUzthqoC9cZD7TV00gv5MTiE8tMi8j+ZHLWc2KebfWtsCRKet
X-Google-Smtp-Source: AGHT+IEhqhmi+/uuFz1Fbog5DE/AV1r+HDsD1UwlwkpNuWJf7wobBS9AqtJFN1Xw/CHLkbbpd70bvw==
X-Received: by 2002:a2e:bc0a:0:b0:2d8:4c1d:10fc with SMTP id
 b10-20020a2ebc0a000000b002d84c1d10fcmr1419744ljf.18.1714495816046; 
 Tue, 30 Apr 2024 09:50:16 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a2e9992000000b002d43737e2d7sm4149404lji.30.2024.04.30.09.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:14 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 03/17] xen: mapcache: Refactor lock functions for
 multi-instance
Date: Tue, 30 Apr 2024 18:49:25 +0200
Message-Id: <20240430164939.925307-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22f.google.com
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

Make the lock functions take MapCache * as argument. This is
in preparation for supporting multiple caches.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index b7cefb78f7..3f11562075 100644
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
@@ -394,7 +394,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
         }
     }
     if (!found) {
-        mapcache_unlock();
+        mapcache_unlock(mapcache);
         return RAM_ADDR_INVALID;
     }
 
@@ -409,7 +409,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
         raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
              ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
     }
-    mapcache_unlock();
+    mapcache_unlock(mapcache);
     return raddr;
 }
 
@@ -480,9 +480,9 @@ static void xen_invalidate_map_cache_entry_bh(void *opaque)
 {
     XenMapCacheData *data = opaque;
 
-    mapcache_lock();
+    mapcache_lock(mapcache);
     xen_invalidate_map_cache_entry_unlocked(data->buffer);
-    mapcache_unlock();
+    mapcache_unlock(mapcache);
 
     aio_co_wake(data->co);
 }
@@ -498,9 +498,9 @@ void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
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
 
@@ -512,7 +512,7 @@ void xen_invalidate_map_cache(void)
     /* Flush pending AIO before destroying the mapcache */
     bdrv_drain_all();
 
-    mapcache_lock();
+    mapcache_lock(mapcache);
 
     QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
         if (!reventry->dma) {
@@ -546,7 +546,7 @@ void xen_invalidate_map_cache(void)
 
     mapcache->last_entry = NULL;
 
-    mapcache_unlock();
+    mapcache_unlock(mapcache);
 }
 
 static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
@@ -606,8 +606,8 @@ uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
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
2.40.1


