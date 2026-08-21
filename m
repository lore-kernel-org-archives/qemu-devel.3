Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C154C5DF88
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUP-00062K-L5; Fri, 21 Aug 2026 00:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUN-00061D-P6
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:19 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUM-0003BN-4L
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:19 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so542837a91.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285056; x=1787889856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zWgraQC/iHNbGM9tiX/UbYCokd7ddZcoQW3LV3tut1Y=;
 b=cwqOSzB68ZApWVC/fts6+2aN5qK0BUqa34mJoXwLrsZhWakvdTWkIvprfbssFNjdws
 Ad6FtvN93M/HMEVFDPSN9pwJKIk4ytSUOjI6fTP3LCc1rvaCp1H11liJVnVf8rJxHabw
 BzaQFYsYx+Y8c/LPnTNA93rd92BqBLGed21pYTH2VeXRzmHM2Ca1br1VPBhBswN6zcuh
 ZqbOto2YdfQy8IWS/BuVMKn6VIwRz8ShruBlxW+L/XS2c4929s3vc3Zs6XXqV+u1C1Sl
 IO4WkraOY3Qi87B69zT/SE9TyF5cB/cQ2UUrDZZmpvqTLR4fn8Y7qgdTVogqlrqsX+jI
 +13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285056; x=1787889856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zWgraQC/iHNbGM9tiX/UbYCokd7ddZcoQW3LV3tut1Y=;
 b=gC9/0o2xL5HXDHU69ycavEMLAFsrp7lr5zoYZGtv8uNdjOU58pf2aeV302yB3JIs2Z
 sx864uBugOk3IlP//k1z7htxHOMIZx44liRKyZYFkTA9uYZO7f94IDvPYaRNxf6dQxXi
 ZYTznvV+LGguD5Ap9XBlZJHwJvWlR6SXwnhh8Hfsb2shg+oNcpfBJTc0RRTSDfq+agF3
 NMu/llJ1rgViQxlkK7jqduIrCPUIgma9/ilgraYtqGtS38g/O1Ra6uTPFdhJws1ltcNA
 yfddznuOwXkJAQqCwyzlMJ1O9iK0xo1od4u1Pg6cd16ByI69M3LMBOyg13Vv3Y7F2fqQ
 99wA==
X-Gm-Message-State: AFuF++k+qvnJOphhxlE0rCVK6z4QtwSTgico8N86yVad0DTWFrHI1NdR
 U3TfUs1IyxwJi7yZ1dvHEhLOktKXtL2niE6pmEaSnj/316tgJ9XfprxBVFMItUxakdctRguedFq
 1UaEg
X-Gm-Gg: AR+sD11ecQGe1jf7ry4y5eySwDzUXaIfrXKIIAbePrktLQ4n1Mu8SX+OqT933johz/+
 j1D3Zit3tNz7ihgRetUpW0nIVstQXMIn1ZcDUFYkS0Er70fvszWWLeWuUduE4EEKXyZ6PmumIqC
 clqh+dARg77PQyOAwCn9hwzNG6xgkM26nQXsI0gqYEDE+XnQ0zI0NUZohUasu+i8sBuQAMacDfX
 sehqfQX3rCQMHEFatCttS2FarBvzuD2sMyz55X5XDsOwEb5Agj/5IRkTsiec6DBMp5MALAG8nJe
 cWjr1hvgdZyxl4OS1JZTgQPoEaRxVYUUgvtL/aIqrpAXa7eVfN4jSelSnEdKoxeXdj6YahIOIyy
 9PzsJMriC5sEM44esRaQq/8Fdzrc25vLqs2Dw2f2LglikKIGKYmyH4IPOn0UnEAEtnp5BrqhTPo
 4GJ71Jt+g0Y+E5pyy/8nThHWLWL2uxLLzCzNmMmvrt8PNu9lBZQLgGVHDza+F3WnMthyk=
X-Received: by 2002:a17:90a:da87:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-395c3731c29mr6565696a91.12.1787285056488; 
 Thu, 20 Aug 2026 21:04:16 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 07/23] target/riscv: Split out vext_page_ldst_us_{host, tlb}
Date: Thu, 20 Aug 2026 21:03:48 -0700
Message-ID: <20260821040404.268123-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Split out the tail of vext_page_ldst_us, after probing.
Merge vext_continuous_ldst_host into vext_page_ldst_us.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 101 ++++++++++++++++---------------
 1 file changed, 51 insertions(+), 50 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 18840336cb..505f0331f2 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -275,33 +275,6 @@ GEN_VEXT_HOST_ST_ELEM(ste_h, uint16_t, H2, stw_le)
 GEN_VEXT_HOST_ST_ELEM(ste_w, uint32_t, H4, stl_le)
 GEN_VEXT_HOST_ST_ELEM(ste_d, uint64_t, H8, stq_le)
 
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
 static void vext_set_tail_elems_1s(uint32_t vl, void *vd,
                                    uint32_t desc, uint32_t nf,
                                    uint32_t esz, uint32_t max_elems)
@@ -411,6 +384,52 @@ GEN_VEXT_ST_STRIDE(vsse64_v, int64_t, ste_d_tlb)
  */
 
 /* unmasked unit-stride load and store operation */
+static inline QEMU_ALWAYS_INLINE void
+vext_page_ldst_us_host(void *vd, void *host, uint32_t i, uint32_t evl,
+                       uint32_t nf, uint32_t log2_esz, uint32_t max_elems,
+                       vext_ldst_elem_fn_host *ldst_host, bool is_load)
+{
+    uint32_t esz = 1 << log2_esz;
+
+    if (nf == 1) {
+        if (!HOST_BIG_ENDIAN && esz == 1) {
+            size_t size = evl - i;
+            if (is_load) {
+                memcpy(vd + i, host, size);
+            } else {
+                memcpy(host, vd + i, size);
+            }
+        } else {
+            do {
+                ldst_host(vd, i, host);
+                host += esz;
+            } while (++i < evl);
+        }
+    } else {
+        uint32_t msize = nf << log2_esz;
+        do {
+            vext_ldst_nf_host(vd, host, i, nf, esz, max_elems, ldst_host);
+            host += msize;
+        } while (++i < evl);
+    }
+}
+
+static inline QEMU_ALWAYS_INLINE void
+vext_page_ldst_us_tlb(CPURISCVState *env, void *vd, target_ulong addr,
+                      uint32_t i, uint32_t evl, uint32_t nf,
+                      uint32_t log2_esz, uint32_t max_elems,
+                      vext_ldst_elem_fn_tlb *ldst_tlb,
+                      int mmu_index, uintptr_t ra)
+{
+    uint32_t esz = 1 << log2_esz;
+    uint32_t msize = nf << log2_esz;
+    do {
+        vext_ldst_nf_tlb(env, vd, addr, i, nf, esz, max_elems, ldst_tlb, ra);
+        addr += msize;
+        env->vstart = ++i;
+    } while (i < evl);
+}
+
 static inline QEMU_ALWAYS_INLINE void
 vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
                   uint32_t elems, uint32_t nf, uint32_t max_elems,
@@ -420,39 +439,21 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
 {
     void *host;
     int flags;
-    uint32_t esz = 1 << log2_esz;
     uint32_t size = (elems * nf) << log2_esz;
-    uint32_t msize = nf * esz;
-    uint32_t evl = env->vstart + elems;
+    uint32_t i = env->vstart;
     MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
 
-    /*
-     * Maximum vector length is VLMAX == 2^16 == LMUL * VL / SEW, and
-     * occurs for LMUL == 8, SEW == 8, VL == 2^16.
-     */
-    g_assert(env->vstart < UINT16_MAX && UINT16_MAX - env->vstart >= elems);
-
     /* Check page permission/pmp/watchpoint/etc. */
     probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &flags,
                 true);
 
     if (flags == 0) {
-        if (nf == 1) {
-            vext_continuous_ldst_host(env, ldst_host, vd, evl, env->vstart,
-                                      host, esz, is_load);
-        } else {
-            for (uint32_t i = env->vstart; i < evl; ++i) {
-                vext_ldst_nf_host(vd, host, i, nf, esz, max_elems, ldst_host);
-                host += msize;
-            }
-        }
+        vext_page_ldst_us_host(vd, host, i, i + elems, nf, log2_esz,
+                               max_elems, ldst_host, is_load);
         env->vstart += elems;
     } else {
-        for (uint32_t i = env->vstart; i < evl; env->vstart = ++i) {
-            vext_ldst_nf_tlb(env, vd, addr, i, nf, esz,
-                             max_elems, ldst_tlb, ra);
-            addr += msize;
-        }
+        vext_page_ldst_us_tlb(env, vd, addr, i, i + elems, nf, log2_esz,
+                              max_elems, ldst_tlb, mmu_index, ra);
     }
 }
 
-- 
2.43.0


