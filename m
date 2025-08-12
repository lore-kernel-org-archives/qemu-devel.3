Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD036C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 12:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uloLa-0007Wi-Cb; Tue, 12 Aug 2025 08:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uloLT-0007VE-HR
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 08:43:15 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uloLK-00011A-K1
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 08:43:14 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-321c346ca4eso460492a91.0
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755002584; x=1755607384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xCBX+AliGxawRd3gfdJGIFt6ukILHm7Yn5PWoCDY74Q=;
 b=siiMUeKKyDshs63PUF3LWilxmV1p1NKhM5lS+LbXByWL3/AVWwLncyrUz7KVadDH1j
 HyvAbBZLevbkIGHUASyw3Rr2m/nUEMG5Sy04rJ+6CqU9UxX2gkOoJRuj4wZ6WbveG7kb
 v1A5HM0VneOl6etZ18bOCoc3cLwA/Ej2eJeYHa7LkvRePdlI+DqOoctdkLSwU3djdWs1
 kaVIYhtZS6aOARs75r55Isaaj6rA07jGLa65btdtmn5yypmHq3Hpqdshq5ZvbCC/1mPv
 yABfkZSMQ23Ec5vFVXLBw57jjkiYK1GPxRKN50JXfNmW7P0SSwRkGCPh9GRSN58J3Yce
 kj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755002584; x=1755607384;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xCBX+AliGxawRd3gfdJGIFt6ukILHm7Yn5PWoCDY74Q=;
 b=DZ7Dhx7mehd6x2mBacgR7UUjsmxBbf150hAEUSqtGBNdvamUq7ZumM24HzQ3OJA5tk
 n2pq/TJQx6cDMJIpiy5jVAecegb6wV489s4g+LulMONVqHAomvcQJ2cPmsSJs4sHCG7p
 cITe0a5UivvcB0RJ9Mri93HLHLy2VXqxEr0jOHAQQRkwPPJqn237Y6kyRmRSPQgOsn8b
 afv0O74YiVkQKmvBaBPns+iPULn14H1PTQR2Kv+iTwTaOclj5ln1wjH+shE3zlHQRDXP
 ZCQiKD2j5wVOPQxql3JamhZ1RlCWep3ONCmc24SZImME3MN0aspXkT4RBfLg0djX4vvZ
 LMjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8XiqzXC20OphPeJkVWUjG1NxaRbI72wEgRY49bv6dMGQnppmacxqqqCG19vNZV9dUmwsvcCj8tgXj@nongnu.org
X-Gm-Message-State: AOJu0YzpVgR1jdkMvrm6Rb+Lm4V1kugNDFkjfmDDvm/qirTbfj1ugPPt
 Xk5r+ndw2biZXgaCHBB91IBUU/t2i2itFTS+cX82UciAMze/lojjY7jQvcK8np8zsFU=
X-Gm-Gg: ASbGncuH8eXn8Q4z3u7R4G5Xs6TUrJqM2mpwPX46t+iAK5ljMZjwmQ6zFGj1SzeabCe
 zlLquroK/usyljY82jX8th+l7Glw1zKqZZELyY4xnd4Ih0uZusFwBe67QoC7jv8ii54LnWd4z+5
 +uFgeTTKFYE0Rss0vOjkM9RsdvgY8MAL4TOyOXDdJN4v3M//H9apkS/rm3r71xoMGUyncVnvN1h
 cY9MZZYsXoQeoWP9VtT7etztJQA42z2SPomN6nwuwED3kyLD9I6FBnuEoohCN1JjhxAIZjOyn/b
 p0BgJZgXUHlzTyeJzbIHMbfpAlMtX6483KC4jjgghyXmFlx3FBb0gJ7zQgPhIaniEyXD4/D4gOt
 a07RJ9+Hmio6ASF2MeQUBv43+TasPxi/+1IL3tKPBXLYiGGbjDbc=
X-Google-Smtp-Source: AGHT+IF/ptFIqONoiByZR9Vd2FWr/hpcmIsSQZGWhfklIqgwytlweB0hkEYGkXWypeQnpdqVO0me1Q==
X-Received: by 2002:a17:90b:1e02:b0:321:c8b1:5bb4 with SMTP id
 98e67ed59e1d1-321c8b15de9mr1747188a91.15.1755002584260; 
 Tue, 12 Aug 2025 05:43:04 -0700 (PDT)
Received: from [192.168.4.112] ([168.140.255.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32161252edcsm17214301a91.15.2025.08.12.05.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 05:43:03 -0700 (PDT)
Message-ID: <9fd617db-8ea4-49b5-98f7-0b949b02f26a@linaro.org>
Date: Tue, 12 Aug 2025 22:42:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/11] target/arm: Replace kvm_arm_pmu_supported by
 host_cpu_feature_supported
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-8-philmd@linaro.org>
 <8efcc809-f548-4383-b742-e435d622da73@linaro.org>
 <14d7d948-e840-4ae7-ae93-122755d6a421@linaro.org>
 <3d88ea9c-9cfe-4cd4-a282-2f467f2a502f@linaro.org>
 <cb6e02cc-1959-419a-bafa-5bb43818c159@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cb6e02cc-1959-419a-bafa-5bb43818c159@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 8/12/25 17:33, Philippe Mathieu-Daudé wrote:
>>>>> -    if (kvm_arm_pmu_supported()) {
>>>>> +    if (host_cpu_feature_supported(ARM_FEATURE_PMU, false)) {
>>>>
>>>> Why is false correct here?  Alternately, in the next patch, why is it correct to pass 
>>>> true for the EL2 test?
>>>
>>> I think I copied to KVM the HVF use, adapted on top of:
>>> https://lore.kernel.org/qemu-devel/20250808070137.48716-12- mohamed@unpredictable.fr/
>>>
>>>>
>>>> What is the purpose of the can_emulate parameter at all?
>>>
>>> When using split-accel on pre-M3, we might emulate EL2:
>>>
>>>         |   feat            |    can_emulate   |    retval
>>>         +   ----            +      -----       +     ----
>>  > M1/M2  |  ARM_FEATURE_EL2         false            false> M1/M2  | 
>> ARM_FEATURE_EL2         true             true
>>> M3/M4  |  ARM_FEATURE_EL2         any              true
>>
>> For example in hvf.c:
>>
>> static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>> {
>>      ...
>>      if (host_cpu_feature_supported(ARM_FEATURE_EL2, true)) {
>>          ahcf->features |= 1ULL << ARM_FEATURE_EL2;
>>      }
>>
>> and then only when split-accel is not enabled:
>>
>> hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
>> {
>>      ...
>>      if (host_cpu_feature_supported(ARM_FEATURE_EL2, false)) {
>>          ret = hv_vm_config_set_el2_enabled(config, true);
>>          if (ret != HV_SUCCESS) {
>>              goto cleanup;
>>          }
>>      }
>>
> 
> What I'm looking for:
> 
> - Is this feature supported BY HW?
> 
>    -> hw_init_feature
> 
> - Is this feature supported BY SW?
> 
>    -> sw_init_feature
> 
> - Is this feature supported BY ANY?
> 
>    -> do smth with feature
> 
> With split-accel, this isn't specific to HVF/ARM.
> 
> I can use a tri-state enum { ANY, HW, SW }.

My point, I guess, is:  tcg_enabled() appears to be the only correct setting for 
can_emulate, and since that's the case, it's clearer to not have the parameter and simply 
test can_emulate within any subroutines.


r~

