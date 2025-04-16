Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C2CC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 06:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4wCg-0005IC-L0; Wed, 16 Apr 2025 02:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4wCd-0005He-U8
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 02:24:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4wCR-0006BL-Kr
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 02:24:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so52897845e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744784680; x=1745389480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ywtgg0QcmgzCtu2Bdhe053g8gGjG5gdsspYd3ytd+tk=;
 b=XHlICTXQG9lnXWuiHJUDOa/hVxIe0k8kS3pdoI2AY4IbAFtVCmLON/mKNRVCeyYHYw
 3Q2ZPkMQOpFcpHSraANNxT3uG1OJ7jdNkNFHhLO/nfMvl+JlROiML/3oVA5hGFUV/Ucv
 nOtO7g/E9Mm+2ipblK1q9SpPmDbshCe0Fo14Ke/hWiixcR9e5vNWnSq3u1NsNZwE7+3p
 z2cAGRdAPAeu+VwGgrfn1DQTAYIwG0TGXe4xeIyZTFZwcKnPETINy7uSICSvq+7rBoa6
 /OCt9aW12+qQmOerW07Up5XFmQ05s795Dh7ZtENVraEonQOQmjGLKXMEU5650frMM4K/
 pZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744784680; x=1745389480;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ywtgg0QcmgzCtu2Bdhe053g8gGjG5gdsspYd3ytd+tk=;
 b=hf5GkargcA320XJV8QcIgPtA9Iwzmtx0O241BcLONETBfD86Q+Tb8FMADej7ZgM3TQ
 aH/eDywGniQM0VEpSJ06Jt/kvZ8FPgCCEiIOLRyDNmmp1VL4wInYl6K3TDGe7di6HlJv
 KOEWVeqwj0HTF/jfuFI2obyGCde36Wq6RDS7w293H69DOjW46ZoBckneDv+fuYS/lFHh
 0q/nyBAi6TBWiAOi9Wf8AGjV03B4CALADORcZj0fC05jJLwW0WKItGPugy3eHoMPzeuz
 WaK4SHq+Rv+OqXZHTsi047GyGM+zynNwn1lqENOsbokTCEB9tbtuiB9Qvu3W65KWJzVc
 EsEg==
X-Gm-Message-State: AOJu0YwmrAR8r2yNQlz1zMTrZ3Z8gnuRDwlmgtLcG0TH3/TLIdSDbSXA
 JXo7CZw3sS2yrecKyO0zKlLD+g8NeJoMDt83poYxzaRBcDAvaEgtcLsaatWTecQ=
X-Gm-Gg: ASbGncsVfq/r3RkfNL8LZ3dx3INWDL9aondv3nWzs+OMZSlScFpdB4QaRXGnmCt2Gzv
 apZOKMiHDr7MKzTBV01xsrmrzJ2uHNWrzG0c+QGspI4NkasSLTyzx+3dDMvYaLepTe7L4FwRWsx
 0YmRyPKwqs+jAwH1HasFDn8QFl45auZ5AhdTupe1mKf3grBSom77zYw2WVGjQXxFzjEunT3BDWM
 VGMEVjtAPRYZTuym+TtL0pA3r6Q0V/skSYNz+tHoEVEGfyfqTVfN3+7ujp8h7D0os/0sn5YaBxm
 L6gCIMt8DJgD+FsrndMgfBadNYz4TgKNWOKOq8GtuLa+QR1aHdRMECr0WcStmcY9JN7Vsl9HS91
 +ldNF5Q==
X-Google-Smtp-Source: AGHT+IEseZRrQ/79hAiuFMGHz6fdINJsSEmqFa9LDfRLz4GjdTbOJ6GQTKwEgGbG/YA6OrNNY2hn1Q==
X-Received: by 2002:a5d:588f:0:b0:39c:30d8:a80 with SMTP id
 ffacd0b85a97d-39ee5b167admr354913f8f.19.1744784680355; 
 Tue, 15 Apr 2025 23:24:40 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b54224bsm10841535e9.38.2025.04.15.23.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 23:24:39 -0700 (PDT)
Message-ID: <8e48b403-6f30-415d-b8e1-30fc772f1d7d@linaro.org>
Date: Wed, 16 Apr 2025 08:24:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 05/13] acpi: Send the GPE event of suspend and
 wakeup for x86
To: Annie Li <annie.li@oracle.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204133.2955-1-annie.li@oracle.com> <87cydeepp8.fsf@draig.linaro.org>
 <5a567f2d-31d4-442c-b68c-ed85491d77d4@oracle.com>
 <6d771164-bac1-4d99-8e05-0bf65a3351ca@linaro.org>
 <07dfb619-d563-4735-ba39-6ff4561d368b@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <07dfb619-d563-4735-ba39-6ff4561d368b@oracle.com>
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

On 15/4/25 23:48, Annie Li wrote:
> 
> On 4/15/2025 11:29 AM, Philippe Mathieu-Daudé wrote:
>> Hi Annie,
>>
>> On 15/4/25 03:24, Annie Li wrote:
>>>
>>> On 4/14/2025 11:18 AM, Alex Bennée wrote:
>>>> Annie Li <annie.li@oracle.com> writes:
>>>>
>>>>> The GPE event is triggered to notify x86 guest to suppend
>>>>> itself. The function acpi_send_sleep_event will also
>>>>> trigger GED events on HW-reduced systems where ACPI GED
>>>>> sleep event is supported.
>>>>>
>>>>> Signed-off-by: Annie Li <annie.li@oracle.com>
>>>>> ---
>>>>>   hw/acpi/core.c                       | 10 ++++++++++
>>>>>   include/hw/acpi/acpi.h               |  1 +
>>>>>   include/hw/acpi/acpi_dev_interface.h |  1 +
>>>>>   3 files changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>>>>> index 58f8964e13..00a9d226f0 100644
>>>>> --- a/hw/acpi/core.c
>>>>> +++ b/hw/acpi/core.c
>>>>> @@ -359,6 +359,16 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
>>>>>       return -1;
>>>>>   }
>>>>> +void acpi_send_sleep_event(void)
>>>>> +{
>>>>> +    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF,
>>>>> NULL);
>>>> Is it a fair assumption there will only ever be one QOM object that
>>>> provides the TYPE_ACPI_DEVICE_IF interface on a system?
>>>
>>> I supposed it was, but I might be wrong(seeing some classes have the 
>>> same interface). Please correct me if I've missed something, thank you!
>>
>>     /**
>>      * object_resolve_path_type:
>>      * @path: the path to resolve
>>      * @typename: the type to look for.
>>      * @ambiguous: (out) (optional): location to store whether the
>>      *             lookup failed because it was ambiguous, or %NULL.
>>      *             Set to %false on success.
>>
>> Since you use ambiguous=NULL, your code will only set %obj if there
>> is exactly ONE device implementing the ACPI_DEVICE interface created.
>>
>> So far IIUC nothing forbids creating multiple ones, so if you expect
>> only one, you should add code to handle the "2 or more" case. Or at
>> least add a comment.
> Actually, there is only one QOM object here.
> There are 3 classes involves with TYPE_ACPI_DEVICE_IF interface.
> PC, Q35, GED.
> For x86 system, the PC or Q35 machine doesn't use GED event, instead,
> it sends the GPE event.
> For microvm/ARM/virt system, GED device is used, its own 
> TYPE_ACPI_DEVICE_IF
> is involved.
> All these objects do not exist at the same time, so it is safe to assume 
> only one QOM
> object exists here.

I agree this is the case as of today, but I'm not sure about tomorrow.
AFAICT nothing prohibit instanciating more than 1 type implementing
TYPE_ACPI_DEVICE_IF.

Anyway we are just trying to be more cautious here; up to the
maintainer.

Regards,

Phil.

> 
> Thanks
> Annie
>>
>> Regards,
>>
>> Phil.
>>
>>>>> +
>>>>> +    if (obj) {
>>>>> +        /* Send sleep event */
>>>>> +        acpi_send_event(DEVICE(obj), ACPI_SLEEP_STATUS);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>   static void acpi_notify_wakeup(Notifier *notifier, void *data)
>>>>>   {
>>>>>       ACPIREGS *ar = container_of(notifier, ACPIREGS, wakeup);
>>>>> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
>>>>> index d1a4fa2af8..64d3ff78ed 100644
>>>>> --- a/include/hw/acpi/acpi.h
>>>>> +++ b/include/hw/acpi/acpi.h
>>>>> @@ -184,6 +184,7 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, 
>>>>> uint32_t addr);
>>>>>   void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
>>>>>                            AcpiEventStatusBits status);
>>>>> +void acpi_send_sleep_event(void);
>>>>>   void acpi_update_sci(ACPIREGS *acpi_regs, qemu_irq irq);
>>>>> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/ 
>>>>> acpi/ acpi_dev_interface.h
>>>>> index 68d9d15f50..1cb050cd3a 100644
>>>>> --- a/include/hw/acpi/acpi_dev_interface.h
>>>>> +++ b/include/hw/acpi/acpi_dev_interface.h
>>>>> @@ -13,6 +13,7 @@ typedef enum {
>>>>>       ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>>>>>       ACPI_VMGENID_CHANGE_STATUS = 32,
>>>>>       ACPI_POWER_DOWN_STATUS = 64,
>>>>> +    ACPI_SLEEP_STATUS = 128,
>>>>>   } AcpiEventStatusBits;
>>>>>   #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
>>


