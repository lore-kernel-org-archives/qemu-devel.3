Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A93C8303D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 02:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWnDr-0003l7-2x; Tue, 01 Jul 2025 22:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWnDp-0003ka-IM
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:29:17 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWnDn-00022c-LO
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:29:17 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-60ef07eb7f4so1841416eaf.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 19:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751423352; x=1752028152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wg+NWeNOqI2N5n/GaHZ/LLPcIAbDq0HjwrLwgpXBjUw=;
 b=mpxPpxqTRVIzhUblZyJOYRYmBnLyxE3NCsQ2UQB38nN9MRVoEnXC7VCAfemn00SNYJ
 t2c7Q/EcYKxbDPhw8/zY65Ybqpn9BhGTdLk2lKh5PNv4sbvhuYcC9jYzO8epTPYeuPDN
 /GD0yxR6BlUMBQjtLkqL04FNPbKPrRGDlORXV/7MMPwQgbfuIvvL486G4X2MGiMzs4NC
 RXJuJ8qkQsqNB/NP2pAe/3j7uyQ36sHV8fGuMsdGStdg/qwvqUYXAze5JyEafK+Rt3Hs
 ghVWG9gTn0Gkm3O2t9j1EiSOvxWZv89FtDAdzFkfxa3rpAtkrTlfOGjkI2/sodpMpSAn
 rAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751423352; x=1752028152;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wg+NWeNOqI2N5n/GaHZ/LLPcIAbDq0HjwrLwgpXBjUw=;
 b=GNhN01v0wwjlMBBCFULDwUfyewzad2TjZtFo+tthsPcuTPauxeVgZV10HbriyWw7Ic
 Ey68QWDkvz+MsjPDlh4JSgg85yyfpC46k9DlF2if3my3wRqrRsf9ecWCZH5PNfPfNDJK
 egWKNKHQbq2y9A3oyE7Caeh5Oya3zLH3ve0goai5hkWPs6gy0JlBsK118PrNdMf+FZv5
 qoDfPYPk7pQj3vudZ7azymvIzhGOnRf8m6oEsMX1M567Wy5Ez0MFY9cYcmExzyDESDxZ
 sbSmsZ+BV4W6r1GCN8XXCrMFJoUmvenh2nPZ5lwpBSkohBWzIAiUtNwG+alUsGSQ3y1i
 55Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwe2Z2VUaoJF+jTrRQE8K07xh5VAsDHgPdVzeNO1e8h0DXrIMmrlcnBZI+CmTaRXqvA2FjNgvNQA/g@nongnu.org
X-Gm-Message-State: AOJu0YxZ+ED3nEphtyaBADnKWGdFpwHPQXJr76/32/eevlsdtGwZ+90T
 mOSkQqhQyfWqwQPQV1D7zYE5wA8LjMrC4yObiLBs0dUQNCtMu85Bi41Q1nELrxcqGFA=
X-Gm-Gg: ASbGncupLQyd1WrMJ6HqtFqReboHQ4XfmOAl5RlaBhfqh+f/LE2G7kby3qeqM0wAmRe
 t7Hi7V+3lKu2ubT+7HwZlX8Np1eREzQJAARGbZUK9FuNEEfE6WaiR3V7yY8tCn2SYSFcicS7Jgw
 FO00xj/rr6Rcx43VhFOzZyFtBjl/bdi23hEyeGNp56iyZ97jjnob/ZbAcoAPJn9VYgpKMN+Lb55
 CHX+Yj0T7r1Mb70IQK5ktyfVJFpa9TZJsCH4IHE06XiJcHYBR4gd0zkn05VE3GnBx8d+YDjVikB
 RmQgluVuZhJuxXmCecQWJZsMnSO+EDiwiJI/DS3ZonWL/zKGRuxm8TuTKNsQFL2qc7GXPT3KC5f
 2jA==
X-Google-Smtp-Source: AGHT+IE/WnHajcVs8T5twY9iO4YAxUBhCwIeTH/r6lPBhkN4R025pWamf4DrJ/siaIl/9R/nwlDY2Q==
X-Received: by 2002:a05:6820:1896:b0:611:b1c7:23f with SMTP id
 006d021491bc7-61200fb67e7mr783563eaf.0.1751423351880; 
 Tue, 01 Jul 2025 19:29:11 -0700 (PDT)
Received: from [10.25.7.201] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b848ba33sm1648411eaf.10.2025.07.01.19.29.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 19:29:11 -0700 (PDT)
Message-ID: <d0fe4c30-3dbd-4868-a277-c6777a83972d@linaro.org>
Date: Tue, 1 Jul 2025 20:29:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] target/arm: Fix VLDR helper load alignment checks
To: William Kosasih <kosasihwilliam4@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
 <20250701103159.62661-5-kosasihwilliam4@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701103159.62661-5-kosasihwilliam4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

On 7/1/25 04:31, William Kosasih wrote:
> This patch adds alignment checks in the load operations in the VLDR
> instruction.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
> Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
> ---
>   target/arm/tcg/mve_helper.c | 41 ++++++++++++++++++++++++++++---------
>   1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
> index 506d1c3475..922cd2371a 100644
> --- a/target/arm/tcg/mve_helper.c
> +++ b/target/arm/tcg/mve_helper.c
> @@ -147,6 +147,22 @@ static void mve_advance_vpt(CPUARMState *env)
>       env->v7m.vpr = vpr;
>   }
>   
> +/* Mapping of LDTYPE/STTYPE to the number of bytes accessed */
> +#define MSIZE_b 1
> +#define MSIZE_w 2
> +#define MSIZE_l 4
> +
> +/* Mapping of LDTYPE/STTYPE to MemOp flag */
> +#define MFLAG_b MO_UB
> +#define MFLAG_w MO_TEUW
> +#define MFLAG_l MO_TEUL
> +
> +#define MSIZE(t)  MSIZE_##t

AFAICS, this isn't used.

> +#define MFLAG(t)  MFLAG_##t
> +
> +#define SIGN_EXT(v, T, B) { \
> +    ((T)(v) << (sizeof(T) * 8 - (B))) >> (sizeof(T) * 8 - (B)) }

Don't do this.  (1) Not all of these operations require sign extension, (2) it's clearer 
to simply cast to an appropriate MTYPE.

r~

> +
>   /* For loads, predicated lanes are zeroed instead of keeping their old values */
>   #define DO_VLDR(OP, MSIZE, LDTYPE, ESIZE, TYPE)                         \
>       void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)    \
> @@ -155,6 +171,8 @@ static void mve_advance_vpt(CPUARMState *env)
>           uint16_t mask = mve_element_mask(env);                          \
>           uint16_t eci_mask = mve_eci_mask(env);                          \
>           unsigned b, e;                                                  \
> +        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
> +        MemOpIdx oi = make_memop_idx(MFLAG(LDTYPE) | MO_ALIGN, mmu_idx);\
>           /*                                                              \
>            * R_SXTM allows the dest reg to become UNKNOWN for abandoned   \
>            * beats so we don't care if we update part of the dest and     \
> @@ -163,7 +181,10 @@ static void mve_advance_vpt(CPUARMState *env)
>           for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
>               if (eci_mask & (1 << b)) {                                  \
>                   d[H##ESIZE(e)] = (mask & (1 << b)) ?                    \
> -                    cpu_##LDTYPE##_data_ra(env, addr, GETPC()) : 0;     \
> +                    SIGN_EXT(cpu_ld##LDTYPE##_mmu(env, addr, oi, GETPC()),\
> +                             TYPE,                                      \
> +                             MSIZE * 8)                                 \
> +                    : 0;                                                \
>               }                                                           \
>               addr += MSIZE;                                              \
>           }                                                               \
> @@ -185,20 +206,20 @@ static void mve_advance_vpt(CPUARMState *env)
>           mve_advance_vpt(env);                                           \
>       }
>   
> -DO_VLDR(vldrb, 1, ldub, 1, uint8_t)
> -DO_VLDR(vldrh, 2, lduw, 2, uint16_t)
> -DO_VLDR(vldrw, 4, ldl, 4, uint32_t)
> +DO_VLDR(vldrb, 1, b, 1, uint8_t)
> +DO_VLDR(vldrh, 2, w, 2, uint16_t)
> +DO_VLDR(vldrw, 4, l, 4, uint32_t)
>   
>   DO_VSTR(vstrb, 1, stb, 1, uint8_t)
>   DO_VSTR(vstrh, 2, stw, 2, uint16_t)
>   DO_VSTR(vstrw, 4, stl, 4, uint32_t)
>   
> -DO_VLDR(vldrb_sh, 1, ldsb, 2, int16_t)
> -DO_VLDR(vldrb_sw, 1, ldsb, 4, int32_t)
> -DO_VLDR(vldrb_uh, 1, ldub, 2, uint16_t)
> -DO_VLDR(vldrb_uw, 1, ldub, 4, uint32_t)
> -DO_VLDR(vldrh_sw, 2, ldsw, 4, int32_t)
> -DO_VLDR(vldrh_uw, 2, lduw, 4, uint32_t)
> +DO_VLDR(vldrb_sh, 1, b, 2, int16_t)
> +DO_VLDR(vldrb_sw, 1, b, 4, int32_t)
> +DO_VLDR(vldrb_uh, 1, b, 2, uint16_t)
> +DO_VLDR(vldrb_uw, 1, b, 4, uint32_t)
> +DO_VLDR(vldrh_sw, 2, w, 4, int32_t)
> +DO_VLDR(vldrh_uw, 2, w, 4, uint32_t)
>   
>   DO_VSTR(vstrb_h, 1, stb, 2, int16_t)
>   DO_VSTR(vstrb_w, 1, stb, 4, int32_t)


