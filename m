Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903C7CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 04:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu1iy-0006fI-GC; Thu, 04 Sep 2025 00:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uu1iw-0006eR-6y; Thu, 04 Sep 2025 00:37:26 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uu1iu-0007MI-3w; Thu, 04 Sep 2025 00:37:25 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7722f2f2aa4so858320b3a.1; 
 Wed, 03 Sep 2025 21:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756960641; x=1757565441; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3sY0mzDc8mRaPyvV43PzU0Y8fRHtLLPDpveCIU5urqQ=;
 b=Vt8zvWVcNo87yXdjFBweP9mX+P/gPu82UpoquZt+XmjwHIfRek/5QzRDn63dBIB6qW
 ORiNlMXBQjAMKxRh02g2W/z/5lla/Tm0mXJxqVuXi+e/sWZVx1SM0uaJ0WCPPssAlnLY
 SL9xR0VGMZLtijZMbig3E/ON7QUqMQLBnzpzwdmbD2/M+q17vYf2+/AKpAf/A8nTcyzI
 TxfaTlbXaTXwACBX8v2zeer0rRS0gE6o9Sb1JK7wzccrM3qDYRmAZnycJ7C8fWBFizrY
 g7HKyd+CuMoYr5CU0p53UcUVdssL/46ItImIN9Luq/AjMapBrZIbOuV3W8MRuP8B5Qis
 kjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756960641; x=1757565441;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3sY0mzDc8mRaPyvV43PzU0Y8fRHtLLPDpveCIU5urqQ=;
 b=YSygqGZbJ5hSUQGnTaJtB/EuE28Pce2u2HdfgBxqv7+53aPiYWqmNPCxjcC5JQoUPF
 0u0xmblKCpOsHyD7epR120jYLiQo/zXYJxf2TuRIs8h/8t0Jlmp2gYgLToMlZ0ENACVm
 2TSF460gQUiPThCuCHD2MmZBGzen36AJNcKyYyYiakxcoeVkYpw34ei8WxGQKvhBCnZy
 KSLicLIFEiwKccaGX6PL1AvPKdH9qp1ZoluKgIS88JC4lHRluOgLzS6hOXRXaXgUgwgd
 aq/U76nABtFPV2coP0ihtqOZr9rR4unfOIgf6MclZMtNcxDE3uD6+x6o1unACvNvKaBo
 3/lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPSk3E0kW2wkhXPnuv2RGrUsZUaIvNgme/PiSkY7HVXKiA2SITPe7Ecciy8vgaeGEXDoVwWcdf2IWvQw==@nongnu.org,
 AJvYcCXSGL1FmsZ6bjHCj9GCW30cdv/Syc4wfN9S8+I0pM4TMsif2SLDq74eazTrZnOTsPqrgS+HZeiJPIKf@nongnu.org
X-Gm-Message-State: AOJu0Yyfx7yhAxvMtoUN86S/wc2gnqgp6DuZAlybmnG70muzEHFeN1sV
 TykjmeAZTJCFmHUTyXftww3QTTFy2pQgDScn+YG2cPcrLLiZCmK0AKK/
X-Gm-Gg: ASbGnct16ospEOpx0PFbd8olJNh2gvKxMYaBl5mHFqKMy1PWxNbIEoAOPoDZXxatl9P
 PPdlRmh6gYTH+9xsfdKRqJcWwDCjaGSY4uScwDtOi48D5zcNn4DpnMhu5X/OjkIUxesE53CmhG8
 o0Xzlein+BOpQ6AvAxDKFnVfpzzrvCgawfc5qaz1RDHHMWUC9bd5U5a8eteoMUyBSIYIqJ7neJq
 oEvijcEuGwz0bnchtR6TodVKEQ52xWv9yoAx0suYIDn6X7v4ZsRcHd3bJtkNMX05aBPRDYZ/UPl
 ii+MGEsmDTZQfYV/6w6b6lFbqD2jdZsPAg3yJq3p6Iiz0MDPqjhMv/oVNpF3gyaaKC3ZouaThgN
 6rkbZOKJ0Y6AjJq8CUd0DhiJ3PbHuhKRtq/xFqKC9VyxbQVw95pQk9isokh2/C29W17RGayFfL3
 g=
X-Google-Smtp-Source: AGHT+IHLJVkETZsZL45k3aNhiZOiYSeRSXbibKpWDYQ7/hBqnWP7V2xFM0JBR4H+Ep50cADyOrXIUg==
X-Received: by 2002:a05:6a00:2da5:b0:772:8101:870c with SMTP id
 d2e1a72fcca58-77281019e70mr6165040b3a.11.1756960640985; 
 Wed, 03 Sep 2025 21:37:20 -0700 (PDT)
Received: from localhost (123.253.189.97.qld.leaptel.network. [123.253.189.97])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7722a090c77sm17953413b3a.0.2025.09.03.21.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 21:37:20 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:37:17 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Chao Liu <chao.liu@zevorn.cn>
Cc: richard.henderson@linaro.org, paolo.savini@embecosm.com, 
 ebiggers@kernel.org, dbarboza@ventanamicro.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Chao Liu <chao.liu@yeah.net>
Subject: Re: [PATCH v6 1/2] target/riscv: Generate strided vector
 loads/stores with tcg nodes.
Message-ID: <lzyoldc5srfkz33clacyjwdrvhyfjyjhn3bhyepo7hv32tsm6t@ogvkrjid23lv>
References: <cover.1756906528.git.chao.liu@zevorn.cn>
 <bcb383174cf82be8116685273e271cdbdda28a59.1756906528.git.chao.liu@zevorn.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb383174cf82be8116685273e271cdbdda28a59.1756906528.git.chao.liu@zevorn.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 03, 2025 at 09:52:01PM +0800, Chao Liu wrote:
> From: Chao Liu <chao.liu@yeah.net>
> 
> This commit improves the performance of QEMU when emulating strided vector
> loads and stores by substituting the call for the helper function with the
> generation of equivalent TCG operations.
> 
> PS:
> 
> An implementation is permitted to cause an illegal instruction if vstart
> is not 0 and it is set to a value that can not be produced implicitly by
> the implementation, but memory accesses will generally always need to
> deal with page faults.
> 
> So, if a strided vector memory access instruction has non-zero vstart,
> check it through vlse/vsse helpers function.

[...]

>  typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
>                                      TCGv, TCGv_env, TCGv_i32);
>  
>  static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
>                                uint32_t data, gen_helper_ldst_stride *fn,
> -                              DisasContext *s)
> +                              DisasContext *s, bool is_load)
>  {
> -    TCGv_ptr dest, mask;
> -    TCGv base, stride;
> -    TCGv_i32 desc;
> +    if (!s->vstart_eq_zero) {
> +        TCGv_ptr dest, mask;
> +        TCGv base, stride;
> +        TCGv_i32 desc;
>  
> -    dest = tcg_temp_new_ptr();
> -    mask = tcg_temp_new_ptr();
> -    base = get_gpr(s, rs1, EXT_NONE);
> -    stride = get_gpr(s, rs2, EXT_NONE);
> -    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
> -                                      s->cfg_ptr->vlenb, data));
> +        dest = tcg_temp_new_ptr();
> +        mask = tcg_temp_new_ptr();
> +        base = get_gpr(s, rs1, EXT_NONE);
> +        stride = get_gpr(s, rs2, EXT_NONE);
> +        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
> +                                          s->cfg_ptr->vlenb, data));
>  
> -    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
> -    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
> +        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
> +        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
> +        mark_vs_dirty(s);
> +        fn(dest, mask, base, stride, tcg_env, desc);
> +        return true;

Most of the lines changed here should just be indenting the
existing code into the 'if' branch. So maybe to split the patch
up a little and make less churn, you could do patch 1 that moves
this code into a function like gen_call_helper_ldst_stride().

Then after patch 2 it would be

    if (!s->vstart_eq_zero) {
        /* vstart != 0 helper slowpath */
        gen_call_helper_ldst_stride(vd, rs1, rs2, data, fn, is, is_load);
        return true;
    }

    [...]

> +    }
> +
> +    TCGv dest = tcg_temp_new();
> +
> +    uint32_t nf = FIELD_EX32(data, VDATA, NF);
> +    uint32_t vm = FIELD_EX32(data, VDATA, VM);
> +
> +    /* Destination register and mask register */
> +    tcg_gen_addi_tl(dest, (TCGv)tcg_env, vreg_ofs(s, vd));
> +
> +    /*
> +     * Select the appropriate load/tore to retrieve data from the vector
                                      ^^^^ store

[...]

> @@ -899,7 +1165,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
>  {
>      uint32_t data = 0;
>      gen_helper_ldst_stride *fn;
> -    static gen_helper_ldst_stride * const fns[4] = {
> +    static gen_helper_ldst_stride *const fns[4] = {
>          gen_helper_vlse8_v, gen_helper_vlse16_v,
>          gen_helper_vlse32_v, gen_helper_vlse64_v
>      };

This probably comes from my patch, just remove the hunk to
reduce patch size. Ditto for any other stray "cleanups".

> @@ -915,7 +1181,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
>      data = FIELD_DP32(data, VDATA, NF, a->nf);
>      data = FIELD_DP32(data, VDATA, VTA, s->vta);
>      data = FIELD_DP32(data, VDATA, VMA, s->vma);
> -    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
> +    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
>  }
>  
>  static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
> @@ -933,23 +1199,13 @@ GEN_VEXT_TRANS(vlse64_v, MO_64, rnfvm, ld_stride_op, ld_stride_check)
>  static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
>  {
>      uint32_t data = 0;
> -    gen_helper_ldst_stride *fn;
> -    static gen_helper_ldst_stride * const fns[4] = {
> -        /* masked stride store */
> -        gen_helper_vsse8_v,  gen_helper_vsse16_v,
> -        gen_helper_vsse32_v,  gen_helper_vsse64_v
> -    };

I gave you an old patch without the stores done, sorry. You
just need to pass the store helper fn through here similarly
as for loads (i.e., this hunk should just be the one liner
change to add extra 'is_load=false' argument to the
ldst_stride_trans() call.).

Thanks,
Nick

