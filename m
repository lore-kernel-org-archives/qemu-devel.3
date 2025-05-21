Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A192C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmFs-0002Bv-WD; Wed, 21 May 2025 12:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHmFr-0002BK-Pq
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:25:19 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHmFp-0003oU-0v
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:25:19 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4e15013bdc5so1690126137.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747844714; x=1748449514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YbH/cVrrukXjkwenpHpYQwy7EWjb3uHOPthagg80G9c=;
 b=FxLDVaUIfrzowpKLJAobAAq47P63rBekbA+mOH2qtQWMXM1SeEf8XIyoA3fku6JmRo
 EMqdHTalBmbqFoaDeFVuippQQq5eCys4HE1fjUWmJnBLEjPKe+La0a3dAXdCnhzmgZy3
 gSQ1T+FCMPbaHDZTPMe7DKUK9uVbarPwXW8LVJB/8XguHuRGycJF9eBVcVrXTfRRZj0c
 QtFL97cIyVDlG+zKqED+TvcysxrTeT+cXshmjhm/Wt2zIwV/XTWhsYnvLafLX9IV2MbC
 JPoSSZI128YbWdtrDklaMNeJ/oETEDOKBCR6YdsCwd2P0cG/DDhJthkN/a3FC8zoaHyh
 gNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747844714; x=1748449514;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YbH/cVrrukXjkwenpHpYQwy7EWjb3uHOPthagg80G9c=;
 b=WMtxa704Cly6paL1Tf/+aeJGVIV4t5l2Z72pYMp+rtCf8ZtCXs7v8kYX22VYasG2Iy
 uLpJAWlv0W6CgZMP1SBb5xokQiAkmqdZpkDm3wb0aGzqSbLyxjjwekkjagzskH6a+E7O
 Eao1VyuTMhOM9cH+JTLXOlu2KppNTZyir9Po0lFD995F/FiZAZ9/+JPz6V6gLEB0op0M
 SfisoHcQgDMRBnF3hT2dJvf1IevDbiHwtjhZlh+tbP12x8YqRo7Xp3OHThxDaJCDx6TI
 BGOYfGNh8hRlmALEcvXxse45dhwTZ0Cm+CH0SnCXl2DaqHzNjjfsVdH/RQauNn7MKPxC
 P3iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv8aqguHHBUh6pKvLv0AYCUF+3jS7KWCCMp2PVs23Bim9xcHb7Rhd9m2IuphMLFjAjXOthKsCxSANz@nongnu.org
X-Gm-Message-State: AOJu0YzBt8lJJQ8KUFlBbAwG2Oi8WoSUP6WZisolhRkE82YFTtryix8Z
 JeQG78mz1lP4c1lGxuMHJVi/Z5un4n7wdSGgLpThBfJuQwZY/2YmU7/sY0JiyzeSjgw=
X-Gm-Gg: ASbGncv/b67MqHE1Zbdk1X6rttyzAV1z3Vx688kuxznPtK01oDx+WduWpptZHxd7Ms4
 dj7/qe++2TazCwbLj8a0GdHl4y5bipTqNGGi6kgf5dycd3Xf4Ww514HGijRG06AMLYxNz4b+pKI
 5Lv4GVQ50og+7nxAqDPV2p1IU9fpkJQ6d39ef5E4HRRoLhRO/1Bw8SguAuoeMmncZEPcZq2BkrC
 Xh9Ni1UFmJ8/cRMwZEYzQpbaUGVgkpTtpA7LI0gu1aGfFu2bL/QWIxQO1zaIuZNo2tulJoMjaED
 HytOCmRx8wa02qmbqEAeqM61Ew808xhPqNFAU0YbdtK6WINiOr71/uLZEqGFvLFjUmSKGYi8iAf
 RWjKuoFv7yi67+tv1UdqTFzJ2iRZZtg==
X-Google-Smtp-Source: AGHT+IH1Y11dEpN/V2gN94TJImotmeLmqs/KEFLajoh2FESznKIbR/nKJLIaXO7quMhOSjzbfd7sJw==
X-Received: by 2002:a05:6102:2088:b0:4e2:86e6:3785 with SMTP id
 ada2fe7eead31-4e286e63831mr8343493137.5.1747844714195; 
 Wed, 21 May 2025 09:25:14 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:d47f:532e:8fb1:3c49:40da?
 ([2804:7f0:b401:d47f:532e:8fb1:3c49:40da])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4dfa64aa8f5sm10181858137.0.2025.05.21.09.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 09:25:13 -0700 (PDT)
Message-ID: <95bff50a-4da9-4abe-b596-95c64ab85231@linaro.org>
Date: Wed, 21 May 2025 13:24:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] hw/i386/acpi-build: Move aml_pci_edsm to a generic
 place
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-15-eric.auger@redhat.com>
 <ad7c7b84-9f12-4767-a349-df47c489c726@linaro.org>
 <2f1d15ea-82fe-4633-9791-ef9a3721b87d@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <2f1d15ea-82fe-4633-9791-ef9a3721b87d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe30.google.com
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

Hi Eric,

On 5/21/25 12:56, Eric Auger wrote:
> Hi Gustavo,
> 
> On 5/21/25 5:26 PM, Gustavo Romero wrote:
>> Hi Eric,
>>
>> On 5/14/25 14:01, Eric Auger wrote:
>>> Move aml_pci_edsm to pcihp since we want to reuse that for
>>> ARM and acpi-index support.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>>    include/hw/acpi/pcihp.h |  2 ++
>>>    hw/acpi/pcihp.c         | 53 +++++++++++++++++++++++++++++++++++++++++
>>>    hw/i386/acpi-build.c    | 53 -----------------------------------------
>>>    3 files changed, 55 insertions(+), 53 deletions(-)
>>>
>>> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>>> index 4d820b4baf..bc31dbff39 100644
>>> --- a/include/hw/acpi/pcihp.h
>>> +++ b/include/hw/acpi/pcihp.h
>>> @@ -82,6 +82,8 @@ bool build_append_notification_callback(Aml
>>> *parent_scope, const PCIBus *bus);
>>>      void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
>>>    +Aml *aml_pci_edsm(void);
>>> +
>>>    /* Called on reset */
>>>    void acpi_pcihp_reset(AcpiPciHpState *s);
>>>    diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>>> index d800371ddc..57fe8938b1 100644
>>> --- a/hw/acpi/pcihp.c
>>> +++ b/hw/acpi/pcihp.c
>>> @@ -937,6 +937,59 @@ void build_append_pci_bus_devices(Aml
>>> *parent_scope, PCIBus *bus)
>>>        }
>>>    }
>>>    +Aml *aml_pci_edsm(void)
>>> +{
>>> +    Aml *method, *ifctx;
>>> +    Aml *zero = aml_int(0);
>>> +    Aml *func = aml_arg(2);
>>> +    Aml *ret = aml_local(0);
>>> +    Aml *aidx = aml_local(1);
>>> +    Aml *params = aml_arg(4);
>>> +
>>> +    method = aml_method("EDSM", 5, AML_SERIALIZED);
>>> +
>>> +    /* get supported functions */
>>> +    ifctx = aml_if(aml_equal(func, zero));
>>> +    {
>>> +        /* 1: have supported functions */
>>> +        /* 7: support for function 7 */
>>> +        const uint8_t caps = 1 | BIT(7);
>>> +        build_append_pci_dsm_func0_common(ifctx, ret);
>>> +        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret,
>>> zero)));
>>> +        aml_append(ifctx, aml_return(ret));
>>> +    }
>>> +    aml_append(method, ifctx);
>>> +
>>> +    /* handle specific functions requests */
>>> +    /*
>>> +     * PCI Firmware Specification 3.1
>>> +     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
>>> +     *        Operating Systems
>>> +     */
>>> +    ifctx = aml_if(aml_equal(func, aml_int(7)));
>>> +    {
>>> +       Aml *pkg = aml_package(2);
>>> +       aml_append(pkg, zero);
>>> +       /* optional, if not impl. should return null string */
>>> +       aml_append(pkg, aml_string("%s", ""));
>>> +       aml_append(ifctx, aml_store(pkg, ret));
>>> +
>>> +       /*
>>> +        * IASL is fine when initializing Package with computational
>>> data,
>>> +        * however it makes guest unhappy /it fails to process such
>>> AML/.
>>> +        * So use runtime assignment to set acpi-index after initializer
>>> +        * to make OSPM happy.
>>> +        */
>>> +       aml_append(ifctx,
>>> +           aml_store(aml_derefof(aml_index(params, aml_int(0))),
>>> aidx));
>>> +       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
>>> +       aml_append(ifctx, aml_return(ret));
>>> +    }
>>> +    aml_append(method, ifctx);
>>> +
>>> +    return method;
>>> +}
>>> +
>>>    const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>>>        .name = "acpi_pcihp_pci_status",
>>>        .version_id = 1,
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index bcfba2ccb3..385e75d061 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -322,59 +322,6 @@ build_facs(GArray *table_data)
>>>        g_array_append_vals(table_data, reserved, 40); /* Reserved */
>>>    }
>>>    -static Aml *aml_pci_edsm(void)
>>> -{
>>> -    Aml *method, *ifctx;
>>> -    Aml *zero = aml_int(0);
>>> -    Aml *func = aml_arg(2);
>>> -    Aml *ret = aml_local(0);
>>> -    Aml *aidx = aml_local(1);
>>> -    Aml *params = aml_arg(4);
>>> -
>>> -    method = aml_method("EDSM", 5, AML_SERIALIZED);
>>> -
>>> -    /* get supported functions */
>>> -    ifctx = aml_if(aml_equal(func, zero));
>>> -    {
>>> -        /* 1: have supported functions */
>>> -        /* 7: support for function 7 */
>>> -        const uint8_t caps = 1 | BIT(7);
>>> -        build_append_pci_dsm_func0_common(ifctx, ret);
>>> -        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret,
>>> zero)));
>>> -        aml_append(ifctx, aml_return(ret));
>>> -    }
>>> -    aml_append(method, ifctx);
>>> -
>>> -    /* handle specific functions requests */
>>> -    /*
>>> -     * PCI Firmware Specification 3.1
>>> -     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
>>> -     *        Operating Systems
>>> -     */
>>> -    ifctx = aml_if(aml_equal(func, aml_int(7)));
>>> -    {
>>> -       Aml *pkg = aml_package(2);
>>> -       aml_append(pkg, zero);
>>> -       /* optional, if not impl. should return null string */
>>> -       aml_append(pkg, aml_string("%s", ""));
>>> -       aml_append(ifctx, aml_store(pkg, ret));
>>> -
>>> -       /*
>>> -        * IASL is fine when initializing Package with computational
>>> data,
>>> -        * however it makes guest unhappy /it fails to process such
>>> AML/.
>>> -        * So use runtime assignment to set acpi-index after initializer
>>> -        * to make OSPM happy.
>>> -        */
>>> -       aml_append(ifctx,
>>> -           aml_store(aml_derefof(aml_index(params, aml_int(0))),
>>> aidx));
>>> -       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
>>> -       aml_append(ifctx, aml_return(ret));
>>> -    }
>>> -    aml_append(method, ifctx);
>>> -
>>> -    return method;
>>> -}
>>> -
>>>    /*
>>>     * build_prt - Define interrupt routing rules
>>>     *
>>
>> EDSM is not called from anywhere. _DSM method actually calls the PDSM,
>> already defined
>> in pcihp.c and generated by aml_pci_pdsm(). build_acpi_pci_hotplug(),
>> which calls
>> aml_pci_pdsm(), properly creates the PDSM method. Then in
>> build_append_pcihp_slots()
>> the a _DSM is defined per slot and inside it there is a call to PDSM,
>> so I understand
>> we should actually stick to the PDSM in pcihp.c instead of EDSM.
> 
> I see build_append_pci_bus_devices -> aml_pci_static_endpoint_dsm
> adds a _DSM method which eventually calls EDSM.

Yes, but I meant in the final generated ACPI AML code.


> aml_pci_device_dsm builds another _DSM implementation which calls PDSM.
> 
> As we use build_append_pci_bus_devices and we are likely to have a _DSM
> implementation that calls EDSM method, I think we shall have it in the
> aml. What do I miss?

Maybe some condition in build_append_pci_bus_devices() of:

         if (pdev->acpi_index &&
             !object_property_get_bool(OBJECT(pdev), "hotpluggable",
                                       &error_abort)) { ... }


is not met?

Does your _DSM method in the machine's ACPI has a call to EDSM? I don't
see it. In my case it's the PDSM that is being called:

gromero@xps13:/tmp$ grep -n PDSM dsdt.dsl
1910:        Method (PDSM, 5, Serialized)
2047:                    Return (PDSM (Arg0, Arg1, Arg2, Arg3, Local0))
gromero@xps13:/tmp$ grep -n EDSM dsdt.dsl
1959:        Method (EDSM, 5, Serialized)
gromero@xps13:/tmp$

I also confirmed that PDSM is what is being used by reverting this patch and
dropping the aml_append(pci0_scope, aml_pci_edsm()); in 15/22.

But also, why shouldn't we use the PDSM defined already in pcihp.c? This is
indeed crafted for the acpi-pcihp-hotplug device as I understand it.


Cheers,
Gustavo

> Thank you for the comprehensive review!
> 
> Cheers
> 
> Eric
>>
>> EDSM, being used in i386 code, feels a outdated PDSM, so maybe PDSM
>> should be used there,
>> although a different story or a clean up for later. I'm not sure what
>> "static endpoint"
>> means in the context of EDSM.
>>
>> Hence this patch can be dropped in my understanding and:
>>
>> aml_append(pci0_scope, aml_pci_edsm()) in 15/22 too, without any
>> prejudice to the
>> hotplugging and unplugging in this series.
>>
>>
>> Cheers,
>> Gustavo
>>
> 


