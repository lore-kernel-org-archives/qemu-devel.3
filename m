Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49889CD3428
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 17:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJEmM-0006Vp-La; Wed, 12 Nov 2025 12:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vJEmA-0006Pk-Bi
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 12:37:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vJEm7-0001Tr-Pi
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 12:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762969014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUYbtUVpev68mdqXTAQcmD4hm2oLVLHGGRnndigEsIg=;
 b=B5NGvZzpzW2x7CpETp2Qs0yoXXFgIi7jAEgmTZkZe60fKG3Rn3ZyiIgk7KbUmMSbA/IOYC
 dIsrSUyJiFfjk6ea3z4GbuFXFi8PZCutXqn3xYiLTCHuh+Df0tOaP1+MZGY02drjlFihoK
 b7r6HPW79Dn5wcWeG1/cFJzOIJEektg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-qdjRfXY8OtClnK3XMMoa-g-1; Wed, 12 Nov 2025 12:36:53 -0500
X-MC-Unique: qdjRfXY8OtClnK3XMMoa-g-1
X-Mimecast-MFC-AGG-ID: qdjRfXY8OtClnK3XMMoa-g_1762969012
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-341661973daso1392803a91.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 09:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762969012; x=1763573812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dUYbtUVpev68mdqXTAQcmD4hm2oLVLHGGRnndigEsIg=;
 b=IeuabYNXfLsBhN5ybamdA9cosNmoGIqo0l5cSnYdovD3dea1TXM1nXVaCrFUG6CD7J
 yvQEWfokJgJIlJSf4tda40iC2MxAGjUq03xpTZpuxrHsEP711DcSyGeHkladZKGok+Q6
 euiABAJpPdhVeb5SIWOUgUY7UsN83M/nVxU7CQKG05CksZ2eSYkDtPc5cANSMpzXUsIy
 HewD1sd/6ixD+3opY4ObTFgGfH9FG7M30SzKcIdPXtwItXlm4iXVh1lkVDq1AL4L34cz
 zPtLCYCb5CHI5W/UwlLdNdMdGyKccxdLRps+cVybQPWAkHYpGEAUww/wdw8/Mr5+3a8d
 7xTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762969012; x=1763573812;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dUYbtUVpev68mdqXTAQcmD4hm2oLVLHGGRnndigEsIg=;
 b=dD7g2Zwv+TEW7qOiQp47j/699ooGkagHqBi2RPvGvqGnuNxURBguJgTfP0zO4Is+5X
 jNnR5xTIqucpWz0mk+8804cC4tgGdSfM7HRW5SpaeCU6ARLDeuWQXAkSlWudRLC0BTKo
 dCUKRunztbx0nWYJivDtyto4N3I+tPWzdbYuF3fw9iaMiBIb/maOO8C3qV+U3gUAr2zv
 qpTVYQQGBhbiokdYHJopPyEKVbsJ2/43gP3YDR3wUUpYLKTPtAl5sMskMG6Bqjj7ekXD
 OAll4oMGjFO1NhWgwnC2f15Oet8owVEiuFHV+DlY1KWKf0hlrhHKAw1XD5WISDKtkyBL
 BKdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrCb18NUHzOSPHTW7excCdIdJ0YLoyO8+socUVY8yAHA0fMMsvCR+J/TQpF2k8bfkPMtn3w9/yLocc@nongnu.org
X-Gm-Message-State: AOJu0YzLyMaOapnENRWUq684GjbUx6d9+jdtX/fEBYQw3IaqAm09tXjn
 u+L+gCWRmxFQqy2IjVHlyC0BUPQu3nFA394EDEQZWxtLcS+T3TwOh7LIGLd4fAkum0+m8I5VREm
 htS/gYE8ErtiKq1r8tYZWkyHrox9gkRL+BrlZBomHCUG6BCHRBuEmlrJM
X-Gm-Gg: ASbGnct72u2IuEowMOhxoXMb7E9ijUD6VpANmnmqrPKNUqSrlx9AZnZP6tCYPTU5X0S
 QtC0lgfLXfpD+X578txYAKNhCaa6g2KD1bgPttdviIL16DoBybR6yg9kdniBH3TL4Ig1YM58uI3
 dC1zTMKu58Me4FLaeiGIEMz44+H6pd2oqleKzF9qs3WRcTlnISKryVaCWjg1TkHjjY/Oaoyu9Xr
 V/LNw47v072/hgWorfTTKwN/s2VwGIAuL9GRApXIIrRZUeLW0SKpzXsM+2Mc95xArjbjw7Q3hVl
 LfSfHVozsHTYj+JgyMSnPS2j3mnrK1QsWF7MOGe1yW8oEOq4nTYyhjEyBadqORI7PhBDB5lEuCw
 ZAD8Xv+QNbYXITDf76vZZjlNP9FWtUYLQ8gFyL7Y=
X-Received: by 2002:a17:90b:2cc4:b0:340:54a1:d6fe with SMTP id
 98e67ed59e1d1-343dde294c6mr4421434a91.15.1762969011909; 
 Wed, 12 Nov 2025 09:36:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElqibeHhHu36Zqno+4iK4E6qn7bAgaYPW/6/VDJyqrvX6l17k3t3K/D0pi7bbKbyfH/rjZ8w==
X-Received: by 2002:a17:90b:2cc4:b0:340:54a1:d6fe with SMTP id
 98e67ed59e1d1-343dde294c6mr4421396a91.15.1762969011422; 
 Wed, 12 Nov 2025 09:36:51 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e0715737sm3341861a91.6.2025.11.12.09.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 09:36:50 -0800 (PST)
Message-ID: <5eb0786e-39b6-4d7d-856e-e7e77cf033d4@redhat.com>
Date: Thu, 13 Nov 2025 03:36:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] acpi/ghes: Extend acpi_ghes_memory_errors() to
 support multiple CPERs
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 shan.gavin@gmail.com
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-5-gshan@redhat.com> <20251110153801.258be29d@fedora>
 <659b0d40-6b06-42a8-ba7d-73dd2dcdf0f0@redhat.com>
 <20251112141203.7d663088@fedora>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251112141203.7d663088@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Igor,

On 11/12/25 11:12 PM, Igor Mammedov wrote:
> On Tue, 11 Nov 2025 14:40:42 +1000
> Gavin Shan <gshan@redhat.com> wrote:
>> On 11/11/25 12:38 AM, Igor Mammedov wrote:
>>> On Wed,  5 Nov 2025 21:44:49 +1000
>>> Gavin Shan <gshan@redhat.com> wrote:
>>>    
>>>> In the situation where host and guest has 64KiB and 4KiB page sizes,
>>>> one problematic host page affects 16 guest pages. we need to send 16
>>>> consective errors in this specific case.
>>>
>>> I still don't like it, since it won't fix anything in case of more than
>>> 1 broken host pages. (in v2 discussion quickly went hugepages route
>>> and futility of recovering from them).
>>>
>>> If having per vCPU source is not desirable,
>>> can we stall all other vcpus that touch poisoned pages until
>>> error is acked by guest and then let another VCPU to queue its own error?
>>>    
>>
>> We're trying to avoid the guest from suddenly disappearing due to the QEMU
>> crash, instead of recovering from the memory errors. To keep the guest
>> accessible, system administrators still get a chance to collect important
>> information from the guest.
>>
>> The idea of stalling the vCPU which is accessing any poisoned pages and
>> retry on delivering the error was proposed in v1, but was rejected.
>>
>> https://lists.nongnu.org/archive/html/qemu-arm/2025-02/msg01071.html
> 
> that depends on what outcome we do wish for.
> Described deadlock might be even desired vs QEMU abort() as it lets
> guest admin to collect VM crash dump.
> 
> But honestly I'd go with per/vCPU approach if it's possible,
> as that still get guest side chance to recover.
> 

Yes, per-vcpu error source is a nice idea as we agreed :-)

>> As the intention of this series is just to improve the memory error
>> reporting, to avoid QEMU crash if possible, it sounds reasonable to send
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> that,
> this series doesn't do that as it would still crash QEMU if another
> vCPU faults on another faulty host page (i.e. not the one we've generated CPERs)
> 

Correct, Qemu can't bear with memory error storm even with this series
applied.

> You also mentioned in previous review that with per vCPU error source
> variant that QEMU would abort elsewhere (is it fixable?).
> 

I need to take a closer look. If two consecutive errors are duplicate
when the problematic error physical addresses falls into same guest
page. The QEMU crash can be avoided by adding more checks. Otherwise,
I need to figure out the fix.

>> 16x consecutive CPERs in one shot for this specific case (4KB guest on
>> 64KB host).
> 
> I don't object to generating 16x CPERs per fault as that obviously
> should reduce # of guest exits.
> 

Thanks, Igor. Just posted (v4) and please take your time to review.
  
> 
> Given it's rather late in release cycle,
> we probably can handle 1 page case 1st as in this series,
> with followup series to switch to per/vCPU variant once new merge
> window opens (assuming I can coax a promise from you to follow up on that).
> 

Yes, it's actually the plan I had. To improve this series so that it can
be merged soon. After that, I will continue the improvement with per-vcpu
error source. The ultimate goal is to have 16x consecutive errors and
per-vcpu error source combined.

>> As to hugetlb cases, it's different story. If the hugetlb
>> folio (page) size is small enough (like 64KB), we can leverage current
>> design to send consecutive CPERs. I don't think there are too much we
>> can do if hugetlb folio size is large enough (from 2MB to 16GB).
>>
>>>    
>>>> Extend acpi_ghes_memory_errors() to support multiple CPERs after the
>>>> hunk of code to generate the GHES error status is pulled out from
>>>> ghes_gen_err_data_uncorrectable_recoverable(). The status field of
>>>> generic error status block is also updated accordingly if multiple
>>>> error data entries are contained in the generic error status block.
>>>
>>> I don't mind much translating 64K page error into several 4K CPER
>>> records, so this part is fine. But it's hardly a solution to the generic
>>> problem.
>>>    
>>
>> Note that I don't expect a memory error storm from the hardware level.
>> In that case, it's a good sign indicating the memory DIMM has been totally
>> broken and needs a replacement :-)
>>
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>    hw/acpi/ghes-stub.c    |  2 +-
>>>>    hw/acpi/ghes.c         | 60 +++++++++++++++++++++++-------------------
>>>>    include/hw/acpi/ghes.h |  2 +-
>>>>    target/arm/kvm.c       |  4 ++-
>>>>    4 files changed, 38 insertions(+), 30 deletions(-)
>>>>   
>>> ...
>>>> @@ -577,10 +568,25 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>>>        assert((data_length + ACPI_GHES_GESB_SIZE) <=
>>>>                ACPI_GHES_MAX_RAW_DATA_LENGTH);
>>>>    
>>>> -    ghes_gen_err_data_uncorrectable_recoverable(block, guid, data_length);
>>>> +    /* Build the new generic error status block header */
>>>> +    block_status = (1 << ACPI_GEBS_UNCORRECTABLE) |
>>>> +                   (num_of_addresses << ACPI_GEBS_ERROR_DATA_ENTRIES);
>>>                          ^^^^^^^^^^^^^^
>>> maybe assert in case it won't fit into bit field
>>>    
>>
>> Yep, Same thing was suggested by Philippe.
>>
>>>> +    if (num_of_addresses > 1) {
>>>> +        block_status |= ACPI_GEBS_MULTIPLE_UNCORRECTABLE;
>>>> +    }
>>>> +
>>>> +    acpi_ghes_generic_error_status(block, block_status, 0, 0,
>>>> +                                   data_length, ACPI_CPER_SEV_RECOVERABLE);
>>>>    
>>>> -    /* Build the memory section CPER for above new generic error data entry */
>>>> -    acpi_ghes_build_append_mem_cper(block, physical_address);
>>>> +    for (i = 0; i < num_of_addresses; i++) {
>>>> +        /* Build generic error data entries */
>>>> +        acpi_ghes_generic_error_data(block, guid,
>>>> +                                     ACPI_CPER_SEV_RECOVERABLE, 0, 0,
>>>> +                                     ACPI_GHES_MEM_CPER_LENGTH, fru_id, 0);
>>>> +
>>>> +        /* Memory section CPER on top of the generic error data entry */
>>>> +        acpi_ghes_build_append_mem_cper(block, addresses[i]);
>>>> +    }
>>>>    
>>>>        /* Report the error */
>>>>        ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
>>>> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
>>>> index df2ecbf6e4..f73908985d 100644
>>>> --- a/include/hw/acpi/ghes.h
>>>> +++ b/include/hw/acpi/ghes.h
>>>> @@ -99,7 +99,7 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>>>>    void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>>>>                              GArray *hardware_errors);
>>>>    int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>>> -                            uint64_t error_physical_addr);
>>>> +                            uint64_t *addresses, uint32_t num_of_addresses);
>>>>    void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>>>>                                 uint16_t source_id, Error **errp);
>>>>    
>>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>>> index 0d57081e69..459ca4a9b0 100644
>>>> --- a/target/arm/kvm.c
>>>> +++ b/target/arm/kvm.c
>>>> @@ -2434,6 +2434,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>>>        ram_addr_t ram_addr;
>>>>        hwaddr paddr;
>>>>        AcpiGhesState *ags;
>>>> +    uint64_t addresses[16];
>>>>    
>>>>        assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>>>>    
>>>> @@ -2454,10 +2455,11 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>>>                 * later from the main thread, so doing the injection of
>>>>                 * the error would be more complicated.
>>>>                 */
>>>> +            addresses[0] = paddr;
>>>>                if (code == BUS_MCEERR_AR) {
>>>>                    kvm_cpu_synchronize_state(c);
>>>>                    if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
>>>> -                                             paddr)) {
>>>> +                                             addresses, 1)) {
>>>>                        kvm_inject_arm_sea(c);
>>>>                    } else {
>>>>                        error_report("failed to record the error");
>>>    

Thanks,
Gavin


