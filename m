Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199E4C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 09:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmUkn-0003AD-10; Mon, 24 Feb 2025 04:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmUkf-00038D-1h
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:27:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmUkc-0005uu-9h
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:27:48 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso24809415e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 01:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740389264; x=1740994064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ILAHXZV6puw4USZCuHT9JXFiOI0s74G7OvRJTstD+Tk=;
 b=kTfHwYNpR5LHIF8moJxRcH8TX5yKfRBYZZ1r0fchoUGGdND8N+DQXIHoH8xAcOdhad
 bEUqlC1b1VMC8kraIlbUUyYmu67b3HbBOp2kH/l7MwODQarcriz5FZeSYnuVTT3LHXI6
 zuHx7CdBbpiI4rUd/AbNMKCpTyuHNjmigGvNv7h4d5QKvPhdaGUvf27S2vU8XcJHQfJ4
 lZ8ZM14nwNt8x7Uf01TG5i2RP5hRuAeVuOHi7LJaGHeVykE6FkyWfvneoHUrQ1/LNYkw
 PwYjK/SYVspPfZN+zBkhVBG78t99/s5TzjJxJG78psLkKK6RYRIZFVwE2XV3iFX39Iz/
 pVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740389264; x=1740994064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ILAHXZV6puw4USZCuHT9JXFiOI0s74G7OvRJTstD+Tk=;
 b=bTXJ1Hpp5tLk4dMnGe/F1fXOtLDWMq0JH44lXHrilWqkLkuQGlm6i0NyQOLC/h+YAb
 KivZvf4ZwjOEWyZjRX09igcj1iQUOm1uTKaHyH1Ixq20Mmerj0GUXF5WjDvx0EdTVulg
 dDecvVS7y/dWRFTotRm7kqOjnNNw8FIONL3TEscZfK0b8YXaTmZRE3tcKh6I79vorclq
 +9TVkUVS7vv8sTqZx78XQvyVycSBJFBXPIa2tLIM/ghWBBkQlnafoN6N8SashTijFpDB
 HRhsY2/L4wP+MtmPwN7BF7w8SS+s3g3cQY1wUtILmzwaBFc1f+JX7tEWDxDL91+Yc2HC
 ewQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOE8S4QtXwQRBcCTIEvf4mChdjeN9XRqCTjc7rByxzCqvAjCuDdaoL4Y3Itff7yancws+QUdytyahs@nongnu.org
X-Gm-Message-State: AOJu0YyztdZL/TPliuA4GWr4gvbH7WCvn78FaEym+4a0P9vTkt5i1wBr
 EQXO31HmpDmVgVRwc8IwOjVNFetONj02sbA8BLk94X+Shm4+Fy+kcTYGpnS6ijRc6ysrCeRPdb4
 kSEU=
X-Gm-Gg: ASbGncttsEyh2mnO8AN0Xuyokuz0AWtr+AZwCWJOw7UyjIXbiBeERO2J3eEqyofWEoQ
 nG1TkKt7b1wTHhwKpsl/HMEm20GH8d4ZxXy7bd7+nlCIg4MXN4/utgUa8e1EWgwX69USJy06ZaY
 fKXf7YfI4rz9u9Sesds6B4vC4xC8pAJCdzrDnT9kSCYaUapEmMxFzfIPkQxuFEP8I47axwMHlmP
 mPgoKf6WO/ThXwZV5CdSk0FlnayPTAWGqY+UjqAd8KE30gz5NubKLLiWdcyJOgYzhJNZ8SAj8xe
 fAsRyxxcaMKrwizbTJtuodaEAe2hyol3TWqXQbh73H6hXam4w63A+/nw7HZgDuw9ZmcTlA==
X-Google-Smtp-Source: AGHT+IFjzk8cjxOXL51fqYaqmvR6ftP5DLUrwUkofHYyFDAAEPrDGpcOVEVUcz1XXu5jBT5MRwApBw==
X-Received: by 2002:a05:600c:a10:b0:439:a1ad:6851 with SMTP id
 5b1f17b1804b1-439ae2eaed9mr92636985e9.23.1740389264362; 
 Mon, 24 Feb 2025 01:27:44 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5e92sm31539793f8f.66.2025.02.24.01.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 01:27:43 -0800 (PST)
Message-ID: <cad09200-6037-45ca-b043-be58b5a92612@linaro.org>
Date: Mon, 24 Feb 2025 10:27:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pvg: do not enable it on cross-architecture targets
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250220133306.1104382-1-pbonzini@redhat.com>
 <20250220133306.1104382-2-pbonzini@redhat.com>
 <df0b1287-1a4d-43ad-860a-59bcd6ec3c7e@linaro.org>
 <701a0452-8aa9-4bcd-b334-bdfca2d12fd4@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <701a0452-8aa9-4bcd-b334-bdfca2d12fd4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 21/2/25 18:01, Paolo Bonzini wrote:
> On 2/20/25 16:19, Philippe Mathieu-Daudé wrote:
>> Hmm what about keeping a MAC_PVG_COMMON instead:
>>
>> -- >8 --
>> --- a/hw/display/Kconfig
>> +++ b/hw/display/Kconfig
>> @@ -141,15 +141,17 @@ config XLNX_DISPLAYPORT
>>   config DM163
>>       bool
>>
>> -config MAC_PVG
>> +config MAC_PVG_COMMON
>>       bool
>> -    default y
>> +    depends on MAC_PVG
>>
>>   config MAC_PVG_MMIO
>>       bool
>> -    depends on MAC_PVG && AARCH64
>> +    depends on AARCH64
> 
> It's possible, but the two "depends on MAC_PVG" cannot be removed here,
> because otherwise MAC_PVG_PCI would be selected by "default y".  The
> only reason to do so, in my opinion, was if one wanted to build pvg as
> a module, otherwise it's just (a handful) more lines of code with no
> particular benefit.
> 
>> -if host_os == 'darwin'
>> -  system_ss.add(when: 'CONFIG_MAC_PVG',         if_true: 
>> [files('apple- gfx.m'), pvg, metal])
>> -  system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true: 
>> [files('apple- gfx-pci.m'), pvg, metal])
>> -  if cpu == 'aarch64'
>> -    system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true: 
>> [files('apple- gfx-mmio.m'), pvg, metal])
>> -  endif
>> -endif
>> +system_ss.add(when: 'CONFIG_MAC_PVG_COMMON', if_true: [files('apple- 
>> gfx.m'), pvg, metal])
>> +system_ss.add(when: 'CONFIG_MAC_PVG_PCI',    if_true: [files('apple- 
>> gfx-pci.m'), pvg, metal])
>> +system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',   if_true: [files('apple- 
>> gfx-mmio.m'), pvg, metal])
> 
> Removing the "if" is independent of whether you keep CONFIG_MAC_PVG_COMMON.
> I can squash that in patch 2:
> 
> -if pvg.found()
> -  system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true: [files('apple- 
> gfx.m', 'apple-gfx-pci.m'), pvg])
> -  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',    if_true: [files('apple- 
> gfx.m', 'apple-gfx-mmio.m'), pvg])
> -endif
> +system_ss.add(when: [pvg, 'CONFIG_MAC_PVG_PCI'],     if_true: 
> [files('apple-gfx.m', 'apple-gfx-pci.m')])
> +system_ss.add(when: [pvg, 'CONFIG_MAC_PVG_MMIO'],    if_true: 
> [files('apple-gfx.m', 'apple-gfx-mmio.m')])
> 
> (you need to keep the conditional, whether as "if" or "when:"; otherwise,
> because Meson cannot know that the .m files will never be built, it
> complains that you don't have an Objective-C compiler).

Ah, I haven't thought of that.

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


