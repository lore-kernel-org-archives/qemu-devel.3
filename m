Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D23C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 13:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1realS-0004l8-V8; Mon, 26 Feb 2024 08:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1realM-0004kk-DD
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:11:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1realJ-0007Kb-WD
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:11:20 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412a4094197so7634785e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 05:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708953076; x=1709557876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/R2bL+M9dUVKr8g/NClBmRCfyT3gposfc7TKPOmTGQ0=;
 b=DIf5eTWyiW2s738E1YxEuyZ8MVPb18zFfoNN51W6R2vDFIwQ7fJ6u2EyvgtI6BIVfL
 iIAodHe7ymvyEYibf5QYXIm2PI5FY6B6q9QNNyly0EcNxeB5vQuGb3/aCJglZjJwbkHh
 XAaHSCjUtQD1JH4Fa35g3fYxSc1zIMPFghTCSckaNGenneb/frjERPEMxZKscUoZydmR
 n4exsMmrpgy2SVGi0B//G0yRWm/IYorSa6uecUQv0vSGnQg1JZq/vWasal91Dkq5qinV
 ES1HkwQEZEY1VP3a0/ncvtlKRSguKOpGlNRsK1chfKKhJVpzrPRyVpibTWIrMcu20Itk
 isLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708953076; x=1709557876;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/R2bL+M9dUVKr8g/NClBmRCfyT3gposfc7TKPOmTGQ0=;
 b=CdipMy2mVYKLFiz+A0eOdiG4/wCsf+QotUmbfHT97BpjoXlFiV87pFXS+wZUlzVQ4A
 8P3SZWAqTItfrbcxjUo7g7vLC2RLaiXU5Aowpi2jv5u469NmxoepOeAGIpTxceNlgxI8
 itv3IEgtjmbp32ecyGAMTQBl8VJAZoD5qYwzecvL3eaqgLv5HFd0bkBJXsqIrHP9sTvc
 1v3+hQjiC8e1yzGdLqaNyOS9zQO47scDomUvgLnvNjIxD7pnVKgonrYJk+BZN1NTH0e5
 rCH+dd4HlkkZYThOp6nBnAU5a3c2v7kpOJKevCIybN/Z8X/QlQ7oGkzBLDTAVWU8J6Yp
 D23g==
X-Gm-Message-State: AOJu0YwiHzk8Cnj5g40kBvP4+YkhH1G+Zg8aTEwkkSgLg3c4+em/ggVv
 IPCZPspbhkBPVFYOg5HYjmwjjN1rgjfj8DcJhENmi8SGVNa2dB8LmGEFt8xGnc0=
X-Google-Smtp-Source: AGHT+IE5l1OmLV3cnE5T199DbCjAwNgAUcIvdVj8Q+S5M5Z3KRu3eY34w6/EqU3fOhKLwlWuFrUz7w==
X-Received: by 2002:a5d:628b:0:b0:33d:b2dd:7fbf with SMTP id
 k11-20020a5d628b000000b0033db2dd7fbfmr4443937wru.21.1708953075579; 
 Mon, 26 Feb 2024 05:11:15 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 f1-20020adfe901000000b0033d8b1ace25sm8347663wrm.2.2024.02.26.05.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 05:11:14 -0800 (PST)
Message-ID: <e8389171-1ae7-4955-9b5b-ac0ad261654b@linaro.org>
Date: Mon, 26 Feb 2024 14:11:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] hw/pci-bridge: Extract QOM ICH definitions to
 'ich9_dmi.h'
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240226111416.39217-1-philmd@linaro.org>
 <20240226111416.39217-9-philmd@linaro.org>
 <5bab87f9-aeee-3aa5-d695-4fa2128130a1@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5bab87f9-aeee-3aa5-d695-4fa2128130a1@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 26/2/24 14:01, BALATON Zoltan wrote:
> On Mon, 26 Feb 2024, Philippe Mathieu-Daudé wrote:
>> Expose TYPE_ICH_DMI_PCI_BRIDGE to the new
>> "hw/pci-bridge/ich9_dmi.h" header.
> 
> Since this is effectively an empty object (that's not even instantiated 
> by default) I still think that instead of adding even more files for it 
> all this could just be moved to hw/isa/lpc_ich9.c and define there as an 
> internal object and drop the OBJECT_DECLARE_SIMPLE_TYPE(I82801b11Bridge, 
> ICH_DMI_PCI_BRIDGE) and just use the size of the superclass as it's 
> instance size. That just adds the realize function and a type definition 
> and gets rid of boilerplate scattered around the source tree which just 
> adds complexity for no reason. But I don't care too much about it, just 
> wanted to say again that if something can be kept simple I'd prefer that 
> over making it more complex and for this device it looks already too 
> complex for what it does or used for.

My understanding was project coherency and style is preferred over
simplifications / optimizations, so we prefer explicit TYPE_FOO
and corresponding OBJECT_DECLARE_XXX() in a public include/hw/foo
header -- because it will end up copy/pasted --, but I might be
wrong.

> Regards,
> BALATON Zoltan
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> MAINTAINERS                               |  1 +
>> include/hw/pci-bridge/ich9_dmi.h          | 20 ++++++++++++++++++++
>> include/hw/southbridge/ich9.h             |  2 --
>> hw/pci-bridge/{i82801b11.c => ich9_dmi.c} | 11 ++++-------
>> hw/pci-bridge/meson.build                 |  2 +-
>> 5 files changed, 26 insertions(+), 10 deletions(-)
>> create mode 100644 include/hw/pci-bridge/ich9_dmi.h
>> rename hw/pci-bridge/{i82801b11.c => ich9_dmi.c} (95%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0849283287..52282c680e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2618,6 +2618,7 @@ F: hw/i2c/smbus_ich9.c
>> F: hw/isa/lpc_ich9.c
>> F: include/hw/acpi/ich9*.h
>> F: include/hw/i2c/ich9_smbus.h
>> +F: include/hw/pci-bridge/ich9_dmi.h
>> F: include/hw/southbridge/ich9.h
>>
>> PIIX4 South Bridge (i82371AB)
>> diff --git a/include/hw/pci-bridge/ich9_dmi.h 
>> b/include/hw/pci-bridge/ich9_dmi.h
>> new file mode 100644
>> index 0000000000..7cf5d9d9b2
>> --- /dev/null
>> +++ b/include/hw/pci-bridge/ich9_dmi.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + * QEMU ICH4 i82801b11 dmi-to-pci Bridge Emulation
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_PCI_BRIDGE_ICH9_DMI_H
>> +#define HW_PCI_BRIDGE_ICH9_DMI_H
>> +
>> +#include "qom/object.h"
>> +#include "hw/pci/pci_bridge.h"
>> +
>> +#define TYPE_ICH_DMI_PCI_BRIDGE "i82801b11-bridge"
>> +OBJECT_DECLARE_SIMPLE_TYPE(I82801b11Bridge, ICH_DMI_PCI_BRIDGE)
>> +
>> +struct I82801b11Bridge {
>> +    PCIBridge parent_obj;
>> +};
>> +
>> +#endif
>> diff --git a/include/hw/southbridge/ich9.h 
>> b/include/hw/southbridge/ich9.h
>> index bee522a4cf..b2abf483e0 100644
>> --- a/include/hw/southbridge/ich9.h
>> +++ b/include/hw/southbridge/ich9.h
>> @@ -114,8 +114,6 @@ struct ICH9LPCState {
>>
>> #define ICH9_D2P_SECONDARY_DEFAULT              (256 - 8)
>>
>> -#define ICH9_D2P_A2_REVISION                    0x92
>> -
>> /* D31:F0 LPC Processor Interface */
>> #define ICH9_RST_CNT_IOPORT                     0xCF9
>>
>> diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/ich9_dmi.c
>> similarity index 95%
>> rename from hw/pci-bridge/i82801b11.c
>> rename to hw/pci-bridge/ich9_dmi.c
>> index c140919cbc..927e48bf2e 100644
>> --- a/hw/pci-bridge/i82801b11.c
>> +++ b/hw/pci-bridge/ich9_dmi.c
>> @@ -45,7 +45,7 @@
>> #include "hw/pci/pci_bridge.h"
>> #include "migration/vmstate.h"
>> #include "qemu/module.h"
>> -#include "hw/southbridge/ich9.h"
>> +#include "hw/pci-bridge/ich9_dmi.h"
>>
>> /*****************************************************************************/
>> /* ICH9 DMI-to-PCI bridge */
>> @@ -53,11 +53,8 @@
>> #define I82801ba_SSVID_SVID     0
>> #define I82801ba_SSVID_SSID     0
>>
>> -typedef struct I82801b11Bridge {
>> -    /*< private >*/
>> -    PCIBridge parent_obj;
>> -    /*< public >*/
>> -} I82801b11Bridge;
>> +
>> +#define ICH9_D2P_A2_REVISION                    0x92
>>
>> static void i82801b11_bridge_realize(PCIDevice *d, Error **errp)
>> {
>> @@ -103,7 +100,7 @@ static void 
>> i82801b11_bridge_class_init(ObjectClass *klass, void *data)
>> }
>>
>> static const TypeInfo i82801b11_bridge_info = {
>> -    .name          = "i82801b11-bridge",
>> +    .name          = TYPE_ICH_DMI_PCI_BRIDGE,
>>     .parent        = TYPE_PCI_BRIDGE,
>>     .instance_size = sizeof(I82801b11Bridge),
>>     .class_init    = i82801b11_bridge_class_init,
>> diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
>> index f2a60434dd..d746487193 100644
>> --- a/hw/pci-bridge/meson.build
>> +++ b/hw/pci-bridge/meson.build
>> @@ -1,6 +1,6 @@
>> pci_ss = ss.source_set()
>> pci_ss.add(files('pci_bridge_dev.c'))
>> -pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))
>> +pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('ich9_dmi.c'))
>> pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
>> pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: 
>> files('pcie_root_port.c', 'gen_pcie_root_port.c'))
>> pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: 
>> files('pcie_pci_bridge.c'))
>>


