Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555D9CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 18:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSf4u-00027M-JB; Thu, 28 May 2026 14:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSf4m-000257-Br
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:03:25 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSf4k-0000Tn-HB
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:03:24 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2bf1cda2b17so543315ad.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779991401; x=1780596201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LdCYtT22giz/ZwD5KeGuntg04/FueLfAzdMHQ+CNCy0=;
 b=vqkUyFlprty442GlB+mn1HzHF5YcjpHmOzKCN9KA1+0V3nbs9WV89VZwNWTm+eRe5s
 TUs+HhyCUXzYYk2VZa82f019eOLMrZEnX+bwNZ8MkVBLaK+sHh2wkhvOaJFi1gVVjUX8
 /Of8w7XYtAfgpCv9mdKQzlNAfWizplVdyjD46QaJKt70Ybb6lE3teLKSyi6/mYu9+mqr
 D7M/NV0MYOZQJlMUd5kqAn2zHx3ye9kKWTDBcpMZNLP8rHQ/muW+NibcPNLKENBLFf7s
 THybjk924d0p5EoDTXgAPTGdOt2O4C0MejWuIQoXM9OaML/vnUWuybcWKeM1nE0HTX0w
 hJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779991401; x=1780596201;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LdCYtT22giz/ZwD5KeGuntg04/FueLfAzdMHQ+CNCy0=;
 b=Wmvyud08Zc5+uh/DI5Mek1C5RLrGDfGjLdQOX7yiviS7qrUFNc4p7KlBkt4DfoVN72
 ygYWF1oyTQlKdTRIEYwrExGZY8koF5qTX32BFv6xXon/Yyn0BXTd0ZNwbxnge3GCRP49
 OOQFyOeJXGvN/lBGDvwway0OqwnA0q1kLr4oeYCIgqCEsm1BaQVj/3wzcjaUI2hAaP8i
 J9+AY2BrUDLIOeWF2iZTPKFB/g0fxpqFG0vsapHB8Cphs0kvHBGsp0DFpM4hsWtNzUNY
 6Bgi41JDuZDKIe1pNtWtVk2gUY02SjUV6WTGTlU6QQJHUhPIS0esk3KO5y8ieqT8IPW6
 +IFQ==
X-Gm-Message-State: AOJu0YwXOBIlSTYLpwWmT2S/2dxCjz3EQInaTZ2YLrfQ7oAtJjdBjIzq
 Xe1VWWN2ix+C9qBt167HEUyKExhsxzVHmmzqdPHfN/IJgkxEno0kx2lqG+bs/Vb0YXpBokA5P1i
 ifrrEs3M=
X-Gm-Gg: Acq92OEZcbvJY1QO/gjS1k7b3UHB0YgEHbxIwb2rAF6kNXVruc/P8Qygciim8MxW1LH
 BsNP9kibsHNtTs7XLJYYYfbJ3BLW2gjiD+cL0zCG2Fyp8fApGvEz09A/xnxZJUnC47qdOB8cgFv
 DO88tm6V28FoVvf9U2LcYqAFXzHM37XhqXR10nHXz64fSGVOl343Sb1QdvSbL6Q50Q/vKrZDXoo
 pbQJlSbfsYhQ+ndMdQDDbQVApUvJkW5uIaafGwA6Qdz5SRGj199kUsH/Ms16ahnpOHrguS+i4PO
 4rGj35paPaEqKqmhrmOOwn+Qg3Wx/vPW9w6IgRAIGwZOBJC4c36ejN7x/sDG0T21cNPkT4mze+r
 F5+QhS8LdmfSjh1afnVstGWCICKPfJaOpOZUSLFBGlUygFYhvPtQoUbYsTpNHEM4kuGCXpnUXTk
 dxDsSf033XBDJEGLlIVO7JepPzTriZE8DcywsDfDEnlJgXiy0=
X-Received: by 2002:a17:903:2309:b0:2bd:d7c5:927c with SMTP id
 d9443c01a7336-2bf10e00476mr23432075ad.20.1779991400806; 
 Thu, 28 May 2026 11:03:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b387dsm192895355ad.50.2026.05.28.11.03.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 11:03:20 -0700 (PDT)
Message-ID: <67f401a3-4b4e-4088-bd32-d91f56d4c2ee@linaro.org>
Date: Thu, 28 May 2026 11:03:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/arm/cpu-features.h: x-rme now means GPC3
To: qemu-devel@nongnu.org
References: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
 <20260528-jmac-gpc3b-v1-1-d34c46c5069f@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260528-jmac-gpc3b-v1-1-d34c46c5069f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 5/28/26 08:34, Jim MacArthur wrote:
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   target/arm/cpu-features.h | 5 +++++
>   target/arm/tcg/cpu64.c    | 4 ++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index f9c979d20b..6819d5f6a7 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -1138,6 +1138,11 @@ static inline bool isar_feature_aa64_rme_gpc2(const ARMISARegisters *id)
>       return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) >= 2;
>   }
>   
> +static inline bool isar_feature_aa64_rme_gpc3(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) >= 3;
> +}
> +
>   static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
>   {
>       return FIELD_EX64_IDREG(id, ID_AA64PFR0, DIT) != 0;

This hunk is ok.

> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index a377f67b9c..53f0ea0404 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -159,8 +159,8 @@ static void cpu_arm_set_rme(Object *obj, bool value, Error **errp)
>   {
>       ARMCPU *cpu = ARM_CPU(obj);
>   
> -    /* Enable FEAT_RME_GPC2 */
> -    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 2 : 0);
> +    /* Enable FEAT_RME_GPC3 */
> +    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 3 : 0);
>   }

This hunk has to go last, once the implementation is complete.


r~

