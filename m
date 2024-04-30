Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D42EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qgn-0007BU-5o; Tue, 30 Apr 2024 12:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgW-0006Hb-0I
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:33 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgO-00061W-3l
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:26 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2dac77cdf43so75645201fa.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495818; x=1715100618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRQG1XAsOj2ShCk3Z8R9KMtS/JhvbfkQx/NMqL6gExE=;
 b=EKM35OAFJXEY/g+jP9YcjXauR+8VkQGvxY9Pt2kxrd0ek1BoAixxN57DyeMyeMqQkU
 tJsksAb8giPDinmHXRfHIqpxR43yT+hCNgdFiaD3u1sZvr6SK4uI+vh5wmEy9iGINccj
 Z+Cs8PrY2vw02XRg7LPpgPqzmWpgiR0xA8dc3AzFWqzyD2ZaysQwJZgSXhaEMI6TKiH8
 O/UuyjEKlIpYgFKCUG50yzG5g7wX814Yfztk2UUyj/XRsmJL0djVAIFsL0Xm1tP/syNP
 XyD3HKCTvUOCxuvBiRPHPvEBN8nlY4X86acbYSeXzpoc9zM+IV1by2NPyBiLe5BiXp4x
 LwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495818; x=1715100618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRQG1XAsOj2ShCk3Z8R9KMtS/JhvbfkQx/NMqL6gExE=;
 b=dCPbVn+/wKo0eWpuTIcowsJjT8U52GEjrDBN3ATRpl383S57dLqRpK0FZodSb+tmrV
 fQtW/XPqnjBDBswf9PR9HctpUtUANSg3vpKM9NBsGb1AuQ+JUxayQ5niUzdB7SBbCsZk
 sLKYikPOPnCc6mk0RIdPFY5yUqnpl7ruai8gmRa1fBcijABru+J6Y05M/2YpJGhoqyXx
 P2wz+jjUdIdnea5EYYuhxY89cjEV4kNrouAVk30WxkSvffyAmcaTCdMfX9shKhEoEu3v
 xUKhOqavBzJsrl2Icwhpo05LUvxPqREZLpgtBoUbxP/7+ddDoMXoWYbgTsZJlIDyktC3
 xupQ==
X-Gm-Message-State: AOJu0YxyHcyaLZdzDfIHDFPdyy6KOpnBhwDk6E8fUrr1hoN8Hf7xZLNO
 uhuTg6mo3vNFuCOhc2VzDV/CIqmSQNjdyNYVCLX8yv9BHJE251o2IUNhneOR
X-Google-Smtp-Source: AGHT+IE34gVM99Avj5+WmVE3KuiSoituQU+AW25n3ZdTsIBUm8HTeWHDkI6iQxAgmbV9XWek/HUgxw==
X-Received: by 2002:a2e:9516:0:b0:2d8:63a2:50d2 with SMTP id
 f22-20020a2e9516000000b002d863a250d2mr213248ljh.6.1714495817622; 
 Tue, 30 Apr 2024 09:50:17 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 b20-20020a2e8954000000b002de1f99164csm2505323ljk.59.2024.04.30.09.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:16 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 04/17] xen: mapcache: Refactor xen_map_cache for
 multi-instance
Date: Tue, 30 Apr 2024 18:49:26 +0200
Message-Id: <20240430164939.925307-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22b.google.com
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

Make xen_map_cache take a MapCache as argument. This is in
prepaparation to support multiple map caches.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 3f11562075..896021d86f 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -240,7 +240,8 @@ static void xen_remap_bucket(MapCacheEntry *entry,
     g_free(err);
 }
 
-static uint8_t *xen_map_cache_unlocked(hwaddr phys_addr, hwaddr size,
+static uint8_t *xen_map_cache_unlocked(MapCache *mc,
+                                       hwaddr phys_addr, hwaddr size,
                                        uint8_t lock, bool dma)
 {
     MapCacheEntry *entry, *pentry = NULL,
@@ -269,16 +270,16 @@ tryagain:
         test_bit_size = XC_PAGE_SIZE;
     }
 
-    if (mapcache->last_entry != NULL &&
-        mapcache->last_entry->paddr_index == address_index &&
+    if (mc->last_entry != NULL &&
+        mc->last_entry->paddr_index == address_index &&
         !lock && !size &&
         test_bits(address_offset >> XC_PAGE_SHIFT,
                   test_bit_size >> XC_PAGE_SHIFT,
-                  mapcache->last_entry->valid_mapping)) {
+                  mc->last_entry->valid_mapping)) {
         trace_xen_map_cache_return(
-            mapcache->last_entry->vaddr_base + address_offset
+            mc->last_entry->vaddr_base + address_offset
         );
-        return mapcache->last_entry->vaddr_base + address_offset;
+        return mc->last_entry->vaddr_base + address_offset;
     }
 
     /* size is always a multiple of MCACHE_BUCKET_SIZE */
@@ -291,7 +292,7 @@ tryagain:
         cache_size = MCACHE_BUCKET_SIZE;
     }
 
-    entry = &mapcache->entry[address_index % mapcache->nr_buckets];
+    entry = &mc->entry[address_index % mc->nr_buckets];
 
     while (entry && (lock || entry->lock) && entry->vaddr_base &&
             (entry->paddr_index != address_index || entry->size != cache_size ||
@@ -326,10 +327,10 @@ tryagain:
     if(!test_bits(address_offset >> XC_PAGE_SHIFT,
                 test_bit_size >> XC_PAGE_SHIFT,
                 entry->valid_mapping)) {
-        mapcache->last_entry = NULL;
+        mc->last_entry = NULL;
 #ifdef XEN_COMPAT_PHYSMAP
-        if (!translated && mapcache->phys_offset_to_gaddr) {
-            phys_addr = mapcache->phys_offset_to_gaddr(phys_addr, size);
+        if (!translated && mc->phys_offset_to_gaddr) {
+            phys_addr = mc->phys_offset_to_gaddr(phys_addr, size);
             translated = true;
             goto tryagain;
         }
@@ -342,7 +343,7 @@ tryagain:
         return NULL;
     }
 
-    mapcache->last_entry = entry;
+    mc->last_entry = entry;
     if (lock) {
         MapCacheRev *reventry = g_new0(MapCacheRev, 1);
         entry->lock++;
@@ -352,16 +353,16 @@ tryagain:
             abort();
         }
         reventry->dma = dma;
-        reventry->vaddr_req = mapcache->last_entry->vaddr_base + address_offset;
-        reventry->paddr_index = mapcache->last_entry->paddr_index;
+        reventry->vaddr_req = mc->last_entry->vaddr_base + address_offset;
+        reventry->paddr_index = mc->last_entry->paddr_index;
         reventry->size = entry->size;
-        QTAILQ_INSERT_HEAD(&mapcache->locked_entries, reventry, next);
+        QTAILQ_INSERT_HEAD(&mc->locked_entries, reventry, next);
     }
 
     trace_xen_map_cache_return(
-        mapcache->last_entry->vaddr_base + address_offset
+        mc->last_entry->vaddr_base + address_offset
     );
-    return mapcache->last_entry->vaddr_base + address_offset;
+    return mc->last_entry->vaddr_base + address_offset;
 }
 
 uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
@@ -370,7 +371,7 @@ uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
     uint8_t *p;
 
     mapcache_lock(mapcache);
-    p = xen_map_cache_unlocked(phys_addr, size, lock, dma);
+    p = xen_map_cache_unlocked(mapcache, phys_addr, size, lock, dma);
     mapcache_unlock(mapcache);
     return p;
 }
-- 
2.40.1


