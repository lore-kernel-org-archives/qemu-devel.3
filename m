Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD18EC83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 20:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZbmk-0002fj-NR; Wed, 09 Jul 2025 16:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZbme-0002dx-Rj
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 16:52:55 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZbmd-0002zl-3z
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 16:52:52 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73a43d327d6so156616a34.2
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752094369; x=1752699169; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LdqYgS2PhTUHUUG0AT9NScCCWRii59ZzMo6AJryRxM4=;
 b=wCoicoEM371WSg3fHl+3Su7+jV3Y+hWS00jLcGFM+nensyezYPfTOJEsyV5eOcETxI
 kdcnMppmfbTayjMM3gk0axa3Bu8AKHWzpLPi7zMeS41lqL1nX8TuUZHYaC1K6yUTr/YW
 9+IEmCthCumcNXIrZ6VnPh5gC9QrPMXbwu/ilYoQwzhrp1HuCt4NB8XG5QaRfonpihHV
 +rS5P+LGjWFNeifcWNqk8jJR/1yT9jvfcFtzYQ8ugJNnqX3RsadfK7CU0zKLo4uSnCgB
 yqx5H1CFPepXNrTFnleI9dZOD0MmZ2MGPjd0kjOWtPvFsZMs2kfjmfey20kdnEVW8+TA
 6TJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752094369; x=1752699169;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LdqYgS2PhTUHUUG0AT9NScCCWRii59ZzMo6AJryRxM4=;
 b=Kf2nhJr12bCko54WrzbI0VBAjMIY2EjEM617ldBCJImOIckUO1mb3vhcPe9JBh1V17
 /1MqQXgq6uZciEXtFBNVQLQ665zEPtxi9ZqQQOQCQtv3GWngNw4wA3t3urb1qavewFoW
 5aeyIjRilnOwlQ+IHkqix1ZYz1DxWEyx4t6lUDKHxWuGnbVChSI3flbrdlVgtvUa7Xgw
 AxTM52oCHOzbXApZTVxvE7oUPMXGOFyW6i3T+Oizr0F16wGv/Q3D+ByjdJYQnSkf77OD
 ycIfl+/lq1AFVyhBOtOTg6VTNPMv2COKG+4PPjmqHxzf036Ya5p59dWWM50JIYLVY3jz
 x6Cg==
X-Gm-Message-State: AOJu0YyqW45OVSTAf7U5f6iJhBdJQLwWKoHrkMViYBCXBuwNNvjCcKCk
 L7GZE6G9JdObScx7u4mWVjBqrbRfYQ9PDVE8w4qKol/erocsAZawJad+leRPEdV7Lro=
X-Gm-Gg: ASbGnctTgpkSMKdPFwcbNeCuP9ddkym4EKbWCG6uB8DZIHzOR3P/+OSmB89b7e/QF9/
 Jh21yWvqlQCFQ2IFKGMdeJA2mucjQ0jp2FJiNer7nEDERmHykzC84qR7PlR7+qR/Ijqu7bxu3da
 H/WeFrkc/hJB9Zld6rbNLMPKCdMSLF5SLN/W9ylo31AAX1tJkL3Uv0GQ/r1qIMoYobc83QMfsUz
 uRDG6hvzJz341zVD5KKst7zkmtiMvS1vyeUyFiCIewltnffwseNBj/13jF9YPJLoJjqk43okXgI
 gGbC6VnlEb0rKYUFyvs3BTBcEszeCtOcZNlm1yFQX4JcYOSTB0zsWMcev71fSaTo8x2G0lQqlzq
 gz/A=
X-Google-Smtp-Source: AGHT+IH6IHm4t5djczgWL4jH9xazF+qAabKjnNRARJXHJQwLlV/sv/TJ1TeynOjXoeQjZrVt7scQYA==
X-Received: by 2002:a05:6830:4883:b0:72c:3235:9c5a with SMTP id
 46e09a7af769-73cf058065emr132052a34.1.1752094369216; 
 Wed, 09 Jul 2025 13:52:49 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f7714c4sm2551758a34.28.2025.07.09.13.52.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 13:52:48 -0700 (PDT)
Message-ID: <0749b8bd-c531-47a2-ad4e-3c0b7f24b390@linaro.org>
Date: Wed, 9 Jul 2025 14:52:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] target/arm: Implement FEAT_MEC cache instructions
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250709180326.1079826-1-gustavo.romero@linaro.org>
 <20250709180326.1079826-6-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250709180326.1079826-6-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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
> This commit implements the two cache maintenance instructions introduced
> by FEAT_MEC, DC CIPAE and DC CIGDPAE.
> 
> Because QEMU does not model the cache topology, all cache maintenance
> instructions are implemented as NOPs, hence these new instructions are
> implemented as NOPs too.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   target/arm/helper.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 34e12bde90..36cf2b6415 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4996,6 +4996,34 @@ static void ic_ivau_write(CPUARMState *env, const ARMCPRegInfo *ri,
>   }
>   #endif
>   
> +static CPAccessResult cipae_access(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                   bool isread)
> +{
> +    int el = arm_current_el(env);
> +
> +    if (!cpu_isar_feature(aa64_mec, env_archcpu(env))) {
> +        return CP_ACCESS_UNDEFINED;
> +    }

Not required, because the cpreg should not be registered in this case.

> +    if (el < 3 && arm_security_space(env) != ARMSS_Realm) {
> +        return CP_ACCESS_UNDEFINED;
> +    }

Correct, but we can simplify this to

     switch (arm_security_space(env)) {
     case ARMSS_Root:  /* EL3 */
     case ARMSS_Realm: /* Realm EL2 */
         return CP_ACCESS_OK;
     default:
         return CP_ACCESS_UNDEFINED;
     }


> +static CPAccessResult cigdpae_access(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                     bool isread)
> +{
> +    CPAccessResult ret = cipae_access(env, ri, isread);
> +
> +    if (ret != CP_ACCESS_OK) {
> +        return ret;
> +    }
> +    if (!cpu_isar_feature(aa64_mte, env_archcpu(env))) {
> +        return CP_ACCESS_UNDEFINED;
> +    }

Likewise not required.  Therefore the two cpregs can share the same accessfn.

> @@ -5094,6 +5122,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
>         .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 2,
>         .fgt = FGT_DCCISW,
>         .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
> +    { .name = "DC_CIPAE", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 14, .opc2 = 0,
> +      .access = PL2_W, .accessfn = cipae_access, .type = ARM_CP_NOP },
> +    { .name = "DC_CIGDPAE", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 14, .opc2 = 7,
> +      .access = PL2_W, .accessfn = cigdpae_access, .type = ARM_CP_NOP },

You should insert the first into the same mec_reginfo[] structure that you introduced in 
patch 1.  The second must be in a separate array, like so:

     if (cpu_isar_feature(aa64_mec, cpu)) {
         define_arm_cp_regs(cpu, mec_reginfo);
         if (cpu_isar_feature(aa64_mte, cpu)) {
             define_arm_cp_regs(cpu, mec_mte_reginfo);
         }
     }


r~

