Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9614FCB621
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyYCK-00014t-Ef; Fri, 06 Mar 2026 11:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyYCH-000149-D3
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:38:41 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyYCF-0003Iy-Oz
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:38:41 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48371119eacso112159135e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772815117; x=1773419917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D6jWx1BGRFQjklrs2kWhg2v+cB8X8lSpsYI+htxB8Qs=;
 b=IepeR3jwMJSTIuFCW9WGPPLZ+pzDnCHONxnyHvcaRLtvYUlSe30og1wFAl4Bn61Uw9
 pDtEVjNhV7ruS42LcVt8+fht63hie9aQaSPmSBYwRKERakYAG1ko3BUN8x6jUrByn2jp
 OPvQbCToho34NdqUhmiXUJPHG9XCgEFnUGFMbPEGY01/KxqdIa4kAJwefBDwWBvgSKJn
 nFfb7Bv2qL6tH005wJfeL2c2jRhc4RDPbRRRcytr3pjMofNmc3LYvAa9kbf7N6M/qqtI
 P2uHSYO2BGzqcaYxYPIdbLR+qD0GizMkoPHWgl5lNf4wojY+7gGQ+xUufHdGKO4R5YoS
 f0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772815118; x=1773419918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D6jWx1BGRFQjklrs2kWhg2v+cB8X8lSpsYI+htxB8Qs=;
 b=I2JafsovhnWhLKRVdgKupEEX5NkIh2a1J3kpkPglAIJPfaaWE6zM9UNpRBHz3qhyOv
 cdbNQlIu0nsm1H8v+4GiDJ/d4UF3j/byZ6zN/KV9PB0zZ4G6aWclOI3Eg4j4G/5vQDqB
 XJpsUCPZn0HLt82/eTUm75dhuAIpWH96cmWrEjTtQZiM3YXqpMMUM74jG+h7qX+e0Tm1
 9gTNAMD5ATxAlRkWccPcPMftk9BdNW2fbTlslHtHt3scLSJfpVkhI7aUpH0SViW/O754
 0M/LQ6v3SpIpvmU6v5D92skkHaS7XQxYFFKkJse00ZcVQSuV7jMYS00a6tfbThFOmRCi
 kZNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzrIvruCMnF920fYoe6KQ9uFvC4DAQI8RsWZRtn1KKY56gq7LEjacacGdwY34/0Mtn7W8GcRJGz5MV@nongnu.org
X-Gm-Message-State: AOJu0YzOSpap01kAd25IJIu4bAUgvzb/iV39F7GHZQWaeNXoo216Tu06
 yjrDIdY7pyadXcnz5GWcoC76Q4/OGwcAaIJvZ5NdZq1EwMcfPVq1wrP1BFGvh1naaZc=
X-Gm-Gg: ATEYQzz5QwqaJWfIE5CP5vY045U3kpJu8mhlijCy/WFzBIIXup3mkqi6Z/5zDPMoWNJ
 NRg6s9Q2KrnfzuJUBkqeD6w+LLjPrpMQ5GX9E3qxijiSP7OPgcEoX/WB8GBeLuj0SjC4zZtyrb/
 OCTfX29GmCYwl8JdZwD0calW41Z630XnpPoTvXnfumfmo5/ZcIQFSuOFNqaS3BJM/51CoOFLxkb
 uoPun79sRmdPF8575xHwSRJPWHkDOJOfhynmG0Ipwzpzix0aSyDdoe5Ly4MbJJ/+jWcv9yqynfz
 d0wajIV7YNWGKdCRW1FAhfoFH3N8Dy/PsyIB+wxwUEA1Zy0XvJj2Kl4NmGGvfepI162e7UoySoQ
 /YXV1OfTK81K8fqbXsljCvxM8DwkZjXgzaZU08G1DwuFeD2+wR7CrExD0swIQYafSHHXzbBnFBN
 ug2vCvdxfO5My/N5dOTzmVTwsRub8q88F62HMbhdl8Ik49KPDKchs8WHjAPljP92BwTw==
X-Received: by 2002:a05:600c:34d2:b0:483:badb:6191 with SMTP id
 5b1f17b1804b1-48526923595mr44412985e9.8.1772815117531; 
 Fri, 06 Mar 2026 08:38:37 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae538bsm165445295e9.7.2026.03.06.08.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 08:38:36 -0800 (PST)
Message-ID: <6ba56fc4-210e-48f2-a31c-aa049dad8f57@linaro.org>
Date: Fri, 6 Mar 2026 17:38:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/17] hvf/arm: handle FEAT_SME2 migration
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20260306161509.79712-1-mohamed@unpredictable.fr>
 <20260306161509.79712-2-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260306161509.79712-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 6/3/26 17:14, Mohamed Mediouni wrote:
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
> SME2 support adds the following state for HVF guests:
> 
> - Vector registers Z0, ... , Z31 (introduced by FEAT_SVE but HVF does
>    not support it)
> - Predicate registers P0, .., P15 (also FEAT_SVE)
> - ZA register
> - ZT0 register
> - PSTATE.{SM,ZA} bits (SVCR pseudo-register)
> - SMPRI_EL1 which handles the PE's priority in the SMCU
> - TPIDR2_EL0 the thread local ID register for SME
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Message-Id: <20260306-sme2-hvf-v7-1-e72eeda41ed3@linaro.org>
> 
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c           | 298 ++++++++++++++++++++++++++++++++-
>   target/arm/hvf/hvf_sme_stubs.h | 172 +++++++++++++++++++
>   target/arm/hvf/sysreg.c.inc    |   8 +
>   target/arm/hvf_arm.h           |  41 +++++
>   target/arm/machine.c           |   2 +-
>   5 files changed, 518 insertions(+), 3 deletions(-)
>   create mode 100644 target/arm/hvf/hvf_sme_stubs.h


> diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
> index 5d19d82e5d..6b1c3b9792 100644
> --- a/target/arm/hvf_arm.h
> +++ b/target/arm/hvf_arm.h
> @@ -22,4 +22,45 @@ void hvf_arm_init_debug(void);
>   
>   void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
>   
> +/*
> + * We need access to types from macOS SDK >=15.2, so expose stubs if the
> + * headers are not available until we raise our minimum macOS version.
> + */
> +#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
> +  #if (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200)
> +    #include "system/hvf_int.h"
> +
> +    static inline bool hvf_arm_sme2_supported(void)
> +    {
> +        if (__builtin_available(macOS 15.2, *)) {
> +            size_t svl_bytes;
> +            hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
> +            if (result == HV_UNSUPPORTED) {
> +                return false;
> +            }
> +            assert_hvf_ok(result);
> +            return svl_bytes > 0;
> +        } else {
> +            return false;
> +        }
> +    }

Why do we need inlined definitions?

> +    static inline uint32_t hvf_arm_sme2_get_svl(void)
> +    {
> +        if (__builtin_available(macOS 15.2, *)) {
> +            size_t svl_bytes;
> +            hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
> +            assert_hvf_ok(result);
> +            return svl_bytes;
> +        } else {
> +            abort();
> +        }
> +    }
> +  #else /* (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) */
> +      #include "hvf/hvf_sme_stubs.h"
> +  #endif /* (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) */
> +#else /* ifdef __MAC_OS_X_VERSION_MAX_ALLOWED */
> +  #include "hvf/hvf_sme_stubs.h"
> +#endif /* ifdef __MAC_OS_X_VERSION_MAX_ALLOWED */
> +
>   #endif

