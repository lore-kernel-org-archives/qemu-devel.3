Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01988C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUpa-0003bB-3C; Wed, 22 Jan 2025 02:07:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taUpV-0003Zt-4U
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:07:13 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taUpQ-000872-67
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:07:09 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385e06af753so3216891f8f.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 23:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737529625; x=1738134425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YLQp8FMqgorbMeo4kFTvvolGoBMaHmWnEAgzOee50uk=;
 b=Xe4YTsQXhCrrUdArOaCcl37KbsTzeZAmt/+yDhbdQeb3HVY79+vHWNLE6cV9e6VusN
 Ex7bi7v+GoyXsXg4TX9RnSfylrX4kUliXhmmRJGnwbISXfjLy1ug5Fj6T3Um3U8ca29j
 O6/Ct15IzNK59tdbco+mwEGAhrVaBhsgPEbMKruTx+jd6Gj9VFviDRv7lutELHKG3W6J
 NKefRCH8sknGRHbVsjGoeJSJ5lk0kSEvF/799w4ECN6Kw2JgN+cSPRTKGQRki54QPtMB
 j2MyUT6AVfAwsr4dEyHuwan/gRoVs0iUxUtA+AVx+FBrrJyy7QuHcSXBF7LS4Uu3TX5B
 KqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737529625; x=1738134425;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YLQp8FMqgorbMeo4kFTvvolGoBMaHmWnEAgzOee50uk=;
 b=Rty4k7r3OSiAIEzylH8oGcAYBOGPETQdJOY9C03p1lWNkk8oH3sQNt2bMglq/zlZC5
 k/lcyLpCHStyYU/nLuXJdTWs6vmEEatnw+I0OOp3uz03L23Nf4ejTYefSA4VCrKM0AnI
 UW5O9HDxoGi08qDxbGjIBo+sR1EccEQ2U/83Q4u0+zzehYR64aTBjGR/4m/SG5XQ6cDN
 hs3cBscmmj43jPfYyI4xsam5CNmmydWmsLKHaM+hT4fORHpwpQHCaPk3h3rtRK9egHBf
 KxJU088slUvRBSYrRY9eJuCTwsq6DBWQZz4yvNgTnDWtOyN1vN8LRalRZ0FipLNKdevm
 j7UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFnYNyFMoQEIMT3GCkxZLZ/lQUtZv2lzB/9zd7hYfOUH4gkeRmCD3Ur8/WLJPCkwUcx5oilYoGcGjy@nongnu.org
X-Gm-Message-State: AOJu0Yx1VVZ20fz8fwn6bL2+6Dw9eSzXUlTrQI6sWSIcRGK6lRRyvkmW
 xqAAz9RCGoebTP5ZHQw4t58FZPBEcCBNDO8WRBK2cwUVZc6H418CNJ5x8Hm+398=
X-Gm-Gg: ASbGncsLsQRsjVpFdngu9neiQn3cpHhbuLAdL48KZZzpFSaAOKsMocpQFckJu1ub703
 zcEaoHM29fj6S0n6A8k9/sIAPVhD0w7rkTSPQlBckPQ26QRkyQ9v2ryrhTORpiZKAoxEJjX6OWu
 i4x8LpeLyW0l7aE7PmnKo8d5lxgs2vbDwGefnhL48eqOAnobsYYR44ZqYFGTxhEXxqPCG+QIJY3
 tFMm8ggmpBVgZPW9UFM5LQHcmvAbpGoHMrJjDfUmnc/Fnnn0WBVwnMNPQGJW0U+ILLU53HDtr0c
 pINmWmfnPrwy3BHExXiLnyVx9oiZmqGNATGTAw==
X-Google-Smtp-Source: AGHT+IHDAJmkNqCD5OVRQYErNPzD1FysKf8ZrKRriyIyM1emooHngMabVL4NBVvEKpr0BvR1WnC3wQ==
X-Received: by 2002:a5d:59a4:0:b0:38b:f3f4:5801 with SMTP id
 ffacd0b85a97d-38bf564d7femr17331418f8f.7.1737529625295; 
 Tue, 21 Jan 2025 23:07:05 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf328dc08sm15290810f8f.101.2025.01.21.23.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 23:07:04 -0800 (PST)
Message-ID: <33d13182-69e8-4f86-b049-3ba46df3fa35@linaro.org>
Date: Wed, 22 Jan 2025 08:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] target/arm: Constify lot of helpers taking
 CPUARMState argument
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250116230435.87580-1-philmd@linaro.org>
 <20250116230435.87580-3-philmd@linaro.org>
 <6e12dd1b-05fc-4094-b422-433ecba27936@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6e12dd1b-05fc-4094-b422-433ecba27936@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/1/25 13:42, Daniel Henrique Barboza wrote:
> 
> 
> On 1/16/25 8:04 PM, Philippe Mathieu-Daudé wrote:
>> When methods don't modify the CPUARMState* argument,
>> we can mark it const. This allow enforcing places where
>> the CPU env shouldn't be modified at all,
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
> 
> We should use 'const' more often in general IMO. It forces a better 
> usage and
> understanding of our own APIs.
> 
> 
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

>> I went via the "modify one and fix until it builds" path,
>> and the result seemed trivial enough, but can try to split
>> if requested.

I actually did split and will respin.

>> ---
>>   target/arm/cpu-features.h |  2 +-
>>   target/arm/cpu.h          | 71 ++++++++++++++++++++-------------------
>>   target/arm/internals.h    | 10 +++---
>>   target/arm/helper.c       | 25 +++++++-------
>>   target/arm/ptw.c          |  2 +-
>>   target/arm/tcg/m_helper.c |  8 ++---
>>   target/arm/vfp_helper.c   |  6 ++--
>>   7 files changed, 63 insertions(+), 61 deletions(-)


