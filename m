Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB1BC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27l-0002qQ-NK; Tue, 10 Jun 2025 12:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1uP0Ir-00054R-AQ; Tue, 10 Jun 2025 10:50:17 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1uP0Io-00080Q-UO; Tue, 10 Jun 2025 10:50:17 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3138d31e40aso1999916a91.1; 
 Tue, 10 Jun 2025 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749567012; x=1750171812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=Cart6UfqDj9LT/UlAicnGPC14gwi5qD74eD6K86z9MM=;
 b=Y8xJ8V0o4RZ0qrrGZ4/XVwJep4g+4cFVrVRSIlXwB73LTY7euGcx+y48Ci0hp2Ba1p
 oP99L9GQh+NskklZn8WqquaPMlbGtJ5aLmHjv8hiNea+eWEZBo6hs2oENz/1SMTe/5YJ
 ekRfpi+P1yfxOLGQmt5myE6/ST/BtRYkoTNhzkgSsHdPhglFeikebDx1u9TGe/Zhn1NQ
 8Rf2IaSzxeZk4V59j4yyASNQeat104zyKXQN+SgXJOoPtx07V+6kGP5+PC/FLJ3siQ/Y
 rR0GctMHHd/OdQI52Xozf6KiGruY6R1bAIYKVEb4Qx8dKmRl9iWfuwvllJv17AGEggI/
 PbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749567012; x=1750171812;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cart6UfqDj9LT/UlAicnGPC14gwi5qD74eD6K86z9MM=;
 b=hSN9+DwmieXH2FoPcYhW35xyVPntf7JPx76VHhe++8Rq+J7uilmTmnefYqJfk/LzMT
 slthO7PSB5XRtKpNaQ+qokzewXunI2aXyWrO6sXEISXYx5pr29OKQARDfNJQeOldzsCq
 Z/CRTQt0OiYiSgKqpuf4TV9BxGiz8xkLHa+jlPfnnCwZXqBY2YWXRvT+CI5s1JZIp7dd
 1VhYgX7mwUbCtNnaOmmH3lBmOj1h9Us7wW2fnFtoh2/jMTMIpMIpe19ULgwHDxZuOAC2
 zXOpruAfcVqPgK7xz0se/D92XwOazPQFupeStEMDpULmHvvx25LlhDH2yBuDIzVqf/FI
 x9sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa8XQUswivAGygyct5pOKgOztZI9z+PXRb2fCbqTvg3bLpQJiG5BCtJnTiawiaPUdDkBnechaFXw==@nongnu.org,
 AJvYcCVVwTZaZEyg02tVdP5LGDTTI0IEnixOZjAwdsIjGkhGdd6b7p1J69xEr61TX2Z9KK6G460WP45zLBnfVw==@nongnu.org
X-Gm-Message-State: AOJu0YymZMcdEANWkFQEtJRkyvdH+cl1Ok/YWtOthqUrqlYJGvdtypW4
 M7akHoAOZ9NZitvZGtMReZG6gTOZtpE19PaExkjsGVWHJQYpbJWmgkw7
X-Gm-Gg: ASbGncsVAH991nnFpVp5reuFTWPL/obAt3qxDsJ7pnYcWaAnI0aZCwGVSTSdgtsTp8g
 Uwjih76zTPxQ2zQ1eqcU4KFwMhlP2E9ZwxwqWl0pcVjKwpbK4m3JUCyyErgYktew+i7215OjrsY
 JWZNA6npfalIrN5U5O4bei+RDH9F4yLaVyuv0NLXwF0QEGUn3wj7h2NDL6lswGUJKtA45Gx0OLP
 YRjR7gBcgaC/ShIb2/rXBNin+fajlsHWnCqzuC77UFwDsKjSWvcEuF5GALZwOuxE9GESBjZzyaF
 jqFpz9ygD41sHEHoDUw+d0WJ58LWUE8tXk9RFezEemtKQ/luPLBuY6VDz1yj1s+dnHGX5QH+aY3
 oYEm2oQRCsE+XgrUUY5Lwlkd0Z29zxnrjsLw=
X-Google-Smtp-Source: AGHT+IEqga3bND3YF4brMGPiwKCmNou27huTqidwK9PTWxMFvNAta6OXqaMFlEPz9zzQjH/fmjAKXQ==
X-Received: by 2002:a17:90b:540f:b0:312:e731:5a66 with SMTP id
 98e67ed59e1d1-313472d087amr23379561a91.3.1749567012521; 
 Tue, 10 Jun 2025 07:50:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-313a688b304sm247140a91.1.2025.06.10.07.50.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 07:50:11 -0700 (PDT)
Message-ID: <538d51fd-29f9-4d4c-a23c-678434743f77@roeck-us.net>
Date: Tue, 10 Jun 2025 07:50:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/npcm7xx_boards: Add support for specifying SPI
 flash model
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250610012851.1627715-1-linux@roeck-us.net>
 <CAFEAcA-aznHrcSk9xfmLHkpJTiabjd4oX2KnvC5TXkkLgW6n8A@mail.gmail.com>
 <50464a50-1ddc-410b-bc5b-ec68b895b797@roeck-us.net>
 <CAFEAcA9CWeEmrZ5vTr7M-UZfH3cp5Y9EZUeGPfc2s75Tz2-K9g@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAFEAcA9CWeEmrZ5vTr7M-UZfH3cp5Y9EZUeGPfc2s75Tz2-K9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.065, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 6/10/25 06:58, Peter Maydell wrote:
> On Tue, 10 Jun 2025 at 14:31, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 6/10/25 01:42, Peter Maydell wrote:
>>> I think the question I would have here is "is this the flash
>>> device the hardware actually has?". If QEMU's using the wrong
>>> flash type, we should fix that. If QEMU's modelling the right
>>> flash type and the kernel doesn't implement it, then that's
>>> a kernel bug and the right fix is to get the kernel to
>>> handle that flash type.
>>>
>>
>> That isn't the point.
> 
> It is the point from my perspective. This board type is
> supposed to be modelling real hardware, and therefore in
> determining how it should behave we start by saying "so
> what does the real hardware do?". Adding extra behaviour
> that the real hardware does not have is something that
> has a tendency to lead into unspecified, untested and hard
> to maintain complexity.
> 

Depends. I would argue that the ability to easily test all
supported flash types makes the code more robust, not less robust.

>> Yes, one is that qemu's emulation is broken, the other is
>> that I wanted to be able to test with other flash types anyway. I understand
>> that this 'violates' the idea of exactly emulating some hardware, but I want
>> to be able to use qemu beyond that.
> 
> Why this machine type in particular, though? You say in the commit
> message that aspeed lets you specify the flash type.
> 

Yes, the aspeed emulations let me provide spi-model= and fmc-model=
board parameters which I use to work around the problem there. That is why
I thought a similar solution might be acceptable for Nuvoton boards,
but apparently I was wrong.

>> Either case, I did some debugging: For flashes with sfdp data (mx25l25635e),
>> qemu returns bad sfdp data (at least with quanta-gsj), causing the kernel
>> (as of v6.16-rc1) to bail out. For other flashes (mx66u51235f) it returns
>> no sfdp data, but the upstream kernel now depends on it.
> 
> That sounds like a bug we should fix. Would one of the Nuvoton
> maintainers like to take a look?
> 

I don't think it is a Nuvoton specific problem. I see the same or similar
problems with Aspeed boards. Besides, the lack of sfdp data for mx66u51235f
is most definitely not Nuvoton specific.

Thanks,
Guenter


