Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B02C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYYl-0002UG-5k; Tue, 20 Feb 2024 17:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcYYP-0002Pn-IV
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:25:34 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcYYM-0003Yk-E6
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:25:33 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1db5212e2f6so44250845ad.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 14:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708467928; x=1709072728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zX4Y6dip0jZSW7OwKHjLcP2jYUkREdzxp8bcTHiTA34=;
 b=FSP4YViJ/DsUclFGdyzz+Y6ShlUdlxJCjHGahpXi95WAhAktxRVgPrUSivaiVueUI6
 eS9jgWN/TPeGRjA6qLNurkkAQ+WP3yhUXAVM21A7bqbWQwIsTGG3tcpIyW9D3QRSv7dB
 76rMnBU8i161WXZbR0we/p7ltx8gKAZDL+tKZYQ2Ytu5mlyHWmOe9g1KhHdlG8wdzRve
 ct6bpI79Os8+w7HzOkAETzD5Q4kQQ7v5djQV1AlmSOSWC6jgdl42mLGj5iB40VWiWLRP
 gYDXih/a0dYCSjr3npgOrntgWbobf0ZsbQViY7beJOrKfJbR/4hvUkOXdyQGPz00BYr7
 /+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708467928; x=1709072728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zX4Y6dip0jZSW7OwKHjLcP2jYUkREdzxp8bcTHiTA34=;
 b=ANS00ZXKvao7kUDnYYZEVFNjFqlRfSnOUB9/FSrW7XkxLGWn8arhpCzYWKGKDjwjTE
 SUHK2r5YSgXXx8OAaQNVYBR9hk6giH0gISYMkMoA5swERKZC7lxEBhzHhBy/H9n2BiND
 zvReqR7pYrSVB1VYfLK0hPsVrlxb4FubbeiKL5lvdCJBJcfizvPn+yD3o1cKxhoHIeuy
 BOQarh4MHDRgLnwDqaouuBuyD1qtP6xYjJKyIU9o+bgN/mOH0FMTSMJr7Adp1BPLs/m1
 CzpoeCk+wuw/wn+spYTZHNv/R/IaLFzm3dQL2W4qQwXHkUKVRZ6DVy0Q7g9hP4JrjXcE
 +Bqw==
X-Gm-Message-State: AOJu0YxNUUbYvCll3+adx7uxg4e5Q1eiW1s1Sbj4cGGUSoxNlY12wvk3
 y7bozB02L1aDyPp+hFfg89tQmHes0rC3oKYcsct4Z0NgtNwDsvtf5qYOSXwS+xIrrgn1osC5trr
 f
X-Google-Smtp-Source: AGHT+IF4IpA5UZcT6FkdGL9vZWjs8tijMsBOsioNOCxjWg+zHS1RLPvdFx4B1JN8u/cR8Gyxt278NA==
X-Received: by 2002:a17:902:c952:b0:1db:edb8:35f6 with SMTP id
 i18-20020a170902c95200b001dbedb835f6mr11496854pla.5.1708467927806; 
 Tue, 20 Feb 2024 14:25:27 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 iw20-20020a170903045400b001dbb86b88e5sm6761044plb.124.2024.02.20.14.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 14:25:27 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 3/6] target/riscv: remove 'over' brconds from vector trans
Date: Tue, 20 Feb 2024 19:25:07 -0300
Message-ID: <20240220222510.209448-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220222510.209448-1-dbarboza@ventanamicro.com>
References: <20240220222510.209448-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc  | 117 -----------------------
 target/riscv/insn_trans/trans_rvvk.c.inc |  18 ----
 2 files changed, 135 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 15ccebf3fc..58299d9bb8 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -615,9 +615,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     TCGv base;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
@@ -639,7 +636,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
 
     fn(dest, mask, base, tcg_env, desc);
 
-    gen_set_label(over);
     return true;
 }
 
@@ -781,9 +777,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     TCGv base, stride;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
@@ -798,7 +791,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
 
     fn(dest, mask, base, stride, tcg_env, desc);
 
-    gen_set_label(over);
     return true;
 }
 
@@ -885,9 +877,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     TCGv base;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     index = tcg_temp_new_ptr();
@@ -903,7 +892,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
 
     fn(dest, mask, base, index, tcg_env, desc);
 
-    gen_set_label(over);
     return true;
 }
 
@@ -1023,9 +1011,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     TCGv base;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
@@ -1038,7 +1023,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     fn(dest, mask, base, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1079,10 +1063,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
                              uint32_t width, gen_helper_ldst_whole *fn,
                              DisasContext *s)
 {
-    uint32_t evl = s->cfg_ptr->vlenb * nf / width;
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, evl, over);
-
     TCGv_ptr dest;
     TCGv base;
     TCGv_i32 desc;
@@ -1099,8 +1079,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
 
     fn(dest, base, tcg_env, desc);
 
-    gen_set_label(over);
-
     return true;
 }
 
@@ -1174,10 +1152,6 @@ static inline bool
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
@@ -1195,7 +1169,6 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
                            s->cfg_ptr->vlenb, data, fn);
     }
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1227,9 +1200,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
     TCGv_i32 desc;
     uint32_t data = 0;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     src2 = tcg_temp_new_ptr();
@@ -1250,7 +1220,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
     fn(dest, mask, src1, src2, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1389,9 +1358,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     TCGv_i32 desc;
     uint32_t data = 0;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     src2 = tcg_temp_new_ptr();
@@ -1412,7 +1378,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     fn(dest, mask, src1, src2, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1474,8 +1439,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
 {
     if (checkfn(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -1488,7 +1451,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
                            s->cfg_ptr->vlenb,
                            data, fn);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -1550,8 +1512,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
 {
     if (opiwv_widen_check(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -1563,7 +1523,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
                            tcg_env, s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fn);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -1622,8 +1581,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
                         gen_helper_gvec_4_ptr *fn, DisasContext *s)
 {
     uint32_t data = 0;
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     data = FIELD_DP32(data, VDATA, VM, vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -1634,7 +1591,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
                        vreg_ofs(s, vs2), tcg_env, s->cfg_ptr->vlenb,
                        s->cfg_ptr->vlenb, data, fn);
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1813,8 +1769,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
             gen_helper_##NAME##_h,                                 \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -1827,7 +1781,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2024,14 +1977,11 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
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
@@ -2047,8 +1997,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
         /* vmv.v.x has rs2 = 0 and vm = 1 */
         vext_check_ss(s, a->rd, 0, 1)) {
         TCGv s1;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         s1 = get_gpr(s, a->rs1, EXT_SIGN);
 
@@ -2081,7 +2029,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
         }
 
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -2108,8 +2055,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
                 gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
                 gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
             };
-            TCGLabel *over = gen_new_label();
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             s1 = tcg_constant_i64(simm);
             dest = tcg_temp_new_ptr();
@@ -2119,7 +2064,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
             fns[s->sew](dest, s1, tcg_env, desc);
 
             mark_vs_dirty(s);
-            gen_set_label(over);
         }
         return true;
     }
@@ -2254,9 +2198,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
             gen_helper_##NAME##_w,                                 \
             gen_helper_##NAME##_d,                                 \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2271,7 +2213,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2289,9 +2230,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     TCGv_i32 desc;
     TCGv_i64 t1;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     src2 = tcg_temp_new_ptr();
@@ -2309,7 +2247,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     fn(dest, mask, t1, src2, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -2372,9 +2309,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         static gen_helper_gvec_4_ptr * const fns[2] = {          \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
         };                                                       \
-        TCGLabel *over = gen_new_label();                        \
         gen_set_rm(s, RISCV_FRM_DYN);                            \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);\
                                                                  \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
@@ -2387,7 +2322,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
                            s->cfg_ptr->vlenb, data,              \
                            fns[s->sew - 1]);                     \
         mark_vs_dirty(s);                                        \
-        gen_set_label(over);                                     \
         return true;                                             \
     }                                                            \
     return false;                                                \
@@ -2446,9 +2380,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         static gen_helper_gvec_4_ptr * const fns[2] = {            \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,          \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2461,7 +2393,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2563,9 +2494,7 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
 {
     if (checkfn(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
         gen_set_rm_chkfrm(s, rm);
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -2576,7 +2505,6 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
                            s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fn);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -2675,8 +2603,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
                 gen_helper_vmv_v_x_w,
                 gen_helper_vmv_v_x_d,
             };
-            TCGLabel *over = gen_new_label();
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             t1 = tcg_temp_new_i64();
             /* NaN-box f[rs1] */
@@ -2690,7 +2616,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
             fns[s->sew - 1](dest, t1, tcg_env, desc);
 
             mark_vs_dirty(s);
-            gen_set_label(over);
         }
         return true;
     }
@@ -2752,9 +2677,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##HELPER##_h,                               \
             gen_helper_##HELPER##_w,                               \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2766,7 +2689,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2803,9 +2725,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##NAME##_h,                                 \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2817,7 +2737,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2870,9 +2789,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##HELPER##_h,                               \
             gen_helper_##HELPER##_w,                               \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2884,7 +2801,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2919,9 +2835,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##HELPER##_h,                               \
             gen_helper_##HELPER##_w,                               \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2933,7 +2847,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3010,8 +2923,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
         vext_check_isa_ill(s)) {                                   \
         uint32_t data = 0;                                         \
         gen_helper_gvec_4_ptr *fn = gen_helper_##NAME;             \
-        TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
         data =                                                     \
@@ -3022,7 +2933,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data, fn);           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3110,8 +3020,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         s->vstart_eq_zero) {                                       \
         uint32_t data = 0;                                         \
         gen_helper_gvec_3_ptr *fn = gen_helper_##NAME;             \
-        TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -3124,7 +3032,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb,                      \
                            data, fn);                              \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3150,8 +3057,6 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
         require_align(a->rd, s->lmul) &&
         s->vstart_eq_zero) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -3166,7 +3071,6 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
                            s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fns[s->sew]);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3180,8 +3084,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
         require_align(a->rd, s->lmul) &&
         require_vm(a->vm, a->rd)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -3196,7 +3098,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
                            s->cfg_ptr->vlenb,
                            data, fns[s->sew]);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3365,9 +3266,6 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         /* This instruction ignores LMUL and vector register groups */
         TCGv_i64 t1;
         TCGv s1;
-        TCGLabel *over = gen_new_label();
-
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         t1 = tcg_temp_new_i64();
 
@@ -3379,7 +3277,6 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         tcg_gen_ext_tl_i64(t1, s1);
         vec_element_storei(s, a->rd, 0, t1);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3421,10 +3318,6 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
 
         /* The instructions ignore LMUL and vector register group. */
         TCGv_i64 t1;
-        TCGLabel *over = gen_new_label();
-
-        /* if vstart >= vl, skip vector register write back */
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         /* NaN-box f[rs1] */
         t1 = tcg_temp_new_i64();
@@ -3432,7 +3325,6 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
 
         vec_element_storei(s, a->rd, 0, t1);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3603,8 +3495,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
             gen_helper_vcompress_vm_b, gen_helper_vcompress_vm_h,
             gen_helper_vcompress_vm_w, gen_helper_vcompress_vm_d,
         };
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
         data = FIELD_DP32(data, VDATA, VTA, s->vta);
@@ -3614,7 +3504,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
                            s->cfg_ptr->vlenb, data,
                            fns[s->sew]);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3637,12 +3526,9 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
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
@@ -3671,8 +3557,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_gvec_3_ptr *fn;
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     static gen_helper_gvec_3_ptr * const fns[6][4] = {
         {
@@ -3717,7 +3601,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
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


