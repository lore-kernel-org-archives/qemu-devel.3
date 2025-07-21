Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90F7C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 17:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uduHM-0007Au-9w; Mon, 21 Jul 2025 13:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uduGd-0006Y7-HA
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 13:25:53 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uduGZ-0001om-Cr
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 13:25:35 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-74b27c1481bso2855892b3a.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753118729; x=1753723529; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7fSkUaiuzjNlJ3L/Lf2+2fcQJIdr2OqK0OJfOrwSvIM=;
 b=mC6OVaUoy9sQw5IICDwcryHR0H9vGMYq3yuUYFeymjtWnT/2sND1j0KXtLUrFQXJS7
 f6zVn8+au4kYrPBSTOlRdrRByHU6lmZ8beu6gyysDcvsxpG/NqabZ0cA+xCJejTIe5Jp
 fDtlWZ2PEJVWM44QUu8fGef+KSUo0wE3vQOhZwis3cz7wEmNjPerIH38lwAYiRqNutrO
 F/Q8GmxJE29GCr6QXiKeqZBUIDq40B/ZLd+kMkCtlCYTBi9+USLS8XTgLMnRpblcMKsH
 8+ElEWvYWhiqeBTNMS4s8ZLwhDNE+XiKpCGjO7H/7vwu9Ssi1oV9agEhNNtEAPtzVR7S
 xmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753118729; x=1753723529;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7fSkUaiuzjNlJ3L/Lf2+2fcQJIdr2OqK0OJfOrwSvIM=;
 b=XHpxvGJk+P6DNAJqhBCzi1yJRzCJ5G8GW4lkDBKgdplP+Kkbnm9vsNZzkULkdqAtbL
 Bj81GtoajzPx7BGxRokoP/VlkJr3IihLeGkya0hNkXlEGkN8JiIvMCi3Qbm8xcHQqbLF
 W81QUtZDOAucmI0gCLc7KpxSpIoFBRDP8Fg0ZQV9PNTM9R94TBvjLK3yk5QqBKZ1fbeH
 sVheC//I1Zd1Ipvf6Sq20I5KRAb3W89O1hSGUArVKjRv4lbrs4u1s5R8wpUArLVt9kEl
 w5dEikV3CvO7Ndl3K1CrxV5i+xP/n6C2dwriu6ESuFSf93Rej3LStUJpbGDgf6DYu7u2
 C2Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW88Z1Ngkv9Eevvn+A32Oy/U5RCpff3TuSlfK+6PEepZO18A6mIu/+iBKDORM+jQcsBi3h2XmI6nrzr@nongnu.org
X-Gm-Message-State: AOJu0YzqXlGZDG5NX+GNxYI/PtxVNSFzvNwxJMSRa6UYlhYQY2vpi2sw
 11oQdZGhhTQBbMAGNX4WuO4rCFYJI7JL6nl+GD6mg+WpGQd2t/oJUtg7s2PQ5rtHt4IGqZSy7gE
 4e4VR
X-Gm-Gg: ASbGnctAvhyYd07GqsK+KU/yCN+st4jrywrhGORjNcmeKwDhN3uZSn4qvujaQT1rNkR
 UNnj4ro6mGKZVg0alR5uNBQFWK+cSvPpamLAt3/AHMbHyJ+6ycyvfwYZG9YR1HJLMQHQ0lXUImB
 7ON5eq5g3LTQssQS1GsmxVxmQDzGUgplkCjlSH0Eu9j3IbLJR+Xqjcu5Zot4RO4B2JF8UZsCpje
 yzKpIcRExq79jkAxv/aLGoJDblqZ482ITHUGxVNou53BBcb2oK27se5EP/bcvrm/kRMdg+uSoBF
 lVeG+rPXr1XfWj0TZihIq8kPUfJKwjo9NHsPmiphyXO0c4RPo4o515xG5DM2C2Zho/ACH5IAJ4r
 kIMzLFccXEqRdJZNchLWbh4N124zGHSeyRe4=
X-Google-Smtp-Source: AGHT+IFffnMFodm7niTA1P5T00ARe9YtzQfDg/zqrhPX7xrCK3aFe3XJJbI1vba8W4T8MczBw8BDGg==
X-Received: by 2002:a05:6a21:1fc3:b0:235:c9fe:5929 with SMTP id
 adf61e73a8af0-237d7b649bbmr30740887637.42.1753118728954; 
 Mon, 21 Jul 2025 10:25:28 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cb76de4fsm5987889b3a.114.2025.07.21.10.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 10:25:28 -0700 (PDT)
Message-ID: <e1272431-f38d-46ee-8140-38e2c3418399@linaro.org>
Date: Mon, 21 Jul 2025 10:25:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: apparent race condition in mttcg memory handling
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 QEMU Development <qemu-devel@nongnu.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <abe00af4-3af5-4c6b-8443-b7350a4d9349@tls.msk.ru>
 <96201a23-784b-4268-b011-a6912175d237@linaro.org>
 <c0878723-62e3-47cc-810e-6ba8a0bd30cd@linaro.org>
 <8a50f07d-ef0b-43b1-b49c-335ca6a7ff70@linaro.org>
 <bd3c403c-6aa2-4583-a50a-5cc5fcaca2b8@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <bd3c403c-6aa2-4583-a50a-5cc5fcaca2b8@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/21/25 10:14 AM, Michael Tokarev wrote:
> On 21.07.2025 19:29, Pierrick Bouvier wrote:
>> On 7/21/25 9:23 AM, Pierrick Bouvier wrote:
> ..
>>> looks like a good target for TSAN, which might expose the race without
>>> really having to trigger it.
>>> https://www.qemu.org/docs/master/devel/testing/main.html#building-and-
>>> testing-with-tsan
> 
> I think I tried with TSAN and it gave something useful even.
> The prob now is to reproduce the thing by someone more familiar
> with this stuff than me :)
> 
>>> Else, you can reproduce your run using rr record -h (chaos mode) [1],
>>> which randomly schedules threads, until it catches the segfault, and
>>> then you'll have a reproducible case to debug.
>>
>> In case you never had opportunity to use rr, it is quite convenient,
>> because you can set a hardware watchpoint on your faulty pointer (watch
>> -l), do a reverse-continue, and in most cases, you'll directly reach
>> where the bug happened. Feels like cheating.
> 
> rr is the first thing I tried.  Nope, it's absolutely hopeless.   It
> tried to boot just the kernel for over 30 minutes, after which I just
> gave up.
>

I had a similar thing to debug recently, and with a simple loop, I 
couldn't expose it easily. The bug I had was triggered with 3% 
probability, which seems close from yours.
As rr record -h is single threaded, I found useful to write a wrapper 
script [1] to run one instance, and then run it in parallel using:
./run_one.sh | head -n 10000 | parallel --bar -j$(nproc)

With that, I could expose the bug in 2 minutes reliably (vs trying for 
more than one hour before). With your 64 cores, I'm sure it will quickly 
expose it.

Might be worth a try, as you need to only catch the bug once to be able 
to reproduce it.

[1] https://github.com/pbo-linaro/qemu/blob/master/try_rme.sh

> Thanks,
> 
> /mjt


