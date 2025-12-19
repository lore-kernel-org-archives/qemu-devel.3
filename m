Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE08D7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdEY-0000GJ-7g; Fri, 19 Dec 2025 11:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEF-0008Cy-KV
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:21:22 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEC-000651-Uv
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:21:19 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so13016095e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161275; x=1766766075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=meXF2SK9eIlreaRt7/f1ZyEA/D/whrGmhDsoxwqaW8A=;
 b=LM7SnO0l7I9YvaNc4AoQz56EoqM8//25wUqnmaJ1ET3vBsRPFCraKcik5iKDydVyxw
 8vAgdHtCL/zTth+KnYwjxyZ3zxjtBCLkG+1mTMavpRJ4Z93k7wfWCb1062MIA4yHKIuQ
 IDxWwKHNMfCvPq4zn6PN2WRNtL24/I+aYPZvPeNhr8RnIagf2eCNQ7oPum7PMj1tKnHZ
 ywzYVSnBwB7qAxhlui0GJjd2AFWkRG/VmIcLjtCuO15GP6i/2prqUs19VZdUPx+DXmjQ
 2F4+xdTdl16adQ8aneLWHmaLJ+SpLyx8DNsy3TVBM5cbBA0ADNiKuaqWW19StSY5D1tX
 PeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161275; x=1766766075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=meXF2SK9eIlreaRt7/f1ZyEA/D/whrGmhDsoxwqaW8A=;
 b=VX6+Lc2P9YJCD2LjNrD8ImW2eIOUVU35fN9ne19APkjzmtU+kVIddamoGvkh/HIpEC
 RRdsrtr7fa+TJLQS0j33uSwtaHybHP/Wg0iMd9RnVZYXiNKP/q5W6gh3A4w93EDsBBb0
 hBJ7ghw68J5n0kSO974lzQgqRnh257cEjnX/JKZCGDP1bL45SupQsxOqZVLlbCaTLQK5
 6ANlHiIdbt8TWX4L90q+j2fFtchcDHwROfBAbGzpo2nIkchQNQr4c3mvQg4sR+oLYLb2
 z9LiSmIvxR5hanCAesn/Kd1kCDN/d2y1JYc1gKqD4OeDL7hBCudnvcVZwrMzVJcyrvDf
 O3iw==
X-Gm-Message-State: AOJu0YykHIIDKTxmG0VUCAOG/d2RoYrIIDAcK47rHbrZ5FcZE9PCbPrn
 EH2zWlSr0HzmsijV9kEC/TRAGpaZmkskFZHFGdO7jpJ8694QacYn0lpnaayomOdIRjN73yjakFP
 Wzbg6OwM=
X-Gm-Gg: AY/fxX5p4SLGeH5WMsI09bqQ8MJGUTbZnXlamwwEVu7uxsVlHqKmLFwO2vTTcD3yMUy
 s6d5rtWr3JKFGpAQxNTzFOIiT3eQpNiEdQYamNMybfbBS7C5PGTS5DP6atoWWDYXZGfBl93WFNP
 0kjiBgUb7XT+Hoj//AcwEEoCvOZCBrPtnl1xhBD9qxtkP64LWkG8fs+Ea7ncUgT2ufkVsTrDZEU
 7gxIrAV22WJxNyorW+2qMLoOTR/5IzVrzZWzbsq3J5GlKQvrP43KCTZW90rNkoKHtdYSGB04tAF
 eEEm/f7ohraI0QOjtXHC404EerarytX/72y1LwGbIgBiky+EM4WORqmNTvIvxQi6vTksbBsYO3d
 K1hDbi+lwmSM8oa5hdFxr7yin6sHJJzzVzHNjxazE29YNcKYZa8/ZYox7hNrcdwqqQeVtwzu3Qf
 YxEFGqc37KNwjRAvnoWmlH9jzTAW4+xnBz0bwZ32vbnfnImjF5IryxvD81jsMo
X-Google-Smtp-Source: AGHT+IF/LR04t+O/Rf1khTdrFK3fGvADUcKocP4ZAwpHuUKbvVZqC+NN8jvyuKTaU1qSf/FUB4RXlg==
X-Received: by 2002:a05:600c:1d1d:b0:477:a21c:2066 with SMTP id
 5b1f17b1804b1-47d19532f48mr32874365e9.5.1766161274782; 
 Fri, 19 Dec 2025 08:21:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea8311fsm5727634f8f.28.2025.12.19.08.21.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:21:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/24] system/memory: Factor
 address_space_ldst[M]_internal() helper out
Date: Fri, 19 Dec 2025 17:19:38 +0100
Message-ID: <20251219161953.72724-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

All the LD/ST[W,L,Q] variants use the same template, only
modifying the access size used. Unify as a single pair of
LD/ST methods taking a MemOp argument. Thus use the 'm'
suffix for MemOp.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Do we know why this warning is here?
Do we know why we aren't asserting alignment?

It makes me wonder if the ldn_*_p above shouldn't be qatomic_ld.
And more so for the stores.

But that's an existing problem, not new with the refactor
---
 system/memory_ldst.c.inc | 298 +++++++++------------------------------
 1 file changed, 63 insertions(+), 235 deletions(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 823fc3a7561..39b3930bf50 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -20,39 +20,43 @@
  */
 
 /* warning: addr must be aligned */
-static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
-    enum device_endian endian)
+static inline
+uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
+                                                  hwaddr addr,
+                                                  MemTxAttrs attrs,
+                                                  MemTxResult *result,
+                                                  enum device_endian endian)
 {
+    const unsigned size = memop_size(mop);
     uint8_t *ptr;
     uint64_t val;
     MemoryRegion *mr;
-    hwaddr l = 4;
+    hwaddr l = size;
     hwaddr addr1;
     MemTxResult r;
     bool release_lock = false;
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (l < 4 || !memory_access_is_direct(mr, false, attrs)) {
+    if (l < size || !memory_access_is_direct(mr, false, attrs)) {
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
         r = memory_region_dispatch_read(mr, addr1, &val,
-                                        MO_32 | devend_memop(endian), attrs);
+                                        mop | devend_memop(endian), attrs);
     } else {
         /* RAM case */
-        fuzz_dma_read_cb(addr, 4, mr);
+        fuzz_dma_read_cb(addr, size, mr);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
         case DEVICE_LITTLE_ENDIAN:
-            val = ldl_le_p(ptr);
+            val = ldn_le_p(ptr, size);
             break;
         case DEVICE_BIG_ENDIAN:
-            val = ldl_be_p(ptr);
+            val = ldn_be_p(ptr, size);
             break;
         default:
-            val = ldl_p(ptr);
+            val = ldn_p(ptr, size);
             break;
         }
         r = MEMTX_OK;
@@ -67,87 +71,30 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
     return val;
 }
 
+/* warning: addr must be aligned */
+static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
+    enum device_endian endian)
+{
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_32, addr,
+                                                    attrs, result, endian);
+}
+
 /* warning: addr must be aligned */
 static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
     enum device_endian endian)
 {
-    uint8_t *ptr;
-    uint64_t val;
-    MemoryRegion *mr;
-    hwaddr l = 8;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (l < 8 || !memory_access_is_direct(mr, false, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
-
-        /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val,
-                                        MO_64 | devend_memop(endian), attrs);
-    } else {
-        /* RAM case */
-        fuzz_dma_read_cb(addr, 8, mr);
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
-            val = ldq_le_p(ptr);
-            break;
-        case DEVICE_BIG_ENDIAN:
-            val = ldq_be_p(ptr);
-            break;
-        default:
-            val = ldq_p(ptr);
-            break;
-        }
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        bql_unlock();
-    }
-    RCU_READ_UNLOCK();
-    return val;
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_64, addr,
+                                                    attrs, result, endian);
 }
 
-uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL, hwaddr addr,
+                                         MemTxAttrs attrs, MemTxResult *result)
 {
-    uint8_t *ptr;
-    uint64_t val;
-    MemoryRegion *mr;
-    hwaddr l = 1;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (!memory_access_is_direct(mr, false, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
-
-        /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, MO_8, attrs);
-    } else {
-        /* RAM case */
-        fuzz_dma_read_cb(addr, 1, mr);
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        val = ldub_p(ptr);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        bql_unlock();
-    }
-    RCU_READ_UNLOCK();
-    return val;
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_8, addr,
+                                                    attrs, result,
+                                                    DEVICE_NATIVE_ENDIAN);
 }
 
 /* warning: addr must be aligned */
@@ -155,37 +102,47 @@ static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
     enum device_endian endian)
 {
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_16, addr,
+                                                    attrs, result, endian);
+}
+
+/* warning: addr must be aligned */
+static inline
+void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
+                                              hwaddr addr, uint64_t val,
+                                              MemTxAttrs attrs,
+                                              MemTxResult *result,
+                                              enum device_endian endian)
+{
+    const unsigned size = memop_size(mop);
     uint8_t *ptr;
-    uint64_t val;
     MemoryRegion *mr;
-    hwaddr l = 2;
+    hwaddr l = size;
     hwaddr addr1;
     MemTxResult r;
     bool release_lock = false;
 
     RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (l < 2 || !memory_access_is_direct(mr, false, attrs)) {
+    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
+    if (l < size || !memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
-
-        /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val,
-                                        MO_16 | devend_memop(endian), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val,
+                                         mop | devend_memop(endian), attrs);
     } else {
         /* RAM case */
-        fuzz_dma_read_cb(addr, 2, mr);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
         case DEVICE_LITTLE_ENDIAN:
-            val = lduw_le_p(ptr);
+            stn_le_p(ptr, size, val);
             break;
         case DEVICE_BIG_ENDIAN:
-            val = lduw_be_p(ptr);
+            stn_be_p(ptr, size, val);
             break;
         default:
-            val = lduw_p(ptr);
+            stn_p(ptr, size, val);
             break;
         }
+        invalidate_and_set_dirty(mr, addr1, size);
         r = MEMTX_OK;
     }
     if (result) {
@@ -195,7 +152,6 @@ static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
         bql_unlock();
     }
     RCU_READ_UNLOCK();
-    return val;
 }
 
 /* warning: addr must be aligned */
@@ -203,74 +159,16 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs,
     MemTxResult *result, enum device_endian endian)
 {
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 4;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 4 || !memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val,
-                                         MO_32 | devend_memop(endian), attrs);
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
-            stl_le_p(ptr, val);
-            break;
-        case DEVICE_BIG_ENDIAN:
-            stl_be_p(ptr, val);
-            break;
-        default:
-            stl_p(ptr, val);
-            break;
-        }
-        invalidate_and_set_dirty(mr, addr1, 4);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        bql_unlock();
-    }
-    RCU_READ_UNLOCK();
+    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_32, addr, val,
+                                             attrs, result, endian);
 }
 
-void glue(address_space_stb, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result)
+void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
+                                     MemTxAttrs attrs, MemTxResult *result)
 {
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 1;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (!memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val, MO_8, attrs);
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        stb_p(ptr, val);
-        invalidate_and_set_dirty(mr, addr1, 1);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        bql_unlock();
-    }
-    RCU_READ_UNLOCK();
+    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_8, addr, val,
+                                             attrs, result,
+                                             DEVICE_NATIVE_ENDIAN);
 }
 
 /* warning: addr must be aligned */
@@ -278,86 +176,16 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint16_t val, MemTxAttrs attrs,
     MemTxResult *result, enum device_endian endian)
 {
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 2;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 2 || !memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val,
-                                         MO_16 | devend_memop(endian), attrs);
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
-            stw_le_p(ptr, val);
-            break;
-        case DEVICE_BIG_ENDIAN:
-            stw_be_p(ptr, val);
-            break;
-        default:
-            stw_p(ptr, val);
-            break;
-        }
-        invalidate_and_set_dirty(mr, addr1, 2);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        bql_unlock();
-    }
-    RCU_READ_UNLOCK();
+    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_16, addr, val,
+                                             attrs, result, endian);
 }
 
 static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs,
     MemTxResult *result, enum device_endian endian)
 {
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 8;
-    hwaddr addr1;
-    MemTxResult r;
-    bool release_lock = false;
-
-    RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 8 || !memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val,
-                                         MO_64 | devend_memop(endian), attrs);
-    } else {
-        /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
-            stq_le_p(ptr, val);
-            break;
-        case DEVICE_BIG_ENDIAN:
-            stq_be_p(ptr, val);
-            break;
-        default:
-            stq_p(ptr, val);
-            break;
-        }
-        invalidate_and_set_dirty(mr, addr1, 8);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        bql_unlock();
-    }
-    RCU_READ_UNLOCK();
+    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_64, addr, val,
+                                             attrs, result, endian);
 }
 
 #define ENDIANNESS
-- 
2.52.0


