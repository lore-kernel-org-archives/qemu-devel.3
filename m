Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4837C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 16:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uByVY-0001Ez-RW; Mon, 05 May 2025 12:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uByV2-0000xK-KE
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:17:08 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uByV0-0006Kz-Uu
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:17:00 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-301a4d5156aso6126551a91.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746461817; x=1747066617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eXONwB36LUT2HpXqhT63IkJ6rNfCp4fLEe4CiDkbyNk=;
 b=qOe/bj7OyW4bLc8kLjC1O6yznElrCSr5LOs35O1jtKov+uM16Z44sMR50rPxIWADMY
 pAFOfDwM2/har9U9CMRntKdWEgDYGR7VJBlQqXUIEPS1OUp2kt69q+SV7bLFTyzzn91K
 dJTTdaHI4UvqeiLbYPGwTgxstLmQpQmSce9c7izCUU0+k/CUnwfllmRgMX82eoia7oKX
 f+lJ2lHkWpm0Qr6LiqALos/2MRSH9hLeZK5hizmAVr5XhqGknBOnx9Xn9Kaq7IhSZ6LX
 E+5rtNjcIWXXaFQIqYqS6NFs909HCN2J5Tc6V2QlHRwBEyGNPI9/ynMCNbTtirFnu3ln
 C+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746461817; x=1747066617;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eXONwB36LUT2HpXqhT63IkJ6rNfCp4fLEe4CiDkbyNk=;
 b=hqX067MiVY5Sv7wBvHEU5IHBEKOQH3odzjqH1WuGkoqbPGw2E8DUpVIq/un9aOd3sP
 AyCBr9hc/HTioDd9RugbjuD5xrUcWKFTSETuodbJq9Dxr8ELX63w5QSHv3zrGb0jcald
 4tW7pp2Kl+wHFYkrb4XIs7lIG1VtIFZX7DLutRWJZ7mUvu6feuW4W1Jr8OcdZgwuliqZ
 91nqgAiZto1hTb0SHoUc2Ds9GfbcEkE6hI94GDEvWpa1PXcjmWvllM2f/ThwT1PIRFIa
 vfwaYCGONBFIJEDO1bYifwwAqTGvpe9iky6N6UKV7/DdGnKgs2KcjAp+W6pQIrQN9wna
 s80w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKbzI0O9Ux6l1bzOeNWkgF32b/aNvBb6uWxyLxZCWy14s4LEC4dKkoIW/QFPCMhvyhJDiIVJ3xn+YQ@nongnu.org
X-Gm-Message-State: AOJu0Yy9wys4KK3SR7bWuQ6iRQgN3EGzGX6WDLA9Nf3NTSW98yGC49KQ
 bJXWcOPeAUkWVguQTQYpS4PaawF+kDikdTaJhLzdIz4oXYOrDgG/A+Y/i9jRzq4=
X-Gm-Gg: ASbGnctwqzzgEZ45YpacVn74FA7OFHZQgPSchXCJswknMoEmrNpWxW+pgRZMw0zr8cy
 IgU/INMDnfiiUUM9D6jZzuayq+nyJ+EoyBMKAzrZ06KS2+mGHCAXOPIZktQPS/vQe5UJYGLtiq1
 q39qeKbz51+E9NkQGMYiLnhC/P2fVDtILmSqtJYIVlpsvBj6new2lySMkdwUqueBg40OTm5E5dI
 uXYAguWlKoV+LApldw/jZHon7Cz7CXgNh6JMC6SwBvHcx+tsdPvcMo4u4/yVI/zYvz17PncMldp
 /PjTqJdF8ll1nVAjsRNlcOodpUoBwLjK+Bszz3NEt9RLy8E89kDibPJXi/HrBh96+zS+8Dk+C7y
 Nv8uVDPs=
X-Google-Smtp-Source: AGHT+IHeQiKJ9cZp9lI64usnUznOuZ9PVvB9kt4guGNvsTjMmBFiAOJtRe1wq9Cwn5FeDgRw0cT8kw==
X-Received: by 2002:a17:90b:28d0:b0:308:7270:d6ea with SMTP id
 98e67ed59e1d1-30a5aed5c28mr14739631a91.30.1746461817245; 
 Mon, 05 May 2025 09:16:57 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34826760sm11907056a91.46.2025.05.05.09.16.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 09:16:56 -0700 (PDT)
Message-ID: <3a084491-6e4a-470e-8322-a07a292f0611@linaro.org>
Date: Mon, 5 May 2025 09:16:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] target/sparc: Fill in TCGCPUOps.pointer_wrap
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: foss@percivaleng.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-12-richard.henderson@linaro.org>
 <e8baad5d-92e4-49c2-be4d-c9c7be4b30bd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e8baad5d-92e4-49c2-be4d-c9c7be4b30bd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 5/5/25 07:54, Philippe Mathieu-Daudé wrote:
> On 4/5/25 22:57, Richard Henderson wrote:
>> Check address masking state for sparc64.
>>
>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/sparc/cpu.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
>> index 2a3e408923..ed7701b02f 100644
>> --- a/target/sparc/cpu.c
>> +++ b/target/sparc/cpu.c
>> @@ -1002,6 +1002,18 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
>>   #ifdef CONFIG_TCG
>>   #include "accel/tcg/cpu-ops.h"
>> +#ifndef CONFIG_USER_ONLY
>> +static vaddr sparc_pointer_wrap(CPUState *cs, int mmu_idx,
>> +                                vaddr result, vaddr base)
>> +{
>> +#ifdef TARGET_SPARC64
>> +    return cpu_env(cs)->pstate & PS_AM ? (uint32_t)result : result;
>> +#else
>> +    return (uint32_t)result;
> 
> Alternatively expose AM_CHECK()?

No, AM_CHECK uses DisasContext.


r~

