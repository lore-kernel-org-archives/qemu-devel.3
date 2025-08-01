Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E0BC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 18:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhu8U-0005JC-BF; Fri, 01 Aug 2025 14:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhsah-0004BJ-V3
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:26:46 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhsae-00006L-Tg
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:26:43 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so1331334b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754065598; x=1754670398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7O/lAkOJ7n4Qw6SK8G5mUy3ma8n7Z+Ne2SgVB1qm9os=;
 b=mlRXmQwH5Zi8j2AypRt9F03Iwo130/kTU5kXwGVWL+Gmpt2OQ2q0cn9bEDEh6TTDo0
 PWPdWE46TJH30IF4dEnGZVpcIAf1pVJCwtFQKn3UCITnwXVrdxb38R6GY5qXov59sjoj
 zulf9X/lq+dSUS753uN4Bs8XzxWIj44vYwE6E2+1zdN0Pf+dE4CnjTlMdWPbhc8ijFjG
 KWAY9pgZ1xHQEdJ69M5SXplE/NexXztL0KOQi7hr3g+WcZNWupjzBfITp2BrGoKDx0u8
 Vfzwx2vo722znZ0bw5Slcnutfik1eV9AzgRJ1mP8Yhf5H9PrqIVv7mvo9rBbq/DSH5CR
 olpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754065598; x=1754670398;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7O/lAkOJ7n4Qw6SK8G5mUy3ma8n7Z+Ne2SgVB1qm9os=;
 b=t162aK8RS7qkHEEuFEZFy2fbfxLimyja8faKUcyjh7R0UewGFfxPYydCFjUJ60uMHI
 YQXja9W6JG8WRF9C+xK/dKKvbSP/U3SfU2LB4t2lo/f4AFb9+GkoZliEipYDX6PNWuCj
 d0740H34OK9++bWUx/W1oQ7buX2ax+xr+yInZ1dqIrp1R3jIHWFZh/nvfdP1HMqyKrVL
 Uo0XKFJfe3x1UhwGVa5wHdICyZ/ZOPL6MgKRfxlaLIvMacTJkFNscOamn8kNaSJFxHWR
 yLbKdtxonFTrS9gaKcRaxFJRi4/dVmaIQmMVBx0/nwvzwapXuvRROKcsZse6ecvW1GR/
 6QAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsKyLr/k5PW48b7LWtAE9A517Zg4SJ5qLFO64XK4LHBBTU1r3nLcuTAfcD/CXejD6Kjnq5V0EJ7t9j@nongnu.org
X-Gm-Message-State: AOJu0YyU+/wqW6AFl505SZCKMZviwEAqAQgJai7d/K8YojkaTq9hqlWM
 PPcHqEsHUdC+YM+XtbPHhPQttgGR4cc8Jr0YBr21SJbGwskToGovoK/oMozIxFpV9TPKx0MlTS7
 hBqKHG0Q=
X-Gm-Gg: ASbGnctQRfW3c9sd8RnP0OLmg6kRvOMNElTVa9QGZALjWIKVcPIB/m/1YSG06qdhtBr
 3iZq6W+7VCShqdlz2SpNzY3gSSezIOln2FnDBbOCSf9nV23dmOP2UNPrD02C6w7BgtFcjujanrP
 5Kt51o9EeIQucnUl95NIrMgF0bonjSj5D/9vVyKDPqMJXw8OfXkzhQU05b2Vq4zaWuhalGHj7bZ
 +iqg+WNmh2AwvVQITAID4liLKWrkHN4JzRD/Ld+i2urjOfh5p9cAWZE5TYbg+GXFR0Hky4vP1Lv
 rpGSzi3zqU9nVPtQjfyOJxq388MV3Bp4Dx4UBJqbB2F9G9ypyv8KOPsPomesGwSToKMceVSIhCh
 bKz3hPWYvU/qpcmjtn/+ob2uSryoIJEVJgFBTuijbSBZV6g==
X-Google-Smtp-Source: AGHT+IF9ebMaDwnDLv1/otjcK6U24WnHTUupFAlZ1Vfu6bplerFclohSLX1vpk7U6wUZYdTEQM+6lg==
X-Received: by 2002:a05:6a20:1596:b0:23d:7a42:52a4 with SMTP id
 adf61e73a8af0-23df910d934mr388233637.32.1754065597364; 
 Fri, 01 Aug 2025 09:26:37 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfe6bcfsm4494559b3a.123.2025.08.01.09.26.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 09:26:36 -0700 (PDT)
Message-ID: <2c337408-5caa-4e24-a8dd-d947203a1dc3@linaro.org>
Date: Fri, 1 Aug 2025 09:26:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 47/82] target/arm: Expand pstate to 64 bits
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-48-richard.henderson@linaro.org>
 <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
 <CAFEAcA_9tkv1EoM33=G=zW6Pw0gBirvjs-SsDaC8ar8feyH_8g@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA_9tkv1EoM33=G=zW6Pw0gBirvjs-SsDaC8ar8feyH_8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/1/25 6:22 AM, Peter Maydell wrote:
> On Thu, 31 Jul 2025 at 21:34, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 7/27/25 1:02 AM, Richard Henderson wrote:
>>> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
>>> index 64ee9b3b56..3cef47281a 100644
>>> --- a/target/arm/gdbstub64.c
>>> +++ b/target/arm/gdbstub64.c
>>> @@ -47,6 +47,7 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>>>        case 32:
>>>            return gdb_get_reg64(mem_buf, env->pc);
>>>        case 33:
>>> +        /* pstate is now a 64-bit value; can we simply adjust the xml? */
>>>            return gdb_get_reg32(mem_buf, pstate_read(env));
>>>        }
>>
>> If I'm correct, we currently don't expose PSTATE through gdbstub, but
>> only CPSR. This was a bit confusing for me, considering that CPSR is not
>> even supposed to exist in Aarch64.
>> Maybe it's a good opportunity to expose PSTATE instead, which could have
>> a 64 bits size. This way, we don't break any workflow.
> 
> Architecturally, PSTATE is simply an abstract bundling together of
> different information: it is not a particular format of a value,
> whether 32 or 64 bit or otherwise. (This makes it different to
> AArch32 CPSR, which really is a guest-visible register.)
>

I see.
Then maybe what we really miss are the special registers associated to 
PSTATE (CurrentEL, DAIF, NZCV, ...) which are defined architecturally.
When I tried to read EL for the first time using gdbstub, I was looking 
for CurrentEL, and finally found it accidently under CPSR.
Would that make more sense?

> The thing that *is* defined architecturally is the SPSR_ELx format, which
> is where various bits of PSTATE get saved when reporting an exception up
> to a higher exception level (and which is pretty much the AArch32 CPSR
> format when the lower EL is AArch32). (Note that not *all* of PSTATE
> appears in the SPSR_ELx: for example the SME SM and ZA bits are
> considered part of PSTATE but they aren't saved into SPSR_ELx.)
> 
> For convenience, various pieces of software pass around information
> in that SPSR_ELx format. Calling this either "CPSR" or "PSTATE"
> is not really correct, but either is perhaps less confusing than
> calling it SPSR when the context is that of the code running at the
> lower EL rather than the higher.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/include/asm/kgdb.h#n41
> suggests that expanding the existing pstate to 64 bits is probably
> likely to produce problems. Perhaps we should define a pstate_high
> or something for the top 32 bits?
>

It seems we don't expose pstate at all now, and from your answer above, 
it would not make sense to expose it directly, as it's not formally 
defined. What is exposed by kgdb?

> (I'll see if I can find out if anybody's already looked at this
> for the native debug case.)
> 
> thanks
> -- PMM


