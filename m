Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D11BE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 14:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNv3t-0000Y4-HU; Wed, 18 Dec 2024 09:30:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tNv3s-0000Xr-8f
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 09:30:04 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tNv3q-00047R-6s
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 09:30:03 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so43969555e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 06:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1734532200; x=1735137000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DP93KB0owwkFFsz3BszVpTFgYFRBoYBfyVmESKBcPk4=;
 b=TPw3esqmfAMOXmP/L8P1Ns23WVwwWojnCwLx1M5cgB0x/8JpkLRT9TKTlAdv9mJcUz
 bdyCVDov0WP35DeGCxWue4SPYOzChso9JT0PFWM5JiXBInT5P/SURa2v+7fMRRZO7IGR
 7c//2x8S0nmi18wswZ0bWi1ziTWrQ3UY8MgxxZlEfgyM8KBW4E1ayC43IJ090WuNrOzm
 9c/+zFXyzA2pJR/FjAUxUrwBO+JCel3Y++mw2s/hueUkRupA29GOwsL630UprwwEpkGm
 6+A3tMErTcafwonCUUDKmE9c9o74ikMKrmzslebP8c3yuFM6KNGFo1h6Dy7/+jTm6Tzm
 bClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734532200; x=1735137000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DP93KB0owwkFFsz3BszVpTFgYFRBoYBfyVmESKBcPk4=;
 b=iU10g8mEbL84Ygl4x6Mqz1oyEGsGFjNIIFPcTmLlSe03G/YXeAejFogi/3C66/5Hhz
 jctNhx9E4bghyjq+FF57Qlk0w1X89a/YEUh46cvIx+0donnnKmGIrKzb0zLMQX+VOnYn
 5IsCn/8j62ukERTzZAHjR1YbPsLsvJKs+kS9ppYsMaxs+LyQVeoSWoQ0GnDYDsTPWdV0
 GX/8c4f8AEvlGAi+ofCoxY97hZZkfE7sgKn2GIDSV111auUfutc57RiXpIeuLY+7Gb15
 n8curiuvd5IfnBd8Wi9KsBblIGy/ycA3KPi9w9n1+nzX0hKfMVyqy0JqZwlhEPlCAOMC
 H+uw==
X-Gm-Message-State: AOJu0Ywh5sqtDgnbh4qNl4vYzR0rP9ogtOzKYAh6eydXm73qZ6UCYEY/
 RMJUMAqgl36B3MHLSelnAnNcVYbCxTM2O6dE8lf1q9ZbrLQPxjKPWaRhNfyOCI7ZfIY9PSIe33V
 XvPY=
X-Gm-Gg: ASbGncsXSdOIepRq8UxQ/ZG7mlGP/iOabuiqk7HabxWZ/qObVq/cwg9q1xTjfxfEBMN
 57io5VMwAwhsEtXkp6/7bAfMEqdIDB3P8CeUv/sO5I4x8zjm7H9Z96KileoR4wn8S/P4EvMNhH3
 VW7vKJbxROvRmqPKhD5oJHPi26dhmQQEsKhPZZdBPHrXADijju8XLXQcnZr3NGgxToYhwNmuC3k
 yjP0r+7kLfsGf+o+KzK/fS4zCyfXi6usID7AsQxIDV2EDbASGQDOf4iq+oJNPxvLlNtAPi+Zyrw
 YLLLAbzIdEu0YoygFC5qhdfZSxwPE5J+T5AMb1ejS/YNp+Gh
X-Google-Smtp-Source: AGHT+IFKtsjRBw08odJMBmzWnrfHc4hS8a5sXUUpWUB298rVWki9jvut5u9mMZVRk9Aa9OmG/2Qtmw==
X-Received: by 2002:a05:600c:4e88:b0:436:488f:50a with SMTP id
 5b1f17b1804b1-4365537128dmr30062895e9.17.1734532200572; 
 Wed, 18 Dec 2024 06:30:00 -0800 (PST)
Received: from dorian..
 (sals-04-b2-v4wan-167965-cust660.vm36.cable.virginm.net. [80.3.10.149])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801a47csm14330046f8f.44.2024.12.18.06.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 06:29:59 -0800 (PST)
From: Craig Blackmore <craig.blackmore@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Craig Blackmore <craig.blackmore@embecosm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Paolo Savini <paolo.savini@embecosm.com>
Subject: [PATCH v6 1/1] target/riscv: rvv: Use wider accesses for unit stride
 load/store
Date: Wed, 18 Dec 2024 14:29:37 +0000
Message-ID: <20241218142937.1028602-2-craig.blackmore@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218142937.1028602-1-craig.blackmore@embecosm.com>
References: <20241218142937.1028602-1-craig.blackmore@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=craig.blackmore@embecosm.com; helo=mail-wm1-x333.google.com
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

Use atomic load/store functions to access multiple elements from host.

Co-authored-by: Paolo Savini <paolo.savini@embecosm.com>

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
Signed-off-by: Craig Blackmore <craig.blackmore@embecosm.com>
---
 target/riscv/trace-events    | 12 +++++
 target/riscv/vector_helper.c | 95 +++++++++++++++++++++++++++++++++---
 2 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/target/riscv/trace-events b/target/riscv/trace-events
index 49ec4d3b7d..9db6b274db 100644
--- a/target/riscv/trace-events
+++ b/target/riscv/trace-events
@@ -9,3 +9,15 @@ pmpaddr_csr_write(uint64_t mhartid, uint32_t addr_index, uint64_t val) "hart %"
 
 mseccfg_csr_read(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": read mseccfg, val: 0x%" PRIx64
 mseccfg_csr_write(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": write mseccfg, val: 0x%" PRIx64
+
+# ldst_atomicity
+load_atom2_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+load_atom4_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+load_atom8_or_exit_fallback(uintptr_t ra) "ra:0x%"PRIxPTR""
+load_atom8_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+load_atom16_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+load_atom16_or_exit_fallback(uintptr_t ra) "ra:0x%"PRIxPTR""
+store_atom2_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+store_atom4_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+store_atom8_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+store_atom16_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index a85dd1d200..63c76a24d1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -31,6 +31,12 @@
 #include "vector_internals.h"
 #include <math.h>
 
+#if CONFIG_TCG && !HOST_BIG_ENDIAN
+#include "trace.h"
+#include "../accel/tcg/internal-common.h"
+#include "../accel/tcg/ldst_atomicity.c.inc"
+#endif
+
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                             target_ulong s2)
 {
@@ -206,10 +212,84 @@ vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
     }
 }
 
+#if CONFIG_TCG && !HOST_BIG_ENDIAN
+/* Atomic operations for load/store */
+
+/*
+ * Return true if there are enough elements for this size access and the
+ * alignment guarantees atomicity with {load,store}_atom_<size>.
+ */
+
+static inline QEMU_ALWAYS_INLINE bool
+ok_for_atomic(uint32_t size, void *host, uint32_t reg_start, uint32_t evl,
+              uint32_t log2_esz)
+{
+  return (reg_start + (size >> log2_esz)) <= evl
+         && ((uintptr_t) host % size) == 0;
+}
+
+#define GEN_VEXT_LDST_ATOMIC_HOST(SIZE, TYPE, MEMOP)                         \
+static inline QEMU_ALWAYS_INLINE void                                        \
+vext_ldst_atom_##SIZE##_host(CPURISCVState *env, void *vd,                   \
+                             uint32_t byte_offset, void *host, bool is_load, \
+                             uintptr_t ra)                                   \
+{                                                                            \
+    TYPE *vd_ptr = (TYPE *) (vd + byte_offset);                              \
+    if (is_load) {                                                           \
+        *vd_ptr = load_atom_##SIZE(env_cpu(env), ra, host, MEMOP);           \
+    } else {                                                                 \
+        store_atom_##SIZE(env_cpu(env), ra, host, MEMOP, *vd_ptr);           \
+    }                                                                        \
+}                                                                            \
+
+GEN_VEXT_LDST_ATOMIC_HOST(2, uint16_t, MO_16)
+GEN_VEXT_LDST_ATOMIC_HOST(4, uint32_t, MO_32)
+GEN_VEXT_LDST_ATOMIC_HOST(8, uint64_t, MO_64)
+GEN_VEXT_LDST_ATOMIC_HOST(16, Int128, MO_128)
+#endif
+
+/* Perform the largest atomic load/store possible for the evl and alignment.  */
+
+static inline QEMU_ALWAYS_INLINE uint32_t
+vext_ldst_atomic_chunk_host(CPURISCVState *env,
+                            vext_ldst_elem_fn_host *ldst_host,
+                            void *vd, uint32_t evl, uint32_t reg_start,
+                            void *host, uint32_t esz, bool is_load,
+                            uint32_t log2_esz, uintptr_t ra)
+{
+#if CONFIG_TCG && !HOST_BIG_ENDIAN
+    uint32_t byte_offset = reg_start * esz;
+
+    if (ok_for_atomic(16, host, reg_start, evl, log2_esz)) {
+        vext_ldst_atom_16_host(env, vd, byte_offset, host, is_load, ra);
+        return 16;
+    }
+
+    if (ok_for_atomic(8, host, reg_start, evl, log2_esz)) {
+        vext_ldst_atom_8_host(env, vd, byte_offset, host, is_load, ra);
+        return 8;
+    }
+
+    if (ok_for_atomic(4, host, reg_start, evl, log2_esz)) {
+        vext_ldst_atom_4_host(env, vd, byte_offset, host, is_load, ra);
+        return 4;
+    }
+
+    if (ok_for_atomic(2, host, reg_start, evl, log2_esz)) {
+        vext_ldst_atom_2_host(env, vd, byte_offset, host, is_load, ra);
+        return 2;
+    }
+#endif
+
+    ldst_host(vd, reg_start, host);
+    return 1;
+}
+
 static inline QEMU_ALWAYS_INLINE void
 vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
                         void *vd, uint32_t evl, uint32_t reg_start, void *host,
-                        uint32_t esz, bool is_load)
+                        uint32_t esz, bool is_load, uint32_t log2_esz,
+                        uintptr_t ra)
 {
 #if HOST_BIG_ENDIAN
     for (; reg_start < evl; reg_start++, host += esz) {
@@ -225,10 +305,13 @@ vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
         } else {
             memcpy(host, vd + byte_offset, size);
         }
-    } else {
-        for (; reg_start < evl; reg_start++, host += esz) {
-            ldst_host(vd, reg_start, host);
-        }
+        return;
+    }
+    uint32_t chunk = 0;
+    for (; reg_start < evl; reg_start += (chunk >> log2_esz),
+                            host += chunk) {
+        chunk = vext_ldst_atomic_chunk_host(env, ldst_host, vd, evl, reg_start,
+                                            host, esz, is_load, log2_esz, ra);
     }
 #endif
 }
@@ -343,7 +426,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     if (flags == 0) {
         if (nf == 1) {
             vext_continus_ldst_host(env, ldst_host, vd, evl, env->vstart, host,
-                                    esz, is_load);
+                                    esz, is_load, log2_esz, ra);
         } else {
             for (i = env->vstart; i < evl; ++i) {
                 k = 0;
-- 
2.43.0


