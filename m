Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D460D26D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFih-0005ko-VA; Fri, 09 Jan 2026 11:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFif-0005Tr-10
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:52:13 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFic-0007Pv-1T
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:52:12 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so3605365f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977528; x=1768582328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2hpwvKk7ET9jTr/WrRA7ZwlKa0SgDvCP9URR6HvV7k=;
 b=jyaKRc07eaJfFLtJH7w2MMwZjIRWBnSoTbChjwrJ53v1sRYnjWS4BfadWir/1k8H/w
 jErPfdrbZThfcMmV9L5Owa9z4du5EN2nQsgeWdxPRiAjsnn+9bJU9enUwgzJhoa35ceq
 rArriKRj5k7LguoCWX9fNn5j1px2fGyaQ/2WaGjS34q67/qwiX/215Af0OwYzuy0Vasd
 w6lGGfAK0HGxL/oaTtZeH5mvFclzErR+t3PqSv7ScTF0AzcB3BGDcvOL82hk6YPcdGY3
 G2nmORaABMQ7vK4l112aX/RzTY351gt9iZ9+KJh8mySa3ETkJJV3nk/whrdk/PiI9oG5
 49ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977528; x=1768582328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P2hpwvKk7ET9jTr/WrRA7ZwlKa0SgDvCP9URR6HvV7k=;
 b=QMSizugZQLNo6gM6N9MdCHEeHxRavw1eTha5EtTV8q5cSG3IiK4lJmJNO8hKWTjI4a
 Y39fJ+VEUcVOYGOT54VGEnq07rVocPITaWUxvqd80Lq7cOAWEkzZXbd4rALRy8we/gNj
 lDqRLzwZAcW/Ql4bIOaXIflp7p27umjBmdG2KaKuadkoaKZGUf0OxpnY6EkGd+yUeLML
 b2sONgwvxHI2SvwRHq+h5kx7Ft6uOOCopsXhG9acgfVFcmcjMxlItZ6ivLjzxybMvQcN
 X7/MS9krJaWbTnM+73Nedteu2VbVPe60GZZbBHRGvCJ36l5XU87hLpwVCRq+WWGQHSMZ
 s36w==
X-Gm-Message-State: AOJu0YwwOLmGY4zXcAah1GS2nqD8Iv4AF0qozL2qOTqRqTXIEM+I4snW
 lmuJY+gOornzXjrmPRDSRIshEOckoaZMuq7v4EBf06AoGSk7TW49J1NOqp178tB47+jqgxK5Q8k
 kv++K/Y4=
X-Gm-Gg: AY/fxX6zNrYbcuwuaTOPuo1jQowMgocwZNq833spgsmocyii7/YDcaz2+ah66CK1x+J
 syT+ctq0GTlW7e5gifSdc6TkNir2PeD+L6i30CA5E9jWXkQ0VnlNzeh0f/1UxkMfynkaVVjbw4w
 ZNN4ZdSiw+C1ptHYMpNjy0HoyPZtA8Vxsp0ylz9GXCNLwTNpU61sNf17VJiQx86j7O5iTtM13FD
 jvGel+mLTr1JfIZL3LFXM9i1Z/NF1gir9pLWhsN4JQrUM2Ox9wv7l9Y7viH+f+6SQ/oKpji9rek
 m22DH3TXTHJbsm1wGBqF3XASRDOfVuv68HurLpPgthyMBnsho+N5Ci18kzpqJLN0qhvG9AVSgJb
 pQ7UvVzscjrS5fnFir2y8BlQSZlBHkzp7uAVZ42VBJiYIbq+5yQy4YvJCDDo+Hl8a3C/Z6xEly0
 Pye1I9VMvtq7rbFjeOyxLdte7H7lQeGMbU+DhilxRtwxxN85N8I26wrGPYRPvy
X-Google-Smtp-Source: AGHT+IF/piKJV5mnJ8p5x4vhyUSpwS9HINkkkJTbRWc4wNfN3tiVu90pcQE+zmlV3gdIgj2aImBPYg==
X-Received: by 2002:a05:6000:40dd:b0:431:2ff:1289 with SMTP id
 ffacd0b85a97d-432c3790856mr12345362f8f.16.1767977527697; 
 Fri, 09 Jan 2026 08:52:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df96asm22966146f8f.28.2026.01.09.08.52.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:52:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 10/22] system/memory: Factor
 address_space_ldst[M]_internal() helper out
Date: Fri,  9 Jan 2026 17:50:46 +0100
Message-ID: <20260109165058.59144-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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


