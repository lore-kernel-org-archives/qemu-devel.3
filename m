Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058CEC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 11:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAo9p-0005I5-8V; Fri, 02 May 2025 07:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAo9l-0005Hj-By
 for qemu-devel@nongnu.org; Fri, 02 May 2025 07:02:14 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAo9i-00010W-BY
 for qemu-devel@nongnu.org; Fri, 02 May 2025 07:02:13 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso1190218f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 04:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746183724; x=1746788524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aj7n2aQkjeTvcvtOPTD16nWz7ldpfoeKuN/vCspx+Es=;
 b=vG6vz798q8/FrF53U1BOsjyu4yIBc3yHsrubQT4hEUY5BUDvxCtMDNHhiMu3ZjUlDc
 H4a85fAAaL0WUxW5EEiIduQ/CAKols9lOdfG+m/M22MyEnQvHUk8jPi5kkZXWlG6JEob
 VkU2IXLVsFSuOQNu6r6sxpGYYebSk30t1S0yRS9YtxgK9VabVALk+VXSRxpTKruXBLOf
 R+I0EREZCx7huizBr54JrDKnLJ+6C0MqCqvHbvwsUaVL12AM3Vc1330hWR6L7UYsZQCG
 h9D8RjrxRqkCecoygQPs9Qayo4sNSjVTRPwWYcBXPp+YsuXv1f7OCX6oGcsnSSCWrHbV
 TC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746183724; x=1746788524;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aj7n2aQkjeTvcvtOPTD16nWz7ldpfoeKuN/vCspx+Es=;
 b=h/33DyyRq3TSIoXCwPsYPJWu4UhUn6sCGtQp6oJNfDhSi1383jH1grxPx1peK12VW5
 edHNsYfJVQte7YUKXpWWclfJQGHYMrtHZIZ416sJY6nBYRSHIyWDkRqTlC/GZ/WyrzZB
 b8BuKQLqVHhPmargPtoTEncTusXycSo8DyZa7nUUlRQabE0Jun4JTIfN1/xpojZkBdVG
 cL2vhlVlEoE7Plx6KLmz/lsQ1xEYguZ8+fz0A8fLhZ9yfaEyubKMpXbbT4BV1EpVF2O/
 Llue0CUR8FQZS0oXUXFPoMv6SboTygzwrCzxhKXyzFXDlq9D3K8OKflZJj6HybkRZAKb
 Lp5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3rRaUNFRnGWHwGPzqIya3C67W6oT9S7oibCxB4nhCcUASE56mNnRylP2/Go1+B733zwb+ICRmnPet@nongnu.org
X-Gm-Message-State: AOJu0YzdyPg5YfcKREIrPWXvOWcdlfmet53c0Xo6oEAQRtZde2SiZPn7
 QIlPtPIkkoyNKhOQLfja3i9qkNAvH6nOX5XarshTFOJDRrs2hNWl0LvsvNJZxuE=
X-Gm-Gg: ASbGncuQXKGXzwC2tEjki/72rW8fQPcQEjU5LIw6q+vIIErmU/af2C1eKgR0Twsdyb4
 +78TA27d3hgsKx2dcvZMKzIXpl9u/7FWEq0K5NCFOPiDM0WRgjYMSeEWghpfEraacuJhKX9wNWY
 Si74IZ/A4PX+1KYgr5UCUHFqfWzpi5ecGmQbKS6HOd5uQftqS5heH5R9UbFKLfhxBRrCdyYidZN
 rKxIZiXTMH380RqZ8pVRP0x/D3Ee5ViYoOryfgKozmQ3bnWF1W1budY48ni8EP7nDGt1dSHUeKy
 QRQ7fflfx0QJI/t94zn8TxawRBsPQvFWEE7iCwFwNl/MulWW9As/i4KL70T3lyGm+yo2AJdUn0a
 +QaQz7IuC
X-Google-Smtp-Source: AGHT+IEct+/L57KLPJgKd+H2vYyxKzke0qZ7ZqO5626FdSlDWIYudRwWuZ02B7hBtK3XhwXdmIEuxw==
X-Received: by 2002:a05:6000:1889:b0:3a0:857e:7e8 with SMTP id
 ffacd0b85a97d-3a099af1c7dmr1770851f8f.56.1746183724270; 
 Fri, 02 May 2025 04:02:04 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa7775cb74sm1069858a12.1.2025.05.02.04.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 04:02:03 -0700 (PDT)
Message-ID: <4a581c92-5545-4d41-b75b-a86a983f59ed@linaro.org>
Date: Fri, 2 May 2025 13:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] hw/i386/pc: Remove
 PCMachineClass::legacy_cpu_hotplug field
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-3-philmd@linaro.org>
 <e1c29ed2-828d-4a4d-b7b4-9417004fc64d@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e1c29ed2-828d-4a4d-b7b4-9417004fc64d@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 2/5/25 10:57, Mark Cave-Ayland wrote:
> On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:
> 
>> The PCMachineClass::legacy_cpu_hotplug boolean was only used
>> by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
>> removed. Remove it and simplify build_dsdt(), removing
>> build_legacy_cpu_hotplug_aml() altogether.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/acpi/cpu_hotplug.h |   3 -
>>   include/hw/i386/pc.h          |   3 -
>>   hw/acpi/cpu_hotplug.c         | 230 ----------------------------------
>>   hw/i386/acpi-build.c          |   4 +-
>>   4 files changed, 1 insertion(+), 239 deletions(-)
>>
>> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/ 
>> cpu_hotplug.h
>> index 3b932abbbbe..aeee630cf05 100644
>> --- a/include/hw/acpi/cpu_hotplug.h
>> +++ b/include/hw/acpi/cpu_hotplug.h
>> @@ -34,7 +34,4 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion 
>> *parent, Object *owner,
>>   void acpi_switch_to_modern_cphp(AcpiCpuHotplug *gpe_cpu,
>>                                   CPUHotplugState *cpuhp_state,
>>                                   uint16_t io_port);
>> -
>> -void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
>> -                                  uint16_t io_base);
>>   #endif
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 79b72c54dd3..a3de3e9560d 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -110,9 +110,6 @@ struct PCMachineClass {
>>       bool enforce_amd_1tb_hole;
>>       bool isa_bios_alias;
>> -    /* generate legacy CPU hotplug AML */
>> -    bool legacy_cpu_hotplug;
>> -
>>       /* use PVH to load kernels that support this feature */
>>       bool pvh_enabled;
>> diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
>> index aa0e1e3efa5..fe439705bda 100644
>> --- a/hw/acpi/cpu_hotplug.c
>> +++ b/hw/acpi/cpu_hotplug.c
>> @@ -116,233 +116,3 @@ void acpi_switch_to_modern_cphp(AcpiCpuHotplug 
>> *gpe_cpu,
>>       memory_region_del_subregion(parent, &gpe_cpu->io);
>>       cpu_hotplug_hw_init(parent, gpe_cpu->device, cpuhp_state, io_port);
>>   }
>> -
>> -void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
>> -                                  uint16_t io_base)
>> -{
>> -    Aml *dev;
>> -    Aml *crs;
>> -    Aml *pkg;
>> -    Aml *field;
>> -    Aml *method;
>> -    Aml *if_ctx;
>> -    Aml *else_ctx;
>> -    int i, apic_idx;
>> -    Aml *sb_scope = aml_scope("_SB");
>> -    uint8_t madt_tmpl[8] = {0x00, 0x08, 0x00, 0x00, 0x00, 0, 0, 0};
>> -    Aml *cpu_id = aml_arg(1);
>> -    Aml *apic_id = aml_arg(0);
>> -    Aml *cpu_on = aml_local(0);
>> -    Aml *madt = aml_local(1);
>> -    Aml *cpus_map = aml_name(CPU_ON_BITMAP);
>> -    Aml *zero = aml_int(0);
>> -    Aml *one = aml_int(1);
>> -    MachineClass *mc = MACHINE_GET_CLASS(machine);
>> -    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
>> -    X86MachineState *x86ms = X86_MACHINE(machine);
>> -
>> -    /*
>> -     * _MAT method - creates an madt apic buffer
>> -     * apic_id = Arg0 = Local APIC ID
>> -     * cpu_id  = Arg1 = Processor ID
>> -     * cpu_on = Local0 = CPON flag for this cpu
>> -     * madt = Local1 = Buffer (in madt apic form) to return
>> -     */
>> -    method = aml_method(CPU_MAT_METHOD, 2, AML_NOTSERIALIZED);
>> -    aml_append(method,
>> -        aml_store(aml_derefof(aml_index(cpus_map, apic_id)), cpu_on));
>> -    aml_append(method,
>> -        aml_store(aml_buffer(sizeof(madt_tmpl), madt_tmpl), madt));
>> -    /* Update the processor id, lapic id, and enable/disable status */
>> -    aml_append(method, aml_store(cpu_id, aml_index(madt, aml_int(2))));
>> -    aml_append(method, aml_store(apic_id, aml_index(madt, aml_int(3))));
>> -    aml_append(method, aml_store(cpu_on, aml_index(madt, aml_int(4))));
>> -    aml_append(method, aml_return(madt));
>> -    aml_append(sb_scope, method);
>> -
>> -    /*
>> -     * _STA method - return ON status of cpu
>> -     * apic_id = Arg0 = Local APIC ID
>> -     * cpu_on = Local0 = CPON flag for this cpu
>> -     */
>> -    method = aml_method(CPU_STATUS_METHOD, 1, AML_NOTSERIALIZED);
>> -    aml_append(method,
>> -        aml_store(aml_derefof(aml_index(cpus_map, apic_id)), cpu_on));
>> -    if_ctx = aml_if(cpu_on);
>> -    {
>> -        aml_append(if_ctx, aml_return(aml_int(0xF)));
>> -    }
>> -    aml_append(method, if_ctx);
>> -    else_ctx = aml_else();
>> -    {
>> -        aml_append(else_ctx, aml_return(zero));
>> -    }
>> -    aml_append(method, else_ctx);
>> -    aml_append(sb_scope, method);
>> -
>> -    method = aml_method(CPU_EJECT_METHOD, 2, AML_NOTSERIALIZED);
>> -    aml_append(method, aml_sleep(200));
>> -    aml_append(sb_scope, method);
>> -
>> -    method = aml_method(CPU_SCAN_METHOD, 0, AML_NOTSERIALIZED);
>> -    {
>> -        Aml *while_ctx, *if_ctx2, *else_ctx2;
>> -        Aml *bus_check_evt = aml_int(1);
>> -        Aml *remove_evt = aml_int(3);
>> -        Aml *status_map = aml_local(5); /* Local5 = active cpu bitmap */
>> -        Aml *byte = aml_local(2); /* Local2 = last read byte from 
>> bitmap */
>> -        Aml *idx = aml_local(0); /* Processor ID / APIC ID iterator */
>> -        Aml *is_cpu_on = aml_local(1); /* Local1 = CPON flag for cpu */
>> -        Aml *status = aml_local(3); /* Local3 = active state for cpu */
>> -
>> -        aml_append(method, aml_store(aml_name(CPU_STATUS_MAP), 
>> status_map));
>> -        aml_append(method, aml_store(zero, byte));
>> -        aml_append(method, aml_store(zero, idx));
>> -
>> -        /* While (idx < SizeOf(CPON)) */
>> -        while_ctx = aml_while(aml_lless(idx, aml_sizeof(cpus_map)));
>> -        aml_append(while_ctx,
>> -            aml_store(aml_derefof(aml_index(cpus_map, idx)), 
>> is_cpu_on));
>> -
>> -        if_ctx = aml_if(aml_and(idx, aml_int(0x07), NULL));
>> -        {
>> -            /* Shift down previously read bitmap byte */
>> -            aml_append(if_ctx, aml_shiftright(byte, one, byte));
>> -        }
>> -        aml_append(while_ctx, if_ctx);
>> -
>> -        else_ctx = aml_else();
>> -        {
>> -            /* Read next byte from cpu bitmap */
>> -            aml_append(else_ctx, 
>> aml_store(aml_derefof(aml_index(status_map,
>> -                       aml_shiftright(idx, aml_int(3), NULL))), byte));
>> -        }
>> -        aml_append(while_ctx, else_ctx);
>> -
>> -        aml_append(while_ctx, aml_store(aml_and(byte, one, NULL), 
>> status));
>> -        if_ctx = aml_if(aml_lnot(aml_equal(is_cpu_on, status)));
>> -        {
>> -            /* State change - update CPON with new state */
>> -            aml_append(if_ctx, aml_store(status, aml_index(cpus_map, 
>> idx)));
>> -            if_ctx2 = aml_if(aml_equal(status, one));
>> -            {
>> -                aml_append(if_ctx2,
>> -                    aml_call2(AML_NOTIFY_METHOD, idx, bus_check_evt));
>> -            }
>> -            aml_append(if_ctx, if_ctx2);
>> -            else_ctx2 = aml_else();
>> -            {
>> -                aml_append(else_ctx2,
>> -                    aml_call2(AML_NOTIFY_METHOD, idx, remove_evt));
>> -            }
>> -        }
>> -        aml_append(if_ctx, else_ctx2);
>> -        aml_append(while_ctx, if_ctx);
>> -
>> -        aml_append(while_ctx, aml_increment(idx)); /* go to next cpu */
>> -        aml_append(method, while_ctx);
>> -    }
>> -    aml_append(sb_scope, method);
>> -
>> -    /* The current AML generator can cover the APIC ID range [0..255],
>> -     * inclusive, for VCPU hotplug. */
>> -    QEMU_BUILD_BUG_ON(ACPI_CPU_HOTPLUG_ID_LIMIT > 256);
>> -    if (x86ms->apic_id_limit > ACPI_CPU_HOTPLUG_ID_LIMIT) {
>> -        error_report("max_cpus is too large. APIC ID of last CPU is %u",
>> -                     x86ms->apic_id_limit - 1);
>> -        exit(1);
>> -    }
>> -
>> -    /* create PCI0.PRES device and its _CRS to reserve CPU hotplug 
>> MMIO */
>> -    dev = aml_device("PCI0." stringify(CPU_HOTPLUG_RESOURCE_DEVICE));
>> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A06")));
>> -    aml_append(dev,
>> -        aml_name_decl("_UID", aml_string("CPU Hotplug resources"))
>> -    );
>> -    /* device present, functioning, decoding, not shown in UI */
>> -    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
>> -    crs = aml_resource_template();
>> -    aml_append(crs,
>> -        aml_io(AML_DECODE16, io_base, io_base, 1, ACPI_GPE_PROC_LEN)
>> -    );
>> -    aml_append(dev, aml_name_decl("_CRS", crs));
>> -    aml_append(sb_scope, dev);
>> -    /* declare CPU hotplug MMIO region and PRS field to access it */
>> -    aml_append(sb_scope, aml_operation_region(
>> -        "PRST", AML_SYSTEM_IO, aml_int(io_base), ACPI_GPE_PROC_LEN));
>> -    field = aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);
>> -    aml_append(field, aml_named_field("PRS", 256));
>> -    aml_append(sb_scope, field);
>> -
>> -    /* build Processor object for each processor */
>> -    for (i = 0; i < apic_ids->len; i++) {
>> -        int cpu_apic_id = apic_ids->cpus[i].arch_id;
>> -
>> -        assert(cpu_apic_id < ACPI_CPU_HOTPLUG_ID_LIMIT);
>> -
>> -        dev = aml_processor(i, 0, 0, "CP%.02X", cpu_apic_id);
>> -
>> -        method = aml_method("_MAT", 0, AML_NOTSERIALIZED);
>> -        aml_append(method,
>> -            aml_return(aml_call2(CPU_MAT_METHOD,
>> -                                 aml_int(cpu_apic_id), aml_int(i))
>> -        ));
>> -        aml_append(dev, method);
>> -
>> -        method = aml_method("_STA", 0, AML_NOTSERIALIZED);
>> -        aml_append(method,
>> -            aml_return(aml_call1(CPU_STATUS_METHOD, 
>> aml_int(cpu_apic_id))));
>> -        aml_append(dev, method);
>> -
>> -        method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
>> -        aml_append(method,
>> -            aml_return(aml_call2(CPU_EJECT_METHOD, aml_int(cpu_apic_id),
>> -                aml_arg(0)))
>> -        );
>> -        aml_append(dev, method);
>> -
>> -        aml_append(sb_scope, dev);
>> -    }
>> -
>> -    /* build this code:
>> -     *   Method(NTFY, 2) {If (LEqual(Arg0, 0x00)) {Notify(CP00, 
>> Arg1)} ...}
>> -     */
>> -    /* Arg0 = APIC ID */
>> -    method = aml_method(AML_NOTIFY_METHOD, 2, AML_NOTSERIALIZED);
>> -    for (i = 0; i < apic_ids->len; i++) {
>> -        int cpu_apic_id = apic_ids->cpus[i].arch_id;
>> -
>> -        if_ctx = aml_if(aml_equal(aml_arg(0), aml_int(cpu_apic_id)));
>> -        aml_append(if_ctx,
>> -            aml_notify(aml_name("CP%.02X", cpu_apic_id), aml_arg(1))
>> -        );
>> -        aml_append(method, if_ctx);
>> -    }
>> -    aml_append(sb_scope, method);
>> -
>> -    /* build "Name(CPON, Package() { One, One, ..., Zero, Zero, ... })"
>> -     *
>> -     * Note: The ability to create variable-sized packages was first
>> -     * introduced in ACPI 2.0. ACPI 1.0 only allowed fixed-size packages
>> -     * ith up to 255 elements. Windows guests up to win2k8 fail when
>> -     * VarPackageOp is used.
>> -     */
>> -    pkg = x86ms->apic_id_limit <= 255 ? aml_package(x86ms- 
>> >apic_id_limit) :
>> -                                        aml_varpackage(x86ms- 
>> >apic_id_limit);
>> -
>> -    for (i = 0, apic_idx = 0; i < apic_ids->len; i++) {
>> -        int cpu_apic_id = apic_ids->cpus[i].arch_id;
>> -
>> -        for (; apic_idx < cpu_apic_id; apic_idx++) {
>> -            aml_append(pkg, aml_int(0));
>> -        }
>> -        aml_append(pkg, aml_int(apic_ids->cpus[i].cpu ? 1 : 0));
>> -        apic_idx = cpu_apic_id + 1;
>> -    }
>> -    aml_append(sb_scope, aml_name_decl(CPU_ON_BITMAP, pkg));
>> -    aml_append(ctx, sb_scope);
>> -
>> -    method = aml_method("\\_GPE._E02", 0, AML_NOTSERIALIZED);
>> -    aml_append(method, aml_call0("\\_SB." CPU_SCAN_METHOD));
>> -    aml_append(ctx, method);
>> -}
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 3fffa4a3328..625889783ec 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1465,9 +1465,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>       }
>>       aml_append(dsdt, scope);
>> -    if (pcmc->legacy_cpu_hotplug) {
>> -        build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>> -    } else {
>> +    {
>>           CPUHotplugFeatures opts = {
>>               .acpi_1_compatible = true, .has_legacy_cphp = true,
>>               .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : 
>> NULL,
> 
> Do you happen to know exactly why the CPU hotplug ACPI entry was 
> deprecated (it might be helpful to add this to the commit message).

I'll mention:

commit 679dd1a957df418453efdd3ed2914dba5cd73773
Author: Igor Mammedov <imammedo@redhat.com>
Date:   Wed Jun 15 11:25:23 2016 +0200

     pc: use new CPU hotplug interface since 2.7 machine type

     For compatibility reasons PC/Q35 will start with legacy
     CPU hotplug interface by default but with new CPU hotplug
     AML code since 2.7 machine type. That way legacy firmware
     that doesn't use QEMU generated ACPI tables will be
     able to continue using legacy CPU hotplug interface.

     While new machine type, with firmware supporting QEMU
     provided ACPI tables, will generate new CPU hotplug AML,
     which will switch to new CPU hotplug interface when
     guest OS executes its _INI method on ACPI tables
     loading.


> Anyhow:
> 
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Thanks!

