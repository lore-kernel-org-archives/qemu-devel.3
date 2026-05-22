Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCAECD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 02:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQFnl-00063M-L6; Thu, 21 May 2026 22:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQFnk-000638-7b
 for qemu-devel@nongnu.org; Thu, 21 May 2026 22:39:52 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQFnh-0004Yt-9C
 for qemu-devel@nongnu.org; Thu, 21 May 2026 22:39:52 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-837dfccd950so3241014b3a.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 19:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779417587; x=1780022387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hP4gTHrEp0Se8EufgotI+bMQowTrjoZK3i/AekbYcE8=;
 b=AcKSy1GPdzX7+yPld2zakD8hjOYqw3sSGGDAgfoYrXR145WnsDBPt8dWGuw06YK50v
 ehZxjpwdhzf2Npwb89W7M3MA+uc7FwGjitVf67A+oy1EMTOenvD/RoTG5+6TIpjyj58e
 Dfu5Mon/8F+kRcV9KwWrQfTs2dOxDMARpWKBHPGV/0D6AS8kBElouhf9+jusRaYLl/BR
 XQKqYym7dKi79nbWpQRr89mNZhxgDquMWlUyX0CgIJzBrNKY/vsbto6ra04TjXzzH7hl
 ZjQ8iyGOcvJP7C9jfnEj2I7aZBvLaMYBMpGafsWZPsLxCsgD+XwY/bl6+bng+OML38wK
 14Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779417587; x=1780022387;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hP4gTHrEp0Se8EufgotI+bMQowTrjoZK3i/AekbYcE8=;
 b=VTUNsTX1cZvekXXPhE6LEX3P5xsJokla41zlGC5sByyoMWw4ccxUmTIfvODYPwJ4F6
 OGUZP6dPHcM0w6leL7wFmFp00QWrcOCXpxnm0l87K29JMmOsZY9ENDCUvmqKvgOtC5uj
 wioffsprFQFRm4zRUdmKsGFylr7KJJsOLcdgBlLqHpWrDheNHq/ON6pG6eHA/NK+HUAw
 FP2NgphgHe69sU5E5tRx83BrvLDK43LU6tVPqfKzYNPF6q8BqEcCnErVBx+ubXdvpBJs
 8n9v1ZTzOag1wAlKyi3AOSQFZl5h/k0Wh/diqZcKrRe8gfjGgO4p54eDD/yi9+rHrLbr
 8HNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TLMVbyMFkgAmmpwtVSjuJSE2c9TotdcOWgrnBiEsFYrfw/rfsrC4DOOyGYGPla3a97xmgu0zMq6Oh@nongnu.org
X-Gm-Message-State: AOJu0Yz/pbx/61m6bK7vGrzixbyZ2CFYLOMBb2/GDeNQLUPNkR7dnVUr
 0x3urr4Jdktm7J6CpxWbI93x1Crt66OgrEjbsilyz31J7LQB/GQvrXxhV76/nTso1CA=
X-Gm-Gg: Acq92OG8hvHHiPQCOZ3qF3Vqa9CsShk/k7e0AVllnfcPwurDSWbd9gGH4WlDTaVarld
 NdXIrNcyaMtZpinSJ/cEdlhAruP8SHuLKLprz9k7zWKHNLmMm1Th0yr9PkvTEaiNGp+5e77VScU
 Janpe5riXUhKIC9j2v9mpFuqV/MnZP5JnvimLhLZvFLutwUNYU0cHtl8K7qhNqHdjo1icVTuOqq
 ElADt/g223b/x5TgGLaO1KVhrMEIOza6g3LzbulxZXnibI8uB4m4UcwA7LYuOy5sMTrZk3F9o5e
 +LfvCEdb2CbVyZ8vwbEd1Prg86youPYQ7SAJM7izUdbcM3+vi+Ak5GUIYYJkLfQ7ZQDFBCBcSw+
 RpX7ONwT+gxYVmTfzqWi5ABKrEXI19mH2TPT9iRaixCJEooL0jESp6DV8NqgsTaYLDG2LjYEp5L
 wUJqWyy+2BBlnzhD6tDTlAqm3rjIEXhImMAVegrNBUyTJ8d+x2I58=
X-Received: by 2002:a05:6a00:430d:b0:838:af72:fb1f with SMTP id
 d2e1a72fcca58-8415f0e43d6mr1909360b3a.2.1779417587283; 
 Thu, 21 May 2026 19:39:47 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164e9e7e3sm263500b3a.30.2026.05.21.19.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 19:39:46 -0700 (PDT)
Message-ID: <c04d2dec-5327-4ad6-88cf-a3cab983350f@linaro.org>
Date: Thu, 21 May 2026 19:39:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 15/22] target/mips: decode Octeon COP2 register
 selectors
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
 <20260521-mips-octeon-missing-insns-v2-v13-15-5a4cb8ec9cd3@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v13-15-5a4cb8ec9cd3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 5/21/26 11:06, James Hilliard wrote:
> +    CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
> +  ]
> +}

Missing CP2_Undef here...

> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index b0af2f4838..910a18d64b 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -13,6 +13,185 @@
>   /* Include the auto-generated decoder.  */
>   #include "decode-octeon.c.inc"
>   
> +#define OCTEON_CRYPTO_OFFSET(FIELD) \
> +    offsetof(CPUMIPSState, octeon_crypto.FIELD)
> +
> +#define CP2_MF_I64(NAME, FIELD) \
> +    TRANS(NAME, trans_octeon_cp2_mf_i64, OCTEON_CRYPTO_OFFSET(FIELD))
> +#define CP2_MF_S32(NAME, FIELD) \
> +    TRANS(NAME, trans_octeon_cp2_mf_s32, OCTEON_CRYPTO_OFFSET(FIELD))
> +#define CP2_MF_U16(NAME, FIELD) \
> +    TRANS(NAME, trans_octeon_cp2_mf_u16, OCTEON_CRYPTO_OFFSET(FIELD))
> +#define CP2_MF_U8(NAME, FIELD) \
> +    TRANS(NAME, trans_octeon_cp2_mf_u8, OCTEON_CRYPTO_OFFSET(FIELD))
> +#define CP2_MT_I64(NAME, FIELD) \
> +    TRANS(NAME, trans_octeon_cp2_mt_i64, OCTEON_CRYPTO_OFFSET(FIELD))
> +#define CP2_MT_U32(NAME, FIELD) \
> +    TRANS(NAME, trans_octeon_cp2_mt_u32, OCTEON_CRYPTO_OFFSET(FIELD))
> +#define CP2_MT_U16(NAME, FIELD) \
> +    TRANS(NAME, trans_octeon_cp2_mt_u16, OCTEON_CRYPTO_OFFSET(FIELD))
> +#define CP2_MT_U8_MASKED(NAME, FIELD, MASK) \
> +    TRANS(NAME, trans_octeon_cp2_mt_u8_masked, \
> +          OCTEON_CRYPTO_OFFSET(FIELD), MASK)
> +
> +static bool trans_CP2_Undef(DisasContext *ctx, arg_CP2_Undef *a)
> +{
> +    generate_exception_err(ctx, EXCP_CpU, 2);
> +    return true;
> +}

... but unused function present here.

> +static bool trans_octeon_cp2_mt_i64(DisasContext *ctx, arg_cp2 *a, int offset)
> +{
> +    TCGv_i64 value = tcg_temp_new_i64();
> +
> +    gen_load_gpr(value, a->rt);
> +    tcg_gen_st_i64(value, tcg_env, offset);
> +    return true;
> +}
...
> +static bool trans_octeon_cp2_mt_resinp(DisasContext *ctx, arg_cp2 *a,
> +                                       unsigned int index)
> +{
> +    TCGv_i64 value = tcg_temp_new_i64();
> +
> +    gen_load_gpr(value, a->rt);
> +    tcg_gen_st_i64(value, tcg_env,
> +                   OCTEON_CRYPTO_OFFSET(aes_resinp[index]));
> +    return true;
> +}

This is now just trans_octeon_cp2_mt_i64.

> +
> +CP2_MF_I64(CVM_MF_HSH_IV0, hsh_iv[0]);
> +CP2_MF_I64(CVM_MF_HSH_IV1, hsh_iv[1]);
> +CP2_MF_I64(CVM_MF_HSH_IV2, hsh_iv[2]);
> +CP2_MF_I64(CVM_MF_HSH_IV3, hsh_iv[3]);

Incorrect implementation.

     rt = HASHIV[0]<31:0> || HASHIV[1]<31:0>

etc.  I gave you a function using tcg_gen_concat32_i64 in a reply to one of the previous 
iterations.

You appear to be missing CVM_MF_HSH_DAT[0-6], which have the same implementation.

> +CP2_MT_I64(CVM_MT_HSH_DAT0, hsh_dat[0]);
> +CP2_MT_I64(CVM_MT_HSH_DAT1, hsh_dat[1]);
> +CP2_MT_I64(CVM_MT_HSH_DAT2, hsh_dat[2]);
> +CP2_MT_I64(CVM_MT_HSH_DAT3, hsh_dat[3]);
> +CP2_MT_I64(CVM_MT_HSH_DAT4, hsh_dat[4]);
> +CP2_MT_I64(CVM_MT_HSH_DAT5, hsh_dat[5]);
> +CP2_MT_I64(CVM_MT_HSH_DAT6, hsh_dat[6]);
> +CP2_MT_I64(CVM_MT_HSH_IV0, hsh_iv[0]);
> +CP2_MT_I64(CVM_MT_HSH_IV1, hsh_iv[1]);
> +CP2_MT_I64(CVM_MT_HSH_IV2, hsh_iv[2]);
> +CP2_MT_I64(CVM_MT_HSH_IV3, hsh_iv[3]);

Incorrect implemtation.

     HASHDAT[0]<31:0> || HASHDAT[1]<31:0> = rt

I have you a function for these as well.


r~

