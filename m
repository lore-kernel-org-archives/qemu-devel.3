Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0029DCA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 07:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uljVu-0006u3-I0; Tue, 12 Aug 2025 03:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uljVe-0006tP-NU
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 03:33:28 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uljVT-0001iX-Rz
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 03:33:24 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-459d7726ee6so26210115e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 00:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754983992; x=1755588792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U46tZm3WdCz9s6+s67rjcVFpZgOy6vILPUGATvBzyns=;
 b=e5HVMp37XQymM6wOUuhjfg611WecI3nOVYItTEUisMnuIuCTrV3MHJcv6U3BtGZ3Kl
 lhduFwdCFZrcb8SHsnjvENAK9tV7PJs1lhhdrVoAR62cC8zBCveVTUC+zjKlwR7lVYpp
 MZuSxjYNr9yQ2NBntrNWT/7MSZ/k/MX8hQTLg04cpDEftEdj6bwpTuJUhiOpSoT6X5qQ
 7yr621/xWH1jVoAqAGqA+LaeZGB8aA5I5KHAhnwDL7P3eRt71eizTrVxjvNCZsVy17YR
 qMstJOJ76zhTmvHebixL9E5zRFzIJ4gzN/GqKHTD2o4y/+eUrHuIjVsDd1pwh1LUaL0W
 R7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754983992; x=1755588792;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U46tZm3WdCz9s6+s67rjcVFpZgOy6vILPUGATvBzyns=;
 b=EXLyPP/iCTSJeaR0OmW+Cw9cnRTXCdqHhVhSN+m3DlrkGPjtFBMGCDLnD7PcH5kBNR
 BGi01cguNUTVQGuqO/GOhpytgYelpEpHchEQnKruYV5Cr/LEdqLoWuDrB0AVkOQXcKqo
 JmignYCJsHfCPa/pDUmsyM+/pB9EdEytjTdXfyS+MqbtC5kUnViJ2F926UiguLtnwLBB
 HUHQOHdgWVtvuw8lte08TbC/qISQUKtA0E8qpMNj/HDlnH/P4ojle7xg8vIduadMni8G
 xAD0QD+WjJCBp9v9wGOT8UKEbn1hOPmszIKgJ5xZCG7fqcDBW5UogjD+uYhx+QqWRjmt
 QW5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/+4QHeQkCPlKXjeNXcN7QeJeChmYjM9y9jU6LzNoP9fnAl/ptJUdV9nyNoNb+UipOC34rUkIYyc5l@nongnu.org
X-Gm-Message-State: AOJu0Yylj6mBEPk/FiAojiaSVkT12Al6MaxBCkxgOcHjGjeBEcZCBqgJ
 suTF90qChY/zVqDiVVd3xIhrdsIRHuAmi7qxUsDYPCLlKWoS456klIa4MhaJMtSBYuQ=
X-Gm-Gg: ASbGnctDe8tUsdbBcgKKGQLhYKhlrBeeF1h6Plmayrsvbutne32AeecJwAn4I3m3wdF
 G5T7q2JkfU45QrmLh0X89qNqyDVXYBavyT47+EudhhzmhyJg+GTmtnuwmPqvZxGpWKz3o4jcujZ
 p8c5pAGx5386RBXicIMgn7W3NhEPt4Y7tAS+dfszLaNCV5eP983lIaqIGmzE4frbgi8Uz0scBPp
 Wd8pDSDKJgH0S9mX5F3eFNr+UigPf69f5Y/gcqj24al4qDdXaYzGHSUnhdqYNkNruvJKJp/Qt08
 q0uG5mrPKdZsUp0umDLyyxcoo2rxduHyZxRylxMAF13SK0BGhuP0++/nvVJYCT8TMRHm/8rzsGv
 ln+9hQgUuM3Kel7UOi1QrsNTBMO7m+GHbwiMXVr7nwQNgZaHBk2K43ODLbrfw7AnOtY47TZg=
X-Google-Smtp-Source: AGHT+IFenbOYBYYL8rtdP5NhvlPx6gH97dvDDxCUDEfprak8jMg7i9COL3O/U+STX2Nwjj//F6/Vtw==
X-Received: by 2002:a05:600c:4e46:b0:456:173c:8a53 with SMTP id
 5b1f17b1804b1-45a10e135b6mr21112745e9.2.1754983992162; 
 Tue, 12 Aug 2025 00:33:12 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eb7acsm525015225e9.28.2025.08.12.00.33.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 00:33:11 -0700 (PDT)
Message-ID: <cb6e02cc-1959-419a-bafa-5bb43818c159@linaro.org>
Date: Tue, 12 Aug 2025 09:33:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/11] target/arm: Replace kvm_arm_pmu_supported by
 host_cpu_feature_supported
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Miguel Luis <miguel.luis@oracle.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Haibo Xu <haibo.xu@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Mark Burton <mburton@qti.qualcomm.com>, Alexander Graf <agraf@csgraf.de>,
 Claudio Fontana <cfontana@suse.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-8-philmd@linaro.org>
 <8efcc809-f548-4383-b742-e435d622da73@linaro.org>
 <14d7d948-e840-4ae7-ae93-122755d6a421@linaro.org>
 <3d88ea9c-9cfe-4cd4-a282-2f467f2a502f@linaro.org>
Content-Language: en-US
In-Reply-To: <3d88ea9c-9cfe-4cd4-a282-2f467f2a502f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 12/8/25 08:03, Philippe Mathieu-Daudé wrote:
> On 12/8/25 06:49, Philippe Mathieu-Daudé wrote:
>> On 12/8/25 02:48, Richard Henderson wrote:
>>> On 8/12/25 03:06, Philippe Mathieu-Daudé wrote:
>>>> +++ b/target/arm/kvm.c
>>>> @@ -288,7 +288,7 @@ static bool 
>>>> kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>>>                                1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
>>>>       }
>>>> -    if (kvm_arm_pmu_supported()) {
>>>> +    if (host_cpu_feature_supported(ARM_FEATURE_PMU, false)) {
>>>
>>> Why is false correct here?  Alternately, in the next patch, why is it 
>>> correct to pass true for the EL2 test?
>>
>> I think I copied to KVM the HVF use, adapted on top of:
>> https://lore.kernel.org/qemu-devel/20250808070137.48716-12- 
>> mohamed@unpredictable.fr/
>>
>>>
>>> What is the purpose of the can_emulate parameter at all?
>>
>> When using split-accel on pre-M3, we might emulate EL2:
>>
>>         |   feat            |    can_emulate   |    retval
>>         +   ----            +      -----       +     ----
>  > M1/M2  |  ARM_FEATURE_EL2         false            false> M1/M2  | 
> ARM_FEATURE_EL2         true             true
>> M3/M4  |  ARM_FEATURE_EL2         any              true
> 
> For example in hvf.c:
> 
> static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> {
>      ...
>      if (host_cpu_feature_supported(ARM_FEATURE_EL2, true)) {
>          ahcf->features |= 1ULL << ARM_FEATURE_EL2;
>      }
> 
> and then only when split-accel is not enabled:
> 
> hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
> {
>      ...
>      if (host_cpu_feature_supported(ARM_FEATURE_EL2, false)) {
>          ret = hv_vm_config_set_el2_enabled(config, true);
>          if (ret != HV_SUCCESS) {
>              goto cleanup;
>          }
>      }
> 

What I'm looking for:

- Is this feature supported BY HW?

   -> hw_init_feature

- Is this feature supported BY SW?

   -> sw_init_feature

- Is this feature supported BY ANY?

   -> do smth with feature

With split-accel, this isn't specific to HVF/ARM.

I can use a tri-state enum { ANY, HW, SW }.

