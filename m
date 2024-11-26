Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DD2D3B994
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFwQU-0001a4-Mu; Tue, 26 Nov 2024 09:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFwQR-0001Zt-Bm
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:20:23 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFwQJ-0000gv-Ls
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:20:21 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-296b567bc30so1744038fac.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732630814; x=1733235614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BEMfwUYyWm6IvAvyDfISl88O+XFm0j/syYv1lf0imMA=;
 b=Afnfb9fibyqbQ0uvGIpyCeRJd2mbPeNTcKyiVD3XUIEh2z/BOro7eDGcawDgTlfITB
 Bb0u2Hcl9go5HxoBSts4l/5ng0ymIXPW/l36xp4RNbkg7yjfdsiA7pQp+dc3PdFMXVLp
 rTWsiifkAmM/w38vzMXVqcZAMm0qsM/g6jSA9DC19IaDbXjcFi8lppNlVElpqAp+I8UW
 HUlJPkBLZlCJtMrdBem8y14MnpdgI3+CmGgNAORQvgvTPYA8CxsCaK+MzWVOWmuwX8tF
 NqlSGQ2ih0lNeS3NfnmBb6zWs9VkHPNg2zXdwImfJ30Veabb0OXkDu6CVF97lZwxMHtQ
 WbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732630814; x=1733235614;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BEMfwUYyWm6IvAvyDfISl88O+XFm0j/syYv1lf0imMA=;
 b=WU1rHACblELPFCweQKHlW+JVRaKAShcAMuwadlmCdWuIvXML83pO7Hl2r6gMZzP8hi
 oMRKl5SyEBcFP1DRnjuTcZGauc/2Nm73a42Ns8DxxWSJMvdF6ae/SmzLLNGiLlcccHgb
 sresKmhzxOA1B2anUq71Cdzfkw+DXrDwakoOyI/83wz1pYqDEtlMjvKp3XWYfCfm7525
 wHQm6kDUIlHQqSFx3Jy/863R6yZifBYTel3u1F+izJI/OGJchZ7tZrCacbqavARGVPpu
 Fq2XWQCkfHlpCMCZCRZ04AIHwkNiQclSsNu8RyB05Lqm3HAeYDC+nFrJQFtapvZLFFYd
 yGeA==
X-Gm-Message-State: AOJu0YyetgZPObcyp2ptYm9FsxUYzlFg3pNzgZJ/GERdJhu1NZF377OG
 +tFyZ/ZhtQQtLx6BG1OZSZPViKOW10ZhK7UeysdpHGZtVLOUvqSusVWGaPX8NiNyrSt0oSFJhm4
 F
X-Gm-Gg: ASbGncvPEq24/OykgeaWJhrSXM+s9phQie47+fzuBjCK5ex4RXtm5mFzc1uYBHQIaRU
 4s7dD2gfu8ChGetEqNPWHWG9lpxhnnfwf9qZ+fXVG0dgAxRaFxMz1dPqdwnQoi5HCZqYvXklF8Y
 zSQanV0Zn6Z+oqulG2bzLUxZHWz3Axnk2sc0wDoQBoV86BekvjEW3/FGErm7mVDlNqB6vT61Jpu
 JMWb0pVEV8Wy1jEsdfO4Gt8xpwse7xkt4CbTu3XINngymY5cTsarvxZVtn+bvjtVw==
X-Google-Smtp-Source: AGHT+IEheBZucpCeAaSxKg/4kNcr9WsoGzP/NeHnKGVQUMfNuF8faQa1SUw5pqOr4Nx3TeJyWnM47Q==
X-Received: by 2002:a05:6870:af0c:b0:297:285e:f9f4 with SMTP id
 586e51a60fabf-297285efab9mr12246167fac.34.1732630812732; 
 Tue, 26 Nov 2024 06:20:12 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71c03845e76sm2951102a34.72.2024.11.26.06.20.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 06:20:11 -0800 (PST)
Message-ID: <08e6c936-756a-4483-95e5-8b000c4e295f@linaro.org>
Date: Tue, 26 Nov 2024 08:20:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] target/mips: Access MXU registers using TCGv_i32 API
To: qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126131546.66145-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
> MXU extension is only built for 32-bit targets,
> its registers are 32-bit only: no need to call
> the 'target-wide' TCG API, we can simply use the
> 32-bit one.
> 
> Mechanical change doing:
> 
>    $ sed -e -i 's/_tl/_i32/g' target/mips/tcg/mxu_translate.c
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/mxu_translate.c | 1538 +++++++++++++++----------------
>   1 file changed, 769 insertions(+), 769 deletions(-)
> 
> diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
> index ee70ae96c32..69b6b352024 100644
> --- a/target/mips/tcg/mxu_translate.c
> +++ b/target/mips/tcg/mxu_translate.c
> @@ -631,16 +631,16 @@ void mxu_translate_init(void)
>   static inline void gen_load_mxu_gpr(TCGv t, unsigned int reg)
>   {
>       if (reg == 0) {
> -        tcg_gen_movi_tl(t, 0);
> +        tcg_gen_movi_i32(t, 0);
>       } else if (reg <= 15) {
> -        tcg_gen_mov_tl(t, mxu_gpr[reg - 1]);
> +        tcg_gen_mov_i32(t, mxu_gpr[reg - 1]);
>       }
>   }

I think you want to s/TCGv/TCGv_i32/ as well.


r~

>   
>   static inline void gen_store_mxu_gpr(TCGv t, unsigned int reg)
>   {
>       if (reg > 0 && reg <= 15) {
> -        tcg_gen_mov_tl(mxu_gpr[reg - 1], t);
> +        tcg_gen_mov_i32(mxu_gpr[reg - 1], t);
>       }
>   }
>   
> @@ -648,22 +648,22 @@ static inline void gen_extract_mxu_gpr(TCGv t, unsigned int reg,
>                                          unsigned int ofs, unsigned int len)
>   {
>       if (reg == 0) {
> -        tcg_gen_movi_tl(t, 0);
> +        tcg_gen_movi_i32(t, 0);
>       } else if (reg <= 15) {
> -        tcg_gen_extract_tl(t, mxu_gpr[reg - 1], ofs, len);
> +        tcg_gen_extract_i32(t, mxu_gpr[reg - 1], ofs, len);
>       }
>   }
>   
>   /* MXU control register moves. */
>   static inline void gen_load_mxu_cr(TCGv t)
>   {
> -    tcg_gen_mov_tl(t, mxu_CR);
> +    tcg_gen_mov_i32(t, mxu_CR);
>   }
>   
>   static inline void gen_store_mxu_cr(TCGv t)
>   {
>       /* TODO: Add handling of RW rules for MXU_CR. */
> -    tcg_gen_mov_tl(mxu_CR, t);
> +    tcg_gen_mov_i32(mxu_CR, t);
>   }
>   
>   /*
> @@ -679,7 +679,7 @@ static void gen_mxu_s32i2m(DisasContext *ctx)
>       XRa = extract32(ctx->opcode, 6, 5);
>       Rb = extract32(ctx->opcode, 16, 5);
>   
> -    gen_load_gpr_tl(t0, Rb);
> +    gen_load_gpr_i32(t0, Rb);
>       if (XRa <= 15) {
>           gen_store_mxu_gpr(t0, XRa);
>       } else if (XRa == 16) {
> @@ -706,7 +706,7 @@ static void gen_mxu_s32m2i(DisasContext *ctx)
>           gen_load_mxu_cr(t0);
>       }
>   
> -    gen_store_gpr_tl(t0, Rb);
> +    gen_store_gpr_i32(t0, Rb);
>   }
>   
>   /*
> @@ -728,61 +728,61 @@ static void gen_mxu_s8ldd(DisasContext *ctx, bool postmodify)
>       optn3 = extract32(ctx->opcode, 18, 3);
>       Rb = extract32(ctx->opcode, 21, 5);
>   
> -    gen_load_gpr_tl(t0, Rb);
> -    tcg_gen_addi_tl(t0, t0, (int8_t)s8);
> +    gen_load_gpr_i32(t0, Rb);
> +    tcg_gen_addi_i32(t0, t0, (int8_t)s8);
>       if (postmodify) {
> -        gen_store_gpr_tl(t0, Rb);
> +        gen_store_gpr_i32(t0, Rb);
>       }
>   
>       switch (optn3) {
>       /* XRa[7:0] = tmp8 */
>       case MXU_OPTN3_PTN0:
> -        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UB);
>           gen_load_mxu_gpr(t0, XRa);
> -        tcg_gen_deposit_tl(t0, t0, t1, 0, 8);
> +        tcg_gen_deposit_i32(t0, t0, t1, 0, 8);
>           break;
>       /* XRa[15:8] = tmp8 */
>       case MXU_OPTN3_PTN1:
> -        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UB);
>           gen_load_mxu_gpr(t0, XRa);
> -        tcg_gen_deposit_tl(t0, t0, t1, 8, 8);
> +        tcg_gen_deposit_i32(t0, t0, t1, 8, 8);
>           break;
>       /* XRa[23:16] = tmp8 */
>       case MXU_OPTN3_PTN2:
> -        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UB);
>           gen_load_mxu_gpr(t0, XRa);
> -        tcg_gen_deposit_tl(t0, t0, t1, 16, 8);
> +        tcg_gen_deposit_i32(t0, t0, t1, 16, 8);
>           break;
>       /* XRa[31:24] = tmp8 */
>       case MXU_OPTN3_PTN3:
> -        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UB);
>           gen_load_mxu_gpr(t0, XRa);
> -        tcg_gen_deposit_tl(t0, t0, t1, 24, 8);
> +        tcg_gen_deposit_i32(t0, t0, t1, 24, 8);
>           break;
>       /* XRa = {8'b0, tmp8, 8'b0, tmp8} */
>       case MXU_OPTN3_PTN4:
> -        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> -        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
> +        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UB);
> +        tcg_gen_deposit_i32(t0, t1, t1, 16, 16);
>           break;
>       /* XRa = {tmp8, 8'b0, tmp8, 8'b0} */
>       case MXU_OPTN3_PTN5:
> -        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> -        tcg_gen_shli_tl(t1, t1, 8);
> -        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
> +        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UB);
> +        tcg_gen_shli_i32(t1, t1, 8);
> +        tcg_gen_deposit_i32(t0, t1, t1, 16, 16);
>           break;
>       /* XRa = {{8{sign of tmp8}}, tmp8, {8{sign of tmp8}}, tmp8} */
>       case MXU_OPTN3_PTN6:
> -        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_SB);
> -        tcg_gen_mov_tl(t0, t1);
> -        tcg_gen_andi_tl(t0, t0, 0xFF00FFFF);
> -        tcg_gen_shli_tl(t1, t1, 16);
> -        tcg_gen_or_tl(t0, t0, t1);
> +        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_SB);
> +        tcg_gen_mov_i32(t0, t1);
> +        tcg_gen_andi_i32(t0, t0, 0xFF00FFFF);
> +        tcg_gen_shli_i32(t1, t1, 16);
> +        tcg_gen_or_i32(t0, t0, t1);
>           break;
>       /* XRa = {tmp8, tmp8, tmp8, tmp8} */
>       case MXU_OPTN3_PTN7:
> -        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> -        tcg_gen_deposit_tl(t1, t1, t1, 8, 8);
> -        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
> +        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UB);
> +        tcg_gen_deposit_i32(t1, t1, t1, 8, 8);
> +        tcg_gen_deposit_i32(t0, t1, t1, 16, 16);
>           break;
>       }
>   
> @@ -813,33 +813,33 @@ static void gen_mxu_s8std(DisasContext *ctx, bool postmodify)
>           return;
>       }
>   
> -    gen_load_gpr_tl(t0, Rb);
> -    tcg_gen_addi_tl(t0, t0, (int8_t)s8);
> +    gen_load_gpr_i32(t0, Rb);
> +    tcg_gen_addi_i32(t0, t0, (int8_t)s8);
>       if (postmodify) {
> -        gen_store_gpr_tl(t0, Rb);
> +        gen_store_gpr_i32(t0, Rb);
>       }
>       gen_load_mxu_gpr(t1, XRa);
>   
>       switch (optn3) {
>       /* XRa[7:0] => tmp8 */
>       case MXU_OPTN3_PTN0:
> -        tcg_gen_extract_tl(t1, t1, 0, 8);
> +        tcg_gen_extract_i32(t1, t1, 0, 8);
>           break;
>       /* XRa[15:8] => tmp8 */
>       case MXU_OPTN3_PTN1:
> -        tcg_gen_extract_tl(t1, t1, 8, 8);
> +        tcg_gen_extract_i32(t1, t1, 8, 8);
>           break;
>       /* XRa[23:16] => tmp8 */
>       case MXU_OPTN3_PTN2:
> -        tcg_gen_extract_tl(t1, t1, 16, 8);
> +        tcg_gen_extract_i32(t1, t1, 16, 8);
>           break;
>       /* XRa[31:24] => tmp8 */
>       case MXU_OPTN3_PTN3:
> -        tcg_gen_extract_tl(t1, t1, 24, 8);
> +        tcg_gen_extract_i32(t1, t1, 24, 8);
>           break;
>       }
>   
> -    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_UB);
> +    tcg_gen_qemu_st_i32(t1, t0, ctx->mem_idx, MO_UB);
>   }
>   
>   /*
> @@ -862,34 +862,34 @@ static void gen_mxu_s16ldd(DisasContext *ctx, bool postmodify)
>       optn2 = extract32(ctx->opcode,  19, 2);
>       Rb    = extract32(ctx->opcode,  21, 5);
>   
> -    gen_load_gpr_tl(t0, Rb);
> -    tcg_gen_addi_tl(t0, t0, s10);
> +    gen_load_gpr_i32(t0, Rb);
> +    tcg_gen_addi_i32(t0, t0, s10);
>       if (postmodify) {
> -        gen_store_gpr_tl(t0, Rb);
> +        gen_store_gpr_i32(t0, Rb);
>       }
>   
>       switch (optn2) {
>       /* XRa[15:0] = tmp16 */
>       case MXU_OPTN2_PTN0:
> -        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UW);
> +        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UW);
>           gen_load_mxu_gpr(t0, XRa);
> -        tcg_gen_deposit_tl(t0, t0, t1, 0, 16);
> +        tcg_gen_deposit_i32(t0, t0, t1, 0, 16);
>           break;
>       /* XRa[31:16] = tmp16 */
>       case MXU_OPTN2_PTN1:
> -        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UW);
> +        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UW);
>           gen_load_mxu_gpr(t0, XRa);
> -        tcg_gen_deposit_tl(t0, t0, t1, 16, 16);
> +        tcg_gen_deposit_i32(t0, t0, t1, 16, 16);
>           break;
>       /* XRa = sign_extend(tmp16) */
>       case MXU_OPTN2_PTN2:
> -        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SW);
> +        tcg_gen_qemu_ld_i32(t0, t0, ctx->mem_idx, MO_SW);
>           break;
>       /* XRa = {tmp16, tmp16} */
>       case MXU_OPTN2_PTN3:
> -        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UW);
> -        tcg_gen_deposit_tl(t0, t1, t1,  0, 16);
> -        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
> +        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UW);
> +        tcg_gen_deposit_i32(t0, t1, t1,  0, 16);
> +        tcg_gen_deposit_i32(t0, t1, t1, 16, 16);
>           break;
>       }
>   
> @@ -921,25 +921,25 @@ static void gen_mxu_s16std(DisasContext *ctx, bool postmodify)
>           return;
>       }
>   
> -    gen_load_gpr_tl(t0, Rb);
> -    tcg_gen_addi_tl(t0, t0, s10);
> +    gen_load_gpr_i32(t0, Rb);
> +    tcg_gen_addi_i32(t0, t0, s10);
>       if (postmodify) {
> -        gen_store_gpr_tl(t0, Rb);
> +        gen_store_gpr_i32(t0, Rb);
>       }
>       gen_load_mxu_gpr(t1, XRa);
>   
>       switch (optn2) {
>       /* XRa[15:0] => tmp16 */
>       case MXU_OPTN2_PTN0:
> -        tcg_gen_extract_tl(t1, t1, 0, 16);
> +        tcg_gen_extract_i32(t1, t1, 0, 16);
>           break;
>       /* XRa[31:16] => tmp16 */
>       case MXU_OPTN2_PTN1:
> -        tcg_gen_extract_tl(t1, t1, 16, 16);
> +        tcg_gen_extract_i32(t1, t1, 16, 16);
>           break;
>       }
>   
> -    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_UW);
> +    tcg_gen_qemu_st_i32(t1, t0, ctx->mem_idx, MO_UW);
>   }
>   
>   /*
> @@ -965,20 +965,20 @@ static void gen_mxu_s32mul(DisasContext *ctx, bool mulu)
>       rt  = extract32(ctx->opcode, 21, 5);
>   
>       if (unlikely(rs == 0 || rt == 0)) {
> -        tcg_gen_movi_tl(t0, 0);
> -        tcg_gen_movi_tl(t1, 0);
> +        tcg_gen_movi_i32(t0, 0);
> +        tcg_gen_movi_i32(t1, 0);
>       } else {
> -        gen_load_gpr_tl(t0, rs);
> -        gen_load_gpr_tl(t1, rt);
> +        gen_load_gpr_i32(t0, rs);
> +        gen_load_gpr_i32(t1, rt);
>   
>           if (mulu) {
> -            tcg_gen_mulu2_tl(t0, t1, t0, t1);
> +            tcg_gen_mulu2_i32(t0, t1, t0, t1);
>           } else {
> -            tcg_gen_muls2_tl(t0, t1, t0, t1);
> +            tcg_gen_muls2_i32(t0, t1, t0, t1);
>           }
>       }
> -    tcg_gen_mov_tl(cpu_HI[0], t1);
> -    tcg_gen_mov_tl(cpu_LO[0], t0);
> +    tcg_gen_mov_i32(cpu_HI[0], t1);
> +    tcg_gen_mov_i32(cpu_LO[0], t0);
>       gen_store_mxu_gpr(t1, XRa);
>       gen_store_mxu_gpr(t0, XRd);
>   }
> @@ -1014,38 +1014,38 @@ static void gen_mxu_d16mul(DisasContext *ctx, bool fractional,
>        */
>   
>       gen_load_mxu_gpr(t1, XRb);
> -    tcg_gen_sextract_tl(t0, t1, 0, 16);
> -    tcg_gen_sextract_tl(t1, t1, 16, 16);
> +    tcg_gen_sextract_i32(t0, t1, 0, 16);
> +    tcg_gen_sextract_i32(t1, t1, 16, 16);
>       gen_load_mxu_gpr(t3, XRc);
> -    tcg_gen_sextract_tl(t2, t3, 0, 16);
> -    tcg_gen_sextract_tl(t3, t3, 16, 16);
> +    tcg_gen_sextract_i32(t2, t3, 0, 16);
> +    tcg_gen_sextract_i32(t3, t3, 16, 16);
>   
>       switch (optn2) {
>       case MXU_OPTN2_WW: /* XRB.H*XRC.H == lop, XRB.L*XRC.L == rop */
> -        tcg_gen_mul_tl(t3, t1, t3);
> -        tcg_gen_mul_tl(t2, t0, t2);
> +        tcg_gen_mul_i32(t3, t1, t3);
> +        tcg_gen_mul_i32(t2, t0, t2);
>           break;
>       case MXU_OPTN2_LW: /* XRB.L*XRC.H == lop, XRB.L*XRC.L == rop */
> -        tcg_gen_mul_tl(t3, t0, t3);
> -        tcg_gen_mul_tl(t2, t0, t2);
> +        tcg_gen_mul_i32(t3, t0, t3);
> +        tcg_gen_mul_i32(t2, t0, t2);
>           break;
>       case MXU_OPTN2_HW: /* XRB.H*XRC.H == lop, XRB.H*XRC.L == rop */
> -        tcg_gen_mul_tl(t3, t1, t3);
> -        tcg_gen_mul_tl(t2, t1, t2);
> +        tcg_gen_mul_i32(t3, t1, t3);
> +        tcg_gen_mul_i32(t2, t1, t2);
>           break;
>       case MXU_OPTN2_XW: /* XRB.L*XRC.H == lop, XRB.H*XRC.L == rop */
> -        tcg_gen_mul_tl(t3, t0, t3);
> -        tcg_gen_mul_tl(t2, t1, t2);
> +        tcg_gen_mul_i32(t3, t0, t3);
> +        tcg_gen_mul_i32(t2, t1, t2);
>           break;
>       }
>       if (fractional) {
>           TCGLabel *l_done = gen_new_label();
>           TCGv rounding = tcg_temp_new();
>   
> -        tcg_gen_shli_tl(t3, t3, 1);
> -        tcg_gen_shli_tl(t2, t2, 1);
> -        tcg_gen_andi_tl(rounding, mxu_CR, 0x2);
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, rounding, 0, l_done);
> +        tcg_gen_shli_i32(t3, t3, 1);
> +        tcg_gen_shli_i32(t2, t2, 1);
> +        tcg_gen_andi_i32(rounding, mxu_CR, 0x2);
> +        tcg_gen_brcondi_i32(TCG_COND_EQ, rounding, 0, l_done);
>           if (packed_result) {
>               TCGLabel *l_apply_bias_l = gen_new_label();
>               TCGLabel *l_apply_bias_r = gen_new_label();
> @@ -1056,22 +1056,22 @@ static void gen_mxu_d16mul(DisasContext *ctx, bool fractional,
>                * D16MULF supports unbiased rounding aka "bankers rounding",
>                * "round to even", "convergent rounding"
>                */
> -            tcg_gen_andi_tl(bias, mxu_CR, 0x4);
> -            tcg_gen_brcondi_tl(TCG_COND_NE, bias, 0, l_apply_bias_l);
> -            tcg_gen_andi_tl(t0, t3, 0x1ffff);
> -            tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0x8000, l_half_done);
> +            tcg_gen_andi_i32(bias, mxu_CR, 0x4);
> +            tcg_gen_brcondi_i32(TCG_COND_NE, bias, 0, l_apply_bias_l);
> +            tcg_gen_andi_i32(t0, t3, 0x1ffff);
> +            tcg_gen_brcondi_i32(TCG_COND_EQ, t0, 0x8000, l_half_done);
>               gen_set_label(l_apply_bias_l);
> -            tcg_gen_addi_tl(t3, t3, 0x8000);
> +            tcg_gen_addi_i32(t3, t3, 0x8000);
>               gen_set_label(l_half_done);
> -            tcg_gen_brcondi_tl(TCG_COND_NE, bias, 0, l_apply_bias_r);
> -            tcg_gen_andi_tl(t0, t2, 0x1ffff);
> -            tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0x8000, l_done);
> +            tcg_gen_brcondi_i32(TCG_COND_NE, bias, 0, l_apply_bias_r);
> +            tcg_gen_andi_i32(t0, t2, 0x1ffff);
> +            tcg_gen_brcondi_i32(TCG_COND_EQ, t0, 0x8000, l_done);
>               gen_set_label(l_apply_bias_r);
> -            tcg_gen_addi_tl(t2, t2, 0x8000);
> +            tcg_gen_addi_i32(t2, t2, 0x8000);
>           } else {
>               /* D16MULE doesn't support unbiased rounding */
> -            tcg_gen_addi_tl(t3, t3, 0x8000);
> -            tcg_gen_addi_tl(t2, t2, 0x8000);
> +            tcg_gen_addi_i32(t3, t3, 0x8000);
> +            tcg_gen_addi_i32(t2, t2, 0x8000);
>           }
>           gen_set_label(l_done);
>       }
> @@ -1079,9 +1079,9 @@ static void gen_mxu_d16mul(DisasContext *ctx, bool fractional,
>           gen_store_mxu_gpr(t3, XRa);
>           gen_store_mxu_gpr(t2, XRd);
>       } else {
> -        tcg_gen_andi_tl(t3, t3, 0xffff0000);
> -        tcg_gen_shri_tl(t2, t2, 16);
> -        tcg_gen_or_tl(t3, t3, t2);
> +        tcg_gen_andi_i32(t3, t3, 0xffff0000);
> +        tcg_gen_shri_i32(t2, t2, 16);
> +        tcg_gen_or_i32(t3, t3, t2);
>           gen_store_mxu_gpr(t3, XRa);
>       }
>   }
> @@ -1113,55 +1113,55 @@ static void gen_mxu_d16mac(DisasContext *ctx, bool fractional,
>       aptn2 = extract32(ctx->opcode, 24, 2);
>   
>       gen_load_mxu_gpr(t1, XRb);
> -    tcg_gen_sextract_tl(t0, t1, 0, 16);
> -    tcg_gen_sextract_tl(t1, t1, 16, 16);
> +    tcg_gen_sextract_i32(t0, t1, 0, 16);
> +    tcg_gen_sextract_i32(t1, t1, 16, 16);
>   
>       gen_load_mxu_gpr(t3, XRc);
> -    tcg_gen_sextract_tl(t2, t3, 0, 16);
> -    tcg_gen_sextract_tl(t3, t3, 16, 16);
> +    tcg_gen_sextract_i32(t2, t3, 0, 16);
> +    tcg_gen_sextract_i32(t3, t3, 16, 16);
>   
>       switch (optn2) {
>       case MXU_OPTN2_WW: /* XRB.H*XRC.H == lop, XRB.L*XRC.L == rop */
> -        tcg_gen_mul_tl(t3, t1, t3);
> -        tcg_gen_mul_tl(t2, t0, t2);
> +        tcg_gen_mul_i32(t3, t1, t3);
> +        tcg_gen_mul_i32(t2, t0, t2);
>           break;
>       case MXU_OPTN2_LW: /* XRB.L*XRC.H == lop, XRB.L*XRC.L == rop */
> -        tcg_gen_mul_tl(t3, t0, t3);
> -        tcg_gen_mul_tl(t2, t0, t2);
> +        tcg_gen_mul_i32(t3, t0, t3);
> +        tcg_gen_mul_i32(t2, t0, t2);
>           break;
>       case MXU_OPTN2_HW: /* XRB.H*XRC.H == lop, XRB.H*XRC.L == rop */
> -        tcg_gen_mul_tl(t3, t1, t3);
> -        tcg_gen_mul_tl(t2, t1, t2);
> +        tcg_gen_mul_i32(t3, t1, t3);
> +        tcg_gen_mul_i32(t2, t1, t2);
>           break;
>       case MXU_OPTN2_XW: /* XRB.L*XRC.H == lop, XRB.H*XRC.L == rop */
> -        tcg_gen_mul_tl(t3, t0, t3);
> -        tcg_gen_mul_tl(t2, t1, t2);
> +        tcg_gen_mul_i32(t3, t0, t3);
> +        tcg_gen_mul_i32(t2, t1, t2);
>           break;
>       }
>   
>       if (fractional) {
> -        tcg_gen_shli_tl(t3, t3, 1);
> -        tcg_gen_shli_tl(t2, t2, 1);
> +        tcg_gen_shli_i32(t3, t3, 1);
> +        tcg_gen_shli_i32(t2, t2, 1);
>       }
>       gen_load_mxu_gpr(t0, XRa);
>       gen_load_mxu_gpr(t1, XRd);
>   
>       switch (aptn2) {
>       case MXU_APTN2_AA:
> -        tcg_gen_add_tl(t3, t0, t3);
> -        tcg_gen_add_tl(t2, t1, t2);
> +        tcg_gen_add_i32(t3, t0, t3);
> +        tcg_gen_add_i32(t2, t1, t2);
>           break;
>       case MXU_APTN2_AS:
> -        tcg_gen_add_tl(t3, t0, t3);
> -        tcg_gen_sub_tl(t2, t1, t2);
> +        tcg_gen_add_i32(t3, t0, t3);
> +        tcg_gen_sub_i32(t2, t1, t2);
>           break;
>       case MXU_APTN2_SA:
> -        tcg_gen_sub_tl(t3, t0, t3);
> -        tcg_gen_add_tl(t2, t1, t2);
> +        tcg_gen_sub_i32(t3, t0, t3);
> +        tcg_gen_add_i32(t2, t1, t2);
>           break;
>       case MXU_APTN2_SS:
> -        tcg_gen_sub_tl(t3, t0, t3);
> -        tcg_gen_sub_tl(t2, t1, t2);
> +        tcg_gen_sub_i32(t3, t0, t3);
> +        tcg_gen_sub_i32(t2, t1, t2);
>           break;
>       }
>   
> @@ -1169,8 +1169,8 @@ static void gen_mxu_d16mac(DisasContext *ctx, bool fractional,
>           TCGLabel *l_done = gen_new_label();
>           TCGv rounding = tcg_temp_new();
>   
> -        tcg_gen_andi_tl(rounding, mxu_CR, 0x2);
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, rounding, 0, l_done);
> +        tcg_gen_andi_i32(rounding, mxu_CR, 0x2);
> +        tcg_gen_brcondi_i32(TCG_COND_EQ, rounding, 0, l_done);
>           if (packed_result) {
>               TCGLabel *l_apply_bias_l = gen_new_label();
>               TCGLabel *l_apply_bias_r = gen_new_label();
> @@ -1181,22 +1181,22 @@ static void gen_mxu_d16mac(DisasContext *ctx, bool fractional,
>                * D16MACF supports unbiased rounding aka "bankers rounding",
>                * "round to even", "convergent rounding"
>                */
> -            tcg_gen_andi_tl(bias, mxu_CR, 0x4);
> -            tcg_gen_brcondi_tl(TCG_COND_NE, bias, 0, l_apply_bias_l);
> -            tcg_gen_andi_tl(t0, t3, 0x1ffff);
> -            tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0x8000, l_half_done);
> +            tcg_gen_andi_i32(bias, mxu_CR, 0x4);
> +            tcg_gen_brcondi_i32(TCG_COND_NE, bias, 0, l_apply_bias_l);
> +            tcg_gen_andi_i32(t0, t3, 0x1ffff);
> +            tcg_gen_brcondi_i32(TCG_COND_EQ, t0, 0x8000, l_half_done);
>               gen_set_label(l_apply_bias_l);
> -            tcg_gen_addi_tl(t3, t3, 0x8000);
> +            tcg_gen_addi_i32(t3, t3, 0x8000);
>               gen_set_label(l_half_done);
> -            tcg_gen_brcondi_tl(TCG_COND_NE, bias, 0, l_apply_bias_r);
> -            tcg_gen_andi_tl(t0, t2, 0x1ffff);
> -            tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0x8000, l_done);
> +            tcg_gen_brcondi_i32(TCG_COND_NE, bias, 0, l_apply_bias_r);
> +            tcg_gen_andi_i32(t0, t2, 0x1ffff);
> +            tcg_gen_brcondi_i32(TCG_COND_EQ, t0, 0x8000, l_done);
>               gen_set_label(l_apply_bias_r);
> -            tcg_gen_addi_tl(t2, t2, 0x8000);
> +            tcg_gen_addi_i32(t2, t2, 0x8000);
>           } else {
>               /* D16MACE doesn't support unbiased rounding */
> -            tcg_gen_addi_tl(t3, t3, 0x8000);
> -            tcg_gen_addi_tl(t2, t2, 0x8000);
> +            tcg_gen_addi_i32(t3, t3, 0x8000);
> +            tcg_gen_addi_i32(t2, t2, 0x8000);
>           }
>           gen_set_label(l_done);
>       }
> @@ -1205,9 +1205,9 @@ static void gen_mxu_d16mac(DisasContext *ctx, bool fractional,
>           gen_store_mxu_gpr(t3, XRa);
>           gen_store_mxu_gpr(t2, XRd);
>       } else {
> -        tcg_gen_andi_tl(t3, t3, 0xffff0000);
> -        tcg_gen_shri_tl(t2, t2, 16);
> -        tcg_gen_or_tl(t3, t3, t2);
> +        tcg_gen_andi_i32(t3, t3, 0xffff0000);
> +        tcg_gen_shri_i32(t2, t2, 16);
> +        tcg_gen_or_i32(t3, t3, t2);
>           gen_store_mxu_gpr(t3, XRa);
>       }
>   }
> @@ -1234,60 +1234,60 @@ static void gen_mxu_d16madl(DisasContext *ctx)
>       aptn2 = extract32(ctx->opcode, 24, 2);
>   
>       gen_load_mxu_gpr(t1, XRb);
> -    tcg_gen_sextract_tl(t0, t1,  0, 16);
> -    tcg_gen_sextract_tl(t1, t1, 16, 16);
> +    tcg_gen_sextract_i32(t0, t1,  0, 16);
> +    tcg_gen_sextract_i32(t1, t1, 16, 16);
>   
>       gen_load_mxu_gpr(t3, XRc);
> -    tcg_gen_sextract_tl(t2, t3,  0, 16);
> -    tcg_gen_sextract_tl(t3, t3, 16, 16);
> +    tcg_gen_sextract_i32(t2, t3,  0, 16);
> +    tcg_gen_sextract_i32(t3, t3, 16, 16);
>   
>       switch (optn2) {
>       case MXU_OPTN2_WW: /* XRB.H*XRC.H == lop, XRB.L*XRC.L == rop */
> -        tcg_gen_mul_tl(t3, t1, t3);
> -        tcg_gen_mul_tl(t2, t0, t2);
> +        tcg_gen_mul_i32(t3, t1, t3);
> +        tcg_gen_mul_i32(t2, t0, t2);
>           break;
>       case MXU_OPTN2_LW: /* XRB.L*XRC.H == lop, XRB.L*XRC.L == rop */
> -        tcg_gen_mul_tl(t3, t0, t3);
> -        tcg_gen_mul_tl(t2, t0, t2);
> +        tcg_gen_mul_i32(t3, t0, t3);
> +        tcg_gen_mul_i32(t2, t0, t2);
>           break;
>       case MXU_OPTN2_HW: /* XRB.H*XRC.H == lop, XRB.H*XRC.L == rop */
> -        tcg_gen_mul_tl(t3, t1, t3);
> -        tcg_gen_mul_tl(t2, t1, t2);
> +        tcg_gen_mul_i32(t3, t1, t3);
> +        tcg_gen_mul_i32(t2, t1, t2);
>           break;
>       case MXU_OPTN2_XW: /* XRB.L*XRC.H == lop, XRB.H*XRC.L == rop */
> -        tcg_gen_mul_tl(t3, t0, t3);
> -        tcg_gen_mul_tl(t2, t1, t2);
> +        tcg_gen_mul_i32(t3, t0, t3);
> +        tcg_gen_mul_i32(t2, t1, t2);
>           break;
>       }
> -    tcg_gen_extract_tl(t2, t2, 0, 16);
> -    tcg_gen_extract_tl(t3, t3, 0, 16);
> +    tcg_gen_extract_i32(t2, t2, 0, 16);
> +    tcg_gen_extract_i32(t3, t3, 0, 16);
>   
>       gen_load_mxu_gpr(t1, XRa);
> -    tcg_gen_extract_tl(t0, t1,  0, 16);
> -    tcg_gen_extract_tl(t1, t1, 16, 16);
> +    tcg_gen_extract_i32(t0, t1,  0, 16);
> +    tcg_gen_extract_i32(t1, t1, 16, 16);
>   
>       switch (aptn2) {
>       case MXU_APTN2_AA:
> -        tcg_gen_add_tl(t3, t1, t3);
> -        tcg_gen_add_tl(t2, t0, t2);
> +        tcg_gen_add_i32(t3, t1, t3);
> +        tcg_gen_add_i32(t2, t0, t2);
>           break;
>       case MXU_APTN2_AS:
> -        tcg_gen_add_tl(t3, t1, t3);
> -        tcg_gen_sub_tl(t2, t0, t2);
> +        tcg_gen_add_i32(t3, t1, t3);
> +        tcg_gen_sub_i32(t2, t0, t2);
>           break;
>       case MXU_APTN2_SA:
> -        tcg_gen_sub_tl(t3, t1, t3);
> -        tcg_gen_add_tl(t2, t0, t2);
> +        tcg_gen_sub_i32(t3, t1, t3);
> +        tcg_gen_add_i32(t2, t0, t2);
>           break;
>       case MXU_APTN2_SS:
> -        tcg_gen_sub_tl(t3, t1, t3);
> -        tcg_gen_sub_tl(t2, t0, t2);
> +        tcg_gen_sub_i32(t3, t1, t3);
> +        tcg_gen_sub_i32(t2, t0, t2);
>           break;
>       }
>   
> -    tcg_gen_andi_tl(t2, t2, 0xffff);
> -    tcg_gen_shli_tl(t3, t3, 16);
> -    tcg_gen_or_tl(mxu_gpr[XRd - 1], t3, t2);
> +    tcg_gen_andi_i32(t2, t2, 0xffff);
> +    tcg_gen_shli_i32(t3, t3, 16);
> +    tcg_gen_or_i32(mxu_gpr[XRd - 1], t3, t2);
>   }
>   
>   /*
> @@ -1319,32 +1319,32 @@ static void gen_mxu_s16mad(DisasContext *ctx)
>   
>       switch (optn2) {
>       case MXU_OPTN2_WW: /* XRB.H*XRC.H */
> -        tcg_gen_sextract_tl(t0, t0, 16, 16);
> -        tcg_gen_sextract_tl(t1, t1, 16, 16);
> +        tcg_gen_sextract_i32(t0, t0, 16, 16);
> +        tcg_gen_sextract_i32(t1, t1, 16, 16);
>           break;
>       case MXU_OPTN2_LW: /* XRB.L*XRC.L */
> -        tcg_gen_sextract_tl(t0, t0,  0, 16);
> -        tcg_gen_sextract_tl(t1, t1,  0, 16);
> +        tcg_gen_sextract_i32(t0, t0,  0, 16);
> +        tcg_gen_sextract_i32(t1, t1,  0, 16);
>           break;
>       case MXU_OPTN2_HW: /* XRB.H*XRC.L */
> -        tcg_gen_sextract_tl(t0, t0, 16, 16);
> -        tcg_gen_sextract_tl(t1, t1,  0, 16);
> +        tcg_gen_sextract_i32(t0, t0, 16, 16);
> +        tcg_gen_sextract_i32(t1, t1,  0, 16);
>           break;
>       case MXU_OPTN2_XW: /* XRB.L*XRC.H */
> -        tcg_gen_sextract_tl(t0, t0,  0, 16);
> -        tcg_gen_sextract_tl(t1, t1, 16, 16);
> +        tcg_gen_sextract_i32(t0, t0,  0, 16);
> +        tcg_gen_sextract_i32(t1, t1, 16, 16);
>           break;
>       }
> -    tcg_gen_mul_tl(t0, t0, t1);
> +    tcg_gen_mul_i32(t0, t0, t1);
>   
>       gen_load_mxu_gpr(t1, XRa);
>   
>       switch (aptn1) {
>       case MXU_APTN1_A:
> -        tcg_gen_add_tl(t1, t1, t0);
> +        tcg_gen_add_i32(t1, t1, t0);
>           break;
>       case MXU_APTN1_S:
> -        tcg_gen_sub_tl(t1, t1, t0);
> +        tcg_gen_sub_i32(t1, t1, t0);
>           break;
>       }
>   
> @@ -1384,53 +1384,53 @@ static void gen_mxu_q8mul_mac(DisasContext *ctx, bool su, bool mac)
>   
>       if (su) {
>           /* Q8MULSU / Q8MACSU */
> -        tcg_gen_sextract_tl(t0, t3,  0, 8);
> -        tcg_gen_sextract_tl(t1, t3,  8, 8);
> -        tcg_gen_sextract_tl(t2, t3, 16, 8);
> -        tcg_gen_sextract_tl(t3, t3, 24, 8);
> +        tcg_gen_sextract_i32(t0, t3,  0, 8);
> +        tcg_gen_sextract_i32(t1, t3,  8, 8);
> +        tcg_gen_sextract_i32(t2, t3, 16, 8);
> +        tcg_gen_sextract_i32(t3, t3, 24, 8);
>       } else {
>           /* Q8MUL / Q8MAC */
> -        tcg_gen_extract_tl(t0, t3,  0, 8);
> -        tcg_gen_extract_tl(t1, t3,  8, 8);
> -        tcg_gen_extract_tl(t2, t3, 16, 8);
> -        tcg_gen_extract_tl(t3, t3, 24, 8);
> +        tcg_gen_extract_i32(t0, t3,  0, 8);
> +        tcg_gen_extract_i32(t1, t3,  8, 8);
> +        tcg_gen_extract_i32(t2, t3, 16, 8);
> +        tcg_gen_extract_i32(t3, t3, 24, 8);
>       }
>   
> -    tcg_gen_extract_tl(t4, t7,  0, 8);
> -    tcg_gen_extract_tl(t5, t7,  8, 8);
> -    tcg_gen_extract_tl(t6, t7, 16, 8);
> -    tcg_gen_extract_tl(t7, t7, 24, 8);
> +    tcg_gen_extract_i32(t4, t7,  0, 8);
> +    tcg_gen_extract_i32(t5, t7,  8, 8);
> +    tcg_gen_extract_i32(t6, t7, 16, 8);
> +    tcg_gen_extract_i32(t7, t7, 24, 8);
>   
> -    tcg_gen_mul_tl(t0, t0, t4);
> -    tcg_gen_mul_tl(t1, t1, t5);
> -    tcg_gen_mul_tl(t2, t2, t6);
> -    tcg_gen_mul_tl(t3, t3, t7);
> +    tcg_gen_mul_i32(t0, t0, t4);
> +    tcg_gen_mul_i32(t1, t1, t5);
> +    tcg_gen_mul_i32(t2, t2, t6);
> +    tcg_gen_mul_i32(t3, t3, t7);
>   
>       if (mac) {
>           gen_load_mxu_gpr(t4, XRd);
>           gen_load_mxu_gpr(t5, XRa);
> -        tcg_gen_extract_tl(t6, t4,  0, 16);
> -        tcg_gen_extract_tl(t7, t4, 16, 16);
> +        tcg_gen_extract_i32(t6, t4,  0, 16);
> +        tcg_gen_extract_i32(t7, t4, 16, 16);
>           if (aptn2 & 1) {
> -            tcg_gen_sub_tl(t0, t6, t0);
> -            tcg_gen_sub_tl(t1, t7, t1);
> +            tcg_gen_sub_i32(t0, t6, t0);
> +            tcg_gen_sub_i32(t1, t7, t1);
>           } else {
> -            tcg_gen_add_tl(t0, t6, t0);
> -            tcg_gen_add_tl(t1, t7, t1);
> +            tcg_gen_add_i32(t0, t6, t0);
> +            tcg_gen_add_i32(t1, t7, t1);
>           }
> -        tcg_gen_extract_tl(t6, t5,  0, 16);
> -        tcg_gen_extract_tl(t7, t5, 16, 16);
> +        tcg_gen_extract_i32(t6, t5,  0, 16);
> +        tcg_gen_extract_i32(t7, t5, 16, 16);
>           if (aptn2 & 2) {
> -            tcg_gen_sub_tl(t2, t6, t2);
> -            tcg_gen_sub_tl(t3, t7, t3);
> +            tcg_gen_sub_i32(t2, t6, t2);
> +            tcg_gen_sub_i32(t3, t7, t3);
>           } else {
> -            tcg_gen_add_tl(t2, t6, t2);
> -            tcg_gen_add_tl(t3, t7, t3);
> +            tcg_gen_add_i32(t2, t6, t2);
> +            tcg_gen_add_i32(t3, t7, t3);
>           }
>       }
>   
> -    tcg_gen_deposit_tl(t0, t0, t1, 16, 16);
> -    tcg_gen_deposit_tl(t1, t2, t3, 16, 16);
> +    tcg_gen_deposit_i32(t0, t0, t1, 16, 16);
> +    tcg_gen_deposit_i32(t1, t2, t3, 16, 16);
>   
>       gen_store_mxu_gpr(t0, XRd);
>       gen_store_mxu_gpr(t1, XRa);
> @@ -1464,45 +1464,45 @@ static void gen_mxu_q8madl(DisasContext *ctx)
>       gen_load_mxu_gpr(t3, XRb);
>       gen_load_mxu_gpr(t7, XRc);
>   
> -    tcg_gen_extract_tl(t0, t3,  0, 8);
> -    tcg_gen_extract_tl(t1, t3,  8, 8);
> -    tcg_gen_extract_tl(t2, t3, 16, 8);
> -    tcg_gen_extract_tl(t3, t3, 24, 8);
> +    tcg_gen_extract_i32(t0, t3,  0, 8);
> +    tcg_gen_extract_i32(t1, t3,  8, 8);
> +    tcg_gen_extract_i32(t2, t3, 16, 8);
> +    tcg_gen_extract_i32(t3, t3, 24, 8);
>   
> -    tcg_gen_extract_tl(t4, t7,  0, 8);
> -    tcg_gen_extract_tl(t5, t7,  8, 8);
> -    tcg_gen_extract_tl(t6, t7, 16, 8);
> -    tcg_gen_extract_tl(t7, t7, 24, 8);
> +    tcg_gen_extract_i32(t4, t7,  0, 8);
> +    tcg_gen_extract_i32(t5, t7,  8, 8);
> +    tcg_gen_extract_i32(t6, t7, 16, 8);
> +    tcg_gen_extract_i32(t7, t7, 24, 8);
>   
> -    tcg_gen_mul_tl(t0, t0, t4);
> -    tcg_gen_mul_tl(t1, t1, t5);
> -    tcg_gen_mul_tl(t2, t2, t6);
> -    tcg_gen_mul_tl(t3, t3, t7);
> +    tcg_gen_mul_i32(t0, t0, t4);
> +    tcg_gen_mul_i32(t1, t1, t5);
> +    tcg_gen_mul_i32(t2, t2, t6);
> +    tcg_gen_mul_i32(t3, t3, t7);
>   
>       gen_load_mxu_gpr(t4, XRa);
> -    tcg_gen_extract_tl(t6, t4, 0, 8);
> -    tcg_gen_extract_tl(t7, t4, 8, 8);
> +    tcg_gen_extract_i32(t6, t4, 0, 8);
> +    tcg_gen_extract_i32(t7, t4, 8, 8);
>       if (aptn2 & 1) {
> -        tcg_gen_sub_tl(t0, t6, t0);
> -        tcg_gen_sub_tl(t1, t7, t1);
> +        tcg_gen_sub_i32(t0, t6, t0);
> +        tcg_gen_sub_i32(t1, t7, t1);
>       } else {
> -        tcg_gen_add_tl(t0, t6, t0);
> -        tcg_gen_add_tl(t1, t7, t1);
> +        tcg_gen_add_i32(t0, t6, t0);
> +        tcg_gen_add_i32(t1, t7, t1);
>       }
> -    tcg_gen_extract_tl(t6, t4, 16, 8);
> -    tcg_gen_extract_tl(t7, t4, 24, 8);
> +    tcg_gen_extract_i32(t6, t4, 16, 8);
> +    tcg_gen_extract_i32(t7, t4, 24, 8);
>       if (aptn2 & 2) {
> -        tcg_gen_sub_tl(t2, t6, t2);
> -        tcg_gen_sub_tl(t3, t7, t3);
> +        tcg_gen_sub_i32(t2, t6, t2);
> +        tcg_gen_sub_i32(t3, t7, t3);
>       } else {
> -        tcg_gen_add_tl(t2, t6, t2);
> -        tcg_gen_add_tl(t3, t7, t3);
> +        tcg_gen_add_i32(t2, t6, t2);
> +        tcg_gen_add_i32(t3, t7, t3);
>       }
>   
> -    tcg_gen_andi_tl(t5, t0, 0xff);
> -    tcg_gen_deposit_tl(t5, t5, t1,  8, 8);
> -    tcg_gen_deposit_tl(t5, t5, t2, 16, 8);
> -    tcg_gen_deposit_tl(t5, t5, t3, 24, 8);
> +    tcg_gen_andi_i32(t5, t0, 0xff);
> +    tcg_gen_deposit_i32(t5, t5, t1,  8, 8);
> +    tcg_gen_deposit_i32(t5, t5, t2, 16, 8);
> +    tcg_gen_deposit_i32(t5, t5, t3, 24, 8);
>   
>       gen_store_mxu_gpr(t5, XRd);
>   }
> @@ -1528,17 +1528,17 @@ static void gen_mxu_s32ldxx(DisasContext *ctx, bool reversed, bool postinc)
>       s12 = sextract32(ctx->opcode, 10, 10);
>       Rb = extract32(ctx->opcode, 21, 5);
>   
> -    gen_load_gpr_tl(t0, Rb);
> -    tcg_gen_movi_tl(t1, s12 * 4);
> -    tcg_gen_add_tl(t0, t0, t1);
> +    gen_load_gpr_i32(t0, Rb);
> +    tcg_gen_movi_i32(t1, s12 * 4);
> +    tcg_gen_add_i32(t0, t0, t1);
>   
> -    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx,
> +    tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx,
>                          MO_SL | mo_endian_rev(ctx, reversed) |
>                           ctx->default_tcg_memop_mask);
>       gen_store_mxu_gpr(t1, XRa);
>   
>       if (postinc) {
> -        gen_store_gpr_tl(t0, Rb);
> +        gen_store_gpr_i32(t0, Rb);
>       }
>   }
>   
> @@ -1563,17 +1563,17 @@ static void gen_mxu_s32stxx(DisasContext *ctx, bool reversed, bool postinc)
>       s12 = sextract32(ctx->opcode, 10, 10);
>       Rb = extract32(ctx->opcode, 21, 5);
>   
> -    gen_load_gpr_tl(t0, Rb);
> -    tcg_gen_movi_tl(t1, s12 * 4);
> -    tcg_gen_add_tl(t0, t0, t1);
> +    gen_load_gpr_i32(t0, Rb);
> +    tcg_gen_movi_i32(t1, s12 * 4);
> +    tcg_gen_add_i32(t0, t0, t1);
>   
>       gen_load_mxu_gpr(t1, XRa);
> -    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
> +    tcg_gen_qemu_st_i32(t1, t0, ctx->mem_idx,
>                          MO_SL | mo_endian_rev(ctx, reversed) |
>                           ctx->default_tcg_memop_mask);
>   
>       if (postinc) {
> -        gen_store_gpr_tl(t0, Rb);
> +        gen_store_gpr_i32(t0, Rb);
>       }
>   }
>   
> @@ -1599,18 +1599,18 @@ static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
>       Rc = extract32(ctx->opcode, 16, 5);
>       Rb = extract32(ctx->opcode, 21, 5);
>   
> -    gen_load_gpr_tl(t0, Rb);
> -    gen_load_gpr_tl(t1, Rc);
> -    tcg_gen_shli_tl(t1, t1, strd2);
> -    tcg_gen_add_tl(t0, t0, t1);
> +    gen_load_gpr_i32(t0, Rb);
> +    gen_load_gpr_i32(t1, Rc);
> +    tcg_gen_shli_i32(t1, t1, strd2);
> +    tcg_gen_add_i32(t0, t0, t1);
>   
> -    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx,
> +    tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx,
>                          MO_SL | mo_endian_rev(ctx, reversed) |
>                           ctx->default_tcg_memop_mask);
>       gen_store_mxu_gpr(t1, XRa);
>   
>       if (postinc) {
> -        gen_store_gpr_tl(t0, Rb);
> +        gen_store_gpr_i32(t0, Rb);
>       }
>   }
>   
> @@ -1637,13 +1637,13 @@ static void gen_mxu_lxx(DisasContext *ctx, uint32_t strd2, MemOp mop)
>       Rc = extract32(ctx->opcode, 16, 5);
>       Rb = extract32(ctx->opcode, 21, 5);
>   
> -    gen_load_gpr_tl(t0, Rb);
> -    gen_load_gpr_tl(t1, Rc);
> -    tcg_gen_shli_tl(t1, t1, strd2);
> -    tcg_gen_add_tl(t0, t0, t1);
> +    gen_load_gpr_i32(t0, Rb);
> +    gen_load_gpr_i32(t1, Rc);
> +    tcg_gen_shli_i32(t1, t1, strd2);
> +    tcg_gen_add_i32(t0, t0, t1);
>   
> -    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mop | ctx->default_tcg_memop_mask);
> -    gen_store_gpr_tl(t1, Ra);
> +    tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, mop | ctx->default_tcg_memop_mask);
> +    gen_store_gpr_i32(t1, Ra);
>   }
>   
>   /*
> @@ -1668,18 +1668,18 @@ static void gen_mxu_s32stxvx(DisasContext *ctx, bool reversed,
>       Rc = extract32(ctx->opcode, 16, 5);
>       Rb = extract32(ctx->opcode, 21, 5);
>   
> -    gen_load_gpr_tl(t0, Rb);
> -    gen_load_gpr_tl(t1, Rc);
> -    tcg_gen_shli_tl(t1, t1, strd2);
> -    tcg_gen_add_tl(t0, t0, t1);
> +    gen_load_gpr_i32(t0, Rb);
> +    gen_load_gpr_i32(t1, Rc);
> +    tcg_gen_shli_i32(t1, t1, strd2);
> +    tcg_gen_add_i32(t0, t0, t1);
>   
>       gen_load_mxu_gpr(t1, XRa);
> -    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
> +    tcg_gen_qemu_st_i32(t1, t0, ctx->mem_idx,
>                          MO_SL | mo_endian_rev(ctx, reversed) |
>                           ctx->default_tcg_memop_mask);
>   
>       if (postinc) {
> -        gen_store_gpr_tl(t0, Rb);
> +        gen_store_gpr_i32(t0, Rb);
>       }
>   }
>   
> @@ -1867,15 +1867,15 @@ static void gen_mxu_d32sxx(DisasContext *ctx, bool right, bool arithmetic)
>   
>       if (right) {
>           if (arithmetic) {
> -            tcg_gen_sari_tl(t0, t0, sft4);
> -            tcg_gen_sari_tl(t1, t1, sft4);
> +            tcg_gen_sari_i32(t0, t0, sft4);
> +            tcg_gen_sari_i32(t1, t1, sft4);
>           } else {
> -            tcg_gen_shri_tl(t0, t0, sft4);
> -            tcg_gen_shri_tl(t1, t1, sft4);
> +            tcg_gen_shri_i32(t0, t0, sft4);
> +            tcg_gen_shri_i32(t1, t1, sft4);
>           }
>       } else {
> -        tcg_gen_shli_tl(t0, t0, sft4);
> -        tcg_gen_shli_tl(t1, t1, sft4);
> +        tcg_gen_shli_i32(t0, t0, sft4);
> +        tcg_gen_shli_i32(t1, t1, sft4);
>       }
>       gen_store_mxu_gpr(t0, XRa);
>       gen_store_mxu_gpr(t1, XRd);
> @@ -1906,20 +1906,20 @@ static void gen_mxu_d32sxxv(DisasContext *ctx, bool right, bool arithmetic)
>   
>       gen_load_mxu_gpr(t0, XRa);
>       gen_load_mxu_gpr(t1, XRd);
> -    gen_load_gpr_tl(t2, rs);
> -    tcg_gen_andi_tl(t2, t2, 0x0f);
> +    gen_load_gpr_i32(t2, rs);
> +    tcg_gen_andi_i32(t2, t2, 0x0f);
>   
>       if (right) {
>           if (arithmetic) {
> -            tcg_gen_sar_tl(t0, t0, t2);
> -            tcg_gen_sar_tl(t1, t1, t2);
> +            tcg_gen_sar_i32(t0, t0, t2);
> +            tcg_gen_sar_i32(t1, t1, t2);
>           } else {
> -            tcg_gen_shr_tl(t0, t0, t2);
> -            tcg_gen_shr_tl(t1, t1, t2);
> +            tcg_gen_shr_i32(t0, t0, t2);
> +            tcg_gen_shr_i32(t1, t1, t2);
>           }
>       } else {
> -        tcg_gen_shl_tl(t0, t0, t2);
> -        tcg_gen_shl_tl(t1, t1, t2);
> +        tcg_gen_shl_i32(t0, t0, t2);
> +        tcg_gen_shl_i32(t1, t1, t2);
>       }
>       gen_store_mxu_gpr(t0, XRa);
>       gen_store_mxu_gpr(t1, XRd);
> @@ -1952,17 +1952,17 @@ static void gen_mxu_d32sarl(DisasContext *ctx, bool sarw)
>   
>           if (!sarw) {
>               /* Make SFT4 from rb field */
> -            tcg_gen_movi_tl(t2, rb >> 1);
> +            tcg_gen_movi_i32(t2, rb >> 1);
>           } else {
> -            gen_load_gpr_tl(t2, rb);
> -            tcg_gen_andi_tl(t2, t2, 0x0f);
> +            gen_load_gpr_i32(t2, rb);
> +            tcg_gen_andi_i32(t2, t2, 0x0f);
>           }
>           gen_load_mxu_gpr(t0, XRb);
>           gen_load_mxu_gpr(t1, XRc);
> -        tcg_gen_sar_tl(t0, t0, t2);
> -        tcg_gen_sar_tl(t1, t1, t2);
> -        tcg_gen_extract_tl(t2, t1, 0, 16);
> -        tcg_gen_deposit_tl(t2, t2, t0, 16, 16);
> +        tcg_gen_sar_i32(t0, t0, t2);
> +        tcg_gen_sar_i32(t1, t1, t2);
> +        tcg_gen_extract_i32(t2, t1, 0, 16);
> +        tcg_gen_deposit_i32(t2, t2, t0, 16, 16);
>           gen_store_mxu_gpr(t2, XRa);
>       }
>   }
> @@ -1997,37 +1997,37 @@ static void gen_mxu_q16sxx(DisasContext *ctx, bool right, bool arithmetic)
>       gen_load_mxu_gpr(t2, XRc);
>   
>       if (arithmetic) {
> -        tcg_gen_sextract_tl(t1, t0, 16, 16);
> -        tcg_gen_sextract_tl(t0, t0,  0, 16);
> -        tcg_gen_sextract_tl(t3, t2, 16, 16);
> -        tcg_gen_sextract_tl(t2, t2,  0, 16);
> +        tcg_gen_sextract_i32(t1, t0, 16, 16);
> +        tcg_gen_sextract_i32(t0, t0,  0, 16);
> +        tcg_gen_sextract_i32(t3, t2, 16, 16);
> +        tcg_gen_sextract_i32(t2, t2,  0, 16);
>       } else {
> -        tcg_gen_extract_tl(t1, t0, 16, 16);
> -        tcg_gen_extract_tl(t0, t0,  0, 16);
> -        tcg_gen_extract_tl(t3, t2, 16, 16);
> -        tcg_gen_extract_tl(t2, t2,  0, 16);
> +        tcg_gen_extract_i32(t1, t0, 16, 16);
> +        tcg_gen_extract_i32(t0, t0,  0, 16);
> +        tcg_gen_extract_i32(t3, t2, 16, 16);
> +        tcg_gen_extract_i32(t2, t2,  0, 16);
>       }
>   
>       if (right) {
>           if (arithmetic) {
> -            tcg_gen_sari_tl(t0, t0, sft4);
> -            tcg_gen_sari_tl(t1, t1, sft4);
> -            tcg_gen_sari_tl(t2, t2, sft4);
> -            tcg_gen_sari_tl(t3, t3, sft4);
> +            tcg_gen_sari_i32(t0, t0, sft4);
> +            tcg_gen_sari_i32(t1, t1, sft4);
> +            tcg_gen_sari_i32(t2, t2, sft4);
> +            tcg_gen_sari_i32(t3, t3, sft4);
>           } else {
> -            tcg_gen_shri_tl(t0, t0, sft4);
> -            tcg_gen_shri_tl(t1, t1, sft4);
> -            tcg_gen_shri_tl(t2, t2, sft4);
> -            tcg_gen_shri_tl(t3, t3, sft4);
> +            tcg_gen_shri_i32(t0, t0, sft4);
> +            tcg_gen_shri_i32(t1, t1, sft4);
> +            tcg_gen_shri_i32(t2, t2, sft4);
> +            tcg_gen_shri_i32(t3, t3, sft4);
>           }
>       } else {
> -        tcg_gen_shli_tl(t0, t0, sft4);
> -        tcg_gen_shli_tl(t1, t1, sft4);
> -        tcg_gen_shli_tl(t2, t2, sft4);
> -        tcg_gen_shli_tl(t3, t3, sft4);
> +        tcg_gen_shli_i32(t0, t0, sft4);
> +        tcg_gen_shli_i32(t1, t1, sft4);
> +        tcg_gen_shli_i32(t2, t2, sft4);
> +        tcg_gen_shli_i32(t3, t3, sft4);
>       }
> -    tcg_gen_deposit_tl(t0, t0, t1, 16, 16);
> -    tcg_gen_deposit_tl(t2, t2, t3, 16, 16);
> +    tcg_gen_deposit_i32(t0, t0, t1, 16, 16);
> +    tcg_gen_deposit_i32(t2, t2, t3, 16, 16);
>   
>       gen_store_mxu_gpr(t0, XRa);
>       gen_store_mxu_gpr(t2, XRd);
> @@ -2060,42 +2060,42 @@ static void gen_mxu_q16sxxv(DisasContext *ctx, bool right, bool arithmetic)
>   
>       gen_load_mxu_gpr(t0, XRa);
>       gen_load_mxu_gpr(t2, XRd);
> -    gen_load_gpr_tl(t5, rs);
> -    tcg_gen_andi_tl(t5, t5, 0x0f);
> +    gen_load_gpr_i32(t5, rs);
> +    tcg_gen_andi_i32(t5, t5, 0x0f);
>   
>   
>       if (arithmetic) {
> -        tcg_gen_sextract_tl(t1, t0, 16, 16);
> -        tcg_gen_sextract_tl(t0, t0,  0, 16);
> -        tcg_gen_sextract_tl(t3, t2, 16, 16);
> -        tcg_gen_sextract_tl(t2, t2,  0, 16);
> +        tcg_gen_sextract_i32(t1, t0, 16, 16);
> +        tcg_gen_sextract_i32(t0, t0,  0, 16);
> +        tcg_gen_sextract_i32(t3, t2, 16, 16);
> +        tcg_gen_sextract_i32(t2, t2,  0, 16);
>       } else {
> -        tcg_gen_extract_tl(t1, t0, 16, 16);
> -        tcg_gen_extract_tl(t0, t0,  0, 16);
> -        tcg_gen_extract_tl(t3, t2, 16, 16);
> -        tcg_gen_extract_tl(t2, t2,  0, 16);
> +        tcg_gen_extract_i32(t1, t0, 16, 16);
> +        tcg_gen_extract_i32(t0, t0,  0, 16);
> +        tcg_gen_extract_i32(t3, t2, 16, 16);
> +        tcg_gen_extract_i32(t2, t2,  0, 16);
>       }
>   
>       if (right) {
>           if (arithmetic) {
> -            tcg_gen_sar_tl(t0, t0, t5);
> -            tcg_gen_sar_tl(t1, t1, t5);
> -            tcg_gen_sar_tl(t2, t2, t5);
> -            tcg_gen_sar_tl(t3, t3, t5);
> +            tcg_gen_sar_i32(t0, t0, t5);
> +            tcg_gen_sar_i32(t1, t1, t5);
> +            tcg_gen_sar_i32(t2, t2, t5);
> +            tcg_gen_sar_i32(t3, t3, t5);
>           } else {
> -            tcg_gen_shr_tl(t0, t0, t5);
> -            tcg_gen_shr_tl(t1, t1, t5);
> -            tcg_gen_shr_tl(t2, t2, t5);
> -            tcg_gen_shr_tl(t3, t3, t5);
> +            tcg_gen_shr_i32(t0, t0, t5);
> +            tcg_gen_shr_i32(t1, t1, t5);
> +            tcg_gen_shr_i32(t2, t2, t5);
> +            tcg_gen_shr_i32(t3, t3, t5);
>           }
>       } else {
> -        tcg_gen_shl_tl(t0, t0, t5);
> -        tcg_gen_shl_tl(t1, t1, t5);
> -        tcg_gen_shl_tl(t2, t2, t5);
> -        tcg_gen_shl_tl(t3, t3, t5);
> +        tcg_gen_shl_i32(t0, t0, t5);
> +        tcg_gen_shl_i32(t1, t1, t5);
> +        tcg_gen_shl_i32(t2, t2, t5);
> +        tcg_gen_shl_i32(t3, t3, t5);
>       }
> -    tcg_gen_deposit_tl(t0, t0, t1, 16, 16);
> -    tcg_gen_deposit_tl(t2, t2, t3, 16, 16);
> +    tcg_gen_deposit_i32(t0, t0, t1, 16, 16);
> +    tcg_gen_deposit_i32(t2, t2, t3, 16, 16);
>   
>       gen_store_mxu_gpr(t0, XRa);
>       gen_store_mxu_gpr(t2, XRd);
> @@ -2142,7 +2142,7 @@ static void gen_mxu_S32MAX_S32MIN(DisasContext *ctx)
>           /* both operands zero registers -> just set destination to zero */
>           tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else if (unlikely((XRb == 0) || (XRc == 0))) {
> -        /* exactly one operand is zero register - find which one is not...*/
> +        /* exaci32y one operand is zero register - find which one is not...*/
>           uint32_t XRx = XRb ? XRb : XRc;
>           /* ...and do max/min operation with one operand 0 */
>           if (opc == OPC_MXU_S32MAX) {
> @@ -2192,7 +2192,7 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
>           /* both operands zero registers -> just set destination to zero */
>           tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else if (unlikely((XRb == 0) || (XRc == 0))) {
> -        /* exactly one operand is zero register - find which one is not...*/
> +        /* exaci32y one operand is zero register - find which one is not...*/
>           uint32_t XRx = XRb ? XRb : XRc;
>           /* ...and do half-word-wise max/min with one operand 0 */
>           TCGv_i32 t0 = tcg_temp_new();
> @@ -2285,7 +2285,7 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
>           /* both operands zero registers -> just set destination to zero */
>           tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else if (unlikely((XRb == 0) || (XRc == 0))) {
> -        /* exactly one operand is zero register - make it be the first...*/
> +        /* exaci32y one operand is zero register - make it be the first...*/
>           uint32_t XRx = XRb ? XRb : XRc;
>           /* ...and do byte-wise max/min with one operand 0 */
>           TCGv_i32 t0 = tcg_temp_new();
> @@ -2387,10 +2387,10 @@ static void gen_mxu_q8slt(DisasContext *ctx, bool sltu)
>           /* destination is zero register -> do nothing */
>       } else if (unlikely((XRb == 0) && (XRc == 0))) {
>           /* both operands zero registers -> just set destination to zero */
> -        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else if (unlikely(XRb == XRc)) {
>           /* both operands same registers -> just set destination to zero */
> -        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else {
>           /* the most general case */
>           TCGv t0 = tcg_temp_new();
> @@ -2401,18 +2401,18 @@ static void gen_mxu_q8slt(DisasContext *ctx, bool sltu)
>   
>           gen_load_mxu_gpr(t3, XRb);
>           gen_load_mxu_gpr(t4, XRc);
> -        tcg_gen_movi_tl(t2, 0);
> +        tcg_gen_movi_i32(t2, 0);
>   
>           for (int i = 0; i < 4; i++) {
>               if (sltu) {
> -                tcg_gen_extract_tl(t0, t3, 8 * i, 8);
> -                tcg_gen_extract_tl(t1, t4, 8 * i, 8);
> +                tcg_gen_extract_i32(t0, t3, 8 * i, 8);
> +                tcg_gen_extract_i32(t1, t4, 8 * i, 8);
>               } else {
> -                tcg_gen_sextract_tl(t0, t3, 8 * i, 8);
> -                tcg_gen_sextract_tl(t1, t4, 8 * i, 8);
> +                tcg_gen_sextract_i32(t0, t3, 8 * i, 8);
> +                tcg_gen_sextract_i32(t1, t4, 8 * i, 8);
>               }
> -            tcg_gen_setcond_tl(TCG_COND_LT, t0, t0, t1);
> -            tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
> +            tcg_gen_setcond_i32(TCG_COND_LT, t0, t0, t1);
> +            tcg_gen_deposit_i32(t2, t2, t0, 8 * i, 8);
>           }
>           gen_store_mxu_gpr(t2, XRa);
>       }
> @@ -2438,10 +2438,10 @@ static void gen_mxu_S32SLT(DisasContext *ctx)
>           /* destination is zero register -> do nothing */
>       } else if (unlikely((XRb == 0) && (XRc == 0))) {
>           /* both operands zero registers -> just set destination to zero */
> -        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else if (unlikely(XRb == XRc)) {
>           /* both operands same registers -> just set destination to zero */
> -        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else {
>           /* the most general case */
>           TCGv t0 = tcg_temp_new();
> @@ -2449,7 +2449,7 @@ static void gen_mxu_S32SLT(DisasContext *ctx)
>   
>           gen_load_mxu_gpr(t0, XRb);
>           gen_load_mxu_gpr(t1, XRc);
> -        tcg_gen_setcond_tl(TCG_COND_LT, mxu_gpr[XRa - 1], t0, t1);
> +        tcg_gen_setcond_i32(TCG_COND_LT, mxu_gpr[XRa - 1], t0, t1);
>       }
>   }
>   
> @@ -2474,10 +2474,10 @@ static void gen_mxu_D16SLT(DisasContext *ctx)
>           /* destination is zero register -> do nothing */
>       } else if (unlikely((XRb == 0) && (XRc == 0))) {
>           /* both operands zero registers -> just set destination to zero */
> -        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else if (unlikely(XRb == XRc)) {
>           /* both operands same registers -> just set destination to zero */
> -        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else {
>           /* the most general case */
>           TCGv t0 = tcg_temp_new();
> @@ -2488,14 +2488,14 @@ static void gen_mxu_D16SLT(DisasContext *ctx)
>   
>           gen_load_mxu_gpr(t3, XRb);
>           gen_load_mxu_gpr(t4, XRc);
> -        tcg_gen_sextract_tl(t0, t3, 16, 16);
> -        tcg_gen_sextract_tl(t1, t4, 16, 16);
> -        tcg_gen_setcond_tl(TCG_COND_LT, t0, t0, t1);
> -        tcg_gen_shli_tl(t2, t0, 16);
> -        tcg_gen_sextract_tl(t0, t3,  0, 16);
> -        tcg_gen_sextract_tl(t1, t4,  0, 16);
> -        tcg_gen_setcond_tl(TCG_COND_LT, t0, t0, t1);
> -        tcg_gen_or_tl(mxu_gpr[XRa - 1], t2, t0);
> +        tcg_gen_sextract_i32(t0, t3, 16, 16);
> +        tcg_gen_sextract_i32(t1, t4, 16, 16);
> +        tcg_gen_setcond_i32(TCG_COND_LT, t0, t0, t1);
> +        tcg_gen_shli_i32(t2, t0, 16);
> +        tcg_gen_sextract_i32(t0, t3,  0, 16);
> +        tcg_gen_sextract_i32(t1, t4,  0, 16);
> +        tcg_gen_setcond_i32(TCG_COND_LT, t0, t0, t1);
> +        tcg_gen_or_i32(mxu_gpr[XRa - 1], t2, t0);
>       }
>   }
>   
> @@ -2525,10 +2525,10 @@ static void gen_mxu_d16avg(DisasContext *ctx, bool round45)
>           /* destination is zero register -> do nothing */
>       } else if (unlikely((XRb == 0) && (XRc == 0))) {
>           /* both operands zero registers -> just set destination to zero */
> -        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else if (unlikely(XRb == XRc)) {
>           /* both operands same registers -> just set destination to same */
> -        tcg_gen_mov_tl(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
> +        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
>       } else {
>           /* the most general case */
>           TCGv t0 = tcg_temp_new();
> @@ -2539,22 +2539,22 @@ static void gen_mxu_d16avg(DisasContext *ctx, bool round45)
>   
>           gen_load_mxu_gpr(t3, XRb);
>           gen_load_mxu_gpr(t4, XRc);
> -        tcg_gen_sextract_tl(t0, t3, 16, 16);
> -        tcg_gen_sextract_tl(t1, t4, 16, 16);
> -        tcg_gen_add_tl(t0, t0, t1);
> +        tcg_gen_sextract_i32(t0, t3, 16, 16);
> +        tcg_gen_sextract_i32(t1, t4, 16, 16);
> +        tcg_gen_add_i32(t0, t0, t1);
>           if (round45) {
> -            tcg_gen_addi_tl(t0, t0, 1);
> +            tcg_gen_addi_i32(t0, t0, 1);
>           }
> -        tcg_gen_shli_tl(t2, t0, 15);
> -        tcg_gen_andi_tl(t2, t2, 0xffff0000);
> -        tcg_gen_sextract_tl(t0, t3,  0, 16);
> -        tcg_gen_sextract_tl(t1, t4,  0, 16);
> -        tcg_gen_add_tl(t0, t0, t1);
> +        tcg_gen_shli_i32(t2, t0, 15);
> +        tcg_gen_andi_i32(t2, t2, 0xffff0000);
> +        tcg_gen_sextract_i32(t0, t3,  0, 16);
> +        tcg_gen_sextract_i32(t1, t4,  0, 16);
> +        tcg_gen_add_i32(t0, t0, t1);
>           if (round45) {
> -            tcg_gen_addi_tl(t0, t0, 1);
> +            tcg_gen_addi_i32(t0, t0, 1);
>           }
> -        tcg_gen_shri_tl(t0, t0, 1);
> -        tcg_gen_deposit_tl(t2, t2, t0, 0, 16);
> +        tcg_gen_shri_i32(t0, t0, 1);
> +        tcg_gen_deposit_i32(t2, t2, t0, 0, 16);
>           gen_store_mxu_gpr(t2, XRa);
>       }
>   }
> @@ -2585,10 +2585,10 @@ static void gen_mxu_q8avg(DisasContext *ctx, bool round45)
>           /* destination is zero register -> do nothing */
>       } else if (unlikely((XRb == 0) && (XRc == 0))) {
>           /* both operands zero registers -> just set destination to zero */
> -        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else if (unlikely(XRb == XRc)) {
>           /* both operands same registers -> just set destination to same */
> -        tcg_gen_mov_tl(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
> +        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
>       } else {
>           /* the most general case */
>           TCGv t0 = tcg_temp_new();
> @@ -2599,17 +2599,17 @@ static void gen_mxu_q8avg(DisasContext *ctx, bool round45)
>   
>           gen_load_mxu_gpr(t3, XRb);
>           gen_load_mxu_gpr(t4, XRc);
> -        tcg_gen_movi_tl(t2, 0);
> +        tcg_gen_movi_i32(t2, 0);
>   
>           for (int i = 0; i < 4; i++) {
> -            tcg_gen_extract_tl(t0, t3, 8 * i, 8);
> -            tcg_gen_extract_tl(t1, t4, 8 * i, 8);
> -            tcg_gen_add_tl(t0, t0, t1);
> +            tcg_gen_extract_i32(t0, t3, 8 * i, 8);
> +            tcg_gen_extract_i32(t1, t4, 8 * i, 8);
> +            tcg_gen_add_i32(t0, t0, t1);
>               if (round45) {
> -                tcg_gen_addi_tl(t0, t0, 1);
> +                tcg_gen_addi_i32(t0, t0, 1);
>               }
> -            tcg_gen_shri_tl(t0, t0, 1);
> -            tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
> +            tcg_gen_shri_i32(t0, t0, 1);
> +            tcg_gen_deposit_i32(t2, t2, t0, 8 * i, 8);
>           }
>           gen_store_mxu_gpr(t2, XRa);
>       }
> @@ -2649,28 +2649,28 @@ static void gen_mxu_q8movzn(DisasContext *ctx, TCGCond cond)
>       gen_load_mxu_gpr(t1, XRb);
>       gen_load_mxu_gpr(t2, XRa);
>   
> -    tcg_gen_extract_tl(t3, t1, 24, 8);
> -    tcg_gen_brcondi_tl(cond, t3, 0, l_quarterdone);
> -    tcg_gen_extract_tl(t3, t0, 24, 8);
> -    tcg_gen_deposit_tl(t2, t2, t3, 24, 8);
> +    tcg_gen_extract_i32(t3, t1, 24, 8);
> +    tcg_gen_brcondi_i32(cond, t3, 0, l_quarterdone);
> +    tcg_gen_extract_i32(t3, t0, 24, 8);
> +    tcg_gen_deposit_i32(t2, t2, t3, 24, 8);
>   
>       gen_set_label(l_quarterdone);
> -    tcg_gen_extract_tl(t3, t1, 16, 8);
> -    tcg_gen_brcondi_tl(cond, t3, 0, l_halfdone);
> -    tcg_gen_extract_tl(t3, t0, 16, 8);
> -    tcg_gen_deposit_tl(t2, t2, t3, 16, 8);
> +    tcg_gen_extract_i32(t3, t1, 16, 8);
> +    tcg_gen_brcondi_i32(cond, t3, 0, l_halfdone);
> +    tcg_gen_extract_i32(t3, t0, 16, 8);
> +    tcg_gen_deposit_i32(t2, t2, t3, 16, 8);
>   
>       gen_set_label(l_halfdone);
> -    tcg_gen_extract_tl(t3, t1, 8, 8);
> -    tcg_gen_brcondi_tl(cond, t3, 0, l_quarterrest);
> -    tcg_gen_extract_tl(t3, t0, 8, 8);
> -    tcg_gen_deposit_tl(t2, t2, t3, 8, 8);
> +    tcg_gen_extract_i32(t3, t1, 8, 8);
> +    tcg_gen_brcondi_i32(cond, t3, 0, l_quarterrest);
> +    tcg_gen_extract_i32(t3, t0, 8, 8);
> +    tcg_gen_deposit_i32(t2, t2, t3, 8, 8);
>   
>       gen_set_label(l_quarterrest);
> -    tcg_gen_extract_tl(t3, t1, 0, 8);
> -    tcg_gen_brcondi_tl(cond, t3, 0, l_done);
> -    tcg_gen_extract_tl(t3, t0, 0, 8);
> -    tcg_gen_deposit_tl(t2, t2, t3, 0, 8);
> +    tcg_gen_extract_i32(t3, t1, 0, 8);
> +    tcg_gen_brcondi_i32(cond, t3, 0, l_done);
> +    tcg_gen_extract_i32(t3, t0, 0, 8);
> +    tcg_gen_deposit_i32(t2, t2, t3, 0, 8);
>   
>       gen_set_label(l_done);
>       gen_store_mxu_gpr(t2, XRa);
> @@ -2708,16 +2708,16 @@ static void gen_mxu_d16movzn(DisasContext *ctx, TCGCond cond)
>       gen_load_mxu_gpr(t1, XRb);
>       gen_load_mxu_gpr(t2, XRa);
>   
> -    tcg_gen_extract_tl(t3, t1, 16, 16);
> -    tcg_gen_brcondi_tl(cond, t3, 0, l_halfdone);
> -    tcg_gen_extract_tl(t3, t0, 16, 16);
> -    tcg_gen_deposit_tl(t2, t2, t3, 16, 16);
> +    tcg_gen_extract_i32(t3, t1, 16, 16);
> +    tcg_gen_brcondi_i32(cond, t3, 0, l_halfdone);
> +    tcg_gen_extract_i32(t3, t0, 16, 16);
> +    tcg_gen_deposit_i32(t2, t2, t3, 16, 16);
>   
>       gen_set_label(l_halfdone);
> -    tcg_gen_extract_tl(t3, t1, 0, 16);
> -    tcg_gen_brcondi_tl(cond, t3, 0, l_done);
> -    tcg_gen_extract_tl(t3, t0, 0, 16);
> -    tcg_gen_deposit_tl(t2, t2, t3, 0, 16);
> +    tcg_gen_extract_i32(t3, t1, 0, 16);
> +    tcg_gen_brcondi_i32(cond, t3, 0, l_done);
> +    tcg_gen_extract_i32(t3, t0, 0, 16);
> +    tcg_gen_deposit_i32(t2, t2, t3, 0, 16);
>   
>       gen_set_label(l_done);
>       gen_store_mxu_gpr(t2, XRa);
> @@ -2751,7 +2751,7 @@ static void gen_mxu_s32movzn(DisasContext *ctx, TCGCond cond)
>       gen_load_mxu_gpr(t0, XRc);
>       gen_load_mxu_gpr(t1, XRb);
>   
> -    tcg_gen_brcondi_tl(cond, t1, 0, l_done);
> +    tcg_gen_brcondi_i32(cond, t1, 0, l_done);
>       gen_store_mxu_gpr(t0, XRa);
>       gen_set_label(l_done);
>   }
> @@ -2784,18 +2784,18 @@ static void gen_mxu_S32CPS(DisasContext *ctx)
>           /* destination is zero register -> do nothing */
>       } else if (unlikely(XRb == 0)) {
>           /* XRc make no sense 0 - 0 = 0 -> just set destination to zero */
> -        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else if (unlikely(XRc == 0)) {
>           /* condition always false -> just move XRb to XRa */
> -        tcg_gen_mov_tl(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
> +        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
>       } else {
>           /* the most general case */
>           TCGv t0 = tcg_temp_new();
>           TCGLabel *l_not_less = gen_new_label();
>           TCGLabel *l_done = gen_new_label();
>   
> -        tcg_gen_brcondi_tl(TCG_COND_GE, mxu_gpr[XRc - 1], 0, l_not_less);
> -        tcg_gen_neg_tl(t0, mxu_gpr[XRb - 1]);
> +        tcg_gen_brcondi_i32(TCG_COND_GE, mxu_gpr[XRc - 1], 0, l_not_less);
> +        tcg_gen_neg_i32(t0, mxu_gpr[XRb - 1]);
>           tcg_gen_br(l_done);
>           gen_set_label(l_not_less);
>           gen_load_mxu_gpr(t0, XRb);
> @@ -2824,10 +2824,10 @@ static void gen_mxu_D16CPS(DisasContext *ctx)
>           /* destination is zero register -> do nothing */
>       } else if (unlikely(XRb == 0)) {
>           /* XRc make no sense 0 - 0 = 0 -> just set destination to zero */
> -        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else if (unlikely(XRc == 0)) {
>           /* condition always false -> just move XRb to XRa */
> -        tcg_gen_mov_tl(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
> +        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
>       } else {
>           /* the most general case */
>           TCGv t0 = tcg_temp_new();
> @@ -2836,25 +2836,25 @@ static void gen_mxu_D16CPS(DisasContext *ctx)
>           TCGLabel *l_not_less_lo = gen_new_label();
>           TCGLabel *l_done_lo = gen_new_label();
>   
> -        tcg_gen_sextract_tl(t0, mxu_gpr[XRc - 1], 16, 16);
> -        tcg_gen_sextract_tl(t1, mxu_gpr[XRb - 1], 16, 16);
> -        tcg_gen_brcondi_tl(TCG_COND_GE, t0, 0, l_done_hi);
> -        tcg_gen_subfi_tl(t1, 0, t1);
> +        tcg_gen_sextract_i32(t0, mxu_gpr[XRc - 1], 16, 16);
> +        tcg_gen_sextract_i32(t1, mxu_gpr[XRb - 1], 16, 16);
> +        tcg_gen_brcondi_i32(TCG_COND_GE, t0, 0, l_done_hi);
> +        tcg_gen_subfi_i32(t1, 0, t1);
>   
>           gen_set_label(l_done_hi);
>           tcg_gen_shli_i32(t1, t1, 16);
>   
> -        tcg_gen_sextract_tl(t0, mxu_gpr[XRc - 1],  0, 16);
> -        tcg_gen_brcondi_tl(TCG_COND_GE, t0, 0, l_not_less_lo);
> -        tcg_gen_sextract_tl(t0, mxu_gpr[XRb - 1],  0, 16);
> -        tcg_gen_subfi_tl(t0, 0, t0);
> +        tcg_gen_sextract_i32(t0, mxu_gpr[XRc - 1],  0, 16);
> +        tcg_gen_brcondi_i32(TCG_COND_GE, t0, 0, l_not_less_lo);
> +        tcg_gen_sextract_i32(t0, mxu_gpr[XRb - 1],  0, 16);
> +        tcg_gen_subfi_i32(t0, 0, t0);
>           tcg_gen_br(l_done_lo);
>   
>           gen_set_label(l_not_less_lo);
> -        tcg_gen_extract_tl(t0, mxu_gpr[XRb - 1],  0, 16);
> +        tcg_gen_extract_i32(t0, mxu_gpr[XRb - 1],  0, 16);
>   
>           gen_set_label(l_done_lo);
> -        tcg_gen_deposit_tl(mxu_gpr[XRa - 1], t1, t0, 0, 16);
> +        tcg_gen_deposit_i32(mxu_gpr[XRa - 1], t1, t0, 0, 16);
>       }
>   }
>   
> @@ -2880,7 +2880,7 @@ static void gen_mxu_Q8ABD(DisasContext *ctx)
>           /* destination is zero register -> do nothing */
>       } else if (unlikely((XRb == 0) && (XRc == 0))) {
>           /* both operands zero registers -> just set destination to zero */
> -        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else {
>           /* the most general case */
>           TCGv t0 = tcg_temp_new();
> @@ -2891,16 +2891,16 @@ static void gen_mxu_Q8ABD(DisasContext *ctx)
>   
>           gen_load_mxu_gpr(t3, XRb);
>           gen_load_mxu_gpr(t4, XRc);
> -        tcg_gen_movi_tl(t2, 0);
> +        tcg_gen_movi_i32(t2, 0);
>   
>           for (int i = 0; i < 4; i++) {
> -            tcg_gen_extract_tl(t0, t3, 8 * i, 8);
> -            tcg_gen_extract_tl(t1, t4, 8 * i, 8);
> +            tcg_gen_extract_i32(t0, t3, 8 * i, 8);
> +            tcg_gen_extract_i32(t1, t4, 8 * i, 8);
>   
> -            tcg_gen_sub_tl(t0, t0, t1);
> -            tcg_gen_abs_tl(t0, t0);
> +            tcg_gen_sub_i32(t0, t0, t1);
> +            tcg_gen_abs_i32(t0, t0);
>   
> -            tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
> +            tcg_gen_deposit_i32(t2, t2, t0, 8 * i, 8);
>           }
>           gen_store_mxu_gpr(t2, XRa);
>       }
> @@ -2940,31 +2940,31 @@ static void gen_mxu_Q8ADD(DisasContext *ctx)
>           gen_load_mxu_gpr(t4, XRc);
>   
>           for (int i = 0; i < 4; i++) {
> -            tcg_gen_andi_tl(t0, t3, 0xff);
> -            tcg_gen_andi_tl(t1, t4, 0xff);
> +            tcg_gen_andi_i32(t0, t3, 0xff);
> +            tcg_gen_andi_i32(t1, t4, 0xff);
>   
>               if (i < 2) {
>                   if (aptn2 & 0x01) {
> -                    tcg_gen_sub_tl(t0, t0, t1);
> +                    tcg_gen_sub_i32(t0, t0, t1);
>                   } else {
> -                    tcg_gen_add_tl(t0, t0, t1);
> +                    tcg_gen_add_i32(t0, t0, t1);
>                   }
>               } else {
>                   if (aptn2 & 0x02) {
> -                    tcg_gen_sub_tl(t0, t0, t1);
> +                    tcg_gen_sub_i32(t0, t0, t1);
>                   } else {
> -                    tcg_gen_add_tl(t0, t0, t1);
> +                    tcg_gen_add_i32(t0, t0, t1);
>                   }
>               }
>               if (i < 3) {
> -                tcg_gen_shri_tl(t3, t3, 8);
> -                tcg_gen_shri_tl(t4, t4, 8);
> +                tcg_gen_shri_i32(t3, t3, 8);
> +                tcg_gen_shri_i32(t4, t4, 8);
>               }
>               if (i > 0) {
> -                tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
> +                tcg_gen_deposit_i32(t2, t2, t0, 8 * i, 8);
>               } else {
> -                tcg_gen_andi_tl(t0, t0, 0xff);
> -                tcg_gen_mov_tl(t2, t0);
> +                tcg_gen_andi_i32(t0, t0, 0xff);
> +                tcg_gen_mov_i32(t2, t0);
>               }
>           }
>           gen_store_mxu_gpr(t2, XRa);
> @@ -2999,10 +2999,10 @@ static void gen_mxu_q8adde(DisasContext *ctx, bool accumulate)
>       if (unlikely((XRb == 0) && (XRc == 0))) {
>           /* both operands zero registers -> just set destination to zero */
>           if (XRa != 0) {
> -            tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
> +            tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>           }
>           if (XRd != 0) {
> -            tcg_gen_movi_tl(mxu_gpr[XRd - 1], 0);
> +            tcg_gen_movi_i32(mxu_gpr[XRd - 1], 0);
>           }
>       } else {
>           /* the most general case */
> @@ -3019,22 +3019,22 @@ static void gen_mxu_q8adde(DisasContext *ctx, bool accumulate)
>               gen_extract_mxu_gpr(t2, XRb, 24, 8);
>               gen_extract_mxu_gpr(t3, XRc, 24, 8);
>               if (aptn2 & 2) {
> -                tcg_gen_sub_tl(t0, t0, t1);
> -                tcg_gen_sub_tl(t2, t2, t3);
> +                tcg_gen_sub_i32(t0, t0, t1);
> +                tcg_gen_sub_i32(t2, t2, t3);
>               } else {
> -                tcg_gen_add_tl(t0, t0, t1);
> -                tcg_gen_add_tl(t2, t2, t3);
> +                tcg_gen_add_i32(t0, t0, t1);
> +                tcg_gen_add_i32(t2, t2, t3);
>               }
>               if (accumulate) {
>                   gen_load_mxu_gpr(t5, XRa);
> -                tcg_gen_extract_tl(t1, t5,  0, 16);
> -                tcg_gen_extract_tl(t3, t5, 16, 16);
> -                tcg_gen_add_tl(t0, t0, t1);
> -                tcg_gen_add_tl(t2, t2, t3);
> +                tcg_gen_extract_i32(t1, t5,  0, 16);
> +                tcg_gen_extract_i32(t3, t5, 16, 16);
> +                tcg_gen_add_i32(t0, t0, t1);
> +                tcg_gen_add_i32(t2, t2, t3);
>               }
> -            tcg_gen_shli_tl(t2, t2, 16);
> -            tcg_gen_extract_tl(t0, t0, 0, 16);
> -            tcg_gen_or_tl(t4, t2, t0);
> +            tcg_gen_shli_i32(t2, t2, 16);
> +            tcg_gen_extract_i32(t0, t0, 0, 16);
> +            tcg_gen_or_i32(t4, t2, t0);
>           }
>           if (XRd != 0) {
>               gen_extract_mxu_gpr(t0, XRb, 0, 8);
> @@ -3042,22 +3042,22 @@ static void gen_mxu_q8adde(DisasContext *ctx, bool accumulate)
>               gen_extract_mxu_gpr(t2, XRb, 8, 8);
>               gen_extract_mxu_gpr(t3, XRc, 8, 8);
>               if (aptn2 & 1) {
> -                tcg_gen_sub_tl(t0, t0, t1);
> -                tcg_gen_sub_tl(t2, t2, t3);
> +                tcg_gen_sub_i32(t0, t0, t1);
> +                tcg_gen_sub_i32(t2, t2, t3);
>               } else {
> -                tcg_gen_add_tl(t0, t0, t1);
> -                tcg_gen_add_tl(t2, t2, t3);
> +                tcg_gen_add_i32(t0, t0, t1);
> +                tcg_gen_add_i32(t2, t2, t3);
>               }
>               if (accumulate) {
>                   gen_load_mxu_gpr(t5, XRd);
> -                tcg_gen_extract_tl(t1, t5,  0, 16);
> -                tcg_gen_extract_tl(t3, t5, 16, 16);
> -                tcg_gen_add_tl(t0, t0, t1);
> -                tcg_gen_add_tl(t2, t2, t3);
> +                tcg_gen_extract_i32(t1, t5,  0, 16);
> +                tcg_gen_extract_i32(t3, t5, 16, 16);
> +                tcg_gen_add_i32(t0, t0, t1);
> +                tcg_gen_add_i32(t2, t2, t3);
>               }
> -            tcg_gen_shli_tl(t2, t2, 16);
> -            tcg_gen_extract_tl(t0, t0, 0, 16);
> -            tcg_gen_or_tl(t5, t2, t0);
> +            tcg_gen_shli_i32(t2, t2, 16);
> +            tcg_gen_extract_i32(t0, t0, 0, 16);
> +            tcg_gen_or_i32(t5, t2, t0);
>           }
>   
>           gen_store_mxu_gpr(t4, XRa);
> @@ -3090,7 +3090,7 @@ static void gen_mxu_d8sum(DisasContext *ctx, bool sumc)
>           /* destination is zero register -> do nothing */
>       } else if (unlikely((XRb == 0) && (XRc == 0))) {
>           /* both operands zero registers -> just set destination to zero */
> -        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else {
>           /* the most general case */
>           TCGv t0 = tcg_temp_new();
> @@ -3101,35 +3101,35 @@ static void gen_mxu_d8sum(DisasContext *ctx, bool sumc)
>           TCGv t5 = tcg_temp_new();
>   
>           if (XRb != 0) {
> -            tcg_gen_extract_tl(t0, mxu_gpr[XRb - 1],  0, 8);
> -            tcg_gen_extract_tl(t1, mxu_gpr[XRb - 1],  8, 8);
> -            tcg_gen_extract_tl(t2, mxu_gpr[XRb - 1], 16, 8);
> -            tcg_gen_extract_tl(t3, mxu_gpr[XRb - 1], 24, 8);
> -            tcg_gen_add_tl(t4, t0, t1);
> -            tcg_gen_add_tl(t4, t4, t2);
> -            tcg_gen_add_tl(t4, t4, t3);
> +            tcg_gen_extract_i32(t0, mxu_gpr[XRb - 1],  0, 8);
> +            tcg_gen_extract_i32(t1, mxu_gpr[XRb - 1],  8, 8);
> +            tcg_gen_extract_i32(t2, mxu_gpr[XRb - 1], 16, 8);
> +            tcg_gen_extract_i32(t3, mxu_gpr[XRb - 1], 24, 8);
> +            tcg_gen_add_i32(t4, t0, t1);
> +            tcg_gen_add_i32(t4, t4, t2);
> +            tcg_gen_add_i32(t4, t4, t3);
>           } else {
> -            tcg_gen_mov_tl(t4, 0);
> +            tcg_gen_mov_i32(t4, 0);
>           }
>           if (XRc != 0) {
> -            tcg_gen_extract_tl(t0, mxu_gpr[XRc - 1],  0, 8);
> -            tcg_gen_extract_tl(t1, mxu_gpr[XRc - 1],  8, 8);
> -            tcg_gen_extract_tl(t2, mxu_gpr[XRc - 1], 16, 8);
> -            tcg_gen_extract_tl(t3, mxu_gpr[XRc - 1], 24, 8);
> -            tcg_gen_add_tl(t5, t0, t1);
> -            tcg_gen_add_tl(t5, t5, t2);
> -            tcg_gen_add_tl(t5, t5, t3);
> +            tcg_gen_extract_i32(t0, mxu_gpr[XRc - 1],  0, 8);
> +            tcg_gen_extract_i32(t1, mxu_gpr[XRc - 1],  8, 8);
> +            tcg_gen_extract_i32(t2, mxu_gpr[XRc - 1], 16, 8);
> +            tcg_gen_extract_i32(t3, mxu_gpr[XRc - 1], 24, 8);
> +            tcg_gen_add_i32(t5, t0, t1);
> +            tcg_gen_add_i32(t5, t5, t2);
> +            tcg_gen_add_i32(t5, t5, t3);
>           } else {
> -            tcg_gen_mov_tl(t5, 0);
> +            tcg_gen_mov_i32(t5, 0);
>           }
>   
>           if (sumc) {
> -            tcg_gen_addi_tl(t4, t4, 2);
> -            tcg_gen_addi_tl(t5, t5, 2);
> +            tcg_gen_addi_i32(t4, t4, 2);
> +            tcg_gen_addi_i32(t5, t5, 2);
>           }
> -        tcg_gen_shli_tl(t4, t4, 16);
> +        tcg_gen_shli_i32(t4, t4, 16);
>   
> -        tcg_gen_or_tl(mxu_gpr[XRa - 1], t4, t5);
> +        tcg_gen_or_i32(mxu_gpr[XRa - 1], t4, t5);
>       }
>   }
>   
> @@ -3156,66 +3156,66 @@ static void gen_mxu_q16add(DisasContext *ctx)
>       TCGv t5 = tcg_temp_new();
>   
>       gen_load_mxu_gpr(t1, XRb);
> -    tcg_gen_extract_tl(t0, t1,  0, 16);
> -    tcg_gen_extract_tl(t1, t1, 16, 16);
> +    tcg_gen_extract_i32(t0, t1,  0, 16);
> +    tcg_gen_extract_i32(t1, t1, 16, 16);
>   
>       gen_load_mxu_gpr(t3, XRc);
> -    tcg_gen_extract_tl(t2, t3,  0, 16);
> -    tcg_gen_extract_tl(t3, t3, 16, 16);
> +    tcg_gen_extract_i32(t2, t3,  0, 16);
> +    tcg_gen_extract_i32(t3, t3, 16, 16);
>   
>       switch (optn2) {
>       case MXU_OPTN2_WW: /* XRB.H+XRC.H == lop, XRB.L+XRC.L == rop */
> -        tcg_gen_mov_tl(t4, t1);
> -        tcg_gen_mov_tl(t5, t0);
> +        tcg_gen_mov_i32(t4, t1);
> +        tcg_gen_mov_i32(t5, t0);
>           break;
>       case MXU_OPTN2_LW: /* XRB.L+XRC.H == lop, XRB.L+XRC.L == rop */
> -        tcg_gen_mov_tl(t4, t0);
> -        tcg_gen_mov_tl(t5, t0);
> +        tcg_gen_mov_i32(t4, t0);
> +        tcg_gen_mov_i32(t5, t0);
>           break;
>       case MXU_OPTN2_HW: /* XRB.H+XRC.H == lop, XRB.H+XRC.L == rop */
> -        tcg_gen_mov_tl(t4, t1);
> -        tcg_gen_mov_tl(t5, t1);
> +        tcg_gen_mov_i32(t4, t1);
> +        tcg_gen_mov_i32(t5, t1);
>           break;
>       case MXU_OPTN2_XW: /* XRB.L+XRC.H == lop, XRB.H+XRC.L == rop */
> -        tcg_gen_mov_tl(t4, t0);
> -        tcg_gen_mov_tl(t5, t1);
> +        tcg_gen_mov_i32(t4, t0);
> +        tcg_gen_mov_i32(t5, t1);
>           break;
>       }
>   
>       switch (aptn2) {
>       case MXU_APTN2_AA: /* lop +, rop + */
> -        tcg_gen_add_tl(t0, t4, t3);
> -        tcg_gen_add_tl(t1, t5, t2);
> -        tcg_gen_add_tl(t4, t4, t3);
> -        tcg_gen_add_tl(t5, t5, t2);
> +        tcg_gen_add_i32(t0, t4, t3);
> +        tcg_gen_add_i32(t1, t5, t2);
> +        tcg_gen_add_i32(t4, t4, t3);
> +        tcg_gen_add_i32(t5, t5, t2);
>           break;
>       case MXU_APTN2_AS: /* lop +, rop + */
> -        tcg_gen_sub_tl(t0, t4, t3);
> -        tcg_gen_sub_tl(t1, t5, t2);
> -        tcg_gen_add_tl(t4, t4, t3);
> -        tcg_gen_add_tl(t5, t5, t2);
> +        tcg_gen_sub_i32(t0, t4, t3);
> +        tcg_gen_sub_i32(t1, t5, t2);
> +        tcg_gen_add_i32(t4, t4, t3);
> +        tcg_gen_add_i32(t5, t5, t2);
>           break;
>       case MXU_APTN2_SA: /* lop +, rop + */
> -        tcg_gen_add_tl(t0, t4, t3);
> -        tcg_gen_add_tl(t1, t5, t2);
> -        tcg_gen_sub_tl(t4, t4, t3);
> -        tcg_gen_sub_tl(t5, t5, t2);
> +        tcg_gen_add_i32(t0, t4, t3);
> +        tcg_gen_add_i32(t1, t5, t2);
> +        tcg_gen_sub_i32(t4, t4, t3);
> +        tcg_gen_sub_i32(t5, t5, t2);
>           break;
>       case MXU_APTN2_SS: /* lop +, rop + */
> -        tcg_gen_sub_tl(t0, t4, t3);
> -        tcg_gen_sub_tl(t1, t5, t2);
> -        tcg_gen_sub_tl(t4, t4, t3);
> -        tcg_gen_sub_tl(t5, t5, t2);
> +        tcg_gen_sub_i32(t0, t4, t3);
> +        tcg_gen_sub_i32(t1, t5, t2);
> +        tcg_gen_sub_i32(t4, t4, t3);
> +        tcg_gen_sub_i32(t5, t5, t2);
>           break;
>       }
>   
> -    tcg_gen_shli_tl(t0, t0, 16);
> -    tcg_gen_extract_tl(t1, t1, 0, 16);
> -    tcg_gen_shli_tl(t4, t4, 16);
> -    tcg_gen_extract_tl(t5, t5, 0, 16);
> +    tcg_gen_shli_i32(t0, t0, 16);
> +    tcg_gen_extract_i32(t1, t1, 0, 16);
> +    tcg_gen_shli_i32(t4, t4, 16);
> +    tcg_gen_extract_i32(t5, t5, 0, 16);
>   
> -    tcg_gen_or_tl(mxu_gpr[XRa - 1], t4, t5);
> -    tcg_gen_or_tl(mxu_gpr[XRd - 1], t0, t1);
> +    tcg_gen_or_i32(mxu_gpr[XRa - 1], t4, t5);
> +    tcg_gen_or_i32(mxu_gpr[XRd - 1], t0, t1);
>   }
>   
>   /*
> @@ -3242,56 +3242,56 @@ static void gen_mxu_q16acc(DisasContext *ctx)
>       TCGv s0 = tcg_temp_new();
>   
>       gen_load_mxu_gpr(t1, XRb);
> -    tcg_gen_extract_tl(t0, t1,  0, 16);
> -    tcg_gen_extract_tl(t1, t1, 16, 16);
> +    tcg_gen_extract_i32(t0, t1,  0, 16);
> +    tcg_gen_extract_i32(t1, t1, 16, 16);
>   
>       gen_load_mxu_gpr(t3, XRc);
> -    tcg_gen_extract_tl(t2, t3,  0, 16);
> -    tcg_gen_extract_tl(t3, t3, 16, 16);
> +    tcg_gen_extract_i32(t2, t3,  0, 16);
> +    tcg_gen_extract_i32(t3, t3, 16, 16);
>   
>       switch (aptn2) {
>       case MXU_APTN2_AA: /* lop +, rop + */
> -        tcg_gen_add_tl(s3, t1, t3);
> -        tcg_gen_add_tl(s2, t0, t2);
> -        tcg_gen_add_tl(s1, t1, t3);
> -        tcg_gen_add_tl(s0, t0, t2);
> +        tcg_gen_add_i32(s3, t1, t3);
> +        tcg_gen_add_i32(s2, t0, t2);
> +        tcg_gen_add_i32(s1, t1, t3);
> +        tcg_gen_add_i32(s0, t0, t2);
>           break;
>       case MXU_APTN2_AS: /* lop +, rop - */
> -        tcg_gen_sub_tl(s3, t1, t3);
> -        tcg_gen_sub_tl(s2, t0, t2);
> -        tcg_gen_add_tl(s1, t1, t3);
> -        tcg_gen_add_tl(s0, t0, t2);
> +        tcg_gen_sub_i32(s3, t1, t3);
> +        tcg_gen_sub_i32(s2, t0, t2);
> +        tcg_gen_add_i32(s1, t1, t3);
> +        tcg_gen_add_i32(s0, t0, t2);
>           break;
>       case MXU_APTN2_SA: /* lop -, rop + */
> -        tcg_gen_add_tl(s3, t1, t3);
> -        tcg_gen_add_tl(s2, t0, t2);
> -        tcg_gen_sub_tl(s1, t1, t3);
> -        tcg_gen_sub_tl(s0, t0, t2);
> +        tcg_gen_add_i32(s3, t1, t3);
> +        tcg_gen_add_i32(s2, t0, t2);
> +        tcg_gen_sub_i32(s1, t1, t3);
> +        tcg_gen_sub_i32(s0, t0, t2);
>           break;
>       case MXU_APTN2_SS: /* lop -, rop - */
> -        tcg_gen_sub_tl(s3, t1, t3);
> -        tcg_gen_sub_tl(s2, t0, t2);
> -        tcg_gen_sub_tl(s1, t1, t3);
> -        tcg_gen_sub_tl(s0, t0, t2);
> +        tcg_gen_sub_i32(s3, t1, t3);
> +        tcg_gen_sub_i32(s2, t0, t2);
> +        tcg_gen_sub_i32(s1, t1, t3);
> +        tcg_gen_sub_i32(s0, t0, t2);
>           break;
>       }
>   
>       if (XRa != 0) {
> -        tcg_gen_add_tl(t0, mxu_gpr[XRa - 1], s0);
> -        tcg_gen_extract_tl(t0, t0, 0, 16);
> -        tcg_gen_extract_tl(t1, mxu_gpr[XRa - 1], 16, 16);
> -        tcg_gen_add_tl(t1, t1, s1);
> -        tcg_gen_shli_tl(t1, t1, 16);
> -        tcg_gen_or_tl(mxu_gpr[XRa - 1], t1, t0);
> +        tcg_gen_add_i32(t0, mxu_gpr[XRa - 1], s0);
> +        tcg_gen_extract_i32(t0, t0, 0, 16);
> +        tcg_gen_extract_i32(t1, mxu_gpr[XRa - 1], 16, 16);
> +        tcg_gen_add_i32(t1, t1, s1);
> +        tcg_gen_shli_i32(t1, t1, 16);
> +        tcg_gen_or_i32(mxu_gpr[XRa - 1], t1, t0);
>       }
>   
>       if (XRd != 0) {
> -        tcg_gen_add_tl(t0, mxu_gpr[XRd - 1], s2);
> -        tcg_gen_extract_tl(t0, t0, 0, 16);
> -        tcg_gen_extract_tl(t1, mxu_gpr[XRd - 1], 16, 16);
> -        tcg_gen_add_tl(t1, t1, s3);
> -        tcg_gen_shli_tl(t1, t1, 16);
> -        tcg_gen_or_tl(mxu_gpr[XRd - 1], t1, t0);
> +        tcg_gen_add_i32(t0, mxu_gpr[XRd - 1], s2);
> +        tcg_gen_extract_i32(t0, t0, 0, 16);
> +        tcg_gen_extract_i32(t1, mxu_gpr[XRd - 1], 16, 16);
> +        tcg_gen_add_i32(t1, t1, s3);
> +        tcg_gen_shli_i32(t1, t1, 16);
> +        tcg_gen_or_i32(mxu_gpr[XRd - 1], t1, t0);
>       }
>   }
>   
> @@ -3321,46 +3321,46 @@ static void gen_mxu_q16accm(DisasContext *ctx)
>           TCGv a0 = tcg_temp_new();
>           TCGv a1 = tcg_temp_new();
>   
> -        tcg_gen_extract_tl(t0, t2,  0, 16);
> -        tcg_gen_extract_tl(t1, t2, 16, 16);
> +        tcg_gen_extract_i32(t0, t2,  0, 16);
> +        tcg_gen_extract_i32(t1, t2, 16, 16);
>   
>           gen_load_mxu_gpr(a1, XRa);
> -        tcg_gen_extract_tl(a0, a1,  0, 16);
> -        tcg_gen_extract_tl(a1, a1, 16, 16);
> +        tcg_gen_extract_i32(a0, a1,  0, 16);
> +        tcg_gen_extract_i32(a1, a1, 16, 16);
>   
>           if (aptn2 & 2) {
> -            tcg_gen_sub_tl(a0, a0, t0);
> -            tcg_gen_sub_tl(a1, a1, t1);
> +            tcg_gen_sub_i32(a0, a0, t0);
> +            tcg_gen_sub_i32(a1, a1, t1);
>           } else {
> -            tcg_gen_add_tl(a0, a0, t0);
> -            tcg_gen_add_tl(a1, a1, t1);
> +            tcg_gen_add_i32(a0, a0, t0);
> +            tcg_gen_add_i32(a1, a1, t1);
>           }
> -        tcg_gen_extract_tl(a0, a0, 0, 16);
> -        tcg_gen_shli_tl(a1, a1, 16);
> -        tcg_gen_or_tl(mxu_gpr[XRa - 1], a1, a0);
> +        tcg_gen_extract_i32(a0, a0, 0, 16);
> +        tcg_gen_shli_i32(a1, a1, 16);
> +        tcg_gen_or_i32(mxu_gpr[XRa - 1], a1, a0);
>       }
>   
>       if (XRd != 0) {
>           TCGv a0 = tcg_temp_new();
>           TCGv a1 = tcg_temp_new();
>   
> -        tcg_gen_extract_tl(t0, t3,  0, 16);
> -        tcg_gen_extract_tl(t1, t3, 16, 16);
> +        tcg_gen_extract_i32(t0, t3,  0, 16);
> +        tcg_gen_extract_i32(t1, t3, 16, 16);
>   
>           gen_load_mxu_gpr(a1, XRd);
> -        tcg_gen_extract_tl(a0, a1,  0, 16);
> -        tcg_gen_extract_tl(a1, a1, 16, 16);
> +        tcg_gen_extract_i32(a0, a1,  0, 16);
> +        tcg_gen_extract_i32(a1, a1, 16, 16);
>   
>           if (aptn2 & 1) {
> -            tcg_gen_sub_tl(a0, a0, t0);
> -            tcg_gen_sub_tl(a1, a1, t1);
> +            tcg_gen_sub_i32(a0, a0, t0);
> +            tcg_gen_sub_i32(a1, a1, t1);
>           } else {
> -            tcg_gen_add_tl(a0, a0, t0);
> -            tcg_gen_add_tl(a1, a1, t1);
> +            tcg_gen_add_i32(a0, a0, t0);
> +            tcg_gen_add_i32(a1, a1, t1);
>           }
> -        tcg_gen_extract_tl(a0, a0, 0, 16);
> -        tcg_gen_shli_tl(a1, a1, 16);
> -        tcg_gen_or_tl(mxu_gpr[XRd - 1], a1, a0);
> +        tcg_gen_extract_i32(a0, a0, 0, 16);
> +        tcg_gen_shli_i32(a1, a1, 16);
> +        tcg_gen_or_i32(mxu_gpr[XRd - 1], a1, a0);
>       }
>   }
>   
> @@ -3388,24 +3388,24 @@ static void gen_mxu_d16asum(DisasContext *ctx)
>       gen_load_mxu_gpr(t3, XRc);
>   
>       if (XRa != 0) {
> -        tcg_gen_sextract_tl(t0, t2,  0, 16);
> -        tcg_gen_sextract_tl(t1, t2, 16, 16);
> -        tcg_gen_add_tl(t0, t0, t1);
> +        tcg_gen_sextract_i32(t0, t2,  0, 16);
> +        tcg_gen_sextract_i32(t1, t2, 16, 16);
> +        tcg_gen_add_i32(t0, t0, t1);
>           if (aptn2 & 2) {
> -            tcg_gen_sub_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
> +            tcg_gen_sub_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
>           } else {
> -            tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
> +            tcg_gen_add_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
>           }
>       }
>   
>       if (XRd != 0) {
> -        tcg_gen_sextract_tl(t0, t3,  0, 16);
> -        tcg_gen_sextract_tl(t1, t3, 16, 16);
> -        tcg_gen_add_tl(t0, t0, t1);
> +        tcg_gen_sextract_i32(t0, t3,  0, 16);
> +        tcg_gen_sextract_i32(t1, t3, 16, 16);
> +        tcg_gen_add_i32(t0, t0, t1);
>           if (aptn2 & 1) {
> -            tcg_gen_sub_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t0);
> +            tcg_gen_sub_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t0);
>           } else {
> -            tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t0);
> +            tcg_gen_add_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t0);
>           }
>       }
>   }
> @@ -3445,14 +3445,14 @@ static void gen_mxu_d32add(DisasContext *ctx)
>               gen_load_mxu_gpr(t1, XRc);
>               gen_load_mxu_cr(cr);
>               if (XRa != 0) {
> -                tcg_gen_extract_tl(t2, cr, 31, 1);
> -                tcg_gen_add_tl(t0, t0, t2);
> -                tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
> +                tcg_gen_extract_i32(t2, cr, 31, 1);
> +                tcg_gen_add_i32(t0, t0, t2);
> +                tcg_gen_add_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
>               }
>               if (XRd != 0) {
> -                tcg_gen_extract_tl(t2, cr, 30, 1);
> -                tcg_gen_add_tl(t1, t1, t2);
> -                tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
> +                tcg_gen_extract_i32(t2, cr, 30, 1);
> +                tcg_gen_add_i32(t1, t1, t2);
> +                tcg_gen_add_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
>               }
>           }
>       } else if (unlikely(XRa == 0 && XRd == 0)) {
> @@ -3468,27 +3468,27 @@ static void gen_mxu_d32add(DisasContext *ctx)
>           if (XRa != 0) {
>               if (aptn2 & 2) {
>                   tcg_gen_sub_i32(t2, t0, t1);
> -                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t1);
> +                tcg_gen_setcond_i32(TCG_COND_GTU, carry, t0, t1);
>               } else {
>                   tcg_gen_add_i32(t2, t0, t1);
> -                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t2);
> +                tcg_gen_setcond_i32(TCG_COND_GTU, carry, t0, t2);
>               }
> -            tcg_gen_andi_tl(cr, cr, 0x7fffffff);
> -            tcg_gen_shli_tl(carry, carry, 31);
> -            tcg_gen_or_tl(cr, cr, carry);
> +            tcg_gen_andi_i32(cr, cr, 0x7fffffff);
> +            tcg_gen_shli_i32(carry, carry, 31);
> +            tcg_gen_or_i32(cr, cr, carry);
>               gen_store_mxu_gpr(t2, XRa);
>           }
>           if (XRd != 0) {
>               if (aptn2 & 1) {
>                   tcg_gen_sub_i32(t2, t0, t1);
> -                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t1);
> +                tcg_gen_setcond_i32(TCG_COND_GTU, carry, t0, t1);
>               } else {
>                   tcg_gen_add_i32(t2, t0, t1);
> -                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t2);
> +                tcg_gen_setcond_i32(TCG_COND_GTU, carry, t0, t2);
>               }
> -            tcg_gen_andi_tl(cr, cr, 0xbfffffff);
> -            tcg_gen_shli_tl(carry, carry, 30);
> -            tcg_gen_or_tl(cr, cr, carry);
> +            tcg_gen_andi_i32(cr, cr, 0xbfffffff);
> +            tcg_gen_shli_i32(carry, carry, 30);
> +            tcg_gen_or_i32(cr, cr, carry);
>               gen_store_mxu_gpr(t2, XRd);
>           }
>           gen_store_mxu_cr(cr);
> @@ -3521,19 +3521,19 @@ static void gen_mxu_d32acc(DisasContext *ctx)
>           gen_load_mxu_gpr(t1, XRc);
>           if (XRa != 0) {
>               if (aptn2 & 2) {
> -                tcg_gen_sub_tl(t2, t0, t1);
> +                tcg_gen_sub_i32(t2, t0, t1);
>               } else {
> -                tcg_gen_add_tl(t2, t0, t1);
> +                tcg_gen_add_i32(t2, t0, t1);
>               }
> -            tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
> +            tcg_gen_add_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
>           }
>           if (XRd != 0) {
>               if (aptn2 & 1) {
> -                tcg_gen_sub_tl(t2, t0, t1);
> +                tcg_gen_sub_i32(t2, t0, t1);
>               } else {
> -                tcg_gen_add_tl(t2, t0, t1);
> +                tcg_gen_add_i32(t2, t0, t1);
>               }
> -            tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
> +            tcg_gen_add_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
>           }
>       }
>   }
> @@ -3563,19 +3563,19 @@ static void gen_mxu_d32accm(DisasContext *ctx)
>           gen_load_mxu_gpr(t0, XRb);
>           gen_load_mxu_gpr(t1, XRc);
>           if (XRa != 0) {
> -            tcg_gen_add_tl(t2, t0, t1);
> +            tcg_gen_add_i32(t2, t0, t1);
>               if (aptn2 & 2) {
> -                tcg_gen_sub_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
> +                tcg_gen_sub_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
>               } else {
> -                tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
> +                tcg_gen_add_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
>               }
>           }
>           if (XRd != 0) {
> -            tcg_gen_sub_tl(t2, t0, t1);
> +            tcg_gen_sub_i32(t2, t0, t1);
>               if (aptn2 & 1) {
> -                tcg_gen_sub_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
> +                tcg_gen_sub_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
>               } else {
> -                tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
> +                tcg_gen_add_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
>               }
>           }
>       }
> @@ -3606,16 +3606,16 @@ static void gen_mxu_d32asum(DisasContext *ctx)
>           gen_load_mxu_gpr(t1, XRc);
>           if (XRa != 0) {
>               if (aptn2 & 2) {
> -                tcg_gen_sub_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
> +                tcg_gen_sub_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
>               } else {
> -                tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
> +                tcg_gen_add_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
>               }
>           }
>           if (XRd != 0) {
>               if (aptn2 & 1) {
> -                tcg_gen_sub_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
> +                tcg_gen_sub_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
>               } else {
> -                tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
> +                tcg_gen_add_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
>               }
>           }
>       }
> @@ -3659,24 +3659,24 @@ static void gen_mxu_s32extr(DisasContext *ctx)
>   
>           gen_load_mxu_gpr(t0, XRd);
>           gen_load_mxu_gpr(t1, XRa);
> -        gen_load_gpr_tl(t2, rs);
> -        tcg_gen_andi_tl(t2, t2, 0x1f);
> -        tcg_gen_subfi_tl(t2, 32, t2);
> -        tcg_gen_brcondi_tl(TCG_COND_GE, t2, bits5, l_xra_only);
> -        tcg_gen_subfi_tl(t2, bits5, t2);
> -        tcg_gen_subfi_tl(t3, 32, t2);
> -        tcg_gen_shr_tl(t0, t0, t3);
> -        tcg_gen_shl_tl(t1, t1, t2);
> -        tcg_gen_or_tl(t0, t0, t1);
> +        gen_load_gpr_i32(t2, rs);
> +        tcg_gen_andi_i32(t2, t2, 0x1f);
> +        tcg_gen_subfi_i32(t2, 32, t2);
> +        tcg_gen_brcondi_i32(TCG_COND_GE, t2, bits5, l_xra_only);
> +        tcg_gen_subfi_i32(t2, bits5, t2);
> +        tcg_gen_subfi_i32(t3, 32, t2);
> +        tcg_gen_shr_i32(t0, t0, t3);
> +        tcg_gen_shl_i32(t1, t1, t2);
> +        tcg_gen_or_i32(t0, t0, t1);
>           tcg_gen_br(l_done);
>           gen_set_label(l_xra_only);
> -        tcg_gen_subi_tl(t2, t2, bits5);
> -        tcg_gen_shr_tl(t0, t1, t2);
> +        tcg_gen_subi_i32(t2, t2, bits5);
> +        tcg_gen_shr_i32(t0, t1, t2);
>           gen_set_label(l_done);
> -        tcg_gen_extract_tl(t0, t0, 0, bits5);
> +        tcg_gen_extract_i32(t0, t0, 0, bits5);
>       } else {
>           /* unspecified behavior but matches tests on real hardware*/
> -        tcg_gen_movi_tl(t0, 0);
> +        tcg_gen_movi_i32(t0, 0);
>       }
>       gen_store_mxu_gpr(t0, XRa);
>   }
> @@ -3709,34 +3709,34 @@ static void gen_mxu_s32extrv(DisasContext *ctx)
>       /* {tmp} = {XRa:XRd} >> (64 - rs - rt) */
>       gen_load_mxu_gpr(t0, XRd);
>       gen_load_mxu_gpr(t1, XRa);
> -    gen_load_gpr_tl(t2, rs);
> -    gen_load_gpr_tl(t4, rt);
> -    tcg_gen_brcondi_tl(TCG_COND_EQ, t4, 0, l_zero);
> -    tcg_gen_andi_tl(t2, t2, 0x1f);
> -    tcg_gen_subfi_tl(t2, 32, t2);
> -    tcg_gen_brcond_tl(TCG_COND_GE, t2, t4, l_xra_only);
> -    tcg_gen_sub_tl(t2, t4, t2);
> -    tcg_gen_subfi_tl(t3, 32, t2);
> -    tcg_gen_shr_tl(t0, t0, t3);
> -    tcg_gen_shl_tl(t1, t1, t2);
> -    tcg_gen_or_tl(t0, t0, t1);
> +    gen_load_gpr_i32(t2, rs);
> +    gen_load_gpr_i32(t4, rt);
> +    tcg_gen_brcondi_i32(TCG_COND_EQ, t4, 0, l_zero);
> +    tcg_gen_andi_i32(t2, t2, 0x1f);
> +    tcg_gen_subfi_i32(t2, 32, t2);
> +    tcg_gen_brcond_i32(TCG_COND_GE, t2, t4, l_xra_only);
> +    tcg_gen_sub_i32(t2, t4, t2);
> +    tcg_gen_subfi_i32(t3, 32, t2);
> +    tcg_gen_shr_i32(t0, t0, t3);
> +    tcg_gen_shl_i32(t1, t1, t2);
> +    tcg_gen_or_i32(t0, t0, t1);
>       tcg_gen_br(l_extract);
>   
>       gen_set_label(l_xra_only);
> -    tcg_gen_sub_tl(t2, t2, t4);
> -    tcg_gen_shr_tl(t0, t1, t2);
> +    tcg_gen_sub_i32(t2, t2, t4);
> +    tcg_gen_shr_i32(t0, t1, t2);
>       tcg_gen_br(l_extract);
>   
>       /* unspecified behavior but matches tests on real hardware*/
>       gen_set_label(l_zero);
> -    tcg_gen_movi_tl(t0, 0);
> +    tcg_gen_movi_i32(t0, 0);
>       tcg_gen_br(l_done);
>   
>       /* {XRa} = extract({tmp}, 0, rt) */
>       gen_set_label(l_extract);
> -    tcg_gen_subfi_tl(t4, 32, t4);
> -    tcg_gen_shl_tl(t0, t0, t4);
> -    tcg_gen_shr_tl(t0, t0, t4);
> +    tcg_gen_subfi_i32(t4, 32, t4);
> +    tcg_gen_shl_i32(t0, t0, t4);
> +    tcg_gen_shr_i32(t0, t0, t4);
>   
>       gen_set_label(l_done);
>       gen_store_mxu_gpr(t0, XRa);
> @@ -3766,29 +3766,29 @@ static void gen_mxu_s32lui(DisasContext *ctx)
>   
>           switch (optn3) {
>           case 0:
> -            tcg_gen_movi_tl(t0, s8);
> +            tcg_gen_movi_i32(t0, s8);
>               break;
>           case 1:
> -            tcg_gen_movi_tl(t0, s8 << 8);
> +            tcg_gen_movi_i32(t0, s8 << 8);
>               break;
>           case 2:
> -            tcg_gen_movi_tl(t0, s8 << 16);
> +            tcg_gen_movi_i32(t0, s8 << 16);
>               break;
>           case 3:
> -            tcg_gen_movi_tl(t0, s8 << 24);
> +            tcg_gen_movi_i32(t0, s8 << 24);
>               break;
>           case 4:
> -            tcg_gen_movi_tl(t0, (s8 << 16) | s8);
> +            tcg_gen_movi_i32(t0, (s8 << 16) | s8);
>               break;
>           case 5:
> -            tcg_gen_movi_tl(t0, (s8 << 24) | (s8 << 8));
> +            tcg_gen_movi_i32(t0, (s8 << 24) | (s8 << 8));
>               break;
>           case 6:
>               s16 = (uint16_t)(int16_t)(int8_t)s8;
> -            tcg_gen_movi_tl(t0, (s16 << 16) | s16);
> +            tcg_gen_movi_i32(t0, (s16 << 16) | s16);
>               break;
>           case 7:
> -            tcg_gen_movi_tl(t0, (s8 << 24) | (s8 << 16) | (s8 << 8) | s8);
> +            tcg_gen_movi_i32(t0, (s8 << 24) | (s8 << 16) | (s8 << 8) | s8);
>               break;
>           }
>           gen_store_mxu_gpr(t0, XRa);
> @@ -3820,7 +3820,7 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
>           TCGv t1 = tcg_temp_new();
>           TCGv t2 = tcg_temp_new();
>   
> -        tcg_gen_movi_tl(t2, 0);
> +        tcg_gen_movi_i32(t2, 0);
>           if (XRb != 0) {
>               TCGLabel *l_less_hi = gen_new_label();
>               TCGLabel *l_less_lo = gen_new_label();
> @@ -3829,32 +3829,32 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
>               TCGLabel *l_greater_lo = gen_new_label();
>               TCGLabel *l_done = gen_new_label();
>   
> -            tcg_gen_sari_tl(t0, mxu_gpr[XRb - 1], 16);
> -            tcg_gen_brcondi_tl(TCG_COND_LT, t0, 0, l_less_hi);
> -            tcg_gen_brcondi_tl(TCG_COND_GT, t0, 255, l_greater_hi);
> +            tcg_gen_sari_i32(t0, mxu_gpr[XRb - 1], 16);
> +            tcg_gen_brcondi_i32(TCG_COND_LT, t0, 0, l_less_hi);
> +            tcg_gen_brcondi_i32(TCG_COND_GT, t0, 255, l_greater_hi);
>               tcg_gen_br(l_lo);
>               gen_set_label(l_less_hi);
> -            tcg_gen_movi_tl(t0, 0);
> +            tcg_gen_movi_i32(t0, 0);
>               tcg_gen_br(l_lo);
>               gen_set_label(l_greater_hi);
> -            tcg_gen_movi_tl(t0, 255);
> +            tcg_gen_movi_i32(t0, 255);
>   
>               gen_set_label(l_lo);
> -            tcg_gen_shli_tl(t1, mxu_gpr[XRb - 1], 16);
> -            tcg_gen_sari_tl(t1, t1, 16);
> -            tcg_gen_brcondi_tl(TCG_COND_LT, t1, 0, l_less_lo);
> -            tcg_gen_brcondi_tl(TCG_COND_GT, t1, 255, l_greater_lo);
> +            tcg_gen_shli_i32(t1, mxu_gpr[XRb - 1], 16);
> +            tcg_gen_sari_i32(t1, t1, 16);
> +            tcg_gen_brcondi_i32(TCG_COND_LT, t1, 0, l_less_lo);
> +            tcg_gen_brcondi_i32(TCG_COND_GT, t1, 255, l_greater_lo);
>               tcg_gen_br(l_done);
>               gen_set_label(l_less_lo);
> -            tcg_gen_movi_tl(t1, 0);
> +            tcg_gen_movi_i32(t1, 0);
>               tcg_gen_br(l_done);
>               gen_set_label(l_greater_lo);
> -            tcg_gen_movi_tl(t1, 255);
> +            tcg_gen_movi_i32(t1, 255);
>   
>               gen_set_label(l_done);
> -            tcg_gen_shli_tl(t2, t0, 24);
> -            tcg_gen_shli_tl(t1, t1, 16);
> -            tcg_gen_or_tl(t2, t2, t1);
> +            tcg_gen_shli_i32(t2, t0, 24);
> +            tcg_gen_shli_i32(t1, t1, 16);
> +            tcg_gen_or_i32(t2, t2, t1);
>           }
>   
>           if (XRc != 0) {
> @@ -3865,32 +3865,32 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
>               TCGLabel *l_greater_lo = gen_new_label();
>               TCGLabel *l_done = gen_new_label();
>   
> -            tcg_gen_sari_tl(t0, mxu_gpr[XRc - 1], 16);
> -            tcg_gen_brcondi_tl(TCG_COND_LT, t0, 0, l_less_hi);
> -            tcg_gen_brcondi_tl(TCG_COND_GT, t0, 255, l_greater_hi);
> +            tcg_gen_sari_i32(t0, mxu_gpr[XRc - 1], 16);
> +            tcg_gen_brcondi_i32(TCG_COND_LT, t0, 0, l_less_hi);
> +            tcg_gen_brcondi_i32(TCG_COND_GT, t0, 255, l_greater_hi);
>               tcg_gen_br(l_lo);
>               gen_set_label(l_less_hi);
> -            tcg_gen_movi_tl(t0, 0);
> +            tcg_gen_movi_i32(t0, 0);
>               tcg_gen_br(l_lo);
>               gen_set_label(l_greater_hi);
> -            tcg_gen_movi_tl(t0, 255);
> +            tcg_gen_movi_i32(t0, 255);
>   
>               gen_set_label(l_lo);
> -            tcg_gen_shli_tl(t1, mxu_gpr[XRc - 1], 16);
> -            tcg_gen_sari_tl(t1, t1, 16);
> -            tcg_gen_brcondi_tl(TCG_COND_LT, t1, 0, l_less_lo);
> -            tcg_gen_brcondi_tl(TCG_COND_GT, t1, 255, l_greater_lo);
> +            tcg_gen_shli_i32(t1, mxu_gpr[XRc - 1], 16);
> +            tcg_gen_sari_i32(t1, t1, 16);
> +            tcg_gen_brcondi_i32(TCG_COND_LT, t1, 0, l_less_lo);
> +            tcg_gen_brcondi_i32(TCG_COND_GT, t1, 255, l_greater_lo);
>               tcg_gen_br(l_done);
>               gen_set_label(l_less_lo);
> -            tcg_gen_movi_tl(t1, 0);
> +            tcg_gen_movi_i32(t1, 0);
>               tcg_gen_br(l_done);
>               gen_set_label(l_greater_lo);
> -            tcg_gen_movi_tl(t1, 255);
> +            tcg_gen_movi_i32(t1, 255);
>   
>               gen_set_label(l_done);
> -            tcg_gen_shli_tl(t0, t0, 8);
> -            tcg_gen_or_tl(t2, t2, t0);
> -            tcg_gen_or_tl(t2, t2, t1);
> +            tcg_gen_shli_i32(t0, t0, 8);
> +            tcg_gen_or_i32(t2, t2, t0);
> +            tcg_gen_or_i32(t2, t2, t1);
>           }
>           gen_store_mxu_gpr(t2, XRa);
>       }
> @@ -3930,47 +3930,47 @@ static void gen_mxu_q16scop(DisasContext *ctx)
>       gen_load_mxu_gpr(t0, XRb);
>       gen_load_mxu_gpr(t1, XRc);
>   
> -    tcg_gen_sextract_tl(t2, t0, 16, 16);
> -    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_b_hi_lt);
> -    tcg_gen_brcondi_tl(TCG_COND_GT, t2, 0, l_b_hi_gt);
> -    tcg_gen_movi_tl(t3, 0);
> +    tcg_gen_sextract_i32(t2, t0, 16, 16);
> +    tcg_gen_brcondi_i32(TCG_COND_LT, t2, 0, l_b_hi_lt);
> +    tcg_gen_brcondi_i32(TCG_COND_GT, t2, 0, l_b_hi_gt);
> +    tcg_gen_movi_i32(t3, 0);
>       tcg_gen_br(l_b_lo);
>       gen_set_label(l_b_hi_lt);
> -    tcg_gen_movi_tl(t3, 0xffff0000);
> +    tcg_gen_movi_i32(t3, 0xffff0000);
>       tcg_gen_br(l_b_lo);
>       gen_set_label(l_b_hi_gt);
> -    tcg_gen_movi_tl(t3, 0x00010000);
> +    tcg_gen_movi_i32(t3, 0x00010000);
>   
>       gen_set_label(l_b_lo);
> -    tcg_gen_sextract_tl(t2, t0, 0, 16);
> -    tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l_c_hi);
> -    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_b_lo_lt);
> -    tcg_gen_ori_tl(t3, t3, 0x00000001);
> +    tcg_gen_sextract_i32(t2, t0, 0, 16);
> +    tcg_gen_brcondi_i32(TCG_COND_EQ, t2, 0, l_c_hi);
> +    tcg_gen_brcondi_i32(TCG_COND_LT, t2, 0, l_b_lo_lt);
> +    tcg_gen_ori_i32(t3, t3, 0x00000001);
>       tcg_gen_br(l_c_hi);
>       gen_set_label(l_b_lo_lt);
> -    tcg_gen_ori_tl(t3, t3, 0x0000ffff);
> +    tcg_gen_ori_i32(t3, t3, 0x0000ffff);
>       tcg_gen_br(l_c_hi);
>   
>       gen_set_label(l_c_hi);
> -    tcg_gen_sextract_tl(t2, t1, 16, 16);
> -    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_c_hi_lt);
> -    tcg_gen_brcondi_tl(TCG_COND_GT, t2, 0, l_c_hi_gt);
> -    tcg_gen_movi_tl(t4, 0);
> +    tcg_gen_sextract_i32(t2, t1, 16, 16);
> +    tcg_gen_brcondi_i32(TCG_COND_LT, t2, 0, l_c_hi_lt);
> +    tcg_gen_brcondi_i32(TCG_COND_GT, t2, 0, l_c_hi_gt);
> +    tcg_gen_movi_i32(t4, 0);
>       tcg_gen_br(l_c_lo);
>       gen_set_label(l_c_hi_lt);
> -    tcg_gen_movi_tl(t4, 0xffff0000);
> +    tcg_gen_movi_i32(t4, 0xffff0000);
>       tcg_gen_br(l_c_lo);
>       gen_set_label(l_c_hi_gt);
> -    tcg_gen_movi_tl(t4, 0x00010000);
> +    tcg_gen_movi_i32(t4, 0x00010000);
>   
>       gen_set_label(l_c_lo);
> -    tcg_gen_sextract_tl(t2, t1, 0, 16);
> -    tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l_done);
> -    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_c_lo_lt);
> -    tcg_gen_ori_tl(t4, t4, 0x00000001);
> +    tcg_gen_sextract_i32(t2, t1, 0, 16);
> +    tcg_gen_brcondi_i32(TCG_COND_EQ, t2, 0, l_done);
> +    tcg_gen_brcondi_i32(TCG_COND_LT, t2, 0, l_c_lo_lt);
> +    tcg_gen_ori_i32(t4, t4, 0x00000001);
>       tcg_gen_br(l_done);
>       gen_set_label(l_c_lo_lt);
> -    tcg_gen_ori_tl(t4, t4, 0x0000ffff);
> +    tcg_gen_ori_i32(t4, t4, 0x0000ffff);
>   
>       gen_set_label(l_done);
>       gen_store_mxu_gpr(t3, XRa);
> @@ -4001,52 +4001,52 @@ static void gen_mxu_s32sfl(DisasContext *ctx)
>   
>       switch (ptn2) {
>       case 0:
> -        tcg_gen_andi_tl(t2, t0, 0xff000000);
> -        tcg_gen_andi_tl(t3, t1, 0x000000ff);
> -        tcg_gen_deposit_tl(t3, t3, t0,  8, 8);
> -        tcg_gen_shri_tl(t0, t0,  8);
> -        tcg_gen_shri_tl(t1, t1,  8);
> -        tcg_gen_deposit_tl(t3, t3, t0, 24, 8);
> -        tcg_gen_deposit_tl(t3, t3, t1, 16, 8);
> -        tcg_gen_shri_tl(t0, t0,  8);
> -        tcg_gen_shri_tl(t1, t1,  8);
> -        tcg_gen_deposit_tl(t2, t2, t0,  8, 8);
> -        tcg_gen_deposit_tl(t2, t2, t1,  0, 8);
> -        tcg_gen_shri_tl(t1, t1,  8);
> -        tcg_gen_deposit_tl(t2, t2, t1, 16, 8);
> +        tcg_gen_andi_i32(t2, t0, 0xff000000);
> +        tcg_gen_andi_i32(t3, t1, 0x000000ff);
> +        tcg_gen_deposit_i32(t3, t3, t0,  8, 8);
> +        tcg_gen_shri_i32(t0, t0,  8);
> +        tcg_gen_shri_i32(t1, t1,  8);
> +        tcg_gen_deposit_i32(t3, t3, t0, 24, 8);
> +        tcg_gen_deposit_i32(t3, t3, t1, 16, 8);
> +        tcg_gen_shri_i32(t0, t0,  8);
> +        tcg_gen_shri_i32(t1, t1,  8);
> +        tcg_gen_deposit_i32(t2, t2, t0,  8, 8);
> +        tcg_gen_deposit_i32(t2, t2, t1,  0, 8);
> +        tcg_gen_shri_i32(t1, t1,  8);
> +        tcg_gen_deposit_i32(t2, t2, t1, 16, 8);
>           break;
>       case 1:
> -        tcg_gen_andi_tl(t2, t0, 0xff000000);
> -        tcg_gen_andi_tl(t3, t1, 0x000000ff);
> -        tcg_gen_deposit_tl(t3, t3, t0, 16, 8);
> -        tcg_gen_shri_tl(t0, t0,  8);
> -        tcg_gen_shri_tl(t1, t1,  8);
> -        tcg_gen_deposit_tl(t2, t2, t0, 16, 8);
> -        tcg_gen_deposit_tl(t2, t2, t1,  0, 8);
> -        tcg_gen_shri_tl(t0, t0,  8);
> -        tcg_gen_shri_tl(t1, t1,  8);
> -        tcg_gen_deposit_tl(t3, t3, t0, 24, 8);
> -        tcg_gen_deposit_tl(t3, t3, t1,  8, 8);
> -        tcg_gen_shri_tl(t1, t1,  8);
> -        tcg_gen_deposit_tl(t2, t2, t1,  8, 8);
> +        tcg_gen_andi_i32(t2, t0, 0xff000000);
> +        tcg_gen_andi_i32(t3, t1, 0x000000ff);
> +        tcg_gen_deposit_i32(t3, t3, t0, 16, 8);
> +        tcg_gen_shri_i32(t0, t0,  8);
> +        tcg_gen_shri_i32(t1, t1,  8);
> +        tcg_gen_deposit_i32(t2, t2, t0, 16, 8);
> +        tcg_gen_deposit_i32(t2, t2, t1,  0, 8);
> +        tcg_gen_shri_i32(t0, t0,  8);
> +        tcg_gen_shri_i32(t1, t1,  8);
> +        tcg_gen_deposit_i32(t3, t3, t0, 24, 8);
> +        tcg_gen_deposit_i32(t3, t3, t1,  8, 8);
> +        tcg_gen_shri_i32(t1, t1,  8);
> +        tcg_gen_deposit_i32(t2, t2, t1,  8, 8);
>           break;
>       case 2:
> -        tcg_gen_andi_tl(t2, t0, 0xff00ff00);
> -        tcg_gen_andi_tl(t3, t1, 0x00ff00ff);
> -        tcg_gen_deposit_tl(t3, t3, t0,  8, 8);
> -        tcg_gen_shri_tl(t0, t0, 16);
> -        tcg_gen_shri_tl(t1, t1,  8);
> -        tcg_gen_deposit_tl(t2, t2, t1,  0, 8);
> -        tcg_gen_deposit_tl(t3, t3, t0, 24, 8);
> -        tcg_gen_shri_tl(t1, t1, 16);
> -        tcg_gen_deposit_tl(t2, t2, t1, 16, 8);
> +        tcg_gen_andi_i32(t2, t0, 0xff00ff00);
> +        tcg_gen_andi_i32(t3, t1, 0x00ff00ff);
> +        tcg_gen_deposit_i32(t3, t3, t0,  8, 8);
> +        tcg_gen_shri_i32(t0, t0, 16);
> +        tcg_gen_shri_i32(t1, t1,  8);
> +        tcg_gen_deposit_i32(t2, t2, t1,  0, 8);
> +        tcg_gen_deposit_i32(t3, t3, t0, 24, 8);
> +        tcg_gen_shri_i32(t1, t1, 16);
> +        tcg_gen_deposit_i32(t2, t2, t1, 16, 8);
>           break;
>       case 3:
> -        tcg_gen_andi_tl(t2, t0, 0xffff0000);
> -        tcg_gen_andi_tl(t3, t1, 0x0000ffff);
> -        tcg_gen_shri_tl(t1, t1, 16);
> -        tcg_gen_deposit_tl(t2, t2, t1,  0, 16);
> -        tcg_gen_deposit_tl(t3, t3, t0, 16, 16);
> +        tcg_gen_andi_i32(t2, t0, 0xffff0000);
> +        tcg_gen_andi_i32(t3, t1, 0x0000ffff);
> +        tcg_gen_shri_i32(t1, t1, 16);
> +        tcg_gen_deposit_i32(t2, t2, t1,  0, 16);
> +        tcg_gen_deposit_i32(t3, t3, t0, 16, 16);
>           break;
>       }
>   
> @@ -4077,20 +4077,20 @@ static void gen_mxu_q8sad(DisasContext *ctx)
>       gen_load_mxu_gpr(t2, XRb);
>       gen_load_mxu_gpr(t3, XRc);
>       gen_load_mxu_gpr(t5, XRd);
> -    tcg_gen_movi_tl(t4, 0);
> +    tcg_gen_movi_i32(t4, 0);
>   
>       for (int i = 0; i < 4; i++) {
> -        tcg_gen_andi_tl(t0, t2, 0xff);
> -        tcg_gen_andi_tl(t1, t3, 0xff);
> -        tcg_gen_sub_tl(t0, t0, t1);
> -        tcg_gen_abs_tl(t0, t0);
> -        tcg_gen_add_tl(t4, t4, t0);
> +        tcg_gen_andi_i32(t0, t2, 0xff);
> +        tcg_gen_andi_i32(t1, t3, 0xff);
> +        tcg_gen_sub_i32(t0, t0, t1);
> +        tcg_gen_abs_i32(t0, t0);
> +        tcg_gen_add_i32(t4, t4, t0);
>           if (i < 3) {
> -            tcg_gen_shri_tl(t2, t2, 8);
> -            tcg_gen_shri_tl(t3, t3, 8);
> +            tcg_gen_shri_i32(t2, t2, 8);
> +            tcg_gen_shri_i32(t3, t3, 8);
>           }
>       }
> -    tcg_gen_add_tl(t5, t5, t4);
> +    tcg_gen_add_i32(t5, t5, t4);
>       gen_store_mxu_gpr(t4, XRa);
>       gen_store_mxu_gpr(t5, XRd);
>   }
> @@ -4290,7 +4290,7 @@ static void gen_mxu_S32ALN(DisasContext *ctx)
>           /* destination is zero register -> do nothing */
>       } else if (unlikely((XRb == 0) && (XRc == 0))) {
>           /* both operands zero registers -> just set destination to all 0s */
> -        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
>       } else {
>           /* the most general case */
>           TCGv t0 = tcg_temp_new();
> @@ -4303,21 +4303,21 @@ static void gen_mxu_S32ALN(DisasContext *ctx)
>   
>           gen_load_mxu_gpr(t0, XRb);
>           gen_load_mxu_gpr(t1, XRc);
> -        gen_load_gpr_tl(t2, rs);
> -        tcg_gen_andi_tl(t2, t2, 0x07);
> +        gen_load_gpr_i32(t2, rs);
> +        tcg_gen_andi_i32(t2, t2, 0x07);
>   
>           /* do nothing for undefined cases */
> -        tcg_gen_brcondi_tl(TCG_COND_GE, t2, 5, l_exit);
> +        tcg_gen_brcondi_i32(TCG_COND_GE, t2, 5, l_exit);
>   
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l_b_only);
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 4, l_c_only);
> +        tcg_gen_brcondi_i32(TCG_COND_EQ, t2, 0, l_b_only);
> +        tcg_gen_brcondi_i32(TCG_COND_EQ, t2, 4, l_c_only);
>   
> -        tcg_gen_shli_tl(t2, t2, 3);
> -        tcg_gen_subfi_tl(t3, 32, t2);
> +        tcg_gen_shli_i32(t2, t2, 3);
> +        tcg_gen_subfi_i32(t3, 32, t2);
>   
> -        tcg_gen_shl_tl(t0, t0, t2);
> -        tcg_gen_shr_tl(t1, t1, t3);
> -        tcg_gen_or_tl(mxu_gpr[XRa - 1], t0, t1);
> +        tcg_gen_shl_i32(t0, t0, t2);
> +        tcg_gen_shr_i32(t1, t1, t3);
> +        tcg_gen_or_i32(mxu_gpr[XRa - 1], t0, t1);
>           tcg_gen_br(l_exit);
>   
>           gen_set_label(l_b_only);
> @@ -4364,32 +4364,32 @@ static void gen_mxu_s32madd_sub(DisasContext *ctx, bool sub, bool uns)
>           TCGv_i64 t2 = tcg_temp_new_i64();
>           TCGv_i64 t3 = tcg_temp_new_i64();
>   
> -        gen_load_gpr_tl(t0, Rb);
> -        gen_load_gpr_tl(t1, Rc);
> +        gen_load_gpr_i32(t0, Rb);
> +        gen_load_gpr_i32(t1, Rc);
>   
>           if (uns) {
> -            tcg_gen_extu_tl_i64(t2, t0);
> -            tcg_gen_extu_tl_i64(t3, t1);
> +            tcg_gen_extu_i32_i64(t2, t0);
> +            tcg_gen_extu_i32_i64(t3, t1);
>           } else {
> -            tcg_gen_ext_tl_i64(t2, t0);
> -            tcg_gen_ext_tl_i64(t3, t1);
> +            tcg_gen_ext_i32_i64(t2, t0);
> +            tcg_gen_ext_i32_i64(t3, t1);
>           }
>           tcg_gen_mul_i64(t2, t2, t3);
>   
>           gen_load_mxu_gpr(t0, XRa);
>           gen_load_mxu_gpr(t1, XRd);
>   
> -        tcg_gen_concat_tl_i64(t3, t1, t0);
> +        tcg_gen_concat_i32_i64(t3, t1, t0);
>           if (sub) {
>               tcg_gen_sub_i64(t3, t3, t2);
>           } else {
>               tcg_gen_add_i64(t3, t3, t2);
>           }
> -        gen_move_low32_tl(t1, t3);
> -        gen_move_high32_tl(t0, t3);
> +        gen_move_low32_i32(t1, t3);
> +        gen_move_high32_i32(t0, t3);
>   
> -        tcg_gen_mov_tl(cpu_HI[0], t0);
> -        tcg_gen_mov_tl(cpu_LO[0], t1);
> +        tcg_gen_mov_i32(cpu_HI[0], t0);
> +        tcg_gen_mov_i32(cpu_LO[0], t1);
>   
>           gen_store_mxu_gpr(t1, XRd);
>           gen_store_mxu_gpr(t0, XRa);
> @@ -4940,8 +4940,8 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
>           TCGLabel *l_exit = gen_new_label();
>   
>           gen_load_mxu_cr(t_mxu_cr);
> -        tcg_gen_andi_tl(t_mxu_cr, t_mxu_cr, MXU_CR_MXU_EN);
> -        tcg_gen_brcondi_tl(TCG_COND_NE, t_mxu_cr, MXU_CR_MXU_EN, l_exit);
> +        tcg_gen_andi_i32(t_mxu_cr, t_mxu_cr, MXU_CR_MXU_EN);
> +        tcg_gen_brcondi_i32(TCG_COND_NE, t_mxu_cr, MXU_CR_MXU_EN, l_exit);
>   
>           switch (opcode) {
>           case OPC_MXU_S32MADD:


