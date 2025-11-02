Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDBDCCF9E3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 22:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFgzX-0006Hy-OP; Sun, 02 Nov 2025 17:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1vFgzM-0006Hc-Gj
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 17:55:57 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1vFgzH-0002FE-MH
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 17:55:54 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7a9c64dfa8aso672008b3a.3
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 14:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762124149; x=1762728949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=ZClu4PJ8WFSuL/Z/8t7wWNm3KebCpCVU7T2O7POP7fQ=;
 b=GDWJ48KtnFZwneSLBPjTi7K+/4l9M5QgLbZkzbi3D/lQughlN84ZQuPOi3HvHrGCNi
 0xwqVFcj2Cr+WwnX7KZULiArLsMHxmLHXxJS5DfdmAikQ/5bGWuZV+eulo9uF7GelZCN
 vKos3AyTxlQbpZ1S2ruEn/4xnD618e8yhnThpgi/pFy5o2WA49zcjWAcCOg4KAu/t+2U
 tjCYMIPLdTEE9No2XmMbCQxtL6Mfd3VX4G1MeolMN6Ju7+jfxfQSVtGzHG+pPazDvGeR
 tbsXb1bThZc4ll0SDlL7be5qK+MHeXoTE+73GksI2cadW0mBMPtgl7Ewc2I4Hh/jRE8t
 9JEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762124149; x=1762728949;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZClu4PJ8WFSuL/Z/8t7wWNm3KebCpCVU7T2O7POP7fQ=;
 b=F/PkKvhQju7+m6yxMzaN5aNXQCs3adh+f9ao6Q6Ta2L/3M6ZlfxJJs4YgMDdQMytcF
 6mZkbjtZT0rwqCFCQhWfJBQAb+cNgEwuSXfiAP5weMLK4w6ryptUkZbKPsg5X5Z6F1TD
 m+KB50I0cpMw0F1OuoPBNTXbPRpzAflpkW4g0ARgiSjDHM745U2zQAI/CLw0ofT4plAU
 sS10Vq6xFWLWNPLkj2IXA4gPJfvM3kiRNYYeuZL7mrbpTEVqsWRixnZ+HVIYhUjJLf2O
 XGsSYoMUcNb5u5xp6Tfpcwtn8KxIsXUl0g2wqi+GMWekf/OuQSvxZs1b8jU/0Tsw9z6x
 TRQA==
X-Gm-Message-State: AOJu0YzBphn79gfTnst8oGFZmkbCsqCY4hvfZPwBZeM4TrXA3orSdvrY
 5xMPSbtoeIciCYsIFvME9QxWpCoK+nDcrcoHIl0N4dycvIZddgHy5Rdj
X-Gm-Gg: ASbGncs2e5gMJbUTzQrlH2FknOn/vqtEuKFao4aUxFwXVhL1kscPVbeJ4d9I0A33iCq
 EDj/WnW6WHaWPm8imxiHzuXPyOOmFZrW6zp9D/nYlyR9mjoHwY+Rk8ftXM7BA5q/tR12pOjBMlv
 Ir7w0GDAHZ2QsCz8DFy4m914Qo+ymBK2BcXYMOfgm7i0V6Gk3gXcikUr2SN5fyly2nekBh3Q0aV
 m/azgLMgK+1PrhZ/+T7VjwgK4ZZmdhYUpdOg9GhQEWZVSXqgnCJ92/YbZqGbTTTcITf1FLSqDEi
 o8cHcD5/Lhh6ghsaptEO0b25zSt+YLnGvNf4lW/i34sutH8WNIE0elKMUxaIjoPiT0D7h/rckPQ
 ebndb+rPSAPt0aBOpxwC7lC+sINJQDJsRgzYiMoqj0LLlqwl1U5F4DLVkUpd3tpDqYB7oX+z14l
 FVyD0zg0o7M1bBqCvvWKDeHWPdhDL0i9ZhTXzOFAZuqxiZJKM4
X-Google-Smtp-Source: AGHT+IHGMeUobNZove8kEgJT05tAPOCL4XeFQw/1cJHq7lvi4/J0TYwzfTfFEZfKG4Qdtrt4l42clA==
X-Received: by 2002:a05:6a00:14cb:b0:7a4:f552:b522 with SMTP id
 d2e1a72fcca58-7a7790dae8emr12936462b3a.27.1762124149499; 
 Sun, 02 Nov 2025 14:55:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ab5ee9fde6sm690127b3a.45.2025.11.02.14.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Nov 2025 14:55:48 -0800 (PST)
Message-ID: <1ea81494-e256-4394-80ab-1bc12db79ae9@roeck-us.net>
Date: Sun, 2 Nov 2025 14:55:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/hppa: Enable LASI i82596 network on 715 machine
To: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk,
 Jason Wang <jasowang@redhat.com>, sarkarsoumyajyoti23@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251101125726.45912-1-soumyajyotisarkar23@gmail.com>
 <07200388-ae9b-4021-afb6-5fd93584d39a@roeck-us.net>
 <5b672b32-cc09-4e9e-8961-efe362991a87@gmx.de>
 <eed77eb0-175d-4853-81ad-4a5a7390f96c@roeck-us.net>
 <a96408bc-bb1f-4792-b3b0-b15ff86ef070@gmx.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <a96408bc-bb1f-4792-b3b0-b15ff86ef070@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/2/25 14:33, Helge Deller wrote:
> On 11/2/25 23:27, Guenter Roeck wrote:
>> On 11/2/25 14:11, Helge Deller wrote:
>>> Hi Guenter,
>>>
>>> On 11/2/25 18:31, Guenter Roeck wrote:
>>>> On Sat, Nov 01, 2025 at 06:27:25PM +0530, Soumyajyotii Ssarkar wrote:
>>>>> From: RemZapCypher <soumyajyotisarkar23@gmail.com>
>>>>>
>>>>> Enable the i82596 network chip which is included in the LASI
>>>>> multi I/O chip. Since LASI has different start addresses on
>>>>> the various machines, always initialize the LASI components
>>>>> by their offsets.
>>>>>
>>>>> As suggested by Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>> Changes since v1:
>>>>> Added proper Qemu device initialization for LASI
>>>>>
>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>
>>>> Signed-off-by: is missing. Other than that,
>>>>
>>>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>> Thank you so much for testing the series!
>>>
>>>> Only on 715, though. The LASI Ethernet interface on B160L no longer
>>>> instantiates for me after the SeaBIOS update to version 19.
>>> Have you actually used LASI Ethernet with B160L, or just enabled it?
>>
>> I do basic testing - instantiate and get an IP address. That works
>> (or, rather, used to work in 10.1) just as good as the 715 emulation,
>> meaning it gets an IP address and then complains about
>>
>> Received frame too small, 60 vs. 64 bytes
>> qemu-system-hppa: Slirp: Failed to send packet, ret: -1
>>
>> I fix this up locally with
>>
>> diff --git a/hw/net/i82596.c b/hw/net/i82596.c
>> index c1ff3e6c56..26224645fc 100644
>> --- a/hw/net/i82596.c
>> +++ b/hw/net/i82596.c
>> @@ -522,7 +522,8 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
>>       }
>>
>>       /* Received frame smaller than configured "min frame len"? */
>> -    if (sz < s->config[10]) {
>> +    /* Note: Add CRC to packet size */
>> +    if (sz + 4 < s->config[10]) {
>>           printf("Received frame too small, %zu vs. %u bytes\n",
>>                  sz, s->config[10]);
>>           return -1;
>>
>> With that, my basic LASI network interface test on B160L works with qemu 10.1.
> 
> Ok, but that means you are basically the only one using it, and
> this just because you "fixed" the source code :-)
> I assume it's OK for you to wait until we activate LASIC NIC on
> B160L in a later version?
> Until then I suggest you stay with the default & out-of-box working tulip card?
> 

Sure, NP.

Thanks,
Guenter


