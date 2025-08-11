Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC91C87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 13:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulSLw-0008Jk-D5; Mon, 11 Aug 2025 09:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulSLs-0008J5-Cg
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:14:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulSLk-0000R6-Cg
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:14:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-458ba079338so33712825e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754918039; x=1755522839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1Vf6DemP29pm+5eGz56PNcfCPAyi0gzIgp3lFXVeRfc=;
 b=cru9tK0WfE45+K16wMA9lPu/WWXYf6B2GB7o9gWOOY2IcFLRAHDDVP1K8gGo0WMBku
 +QXwxVAamBBZDqOG/vgD/CnwVTaHgmyLJKOxuqT/osQai9AwAY3G2ap+A9YDLFT3yvjJ
 zs/M6M6ac1BJoI7ZMFUatJ0Nt2ITR9vsO02qbuA0wSJz/z459T+J6YoHC5QG0SBnUzYA
 xg4ptojw6SyhdmqgOhcurSMvvIpOYbrkVp+272tKYiu4OcZpSG2G2+iE7wLRkZe4AWCo
 2ars3ap9lHnePO2EkhyetKltFnQW9pooPtjFRNf/kTyyEa6H0BIMCZimg5i/8KSC9Hs8
 sPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754918039; x=1755522839;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Vf6DemP29pm+5eGz56PNcfCPAyi0gzIgp3lFXVeRfc=;
 b=jKwNapxALWRmSAARrQzsiUhGtZD/pNTzT04lH/VCf66I9YouGjQpUAdjnOnO5cThG5
 JRB1GbUkvYJrNfZlYkVGI+NJ02RXr2ExPdefHZlbhsbmjyams6HCiqlQgKc+ZxtWLgFa
 7ezs27gGyO/B+SXGlo6gzKaLZd1POSjaIUVlB7VlPK7MtoKAE6/c8mbawIgUXLqJiQlN
 cQpW4S6i33FGerzXa4HVXcCozzrEVkw44WnfFKhfkZA10uprQg0hh6jEj3H376o6zopE
 5m6touYLJgbEQRFo6EouSYafZjMIcNR6CaqMUNZJLgmmbHDL/x6VrTbk0UVHmfHp9+8F
 Dc1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMIpVdsDWYRIyVogrbVpdVdHB0qtlBMgzXJtcHT1LoH8oAHNyUohMKJK8O+/KRUo42PB4C4qZOse9S@nongnu.org
X-Gm-Message-State: AOJu0Yydd1yir3WgYTPkmFHxsaCJ5Yl5OLaQecnOJzmtt/RW2c8Bnxqj
 sPCea9PTP5kNZq9WfQlb3cFwYmUAG5R9bPk81mKWVBBDKNPWS8tPeJxnFV30gNlv3ek=
X-Gm-Gg: ASbGncugv8QCxu42Bi37v70FOv0j2wifM9wIyFOEThJE6nTDzJDk9cYtEodyTFY3Say
 NhbKtlkYg5oKPTd4iJ01A0XebBP2uWtD4p4j3v4QNO31Qr5HtTcu2s/39K7ayT5qPKp30tDWXyW
 Jg6p7WssRg0EfWoM9+5s42FcD5a6YfS+aLh9xmXjD/XF+iq53/XUEIW13DwZjxmWg6UJPnl0YJy
 YOUTm9IsUOhaNiHxU7hOQ/Z5+2kEtt7nJivbH7/Dso18d3kw7gn2SIB+Ycf6v8HqBLHIihtXD1t
 W9kmmJsCGG0m2bgUsnC1SdTG7SbTxhiHhvdHBoB66KTDnSQcSA/GY5yAAi6puSlOf3OcmW7fyej
 vxX0t3PMcV1SJLffRDtHPeeo7fXi21UuUgeC35FdqrOkHm3xs0Y2WiE1TpkrITrnO+P4JKAg=
X-Google-Smtp-Source: AGHT+IHtXlkJF52pKXyI4ynue+qvczxNrS82n04iCAA6R4HiYeMOKqtRF0NXzoVqtZ/71Ou288UyXg==
X-Received: by 2002:a05:600c:1f89:b0:458:bade:72c5 with SMTP id
 5b1f17b1804b1-459f51c662emr132435815e9.8.1754918038728; 
 Mon, 11 Aug 2025 06:13:58 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e586eef8sm251813365e9.21.2025.08.11.06.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 06:13:58 -0700 (PDT)
Message-ID: <7de5cc4e-474c-4e42-ae60-70d1fafa837f@linaro.org>
Date: Mon, 11 Aug 2025 15:13:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/13] hw/arm, target/arm: nested virtualisation on HVF
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
 <20250808070137.48716-6-mohamed@unpredictable.fr>
 <caeafe09-4c2c-48bf-9f46-f6e739931b26@linaro.org>
Content-Language: en-US
In-Reply-To: <caeafe09-4c2c-48bf-9f46-f6e739931b26@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 11/8/25 14:56, Philippe Mathieu-Daudé wrote:
> On 8/8/25 09:01, Mohamed Mediouni wrote:
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>   hw/arm/virt.c         |  9 ++++++---
>>   target/arm/hvf-stub.c | 15 +++++++++++++++
>>   target/arm/hvf/hvf.c  | 41 +++++++++++++++++++++++++++++++++++++++--
>>   target/arm/hvf_arm.h  |  3 +++
>>   4 files changed, 63 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 59e6c2b9df..91d8cd9363 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -817,8 +817,7 @@ static void create_gic(VirtMachineState *vms, 
>> MemoryRegion *mem)
>>           g_assert_not_reached();
>>       }
>> -    if (kvm_enabled() && vms->virt &&
>> -        (revision != 3 || !kvm_irqchip_in_kernel())) {
>> +    if (kvm_enabled() && vms->virt && (revision != 3 || ! 
>> kvm_irqchip_in_kernel())) {
>>           error_report("KVM EL2 is only supported with in-kernel GICv3");
>>           exit(1);
>>       }
>> @@ -2281,7 +2280,8 @@ static void machvirt_init(MachineState *machine)
>>           exit(1);
>>       }
>> -    if (vms->virt && !kvm_enabled() && !tcg_enabled() && ! 
>> qtest_enabled()) {
>> +    if (vms->virt && !kvm_enabled() && !tcg_enabled()
>> +       && !hvf_enabled() && !qtest_enabled()) {
>>           error_report("mach-virt: %s does not support providing "
>>                        "Virtualization extensions to the guest CPU",
>>                        current_accel_name());
>> @@ -2553,6 +2553,9 @@ static void virt_set_virt(Object *obj, bool 
>> value, Error **errp)
>>       VirtMachineState *vms = VIRT_MACHINE(obj);
>>       vms->virt = value;
>> +#if defined(CONFIG_HVF) && defined(__aarch64__)
>> +    hvf_arm_el2_enable(value);
>> +#endif
>>   }

> We don't have hvf_arm_el1_enable(). I think we just want to always
> provide the most performant configuration to users.
> IOW, we don't need hvf_arm_el2_enable(). I'd just always enable EL2
> (if supported) in hvf_arm_get_host_cpu_features().

We create vCPUs in machvirt_init(). Upon vCPU INITialization, we check
host features. Then during REALIZation, we check the QOM properties.
If 'virt' flag is disabled, machvirt_init() sets "has_el2" property
to false, effectively setting ARMCPU::has_el2 field to %false.
In arm_cpu_realizefn(), if ARMCPU::has_el2 we unset ARM_FEATURE_EL2.

