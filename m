Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DDFCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 12:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vInMq-0006wm-Kf; Tue, 11 Nov 2025 07:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vInLQ-0004cF-5K
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 07:19:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vInLN-00019S-ED
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 07:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762863568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4vFMP2+PgPcpDrBpxIP2bJH0X/tllQNcH+EXd83rIM=;
 b=WFyyeLSmm7Vl7bY6Io+badPunyocaAZGIk7ImpVSQj0+cKRjCDcubW0lFgfvGcsWVpWqdp
 xQoHROSwjTRqpBcyDKUdbJm8gGtXrbgNEqlhjmUFnxvKLhRytKaHySeqJTGf3RfJyLvRw4
 3s52K3k2f2regHOzvCje7kc+O9MG+0U=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-L_jdpESRMYiCHsSf_n4jLA-1; Tue, 11 Nov 2025 07:19:26 -0500
X-MC-Unique: L_jdpESRMYiCHsSf_n4jLA-1
X-Mimecast-MFC-AGG-ID: L_jdpESRMYiCHsSf_n4jLA_1762863566
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3438b1220bcso2991788a91.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 04:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762863566; x=1763468366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j4vFMP2+PgPcpDrBpxIP2bJH0X/tllQNcH+EXd83rIM=;
 b=b4QGFAj97yRQo8IFK7U6Nc3o8vksMZHT/iPsH2ZSJgt4hEwWxjHbGR39EUnKZBL9x7
 XrI5TmpQOUfBUPNgSUOBJCuqjX5VhT0zQcwzgsKRYNbn3kEn78b8ZtcdrX+CXFXUwkS4
 rBtjFPjC6aDY52PTJLNzYQ7uWymXt5N0T8XifsNjj77EQy7QoWN4UPwrGHCwgHuMe7mC
 RYjwg4XgJLykumthN8amOJJBUstFYTZkb19uN2fuRNR2R8DyrvuzTlNBDfHQmGv8WKu2
 3Om67FBHAfA2+Uwf91olISmS/TWc9fTf4bc70OeHZn8+W+6rkVg3L6hl/wRecZNCiXek
 VvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762863566; x=1763468366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j4vFMP2+PgPcpDrBpxIP2bJH0X/tllQNcH+EXd83rIM=;
 b=m7qmkEO07aDIYjEKSz7sJz1OQo/egpMPWuoTVD5t2pEuKk7A+GD7AlAFdGPLQZLndE
 hdz6udgACuiAKy9ijjd/ch+Z47pzBlMG/2BPMBb63zWdEdfTrMNoAuk6gxEobvNm4SKC
 yYYq8Fd+mci/MBOBgL5em62zH0JrU/amg7Vp7IxGCJ/6Fx1PBUXcIfFD2olxBVlqYATH
 hv7r/rOYz/rzR1pOFpHMSabI9tBt/wCbdwRUrpKEE7vkLC1XPrRlKH0k75b6mRamcwlG
 HhfzJvGGZWSGCR/43sc8PvewljdfuXA0ox+eIpAxDcC4FCbYBfRQaoX6pR0ACAG5iSS+
 tVJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJs8WR6UX6nyhUvESSLgK9CnXrJfyjIvXXmSRqydO2netjVwlKhkGIiqwglCMZI71UD0+MEieowWO/@nongnu.org
X-Gm-Message-State: AOJu0YwVnAVXgQL/pAwLjesW/yI4NngvHuDl19fXin2Fow3kgvDXF0+i
 NcvRmURsj7ddsa+8k+VvKcnGnyNCECTLmWlLayD6lULoa/hC+MccUf0PHsmeoj3gBQM3GrSu3qC
 0wPidgD32/2+HmGAC+DiLuGGfOxMQcNRMCyRh5Qa7+14T9orsnkHGG4Lj
X-Gm-Gg: ASbGncsej22IaRqPtawhjBKw2outr4KkEuvd9TkqkQrgH4ldqVDjvaQYP1ShFnKkFXK
 m4QnOA0Xc9tngC69yYvUGC9qFuAdI51iwVWQmPTZbyykqpzNqVJMIMEmO+X1QRWF46Q7poMqWnG
 f4u5KCggtxxH3a7ybZlzuOObTLjyPev/KEPjVc0ZPDjPi8cFXKSboxwn0RsAuukRo2qfvEZ04u0
 ZrViAQjLACEtCIMhlRiKLSE1QYU45WmZkI3sZPTvB62/URjrbNK4MW/siwuGVrPuSpoV2V5hqwf
 JhF+xbIXFvqA8nAw5HrR4T9EdZCfiMMlGJacExyXlOJODs0caA1dvR8TvFLZ26d4fz4tY0r4NOF
 C3+80xoFfV9iTGwOmuncgjG4PhvZ5fQQ5UbL/PwM=
X-Received: by 2002:a17:90a:e710:b0:340:dcd4:f851 with SMTP id
 98e67ed59e1d1-3436cb73cb1mr13540565a91.3.1762863565607; 
 Tue, 11 Nov 2025 04:19:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBHn4H9bZrdWxPBi2rdXHGLAVOuYVkOomXD5ohBndslH4wZdqE20IEvS7wmwTVumgvXJiCfw==
X-Received: by 2002:a17:90a:e710:b0:340:dcd4:f851 with SMTP id
 98e67ed59e1d1-3436cb73cb1mr13540530a91.3.1762863565096; 
 Tue, 11 Nov 2025 04:19:25 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3434c31d86esm14711595a91.8.2025.11.11.04.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 04:19:24 -0800 (PST)
Message-ID: <e797a9f6-aee6-4c0f-9c17-f4200199e317@redhat.com>
Date: Tue, 11 Nov 2025 22:19:18 +1000
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
 <2440a0dd-6543-4590-9c0f-06b05bdfc8a4@redhat.com>
 <20251111115551.00003385@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251111115551.00003385@huawei.com>
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

On 11/11/25 9:55 PM, Jonathan Cameron wrote:
> On Tue, 11 Nov 2025 20:55:17 +1000
> Gavin Shan <gshan@redhat.com> wrote:
>> On 11/11/25 8:07 PM, Jonathan Cameron wrote:
>>> On Tue, 11 Nov 2025 14:08:13 +1000
>>> Gavin Shan <gshan@redhat.com> wrote:
>>>> On 11/11/25 12:49 AM, Igor Mammedov wrote:
>>>>> On Thu, 6 Nov 2025 13:15:52 +1000
>>>>> Gavin Shan <gshan@redhat.com> wrote:
>>>>>> On 11/6/25 12:14 AM, Jonathan Cameron wrote:
>>>>>>> On Wed,  5 Nov 2025 21:44:49 +1000
>>>>>>> Gavin Shan <gshan@redhat.com> wrote:
>>>>>>>          
>>>>>>>> In the situation where host and guest has 64KiB and 4KiB page sizes,
>>>>>>>> one problematic host page affects 16 guest pages. we need to send 16
>>>>>>>> consective errors in this specific case.
>>>>>>>>
>>>>>>>> Extend acpi_ghes_memory_errors() to support multiple CPERs after the
>>>>>>>> hunk of code to generate the GHES error status is pulled out from
>>>>>>>> ghes_gen_err_data_uncorrectable_recoverable(). The status field of
>>>>>>>> generic error status block is also updated accordingly if multiple
>>>>>>>> error data entries are contained in the generic error status block.
>>>>>>>>
>>>>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>>>> Hi Gavin,
>>>>>>>
>>>>>>> Mostly fine, but a few comments on the defines added and a
>>>>>>> question on what the multiple things are meant to mean?
>>>>>>>          
>>>>>>
>>>>>> Thanks for your review and comments, replies as below.
>>>>>>      
>>>>>>>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
>>>>>>>> index a9c08e73c0..527b85c8d8 100644
>>>>>>>> --- a/hw/acpi/ghes.c
>>>>>>>> +++ b/hw/acpi/ghes.c
>>>>>>>> @@ -57,8 +57,12 @@
>>>>>>>>      /* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
>>>>>>>>      #define ACPI_GHES_MEM_CPER_LENGTH           80
>>>>>>>>      
>>>>>>>> -/* Masks for block_status flags */
>>>>>>>> -#define ACPI_GEBS_UNCORRECTABLE         1
>>>>>>>> +/* Bits for block_status flags */
>>>>>>>> +#define ACPI_GEBS_UNCORRECTABLE           0
>>>>>>>> +#define ACPI_GEBS_CORRECTABLE             1
>>>>>>>> +#define ACPI_GEBS_MULTIPLE_UNCORRECTABLE  2
>>>>>>>> +#define ACPI_GEBS_MULTIPLE_CORRECTABLE    3
>>>>>>>
>>>>>>> So this maps to the bits in block status.
>>>>>>>
>>>>>>> I'm not actually sure what these multiple variants are meant to tell us.
>>>>>>> The multiple error blocks example referred to by the spec is a way to represent
>>>>>>> the same error applying to multiple places.  So that's one error, many blocks.
>>>>>>> I have no idea if we set these bits in that case.
>>>>>>>
>>>>>>> Based on a quick look I don't think linux even takes any notice.  THere
>>>>>>> are defines in actbl1.h but I'm not seeing any use made of them.
>>>>>>>          
>>>>>>
>>>>>> I hope Igor can confirm since it was suggested by him.
>>>>>>
>>>>>> It's hard to understand how exactly these multiple variants are used from the
>>>>>> spec. In ACPI 6.5 Table 18.11, it's explained as below.
>>>>>>
>>>>>> Bit [2] - Multiple Uncorrectable Errors: If set to one, indicates that more
>>>>>> than one uncorrectable errors have been detected.
>>>>>>
>>>>>> I don't see those multiple variants have been used by Linux. So I think it's
>>>>>> safe to drop them.
>>>>>
>>>>> even though example describes 'same' error at different components,
>>>>> the bit fields descriptions doesn't set any limits on what 'more than one' means.
>>>>>
>>>>> Also from guest POV it's multiple different pages that we are reporting here
>>>>> as multiple CPERs.
>>>>> It seems to me that setting *_MULTIPLE_* here is correct thing to do.
>>>>>       
>>>>
>>>> I don't have strong opinions. Lets keep to set _MULTIPLE_ flag if Jonathan
>>>> is fine. Again, this field isn't used by Linux guest.
>>> I don't care strongly.  Maybe we should ask for a spec clarification as I doubt
>>> implementations will be consistent on this given the vague description and that
>>> Linux ignores it today.
>>>    
>>
>> Google Gemini has the following question. If it can be trusted, it should be
>> set when @num_of_addresses is larger than 1.
>>
>> Quota from Google Gemini:
>>
>> The system firmware sets this bit to indicate to the Operating System Power Management (OSPM)
>> that more than one correctable error condition has been detected and logged for the associated
>> hardware component since the last time the status was cleared by the software. This is crucial
>> because a high frequency of correctable errors often indicates a potential underlying hardware
>> issue that could lead to uncorrectable (and potentially fatal) errors if not addressed (e.g.,
>> in memory, where multiple correctable errors might trigger a spare memory operation).
>>
>>>>   
>>>>>>>> +#define ACPI_GEBS_ERROR_DATA_ENTRIES      4
>>>>>>>
>>>>>>> This is bits 4-13 and the define isn't used. I'd drop it.
>>>>>>>          
>>>>>>
>>>>>> The definition is used in acpi_ghes_memory_errors() of this patch. However,
>>>>>> I don't see it has been used by Linux. This field isn't used by Linux to determine
>>>>>> the total number of error entries. So I think I can drop it either if Igor is ok.
>>>>>>      
>>>>
>>>> Lets keep this field either in next revision if Jonathan is fine.
>>>
>>> I'm fine with the field, but not the value.  As far as I can tell form the spec, it should
>>> be a mask, not a single bit.
>>>    
>>
>> Agreed, lets keep ACPI_HEST_ERROR_ENTRY_COUNT as zero in next revision.
> 
> I'm even more confused now.  The GEBS Error Data entry count should be field from 13:4
> and the value taken should be the number of entries in the record, so 1, 4, 16 depending
> on the page size.
> 
> So that define of the value 4 is garbage. If it were DATA_ENTRIES_SHIFT then I'd be much happier.
> 

My bad. I misunderstood your point. It will be fixed by using APIs from
"hw/registerfields.h" as suggested by Philippe in another reply.

   ...
   FIELD(ACPI_GEBS, MULTIPLE_CORRECTABLE, 3, 1)
   FIELD(ACPI_GEBS, ERROR_DATA_ENTRIES, 4, 10)

   then use FIELD_DP32() to only set the correct bits.

Thanks,
Gavin


