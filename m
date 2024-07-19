Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEACC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUhvq-0008Gx-QA; Fri, 19 Jul 2024 03:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sUhvm-0008F7-KQ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:21:30 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sUhvk-0006AW-Is
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:21:30 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fc60c3ead4so13158905ad.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 00:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721373687; x=1721978487;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l+InLfvy3Wi5yP9doSp4CIHfQTGOwoe0asCqSW+LgII=;
 b=hMoUXmNDX3wVZ0ZX2IRhT51TURtfOniJ4nDo3sR7bR1TjgnAwfzWDUceK0qELB6YmL
 eZM1rencnVzVyYLBtUc8Sw7RdrfSVHFTKSE0LfCWIOonvXhS2jiaMgKmEnZucMlMjDNH
 xScPPcIp6m+X+qlOlxw5+FhjqQMJh2l7wN//6d7DkhknojSs6rN18P05L/+8LGPHzLW0
 PHIG0G3BQp7VkzYZxIeerXgRK9GadWDFCcK2mTrGFuBS6bfYay8p8tvFmRMuXrVbfVne
 +Qmkqnc+1vPOkpVpqJvoP9cEUa0CkM/hbKFiHfQRrNs8ZrmMVBirUbwuMLvbAXwbIzdg
 buQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721373687; x=1721978487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l+InLfvy3Wi5yP9doSp4CIHfQTGOwoe0asCqSW+LgII=;
 b=IU8V4OZ0Ar5HL6U7/HZOckY6GFPTqLSqJ7kE+u1uLdUlEQ64Tt8Yq3dJcf7IG8uBkV
 8kpJ3ZqbHdwQ5PE5118M8y+RO6vwwsF+GbY13Q3kIIEsCVk3/nxdcZ+BU7f4qNgh5Db2
 B8ngQfF720UAeiCVdCkaZSR9rSH2F3KS/SRf10SPSCbaDLt+RV8b9/qhgz8larinkZNW
 TvlOd66qzySUdZZFgeGIMoEOkhFOFLzRbLNPClrfctBwgxszzatwV2sdez26/jawippA
 Mobn4akt92lcGuNzQh6JdnvbK0ywJHVPtV45yRTiME1GhPcwsKt2KPLQEb8XBpfmzy+J
 CUow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzF79DwGDIF6BO0yS8n+khSPk7bhDR5Gax462b9nwZFn0+eU7eQPxfXaCb6VTXAeKEWEmIs1Xcr2yb2luCxkjmn9b3ndE=
X-Gm-Message-State: AOJu0YznEB0V2m1gecsehxdjejEdPNCURom0icF5uqtBi7xdCecmjEsK
 X0gCAJ+c7OOuUw76SqMI0rKki5HC2U6ofBR2YywfgCMNuBwbObTzwtznxpCq4eK243YGsJvaMNd
 ngu0=
X-Google-Smtp-Source: AGHT+IG7pRZucV2pX7tEVeC3k9EOYe78N/rINrMJ7dbtG9GdYk8KtIyq0X7XFRJmyzfRif5BJbm9rw==
X-Received: by 2002:a17:902:c948:b0:1fb:8a0e:76f9 with SMTP id
 d9443c01a7336-1fc4e17ec73mr57478355ad.39.1721373686807; 
 Fri, 19 Jul 2024 00:21:26 -0700 (PDT)
Received: from [133.11.54.222] (h222.csg.ci.i.u-tokyo.ac.jp. [133.11.54.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d0703bsm7344875ad.155.2024.07.19.00.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 00:21:26 -0700 (PDT)
Message-ID: <f9cf0616-34df-42c3-a753-4dec8e2d25b5@daynix.com>
Date: Fri, 19 Jul 2024 16:21:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] target/arm/kvm: Fix PMU feature bit early
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
 <20240716-pmu-v3-2-8c7c1858a227@daynix.com>
 <CAFEAcA8tFtdpCQobU9ytzxvf3_y3DiA1TwNq8fWgFUtCUYT4hQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA8tFtdpCQobU9ytzxvf3_y3DiA1TwNq8fWgFUtCUYT4hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/07/18 21:07, Peter Maydell wrote:
> On Tue, 16 Jul 2024 at 13:50, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> kvm_arm_get_host_cpu_features() used to add the PMU feature
>> unconditionally, and kvm_arch_init_vcpu() removed it when it is actually
>> not available. Conditionally add the PMU feature in
>> kvm_arm_get_host_cpu_features() to save code.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   target/arm/kvm.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 70f79eda33cd..849e2e21b304 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -280,6 +280,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>       if (kvm_arm_pmu_supported()) {
>>           init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
>>           pmu_supported = true;
>> +        features |= 1ULL << ARM_FEATURE_PMU;
>>       }
>>
>>       if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
>> @@ -448,7 +449,6 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>       features |= 1ULL << ARM_FEATURE_V8;
>>       features |= 1ULL << ARM_FEATURE_NEON;
>>       features |= 1ULL << ARM_FEATURE_AARCH64;
>> -    features |= 1ULL << ARM_FEATURE_PMU;
>>       features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
>>
>>       ahcf->features = features;
>> @@ -1888,13 +1888,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>       if (!arm_feature(env, ARM_FEATURE_AARCH64)) {
>>           cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_EL1_32BIT;
>>       }
>> -    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
>> -        cpu->has_pmu = false;
>> -    }
>>       if (cpu->has_pmu) {
>>           cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
>> -    } else {
>> -        env->features &= ~(1ULL << ARM_FEATURE_PMU);
>>       }
>>       if (cpu_isar_feature(aa64_sve, cpu)) {
>>           assert(kvm_arm_sve_supported());
> 
> Not every KVM CPU is necessarily the "host" CPU type.
> The "cortex-a57" and "cortex-a53" CPU types will work if you
> happen to be on a host of that CPU type, and they don't go
> through kvm_arm_get_host_cpu_features().

kvm_arm_vcpu_init() will emit an error in such a situation and I think 
it's better than silently removing a feature that the requested CPU type 
has. A user can still disable the feature if desired.

Regards,
Akihiko Odaki

