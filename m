Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D78C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 03:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTZ1f-0007dm-4T; Mon, 15 Jul 2024 23:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sTZ1c-0007dA-Hn
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 23:38:49 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sTZ1S-0004Ep-43
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 23:38:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-427ad8bd88eso12100885e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 20:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1721101116; x=1721705916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kt/z4GpFD6dlASPB3/sJPzo0mAS54OGVopX+8ffrrYQ=;
 b=YmWm440VYeo+jNjpFR4W7KzNoVl5bja/kFtElVDv60OJEUVTVJb00dIbUBglOYryyO
 ELvbK1glwlMyZqhakuFifpNhLWb6UD73oPVuJbryeG9BXVz3ePfEVySUJsxB4GyfVDJG
 oWHu2wqv75vgqn8gbGYmJ1dP3ylfdu62XG5rUn+WjYZOwQmIeDmuywW+HuEfzB+ddVqV
 u9Qv2HVZwVuMXy84czohW5BG6AluCslh0L36ANVKtHDOYsqsTxWwG0PNWGw57ejrZWmw
 U1hIxWX1Uo6ws7YKmobdLvTRyuWsbkSZWDiGYSTlLkmHWEDj0+hu/frxQPt4H3OApeai
 itRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721101116; x=1721705916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kt/z4GpFD6dlASPB3/sJPzo0mAS54OGVopX+8ffrrYQ=;
 b=Qj6rpUCz2FiMHF9bnN/mcgqbmmEXOoNjFJsNMbWRfA0UZtkX2yxZSfpM/T19ppORXH
 k+AdVQAe9O1I5vbH8xChONcZJbBNUMVaQchNLxsYgSLb98b7Ahu++pbEYmTxZ+2ZRY+Q
 08siO3tLMB4lUWhAI1EfWnuveev/cSiOJKdPK31Hf94yLtqYYTVuIvfCmwd3rbUsJqhy
 Ikm5lh/DbCyZ+BXUiytoP5mmEgWWDFTwEO6yWM0HGqkkS6Jg/j1KbN+X1r3d36gtOBrM
 usly3U0A9HREdxZxPa2DuIu6mBdQJ8aiDg/KeYjwQOM0k3JPxUvn/+sxibSRMf7quMkT
 yBlA==
X-Gm-Message-State: AOJu0YzqmZEaBUDuiEZZHNTsJcmKN+SM3XfKQKpVYW4xbAdFoTfDacb7
 1b/aufSLPSBg+oL1oTexw9PaevNu01QImrVFkISwiSw9oHqmNGoIB1J+HFLSqWQ=
X-Google-Smtp-Source: AGHT+IEYLeLxVL+JlL8n/kvg2kC5tdtUnmlDlWIrb39A3GM6DfQM0aQtrDwj3zdoASZnsbqyStzu2A==
X-Received: by 2002:a05:600c:3589:b0:426:6551:3174 with SMTP id
 5b1f17b1804b1-427ba6975aemr5193765e9.29.1721101116141; 
 Mon, 15 Jul 2024 20:38:36 -0700 (PDT)
Received: from [10.11.12.72] ([90.220.10.255])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427bb9988f6sm4303705e9.1.2024.07.15.20.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 20:38:35 -0700 (PDT)
Message-ID: <4b829bf1-d31c-49eb-b18f-6d87e08c5c04@opnsrc.net>
Date: Tue, 16 Jul 2024 03:38:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V15 0/7] Add architecture agnostic code to support vCPU
 Hotplug
To: Igor Mammedov <imammedo@redhat.com>, Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 Linuxarm <linuxarm@huawei.com>, peterx@redhat.com
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <20240715155436.577d34c5@imammedo.users.ipa.redhat.com>
 <b93b570158794e28bf8c00a949afa8b4@huawei.com>
 <3848723ea2584b9b813c3d76e1e6dd59@huawei.com>
 <20240715171154.2667d187@imammedo.users.ipa.redhat.com>
Content-Language: en-GB
From: Salil Mehta <salil.mehta@opnsrc.net>
In-Reply-To: <20240715171154.2667d187@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Igor,

On 15/07/2024 15:11, Igor Mammedov wrote:
> On Mon, 15 Jul 2024 14:19:12 +0000
> Salil Mehta <salil.mehta@huawei.com> wrote:
> 
>>>   From: qemu-arm-bounces+salil.mehta=huawei.com@nongnu.org <qemu-
>>>   arm-bounces+salil.mehta=huawei.com@nongnu.org> On Behalf Of Salil
>>>   Mehta via
>>>   Sent: Monday, July 15, 2024 3:14 PM
>>>   To: Igor Mammedov <imammedo@redhat.com>
>>>   
>>>   Hi Igor,
>>>     
>>>   >  From: Igor Mammedov <imammedo@redhat.com>
>>>   >  Sent: Monday, July 15, 2024 2:55 PM
>>>   >  To: Salil Mehta <salil.mehta@huawei.com>
>>>   >
>>>   >  On Sat, 13 Jul 2024 19:25:09 +0100
>>>   >  Salil Mehta <salil.mehta@huawei.com> wrote:
>>>   >
>>>   >  > [Note: References are present at the last after the revision
>>>   > history]  >  > Virtual CPU hotplug support is being added across
>>>   > various architectures  [1][3].
>>>   >  > This series adds various code bits common across all architectures:
>>>   >  >
>>>   >  > 1. vCPU creation and Parking code refactor [Patch 1] 2. Update ACPI
>>>   > > GED framework to support vCPU Hotplug [Patch 2,3] 3. ACPI CPUs AML
>>>   > > code change [Patch 4,5] 4. Helper functions to support unrealization
>>>   > > of CPU objects [Patch 6,7]
>>>   >
>>>   >  with patch 1 and 3 fixed should be good to go.
>>>   >
>>>   >  Salil,
>>>   >  Can you remind me what happened to migration part of this?
>>>   >  Ideally it should be a part of of this series as it should be common
>>>   > for  everything that uses GED and should be a conditional part of
>>>   > GED's  VMSTATE.
>>>   >
>>>   >  If this series is just a common base and no actual hotplug on top of
>>>   > it is  merged in this release (provided patch 13 is fixed), I'm fine
>>>   > with migration  bits being a separate series on top.
>>>   >
>>>   >  However if some machine would be introducing cpu hotplug in the same
>>>   > release, then the migration part should be merged before it or be a
>>>   > part  that cpu hotplug series.
>>>   
>>>   We have tested Live/Pseudo Migration and it seem to work with the
>>>   changes part of the architecture specific patch-set.
> 
> have you tested, migration from new QEMU to an older one (that doesn't have cpuhotplug builtin)?


Just curious, how can we detect at source Qemu what version of the Qemu
destination is running. We require some sort of compatibility check but
then this is a problem not specific to CPU Hotplug?

We  are not initializing CPU Hotplug VMSD in this patch-set. I was
wondering then how can a new machine attempt to migrate VMSD state from 
new Qemu to older Qemu.

ARM vCPU Hotplug patches will be on top of this later in next Qemu cycle.


> 
>>>   
>>>   Ampere: https://lore.kernel.org/all/e17e28ac-28c7-496f-b212-
>>>   2c9b552dbf63@amperemail.onmicrosoft.com/
>>>   Oracle: https://lore.kernel.org/all/46D74D30-EE54-4AD2-8F0E-
>>>   BA5627FAA63E@oracle.com/
>>>   
>>>   
>>>   For ARM, please check below patch part of RFC V3 for changes related to
>>>   migration:
>>>   https://lore.kernel.org/qemu-devel/20240613233639.202896-15-
>>>   salil.mehta@huawei.com/
>>
>>
>> Do you wish to move below change into this path-set and make it common
>> to all instead?
> 
> it would be the best to include this with here.
> 
>>
>>
>> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
>> index 63226b0040..e92ce07955 100644
>> --- a/hw/acpi/generic_event_device.c
>> +++ b/hw/acpi/generic_event_device.c
>> @@ -333,6 +333,16 @@ static const VMStateDescription vmstate_memhp_state = {
>>       }
>>   };
>>   
>> +static const VMStateDescription vmstate_cpuhp_state = {
>> +    .name = "acpi-ged/cpuhp",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields      = (VMStateField[]) {
>> +        VMSTATE_CPU_HOTPLUG(cpuhp_state, AcpiGedState),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   static const VMStateDescription vmstate_ged_state = {
>>       .name = "acpi-ged-state",
>>       .version_id = 1,
>> @@ -381,6 +391,7 @@ static const VMStateDescription vmstate_acpi_ged = {
>>       },
>>       .subsections = (const VMStateDescription * const []) {
>>           &vmstate_memhp_state,
>> +        &vmstate_cpuhp_state,
> 
> I'm not migration guru but I believe this should be conditional
> to avoid breaking cross-version migration.
> See 679dd1a957d '.needed = vmstate_test_use_cpuhp. part


Sure, thanks for this. As I can see, the needed() function is used at
the source to decide if the state corresponding to a particular device
can be forwarded to the destination QEMU/VM. But how can this be used
to check for cross-version migration?

BTW, I've prepared V16. May I request a quick peek at:

https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v3.arch.agnostic.v16/


Above does not have the suggested migration change yet. I can add it as
a separate path


Best regards,
Salil

> 
> CCing Peter
> 
>>           &vmstate_ghes_state,
>>           NULL
>>       }
>>
>> Maybe I can add a separate patch for this in the end? Please confirm.
>>
>> Thanks
>> Salil.
> 

