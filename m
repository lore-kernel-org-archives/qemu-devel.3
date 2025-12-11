Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D75D43359
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 22:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTp0v-0006ZV-AB; Thu, 11 Dec 2025 17:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vTp0p-0006Xp-0r
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 17:19:52 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vTp0l-0002uy-O6
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 17:19:50 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7aa2170adf9so533637b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 14:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765491586; x=1766096386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5bEqGIVPPRLXlqL/30bOCe5ZV2sUC4j9VKrGby81KYU=;
 b=xyigyNu+5ImUBXQkYsahiEDgwy8ih6seTIuwuW5KVIc0KRXVc6SJILq71rWXcmr2Qm
 NoQeQlNS2Zt7HlgYnl531VcwHxMP1DkkVfce+ComfCOuSWk0uBqeKQ3ubsNQyJHJ7Fc4
 H+lt8UQEf9WwnJAKjpc+onm/AeU+SBlWWuGWJN8SceQh7bdyFrLzTl8RPD0G4sjhOE/b
 yuOfSFP7kbgN6jj7/sS4mG9cvh+ZxbEU1SYarlkw193oqgXv15rBOO6mqklnmJIA29N7
 C1ldhhYnCn0qZrLmXoKF0s/MJouvOKhI4iUPV3QfheKlOZw5v0Z6GfNQ+C7xniKbHdmZ
 cnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765491586; x=1766096386;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5bEqGIVPPRLXlqL/30bOCe5ZV2sUC4j9VKrGby81KYU=;
 b=uWGcs9hAmNSyDLVaXsUCrphaEmNKVJ+b6UrglNIYg6wNuJ00Eg+NRV2/ILLuBkaBJK
 IQeZka/PmeshaJ8IcCvmAq20NmOnOgAESIzNra/SX7ioenJe+0v3nuUooCooJTDo1tHV
 +wiJPs3J9xwg5PdVi0EQAAxDnCzAFY44t+5bSNbuOfu5kDRQgS6uUxnhSvPq1eRWOnvW
 IomVLXcsRNRKJDsAn6jo4rL55zkEOaq401+sIYyWlLH2LSj0U2gnBRS5E86pC8rQLwQp
 5CIFwLcLZXQhwiOlAag0Zp7N2cpW//zI5oDvrnUuY0+XOtAKcjaHMU023ElIUNt5HH90
 u08w==
X-Gm-Message-State: AOJu0YwMu8WEsF0j53X41JIFUtqRNI5K4R7OLxiGuOeztq7dQjz7TlIt
 T2+bcxx8avcmjUWFuJoDZp8B2k26NLC/V+i12sgs9xWrY5wYUtk7KvmWBtmTtbWYVb8=
X-Gm-Gg: AY/fxX5ey3DWUtA/JyxutDqO7L+3o0cymOvxVEGgN+iVbxlmNULSbj/xoh7k8NEOs9s
 AxrzjPvaKE7KIyk4XGDDwuWgiygbzlCS6nYG77WVeuBfZsO9pzbDZnx3hEuT04nqht4o8ZDurTe
 LTuMPBPa/1VmmLzIegpFGP0Te335lfIk8MsdH3KH+cNo7meahMG1soK04NAYt9RDhUolqHqK5rg
 QsvLQXYtbsvIRHcaRK22h1RvaD6gidTOkxqrrvCynWe/97rz0J7XamkyadtlxRuwb36CSYW2EGr
 fEET8trq5alRnL/aDen5WW1ykAqD6N5m113Ii8OUbhP8Yuj6GN7GgldypELWKOZhvkvk0sExNnC
 H5NmTdWLMgA1RWMfcbTCZIUEb8SO/jsmY9Xi59IO6FQb6EuUBkCUWffbz5NcxA0M1CaX76e2dCg
 7IPsrOnJG3yI8vB+LBqrwFUbRcTatPjh+S3yrwa8tGC4Tj1/T+cUzH1qI=
X-Google-Smtp-Source: AGHT+IGy1ZCX7/aQXlPWRzcT5JnfGPx2y50zbSE0KwB2QTCW6H2IsoyfPzPMD4Oe7WSfzPrviwfdhQ==
X-Received: by 2002:a05:6a20:258c:b0:35f:fafa:a198 with SMTP id
 adf61e73a8af0-369ad5e705fmr26142637.10.1765491585902; 
 Thu, 11 Dec 2025 14:19:45 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c25a87487sm3219470a12.7.2025.12.11.14.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 14:19:45 -0800 (PST)
Message-ID: <d51f1433-ee70-4bb8-bebf-e348008460eb@linaro.org>
Date: Thu, 11 Dec 2025 14:19:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 08/21] hw/arm/smmuv3: Add separate address space for
 secure SMMU accesses
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012150701.4127034-9-tangtao1634@phytium.com.cn>
 <db7fde79-85fa-4bd4-83ca-021ed3f09353@linaro.org>
In-Reply-To: <db7fde79-85fa-4bd4-83ca-021ed3f09353@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 12/11/25 2:12 PM, Pierrick Bouvier wrote:
> Hi Tao,
> 
> On 10/12/25 8:06 AM, Tao Tang wrote:
>> According to the Arm architecture, SMMU-originated memory accesses,
>> such as fetching commands or writing events for a secure stream, must
>> target the Secure Physical Address (PA) space. The existing model sends
>> all DMA to the global non-secure address_space_memory.
>>
>> This patch introduces the infrastructure to differentiate between secure
>> and non-secure memory accesses. Firstly, SMMU_SEC_SID_S is added in
>> SMMUSecSID enum to represent the secure context. Then a weak global
>> symbol, arm_secure_address_space, is added, which can be provided by the
>> machine model to represent the Secure PA space.
>>
>> A new helper, smmu_get_address_space(), selects the target address
>> space based on SEC_SID. All internal DMA calls
>> (dma_memory_read/write) will be updated to use this helper in follow-up
>> patches.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>    hw/arm/smmu-common.c         |  8 ++++++++
>>    hw/arm/virt.c                |  5 +++++
>>    include/hw/arm/smmu-common.h | 27 +++++++++++++++++++++++++++
>>    3 files changed, 40 insertions(+)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 62a7612184..24db448683 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -30,6 +30,14 @@
>>    #include "hw/arm/smmu-common.h"
>>    #include "smmu-internal.h"
>>    
>> +/* Global state for secure address space availability */
>> +bool arm_secure_as_available;
>> +
>> +void smmu_enable_secure_address_space(void)
>> +{
>> +    arm_secure_as_available = true;
>> +}
>> +
>>    /* IOTLB Management */
>>    
>>    static guint smmu_iotlb_key_hash(gconstpointer v)
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 175023897a..83dc62a095 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -92,6 +92,8 @@
>>    #include "hw/cxl/cxl_host.h"
>>    #include "qemu/guest-random.h"
>>    
>> +AddressSpace arm_secure_address_space;
>> +
>>    static GlobalProperty arm_virt_compat[] = {
>>        { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
>>    };
>> @@ -2257,6 +2259,9 @@ static void machvirt_init(MachineState *machine)
>>            memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
>>                               UINT64_MAX);
>>            memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
>> +        address_space_init(&arm_secure_address_space, secure_sysmem,
>> +                           "secure-memory-space");
>> +        smmu_enable_secure_address_space();
>>        }
>>    
>>        firmware_loaded = virt_firmware_init(vms, sysmem,
>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>> index b0dae18a62..d54558f94b 100644
>> --- a/include/hw/arm/smmu-common.h
>> +++ b/include/hw/arm/smmu-common.h
>> @@ -43,9 +43,36 @@
>>    /* StreamID Security state */
>>    typedef enum SMMUSecSID {
>>        SMMU_SEC_SID_NS = 0,
>> +    SMMU_SEC_SID_S,
>>        SMMU_SEC_SID_NUM,
>>    } SMMUSecSID;
>>    
>> +extern AddressSpace __attribute__((weak)) arm_secure_address_space;
>> +extern bool arm_secure_as_available;
>> +void smmu_enable_secure_address_space(void);
>> +
>> +/*
>> + * Return the address space corresponding to the SEC_SID.
>> + * If SEC_SID is Secure, but secure address space is not available,
>> + * return NULL and print a warning message.
>> + */
>> +static inline AddressSpace *smmu_get_address_space(SMMUSecSID sec_sid)
>> +{
>> +    switch (sec_sid) {
>> +    case SMMU_SEC_SID_NS:
>> +        return &address_space_memory;
>> +    case SMMU_SEC_SID_S:
>> +        if (!arm_secure_as_available || arm_secure_address_space.root == NULL) {
>> +            printf("Secure address space requested but not available");
>> +            return NULL;
>> +        }
>> +        return &arm_secure_address_space;
>> +    default:
>> +        printf("Unknown SEC_SID value %d", sec_sid);
>> +        return NULL;
>> +    }
>> +}
>> +
>>    /*
>>     * Page table walk error types
>>     */
> 
> I ran into the same issue, when adding Granule Protection Check to the
> SMMU, for RME support. It requires access to secure memory, where
> Granule Protection Table is kept, and thus, access secure address space.
> 
> After talking with Richard and Philippe, I have been suggested a better
> way. Similar to how arm cpus handle this, boards (virt & sbsa-ref) are
> simply passing pointers to MemoryRegion for global and secure memory.
> Then, the SMMU can create its own address spaces, based on those regions.
> 
> It's clean, does not require any weak variable, and mimic what is
> already done for cpus. Please see the two patches attached.
> 
> First one define properties, and pass memory regions from boards to
> SMMU. Second one replace global address spaces with SMMU ones.
> 
> I'll send patch 1 as it's own series, and you can take inspiration from
> patch 2 for this series. SMMU unit tests will need to be modified to be
> passed the memory regions also.
> 
> Regards,
> Pierrick

Sent patch 1 here:
https://lore.kernel.org/qemu-devel/20251211221715.2206662-1-pierrick.bouvier@linaro.org/T/#u

