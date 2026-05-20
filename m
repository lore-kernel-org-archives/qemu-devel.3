Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FDFCD4F5B
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 00:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPV1U-0007ZA-1T; Tue, 19 May 2026 20:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPV1R-0007Yv-9N
 for qemu-devel@nongnu.org; Tue, 19 May 2026 20:42:53 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPV1O-0002Nv-Ps
 for qemu-devel@nongnu.org; Tue, 19 May 2026 20:42:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2bab2548e8bso18340525ad.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 17:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779237769; x=1779842569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T/j53/MVB1mzdEk1xNBiMgsEwgn7Vwru/QGCC72hCJ8=;
 b=cn7HRWPOBHBNau96hDhvQ2mvUrUioe4b2KHT6QYjm5NLqeS7rCqS8rqf6uaaxr6uKK
 5QFLOtnulYd5e6hzSPSTxxuih6aob9R2VHChn5bAHR352G/K6eRbtGDEPbPtrXS0DCwY
 xwVrXTKwgOEUvGj3HPQrgYGxaQeECMPWaSkCxKJBRjhf04pYfAxRGyCUHpVuuhJv7xzG
 bNwAAVCd+3lijpmQw9lQm38e+QyABZdV5KHwLow0b5wYTzG32kSg1RHT6bgMa+MwEkHH
 TVL4nPFMEr53fzx7An4qofuKO9t05Ja2g2hu6QgBJNd8MfmEuKXQLNnrgx58RgZcTdmk
 nedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779237769; x=1779842569;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T/j53/MVB1mzdEk1xNBiMgsEwgn7Vwru/QGCC72hCJ8=;
 b=b6Rvd7ob0Bl9Q08SHcm4DuEhDl1ocal56QgtW/xFJ8ZCOUhJFrUfhwNIm5MmIAfgvn
 lbiEcIVU9vF5EU+w8GAJ3wJw4QZRg/15JeR0jJ6QH4XAyY60Ee2f+nSTEknVxIJ8tB9/
 0R6YXFravM07vpMLx3J8Dtci+mCMqjqGjPIFLIcm3ToddTTTNIk98ff/m3frFHMioMLN
 WwlwIYXoVkc13c2j3CLynhYhAlfQj0z8XfAcKCwtXxQE6+DTRGZ7MVd4eaJmv8iOSQ76
 +SyuhOBEuRyflYAtyS7hQBDUkGLRbl3suAJDIPpERZQTRlO8N0jeupaAkZl3CyQbW7j9
 4xhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JOO0U62s2aG6HRuUryiZhtgMkii2Oqba6HoF9EhYZBJ0b4+Q8o11DSy6x49VvBvMhAmd7PW/PN7ou@nongnu.org
X-Gm-Message-State: AOJu0YzxV3reCt1PT200DTzqXDvi+isPROowbEmWlC9SiYMcvY2GaJfz
 RVTUuqvuibc7dJmdPpEBaUka+bd+dHGqs5HQPCNvd50eBQcQoQyMGXNKWGqOxZ9aUbI=
X-Gm-Gg: Acq92OH0azmwWgHOmclppB8m1LYZ7agCu8Dqy8XuWLlXBJ/NP0TdtcLUoApu7W3LRmF
 LBqBgGyryV++2fhlmbwqdsC00lVO8NUpHHJe3Ve6hOHmtbWGTHh+Z3RFJ+6v0mTvLjA03LH+jxm
 cy4ui8iM52QqUreg+n5+2ZZJHUWntJvshLumoqhmzZUzTgVYGz0V16VEn/n6OSCAXU0fEJeu0Yu
 mgTVf1acY4sRo+IW6NHM1CGVBrtRu2lVKAbX5ASbZAFy/qpP834fQOV3/bpfpb5L2yrOIRQJCFN
 hcsTyS9bqmy9X4S2mEOhr9w1RxZVr96yUkwoHQ2654CB96s4B+VdDv393pW7hOfg6FCEoRS4CYz
 NEDuYNY9qD0cjntQGY4gVF2TItjOf9Z2q4/Unymc1hxurh/XIkQXk4QfsFDQ/UmaM/ZV02MpkwA
 TRNpawb6/KS1iprCEun/opF7WCh8LNvnN/Y9ZH3QZLdlnYPOQ=
X-Received: by 2002:a17:903:17cd:b0:2bd:8938:b811 with SMTP id
 d9443c01a7336-2bd8938b845mr221445365ad.34.1779237768579; 
 Tue, 19 May 2026 17:42:48 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe49a4sm183475855ad.38.2026.05.19.17.42.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 17:42:48 -0700 (PDT)
Message-ID: <2ab54212-9ce3-4740-a85c-8c930c1baead@linaro.org>
Date: Tue, 19 May 2026 17:42:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 27/40] target/mips: add Octeon GFM COP2 helpers
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-27-d7dd735ecddd@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-27-d7dd735ecddd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 5/19/26 09:22, James Hilliard wrote:
> --- a/target/mips/tcg/octeon_crypto.c
> +++ b/target/mips/tcg/octeon_crypto.c
> @@ -94,10 +94,108 @@ static void octeon_crc_update_reflect(MIPSOcteonCryptoState *crypto,
>   
>       octeon_crc_set_state_reflect(crypto, crc);
>   }
> +static uint64_t octeon_gfm_reduce64(Int128 product, uint8_t poly)

Missing newline.

> +static void octeon_gfm_mul64_uia2(const uint64_t x[2], const uint64_t y[2],
> +                                  uint8_t poly, uint64_t out[2])
> +{
> +    uint64_t vx = revbit64(x[1]);
> +    uint64_t vy = revbit64(y[0]);
> +    Int128 product = clmul_64(vx, vy);
> +    uint64_t res = octeon_gfm_reduce64(product, revbit32(poly) >> 24);
> +
> +    out[0] = 0;
> +    out[1] = revbit64(res);
> +}
> +
> +static void octeon_gfm_mul_reflect(MIPSOcteonCryptoState *crypto, uint64_t data)
> +{
> +    uint64_t in[2] = {
> +        crypto->gfm_reflect_resinp[0] ^ crypto->gfm_reflect_xor0,
> +        crypto->gfm_reflect_resinp[1] ^ data,
> +    };
> +
> +    octeon_gfm_mul64_uia2(in, crypto->gfm_reflect_mul,
> +                          crypto->gfm_poly, crypto->gfm_reflect_resinp);
> +    crypto->gfm_reflect_xor0 = 0;
> +}

This seems to be wrong.  At least I don't see how it matches the pseudocode.  Certainly 
helper_octeon_cp2_mt_gfm_xormul1_reflect should not just handle 64 bits like this.

> +static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
> +                           uint16_t poly, uint64_t out[2])
> +{
> +    uint64_t zh = 0, zl = 0;
> +    uint64_t vh = y[0], vl = y[1];
> +    uint64_t rh = (uint64_t)poly << 48;
> +    int i;
> +
> +    for (i = 0; i < 128; i++) {
> +        bool bit;
> +        bool lsb;
> +
> +        if (i < 64) {
> +            bit = (x[0] >> (63 - i)) & 1;
> +        } else {
> +            bit = (x[1] >> (127 - i)) & 1;
> +        }
> +        if (bit) {
> +            zh ^= vh;
> +            zl ^= vl;
> +        }
> +
> +        lsb = vl & 1;
> +        vl = (vh << 63) | (vl >> 1);
> +        vh >>= 1;
> +        if (lsb) {
> +            vh ^= rh;
> +        }
> +    }
> +
> +    out[0] = zh;
> +    out[1] = zl;
> +}

Some comments would be good here, especially since this doesn't match the pseudocode.

There are lots of doubleword_bit_reflect in the pseudocode, which you appear to be 
avoiding by reversing the direction of the shift.  You appear to be swapping the read and 
writeback of hi/lo to account for the individual and separate doubleword_bit_reflect wrt 
the 128-bit quantity.

Your treatment of the polynomial appears to be wrong.  The pseudocode places 8 bits in 
POLY[0] and 8 bits in POLY[1], whereas you're placing 16 polynomial bits in POLY[0].

I think you're overthinking the function parameters.  You might as well directly access 
env->crypto.gfm_*.

> +void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
> +{
> +    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
> +    uint64_t in[2] = {
> +        crypto->gfm_resinp[0] ^ crypto->gfm_xor0,
> +        crypto->gfm_resinp[1] ^ value,
> +    };
> +
> +    if (crypto->gfm_poly <= 0xff && crypto->gfm_mul[1] == 0 && in[0] == 0) {
> +        octeon_gfm_mul64_uia2(in, crypto->gfm_mul,
> +                              crypto->gfm_poly, crypto->gfm_resinp);

The uia2 path is definitely non-obvious.

I don't see how you can use clmul_64 and include the polynomial.  If there were to be a 
clmul path, I would expect GFMPOLY == 0, so that V does not vary other than by shifting 
around the GFMMULT loop.

Either way, perhaps this is premature optimization.


r~

