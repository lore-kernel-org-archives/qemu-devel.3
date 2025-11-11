Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEA1CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 04:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIgBf-0002fP-1B; Mon, 10 Nov 2025 23:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vIgBc-0002Wf-2o
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 23:40:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vIgBY-0005WU-Nc
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 23:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762836051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KvIb+o9yHfWawf8Rx5NTGMXQkEQ5gId4H5ppEmceRpA=;
 b=HheUwBGKzAoFX7Hfwq5zXN4w0nNtk5m5TrmJ2lI3HnDlrn/zIM+pIK0oPt2wOCR/YCTdjG
 AuslcvaoLcxUBbKkAT1+V+/Pz49JF7nFogAteO4p+g1DI8J3NWEHvR7Xa6v0BE6TI1THPG
 vzE3SpQvPGTovuBXRyGN5gyyJ1XqLj8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-ILiizkT3Oo6rJkkcwCOgdw-1; Mon, 10 Nov 2025 23:40:50 -0500
X-MC-Unique: ILiizkT3Oo6rJkkcwCOgdw-1
X-Mimecast-MFC-AGG-ID: ILiizkT3Oo6rJkkcwCOgdw_1762836049
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-297f8a2ba9eso70045685ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 20:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762836049; x=1763440849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KvIb+o9yHfWawf8Rx5NTGMXQkEQ5gId4H5ppEmceRpA=;
 b=KqDh6rpYhTqOqxFeON2jbXwEslV6HV3igqhk5fMPrSKFTwBMqmkiNz2ruPfG3rNUYI
 10IQmEbkHGjJkBqMTqZcQHCqWbygK/zWf0NYULMiDm/PfX2+f5toN11ymqO06TP5qZN0
 78XGp57P0cv/MAvNOQ0dNSXeSmuOa05QCD7fh7duVsvv+vhNXKe9xNdxho/Jf808CvC4
 QkNtKpQ/SUWCx6ezj+vhAyP1+3OMxGChosxUVPBXwZblZrPWei17Y5Xt93jEEN+pIslC
 4JAviNQgkQoyz2wPGXyMW9Whi9WWEgUiys2LPJ4ujDgx1zOgYZwnMLon9DOnqUu3lM0N
 G1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762836049; x=1763440849;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KvIb+o9yHfWawf8Rx5NTGMXQkEQ5gId4H5ppEmceRpA=;
 b=ozyqA2Pccx0hwyMk9yxH5GvqoUIMiUd22qE8f0kTFAne9r+kVXvnR1QtU8kYDF75jr
 P+Yp0Lyr8EnV1m3GdZ+TsOf11dQByoBaPaBLfNJp6vjDeE5+fcNU3M90hG0/bkzVaG21
 pQMTkOUfco+rwYcahUkSsMDWBdR32/vTGl0ucmK6nPJOenLSvLXNWxD45o13+ZFbZlr/
 mt+UAdRtITY3zGa/qwE3+qYZicPHO8QdyODsf/VB0j07ZRm7jqD+QCocdQxhgcfRb9FZ
 ROlqUb4Hak5CWrt5Ar1VaYXKtnz33/aMhoYK8WWR1v/P9Tv6QM1AMtEgArz63A6DuyWo
 cA0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYFIHDNAM+9iCj7YRckT1uJ+qQ8bfZQtd/rhHEG7aBa2v1KhSIgsn4DpHkM7yAcdn3AsgSMgU/VIXS@nongnu.org
X-Gm-Message-State: AOJu0YxzxcBmxQX+4jwcpD0NKMIT4W7hgRiCGdlji4Ul8kS6IkFy2ITr
 mPAJWfhXtyV5v5kj9iLYh5uSXsuTeTDsU2l38JpGd/EYp7kMPfTjpAd5WI0xt0TNtea3SV6o03R
 jlePcfTnvBFfl3MR+ErigJ73H3zUkYJxfRLqCgib0TQ7N73EeOAPcEgbc
X-Gm-Gg: ASbGncveHyXBDArkN2BvBV9kpYP6J53wqtqjbnMQ3CeO5dzifPRk7HaIuyNdmUvcr4H
 QhTy6Q2TtUCX+P0YgHpUDV95It7SK+Oi329w1kwX6tWIKgYS/2UzcHq3EKXTDqqbv5VqBZtszvM
 p2teSTJ/MOCHUCkYAIPyMnefp8rYAuyv10ylSmBfr5O0/Gwkv4eHdsbyNbIh2DuijGk9sF2wSKQ
 maooMBrODAq0Q1zbsD/dDY57YazwX2qeXy8aBGqu2aGuzzvgZJzuKHxVwY+pg7GcrIOcAtETdlu
 xdRuJ6SAIp+bsxAX5HCOA2DdxgpY6Yo11A7HjiwySLVGLd1Fv2gePiL8W+ZiZJ0EmmTa19nXvDZ
 Zd8gokp8kYbDYbd9GQL8T7r8dF5w6ftwmVvpE7IE=
X-Received: by 2002:a17:902:da4b:b0:295:fc0:5a32 with SMTP id
 d9443c01a7336-297e53e7aa7mr139797175ad.3.1762836049079; 
 Mon, 10 Nov 2025 20:40:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnDX5dI7N/F+glRRKpH2cAr+Zv0auRVeUsqg+ywIns9b9aMQOVj98//kdzU/Zd+TxfmbvD7w==
X-Received: by 2002:a17:902:da4b:b0:295:fc0:5a32 with SMTP id
 d9443c01a7336-297e53e7aa7mr139796905ad.3.1762836048720; 
 Mon, 10 Nov 2025 20:40:48 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c94ac5sm163762095ad.92.2025.11.10.20.40.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 20:40:48 -0800 (PST)
Message-ID: <659b0d40-6b06-42a8-ba7d-73dd2dcdf0f0@redhat.com>
Date: Tue, 11 Nov 2025 14:40:42 +1000
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251110153801.258be29d@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
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

On 11/11/25 12:38 AM, Igor Mammedov wrote:
> On Wed,  5 Nov 2025 21:44:49 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> In the situation where host and guest has 64KiB and 4KiB page sizes,
>> one problematic host page affects 16 guest pages. we need to send 16
>> consective errors in this specific case.
> 
> I still don't like it, since it won't fix anything in case of more than
> 1 broken host pages. (in v2 discussion quickly went hugepages route
> and futility of recovering from them).
> 
> If having per vCPU source is not desirable,
> can we stall all other vcpus that touch poisoned pages until
> error is acked by guest and then let another VCPU to queue its own error?
> 

We're trying to avoid the guest from suddenly disappearing due to the QEMU
crash, instead of recovering from the memory errors. To keep the guest
accessible, system administrators still get a chance to collect important
information from the guest.

The idea of stalling the vCPU which is accessing any poisoned pages and
retry on delivering the error was proposed in v1, but was rejected.

https://lists.nongnu.org/archive/html/qemu-arm/2025-02/msg01071.html

As the intention of this series is just to improve the memory error
reporting, to avoid QEMU crash if possible, it sounds reasonable to send
16x consecutive CPERs in one shot for this specific case (4KB guest on
64KB host). As to hugetlb cases, it's different story. If the hugetlb
folio (page) size is small enough (like 64KB), we can leverage current
design to send consecutive CPERs. I don't think there are too much we
can do if hugetlb folio size is large enough (from 2MB to 16GB).

> 
>> Extend acpi_ghes_memory_errors() to support multiple CPERs after the
>> hunk of code to generate the GHES error status is pulled out from
>> ghes_gen_err_data_uncorrectable_recoverable(). The status field of
>> generic error status block is also updated accordingly if multiple
>> error data entries are contained in the generic error status block.
> 
> I don't mind much translating 64K page error into several 4K CPER
> records, so this part is fine. But it's hardly a solution to the generic
> problem.
> 

Note that I don't expect a memory error storm from the hardware level.
In that case, it's a good sign indicating the memory DIMM has been totally
broken and needs a replacement :-)

>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   hw/acpi/ghes-stub.c    |  2 +-
>>   hw/acpi/ghes.c         | 60 +++++++++++++++++++++++-------------------
>>   include/hw/acpi/ghes.h |  2 +-
>>   target/arm/kvm.c       |  4 ++-
>>   4 files changed, 38 insertions(+), 30 deletions(-)
>>
> ...
>> @@ -577,10 +568,25 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>       assert((data_length + ACPI_GHES_GESB_SIZE) <=
>>               ACPI_GHES_MAX_RAW_DATA_LENGTH);
>>   
>> -    ghes_gen_err_data_uncorrectable_recoverable(block, guid, data_length);
>> +    /* Build the new generic error status block header */
>> +    block_status = (1 << ACPI_GEBS_UNCORRECTABLE) |
>> +                   (num_of_addresses << ACPI_GEBS_ERROR_DATA_ENTRIES);
>                         ^^^^^^^^^^^^^^
> maybe assert in case it won't fit into bit field
> 

Yep, Same thing was suggested by Philippe.

>> +    if (num_of_addresses > 1) {
>> +        block_status |= ACPI_GEBS_MULTIPLE_UNCORRECTABLE;
>> +    }
>> +
>> +    acpi_ghes_generic_error_status(block, block_status, 0, 0,
>> +                                   data_length, ACPI_CPER_SEV_RECOVERABLE);
>>   
>> -    /* Build the memory section CPER for above new generic error data entry */
>> -    acpi_ghes_build_append_mem_cper(block, physical_address);
>> +    for (i = 0; i < num_of_addresses; i++) {
>> +        /* Build generic error data entries */
>> +        acpi_ghes_generic_error_data(block, guid,
>> +                                     ACPI_CPER_SEV_RECOVERABLE, 0, 0,
>> +                                     ACPI_GHES_MEM_CPER_LENGTH, fru_id, 0);
>> +
>> +        /* Memory section CPER on top of the generic error data entry */
>> +        acpi_ghes_build_append_mem_cper(block, addresses[i]);
>> +    }
>>   
>>       /* Report the error */
>>       ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
>> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
>> index df2ecbf6e4..f73908985d 100644
>> --- a/include/hw/acpi/ghes.h
>> +++ b/include/hw/acpi/ghes.h
>> @@ -99,7 +99,7 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>>   void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>>                             GArray *hardware_errors);
>>   int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>> -                            uint64_t error_physical_addr);
>> +                            uint64_t *addresses, uint32_t num_of_addresses);
>>   void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>>                                uint16_t source_id, Error **errp);
>>   
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 0d57081e69..459ca4a9b0 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -2434,6 +2434,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>       ram_addr_t ram_addr;
>>       hwaddr paddr;
>>       AcpiGhesState *ags;
>> +    uint64_t addresses[16];
>>   
>>       assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>>   
>> @@ -2454,10 +2455,11 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>                * later from the main thread, so doing the injection of
>>                * the error would be more complicated.
>>                */
>> +            addresses[0] = paddr;
>>               if (code == BUS_MCEERR_AR) {
>>                   kvm_cpu_synchronize_state(c);
>>                   if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
>> -                                             paddr)) {
>> +                                             addresses, 1)) {
>>                       kvm_inject_arm_sea(c);
>>                   } else {
>>                       error_report("failed to record the error");
> 

Thanks,
Gavin


