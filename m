Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8C0C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKq-0007TO-IT; Sat, 15 Aug 2026 15:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKm-0007Op-QL
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:24 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKk-0008NJ-9m
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2d032846c95so30947335ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823181; x=1787427981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7bZekzKnK+mg088URZdChMVNehIPR960HYA/tqwZ5V0=;
 b=D521YCkJEKiQH0z47uQOqu6sI0K8cNpukOpfj8TwAoQSqKd6a+10EQHjYN0eS0svNy
 Ml5ZZ3fWgncznF2FWf2KMU0/eCoY3EN233fKyZLvoLkV5UEgn3myIcTi75xjWpalYyuj
 CHYLj3i6Mi3ON9h9K3DDwggMv7YkNpQ1aRwwyxQSgLHY7Aj5VFTkvQ60dRWU5r3QIeiy
 oDBj0DP8sn3J4u/Fu1MmWhS9WDsvZBgmN2Z4zSpVYus8VztGLkmjN2Un1f3FaQ0j8KGZ
 yyIL88s5LWT0Ac3nQYtbYrj3RB7eT4WyF1ORAss1z0X+dZ1t/A4kKYO6+5BpEp7PIYRa
 VDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823181; x=1787427981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7bZekzKnK+mg088URZdChMVNehIPR960HYA/tqwZ5V0=;
 b=nMi3hngn1a6sIu01BVd9/+Jc9NRN3pEniQJC+E40pWVnR/ERq8QjsRRzejsXGBxkFt
 zuW7TBgCr6KXwt5mB4ZyPy9hk0AeKU+Iirwr/5uOSNLgLLcgfRgWl5NRIJbzXP2okRYt
 974bxcr6ty7M1gP41RjGbXbLr+NE+W38cWE3FhfqMf7gn19ZiRiKFWa0B0wqoGgIUnUi
 8tx8wIKsxfq/zLpxnnfhdf4YzMgiJ6tGoLxYSSmytVcKFrUVoNeyJpMyMKuJAa8hjKo2
 BLx2aK8OFdgTtmclQ3emBHBXh3tVXPdjqIr4oXRkLWwY5+TMGY5yMNMJQ+CDuJOGcUO9
 x/7w==
X-Gm-Message-State: AOJu0YzVxDDDoFY+vgSHPw4kzA5UccHYKxg+RYI5R99maiBeFJxQIt/E
 wFc/BUdr85I30WroNozgyjjnrGVo41hq6fzJbWrsQozwnoXBsMAlAbekrh4hBU+IiL8YIwm6Tit
 iplym
X-Gm-Gg: AR+sD11MtNh/iuuUD6CDq1y6TbfMLQkSslh7FNzYe+RHKXgP8nBt2CaI69bj9Ugrycc
 oJXPg7ZId25xbpISC3CljX90tvKRx+3GM7x7ylKT5ZIDEpoZi7gJRfxusJ2UCR7QhjehCmeO1L7
 YQuMS1F+mhYxy3RBzoeUefgKn3QAuaG/0XTNLgweEW0UQr7lgj1gVx8EEOhRXLgjc1LjvRxAE8m
 cz5icM4JtLXDyoAT1/pcYS5JJ22WmAEiieAKnnaDPYVA+h3ufcLHFNPRwfF98UqpJgKEwTdvzap
 cw7T4rYOpImtvljrD7HF23mvuSWHIxu2YywaVFAJWnn6eUFqtSwVyd/PMUTKVtCY4jhs3BJ4oRM
 0UF6O2qxiFIgHB07GCd4eyNg1slqvWoqPy2jKvh+mTbYQ29ZPj+VHZmfswp5HufNahTCfSEui2W
 gdkUNRXEnzjMNXMSTbja4tFsgl4uu06/oUjy+aqmHNZxqIyWa90weRC9vYavv6Nni2BOJNdboMn
 9DbyburVmq3Cve7iQXx
X-Received: by 2002:a17:902:e5c7:b0:2c9:bf82:dd11 with SMTP id
 d9443c01a7336-2d3b0842406mr169956855ad.7.1786823180803; 
 Sat, 15 Aug 2026 12:46:20 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 20/23] target/riscv: Use FLATTEN rather than ALWAYS_INLINE for
 vector ldst
Date: Sat, 15 Aug 2026 12:45:45 -0700
Message-ID: <20260815194549.1377505-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It turns out there are fewer places that need annotation if we
just flatten from the outer helper macros instead of everything
along the call stack.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 143 +++++++++++++++----------------
 1 file changed, 67 insertions(+), 76 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 473b112426..2a24e15a31 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -158,7 +158,7 @@ static inline void vext_set_elem_mask(void *v0, int index,
     ((uint64_t *)v0)[idx] = deposit64(old, pos, 1, value);
 }
 
-static inline MemOpIdx vext_oi(uint32_t desc, MemOp memop)
+static MemOpIdx vext_oi(uint32_t desc, MemOp memop)
 {
     uint32_t data = simd_data(desc);
 
@@ -179,17 +179,15 @@ typedef void vext_ldst_elem_fn_host(void *vd, void *host,
                                     uint32_t idx, uint32_t evl);
 
 #define GEN_VEXT_TLB_LD_ELEM(NAME, ETYPE, H, LDSUF)                     \
-static inline QEMU_ALWAYS_INLINE                                        \
-void NAME##_tlb(CPURISCVState *env, abi_ptr addr, uint32_t idx,         \
-                void *vd, MemOpIdx oi, uintptr_t retaddr)               \
+static void NAME##_tlb(CPURISCVState *env, abi_ptr addr, uint32_t idx,  \
+                       void *vd, MemOpIdx oi, uintptr_t retaddr)        \
 {                                                                       \
     ETYPE *cur = ((ETYPE *)vd + H(idx));                                \
     *cur = cpu_##LDSUF##_mmu(env, addr, oi, retaddr);                   \
 }
 
 #define GEN_VEXT_HOST_LD_ELEM(NAME, ETYPE, H, LDSUF)                    \
-static inline QEMU_ALWAYS_INLINE                                        \
-void NAME##_host(void *vd, void *host, uint32_t idx, uint32_t evl)      \
+static void NAME##_host(void *vd, void *host, uint32_t idx, uint32_t evl) \
 {                                                                       \
     do {                                                                \
         ETYPE *cur = (ETYPE *)vd + H(idx);                              \
@@ -206,8 +204,7 @@ GEN_VEXT_TLB_LD_ELEM(lde_d, uint64_t, H8, ldq)
 #if HOST_BIG_ENDIAN
 GEN_VEXT_HOST_LD_ELEM(lde_b, uint8_t,  H1, ldub)
 #else
-static inline QEMU_ALWAYS_INLINE
-void lde_b_host(void *vd, void *host, uint32_t idx, uint32_t evl)
+static void lde_b_host(void *vd, void *host, uint32_t idx, uint32_t evl)
 {
     memcpy(vd + idx, host, evl - idx);
 }
@@ -218,8 +215,7 @@ GEN_VEXT_HOST_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
 GEN_VEXT_HOST_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
 
 #define GEN_VEXT_TLB_ST_ELEM(NAME, ETYPE, H, STSUF)                     \
-static inline QEMU_ALWAYS_INLINE                                        \
-void NAME##_tlb(CPURISCVState *env, abi_ptr addr, uint32_t idx,         \
+static void NAME##_tlb(CPURISCVState *env, abi_ptr addr, uint32_t idx,  \
                 void *vd, MemOpIdx oi, uintptr_t retaddr)               \
 {                                                                       \
     ETYPE data = *((ETYPE *)vd + H(idx));                               \
@@ -227,8 +223,7 @@ void NAME##_tlb(CPURISCVState *env, abi_ptr addr, uint32_t idx,         \
 }
 
 #define GEN_VEXT_HOST_ST_ELEM(NAME, ETYPE, H, STSUF)                    \
-static inline QEMU_ALWAYS_INLINE                                        \
-void NAME##_host(void *vd, void *host, uint32_t idx, uint32_t evl)      \
+static void NAME##_host(void *vd, void *host, uint32_t idx, uint32_t evl) \
 {                                                                       \
     do {                                                                \
         ETYPE data = *((ETYPE *)vd + H(idx));                           \
@@ -245,8 +240,7 @@ GEN_VEXT_TLB_ST_ELEM(ste_d, uint64_t, H8, stq)
 #if HOST_BIG_ENDIAN
 GEN_VEXT_HOST_ST_ELEM(ste_b, uint8_t,  H1, stb)
 #else
-static inline QEMU_ALWAYS_INLINE
-void ste_b_host(void *vd, void *host, uint32_t idx, uint32_t evl)
+static void ste_b_host(void *vd, void *host, uint32_t idx, uint32_t evl)
 {
     memcpy(host, vd + idx, evl - idx);
 }
@@ -361,7 +355,7 @@ GEN_VEXT_ST_STRIDE(vsse64_v, int64_t, ste_d_tlb)
  */
 
 /* unmasked unit-stride load and store operation */
-static inline QEMU_ALWAYS_INLINE void
+static void
 vext_page_ldst_us_host(void *vd, void *host, uint32_t i, uint32_t evl,
                        uint32_t nf, uint32_t log2_esz, uint32_t max_elems,
                        vext_ldst_elem_fn_host *ldst_host)
@@ -378,7 +372,7 @@ vext_page_ldst_us_host(void *vd, void *host, uint32_t i, uint32_t evl,
     }
 }
 
-static inline QEMU_ALWAYS_INLINE void
+static void
 vext_page_ldst_us_tlb(CPURISCVState *env, void *vd, target_ulong addr,
                       uint32_t i, uint32_t evl, uint32_t nf,
                       uint32_t log2_esz, uint32_t max_elems,
@@ -409,7 +403,7 @@ static void vext_test_alignment(CPURISCVState *env, vaddr addr, uint32_t esz,
     }
 }
 
-static inline QEMU_ALWAYS_INLINE void
+static void
 vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env,
              uint32_t log2_esz, uint32_t nf, uint32_t evl,
              uint32_t max_elems, bool vma,
@@ -511,7 +505,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env,
     }
 }
 
-static inline QEMU_ALWAYS_INLINE void
+static void
 vext_ldst_us_desc(void *vd, target_ulong base, CPURISCVState *env,
                   uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
                   vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
@@ -528,20 +522,19 @@ vext_ldst_us_desc(void *vd, target_ulong base, CPURISCVState *env,
  * stride, stride = NF * sizeof (ETYPE)
  */
 
-#define GEN_VEXT_LD_US(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)      \
-void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,     \
-                         CPURISCVState *env, uint32_t desc)         \
-{                                                                   \
-    uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));         \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, false,        \
-                     LOAD_FN_TLB, ctzl(sizeof(ETYPE)), GETPC());    \
-}                                                                   \
-                                                                    \
-void HELPER(NAME)(void *vd, void *v0, target_ulong base,            \
-                  CPURISCVState *env, uint32_t desc)                \
-{                                                                   \
-    vext_ldst_us_desc(vd, base, env, desc, LOAD_FN_TLB, LOAD_FN_HOST,    \
-                      ctzl(sizeof(ETYPE)), env->vl, GETPC(), true);      \
+#define GEN_VEXT_LD_US(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)          \
+QEMU_FLATTEN void HELPER(NAME##_mask)(void *vd, void *v0,               \
+    target_ulong base, CPURISCVState *env, uint32_t desc)               \
+{                                                                       \
+    uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));             \
+    vext_ldst_stride(vd, v0, base, stride, env, desc, false,            \
+                     LOAD_FN_TLB, ctzl(sizeof(ETYPE)), GETPC());        \
+}                                                                       \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong base,   \
+                               CPURISCVState *env, uint32_t desc)       \
+{                                                                       \
+    vext_ldst_us_desc(vd, base, env, desc, LOAD_FN_TLB, LOAD_FN_HOST,   \
+                      ctzl(sizeof(ETYPE)), env->vl, GETPC(), true);     \
 }
 
 GEN_VEXT_LD_US(vle8_v,  int8_t,  lde_b_tlb, lde_b_host)
@@ -549,20 +542,19 @@ GEN_VEXT_LD_US(vle16_v, int16_t, lde_h_tlb, lde_h_host)
 GEN_VEXT_LD_US(vle32_v, int32_t, lde_w_tlb, lde_w_host)
 GEN_VEXT_LD_US(vle64_v, int64_t, lde_d_tlb, lde_d_host)
 
-#define GEN_VEXT_ST_US(NAME, ETYPE, STORE_FN_TLB, STORE_FN_HOST)         \
-void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,          \
-                         CPURISCVState *env, uint32_t desc)              \
-{                                                                        \
-    uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));              \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, false,             \
-                     STORE_FN_TLB, ctzl(sizeof(ETYPE)), GETPC());        \
-}                                                                        \
-                                                                         \
-void HELPER(NAME)(void *vd, void *v0, target_ulong base,                 \
-                  CPURISCVState *env, uint32_t desc)                     \
-{                                                                        \
-    vext_ldst_us_desc(vd, base, env, desc, STORE_FN_TLB, STORE_FN_HOST,  \
-                      ctzl(sizeof(ETYPE)), env->vl, GETPC(), false);     \
+#define GEN_VEXT_ST_US(NAME, ETYPE, STORE_FN_TLB, STORE_FN_HOST)        \
+QEMU_FLATTEN void HELPER(NAME##_mask)(void *vd, void *v0,               \
+    target_ulong base, CPURISCVState *env, uint32_t desc)               \
+{                                                                       \
+    uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));             \
+    vext_ldst_stride(vd, v0, base, stride, env, desc, false,            \
+                     STORE_FN_TLB, ctzl(sizeof(ETYPE)), GETPC());       \
+}                                                                       \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong base,   \
+                  CPURISCVState *env, uint32_t desc)                    \
+{                                                                       \
+    vext_ldst_us_desc(vd, base, env, desc, STORE_FN_TLB, STORE_FN_HOST, \
+                      ctzl(sizeof(ETYPE)), env->vl, GETPC(), false);    \
 }
 
 GEN_VEXT_ST_US(vse8_v,  int8_t,  ste_b_tlb, ste_b_host)
@@ -573,8 +565,8 @@ GEN_VEXT_ST_US(vse64_v, int64_t, ste_d_tlb, ste_d_host)
 /*
  * unit stride mask load and store, EEW = 1
  */
-void HELPER(vlm_v)(void *vd, void *v0, target_ulong base,
-                    CPURISCVState *env, uint32_t desc)
+QEMU_FLATTEN void HELPER(vlm_v)(void *vd, void *v0, target_ulong base,
+                                CPURISCVState *env, uint32_t desc)
 {
     /* evl = ceil(vl/8) */
     uint8_t evl = (env->vl + 7) >> 3;
@@ -582,8 +574,8 @@ void HELPER(vlm_v)(void *vd, void *v0, target_ulong base,
                       0, evl, GETPC(), true);
 }
 
-void HELPER(vsm_v)(void *vd, void *v0, target_ulong base,
-                    CPURISCVState *env, uint32_t desc)
+QEMU_FLATTEN void HELPER(vsm_v)(void *vd, void *v0, target_ulong base,
+                                CPURISCVState *env, uint32_t desc)
 {
     /* evl = ceil(vl/8) */
     uint8_t evl = (env->vl + 7) >> 3;
@@ -609,7 +601,7 @@ GEN_VEXT_GET_INDEX_ADDR(idx_h, uint16_t, H2)
 GEN_VEXT_GET_INDEX_ADDR(idx_w, uint32_t, H4)
 GEN_VEXT_GET_INDEX_ADDR(idx_d, uint64_t, H8)
 
-static inline void
+static void
 vext_ldst_index(void *vd, void *v0, target_ulong base,
                 void *vs2, CPURISCVState *env, uint32_t desc,
                 vext_get_index_addr get_index_addr,
@@ -646,12 +638,12 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     }
 }
 
-#define GEN_VEXT_LD_INDEX(NAME, ETYPE, INDEX_FN, LOAD_FN)                  \
-void HELPER(NAME)(void *vd, void *v0, target_ulong base,                   \
-                  void *vs2, CPURISCVState *env, uint32_t desc)            \
-{                                                                          \
-    vext_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,                \
-                    LOAD_FN, ctzl(sizeof(ETYPE)), GETPC());                \
+#define GEN_VEXT_LD_INDEX(NAME, ETYPE, INDEX_FN, LOAD_FN)               \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong base,   \
+                               void *vs2, CPURISCVState *env, uint32_t desc) \
+{                                                                       \
+    vext_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,             \
+                    LOAD_FN, ctzl(sizeof(ETYPE)), GETPC());             \
 }
 
 GEN_VEXT_LD_INDEX(vlxei8_8_v,   int8_t,  idx_b, lde_b_tlb)
@@ -671,13 +663,12 @@ GEN_VEXT_LD_INDEX(vlxei64_16_v, int16_t, idx_d, lde_h_tlb)
 GEN_VEXT_LD_INDEX(vlxei64_32_v, int32_t, idx_d, lde_w_tlb)
 GEN_VEXT_LD_INDEX(vlxei64_64_v, int64_t, idx_d, lde_d_tlb)
 
-#define GEN_VEXT_ST_INDEX(NAME, ETYPE, INDEX_FN, STORE_FN)       \
-void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
-                  void *vs2, CPURISCVState *env, uint32_t desc)  \
-{                                                                \
-    vext_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,      \
-                    STORE_FN, ctzl(sizeof(ETYPE)),               \
-                    GETPC());                                    \
+#define GEN_VEXT_ST_INDEX(NAME, ETYPE, INDEX_FN, STORE_FN)              \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong base,   \
+                               void *vs2, CPURISCVState *env, uint32_t desc) \
+{                                                                       \
+    vext_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,             \
+                    STORE_FN, ctzl(sizeof(ETYPE)), GETPC());            \
 }
 
 GEN_VEXT_ST_INDEX(vsxei8_8_v,   int8_t,  idx_b, ste_b_tlb)
@@ -700,7 +691,7 @@ GEN_VEXT_ST_INDEX(vsxei64_64_v, int64_t, idx_d, ste_d_tlb)
 /*
  * unit-stride fault-only-fisrt load instructions
  */
-static inline void
+static void
 vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
           uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
           vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz, uintptr_t ra)
@@ -933,12 +924,12 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     }
 }
 
-#define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)   \
-void HELPER(NAME)(void *vd, void *v0, target_ulong base,        \
-                  CPURISCVState *env, uint32_t desc)            \
-{                                                               \
-    vext_ldff(vd, v0, base, env, desc, LOAD_FN_TLB,             \
-              LOAD_FN_HOST, ctzl(sizeof(ETYPE)), GETPC());      \
+#define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)           \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong base,   \
+                               CPURISCVState *env, uint32_t desc)       \
+{                                                                       \
+    vext_ldff(vd, v0, base, env, desc, LOAD_FN_TLB,                     \
+              LOAD_FN_HOST, ctzl(sizeof(ETYPE)), GETPC());              \
 }
 
 GEN_VEXT_LDFF(vle8ff_v,  int8_t,  lde_b_tlb, lde_b_host)
@@ -959,7 +950,7 @@ GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb, lde_d_host)
 /*
  * load and store whole register instructions
  */
-static inline QEMU_ALWAYS_INLINE void
+static void
 vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
                 vext_ldst_elem_fn_tlb *ldst_tlb,
                 vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
@@ -973,8 +964,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 }
 
 #define GEN_VEXT_LD_WHOLE(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)   \
-void HELPER(NAME)(void *vd, target_ulong base, CPURISCVState *env,  \
-                  uint32_t desc)                                    \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, target_ulong base,         \
+                               CPURISCVState *env, uint32_t desc)   \
 {                                                                   \
     vext_ldst_whole(vd, base, env, desc, LOAD_FN_TLB, LOAD_FN_HOST, \
                     ctzl(sizeof(ETYPE)), GETPC(), true);            \
@@ -998,8 +989,8 @@ GEN_VEXT_LD_WHOLE(vl8re32_v, int32_t, lde_w_tlb, lde_w_host)
 GEN_VEXT_LD_WHOLE(vl8re64_v, int64_t, lde_d_tlb, lde_d_host)
 
 #define GEN_VEXT_ST_WHOLE(NAME, ETYPE, STORE_FN_TLB, STORE_FN_HOST)     \
-void HELPER(NAME)(void *vd, target_ulong base, CPURISCVState *env,      \
-                  uint32_t desc)                                        \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, target_ulong base,             \
+                               CPURISCVState *env, uint32_t desc)       \
 {                                                                       \
     vext_ldst_whole(vd, base, env, desc, STORE_FN_TLB, STORE_FN_HOST,   \
                     ctzl(sizeof(ETYPE)), GETPC(), false);               \
-- 
2.43.0


