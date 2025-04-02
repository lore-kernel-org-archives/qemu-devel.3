Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EECCC36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 20:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u04Sw-0003RJ-K9; Wed, 02 Apr 2025 16:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u04Sv-0003Qx-BE
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 16:13:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u04St-0001cX-4y
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 16:13:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so1289735e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743624812; x=1744229612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hyJHGJVM0y7gQtDe2UrYLgglTL6Yr+pC5jHcpInzBG4=;
 b=kdRZFDVCCwKR7Fj5MUZwbXOfQamhdtJChKOvNeGyWG/zvVyyeNObthdEwff8kOEhLL
 OgWxNmEi2a7xR9RGbi4rarzC54zI5d8/6tInwzGj2cYR8J4MZKzVSD7UdRGshWk6qQ/W
 M/lTHYAeS+mK/JitMprkKPELLXp3sDIrz8ELX7CWQZ3Nos/8ET96kNa54r6pFmFCAUfb
 sshAAV/spT31s3ST4YH+Vqi6K5tTRLnYiYZuybezMG+sEZhIUq+Wi4i7imOmGtVRZJMg
 Wc5M6KtIuKoLgEssqaSNkNyn5z/5LU0497WcSMlgIkEKTtIOr6Wtgkpgsd1bnMOjtoAV
 HWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743624812; x=1744229612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hyJHGJVM0y7gQtDe2UrYLgglTL6Yr+pC5jHcpInzBG4=;
 b=EgYVc4yJ2Rid04DQ5E1xg+A5CHGOird5l1h3gepazEopWyJ/y4WXrx5N/yCIHEtUIS
 kN+nZE+kkmtH9muYPsT3rXpjLZa2mygfMIIZPddzTZf0cYKiye5OJK61u3n3Kf6cqkI7
 i+G67ojLj0zBHe/nwMHqirDipx7RGriwnW1tgZ/R7FCW5IKmlu21bBA9mjmUB5zifCrH
 mQnhZ7ZufhQP5uC35tdz9vUCFeX81Xi41xhkcTkJsyxwxpfD+02iZvN8Y3b8u5xz9PeO
 HBErl+/YqLypxMCLpNIkEt20zxKraDD53ykgUvG51DGwmMIUDtSEef4hYBylHuLDAff3
 8/+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW340A7ubri20TQvYB9iw3wx1mW/+xAY3/heL0Q3M44nSWRNO3xL9WJOUidQotP6+seZOfRVLWsOOXK@nongnu.org
X-Gm-Message-State: AOJu0YzNiyTLpQi0PxBDmG1ZEvOBw7tgvZQkgadIxO695QY2uUIrHmr/
 TQ6plqEFIK0UqM5kfzgpUYeFXcpwtLhlJ12NKwu17bT+bVm2PPZPYulY8GFcyNs=
X-Gm-Gg: ASbGncuf4mSA0dSvwauN0wx70wZE0+9fLXgv/nJnPV5nAFR9hjycc/L++7WpAzivDEp
 DisbWhE3jWhtni5qrft/jIvzxrrAfn7vTo14ztPtdImkE5zOnzeiIlaToZqv0KYNlRHASo5139J
 AuENJ/4v+hJ0aqDRBdA86rRUsLGo4UDdLd0WGUf/PhqFdVuU60pY9jesnFQx4yX7wiQPBL30aV4
 p8pROhFfuZEnWNG5Vw0N9t07RmgH6BcvpTPSRPcLonFLZ75KXisMGp2g1W9bBGon7bt3E9t3kWX
 X2H3G8C5j3GwDKJRGn+MnmK/7W38ZPBBTZy+R5BpLY/vh242tLB41R/xwGqSXsPO5w9af4pdGPj
 Bl1LBGSJZBZjp
X-Google-Smtp-Source: AGHT+IGPXaidrTdE20mCq+0ZNBWQx/srl+TgezuFycnADxGQ4SEJF3YQgodedKriJXY7vllnW5Xzsw==
X-Received: by 2002:a05:600c:4fd1:b0:43c:f6b0:e807 with SMTP id
 5b1f17b1804b1-43db8527142mr191723025e9.31.1743624812015; 
 Wed, 02 Apr 2025 13:13:32 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a422dsm18110862f8f.93.2025.04.02.13.13.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 13:13:31 -0700 (PDT)
Message-ID: <aae2c395-4649-4281-bf08-4104917aa3c6@linaro.org>
Date: Wed, 2 Apr 2025 22:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/23] include/exec: Split out exec/cpu-interrupt.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
 <20250308225902.1208237-6-richard.henderson@linaro.org>
 <b240dea4-082c-4bdd-8dfb-45d444ae12ef@linaro.org>
 <6b3e4490-781f-4337-837c-3ed38483332a@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6b3e4490-781f-4337-837c-3ed38483332a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 2/4/25 20:46, Richard Henderson wrote:
> On 4/2/25 03:17, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 8/3/25 23:58, Richard Henderson wrote:
>>> Some of these bits are actually common to all cpus; while the
>>> reset have common reservations for target-specific usage.
>>> While generic code cannot know what the target-specific usage is,
>>> common code can know what to do with the bits, e.g. single-step.
>>>
>>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/exec/cpu-all.h       | 53 +--------------------------
>>>   include/exec/cpu-interrupt.h | 70 ++++++++++++++++++++++++++++++++++++
>>>   include/exec/poison.h        | 13 -------
>>>   3 files changed, 71 insertions(+), 65 deletions(-)
>>>   create mode 100644 include/exec/cpu-interrupt.h
>>
>>
>>> diff --git a/include/exec/poison.h b/include/exec/poison.h
>>> index 35721366d7..8ed04b3108 100644
>>> --- a/include/exec/poison.h
>>> +++ b/include/exec/poison.h
>>> @@ -46,19 +46,6 @@
>>>   #pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
>>> -#pragma GCC poison CPU_INTERRUPT_HARD
>>> -#pragma GCC poison CPU_INTERRUPT_EXITTB
>>> -#pragma GCC poison CPU_INTERRUPT_HALT
>>> -#pragma GCC poison CPU_INTERRUPT_DEBUG
>>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_0
>>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_1
>>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_2
>>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_3
>>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_4
>>> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_0
>>> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_1
>>> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_2
>>
>> If I understood correctly yesterday's discussion, these
>> definitions are internal to target/ and shouldn't be used
>> by hw/ at all. If this is right, then we need to keep them
>> poisoned for hw/ code.
> 
> No.  They are used by generic code to mask CPU_INTERRUPT_TGT_EXT_* 
> during single-stepping.  We don't know what they mean, but they're all 
> external interrupts.

I'm wondering about CPU_INTERRUPT_HARD ... CPU_INTERRUPT_DEBUG.

