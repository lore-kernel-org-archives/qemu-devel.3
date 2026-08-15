Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C57C5DF70
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKp-0007SA-93; Sat, 15 Aug 2026 15:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKb-0007JC-G0
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:18 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKY-0008Ih-OD
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:12 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ccf2360620so21440535ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823169; x=1787427969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GgeC2Gz0Cy5NIUncliWwHs8r8iCx5AzYcDVo3ksrI48=;
 b=PgqeUTJALDRCrFqF9ysOwv1NejWOoeDT8+YqgaeTrGPlRHV88HjgQszNxu4XyupCKj
 uyUzJWNfCtg4H0EL3MpSW9XpBTrbwMm8pwEnRWMNRgbkzR3UojunpQCFotTLBQd0DkqP
 snSTri5iqa2ncIwz27aw6r5VpYKsquTLjyDUZsoyHrH6awIswtRyWjGNLvx6ULxhd7ya
 JEgU4pcn9vKbTaqdvhAGfZL35FktTZSw0CP8PhzAm09GrUzHuCARJUJzi8+Hk63MCi3O
 +Ne0fmdmLX1uWNjq7bTQ0vi4oHZLVEg2km7xC776h0iphmDt99hv3SgsdShLSQzq26Dm
 3XXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823169; x=1787427969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GgeC2Gz0Cy5NIUncliWwHs8r8iCx5AzYcDVo3ksrI48=;
 b=PK22vNRwzRhbPNTLW8Piy/La5U0lRsKGQvh+ksHhm+Eiq8eAxN/cE2QycW1pB/1T4U
 T/W2pTgntJnHUvlhLUpJ1RI3BIHKcmdOFUAsjwa6S2N98oLd/mi3Tiv0nYTucLbIquVV
 fwkaTdjP/xf6Ho3QBgreLFgVWGRChV0ZIu80b9vwX7E4cqaZU7J54LGztUxgtzsIi72K
 pqmN9s6LXU/2GyaV2Vq1+dqTA7Ak5MYHPu1csgt0VeYx4RoiECYLe1qiJ7a4jx9Co7s8
 +UZKufa+dDncH6skslH3U7R1X5PjmqHA1nzZnjEz8j46ujmpUjyH7ju62U5vj7FjE/Oz
 JXCA==
X-Gm-Message-State: AOJu0Yw0qR/il+YcyQ7EyYygPsp7e/B2L2DbLNMy/qQYcQH4kTOdKHsD
 MhLlZE3E9a7T0P/YCQ54AvLHcCc90CitbX4QLG7x9qQLpNn6Sm9qRAI+tCteR4wFjI8l+nbloQy
 wAu1J
X-Gm-Gg: AR+sD11tLxBqhuzHbVQfZ9UXSVnaGtOLxIlcChBFE8cECatP4hTXUBEnLzZA+541nlv
 yM7Z6cOLqmTEU5zs9ly0uC3mUFl95cYgtYHP+FyN6nRldgVPE73j8irAucmX57KG7q4QLKc43QS
 quxYs1jVFDqOovfmefH9EPR5z4I3jEVou8MxDVUHK6lLOiLT/i0YyPkm6B3ZK0RJmroBeP5PovH
 TJexUyHvkhwRmpYlm3BkWojh92TgXfeUAsg4cvuBIU81+uVNHIIkESts6+6rku93DXnXjSZwpWs
 fbGW+9agO18VWnEl+5iUc3EiGkgPAruiqt3zYv8ImW6biXND57CGWHlIRNb0EFfhSKv2qDyyWOj
 PDNPrUlIWfozmY/QsAiqDLBUTNHvNForp8ZWFUQv2A8ashGu2KxLYQSzOAs6ZERF8Eq9Zl678ro
 zVL6os8BfuHk4hOfRyMVgoJVq2Imc7BJkYkg/0TyrVeHXLacDJ/fu6Po9hTalt6bCrngH+KzTZ6
 u7Tek9jxJD8/OvTgB5P
X-Received: by 2002:a17:903:360c:b0:2ca:b8fd:f31 with SMTP id
 d9443c01a7336-2d3b0d5e37amr160724755ad.15.1786823169041; 
 Sat, 15 Aug 2026 12:46:09 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 09/23] target/riscv: Split out vext_page_ldst_us_{host,tlb}
Date: Sat, 15 Aug 2026 12:45:34 -0700
Message-ID: <20260815194549.1377505-10-richard.henderson@linaro.org>
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

Split out the tail of vext_page_ldst_us, after probing.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 60 ++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 12ef020840..7f721dc24d 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -403,6 +403,39 @@ GEN_VEXT_ST_STRIDE(vsse64_v, int64_t, ste_d_tlb)
  */
 
 /* unmasked unit-stride load and store operation */
+static inline QEMU_ALWAYS_INLINE void
+vext_page_ldst_us_host(void *vd, void *host, uint32_t i, uint32_t evl,
+                       uint32_t nf, uint32_t log2_esz, uint32_t max_elems,
+                       vext_ldst_elem_fn_host *ldst_host)
+{
+    if (nf == 1) {
+        ldst_host(vd, host, i, evl);
+    } else {
+        uint32_t esz = 1 << log2_esz;
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
@@ -412,38 +445,21 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
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
-            ldst_host(vd, host, env->vstart, evl);
-        } else {
-            for (uint32_t i = env->vstart; i < evl; ++i) {
-                vext_ldst_nf_host(vd, host, i, nf, esz, max_elems, ldst_host);
-                host += msize;
-            }
-        }
+        vext_page_ldst_us_host(vd, host, i, i + elems, nf,
+                               log2_esz, max_elems, ldst_host);
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


