Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B15C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 07:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR3qO-0008Pr-Kd; Mon, 16 Jun 2025 03:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR3p4-0007tu-6C
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 03:00:02 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR3p1-0007du-O5
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 03:00:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so2301744f8f.0
 for <qemu-devel@nongnu.org>; Sun, 15 Jun 2025 23:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750057198; x=1750661998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4s3DbBDAd51zuhWyOoGPamcx1FvMG27o9sDs/2K5+Vs=;
 b=s7FvJCEzPgnEWl6rEtQ62kkEiISlJyPgUkdYKsbMr69yKYRygL9gRU/RXgOQmNYkv9
 fnf4tbDunixo3PNAG1bRCZsbHhmUj9wHay07HlI6Ze23BNYN4dcoQXy9fmsgPpYZQtzY
 84iKWV1qiwsDzJZoQbvZG+ONW4TiyupxphKyXykrRxT+UCZOn48R/uxuxx6JFKvJ4M5s
 KYC7X7TLn+LdFQFn4V1SX8jDko4dVO6ZFv7Zfmn/340uI5xieFNHCi9Hm5PfvhSw1onE
 awABLk+JTCrtpxxo8facgVWs5ObtUnHVDKG6HwGloFn6BkVASgAr92BUSGLLDrZ/+KEL
 ZLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750057198; x=1750661998;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4s3DbBDAd51zuhWyOoGPamcx1FvMG27o9sDs/2K5+Vs=;
 b=MUKQhiAil4te/AQ7q9ULp+3hIwpQlyQYn2XO384J27OIIcKmV1Q+sfZR6+Z/KOdNdl
 A/qIkdsg57mYKI3qznhMsR6Dgux1kCZ4RFTNtPPU5wfasgPgMHcjksc8Qa+fffgQ6clH
 XYyWSwPJ4yfCtZXU465Z/+lisG6XKVZSkLjodUDe3isMOPpktpoZ46ydYXdduEfC29mk
 fqE7nfyg/Jc4HrmI2ZIPJ7rdF2/AIMl/U4PmhpsZAitmA+YU1WL2LjcipFadWA7ZWl1c
 JeE0ixXO6liQVk7HrBAhvc9SNTWNLnng/1DTdkH2xIftU39Nc4EdOcHOw36MiowzjXgi
 q/2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6rOZss7qwzOw6VivJ/d5xXC3uaI25G0r+qQFocsVMMdMDzBrBywancIoTlPLsNRzOn8qWN6ZVfkMQ@nongnu.org
X-Gm-Message-State: AOJu0YzTyMUH6rLE5oJxA9MUBQ4ITEWpAn2Fh7lF2h/1iIbR+LEXFhJ7
 N90HaGIQmRLpJkKvosjURUKcyYiKh5MC2WTGqxpWeCs5ZPoP75jASO4MziVXDIkHcqw=
X-Gm-Gg: ASbGnctRVSK6oyy/SirFVIPgN6jaSHTPDTj/woyIIAD/xj3uJIUsbGBH18naOmHf6J/
 f2zfhH8jFDEaPH86aGiuACappx7oxicDXZIFVs9CxIpi/0npHTJ7Gnjj+fv8sSBj91RsJn4NvIF
 u/2XKGxJpsAe2I023yznxISYu9w/ittEAOVy2xBj7zY4MTbdwix4WPIJ7Umhg3VHAL8VDlBXvtp
 YImpV4oZuHAtIYTjxLOh5L+IVwcTA2VHgwTjAiJZkMEc3riiAu6WYwy4J/IcFFY0yTJmxSob2LU
 suvml+r60CFtP4+jg8mMSMTKN6JJ73xGcceqEgrh7KpAqhifIFPCGs48S8UhgWeJhXxtZ8kpkSD
 62xd9PydRWxxJWPRHODILfUyjp7k4Ew==
X-Google-Smtp-Source: AGHT+IFDUUtUum/+HBTDrKXa01+LJ+72wZVux7YpPuxfZRGe7/KurMNCq9z7FWuSo6fC8GiWv9UXFQ==
X-Received: by 2002:a05:6000:25ca:b0:3a4:ce5c:5e8d with SMTP id
 ffacd0b85a97d-3a56d83454bmr8556200f8f.20.1750057198051; 
 Sun, 15 Jun 2025 23:59:58 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e232e4asm133225565e9.11.2025.06.15.23.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Jun 2025 23:59:57 -0700 (PDT)
Message-ID: <eba82f72-fd87-4f47-b5a9-86dbccb6b90a@linaro.org>
Date: Mon, 16 Jun 2025 08:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] amd_iommu: Fixes to align with AMDVi specification
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Ethan MILON <ethan.milon@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20250529193023.3590780-1-alejandro.j.jimenez@oracle.com>
 <af1423ff-24ad-4a4c-8a42-eec5fe77a66c@eviden.com>
 <ca5c935f-adc7-4d9d-930b-b8a4e71003ab@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ca5c935f-adc7-4d9d-930b-b8a4e71003ab@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Hi Alejandro,

On 12/6/25 22:59, Alejandro Jimenez wrote:
> Hi Ethan,
> 
> On 6/12/25 4:36 AM, Ethan MILON wrote:
>> Hi,
>>
>> Is this series the right place to include the following minor fix?
>>
> 
> I would defer this change for two reasons:
> 
> 1) This series has been reviewed and tested already. I was hoping it 
> would be included on the Jun 1st pull but I sent v3 too late for that. I 
> think it is ready so I would like to leave it as is unless there are any 
> objections ...
> 
> 
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 0775c..18d30e1 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -140,7 +140,7 @@ static void amdvi_writeq(AMDVIState *s, hwaddr addr,
>> uint64_t val)
>>   {
>>       uint64_t romask = ldq_le_p(&s->romask[addr]);
>>       uint64_t w1cmask = ldq_le_p(&s->w1cmask[addr]);
>> -    uint32_t oldval = ldq_le_p(&s->mmior[addr]);
>> +    uint64_t oldval = ldq_le_p(&s->mmior[addr]);
>>       stq_le_p(&s->mmior[addr],
>>               ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
>>   }
>>
>> This corrects the type of oldval to match the return type of ldq_le_p().
>>
> 
> 2) This fix is needed, but it is likely better as part of additional 
> changes that are needed to cleanup/fix the XTSup support. i.e. there are 
> unhandled writes to the 0x170, 0x178, and 0x180 MMIO offsets, and those 
> depend on MMIO 0x18[IntCapXTEn]=1. I think the truncation of oldval that 
> you found is causing XTEn and IntCapXTEn bits on the control registers 
> to be ignored, but ultimately things are not broken enough (yet).

I agree with Ethan it is better to avoid hidden truncation, because it
just makes debugging experience harder.

If this is the expected behavior, better add a comment, or use
extract64() which makes the truncation explicit.

Regards,

Phil.

> In 
> other words, I think there is a lot more work to do in here, and it is 
> something I am looking into.
> 
> I suspect Vasant might have spotted this problem already, so he might 
> even have some fixes queued up...
> 
> That being said, if you want to send a patch with your S-b I'll add it 
> to this series.
> 
> Alejandro
> 
>> Thanks,
>> Ethan
>>
>> On 5/29/25 9:30 PM, Alejandro Jimenez wrote:
>>> Caution: External email. Do not open attachments or click links, 
>>> unless this email comes from a known sender and you know the content 
>>> is safe.
>>>
>>>
>>> The main reason for sending this new revision so soon is that v2 
>>> included a
>>> duplicated [PATCH 5/7]. I fixed a typo in the commit subject and missed
>>> removing the old patch. Apologies for the mistake.
>>>
>>> Additional changes in v3:
>>> - Fixed typo on [PATCH 1/7] subject line (s/Miscellanous/ 
>>> Miscellaneous/).
>>> - Added 'Fixes:' tag to [PATCH 5/7].
>>> - Added Vasant's R-b to patches 4,5,7.
>>>
>>> Thank you,
>>> Alejandro
>>>
>>> v2:
>>> https://lore.kernel.org/qemu-devel/20250528221725.3554040-1- 
>>> alejandro.j.jimenez@oracle.com/
>>>
>>> v1:
>>> https://lore.kernel.org/all/20250311152446.45086-1- 
>>> alejandro.j.jimenez@oracle.com/
>>>
>>>
>>> Alejandro Jimenez (7):
>>>    amd_iommu: Fix Miscellaneous Information Register 0 offsets
>>>    amd_iommu: Fix Device ID decoding for INVALIDATE_IOTLB_PAGES command
>>>    amd_iommu: Update bitmasks representing DTE reserved fields
>>>    amd_iommu: Fix masks for various IOMMU MMIO Registers
>>>    amd_iommu: Fix mask to retrieve Interrupt Table Root Pointer from DTE
>>>    amd_iommu: Fix the calculation for Device Table size
>>>    amd_iommu: Remove duplicated definitions
>>>
>>>   hw/i386/amd_iommu.c | 15 ++++++------
>>>   hw/i386/amd_iommu.h | 59 ++++++++++++++++++++++-----------------------
>>>   2 files changed, 37 insertions(+), 37 deletions(-)
>>>
>>>
>>> base-commit: 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e
>>> -- 
>>> 2.43.5
>>>
>>>
> 
> 


