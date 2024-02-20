Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25B0C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVlG-0006T4-Q1; Tue, 20 Feb 2024 14:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcVl5-0006Ph-8q
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:29 -0500
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcVl0-0006Ug-BI
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:26 -0500
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7bc332d3a8cso304340739f.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708457181; x=1709061981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yslHh8FTZWsAylQ1LO2udMOTXqFrYthlo4OZxb8za7s=;
 b=LlgNhRSgCuhNcVCTEcnHAjcrg91U5HrDDp23IEOVQZmCBEaD5KrCy9+Irh3vJPl9UY
 Nyy3KT0MJusa63Wx5SvUx0hlYd/mTMlvJH1eklncGjYzTSIk4+5HbJ72i7YGt+fmomUi
 /pk9DcIt9NbCChlz7JVsVCyZjffc+tkPSRDhFtquA0364AXXpczEJLBbSdIsNyeRtz5z
 yo/oOhzQ81V2p1wcyw34b80xWR7lA4czfgppbnWN7pJVn0+K/rrJ5lZEdHk886MiG0T+
 4Wkrin5ZD+0Izo5R5CNC1p6YVVze5nDsNvHINbt983Hna+CiZuKWUi87sWHzzuubTeEK
 k43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708457181; x=1709061981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yslHh8FTZWsAylQ1LO2udMOTXqFrYthlo4OZxb8za7s=;
 b=qdtCyjljNO8B+FX8LErImr+CDNUU7oauZSNJJiYiSNsneb1rPmRlQLv/rSe50BtVwr
 BZi74/Qw0AJN2K4Vz7MyMFwEYR2B2Syu76Rsfbk+0CYT/YwB1fIrWn4mM7r7GQe/KXLJ
 Pux+yA4Mjsjxak/LKbTXe/TCe87uPz0KcBOrX0vOac2wifWhlZvjCxGIEXLXt+UddoPT
 g4kK5L4hnfRSEY9EbsmNQL+PC3HxBvp5H8XqJDTLzGO75YG9YFoq+VOfnCu+FsD0GAOP
 Ves5MFRlok/JIKUZ8aQmE1tOmUV+2xS6BTAuRDJXp+0jiodxL9cZWl8LIRAX3LjeUb67
 1DiQ==
X-Gm-Message-State: AOJu0Yzqb4/c1iQ4p/bgJm0YUqUTGIF4EzSqgfgWr9Sxh1fEfXEnYGVI
 TccmP8bq2kaeqp3TdDa2MnRQPC8CwcH5B8FHXXRGEpxU0W/GcWdRnrRIM5QVp5gzn7147ybh8tE
 k
X-Google-Smtp-Source: AGHT+IGhxuC2FK4uB7635jv1pLyi0VsN8VJCxWuIJyap2RMVo4lZiTSTfjPNS9MN4pj1drz6KszUYQ==
X-Received: by 2002:a92:c651:0:b0:365:c8:7a15 with SMTP id
 17-20020a92c651000000b0036500c87a15mr13920499ill.20.1708457180588; 
 Tue, 20 Feb 2024 11:26:20 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 i73-20020a636d4c000000b005b458aa0541sm6943005pgc.15.2024.02.20.11.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 11:26:20 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 2/5] target/riscv: remove 'over' brconds from vector trans
Date: Tue, 20 Feb 2024 16:26:04 -0300
Message-ID: <20240220192607.141880-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220192607.141880-1-dbarboza@ventanamicro.com>
References: <20240220192607.141880-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-io1-xd2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Most of the vector translations has this following pattern at the start:

    TCGLabel *over = gen_new_label();
    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);

And then right at the end:

     gen_set_label(over);
     return true;

This means that if vstart >= vl we'll not set vstart = 0 at the end of
the insns - this is done inside the helper that is being skipped.  The
reason why this pattern hasn't been a bigger problem is because the
conditional vstart >= vl is very rare.

Checking all the helpers in vector_helper.c we see all of them with a
pattern like this:

    for (i = env->vstart; i < vl; i++) {
        (...)
    }
    env->vstart = 0;

Thus they can handle vstart >= vl case gracefully, with the benefit of
setting env->vstart = 0 during the process.

Remove all 'over' conditionals and let the helper set env->vstart = 0
every time.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc  | 116 -----------------------
 target/riscv/insn_trans/trans_rvvk.c.inc |  18 ----
 2 files changed, 134 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 2065e9064e..d80f50acdd 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -616,9 +616,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     TCGv base;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
@@ -643,7 +640,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     fn(dest, mask, base, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -785,9 +781,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     TCGv base, stride;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
@@ -805,7 +798,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     fn(dest, mask, base, stride, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -892,9 +884,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     TCGv base;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     index = tcg_temp_new_ptr();
@@ -913,7 +902,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     fn(dest, mask, base, index, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1033,9 +1021,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     TCGv base;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
@@ -1048,7 +1033,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     fn(dest, mask, base, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1089,10 +1073,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
                              uint32_t width, gen_helper_ldst_whole *fn,
                              DisasContext *s, bool is_store)
 {
-    uint32_t evl = s->cfg_ptr->vlenb * nf / width;
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, evl, over);
-
     TCGv_ptr dest;
     TCGv base;
     TCGv_i32 desc;
@@ -1112,7 +1092,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
     fn(dest, base, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
 
     return true;
 }
@@ -1187,10 +1166,6 @@ static inline bool
 do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
               gen_helper_gvec_4_ptr *fn)
 {
-    TCGLabel *over = gen_new_label();
-
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
         gvec_fn(s->sew, vreg_ofs(s, a->rd),
                 vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),
@@ -1208,7 +1183,6 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
                            s->cfg_ptr->vlenb, data, fn);
     }
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1240,9 +1214,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
     TCGv_i32 desc;
     uint32_t data = 0;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     src2 = tcg_temp_new_ptr();
@@ -1263,7 +1234,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
     fn(dest, mask, src1, src2, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1402,9 +1372,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     TCGv_i32 desc;
     uint32_t data = 0;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     src2 = tcg_temp_new_ptr();
@@ -1425,7 +1392,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     fn(dest, mask, src1, src2, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1487,8 +1453,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
 {
     if (checkfn(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -1501,7 +1465,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
                            s->cfg_ptr->vlenb,
                            data, fn);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -1563,8 +1526,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
 {
     if (opiwv_widen_check(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -1576,7 +1537,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
                            tcg_env, s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fn);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -1635,8 +1595,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
                         gen_helper_gvec_4_ptr *fn, DisasContext *s)
 {
     uint32_t data = 0;
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     data = FIELD_DP32(data, VDATA, VM, vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -1647,7 +1605,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
                        vreg_ofs(s, vs2), tcg_env, s->cfg_ptr->vlenb,
                        s->cfg_ptr->vlenb, data, fn);
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1826,8 +1783,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
             gen_helper_##NAME##_h,                                 \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -1840,7 +1795,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2037,14 +1991,11 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
                 gen_helper_vmv_v_v_b, gen_helper_vmv_v_v_h,
                 gen_helper_vmv_v_v_w, gen_helper_vmv_v_v_d,
             };
-            TCGLabel *over = gen_new_label();
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
                                tcg_env, s->cfg_ptr->vlenb,
                                s->cfg_ptr->vlenb, data,
                                fns[s->sew]);
-            gen_set_label(over);
         }
         mark_vs_dirty(s);
         return true;
@@ -2060,8 +2011,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
         /* vmv.v.x has rs2 = 0 and vm = 1 */
         vext_check_ss(s, a->rd, 0, 1)) {
         TCGv s1;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         s1 = get_gpr(s, a->rs1, EXT_SIGN);
 
@@ -2094,7 +2043,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
         }
 
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -2121,8 +2069,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
                 gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
                 gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
             };
-            TCGLabel *over = gen_new_label();
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             s1 = tcg_constant_i64(simm);
             dest = tcg_temp_new_ptr();
@@ -2132,7 +2078,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
             fns[s->sew](dest, s1, tcg_env, desc);
 
             mark_vs_dirty(s);
-            gen_set_label(over);
         }
         return true;
     }
@@ -2267,9 +2212,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
             gen_helper_##NAME##_w,                                 \
             gen_helper_##NAME##_d,                                 \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2284,7 +2227,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2302,9 +2244,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     TCGv_i32 desc;
     TCGv_i64 t1;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     src2 = tcg_temp_new_ptr();
@@ -2322,7 +2261,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     fn(dest, mask, t1, src2, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -2385,9 +2323,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         static gen_helper_gvec_4_ptr * const fns[2] = {          \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
         };                                                       \
-        TCGLabel *over = gen_new_label();                        \
         gen_set_rm(s, RISCV_FRM_DYN);                            \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);\
                                                                  \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
@@ -2400,7 +2336,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
                            s->cfg_ptr->vlenb, data,              \
                            fns[s->sew - 1]);                     \
         mark_vs_dirty(s);                                        \
-        gen_set_label(over);                                     \
         return true;                                             \
     }                                                            \
     return false;                                                \
@@ -2459,9 +2394,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         static gen_helper_gvec_4_ptr * const fns[2] = {            \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,          \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2474,7 +2407,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2576,9 +2508,7 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
 {
     if (checkfn(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
         gen_set_rm_chkfrm(s, rm);
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -2589,7 +2519,6 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
                            s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fn);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -2688,8 +2617,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
                 gen_helper_vmv_v_x_w,
                 gen_helper_vmv_v_x_d,
             };
-            TCGLabel *over = gen_new_label();
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             t1 = tcg_temp_new_i64();
             /* NaN-box f[rs1] */
@@ -2703,7 +2630,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
             fns[s->sew - 1](dest, t1, tcg_env, desc);
 
             mark_vs_dirty(s);
-            gen_set_label(over);
         }
         return true;
     }
@@ -2765,9 +2691,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##HELPER##_h,                               \
             gen_helper_##HELPER##_w,                               \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2779,7 +2703,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2816,9 +2739,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##NAME##_h,                                 \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2830,7 +2751,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2883,9 +2803,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##HELPER##_h,                               \
             gen_helper_##HELPER##_w,                               \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2897,7 +2815,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2932,9 +2849,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##HELPER##_h,                               \
             gen_helper_##HELPER##_w,                               \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2946,7 +2861,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3023,8 +2937,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
         vext_check_isa_ill(s)) {                                   \
         uint32_t data = 0;                                         \
         gen_helper_gvec_4_ptr *fn = gen_helper_##NAME;             \
-        TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
         data =                                                     \
@@ -3035,7 +2947,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data, fn);           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3123,8 +3034,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         s->vstart_eq_zero) {                                       \
         uint32_t data = 0;                                         \
         gen_helper_gvec_3_ptr *fn = gen_helper_##NAME;             \
-        TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -3137,7 +3046,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb,                      \
                            data, fn);                              \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3163,8 +3071,6 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
         require_align(a->rd, s->lmul) &&
         s->vstart_eq_zero) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -3179,7 +3085,6 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
                            s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fns[s->sew]);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3193,8 +3098,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
         require_align(a->rd, s->lmul) &&
         require_vm(a->vm, a->rd)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -3209,7 +3112,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
                            s->cfg_ptr->vlenb,
                            data, fns[s->sew]);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3378,9 +3280,6 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         /* This instruction ignores LMUL and vector register groups */
         TCGv_i64 t1;
         TCGv s1;
-        TCGLabel *over = gen_new_label();
-
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         t1 = tcg_temp_new_i64();
 
@@ -3392,7 +3291,6 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         tcg_gen_ext_tl_i64(t1, s1);
         vec_element_storei(s, a->rd, 0, t1);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3434,10 +3332,6 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
 
         /* The instructions ignore LMUL and vector register group. */
         TCGv_i64 t1;
-        TCGLabel *over = gen_new_label();
-
-        /* if vstart >= vl, skip vector register write back */
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         /* NaN-box f[rs1] */
         t1 = tcg_temp_new_i64();
@@ -3445,7 +3339,6 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
 
         vec_element_storei(s, a->rd, 0, t1);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3616,8 +3509,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
             gen_helper_vcompress_vm_b, gen_helper_vcompress_vm_h,
             gen_helper_vcompress_vm_w, gen_helper_vcompress_vm_d,
         };
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
         data = FIELD_DP32(data, VDATA, VTA, s->vta);
@@ -3627,7 +3518,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
                            s->cfg_ptr->vlenb, data,
                            fns[s->sew]);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3650,12 +3540,9 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
                              vreg_ofs(s, a->rs2), maxsz, maxsz);        \
             mark_vs_dirty(s);                                           \
         } else {                                                        \
-            TCGLabel *over = gen_new_label();                           \
-            tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, maxsz, over);  \
             tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), \
                                tcg_env, maxsz, maxsz, 0, gen_helper_vmvr_v); \
             mark_vs_dirty(s);                                           \
-            gen_set_label(over);                                        \
         }                                                               \
         return true;                                                    \
     }                                                                   \
@@ -3684,8 +3571,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_gvec_3_ptr *fn;
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     static gen_helper_gvec_3_ptr * const fns[6][4] = {
         {
@@ -3730,7 +3615,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
                        s->cfg_ptr->vlenb, data, fn);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index a5cdd1b67f..6d640e4596 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -164,8 +164,6 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
                 gen_helper_##NAME##_w,                                     \
                 gen_helper_##NAME##_d,                                     \
             };                                                             \
-            TCGLabel *over = gen_new_label();                              \
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);     \
                                                                            \
             data = FIELD_DP32(data, VDATA, VM, a->vm);                     \
             data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                 \
@@ -177,7 +175,6 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
                                s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,       \
                                data, fns[s->sew]);                         \
             mark_vs_dirty(s);                                              \
-            gen_set_label(over);                                           \
             return true;                                                   \
         }                                                                  \
         return false;                                                      \
@@ -249,14 +246,12 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
             TCGv_ptr rd_v, rs2_v;                                             \
             TCGv_i32 desc, egs;                                               \
             uint32_t data = 0;                                                \
-            TCGLabel *over = gen_new_label();                                 \
                                                                               \
             if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
                 /* save opcode for unwinding in case we throw an exception */ \
                 decode_save_opc(s);                                           \
                 egs = tcg_constant_i32(EGS);                                  \
                 gen_helper_egs_check(egs, tcg_env);                           \
-                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
             }                                                                 \
                                                                               \
             data = FIELD_DP32(data, VDATA, VM, a->vm);                        \
@@ -272,7 +267,6 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
             tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
             gen_helper_##NAME(rd_v, rs2_v, tcg_env, desc);                    \
             mark_vs_dirty(s);                                                 \
-            gen_set_label(over);                                              \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -325,14 +319,12 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
             TCGv_ptr rd_v, rs2_v;                                             \
             TCGv_i32 uimm_v, desc, egs;                                       \
             uint32_t data = 0;                                                \
-            TCGLabel *over = gen_new_label();                                 \
                                                                               \
             if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
                 /* save opcode for unwinding in case we throw an exception */ \
                 decode_save_opc(s);                                           \
                 egs = tcg_constant_i32(EGS);                                  \
                 gen_helper_egs_check(egs, tcg_env);                           \
-                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
             }                                                                 \
                                                                               \
             data = FIELD_DP32(data, VDATA, VM, a->vm);                        \
@@ -350,7 +342,6 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
             tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
             gen_helper_##NAME(rd_v, rs2_v, uimm_v, tcg_env, desc);            \
             mark_vs_dirty(s);                                                 \
-            gen_set_label(over);                                              \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -394,7 +385,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
     {                                                                         \
         if (CHECK(s, a)) {                                                    \
             uint32_t data = 0;                                                \
-            TCGLabel *over = gen_new_label();                                 \
             TCGv_i32 egs;                                                     \
                                                                               \
             if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
@@ -402,7 +392,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
                 decode_save_opc(s);                                           \
                 egs = tcg_constant_i32(EGS);                                  \
                 gen_helper_egs_check(egs, tcg_env);                           \
-                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
             }                                                                 \
                                                                               \
             data = FIELD_DP32(data, VDATA, VM, a->vm);                        \
@@ -417,7 +406,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
                                data, gen_helper_##NAME);                      \
                                                                               \
             mark_vs_dirty(s);                                                 \
-            gen_set_label(over);                                              \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -448,7 +436,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
 {
     if (vsha_check(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
         TCGv_i32 egs;
 
         if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
@@ -456,7 +443,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
             decode_save_opc(s);
             egs = tcg_constant_i32(ZVKNH_EGS);
             gen_helper_egs_check(egs, tcg_env);
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
         }
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -472,7 +458,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
                 gen_helper_vsha2cl32_vv : gen_helper_vsha2cl64_vv);
 
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -482,7 +467,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
 {
     if (vsha_check(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
         TCGv_i32 egs;
 
         if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
@@ -490,7 +474,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
             decode_save_opc(s);
             egs = tcg_constant_i32(ZVKNH_EGS);
             gen_helper_egs_check(egs, tcg_env);
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
         }
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -506,7 +489,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
                 gen_helper_vsha2ch32_vv : gen_helper_vsha2ch64_vv);
 
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
-- 
2.43.2


