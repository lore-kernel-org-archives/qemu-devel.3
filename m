Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AA8C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 14:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRtgz-0004Cp-LZ; Wed, 18 Jun 2025 10:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uRtgt-0004Bj-Nt
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 10:23:07 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uRtgm-0002EL-OP
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 10:23:03 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-234b440afa7so70367215ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750256572; x=1750861372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DknIqKYf/d5KQMcqshNZkkgpnnTskoUbbgAQq1PkHyA=;
 b=EngBmpPzPBkeiTH3Y6deuMdzIBhNKfd/3Tqh+S2mSnLaUdUqklvsIvx0UHRdXlE32+
 bX/huEUAL/CEkKPY6j1XE6y/5AsPYKDHovuKxYYm25sIGh1qklgLLh1+HlFKwwNZlFVp
 FXZAQtA/rZW4cqS4woplo7NUCezEB+jCn636R2FFNfNZz21zudnzQySECxRpogNnAwV2
 DsTPK4ja9hO35igzhp2ihWjLfWl0oRs41N0ISlmQuIpeyNal7Sq3wz6UhKgbGPXo3qi+
 4X9dpG6SH1hFRwdCj5Eee201kLNBg3cHCvxfYHcLW0j36SnRRutHbqdjp6joGf70oK1V
 ZW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750256572; x=1750861372;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DknIqKYf/d5KQMcqshNZkkgpnnTskoUbbgAQq1PkHyA=;
 b=WXm4e8qcWYzTPVNjdnD0ZNJfiQlAx1d20so8zC4K5zxUU1fijetrqXt5UtI+TBJGGK
 BFInDdV6YlxaB95r04cZMHcy8luj5tUD6TY2k0of/BKAELSYx5xAzb08xYUlfUjlXKCn
 0g7/3ju6D29c8NabLaG1AIdeF0ZuHySNJhJLe4G6cz+AYXEO640d8tBVqW6eQecP9vQf
 ewaSa1NjyJH36LCvWLgoLJVUBh4R0GnhHc4af1RmBucAcmtcyp02z3D1r5T9JhjCJ2xQ
 AxrUgphG0TRDESbMqeen+JuU8v6GrobauBg2BJFgXQBLtxS23LrrYGWdHOKEcoRHJiDw
 jquA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVoD83epp1QQS9B9/iFzbcNoj8VBAwuoxkiEH9LPdSrsTezLPvWoQ0qGCnlzQxdmcT8OOrt+Mev9eI@nongnu.org
X-Gm-Message-State: AOJu0Ywx88i1G7bMvmqlx0fZ1GYwIPuWZ7CnR6fwhMLtIVIKMEYSs9v8
 YLlMnC8VqzQszkT32ekO+SPFmP4Cu5moyeRF09U9z05bGWHZjE5pqufbobjjddADQ0Q=
X-Gm-Gg: ASbGncsptS1RAYSKBN0dkAKOkkwgDXFwdiCnVhpDcAX/ghhLlGeDWcx5zIAS/RvoRbG
 5ZQhp7j0P/f8W/gNujrsWMgRIveeoEe0KGT0lhehh5sQPSRgWzlYdAPzS8aSM64RAECjLIJTuuQ
 MbORC8ySt1hC36u8RB/MJKcJwwZtKZD3b0YySiRBrsqZLj7dGONqOJPnrdnhmklaTi6lvMKpmIb
 RGBx1DX22uc6w5cwtn/swJgUFHBmIY3cJEkofGBs6njf3wlqjrqF2WccS16qXj/9zWr/oTho7/w
 hQPNir6PXWfcU7EKA9/y8tX8f2YSJVWzIkBEs4xa6aL5XYzUiggEtVFXsAdd+VF8vmx09CYG9Sp
 V
X-Google-Smtp-Source: AGHT+IEzC2kIAxqDS7lIuIeh2YAmV542Dg0U7NBq4LKBnDkrx0TT4o3F3ZGasoGgHo/oS1lh/zEmPQ==
X-Received: by 2002:a17:902:b681:b0:236:748f:541f with SMTP id
 d9443c01a7336-236748f5ec4mr173147985ad.33.1750256572516; 
 Wed, 18 Jun 2025 07:22:52 -0700 (PDT)
Received: from [192.168.68.110] ([191.255.35.152])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365dea8ff7sm100719695ad.171.2025.06.18.07.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 07:22:51 -0700 (PDT)
Message-ID: <9812c3c3-c9e4-4b29-968b-9da99891489a@ventanamicro.com>
Date: Wed, 18 Jun 2025 11:22:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Add a property to set vill bit on reserved
 usage of vsetvli instruction
To: Vasilis Liaskovitis <vliaskovitis@suse.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: ajones@ventanamicro.com, alistair.francis@wdc.com, philmd@linaro.org
References: <20250618072500.8469-1-vliaskovitis@suse.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250618072500.8469-1-vliaskovitis@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x641.google.com
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

Hi,

Thanks for putting this into a patch. A comment below:

On 6/18/25 4:25 AM, Vasilis Liaskovitis wrote:
> Usage of vsetvli instruction is reserved if VLMAX is changed when vsetvli rs1
> and rd arguments are x0.
> 
> In this case, if the new property is true, only the vill bit will be set.
> 
> See https://github.com/riscv/riscv-isa-manual/blob/main/src/v-st-ext.adoc#avl-encoding
> According to the spec, the above use cases are reserved, and
> "Implementations may set vill in either case."
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2422
> Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
> ---
>   target/riscv/cpu.c                      |  1 +
>   target/riscv/cpu_cfg_fields.h.inc       |  1 +
>   target/riscv/helper.h                   |  2 +-
>   target/riscv/insn_trans/trans_rvv.c.inc |  4 ++--
>   target/riscv/vector_helper.c            | 22 ++++++++++++----------
>   5 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501..1c29ed3b2b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2595,6 +2595,7 @@ static const Property riscv_cpu_properties[] = {
>       DEFINE_PROP_BOOL("rvv_ta_all_1s", RISCVCPU, cfg.rvv_ta_all_1s, false),
>       DEFINE_PROP_BOOL("rvv_ma_all_1s", RISCVCPU, cfg.rvv_ma_all_1s, false),
>       DEFINE_PROP_BOOL("rvv_vl_half_avl", RISCVCPU, cfg.rvv_vl_half_avl, false),
> +    DEFINE_PROP_BOOL("rvv_vsetvl_x0_vill", RISCVCPU, cfg.rvv_vsetvl_x0_vill, false),
>   
>       /*
>        * write_misa() is marked as experimental for now so mark
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 59f134a419..9c78a797cf 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -114,6 +114,7 @@ BOOL_FIELD(ext_supm)
>   BOOL_FIELD(rvv_ta_all_1s)
>   BOOL_FIELD(rvv_ma_all_1s)
>   BOOL_FIELD(rvv_vl_half_avl)
> +BOOL_FIELD(rvv_vsetvl_x0_vill)
>   /* Named features  */
>   BOOL_FIELD(ext_svade)
>   BOOL_FIELD(ext_zic64b)
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 85d73e492d..f712b1c368 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -159,7 +159,7 @@ DEF_HELPER_FLAGS_3(hyp_hsv_d, TCG_CALL_NO_WG, void, env, tl, tl)
>   #endif
>   
>   /* Vector functions */
> -DEF_HELPER_3(vsetvl, tl, env, tl, tl)
> +DEF_HELPER_4(vsetvl, tl, env, tl, tl, tl)
>   DEF_HELPER_5(vle8_v, void, ptr, ptr, tl, env, i32)
>   DEF_HELPER_5(vle16_v, void, ptr, ptr, tl, env, i32)
>   DEF_HELPER_5(vle32_v, void, ptr, ptr, tl, env, i32)
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 2b6077ac06..87071c5d62 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -202,7 +202,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
>           s1 = get_gpr(s, rs1, EXT_ZERO);
>       }
>   
> -    gen_helper_vsetvl(dst, tcg_env, s1, s2);
> +    gen_helper_vsetvl(dst, tcg_env, s1, s2, tcg_constant_tl((int) (rd == 0 && rs1 == 0)));
>       gen_set_gpr(s, rd, dst);
>       finalize_rvv_inst(s);
>   
> @@ -222,7 +222,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
>   
>       dst = dest_gpr(s, rd);
>   
> -    gen_helper_vsetvl(dst, tcg_env, s1, s2);
> +    gen_helper_vsetvl(dst, tcg_env, s1, s2, tcg_constant_tl(0));
>       gen_set_gpr(s, rd, dst);
>       finalize_rvv_inst(s);
>       gen_update_pc(s, s->cur_insn_len);
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 5dc1c10012..2545d73cc1 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -35,7 +35,7 @@
>   #include <math.h>
>   
>   target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
> -                            target_ulong s2)
> +                            target_ulong s2, target_ulong x0)
>   {
>       int vlmax, vl;
>       RISCVCPU *cpu = env_archcpu(env);
> @@ -64,15 +64,6 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>           }
>       }
>   
> -    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
> -        /* only set vill bit. */
> -        env->vill = 1;
> -        env->vtype = 0;
> -        env->vl = 0;
> -        env->vstart = 0;
> -        return 0;
> -    }
> -
>       /* lmul encoded as in DisasContext::lmul */
>       lmul = sextract32(FIELD_EX64(s2, VTYPE, VLMUL), 0, 3);
>       vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
> @@ -83,6 +74,17 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       } else {
>           vl = vlmax;
>       }
> +
> +    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0) ||
> +        (cpu->cfg.rvv_vsetvl_x0_vill && x0 && (env->vl != vl))) {

In this particular case I don't mind replicating code. The first existing check can be
left untouched, exiting early before spending time calculating vlmax and vl.

We can then add the new check that depends on vl here, even if we end up copying those
few "env->something =" lines again. If you really want to avoid code duplication I
wouldn't oppose adding a 'vill' label and using 'goto' as an alternative of duplicating
those 6 lines.


Patch LGTM otherwise. Thanks,


Daniel

> +        /* only set vill bit. */
> +        env->vill = 1;
> +        env->vtype = 0;
> +        env->vl = 0;
> +        env->vstart = 0;
> +        return 0;
> +    }
> +
>       env->vl = vl;
>       env->vtype = s2;
>       env->vstart = 0;


