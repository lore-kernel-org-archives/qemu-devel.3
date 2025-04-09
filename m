Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99231C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 05:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2OJo-0005Df-NS; Wed, 09 Apr 2025 01:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u2OJn-0005D8-Bi
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 01:49:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u2OJl-00027T-Ey
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 01:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744177783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F42P/aBeYsB6PnKEv93K1Zy2owJdwhN+7EZdJpS6u+c=;
 b=LjMmmEyHvFwoW80TrR86z3+vcaZftZXzw1Paur3kcv5a5k6lZqmIrV50YQrWgoPyh4rZZ+
 sTYFs835W6w7JlYhtf9yWl8Uky2bc13zz6bRssWv7hhknTNCOlA6fOXpnxsXaH4cH77LWS
 CTdFJnT/xZJngDLk7N6uJzGuKac6rs4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-AnR94UY2MJyj5jN8Wzk78g-1; Wed, 09 Apr 2025 01:49:41 -0400
X-MC-Unique: AnR94UY2MJyj5jN8Wzk78g-1
X-Mimecast-MFC-AGG-ID: AnR94UY2MJyj5jN8Wzk78g_1744177780
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac3e0c1336dso479121966b.3
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 22:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744177780; x=1744782580;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F42P/aBeYsB6PnKEv93K1Zy2owJdwhN+7EZdJpS6u+c=;
 b=ghsnYwTf2/HYF0n2LX3hFdAPEXi0iD416LZg9JtyYjVoxx6ajiDVYvx27QBnaYUUJj
 uLJyqkJrJAqd7QiT5LuQ+XzyQG0Rioh7uNPjEP2Sy7jJK8SBxsdzZpaX1A7vFhCq/BYH
 edrvNQG99nxDX2Cypk2oyP02a/cXgoVAUFww3FVS+9WB2Xfkb5aRcwMop6ipjhGUGQSg
 4sjFyopiSj0YyrQ4OslOcHA1c8T91KrbFBNCbGcNhqYC9XrzuSTnjqujbhoEEICHPiCU
 6RyqwN0DyvQ5m7vjzzNcwlCSigiiDvmD9OjZTSBcYrss6I/3in+GjTeEzzAYqV15F2NL
 hb7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4chTh7yiD1CHKCpT7K4IKJOTjRZmcV7OfoZoQHC6qeRJIxDYfXrmnXYAfyDKEr4E3EWg6ri/N7fIx@nongnu.org
X-Gm-Message-State: AOJu0Yy8RSD0dFxgXANWw51fodwx5iBM3PNaNsIjluhAqdmeme+W4ll9
 vqmzCpR3ckPVvGV+M7Z9UUB3/3FKlzieNaknr5LivH7+1rj6AUK60i5RD6oABD4T4bx1HPi83aF
 19V5+ruVSC9oZZiCPzcz+FKNc+ZAgSGRCsBOwaxznQfWau8YC6EA6BvefW8jOBN8=
X-Gm-Gg: ASbGncuvublcDJ9XR4ETYCApLI4NwWi/8c6ROfvP/eL7fCO/+VoJbEXNV0IkuW48y4t
 7gXMkoShC3avUqT17WqsvW/Bg3xQsf1U1U1EuqVntR1jWZpOVmzGvySJ2/+xJTUNbpCkj6r5Vbk
 bUIJvtAbpB/5+/WNnW9jkWnwX4eZJnXdnIdCSacnp8Bz2q469gAR4fYUSwsEGmidksb0aO8mOhC
 RyQe8zVT3xSawmWAtVFXf/QqsgyAmLppucOADItzY6/ev7QvoNj8IB1DX8385OrofYsbbjvTQ95
 KIcgSToowQeFzSt4zBn4VAd66a/253N/VEY+QMFOG0adLPM=
X-Received: by 2002:a17:907:86a3:b0:ac8:17a1:e42 with SMTP id
 a640c23a62f3a-aca9d615aa9mr113604966b.22.1744177780308; 
 Tue, 08 Apr 2025 22:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU6HPwJsQM7fUKAlB+3VbD/X2t/JbveHt56UwrJpYFMyS2BTFUTlCrbN9ne+NZAWu2QLDXbg==
X-Received: by 2002:a17:907:86a3:b0:ac8:17a1:e42 with SMTP id
 a640c23a62f3a-aca9d615aa9mr113603166b.22.1744177779951; 
 Tue, 08 Apr 2025 22:49:39 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1bb2e15sm35957466b.17.2025.04.08.22.49.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 22:49:39 -0700 (PDT)
Message-ID: <037d512b-5214-449c-a518-a6b2d9d5fc29@redhat.com>
Date: Wed, 9 Apr 2025 07:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] hw/s390x: compat handling for backward migration
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250331140041.3133621-1-shalini@linux.ibm.com>
 <20250331140041.3133621-5-shalini@linux.ibm.com>
 <1584a6d0-63b8-459b-9f4b-84192a9256e1@redhat.com>
 <688c719a1942615ada3e438670b8fb29@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <688c719a1942615ada3e438670b8fb29@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 03/04/2025 14.49, Shalini Chellathurai Saroja wrote:
> On 2025-04-02 09:52, Thomas Huth wrote:
>> On 31/03/2025 16.00, Shalini Chellathurai Saroja wrote:
>>> Add Control-Program Identification (CPI) device to QOM only when the virtual
>>> machine supports CPI. CPI is supported from "s390-ccw-virtio-10.0" machine
>>> and higher.
>>>
>>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>>> ---
>>>   hw/s390x/event-facility.c  | 27 ++++++++++++++++++++++-----
>>>   hw/s390x/s390-virtio-ccw.c |  1 +
>>>   2 files changed, 23 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>>> index c0fb6e098c..cb23bbc54b 100644
>>> --- a/hw/s390x/event-facility.c
>>> +++ b/hw/s390x/event-facility.c
>>> @@ -22,6 +22,7 @@
>>>   #include "hw/s390x/sclp.h"
>>>   #include "migration/vmstate.h"
>>>   #include "hw/s390x/event-facility.h"
>>> +#include "hw/qdev-properties.h"
>>>     typedef struct SCLPEventsBus {
>>>       BusState qbus;
>>> @@ -54,6 +55,7 @@ struct SCLPEventFacility {
>>>       bool allow_all_mask_sizes;
>>>       /* length of the receive mask */
>>>       uint16_t mask_length;
>>> +    bool use_cpi;
>>>   };
>>>     /* return true if any child has event pending set */
>>> @@ -455,11 +457,20 @@ static void realize_event_facility(DeviceState 
>>> *dev, Error **errp)
>>>           qdev_unrealize(DEVICE(&event_facility->quiesce));
>>>           return;
>>>       }
>>> -    if (!qdev_realize(DEVICE(&event_facility->cpi),
>>> -                      BUS(&event_facility->sbus), errp)) {
>>> -        qdev_unrealize(DEVICE(&event_facility->quiesce));
>>> -        qdev_unrealize(DEVICE(&event_facility->cpu_hotplug));
>>> -        return;
>>> +    /*
>>> +     * Add sclpcpi device to QOM only when the virtual machine supports
>>> +     * Control-Program Identification. It is supported by "s390-ccw- 
>>> virtio-10.0"
>>> +     * machine and higher.
>>> +     */
>>> +    if (!event_facility->use_cpi) {
>>> +        object_unparent(OBJECT(&event_facility->cpi));
>>> +    } else {
>>> +        if (!qdev_realize(DEVICE(&event_facility->cpi),
>>> +                          BUS(&event_facility->sbus), errp)) {
>>> +            qdev_unrealize(DEVICE(&event_facility->quiesce));
>>> +            qdev_unrealize(DEVICE(&event_facility->cpu_hotplug));
>>> +            return;
>>> +        }
>>
>> Hmm, first doing object_initialize_child() in init_event_facility()
>> and then unparenting it here again in case we are running with an
>> older machine type is a little bit ugly. I wonder whether it would be
>> nicer to add the QOM object from ccw_init() init instead, similar to
>> what we do with the SCLP-console in s390_create_sclpconsole() ? If
>> you've got some spare minutes, could you please give it a try whether
>> that looks nicer?
>>
> 
> Hello Thomas,
> 
> Sure. Did you mean like the code below?, if yes, the use_cpi is always true 
> when adding the sclpcpi device from ccw_init(). The use_cpi is set to false 
> at a later point, when the machine type is 9.2 or older. This means the 
> sclpcpi device is always added, the output and the code are provided below. 
> Please let me know how to proceed, thank you very much.
...
> @@ -499,6 +485,7 @@ static void init_event_facility_class(ObjectClass 
> *klass, void *data)
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>       k->command_handler = command_handler;
>       k->event_pending = event_pending;
> +    k->use_cpi = use_cpi;
>   }
...
> diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event- 
> facility.h
> index f445d2f9f5..ba20161023 100644
> --- a/include/hw/s390x/event-facility.h
> +++ b/include/hw/s390x/event-facility.h
> @@ -204,6 +204,7 @@ struct SCLPEventFacilityClass {
>       SysBusDeviceClass parent_class;
>       void (*command_handler)(SCLPEventFacility *ef, SCCB *sccb, uint64_t 
> code);
>       bool (*event_pending)(SCLPEventFacility *ef);
> +    bool (*use_cpi)(SCLPEventFacility *ef);
>   };

  Hi,

you certainly don't need the (*use_cpi) callback here.

I'd suggest to:

1) Add a boolean flag to S390CcwMachineClass in s390-virtio-ccw.h called 
"use_cpi", "cpi_allowed", "has_cpi" or whatever.

2) Set that flag to true in ccw_machine_class_init() (similar to that 
hpage_1m_allowed flag)

3) Set that flag to false in ccw_machine_9_2_class_options() so that it gets 
disabled for older machine type classes. Important: use the class_options() 
function here, not the instance_options()! Also not that this should go into 
the ccw_machine_10_0_class_options() functions instead once v10.0 has been 
released.

4) In ccw_init() you should now be able to use "S390CcwMachineClass *s390mc 
= S390_CCW_MACHINE_CLASS(mc)" to query the flag from the machine class.

  HTH,
   Thomas


