Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8B1C54E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebJw-00023s-Qw; Mon, 26 Feb 2024 08:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebJu-00023e-Vd
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:47:03 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebJt-0006DS-5x
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:47:02 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a3f3d0d2787so298805166b.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 05:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708955219; x=1709560019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TNiuodzAac1FzF0eoUf6pY4f5LfypNmUEBuoUfQGFF4=;
 b=upsDIkNkYDUa4jUknsEtKbbd1Hfhrufcr4BxrqXbIAECZk2Mmnv1ty0Ag8eWnxChLP
 UNDwcokmbDw8nIF/Syo7wo4FvQoy7jOoX+l2mfozIk7j1154rYJQSgdn9XCcqpUSYDdO
 NkI2h9bNx83ffLOacgIqz39GF6RCI/l8DUTrPO/VJoAEIJxmSlQ3MjxNsNtV7KRb0WjQ
 2QRcTmPidfVrTsAS1WBtahGRWwY+vF/fUC82i4zI+XcZS4H06+1cwQOsu1En+pzceobI
 iSOX6/mMrjutuqxDxiuxkXo/Vucv+eDPgjei5kM2OcdBB9vmPPRUk1BnBatjH7xjqU3w
 A+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708955219; x=1709560019;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TNiuodzAac1FzF0eoUf6pY4f5LfypNmUEBuoUfQGFF4=;
 b=IFhBI91g3nQ895cPsBjWfx9xN7G+1Hm5rF/AMGBF2bkSaK4rn2sk+Z+jUSEfDPEjNg
 7aP73gkMvXmVFsooqyJNou1ZxvWcMnpmThKx3kHdsD/FpR1KMrYcO4qFIABiGJz5QMhL
 D6dfjHEdDUIXZeYjZkprimf4/+q3BdDgSW9FU38eW6d0KGa1VXq4qKVKmfoJp32VMfEG
 9xzcZvDnPEL3z85wimJFW/H3HUHRD9Yup9M0aXVG0a8VSPZuV6Q4DrrDOT1pQ2V2Fesh
 QkbAa5ZdyiUNKZFsATKjQkL23vJj7bAah7q8kOTWesjo9HOZUE01BZAxrzKhjALvoBcZ
 ZJNA==
X-Gm-Message-State: AOJu0YyfjcfVIo33IV/Fgyt9mfVlvkyfdowvtVfn53AYLtzASdoGxK0u
 4d5GOnFyf1s0FUxS6IyEurvMhbVij1eH6QRQesUuzjdRTslpSumS40IdNyehL/U=
X-Google-Smtp-Source: AGHT+IEFT6T+obzdqCwBvCmAWuxvgpjNWeFdXWf+gSeZU520DIfpsikylQ4fogNTjwVfmFNEQ6SllA==
X-Received: by 2002:a17:906:31d8:b0:a3e:7ef1:8c91 with SMTP id
 f24-20020a17090631d800b00a3e7ef18c91mr4203437ejf.77.1708955219462; 
 Mon, 26 Feb 2024 05:46:59 -0800 (PST)
Received: from [192.168.69.100] ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 cx4-20020a170907168400b00a42f6d48c72sm2287061ejd.145.2024.02.26.05.46.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 05:46:58 -0800 (PST)
Message-ID: <de867567-f486-4b3a-93cc-9b109e9d549a@linaro.org>
Date: Mon, 26 Feb 2024 14:46:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] hw/pci-bridge: Extract QOM ICH definitions to
 'ich_dmi_pci.h'
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
 <20240219163855.87326-7-philmd@linaro.org>
 <0841e333-3d7d-0440-a8bf-8a7fd2f0011f@eik.bme.hu>
 <19500c79-8e4a-2160-3622-dbf145655046@eik.bme.hu>
 <cee6951f-234e-4806-b6a1-147c39455f07@linaro.org>
 <055d34b8-64c6-fcc4-9bf9-b8491a50ce5f@eik.bme.hu>
 <5726ea2c-425b-40a3-80a2-9fa3503a7f4c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5726ea2c-425b-40a3-80a2-9fa3503a7f4c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/2/24 13:55, Thomas Huth wrote:
> On 20/02/2024 13.20, BALATON Zoltan wrote:
>> On Tue, 20 Feb 2024, Philippe Mathieu-Daudé wrote:
>>> On 19/2/24 19:24, BALATON Zoltan wrote:
>>>> On Mon, 19 Feb 2024, BALATON Zoltan wrote:
>>>>> On Mon, 19 Feb 2024, Philippe Mathieu-Daudé wrote:
>>>>>> Expose TYPE_ICH_DMI_PCI_BRIDGE to the new
>>>>>> "hw/pci-bridge/ich_dmi_pci.h" header.
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>> MAINTAINERS                         |  1 +
>>>>>> include/hw/pci-bridge/ich_dmi_pci.h | 20 ++++++++++++++++++++
>>>>>> include/hw/southbridge/ich9.h       |  2 --
>>>>>> hw/pci-bridge/i82801b11.c           | 11 ++++-------
>>>>>> 4 files changed, 25 insertions(+), 9 deletions(-)
>>>>>> create mode 100644 include/hw/pci-bridge/ich_dmi_pci.h
>>>>>>
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index 1b210c5cc1..50507c3dd6 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -2609,6 +2609,7 @@ F: hw/acpi/ich9*.c
>>>>>> F: hw/i2c/smbus_ich9.c
>>>>>> F: hw/isa/lpc_ich9.c
>>>>>> F: include/hw/acpi/ich9*.h
>>>>>> +F: include/hw/pci-bridge/ich_dmi_pci.h
>>>>>> F: include/hw/southbridge/ich9.h
>>>>>>
>>>>>> PIIX4 South Bridge (i82371AB)
>>>>>> diff --git a/include/hw/pci-bridge/ich_dmi_pci.h 
>>>>>> b/include/hw/pci-bridge/ich_dmi_pci.h
>>>>>> new file mode 100644
>>>>>> index 0000000000..7623b32b8e
>>>>>> --- /dev/null
>>>>>> +++ b/include/hw/pci-bridge/ich_dmi_pci.h
>>>>>> @@ -0,0 +1,20 @@
>>>>>> +/*
>>>>>> + * QEMU ICH4 i82801b11 dmi-to-pci Bridge Emulation
>>>>>> + *
>>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef HW_PCI_BRIDGE_ICH_D2P_H
>>>>>> +#define HW_PCI_BRIDGE_ICH_D2P_H
>>>>>> +
>>>>>> +#include "qom/object.h"
>>>>>> +#include "hw/pci/pci_bridge.h"
>>>>>> +
>>>>>> +#define TYPE_ICH_DMI_PCI_BRIDGE "i82801b11-bridge"
>>>>>> +OBJECT_DECLARE_SIMPLE_TYPE(I82801b11Bridge, ICH_DMI_PCI_BRIDGE)
>>>>>> +
>>>>>> +struct I82801b11Bridge {
>>>>>> +    PCIBridge parent_obj;
>>>>>> +};
>>>>>
>>>>> If this class has no fields of its own why does it need its own 
>>>>> state struct defined? You could just set .instance_size = 
>>>>> sizeof(PCIBridge) in the TypeInfo i82801b11_bridge_info below and 
>>>>> delete this struct completely as it's not even used anywhere. One 
>>>>> less needless QOM complication :-) For an example see the empty 
>>>>> via-mc97 device in hw/audio/via-ac97.c.
>>>>>
>>>>> Then you can put the OBJECT_DECLARE_SIMPLE_TYPE in 
>>>>> hw/pci-bridge/i82801b11.c where this object is defined and the 
>>>>> #define TYPE_ICH_DMI_PCI_BRIDGE in
>>>>
>>>> You don't even need OBJECT_DECLARE_SIMPLE_TYPE if there's no state 
>>>> struct. But on second look what is this object at all? It's never 
>>>> instantiated anywhere. Is it used somewhere?
>>>
>>> Here my view is we should always define QOM type names in headers
>>> and use them, in particular in the TypeInfo registration. To unify
>>> style and copy/pasting, better use the QOM DECLARE_TYPE macros.
>>> I envision that might help moving toward DSL and have HW modelling
>>> checks done externally, before starting QEMU. But then this is my
>>> view and I dunno about when we'll get that DSL in so I'm OK to
>>> revisit this patch.
>>
>> The question here is more if we need this object at all because it 
>> wasn't enstantiated before, and after your series it could be 
>> instantiated by a property that's never set. So unless I misunderstood 
>> somthing this whole thing could just be removed as dead code and let 
>> it be re-added later when it's actually implemented following whatever 
>> conventions we'll have then. No need to keep around empty placeholders 
>> that aren't used. Or does it serve any purpose?

This isn't a virtual hardware, and is well specified, I'm trying to
plug all the parts we have so the full chipset can be used to create
a dynamic machine.

> It's apparently used by some q35 configs:
> 
> $ grep -r i82801b11 docs/
> docs/config/q35-emulated.cfg:  driver = "i82801b11-bridge"
> 
>   Thomas
> 
> 


