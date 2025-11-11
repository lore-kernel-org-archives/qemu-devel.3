Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D06CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIm2S-0001JC-3t; Tue, 11 Nov 2025 05:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vIm2B-00019j-7Y
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:55:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vIm25-0005Jm-Pa
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762858527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdTH9cBbXErTKI5IaWkLrOaWjhiX9JhIGeEc4IPNru4=;
 b=jUek/1o8dhw/pbRU0OE9pCTtkPCHUZiN5xu3+xL5Q07EoabHyhTCt7SuaeetoZYohkCfF6
 pa2MmDEXEdV3wlNdCYjF5xQkI/KSTR/e5dSqh1LJVIzMrbEJS+pTDUWCrmgHQh3k/GKxeQ
 TSOwlhhcW5QYn5iF4zxUgD8/FYXiKp8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-oeu9BfbFMUqGxcTzE-b_zg-1; Tue, 11 Nov 2025 05:55:26 -0500
X-MC-Unique: oeu9BfbFMUqGxcTzE-b_zg-1
X-Mimecast-MFC-AGG-ID: oeu9BfbFMUqGxcTzE-b_zg_1762858525
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-297ddb3c707so31396265ad.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 02:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762858525; x=1763463325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zdTH9cBbXErTKI5IaWkLrOaWjhiX9JhIGeEc4IPNru4=;
 b=cqQbPYyiQw+0ZX2dXt6ZZMYw6qEcKaOAyimHgHKTxqK7neVjoqrxKejIju/hUeatvd
 4rYSS+BWhfvLbBt/tKRaFVctE17JbL2EDXmC+mkN+cTJomlYXfTvbpVgg8rsVvGSozRU
 +r0TPxfy4CycpSC18ioBtDpRaXxS8FfX1gmconBlPLNHiFjvz9gwXfImy97QJdTfBV0P
 on0EN6h+j62rf3+GDdSCWoRsqwZ1n5L+9Rn4+YuLmgVl/HSCB30GCOxVb8a8xPJNqdXI
 E2qFrATJozT7rGJvA0cUAAiqjiwd3FlOZ15Kkvl3QIzcQTTPXKRhRgCNe5XEYoRIBgpb
 d/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762858525; x=1763463325;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zdTH9cBbXErTKI5IaWkLrOaWjhiX9JhIGeEc4IPNru4=;
 b=LI8vLIf0YntHev1OPn9Mj26Oh+okQipVpQpXt5E/p9l2wPvKbTshCu3Y6jkgll7f3v
 i7c74E9kQF9zwOwDGnL/Mop+AL4eAWBOAk/6M/9dnpbPZjp6Uzri9vK9mdkBIGVAH3Hx
 F1h6kGVRqla7MkyDpWV1XDg27nLU67Gv5g/I4C7lehLNbpa/kNCEa/ZNHi6KFL7UIgsu
 oFnyK8oz5EjHd9j1tvfLV2mfysuEytm1wTmPVA0zHzAfUAQYf+miyOya1zdYtFq0/C4O
 jNszI/MsiwY5JyNB3hP9R0qHHzhdmNZkkd5pkyZej5I9Z206d96kzo6gmyVP5g/IdwF3
 zZRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVycn7uyWBCF4tl81FKXJftVF6t2JbQIx/lpcCwLDhOdM0DqT4PDvXfTcDLBqcnfuXXbCBRAU3N/mON@nongnu.org
X-Gm-Message-State: AOJu0YxA22K26AXyavFEjFM7bI8onoRqeQlvoPFzN80z7hfkKkxt9z+O
 Zj0FL+DLt/nTdqFwxdHC1gqun4ngIIetlDeyHXGP3BvzCDZ4iPljDI7iLZdpyMj1QRSw7hl/9uL
 pARtz9toRGW5YPNSXpw8t0xpc+KPIWJdlVdzkIrKsfZSe2FOTh5KjvZ82
X-Gm-Gg: ASbGncspjA8TViD/wK0Mru8v6Umxif1yDzp/D/k7tH3HUMQUmo3p2c7V6UrlaGe49MP
 XecRyIURX907bAlTBL5i26dWSRHVZDxw9VQPUbBX7lm3fDyWsn8D7rx7aEcrNDctocbm2Oa6EPe
 PyNXRAA1l1lA0+pqIX3ru68j9N+uszg32NoAvR8bRvue6fbnvHjorr3D1sDFhdD6XwchnZSF5uU
 O7EmWaylb6Dxup2CmSc4nJzF53+1iqH3lenHD+nJDIkry6F6oTq3Ko44gYqJSyhr9T4r0+RGCgQ
 12rEKkYNc+1kCAs5MKddPMe7AUWuM9HqrogX87tS84npXzLQojTDcykQzd1N1SIcPFaHl4AwVBB
 epercy8PmRcIMEbE22cUc5qhUdbNpw64e21V8w+g=
X-Received: by 2002:a17:903:120e:b0:298:485d:5571 with SMTP id
 d9443c01a7336-298485d5608mr4127525ad.54.1762858525087; 
 Tue, 11 Nov 2025 02:55:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJmLPwbefJLs8w2duJPGndCIjArCfeaXzq/mzlAeqILakcvAf2GAvY3kXFzFhaoEH1reI2bw==
X-Received: by 2002:a17:903:120e:b0:298:485d:5571 with SMTP id
 d9443c01a7336-298485d5608mr4127075ad.54.1762858524558; 
 Tue, 11 Nov 2025 02:55:24 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c94abasm180024395ad.82.2025.11.11.02.55.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 02:55:23 -0800 (PST)
Message-ID: <2440a0dd-6543-4590-9c0f-06b05bdfc8a4@redhat.com>
Date: Tue, 11 Nov 2025 20:55:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] acpi/ghes: Extend acpi_ghes_memory_errors() to
 support multiple CPERs
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, shan.gavin@gmail.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 gengdongjiu1@gmail.com, mst@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-5-gshan@redhat.com>
 <20251105141455.000052f0@huawei.com>
 <cc07dfc9-f58a-4654-8854-c16a2e85fecd@redhat.com>
 <20251110154957.5c481df7@fedora>
 <cad74549-a313-48b6-8260-f23f6be1e8c8@redhat.com>
 <20251111100746.00003136@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251111100746.00003136@huawei.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Jonathan,

On 11/11/25 8:07 PM, Jonathan Cameron wrote:
> On Tue, 11 Nov 2025 14:08:13 +1000
> Gavin Shan <gshan@redhat.com> wrote:
>> On 11/11/25 12:49 AM, Igor Mammedov wrote:
>>> On Thu, 6 Nov 2025 13:15:52 +1000
>>> Gavin Shan <gshan@redhat.com> wrote:
>>>> On 11/6/25 12:14 AM, Jonathan Cameron wrote:
>>>>> On Wed,  5 Nov 2025 21:44:49 +1000
>>>>> Gavin Shan <gshan@redhat.com> wrote:
>>>>>       
>>>>>> In the situation where host and guest has 64KiB and 4KiB page sizes,
>>>>>> one problematic host page affects 16 guest pages. we need to send 16
>>>>>> consective errors in this specific case.
>>>>>>
>>>>>> Extend acpi_ghes_memory_errors() to support multiple CPERs after the
>>>>>> hunk of code to generate the GHES error status is pulled out from
>>>>>> ghes_gen_err_data_uncorrectable_recoverable(). The status field of
>>>>>> generic error status block is also updated accordingly if multiple
>>>>>> error data entries are contained in the generic error status block.
>>>>>>
>>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>> Hi Gavin,
>>>>>
>>>>> Mostly fine, but a few comments on the defines added and a
>>>>> question on what the multiple things are meant to mean?
>>>>>       
>>>>
>>>> Thanks for your review and comments, replies as below.
>>>>   
>>>>>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
>>>>>> index a9c08e73c0..527b85c8d8 100644
>>>>>> --- a/hw/acpi/ghes.c
>>>>>> +++ b/hw/acpi/ghes.c
>>>>>> @@ -57,8 +57,12 @@
>>>>>>     /* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
>>>>>>     #define ACPI_GHES_MEM_CPER_LENGTH           80
>>>>>>     
>>>>>> -/* Masks for block_status flags */
>>>>>> -#define ACPI_GEBS_UNCORRECTABLE         1
>>>>>> +/* Bits for block_status flags */
>>>>>> +#define ACPI_GEBS_UNCORRECTABLE           0
>>>>>> +#define ACPI_GEBS_CORRECTABLE             1
>>>>>> +#define ACPI_GEBS_MULTIPLE_UNCORRECTABLE  2
>>>>>> +#define ACPI_GEBS_MULTIPLE_CORRECTABLE    3
>>>>>
>>>>> So this maps to the bits in block status.
>>>>>
>>>>> I'm not actually sure what these multiple variants are meant to tell us.
>>>>> The multiple error blocks example referred to by the spec is a way to represent
>>>>> the same error applying to multiple places.  So that's one error, many blocks.
>>>>> I have no idea if we set these bits in that case.
>>>>>
>>>>> Based on a quick look I don't think linux even takes any notice.  THere
>>>>> are defines in actbl1.h but I'm not seeing any use made of them.
>>>>>       
>>>>
>>>> I hope Igor can confirm since it was suggested by him.
>>>>
>>>> It's hard to understand how exactly these multiple variants are used from the
>>>> spec. In ACPI 6.5 Table 18.11, it's explained as below.
>>>>
>>>> Bit [2] - Multiple Uncorrectable Errors: If set to one, indicates that more
>>>> than one uncorrectable errors have been detected.
>>>>
>>>> I don't see those multiple variants have been used by Linux. So I think it's
>>>> safe to drop them.
>>>
>>> even though example describes 'same' error at different components,
>>> the bit fields descriptions doesn't set any limits on what 'more than one' means.
>>>
>>> Also from guest POV it's multiple different pages that we are reporting here
>>> as multiple CPERs.
>>> It seems to me that setting *_MULTIPLE_* here is correct thing to do.
>>>    
>>
>> I don't have strong opinions. Lets keep to set _MULTIPLE_ flag if Jonathan
>> is fine. Again, this field isn't used by Linux guest.
> I don't care strongly.  Maybe we should ask for a spec clarification as I doubt
> implementations will be consistent on this given the vague description and that
> Linux ignores it today.
> 

Google Gemini has the following question. If it can be trusted, it should be
set when @num_of_addresses is larger than 1.

Quota from Google Gemini:

The system firmware sets this bit to indicate to the Operating System Power Management (OSPM)
that more than one correctable error condition has been detected and logged for the associated
hardware component since the last time the status was cleared by the software. This is crucial
because a high frequency of correctable errors often indicates a potential underlying hardware
issue that could lead to uncorrectable (and potentially fatal) errors if not addressed (e.g.,
in memory, where multiple correctable errors might trigger a spare memory operation).

>>
>>>>>> +#define ACPI_GEBS_ERROR_DATA_ENTRIES      4
>>>>>
>>>>> This is bits 4-13 and the define isn't used. I'd drop it.
>>>>>       
>>>>
>>>> The definition is used in acpi_ghes_memory_errors() of this patch. However,
>>>> I don't see it has been used by Linux. This field isn't used by Linux to determine
>>>> the total number of error entries. So I think I can drop it either if Igor is ok.
>>>>   
>>
>> Lets keep this field either in next revision if Jonathan is fine.
> 
> I'm fine with the field, but not the value.  As far as I can tell form the spec, it should
> be a mask, not a single bit.
> 

Agreed, lets keep ACPI_HEST_ERROR_ENTRY_COUNT as zero in next revision.

Thanks,
Gavin


