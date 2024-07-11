Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB68C3DA42
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 03:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRkVB-0000aR-LN; Wed, 10 Jul 2024 23:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sRkVA-0000ZY-2P
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 23:29:48 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sRkV7-0004lW-T9
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 23:29:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4266182a9d7so2514395e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 20:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1720668583; x=1721273383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xu5Pwo28iuFH9ZLTj66GK89uHgcEaX07Mu/Z/kn2x3A=;
 b=C18CXvQOqS4IRNBF6YzLRF/6ijo0d8vnekWOYenVd0+lr8OrMwCvXeMliRiEQZL9fl
 gcOVUtJLD/SH5xj6kEejjOha9Km1XydsUYWXTEDd4qI9xajykNAoH25gzc6bE49EoV4T
 4oEtOUmKQJ9WZnal/khRSf5NRH183vjZnKrP2kWHDzlyytWe5fODFathJ8YHRVQOJWEQ
 VXaomTfrPpw8/nIvEaBtt3BgmoWBkZvdYni9brCxcFWUS7ChBO7dI6nlrVVL/P8uS6a8
 MYMMCfZudnC3S6wm6ATKQJSZ3fFz54YTqr7yeJab07rzh84ADIvDLVuIs1+yV3eV3ttv
 FD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720668583; x=1721273383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xu5Pwo28iuFH9ZLTj66GK89uHgcEaX07Mu/Z/kn2x3A=;
 b=Lm3yDfWnljd2IgPaKTc/zHn2eDSnkE0wBmKRpM6JD3ah2Wkj7TUOZeTnFPY4YtCn5Z
 UfT4kaZ8r6XyRVmu/yZ0AqE/lp9tPkHOdhsGaDAhWR6AQBWz3sLHhKORG23Bsdra64Bm
 HE3fSTZZCd1HMJkEf2Id56dvqecJ8eIyS1lnXVNvalp/Yzb/Bn2kqbPLtZX5Fuh54PW9
 3fEgL3kgTJkup7IASmtmakEUnsBkTs4p1KjSDdGQDv1/NwicIfT2AUFPZ0+z7+3yORAX
 Di/+NAxESABXNgmeMfXGMN0LAHSbJINSh26b6ZJfWT8ALEYOk2SxMLGfz0qBUB27rLhP
 ClWQ==
X-Gm-Message-State: AOJu0Yxf27nN/xYOVAVRCE9880sawp4qOnRo0W3n4VsyKnTpGC6ihESw
 g4uh0mkF7UB5IcFJcM4gaTmMAvVYDG7z2GRHv9/hGJ8rgxEgoNFOI5hQnETk7z8=
X-Google-Smtp-Source: AGHT+IEsxZFgYCBkyJa7FOTUpAeQ1kVc/75VPAvKrq2BQmyUz73ZS6V5CWVXF2zNBxh4WLcQkWHcsA==
X-Received: by 2002:a5d:4581:0:b0:366:e9fa:178 with SMTP id
 ffacd0b85a97d-367ce5df873mr4350223f8f.0.1720668582797; 
 Wed, 10 Jul 2024 20:29:42 -0700 (PDT)
Received: from [10.11.12.72] ([90.220.10.255])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfb2327sm6609926f8f.116.2024.07.10.20.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 20:29:42 -0700 (PDT)
Message-ID: <27cc0420-df0b-481e-a58f-e17fa4d02367@opnsrc.net>
Date: Thu, 11 Jul 2024 03:29:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 4/8] hw/acpi: Update GED _EVT method AML with CPU scan
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
 <20240607115649.214622-5-salil.mehta@huawei.com>
 <20240706162845.3baf5568@imammedo.users.ipa.redhat.com>
Content-Language: en-GB
From: Salil Mehta <salil.mehta@opnsrc.net>
In-Reply-To: <20240706162845.3baf5568@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x330.google.com
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

Hi Igor,


On 06/07/2024 14:28, Igor Mammedov wrote:
> On Fri, 7 Jun 2024 12:56:45 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>
>> OSPM evaluates _EVT method to map the event. The CPU hotplug event eventually
>> results in start of the CPU scan. Scan figures out the CPU and the kind of
>> event(plug/unplug) and notifies it back to the guest. Update the GED AML _EVT
>> method with the call to \\_SB.CPUS.CSCN
>>
>> Also, macro CPU_SCAN_METHOD might be referred in other places like during GED
>> intialization so it makes sense to have its definition placed in some common
>> header file like cpu_hotplug.h. But doing this can cause compilation break
>> because of the conflicting macro definitions present in cpu.c and cpu_hotplug.c
> one of the reasons is that you reusing legacy hw/acpi/cpu_hotplug.h,
> see below for suggestion.
>
>> and because both these files get compiled due to historic reasons of x86 world
>> i.e. decision to use legacy(GPE.2)/modern(GED) CPU hotplug interface happens
>> during runtime [1]. To mitigate above, for now, declare a new common macro
>> ACPI_CPU_SCAN_METHOD for CPU scan method instead.
>> (This needs a separate discussion later on for clean-up)
>>
>> Reference:
>> [1] https://lore.kernel.org/qemu-devel/1463496205-251412-24-git-send-email-imammedo@redhat.com/
>>
>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>> Tested-by: Xianglai Li <lixianglai@loongson.cn>
>> Tested-by: Miguel Luis <miguel.luis@oracle.com>
>> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>> Tested-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>>   hw/acpi/cpu.c                  | 2 +-
>>   hw/acpi/generic_event_device.c | 4 ++++
>>   include/hw/acpi/cpu_hotplug.h  | 2 ++
>>   3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
>> index 473b37ba88..af2b6655d2 100644
>> --- a/hw/acpi/cpu.c
>> +++ b/hw/acpi/cpu.c
>> @@ -327,7 +327,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
>>   #define CPUHP_RES_DEVICE  "PRES"
>>   #define CPU_LOCK          "CPLK"
>>   #define CPU_STS_METHOD    "CSTA"
>> -#define CPU_SCAN_METHOD   "CSCN"
>> +#define CPU_SCAN_METHOD   ACPI_CPU_SCAN_METHOD
>>   #define CPU_NOTIFY_METHOD "CTFY"
>>   #define CPU_EJECT_METHOD  "CEJ0"
>>   #define CPU_OST_METHOD    "COST"
>> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
>> index 54d3b4bf9d..63226b0040 100644
>> --- a/hw/acpi/generic_event_device.c
>> +++ b/hw/acpi/generic_event_device.c
>> @@ -109,6 +109,10 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>>                   aml_append(if_ctx, aml_call0(MEMORY_DEVICES_CONTAINER "."
>>                                                MEMORY_SLOT_SCAN_METHOD));
>>                   break;
>> +            case ACPI_GED_CPU_HOTPLUG_EVT:
>> +                aml_append(if_ctx, aml_call0(ACPI_CPU_CONTAINER "."
>> +                                             ACPI_CPU_SCAN_METHOD));
> I don't particularly like exposing cpu hotplug internals for outside code
> and then making that code do plumbing hoping that nothing will explode
> in the future.
>
> build_cpus_aml() takes event_handler_method to create a method that
> can be called by platform. What I suggest is to call that method here
> instead of trying to expose CPU hotplug internals and manually building
> call path here.
> aka:
>    build_cpus_aml(event_handler_method = PATH_TO_GED_DEVICE.CSCN)
> and then call here
>    aml_append(if_ctx, aml_call0(CSCN));
> which will call  CSCN in GED scope, that was be populated by
> build_cpus_aml() to do cpu scan properly without need to expose
> cpu hotplug internal names and then trying to fixup conflicts caused by that.
>
> PS:
> we should do the same for memory hotplug, we see in context above

In the x86 world and ARM, two different types of event handling 
mechanisms are
used: one based on GPE and the other on GED. The latter has its own 
placeholder
within the generic_event_device.c file, which also multiplexes other GED 
events.
Multiplexing AMLs for two different types of handlers into 
build_cpus_aml() seems
to be a fundamental mistake here. For CPU handling, this should also not 
be done
because x86 deals with legacy hotplug and modern hotplug differently but 
still
uses the same GPE-based event handling for both. Moreover, which type of 
handler
should be used depends upon the context from which build_cpus_aml() is 
called
and it would be ugly to demultiplex these inside the build_cpus_aml() code.

Therefore, my suggestion is:
1. Keep the CPU’s _EVT handling code in the generic_event_device.c as it is.
2. Pull out the event handler method and CPU scan call-related 
initialization entirely
     out of the CPU’s AML code (i.e., both in build_cpus_aml() and 
build_legacy_cpu_hotplug_aml()).
3. Remove the input parameter of event_handler in build_cpus_aml().
4. Create a separate function like build_gpe_aml() and use this function 
in the
      following places:

File: hw/i386/acpi-build.c

build_dsdt()
{
    [...]
     scope =  aml_scope("_GPE");
    [...]
     aml_append(dsdt, scope);

     if (pcmc->legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
         CPUHotplugFeatures opts = {
             .acpi_1_compatible = true, .has_legacy_cphp = true,
             .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,
             .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
         };
         build_cpus_aml(dsdt, machine, opts, pc_madt_cpu_entry,
-                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02");
+                      pm->cpu_hp_io_base, "\\_SB.PCI0");
+      build_gpe_aml(...,, ,"\\_GPE._E02")

     }
    [...]
}

File: hw/acpi/cpu.c

@@ -343,9 +343,10 @@ const VMStateDescription vmstate_cpu_hotplug = {
  #define CPU_FW_EJECT_EVENT "CEJF"

  void build_cpus_aml(Aml *table, MachineState *machine, 
CPUHotplugFeatures opts,
-                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
+                    build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
                      const char *res_root,
-                    const char *event_handler_method)
+                    AmlRegionSpace rs)
  {
      Aml *ifctx;
      Aml *field;


That said, if you still wish you proceed with your suggestions I can go
ahead and do it but please understand that I'll have to put a check
to avoid adding call to CPU Scan for am/virt platform since we would
want to add that call as part of the GED/AML code. This is unnecessary
and would look ugly.


Thanks
Salil.


>
>
>> +                break;
>>               case ACPI_GED_PWR_DOWN_EVT:
>>                   aml_append(if_ctx,
>>                              aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
>> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
>> index 48b291e45e..ef631750b4 100644
>> --- a/include/hw/acpi/cpu_hotplug.h
>> +++ b/include/hw/acpi/cpu_hotplug.h
>> @@ -20,6 +20,8 @@
>>   #include "hw/acpi/cpu.h"
>>   
>>   #define ACPI_CPU_HOTPLUG_REG_LEN 12
>> +#define ACPI_CPU_SCAN_METHOD "CSCN"
>> +#define ACPI_CPU_CONTAINER "\\_SB.CPUS"
>>   
>>   typedef struct AcpiCpuHotplug {
>>       Object *device;

