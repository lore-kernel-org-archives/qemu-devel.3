Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB43E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwSV-0006Hx-MG; Wed, 18 Dec 2024 10:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNwSP-0006Ea-Sx
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:59:29 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNwSO-0007t7-6U
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:59:29 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-30229d5b229so64021571fa.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734537565; x=1735142365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nn9xLwkBXbuaQt1swaArTezbwGajJ0lSyhLeifG5VNk=;
 b=vgM2E58k/Hk964rwEee0gv26+U+h8jhqsQp5QJYJ9JF0spLS9euJX7ti+bsZLynwLi
 +KNc+F1+VE0G/03Xse30emOImBliYGvRR4EV1P06ehm7n5MYxPuUAjjN1/S9l4ooX3JV
 xxjgyjUj7Ytc49B9dMaR1gI/VovKTdAlsAQAqVGOA+jGbr9AIG3G8bqWGMFH2gr61IMS
 uIQ3LaWZ1Kf2BgDcgtleVCJhE+uDtuwYtG859XfhU2CDLmLH/aK6MNG5PN5airnjMjg/
 fqLXjLG9/E9rkYL45aUcQP1jWaUOF+jnl1I1AL/ZfDMmkwHVbxD00zhjDufx8R1Df3yg
 MBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537565; x=1735142365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nn9xLwkBXbuaQt1swaArTezbwGajJ0lSyhLeifG5VNk=;
 b=hFwlITkeYi4OMYL9/I1nBtTZjdnpC/dH8amX1eAA9lq+zFvdSDHgYO2Dv9Mzh86/f2
 Xsw3tCK/loFpTRS5PMlTXm7B0n341IhyhQ+L93hMvLRTLmcL2lxTM1Ko9Ms3g95ZP1Ow
 ecDq25Lrx+tVWBmUS98bjCEjmwyvpTvgMHRgiZbAn07ebSZID+XbMKe0+3KS9n9PNR81
 8FxBWv7A9c8cjS8/qDhHz7cHlpcNDie2BxyDd5RVM+klqan0LvorfEzVWdPK4CC2RE1I
 6CZlRS++Kqrsjytm0sry2MPN7awPRGMsYdjZyLiFJwpRivqBV05G2jU6rRz0TZSaS38/
 k7mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN3Shk/2VF8y+cL/ON2lhEhQx99TYdGeX/Hdh/1Skq4RdTE7OzgXX1l+0tdGMhp2Exd1YXpzpgz1CA@nongnu.org
X-Gm-Message-State: AOJu0YyTV97AQ8nw36InEzNa1F39I4NAYlHUnuNpATHdEqXtE1LypmI0
 0SQTLKzqu2yUdkCWKpuMJNJIdeNCbzgzrmtluHPaO0QPRR0BWrh2JyEeupi+eC4=
X-Gm-Gg: ASbGncumnbBmGJDrfuFPPh6Zv5s73q34TQ+gkVWOI2IADYNh54Af4JpZcFODWNZNhWc
 winlb2tP9dNFKFBloVmevVd27JvejeT9KGJ5ZV/6Z1e58IDVsRsuo8Fk00mtOW1VO3VXvqmNtXN
 rT0RjSA4TJ2dAf5mohMLnSKw/97hRsRKqKFWDUicji7/Wg6cnm4B67iuiPD2yU5JW4jrJX1pKjD
 B6wzrJGH5BNpzZSr5/hr4pay02zvPkTeilF8/8L9AUR9idBTP6oV/1sljlBHs0bWQNuQwjKRh8=
X-Google-Smtp-Source: AGHT+IGT1dXEnbv7TC30iVxCwcr3Oqm7XF1WK7MD/Qwz45gXj70+llIqIxqsBDXM6l+n24ZU5Kii+A==
X-Received: by 2002:a2e:b8d2:0:b0:300:15f1:cd5c with SMTP id
 38308e7fff4ca-3044daebbc0mr13035721fa.17.1734537564821; 
 Wed, 18 Dec 2024 07:59:24 -0800 (PST)
Received: from [192.168.242.227] ([91.209.212.65])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30344045342sm16601281fa.33.2024.12.18.07.59.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 07:59:24 -0800 (PST)
Message-ID: <2972bfcb-67dc-4bec-989c-1e7449096ea5@linaro.org>
Date: Wed, 18 Dec 2024 09:59:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] target/riscv: rvv: Use wider accesses for unit
 stride load/store
To: Craig Blackmore <craig.blackmore@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Paolo Savini <paolo.savini@embecosm.com>
References: <20241218142937.1028602-1-craig.blackmore@embecosm.com>
 <20241218142937.1028602-2-craig.blackmore@embecosm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241218142937.1028602-2-craig.blackmore@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x236.google.com
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

On 12/18/24 08:29, Craig Blackmore wrote:
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -31,6 +31,12 @@
>   #include "vector_internals.h"
>   #include <math.h>
>   
> +#if CONFIG_TCG && !HOST_BIG_ENDIAN
> +#include "trace.h"
> +#include "../accel/tcg/internal-common.h"
> +#include "../accel/tcg/ldst_atomicity.c.inc"
> +#endif

No, you cannot include random bits of accel/tcg/ into target/ code.


> +#define GEN_VEXT_LDST_ATOMIC_HOST(SIZE, TYPE, MEMOP)                         \
> +static inline QEMU_ALWAYS_INLINE void                                        \
> +vext_ldst_atom_##SIZE##_host(CPURISCVState *env, void *vd,                   \
> +                             uint32_t byte_offset, void *host, bool is_load, \
> +                             uintptr_t ra)                                   \
> +{                                                                            \
> +    TYPE *vd_ptr = (TYPE *) (vd + byte_offset);                              \
> +    if (is_load) {                                                           \
> +        *vd_ptr = load_atom_##SIZE(env_cpu(env), ra, host, MEMOP);           \
> +    } else {                                                                 \
> +        store_atom_##SIZE(env_cpu(env), ra, host, MEMOP, *vd_ptr);           \
> +    }                                                                        \
> +}                                                                            \
> +
> +GEN_VEXT_LDST_ATOMIC_HOST(2, uint16_t, MO_16)
> +GEN_VEXT_LDST_ATOMIC_HOST(4, uint32_t, MO_32)
> +GEN_VEXT_LDST_ATOMIC_HOST(8, uint64_t, MO_64)
> +GEN_VEXT_LDST_ATOMIC_HOST(16, Int128, MO_128)
> +#endif

I was suggesting use of "qemu/atomic.h", which would just be

     *vd_ptr = qatomic_read_nocheck(ptr);
else
     qatomic_set_nocheck(ptr, *vd_ptr);

for types up til uint32_t.

Add an ifdef for CONFIG_ATOMIC64 and you can use uint64_t.

Get that working before tackling Int128.


r~

