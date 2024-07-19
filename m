Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EBFC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 16:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUqUD-0001xE-DL; Fri, 19 Jul 2024 12:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sUqUC-0001rp-6O
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:36 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sUqUA-00045T-99
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:35 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70b12572bd8so813024b3a.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721406573; x=1722011373;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TWuFYjkE1q20mT6m9Gz+SjZGLVtg8tkx2StoOgf/mng=;
 b=qvjBbed+ly81tI1wL6gE0SbEvA0KgrBkIPq+ZCyLxS33tbo7cTZFBRW8XDtCv+l3Gy
 lRrYZ10lqr9NwUS6kdNP/HUFGgwb8cbYswJLhNecjU9kTDebrpnNCanNTBLOhT+aEN6z
 CGYqQz5uduHDBdEfFgRnXvS71YVZAdntoTfUTCbyI/6nLG/r65s0Mk9qU1JHa0XKQI/s
 cXNu5VrjksvTgKvHnaqc3tLyMyKJtm60gcD7bG8IJJirilgavoKJtc6eC4Pa6n4/+Nm1
 dTvI2aQMxlOvaw+tK5Xh7hEBwCOE6xSwWu0fmPqHS6eYW+Tq+LDAuEGO2RqZUQF36xP9
 XIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721406573; x=1722011373;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TWuFYjkE1q20mT6m9Gz+SjZGLVtg8tkx2StoOgf/mng=;
 b=i5HY31QYuEfCbC9lnCYqgfFL7hOdgfiq9psir6xpaFmh+a9V5noR48ivuWMBcXsXV0
 3nYQjaRL3rujShEpoYxXbeC2MvSEMJizuwQuAitRr+ftkqe4f1NFWD/zUAUS3gUCNyEh
 YCiSzVMNduxHGoaz93Hupenl4qxre/zbKCvwQ3XvQLK/BMYTCToQVydNrsoEDQEmUsCG
 16xRXJRC5g2RhUoveioMfQYb0FtCQpT6hzrE8RMKeXpQ6jMbGclS1TR5E7znq9XPBTxG
 N9VtBjSKE/D+3+3/53bmonZmtSHVEb/vv7ndwkm3+tRIEh6eRCSytKWbGLVYJLbcUZBd
 z0RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgfWnwF1Rg+sCyM5CJkN6RQ1VvURHF+yCv7EXtKJ2Ie2jnIu+M+vzW62Ux1VFqitVS7meFav/BwActEmNubEiBPRAAMPA=
X-Gm-Message-State: AOJu0YyjzQeogwx+ht1HUuZ6pCSap+OEyPb3XbtzxEqxLY1zh0Bg0yxN
 WDgb+wXqWhToy1pq+DUbCb+HTDIp7wTpDHf0pYgHbL3b2TUOaHe0GxWeoHQIKxo=
X-Google-Smtp-Source: AGHT+IEKT4AGXtfvIyGaqgqG/ujci4q9QMV+Yb5g27ubDgaaGctBNWqX4OR++3iFt+dPhMFsXZWTiQ==
X-Received: by 2002:a05:6a00:2353:b0:70b:8190:d555 with SMTP id
 d2e1a72fcca58-70ce4f43908mr10405084b3a.32.1721406572554; 
 Fri, 19 Jul 2024 09:29:32 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff5587e4sm1371596b3a.135.2024.07.19.09.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 09:29:32 -0700 (PDT)
Message-ID: <414c64cb-7d01-4e63-83ea-90eca0de0942@daynix.com>
Date: Sat, 20 Jul 2024 01:29:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] target/arm/kvm: Fix PMU feature bit early
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
 <20240716-pmu-v3-2-8c7c1858a227@daynix.com>
 <CAFEAcA8tFtdpCQobU9ytzxvf3_y3DiA1TwNq8fWgFUtCUYT4hQ@mail.gmail.com>
 <f9cf0616-34df-42c3-a753-4dec8e2d25b5@daynix.com> <87cyn9a7yn.fsf@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87cyn9a7yn.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
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

On 2024/07/19 21:21, Cornelia Huck wrote:
> On Fri, Jul 19 2024, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
>> On 2024/07/18 21:07, Peter Maydell wrote:
>>> On Tue, 16 Jul 2024 at 13:50, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> kvm_arm_get_host_cpu_features() used to add the PMU feature
>>>> unconditionally, and kvm_arch_init_vcpu() removed it when it is actually
>>>> not available. Conditionally add the PMU feature in
>>>> kvm_arm_get_host_cpu_features() to save code.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    target/arm/kvm.c | 7 +------
>>>>    1 file changed, 1 insertion(+), 6 deletions(-)
>>>>
>>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>>> index 70f79eda33cd..849e2e21b304 100644
>>>> --- a/target/arm/kvm.c
>>>> +++ b/target/arm/kvm.c
>>>> @@ -280,6 +280,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>>>        if (kvm_arm_pmu_supported()) {
>>>>            init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
>>>>            pmu_supported = true;
>>>> +        features |= 1ULL << ARM_FEATURE_PMU;
>>>>        }
>>>>
>>>>        if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
>>>> @@ -448,7 +449,6 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>>>        features |= 1ULL << ARM_FEATURE_V8;
>>>>        features |= 1ULL << ARM_FEATURE_NEON;
>>>>        features |= 1ULL << ARM_FEATURE_AARCH64;
>>>> -    features |= 1ULL << ARM_FEATURE_PMU;
>>>>        features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
>>>>
>>>>        ahcf->features = features;
>>>> @@ -1888,13 +1888,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>>        if (!arm_feature(env, ARM_FEATURE_AARCH64)) {
>>>>            cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_EL1_32BIT;
>>>>        }
>>>> -    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
>>>> -        cpu->has_pmu = false;
>>>> -    }
>>>>        if (cpu->has_pmu) {
>>>>            cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
>>>> -    } else {
>>>> -        env->features &= ~(1ULL << ARM_FEATURE_PMU);
>>>>        }
>>>>        if (cpu_isar_feature(aa64_sve, cpu)) {
>>>>            assert(kvm_arm_sve_supported());
>>>
>>> Not every KVM CPU is necessarily the "host" CPU type.
>>> The "cortex-a57" and "cortex-a53" CPU types will work if you
>>> happen to be on a host of that CPU type, and they don't go
>>> through kvm_arm_get_host_cpu_features().
>>
>> kvm_arm_vcpu_init() will emit an error in such a situation and I think
>> it's better than silently removing a feature that the requested CPU type
>> has. A user can still disable the feature if desired.
> 
> OTOH, if we fail for the named cpu models if the kernel does not provide
> the cap, but silently disable for the host cpu model in that case, that
> also seems inconsistent. I'd rather keep it as it is now.

There are two perspectives of consistency:
1) The initial value of pmu
2) The behavior with the pmu value

This change introduces inconsistency for 1); the host cpu model will 
have pmu=off by default and the other cpu models will keep default 
pmu=on value on a system that does not support PMU. It still keeps 
consistency for 2); it fails if the user sets pmu=on for any cpu model 
on such a system.

We should align 1) for better consistency, but I don't think such a 
change would be useful. It is likely that something is wrong with the 
system when the system reports a cpu model but it doesn't support its 
feature. I think that is the reason why we assert 
kvm_arm_sve_supported() for SVE; however I don't think such an assertion 
would help either because kvm_arm_vcpu_init() will fail anyway.

Regards,
Akihiko Odaki

