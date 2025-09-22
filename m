Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEAFCA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0mEW-0005E8-Aw; Mon, 22 Sep 2025 15:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0mET-0005Cp-LS
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 15:29:53 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0mEM-0002Qm-S6
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 15:29:52 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3304a57d842so3416222a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758569383; x=1759174183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W6jjoifMhsz3D5D+KPnArq2qaNpW1k7zris8SQE/uuE=;
 b=Msw9mLaBUbmd9hAaT4IQhDLfZ2Y+3ioNDV+ppYYVUaTfX7CXzq7UXOY7uTXnswdVwX
 BzIaYh7aPVbPf7ZiYNQsrq8iO+CaLEwNfkrV7xC7rrPCWJavOeVImxuVGbwaxX8JdO33
 nyi7SimNe4BqqbfesubETs6FMxaevV7BpwCdsweHpvk1S5Lz4oqEo5zqcvKfB8ZdWnIM
 4pohqDpMCFhGtnAMCOAVmra8YIU03/xuP6BTQH7Jz531L5FaZj5s+icZlDn9Cp5aEF8V
 ZcoJUnECaf7A5Bq5JN2IXwXSNj49NsQ7dJ0U551scSyxrA+DIVg9YIADjtizxS77684r
 T0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758569383; x=1759174183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W6jjoifMhsz3D5D+KPnArq2qaNpW1k7zris8SQE/uuE=;
 b=cTz2zN1ulOOCzMZsAkSmC9zrRWAfGpcVIyNDAQfufhyXHxKbDTJGNsG36Ft820DUp0
 +Cw4G4vCCaI2Z6eVMhOxwllsAcoE3qHVj/DEcVIUpyvc2ou0mF+zvy63WSVXmCvXLYOF
 MPfFaXkxEI3TsaMPlvCIsz+qTIbo1u1pgdTTLoYMrJI4ucEhwY6NFskd7wFoLS6KVn+P
 VzVi9TpcqFoJNeExiwXuIfN9ISgv9xmkAS3kQarxUGpXYqWPxJ+Bvgy1xlQ9Kqgu6eK5
 7h1swh9D7R9AqZ/babob+8o7h+sDWccOQ341aJCpsgmre6k84CZ8zlHtj4V3WyrydMFP
 zw5A==
X-Gm-Message-State: AOJu0Yxskt5nB7WE/aLQHLypHGrZC0+R89M5DmnpghzH+B8H0Kph8HOW
 01bq8nOz62/B4RvqaMqxeBJ9UQR74t+a4Ga3DM0YDGUzfoCO58XtSG2VqUes4wvQv3d2SVxfSw0
 xTSBB
X-Gm-Gg: ASbGnct4SZGe+XMes63SATyHxT0Qfisffq/Y8l+7on5ErxQwBEygzADrZzyytrUbuAa
 VquO0AGlzQmxS+s6CmaDEORq38oH0PzIpvlCNfV/kAZSjRqFByTL3yb/3i2reJjJCUe2pm1xMMG
 WHs81IRr2P+qvGGwlqJeLjV2KH8DddIcmtX6chSv+r9IIjJhsE6uYqHhzeExkE1VmR9cptF8NcU
 yF+awp2F9RIY8oCfLw9Qj052/5bogal4uVQdJhgbH1vA2T7z2xRz1TrS0sdRsjFQxPbdQRAF54l
 M9brIckh8T1Wse97ThGtE5Q82QUxy99uWcpqXqs/+76StURRTAI63RekvDOeYo+OZIySV2HGjGH
 MGAo9m8ekCNYkicl4awX2SQgMLltPQEQt+Apk/wo=
X-Google-Smtp-Source: AGHT+IGZ0M6fDfwbMFyO67/SWh6p+PNblSW8J/Xw58ZsOogfKpU7enbRycakzrurRahws47IlrG89A==
X-Received: by 2002:a17:90b:4ac1:b0:32e:3830:65d5 with SMTP id
 98e67ed59e1d1-332a96fd8c1mr66577a91.36.1758569382286; 
 Mon, 22 Sep 2025 12:29:42 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f335995cbsm4490399b3a.63.2025.09.22.12.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 12:29:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH] system/memory: Split address_space_write_rom_internal
Date: Mon, 22 Sep 2025 12:29:40 -0700
Message-ID: <20250922192940.2908002-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
---
 system/physmem.c | 90 ++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 53 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index ae8ecd50ea..5f76a5f767 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3187,63 +3187,33 @@ void cpu_physical_memory_rw(hwaddr addr, void *buf,
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
@@ -3255,9 +3225,23 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
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
2.43.0


