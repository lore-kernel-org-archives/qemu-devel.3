Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A7DC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 05:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td0TY-0006Ei-6l; Wed, 29 Jan 2025 00:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1td0TT-0006EK-Kr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 00:18:52 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1td0TQ-0005JN-3a
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 00:18:50 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2156e078563so91123975ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 21:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738127925; x=1738732725;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+MvKBDTYqZ4kgG+IAuEhkVM5rhrVIL9eA78RgLiixmk=;
 b=CCTVoGessg73LeCpnDe6txkjSo4jLeH0RwHwKNL37fS4LepRbbeOI4qyYue2vyiwHa
 lLmT8h9CRQDcNwpQV+4dsUGUXx/StyJm0QxkZWA6ms20SfEAV5++eB/MhY8Jq1A0FHQS
 uXmTs7PTa1ps5Lldd67ZcALblwOxdmrjBdKNDAkMX+smw3J8vmBzndYfa6lizF3ej32q
 PubqN7C7dv1fyBW/tV6ea5ssxzHXmDq4G4LjSNq2EB1OO2JGlWaWh+BRstxKs5QQJ9kQ
 M+hMqKa9+RLgU+TsHqLBJHRcPOAp/iNiWdqkqB5wW2T1AUpHUyAw85cpmX/hq/YXAEDr
 zRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738127925; x=1738732725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+MvKBDTYqZ4kgG+IAuEhkVM5rhrVIL9eA78RgLiixmk=;
 b=Q4ztQakr5ExUVbudev7OnKQdbH5Say5F+dJ5SQlsF+PNXBVE2/OJHmBZSOZo8GudiZ
 Z90Y7uXjs0S4dTleeq2CEVFVJfJxSEfCSUv78TUrQARgKLzAuIVFMGcaBHfKe0vJAMzA
 eeKL7kmiuhY20LjsJzn77EXEDdS7vE3d6OgaNngjgIc6FKIptzf46FxJ5qM6bNGQllVy
 +k1xQQZID5WGVd8YkXBZzVu643giYighwfgqAaz19eypN2AlGIJzl28p5/IGQENDt7kw
 awdxd/dhtoejVSqHVtPojj70FzJdVS1N3zM/b1m40x+3RJxWCBJjSdhSbQs4SgywL82I
 5/ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWooFZsIvt6MtlEuF5SunjcNPGFBHOy5+smn4S15YH9oB9vTOZv8gk7IgK3UPzhrtIBvL3PiLZYX8fy@nongnu.org
X-Gm-Message-State: AOJu0YwRcvqK+sL0DdgWpLMbIWV/TO/YZhQUHkickJX+3sDegUIHEy+l
 FmcQ11iRb/6Da3sE7a/lOmWT9mqbthYFWFW8EqnSiTH3iKfxZcX5umrLA1C8omobFPHlA3FvLzf
 ehBY=
X-Gm-Gg: ASbGncsBdHlIKvijYY2f2wutG3uiZZR4psn+P2Y3P8F/wKQxEs3u8d/wYxhJmY/eJFd
 kKY28deCrtz8GkOYpWK6Cmi9EBvTqPh2OEtShAuKuKBm+T1AcQET1rtZMnYRIibYgXjhLrvkMO8
 sOLUyyPHqSzPpdk0JTzLNH6eW4zz6cNGbHLtDKqRYrXjsi6zu5uciH1gUyLdROE7jvydPOMOrsP
 CujiS0fehDKzIqq7lqN0R4kop+ZMdiL2NuTZYBe0irfRqfAX3ddGfJIwY75Oo23zt2W19u+O9I/
 PoXBJzQIv87gW87pYucGLP2SQ5Qe
X-Google-Smtp-Source: AGHT+IHNV33fcZHTRms+0VcI1kW4iI9FQyT3CGxyPaVhJDp2GhW9NkzGc0l25U9aBMjLUxXYJZCR1w==
X-Received: by 2002:a17:903:287:b0:215:cbbf:8926 with SMTP id
 d9443c01a7336-21dd7dddeabmr32201765ad.35.1738127925290; 
 Tue, 28 Jan 2025 21:18:45 -0800 (PST)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414db7fsm89756735ad.176.2025.01.28.21.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 21:18:44 -0800 (PST)
Message-ID: <f3c2af5f-43f9-45f7-871e-ad572b17449a@daynix.com>
Date: Wed, 29 Jan 2025 14:18:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] target/arm: Always add pmu property for Armv7-A/R+
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 devel@daynix.com
References: <20250104-pmu-v5-1-be9c8777c786@daynix.com>
 <CAFEAcA9NzHeo+V8FpXDBjPK9n2i+LDVCxe1AS8z7O9DX9Cvzuw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA9NzHeo+V8FpXDBjPK9n2i+LDVCxe1AS8z7O9DX9Cvzuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2025/01/28 23:48, Peter Maydell wrote:
> On Sat, 4 Jan 2025 at 07:10, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> kvm-steal-time and sve properties are added for KVM even if the
>> corresponding features are not available. Always add pmu property for
>> Armv7+. Note that the property is added only for Armv7-A/R+ as QEMU
>> currently emulates PMU only for such versions, and a different
>> version may have a different definition of PMU or may not have one at
>> all.
> 
> This isn't how we generally handle CPU properties corresponding
> to features. The standard setup is:
>   * if the CPU can't have feature foo, no property
>   * if the CPU does have feature foo, define a property, so the
>     user can turn it off

Is that really standard? The patch message says kvm-steal-time and sve 
properties are added even if the features are not available. Looking at 
other architectures, I can confirm that IvyBridge, an x86_64 CPU, has a 
property avx512f that can be set to true though the physical CPU model 
does not have one. I believe the situation is no different for RISC-V too.

> 
> See also my longer explanation in reply to this patch in v4:
> 
> https://lore.kernel.org/all/CAFEAcA_HWfCU09NfZDf6EC=rpvHn148avySCztQ8PqPBMFx4_Q@mail.gmail.com/

It explains well why the PMU of ARMv7 is different from other features 
like avx512f on x86_64 or RISC-V features; the architecture does not 
allow feature detection. However, as I noted in an earlier email, it 
also means explicitly disabling the PMU on ARMv7 is equally dangerous as 
enabling the PMU. So I see two logical design options:

1. Forbid to explicitly disable or enable the PMU on ARMv7 at all to 
avoid breaking the guest.
2. Allow explicitly disabling or enabling the PMU on ARMv7 under the 
assumption that the property will be used only by experienced users.

> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> The "pmu" property is added only when the PMU is available. This makes
>> tests/qtest/arm-cpu-features.c fail as it reads the property to check
>> the availability. Always add the property when the architecture defines
>> the PMU even if it's not available to fix this.
> 
> This seems to me like a bug in the test.
> 
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index dcedadc89eaf..e76d42398eb2 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1761,6 +1761,10 @@ void arm_cpu_post_init(Object *obj)
>>
>>       if (!arm_feature(&cpu->env, ARM_FEATURE_M)) {
>>           qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_hivecs_property);
>> +
>> +        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
>> +            object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
>> +        }
>>       }
>>
>>       if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
>> @@ -1790,7 +1794,6 @@ void arm_cpu_post_init(Object *obj)
>>
>>       if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
>>           cpu->has_pmu = true;
>> -        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
>>       }
>>
>>       /*
> 
> This would allow the user to enable the PMU on a CPU that
> says it doesn't have one. We don't generally permit that.
> 
> thanks
> -- PMM


