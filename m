Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803F2E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 14:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLNkr-0002Vx-ID; Wed, 11 Dec 2024 09:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tLNki-0002Ud-5C
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:31:48 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tLNkg-0001sh-7o
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:31:47 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434ab938e37so44439295e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 06:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1733927502; x=1734532302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DP93KB0owwkFFsz3BszVpTFgYFRBoYBfyVmESKBcPk4=;
 b=gHHMp2Oy58v78yOr2Vj2PkJnFQgJMlDMQ9KzTJERsSAoYCBPOLVUdPB8u508q2RYIt
 lY0spnkqSad5lXHbe7LkxElC65v6IK4r2YeLYwArPceECL+vtyfFQ0v98050LDUZV+1o
 5Q9b0SvgdqgcAw7P4phGh3FPZmfax7+HQp97tQ2gUsdrhXmk7+w1gJ+jIPerP3EEDHEL
 TZQKhb61ASCDQFHsmtM7LPS0ZtOhsyRPdHtGYF3Iu4ckydSG9WVdd8lPGZV4npTzHX6m
 WSdoQmS8TV20XDzePTzrxEfKKN47APr6I0uT2gSr2jztdP9oIsgUm91wxTZwjVWozosM
 fiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733927502; x=1734532302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DP93KB0owwkFFsz3BszVpTFgYFRBoYBfyVmESKBcPk4=;
 b=mdgI3/LSFDBX4R8cddUePSAaW6oLK89VgcOAoVSL+dc76FVLhR2gIB87AY6kbOfsx9
 EmeThg89fupWc//AbgCym1NhUrMkA/lubT/uI8fY+LUB5h6P9NXVVnYZheGLxlnNOwG2
 RGE6oUQ6cpJjgoqiHunSuL2t5y2n9fuTikwA/Whc5ofhByoQOImGZB35x/qfED+TQEUi
 Z+rWMgyndtH5D37pT2Vf3fI42HpTr61YSl6u0kilA6B0osD/TJN/qm28yLsvSPJYM1XU
 eYBAQYsiBfpmUOZ5gdZBoPOSAp9+EbJtmKy70NpEqBu79aI4AMhPw2xH0COxoiId7pfE
 jyKQ==
X-Gm-Message-State: AOJu0YwBjcoWCXOcumy3/aohWHkDlUIgYgJLPcnDb/XG0ZtW/3M5Z3SQ
 hdSg2vs/Pgp9kwRlzGKf7UzMyD9EPefW3VVamLzOmcDNv+Np7yt0azyLIwNSRBfQecYcwJg+pKA
 bMkU=
X-Gm-Gg: ASbGncvznpLxPh8HedfhbsiQxmFvEz0TUS2sn2ZZ4xoE0IhvWKJ7ZBbQlOOHCTOzKU9
 qN2xBL4kahjwBsFABcU8X2uHkOCampuKn4PY2SMVpGE8zRgs3x20kXOsDtDP00uyBGXNtWX4ghd
 oYvpXIafc0JgDJ91E9LMb1S5PpG3etG/OhBSFeQqrB9iqyDKID0rpsuMMIbFFz4+bOIzfaxyajc
 YzCs5/1KpOBHzayaXR8fkMf6brHsPs7RsRl4zBjMVaAxY9UQkOA9oVLFs4lC7cugqtj0RqQYrvI
 Ot/SacahULPE5BYm7Ah6KdbkmbbGpPncodmD7C1/9jKzDA==
X-Google-Smtp-Source: AGHT+IGQK/PcW0mFKEYF9+6jTSHK9DasgrRmRZc2Z0g/D8v45TzM+sb9gySL5pw95+qO5CJiEntKlA==
X-Received: by 2002:a05:600c:4450:b0:434:a1d3:a30f with SMTP id
 5b1f17b1804b1-4361c346cbbmr20975055e9.6.1733927501945; 
 Wed, 11 Dec 2024 06:31:41 -0800 (PST)
Received: from dorian..
 (sals-04-b2-v4wan-167965-cust660.vm36.cable.virginm.net. [80.3.10.149])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434e8ec8072sm153602425e9.18.2024.12.11.06.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 06:31:41 -0800 (PST)
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
Subject: [RFC PATCH v5 1/1] target/riscv: rvv: Use wider accesses for unit
 stride load/store
Date: Wed, 11 Dec 2024 14:31:18 +0000
Message-ID: <20241211143118.661268-2-craig.blackmore@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211143118.661268-1-craig.blackmore@embecosm.com>
References: <20241211143118.661268-1-craig.blackmore@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=craig.blackmore@embecosm.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


