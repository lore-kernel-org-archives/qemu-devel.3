Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D9AC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 06:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcJK1-0000IE-5g; Tue, 20 Feb 2024 01:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcJJy-0000Hw-6g
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:09:38 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcJJv-0006ga-FH
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:09:37 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4126ea3b812so1969465e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 22:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708409363; x=1709014163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=muzvncswgk08dapAN0iqRiFau0hMMeJpToiMAwgnXHI=;
 b=ri1XUfC3sXlhbSlLgw6JVPRH/4Z8IFEQQ+Fp4XxDAsd4YIroJVmXad+OtpBzLIwXR4
 XZbgsDXGkSmKk5pIrm7pitsnq1zlvGfzzAoN9fWGmdxa5u4FxXRf6aoQ0Y82vh2TQNf9
 BB0Ok5GjC9Q5duSpDa69SI6Fe1vmy8ZX4vntGAYcBwjZl0AJhjHzmkvs6sbC6BiZxQJm
 J29Ovg09EPauJErFcOHb9qs45Eid35lZ7E6Y2ocTclnPu/4dbZFz7bE0aXza4UYfetfw
 +4u9fXJD+pN7qvCI2yEnaaaWIZf/smaz3KJ6kyVQF0TeZu56/e5ds5kMIonvneZlR3ez
 AFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708409363; x=1709014163;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=muzvncswgk08dapAN0iqRiFau0hMMeJpToiMAwgnXHI=;
 b=PJGo/D7uOH99akhgiqGDF9deC5elVkhyDmZHnHqQ4wHyIMapjJhEmSPB3Dc3/+kml6
 CyIOSAKeAuzmjdDgY2Dde0NgIo4cE7rg+1fW8NlNV0mNVZWbCtFbeJTEoyIY18bWUSJw
 krv/LNeztg1zr32nZ77sc5Pk8KMmQ/SQhniN/DzZ0MGQ1k8MjDwLgNw2iUJufvSxJ3Wt
 hwQUT0klSDtPNjhiS1TkQ5pCYAMnQWRV8VjYAkkoobjqaTsLZrRo2h9Ow8DwvVKkO6o5
 z4fRKUckbheIft/Evl5tY15DwOzblDN9HY/rm1s7G64yL/edzpwmwkzs80e8cB7ubxNy
 5d2w==
X-Gm-Message-State: AOJu0Yw4latJbrxNmlwzkYNA8yYTOioPcTdb1ymhp1xGZsHF0zBza3bH
 uw5hD+IPUZzGL0F1Ca7UwjVJSMPoZIPASKD428Mt782VsDNZTuseLFAOcj5jRAY=
X-Google-Smtp-Source: AGHT+IGvxxxRyY48DvS/val+w+I4SbEnZcb0PTeIFo/MzdFuqkkhCDv/A5sErWT6rH4gL29fyQgyag==
X-Received: by 2002:a05:600c:1c1e:b0:412:1d7d:6c51 with SMTP id
 j30-20020a05600c1c1e00b004121d7d6c51mr10064121wms.6.1708409362466; 
 Mon, 19 Feb 2024 22:09:22 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 s8-20020a7bc388000000b00412260889d9sm13337417wmj.1.2024.02.19.22.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 22:09:22 -0800 (PST)
Message-ID: <cee6951f-234e-4806-b6a1-147c39455f07@linaro.org>
Date: Tue, 20 Feb 2024 07:09:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] hw/pci-bridge: Extract QOM ICH definitions to
 'ich_dmi_pci.h'
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
 <20240219163855.87326-7-philmd@linaro.org>
 <0841e333-3d7d-0440-a8bf-8a7fd2f0011f@eik.bme.hu>
 <19500c79-8e4a-2160-3622-dbf145655046@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <19500c79-8e4a-2160-3622-dbf145655046@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 19/2/24 19:24, BALATON Zoltan wrote:
> On Mon, 19 Feb 2024, BALATON Zoltan wrote:
>> On Mon, 19 Feb 2024, Philippe Mathieu-Daudé wrote:
>>> Expose TYPE_ICH_DMI_PCI_BRIDGE to the new
>>> "hw/pci-bridge/ich_dmi_pci.h" header.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> MAINTAINERS                         |  1 +
>>> include/hw/pci-bridge/ich_dmi_pci.h | 20 ++++++++++++++++++++
>>> include/hw/southbridge/ich9.h       |  2 --
>>> hw/pci-bridge/i82801b11.c           | 11 ++++-------
>>> 4 files changed, 25 insertions(+), 9 deletions(-)
>>> create mode 100644 include/hw/pci-bridge/ich_dmi_pci.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 1b210c5cc1..50507c3dd6 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2609,6 +2609,7 @@ F: hw/acpi/ich9*.c
>>> F: hw/i2c/smbus_ich9.c
>>> F: hw/isa/lpc_ich9.c
>>> F: include/hw/acpi/ich9*.h
>>> +F: include/hw/pci-bridge/ich_dmi_pci.h
>>> F: include/hw/southbridge/ich9.h
>>>
>>> PIIX4 South Bridge (i82371AB)
>>> diff --git a/include/hw/pci-bridge/ich_dmi_pci.h 
>>> b/include/hw/pci-bridge/ich_dmi_pci.h
>>> new file mode 100644
>>> index 0000000000..7623b32b8e
>>> --- /dev/null
>>> +++ b/include/hw/pci-bridge/ich_dmi_pci.h
>>> @@ -0,0 +1,20 @@
>>> +/*
>>> + * QEMU ICH4 i82801b11 dmi-to-pci Bridge Emulation
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#ifndef HW_PCI_BRIDGE_ICH_D2P_H
>>> +#define HW_PCI_BRIDGE_ICH_D2P_H
>>> +
>>> +#include "qom/object.h"
>>> +#include "hw/pci/pci_bridge.h"
>>> +
>>> +#define TYPE_ICH_DMI_PCI_BRIDGE "i82801b11-bridge"
>>> +OBJECT_DECLARE_SIMPLE_TYPE(I82801b11Bridge, ICH_DMI_PCI_BRIDGE)
>>> +
>>> +struct I82801b11Bridge {
>>> +    PCIBridge parent_obj;
>>> +};
>>
>> If this class has no fields of its own why does it need its own state 
>> struct defined? You could just set .instance_size = sizeof(PCIBridge) 
>> in the TypeInfo i82801b11_bridge_info below and delete this struct 
>> completely as it's not even used anywhere. One less needless QOM 
>> complication :-) For an example see the empty via-mc97 device in 
>> hw/audio/via-ac97.c.
>>
>> Then you can put the OBJECT_DECLARE_SIMPLE_TYPE in 
>> hw/pci-bridge/i82801b11.c where this object is defined and the #define 
>> TYPE_ICH_DMI_PCI_BRIDGE in
> 
> You don't even need OBJECT_DECLARE_SIMPLE_TYPE if there's no state 
> struct. But on second look what is this object at all? It's never 
> instantiated anywhere. Is it used somewhere?

Here my view is we should always define QOM type names in headers
and use them, in particular in the TypeInfo registration. To unify
style and copy/pasting, better use the QOM DECLARE_TYPE macros.
I envision that might help moving toward DSL and have HW modelling
checks done externally, before starting QEMU. But then this is my
view and I dunno about when we'll get that DSL in so I'm OK to
revisit this patch.

> Regards,
> BALATON Zoltan
> 
>> hw/southbridge/ich9.h and then you don't need this header at all so 
>> you don't end up with:
>>
>> 4 files changed, 25 insertions(+), 9 deletions(-)
>>
>> but really simplifying it.
>>
>> Regards,
>> BALATON Zoltan
>>
>>> +
>>> +#endif
>>> diff --git a/include/hw/southbridge/ich9.h 
>>> b/include/hw/southbridge/ich9.h
>>> index bee522a4cf..b2abf483e0 100644
>>> --- a/include/hw/southbridge/ich9.h
>>> +++ b/include/hw/southbridge/ich9.h
>>> @@ -114,8 +114,6 @@ struct ICH9LPCState {
>>>
>>> #define ICH9_D2P_SECONDARY_DEFAULT              (256 - 8)
>>>
>>> -#define ICH9_D2P_A2_REVISION                    0x92
>>> -
>>> /* D31:F0 LPC Processor Interface */
>>> #define ICH9_RST_CNT_IOPORT                     0xCF9
>>>
>>> diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
>>> index c140919cbc..dd17e35b0a 100644
>>> --- a/hw/pci-bridge/i82801b11.c
>>> +++ b/hw/pci-bridge/i82801b11.c
>>> @@ -45,7 +45,7 @@
>>> #include "hw/pci/pci_bridge.h"
>>> #include "migration/vmstate.h"
>>> #include "qemu/module.h"
>>> -#include "hw/southbridge/ich9.h"
>>> +#include "hw/pci-bridge/ich_dmi_pci.h"
>>>
>>> /*****************************************************************************/
>>> /* ICH9 DMI-to-PCI bridge */
>>> @@ -53,11 +53,8 @@
>>> #define I82801ba_SSVID_SVID     0
>>> #define I82801ba_SSVID_SSID     0
>>>
>>> -typedef struct I82801b11Bridge {
>>> -    /*< private >*/
>>> -    PCIBridge parent_obj;
>>> -    /*< public >*/
>>> -} I82801b11Bridge;
>>> +
>>> +#define ICH9_D2P_A2_REVISION                    0x92
>>>
>>> static void i82801b11_bridge_realize(PCIDevice *d, Error **errp)
>>> {
>>> @@ -103,7 +100,7 @@ static void 
>>> i82801b11_bridge_class_init(ObjectClass *klass, void *data)
>>> }
>>>
>>> static const TypeInfo i82801b11_bridge_info = {
>>> -    .name          = "i82801b11-bridge",
>>> +    .name          = TYPE_ICH_DMI_PCI_BRIDGE,
>>>     .parent        = TYPE_PCI_BRIDGE,
>>>     .instance_size = sizeof(I82801b11Bridge),
>>>     .class_init    = i82801b11_bridge_class_init,
>>


