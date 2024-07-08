Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CDBC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 05:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQgu9-0006Ju-9B; Mon, 08 Jul 2024 01:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sQgu5-00066i-S9
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:27:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sQgtt-0002v5-5j
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:27:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4255fc43f1cso23685525e9.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 22:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1720416416; x=1721021216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R/DeiRpjh0GXdaS/rrFXzjHReveWUeCqSmh6wE1DD64=;
 b=WtolVME0+TSRhQ003nNQUdCTIpSDrIZVffIdzoWc4Li5weql14BdBNy7t58RE//C/6
 UPtQ9ZZfJdS5uYJy8JzPBHqhAgb7SCnPzuQTQEVH9oFv5OKohkMsNCLBfsWtQAzauCzQ
 bXv/vIWWZyjGLzutX+CRmk9e9vZI/6qRAgw5RHN/GOVU5xojtCVxn2vC6xyd2kCugLC6
 ByhaqHVsyRZkn5xJiEgTnl08b4n9CpUYOVONrUCrTxyRgsdJ4nDhArj4hIuWKr+57/LI
 ePFac9D7PYZceG8tSCoIW9iDg0PX9q+bqvZ/YPwa+dlPuksyohsYDFtbO75myGWe5paK
 pWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720416416; x=1721021216;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R/DeiRpjh0GXdaS/rrFXzjHReveWUeCqSmh6wE1DD64=;
 b=PAPfS82XO0psG9tS+e+nXvMeb06LIh9nM999DXcvbGFDG+3DJMXgGrFcrWmmbqlUSS
 ALw0sxnS+ScJlGIyesALq/aj5DtMPu7O3iv8u6qzznx2K9Z9vdjg8gOb3ZCvELGhRgsn
 EBkd5cduGYMkEAOVKAC+kWuOzNNIKZxVbIQclLEqmNmWPsiBL/fZFOxtU3UF9NZSAbmr
 au6lcvutMjx0jBE/oVY04bKRdzFafR5Y+4KWyv/Hb+PUwllvjRSOu1LCWms+cP81maFA
 schKjTfhI7Gep0yZLtMfBB/7boIcT8GvC5X3+4MZ18YtH840t90AB7sa6ZpxU9p6pchq
 O7Rw==
X-Gm-Message-State: AOJu0YxIYw3IA6WghfULYN4pEXRVl4wp7wKrzwl9WwimplsW8/hganS7
 dCKrG/mUX9A83znjRVX6iTFGFMo6Tug78k9uk4llRowvkVX0+ReyvoOJHW23N8Q=
X-Google-Smtp-Source: AGHT+IEXDtT0MJkQ0T3ZZFmiaEmN65ghdH9fEeb9RuZmHgK605Z4GpIm0fEwoyzzqHM7WG80cCiTnw==
X-Received: by 2002:a05:600c:4202:b0:426:66fe:8051 with SMTP id
 5b1f17b1804b1-42666fe8219mr21466175e9.24.1720416415459; 
 Sun, 07 Jul 2024 22:26:55 -0700 (PDT)
Received: from [10.11.12.72] ([90.220.10.255])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266dd5eca3sm841795e9.21.2024.07.07.22.26.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 22:26:55 -0700 (PDT)
Message-ID: <3ff1db66-0947-4876-96f6-53f228e0b74d@opnsrc.net>
Date: Mon, 8 Jul 2024 05:26:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 6/8] physmem: Add helper function to destroy CPU
 AddressSpace
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
 <20240607115649.214622-7-salil.mehta@huawei.com>
 <20240706163704.524ba618@imammedo.users.ipa.redhat.com>
Content-Language: en-GB
From: Salil Mehta <salil.mehta@opnsrc.net>
In-Reply-To: <20240706163704.524ba618@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 06/07/2024 14:37, Igor Mammedov wrote:
> On Fri, 7 Jun 2024 12:56:47 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>
>> Virtual CPU Hot-unplug leads to unrealization of a CPU object. This also
>> involves destruction of the CPU AddressSpace. Add common function to help
>> destroy the CPU AddressSpace.
>>
>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Tested-by: Xianglai Li <lixianglai@loongson.cn>
>> Tested-by: Miguel Luis <miguel.luis@oracle.com>
>> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>> Tested-by: Zhao Liu <zhao1.liu@intel.com>
>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
Thanks, Salil.
>
>> ---
>>   include/exec/cpu-common.h |  8 ++++++++
>>   include/hw/core/cpu.h     |  1 +
>>   system/physmem.c          | 29 +++++++++++++++++++++++++++++
>>   3 files changed, 38 insertions(+)
>>
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index 815342d043..240ee04369 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -129,6 +129,14 @@ size_t qemu_ram_pagesize_largest(void);
>>    */
>>   void cpu_address_space_init(CPUState *cpu, int asidx,
>>                               const char *prefix, MemoryRegion *mr);
>> +/**
>> + * cpu_address_space_destroy:
>> + * @cpu: CPU for which address space needs to be destroyed
>> + * @asidx: integer index of this address space
>> + *
>> + * Note that with KVM only one address space is supported.
>> + */
>> +void cpu_address_space_destroy(CPUState *cpu, int asidx);
>>   
>>   void cpu_physical_memory_rw(hwaddr addr, void *buf,
>>                               hwaddr len, bool is_write);
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index bb398e8237..60b160d0b4 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -486,6 +486,7 @@ struct CPUState {
>>       QSIMPLEQ_HEAD(, qemu_work_item) work_list;
>>   
>>       struct CPUAddressSpace *cpu_ases;
>> +    int cpu_ases_count;
>>       int num_ases;
>>       AddressSpace *as;
>>       MemoryRegion *memory;
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 342b7a8fd4..146f17826a 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -763,6 +763,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>>   
>>       if (!cpu->cpu_ases) {
>>           cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
>> +        cpu->cpu_ases_count = cpu->num_ases;
>>       }
>>   
>>       newas = &cpu->cpu_ases[asidx];
>> @@ -776,6 +777,34 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>>       }
>>   }
>>   
>> +void cpu_address_space_destroy(CPUState *cpu, int asidx)
>> +{
>> +    CPUAddressSpace *cpuas;
>> +
>> +    assert(cpu->cpu_ases);
>> +    assert(asidx >= 0 && asidx < cpu->num_ases);
>> +    /* KVM cannot currently support multiple address spaces. */
>> +    assert(asidx == 0 || !kvm_enabled());
>> +
>> +    cpuas = &cpu->cpu_ases[asidx];
>> +    if (tcg_enabled()) {
>> +        memory_listener_unregister(&cpuas->tcg_as_listener);
>> +    }
>> +
>> +    address_space_destroy(cpuas->as);
>> +    g_free_rcu(cpuas->as, rcu);
>> +
>> +    if (asidx == 0) {
>> +        /* reset the convenience alias for address space 0 */
>> +        cpu->as = NULL;
>> +    }
>> +
>> +    if (--cpu->cpu_ases_count == 0) {
>> +        g_free(cpu->cpu_ases);
>> +        cpu->cpu_ases = NULL;
>> +    }
>> +}
>> +
>>   AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
>>   {
>>       /* Return the AddressSpace corresponding to the specified index */

