Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBF3C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5T6r-0003VM-IQ; Thu, 17 Apr 2025 13:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T6p-0003Sq-QR
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:33:07 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T6n-0001Zq-No
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:33:07 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so981726b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744911184; x=1745515984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=88YhsxnLsPVfL39k4DZVV3f8W2Zlkak4W9vvWBfVo7I=;
 b=jXYVfcI+Vturui3juGO7cut2+ozXfi0fmMUESZq7WIaksFi7/oHtQ2QG3iwqac/vIP
 9zG400MgGbiADEpJOEHIGQmxNkA0Ij/fPUwgL3GcFvMYwKk7efW4J9FhWhlgfmO2AzRx
 LifB5v/JaMj0SNvh7kzWTmg5IYpJrlljbK7gye7koboRzALmGy8M4HzVd8GYFzMNVMix
 TnzFc+Sg2lq6BVEOIQ/3kxoiPAOElTJ3HyTzNbOoM0wBJ7l/kWgyniHucM5KXgFSKXQb
 OcIrV34PKAw3gMrdIgQ/iTUGoB0cGjMll9qKmBpoJbmyfYkgMhzeqeMMCBi12/UtOsC+
 j0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744911184; x=1745515984;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=88YhsxnLsPVfL39k4DZVV3f8W2Zlkak4W9vvWBfVo7I=;
 b=Z2iAB3ue3rwRfkg3DxU8DRuNLM9UOzEHOrnKBVTGZGQwib87CYkue5hs7ym5sCXgQf
 VW6/3UgWDmor3Y2x8WSDrsR1TEZz2Utwwz3614ZekNE3gX9C/qpnWGiUeS/XRsZB7Tou
 46n1YY5btsxHV+YfUg2yDRzELHrp1L/a7TrVNw+LhWQ9/Hr5O/GqKdjQ2JXo/OijKPq5
 GWt2Ii/uJaZGNK1PkyUD0BuO04X3QZDyCVPLcO2sZugseXv9YfGgbVzAogVnsxqVywp0
 Xn4B5uPiu9d5mr7Turv5dc3TqQS+E3yjmAn7pQwe/J074sknNtuBS+H4xASkBPLbiEw2
 Xr7Q==
X-Gm-Message-State: AOJu0YxYJuqQcExeoAUq7NA+oEonZ7cu1dEDk41Ayo9VB37L+Mw4c0ym
 OXUanPwT69oADjhc1z7zrkjAsQ+laBGthtj4/4OtqWDnCJ45Myd0Lkh+Nvwrw00=
X-Gm-Gg: ASbGncsehlxcP2B0hS5+9Q24rcXTw0AI+jLB1PwBohlaYBk/xn9esrdwPPJp+2Y5iQ6
 byr4i11f7+mKX8tr4Vb38T7yQLbiPfV+dqlZf6M9HGxBAfh02b/W7GUUm3DrQm8ke5QMswKEGhj
 1mtJgKoAg5rqYVE7WhaxNCBww0lDDvSBjvH9EwIKOavRjzUF0CH7dmLX3vVbg6Sc3tbBwdySTiy
 JGJOntKwvdydYRBJIkri/YyCS2Q9nPnBMXU3uUIdwoc16JgQMW/0XSZRkOArw35wBTc2VQC1pnC
 +vss6FFuxrcftCXH8YMmrcej86VdY2J9J2sfZRr56MpkNbX/dLa5
X-Google-Smtp-Source: AGHT+IEqzTf4kt+lEqdyAy/srWp6I6aMtRgG2WbPA1+yhkC8xAyqDvILbJkd3zLCb0vbwOvTrWAFKw==
X-Received: by 2002:a05:6a20:e68f:b0:1f5:6abb:7cbb with SMTP id
 adf61e73a8af0-203ca71dae8mr393190637.23.1744911183917; 
 Thu, 17 Apr 2025 10:33:03 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db13ad7d5sm151857a12.31.2025.04.17.10.32.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 10:33:03 -0700 (PDT)
Message-ID: <a7240b57-6f86-4172-9607-7324dd1b13a3@linaro.org>
Date: Thu, 17 Apr 2025 14:32:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 05/13] acpi: Send the GPE event of suspend and
 wakeup for x86
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Annie Li <annie.li@oracle.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204133.2955-1-annie.li@oracle.com> <87cydeepp8.fsf@draig.linaro.org>
 <5a567f2d-31d4-442c-b68c-ed85491d77d4@oracle.com>
 <6d771164-bac1-4d99-8e05-0bf65a3351ca@linaro.org>
 <07dfb619-d563-4735-ba39-6ff4561d368b@oracle.com>
 <8e48b403-6f30-415d-b8e1-30fc772f1d7d@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <8e48b403-6f30-415d-b8e1-30fc772f1d7d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x436.google.com
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

Hi Annie,

On 4/16/25 03:24, Philippe Mathieu-Daudé wrote:
> On 15/4/25 23:48, Annie Li wrote:
>>
>> On 4/15/2025 11:29 AM, Philippe Mathieu-Daudé wrote:
>>> Hi Annie,
>>>
>>> On 15/4/25 03:24, Annie Li wrote:
>>>>
>>>> On 4/14/2025 11:18 AM, Alex Bennée wrote:
>>>>> Annie Li <annie.li@oracle.com> writes:
>>>>>
>>>>>> The GPE event is triggered to notify x86 guest to suppend
>>>>>> itself. The function acpi_send_sleep_event will also
>>>>>> trigger GED events on HW-reduced systems where ACPI GED
>>>>>> sleep event is supported.
>>>>>>
>>>>>> Signed-off-by: Annie Li <annie.li@oracle.com>
>>>>>> ---
>>>>>>   hw/acpi/core.c                       | 10 ++++++++++
>>>>>>   include/hw/acpi/acpi.h               |  1 +
>>>>>>   include/hw/acpi/acpi_dev_interface.h |  1 +
>>>>>>   3 files changed, 12 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>>>>>> index 58f8964e13..00a9d226f0 100644
>>>>>> --- a/hw/acpi/core.c
>>>>>> +++ b/hw/acpi/core.c
>>>>>> @@ -359,6 +359,16 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
>>>>>>       return -1;
>>>>>>   }
>>>>>> +void acpi_send_sleep_event(void)
>>>>>> +{
>>>>>> +    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF,
>>>>>> NULL);
>>>>> Is it a fair assumption there will only ever be one QOM object that
>>>>> provides the TYPE_ACPI_DEVICE_IF interface on a system?
>>>>
>>>> I supposed it was, but I might be wrong(seeing some classes have the same interface). Please correct me if I've missed something, thank you!
>>>
>>>     /**
>>>      * object_resolve_path_type:
>>>      * @path: the path to resolve
>>>      * @typename: the type to look for.
>>>      * @ambiguous: (out) (optional): location to store whether the
>>>      *             lookup failed because it was ambiguous, or %NULL.
>>>      *             Set to %false on success.
>>>
>>> Since you use ambiguous=NULL, your code will only set %obj if there
>>> is exactly ONE device implementing the ACPI_DEVICE interface created.
>>>
>>> So far IIUC nothing forbids creating multiple ones, so if you expect
>>> only one, you should add code to handle the "2 or more" case. Or at
>>> least add a comment.
>> Actually, there is only one QOM object here.
>> There are 3 classes involves with TYPE_ACPI_DEVICE_IF interface.
>> PC, Q35, GED.
>> For x86 system, the PC or Q35 machine doesn't use GED event, instead,
>> it sends the GPE event.
>> For microvm/ARM/virt system, GED device is used, its own TYPE_ACPI_DEVICE_IF
>> is involved.
>> All these objects do not exist at the same time, so it is safe to assume only one QOM
>> object exists here.
> 
> I agree this is the case as of today, but I'm not sure about tomorrow.
> AFAICT nothing prohibit instanciating more than 1 type implementing
> TYPE_ACPI_DEVICE_IF.
> 
> Anyway we are just trying to be more cautious here; up to the
> maintainer.

Annie, very soon probably the GPEX device will use the TYPE_ACPI_DEVICE_IF as well.
GPEX is used in Arm machines (like "virt") and due to the support for ACPI PCI hotplug,
which needs to be routed through the PCIe controller's hotplug handlers and the ACPI pcihp
device before the hotplug event is finally delivered to the OS via the GED device, it also
will use this ACPI interface.

I can think of something when adding the ACPI PCI hotplug support on machine with GPEX,
but even for future cases, could you please add at least a check for the ambiguity and
assert for no ambiguity here?

I suspect the only case we can have an ambiguity is when we have a device that
needs to do something more complex and then deliver an event via GED, so specifically
here for the sleep button I think it's ok to, in case of ambiguity, select the GED
device by default.


Cheers,
Gustavo

