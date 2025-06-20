Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401BBC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 09:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSXvT-0004ds-NI; Fri, 20 Jun 2025 05:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uSXvP-0004d7-RO
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:20:44 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uSXvM-00075L-BM
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:20:43 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-23636167afeso15638355ad.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 02:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750411237; x=1751016037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6xHf02YcT0Rgbc6pCd7Ec7qDWqlk0cFy9O/dqA1x7yU=;
 b=SsKy9E1rtlIBAlq/uqnRaI6e45jSlKSikuxF6MgBsYuNk+t6gHnO4ohI77PN+7iGV4
 NWqTahdN/izgr+byDvJYWw08xNkxpUbqSq57AdUgiMWVIuYw4E6YKSuPeFI/XezdOlD9
 wyUGdESL4OC4j/bkKdCs1x6kYjFnQOus0kOl6Ia5eoHvoYY3c8XJwmZlKWTq8EqfF5MG
 fgSHoY5hEv3hgbp0H6TCwchXsSIwuyKOoZqKADWhQf0LT6plCBdfH9sYTiPu9X18nS8O
 8rYEn632nPESlzkNbRmc5DOro8KLCOXE4QbbxqIXVbLcooqwykmVA5tk/FBjRWsSwwKi
 e3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750411237; x=1751016037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6xHf02YcT0Rgbc6pCd7Ec7qDWqlk0cFy9O/dqA1x7yU=;
 b=koal7TyK7NDGUNFTOQYvDzFvhRckgCJsngM8Fu2+e6OPhj3yJir/G+0MLQJTK+VNKy
 E1Qpco/SkeQRFM6nfwwu+0buOKRJpx176ciXdDG8DMtVM6d8TX/ZSaeHFaRCC9lL+H5M
 l2Qt0bUyMfVlQSSVpXm6rJxxvdZzixWHkzj2MwqJcl1prD5DoW8kHmC0BGAHyZYNSSSV
 3KcsHEyi/sbOqqUJthMN0K6Gx6r/Ml67hXV+5E4IsAO4vSqU/0PhpxP1PRQMV6JXpxCg
 79DZSWX6OOUILt3BUJEp0vBDPFjagDBGKUBPwVoSJihzprzfZiqk+GpUVC3+ieMfFMKI
 gFig==
X-Forwarded-Encrypted: i=1;
 AJvYcCURm9KDPepbvTbtZCGB+GKLTMJg8zzg3Vf8BTwUmtVbIbpqu2N6uY5IVKaeOkpEEqQCS3DoY03VIZd8@nongnu.org
X-Gm-Message-State: AOJu0YzSzIPnalWIv6vaIfk7E47I/zlmSeNyZbuzZ4aYMJJctUBDtfm4
 5AZvJejjtzjQIdYw1NGSqctghMESeOO6/zHubmTR2Ps+yunVhuYuz/rrQIvmMiWm7fo=
X-Gm-Gg: ASbGncvvHwjqfb6Of8uyo4rs1NpOnuh5ieoWSrlaaTDtkWPY0YHZ9LaIY5MV2uILm0F
 +F2R2Wp9RLREb9fL4N6hUMJpCMfhUCMKqqq5Q3ZAZFy/bHNhL3MYgl7CHM0aN3Xa9nDaLYW2BBm
 SFj/K4Aelw+1YhZyVfjhAbXi5jcn2Dj59cqFyzTnyHntUePDwkqCnnPUzGlxnmYg87iXjZWSvSx
 mtyLOLb7R0+r2TfDHZKEMowT1B4RE78tTg4Wr54FeSnRG9lG9DBNVuHBQ7dxv/s2qWmO9tJKNo3
 mgWGqEOQ8s0RLh9rUROoOE5nobD0cYMDtONIQkkm1k+4YxmRt2ZmU90ZuSCsxwtvjuCYsTZrr7j
 XIes2M/jG9Xc=
X-Google-Smtp-Source: AGHT+IECNGHCkAQh0JRfvKbJzCdStwuRNQsOlMU0/3+x/qzRb3MLORqBCOX1gpOwD4wT14LOsW/mVQ==
X-Received: by 2002:a17:903:2285:b0:235:225d:3098 with SMTP id
 d9443c01a7336-237d9b9384amr31681505ad.46.1750411236941; 
 Fri, 20 Jun 2025 02:20:36 -0700 (PDT)
Received: from [192.168.68.110] ([191.255.35.152])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83ce31asm13440085ad.63.2025.06.20.02.20.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 02:20:36 -0700 (PDT)
Message-ID: <15fe0336-71e2-4bd6-8465-805522c14197@ventanamicro.com>
Date: Fri, 20 Jun 2025 06:20:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Add a property to set vill bit on
 reserved usage of vsetvli instruction
To: Vasilis Liaskovitis <vliaskovitis@suse.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: ajones@ventanamicro.com, alistair.francis@wdc.com, philmd@linaro.org
References: <20250618213542.22873-1-vliaskovitis@suse.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250618213542.22873-1-vliaskovitis@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x644.google.com
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



On 6/18/25 6:35 PM, Vasilis Liaskovitis wrote:
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

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c                      |  1 +
>   target/riscv/cpu_cfg_fields.h.inc       |  1 +
>   target/riscv/helper.h                   |  2 +-
>   target/riscv/insn_trans/trans_rvv.c.inc |  4 ++--
>   target/riscv/vector_helper.c            | 12 +++++++++++-
>   5 files changed, 16 insertions(+), 4 deletions(-)
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
> index 5dc1c10012..b41c29da0b 100644
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
> @@ -83,6 +83,16 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       } else {
>           vl = vlmax;
>       }
> +
> +    if (cpu->cfg.rvv_vsetvl_x0_vill && x0 && (env->vl != vl)) {
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


