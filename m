Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B171EC5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKp-0007SY-P0; Sat, 15 Aug 2026 15:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKf-0007JS-Ft
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:19 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKb-0008Jt-JB
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2d5335cf904so11076965ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823172; x=1787427972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kIcqFilPWZIzxet5M1i5bmYJsXUO1m+vtWn5m97WeJ8=;
 b=D2a6AUzfxCR8ryziqEgbiCVpWMszK5EXUjfZ09Kley8m+qNcj+A9W40e37oqLj8nzy
 cwv8AvFh3nP7UGgUJ496arnmc7XvX4Lpbox9lXHli8mbLjALxgeP5tB4e904B9FTkOWG
 4I4nnXUgna9KI/Xoh6Po/nyx2rwhmJFF/+YV4OckwUPgkTOH3h32bMtWaMez9VY7BYNt
 LR+xcViDOWvozcMXVBJXnT6u/iaCrW33WHmxgVRi4pcUYBii7+5U9OzhMqWmiSCxdt5C
 T0dzfm6N1rq35XPm85sytQdTi7/hxnT4dhA7DMOR1JRzbq8ncEWtovSd6IZe2th/KYS0
 r1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823172; x=1787427972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kIcqFilPWZIzxet5M1i5bmYJsXUO1m+vtWn5m97WeJ8=;
 b=KCY8W1E232pkknr8tbwRfXKdMeTTmJjDtIt5efLmY62A7/g/qeVuvhPPE+7H8uZvVu
 rqMyBiOanFEcX2OEiN4l2Qi4mEOsx+FGlL2j65DrAwoVrsvNaow6x9gdGkqogwoBd0nr
 zCwvJa90KJhMiV+T/0Sw2Jtjep2B55SXk5G/oZFKGggkmRmjLPQKEvxgLtTy0VxFAAcp
 DqEvec/h9vUiJ9AQlA2D87zp7uuNTmwtRx3nm7rBPbyRvczAvAMYbKWHKiVKvy8W2v8u
 r7wvUCBGIWGXLGygdeNGYHDfm9LMneKN2p4ic7st48ObNYR9sM8ZD7C74zvNjiO/5oCi
 ni7g==
X-Gm-Message-State: AOJu0Yysudk+Xu1/AATPxm1sc4GK3Z9W+ezV2xnZ91LIy9PzER/Qkm8M
 mvFG0ZgMT4Dqx5bcOgDK6FMasjSzayS29xJcbUtpu5kCgIl5o0Js10b1mXOPRINEZa2pIR10O7S
 mDazD
X-Gm-Gg: AR+sD11g/Y5H74b9XuxhIu538u0GbURCgj1sFqgvrDtNffWQdawHJyuRKAC7qzKyq/3
 pCnS50LYtWXjcuxLGZrbbZzrMzLWSX+t7pBIgj4TFMyvZUJ/GbuiooCoGZ+PfKAxpfHGqkuj4w+
 LngGErnrllOQGT66ZB3YtzF4gfvDcLPTyhw7nwLTvzxOabEYx48pAzSJ9YYDBYTvPlsZQ0XnRJN
 7619pjUjPqhVsF8hhpEzc3IyfenB3+l697SQsBTi2kVAyoGFOF7IE/oWowJnTp54JL5yKddFa24
 x4hPSDLTZlF3sv7X5OqBAbEo7cFyZpcIpyT9i2ANagvUXp9PZ9E8SrejNcJSBB7j1f5mx2AxD2l
 xbHtJSVrV2r+Tw13BjYyEysbpoOosd8z3ZTcYQgLVVq+X9J/vtxB8oeVDj00ornX33WVpHi8hV2
 GF/JlhTDO5WlBej+h1shSEdCgDJkTYX1fA7Wafzvg0nQOzIUjGVt+xoy2W4C40iXregreSu6Ip6
 pQ2myOjNMtsosJ5vfZYTjaTpw==
X-Received: by 2002:a17:902:f647:b0:2c6:a772:7e43 with SMTP id
 d9443c01a7336-2d3b0cf4b68mr172787265ad.18.1786823172022; 
 Sat, 15 Aug 2026 12:46:12 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 12/23] target/riscv: Split out vext_ldst_us_desc
Date: Sat, 15 Aug 2026 12:45:37 -0700
Message-ID: <20260815194549.1377505-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Rename vext_ldst_us to vext_ldst_us_desc and split out
a new vext_ldst_us that doesn't use 'desc'.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 38 ++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index b482537f40..abb1ebcb43 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -478,15 +478,14 @@ static void vext_test_alignment(CPURISCVState *env, vaddr addr, uint32_t esz,
 }
 
 static inline QEMU_ALWAYS_INLINE void
-vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
+vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env,
+             uint32_t log2_esz, uint32_t nf, uint32_t evl,
+             uint32_t max_elems, bool vma,
              vext_ldst_elem_fn_tlb *ldst_tlb,
-             vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
-             uint32_t evl, uintptr_t ra, bool is_load)
+             vext_ldst_elem_fn_host *ldst_host,
+             uintptr_t ra, bool is_load)
 {
     target_ulong elems, addr, last, last_in_page, page_split;
-    uint32_t nf = vext_nf(desc);
-    uint32_t vma = vext_vma(desc);
-    uint32_t max_elems = vext_max_elems(desc, log2_esz);
     uint32_t esz = 1 << log2_esz;
     uint32_t msize = nf * esz;
     int mmu_index = riscv_env_mmu_index(env, false);
@@ -579,6 +578,17 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     }
 }
 
+static inline QEMU_ALWAYS_INLINE void
+vext_ldst_us_desc(void *vd, target_ulong base, CPURISCVState *env,
+                  uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
+                  vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
+                  uint32_t evl, uintptr_t ra, bool is_load)
+{
+    vext_ldst_us(vd, base, env, log2_esz, vext_nf(desc), evl,
+                 vext_max_elems(desc, log2_esz), vext_vma(desc),
+                 ldst_tlb, ldst_host, ra, is_load);
+}
+
 /*
  * masked unit-stride load and store operation will be a special case of
  * stride, stride = NF * sizeof (ETYPE)
@@ -596,8 +606,8 @@ void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,     \
 void HELPER(NAME)(void *vd, void *v0, target_ulong base,            \
                   CPURISCVState *env, uint32_t desc)                \
 {                                                                   \
-    vext_ldst_us(vd, base, env, desc, LOAD_FN_TLB, LOAD_FN_HOST,    \
-                 ctzl(sizeof(ETYPE)), env->vl, GETPC(), true);      \
+    vext_ldst_us_desc(vd, base, env, desc, LOAD_FN_TLB, LOAD_FN_HOST,    \
+                      ctzl(sizeof(ETYPE)), env->vl, GETPC(), true);      \
 }
 
 GEN_VEXT_LD_US(vle8_v,  int8_t,  lde_b_tlb, lde_b_host)
@@ -617,8 +627,8 @@ void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,          \
 void HELPER(NAME)(void *vd, void *v0, target_ulong base,                 \
                   CPURISCVState *env, uint32_t desc)                     \
 {                                                                        \
-    vext_ldst_us(vd, base, env, desc, STORE_FN_TLB, STORE_FN_HOST,       \
-                 ctzl(sizeof(ETYPE)), env->vl, GETPC(), false);          \
+    vext_ldst_us_desc(vd, base, env, desc, STORE_FN_TLB, STORE_FN_HOST,  \
+                      ctzl(sizeof(ETYPE)), env->vl, GETPC(), false);     \
 }
 
 GEN_VEXT_ST_US(vse8_v,  int8_t,  ste_b_tlb, ste_b_host)
@@ -634,8 +644,8 @@ void HELPER(vlm_v)(void *vd, void *v0, target_ulong base,
 {
     /* evl = ceil(vl/8) */
     uint8_t evl = (env->vl + 7) >> 3;
-    vext_ldst_us(vd, base, env, desc, lde_b_tlb, lde_b_host,
-                 0, evl, GETPC(), true);
+    vext_ldst_us_desc(vd, base, env, desc, lde_b_tlb, lde_b_host,
+                      0, evl, GETPC(), true);
 }
 
 void HELPER(vsm_v)(void *vd, void *v0, target_ulong base,
@@ -643,8 +653,8 @@ void HELPER(vsm_v)(void *vd, void *v0, target_ulong base,
 {
     /* evl = ceil(vl/8) */
     uint8_t evl = (env->vl + 7) >> 3;
-    vext_ldst_us(vd, base, env, desc, ste_b_tlb, ste_b_host,
-                 0, evl, GETPC(), false);
+    vext_ldst_us_desc(vd, base, env, desc, ste_b_tlb, ste_b_host,
+                      0, evl, GETPC(), false);
 }
 
 /*
-- 
2.43.0


