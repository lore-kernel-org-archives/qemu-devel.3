Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E5AC5DF88
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUz-0006S6-TF; Fri, 21 Aug 2026 00:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUZ-00068M-Nd
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:33 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUV-0003Fn-JX
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:29 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso675541a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285066; x=1787889866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HRZwvHbqGF3WUpbuWxH7XOYS4tVXJqwo7euDjl4jlvQ=;
 b=hMmuiNoj5N1x1+JRJ0aNhEgvwX+vL0pkWYqtn1MyWr77//LXYhJf5ILuobSdWuYKFp
 A2BpQ30iO0R4lhhBBls2IjAz1Nwosu4oghwvIpGsuG18mFmJCA0xPuC9XX110PeHwl+g
 MxFNZi+529NBwY83JEk8ys+KrublwiNIJGci0OwLy2P+1spWDhrd0hnLlX3wAk12o1WN
 7pUTlN/ip3hb71syWlCLmycpn/Kfzp2Fzjh5ZIBaeS3rkXtwXqGNXuobqtul67Hocrk2
 scQoL2f79F2BWMMSkiMo72EyFAld4skddBFkyUAUD+NjHfgZoRxMqJSLu1uIsnzPqM0P
 IkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285066; x=1787889866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HRZwvHbqGF3WUpbuWxH7XOYS4tVXJqwo7euDjl4jlvQ=;
 b=LPrAoDlX0w+SkHs2iYo2Eq+0TiyDC09Oz1/8xAffCv2wBT0dvA4tcJrxmurTMc91eh
 aSOA34dgh83W0k9Pl6XU7iCS9XQIpJkXyeBB2RiHXQKufhxd9ZiblQ9li3yL4B1IPm3I
 7gPn1epsJnmA3aPP9HYbGt9iTCD+m4l2rA69vHbcX+qrOeaABkGo45vqUzhZgZia/YI4
 dV4C0k0m3JPwbhnibPBXzhpd/hRKkX4jb2l+XBOVcr9capTAju2c+r2yGeeXa+TkNgyj
 dngyIp365l7+VkbqtGr6QCtmOWhkZ5/oyykN9mU3jCbiRczOKq+MgsxyOeS+MtFw2ana
 5U5g==
X-Gm-Message-State: AFuF++k6qHUCj0inlwZynnNKzrliGIS7RQ+6jMznS1O2e+c+MgJ/NQXp
 odowSKpfLGLSr6lWo1sYw0aIWOGbQE+PKi3L8ih9tkoGK9KKBecO5xfrdca+NgW8dD7/FCIRJ9O
 0PcNv
X-Gm-Gg: AR+sD139ODCpqBHgDyhFmXlQBbIiI8aP8rL8G2l43Q5c0DJYUs2/hkIkA2CPjANnDKL
 TdSol4/D2IjWQK/I7oaMuqzRxXWEFcjGrC4ClsAq756KA4YG6NiEKcQHVz5kVGel6E1wUNthNK9
 i3PARXDt/hGCQqB13nq5g5Go/kvlbqgWHkmwFgBmzOBx4GVG4/OdMMT5Bo+EC5fEpkOholQOiO9
 qawbLrSwvns5FZhgi+AX8a7BDEk/DYxm2z0rDaVxgoxt75HHfA3x4NIwpWt8stnglHsxwGw2Brl
 gUP9qI4sIfcJnCivFf54aLakvAXxEWZk5qZ/9z7M5IgOKYG+RFhCdhnh6OCsmY8gAdnhv/rvWPf
 y3hAhiVE+v/sx0O+t2aXDC0Ze8pI32C2CTtvZbC/i/67RyZbgnUzuDmRd8Thw+vxD8ZFLpFvjg1
 mSt0o7Nh5bVLXz8gi09lkl6ZmurUmc69+qu+wLrAmZStFA3+X6uqzdEB/kcvu+FCbyUN4=
X-Received: by 2002:a17:90b:2687:b0:38f:26c7:165e with SMTP id
 98e67ed59e1d1-395c383cae0mr6624780a91.9.1787285066060; 
 Thu, 20 Aug 2026 21:04:26 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 19/23] target/riscv: Drop v0 argument from
 gen_helper_ldst_us
Date: Thu, 20 Aug 2026 21:04:00 -0700
Message-ID: <20260821040404.268123-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Since we're also passing env, v0 is always env->vreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                       | 44 ++++++++++-----------
 target/riscv/tcg/vector_helper.c            | 34 ++++++++--------
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 25 ++++--------
 3 files changed, 47 insertions(+), 56 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 4fc2d3a155..8a42a6ce03 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -161,24 +161,24 @@ DEF_HELPER_FLAGS_3(hyp_hsv_d, TCG_CALL_NO_WG, void, env, tl, tl)
 
 /* Vector functions */
 DEF_HELPER_4(vsetvl, tl, env, tl, tl, tl)
-DEF_HELPER_5(vle8_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle16_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle32_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle64_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle8_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle16_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle32_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle64_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse8_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse16_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse32_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse64_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse8_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse16_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse32_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse64_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlm_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vsm_v, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_4(vle8_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle16_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle32_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle64_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle8_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle16_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle32_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle64_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse8_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse16_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse32_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse64_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse8_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse16_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse32_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse64_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vlm_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vsm_v, void, ptr, tl, env, i32)
 DEF_HELPER_6(vlse8_v, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vlse16_v, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vlse32_v, void, ptr, ptr, tl, tl, env, i32)
@@ -219,10 +219,10 @@ DEF_HELPER_6(vsxei64_8_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxei64_16_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_5(vle8ff_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle16ff_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle32ff_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle64ff_v, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_4(vle8ff_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle16ff_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle32ff_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle64ff_v, void, ptr, tl, env, i32)
 
 DEF_HELPER_4(vl1re8_v, void, ptr, tl, env, i32)
 DEF_HELPER_4(vl1re16_v, void, ptr, tl, env, i32)
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index c5b4085f9c..66a5f68de8 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -277,11 +277,12 @@ static void vext_ldst_nf_tlb(CPURISCVState *env, void *vd, target_ulong addr,
  * stride: access vector element from strided memory
  */
 static void
-vext_ldst_stride(void *vd, void *v0, target_ulong base, target_ulong stride,
+vext_ldst_stride(void *vd, target_ulong base, target_ulong stride,
                  CPURISCVState *env, uint32_t desc, uint32_t vm,
                  vext_ldst_elem_fn_tlb *ldst_elem, uint32_t log2_esz,
                  uintptr_t ra)
 {
+    void *v0 = env->vreg;
     uint32_t nf = vext_nf(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
     uint32_t esz = 1 << log2_esz;
@@ -309,7 +310,7 @@ QEMU_FLATTEN void HELPER(NAME)(void *vd, void * v0, target_ulong base,  \
                                uint32_t desc)                           \
 {                                                                       \
     uint32_t vm = vext_vm(desc);                                        \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, vm, LOAD_FN,      \
+    vext_ldst_stride(vd, base, stride, env, desc, vm, LOAD_FN,          \
                      ctzl(sizeof(ETYPE)), GETPC());                     \
 }
 
@@ -324,7 +325,7 @@ QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong base,   \
                                uint32_t desc)                           \
 {                                                                       \
     uint32_t vm = vext_vm(desc);                                        \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, vm, STORE_FN,     \
+    vext_ldst_stride(vd, base, stride, env, desc, vm, STORE_FN,         \
                      ctzl(sizeof(ETYPE)), GETPC());                     \
 }
 
@@ -518,14 +519,14 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
  */
 
 #define GEN_VEXT_LD_US(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)          \
-QEMU_FLATTEN void HELPER(NAME##_mask)(void *vd, void *v0,               \
-    target_ulong base, CPURISCVState *env, uint32_t desc)               \
+QEMU_FLATTEN void HELPER(NAME##_mask)(void *vd, target_ulong base,      \
+                                      CPURISCVState *env, uint32_t desc) \
 {                                                                       \
     uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));             \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, false,            \
+    vext_ldst_stride(vd, base, stride, env, desc, false,                \
                      LOAD_FN_TLB, ctzl(sizeof(ETYPE)), GETPC());        \
 }                                                                       \
-QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong base,   \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, target_ulong base,             \
                                CPURISCVState *env, uint32_t desc)       \
 {                                                                       \
     vext_ldst_us(vd, base, env, desc, LOAD_FN_TLB, LOAD_FN_HOST,        \
@@ -538,14 +539,14 @@ GEN_VEXT_LD_US(vle32_v, int32_t, lde_w_tlb, lde_w_host)
 GEN_VEXT_LD_US(vle64_v, int64_t, lde_d_tlb, lde_d_host)
 
 #define GEN_VEXT_ST_US(NAME, ETYPE, STORE_FN_TLB, STORE_FN_HOST)         \
-QEMU_FLATTEN void HELPER(NAME##_mask)(void *vd, void *v0,                \
-    target_ulong base, CPURISCVState *env, uint32_t desc)                \
+QEMU_FLATTEN void HELPER(NAME##_mask)(void *vd, target_ulong base,       \
+                                      CPURISCVState *env, uint32_t desc) \
 {                                                                        \
     uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));              \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, false,             \
+    vext_ldst_stride(vd, base, stride, env, desc, false,                 \
                      STORE_FN_TLB, ctzl(sizeof(ETYPE)), GETPC());        \
 }                                                                        \
-QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong base,    \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, target_ulong base,              \
                                CPURISCVState *env, uint32_t desc)        \
 {                                                                        \
     vext_ldst_us(vd, base, env, desc, STORE_FN_TLB, STORE_FN_HOST,       \
@@ -560,7 +561,7 @@ GEN_VEXT_ST_US(vse64_v, int64_t, ste_d_tlb, ste_d_host)
 /*
  * unit stride mask load and store, EEW = 1
  */
-QEMU_FLATTEN void HELPER(vlm_v)(void *vd, void *v0, target_ulong base,
+QEMU_FLATTEN void HELPER(vlm_v)(void *vd, target_ulong base,
                                 CPURISCVState *env, uint32_t desc)
 {
     /* evl = ceil(vl/8) */
@@ -569,7 +570,7 @@ QEMU_FLATTEN void HELPER(vlm_v)(void *vd, void *v0, target_ulong base,
                  0, evl, GETPC(), true);
 }
 
-QEMU_FLATTEN void HELPER(vsm_v)(void *vd, void *v0, target_ulong base,
+QEMU_FLATTEN void HELPER(vsm_v)(void *vd, target_ulong base,
                                 CPURISCVState *env, uint32_t desc)
 {
     /* evl = ceil(vl/8) */
@@ -685,10 +686,11 @@ GEN_VEXT_ST_INDEX(vsxei64_64_v, int64_t, idx_d, ste_d_tlb)
  * unit-stride fault-only-fisrt load instructions
  */
 static void
-vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
+vext_ldff(void *vd, target_ulong base, CPURISCVState *env,
           uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
           vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz, uintptr_t ra)
 {
+    void *v0 = env->vreg;
     uint32_t i = env->vstart, vl = env->vl;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
@@ -916,10 +918,10 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
 }
 
 #define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)           \
-QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong base,   \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, target_ulong base,             \
                                CPURISCVState *env, uint32_t desc)       \
 {                                                                       \
-    vext_ldff(vd, v0, base, env, desc, LOAD_FN_TLB,                     \
+    vext_ldff(vd, base, env, desc, LOAD_FN_TLB,                         \
               LOAD_FN_HOST, ctzl(sizeof(ETYPE)), GETPC());              \
 }
 
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index 3916236762..3d32564660 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -690,8 +690,7 @@ static uint8_t vext_get_emul(DisasContext *s, uint8_t eew)
 /*
  *** unit stride load and store
  */
-typedef void gen_helper_ldst_us(TCGv_ptr, TCGv_ptr, TCGv,
-                                TCGv_env, TCGv_i32);
+typedef void gen_helper_ldst_us(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
 
 static uint32_t vdata_add_memopidx(DisasContext *s, uint32_t data)
 {
@@ -705,14 +704,10 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
                           gen_helper_ldst_us *fn, DisasContext *s,
                           bool is_store)
 {
-    TCGv_ptr dest, mask;
-    TCGv base;
+    TCGv_ptr dest = tcg_temp_new_ptr();
+    TCGv base = get_gpr(s, rs1, EXT_NONE);
     TCGv_i32 desc;
 
-    dest = tcg_temp_new_ptr();
-    mask = tcg_temp_new_ptr();
-    base = get_gpr(s, rs1, EXT_NONE);
-
     /*
      * As simd_desc supports at most 2048 bytes, and in this implementation,
      * the max vector group length is 4096 bytes. So split it into two parts.
@@ -725,7 +720,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
                                       s->cfg_ptr->vlenb, data));
 
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
-    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
     /*
      * According to the specification
@@ -745,7 +739,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
 
     mark_vs_dirty(s);
 
-    fn(dest, mask, base, tcg_env, desc);
+    fn(dest, base, tcg_env, desc);
 
     if (!is_store && s->ztso) {
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
@@ -1133,22 +1127,17 @@ GEN_VEXT_TRANS(vsxei64_v, MO_64, rnfvm, st_index_op, st_index_check)
 static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
                        gen_helper_ldst_us *fn, DisasContext *s)
 {
-    TCGv_ptr dest, mask;
-    TCGv base;
+    TCGv_ptr dest = tcg_temp_new_ptr();
+    TCGv base = get_gpr(s, rs1, EXT_NONE);
     TCGv_i32 desc;
 
-    dest = tcg_temp_new_ptr();
-    mask = tcg_temp_new_ptr();
-    base = get_gpr(s, rs1, EXT_NONE);
-
     data = vdata_add_memopidx(s, data);
     desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
                                       s->cfg_ptr->vlenb, data));
 
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
-    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
-    fn(dest, mask, base, tcg_env, desc);
+    fn(dest, base, tcg_env, desc);
 
     finalize_rvv_inst(s);
 
-- 
2.43.0


