Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26759F9EDFD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 07:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFo6H-0002nT-Pw; Thu, 23 Apr 2026 03:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFo6G-0002nG-28
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 03:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFo67-0005WX-G5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 03:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776927817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5yKQFfx/2LOA6zqVluGTipnRC1mV/o6U/b+oD0t4wws=;
 b=KRUNuiEnooq/Lipl3h8jiHDfDqXFDZu8U98pl9f3YB4qZoSzoygjXz+TLynRihkd0C6pCy
 I1U0BnAEnInevS6Cjy9Pwgj2Z7gUAGlqMdzWsKHQE382yCRMqc8ukXfBZuQI2aBFqR5kqJ
 6VPkzUq9b3UJoqDdr3cdHkzIdM0I314=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-JlvGiN1tOKWndqcTjBOPmw-1; Thu, 23 Apr 2026 03:03:34 -0400
X-MC-Unique: JlvGiN1tOKWndqcTjBOPmw-1
X-Mimecast-MFC-AGG-ID: JlvGiN1tOKWndqcTjBOPmw_1776927813
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43ff19e54beso3232562f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 00:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776927813; x=1777532613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5yKQFfx/2LOA6zqVluGTipnRC1mV/o6U/b+oD0t4wws=;
 b=IVcdME29KdIC5lGQkk/gxDwTr/RVo+NyDBvrcvxZGWDsJoxjfNDgUFOOa/DpAr/0YV
 1KGKkKk5M8OK+eiM3saW2d/Eh7ry/fRiEuObTxvdD0WqsLKc35C2jtzPIn+MCA29zsPE
 TIoJN6xS9IqZzuEUlH5G7bn7JnXfks3qXwcJRi9pkU71Nws6k9IqLxHIBwtaLV5XuQFm
 eOXIu6XS+J+V++g1XL2eJiXHLjpSN2Hq4lXzHXGpG8qZN9olB/fgoR9HQ4rlrTiyHPnE
 kDPSLH9YriMEay3W+Rb8/Ez92ez0+JsbvbsANMxMLXxPFoNsa8Ne7V5VUFWeGeJKqq4m
 atrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776927813; x=1777532613;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yKQFfx/2LOA6zqVluGTipnRC1mV/o6U/b+oD0t4wws=;
 b=Tjijf2BkLsBlbYPuqi036XpPZOBEnxMapj9QJpoRfcPwa4ZGb7ijVHobeymXhVhDQE
 Do+NnWviNxfET+DTzOfWCsSihSUCzasfRB8uQXkIXfA06CITcVH1MCMc1/5Gkb7C5N/4
 i7tWAqZ+Er2+K9L1QuoOk3FBcxYqBkOk8DQmDw5WAOw2jqKum9cxsdN8c4jpNgb+3nwM
 05d8XyttboXtZqxUConMOxNUVptfgxlb0kisUz1l7+uPO+USSTpkjXvyRvGEpUZVUXL1
 AUmUyjxl/jZSWqnGj6VlqNg+kEX08C6Yc0oqFysA5lVM+wKM4yX0MU8zK8MfQiXz0DRh
 gIdw==
X-Gm-Message-State: AOJu0YxYzDAAJOchh8+5eDbRlwvmwu+jf63CtBAs+BI0UxVAt0FAF3+F
 kbuEKk/wazeYI6006JMqjnUG6suglkK6/tqVpIOFKxQw19OUKljqQSXao9nJEwWKoo9Y8SGOZbV
 irLC7c0pW8U4sFhqkeZbDVKFGZeGIoyN914V1OtEQuO/8X7Vv6DKgBAIJ
X-Gm-Gg: AeBDiesGj45YMWqGqynWiWN0qM3ov0BybL506DeIMaRTHBiqIJ4NrSeGxcD3djP4aO+
 Js4zrRmBWQPzw5OahYfBKCywfK/0KfwgSehPiOZ7XD3kHIwWQTODVaB9jqF2c2EBVl/MqUfN34A
 DSyYaBhpj00v/ZTDg2PEkTNx6r7ygdg7KdZjQHYBiBhDdaqmzaI8vdPrJZIH/mIPCocqUPrMmAC
 FzS5Usp9UATul5kJgIoGVxQOoNOC/kzvOlsqX/BJ9x/SvobUGTwOBNBA7L3kgZp1srVjv7Ldrcn
 e1aSygcKnANxJzvmSVMHxMsifwYiG8HnhMRrBqgahMDKVgPsRYQPhGltlLtRv8/ZDigdsYbn4BK
 FjKNuflmvd4NjQz5RquODjrageaqF1Q==
X-Received: by 2002:a05:6000:40ca:b0:43d:70de:1c62 with SMTP id
 ffacd0b85a97d-43fe3e120c6mr40891896f8f.45.1776927812968; 
 Thu, 23 Apr 2026 00:03:32 -0700 (PDT)
X-Received: by 2002:a05:6000:40ca:b0:43d:70de:1c62 with SMTP id
 ffacd0b85a97d-43fe3e120c6mr40891800f8f.45.1776927812364; 
 Thu, 23 Apr 2026 00:03:32 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc375dsm46114823f8f.14.2026.04.23.00.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 00:03:31 -0700 (PDT)
Message-ID: <3b807fa9-ab6f-47ea-8dd0-828a58a60a4e@redhat.com>
Date: Thu, 23 Apr 2026 09:03:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] hw/core/register: add the REGISTER_ARRAY type
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20251017161809.235740-1-luc.michel@amd.com>
 <20251017161809.235740-3-luc.michel@amd.com>
 <86c40a92-76d0-4121-9347-929cfcd32f2a@redhat.com>
 <9eb1d421-2183-4093-bd93-ab015414bceb@redhat.com>
 <aenBv7JowYFfHpMX@XFR-LUMICHEL-L2.amd.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aenBv7JowYFfHpMX@XFR-LUMICHEL-L2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/04/2026 08.53, Luc Michel wrote:
> Hi Thomas,
> 
> On 13:06 Wed 22 Apr     , Thomas Huth wrote:
>> On 22/04/2026 12.56, Thomas Huth wrote:
>>> On 17/10/2025 18.18, Luc Michel wrote:
>>>> Introduce the REGISTER_ARRAY QOM type. This type reuses the existing
>>>> RegisterInfoArray struct. When `register_init_block' is called, it creates
>>>> a REGISTER_ARRAY object and parents it to the calling device. This way
>>>> it gets finalized when the device is. The memory region is parented to
>>>> the REGISTER_ARRAY object to ensure correct finalizing order.
>>>>
>>>> The finalize function of the REGISTER_ARRAY type performs the necessary
>>>> cleaning that used to be done by `register_finalize_block'. The latter
>>>> is left empty and will be removed when all the register API users have
>>>> been refactored.
>>>>
>>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>>> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
>>>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>>>> Signed-off-by: Luc Michel <luc.michel@amd.com>
>>>> ---
>>>>    include/hw/register.h |  4 ++++
>>>>    hw/core/register.c    | 26 ++++++++++++++++++++++----
>>>>    2 files changed, 26 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/include/hw/register.h b/include/hw/register.h
>>>> index 4d13ea183c7..65c82600e06 100644
>>>> --- a/include/hw/register.h
>>>> +++ b/include/hw/register.h
>>>> @@ -81,10 +81,12 @@ struct RegisterInfo {
>>>>        const RegisterAccessInfo *access;
>>>>        void *opaque;
>>>>    };
>>>> +#define TYPE_REGISTER_ARRAY "qemu-register-array"
>>>> +OBJECT_DECLARE_SIMPLE_TYPE(RegisterInfoArray, REGISTER_ARRAY)
>>>>    /**
>>>>     * This structure is used to group all of the individual registers
>>>> which are
>>>>     * modeled using the RegisterInfo structure.
>>>>     *
>>>> @@ -94,10 +96,12 @@ struct RegisterInfo {
>>>>     *
>>>>     * @mem: optional Memory region for the register
>>>>     */
>>>>    struct RegisterInfoArray {
>>>> +    Object parent_obj;
>>>> +
>>>>        MemoryRegion mem;
>>>>        int num_elements;
>>>>        RegisterInfo **r;
>>>> diff --git a/hw/core/register.c b/hw/core/register.c
>>>> index 2553cb15aba..1612ad174f9 100644
>>>> --- a/hw/core/register.c
>>>> +++ b/hw/core/register.c
>>>> @@ -243,14 +243,20 @@ static RegisterInfoArray
>>>> *register_init_block(DeviceState *owner,
>>>>                                                  bool debug_enabled,
>>>>                                                  uint64_t memory_size,
>>>>                                                  size_t data_size_bits)
>>>>    {
>>>>        const char *device_prefix = object_get_typename(OBJECT(owner));
>>>> -    RegisterInfoArray *r_array = g_new0(RegisterInfoArray, 1);
>>>> +    Object *obj;
>>>> +    RegisterInfoArray *r_array;
>>>>        int data_size = data_size_bits >> 3;
>>>>        int i;
>>>> +    obj = object_new(TYPE_REGISTER_ARRAY);
>>>> +    object_property_add_child(OBJECT(owner), "reg-array[*]", obj);
>>>> +    object_unref(obj);
>>>> +
>>>> +    r_array = REGISTER_ARRAY(obj);
>>>>        r_array->r = g_new0(RegisterInfo *, num);
>>>>        r_array->num_elements = num;
>>>>        r_array->debug = debug_enabled;
>>>>        r_array->prefix = device_prefix;
>>>> @@ -265,11 +271,11 @@ static RegisterInfoArray
>>>> *register_init_block(DeviceState *owner,
>>>>            r->opaque = owner;
>>>>            r_array->r[i] = r;
>>>>        }
>>>> -    memory_region_init_io(&r_array->mem, OBJECT(owner), ops, r_array,
>>>> +    memory_region_init_io(&r_array->mem, OBJECT(r_array), ops, r_array,
>>>>                              device_prefix, memory_size);
>>>
>>>    Hi,
>>>
>>> this likely broke the xlnx-versal-ospi device, see:
>>>
>>>    https://gitlab.com/qemu-project/qemu/-/work_items/3422
>>
>> And also:
>>
>>   https://gitlab.com/qemu-project/qemu/-/work_items/3421
>> and
>>   https://gitlab.com/qemu-project/qemu/-/work_items/3423
> 
> Let me have a look and come back with a series to fix those.
> 
>>
>> ... I wonder why nobody noticed this before? Are these corresponding
>> machines completely unused nowadays? At least we seem to lack a proper
>> functional test for those...
> 
> tests/functional/aarch64/test_xlnx_versal.py does exist but needs some
> improvements to better cover those machines.

D'oh, I grep'ed for the old name "xlnx-versal-virt", that's why I missed it!
Sorry for the confusion!

  Thanks,
   Thomas


