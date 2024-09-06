Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED90ACE7AE2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 08:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smU8y-0000M9-9k; Fri, 06 Sep 2024 04:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smU8u-00006G-ES
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:16:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smU8s-0004np-EY
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:16:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42bb7298bdeso17737105e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 01:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725610588; x=1726215388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NkESefyHeyR0NV5fkglDv3/YD8P6jaBiVeA38wMXhUM=;
 b=Ia3TBgMrpPeCKq5yR4Wj0wQ3JnL2HgS8xNZF0zkNg1HCK6w0RTDjkZ57AAUMAa5XAf
 MTtje9rvbihs59D+wULrXfloBh5d1fyhnCZbPEBYladDa4aRNk5iHq1lW+VUW2PaiG3/
 ZbfOzzvENtn7Rs8aeXQtq7so+XKrBXBj1mrs1/kifABZvm3PiFdBjtpJ0XBlSOoc8x48
 GA0DPlqh/uSrsFJ6cSgW0cuLnasVimNXQcoBCmYr3+ywdNBhyw6W5oqVwwKywPgRiNUJ
 WXDki6a0G24ePJfWztGI3X9MIqRqBeYTDVJ0roe0kSPtQi+NYoF1TX592TvcobwydZdP
 IRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725610588; x=1726215388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NkESefyHeyR0NV5fkglDv3/YD8P6jaBiVeA38wMXhUM=;
 b=qtwFfS8OOAEKbtUCihkNjwLFO+SqcZi3RDsV2IAZNz6m6idltBH9f2XOTRQbMCJPFf
 0pJLKghRmuJwAWzMc4wb3FdNYet493n18wejriFVRXPhe/rzHj2eZo/zLDWf/HUscOen
 WnGRHmsfPnv5492RH9cGZ96LK71TnVWN7LTZtWbV/+OZvoyRxXsC0XpqcGL/ZZxit3pm
 4+yOyqfBCEd2aZ8XjOBVROxDcWVTk4pI5oypYKn7x/fU/QEngB0HtMKO/DdIO1fb2Zip
 Q0Vr8YBYFcPYVzSTmQjI7n8erHSz4irrNAelm8uzTwlDtERjF7jK48eJvYQoYWSNrPj1
 UHbA==
X-Gm-Message-State: AOJu0YxJEzMaCees2AlzTLiJBCjhWAty3yEpE2XTUU7DDKCNB3TUpidp
 2tDvpf8XvCjfOYu468sh3xuUInL7vRn3JzcRB1Lgz0DnL7cahyJdhRdtPpXgVbE=
X-Google-Smtp-Source: AGHT+IG34yFbyAMwKQjo3hPHr5LPFCtGX+q+MxtBRjASEbr39vycMZ8RHw7cN9QuBPoyRw+Y/YKkXg==
X-Received: by 2002:a05:600c:3c8b:b0:426:5e1c:1ac2 with SMTP id
 5b1f17b1804b1-42c9f985156mr13759415e9.8.1725610588352; 
 Fri, 06 Sep 2024 01:16:28 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05c6facsm12257045e9.9.2024.09.06.01.16.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 01:16:27 -0700 (PDT)
Message-ID: <37328055-a88b-42ae-9d6a-59b0e6507f62@linaro.org>
Date: Fri, 6 Sep 2024 10:16:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] Revert "target/riscv: Restrict semihosting to TCG"
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org
References: <20240905191434.694440-1-thuth@redhat.com>
 <20240905191434.694440-8-thuth@redhat.com>
 <CAFEAcA8NqfTdHhCJo8QzPy=EJQYKm=9dCC41UN4K_2pqeXifqA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8NqfTdHhCJo8QzPy=EJQYKm=9dCC41UN4K_2pqeXifqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/9/24 21:53, Peter Maydell wrote:
> On Thu, 5 Sept 2024 at 20:16, Thomas Huth <thuth@redhat.com> wrote:
>>
>> This reverts commit 10425887ba54241be1ce97f8935fc320332b531c.
>>
>> Using "imply" instead of "select" is causing a build failure:

(please mention ./configure arguments besides --without-default-devices)

>>
>>   /usr/bin/ld: libqemu-riscv32-softmmu.a.p/target_riscv_cpu_helper.c.o: in function `riscv_cpu_do_interrupt':
>>   .../qemu/target/riscv/cpu_helper.c:1678:(.text+0x2214): undefined reference to `do_common_semihosting'
>>
>> Thus revert to fix the build.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   target/riscv/Kconfig | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
>> index c332616d36..5f30df22f2 100644
>> --- a/target/riscv/Kconfig
>> +++ b/target/riscv/Kconfig
>> @@ -1,9 +1,9 @@
>>   config RISCV32
>>       bool
>> -    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
>> +    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
>>       select DEVICE_TREE # needed by boot.c
>>
>>   config RISCV64
>>       bool
>> -    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
>> +    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
>>       select DEVICE_TREE # needed by boot.c
> 
> This will break the intended "we don't need semihosting if
> this is a KVM-only compile", though. Can we fix the
> build problem use see with
>   "select ARM_COMPATIBLE_SEMIHOSTING if TCG"

We had this discussion with Paolo in
https://lore.kernel.org/qemu-devel/CABgObfbvjG9bBgCwM-kL+YhjhMw1qLnQdQToCEkKW+V3trskoA@mail.gmail.com/
Not sure this is as easy as it looks...

I feel the riscv part could be fixed by a respin of:
https://lore.kernel.org/qemu-devel/20230711121453.59138-1-philmd@linaro.org/
where semihosting is restricted to TCG and isn't an issue
anymore for other accelerators such KVM.

Let me have a try.

