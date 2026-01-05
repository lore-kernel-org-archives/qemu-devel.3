Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4531C2A099
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 11:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcj2P-0002w2-9P; Mon, 05 Jan 2026 06:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcj2D-0002st-M2
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 06:46:13 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcj2B-0005P4-4A
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 06:46:05 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7aae5f2633dso14556703b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 03:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767613559; x=1768218359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cbDjOVqIGteFc5iDKNL2pbIYz3DrQR6Vlr70wVlaNWw=;
 b=WManrdC7FbAFKULzK6AatOI3Ys6l7MMETYfraQOCD+1RMpVfDGp9zyDUQ5NEQXmamp
 ErERVX0Ij+tvzUWgJbLyJujdEib9WyzIrhP6OgsREzSnpwjmH69VAy6vgyiRrQxhdQJb
 +4FAY1e1H2fzGxHbSOelopKlEHbI0EHNd+106CMhshyTCZFBoToYPbHaH8sYsbbBph5P
 Gs7bUs1MVl6l/CgIJEZKpG70AiJSyfhRQLc6kYEG4DnU1rSzUaUH+oiqxCu0JhQAmWiC
 AOut0ZSUPqurYrg5FMctaX8wH2eu5Rl9uCg7Ktq9KDnBT5OPREqm2wx6cn1BZfV4si36
 uoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767613559; x=1768218359;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cbDjOVqIGteFc5iDKNL2pbIYz3DrQR6Vlr70wVlaNWw=;
 b=ppAGv9p2O50IITUkMdFrUzGGpe/ieUGEA+oLGgbzbN9R3wFE3oNzL5eqeX2FTura1O
 fjX6vUhBpZ8sM6rIAAy3KmYqSY4Ik1CSMluSGFnevMQzXlE/vpimSBYDqSNwCN/zzYwD
 0tybu4LUF1MYB0v/pkoAZu1a4CfYQarqoE1LNzzTMdl7mi1WxQFHEfAIe7Y4TxrW/MgA
 6kTLwX0d2spQFeLp/SIUtQgmdZGhIWNhmaYMg1cobGVQ+jAHesXFjJudgIetHO5srgM4
 FYATQZ4p3OPmIL2GaLova5Y1yEFLiVYiQwOz3YO/b7m5iIIa1r/vZngDi4kwKGub9ooZ
 X6pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2OnpNG9kJ7yJX+K41RiXlyuyRrl5z+6EyEVEJ0hXSehRrqyTzHyLoZV7ETYy/E2bYKAdAGAHdlJh0@nongnu.org
X-Gm-Message-State: AOJu0Yy/xLFoqocxwkt6SVKG64mGJykqsIkRqWmk5lfkHyHkSc2tlA5O
 9cYqhlygrj6HijK8WGEJtWLK3hUy9h3Bt0fHjQFepjT+Nc5Rzav+03IkADWkZAtLyiU=
X-Gm-Gg: AY/fxX5ZpgLpn5cg941z3ybjp82IMMjlQP3v2mPwHQhxhxYwR+15ThLg/5w259Yr/Wi
 5irOfmUwcsgldg5qSaKYL2CB7wQxF5y32ui0fQ+iynXu+Vn96EDTZeFP60xflD4BWZpjQlSexXB
 O5FVE/fkxf2EL9bYNZZvH3F8ivaVNJwSLfInQ4gAbhoYU+Jc0DGevO21sH7BgUL3zIsln9JUt2w
 HzLHQ4tQ/A+/y0jtgPOG/ODsFaRh78Tq4KwfcSDuBjoLOod8pN7nIQohijOe0ZAgTf6XUFZjiey
 kxVWb5N6o7GajsUAn3SBWVJA8rM3TA+Q4RA2Hz0yq2+7fRELZk+ACPZjV177YslfllKtZeLeQ07
 sNf8HGAYWZEKqBqa28rEFXHU2EfyZWxq/lX8SQfRi2osihFTDEmakaKDe1rrU3Rf7lWohsRksyu
 yWaPpm1rhyghvVD9CEVy1YSORxImDz/A==
X-Google-Smtp-Source: AGHT+IEEng14EIVtIT7uClXOQ0JNGruyQYYlG9UCwmZYBrkU+eRBRJVHiFPSzpyNOwbQJMb2ronIzA==
X-Received: by 2002:aa7:9318:0:b0:7e8:450c:61c5 with SMTP id
 d2e1a72fcca58-7ff6667cb84mr42420707b3a.53.1767613559502; 
 Mon, 05 Jan 2026 03:45:59 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7b5236b5sm47636148b3a.29.2026.01.05.03.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 03:45:59 -0800 (PST)
Message-ID: <0a04dfd8-1c8c-4d87-99b8-d0e3cb9329d6@linaro.org>
Date: Mon, 5 Jan 2026 22:45:49 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] target/sparc: Simplify gdbstub
 sparc_cpu_gdb_write_register()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-9-philmd@linaro.org>
 <a48503cb-0a62-4cc7-83ff-393945dace0d@linaro.org>
 <854a4169-0f9b-4f10-a519-0410b799cb4e@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <854a4169-0f9b-4f10-a519-0410b799cb4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/5/26 21:56, Philippe Mathieu-Daudé wrote:
> On 5/1/26 01:37, Richard Henderson wrote:
>> On 12/25/25 03:26, Philippe Mathieu-Daudé wrote:
>>> Rather than ldtul_p() which uses the underlying 'unsigned
>>> long' size, use the ldn() variant, passing the access size
>>> as argument (evaluating TARGET_LONG_BITS / 8).
>>>
>>> No need to use #ifdef'ry to check for TARGET_ABI32, since
>>> it is 64-bit:
>>>
>>>    $ git grep -E '(ABI32|LONG_BITS)' configs/targets/sparc*
>>>    configs/targets/sparc-linux-user.mak:5:TARGET_LONG_BITS=32
>>>    configs/targets/sparc-softmmu.mak:4:TARGET_LONG_BITS=32
>>>    configs/targets/sparc32plus-linux-user.mak:2:TARGET_ABI32=y
>>>    configs/targets/sparc32plus-linux-user.mak:8:TARGET_LONG_BITS=64
>>>    configs/targets/sparc64-linux-user.mak:8:TARGET_LONG_BITS=64
>>>    configs/targets/sparc64-softmmu.mak:6:TARGET_LONG_BITS=64
>>>
>>> Directly expand to the big-endian variant (with the '_be' suffix)
>>> since we only build the SPARC targets as big-endian.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   target/sparc/gdbstub.c | 12 ++----------
>>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
>>> index 134617fb232..d265681f6d2 100644
>>> --- a/target/sparc/gdbstub.c
>>> +++ b/target/sparc/gdbstub.c
>>> @@ -112,15 +112,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, 
>>> int n)
>>>   {
>>>       SPARCCPU *cpu = SPARC_CPU(cs);
>>>       CPUSPARCState *env = &cpu->env;
>>> -#if defined(TARGET_ABI32)
>>> -    uint32_t tmp;
>>> -
>>> -    tmp = ldl_p(mem_buf);
>>> -#else
>>> -    target_ulong tmp;
>>> -
>>> -    tmp = ldtul_p(mem_buf);
>>> -#endif
>>> +    uint64_t tmp = ldn_be_p(mem_buf, TARGET_LONG_BITS / 8);
>>
>> No, this changes the behaviour of sparc32plus.
> 
> $ git grep TARGET_ABI32 configs/targets/sparc*
> configs/targets/sparc32plus-linux-user.mak:2:TARGET_ABI32=y
> 
> $ cat configs/targets/sparc32plus-linux-user.mak
> TARGET_ABI32=y
> TARGET_BIG_ENDIAN=y
> TARGET_LONG_BITS=64
> 
> Isn't it the same?

No.  ABI32 uses uint32_t, not uint64_t, even with 64-bit registers.

Which is probably functionally broken, because, history.


r~

