Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94894E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkqk-00068B-WE; Thu, 12 Dec 2024 10:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkqj-00066U-OA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:11:33 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkqg-0003Ly-2N
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:11:31 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3eb40876bbfso134076b6e.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734016286; x=1734621086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=40Zo8V4LF1yIaYiA/NIJ/KoVW3/wpiJOBuOUU6k7hGo=;
 b=wT7h/R2UNycgfuA8BJtulu3jdZ3hvOC4z6xh5rEfApu2AVuUAMBC3yAxgD3IX7gKC1
 oErYxU0Lb+Jiz3/5O62dtgvmn1i/MnCOuHM2RDSEkdtk7tc1VmjTygvRnrsNrONxxQZ5
 OTkzDRhs6LKIm61lzNq469ze5uEWXzBi/iiqGd0SJECholEnbXh40iK0/Y8HuyrTWNRX
 loIQ3GHZVg07Yql9uXgN23byqUKI/8zniqWxvfazWxzrHIkFAop47BadIg08Q0OuEhZo
 8JNyEKMi5U/MdJRCy8NV0yNhq7cBVoQZqrRFve487iomQM6eNwAPPB4o3iL78CWulmPS
 PK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734016286; x=1734621086;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=40Zo8V4LF1yIaYiA/NIJ/KoVW3/wpiJOBuOUU6k7hGo=;
 b=eqeQMBsrXO2eJIv94EzJqVpiBGoumwh0e5hyDHluwIoaonN5x4BTjrLuxlFcojf7qP
 YmwjEk6oyRhcMHqpQEiYCEEGMMpI48oZjVqy7IHgfTr8eMWndJSnCbT/0xntnr1653+P
 UPxOUcPdMS5B/20Ty98ONJsvdGvWfrY069KieZg0Uno3IKafW5jc9y8peQELs6TsF/ML
 znXUoV6/RZqpkjoj7VVc0750JqsoTWKNgjL6UgRv26hRrZhRjDxpZJbuK0cm6PaHYrG6
 SaA5AcYc3h+IQ6nYlNADeLumhcVikN+89XmL9H0Pbzf/B7PSb9pFVMOMuD19PAmmzBz/
 JzdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYNhvEEIqy/vXGvqreHeilQb1VHhoIhOpvJM48/wMYQXfCKfBPyURjvEQvK81lBTZ5TVD6LOeb1puU@nongnu.org
X-Gm-Message-State: AOJu0YzmyFOZ9rcW2GgAURbMVqihuDUz98ewRS+i2gJ5MJ2PFquVqJss
 QKZMHleg0FdE8BKqNY8WgE1Ge7A15zjvc2jSfEQsCfH0LgBYPPJconCHZ7TwvikliLIdeuIp7d2
 dFwG5xXff
X-Gm-Gg: ASbGnctl/p9cUHI4rViaH7zOXyK1gIaI01oVZLjIW2wbzhTdbw9XKc93/YYucuqSMxE
 ObIIZ30dOzhA00msZLBw0n/wlZiTG/tNr0rgcMCKPDPTqnhHHW4i/2tEF9uWPvrsKC3uIQjtMgu
 m6Zy+tTK1PhnucOOOeTutztRm63g+I7SbyiYXkZ4t+mtShOGQa1T5Vn7AARH9crAlvsCmXtUFu7
 f+MXFF5APjtYada5+JvkKEsvQEgB20gguxHwR1/JqkHht1vW1WrwunShZwmRRXB4AMv/AHTlTYf
 zncE/OhSwk+H5Hbzki4jOVxIQow+62I+/ik=
X-Google-Smtp-Source: AGHT+IGA4dfoh7GYE7Db9oAloHanZTbdaBE9LcvSrfPWdPuz87hJM0bhJMOEyDoEd19YqHOp8PJokw==
X-Received: by 2002:a05:6808:2021:b0:3eb:4829:59e with SMTP id
 5614622812f47-3eb85aef4a3mr4515545b6e.6.1734016286601; 
 Thu, 12 Dec 2024 07:11:26 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb8ccd18d6sm650362b6e.37.2024.12.12.07.11.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:11:26 -0800 (PST)
Message-ID: <5e8c7bd6-4afa-45bd-af79-3e03b9e6075a@linaro.org>
Date: Thu, 12 Dec 2024 09:11:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qemu/atomic: Rename atomic128-cas.h headers using
 .h.inc suffix
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241212141018.59428-1-philmd@linaro.org>
 <20241212141018.59428-2-philmd@linaro.org>
 <ee831fff-eb0a-4e56-8eee-99222e55d707@linaro.org>
 <8c52c730-cc87-466f-b36e-270d738b86f1@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8c52c730-cc87-466f-b36e-270d738b86f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 12/12/24 09:09, Philippe Mathieu-Daudé wrote:
> On 12/12/24 16:02, Richard Henderson wrote:
>> On 12/12/24 08:10, Philippe Mathieu-Daudé wrote:
>>> Since commit 139c1837db ("meson: rename included C source files
>>> to .c.inc"), QEMU standard procedure for included C files is to
>>> use *.c.inc.
>>>
>>> Besides, since commit 6a0057aa22 ("docs/devel: make a statement
>>> about includes") this is documented in the Coding Style:
>>>
>>>    If you do use template header files they should be named with
>>>    the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
>>>    being included for expansion.
>>>
>>> Therefore rename 'atomic128-cas.h' as 'atomic128-cas.h.inc'.
>>
>> But these are not templates, nor included multiple times, so...
>> I don't get it.
> I wanted to avoid including "qemu/atomic.h" in each of them due to:
> 
>      host/include/generic/host/atomic128-cas.h:23:11: error: call to undeclared function 
> 'qatomic_cmpxchg__nocheck'; ISO C99 and later do not support implicit function 
> declarations [-Wimplicit-function-declaration]
>         23 |     r.i = qatomic_cmpxchg__nocheck(ptr_align, c.i, n.i);
>            |           ^
>      1 error generated.

And why would you ever have that?

r~

