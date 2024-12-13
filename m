Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A773E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 13:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM5pG-0006Kl-8H; Fri, 13 Dec 2024 08:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5p8-0005r0-7o
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:35:18 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5p6-0001PZ-I2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:35:17 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-435004228c0so21181625e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 05:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734096915; x=1734701715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6C/IoCpQeK++/iWStUYGcPGDiX9QdJKmpK7/wwLjKlk=;
 b=flExZpeEYFqU72aQj8JnNR6DIRiyefj3nBKzniYE+OdiA+flQB5BsQRD8iq42iG/v9
 E6b2eyqP5BhbubM5iLcpuO1BG2LXbfuesWoIJNRuQ70+ScH8awn4meRd69rsMvjZO2H8
 GTuWWEWGxD5KCNttzpOgc4C6R9LmY6lWG6lJHhvQzzA7k8sfk7fJMEeZnCeR2Wfi01dh
 glzL5r1YLqUlk4/jwqKGBhv+W19EWgOn2EQRGx/c++T7r9QY1b8hzk5YWFHxcrWkPxlZ
 0uLjKWeSYASOLlW/1oSV/IbqnHUvdtgDVEZJtZwqml4g+kSdcDy7vTk1s+9IPPm3uyBj
 H/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734096915; x=1734701715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6C/IoCpQeK++/iWStUYGcPGDiX9QdJKmpK7/wwLjKlk=;
 b=F6d74gs3CZnJk1+vqwdvAG4nYbPH3QmxH64AZ6gvxR8cVjI7gfL9RsX926fc+DRUxq
 42yx8Y1hjvPMGQxxAqH/icUFMYixm9YrKDqSMRc7XZ0GH2I06pz9SCwRl4YPVOD24iaq
 LaveyY9PcHWoyiDCA45Lfg0PRWBDM1teKkgVsca1w7xfATwU0w5HwdhurzfTUJqGXHa/
 UXES3LyFMpvbqN4ETtA3ALdqn4Muod2pCq7gLCVAdSyYmkOulMOn4yEEi/PgoGOhXzMO
 FJPcuCjfo8nhmhxAfVKXqJczJixzlQk/MPACGl8CBcmvYGtw3s4Pn/xLCNpP+hLlDnbU
 1swA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHDr42TBzczMovAplkgAKW/mo4hdT2MI+9JMHS2t6AQ4ru1gL6axaHW+XMv3PruzCPVijfZ/unCEJE@nongnu.org
X-Gm-Message-State: AOJu0YxhnjswHI5PvAbXmtkK8RCZLTxKhrqI3azCKaDMUPpowpeBbVpJ
 lCTZskDiq18Nkbo/UV9fdtJeQlWYAw76cUrBIoasmQZBPapyyAqdGTfx94Yi6jY=
X-Gm-Gg: ASbGnctuRi4/NRdZeY6qjbos58W7g3lJK21FROY5mqb/Az1kMMm0D4ayb+33YhWXhVY
 GaP1yTEytpBvyeCauWsDy4B9FIKe/c9HxIQBJ6emr+gzQXSHLLKHkzxlq5sf04QOZ7oYhBKcxI8
 ym965IInyZtCHq2iATMcGLCE0TylEXfxokoTfps0FGCVUIpxxdfOo5YgyC8uy15GT8wGmbQ+ux2
 J3Nfw+StF7vCKGurqxnhPcABsP6YavScQkKBw/4UlgOWukLrODJflEEpKQSmWj6T7ZakauCf60V
 nKIG/TZWZmAaMeOqNLTU+CvUYzrO1A==
X-Google-Smtp-Source: AGHT+IFtazAlc26oYB8eOV3KJLmhO69qDo14/pB9SK0aySnbQHg0h+8/8tP3cwbbHbgCmaTNDdr8PA==
X-Received: by 2002:a05:600c:1e19:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-4362aa5005fmr27932675e9.16.1734096913625; 
 Fri, 13 Dec 2024 05:35:13 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a5005sm7145418f8f.41.2024.12.13.05.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 05:35:13 -0800 (PST)
Message-ID: <eb62155a-39ef-4931-898a-84fcc5a86243@linaro.org>
Date: Fri, 13 Dec 2024 14:35:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] hw/pci: Have PCI_BUS implement
 TYPE_FW_CFG_DATA_GENERATOR_INTERFACE
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jiahui Cen <cenjiahui@huawei.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Bernhard Beschow <shentey@gmail.com>
References: <20241206181352.6836-1-philmd@linaro.org>
 <20241206181352.6836-4-philmd@linaro.org> <Z1wbODM1V5E7oCU6@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z1wbODM1V5E7oCU6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 13/12/24 12:32, Daniel P. Berrangé wrote:
> On Fri, Dec 06, 2024 at 07:13:49PM +0100, Philippe Mathieu-Daudé wrote:
>> The FW_CFG_DATA_GENERATOR allows any object to produce
>                             ^
>                            ^^^
>                           ^^^^^  insert word 'interface'
> 
>> blob of data consumable by the fw_cfg device. Implement
> 
>   ^ 'a' as in 'a blob of...'
> 
>> that for PCI bus objects.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/pci/pci.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 1416ae202c3..8844251eceb 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -46,6 +46,7 @@
>>   #include "hw/pci/msix.h"
>>   #include "hw/hotplug.h"
>>   #include "hw/boards.h"
>> +#include "hw/nvram/fw_cfg.h"
>>   #include "qapi/error.h"
>>   #include "qemu/cutils.h"
>>   #include "pci-internal.h"
>> @@ -216,11 +217,41 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
>>       return NUMA_NODE_UNASSIGNED;
>>   }
>>   
>> +static GByteArray *pci_bus_fw_cfg_gen_data(Object *obj, Error **errp)
>> +{
>> +    PCIBus *bus = PCI_BUS(obj);
>> +    GByteArray *byte_array;
>> +    uint64_t extra_hosts = 0;
>> +
>> +    if (!bus) {
>> +        return NULL;
>> +    }
> 
> Returning NULL without setting 'errp'.
> 
> On the one hand I could see returning NULL, without errp, as being
> useful semantics for "I have no data to add currently". THe callers
> don't appear to distinguish NULL without errp, from NULL with errp.
> They just propagate a failure return code up the stack.
> 
> The API docs for 'get_data' method don't say you can return NULL
> without setting errp either.

Good catch. API updated here:
https://lore.kernel.org/qemu-devel/20241213133352.10915-4-philmd@linaro.org/

Thanks,

Phil.

> 
>> +
>> +    QLIST_FOREACH(bus, &bus->child, sibling) {
>> +        /* look for expander root buses */
>> +        if (pci_bus_is_root(bus)) {
>> +            extra_hosts++;
>> +        }
>> +    }
>> +
>> +    if (!extra_hosts) {
>> +        return NULL;
> 
> Same.
> 
>> +    }
>> +    extra_hosts = cpu_to_le64(extra_hosts);
>> +
>> +    byte_array = g_byte_array_new();
>> +    g_byte_array_append(byte_array,
>> +                        (const void *)&extra_hosts, sizeof(extra_hosts));
>> +
>> +    return byte_array;
>> +}


