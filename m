Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A27D3B9A9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 05:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTCfM-0000Kk-KF; Wed, 10 Dec 2025 00:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTCfH-0000K9-4o
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 00:23:03 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTCfF-0006wA-0a
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 00:23:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso48442745e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 21:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765344180; x=1765948980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cbK1eY/a7f7r/FXqZuD20S0rpfAjPQMM0B2HxoXfDoU=;
 b=DeCCu6MH1lbsYgophvoFPOQYN8KoEuFrKN72STfG8j+hcdPk/2AMTEQ6u9OvLG6jTj
 p5qj8Nm7C1joNK4bJxL4223XeFmBgln16gk/yCWXfuVzAdjl53MG9wQeV7iOIRfwb4Zn
 LO+LEOZ/czQ5lE6DpbuxvTsof7zbHXiEXpJE7v1CoOKyM63aWQBifZ/Y1gUKdFx3dM3M
 7FLxIOZL4iQQyYgbYTfqoYRQCUgDSigeb0S1iSnXyx4/Lu3ClXPkxZjsdyj6B/3BEDOZ
 t/bLp4xhyXWy9c9qHQWE2YR30L/nEeaxuoMQurXEtKSJUGA45OswhaW+3GMo9Kc78mQr
 VS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765344180; x=1765948980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cbK1eY/a7f7r/FXqZuD20S0rpfAjPQMM0B2HxoXfDoU=;
 b=TqfN64CUCP09C6/R4I9VJ1ewx6PyyrXrkLgVDq5IqubJgU8SNohGXcKy9X9j8FkXO8
 wdqipLm0lcy4+iW4VrRf98XBZpN6jKdTKBm9EKHgjlgWrFC5bDso54dqTuCGN1bVA7os
 vrplgiIEtrFietwmM12Z7HPsnx66JrPw1MS6ME6c3GYlC47qk4VlJRldF/6KJwyRhjwl
 or8ZqdR7w7MKTQCEH0sPpcGyx9SuYISNB7U6U7WHubH7XXDWiXUUAyS77f4TVTYiiNcU
 jKssKkJFVrLCRm1Nqy3x3ozxBRHwp5vl2tnN1wj68tCsgACJb6TsAR2s35gFgl/4eDYE
 +wBg==
X-Gm-Message-State: AOJu0YxeleXvkJtuHTKK1mZCJRQIhRc+R/gzTzZIQ/3alfpBdQRMHzLJ
 DnGK/TWBSlJjNLFuW5cniEAJ7uejaG3uVFFp70s57SWT6LXNxyPPmHI8O5KyD6vFB90=
X-Gm-Gg: AY/fxX7JS/0mHmvCNBVOsjq9O7nttjyGCzJLFwpGWTdXEKzUDeEs4Z91KtZPlLh/t1c
 KfYCrsoVMbI8Pi4Y1X3D+zkLYoeItkdyn4xpwQIrqzpf5Q2XBbq/S0AoDLbpG03dE3gS/gaofdr
 91PZZnU6lpUChgAZ36xB3Y+X+540V+0Ym7Z39UWyg0541LTiDqkrLKeHiznpOyeThwABzBPm+/3
 MPRIfeO+taDk79C97fi0jcq9aQJHCTr68oqJkYBv8SO4aRkVG4H60g5MZBSIgCWFADRfgJNLQm3
 DUuIQOF+tZ1CcuHlzlU++KE0twDNc3+CW6SwXjspJWIRbjZjqTIBD+8X7dwaE1FLcsPcjpNoqIW
 Az39YqQ+rfA5AiM2qqmG1R1Ka/fjtSxF9b+/H7f/kayawe8YVj4ufJR4rGU0KyEA9dbI1AWcweZ
 TNQtlzvG8HgpHkmvmXkoczGFexPzWSe9/Z91O6/x+Rdvk7019iwRzJun4AN/byZ8w0
X-Google-Smtp-Source: AGHT+IGvlBbkSNNMjJdfPLw5g25nIlpkWcuiSpW71RQr64N4FfA6QDHg5ho+Js9Y4kZ/qcES7VwxEw==
X-Received: by 2002:a05:6000:4007:b0:42b:47da:c313 with SMTP id
 ffacd0b85a97d-42fa39d9328mr871266f8f.3.1765344179594; 
 Tue, 09 Dec 2025 21:22:59 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d330b20sm34410629f8f.29.2025.12.09.21.22.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 21:22:59 -0800 (PST)
Message-ID: <36365615-9e43-4ce5-a1ba-e495eacb1f24@linaro.org>
Date: Wed, 10 Dec 2025 06:22:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-4-shorne@gmail.com>
 <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
 <8c34270f-9fdc-3e94-0984-29d9a5e5542f@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8c34270f-9fdc-3e94-0984-29d9a5e5542f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 2/6/22 17:49, Richard Henderson wrote:
> On 6/2/22 04:42, Joel Stanley wrote:
>> Hi Stafford,
>>
>> On Fri, 27 May 2022 at 17:27, Stafford Horne <shorne@gmail.com> wrote:
>>>
>>> This patch add the OpenRISC virtual machine 'virt' for OpenRISC.  This
>>> platform allows for a convenient CI platform for toolchain, software
>>> ports and the OpenRISC linux kernel port.
>>>
>>> Much of this has been sourced from the m68k and riscv virt platforms.
>>
>> It's a good idea! I did some playing around with your patch today.
>>
>> I'd suggest adding something to docs/system/target-openrsic.rst,
>> including an example command lines.
>>
>>>
>>> The platform provides:
>>>   - OpenRISC SMP with up to 8 cpus
>>
>> You have this:
>>
>> #define VIRT_CPUS_MAX 4
>>
>> I tried booting with -smp 4 and it locked up when starting userspace
>> (or I stopped getting serial output?):
>>
>> [    0.060000] smp: Brought up 1 node, 4 CPUs
>> ...
>> [    0.960000] Run /init as init process
>>
>> Running with -smp 2 and 3 worked. It does make booting much much slower.
> 
> target/openrisc/cpu.h is missing
> 
> #define TCG_GUEST_DEFAULT_MO      (0)
> 
> 
> to tell the JIT about the weakly ordered guest memory model, and to 
> enable MTTCG by default.
> 
>> I enabled the options:
>>
>> CONFIG_RTC_CLASS=y
>> # CONFIG_RTC_SYSTOHC is not set
>> # CONFIG_RTC_NVMEM is not set
>> CONFIG_RTC_DRV_GOLDFISH=y
>>
>> But it didn't work. It seems the goldfish rtc model doesn't handle a
>> big endian guest running on my little endian host.
>>
>> Doing this fixes it:
>>
>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .endianness = DEVICE_HOST_ENDIAN,
>>
>> [    0.190000] goldfish_rtc 96005000.rtc: registered as rtc0
>> [    0.190000] goldfish_rtc 96005000.rtc: setting system clock to
>> 2022-06-02T11:16:04 UTC (1654168564)
>>
>> But literally no other model in the tree does this, so I suspect it's
>> not the right fix.
> 
> Correct.  The model might require
> 
>      .endianness = DEVICE_LITTLE_ENDIAN,
> 
> if that is the actual specification, or it may simply require fixes to 
> handle a big-endian guest.
> 
> All that said, if we're going to make up a new virt platform, it should 
> use PCI not virtio.  See the recent discussion about RISC-V virtual 
> machines, where they made exactly this mistake several years ago.

Unfortunately this precious remark was missed :(

