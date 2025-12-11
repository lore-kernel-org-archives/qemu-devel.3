Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F30D41D4D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 14:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vThsZ-0001kY-Ud; Thu, 11 Dec 2025 09:42:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vThsY-0001j7-CW
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 09:42:50 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vThsW-0003KH-RX
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 09:42:50 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4537407477aso82575b6e.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 06:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765464167; x=1766068967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+cFAEzlgtQY1AT9B2kUty8FIRpyH2TO/dQMsHu7UMpM=;
 b=aBS2mLn9qGcBdIdoe23RcGiqEgLSD4cRorl2mlNr8ZRRGCfG9FScBHDqXtISa07BlZ
 Nahst9CRqigL4eL5xJrTjXh3fFIyIcA9EnqD3HyUD9ERJXaxbsXNVqORLaJU7YhZgnpP
 KvUppQohuphR7nRbfB2teUW+vdcd50gLwqfLdw1M74ftDSmaYrjECjQNRd7+4V3EVT6x
 lWKWMwG5INB7+q1smtEatkcVDwpv9H8wge4SZzZyOqmNrUbH919IdRlf9BYLoIfq1zwN
 y92aVtw0OnOMp1RRl614LQjTwKXaVg3n+p9G3wHc4smzy/Jn6FVj1qHaGYeGVOmA2k1z
 zweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765464167; x=1766068967;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+cFAEzlgtQY1AT9B2kUty8FIRpyH2TO/dQMsHu7UMpM=;
 b=t3qCRHLfxoNFhiq4nqJCfYgIOdqR+CrpZ0AMD7k5vbeGGds7/izhG/d9gWjiPdxq0W
 As7w/vXVO4t7vwkzAlUOA2exiC/SJf8SjP74HEOmSOf1SrnLpzqhC+U0vAFoDl6JroLE
 py8KWuWISambq2L1+7h/7WyS04clJf8TNLx0wLF4ZLF8bXtEYHOFfPv2dOyN+42KhNZi
 wLuYh12Yw6htn+VhTQn17rbZ49s9iR7lnOjpdhWCjaibzXZItaM8kDg5W+lnPuPYfKrL
 yAlG/K+2dmfq7SuC7x0ye12cA8Sp30MkwkVReggylp/M/+Elv6/2MMfiWloi021xbJBK
 a5Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVtH3hZgvENccpxR6N9gu+VMtaS24MREkmonIkvMEt2IrDoHk87Gsk5akA2uRkKXuuK6UH4t40SwK2@nongnu.org
X-Gm-Message-State: AOJu0YyoMpUyekJu4i+9I8MShuBt8PIYGL7ZBPw9JxFhiwE2XXZxBXDo
 aODkfAipGPayuixr19vCcb7F0M5LhUqnsjtsqIifb+0iLftR/m6KVDJAH78VWBvuHbQ=
X-Gm-Gg: AY/fxX4J/TmSAV0nKmrPWc6EgkqdR0z+vsGaLyNdu5t9F6QdgxKyWW+4SDiM2ty4FCW
 s6Bi227Cqa862uEe5c6OSnKQJk2jhk0LoYOeDp5UqvCxhb1ltMkNuXissR4ADk6j9R9lg3pnrrE
 ruu4aV3aYz9sD5RNVZ1ulxVy8SbYm0ZM6bYucNYjSLg3ZLppklF13uZGMxP8oEsKdoN2DvvWRAD
 h5bxt3BEXkoFra3MtGahBXukRQEo0b1hbgehbJM6Xi3xVFrBr+zjkEuOzarZYX+h8E39AjCRr5Y
 NfjsCsI5RRu/nzKqikX+j2h24umWLCKC2q9s7c15xG/9BVwDEyyTFYchP3OOPX4xct6H1s7OUxU
 5sGuq8X6+eROk8vngcjL5DEwsa0PbOex7wkK1Wn7H3CKcUCtjEtLPeglqYmoK0TNa83kOc4NuUo
 qhi12Rw+f4ZSLBcdNlvHhvNYUoBmeNF7ai6P3s6v6qqr2pL6p0dKyo+7NSSpOyXP6O
X-Google-Smtp-Source: AGHT+IGDmEBAG9H0mSdHNDJhM9cOfGyeeWuM011Jzbn02SStQNzbhUbRMYWYrRhiYqM8Fg1yy9CggA==
X-Received: by 2002:a05:6808:130f:b0:453:7404:90bf with SMTP id
 5614622812f47-455863867a4mr3352472b6e.14.1765464167380; 
 Thu, 11 Dec 2025 06:42:47 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d4e70030sm1809287fac.6.2025.12.11.06.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 06:42:47 -0800 (PST)
Message-ID: <33f7f11a-94be-4e49-835f-d414e5903a09@linaro.org>
Date: Thu, 11 Dec 2025 08:42:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] target/arm/tcg/cpu64.c: Enable ASID2 for cpu_max
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>
References: <20251210-jmac-asid2-v6-0-d3b3acab98c7@linaro.org>
 <20251210-jmac-asid2-v6-3-d3b3acab98c7@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210-jmac-asid2-v6-3-d3b3acab98c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

On 12/10/25 08:50, Jim MacArthur wrote:
> docs/system/arm/emulation.rst: Add ASID2
> 
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   target/arm/tcg/cpu64.c        | 4 ++++
>   2 files changed, 5 insertions(+)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 31a5878a8f..3f30ea5a30 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -24,6 +24,7 @@ the following architecture extensions:
>   - FEAT_AIE (Memory Attribute Index Enhancement)
>   - FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)
>   - FEAT_ASID16 (16 bit ASID)
> +- FEAT_ASID2 (Concurrent use of two ASIDs)
>   - FEAT_ATS1A (Address Translation operations that ignore stage 1 permissions)
>   - FEAT_BBM at level 2 (Translation table break-before-make levels)
>   - FEAT_BF16 (AArch64 BFloat16 instructions)
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 6871956382..ef4c0c8d73 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1334,6 +1334,10 @@ void aarch64_max_tcg_initfn(Object *obj)
>       t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* FEAT_AIE */
>       SET_IDREG(isar, ID_AA64MMFR3, t);
>   
> +    t = GET_IDREG(isar, ID_AA64MMFR4);
> +    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* FEAT_ASID2 */
> +    SET_IDREG(isar, ID_AA64MMFR4, t);
> +
>       t = GET_IDREG(isar, ID_AA64ZFR0);
>       t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
>       t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
> 


