Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70FBC83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 20:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZbNY-0005KE-Ez; Wed, 09 Jul 2025 16:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZbNR-0005Jg-1P
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 16:26:49 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZbNO-0007pH-O1
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 16:26:48 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-73a4c557d47so119283a34.3
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 13:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752092804; x=1752697604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bXT2dHDB7AvyhAC7jq6WSGFWH56BrQpqzseQhdvvmsw=;
 b=URro7wi4UPa3HCxJnCS2ScvYY+kp98O+ubAhJea4xSxe6NJr0GBHi0RsgBBHsmaN41
 HrfmZlksdjhX/RT7ZrtQgeUtVp/VI+fpu57R+GyRNlv4gOJL0ZRHZV8fB/6G2pQ7gNbk
 AbpQ3475chPhoHpWyDmjqgL2wVN2AHNxghNutVQ0a/b97fzQT35HrbDJ2ul5OEF1pUGA
 kYq6T2v2SdyNCSrndgQ/XUf4q2YKb8AzenkxJvfs6FnCz0zSUG/+yQcGjqaBuoFo8ZGz
 RjcDNd0GAACQLkHRgbUAzxj/SxD2v7MZQku/n2m5SBAw7SnZBh+CDM3lvYSygtWgeBWR
 WpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752092804; x=1752697604;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bXT2dHDB7AvyhAC7jq6WSGFWH56BrQpqzseQhdvvmsw=;
 b=n7khvytmee4Gs83sxgIYGkfFEh+bzGaUooCKlIgtLq02WjORHyns4msudQ3yba3cyV
 xp8tvwKsEkeE6LJV2iR1i8dSer6dFRIsKemKSxQsIWJnpCVNkGQNCapSzYuvjLtmfFq2
 Sdj28K4+UIxtQwRIzDvah/0HtBgQa3Ef4m96hBY5Wd+VS++mZWpIIacSm3Vn7sN3GtGT
 CudrtKnuXGlRNWJ4ZySOT7SPFwS77piFNLnc5cFAgkXwIdwrGgchA3HuOo7naK30eLhe
 1bbImVEHpdtFCVWnr2Raqv5r3uW5xPSbI7yupdZIgWLryOMpgRNE6xVoFydaqrDz+G/T
 wHSA==
X-Gm-Message-State: AOJu0YwPNKaQN6+Q+ERB4hyPaim6i4CQJUy+/BMIDRk6fmHZrUGppDv6
 PouS9q97V6BP9RUsDGz1vrSuiYrEeDuSgWeh9fi8Umy4yAvhVhx67Oh4gEIZBvcZCr4=
X-Gm-Gg: ASbGncu6nhGYVsMaR0Uyl31U4p0woZWg/U58CNUnlgXg0iay7B56aqMzqT+372KVOFS
 +KXigbt/731Md6vsbnC24/lOlCThw5oNSgdUkOnMZJ/GOMwwzI9fgxdqDBj8v/LucI4DT2Lr1Io
 PsD3ueJHUW6qJljpRgUXiJY/wGn7JmThUnehCxigCugiRnIlr8N0T+RlDgdU1flQhJ+mb3qzzZq
 Umf3WKNe3xxKxAlBDOyXsRJ6b5s8lzBTkXA5ZVWVIgBwrxHNzdjkSy+X8qTn0t/ILlQQ8x5XCn6
 zw07dB5Yx/83jrGdLkiKPemubYLkCejdYyT/5FRK8WoWpnE/3Wu6okE8nqvvqDQGjNZ3Mch1efb
 Hx2g=
X-Google-Smtp-Source: AGHT+IH/nEutk46BwO7z/kbglbjFlEcwPcp+Ut/53JFT0kFqV951LnJksf2C2VfmxIZoB/Rdkj6zxg==
X-Received: by 2002:a05:6808:5144:b0:409:f8e:7284 with SMTP id
 5614622812f47-412b9f54025mr2986140b6e.6.1752092804535; 
 Wed, 09 Jul 2025 13:26:44 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02a32a89sm2051509b6e.8.2025.07.09.13.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 13:26:44 -0700 (PDT)
Message-ID: <82431249-aa2f-4d54-a50b-dce0f69161ae@linaro.org>
Date: Wed, 9 Jul 2025 14:26:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] target/arm: Add FEAT_MEC registers
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250709180326.1079826-1-gustavo.romero@linaro.org>
 <20250709180326.1079826-3-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250709180326.1079826-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 7/9/25 12:03, Gustavo Romero wrote:
> Add all FEAT_MEC registers.
> 
> To work properly, FEAT_MEC also depends on FEAT_SCTLR2 and FEAT_TCR2,
> which are not implemented in this commit. The bits in SCTLR2 and TCR2
> control which translation regimes use MECIDs, and determine which MECID
> is selected.
> 
> FEAT_MEC also requires two new cache management instructions, not
> included in this commit, that will be implemented in subsequent commits.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   target/arm/cpu-features.h |  5 +++
>   target/arm/cpu.h          | 11 ++++++
>   target/arm/helper.c       | 70 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 86 insertions(+)
> 
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 5876162428..552d8757b7 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -594,6 +594,11 @@ static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
>       return FIELD_EX64_IDREG(id, ID_AA64ISAR2, BC) != 0;
>   }
>   
> +static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
> +}
> +
>   static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
>   {
>       return FIELD_EX64_IDREG(id, ID_AA64ISAR2, MOPS);
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 0f64c7b163..a93eebe077 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -576,6 +576,15 @@ typedef struct CPUArchState {
>   
>           /* NV2 register */
>           uint64_t vncr_el2;
> +
> +        /* MEC registers */
> +        uint64_t mecid_p0_el2;
> +        uint64_t mecid_a0_el2;
> +        uint64_t mecid_p1_el2;
> +        uint64_t mecid_a1_el2;
> +        uint64_t mecid_rl_a_el3;
> +        uint64_t vmecid_p_el2;
> +        uint64_t vmecid_a_el2;
>       } cp15;
>   
>       struct {
> @@ -2424,6 +2433,8 @@ FIELD(MFAR, FPA, 12, 40)
>   FIELD(MFAR, NSE, 62, 1)
>   FIELD(MFAR, NS, 63, 1)
>   
> +#define MECID_WIDTH 16

This could go in internals.h.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

