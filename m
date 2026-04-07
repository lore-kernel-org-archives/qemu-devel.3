Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A9BFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABVz-0007cs-4m; Tue, 07 Apr 2026 14:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wABTm-0004Gu-GK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:50 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wA3mF-00051Q-Ue
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 06:35:25 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so830574266b.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 03:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775558122; x=1776162922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4J6Ift+xhC7xhyDboIdkdRXdlpajdh3ah/BAd3Mcqg=;
 b=J8l+rQk2UKIQCP70WEkO8+8jqUFWhChBO/ChJnA7ZETWURpkqQ2UuIFeRUPSZ0OxtU
 sWhAfprZQeO34EdrOH5DHhn+3CrE5LBfjkxLRKzmcKYN7Url/0kYya6ccNyJOyjxXXlh
 SZYiD3BxnA+CnB/cHs+N1tMGMYuabk3tvm36K9U0UUNY7o81LT/C52+/C/0N4vmxJxQv
 7L1c86WpPUKQgS6I0lbgJiZKmHjo5U4q1SjwBwd9y9tL26MyPuD5V+ukK1RLhbr5ix6W
 GfTDm7jZNbT3/Q6IjSoeRXLj4R37o9zZgqS/nPDE8xhqGnxm/M7Tm8WLGxQa2vDO+Gv7
 a0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775558122; x=1776162922;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P4J6Ift+xhC7xhyDboIdkdRXdlpajdh3ah/BAd3Mcqg=;
 b=U8Wq30+3wEH/o4Fy5rrl5Xylad9jIjmIxXldJsTHqGfv4bw2m4mhXmahmllnTeG7dV
 knNfy6ceM74JNPfGgl6+Z4CNNjTvcMDUy6fwbSHg/MsW46xCOKlFazFdOCwqcVjOMn0E
 uXC6oGHr7nmxeOu2IC0qStvwOXGyEI4TLDAPSVU6os1oXNWbw8K2ZPvKWlkXtgqn800q
 tBgtdKWmjkYjKUte/+fwI2TcKjjlnqwoctZQfJPQRWuqEWdOXniVi6LSLo4mVzNB/5D+
 2ksj4UdDlCurawlkqFZLFrFb8rg0ZxhF0lqr/9o6+cyGszarGw+vM+MJVhXhKTMepm/m
 YYbw==
X-Gm-Message-State: AOJu0YzA3VaJPtgPLPZzs1LYa6DQ+OLfh3hepC+Oj0EXQUirbu6UmULd
 8slgPHAd61TeAZ1TyWv/7UTBMPQpGHJFyhGqoYKS71nmbESJXLjYs1LlNcrTJa51Y96wE1PXIHJ
 OtYqJGpk=
X-Gm-Gg: AeBDieuH2aF4TUldLRIvTvNsUZuJwPQe5EvVu0nh7EOw9h5VRBw5EkRsvQRxfkygn1k
 OWTMKPqIyG2NZn6T34V8NvojJTBnWD29Z+7m6seHhIIAa3sibJ7IT6ngAxHT79f6e+ZIg1maH/R
 HbyYV/wYLjRitLQvjJSVAfjzNFcJ2kHE/iEQofYPjRH07IDBfPOZEfrH76V9QmIWqFiY+ejGIhG
 9LPXN4aVoDJAR6XEU1nzo2idg+8fYZ978u6z90zlu1r0FOo5XoYb0IRlm/Za6xnb1hq873w+fuH
 dSvIbIupsvIAaTga6rtXz0opOeNjaiCVxiH57IP4Mg+dL04zw9G3bnHUAfcqu7iuR2at0yya2rh
 t/tqh/Gv3s7tF7wnOPwgyvyPxIv/AY4VBJIYJ0oUT7ddv2RjDCwgH0Kunmr3oS60sOzarmMNbiw
 fMb3AA9heLtn6nT4/TEGRLxcI=
X-Received: by 2002:a17:906:9fd0:b0:b9c:451b:234e with SMTP id
 a640c23a62f3a-b9c6744651bmr864559266b.11.1775558121889; 
 Tue, 07 Apr 2026 03:35:21 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3d028831sm535165566b.59.2026.04.07.03.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 03:35:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 778745F9CD;
 Tue, 07 Apr 2026 11:35:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 27/35] target/arm: wrap event_register in a union
In-Reply-To: <0877e0da-c083-4293-bba2-5c1d2e2315b7@linaro.org> (Richard
 Henderson's message of "Mon, 6 Apr 2026 10:37:17 +1000")
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-28-alex.bennee@linaro.org>
 <0877e0da-c083-4293-bba2-5c1d2e2315b7@linaro.org>
User-Agent: mu4e 1.14.1-pre1; emacs 30.1
Date: Tue, 07 Apr 2026 11:35:20 +0100
Message-ID: <87zf3fawif.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Richard Henderson <richard.henderson@linaro.org> writes:

> On 3/21/26 00:05, Alex Benn=C3=A9e wrote:
>> While the event register is either set or not due to the
>> implementation defined nature of bool types we can't set it directly
>> from TCG code. By wrapping in a union we can alias a 32 bit value to
>> the bool in a future patch.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   target/arm/cpu.h           | 9 +++++++--
>>   hw/intc/armv7m_nvic.c      | 2 +-
>>   target/arm/machine.c       | 4 ++--
>>   target/arm/tcg/m_helper.c  | 4 ++--
>>   target/arm/tcg/op_helper.c | 6 +++---
>>   5 files changed, 15 insertions(+), 10 deletions(-)
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index bf6cf74c2e1..9c25b60ae83 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -763,9 +763,14 @@ typedef struct CPUArchState {
>>       /*
>>        * The event register is shared by all ARM profiles (A/R/M),
>>        * so it is stored in the top-level CPU state.
>> -     * WFE/SEV handling is currently implemented only for M-profile.
>> +     *
>> +     * It is treated as a boolean but we need the union so we can set
>> +     * it from TCG.
>>        */
>> -    bool event_register;
>> +    union {
>> +        bool as_bool;
>> +        uint32_t as_uint32;
>> +    } event_register;
>
> What are you attempting here?  This smells like a big-endian bug.
>
> TCG is certainly capable of storing to a bool, via tcg_gen_st8_*.

So the problem I had was I don't know what size bool will be as its up
to each architecture to define the size. I originally had a compile time
assert but that failed. Hence this hack to put something that would
plausibly overlap.

I wonder if there would be a way to use a Generic so tcg_gen_st8_bool
would always map to the right size whichever arch we are on?

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

