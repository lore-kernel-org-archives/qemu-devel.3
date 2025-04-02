Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9EBC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 05:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzqCS-0005wG-Fw; Wed, 02 Apr 2025 00:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzqCL-0005vF-HB
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 00:59:34 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzqCJ-0006PW-CH
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 00:59:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so35361765e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 21:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743569969; x=1744174769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GOruClMNTit57F3ZC8/M8MmBjldweiifKC68p7wA4Ho=;
 b=HwAiXiiKI0GqzDKvD7nGUKUVpsK0TGARyVn9jCIXfqXRavJvacjCVYWFtRI7xUZCdt
 bcQqb8ZxrtD5a+trKxyEBpgmcHZhG2jKh97Fmprpup1Px95thJ+rfmD1FCkFlLyL1iQ+
 5Our4FUUmm8t7O6g9+Oz/uzZKBkBN0md8SEigSeNGQlvqmmZh68xvSOdf4R66LcmdMdM
 GmVzx66z9HUMSAjqdSVvz8445AMsDImbMIzIy//LLSgDe/sx1KrRvYea/uLVqkvnkx5M
 gUW72PhZTDXItM+OEuhEs4SuK5QJ2jVCOkX4GF1eGJTlq1l3nEUnI9KXDac2n75KYXh1
 OFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743569969; x=1744174769;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GOruClMNTit57F3ZC8/M8MmBjldweiifKC68p7wA4Ho=;
 b=qrDcD+ynSC72Nz9r1rOZjK5E8uAN9VoAcjfZwlwghKdxcfjZ4NPqc/xkaMP8lvsz02
 or7OhKGkB1uuzKFodadKoTaVNfOWB/o5wtRzK213Sw+hzUI2Zc//7IQywdtyXtes24jY
 zSVkjAYcGcNbN+aGYHsGOqmq38wtSbBtv1Tzw6rVF35CN/AAe5iKbUFvjKarINtsVRYs
 5WY0yGcPcss6qdzCnfdwQPs3DfbnmAyW/hDBwdjyDHsciQluv+ImANo9SZH1IVRkDNHx
 CYRB1kS35SF99efUFpltvHeKhOaqr+5/dDO+cdmsAdoeMDsRb5WIYm9/+mxyncAwISnA
 +oWg==
X-Gm-Message-State: AOJu0YzodQf+bP7NbFmT0I4Q2b9ycj48xwVo0RQkPvREwdB5JB+IIBH4
 944oiUjPyX/o1IeLDxk2vrEepicp0vANFLa1wut8G6APPEN+8MOoreWzw+w3exgg2t9/fmR2/Wm
 g
X-Gm-Gg: ASbGnctyfW05wU73eMQKJr/BREMRAgaiejuhGxX+0dbtXMUyr6Xc+LLPkgnS8mGxNhj
 2rD05cL4NoKoiMcwLPwP1d4OWvHV8ZK0omMTyB1z07GXx8Q1TKDuz4+Ml7IO6DX0EKcrip5P8ps
 VTtUjikOWMBbMbFvo26hlZ+7puNDeq31DByS/e4J5klg/y8kS+ahlgC5M1nwIBF/QeaJcRnkAch
 Xr/sg+vhQSjKLjVKm+l8Jxdaa09pHNWjAb5d2VQdjWpEAtHbefBY2C1eYnHy4kplHYO6aAmchS5
 +z3oLshFAIaWOeWPI4SCLiRWxYXpvrDbJCJ4qoJpOuKfJeErvrfdKUxdoCRp0yUkiCJmqSjRUP4
 y8PI2hxlVnx3H
X-Google-Smtp-Source: AGHT+IGOds2pqwJ4p9y0NX6X9ec6Y5hlNKtiL/DcoUv+FSxi408lf80dJiYNgWlIQE8W9ujHoazXRw==
X-Received: by 2002:a5d:5f55:0:b0:391:22e2:cd21 with SMTP id
 ffacd0b85a97d-39c297e41bamr688836f8f.36.1743569968741; 
 Tue, 01 Apr 2025 21:59:28 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0d1sm15874572f8f.70.2025.04.01.21.59.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 21:59:28 -0700 (PDT)
Message-ID: <cb565aaf-b2a6-4cdd-bd69-36d3c517eb0b@linaro.org>
Date: Wed, 2 Apr 2025 06:59:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] target/arm: Move CPU QOM type definitions to
 "hw/arm/cpu.h"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20230110164406.94366-1-philmd@linaro.org>
 <20230110164406.94366-6-philmd@linaro.org>
 <325310d0-aad6-fc39-748a-80762d644dd8@linaro.org>
 <b91019e8-1a75-d968-c842-1d040b32a431@linaro.org>
 <6ea2ab5a-47fd-45d3-85c9-36a8ac3c8b18@linaro.org>
Content-Language: en-US
In-Reply-To: <6ea2ab5a-47fd-45d3-85c9-36a8ac3c8b18@linaro.org>
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

On 2/4/25 06:06, Philippe Mathieu-Daudé wrote:
> Cc'ing Pierrick
> 
> On 12/1/23 08:17, Philippe Mathieu-Daudé wrote:
>> On 11/1/23 21:02, Richard Henderson wrote:
>>> On 1/10/23 08:43, Philippe Mathieu-Daudé wrote:
>>>> +++ b/target/arm/cpu.h
>>>> @@ -26,6 +26,7 @@
>>>>   #include "cpu-qom.h"
>>>>   #include "exec/cpu-defs.h"
>>>>   #include "qapi/qapi-types-common.h"
>>>> +#include "hw/arm/cpu.h"
>>>
>>> I'm not a fan of this.
>>>
>>> If you want a smaller version of cpu-qom.h here in target/arm/, for 
>>> use by hw/, that's one thing.  But target/ should not be reaching 
>>> back into hw/, IMO.

Giving it more thought, we should keep "target/foo/cpu.h" private to
target/foo/, and only access its fields from hw/ via clearly defined
methods/constants.

>>
>> I concur, but currently we have:
>>
>> $ git grep '#include "hw' target | wc -l
>>       220
>>
>> $ git grep -h '#include "hw' target | sort | uniq -c
>>     1 #include "hw/acpi/acpi.h"
>>     1 #include "hw/acpi/ghes.h"
>>     1 #include "hw/arm/boot.h"
>>     1 #include "hw/arm/virt.h"
>>    19 #include "hw/boards.h"
>>     2 #include "hw/clock.h"
>>     3 #include "hw/core/accel-cpu.h"
>>    24 #include "hw/core/cpu.h"
>>    20 #include "hw/core/sysemu-cpu-ops.h"
>>    24 #include "hw/core/tcg-cpu-ops.h"
>>     1 #include "hw/hppa/hppa_hardware.h"
>>     3 #include "hw/hw.h"
>>     1 #include "hw/hyperv/hyperv-proto.h"
>>     2 #include "hw/hyperv/hyperv.h"
>>     2 #include "hw/i386/apic-msidef.h"
>>     2 #include "hw/i386/apic.h"
>>     8 #include "hw/i386/apic_internal.h"
>>     1 #include "hw/i386/e820_memory_layout.h"
>>     1 #include "hw/i386/intel_iommu.h"
>>     1 #include "hw/i386/ioapic.h"
>>     2 #include "hw/i386/pc.h"
>>     1 #include "hw/i386/sgx-epc.h"
>>     1 #include "hw/i386/topology.h"
>>     1 #include "hw/i386/x86-iommu.h"
>>     2 #include "hw/i386/x86.h"
>>     1 #include "hw/intc/riscv_aclint.h"
>>     8 #include "hw/irq.h"
>>     1 #include "hw/isa/isa.h"
>>     5 #include "hw/loader.h"
>>     1 #include "hw/loongarch/virt.h"
>>     2 #include "hw/mips/cpudevs.h"
>>     2 #include "hw/pci/msi.h"
>>     1 #include "hw/pci/msix.h"
>>     3 #include "hw/pci/pci.h"
>>     1 #include "hw/ppc/openpic_kvm.h"
>>     5 #include "hw/ppc/ppc.h"
>>     2 #include "hw/ppc/spapr.h"
>>     1 #include "hw/ppc/spapr_cpu_core.h"
>>     2 #include "hw/qdev-clock.h"
>>    12 #include "hw/qdev-properties.h"
>>    11 #include "hw/registerfields.h"
>>     2 #include "hw/s390x/ebcdic.h"
>>     5 #include "hw/s390x/ioinst.h"
>>     2 #include "hw/s390x/ipl.h"
>>     8 #include "hw/s390x/pv.h"
>>     2 #include "hw/s390x/s390-pci-bus.h"
>>     2 #include "hw/s390x/s390-pci-inst.h"
>>     2 #include "hw/s390x/s390-virtio-ccw.h"
>>     2 #include "hw/s390x/s390-virtio-hcall.h"
>>     3 #include "hw/s390x/s390_flic.h"
>>     1 #include "hw/s390x/sclp.h"
>>     2 #include "hw/s390x/storage-keys.h"
>>     1 #include "hw/s390x/tod.h"
>>     1 #include "hw/sh4/sh_intc.h"
>>     2 #include "hw/sysbus.h"
>>     1 #include "hw/watchdog/wdt_diag288.h"
>>     1 #include "hw/xtensa/xtensa-isa.h"
>>
>> Assuming we want to have a self-contained libtarget$arch, how can we
>> deal with HW tied to the arch such CPU timers or NVIC?
> 


