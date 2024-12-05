Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E21DE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 00:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIzVb-0001VJ-N6; Wed, 04 Dec 2024 19:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIzVZ-0001V3-Vl
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 19:14:18 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIzVY-0005eB-DL
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 19:14:17 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-29666708da7so269567fac.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 16:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733357655; x=1733962455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kfMx5DgDDJWI8t9WNnp/HlXLeavZB5n2cWqShvyjn64=;
 b=nyl4ETDpt1dRt68mNFiqC9IyDXlRdACbpwbY6jgeSlG6MiOAbS5aPRdudRL9pmNyna
 4Vg9xGXAwTQ9Pe7yJtuKkayAj7o1oGZUOA9RqnS2co2kNW6ZmyDNmvXmd8ZXfPUrGi2m
 KxgqTGVrl1phvac4KivcmeC5gwtpDmkiAb8Xdnvq8WQjTAAA8S0uAi3ir+0Ut/Wl2f8n
 JLvkLiXla1u4Vr2pHZAcifc7I2L3Yqm5rAc+EHLEs7wfEqThEzoINIge9tV1Jah4aE8x
 Ciu/JPZL8h+oJof+1AmLZISY0/QVtzwUVgsdqnN3cnJBkMEXvNn88/Eh0PCNL9Crek7H
 8XxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733357655; x=1733962455;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kfMx5DgDDJWI8t9WNnp/HlXLeavZB5n2cWqShvyjn64=;
 b=q2yKf45tFampcjuB72qNHMTSIVF6bw92lu3CIVDac+vCc3J6XOId/3VVJKDrfcAYkp
 tdUD03CZXm2ELKkeHG/BquPOT2x8LOBCU1/Wg60akLXNW/23bhqZ5AEkShPjqufaoKql
 GCmbrgIg20XFElbYT2GJIswRfYx2JuLiLZcMQOailETKCwxX97k/YqFYU+dTH5CJ4vgR
 AB3gky0DvhV4F3IyVG+v3LiflbWKC/fLpjKQUSfzcN7AlB3ttn9Kr/3I2OpNHqrpILCL
 6OvEZBQ2rP8p4uj1F3upq7Uf7TYzAWM4c6w1i6CCTz4SJeic79A2/PHneLv8YKlyz4m1
 y64Q==
X-Gm-Message-State: AOJu0YwjV0lxsR7HfVQxvwJZOoLAcDCwxD39zSsuaAnntCftsW0a+Ggi
 8NbqjRhdcf4Q+4xNmzrWbyNLPHZ/zBMdcBpAhHlb9Gz2LqXaApfRlHExl90gRyi2Q3E01QNR0Av
 WocDbOA==
X-Gm-Gg: ASbGncuZHngbZ1DNXSZMyue7JFD7E1M1WiEA1bXPAXq3t7V8EuW64QChI6PGduC7rvR
 XMW9NBiFZRvGs6Nwjl6QCiE4lujUGP0DmXO2JcHwDUcNN++pC2UFXJSPv6AFVwCzFlfxqoHutAW
 LmWE9Kb6fI1bYn9tAPDnLKj+JCCAeQKwGvNdUKURYII6nDNeMJ+Kne0ex2A3IiGbDfU19llZ3Vx
 lTFLVFOY6tM2XfSvi7NnuL6QobmoqyBwm4YAtliwyoctn5QdyjBqUMgIc2XvPQCAcLfTQgfwZET
 4DI5GyyJojahFHLn6+iT2i+pjz0K
X-Google-Smtp-Source: AGHT+IGP8/TUJF1ml2pLuG3U4uID4M9O7jLGbnqiqNXc7hHIGM1F4cbLYgfAwi4yjLdJi7LMJdrLUA==
X-Received: by 2002:a05:6870:2188:b0:29d:c999:b90c with SMTP id
 586e51a60fabf-29e9b08c113mr3898791fac.1.1733357654787; 
 Wed, 04 Dec 2024 16:14:14 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f56666e51sm90905fac.1.2024.12.04.16.14.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 16:14:14 -0800 (PST)
Message-ID: <f20fd85b-95b2-4c7c-95d7-53967f415a41@linaro.org>
Date: Wed, 4 Dec 2024 18:14:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: Use memcpy() in memcpy32()
To: qemu-devel@nongnu.org
References: <20241204204151.61221-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241204204151.61221-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

On 12/4/24 14:41, Philippe Mathieu-Daudé wrote:
> Rather than manually copying each register, use
> the libc memcpy(), which is well optimized.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Worth renaming as reg8cpy()?
> ---
>   target/sparc/win_helper.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
> index b53fc9ce940..dab0ff00ccc 100644
> --- a/target/sparc/win_helper.c
> +++ b/target/sparc/win_helper.c
> @@ -26,14 +26,7 @@
>   
>   static inline void memcpy32(target_ulong *dst, const target_ulong *src)
>   {
> -    dst[0] = src[0];
> -    dst[1] = src[1];
> -    dst[2] = src[2];
> -    dst[3] = src[3];
> -    dst[4] = src[4];
> -    dst[5] = src[5];
> -    dst[6] = src[6];
> -    dst[7] = src[7];
> +    memcpy(dst, src, 8 * sizeof(target_ulong));
>   }
>   
>   void cpu_set_cwp(CPUSPARCState *env, int new_cwp)

Once upon a time, calling the libc function was slower.
That optimization is probably at least 10 years out of date.
I imagine this gets expanded inline as a vector copy these days.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'll agree with Pierrick that we can probably remove the function too.


r~

