Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD775D59D6F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6uV-0004sr-42; Fri, 12 Dec 2025 12:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vU6uT-0004sW-Gy
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:26:29 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vU6uR-0003pn-Nk
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:26:29 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7aab061e7cbso1863683b3a.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 09:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765560386; x=1766165186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+N/fT+nUyiM8V/hhP9oiwKc6z2ij+E5mFgc1Q9wHQLU=;
 b=xJw3aBU5iNfSdZSay/k7az2WKOU7w8Fy9UeXAEGs7JP3+R6j86JUhcHdjIhoZswTPB
 GxuOORPWO6HYGKjkxadZMVXbrgwU19mSK89YSBKZmAlXMCa0+GBnqFjSd42onwSNrxiX
 YYOYX8/UlnIGAU/VPKdTtAFoXgBOF+8J6nNofqptUOI/uLupdQJv9j60AzzZD/rTRFsh
 uNFWJfGni2C2KONSy6UDwae3sqwQTVdZ9UBwsKgo5TuhK/8D3ZlOX+nwNmeJNCDmRDhI
 4pkgrtHbNcXNyQROl3isNv3ZGQ+nrk2Pl7rkzvqYvBK0W9ekkyjkVPr8pxqQJ7JLFyDI
 yzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765560386; x=1766165186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+N/fT+nUyiM8V/hhP9oiwKc6z2ij+E5mFgc1Q9wHQLU=;
 b=P513ejluSwmGmUkhqNmlB3eogzNX0KPrlmxO42SGDV4t+UJMUiiyIWFYjg3ApDSTnv
 KB69fO/yG2O5z46dtwewSVwZ/Tp0MNCU7HT6k36/Kic2whRD01kamtlXjKjtUhQSNFLQ
 R3Hz+QR0hmh1/s0wHcMsMMxww3lCwyxns4QEbLfHL59/kPGscqBmWBJ+kV4cOjeIj8aA
 yWhoLsIungB/Nhv2A6Ldkz1tFCrn3nejOl3OBj7CZn2hV50xJH9vdZdHwZUhHqiyLho2
 2+/jv/ZGYHrWvTL0v1tYzTAuNMzh0p1kLtM34kv6hDNUfdS6d69sRmIjpD1EIOz8oO0O
 DebQ==
X-Gm-Message-State: AOJu0YzmMZtHPTW4Tev0Pkoe4Y/GZFUP8jcNcPtjl91AzCE75Z94oAzT
 sHhtmcte36CzGeqtyuuXNu/IKY89dzQFzAeYRMLMt1/ihLzX8KP4jlsiKob3sYhBBeU=
X-Gm-Gg: AY/fxX4FL+ShbYnMxahYR+VS/Mewy9HHQU7FnoqiUwYlQlVtQUcCQhRex5JtymvLfAI
 WbijkHYgtH1rvkLMQOXFUc3SWBiuG6ZNxvMT1VdvN/FtywwEZ8wLQOY8OoWoFvroY6wyJdxFlAB
 1uwBH5zNWW/2C8HFudEuRT4lyB4hFq1iVU7MW2AysAgPSv/RSYkM7vhxQOh7OsVr49x8JaviN86
 HrYWzjrZN6oL8lOvgTrBxXHm6xHHeZw2K+/g8oIQwIN4d0VFOusSq9UJvk4kT5oOLZSSQ/ERgL3
 gcpv00K79BG4eBcRjCP1asKkGxnVHNjWzvuS+vzBeuxqdi9IXcujf8f7s+LspoUKoq3ONsn6Wgj
 lL6e5eILCbggsFbOM5oFH/uB6R0l8N0B8IsBubS2vugPXnLrfsEqijHN0XBkDFFnioigfVf39+y
 qDsOlv3GblvE5GdhYoIpr8NNbK12ibsrA0O3VwYaihxofannbUkBQD230=
X-Google-Smtp-Source: AGHT+IFmjRcG6/T+E84pI+lrwefui35xKxXHeqT95WgJR6LfdwszRpi+YLz7iAv7r9KHMnaQXw+UNg==
X-Received: by 2002:a05:6a00:290f:b0:7e8:4433:8fa4 with SMTP id
 d2e1a72fcca58-7f6694aa67dmr2644027b3a.44.1765560385928; 
 Fri, 12 Dec 2025 09:26:25 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7f4c2772613sm5828720b3a.18.2025.12.12.09.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 09:26:25 -0800 (PST)
Message-ID: <408145f6-0d61-4341-b397-2c8984038fcd@linaro.org>
Date: Fri, 12 Dec 2025 09:26:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/smmu: add memory regions as property for an SMMU
 instance
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 tangtao1634@phytium.com.cn, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20251211221715.2206662-1-pierrick.bouvier@linaro.org>
 <87a479e9-21eb-4c4c-8e64-32744eea1f96@linaro.org>
 <CAFEAcA9cd+v5GrWK3KPjQ9ZURHbNzx+_SywcBaZdeAxYEk_NBA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA9cd+v5GrWK3KPjQ9ZURHbNzx+_SywcBaZdeAxYEk_NBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 12/12/25 2:50 AM, Peter Maydell wrote:
> On Fri, 12 Dec 2025 at 06:16, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Pierrick,
>>
>> On 11/12/25 23:17, Pierrick Bouvier wrote:
>>> This will be used to access non-secure and secure memory. Secure support
>>> and Granule Protection Check (for RME) for SMMU need to access secure
>>> memory.
>>
>> Sorry yesterday it was late for me and I forgot to post the similar
>> patch :/
>>
>>>
>>> As well, it allows to remove usage of global address_space_memory,
>>> allowing different SMMU instances to have a specific view of memory.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    include/hw/arm/smmu-common.h |  4 ++++
>>>    hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>>>    hw/arm/smmu-common.c         | 24 ++++++++++++++++++++++++
>>>    hw/arm/virt.c                | 16 +++++++++++-----
>>>    4 files changed, 51 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>>> index a6bdb67a983..0f08ae080c9 100644
>>> --- a/include/hw/arm/smmu-common.h
>>> +++ b/include/hw/arm/smmu-common.h
>>> @@ -227,6 +227,10 @@ struct SMMUState {
>>>        uint8_t bus_num;
>>>        PCIBus *primary_bus;
>>>        bool smmu_per_bus; /* SMMU is specific to the primary_bus */
>>> +    MemoryRegion *memory;
>>> +    AddressSpace as_memory;
>>> +    MemoryRegion *secure_memory;
>>> +    AddressSpace as_secure_memory;
>>
>> Has SMMU concept of "secure memory"?
> 
> Yes -- IHI0070G.b section 3.10.2: when SMMU_S_IDR1.SECURE_IMPL=1
> "the SMMU can generate transactions to the memory system, to Secure
> PA space (NS=0) and Non-secure PA space (NS=1)".
> 
> When the SMMU has Realm support then further (3.10.3)
> the output PA space can be Realm, and also GPT checks are
> always done to the Root address space.
> 
> So an SMMU with Secure and Realm support can emit transactions
> to any of the 4 address spaces, the same as a CPU with those
> features.
> 
> Separately from that, at the moment the way we model Realm
> and Root is by using the same QEMU MemoryRegion trees we
> have for NS and S and just using MemTxAttrs::space to distinguish,
> because we don't have any need for devices that appear only in
> Realm and not NS, or only in Root and not S. So for CPUs we
> collapse the 4 architectural address spaces down into two QEMU
> ones.
>

Yes, thanks for confirming this.
I was a bit puzzled by the fact I could not read the gpt with the global 
address_space_memory, but after talking with Richard and Philippe, it 
made sense as this memory is under secure memory. As a consequence, I 
understood better your explaination about AddressSpace in our call on 
Tuesday, so that's good to see puzzle starting to get assembled.

> For the SMMU we can presumably follow the CPU there
> (with an equivalent "give me the AddressSpace I should
> use for these MemTxAttrs" function as arm_addressspace()).
>

This is exactly what Tao introduced in his series, and that I extended 
for Realm on my side.

>> My understanding is just a
>> different memory to access GPT, so I'd name it "gpt_memory".
> 
> I would prefer that we use the architecturally standard
> terminology here.
> 
> thanks
> -- PMM

Overall, I posted this as it's needed for both Tao's work and mine, and 
instead of pushing this to Tao as part of this series, I thought it 
could be included already, so we both can benefit without having to play 
with series merging.

