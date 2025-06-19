Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3465EC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 21:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMeT-0004OB-9x; Thu, 19 Jun 2025 17:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMeN-0004Ni-7n
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:18:23 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMeL-00013x-1n
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:18:22 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7481600130eso1370721b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750367899; x=1750972699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Z1S7N42ERdXx54xmaOI9EsxTTnLKwaeZEDwV0ye2fM=;
 b=SrR4VqtSsAe1E3o+7JlG9ZSIL08JEDmyEU7s85ooWI0CIshTLo4AwS/mV6BWbZBITM
 jFH7pzlG6r6nZgctqKT2SoKjm8fT8jQpY5i6HC7aRgjMwnwhtdHCvvHpX/FLZvX29373
 bTEIobMOLo2DHsg6pltvSZB/fGYqeTaDQquhnoXAYS+CqybrJTJ1G7ERzLyf0AAB9qaO
 dd1plFYGnb29xpWHvrqlH1xAwcbuR8uopxo8mHNeJxKfO2WbtsCBAYJ6hd30fqgRsu6I
 Ei9okOa4NWw9WmKDUegR7x8xu8YM+lPi6qwXZimuL+5Tu5k8B8BKUDTPLE2uDcSBU58m
 SqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750367899; x=1750972699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Z1S7N42ERdXx54xmaOI9EsxTTnLKwaeZEDwV0ye2fM=;
 b=UJeMiU5F8gdqFjC0VmyMMCY26xalFsZdbwPTyLL6UpSDHDD+ZGI3beNW5tZzovPyPK
 0peVLS3XnO0/Or2QoKjLhgOAg/jJO8f8kJR0vMV317uzh+Fnf7h/HYSWT/f1bzHd2o8g
 miurJi+Rih+hi8YCTsJC41c23ghjKUEWn5DxHSLEgjm/KZT2bpDFGzgKXdE0tYb3kiZO
 ACBxwz84JyubqT7xGBNSmLHoqKnK0eMrTeSrFfGRKvWtS67NLvvQ10knZzBUGr0bJQfF
 CUIZ8ZK9ghhQR6wsvKfsYYiYa5xMd0vO7vOpRu+zNaFlCaJDv+6CiS68324ZZWFeh4WX
 O/Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP+NJzEMvx3bKu8GxjLGxrc1uN22EGaUfQCI+WGIB0TLA1/OA0fecQGybqjjIwgJPIxUH488sjdLO7@nongnu.org
X-Gm-Message-State: AOJu0Yw1afuU35ulKWQCMejuU1dn1QT36DDa8iesyQj9IeL9qxh/P3IJ
 JY2pirT7KP3463+CqJXIOGPifWwb3fGYTuT4UJzIlVl/NOyhEungaRtY6MwQsQTPKIU=
X-Gm-Gg: ASbGncuJ3vBvl9yH6d9Kf+wCGH2yA+3O5rk9Xj38EJDHtTTALDXmbelYbbDqbHWDzqF
 01XtRF/6BLp3Oa/D9v79i/bRsOckDCCdLIzfsirJ9Jv1hAKGNVh1p5Dpaqzr4SRUSuZKnM1alxX
 LUdWFgiFkY9dFNZN9fM40B3j9y9J+v5vaS7Vde6OG7rmSf+Wu9IMCapZjfNVpFxjYxI+YEYlE6d
 Ju9Bjm6gZkF7Gsx225PHM8EIOgoXI7M22GgCXoByLOZvTE6aMr3xVxYLSFPGUm1C06wgsVFAuk9
 /CjyJw41r7H50ov+4EvTUO/UhqcENsPiA5ATMGGLkAEhehcHE2gJGi+jt2mnq3Z6T5xt5Mts8Eh
 ZyWNBXmcnPtbw2SRmEA4aSNzkfUAx
X-Google-Smtp-Source: AGHT+IF/i78SKeZMt1mg6x2bfGDSE133dHtUd8yP3kI5ZU9HD3E878XuWDesY7ODfNDIQ6YO/kA/4A==
X-Received: by 2002:a05:6a00:3d53:b0:736:31cf:2590 with SMTP id
 d2e1a72fcca58-7490d786d8cmr351870b3a.16.1750367899123; 
 Thu, 19 Jun 2025 14:18:19 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46bc2bsm541945b3a.28.2025.06.19.14.18.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 14:18:18 -0700 (PDT)
Message-ID: <2b1fdb64-1865-41e1-8638-17f60a47cdf4@linaro.org>
Date: Thu, 19 Jun 2025 14:18:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/20] target/arm/hvf: Correct dtb_compatible value
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250619131319.47301-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 6/19/25 06:13, Philippe Mathieu-Daudé wrote:
> Linux kernel knows how to parse "arm,armv8", not "arm,arm-v8".
> 
> Fixes: 585df85efea ("hvf: arm: Implement -cpu host")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index ccdadce4766..1fbfdaed59f 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -879,7 +879,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>       hv_vcpu_exit_t *exit;
>       int i;
>   
> -    ahcf->dtb_compatible = "arm,arm-v8";
> +    ahcf->dtb_compatible = "arm,armv8";
>       ahcf->features = (1ULL << ARM_FEATURE_V8) |
>                        (1ULL << ARM_FEATURE_NEON) |
>                        (1ULL << ARM_FEATURE_AARCH64) |

If so, it's equally wrong in kvm.


r~

