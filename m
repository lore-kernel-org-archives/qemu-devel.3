Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220AEC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 02:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjrQK-0005Fe-Fe; Mon, 11 Mar 2024 21:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rjrQD-0005FB-KD; Mon, 11 Mar 2024 21:59:17 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rjrQ7-00040w-1P; Mon, 11 Mar 2024 21:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1710208738; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=03KyswhJLcvSa61s7wr9MXVRzJwemBFqRcWvQCzv8vM=;
 b=t0EjCPPcTVmzbXbHXDoLFZmXUz8CbPHUEI76iT0VKQVQ6YXcGfvZ3JLNXj27I6SJmbQpd7q4I3yPPtoqNVsSpN3kcja3tObuiYmfeUXwd1CefUsSrKxG8eHTRH8MhDoN/RBpyG7py1cB7InK+ccfcuU2O2y6rdmitGJGVrKee/0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W2K-DCf_1710208736; 
Received: from 30.198.0.173(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W2K-DCf_1710208736) by smtp.aliyun-inc.com;
 Tue, 12 Mar 2024 09:58:57 +0800
Message-ID: <92a10532-c1af-4290-921c-325066ad51a7@linux.alibaba.com>
Date: Tue, 12 Mar 2024 09:58:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/7] target/riscv: remove 'over' brconds from vector
 trans
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, palmer@rivosinc.com, philmd@linaro.org,
 richard.henderson@linaro.org
References: <20240311180821.250469-1-dbarboza@ventanamicro.com>
 <20240311180821.250469-5-dbarboza@ventanamicro.com>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240311180821.250469-5-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/3/12 2:08, Daniel Henrique Barboza wrote:
> The previous patch added an early vstart >= vl exit in all vector
> helpers, most of them using the VSTART_CHECK_EARLY_EXIT() macro,
> and now we're left with a lot of 'brcond' that has not use. The
> pattern goes like this:
>
>      VSTART_CHECK_EARLY_EXIT(env);
>      (...)
>      tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>      (...)
>      gen_set_label(over);
>      return true;
>
> The early exit makes the 'brcond' unneeded since it's already granted that
> vstart < vl. Remove all 'over' conditionals from the vector helpers.
>
> Note that not all insns uses helpers, and for those cases the 'brcond'
> jump is the only way to filter vstart >= vl. This is the case of
> trans_vmv_s_x() and trans_vfmv_s_f(). We won't remove the 'brcond'
> conditionals from them.
>
> While we're at it, remove the (vl == 0) brconds from trans_rvbf16.c.inc
> too since they're unneeded.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/insn_trans/trans_rvbf16.c.inc |  12 ---
>   target/riscv/insn_trans/trans_rvv.c.inc    | 108 ---------------------
>   target/riscv/insn_trans/trans_rvvk.c.inc   |  18 ----
>   3 files changed, 138 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
> index 8ee99df3f3..a842e76a6b 100644
> --- a/target/riscv/insn_trans/trans_rvbf16.c.inc
> +++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
> @@ -71,11 +71,8 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
>   
>       if (opfv_narrow_check(ctx, a) && (ctx->sew == MO_16)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
>   
>           gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
> @@ -87,7 +84,6 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
>                              ctx->cfg_ptr->vlenb, data,
>                              gen_helper_vfncvtbf16_f_f_w);
>           mark_vs_dirty(ctx);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -100,11 +96,8 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
>   
>       if (opfv_widen_check(ctx, a) && (ctx->sew == MO_16)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
>   
>           gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
> @@ -116,7 +109,6 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
>                              ctx->cfg_ptr->vlenb, data,
>                              gen_helper_vfwcvtbf16_f_f_v);
>           mark_vs_dirty(ctx);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -130,11 +122,8 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
>       if (require_rvv(ctx) && vext_check_isa_ill(ctx) && (ctx->sew == MO_16) &&
>           vext_check_dss(ctx, a->rd, a->rs1, a->rs2, a->vm)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
>   
>           gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
> @@ -147,7 +136,6 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
>                              ctx->cfg_ptr->vlenb, data,
>                              gen_helper_vfwmaccbf16_vv);
>           mark_vs_dirty(ctx);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 8c16a9f5b3..4c1a064cf6 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -616,9 +616,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>       TCGv base;
>       TCGv_i32 desc;
>   
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       dest = tcg_temp_new_ptr();
>       mask = tcg_temp_new_ptr();
>       base = get_gpr(s, rs1, EXT_NONE);
> @@ -660,7 +657,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>           tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
>       }
>   
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -802,9 +798,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
>       TCGv base, stride;
>       TCGv_i32 desc;
>   
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       dest = tcg_temp_new_ptr();
>       mask = tcg_temp_new_ptr();
>       base = get_gpr(s, rs1, EXT_NONE);
> @@ -819,7 +812,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
>   
>       fn(dest, mask, base, stride, tcg_env, desc);
>   
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -906,9 +898,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
>       TCGv base;
>       TCGv_i32 desc;
>   
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       dest = tcg_temp_new_ptr();
>       mask = tcg_temp_new_ptr();
>       index = tcg_temp_new_ptr();
> @@ -924,7 +913,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
>   
>       fn(dest, mask, base, index, tcg_env, desc);
>   
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -1044,9 +1032,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>       TCGv base;
>       TCGv_i32 desc;
>   
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       dest = tcg_temp_new_ptr();
>       mask = tcg_temp_new_ptr();
>       base = get_gpr(s, rs1, EXT_NONE);
> @@ -1059,7 +1044,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>       fn(dest, mask, base, tcg_env, desc);
>   
>       mark_vs_dirty(s);
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -1100,10 +1084,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
>                                uint32_t width, gen_helper_ldst_whole *fn,
>                                DisasContext *s)
>   {
> -    uint32_t evl = s->cfg_ptr->vlenb * nf / width;
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, evl, over);
> -
>       TCGv_ptr dest;
>       TCGv base;
>       TCGv_i32 desc;
> @@ -1120,8 +1100,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
>   
>       fn(dest, base, tcg_env, desc);
>   
> -    gen_set_label(over);
> -
>       return true;
>   }
>   
> @@ -1195,10 +1173,6 @@ static inline bool
>   do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
>                 gen_helper_gvec_4_ptr *fn)
>   {
> -    TCGLabel *over = gen_new_label();
> -
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
>           gvec_fn(s->sew, vreg_ofs(s, a->rd),
>                   vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),
> @@ -1216,7 +1190,6 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
>                              s->cfg_ptr->vlenb, data, fn);
>       }
>       mark_vs_dirty(s);
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -1248,9 +1221,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
>       TCGv_i32 desc;
>       uint32_t data = 0;
>   
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       dest = tcg_temp_new_ptr();
>       mask = tcg_temp_new_ptr();
>       src2 = tcg_temp_new_ptr();
> @@ -1271,7 +1241,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
>       fn(dest, mask, src1, src2, tcg_env, desc);
>   
>       mark_vs_dirty(s);
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -1410,9 +1379,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
>       TCGv_i32 desc;
>       uint32_t data = 0;
>   
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       dest = tcg_temp_new_ptr();
>       mask = tcg_temp_new_ptr();
>       src2 = tcg_temp_new_ptr();
> @@ -1433,7 +1399,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
>       fn(dest, mask, src1, src2, tcg_env, desc);
>   
>       mark_vs_dirty(s);
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -1495,8 +1460,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
>   {
>       if (checkfn(s, a)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -1509,7 +1472,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
>                              s->cfg_ptr->vlenb,
>                              data, fn);
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -1571,8 +1533,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
>   {
>       if (opiwv_widen_check(s, a)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -1584,7 +1544,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
>                              tcg_env, s->cfg_ptr->vlenb,
>                              s->cfg_ptr->vlenb, data, fn);
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -1643,8 +1602,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
>                           gen_helper_gvec_4_ptr *fn, DisasContext *s)
>   {
>       uint32_t data = 0;
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>       data = FIELD_DP32(data, VDATA, VM, vm);
>       data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -1655,7 +1612,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
>                          vreg_ofs(s, vs2), tcg_env, s->cfg_ptr->vlenb,
>                          s->cfg_ptr->vlenb, data, fn);
>       mark_vs_dirty(s);
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -1834,8 +1790,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
>               gen_helper_##NAME##_h,                                 \
>               gen_helper_##NAME##_w,                                 \
>           };                                                         \
> -        TCGLabel *over = gen_new_label();                          \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -1848,7 +1802,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
>                              s->cfg_ptr->vlenb, data,                \
>                              fns[s->sew]);                           \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -2045,14 +1998,11 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
>                   gen_helper_vmv_v_v_b, gen_helper_vmv_v_v_h,
>                   gen_helper_vmv_v_v_w, gen_helper_vmv_v_v_d,
>               };
> -            TCGLabel *over = gen_new_label();
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>               tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
>                                  tcg_env, s->cfg_ptr->vlenb,
>                                  s->cfg_ptr->vlenb, data,
>                                  fns[s->sew]);
> -            gen_set_label(over);
>           }
>           mark_vs_dirty(s);
>           return true;
> @@ -2068,8 +2018,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
>           /* vmv.v.x has rs2 = 0 and vm = 1 */
>           vext_check_ss(s, a->rd, 0, 1)) {
>           TCGv s1;
> -        TCGLabel *over = gen_new_label();
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           s1 = get_gpr(s, a->rs1, EXT_SIGN);
>   
> @@ -2102,7 +2050,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
>           }
>   
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -2129,8 +2076,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
>                   gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
>                   gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
>               };
> -            TCGLabel *over = gen_new_label();
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>               s1 = tcg_constant_i64(simm);
>               dest = tcg_temp_new_ptr();
> @@ -2140,7 +2085,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
>               fns[s->sew](dest, s1, tcg_env, desc);
>   
>               mark_vs_dirty(s);
> -            gen_set_label(over);
>           }
>           return true;
>       }
> @@ -2275,9 +2219,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
>               gen_helper_##NAME##_w,                                 \
>               gen_helper_##NAME##_d,                                 \
>           };                                                         \
> -        TCGLabel *over = gen_new_label();                          \
>           gen_set_rm(s, RISCV_FRM_DYN);                              \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2292,7 +2234,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
>                              s->cfg_ptr->vlenb, data,                \
>                              fns[s->sew - 1]);                       \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -2310,9 +2251,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
>       TCGv_i32 desc;
>       TCGv_i64 t1;
>   
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       dest = tcg_temp_new_ptr();
>       mask = tcg_temp_new_ptr();
>       src2 = tcg_temp_new_ptr();
> @@ -2330,7 +2268,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
>       fn(dest, mask, t1, src2, tcg_env, desc);
>   
>       mark_vs_dirty(s);
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -2393,9 +2330,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
>           static gen_helper_gvec_4_ptr * const fns[2] = {          \
>               gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
>           };                                                       \
> -        TCGLabel *over = gen_new_label();                        \
>           gen_set_rm(s, RISCV_FRM_DYN);                            \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);\
>                                                                    \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);               \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
> @@ -2408,7 +2343,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
>                              s->cfg_ptr->vlenb, data,              \
>                              fns[s->sew - 1]);                     \
>           mark_vs_dirty(s);                                        \
> -        gen_set_label(over);                                     \
>           return true;                                             \
>       }                                                            \
>       return false;                                                \
> @@ -2467,9 +2401,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
>           static gen_helper_gvec_4_ptr * const fns[2] = {            \
>               gen_helper_##NAME##_h, gen_helper_##NAME##_w,          \
>           };                                                         \
> -        TCGLabel *over = gen_new_label();                          \
>           gen_set_rm(s, RISCV_FRM_DYN);                              \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2482,7 +2414,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
>                              s->cfg_ptr->vlenb, data,                \
>                              fns[s->sew - 1]);                       \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -2584,9 +2515,7 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
>   {
>       if (checkfn(s, a)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
>           gen_set_rm_chkfrm(s, rm);
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -2597,7 +2526,6 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
>                              s->cfg_ptr->vlenb,
>                              s->cfg_ptr->vlenb, data, fn);
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -2696,8 +2624,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
>                   gen_helper_vmv_v_x_w,
>                   gen_helper_vmv_v_x_d,
>               };
> -            TCGLabel *over = gen_new_label();
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>               t1 = tcg_temp_new_i64();
>               /* NaN-box f[rs1] */
> @@ -2711,7 +2637,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
>               fns[s->sew - 1](dest, t1, tcg_env, desc);
>   
>               mark_vs_dirty(s);
> -            gen_set_label(over);
>           }
>           return true;
>       }
> @@ -2773,9 +2698,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>               gen_helper_##HELPER##_h,                               \
>               gen_helper_##HELPER##_w,                               \
>           };                                                         \
> -        TCGLabel *over = gen_new_label();                          \
>           gen_set_rm_chkfrm(s, FRM);                                 \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2787,7 +2710,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>                              s->cfg_ptr->vlenb, data,                \
>                              fns[s->sew - 1]);                       \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -2824,9 +2746,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>               gen_helper_##NAME##_h,                                 \
>               gen_helper_##NAME##_w,                                 \
>           };                                                         \
> -        TCGLabel *over = gen_new_label();                          \
>           gen_set_rm(s, RISCV_FRM_DYN);                              \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2838,7 +2758,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>                              s->cfg_ptr->vlenb, data,                \
>                              fns[s->sew]);                           \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -2891,9 +2810,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>               gen_helper_##HELPER##_h,                               \
>               gen_helper_##HELPER##_w,                               \
>           };                                                         \
> -        TCGLabel *over = gen_new_label();                          \
>           gen_set_rm_chkfrm(s, FRM);                                 \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2905,7 +2822,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>                              s->cfg_ptr->vlenb, data,                \
>                              fns[s->sew - 1]);                       \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -2940,9 +2856,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>               gen_helper_##HELPER##_h,                               \
>               gen_helper_##HELPER##_w,                               \
>           };                                                         \
> -        TCGLabel *over = gen_new_label();                          \
>           gen_set_rm_chkfrm(s, FRM);                                 \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2954,7 +2868,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>                              s->cfg_ptr->vlenb, data,                \
>                              fns[s->sew]);                           \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -3031,8 +2944,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
>           vext_check_isa_ill(s)) {                                   \
>           uint32_t data = 0;                                         \
>           gen_helper_gvec_4_ptr *fn = gen_helper_##NAME;             \
> -        TCGLabel *over = gen_new_label();                          \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
>           data =                                                     \
> @@ -3043,7 +2954,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
>                              s->cfg_ptr->vlenb,                      \
>                              s->cfg_ptr->vlenb, data, fn);           \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -3131,8 +3041,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>           s->vstart_eq_zero) {                                       \
>           uint32_t data = 0;                                         \
>           gen_helper_gvec_3_ptr *fn = gen_helper_##NAME;             \
> -        TCGLabel *over = gen_new_label();                          \
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -3145,7 +3053,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>                              s->cfg_ptr->vlenb,                      \
>                              data, fn);                              \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -3171,8 +3078,6 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
>           require_align(a->rd, s->lmul) &&
>           s->vstart_eq_zero) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -3187,7 +3092,6 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
>                              s->cfg_ptr->vlenb,
>                              s->cfg_ptr->vlenb, data, fns[s->sew]);
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -3201,8 +3105,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
>           require_align(a->rd, s->lmul) &&
>           require_vm(a->vm, a->rd)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -3217,7 +3119,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
>                              s->cfg_ptr->vlenb,
>                              data, fns[s->sew]);
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -3630,8 +3531,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
>               gen_helper_vcompress_vm_b, gen_helper_vcompress_vm_h,
>               gen_helper_vcompress_vm_w, gen_helper_vcompress_vm_d,
>           };
> -        TCGLabel *over = gen_new_label();
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
>   
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
>           data = FIELD_DP32(data, VDATA, VTA, s->vta);
> @@ -3641,7 +3540,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
>                              s->cfg_ptr->vlenb, data,
>                              fns[s->sew]);
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -3664,12 +3562,9 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
>                                vreg_ofs(s, a->rs2), maxsz, maxsz);        \
>               mark_vs_dirty(s);                                           \
>           } else {                                                        \
> -            TCGLabel *over = gen_new_label();                           \
> -            tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, maxsz, over);  \

Hi Daniel,

This is not right.

As you can see the helper_vmvr_v, it will copy (maxsz - vstart) bytes 
from source to destination, which is dangerous if we don't have this guard.

You can move it to the helper function or keep it here.

Thanks,
Zhiwei

>               tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), \
>                                  tcg_env, maxsz, maxsz, 0, gen_helper_vmvr_v); \
>               mark_vs_dirty(s);                                           \
> -            gen_set_label(over);                                        \
>           }                                                               \
>           return true;                                                    \
>       }                                                                   \
> @@ -3698,8 +3593,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
>   {
>       uint32_t data = 0;
>       gen_helper_gvec_3_ptr *fn;
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>       static gen_helper_gvec_3_ptr * const fns[6][4] = {
>           {
> @@ -3744,7 +3637,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
>                          s->cfg_ptr->vlenb, data, fn);
>   
>       mark_vs_dirty(s);
> -    gen_set_label(over);
>       return true;
>   }
>   
> diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
> index a5cdd1b67f..6d640e4596 100644
> --- a/target/riscv/insn_trans/trans_rvvk.c.inc
> +++ b/target/riscv/insn_trans/trans_rvvk.c.inc
> @@ -164,8 +164,6 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
>                   gen_helper_##NAME##_w,                                     \
>                   gen_helper_##NAME##_d,                                     \
>               };                                                             \
> -            TCGLabel *over = gen_new_label();                              \
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);     \
>                                                                              \
>               data = FIELD_DP32(data, VDATA, VM, a->vm);                     \
>               data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                 \
> @@ -177,7 +175,6 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
>                                  s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,       \
>                                  data, fns[s->sew]);                         \
>               mark_vs_dirty(s);                                              \
> -            gen_set_label(over);                                           \
>               return true;                                                   \
>           }                                                                  \
>           return false;                                                      \
> @@ -249,14 +246,12 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
>               TCGv_ptr rd_v, rs2_v;                                             \
>               TCGv_i32 desc, egs;                                               \
>               uint32_t data = 0;                                                \
> -            TCGLabel *over = gen_new_label();                                 \
>                                                                                 \
>               if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
>                   /* save opcode for unwinding in case we throw an exception */ \
>                   decode_save_opc(s);                                           \
>                   egs = tcg_constant_i32(EGS);                                  \
>                   gen_helper_egs_check(egs, tcg_env);                           \
> -                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
>               }                                                                 \
>                                                                                 \
>               data = FIELD_DP32(data, VDATA, VM, a->vm);                        \
> @@ -272,7 +267,6 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
>               tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
>               gen_helper_##NAME(rd_v, rs2_v, tcg_env, desc);                    \
>               mark_vs_dirty(s);                                                 \
> -            gen_set_label(over);                                              \
>               return true;                                                      \
>           }                                                                     \
>           return false;                                                         \
> @@ -325,14 +319,12 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
>               TCGv_ptr rd_v, rs2_v;                                             \
>               TCGv_i32 uimm_v, desc, egs;                                       \
>               uint32_t data = 0;                                                \
> -            TCGLabel *over = gen_new_label();                                 \
>                                                                                 \
>               if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
>                   /* save opcode for unwinding in case we throw an exception */ \
>                   decode_save_opc(s);                                           \
>                   egs = tcg_constant_i32(EGS);                                  \
>                   gen_helper_egs_check(egs, tcg_env);                           \
> -                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
>               }                                                                 \
>                                                                                 \
>               data = FIELD_DP32(data, VDATA, VM, a->vm);                        \
> @@ -350,7 +342,6 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
>               tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
>               gen_helper_##NAME(rd_v, rs2_v, uimm_v, tcg_env, desc);            \
>               mark_vs_dirty(s);                                                 \
> -            gen_set_label(over);                                              \
>               return true;                                                      \
>           }                                                                     \
>           return false;                                                         \
> @@ -394,7 +385,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
>       {                                                                         \
>           if (CHECK(s, a)) {                                                    \
>               uint32_t data = 0;                                                \
> -            TCGLabel *over = gen_new_label();                                 \
>               TCGv_i32 egs;                                                     \
>                                                                                 \
>               if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
> @@ -402,7 +392,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
>                   decode_save_opc(s);                                           \
>                   egs = tcg_constant_i32(EGS);                                  \
>                   gen_helper_egs_check(egs, tcg_env);                           \
> -                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
>               }                                                                 \
>                                                                                 \
>               data = FIELD_DP32(data, VDATA, VM, a->vm);                        \
> @@ -417,7 +406,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
>                                  data, gen_helper_##NAME);                      \
>                                                                                 \
>               mark_vs_dirty(s);                                                 \
> -            gen_set_label(over);                                              \
>               return true;                                                      \
>           }                                                                     \
>           return false;                                                         \
> @@ -448,7 +436,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
>   {
>       if (vsha_check(s, a)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
>           TCGv_i32 egs;
>   
>           if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
> @@ -456,7 +443,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
>               decode_save_opc(s);
>               egs = tcg_constant_i32(ZVKNH_EGS);
>               gen_helper_egs_check(egs, tcg_env);
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>           }
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
> @@ -472,7 +458,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
>                   gen_helper_vsha2cl32_vv : gen_helper_vsha2cl64_vv);
>   
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -482,7 +467,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
>   {
>       if (vsha_check(s, a)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
>           TCGv_i32 egs;
>   
>           if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
> @@ -490,7 +474,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
>               decode_save_opc(s);
>               egs = tcg_constant_i32(ZVKNH_EGS);
>               gen_helper_egs_check(egs, tcg_env);
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>           }
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
> @@ -506,7 +489,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
>                   gen_helper_vsha2ch32_vv : gen_helper_vsha2ch64_vv);
>   
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;

