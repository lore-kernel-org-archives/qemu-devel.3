Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2C4CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBe4j-0001bC-HW; Wed, 22 Oct 2025 15:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBe4h-0001a8-82
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:00:43 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBe4f-000658-1l
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:00:42 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-475c696ab72so6557335e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761159639; x=1761764439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2IfWHImcaqyKSRvjEy3I4vyXN8NDG7NL01bd1QTvyuI=;
 b=iORlB/jcl6ti7/slU9+ykx5xj0/+TKdQQtKDmSmHqUScV/3ZnI/phEKFWcHyrk8dge
 y0nmLdaDbMYneX2E+a8oObmzpooCPMW3D/0NSNMmjta9oVzUEfuqimOwZf5FLr/cl1Yd
 fIP1JebAOfakhyUvsKJH0OQu4lTkGSuk/oEHgMve7dpKEi9aa/Q7rpKiEjQzkCoMipz+
 8XKsJOLGTcxbHU+5IcVLnfsBxzcrSFHwvOI2RfoMmVB4+VocNhh1VGkKPg+08fYUGSsq
 aN1wvPaa6E7JCAHp/YAbda2q9LYGJqa+BAc1ZWJGdjwpJ+ULzpqoAcgW+/iX/u9NRVLu
 jzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761159639; x=1761764439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2IfWHImcaqyKSRvjEy3I4vyXN8NDG7NL01bd1QTvyuI=;
 b=satHjiTpM75IKh30Ktkzu5bGLJmBWgwZI4s78dIB3fvAs2pYV/qSBDQFLx8wKJwi2z
 eSiABr1/Z+H5Z9Kkrv/mrNf4ZjgJVwUZ77RkK2KXd+dqgREs3DmvrmmOUZgXZT9xo53i
 fS+ZYwZl0Jx87S3gS+VYsJrsSIGdDRiR18YGwZGjPLFPJOUsuAV3RNOity463FeWdhT2
 uWYQEAtghlPlNTE/QJOAe9GbXX4X3IkyEwByUo+9fEvHu8NEz/ETmSEFovlIxCjrQvMk
 SgovpVubYQOv3M/djJwdDplzL/eVJ0U2MBVrGp9DgA3LeeEma/hZmRtfHIq+KYaGvJeW
 6gZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgypYIG2gobtjeRtAIe9jp/L0pg3YRt57rbXKDzsJOx/gqtQfLSE/d+OYC7JvgkH2tR681f+ADTeN6@nongnu.org
X-Gm-Message-State: AOJu0YwMJkv0vQdfbmbeIQ7cO9feXWuXF9ez7YY57arqeDECVBnBlhXB
 SL3dgHSSe6vHJN0IUxigQ6tT2RIuZ/+Qf+QWIvDoXGQDGdOo2MQ0DQhegLkHd6UxsSE=
X-Gm-Gg: ASbGncuHQgzkoF9ziMc29x7n254VF788HhFYVSEr5cgTAwJf/ml9/dP0YZUQPVoPxe8
 pKOhaRbAgRA1ddpyHGca8YkVGKcA09aJea+S3EfHzjgsWW16EzAvUCkUQWD9FWmITNsRM1mQhMo
 DJ494q+1gWQX004r8zvJUrUwEPLDVL0zhG8hDueesKm0Gn4QSnQeFrzPOwBzW4E7iFkTCT8Jtkk
 MvmDswpuAA535jVBZDmHWAkZ6r2pepHtbxM4kzPAlZx91UiwtTKgMIU8U8wD1O7YYSFz54/euYA
 +R3BqATeav1Ew+wHnd4e+IvtBjYzhZAxgXVEOXb6uwEEgXcBCnv0KOaFEZivM6eTlzxIA1tQvFY
 hZYmBA22TFyLi6AeNSBt1kBdmKCUP/zi2QR2ysmKzyI7eEd3T6UbUtOVMiLo6V065UM4Ion0SrT
 yYXcxDh1WY2E0ARfyMvT3lv+Q+P/suakkE0RdpPGTMH68=
X-Google-Smtp-Source: AGHT+IFZu+BOH2IdWbpF3UTHfMahdXQwUmkMifbliwRjHLrW2rXpl0TcCPpBUwvFFrSrT+VtnH/k0g==
X-Received: by 2002:a05:600c:450a:b0:471:21:554a with SMTP id
 5b1f17b1804b1-4711787c0c0mr131881085e9.13.1761159639031; 
 Wed, 22 Oct 2025 12:00:39 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428dafesm55172395e9.6.2025.10.22.12.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 12:00:38 -0700 (PDT)
Message-ID: <6c4d97fc-56fc-417c-9f2b-6a89c9c86591@linaro.org>
Date: Wed, 22 Oct 2025 21:00:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Set FPCR exception flag bits for non-trapped
 exceptions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Gabriel Brookman <brookmangabriel@gmail.com>
References: <20251017085350.895681-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251017085350.895681-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Cc'ing Gabriel

On 17/10/25 10:53, Peter Maydell wrote:
> In commit ebd394948de4e8 ("target/hppa: Fix FPE exceptions") when
> we added the code for setting up the registers correctly on trapping
> FP exceptions, we accidentally broke the handling of the flag bits
> for non-trapping exceptions.
> 
> In update_fr0_op() we incorrectly zero out the flag bits and the C
> bit, so any fp operation would clear previously set flag bits. We
> also stopped setting the flag bits when the fp operation raises
> an exception and the trap is not enabled.
> 
> Adjust the code so that we set the Flag bits for every exception that
> happened and where the trap is not enabled.  (This is the correct
> behaviour for the case where an instruction triggers two exceptions,
> one of which traps and one of which does not; that can only happen
> for inexact + underflow or inexact + overflow.)
> 
> Cc: qemu-stable@nongnu.org
> Fixes: ebd394948de4e8 ("target/hppa: Fix FPE exceptions")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3158
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/hppa/fpu_helper.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
> index 45353202fae..2d272730f60 100644
> --- a/target/hppa/fpu_helper.c
> +++ b/target/hppa/fpu_helper.c
> @@ -94,7 +94,8 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
>   {
>       uint32_t soft_exp = get_float_exception_flags(&env->fp_status);
>       uint32_t hard_exp = 0;
> -    uint32_t shadow = env->fr0_shadow & 0x3ffffff;
> +    uint32_t shadow = env->fr0_shadow;
> +    uint32_t to_flag = 0;
>       uint32_t fr1 = 0;
>   
>       if (likely(soft_exp == 0)) {
> @@ -122,6 +123,10 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
>               fr1 |= hard_exp << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
>           }
>       }
> +    /* Set the Flag bits for every exception that was not enabled */
> +    to_flag = hard_exp & ~shadow;
> +    shadow |= to_flag << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
> +
>       env->fr0_shadow = shadow;
>       env->fr[0] = (uint64_t)shadow << 32 | fr1;
>   


