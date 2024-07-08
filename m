Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F208BC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 05:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQggK-0003dZ-MO; Mon, 08 Jul 2024 01:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sQggI-0003b7-V1
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:12:54 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sQggG-0000w2-U1
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:12:54 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52ea33671ffso3074853e87.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 22:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1720415571; x=1721020371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jqxTOFeQU2iWq1/HjV4ZOhu8fpH/gfzBGj0nrZu+NQ0=;
 b=VXGCULEiWd5WCFjshL7ghDF4FR9oup31MlkqphYnQ8QGn9Yf3MhiV7wL/8NoCTPvOv
 +GnU542Nfn8Nu5DLdoLlsL4d+nh5pSYe4dOgDbfSMNN+dk798kobhyXuGKDv//ZqJn+p
 E9Eab3tJt6obF9mDsZwaWfKapj+/WgBcjepJJvBAn7K6AYo67kLjZJUVjh40CedEvG1t
 OtQz2TooPDJ20z/gYpRp9s3PJ41nnNzw63emUNfw6Op0QiDPAb95xGndR+0JpvE1LPEj
 BUgIosLYD3gqmK+Hd+mHmlv88APnbU5j1+wIodv/gAA8ZMUHVxzUkMhYCISxQD3hdaN2
 PRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720415571; x=1721020371;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jqxTOFeQU2iWq1/HjV4ZOhu8fpH/gfzBGj0nrZu+NQ0=;
 b=DYmGhhiVzBzCkcVu3pcNSH4+MzIZfXSPKpRe3EtmYv1F3Uib+wmPFHfSwTYsga70F4
 2hNioatOqhM7/KLAvSu9xgFXgm55hGs2Y92rstMvdA0Q0Z3EsZgdn1PTfTm2DuWkI6Yb
 EP7WEcRXgVsOIVcU8uixn8gApk8bqqE/yEbHRQhIi7YTrrRnmtaqGwOBhFH30TV1oOXI
 6bWDn9QM1USNsDCtL8gdoW58CuyWd+pkDmih0J6zYVzr0jzuYhFRyp2YIjFSqgDecq44
 oPL8OqSF6v/5TzhajiK8616J27wBefScd0a7uGgJ05zQTNXH5MGcNZrBSJhU7HgZ2NgV
 iPvw==
X-Gm-Message-State: AOJu0Yz7Sv7t2vDSlbMQRG45hxLvDJG48ireZqsIQHLwYORVdniuzlDe
 fl01WPW/TZjcerNV8BLhxf2vcLKkTQtLZyJEnHQ4fIFLF18TwNTjNhbiIBuvyEY=
X-Google-Smtp-Source: AGHT+IGXInKd71qlZaOrrT33sRSJ3LwomIsUbQoWs4hd29kncEf36qVRpQzmAIZ4hNmYtAjTa0zd8g==
X-Received: by 2002:a19:434a:0:b0:52e:9f17:8418 with SMTP id
 2adb3069b0e04-52ea06368eemr7085022e87.12.1720415570505; 
 Sun, 07 Jul 2024 22:12:50 -0700 (PDT)
Received: from [10.11.12.72] ([90.220.10.255])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266c3650f4sm8846945e9.1.2024.07.07.22.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 22:12:50 -0700 (PDT)
Message-ID: <c74b6d5e-1939-48df-ae21-9cdd4158a683@opnsrc.net>
Date: Mon, 8 Jul 2024 05:12:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 3/8] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
To: Igor Mammedov <imammedo@redhat.com>, Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, oliver.upton@linux.dev,
 pbonzini@redhat.com, mst@redhat.com, will@kernel.org, gshan@redhat.com,
 rafael@kernel.org, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com, Shaoqin Huang <shahuang@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-4-salil.mehta@huawei.com>
 <20240706154640.0a45c5d6@imammedo.users.ipa.redhat.com>
Content-Language: en-GB
From: Salil Mehta <salil.mehta@opnsrc.net>
In-Reply-To: <20240706154640.0a45c5d6@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


On 06/07/2024 13:46, Igor Mammedov wrote:
> On Fri, 7 Jun 2024 12:56:44 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>
>> ACPI GED (as described in the ACPI 6.4 spec) uses an interrupt listed in the
>> _CRS object of GED to intimate OSPM about an event. Later then demultiplexes the
>> notified event by evaluating ACPI _EVT method to know the type of event. Use
>> ACPI GED to also notify the guest kernel about any CPU hot(un)plug events.
>>
>> ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HOTPLUG
>> support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
>> stub to avoid compilation break.
>>
>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>> Tested-by: Xianglai Li <lixianglai@loongson.cn>
>> Tested-by: Miguel Luis <miguel.luis@oracle.com>
>> Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>> Tested-by: Zhao Liu <zhao1.liu@intel.com>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>>   hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++++++
>>   hw/acpi/cpu.c                          |  6 +++++-
>>   hw/acpi/generic_event_device.c         | 17 +++++++++++++++++
>>   include/hw/acpi/generic_event_device.h |  4 ++++
>>   4 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
>> index 3fc4b14c26..c6c61bb9cd 100644
>> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
>> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
>> @@ -19,6 +19,12 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
>>       return;
>>   }
>>   
>> +void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>> +                         CPUHotplugState *state, hwaddr base_addr)
>> +{
>> +    return;
>> +}
>> +
>>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
>>   {
>>       return;
>> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
>> index 69aaa563db..473b37ba88 100644
>> --- a/hw/acpi/cpu.c
>> +++ b/hw/acpi/cpu.c
>> @@ -221,7 +221,11 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>>       const CPUArchIdList *id_list;
>>       int i;
>>   
>> -    assert(mc->possible_cpu_arch_ids);
>> +    /* hotplug might not be available for all types like x86/microvm etc. */
>> +    if (!mc->possible_cpu_arch_ids) {
>> +        return;
>> +    }
> if hotplug is not supported, this function shouldn't be called at all.

True. But none the less this gets called for Intel/microvm and causes 
qtest to fail.

I think, we've had this discussion before last year as well. Please 
check below:

https://lore.kernel.org/qemu-devel/15e70616-6abb-63a4-17d0-820f4a254607@opnsrc.net/

>
> [...]
>> @@ -400,6 +411,12 @@ static void acpi_ged_initfn(Object *obj)
>>       memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
>>                             TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
>>       sysbus_init_mmio(sbd, &ged_st->regs);
>> +
>> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp container",
>> +                       ACPI_CPU_HOTPLUG_REG_LEN);
>> +    sysbus_init_mmio(sbd, &s->container_cpuhp);
>> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
>> +                        &s->cpuhp_state, 0);
> suggest to move this call to realize time, and gate it on
> ACPI_GED_CPU_HOTPLUG_EVT being set.
> Platform that supports cpu hotplug must optin, setting ACPI_GED_CPU_HOTPLUG_EVT,
> while for the rest it will be ignored.
>
> for example: create_acpi_ged() : event |= ACPI_GED_NVDIMM_HOTPLUG_EVT;

Similar case applies to the Memory hotplug as well and any cleaning here

will mean going beyond the realms of this patch-set. But I can definitely

take this activity in a separate patch-set if you wish?

Thanks

>
>>   }
>>   
>>   static void acpi_ged_class_init(ObjectClass *class, void *data)
>> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
>> index ba84ce0214..90fc41cbb8 100644
>> --- a/include/hw/acpi/generic_event_device.h
>> +++ b/include/hw/acpi/generic_event_device.h
>> @@ -60,6 +60,7 @@
>>   #define HW_ACPI_GENERIC_EVENT_DEVICE_H
>>   
>>   #include "hw/sysbus.h"
>> +#include "hw/acpi/cpu_hotplug.h"
>>   #include "hw/acpi/memory_hotplug.h"
>>   #include "hw/acpi/ghes.h"
>>   #include "qom/object.h"
>> @@ -95,6 +96,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>>   #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
>>   #define ACPI_GED_PWR_DOWN_EVT      0x2
>>   #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>> +#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
>>   
>>   typedef struct GEDState {
>>       MemoryRegion evt;
>> @@ -106,6 +108,8 @@ struct AcpiGedState {
>>       SysBusDevice parent_obj;
>>       MemHotplugState memhp_state;
>>       MemoryRegion container_memhp;
>> +    CPUHotplugState cpuhp_state;
>> +    MemoryRegion container_cpuhp;
>>       GEDState ged_state;
>>       uint32_t ged_event_bitmap;
>>       qemu_irq irq;

