Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E616CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTsQ-0005HU-4g; Tue, 16 Jun 2026 09:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTsO-0005Gw-Bg
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:30:48 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTsK-0006xh-Cu
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:30:48 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-66077c46c5cso4283595d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 06:30:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781616642; cv=none;
 d=google.com; s=arc-20240605;
 b=clM17vbFVr2sdmPYpidzVvHMM8MGwQnW7worf22jUf0WKQkRFcjVANOgHKhRrjelaM
 BA39jfBvOc6rLIaRYOH4gODxHuAYXrfpmsGFS2kSzCH3OnZrjL74vvHRSTzJ/S1KeHLR
 qKGyupHV840WYaXAhiqlLNjP2u4XTEwmtCFBuj+7xSI6jIx5gOq2ginVjP6piaf3pVaB
 cq+gReuhD2tGK42y2BaNgaGzbd/DJNVNa7G6YFD/1POhrIoiXU6gRjl51z1CcaMKHBEV
 V13B5QMxnU8cqZx440Bh/Yopac/TeOD99APdVQ1qh6Uh/Ul/V9cPJ6gIVesIZT5lqYmK
 OuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qz1ZuqyKE8PXmEpkiulGq3MVnyojO7yVlpbsYHHg/Xg=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=EdOB0wH0cEI6tY1N36npt4ATyAzH/aAFYbotFnXb8L5uzIeKw2XOT9F7QMyvvA7rFw
 YqcEyEoKDls+iGllineB5RNmH3UR4AoNMT8KBA8UjxdJu/YXfM4pYvKBka7BMweVl0vU
 PyrUV5o0qjaLMzAw1TNV+R94OkaaECXoua6K/xAU2rySzmk2SG20VE5JoiNB5E3i5tPE
 hIq6SiCxKlgoF9CrpEYSu7Wj80jH/kNlT/YKRS5V+rD4b4TokcdXVrgp+s80zF/6MVEL
 hFJDwMD02qHXu7uhGOtPu7ZTykQHmWJRY/CPt3IR+k/kOW+tw1/qz/byuyUVPoI5a4in
 htOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781616642; x=1782221442; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qz1ZuqyKE8PXmEpkiulGq3MVnyojO7yVlpbsYHHg/Xg=;
 b=jZ1zLEWfvduTlfku/VL5YjCzKzBt6ysVNKu10Ghdo9PvqZnL5KxWZygu5J+Dq0U8Y3
 URXz8g5z7DBlxUjVbaY7qHVe6KmQ6vlvPLn7cXLePmgf2qJEYr4HNuNwUMAHmFak0DKN
 PHB4BFgVcxwGeXxFNG9aBlP3IOH/OsKxlQT6grTMTFKWVQGjh+pKYDubkOztgQpFKh3W
 C09ILdcpXSl/BPwQGVAtwvF+KkIUGSq9ZWQk61cw2IcVQ852qVac32c7qAkwjR/M+xsM
 lUmzYgLH6kfg3JMbhn/CC3pwJWlpAKtd7LwsORFkb+d/SfF2FyOu0lalkxffsIGSrjAA
 eFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781616642; x=1782221442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qz1ZuqyKE8PXmEpkiulGq3MVnyojO7yVlpbsYHHg/Xg=;
 b=dGTB6KWz2S5BUrG6m8fIW9ywIxlcYwynvYh2FI3lqHAT8ZcuITGRSWWkgSAeUZBMBr
 Ljx6ZKxng1YarvcEqLVAnYV0eyz2QuoEFR289knQj3/+5Pa33EaVhaNgd4V7Ts9C+GC3
 CnY4YsIrEf4OmuIfz61rwwxCVMKOGxTeunlwI3uTpE0jQs0X9lMOz8YWShIJQgwOiAQr
 Sc17P3laGUltZEMMk2MwGGy6WBPOnR21mhj3r+IB63rfnECpCwyczTuWJWE+zfTZ2YXv
 9cWn57zI+yUfm9Ts0/V5BlHOFLg5kOvqUZEBcBoM3eneJH3cSJANftt3HMxLBYAqkcit
 sjTg==
X-Gm-Message-State: AOJu0Ywt/WrJeywe3rZ0UCJqqYFW26gJfTkCL77AbIUMdy5OssvOlgt/
 KHKxdpCL8l77mLhJvMHsRw7J1BUujqcBxnjUBTFDywkZo+i6sKcHMUPa044cTvion+wJYblZdE+
 ieH3g9EFpoUIyjoXtjw7Vj2vjUBhEc38IyxE9xTzwJA==
X-Gm-Gg: AfdE7ckxTBRVrLWhSoJkibyAKxQI3uui5QjFMg9nWS76Bh5kyFxgoSvgcbVt/NSMGJD
 e7/Hye0aExPMZbwD8jHt5Qp8Fj2IAQ3O6cVTqXjw29GAImlQa/uIzdv38MJ33uD7f4Q32w/dwKy
 gRahnrfaUWypY6HI5z7Z/7goyF5a09ajPO8q0Azu3blaJ2+lWtCLFBXI/JeOJJ/GO9ptoMPcWQ7
 3ducu0PIxyRqjtgy4zfy9O2ya7QiKdBLai0FkjlXI4aXJw2YgSeMmIg5b8zGRD2Un7UI7uTCVtm
 eWB5kjFbUSTU7vhlh5EVwuOmBSML3z2/F3DfAEhleoPrBWoW/nFYdSxknBjV/D3DanU=
X-Received: by 2002:a05:690e:480e:b0:65e:3bde:7c14 with SMTP id
 956f58d0204a3-662b61044fcmr2052623d50.32.1781616641771; Tue, 16 Jun 2026
 06:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-20-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 14:30:30 +0100
X-Gm-Features: AVVi8Cc9__pY-Qm1tkeszQLXhLY7zzPybpXaHOFXukWgQmW8U_XiQ8qdnFhjANI
Message-ID: <CAFEAcA9JWsJPLx=rH2OiuDMP4f46H5PSzzOBrQaVq=URonSfRQ@mail.gmail.com>
Subject: Re: [PATCH 19/25] target/arm: Implement EXPAND
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 5 Jun 2026 at 00:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve-defs.h |  5 +++++
>  target/arm/tcg/sve_helper.c      | 28 ++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sve.c   |  7 +++++++
>  target/arm/tcg/sve.decode        |  2 ++
>  4 files changed, 42 insertions(+)
>
> diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
> index de2254bb19..75c0fc919d 100644
> --- a/target/arm/tcg/helper-sve-defs.h
> +++ b/target/arm/tcg/helper-sve-defs.h
> @@ -3203,3 +3203,8 @@ DEF_HELPER_FLAGS_6(sve2_famin_s, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, ptr, fpst, i32)
>  DEF_HELPER_FLAGS_6(sve2_famin_d, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, ptr, fpst, i32)
> +
> +DEF_HELPER_FLAGS_4(sve2p2_expand_b, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(sve2p2_expand_h, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(sve2p2_expand_s, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(sve2p2_expand_d, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
> diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
> index c2b3162084..a13ccf4b85 100644
> --- a/target/arm/tcg/sve_helper.c
> +++ b/target/arm/tcg/sve_helper.c
> @@ -8669,3 +8669,31 @@ void HELPER(pext)(void *vd, uint32_t png, uint32_t desc)
>          do_whilel(vd, mask, MIN(b_count, vl), vl);
>      }
>  }
> +
> +#define DO_EXPAND(NAME, TYPE, H)                                      \
> +void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)        \
> +{                                                                     \
> +    intptr_t oprsz = simd_oprsz(desc);                                \
> +    ARMVectorReg tn = *(ARMVectorReg *)vn;                            \
> +    intptr_t i = 0, j = 0;                                            \
> +    do {                                                              \
> +        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));               \
> +        do {                                                          \
> +            TYPE nn = 0;                                              \
> +            if (pg & 1) {                                             \
> +                nn = *(TYPE *)((void *)&tn + H(j));                   \
> +                j += sizeof(TYPE);                                    \
> +            }                                                         \
> +            *(TYPE *)(vd + H(i)) = nn;                                \
> +            i += sizeof(TYPE);                                        \
> +            pg >>= sizeof(TYPE);                                      \
> +        } while (i & 15);                                             \
> +    } while (i < oprsz);                                              \

It looks like in the other macros where we iterate like this
(eg DO_ZPZZ, DO_ZPZ) we write the outer loop as
   for (i = 0; i < opr_sz; ) {
     ...
   }

rather than as a do while(). Is there a reason I'm missing why
we need the do-while here ?

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

