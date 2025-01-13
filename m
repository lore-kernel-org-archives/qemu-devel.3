Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3558C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 16:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXMsF-0002RI-Sz; Mon, 13 Jan 2025 11:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXMsA-0002Qv-5C
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 11:01:04 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXMs7-0007Fg-Sw
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 11:01:01 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43618283d48so32291525e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 08:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736784057; x=1737388857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lVMUJbLRIl4dc6gKouVfrRTIBCo5idwT2IQi0pT3kRI=;
 b=omtGt9wCXaGCEGlRHmsWE9SDyiGm561TSgxPeDvHrsp922+nOytp2DvcAGiuESKEt3
 WaqGoWJq8TTkaxWd5rUB0hMI3MnSzqaOUb2TbtEcrOfgUlI8tp1Deaao58RlFgNzSm8w
 3rjqQFlWa+zkXVZHmmZYvbYJXrQO5QkZzfCaPJWYe3U8ldPu8gCksxAzmNuqt29e19cV
 Vds2AcYotaWKI7fPBJdWyxXgSwSeWflZm5ZnbzuI0K5hGr4foHZzCIMj2r3s36u5BLRR
 If8Q4Rpvqu7ykN6JIiiKDXWncG0/55t/E3+YOjX6mY2zDbBz2fLdjeiSfveH3uEnQ35V
 INLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736784057; x=1737388857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lVMUJbLRIl4dc6gKouVfrRTIBCo5idwT2IQi0pT3kRI=;
 b=CSe8edM1z7jNPhyUcQQkpdzO7NgpNtBMoHFunI4nUSB9BQcvjhVjhjHswoLcu5POzk
 xCh8QIlF42aG6/zhCyNh/Ecd7Djz9gLHVZuNqreEX7XYqHqZ3tOa4FUuuygLidmtqCOe
 A6jnN3jefjeOI4TRq4zaQzyAnTR6BPINMOh4kZMb3KIN6csNXkAAZv4tQTKus+kNY6WB
 aQOctc5LyqKMdKYc/eSwdx5/UbDO5rl4o+sbjEr1RIOxGiIg8zHSTp7uV3ScW2+G8JI1
 i42scq0m+5no4xPDR89LPSkrgP87P6S60CtAbmn/iazYEx60kYj0MaG8rm33j1tHSGaF
 2oTg==
X-Gm-Message-State: AOJu0YwpwZRwPWGCHjxvA0XUZPWOck1hSGppRzrDKAcWdbERup/N5awh
 S1xByEmLH6o+yEedG7CQ6XlEjzlR4BCJx8lk7zOIvuGFzAkwA8+n5N09cOXJZho=
X-Gm-Gg: ASbGncugiq9Hxr0XM5PP0Y0nCEVQRSe4sl6A/atJediPk57dy/990F9DJnocc79Dp8F
 aHZZ07e9vrhZec6vKc7y3agFWpDGB0OzvJRNSmRBZxKaXpXxefw6A37i+KkMpClRLRpU9DVrl/U
 aEATNlnkeNrjvmOnBnzhdb7Sct7SbrgJWSCwMBDr1qsRHpp6MMwq421rjhkrlbwkYGi+1Of8aPd
 J01+OZ7wV061cYpFaO0k/eyGE0VjG9HAM3GfXNPHvaVodJnbw7OyZ3l8SgnsS30UM09LH1HEa0F
 ZM4ZHE+CO9aDUK8BKKTDdmCo
X-Google-Smtp-Source: AGHT+IHN+YiAVSo7HJjYfr6Tp4oejCbX6/EzLqx7w/u3VJu4uz3pndpO+1OxzstPwBwZSjgJu1PTbA==
X-Received: by 2002:a05:600c:283:b0:434:f1e9:afae with SMTP id
 5b1f17b1804b1-436ee0f8783mr101535665e9.1.1736784057207; 
 Mon, 13 Jan 2025 08:00:57 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38d008sm12844621f8f.59.2025.01.13.08.00.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 08:00:56 -0800 (PST)
Message-ID: <6f9225ad-edc6-4fe0-b0e6-8a93e7f50102@linaro.org>
Date: Mon, 13 Jan 2025 17:00:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/49] hw: Add QOM parentship relation with CPUs
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250112221726.30206-1-philmd@linaro.org>
 <20250112221726.30206-5-philmd@linaro.org>
 <20250113132832.049f651a@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250113132832.049f651a@imammedo.users.ipa.redhat.com>
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

On 13/1/25 13:28, Igor Mammedov wrote:
> On Sun, 12 Jan 2025 23:16:40 +0100
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> QDev objects created with object_new() need to manually add
>> their parent relationship with object_property_add_child().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> Message-Id: <20240216110313.17039-22-philmd@linaro.org>
>> ---
>>   hw/i386/x86-common.c                     | 1 +
>>   hw/microblaze/petalogix_ml605_mmu.c      | 1 +
>>   hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 +
>>   hw/mips/cps.c                            | 1 +
>>   hw/ppc/e500.c                            | 1 +
>>   hw/ppc/spapr.c                           | 1 +
>>   6 files changed, 6 insertions(+)
>>
>> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
>> index 97b4f7d4a0d..9c9ffb3484a 100644
>> --- a/hw/i386/x86-common.c
>> +++ b/hw/i386/x86-common.c
>> @@ -60,6 +60,7 @@ static void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
>>       if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
>>           goto out;
>>       }
>> +    object_property_add_child(OBJECT(x86ms), "cpu[*]", OBJECT(cpu));
> 
> I might  be missing something but why it needs to be done manually?
> 
> device_set_realized() will place any parent-less device under (1) /machine/unattached

This is exactly what we want to avoid, to eventually remove
the "/machine/unattached" container for good.

See "= Problem 4: The /machine/unattached/ orphanage =" in:
https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/

> while devices created with device_add() are be placed under /machine/peripheral[-anon]
> 
> The commit message unfortunately doesn't explain why [1] shall be replaced
> by direct cpu[*] array property directly under machine.

Right. I'll drop for now and respin once reworded.

> Granted, those paths aren't any kind of ABI and wrt x86 cpus
> nothing should break (or I'd say it shouldn't break our promises)
> But I'd rather not do this without a good reason/explanation.
> 
>>       qdev_realize(DEVICE(cpu), NULL, errp);
>>   
>>   out:


