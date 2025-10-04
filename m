Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F98CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wSe-0003Zd-3F; Sat, 04 Oct 2025 03:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSc-0003ZM-Db
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSa-0004uC-GJ
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:42 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ee1381b835so2597722f8f.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562018; x=1760166818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yTtblsbYPy8BN/aXoznRFWlya17ZOEEH5hAU3DSuYl4=;
 b=zsl/IZwATa7bqOOqF7aJuzg09Bg7Q9Bh1TYg9ctQKjE5BkbJxMvgwZ4AJaaSZJKM5s
 HYwKuP7pzX7EkLCTYImSIjTIv5azOPx/42quCTYnb8jBC+LjC00cscUqJWc5tyNRv1a/
 ujw3f80tpd4npT2feZ3I+J04q37mSqoK2ybVzqoc1+sCjUhFGDvxZEwppxLpuAQFBVUJ
 j32P+1JcsGwwmPzUoqvuzcXue/wBBtlb/vpI9KLCqRVfE9nOTjmeubA9COinhheebxnx
 iJJUQ8ifk9VVitavtgXLyXi8AJ4Tgr02vDQajXTgyF6jCqrYob8d6vBCUTkfI8eF1J7P
 gvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562018; x=1760166818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTtblsbYPy8BN/aXoznRFWlya17ZOEEH5hAU3DSuYl4=;
 b=SnsDrGzcTkkjRj5nN7jYUn/laLl5hWkclHgzXYyZpKUvwC6sqqbLd7lL0Am8RWTcUk
 dvi6wh98b283auUzZUnYvbiPPdU9dPAIbpu+0Jge5M4WUjPK++5vKdSmE+ktf8DjWKpQ
 JlYJQzPHpXgHwZ99NSH0sAeOs72cgH9Wc/OFgE90UCy9NLvDLnixBO1/WpQyZX2+bZ5N
 Axu5xixNX/oNidAbg34qYoqmESbTr83nuIIrheyvuWlVU7zjSoCYMZeJ9oh+T3u+H4lo
 5L6L2K2p19+Pwj+8LJT+fWfm93tXbmjVcsYBzJ4EHnb4wJcjPuDOxbs+RSCuKVdlSqgq
 q+fA==
X-Gm-Message-State: AOJu0Ywojjw2U7AszsGQo4RKUMroe+hprTvVLGA3iyfFwhcwkeO8860K
 48SFapgaNjIOoFvrlDghHKgTvEgZ2JMCSPIgtnIpJu+4Nz6pWm6wLWRP0r1Y8Z3+WEH2MmKPtdi
 G7JbroX+BHw==
X-Gm-Gg: ASbGncsLouoaW4QpvU4uyM0+pDz72smU3Vhd+qXZGhX3eqdG2x0ue4t+2Z9lYZ2zkBO
 VPHrSPgLCGrDV3qmEeYOQtdXfCmk5NkM3ODKsbE7J+/OL21Dz0CDl4j83U7l57d3V0yqFgvcxQi
 brNzo+chxHED1dn7QFQaMeI0qGYqz9K382XRh+a8oLvRDBjUOjJ+f3ZGCYPYrf1Mlu+aJH88vlZ
 gvGIe5ywWPkxfbKJ+LvpxGiCUjSORkEmi2AtJb6CCabD9rUvBNGvdoBqHYmrDVsfbACCeh9R2Fv
 Gp6wTbVty+uY9q9SRZOYuMAfPxq4LYu2ofq7opGLDCH4sTR2rNWXIROVQpsmofKiwf6vKpWsjbo
 ls+sooLfHqAzqto092OxPJXOkg+jpZRj4DKN6SO+cIU8RFDY5RaGslkNaaUoOAiOaCioEe9m4iR
 8ehh5mtmsxAyuplpSR1loC89N1
X-Google-Smtp-Source: AGHT+IHNrxSZUfCkMvjCwKT1ziqarvrRRnwcYcxmKDWIoWbCnSCYzQe4RXKg2/RYyrB1vxt6TTqyRA==
X-Received: by 2002:a5d:64e5:0:b0:3ee:1125:fb6d with SMTP id
 ffacd0b85a97d-425671351ecmr2793758f8f.9.1759562018385; 
 Sat, 04 Oct 2025 00:13:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0846sm11157936f8f.45.2025.10.04.00.13.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:13:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/41] system/memory: Split address_space_write_rom_internal
Date: Sat,  4 Oct 2025 09:12:32 +0200
Message-ID: <20251004071307.37521-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

In 2dbaf58bbe7 we conditionally skipped the increment
of buf because ubsan warns incrementing NULL, and buf
is always NULL for FLUSH_CACHE.  However, the existence
of the test for NULL caused Coverity to warn that the
memcpy in the WRITE_DATA case lacked a test for NULL.

Duplicate address_space_write_rom_internal into the two
callers, dropping enum write_rom_type, and simplify.
This eliminates buf in the flush case, and eliminates
the conditional increment of buf in the write case.

Coverity: CID 1621220
Fixes: 2dbaf58bbe7 ("system/physmem: Silence warning from ubsan")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250922192940.2908002-1-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c | 90 ++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 53 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 1a74e48157b..225ab817883 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3188,63 +3188,33 @@ void cpu_physical_memory_rw(hwaddr addr, void *buf,
                      buf, len, is_write);
 }
 
-enum write_rom_type {
-    WRITE_DATA,
-    FLUSH_CACHE,
-};
-
-static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
-                                                           hwaddr addr,
-                                                           MemTxAttrs attrs,
-                                                           const void *ptr,
-                                                           hwaddr len,
-                                                           enum write_rom_type type)
-{
-    hwaddr l;
-    uint8_t *ram_ptr;
-    hwaddr addr1;
-    MemoryRegion *mr;
-    const uint8_t *buf = ptr;
-
-    RCU_READ_LOCK_GUARD();
-    while (len > 0) {
-        l = len;
-        mr = address_space_translate(as, addr, &addr1, &l, true, attrs);
-
-        if (!memory_region_supports_direct_access(mr)) {
-            l = memory_access_size(mr, l, addr1);
-        } else {
-            /* ROM/RAM case */
-            ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-            switch (type) {
-            case WRITE_DATA:
-                memcpy(ram_ptr, buf, l);
-                invalidate_and_set_dirty(mr, addr1, l);
-                break;
-            case FLUSH_CACHE:
-                flush_idcache_range((uintptr_t)ram_ptr, (uintptr_t)ram_ptr, l);
-                break;
-            }
-        }
-        len -= l;
-        addr += l;
-        if (buf) {
-            buf += l;
-        }
-    }
-    return MEMTX_OK;
-}
-
 /* used for ROM loading : can write in RAM and ROM */
 MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs,
                                     const void *buf, hwaddr len)
 {
-    return address_space_write_rom_internal(as, addr, attrs,
-                                            buf, len, WRITE_DATA);
+    RCU_READ_LOCK_GUARD();
+    while (len > 0) {
+        hwaddr addr1, l = len;
+        MemoryRegion *mr = address_space_translate(as, addr, &addr1, &l,
+                                                   true, attrs);
+
+        if (!memory_region_supports_direct_access(mr)) {
+            l = memory_access_size(mr, l, addr1);
+        } else {
+            /* ROM/RAM case */
+            void *ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
+            memcpy(ram_ptr, buf, l);
+            invalidate_and_set_dirty(mr, addr1, l);
+        }
+        len -= l;
+        addr += l;
+        buf += l;
+    }
+    return MEMTX_OK;
 }
 
-void cpu_flush_icache_range(hwaddr start, hwaddr len)
+void cpu_flush_icache_range(hwaddr addr, hwaddr len)
 {
     /*
      * This function should do the same thing as an icache flush that was
@@ -3256,9 +3226,23 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
         return;
     }
 
-    address_space_write_rom_internal(&address_space_memory,
-                                     start, MEMTXATTRS_UNSPECIFIED,
-                                     NULL, len, FLUSH_CACHE);
+    RCU_READ_LOCK_GUARD();
+    while (len > 0) {
+        hwaddr addr1, l = len;
+        MemoryRegion *mr = address_space_translate(&address_space_memory,
+                                                   addr, &addr1, &l, true,
+                                                   MEMTXATTRS_UNSPECIFIED);
+
+        if (!memory_region_supports_direct_access(mr)) {
+            l = memory_access_size(mr, l, addr1);
+        } else {
+            /* ROM/RAM case */
+            void *ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
+            flush_idcache_range((uintptr_t)ram_ptr, (uintptr_t)ram_ptr, l);
+        }
+        len -= l;
+        addr += l;
+    }
 }
 
 /*
-- 
2.51.0


