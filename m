Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA849C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUn-0006HX-V7; Fri, 21 Aug 2026 00:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUV-00067j-Qx
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:29 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUS-0003EN-1W
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:25 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c96b08cdd1cso485851a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285062; x=1787889862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=68pOmPzSVLedIxa6xDxSTghcazTA2dqFNSAoW+HSS78=;
 b=zgx0Q3Uvi5gGdT5PuYekznxAqFy1c4+8a7isMEBvB9gGXPNRL6pXxEV15JTykx/rOo
 Pjm2G3qXsCjsejL1DiMiNjd+ErVrfYcZNxWz017lwU/RXpBZdtw+Sz7J50H9QquSTk3Q
 L6Y7D/vQR14olT/QmggNK3td6jWFJfQ9HyiDBWi1D18Za1hH+ivFLcvifBTPoAUx1eed
 SGQ5Ie8jDLwIN9Nn4y1msHlAeMptSwrVPHnVlAE7b+Bh3BgPrces9ZBH574J4fceXpdG
 L0nZ4rgMwSERPBGrrMIe9t+ylgFLVadOxE7SCYFLuPrLFOFMuCx7jHx1n6gyWyIHv47v
 yfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285062; x=1787889862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=68pOmPzSVLedIxa6xDxSTghcazTA2dqFNSAoW+HSS78=;
 b=Cf1Pt18MVDI+iox/gjmXSTASjBP/n5xNKw2UCN2e2WuF1djVDmXeLdH4G+skS3oH14
 ryoNAdS3ljbyaIIzv8Vweyydvt5SEd9f8vzfqI0/YliroMovek/YztU27fZnfk70xGlT
 PwdLkPHjxXwCuMelYE6uyxidHP87s23405uXahd67rkB3A4LJ34APWDPnCEByXxJb6m8
 d649UIWO/OMWFQqxD7XUcVhGpn8icR/KOyD4kBRU4P/qUmCN4jQDCP0B8ohpnkakORIx
 rPGIOtgHuYHYe8lHjoyQGeUTyW+ybnS2g4EwfA+CC3pF/q/oBE4y9BLDTOXXbNmXRUET
 4zVA==
X-Gm-Message-State: AFuF++lFRBKmDCA+AfJ7K1UthGG7LPbPtmlG/2F4vjZXvIXjJa/B6fDJ
 G355GKUkjhEcG0LQw4wu0OfAo0kOMNSXhE9sdi7HUCWQ2Fo6hvTtIvr6JP2VOGw/Oj05MgJLZR8
 hLUM7
X-Gm-Gg: AR+sD11ar1w3KMbfJTHg1CYEXdHoWAt+wGkf0DI31KKXjXBUt0kYIJ8eP+rM5kapFFx
 3Lw4ZUZVXRqgN3wCPaH04SLmA0R8lPqK8AbuU0x+wgorp7XuO+t3wX+wbUdK+YGsQCsbzB8TPnF
 Opmjy3qKA6hC0ciYYaKAZHzJQXkTZ4AxAauDtU5x/d5OAVjTJCvhZaTEZmTYhkeik8eoatE2thU
 nAHlnyRYZsMEerOi2IBaBER9EMT//U8zYH2Nm/0SkP9YaDy/m6Y6Kp3A1rDF2rM6uh1bRW+MLzF
 gVzF1PyZhpKS9ykNJF+3l122yYpWlD9Ja+iPvFn+XvPCPRLcpmB9l6GV1/kZv1UZZlvqlLUDa03
 cIZoPmOGl3weyi83KQTC0YfLEJqM/bLcr67WRwTBOO3xPWaBsy/4YSGh9rSidlys0LMQUwOPLCC
 pvfg1tLr0bD0WXevH530OQW0WLx3x6Ifp9wGPSU1Wai8kyVMHUKynsmjYanYeCbunkizM=
X-Received: by 2002:a17:90b:1b05:b0:38e:67e1:15b with SMTP id
 98e67ed59e1d1-395c353226dmr5177944a91.6.1787285062470; 
 Thu, 20 Aug 2026 21:04:22 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 15/23] target/riscv: Pass MemOpIdx to vext_ldst_us
Date: Thu, 20 Aug 2026 21:03:56 -0700
Message-ID: <20260821040404.268123-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Use mmu data passed in with VDATA.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 76990894e5..9b0c3f70c2 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -158,6 +158,19 @@ static inline void vext_set_elem_mask(void *v0, int index,
     ((uint64_t *)v0)[idx] = deposit64(old, pos, 1, value);
 }
 
+static inline MemOpIdx vext_oi(uint32_t desc, MemOp memop)
+{
+    uint32_t data = simd_data(desc);
+
+    if (FIELD_EX32(simd_data(desc), VDATA, BSWAP)) {
+        memop |= MO_BSWAP;
+    }
+    if (FIELD_EX32(simd_data(desc), VDATA, ALIGN)) {
+        memop |= MO_ALIGN;
+    }
+    return make_memop_idx(memop, FIELD_EX32(data, VDATA, MEM_IDX));
+}
+
 static inline MemOpIdx vext_make_memop_idx(CPURISCVState *env, size_t size)
 {
     int mmu_idx = riscv_env_mmu_index(env, false);
@@ -406,12 +419,12 @@ vext_ldst_us_notail(void *vd, target_ulong base, CPURISCVState *env,
                     uint32_t max_elems, bool vma,
                     vext_ldst_elem_fn_tlb *ldst_tlb,
                     vext_ldst_elem_fn_host *ldst_host,
-                    uintptr_t ra, bool is_load)
+                    uintptr_t ra, bool is_load, MemOpIdx oi)
 {
     target_ulong elems, addr, last, last_in_page, page_split;
     uint32_t esz = 1 << log2_esz;
     uint32_t msize = nf * esz;
-    int mmu_index = riscv_env_mmu_index(env, false);
+    int mmu_index = get_mmuidx(oi);
     MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
     uint32_t i = env->vstart;
     void *host;
@@ -505,7 +518,8 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
 
     vext_ldst_us_notail(vd, base, env, log2_esz, vext_nf(desc), evl, max_elems,
-                        vext_vma(desc), ldst_tlb, ldst_host, ra, is_load);
+                        vext_vma(desc), ldst_tlb, ldst_host, ra, is_load,
+                        vext_oi(desc, log2_esz));
 
     env->vstart = 0;
     vext_set_tail_elems_1s(evl, vd, desc, nf, 1 << log2_esz, max_elems);
@@ -947,7 +961,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t evl = (riscv_cpu_cfg(env)->vlenb * vext_nf(desc)) >> log2_esz;
 
     vext_ldst_us_notail(vd, base, env, log2_esz, 1, evl, evl, false,
-                        ldst_tlb, ldst_host, ra, is_load);
+                        ldst_tlb, ldst_host, ra, is_load,
+                        vext_oi(desc, log2_esz));
     env->vstart = 0;
 }
 
-- 
2.43.0


