Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB31AC25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xdQ-0000K4-QM; Mon, 06 May 2024 08:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdO-0008O7-KY
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:58 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdA-0002En-Vt
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:58 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41dc9c83e57so23343225e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999183; x=1715603983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2FxlBjDJOEbHnMQ/UhA0SxKIT6u4WalO0XGgQNG39go=;
 b=fIuKLwAKU0c9zePIgoR/vAw5s4yRUeaG84yOtI7lHYSAo1qdrZfNbemgnrjD4ybGe/
 +1l4lxxKP1ACCf0Px00xLOFM2HZHCnPRrc+LqIunaK0VP+Sl/KEQq2u2aTlzf6pQ8xcI
 a+Et/gGTLjAHgn7v83oUhKi8NyNg8IlZzxTdDjHmfZTsgxlrv+AOzr2QTFcfRoeoVHrb
 5Dax7BeiYt+b9RE7Ss2mnidEZmVjIe142yLWQcHJpgswg0wsIyRdCYQXkSzOGm9Rraei
 NR1X1QMP1xuz4lJ1938ulrwk5lRupPjFyWGodPX5Vit7mTfcMMSC5VvE6olsQJ/AaUiA
 /MRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999183; x=1715603983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2FxlBjDJOEbHnMQ/UhA0SxKIT6u4WalO0XGgQNG39go=;
 b=Rba3F6U6Jp1dF32+s19F6LHNjkErtIEjYHFYeOgM3M+I1S61gy7Gctmv+KB8y0d4IO
 O1o88DXwE8VaiD8aCKpMdPrapwxEaEE7TY7HYjmOwethzdHYVf27V4LPD1wJd3ytXLh0
 +WI9VsZLdiYWoVuYiU5TvO7rsDmE5nNwV3WoKjEKs2Bvgpr/PGwlDykkNH7APdsS0Zxe
 QgMJDnftGbMj+5O8dTZAckKs7eGgApPcPX67Wwg7tJMneplVmS1w/jjO4kYaYefcGBho
 CSsorA+YGbJUdQ+mzyUVd2kRVANT/NTxFHoqqg19PrvXSz91EIvfgXegUEi29aNa3XMj
 5SDA==
X-Gm-Message-State: AOJu0YwgNOXkdzWm+mMFyO9MDcouZrlrESv1eOjL9BoNf8oGri70RK/N
 AEBJOFF+WZQOZ4xT9rtw4rpGHq4+5bR4uL4kZIwJJxWeLuUmkgnLuIhE2Pzu2skxlvC/GB1W/jE
 I
X-Google-Smtp-Source: AGHT+IGGhcuANiUPVKeCT+Rmh4gFXxUsw7t9mo79ygZxjsZ6V0jS1QXmyAscfvdNJEsYRvnu9g4f2A==
X-Received: by 2002:a05:600c:3c9e:b0:418:3ea8:46c0 with SMTP id
 bg30-20020a05600c3c9e00b004183ea846c0mr11560331wmb.13.1714999183232; 
 Mon, 06 May 2024 05:39:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 m9-20020a05600c4f4900b0041bf7da4200sm16063851wmq.33.2024.05.06.05.39.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:39:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>
Subject: [PULL 19/28] xen: mapcache: Refactor xen_map_cache for multi-instance
Date: Mon,  6 May 2024 14:37:19 +0200
Message-ID: <20240506123728.65278-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <20240430164939.925307-5-edgar.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-mapcache.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index c27be6abee..9e0a56b41b 100644
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
2.41.0


