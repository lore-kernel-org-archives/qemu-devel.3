Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07474C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKq-0007T9-Bj; Sat, 15 Aug 2026 15:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKV-0007Hg-Ei
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:07 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKT-0008H0-Nt
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:07 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cc891373e0so27936765ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823164; x=1787427964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PwrL7badJiVWs6ya4sCETcneM+ddqqSpHKgWHUOhTRE=;
 b=PSwqPLDxMypoB/hSJyzI71RrJd13etBFNdC6V58tIhWu7lfCL5Aqk+gbp3UkdootTv
 YE3wMU4MWToOjJ4lRhrO4DICsmSEAKMFfZezG4lna4HeKZcSz3VLljqlLKrV4JkDqsye
 Xxj7Fp6+AOAuI1h62ieBOfZJMd9UZwZ4ZnO9B4x/vz1g3v/rj1/AR3v7HGwYxWH9IpqY
 BHmxSNm0Jm7iNOoZM0WP0aEGZa2AMp/9qjNJVIWV1BnQE3oiDJ6nle6WalYvjVZJ3z/X
 kNa3odS+sbtUxaSrEgEFyMgSpcAuRoNwJABL+vyKpzsWxrBmJPamSuBiXDDvkx6CkzWj
 2UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823164; x=1787427964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PwrL7badJiVWs6ya4sCETcneM+ddqqSpHKgWHUOhTRE=;
 b=PL8VtVe4IUv2WPdSA5m6+gYpOGx6wYbBop34Rji2GhfZmLHVY2oDzSyE/pHQ/xhKMx
 MFMEncRAz/OTbeSwCpjZm4jYzEqUgCInN0xj2C3OLvnO2YVHmYw2/PfCq/dZDZ87fnU5
 OEy50Cxer4q2KDvd1jptcOTX2b3PFoSWdwdVF4A9IDEXcWTblaDAlLD2IFlleBaNRkso
 YDfMKdyDQ2K4blzurpmvY3ZQpppYW7gCdshZicW6qHbazwxgq46ScgZckXvfJjTUWAFT
 awL4NqDAgk9vfDOZmpOsvRgQ0Prew6HhNUHAtQletZYjOMWljeHOom9GBVYBaNlpohub
 lpYQ==
X-Gm-Message-State: AOJu0YzFog74XLxRSxW9EIO3+GARULWcLwwiaDkrHL0BMe+DnFPM04p7
 mu89UB9mmOb9nUCrLVQxOdk8Wd35XVOqkkLJTXSJrIeGJGCf1XDL7CpIhuY76kl9wCl7bSYnF9Z
 rCCBo
X-Gm-Gg: AR+sD13NSykZF5tS+IDgewXRXCZN5B8T3aco5+2xrhEXcquOHIBChfdsF6XT+rYGy9v
 tDb0ugmgapbhme+MIVHVwfqbSfKNBtnSzowHn7fl11SaDhPb+0MI5Tm2dfapGGPNJLjHPz+liaz
 f1rDA3i1p1zou7USilHLeosGU7YV8ksu5D+6/6gYNlg71i6DPryuRqAOohl2v00pHMzglbglsZm
 p9+bas0gw/H7Gjw7c2CKZ7egWX8lgQKhH4RbcbfCuSc3JRpfcNGq8L+DI7KitLA40Bke4TIvX8X
 odGvqhTUEN8KXeV0UIMe0zDggOT9oa5rs65JOnZ/eP6gKRfwj90cRsMCrPlSurJ9isd9GkDMVSd
 /6VLMKn+ji70S3x7fr1+/PKiheUlP0cYCPgwxeP4HixsO2bWrIb4NQl6HilzPEZbvYvoCAkHcqN
 gV17he2DNaDmW7Mec+OTFSDTbPx3A5z7DxG3Vhcl4MjjLYti/SBUorSyYAVwpxmWSvdIm3r72Of
 McLz5bT2iEeBfkN333K
X-Received: by 2002:a17:903:1965:b0:2c0:e5ee:f55e with SMTP id
 d9443c01a7336-2d3b0db9f3cmr161142175ad.7.1786823164184; 
 Sat, 15 Aug 2026 12:46:04 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 05/23] target/riscv: Add evl argument to vext_ldst_elem_fn_host
Date: Sat, 15 Aug 2026 12:45:30 -0700
Message-ID: <20260815194549.1377505-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

This merges vext_continuous_ldst_host into the ldst_host function.
We can then handle the byte little-endian optimization at compile-time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 83 +++++++++++++++-----------------
 1 file changed, 40 insertions(+), 43 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 661f1ab2f6..3786a17231 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -214,7 +214,8 @@ static inline MemOpIdx vext_make_memop_idx(CPURISCVState *env, size_t size)
 /* elements operations for load and store */
 typedef void vext_ldst_elem_fn_tlb(CPURISCVState *env, abi_ptr addr,
                                    uint32_t idx, void *vd, uintptr_t retaddr);
-typedef void vext_ldst_elem_fn_host(void *vd, uint32_t idx, void *host);
+typedef void vext_ldst_elem_fn_host(void *vd, void *host,
+                                    uint32_t idx, uint32_t evl);
 
 #define GEN_VEXT_TLB_LD_ELEM(NAME, ETYPE, H, LDSUF)         \
 static inline QEMU_ALWAYS_INLINE                            \
@@ -226,12 +227,15 @@ void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
     *cur = cpu_##LDSUF##_mmu(env, addr, oi, retaddr);       \
 }                                                           \
 
-#define GEN_VEXT_HOST_LD_ELEM(NAME, ETYPE, H, LDSUF)        \
-static inline QEMU_ALWAYS_INLINE                            \
-void NAME##_host(void *vd, uint32_t idx, void *host)        \
-{                                                           \
-    ETYPE *cur = ((ETYPE *)vd + H(idx));                    \
-    *cur = (ETYPE)LDSUF##_p(host);                          \
+#define GEN_VEXT_HOST_LD_ELEM(NAME, ETYPE, H, LDSUF)                    \
+static inline QEMU_ALWAYS_INLINE                                        \
+void NAME##_host(void *vd, void *host, uint32_t idx, uint32_t evl)      \
+{                                                                       \
+    do {                                                                \
+        ETYPE *cur = (ETYPE *)vd + H(idx);                              \
+        *cur = LDSUF##_p(host);                                         \
+        host += sizeof(ETYPE);                                          \
+    } while (++idx < evl);                                              \
 }
 
 GEN_VEXT_TLB_LD_ELEM(lde_b, uint8_t,  H1, ldb)
@@ -239,7 +243,16 @@ GEN_VEXT_TLB_LD_ELEM(lde_h, uint16_t, H2, ldw)
 GEN_VEXT_TLB_LD_ELEM(lde_w, uint32_t, H4, ldl)
 GEN_VEXT_TLB_LD_ELEM(lde_d, uint64_t, H8, ldq)
 
+#if HOST_BIG_ENDIAN
 GEN_VEXT_HOST_LD_ELEM(lde_b, uint8_t,  H1, ldub)
+#else
+static inline QEMU_ALWAYS_INLINE
+void lde_b_host(void *vd, void *host, uint32_t idx, uint32_t evl)
+{
+    memcpy(vd + idx, host, evl - idx);
+}
+#endif
+
 GEN_VEXT_HOST_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
 GEN_VEXT_HOST_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
 GEN_VEXT_HOST_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
@@ -254,12 +267,15 @@ void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
     cpu_##STSUF##_mmu(env, addr, data, oi, retaddr);        \
 }                                                           \
 
-#define GEN_VEXT_HOST_ST_ELEM(NAME, ETYPE, H, STSUF)        \
-static inline QEMU_ALWAYS_INLINE                            \
-void NAME##_host(void *vd, uint32_t idx, void *host)        \
-{                                                           \
-    ETYPE data = *((ETYPE *)vd + H(idx));                   \
-    STSUF##_p(host, data);                                  \
+#define GEN_VEXT_HOST_ST_ELEM(NAME, ETYPE, H, STSUF)                    \
+static inline QEMU_ALWAYS_INLINE                                        \
+void NAME##_host(void *vd, void *host, uint32_t idx, uint32_t evl)      \
+{                                                                       \
+    do {                                                                \
+        ETYPE data = *((ETYPE *)vd + H(idx));                           \
+        STSUF##_p(host, data);                                          \
+        host += sizeof(ETYPE);                                          \
+    } while (++idx < evl);                                              \
 }
 
 GEN_VEXT_TLB_ST_ELEM(ste_b, uint8_t,  H1, stb)
@@ -267,7 +283,16 @@ GEN_VEXT_TLB_ST_ELEM(ste_h, uint16_t, H2, stw)
 GEN_VEXT_TLB_ST_ELEM(ste_w, uint32_t, H4, stl)
 GEN_VEXT_TLB_ST_ELEM(ste_d, uint64_t, H8, stq)
 
+#if HOST_BIG_ENDIAN
 GEN_VEXT_HOST_ST_ELEM(ste_b, uint8_t,  H1, stb)
+#else
+static inline QEMU_ALWAYS_INLINE
+void ste_b_host(void *vd, void *host, uint32_t idx, uint32_t evl)
+{
+    memcpy(host, vd + idx, evl - idx);
+}
+#endif
+
 GEN_VEXT_HOST_ST_ELEM(ste_h, uint16_t, H2, stw_le)
 GEN_VEXT_HOST_ST_ELEM(ste_w, uint32_t, H4, stl_le)
 GEN_VEXT_HOST_ST_ELEM(ste_d, uint64_t, H8, stq_le)
@@ -284,33 +309,6 @@ vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
     }
 }
 
-static inline QEMU_ALWAYS_INLINE void
-vext_continuous_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
-                        void *vd, uint32_t evl, uint32_t reg_start, void *host,
-                        uint32_t esz, bool is_load)
-{
-    if (HOST_BIG_ENDIAN) {
-        for (; reg_start < evl; reg_start++, host += esz) {
-            ldst_host(vd, reg_start, host);
-        }
-    } else {
-        if (esz == 1) {
-            uint32_t byte_offset = reg_start * esz;
-            uint32_t size = (evl - reg_start) * esz;
-
-            if (is_load) {
-                memcpy(vd + byte_offset, host, size);
-            } else {
-                memcpy(host, vd + byte_offset, size);
-            }
-        } else {
-            for (; reg_start < evl; reg_start++, host += esz) {
-                ldst_host(vd, reg_start, host);
-            }
-        }
-    }
-}
-
 static void vext_set_tail_elems_1s(uint32_t vl, void *vd, uint32_t nf,
                                    uint32_t esz, uint32_t max_elems)
 {
@@ -334,7 +332,7 @@ static void vext_ldst_nf_host(void *vd, void *host, uint32_t i, uint32_t nf,
                               vext_ldst_elem_fn_host *ldst_host)
 {
     for (uint32_t k = 0; k < nf; k++, host += esz) {
-        ldst_host(vd, i + k * max_elems, host);
+        ldst_host(vd + k * max_elems, host, i, i + 1);
     }
 }
 
@@ -450,8 +448,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
      */
     if (flags == 0 && (riscv_cpu_cfg(env)->ext_zicclsm || !misaligned)) {
         if (nf == 1) {
-            vext_continuous_ldst_host(env, ldst_host, vd, evl, env->vstart,
-                                      host, esz, is_load);
+            ldst_host(vd, host, env->vstart, evl);
         } else {
             for (uint32_t i = env->vstart; i < evl; ++i) {
                 vext_ldst_nf_host(vd, host, i, nf, esz, max_elems, ldst_host);
-- 
2.43.0


