Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368CEC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 19:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC13K-0001NV-Fj; Mon, 05 May 2025 15:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC138-0001BK-4A
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:00:22 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC135-00088m-Rf
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:00:21 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-30a452d3b38so4031746a91.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746471617; x=1747076417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7J3bEn0XzWtghFNJ8ChervkRgSNnpRWnta11ofNV6t4=;
 b=Z18v2FIqc7/8GfAaFHuvRGHNm8p4U0ZoOiDsAeK/e0rr4XUIwUDsjn2lGsB2P132yW
 Y4CQn1yTLgUW24b4MVPt6xVQCXp844m97xS+htEt9i7WjbYgYHkBtlYUuWwac/EDJGJU
 Sv6xT8110hLtB6AZADEJQPis+RCW54YbQz0EMswd+qj6swdgmyt01LfFmMz4GVylveZk
 d84areYrla3kEiC2fnEb9DEoTHbzJLE+S9koaSbMRZfLE4GpEgmg4bw0+OLXi5/TbIos
 0Rxh8TGLyMzUXPiK0CzjjXXJV+IJAfyd6J7uce/mS8u3ijoGBSLMMab/bite9DQrtaKd
 vVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746471617; x=1747076417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7J3bEn0XzWtghFNJ8ChervkRgSNnpRWnta11ofNV6t4=;
 b=nm4VPF60YviHSDjZuMYCDEnx2nsZdCJv+KIUcmmGWWmK5EweYXT+k6jRN0nFpr/ezb
 mHYoEmJpGLCWQLv5cbsQyLn70Bz7TFSV2eRuOmD3JSIX10muPOK2LpbPj6YmIWxkiwIP
 dcfqT134fdrE39VNFZQHeahb/z6cGJjKp1uPB4R7TXkq7NZzoJ2QI3/rHxSJy7UTWK9e
 QTXb9aRx0+E03tr/Qfjg2xBS/6mBKzqnDi2hHEC6ap+7vvI9FVHixmFOhJ3sbLGzCklX
 dum/hljeLrhFdtAZB1SX3D2MXNTKmK3J4SAEgKn/VzE6nuAtyCo3t57Pzu8rHhAyiLfE
 LcZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEYhDz4OecG9ImQTWvshSE6R5hvPJGNI1Znjdxn3Za6C+TAzvrV18C0cZd7z4nKtTTWy/X1IRBl6mV@nongnu.org
X-Gm-Message-State: AOJu0YyhQ9rbZh+wnb+Voz0Vs7eNgmbTSbo/oMC9o6Nj6zhb1CTmEK4B
 Tg1ZDvtvGCqF1dU8oD8jfY8GhaXkkvYp7sQz3HX0uIqQ195fl++OMlxpF/sMum4=
X-Gm-Gg: ASbGnctXsRe2SJI5A1Uz2PBlHK0yOmcDkrGfHwYZ4waPhkVxAb6s8Gl4MCePMqTLabe
 MJCPDpH5ZgRcNDbVebdxDiT7wzFbXfkTW2xw8ptGLYwZm4JdRvgjLCe1m+pJHzXFWk0ZZWGhY7s
 5fk4D7X/H+4k40S/jhJ71uAhTdNB4rEWDxei4vtuVJgr1GAtft7wgCPVyFecx57fvBpWXjrLkby
 mPcpC7L9MLVgNXITiDtXeOEYvBgX60/GeLa+u+DizVCzHZ0oooizHYZ4tpqmed4JJfUEViDyoq2
 T4qsvH7r90lL0/LntoJ3ZLE9BECGM04zFe8hWI+zkctQBXMo0xhkO2gDxyua014jTUvgkbU+5zx
 hv0xVE5E=
X-Google-Smtp-Source: AGHT+IEBAv+/F2Uw+pTXsIUPnecV2k3as5EwZIcWPeiJ1X9HdHurhzBTLgQtYATtzty6VBCwpFQ2NA==
X-Received: by 2002:a17:90b:1dc7:b0:308:5273:4df8 with SMTP id
 98e67ed59e1d1-30a4e5a57e5mr25470638a91.10.1746471617026; 
 Mon, 05 May 2025 12:00:17 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a47625a85sm9337345a91.37.2025.05.05.12.00.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 12:00:16 -0700 (PDT)
Message-ID: <06ee617b-f5ea-40ae-9514-d325f79b4832@linaro.org>
Date: Mon, 5 May 2025 12:00:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] target/ppc: Fill in TCGCPUOps.pointer_wrap
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: foss@percivaleng.com, qemu-ppc@nongnu.org
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-9-richard.henderson@linaro.org>
 <e59a8b0f-7342-4fa7-aec5-98aebd2fa70b@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e59a8b0f-7342-4fa7-aec5-98aebd2fa70b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 5/5/25 09:50, Philippe Mathieu-Daudé wrote:
> On 4/5/25 22:57, Richard Henderson wrote:
>> Check 32 vs 64-bit state.
>>
>> Cc: qemu-ppc@nongnu.org
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/ppc/cpu_init.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>> index cf88a18244..1f18967b62 100644
>> --- a/target/ppc/cpu_init.c
>> +++ b/target/ppc/cpu_init.c
>> @@ -7386,6 +7386,12 @@ static void ppc_cpu_exec_exit(CPUState *cs)
>>           cpu->vhyp_class->cpu_exec_exit(cpu->vhyp, cpu);
>>       }
>>   }
>> +
>> +static vaddr ppc_pointer_wrap(CPUState *cs, int mmu_idx,
>> +                              vaddr result, vaddr base)
>> +{
>> +    return (cpu_env(cs)->hflags >> HFLAGS_64) & 1 ? result : (uint32_t)result;
> 
> Alternatively expose and use NARROW_MODE().

Again, that's a DisasContext thing, only valid during translation.


r~

