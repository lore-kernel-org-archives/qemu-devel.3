Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF02FC5DF88
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGV1-0006Sl-6b; Fri, 21 Aug 2026 00:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUc-00069F-2v
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:35 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUX-0003GO-Ei
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:33 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so503030a91.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285068; x=1787889868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7DhfVuYLFdEoMKrZZuk/ONJCjnZ312P16LOTlvJKbjU=;
 b=L2ciFoAHp442rdiFdzfDmjVbiBK3QbQeXmw5xWXkOQ7DXN2bEeU+9sieByBl6pYANf
 d5VAJ2yJVo6gBGyngQQ81jdbtU6Mu/IGs4/tfnemHjKo/XSC4OMCLLIT3ZNJqoGLVRr7
 FjPfUW3kOegGz5ilMB9fBlzlQ611pfm56qGIr9ahtPY66czYq64hZoVHBJ5TwLwmsZhe
 0gfk+QG5OoniWTOtgURG5fRpXdL1XJNEOIMqt4DPi059K8C2F8gkJqc+q5HyDn9AnyuP
 CX9X59Lr1hMc27eYf+mlQkv8uFf92yCIHmER274EgcBxQ6ML3+lsjWqFgFhrmJZ+XeWx
 OoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285068; x=1787889868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7DhfVuYLFdEoMKrZZuk/ONJCjnZ312P16LOTlvJKbjU=;
 b=mGVsjh79meJy2DQ1DD02aZsM5imljhHlzGqG78Nrp2PIeiPDL/smQL08nQmbxBksGX
 75kJQAKfClVUxCqcnhgeBPOmEiKYi/GxhJU6H3Rs1NIglhHs4XnF4jAHWsaDGfhZ4hmF
 K5d7ZEXtXEivxsSLnAMPtTKJRjN4cLPR3v2qLHrBlsOTYx4dJW7vheciddZ3SNi/yIdB
 cpLnBgo9ZZiBAen588E4G4bBu4sWaauIQsvqzKAabAOpTlCWq5lTQZsGMbu4HY/pCRRL
 Pxllw0JGy8NG8X936lQTMObQQlDObWZevgZRDefGy1Gh2ZTaNyuFCo+wOsdx0YwlVjN4
 lMyg==
X-Gm-Message-State: AFuF++kevyqr5cx3Qh0DGkfuLr+RXbV6fKY46NDz9/VEwq2DrakkV/hI
 zdkMRqlQhFI+XKCDWO9rbGCft8W8ndhg/uNvW5Q1D9GdeOgItyYIxV6S1gVtjiHZWkXQvurzSZn
 THa8N
X-Gm-Gg: AR+sD11ZwfK/ESMWF7RBumt0HfhR5+YBmT5f+PMMRSVjUV4TtUJC77wmP+K1mAuPm4U
 MNrruBvFvEprSXBpy11Je465nRc4ROhL9Lp9mtnFDImRguyexBsxXxiWBDms5Rih6oIz9hNhS/q
 uTWEEnYZCc+H6az94GWevv3n/BAeoc1opdHL1HgYJVf0DgFzvNsJ13PxXAdycb30fuSS8VCuW9X
 TTphn1bTeBBwFIy31WR+ksFJxusAVcQVdQVFqi5DxPNt8ttgOES1Zt6Xmdpkut8NCJNMToH5PkR
 ZSXYWyjYT80DTYCFB88wExeGZJkOG/eo7P33KznYe+wEF96nPGRQLXeJ2DmJnU4nxxx06lkbJDJ
 rbwRdDomklTShVbjqWrVjOl35pwm2bTnnkvhBQoQTA5O5I2n/RKXppLqzMclu/HVBdS50eFRPcV
 Fd2CFnufwPNo5491Ci8z4L40YvwE/h477Cbd6mL2fBuFR8LatTsJ1YeJSHuZ1ZMJObbWFF
X-Received: by 2002:a17:90b:5907:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-395c33ed38amr6655108a91.2.1787285067592; 
 Thu, 20 Aug 2026 21:04:27 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 21/23] target/riscv: Drop v0 argument from
 gen_helper_ldst_index
Date: Thu, 20 Aug 2026 21:04:02 -0700
Message-ID: <20260821040404.268123-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Since we're also passing env, v0 is always env->vreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                       | 64 ++++++++++-----------
 target/riscv/tcg/vector_helper.c            | 15 ++---
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 17 ++----
 3 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 3ef352898b..bf49a793d5 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -187,38 +187,38 @@ DEF_HELPER_5(vsse8_v, void, ptr, tl, tl, env, i32)
 DEF_HELPER_5(vsse16_v, void, ptr, tl, tl, env, i32)
 DEF_HELPER_5(vsse32_v, void, ptr, tl, tl, env, i32)
 DEF_HELPER_5(vsse64_v, void, ptr, tl, tl, env, i32)
-DEF_HELPER_6(vlxei8_8_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei8_16_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei16_8_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei16_16_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei32_8_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei32_16_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei64_8_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei64_16_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei8_8_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei8_16_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei16_8_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei16_16_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei32_8_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei32_16_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei64_8_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei64_16_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei8_8_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei8_16_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei8_32_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei8_64_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei16_8_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei16_16_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei16_32_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei16_64_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei32_8_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei32_16_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei32_32_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei32_64_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei64_8_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei64_16_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei64_32_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlxei64_64_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei8_8_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei8_16_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei8_32_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei8_64_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei16_8_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei16_16_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei16_32_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei16_64_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei32_8_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei32_16_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei32_32_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei32_64_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei64_8_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei64_16_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei64_32_v, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsxei64_64_v, void, ptr, tl, ptr, env, i32)
 DEF_HELPER_4(vle8ff_v, void, ptr, tl, env, i32)
 DEF_HELPER_4(vle16ff_v, void, ptr, tl, env, i32)
 DEF_HELPER_4(vle32ff_v, void, ptr, tl, env, i32)
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 15c1281538..d46fd5c9c4 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -598,12 +598,13 @@ GEN_VEXT_GET_INDEX_ADDR(idx_w, uint32_t, H4)
 GEN_VEXT_GET_INDEX_ADDR(idx_d, uint64_t, H8)
 
 static void
-vext_ldst_index(void *vd, void *v0, target_ulong base,
+vext_ldst_index(void *vd, target_ulong base,
                 void *vs2, CPURISCVState *env, uint32_t desc,
                 vext_get_index_addr get_index_addr,
                 vext_ldst_elem_fn_tlb *ldst_elem,
                 uint32_t log2_esz, uintptr_t ra)
 {
+    void *v0 = env->vreg;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
@@ -633,10 +634,10 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
 }
 
 #define GEN_VEXT_LD_INDEX(NAME, ETYPE, INDEX_FN, LOAD_FN)               \
-QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong base,   \
-                               void *vs2, CPURISCVState *env, uint32_t desc) \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, target_ulong base, void *vs2,  \
+                               CPURISCVState *env, uint32_t desc)       \
 {                                                                       \
-    vext_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,             \
+    vext_ldst_index(vd, base, vs2, env, desc, INDEX_FN,                 \
                     LOAD_FN, ctzl(sizeof(ETYPE)), GETPC());             \
 }
 
@@ -658,10 +659,10 @@ GEN_VEXT_LD_INDEX(vlxei64_32_v, int32_t, idx_d, lde_w_tlb)
 GEN_VEXT_LD_INDEX(vlxei64_64_v, int64_t, idx_d, lde_d_tlb)
 
 #define GEN_VEXT_ST_INDEX(NAME, ETYPE, INDEX_FN, STORE_FN)              \
-QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong base,   \
-                               void *vs2, CPURISCVState *env, uint32_t desc) \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, target_ulong base, void *vs2,  \
+                               CPURISCVState *env, uint32_t desc)       \
 {                                                                       \
-    vext_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,             \
+    vext_ldst_index(vd, base, vs2, env, desc, INDEX_FN,                 \
                     STORE_FN, ctzl(sizeof(ETYPE)), GETPC());            \
 }
 
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index 5e352dbf41..4556c644cc 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -975,33 +975,28 @@ GEN_VEXT_TRANS(vsse64_v, MO_64, rnfvm, st_stride_op, st_stride_check)
 /*
  *** index load and store
  */
-typedef void gen_helper_ldst_index(TCGv_ptr, TCGv_ptr, TCGv,
-                                   TCGv_ptr, TCGv_env, TCGv_i32);
+typedef void gen_helper_ldst_index(TCGv_ptr, TCGv, TCGv_ptr,
+                                   TCGv_env, TCGv_i32);
 
 static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
                              uint32_t data, gen_helper_ldst_index *fn,
                              DisasContext *s)
 {
-    TCGv_ptr dest, mask, index;
-    TCGv base;
+    TCGv_ptr dest = tcg_temp_new_ptr();
+    TCGv_ptr index = tcg_temp_new_ptr();
+    TCGv base = get_gpr(s, rs1, EXT_NONE);
     TCGv_i32 desc;
 
-    dest = tcg_temp_new_ptr();
-    mask = tcg_temp_new_ptr();
-    index = tcg_temp_new_ptr();
-    base = get_gpr(s, rs1, EXT_NONE);
-
     data = vdata_add_memopidx(s, data);
     desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
                                       s->cfg_ptr->vlenb, data));
 
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(index, tcg_env, vreg_ofs(s, vs2));
-    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
     mark_vs_dirty(s);
 
-    fn(dest, mask, base, index, tcg_env, desc);
+    fn(dest, base, index, tcg_env, desc);
 
     finalize_rvv_inst(s);
     return true;
-- 
2.43.0


