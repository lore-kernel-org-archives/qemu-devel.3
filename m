Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C832EE7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQif-0003SL-51; Wed, 24 Dec 2025 10:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQiR-0003KZ-3i
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:23:57 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQiO-0004k6-Pq
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:23:54 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b735e278fa1so1059808066b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589831; x=1767194631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2hpwvKk7ET9jTr/WrRA7ZwlKa0SgDvCP9URR6HvV7k=;
 b=rNegk4/s1vPIsyO7zve2kGUKSUsmTPehH1bn1BHZBDzJL40IE7qzv9I0TadB2bKx1O
 00prkafsvvKo1WwVpMwki8L4eiITfluzvo24544V0RypTvD/U31t3LORqzwNg7g/dq6X
 y78wYwXRlUwujPShmaS7prgB/MdQ+OYZTi8PyzhTlAA/qpywr+Qceh5uwn4f1Q2b6kws
 yLu0DP5T3HXP7zyv6htLVuQWhE+q7/m/WjAe4bhyAnG0rI/5mf3b7mfUaiyIwPKYNclD
 vM6/Z2A+VH1WsH8id3xk5aVz9g96cJuN7sfkSZX+BO/3XgJiC8+5iqhWIjcJNvodXKZc
 iogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589831; x=1767194631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P2hpwvKk7ET9jTr/WrRA7ZwlKa0SgDvCP9URR6HvV7k=;
 b=mW2PQgkhZ0/IRyon5MhblxU0vm3q+9AaIkR8JN8hAx+TXR9rwYzqtwJ0HmcfdStfoN
 mNwBjxRxz2b61KfanpTDCxu/oFkCoEbIGoFuf7baZmEBEsj8MqF55GfvfVFXzt3IJqAS
 qhnr2l0nMpMk8a/2rn1tJJrx2jYPvku9Rim4Y6fZvSeSM7zmUE+0Vg8O3uPv70ywlz5Y
 HiVkJnIby7HWIiHeyrBU8oZXROiXuLWmXfWxgbqCXG9ug8jZEDjvdVnf3BwF3Pg5t/72
 7hP2FFwKhmquTR0C3ytDT4a7rBu49am5I9WoUwOkRybwQZ8lOJ7jnjR8J6NEOBO1j+Fw
 nFBQ==
X-Gm-Message-State: AOJu0YxpKeig9t8gSPQCaNip5J0xNfp+ryaPkrvMvABymjFX82qPFFSk
 LA6YmTKU5Fhsy/Kn0s27QBaXFikJlsJWZXtCfGaoCNdjQNb2Iuc028ttU6cMTw+HVhiUTzIx6eZ
 BkHOGg2o=
X-Gm-Gg: AY/fxX4dtgCpg042P2XcR6YYD1ZdFnxZH3wuv0hPYsxSAUyPyAbTyYCub2LQDaG8T0Y
 LdMOn5a0I34HTMX8AKgNb9/UvD+4VZ3ssTG5oVlTXwHO4a+spbex1bJ9yRdgTxDVs6Gqo3VteP+
 UfzZ6jQ4QJrlli0Gnj5OcGblhW7gRkuRb4HdbkTkWTUa+t6S41olXcA4bCXhjBWUSMxBqDhki6z
 bjs+LaYqvTiiZnm2d+eyRYOezOc44gB2IXvF3aHKvip7g+vauXaAo+A49Mnd2DW3M8kH9XX2Llv
 1OS+Yfc5W61kp3ZLEAy/r3Lq87uUxNGMhXfE2j0GYN7ZRJGVUg76BN+2xddZyLZsTsq4DIEXUbS
 b4lwrsqXYv3xPuZ3l7Xy20SPG290poReD1l16kNLVvO//kb80WLZe+3na7Y9oQwTg9gscw8M0jY
 4ljXYTgtYovKPUfyNtGsrwB+4jDOOv35l60Th9e11jKJtLWHP+9ITHzrKWBYNLMEt+y8XlId0=
X-Google-Smtp-Source: AGHT+IGwuxRE0cFlewCnb2clVrH2se/+xqR/0pvYlL0X2yb1bKtPF/rqGqzj6Bxzd7sZQ8UInpYDDg==
X-Received: by 2002:a17:907:7753:b0:b83:1326:7d46 with SMTP id
 a640c23a62f3a-b831326eb32mr147448666b.30.1766589830776; 
 Wed, 24 Dec 2025 07:23:50 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a61595sm1822908766b.8.2025.12.24.07.23.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:23:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 10/25] system/memory: Factor
 address_space_ldst[M]_internal() helper out
Date: Wed, 24 Dec 2025 16:21:53 +0100
Message-ID: <20251224152210.87880-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Keep the pre-existing "warning: addr must be aligned" comment.

We leave the wonder about why we aren't asserting alignment
for later.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


