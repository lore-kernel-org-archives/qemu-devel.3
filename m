Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F489FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITOL-0003I7-RF; Thu, 30 Apr 2026 11:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wITO2-0003FO-8T
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:33:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wITNz-0000Ew-F2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:33:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so9291745e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777563185; x=1778167985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IHWBCTfoJ1M/5sEqnEBeY+jsak3fzq9brJEAJrKYDiE=;
 b=oQNklRwUSSpFkKmM/frcem1am/rYyJY1tNfDOQCjCY0BALx16H/9qNKSMyRNVHBxpw
 Y4KYJP767XUxewcB7wIfJnYPiv4xqO97UgXQqaTJFMUAOQ22VriSsVCSXHiLpyY1UxRf
 coZKOzPO803CteHQcFXCL9g27hW4hWsvs7Qm2Do++PvVkK2j8xxhLjfgnEJu9BV7wNNd
 ksfoOikUpI7fZW6ylnPtuDNkRJvgCllx0xz9ZYgXN8aABk2BKjstvxp6HqJzONl7sP8s
 k9kkIPtmaOIFfS92pVG67wDMuv3o0moFIkoVDwtIZZEXlwzAxflmNqBQRQ2nypr980L0
 6gCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777563185; x=1778167985;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IHWBCTfoJ1M/5sEqnEBeY+jsak3fzq9brJEAJrKYDiE=;
 b=NvkHD4wzYLikV5JMRsL2c9Ibw1LebbqhNhwuDofPhJl1E2pELpejVfSAUzlbFFe3WR
 8p6vPmA68bowNbrJwAOpz23ZfznGRL7p3x5qP0R9UdBhtzkelwRUUtWM3JVSVwQ4Geuv
 gtzTf8x4NcFCMiisyBBmKRk9e2hNOWSDFdB6Dgj0T0V9kUgfCXG/1Cybcjv91Jb3XJ1i
 wh1nCQNftZY662BUsI+PGLC30JR2hXIbln87R3pWpohRDJpkRbg8oXKFXSjDWjOgq+81
 +jJ6s9e0PlpbdPRJWpB2sAkVTIMrYkbju943f3f0gnL+nMmlrymMqYFIZKWBlp9oI2YU
 rgFw==
X-Gm-Message-State: AOJu0YxW6uuA1n5ow9v/TwTBZ/+EHJPuKJZ9Z4xm2IFitDLJVJwRcdwB
 zuNfI8OgzHgISp8nDYJ5zvSPN3iUI6vgLFzAB+dGGyB+EwR+KOP1OajzK2z/6gcZ07A=
X-Gm-Gg: AeBDiev91tXEDoZ/peSvZ1sMEMx810Bpg0Q72A+495ryTcH/sfPMhoRY6arKlY8RduP
 FvtR6cm0eSSAkhym4Uw+p4qL7wjGK2Dt8j3OUKRAO59GYYW1vjypmaqMUEbV95l8FWK4SxEvaQv
 MvOjgwIPcVYCJhnbkJrXD4dhkKUEJpP0hixpG+WT1wPUAqUAly5cefHNPw2XIHAJW/1IMOBbF96
 PgpOq2HVz/QZugMQsXHlEWYUVLbXVIymNvBVzylqUdjNMwccooWae8oz0pJQtyNUmvA/goy572K
 vRY3QnliBm0r7pHXl4inlz8wE6TBRmZlat24V1uZMYpf9viw04ocfjEJaZl8e6QiCIrF4avMb8M
 PGCRCzA6Xnu2KYFaQVJEPHJoOJbiBdQwHujFvPmAP0t/Zra0Yc4bNuX7tLoYZM9oxmcC4Hklg7G
 YlXJBogJsHsn5XKBQrQ7HY4HGowypZ8c02LgmUpmE8WQmMwMTeW2VqwcWE99BWcnhYlIxNQU6iy
 29n
X-Received: by 2002:a05:600c:8901:b0:48a:7a10:4f47 with SMTP id
 5b1f17b1804b1-48a83d6e15fmr44463495e9.3.1777563185435; 
 Thu, 30 Apr 2026 08:33:05 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b912869sm46093055e9.6.2026.04.30.08.33.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 08:33:04 -0700 (PDT)
Message-ID: <7dcb7527-6e30-4b9c-bd73-b62d85d66488@linaro.org>
Date: Thu, 30 Apr 2026 17:33:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/npcm7xx_fiu: Specify .impl for
 npcm7xx_fiu_flash_ops
To: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
References: <20260428093339.2087081-1-peter.maydell@linaro.org>
 <20260428093339.2087081-3-peter.maydell@linaro.org>
 <22ce7f65-39ee-45cb-a021-ac275d036f38@linaro.org>
 <CAFEAcA8SpD+X0kLg-6kQ+TR2VSJqhtMpzQrfsOqEZE_EzfkW3Q@mail.gmail.com>
 <afNyLaTjM2uz_wX8@x1.local>
 <CAFEAcA8V0p4TqLFhhh8Aokw2g=vqKkU4wc-kDnKSG1ceG-bqNA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8V0p4TqLFhhh8Aokw2g=vqKkU4wc-kDnKSG1ceG-bqNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 30/4/26 17:19, Peter Maydell wrote:
> On Thu, 30 Apr 2026 at 16:16, Peter Xu <peterx@redhat.com> wrote:
>>
>> On Wed, Apr 29, 2026 at 01:26:36PM +0100, Peter Maydell wrote:
>>> On Wed, 29 Apr 2026 at 08:38, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>
>>>> On 28/4/26 11:33, Peter Maydell wrote:
>>>>> Currently npcm7xx_fiu_flash_ops provides no .impl substruct; this
>>>>> means that it gets the default of "implements 1, 2 and 4 byte aligned
>>>>> accesses".  This is more constrained than the device permits in its
>>>>> .valid substruct, and also narrower than the functions are written to
>>>>> handle.
>>>>>
>>>>> Add a .impl substruct matching the .valid substruct; this means that
>>>>> all guest accesses are handled directly by the read and write
>>>>> functions, and are never synthesized by the memory subsystem
>>>>> performing multiple accesses to the device (which would not behave
>>>>> correctly, as these read and write fucntions have side effects).
>>>>
>>>> Typo "functions".
>>>>
>>>>>
>>>>> Based-on-a-patch-by: CJ Chen <cjchen@igel.co.jp>
>>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>>> ---
>>>>>    hw/ssi/npcm7xx_fiu.c | 5 +++++
>>>>>    1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
>>>>> index 02707de350..2d5bed005a 100644
>>>>> --- a/hw/ssi/npcm7xx_fiu.c
>>>>> +++ b/hw/ssi/npcm7xx_fiu.c
>>>>> @@ -250,6 +250,11 @@ static const MemoryRegionOps npcm7xx_fiu_flash_ops = {
>>>>>        .read = npcm7xx_fiu_flash_read,
>>>>>        .write = npcm7xx_fiu_flash_write,
>>>>>        .endianness = DEVICE_LITTLE_ENDIAN,
>>>>> +    .impl = {
>>>>> +        .min_access_size = 1,
>>>>> +        .max_access_size = 8,
>>>>
>>>> IMO this device should be adapted to have byte granularity ops handlers,
>>>> thus .max_access_size = 1.
>>>
>>> Looking at the implementation that doesn't look like it
>>> would be possible. The implementation does operations
>>> to start an SSI transfer, then transfers the number
>>> of bytes written. That makes "guest does an 8 byte
>>> write" different from "guest does 8 separate byte writes",
>>> and so the read/write fns need to really handle all
>>> the possible access sizes.
>>
>> I tend to agree.
>>
>> AFAIU, a split could cause non-atomic issues (even I'm not sure if there's
>> any need of it in reality..). Since the use of deposit64/extract64 should
>> mean they're ready for 8B accesses, then it sounds wise to support 8B.
> 
> My guess from the fact this device previously didn't set .impl
> at all is that the author didn't realize (and we didn't catch
> in code review) that to define an MR that accepts the full
> range of widths and alignment you need to specify both .impl
> and .valid, and then they didn't notice it in testing because
> it works for 1..4 byte widths. Adding the .impl matching the
> existing .valid is I think changing the code to match the
> author intention.

Yeah simple gut feeling this ought to be modelled 8-bit only with a
state machine, but I haven't looked at the datasheet and it works so
I won't insist.

Still, accepting more than 32-bit is dubious IMO. But that is for
another patch.

