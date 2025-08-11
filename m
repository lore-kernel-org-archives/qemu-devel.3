Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E202C87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 13:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulSfQ-0005SI-VK; Mon, 11 Aug 2025 09:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulSfN-0005Oh-0g
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:34:21 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulSfE-0004fT-A0
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:34:19 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45a0fbc6f7fso1308325e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754919249; x=1755524049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dmobd2/zHt9V/MyHoiPBWyb4/WncLJBlsPl6j0hh3F4=;
 b=ffu3BtkIsr/gtILd2RWRaqVwNznpEcUkAZGvdIO5S7uJdVYqrh7Op7nbxbYqkjx6HR
 MbPjgoCuwvsVQkIe0ZkZV0wn8mA3kP1OtwmQufx3z2426ryD949o7ZLS+6T9kp3V3Foz
 Cg4Zoq2t4TRjK/vpsaEx5trHEQ3+xoMEAI05xMSoRv3GoEFRH5/K0PvGMbqXPnuwIJp0
 TVexVqwTHaVBlrIpL6MJ1t/d2xnXP9lMC48cQM8vQIENqQg/vJPeUp++S5zKj/c695NQ
 mc7jHowMy1QTHZGQTJIYbbzR0cu28fEx8ZidECzrJp9UGX44mFtJDMkbsJjm/sYcd/RA
 /c6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754919249; x=1755524049;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dmobd2/zHt9V/MyHoiPBWyb4/WncLJBlsPl6j0hh3F4=;
 b=j/n5/W6oFxkHGxZMYIE0heOlSubiG+7HOBo5Sk2opntyEXwRKeAiRSLTD6sOJdldlY
 Glgsw3Rx/+yWQSD6jzfypC61jKmNpKSGxV0elbi5A/N8eCfE9HJ/ZsYzCMHamNyxT6vs
 S1kidpAk6w36M/PyOjM3LGatWN3EVPgqVsfUYCaXQJ+FpAcmxUO5slI2P2twNe1qIVWi
 KK3Fplzju2igfCQ8ZB3asUueL5TxvZkHVZniu0X2n7Zf555iSQ8pd/guoh1r5662Qa0H
 A8swEbtKT1HFvxKc35JYWIOyKvV68qYUdPx71aG5oe5Z9Pzr+DoBD1jZ0/07IpGDPUCX
 sH9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrlrT7IX14nXm/3YntS0coVEmHqCeKANK1yz98HG5YDWqcgg7KQoIll8aeGWbBIxvtd8ee0LB3Qgpy@nongnu.org
X-Gm-Message-State: AOJu0YyF/Hd/ljcixfBLmKwwm4j4sKkNPGvJtN7HM9t0u0GmF4JwjsZ2
 0HU6OsnjV+MQ1OvfMMKeEipPLBoc/ciJ5S+jCiRzV56SFup1C/FBSgvmstXGGhJIRnE=
X-Gm-Gg: ASbGncuX1LG3e/d6jp5u5zZPvYrNf+gJxj6anZJGixSoo5DtRV+0foFccxIxax6S1bU
 p+9+08PE2FNGHzhxq1hw3pbC0mEXDZSi/z377a5/mbLtKYbdjlxlyEQTSgUm/5sWIo7UfT1/IJO
 ZbcdMBMQufKaYSR67jmNBDe5PWFV5N28wLiKYsp3v1AbKUYFz/PnAgyPYI7KKlEYIsbyPfxfjUU
 X/i/i92iS7fguYh8nsvjmjCuw2bgHvsVfJyn5WDOAelP1xif2beuU2oBXql5nK5KyYUMfDa1bCb
 RieEj9R6zyuSxvdmJ7VHoJUvcuYIMVQzlAOJu1PVhCjQLs7hR92Hxe26XVqAvCqbU4IBz+x8DiZ
 vvuk9SvfP+1Wphy7Y4fMveB89N7OWjnaZBivDeRjOu1bIP9n5nJFLV5H1D/ciPfVtP/L5LIM=
X-Google-Smtp-Source: AGHT+IEjiKSmIZ/k4gVvdp0RN7ndl/GRdu/EJsA58fG6emkc3mQ1epqs3x9ZRUHE+Dz1ElarxcOq6A==
X-Received: by 2002:a05:600c:628f:b0:459:e3a1:a0c4 with SMTP id
 5b1f17b1804b1-459f4f36f0dmr122986145e9.30.1754919248970; 
 Mon, 11 Aug 2025 06:34:08 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5c84b8csm142027715e9.4.2025.08.11.06.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 06:34:08 -0700 (PDT)
Message-ID: <5aa47304-f516-483f-a442-90ab5a1a20f8@linaro.org>
Date: Mon, 11 Aug 2025 15:34:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] accel/tcg: introduce tcg_kick_vcpu_thread
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-5-pbonzini@redhat.com>
 <d7923560-58b8-4967-ae2b-2cabf5dfea7d@linaro.org>
 <78ceb108-670b-4be6-9d74-4521c0b6d872@redhat.com>
 <0b1f2388-a1a8-457e-a60c-3f34f6f1bf80@linaro.org>
Content-Language: en-US
In-Reply-To: <0b1f2388-a1a8-457e-a60c-3f34f6f1bf80@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 11/8/25 10:33, Philippe Mathieu-Daudé wrote:
> On 11/8/25 08:10, Paolo Bonzini wrote:
>> On 8/10/25 01:26, Richard Henderson wrote:
>>> On 8/9/25 04:59, Paolo Bonzini wrote:
>>>> +void tcg_kick_vcpu_thread(CPUState *cpu)
>>>> +{
>>>> +    /*
>>>> +     * Ensure cpu_exec will see the reason why the exit request was 
>>>> set.
>>>> +     * FIXME: this is not always needed.  Other accelerators instead
>>>> +     * read interrupt_request and set exit_request on demand from the
>>>> +     * CPU thread; see kvm_arch_pre_run() for example.
>>>> +     */
>>>> +    qatomic_store_release(&cpu->exit_request, 1);
>>>> +
>>>> +    /* Ensure cpu_exec will see the exit request after TCG has 
>>>> exited.  */
>>>> +    qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
>>>> +}
>>>
>>> So, now both cpu_exit and cpu_kick set exit_request.
>>>
>>> You ifdef this out again for user-only in patch 7, but this does 
>>> suggest that kick and exit are essentially interchangeable.  You 
>>> rearrange things a bit in patch 6, but it's still not clear to me 
>>> what the difference between the two should be.  There's certainly 
>>> nothing at all in include/hw/core/cpu.h to differentiate them.
>>>
>>> Should we instead eliminate one of kick or exit, unifying the paths?
>> In cpu-exec.c terms, qemu_cpu_kick() *should* go out to 
>> cpu_handle_interrupt() whereas cpu_exit() *should* go out to 
>> cpu_handle_exception().  The difference matters for some accelerators 
>> where qemu_cpu_kick() tries not to take the BQL in the vCPU thread.
> 
> While I'm still learning this area, this answer makes sense to me.
> If this is correct (reviewed by others), can we document it in the
> corresponding prototype declarations?

Maybe we can rename as something like cpu_kick_for_interrupt() and
cpu_exit_for_exception()?  Or cpu_kick_maybe_[handle]_interrupt()
and cpu_exit_maybe_[handle]_exception()...

