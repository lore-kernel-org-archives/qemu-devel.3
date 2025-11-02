Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D39CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 23:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFh6M-0007Ri-G7; Sun, 02 Nov 2025 18:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vFh6L-0007RN-Sm
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 18:03:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vFh6J-0003Ny-Bd
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 18:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762124585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPulkiy2ucm/s92x/ug0j171LDt49kx6+5P/k/6RWbU=;
 b=VKWHiosXSKPUJ4YgF4MoPU56OguYhRXq/YTGErOvlT0UuAabldY+2NEiJVlUW78zijmlq6
 8LyxFW2AHDTPUcCCL1S/8cienyjDl8mi1We719ZsSGG/0ixe2AxazLA5dKicFY2si/E0MH
 COeyKh1n9oy1W0CpAdo6RAaDQ3a6xPE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-ifIUI_60Pn-oCACuYV8y3A-1; Sun, 02 Nov 2025 18:03:02 -0500
X-MC-Unique: ifIUI_60Pn-oCACuYV8y3A-1
X-Mimecast-MFC-AGG-ID: ifIUI_60Pn-oCACuYV8y3A_1762124581
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-286a252bfbfso95476635ad.3
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 15:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762124581; x=1762729381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BPulkiy2ucm/s92x/ug0j171LDt49kx6+5P/k/6RWbU=;
 b=VDtZ0rWm1V9rqdIlU7fa9+ZaFjA/7RLPOkycZPg4qMu6y3oX5V01U5Rf3BzjhVJprf
 dJqBCkVXlXktEnh0ekxA3dXgC6SgIVP93bTnkypB6iy0tb6r2ieWzxc9ADfp8oVBxGwy
 eGqewZVd+OLowQpXcTSp1Az7PtJy5j03LKKV5M/PdPQTTOj1a6ovYnHWD6vseo9IWnJ/
 HQ5kTdNAJ4SeHvLxFwIIrcB12J7X0JcevfcVMeVDFWW47H3ZkQ9mLmqlVtjD7bjcospp
 Mvpg9+sKwt0Fl8ZUvHX+25lpXrDAovO/W1l96n4g1csFedju9LuRQ8Pd14V/elQCFw/F
 Quqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762124581; x=1762729381;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BPulkiy2ucm/s92x/ug0j171LDt49kx6+5P/k/6RWbU=;
 b=Q8b8PgTqSJfe44zDVJR9j/mWeoRswjoz3Vcl/QuqJNzaOL8rcBAbu6FAbE6IAZd5w6
 kUuRnIA6WJiKQhHriPQKTxS4kqiJU5Qb4ofJr5WMB8/OFgMRK4sztbd9DS2aSi90vHPM
 DqUI6DUEf2XPnc1Wb9Pyu+pXsa+0BkzZrlywVHh2yqepP5oBhBK1DSXZOlAqFK5PUy1Q
 bfPmfedu2U6zTydTe1EowWdUCz8j/FHKRne90BqlsdtAwI+subsTnc+EfCjoQU9YIJys
 7eIdP+YYIaMprISWB1mLLt7IDqzDmt/kU/ANIZDjICEA/+l1Kfdx8rg6muUGCSwE56E9
 JSyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkHbNndAxSgT5ioPYsocuePeA+iXmfQ4DTQHFDxFL72y/uuy77lYBu7ynsw4yEGtBl9UW+Cr/eLpiK@nongnu.org
X-Gm-Message-State: AOJu0YxvraAbmPqaCtrZVbp7GkCWFTuCl5k9bvYGpF8j8/k9zxpcjuuk
 R1427RI2WRcCd5nfvFU4fP3IWj7bf06grKcbaoVlJW8WXers0zuSaxChs951ERjvmD77xnoaJdN
 wh1lxbvN4nnSksF3Fssi6j/CXsORvBBD0gMqI2kSDAYUVoaV9JEDyF5Dj
X-Gm-Gg: ASbGncugGKMe8eDNgrLHxUTrIorZbWC+fmmShGdeF0tmYZeiHyukwY2XNFwbKFlB8av
 unLmqC18isDNoauaLS+RFn2UDz6eokUdKF9hN+P1fWvpN68Aa9CrY546JG1WpFcAw0tfSyMkTIb
 k6KZPpE36drIaAG9tot78ZjMdvIYwWf5Z7NyHDi/gMuNMxg3ciItQrjqwuq0a2OCDGQbuLItZ+p
 LGu8bZQJrb9+kTeY/cj1RBfk/W3Gm4BsHOUOxPIu3rUkP+ukAmXojHNG7O6a3F1NvV1qoN12xpq
 F/AIcgx51n5etRp545ozKuJXT+tdQNeYVkyEDKpxiZQS/An6OmkCS2BZe2Dfz3UqODkLh/kwMvl
 IIcQZV7IzfaFBJt8foH2hmfgwxzAhANK4TW6Jrmo=
X-Received: by 2002:a17:903:41cd:b0:24c:da3b:7376 with SMTP id
 d9443c01a7336-2951a3b0522mr147073565ad.26.1762124580640; 
 Sun, 02 Nov 2025 15:03:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6b6EUY0uQiYZ2ibOm9h67Fj5ACS/XDgFNQAa54ojTG3jNX3enEz5Y/WJQtQ2B+aRHK9tBIA==
X-Received: by 2002:a17:903:41cd:b0:24c:da3b:7376 with SMTP id
 d9443c01a7336-2951a3b0522mr147073205ad.26.1762124580111; 
 Sun, 02 Nov 2025 15:03:00 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-295269bda9csm95225725ad.104.2025.11.02.15.02.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Nov 2025 15:02:59 -0800 (PST)
Message-ID: <88a41137-d5fb-4b61-a3f2-dd73133c17ec@redhat.com>
Date: Mon, 3 Nov 2025 09:02:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 3/3] target/arm/kvm: Support multiple memory
 CPERs injection
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, mchehab+huawei@kernel.org, Jonathan.Cameron@huawei.com,
 shan.gavin@gmail.com
References: <20251007060810.258536-1-gshan@redhat.com>
 <20251007060810.258536-4-gshan@redhat.com> <20251017162746.2a99015b@fedora>
 <a635de53-71fa-4edb-87c0-8775722c284d@redhat.com>
 <20251031145539.3551b0a5@fedora>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251031145539.3551b0a5@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/31/25 11:55 PM, Igor Mammedov wrote:
> On Sun, 19 Oct 2025 10:36:16 +1000
> Gavin Shan <gshan@redhat.com> wrote:
>> On 10/18/25 12:27 AM, Igor Mammedov wrote:
>>> On Tue,  7 Oct 2025 16:08:10 +1000
>>> Gavin Shan <gshan@redhat.com> wrote:
>>>    
>>>> In the combination of 64KB host and 4KB guest, a problematic host page
>>>> affects 16x guest pages. In this specific case, it's reasonable to
>>>> push 16 consecutive memory CPERs. Otherwise, QEMU can run into core
>>>> dump due to the current error can't be delivered as the previous error
>>>> isn't acknoledges. It's caused by the nature the host page can be
>>>> accessed in parallel due to the mismatched host and guest page sizes.
>>>
>>> can you explain a bit more what goes wrong?
>>>
>>> I'm especially interested in parallel access you've mentioned
>>> and why batch adding error records is needed
>>> as opposed to adding records every time invalid access happens?
>>>
>>> PS:
>>> Assume I don't remember details on how HEST works,
>>> Answering it in this format also should improve commit message
>>> making it more digestible for uninitiated.
>>>    
>>
>> Thanks for your review and I'm trying to answer your question below. Please let
>> me know if there are more questions.
>>
>> There are two signals (BUS_MCEERR_AR and BUS_MCEERR_AO) and BUS_MCEERR_AR is
>> concerned here. This signal BUS_MCEERR_AR is sent by host's stage2 page fault
>> handler when the resolved host page has been marked as marked as poisoned.
>> The stage2 page fault handler is invoked on every access to the host page.
>>
>> In the combination where host and guest has 64KB and 4KB separately, A 64KB
>> host page corresponds to 16x consecutive 4KB guest pages. It means we're
>> accessing the 64KB host page when any of those 16x consecutive 4KB guest pages
>> is accessed. In other words, a problematic 64KB host page affects the accesses
>> on 16x 4KB guest pages. Those 16x 4KB guest pages can be owned by different
>> threads on the guest and they run in parallel, potentially to access those
>> 16x 4KB guest pages in parallel. It potentially leading to 16x BUS_MCEERR_AR
>> signals at one point.
>>
>> In current implementation, the error record is built as the following calltrace
>> indicates. There are 16 error records in the extreme case (parallel accesses on
>> 16x 4KB guest pages, mapped to one 64KB host page). However, we can't handle
>> multiple error records at once due to the acknowledgement mechanism in
>> ghes_record_cper_errors(). For example, the first error record has been sent,
>> but not consumed by the guest yet. We fail to send the second error record.
>>
>> kvm_arch_on_sigbus_vcpu
>>     acpi_ghes_memory_errors
>>       ghes_gen_err_data_uncorrectable_recoverable      // Generic Error Data Entry
>>       acpi_ghes_build_append_mem_cper                  // Memory Error
>>       ghes_record_cper_errors
>>         
>> So this series improves this situation by simply sending 16x error records in
>> one shot for the combination of 64KB host + 4KB guest.
> 
> 1) What I'm concerned about is that it target one specific case only.
> Imagine if 1st cpu get error on page1 and another on page2=(page1+host_page_size)
> and so on for other CPUs. Then we are back where we were before this series.
> 
> Also in abstract future when ARM gets 1Gb pages, that won't scale well.
> 
> Can we instead of making up CPERs to cover whole host page,
> create 1/vcpu GHES source?
> That way when vcpu trips over bad page, it would have its own
> error status block to put errors in.
> That would address [1] and deterministically scale
> (well assuming that multiple SEA error sources are possible in theory)
> 

I think it's a good idea to have individual error source for each vCPU. In this
way, the read_ack_reg won't be a limitation. I hope Jonathan is ok to this scheme.

Currently, we have two (fixed) error sources like below. I assume the index of
the error source per vCPU will starts from (ACPI_HEST_SRC_ID_QMP + 1) based on
CPUState::cpu_index.

enum AcpiGhesSourceID {
     ACPI_HEST_SRC_ID_SYNC,
     ACPI_HEST_SRC_ID_QMP,       /* Use it only for QMP injected errors */
};


> PS:
> I also wonder what real HW does when it gets in similar situation
> (i.e. error status block is not yet acknowledged but another async
> error arrived for the same error source)?
> 

I believe real HW also have this specific issue. As to ARM64, I ever did some
google search and was told the error follows the firmware-first policy and
handled by a component of trustfirmware-a. However, I was unable to get the
source code. So it's hard for me to know how this specific issue is handled
there.

Thanks,
Gavin

>>>> Imporve push_ghes_memory_errors() to push 16x consecutive memory CPERs
>>>> for this specific case. The maximal error block size is bumped to 4KB,
>>>> providing enough storage space for those 16x memory CPERs.
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>    hw/acpi/ghes.c   |  2 +-
>>>>    target/arm/kvm.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>>>>    2 files changed, 46 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
>>>> index 045b77715f..5c87b3a027 100644
>>>> --- a/hw/acpi/ghes.c
>>>> +++ b/hw/acpi/ghes.c
>>>> @@ -33,7 +33,7 @@
>>>>    #define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
>>>>    
>>>>    /* The max size in bytes for one error block */
>>>> -#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
>>>> +#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (4 * KiB)
>>>>    
>>>>    /* Generic Hardware Error Source version 2 */
>>>>    #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
>>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>>> index c5d5b3b16e..3ecb85e4b7 100644
>>>> --- a/target/arm/kvm.c
>>>> +++ b/target/arm/kvm.c
>>>> @@ -11,6 +11,7 @@
>>>>     */
>>>>    
>>>>    #include "qemu/osdep.h"
>>>> +#include "qemu/units.h"
>>>>    #include <sys/ioctl.h>
>>>>    
>>>>    #include <linux/kvm.h>
>>>> @@ -2433,10 +2434,53 @@ static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
>>>>                                        uint64_t paddr)
>>>>    {
>>>>        GArray *addresses = g_array_new(false, false, sizeof(paddr));
>>>> +    uint64_t val, start, end, guest_pgsz, host_pgsz;
>>>>        int ret;
>>>>    
>>>>        kvm_cpu_synchronize_state(c);
>>>> -    g_array_append_vals(addresses, &paddr, 1);
>>>> +
>>>> +    /*
>>>> +     * Sort out the guest page size from TCR_EL1, which can be modified
>>>> +     * by the guest from time to time. So we have to sort it out dynamically.
>>>> +     */
>>>> +    ret = read_sys_reg64(c->kvm_fd, &val, ARM64_SYS_REG(3, 0, 2, 0, 2));
>>>> +    if (ret) {
>>>> +        goto error;
>>>> +    }
>>>> +
>>>> +    switch (extract64(val, 14, 2)) {
>>>> +    case 0:
>>>> +        guest_pgsz = 4 * KiB;
>>>> +        break;
>>>> +    case 1:
>>>> +        guest_pgsz = 64 * KiB;
>>>> +        break;
>>>> +    case 2:
>>>> +        guest_pgsz = 16 * KiB;
>>>> +        break;
>>>> +    default:
>>>> +        error_report("unknown page size from TCR_EL1 (0x%" PRIx64 ")", val);
>>>> +        goto error;
>>>> +    }
>>>> +
>>>> +    host_pgsz = qemu_real_host_page_size();
>>>> +    start = paddr & ~(host_pgsz - 1);
>>>> +    end = start + host_pgsz;
>>>> +    while (start < end) {
>>>> +        /*
>>>> +         * The precise physical address is provided for the affected
>>>> +         * guest page that contains @paddr. Otherwise, the starting
>>>> +         * address of the guest page is provided.
>>>> +         */
>>>> +        if (paddr >= start && paddr < (start + guest_pgsz)) {
>>>> +            g_array_append_vals(addresses, &paddr, 1);
>>>> +        } else {
>>>> +            g_array_append_vals(addresses, &start, 1);
>>>> +        }
>>>> +
>>>> +        start += guest_pgsz;
>>>> +    }
>>>> +
>>>>        ret = acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses);
>>>>        if (ret) {
>>>>            goto error;
>>>    
>>
> 


