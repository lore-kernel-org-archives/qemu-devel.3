Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D40BCAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 09:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy5e3-0008UK-FM; Mon, 15 Sep 2025 05:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uy5dx-0008Ry-MS
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 05:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uy5c1-0001Iv-0Q
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 05:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757928899;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/H12fGchyrIH7qwRBNagf9r7hA/DpMHPJxFYE+/ei7g=;
 b=VZitlBkBgecnT9C+6ZPlUfNL/U41M7f4eAkQ1abcCpvc/DJsv6ycpVIDOZ1nB9sDl4AQ1B
 UhJbzOJSaCFUR9JOdhFA9toyjflbXqn1aljVJfuWIwMzNOLm+hK9FIOIhobzVNcxVI6gky
 ba/S67LBrw7uRa+D4ovwZOz+46HPVvY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-vUFOEoZDO9e8cCYDpJZ39g-1; Mon, 15 Sep 2025 05:34:58 -0400
X-MC-Unique: vUFOEoZDO9e8cCYDpJZ39g-1
X-Mimecast-MFC-AGG-ID: vUFOEoZDO9e8cCYDpJZ39g_1757928897
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45dd9a66cfbso34980475e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 02:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757928897; x=1758533697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/H12fGchyrIH7qwRBNagf9r7hA/DpMHPJxFYE+/ei7g=;
 b=TOPRVH4OXXy5AwHWVyip8GT4h4y8CU71qRqrqhLcH6+ChfotzIGVxueHi4m7A6ppzh
 9tL4/RGaf2zca5guYH1bZx9r8F+iS+NKhkgnSeel0uBqhFy+836mAlgNC9Mn3dKx4LXy
 1RM7M6TDB/47pWOtbn4/30C8qcEmITvW/TkOxX/ULw/KfkBu8ll7wXBp5UjkGpQRI8cc
 arAbRkawW9P+MtpJG2QWrH2e9VWopNa4zlMjJPHjdxxQrYsV7dn2DeiYueXvcc6hVd4b
 w1os/VbOKolYpFWtgwBYb2ZfGFW1f7qgh1ptqkwM5leYxR78ns3KS2kaRLIw7qi3Pe4y
 IJNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbJJLWYy6kUOtwZRNmbrG9VTp63LAi6bscOP43hU2cdg405tTztVl6c6xWJ9oVZI1SP2PbcujmDbZS@nongnu.org
X-Gm-Message-State: AOJu0Yz5XGekSeZxP9MB8JjIfaCG4R899j1dcy8STDX7x0NdYYrPRLt0
 brb79BcpT5XKB+/iTvUQXPQkfYfg589OClxYP/zr4Qo9K/SUGBiBDYqhVEPQaIoDNIy1kcWpdr7
 ODV8euV9yWfkTaR/tco6FC2FPvuqyb0UA9UdN9hjN+jR2S5ELtX26iv8u
X-Gm-Gg: ASbGnctZAEZxqary1xnOPR+5vXJCCf6EjiGVbxY9DBB3WQQTdPpslSgmv5KfluKOahn
 GICUt4rBN2Yu5ZbIazeqD2slQLTPVbqdtNmW5AKMDDKZZfo50kom/bGOeLuLyEIx0+93w16CSJz
 BGJiBV5xCtzTI71a0SGevR3IplezEfZ0DNn21EG+dbUuywp9Hh0DERhi6XjBQ6RdE34TDIaH5K2
 UsB1/MrbUA1/MmjXd/tLbyCUdRZ2P3BtPpMXvDbMQx2b6UxKOwtDleWcqDTZd7dLWqiKhMPstBS
 lxR20OhxP23IO5ttZBZ9bjjdvbKJvWv5PURGeRrqfHsl+/fNAjnysPFRxXM2JfvjrAMghwsju4b
 +ivejGqMgQMQ=
X-Received: by 2002:a05:600c:3505:b0:45f:2843:e76b with SMTP id
 5b1f17b1804b1-45f2843e99cmr53793115e9.2.1757928897246; 
 Mon, 15 Sep 2025 02:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKtlqdKidjryuc8tCVhgCeBwAJANsW36ih8aaFYsF/eKtndaf8UCw54QZDfwJcDnXfD5cF5A==
X-Received: by 2002:a05:600c:3505:b0:45f:2843:e76b with SMTP id
 5b1f17b1804b1-45f2843e99cmr53792735e9.2.1757928896682; 
 Mon, 15 Sep 2025 02:34:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f2978ad91sm83548575e9.6.2025.09.15.02.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 02:34:56 -0700 (PDT)
Message-ID: <39d51d3c-e773-42e4-8161-c9d283379498@redhat.com>
Date: Mon, 15 Sep 2025 11:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/11] hw/arm/smmuv3: Implement read/write logic for secure
 registers
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 jean-philippe@linaro.org
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-3-tangtao1634@phytium.com.cn>
 <aKOaIcPp26kbS3Nn@google.com>
 <53607fe8-0555-4408-bfa6-e4b95d44e230@phytium.com.cn>
 <aKma98hlAWG9M4h_@google.com>
 <8987bd11-afae-4157-979d-ef10be69a7a5@phytium.com.cn>
 <aMfY4LJVEGw3egdP@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aMfY4LJVEGw3egdP@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 9/15/25 11:14 AM, Mostafa Saleh wrote:
> Hi Tao,
>
> On Thu, Sep 11, 2025 at 11:27:50PM +0800, Tao Tang wrote:
>> Hi Mostafa,
>>
>> First, my apologies for the long delay in getting back to you. I was away on
>> paternity leave for the last few weeks.
> No worries!
>
>> Thank you for the detailed follow-up, your advice is very helpful for
>> simplifying the series.
>>
>>
>> On 2025/8/23 18:41, Mostafa Saleh wrote:
>>> On Wed, Aug 20, 2025 at 11:21:02PM +0800, Tao Tang wrote:
>>>> On 2025/8/19 05:24, Mostafa Saleh wrote:
>>>>> On Wed, Aug 06, 2025 at 11:11:25PM +0800, Tao Tang wrote:
>>>>>> This patch builds upon the previous introduction of secure register
>>>>>> definitions by providing the functional implementation for their access.
>>>>>>
>>>>>> The availability of the secure programming interface is now correctly
>>>>>> gated by the S_IDR1.SECURE_IMPL bit. When this bit indicates that
>>>>>> secure functionality is enabled, the I/O handlers (smmuv3_read and
>>>>>> smmuv3_write) will correctly dispatch accesses to the secure
>>>>>> register space.
>>>>>>
>>>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>>>> ---
>>>>>>    hw/arm/smmuv3-internal.h |   5 +
>>>>>>    hw/arm/smmuv3.c          | 451 +++++++++++++++++++++++++++++++++++++++
>>>>>>    2 files changed, 456 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>>>>>> index 483aaa915e..1a8b1cb204 100644
>>>>>> --- a/hw/arm/smmuv3-internal.h
>>>>>> +++ b/hw/arm/smmuv3-internal.h
>>>>>> @@ -122,6 +122,11 @@ REG32(CR0,                 0x20)
>>>>>>    #define SMMU_CR0_RESERVED 0xFFFFFC20
>>>>>> +/*
>>>>>> + * BIT1 and BIT4 are RES0 in SMMU_S_CRO
>>>>>> + */
>>>>>> +#define SMMU_S_CR0_RESERVED 0xFFFFFC12
>>>>>> +
>>>>>>    REG32(CR0ACK,              0x24)
>>>>>>    REG32(CR1,                 0x28)
>>>>>>    REG32(CR2,                 0x2c)
>>>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>>>> index ab67972353..619180d204 100644
>>>>>> --- a/hw/arm/smmuv3.c
>>>>>> +++ b/hw/arm/smmuv3.c
>>>>>> @@ -317,6 +317,18 @@ static void smmuv3_init_regs(SMMUv3State *s)
>>>>>>        s->gerrorn = 0;
>>>>>>        s->statusr = 0;
>>>>>>        s->gbpa = SMMU_GBPA_RESET_VAL;
>>>>>> +
>>>>>> +    /* Initialize secure state */
>>>>>> +    memset(s->secure_idr, 0, sizeof(s->secure_idr));
>>>>>> +    /* Secure EL2 and Secure stage 2 support */
>>>>>> +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1, SEL2, 1);
>>>>> AFAIU, this is wrong, SEL2 means that the SMMU has dual stage-2,
>>>>> one for secure (S_S2TTB) and one for non-secure IPAs(S2TTB).
>>>>> Which is not implemented in this series.
>>>> Hi Mostafa,
>>>>
>>>> Thank you for the very detailed and helpful review. Your feedback is spot
>>>> on, and I'd like to address your points and ask for a quick confirmation on
>>>> them.
>>>>
>>>> Regarding the SEL2 bit, you are absolutely right, my understanding was
>>>> incorrect. I've spent the last few days reviewing the manual to better
>>>> understand the selection between Secure and Non-secure Stage 2 translations.
>>>> I would be very grateful if you could confirm if my new understanding is
>>>> correct:
>>>>
>>>> - In Stage 2-only mode (Stage 1 bypassed), the choice between a Secure or
>>>> Non-secure IPA translation is determined solely by STE.NSCFG.
>>>>
>>> Yes, but that's only with SMMU_IDR1.ATTR_PERMS_OVR which Qemu doesn't
>>> advertise, so in our case it's always secure.
>>>
>>>> - In Stage 1-enabled mode, STE.NSCFG is ignored. The choice is determined by
>>>> the translation process, starting from CD.NSCFGx, with the output NS
>>>> attribute being the result of intermediate NSTable flags and the final
>>>> descriptor.NS bit (TTD.NSTable, TTD.NS).
>>>>
>>> You have to differentiate between the security state of the translation and
>>> the security state of the translation table access.
>>>
>>> For stage-1, the security state is determined by the NS bit in the last
>>> level PTE, which in case of nested translation it will choose between S2TTB
>>> or S_S2TTB.
>>>
>>> Also, note that the stage-2 also have an NS which define the final attribute
>>> of the transaction.
>>>
>>> You have to also be careful around things such as NSCFG{0,1} as it might
>>> change which stage-2 is used for the stage-1 TTB walk.
>>>
>>> I see, in your patches, all the page-table access is done using the secure
>>> state of the SID which is not correct.
>>>
>>>
>>>> Based on this, I plan to have an internal flag, perhaps named
>>>> target_ipa_is_ns in SMMUTransCfg.SMMUS2Cfg struct, to track the outcome of
>>>> this process. This flag will then determine whether S_S2TTB or S2TTB is used
>>>> for the Stage 2 translation.
>>>>
>>> I am worried that it's not that simple for a single secure nested translation
>>> you can have multiple stage-2 walks where some might be secure and others not,
>>> so I imagine this some how will be determined from each stage-1 walk and
>>> some how returned (maybe in the TLB struct) which is then the stage-2
>>> walk looks into.
>>>
>>> I am not sure how complicated it is to manage 2 stage-2 with the current code
>>> base, so my advice would be to split the problem; for now you can drop SEL2
>>> from this series and rely on NS stage-2.
>>
>> I would like to confirm my understanding of the implementation. Does this
>> mean that for the current RFC, we should set S_IDR1.SEL2=0, which implies
>> that all Stage-2 translations will begin with a Non-secure IPA? And the
>> final output PA space will then almost always be Non-secure PA, with the
>> sole exception being when S2SW, S2SA, S2NSW, and S2NSA are ALL ZERO.
>>
>>
>> However, since these fields are RES0 when S_IDR1.SEL2=0, it seems we can
>> conclude that for this version, the output will definitively be a Non-secure
>> PA. I believe this is what you meant by your advice to "rely on NS stage-2".
>> I would be grateful if you could let me know whether this interpretation is
>> on the right track.
> Yes, that’s what I meant, I think that simplifies a lot, in this series we
> can focus on the infrastructure for the secure SMMU (registers, TLBs..),
> and then extra features such as secure stage-2 can be added later.
>
>>
>> ------------------------------<snip>------------------------------
>>
>>>> The new code performs a single, necessary security state check at the entry
>>>> point of the MMIO handlers. The rest of the logic relies on the banking
>>>> mechanism, which makes the implementation generic for Non-secure, Secure,
>>>> and future states like Realm/Root. The new structure looks like this:
>>>>
>>>> /* Structure for one register bank */
>>>> typedef struct SMMUv3Bank {
>>>>      uint32_t idr[6];     /* IDR0-IDR5, note: IDR5 only used for NS bank */
>>>>      uint32_t cr[3];      /* CR0-CR2 */
>>>>      uint32_t cr0ack;
>>>>      uint32_t init;       /* S_INIT register (secure only), reserved for NS
>>>> */
>>>>      uint32_t gbpa;
>>>>
>>>> ......
>>>>
>>>>      SMMUQueue eventq, cmdq;
>>>> } SMMUv3Bank;
>>>>
>>>> struct SMMUv3State {
>>>>      SMMUState     smmu_state;
>>>>
>>>>      /* Shared (non-banked) registers and state */
>>>>      uint32_t features;
>>>>      uint8_t sid_size;
>>>>      uint8_t sid_split;
>>>>
>>>> ......
>>>>
>>>>      /* Banked registers for all access */
>>>>      SMMUv3Bank bank[SMMU_SEC_IDX_NUM];
>>>> ......
>>>> };
>>>>
>>> Yes, IMO,that’s the right approach. Although that might make the
>>> migration code more complicated as we changed the state struct.
>>>
>>> Thanks,
>>> Mostafa
>> I have almost completed the refactoring based on this new structure, and I
>> will send out the v2 patch series in the next few days for review.
> Sounds good!
Sorry for having failed to review the RFC on time. Thanks to other
reviewers I think you've got quite a lot of feedbacks already. I will
review v2.

Looking forward to receiving your respin.

Thanks

Eric
>
> Thanks,
> Mostafa
>
>> Thanks again for your invaluable guidance.
>>
>> Best regards,
>>
>> Tao
>>


