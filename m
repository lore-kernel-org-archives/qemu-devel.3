Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827FDC77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 18:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTmJW-0000N6-Fv; Mon, 23 Jun 2025 14:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uTmJV-0000Mq-7s
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 14:54:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uTmJS-0002y7-CT
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 14:54:40 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-748e378ba4fso5661531b3a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750704877; x=1751309677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3/IXpHCAIwAHF2+6D0xIvAg7uvuJY4X9jPtJNi9WglY=;
 b=KKWYpaXoyJBxmyxNVeXBmFVkzLKY4BHXMUt3joIZEAIMnUinZRUZTVT8zfstcAey60
 ryX44WXWT84kb1aX1aKTLf3SdH09DtjicaolYcV29RHJdB0R2i+k9OnYWcjBbiwvfCZD
 j2q72z6k+qB/HOyZxuUKuCvRmBkbmRvCkv+vySyvWM+fy6NKHrgPipxhzhYAaRaCE88E
 B4+k+559lNTh79yfs+xVs5ql3G25JMfL1ylam0g6h6wETdi7uEyWf3Ti4geRa9ZjpxIO
 Pmp+ziJSFb4nA3+8d1jUnozDHnoVRkzkDIATqkX8oRRQIFcGQ5qKraZDc+MJemycnPsE
 1b7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750704877; x=1751309677;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3/IXpHCAIwAHF2+6D0xIvAg7uvuJY4X9jPtJNi9WglY=;
 b=jlwBhk2xoWhyPQ8WHX4g6tXJMEMSj149rCLTIN7B7iQvABWiTG5dL3o1DkGk/spOXA
 zL9ZGJ7vOaRYTwfVWYNDvyt4R6l80doNLmPtxEAJPgcU6zvO7ytyzwpSFb70KhAHx9tv
 F7q+ulCnmf0c62hojgVXupsx2cBw/LO7UwKl7LLU6l/hcYr2kCG8cyF1g4T0Naonc8j3
 JRKBADNbxJi+O2TnG1dcmHB+7k73NvabAx9J6WvrIayPisRhTqgR1o46oYzKtklbpR6K
 ddGa+VW+1wXFIMVkjlIEaV1+6MSBqKOyKJFLQo5iBcCq6bqq/seyy7D8DitFr1C5eEjo
 8BYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeQ3UNSxJh87+WHJnhbuANei/ORs5G1GEWxCM919emt3MtGnjbY5DNtKcR2zVBK3B8SJHWW2R7JN1T@nongnu.org
X-Gm-Message-State: AOJu0YzTEYkLAgRMAjtF8HGnwX3UizOU30etTxl4xf533LVVTTX9WOo2
 cc2/KBrLGUl03F20ebk98mSIAeuQruk97NeES+MZLY/v/lT3/5w42Kbw7jHHOXnLgCg=
X-Gm-Gg: ASbGncvL4GK5UeSJTs9DELwmSjwNWxHPkKpZmJMGW8LjaeHv9iFjxg6zOzqBHFIo7Dn
 cukuX8uK5hESDn08GtxJtK2Elne/bU0p/Wn3Cdmth/mFAg+5F+Ee8YC1w7fg1J/De9fWH+pSQ5X
 KGHyqF9q2I6WZcPoUEbvvW+yy1tfyLGPlnm164o53ZjKkjgHSfAFDgjJUHOer9R3quTwu1rDd6T
 2CfcS5NayWd9kxAyFaw7N6z9ApYlGQ/HccX3EMlqn4/ciuZP2M7zscC7FdsOlMHE5ND6xmoGSl1
 JGayyaXT/8lTHp+wrbR8SzkMlIY9fZ9XjVmIldQnjaPjtPdTSOnfVvf+m2FZzAlTaQkGhbA34g=
 =
X-Google-Smtp-Source: AGHT+IGut3T4373OR4+gus/ZZuHmpKmrLMdXpTr/TRLKWekKznOPkH/RicRBUxdBuXtzAQxKKpSYxQ==
X-Received: by 2002:a05:6a00:cd4:b0:748:e772:f952 with SMTP id
 d2e1a72fcca58-7490d651b3bmr18132635b3a.17.1750704876835; 
 Mon, 23 Jun 2025 11:54:36 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.58.88])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f125d668sm7351529a12.54.2025.06.23.11.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 11:54:36 -0700 (PDT)
Message-ID: <99b8c58a-e570-4ab6-8abe-541fd89efec6@linaro.org>
Date: Mon, 23 Jun 2025 15:54:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v4 0/8] hw/arm: GIC 'its=off' ACPI table fixes
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
 <5b0f2250-e521-4172-870c-0384c5ef2382@redhat.com>
 <36ac7f90-d946-439f-ab20-123f542291b6@linaro.org>
 <cd38280c-6f5e-4c58-b40c-3391d121e557@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <cd38280c-6f5e-4c58-b40c-3391d121e557@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x429.google.com
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

Hi Eric,

On 6/17/25 10:26, Eric Auger wrote:
> Hi Gustavo,
> 
> On 6/17/25 3:01 PM, Gustavo Romero wrote:
>> Hi Eric,
>>
>> Thanks a lot for doing a first pass on this series!
>>
>> On 6/17/25 06:35, Eric Auger wrote:
>>> Hi Gustavo,
>>>
>>> On 6/16/25 3:18 PM, Gustavo Romero wrote:
>>>> Since v2:
>>>> - Fixed no_tcg_its inverted logic (rth)
>>>>
>>>> Since v3:
>>>> - Fixed remappings in the IORT table when ITS is no present
>>>> - Rebased on master and resoled conflics, like no more "no_its"
>>>>     flag in VirtMachineClass
>>>> - Dropped patch 1/9 because we actually want the instance flags,
>>>>     not only the class flags, and the instance flags are the ones
>>>>     to be used often when deciding about the presence/absence of a
>>>>     machine feature, instead of the negated class flags ("no_*")
>>>> - Adapted the other patches that depended on 1/9
>>>> - Dropped patch 4/9 in favor of using the instance flag for
>>>>     checking if ITS is on or off
>>>> - Simplified VM options for the new "its=off" test
>>>>
>>>> v1: https://lists.gnu.org/archive/html/qemu-devel/2025-03/msg07080.html
>>>> v2:
>>>> https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00495.html
>>>> (Patches 6/14 -> 14/14 in the series)
>>>> v3: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00567.html
>>>>
>>>> Fix ACPI tables for '-M its=off' CLI option and resolve the issue:
>>>>
>>>> https://gitlab.com/qemu-project/qemu/-/issues/2886
>>>
>>> One first comment is that this series will collide with Shameer's SMMU
>>> multi instance series which has been lunder review for quite some time
>>> (adding him in TO):
>>>
>>> I think it may be more future proof if you could rebase on it - I know
>>> it is a pain ;-( -. Or if sbdy objects for Shameer's series please raise
>>> your voice now.
>>>
>>> [PATCH v4 0/7] hw/arm/virt: Add support for user creatable SMMUv3
>>> device
>>> <https://lore.kernel.org/all/20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com/#r>
>>>
>>> https://lore.kernel.org/all/20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com/
>>>
>>
>> ayayay, life is never that easy! :)
>>
>> Thanks for point that out. Sure, I can rebase it on Shameer's series,
>> but also
>> I'd like to have this ITS fix for 10.1, so I think it's a matter of
>> understanding
>> if Shameer's series will make the 10.1 release (thanks for asking the
>> reviewers if they
>> have any current objection so we have an idea if it's close to get
>> accepted
>> or not)?
> Peter was the most annoyed by the usage of -device arm-smmuv3 option
> line. We'd better ask him.

I've talked to Peter via IRC and he said that since this is a fix it could
be merged first than Shameer's SMMU series.

In any case, I'm wondering if you could review v5 of this series, which I
published earlier today, specially patch 8/9 "Fix ACPI IORT and MADT tables
when its=off", since it's the main patch in the series and currently it has
no R-bs. I've addressed all your comments on v4.

Thanks a lot!


Cheers,
Gustavo

[v5] https://lists.nongnu.org/archive/html/qemu-devel/2025-06/msg03793.html

> On my end I don't see how we can achieve this more elegantly.
>>
>> Meanwhile, I'm pretty keen on if I'm correctly generating the IORT
>> table pruned from ITS
>> (patch 7/8 in this series), like, are the remappings for the RC and
>> SMMU nodes correct? That
>> would make me more comfortable to start working on a rebase.
> sure looking at it...
> 
> Eric
>>
>>
>>> Also I understood Shameer intended to write some new bios-tables-test.
>>
>> I see.
>>
>>
>> Cheers,
>> Gustavo
>>
> 


