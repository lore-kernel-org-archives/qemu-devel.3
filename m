Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC98BC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 16:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYTIX-0006YW-TW; Mon, 29 Jul 2024 12:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYTIS-0006Ac-1z
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 12:32:28 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYTIN-0005U9-Tt
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 12:32:27 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70d399da0b5so2975453b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722270739; x=1722875539;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NP0mnjphVBIb1VHUp9w1Gbv9MySDgOtzxAXgvoRoCWk=;
 b=kl3CesCekBJDDxKvOYQz8Hl2iLD2rOxZu+bYHKTSjuPVm2/yHm4FlAmvDb77/pJsoV
 54/T8JefZP+Twp1hiPWOwjl/LkzkbRlFSPCuAL+L2Q3onIaBdzl4YI5IA0LxR0v2/xSZ
 VMdR5I8eVpY1XVON8P5VZYJUUKv9Yt+oNurRu94/Hx/HUBM8eQtog/S6TUURffEG4Zpc
 RZryfq7v7AZPim28IHAAta5tq0g8WgMOp4HVLVPFnE9rdEkKrGvB+wHotqUV1lWmx0/2
 A5Q7beHkFlaHBMYez9vlrLg3CdBswcTd8G3MFEd0dQu6hDqZD6rMk6MlAgOUk8h15GBA
 hGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722270739; x=1722875539;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NP0mnjphVBIb1VHUp9w1Gbv9MySDgOtzxAXgvoRoCWk=;
 b=IfLifsWBd0Bx00j6MTMHA1OmufUc2v1Qf3/5jZPBJ3ylcH05/LQcYMGuUFWjAg70IM
 kn6tnWHvuN36vuKtFCGV9kRhAQtT7lGam9rRQ83mbWm9bR0XDCJThq978iDwMenqSJ3m
 7D3fSCpQy0KW2CP2tywGAim+C8mjd29GdfoSEImejVfToAbsoDue1iEYhNph95uXGR9N
 QPr06wt7aLmHVW8rSM823xL2aAs9b1UNDSHOscWXxNXnKw+5gqvsdLoAI/CYu2GKEVFZ
 ud6JklM6EHDQiVKhx3AvaX3c5sysIeDv+9HcKOA3jsXfWfcVDALlNn9NIAUHUHmOQdKd
 +i1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy+nwuJ9Fehgs54J3CCzXD7wDONe2aAL4pkMLS4Xyt9jnZp32M81k9cD+Q4z6+hoy+VKCi4bPYHXEC63zosc80pMehfDY=
X-Gm-Message-State: AOJu0YzNTewPOKBqb1E5IO71mEjD1+62nIJkUMcS7Kh+g6J9K1fjq6h0
 duVDbubIvq97dNV2i44KCE5yLqT09vvRS4bcXQT0gxN6Z75y0FjxkTLfYiTGhnQ=
X-Google-Smtp-Source: AGHT+IE8USeonXb4Pm9/EG3A3k5KbT5WMV9i2oo6wxOG6M5W2IsdmVYvAs1TCLj8GNJj8VLKjiJU2g==
X-Received: by 2002:a05:6a21:3406:b0:1c3:18f9:16d8 with SMTP id
 adf61e73a8af0-1c4a1511038mr10516471637.52.1722270739318; 
 Mon, 29 Jul 2024 09:32:19 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead7120easm7010598b3a.55.2024.07.29.09.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 09:32:18 -0700 (PDT)
Message-ID: <361cec8b-cd35-416b-b3d2-9e6d87981edd@daynix.com>
Date: Tue, 30 Jul 2024 01:32:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] target/arm: Always add pmu property for Armv7-A/R+
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
 <20240720-pmu-v4-3-2a2b28f6b08f@daynix.com>
 <CAFEAcA_HWfCU09NfZDf6EC=rpvHn148avySCztQ8PqPBMFx4_Q@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA_HWfCU09NfZDf6EC=rpvHn148avySCztQ8PqPBMFx4_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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

On 2024/07/30 0:13, Peter Maydell wrote:
> On Sat, 20 Jul 2024 at 10:31, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> kvm-steal-time and sve properties are added for KVM even if the
>> corresponding features are not available. Always add pmu property for
>> Armv8. Note that the property is added only for Armv7-A/R+ as QEMU
>> currently emulates PMU only for such versions, and a different
>> version may have a different definition of PMU or may not have one at
>> all.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   target/arm/cpu.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 19191c239181..c1955a82fb3c 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1741,6 +1741,10 @@ void arm_cpu_post_init(Object *obj)
>>
>>       if (!arm_feature(&cpu->env, ARM_FEATURE_M)) {
>>           qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_hivecs_property);
>> +
>> +        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
>> +            object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
>> +        }
> 
> Not every V7 CPU has a PMU[*]. Unfortunately for PMUv1 the
> architecture did not define an ID register field for it,
> so there's no ID field you can look at to distinguish
> "has PMUv1" from "has no PMU". (For PMUv2 and later you
> can look at ID_DFR0 bits [27:24]; or for AArch64
> ID_AA64DFR0_EL1.PMUVer.) This is why we have the
> ARM_FEATURE_PMU feature bit. So the correct way to determine
> "does this CPU have a PMU and so it's OK to add the 'pmu'
> property" is to look at ARM_FEATURE_PMU. Which is what
> we already do.
> 
> Alternatively, if you want to make the property always
> present even on CPUs where it can't be set, you need
> to have some mechanism for having the user's attempt to
> enable it fail. But mostly for Arm at the moment we
> have properties which are only present when they're
> meaningful. (I'm not opposed to changing this -- it would
> arguably be cleaner to have properties be per-class,
> not per-object, to aid in introspection. But it's a big
> task and probably not easy.)

Why not disabling PMU fail for V7 then? If the guest cannot know the 
presence or the lack of PMUv1, disabling PMUv1 for a V7 CPU that has one 
is as wrong as enabling PMUv1 for a V7 CPU lacking PMUv1.

Regards,
Akihiko Odaki

