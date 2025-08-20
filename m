Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F90BCA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 12:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uohpE-0005Dv-49; Wed, 20 Aug 2025 08:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uohp4-0005C1-9g
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:21:47 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uohp1-0001oj-Im
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:21:46 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45b49f7aaf5so3674185e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755692501; x=1756297301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u1r13BgNYnzGSFdz6ZD9EK43s0oGmAYXrxfKeGUtfAw=;
 b=qBWwNo+ay0wTToOE/P71xERiVUKP1+nCXCmPe3qztz8zpgWjwtQ8uXmc2GGyR5yAHU
 6cWfVk3Uxx06c65MHCTlzbDReVa2+Lw0t8KP8VmsMU6a1DXszCxJ5SvSSu6Vc+6lG6mG
 a1ZCXh3z1nbgyPucvWy2kfJoh94vlOX9KtB3OwqF5YrZzLaSPPMvzuQLTIhMZjaH9dib
 quVo567r1xqrg5PSpoIebxaIatdh+XwvT3M1FbafmCs4QVK6vWGlSAb1pYRRhJUYdn3x
 XbIQ4VORPL/YfN7p1qtnYWmwbbIDOKyDe3UOjoqAiAw/YaGkpcfgOlmyXwfkJlkg75Mz
 LC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755692501; x=1756297301;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u1r13BgNYnzGSFdz6ZD9EK43s0oGmAYXrxfKeGUtfAw=;
 b=XPjtT8zpqHuIEznpgr3D9qC7eP518xI7WnUbQuMdf86BrhTNFm4JrQ0z9M5YFKzY7s
 CSHSSXhsQ8FHye8ddblrCGS84iq3NQx3QAMt+dG7j/x1xIq8kkLF7EX8xWMqvw1JIbM7
 lnZ6H1MuljqGYyYc7oPGeJ2imjrawuXDDhgMxtlmB0DBkBd/kgbD/Ib921YcbirtIa3A
 YMJQHUBW9yWSlHTGgt/RHatnYpOYtdxRBAvV91qQIN+Qt3YanOJRnjaj385FRqdSgnlH
 GDrXKGriul8g8pb8AON59T3xsh0OYbVGy+P/Jrv9LkrgEh5GaQ2p5PfRU8FZIV+qNDTb
 D+Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK854V9EtNubtlFq0K+G523i1kQ8QlysohJ4dr14E8Js8PF8YPTwV2CeujXSot6O3N1Kak9KQen8EE@nongnu.org
X-Gm-Message-State: AOJu0YyNpZKVXsnj15SHHfj1bZoUF8ZbEb19heuXXfSXCloBkzyHgm6U
 /P9NO//KbAwnXzTPQUyC4Vak8AoJm3pKzwlTEpl8bnOl5SS7BcwDgiA7gL7k7+Wz0Fg=
X-Gm-Gg: ASbGncvhs3rcxn8gvHwsxMjx5I46AyvulFtt3BhNQ9NzwNAw31N+7ROKX0RgnA/BnK4
 gs6EWCd7CYiM7LjUhgfhjBSo/c9OIz7/cLvf8fJO/JC3M5GlQCMs5n19pbhNj3NvcpQTy7FU/Eq
 xVezFlhFr8YYBreIqa4zKlA6qAIGTOMJEHIaPWtN6sNZD4kJMTRD8im1YbLoF+joyRIMYO9lhWL
 ju09WIER0CW1IrDy8lKBeT4ZTzMlp/wFPeS7gxIPeagUSYKQOrOmBcMF23Eg/0EjE0KzoqAhV+k
 5SykT0iP0dhw4Dq4GDO5dcLG92Iy62mLA2DsI71FhY94HNH8d/mRYt/ULPIBEV3lHlv+7PAsi8a
 YsM3Vn9EoAEdIfVcg2YFX8VybE6aHVm2a8LwRZrQwojY/iKi7cek8gP1yjqEeYNC9v+38AQ/47c
 31s8D8VQ==
X-Google-Smtp-Source: AGHT+IFkByznBXg0kiMf0vWPgiFz/2B6WaUjDlzHARod1WxQSc5SXaLlulsQSlJtFj30V636+85leg==
X-Received: by 2002:a05:600c:3511:b0:459:db71:74d7 with SMTP id
 5b1f17b1804b1-45b47a03b3emr17894045e9.27.1755692501442; 
 Wed, 20 Aug 2025 05:21:41 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47cb98b6sm32088625e9.26.2025.08.20.05.21.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Aug 2025 05:21:40 -0700 (PDT)
Message-ID: <e7090f12-ba40-4495-b80f-0f85b45a7434@linaro.org>
Date: Wed, 20 Aug 2025 14:21:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/47] hw/arm/xlnx-versal: refactor CPU cluster creation
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250820082549.69724-1-luc.michel@amd.com>
 <20250820082549.69724-21-luc.michel@amd.com>
 <9a47da92-1d12-4eda-9c18-235f93bca8b5@linaro.org>
Content-Language: en-US
In-Reply-To: <9a47da92-1d12-4eda-9c18-235f93bca8b5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 20/8/25 14:16, Philippe Mathieu-Daudé wrote:
> Hi Luc,
> 
> On 20/8/25 10:25, Luc Michel wrote:
>> Refactor the CPU cluster creation using the VersalMap structure. There
>> is no functional change. The clusters properties are now described in
>> the VersalMap structure. For now only the APU is converted. The RPU will
>> be taken care of by next commits.
>>
>> Signed-off-by: Luc Michel <luc.michel@amd.com>
>> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
>> ---
>>   include/hw/arm/xlnx-versal.h |  11 +-
>>   hw/arm/xlnx-versal-virt.c    |  80 +-------
>>   hw/arm/xlnx-versal.c         | 346 ++++++++++++++++++++++++++---------
>>   3 files changed, 269 insertions(+), 168 deletions(-)
>>
>> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
>> index af47acb288f..ba5719d80f5 100644
>> --- a/include/hw/arm/xlnx-versal.h
>> +++ b/include/hw/arm/xlnx-versal.h
> 
> 
>> @@ -41,19 +40,10 @@ OBJECT_DECLARE_TYPE(Versal, VersalClass, 
>> XLNX_VERSAL_BASE)
>>   struct Versal {
>>       /*< private >*/
>>       SysBusDevice parent_obj;
>>       /*< public >*/
>> -    struct {
>> -        struct {
>> -            MemoryRegion mr;
>> -            CPUClusterState cluster;
>> -            ARMCPU cpu[XLNX_VERSAL_NR_ACPUS];
>> -            GICv3State gic;
>> -        } apu;
>> -    } fpd;
> 
> 
>> @@ -427,11 +359,11 @@ static void versal_virt_init(MachineState *machine)
>>           /* Some boot-loaders (e.g u-boot) don't like blobs at 
>> address 0 (NULL).
>>            * Offset things by 4K.  */
>>           s->binfo.loader_start = 0x1000;
>>           s->binfo.dtb_limit = 0x1000000;
>>       }
>> -    arm_load_kernel(&s->soc.fpd.apu.cpu[0], machine, &s->binfo);
>> +    arm_load_kernel(ARM_CPU(qemu_get_cpu(0)), machine, &s->binfo);
> 
> We'd like to restrict qemu_get_cpu() to generic accelerator code, where
> what type of scheduled vCPU doesn't matter. And forbid this API under
> hw/, because it triggers odd bugs in heterogenous context (we can
> instanciate vCPU in random order, and hot[un]plug them, changing their
> id). Besides hw/ normally have knowledge of how to directly address a
> CPU (how/where it is wired). So I'm not really keen on adding another
> qemu_get_cpu() call here. Can't we keep references in VersalVirt (at
> least for the booting cpu)?

Otherwise simpler to use the constant QOM path:

   booting_cpu = ARM_CPU(object_resolve_path("/machine/fpd/apu/cpu[0]"));

> 
>>       for (i = 0; i < XLNX_VERSAL_NUM_OSPI_FLASH; i++) {
>>           ObjectClass *flash_klass;
>>           DriveInfo *dinfo = drive_get(IF_MTD, 0, i);
>>           BlockBackend *blk;
>> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
>> index fe2c789a557..5a08ad07b28 100644
>> --- a/hw/arm/xlnx-versal.c
>> +++ b/hw/arm/xlnx-versal.c
>> @@ -41,10 +41,11 @@
>>   #include "hw/rtc/xlnx-zynqmp-rtc.h"
>>   #include "hw/misc/xlnx-versal-cfu.h"
>>   #include "hw/misc/xlnx-versal-cframe-reg.h"
>>   #include "hw/or-irq.h"
>>   #include "hw/misc/xlnx-versal-crl.h"
>> +#include "hw/intc/arm_gicv3_common.h"
>>   #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>>   #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>>   #define GEM_REVISION        0x40070106
>> @@ -65,11 +66,38 @@ FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on 
>> the IRQ OR gate */
>>   typedef struct VersalSimplePeriphMap {
>>       uint64_t addr;
>>       int irq;
>>   } VersalSimplePeriphMap;
>> +typedef struct VersalGicMap {
>> +    int version;
>> +    uint64_t dist;
>> +    uint64_t redist;
>> +    size_t num_irq;
>> +} VersalGicMap;
>> +
>> +enum StartPoweredOffMode {
>> +    SPO_SECONDARIES,
>> +    SPO_ALL,
>> +};
>> +
>> +typedef struct VersalCpuClusterMap {
>> +    VersalGicMap gic;
>> +
>> +    const char *name;
>> +    const char *cpu_model;
>> +    size_t num_core;
>> +    size_t num_cluster;
>> +    uint32_t qemu_cluster_id;
>> +    bool dtb_expose;
>> +
>> +    enum StartPoweredOffMode start_powered_off;
>> +} VersalCpuClusterMap;
>> +
>>   typedef struct VersalMap {
>> +    VersalCpuClusterMap apu;
>> +
>>       VersalSimplePeriphMap uart[2];
>>       size_t num_uart;


