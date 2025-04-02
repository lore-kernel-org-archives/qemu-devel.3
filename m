Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CDFC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 04:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzpN5-0006X4-B4; Wed, 02 Apr 2025 00:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzpMx-0006WY-II
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 00:06:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzpMt-0006rp-K6
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 00:06:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so2073825e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 21:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743566781; x=1744171581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0dcLhlw2Az8zls6DdVR5sQAQf1Ur0qS0XvZZXBd8Wd8=;
 b=N81Jb/frvgWsmwctxrFh/7k5ddajPHY/Sgm0BCeoiiNxvOiZp4Jaxfq836GhZOvLCO
 x6JAhetmYxSDyWdsxMIEVJKyo/1FrQaHq+BN9eTQkr04gEiEAkVLb+EzM6TCPdkisL13
 Polk1bwB05ohyWv0l+zMsKg6wHUt/bsr+KkfeotjlccogX+UQaFb6IHA2YthDyQ3rcVc
 K+R6C15h2wRI64TrlwxhlPNUXd1PnTD+JEos4tOvyA8plRLaeXma7vRCPt9ZZaArANVS
 1C43PRx3REsBx2JE/WYeMztmEX7XU/FGPvDXQB5nSJ2u7Sv+kkUYtvizWRkUI7FSU7rI
 yqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743566781; x=1744171581;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0dcLhlw2Az8zls6DdVR5sQAQf1Ur0qS0XvZZXBd8Wd8=;
 b=Js8p4y3EfRv8Gwd4lqlKKjXyrPxxwK27dvz4TlU7sM6DU1Z9VN3PMryRsQ+kDg1Tju
 RwbWCdPAoIRm8RT1+oCyDH3/ZdpL+cAoz/5YBbeB608xDzNIc7NU5IoRni+yeq/acgRZ
 GuMFSxT0Rrw8iEJQ9Fdd91zeVK4yBWY9FawvhhgHO3fZ7E/+CdBex6hzaR9TVmVREQT1
 eKYse17NBYk+8pT+Zj7SEbsPSTL62Rl4tF1N9BsYjKBVu/fYjy+6Vsp2YyI6yCqD7EPg
 qsnPm4yCzA2/fKoOYoisEyN0ngGYMslju3mwd8vfwJWdkjL6d0l4L2+NI3Cqo/Gtn5Zw
 ujtg==
X-Gm-Message-State: AOJu0YytZNePhJdToD4fje63BX/HoxkxV7kEvQEltldsyS8QqMqwSlmj
 I91q11WhXaxg12rlJOFTaGclJiav2sLF0srH7/OE6mc7PlLpvs7TxHK4auqJLxzOCr8IjR9ssHF
 n
X-Gm-Gg: ASbGnctwWH7k+KVhRgiOYptys4VLYL2jCj3IDLpaxO/SqWjSiCQ0awJ4GI6jrwjhoxp
 MNb048GxydHtwXlB+33mitH5UEEvuBhKD1YWCXVElvPnqdGqgrppWKr/u9cNjktoZ4jO/FMNySw
 FDQs81scHspiVS8VX+IUe6PN9HvLvmE1TiS+/WFr3tyWOeyIiGx8afSGl49E2nUD7HEbQuIuLQX
 +AUbIcgtpPPZjP3DGIq51HB6W97+9rTYc+yhy7pcg5rzy5kwV3UzzzSV+UtTXo6xzkyPSKHHuvf
 ScsRR/aOVx1idRM7upq9ZuAiy1VFFqf16XAbALmVw2SPslFlBjYmr1nkUpIwAI4Qc1agEpY2I4M
 EfyifDVnG3gX4D9H5WUumsuQ=
X-Google-Smtp-Source: AGHT+IE8hVfxApRLPh3TmGhqw2QtQfLdKwA5JHtgCYuBZ5C4PW702a2q2r31JhB9vbG9jlEfq/gsKA==
X-Received: by 2002:a05:600c:350f:b0:439:9737:675b with SMTP id
 5b1f17b1804b1-43eb7191d78mr2785595e9.7.1743566781267; 
 Tue, 01 Apr 2025 21:06:21 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb6190bb9sm7828315e9.29.2025.04.01.21.06.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 21:06:20 -0700 (PDT)
Message-ID: <6ea2ab5a-47fd-45d3-85c9-36a8ac3c8b18@linaro.org>
Date: Wed, 2 Apr 2025 06:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] target/arm: Move CPU QOM type definitions to
 "hw/arm/cpu.h"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
References: <20230110164406.94366-1-philmd@linaro.org>
 <20230110164406.94366-6-philmd@linaro.org>
 <325310d0-aad6-fc39-748a-80762d644dd8@linaro.org>
 <b91019e8-1a75-d968-c842-1d040b32a431@linaro.org>
Content-Language: en-US
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b91019e8-1a75-d968-c842-1d040b32a431@linaro.org>
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

Cc'ing Pierrick

On 12/1/23 08:17, Philippe Mathieu-Daudé wrote:
> On 11/1/23 21:02, Richard Henderson wrote:
>> On 1/10/23 08:43, Philippe Mathieu-Daudé wrote:
>>> +++ b/target/arm/cpu.h
>>> @@ -26,6 +26,7 @@
>>>   #include "cpu-qom.h"
>>>   #include "exec/cpu-defs.h"
>>>   #include "qapi/qapi-types-common.h"
>>> +#include "hw/arm/cpu.h"
>>
>> I'm not a fan of this.
>>
>> If you want a smaller version of cpu-qom.h here in target/arm/, for 
>> use by hw/, that's one thing.  But target/ should not be reaching back 
>> into hw/, IMO.
> 
> I concur, but currently we have:
> 
> $ git grep '#include "hw' target | wc -l
>       220
> 
> $ git grep -h '#include "hw' target | sort | uniq -c
>     1 #include "hw/acpi/acpi.h"
>     1 #include "hw/acpi/ghes.h"
>     1 #include "hw/arm/boot.h"
>     1 #include "hw/arm/virt.h"
>    19 #include "hw/boards.h"
>     2 #include "hw/clock.h"
>     3 #include "hw/core/accel-cpu.h"
>    24 #include "hw/core/cpu.h"
>    20 #include "hw/core/sysemu-cpu-ops.h"
>    24 #include "hw/core/tcg-cpu-ops.h"
>     1 #include "hw/hppa/hppa_hardware.h"
>     3 #include "hw/hw.h"
>     1 #include "hw/hyperv/hyperv-proto.h"
>     2 #include "hw/hyperv/hyperv.h"
>     2 #include "hw/i386/apic-msidef.h"
>     2 #include "hw/i386/apic.h"
>     8 #include "hw/i386/apic_internal.h"
>     1 #include "hw/i386/e820_memory_layout.h"
>     1 #include "hw/i386/intel_iommu.h"
>     1 #include "hw/i386/ioapic.h"
>     2 #include "hw/i386/pc.h"
>     1 #include "hw/i386/sgx-epc.h"
>     1 #include "hw/i386/topology.h"
>     1 #include "hw/i386/x86-iommu.h"
>     2 #include "hw/i386/x86.h"
>     1 #include "hw/intc/riscv_aclint.h"
>     8 #include "hw/irq.h"
>     1 #include "hw/isa/isa.h"
>     5 #include "hw/loader.h"
>     1 #include "hw/loongarch/virt.h"
>     2 #include "hw/mips/cpudevs.h"
>     2 #include "hw/pci/msi.h"
>     1 #include "hw/pci/msix.h"
>     3 #include "hw/pci/pci.h"
>     1 #include "hw/ppc/openpic_kvm.h"
>     5 #include "hw/ppc/ppc.h"
>     2 #include "hw/ppc/spapr.h"
>     1 #include "hw/ppc/spapr_cpu_core.h"
>     2 #include "hw/qdev-clock.h"
>    12 #include "hw/qdev-properties.h"
>    11 #include "hw/registerfields.h"
>     2 #include "hw/s390x/ebcdic.h"
>     5 #include "hw/s390x/ioinst.h"
>     2 #include "hw/s390x/ipl.h"
>     8 #include "hw/s390x/pv.h"
>     2 #include "hw/s390x/s390-pci-bus.h"
>     2 #include "hw/s390x/s390-pci-inst.h"
>     2 #include "hw/s390x/s390-virtio-ccw.h"
>     2 #include "hw/s390x/s390-virtio-hcall.h"
>     3 #include "hw/s390x/s390_flic.h"
>     1 #include "hw/s390x/sclp.h"
>     2 #include "hw/s390x/storage-keys.h"
>     1 #include "hw/s390x/tod.h"
>     1 #include "hw/sh4/sh_intc.h"
>     2 #include "hw/sysbus.h"
>     1 #include "hw/watchdog/wdt_diag288.h"
>     1 #include "hw/xtensa/xtensa-isa.h"
> 
> Assuming we want to have a self-contained libtarget$arch, how can we
> deal with HW tied to the arch such CPU timers or NVIC?


