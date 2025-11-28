Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23BED116F1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 13:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOy7l-0007vi-Cj; Fri, 28 Nov 2025 08:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOy7i-0007oC-Kk
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:02:54 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOy7g-00062C-Of
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:02:54 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-42b566859ecso1761810f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 05:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764334971; x=1764939771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Eh6YV1YT+cwxxhQ2cO3Pzaktk5TaFCw4cbmkvdsDd84=;
 b=oOzZZLeFzyvt71v8b2xruYG9OZTHr33CD4CcfOiiEugLyLuZDW9tO2VCiKdjzEo4cJ
 r/kyd+p8tYbPQJMbmMj87pou0JmGEf09p6kzsemWyUiReG5333ABGe3LzB3Wfzh6l69A
 abPXnxQpANTvCdr9z2KgMAVjYFEdsVifmbo8GQzX+XxaF8Y3TobBSEBick3lti/ImuLj
 HBBMb4ZnWt8GNcdWvXwnwdQCM2J5KVaRnPQJMQVYBWiRjt5i/KFeX9zfa+Rz0MXBeezR
 uiQkPDmz01zuAEZg/5ezlgn2mmYYSCGx2e70R08tT3hRgM5apO7dVy/E9a9LVCe57ZgV
 Bt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764334971; x=1764939771;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eh6YV1YT+cwxxhQ2cO3Pzaktk5TaFCw4cbmkvdsDd84=;
 b=IFlckuewWvjBOrnAtPW94SDM3cW+Ss+UjJ3DnP20m8G1HeXsk7ydSzcUq/sOi5li5x
 QDbC2POsP2CtkOqr5QxiNkQV0lPmn2XysYN6VsYxivIzFIDV4qH603w/z54KN48nlCN0
 VaH0WMPcWAIb+mOFtEy3elqti1jFcIcNi2rWO5UvJ5edZR2RC0aWmsjNapifBl4Fb52i
 GVlc0mlyROoPnvHOCGB7Fa3jZE64iunp+ePUN9TFgAk1izqfP1NEIFytnh4jryKbg8ZY
 s/tm5jCjHXGiJRUeF+QOyRyWNwZAjV5YMkPf+DptDPSY14AOgSN3SZGcNdCe5bIciBQ3
 PxFw==
X-Gm-Message-State: AOJu0YxLao0SCppepQj/T47/THSqBnOZNZeczBHaK6khSxKZKPLmEL9g
 6NKVVQODXT5Ne2g/s4ghKGZgpb79rSi7FvPbExJ6Rhd2uirjLwq8XAbQ5Egm47y2ltY0iOihms7
 PfZ7z9DZ4MGMu
X-Gm-Gg: ASbGncsyk4bV4REcYEE/xBlwFBb2HY7Cgy5e9lKxyYYprUtWBf758+z8s5rEbC447fq
 5/EzstPMoQ00Rsq0OkSFAIXDhhTD26+Y4juMwOGrvory2XdO2pRqm9V8Gw0EwZVqLBEdb+uigX3
 HFh9RNCmC8GwpUnzbJ0gACaDGZ+/JM1dXWKhEOnOlwq3olvJxu6LtJ47EpTj7DxrPWZvvK9+F6/
 NIQafz+f8Nfm3Pfa8RDVwv4M7n9+taOsKlTW3X3bRoGeaJ/KMNfMq38Zcg4Zhv420LlbfjWaFre
 0NuToCslx1TaWIDlktr0wst6K+oDYauUE5Iu6uYiGICZkLxadQhkzPul1mMkWoOuC/koya7b+Bx
 EK2NALczONed6Ie4hVbHq4PApd15Ac4nDn08NPb4bw0xwMUAimuaH3vb9eg259c6FLgG3w+hOgK
 xZJLPiJp2doDgFfvrZDC8X+ImdHJ0vCyFSzzMPiUnl1U3Ba4POO0nLQw==
X-Google-Smtp-Source: AGHT+IHlMhwrbryuUfKvi1tSNH2cIq1rxzcQUT7s+4XgOQGR8FOune9xrieRm1VHpXpneoTxJWxTCg==
X-Received: by 2002:a05:6000:607:b0:429:d19f:d959 with SMTP id
 ffacd0b85a97d-42e0f21e851mr15889520f8f.15.1764334970412; 
 Fri, 28 Nov 2025 05:02:50 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d618csm9438796f8f.14.2025.11.28.05.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 05:02:49 -0800 (PST)
Message-ID: <768e0294-3f03-4ab5-b9d9-d188e43cbcb7@linaro.org>
Date: Fri, 28 Nov 2025 14:02:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix i386 HVF compilation failures
Content-Language: en-US
To: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org
References: <20251126094601.56403-1-phind.uet@gmail.com>
 <8f6eb2ec-d6a7-49dd-b425-ee771d2f9be3@linaro.org>
 <66f442e9-87d9-4a62-b7ca-d29a1e1b9dc0@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <66f442e9-87d9-4a62-b7ca-d29a1e1b9dc0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

On 28/11/25 09:46, Nguyen Dinh Phi [SG] wrote:
> On 26/11/25 9:39 pm, Philippe Mathieu-Daudé wrote:
>> On 26/11/25 10:46, phind.uet@gmail.com wrote:
>>> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>>>
>>> Recent changes introduced build errors in the i386 HVF backend:
>>>
>>> - ../accel/hvf/hvf-accel-ops.c:163:17: error: no member named 
>>> 'guest_debug_enabled' in 'struct AccelCPUState'
>>>    163 |     cpu->accel->guest_debug_enabled = false;
>>>
>>> - ../accel/hvf/hvf-accel-ops.c:151:51
>>>    error: no member named 'unblock_ipi_mask' in 'struct AccelCPUState'
>>>
>>> - ../target/i386/hvf/hvf.c:736:5
>>>    error: use of undeclared identifier 'rip'
>>>
>>> - ../target/i386/hvf/hvf.c:737:5
>>>    error: use of undeclared identifier 'env'
>>>
>>> This patch corrects the field usage and move identifier to correct
>>> function ensuring successful compilation of the i386 HVF backend.
>>>
>>> These issues were caused by:
>>>
>>> Fixes: 2ad756383e1b (“accel/hvf: Restrict ARM-specific fields of 
>>> AccelCPUState”)
>>> Fixes: 2a21c9244740 (“target/i386/hvf: Factor hvf_handle_vmexit() out”)
>>
>> Oops.
>>
>>>
>>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>>> ---
>>>   accel/hvf/hvf-accel-ops.c | 5 +++--
>>>   target/i386/hvf/hvf.c     | 6 ++----
>>>   2 files changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
>>> index 3e5feecd8a..e2cb8f202b 100644
>>> --- a/accel/hvf/hvf-accel-ops.c
>>> +++ b/accel/hvf/hvf-accel-ops.c
>>> @@ -148,19 +148,20 @@ static int hvf_init_vcpu(CPUState *cpu)
>>>       sigact.sa_handler = dummy_signal;
>>>       sigaction(SIG_IPI, &sigact, NULL);
>>> +#ifdef __aarch64__
>>>       pthread_sigmask(SIG_BLOCK, NULL, &cpu->accel->unblock_ipi_mask);
>>>       sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
>>> -#ifdef __aarch64__
>>>       r = hv_vcpu_create(&cpu->accel->fd,
>>>                          (hv_vcpu_exit_t **)&cpu->accel->exit, NULL);
>>>   #else
>>>       r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
>>>   #endif
>>>       assert_hvf_ok(r);
>>> +#ifdef __aarch64__
>>>       cpu->vcpu_dirty = true;
>>
>> Don't we want the ifdef *after* this line?
> Oops, that was acutally that I meant to do, I think I made mistake when 
> formatting the code. I will send a new version to move the #ifdef line. 
> Somehow the vm still work normally on my intel Macbook.

Does that mean you tested this patch and it works for you? I posted v2:
https://lore.kernel.org/qemu-devel/20251126134434.14355-1-philmd@linaro.org/
What do you plan to change with it?

Thanks,

Phil.

