Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3491CD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0Gi-00044m-82; Mon, 18 May 2026 11:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP0GS-00042q-GD
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:52:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP0GP-0001oS-Vs
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:52:20 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2bdeed4f717so5589175ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779119535; x=1779724335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ISJ+z9xmpazJyHzMYnI5yhxO1FflTC2t9s1IMXMb7k=;
 b=VczK74j77DAWW4wS3hAeVCVuC3SLHLEOitc4FJ32e2eYEeUM87jq2Jejb7S5uEouqb
 cpIh7zc47/Lo6PGw9puahcwZ7ENzF0T8KSIXyuK9QHdsct74Mwnmg3OJkK9o20KYIPwF
 osSy4rc9fjjnwBvpwz0m7ZJLyqxPe5PanN0En1xU8VaaZq5Fy4OPv+uP2gUpD3j/3rtI
 deFekEW/Y16Vs90kNufLEHWw7I5pui4v4oH7kA5SsaDSz9L+NRKhq0RjO3WjuCjVWwGC
 6DkUPdiHKTQ5jeY/7qI6Bi8qWDS5S6SpEsp7YSk7XUgNz1DwqQkEsAMWfZ6cctb/Avl7
 nMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779119535; x=1779724335;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ISJ+z9xmpazJyHzMYnI5yhxO1FflTC2t9s1IMXMb7k=;
 b=gQDQWVTLXV/KnmKppqfgNIkcwHRTxEUa8MSNpZvHxiblTQM3PP6nMGULKPMIOqx1oa
 vb+cShYZAKVdFX/v1Q8VQC2meF93tUknuHh9O4Xc/DxJFK6hwjSq6HpLWaq3i6J/la2s
 CpnN5b11vUzxEk6nM3XkFfErnLn/7UmKbypXxu2tix19Uix+UQqBNZIZa7hZAK2eUMZM
 MiL4W/iAv4tLXQ72i/zUZe8UqpAwREH6aW4ShKelLh4wjyDEHVrQDVCq1uU3/XH9QJxD
 tuH4SC06AIxzJFryf9ORGrmqpbFDRbcOcoxEcVz4vYAGmDK4N6kGCL347wfRLU8lcuVg
 l2Sg==
X-Gm-Message-State: AOJu0YxH1RLlcL9WFJOx+eaFi8k1c2x45QmMcDLrhZteoXKE2ZfhqXpB
 BTUDdhvd5iOCIP3wzjb+UuO0MGOGLwXlx2dK3N3xJ1hDz80/Cvh1HIJTKJ8acPzjGH4nYroYNNS
 25aaevig=
X-Gm-Gg: Acq92OH5ElCrByTP7kU/Ipocf7uSKQI0+6fiYiP1lIejxEnbvV1I/pyKZk96d8FbtWF
 DTrTQt52PypQmH7j/Z3GL7AgYgEh4PsaWhiOuX903OEinXTQgz5csmlMFXvOTeoWFGgPDe1/bzK
 rUmLZM8El8lo/oRwbz9fD3qCmPKQ7Fjz9vNVH4TPHXd+S/EuPo7BE46qr1qudN0Wa6FJqC9RxJ2
 2qe+6AUzR5EHMIxN6p94Y8gGzvg50nYA/F7EEo6wFHlYQ5tXU22dy+ajmp2Tm1A2pOV9zZfZLzB
 1FWkD2dIHQBP3RnFGI2ikO5myxGf9xDU29Pv4FlsHbo/c1jYvMaBxSrJKKXFyOlYdSQxmuKUsCN
 5XWbb4STyRwMIRsLirmugDgziIsKpFU+PX4ggcts8a6YKr5be1h5qwbN/gonRdBz0Gf7O9Rboku
 dwiTjLaus0aiih6R1iK/ZLU01L0JVAvLysm7mX
X-Received: by 2002:a17:903:3b85:b0:2bd:61e8:1ee with SMTP id
 d9443c01a7336-2bd7e8c67f2mr183372565ad.21.1779119534896; 
 Mon, 18 May 2026 08:52:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d234540sm151982585ad.79.2026.05.18.08.52.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:52:14 -0700 (PDT)
Message-ID: <65e56b66-6bc2-40e6-bb81-96c6985ed3bc@linaro.org>
Date: Mon, 18 May 2026 08:52:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/14] target/arm/ptw: Flip sense of
 get_phys_addr_twostage return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 5/15/26 07:25, Peter Maydell wrote:
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index c89cccd431..545138464d 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -3571,7 +3571,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
>   
>       /* If S1 fails, return early.  */
>       if (ret) {
> -        return ret;
> +        return !ret;
>       }
>   
>       ipa = result->f.phys_addr;
> @@ -3602,7 +3602,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
>   
>       /* If S2 fails, return early.  */
>       if (ret) {
> -        return ret;
> +        return !ret;
>       }

Perhaps clearer to simply return false here, rather than operating on ret?
We know what the value must be after all, via the if.


r~

>   
>       /*
> @@ -3656,7 +3656,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
>           result->f.attrs.space = arm_secure_to_space(result->f.attrs.secure);
>       }
>   
> -    return false;
> +    return true;
>   }
>   
>   static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
> @@ -3724,7 +3724,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
>           ptw->in_mmu_idx = mmu_idx = s1_mmu_idx;
>           if (arm_feature(env, ARM_FEATURE_EL2) &&
>               !regime_translation_disabled(env, ARMMMUIdx_Stage2, ptw->in_space)) {
> -            return get_phys_addr_twostage(env, ptw, address, access_type,
> +            return !get_phys_addr_twostage(env, ptw, address, access_type,
>                                             memop, result, fi);
>           }
>           /* fall through */


