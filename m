Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E21E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 14:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM6Xp-0002sn-MZ; Fri, 13 Dec 2024 09:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tM6Xo-0002sL-0e
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:21:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tM6Xl-00027m-TD
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734099683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EqxH9j0lf/UBFpEfgA4h0mW+tm2JfVUN5PVB4x4kC08=;
 b=XM57tTPLxzl/YjZn39a9gnZCXTyyRFaWBdy2tKhBWc5lF5hhKxslrrLz5NJzzt1afbrXGL
 cYGlGAfKWjNhmi7ZLGKyMWoMmUm1ck02ojEXCnhGewCKBy4c8sf2lJrwEF5YzkgtienlED
 g8zXHTlo1o4nRma7Fs/a5LDkJNXRn74=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-WID9bhFoPAeLMv5V1118dg-1; Fri, 13 Dec 2024 09:21:22 -0500
X-MC-Unique: WID9bhFoPAeLMv5V1118dg-1
X-Mimecast-MFC-AGG-ID: WID9bhFoPAeLMv5V1118dg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e1339790so1201905f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 06:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734099682; x=1734704482;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EqxH9j0lf/UBFpEfgA4h0mW+tm2JfVUN5PVB4x4kC08=;
 b=ZnZnbnOf4czdswZe0o5JBo1WLX3sT7Djr8hCESehVcXWiGicOvjs1QOIZtYR+s4+ew
 i/AhrJNReoaSvVxagApZ1jxRRFNy1L793EauTUE5lZmQkDs38IXdwWAHcv7mB/E1qdaX
 SH4fWrZ0O8dcFvZ6ZhjhhSU+W4rVsy6MuSdnz96P1dm5W0tHw/nzvx7Yy5GmRn7HygaO
 qfNAKEyaG0wQ8RRuOYDi4vfmga+RezWoUkXwEHEdGmXSFh2kHyIhibgZm88gLGv6oXC7
 G3HjpC+0mwPtjyQmBH+QS2csFw19IlawRuKuMwajs6AAM+lpjihhSt81Rv7l/+PNNA09
 F9pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYL0wU+zyfY0HEEPYDqINn2hl0fkuCdhQhdy9fopJUS6sbOq1912I71TAdOiEWPLZ/zX5qxzimMKsx@nongnu.org
X-Gm-Message-State: AOJu0YzV5JXQVKby9zNYDmMJaeZY9ymyUZDQ34oqA4Bfo2IZtBe7GUPz
 dScRrMYfXyTWvyF0o2XAaLsxNkAzck/YI0cSmAceSoBZXGtNyyaC4nnPEH1gycfjOxI53+eLZ/g
 JZQ/bTjsVrdymZtAwsHEma45wZwGz6Opl4CFpUqdq8IR13JOt0zOo
X-Gm-Gg: ASbGncuagJ9LjRf34YoYl8/vZR6hqegyHRfmZONWlrZWC6FwbKuSpoTM31065DFcGwB
 4coajhMprp47BMdBeIAVYPqWzL45eFmIX8GtzuNaUzZrnWKsnIz6/82f3kq28u/rkQVTDXBglSQ
 mRVywvZ8dlVzCADCzsVH+0EZpULvqjZi9e7SSsg32948tGUd4cn7i9VqM7pTrzKrULcXPeGlCpH
 x1xH/Ee9t5cS4rzCry5h0rMiIYn4m/AYKobdo2IoOBskG/WQp4yDxbKBYzn6ZKjtJ3qxZvflO/Y
 ZDBYUMZlhVwvKBgjzyWU/OopBlWRCzj9CWPZEykrCRnVTzjOQu+/9qC7wFOL8/dYo7lFnCiiM/F
 jlgdOJg==
X-Received: by 2002:a5d:588b:0:b0:385:f062:c2d4 with SMTP id
 ffacd0b85a97d-3888e0b87d6mr2240094f8f.37.1734099681496; 
 Fri, 13 Dec 2024 06:21:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP7/G/V8m/z25aHjjbF7TBerT4Y0YIPnhe/mgo8m8PJ6y1GpLPoKR7MXNIc4CT9AGzZHV+4A==
X-Received: by 2002:a5d:588b:0:b0:385:f062:c2d4 with SMTP id
 ffacd0b85a97d-3888e0b87d6mr2240044f8f.37.1734099681014; 
 Fri, 13 Dec 2024 06:21:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:7500:e6f:ae52:22f6:4582?
 (p200300cbc70775000e6fae5222f64582.dip0.t-ipconnect.de.
 [2003:cb:c707:7500:e6f:ae52:22f6:4582])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a3fa7sm7230617f8f.24.2024.12.13.06.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 06:21:19 -0800 (PST)
Message-ID: <507b1440-21e0-42b9-a8e6-aa3a17288592@redhat.com>
Date: Fri, 13 Dec 2024 15:21:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] s390x/s390-virtio-ccw: prepare for memory devices
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20241008105455.2302628-1-david@redhat.com>
 <20241008105455.2302628-11-david@redhat.com>
 <6fcccb4c-6260-401d-aab9-3d77b7cf3cf5@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6fcccb4c-6260-401d-aab9-3d77b7cf3cf5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13.12.24 13:40, Thomas Huth wrote:
> On 08/10/2024 12.54, David Hildenbrand wrote:
>> Let's prepare our address space for memory devices if enabled via
>> "maxmem" and if we have CONFIG_MEM_DEVICE enabled at all. Note that
>> CONFIG_MEM_DEVICE will be selected automatically once we add support
>> for devices.
>>
>> Just like on other architectures, the region container for memory devices
>> is placed directly above our initial memory. For now, we only align the
>> start address of the region up to 1 GiB, but we won't add any additional
>> space to the region for internal alignment purposes; this can be done in
>> the future if really required.
>>
>> The RAM size returned via SCLP is not modified, as this only
>> covers initial RAM (and standby memory we don't implement) and not memory
>> devices; clarify that in the docs of read_SCP_info(). Existing OSes without
>> support for memory devices will keep working as is, even when memory
>> devices would be attached the VM.
>>
>> Guest OSs which support memory devices, such as virtio-mem, will
>> consult diag500(), to find out the maximum possible pfn. Guest OSes that
>> don't support memory devices, don't have to be changed and will continue
>> relying on information provided by SCLP.
>>
>> There are no remaining maxram_size users in s390x code, and the remaining
>> ram_size users only care about initial RAM:
>> * hw/s390x/ipl.c
>> * hw/s390x/s390-hypercall.c
>> * hw/s390x/sclp.c
>> * target/s390x/kvm/pv.c
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    hw/s390x/s390-virtio-ccw.c | 23 ++++++++++++++++++++++-
>>    hw/s390x/sclp.c            |  6 +++++-
>>    2 files changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 749d46e700..2031c4cf29 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -156,6 +156,7 @@ static void s390_memory_init(MachineState *machine)
>>        MemoryRegion *sysmem = get_system_memory();
>>        MemoryRegion *ram = machine->ram;
>>        uint64_t ram_size = memory_region_size(ram);
>> +    uint64_t devmem_base, devmem_size;
>>    
>>        if (!QEMU_IS_ALIGNED(ram_size, 1 * MiB)) {
>>            /*
>> @@ -168,11 +169,31 @@ static void s390_memory_init(MachineState *machine)
>>            exit(EXIT_FAILURE);
>>        }
>>    
>> -    s390_set_memory_limit(s390ms, ram_size);
>> +    devmem_size = 0;
>> +    devmem_base = ram_size;
>> +#ifdef CONFIG_MEM_DEVICE
>> +    if (machine->ram_size < machine->maxram_size) {
>> +
>> +        /*
>> +         * Make sure memory devices have a sane default alignment, even
>> +         * when weird initial memory sizes are specified.
>> +         */
>> +        devmem_base = QEMU_ALIGN_UP(devmem_base, 1 * GiB);
>> +        devmem_size = machine->maxram_size - machine->ram_size;
> 
> Shouldn't that rather be:
> 
>              devmem_size = machine->maxram_size - devmem_base;
> 
> instead?

For example, having ram_size == 1.5 GiB and maxram_size == 3 GiB means: 
we want to be able to hotplug 1.5 GiB, which is how we are going to size 
the region for memory devices.

So we would get

devmem_base = 2 GiB
devmem_size = 1.5 GiB

Instead of with your calculation

devmem_size = 1 GiB


Allowing us to only hotplug 1 GiB of memory.

Thanks for the review!

-- 
Cheers,

David / dhildenb


