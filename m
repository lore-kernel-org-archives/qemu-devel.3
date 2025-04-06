Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA04C36010
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 01:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1Erd-0001ih-Fn; Sat, 05 Apr 2025 21:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u1Erb-0001iE-BT
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 21:31:55 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u1ErZ-00013k-AK
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 21:31:55 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so2689452b3a.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 18:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743903111; x=1744507911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=ncP4P4HxOXmaECdoiUPLPzyrau/Ydkrd4Pdc4KA418s=;
 b=kEkqA1Pq2pdAA2Hfaf4i/VnlckNEjQk+238JmH/xTdx/MPiApt8nvH3bbSJjo9KnDt
 bEgKM2t/8VfJZw1/22759SVcElPDBGU+7SIwopiF1uc5U8EnDH39kW/yNiFpF9MvqWSA
 gQIJi9XSINSWe4Kl5eXniFYxGwU6GEdjr3l0Fl/NURzk/Nzholz8KdCVb+wiV9pXccP0
 /6BP7GXhRC+Q+ke0J0gmsp4sp2MH+wg7JWOe5Dnf+PnPuPPghvtQ0WL4zWv3pMIMGOO6
 hsWwvFgrknAJ3DQczVwio4wAW7Novc1TG8SZtGedq5U64LO2Jaeoxovj5qlCTrz2jZKj
 BkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743903111; x=1744507911;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncP4P4HxOXmaECdoiUPLPzyrau/Ydkrd4Pdc4KA418s=;
 b=eaYHmTjf7rp4afWvE9hDazPG9uFwbKKwJa1if7254XVnTx/2ppWtbfSv9Lj1ay6uGu
 Lx5dnRxUTylpMAGxaPyjpMIQ9A7NP2qd4Z0jH93x+TSZQHnMBV3xsbDOW79Eftil2hv5
 IhEnI6MPBy6iYmGaAEROqql1Yv4RLkLpwZat+wk4AGXpOxcG6fQF1QyQNBspR/eByswk
 g7ZIxxRDoSRvzPj2mLW83guJlCSKT5A3tEFVP2iOz4rW8zjrGjBRK906RxPW1Zz8Pf52
 C/oJQjk/7oEitxsGTBjn7diEeP6nEXRNYgKwqTC145fGqMTkPxISLXOgRauRUp9H4qBn
 pVtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPSNZ1N3L+caQLuzKidCqGAOYm9s7zLy7a55RKjt44LbqFd5Cx4mkfPeMFNUJ19lHAdovohWrKWXcG@nongnu.org
X-Gm-Message-State: AOJu0Yyz9qhyutsvvaC2XnPA88j7cjYLpYsMz3NzdvEpLod1R0Dgln7A
 tXO7mCcEZsILfDeOkebZ0gpZMmBKTKem2lDjKOnH6oov8TwtthzC
X-Gm-Gg: ASbGncsNKTq13mI2DhW1m9dEyXUvONTYH79MtZG8bKhycCrOTWtHPg0YCL+7L+C0Eaw
 pDmrIbS7wRjBcRZ5iQ8ggQTi0K1MNtOGJ+aBurlz9wzVcGdxw9/nHMk2pEKg6KXbM6r21ktkYRO
 MMBO42sQsqfNhKX8M1lIZeZhfph09hpVuDqU4fYmjKqmiCu64wn/9++5Vj+fLqHMIauItrJc/RZ
 6WUyPLxW04rJoQccRV65v82Wj2+qziCiI8YnXXJtbcs5LloWKKTLs1Wmipg7khU/wjxfDwGHJiX
 3rteDvgEfkxKnjqjwQZBkSPhQZLZYV1oh7TqrDklYWZh15sPSNCTqIJ/KtJW0lEjdCeZpeRfOXm
 tOBrBtahrmhu/YFqP+A==
X-Google-Smtp-Source: AGHT+IFYB82WZ7vmHbHnnCSYqZeqfUOrHrr6rikkuvgofsIY5aH4/H2/Ne39xytLW6zRlIKF4rii+A==
X-Received: by 2002:a05:6a20:9f49:b0:1f3:388b:3b4b with SMTP id
 adf61e73a8af0-20113c5aa33mr5763708637.15.1743903111373; 
 Sat, 05 Apr 2025 18:31:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d9e9dc9dsm6030745b3a.96.2025.04.05.18.31.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 18:31:50 -0700 (PDT)
Message-ID: <42a82455-7fa1-4890-a9e8-690fec3433c3@roeck-us.net>
Date: Sat, 5 Apr 2025 18:31:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add property to support writing ERSTBA in high-low
 order
To: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <ae8cd367-8580-4476-9a75-3fa4f7aa2536@linaro.org>
 <7ed5d213-9429-45c8-bbf3-6f3f841a2299@roeck-us.net>
 <7C5A41A1-38EE-4D22-8F84-6A5A3A2BDD82@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <7C5A41A1-38EE-4D22-8F84-6A5A3A2BDD82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42d.google.com
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

On 4/5/25 12:28, Bernhard Beschow wrote:
> 
> 
> Am 5. April 2025 17:26:14 UTC schrieb Guenter Roeck <linux@roeck-us.net>:
>> On 4/5/25 07:25, Philippe Mathieu-Daudé wrote:
>>> Hi Guenter,
>>>
>>> On 5/4/25 16:00, Guenter Roeck wrote:
>>>> This series is needed to support the USB interface on imx8mp-evk when
>>>> booting the Linux kernel.
>>>>
>>>> According to the XHCI specification, ERSTBA should be written in Low-High
>>>> order. The Linux kernel writes the high word first. This results in an
>>>> initialization failure.
>>>>
>>>> The following information is found in the Linux kernel commit log.
>>>>
>>>> [Synopsys]- The host controller was design to support ERST setting
>>>> during the RUN state. But since there is a limitation in controller
>>>> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
>>>> It is supported when the ERSTBA is programmed in 64bit,
>>>> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
>>>>
>>>> [Synopsys]- The internal initialization of event ring fetches
>>>> the "Event Ring Segment Table Entry" based on the indication of
>>>> ERSTBA_LO written.
>>>>
>>>> Add property to support writing the high word first. Enable it
>>>> for dwc3.
>>>>
>>>> ----------------------------------------------------------------
>>>> Guenter Roeck (2):
>>>>         hw: usb: xhci: Add property to support writing ERSTBA in high-low order
>>>>         hw/usb/hcd-dwc3: Set erstba-hi-lo property
>>>
>>> What about using .impl.min_access_size = 8 instead?
>>>
>>> Could you try this patch, or provide me with a reproducer?
>>>
>>
>> You should find everything you need to reproduce the problem at
> 
> Hi Guenter,
> 
> thanks for testing the new board, much appreciated.
> 

In this context: Did you get the PCIe interface to work ?
It instantiates for me, but interrupts don't get through.
This is with the latest Linux kernel.

Thanks,
Guenter


