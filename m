Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00807D7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdEb-0000ZR-V5; Fri, 19 Dec 2025 11:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEM-0008Nw-3p
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:21:31 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEK-00065v-3R
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:21:25 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso20177945e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161282; x=1766766082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UFVhD8dczJbMkx90KKbndfFREu2le89IhK/CmXUoOhk=;
 b=YGqGKDJiFElxx1Ee34QGS+q3NX2RcqwPfCk3eqNr9HX4sF6S+MNDRmzsbecQeQTx5h
 49S/d0+2LUG9vtKBA/asTQRpsp2YQfCPGoENw4L2+GRFl2EywYXLvM46A69oATJqdDe/
 XmMA52WU9N/VvHQMJ6ilmrmOzMTai0Ct5If7byzq9FVsivNlc+wdnnBfUQUyTJgnonXx
 I8ktk25/m1V5BKPDCzQ5uljeZD8NBPbJLvI9P5IPvzjbcdqeJW1UJ4wIu5OAy6Tj+ZEP
 00fSxdRSvZ+MLAJN7Rk4aduYVHDbImsiKJUe0qurA7+FTLy4PfV2qi4b0iFPPK9vDPAS
 fyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161282; x=1766766082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UFVhD8dczJbMkx90KKbndfFREu2le89IhK/CmXUoOhk=;
 b=Shap/abBAL2z0O4GoYFn7eU5OoRz9xvE9ko8eQvqbT4UzjLFT9vVjHOUoKOg4kcVbk
 ye96NFF8xvQ2CIgwBklG1md+d9/fXb7Eqsc1BA1qSoJQCMOUk8V2EodwbKidUGUHA4OR
 wcJIfC+zXP9/vm3XWvBliYcOO7VZRN9z4oh//jzCIo3xDvWVsu2+irZtJWarQGB+buTQ
 TPtdX7cEbCuyDs+6v61aUOfY36dGMd/4CnXy78qzdT9oBn5XgUdTNdrhle+Q814qvxkh
 T+M5LDg9Zc1vA4orG6dBjJSQQTlhGxgFbx1DchInDAKVAunS3f2/ZUofFt2db3x3+WYk
 qWIA==
X-Gm-Message-State: AOJu0Yy2BgrbHv2PfNvOD6q882IoaX8tDA2aEC4q0u8Sog9pBI0vrKVX
 dy3HbiyI8LqhhMEs/ufL+dFm6bQcit+6L4Qlrh2kV5FXT4KQ7Su8X5JciY4/LUOFibKptZdOQ83
 bwN1ktFxLGA==
X-Gm-Gg: AY/fxX4WmN+OjAcPYcAn9t/x3Q7AaZ5+XMAB0wq/snQdf/RWEBB0l8pUzN2BqVmQGYY
 oY9SffC58fybYIqdUD5M/MxyIn6GzkXOoD2UKdPpi836Kh2m/xzdWgLiFRcTHOmfptIz3+M7zUw
 IZ2KmzM8G5NX/ebHO4YNLdLUH6/50Xs5LB2anU5yaMxMeANf4Wlr2fFX2iIIagY4B6ACu//qwoO
 ZLBWx1mUCznMvlKBB7h3/tUyzzRETCcIkqTssRb0MVYD9dufHgkto9E49axcJhXNxi+6aiZ+n0R
 ua+HPCwOzw77Tb1uXZcg0B3C9fKkojjj4BbjtgU8MtUKrmdpr/f/EfkDwZMV0E/+xhhuZzgH6jS
 yru7VNKXVTGT3l8bfC722kBUBBthzsVha/r5pPMQG8r0PetOpLypCVA6YLfz60mQidhdSd6Ad7p
 uV2IVXUy8IrKkM3acJqX0p1wuHsjKoBfFJ6FyfYKu4x5KAVq70YKMv8KTNGW5y
X-Google-Smtp-Source: AGHT+IFInvATHQk8OIVGXuZdZzuDvoU8kdb3BZAceJGzHXH8e9qRWxSmEg92s6evfXkodD8PmujgSw==
X-Received: by 2002:a05:600c:198d:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-47d195a06a0mr31651375e9.27.1766161281999; 
 Fri, 19 Dec 2025 08:21:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a33c1csm42897205e9.1.2025.12.19.08.21.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:21:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/24] system/memory: Pass device_endian argument as MemOp
 bit
Date: Fri, 19 Dec 2025 17:19:39 +0100
Message-ID: <20251219161953.72724-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

Use the MemOp argument to hold both the access size and
its endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/memory_ldst.c.inc        | 86 ++++++++++++---------------------
 system/memory_ldst_endian.c.inc | 26 +++++-----
 2 files changed, 44 insertions(+), 68 deletions(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 39b3930bf50..5c8299e0cdc 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -24,8 +24,7 @@ static inline
 uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
                                                   hwaddr addr,
                                                   MemTxAttrs attrs,
-                                                  MemTxResult *result,
-                                                  enum device_endian endian)
+                                                  MemTxResult *result)
 {
     const unsigned size = memop_size(mop);
     uint8_t *ptr;
@@ -42,22 +41,15 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val,
-                                        mop | devend_memop(endian), attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, mop, attrs);
     } else {
         /* RAM case */
         fuzz_dma_read_cb(addr, size, mr);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
+        if ((mop & MO_BSWAP) == MO_LE) {
             val = ldn_le_p(ptr, size);
-            break;
-        case DEVICE_BIG_ENDIAN:
+        } else {
             val = ldn_be_p(ptr, size);
-            break;
-        default:
-            val = ldn_p(ptr, size);
-            break;
         }
         r = MEMTX_OK;
     }
@@ -73,37 +65,33 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
 
 /* warning: addr must be aligned */
 static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
-    enum device_endian endian)
+    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_32, addr,
-                                                    attrs, result, endian);
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_32, addr,
+                                                    attrs, result);
 }
 
 /* warning: addr must be aligned */
 static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
-    enum device_endian endian)
+    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_64, addr,
-                                                    attrs, result, endian);
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_64, addr,
+                                                    attrs, result);
 }
 
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL, hwaddr addr,
                                          MemTxAttrs attrs, MemTxResult *result)
 {
     return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_8, addr,
-                                                    attrs, result,
-                                                    DEVICE_NATIVE_ENDIAN);
+                                                    attrs, result);
 }
 
 /* warning: addr must be aligned */
 static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
-    enum device_endian endian)
+    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_16, addr,
-                                                    attrs, result, endian);
+    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_16, addr,
+                                                    attrs, result);
 }
 
 /* warning: addr must be aligned */
@@ -111,8 +99,7 @@ static inline
 void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
                                               hwaddr addr, uint64_t val,
                                               MemTxAttrs attrs,
-                                              MemTxResult *result,
-                                              enum device_endian endian)
+                                              MemTxResult *result)
 {
     const unsigned size = memop_size(mop);
     uint8_t *ptr;
@@ -126,21 +113,14 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < size || !memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val,
-                                         mop | devend_memop(endian), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, mop, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
+        if ((mop & MO_BSWAP) == MO_LE) {
             stn_le_p(ptr, size, val);
-            break;
-        case DEVICE_BIG_ENDIAN:
+        } else {
             stn_be_p(ptr, size, val);
-            break;
-        default:
-            stn_p(ptr, size, val);
-            break;
         }
         invalidate_and_set_dirty(mr, addr1, size);
         r = MEMTX_OK;
@@ -156,48 +136,44 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
 
 /* warning: addr must be aligned */
 static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs,
-    MemTxResult *result, enum device_endian endian)
+    MemOp mop, hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
 {
-    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_32, addr, val,
-                                             attrs, result, endian);
+    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_32, addr, val,
+                                             attrs, result);
 }
 
 void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
                                      MemTxAttrs attrs, MemTxResult *result)
 {
     glue(address_space_stm_internal, SUFFIX)(ARG1, MO_8, addr, val,
-                                             attrs, result,
-                                             DEVICE_NATIVE_ENDIAN);
+                                             attrs, result);
 }
 
 /* warning: addr must be aligned */
 static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint16_t val, MemTxAttrs attrs,
-    MemTxResult *result, enum device_endian endian)
+    MemOp mop, hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
 {
-    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_16, addr, val,
-                                             attrs, result, endian);
+    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_16, addr, val,
+                                             attrs, result);
 }
 
 static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs,
-    MemTxResult *result, enum device_endian endian)
+    MemOp mop, hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
 {
-    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_64, addr, val,
-                                             attrs, result, endian);
+    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_64, addr, val,
+                                             attrs, result);
 }
 
 #define ENDIANNESS
-#define DEVICE_ENDIANNESS       DEVICE_NATIVE_ENDIAN
+#define MO_ENDIAN               (target_big_endian() ? MO_BE : MO_LE)
 #include "memory_ldst_endian.c.inc"
 
 #define ENDIANNESS              _le
-#define DEVICE_ENDIANNESS       DEVICE_LITTLE_ENDIAN
+#define MO_ENDIAN               MO_LE
 #include "memory_ldst_endian.c.inc"
 
 #define ENDIANNESS              _be
-#define DEVICE_ENDIANNESS       DEVICE_BIG_ENDIAN
+#define MO_ENDIAN               MO_BE
 #include "memory_ldst_endian.c.inc"
 
 #undef ARG1_DECL
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.inc
index 16d686b50f7..29100c02f80 100644
--- a/system/memory_ldst_endian.c.inc
+++ b/system/memory_ldst_endian.c.inc
@@ -22,43 +22,43 @@
 uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                               MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(uw)(ARG1, addr, attrs, result,
-                                         DEVICE_ENDIANNESS);
+    return ADDRESS_SPACE_LD_INTERNAL(uw)(ARG1, MO_ENDIAN,
+                                        addr, attrs, result);
 }
 
 uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(l)(ARG1, addr, attrs, result,
-                                        DEVICE_ENDIANNESS);
+    return ADDRESS_SPACE_LD_INTERNAL(l)(ARG1, MO_ENDIAN,
+                                        addr, attrs, result);
 }
 
 uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, addr, attrs, result,
-                                        DEVICE_ENDIANNESS);
+    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, MO_ENDIAN,
+                                        addr, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(w)(ARG1, addr, val, attrs, result,
-                                 DEVICE_ENDIANNESS);
+    ADDRESS_SPACE_ST_INTERNAL(w)(ARG1, MO_ENDIAN,
+                                 addr, val, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(l)(ARG1, addr, val, attrs, result,
-                                 DEVICE_ENDIANNESS);
+    ADDRESS_SPACE_ST_INTERNAL(l)(ARG1, MO_ENDIAN,
+                                 addr, val, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, addr, val, attrs, result,
-                                 DEVICE_ENDIANNESS);
+    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, MO_ENDIAN,
+                                 addr, val, attrs, result);
 }
 
 #undef ADDRESS_SPACE_LD
@@ -67,4 +67,4 @@ void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
 #undef ADDRESS_SPACE_ST_INTERNAL
 
 #undef ENDIANNESS
-#undef DEVICE_ENDIANNESS
+#undef MO_ENDIAN
-- 
2.52.0


