Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF03EE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 16:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVYXI-0002l9-P3; Wed, 08 Jan 2025 11:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVYXH-0002kc-LG
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:03:59 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVYXG-0008Op-0s
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:03:59 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so760734f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 08:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736352236; x=1736957036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4I/Wd+H1o4NXowT6XIITXWN2M9y/aTJCGVmNKAVS1MQ=;
 b=frNfLfka89kVeSY0u7kSpq2jYOzx2gTnpxB3sDo2NnVo2kmym2Js67oO3zMnzuEYJJ
 9Ot+gCfTURFKhFQohhxlcOultgbMiqtHgJdhGi/Dn3BGzOlndbrIoGcBDdqhPmF1x0Jw
 trb7LCx2neLP7pU7oTL+BdIp4D5qNF2U2LKjdT1EFnA1N/z62vmKibw+Ue0xI0+Yn5tK
 Vfk1ELf9gMKZ82v2i5D5uXUITRrAjci075lIfr6YdQmkkzXYClpWkXaK5vGb25EyXQ1G
 SXzAHapBNZ1bBiQtekT6maT6/xgSoLAr1Qa5VFoiOydWGrfqclEFgNwkWhPT3agCSG7s
 WzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736352236; x=1736957036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4I/Wd+H1o4NXowT6XIITXWN2M9y/aTJCGVmNKAVS1MQ=;
 b=NMuoRGM1wNbmigEQ4mdX0L+cmZZMUkpCEKwAq9Q49NvqyS/5yM1J17lcudS/jKEhx1
 gxsJutjnndxCJHzne73u3nvsfr767tMMa0jaTNxeWDyiuGU+4xoj15rnsi/Dv5bqmako
 OhJZkCKDaQ/Bt2CCLmGTPE+Brgy8wtode/PIx3EUQnPegkU1/wfn6ZvRJWsfgs+pg6ad
 35V6beN3+YaOlqc1kMmNnRbQ5gTPXZzumCCDetrjhxHrGXyTMyxe7Bxjnz/fZhlJTI9p
 7OWWOxFUFKiGGFp89jQIlddHmcXuv4sP8IjZNqP9DODQEE3abLq/66MdyL+va3NcjuBY
 aDew==
X-Gm-Message-State: AOJu0YyToqnoTqmqrE0dosbLp5qYfvMywQMi0lUK0M2oPTAm0/rxaJ67
 W06Hz+BwwjTokYQxQg5uzmmfVn+NPSzAWvY4J5qZqrIopKZVckQnGlaPYhv1pX8=
X-Gm-Gg: ASbGnctbOFAEQxDh2N8dINTW7kgjmeFy6DHp45fIT+czRq8zVtVrTWZDcwFBPikJuZu
 baiQx2Kcb5Ms401APro+b3s1XxmHuCwYqSsVFYIfANaVO/X5bfcOTJ87iSIyhOjUZl/TpwVJ1T9
 BuXEROKQbCSnkyDk1hpwfx8tDdJxdMiwC76mQYZEiemP8QuIpnUJhZg//C6qPNSrQv8TcOnIaDB
 yNqrJwoPYLHkqg6+P9kAHAR/P1IESq4PUA6F2XqN0uEKwEvHE64OqllbFLlDstzwsZVlr6A2sfX
 ourLMEwcwR5Z1NcH4X817u7s
X-Google-Smtp-Source: AGHT+IGyVO8jVPq9y4MqH6EW/XpKxfLKAOiQRqaPEEjGEPLti6m/j2NzX9Nu90o6is3P99Pzyk3ltw==
X-Received: by 2002:a05:6000:1849:b0:385:fa26:f0b5 with SMTP id
 ffacd0b85a97d-38a85f4ee77mr2711953f8f.20.1736352235999; 
 Wed, 08 Jan 2025 08:03:55 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e69sm52699427f8f.35.2025.01.08.08.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 08:03:55 -0800 (PST)
Message-ID: <7b576b03-efdf-4b54-a1cd-5dfe09f38ebb@linaro.org>
Date: Wed, 8 Jan 2025 17:03:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] docs/nitro-enclave: Clarify Enclave and Firecracker
 relationship
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <graf@amazon.com>
References: <20241211222512.95660-1-graf@amazon.com>
 <CAFfO_h6iv=_dae_CdhB9Ggi-Q1ETREQROn22-p6vMN=g=DjrKA@mail.gmail.com>
 <CAFfO_h4iocyfTPZ_vtGU=ny=pw4hCapP8wQHB3ZoDVE=rAsi5A@mail.gmail.com>
 <CAFfO_h60R79YgTWjZi6hvd4-xMh=qTgsZey5xqr9bzv8u=MyCQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFfO_h60R79YgTWjZi6hvd4-xMh=qTgsZey5xqr9bzv8u=MyCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 7/1/25 18:01, Dorjoy Chowdhury wrote:
> On Tue, Dec 31, 2024 at 12:26 AM Dorjoy Chowdhury
> <dorjoychy111@gmail.com> wrote:
>>
>> On Thu, Dec 12, 2024 at 8:14 PM Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
>>>
>>> On Thu, Dec 12, 2024 at 4:25 AM Alexander Graf <graf@amazon.com> wrote:
>>>>
>>>> The documentation says that Nitro Enclaves are based on Firecracker. AWS
>>>> has never made that statement.
>>>>
>>>> This patch nudges the wording to instead say it "looks like a
>>>> Firecracker microvm".
>>>>
>>>> Signed-off-by: Alexander Graf <graf@amazon.com>
>>>> ---
>>>>   docs/system/i386/nitro-enclave.rst | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>
>>> Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
>>>
>>> cc Paolo. This can be picked up for merging along with the 3 other
>>> nitro-enclave related patches from me.
>>>
>>
>> Ping.
>>
>> It's been a while and this one is just a documentation change, so can
>> be picked up for merging. Thanks!
>>
> 
> Ping.
> 
> This one can be picked up for merging.

I have queued it, sorry for not mentioning sooner.


