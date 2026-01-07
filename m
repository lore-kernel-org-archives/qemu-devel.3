Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A66C47BEB
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 00:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdHPD-0006vq-WC; Tue, 06 Jan 2026 19:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdHPC-0006vN-1X
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 19:28:06 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdHPA-0004xf-D5
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 19:28:05 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so17047405ad.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 16:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767745682; x=1768350482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KXR2U0BXKADu7D4rjxATj7GxddPRrgoJFmEZENyPs6w=;
 b=HE5EY+/S9a1fuP/X5pEkRxrc0hnN1eHdKFfaOmxpa37D8rkIgsbJ+5EinhjFw4He89
 /0jZ1xWye1uVdG4SZcJdwpt7SPQZHEV2F7v9EZnBETSV/DoS7PM+iy/57s+at3f8mmJR
 WA/dEdOuW2xjldlZMEVOS8Ag9FBKOa7yRUCGhzFbHkUy2QAU5AjFLo3wX9Vj9qsz6dxT
 MiLMH+94Ybl4UBGoW6FWJmF/9/nagLg+5U5j/V56ByF/CE1pl9/3tth892F3y/ztLiEA
 6x30+IjDuINx0/5NbAlbFEroxBEFyjhttIxXu9Ls8Mcs5Kdn8wgxegUSKaytPpYuc931
 42jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767745682; x=1768350482;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KXR2U0BXKADu7D4rjxATj7GxddPRrgoJFmEZENyPs6w=;
 b=bIXXoIPDD1mslhR5Ws97btpx1bg8+dmPOjycSqaYuhD3a4BaG2rcDY4rgUKwBtTPL/
 8jVa7dvmlRQJhRHcRAsPYoIFXlAsb/mSzUDi6uQrXeDPYPaLXdedDmYt0NuWN6fJa00E
 4EbfUwINNTHBAIs9nUTmEP3JnsjSv+L3LhqW5uHB+y6InXLyBU7MSohDXcXBX7+8vQGk
 Dex0iIoqw34ZybiZ6TajzEh8Qn+bFPYwD6HE0FAX9VfK1MH2a1a3GLHdf0281bSxEMXb
 o1yl1CeHilh/UGguIy0cj6FGROdWGleMkvogIc0Q5YCX8j56FAjU4wjsjwkoRXtKqI4L
 L8pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ0oLXry2HK9cjoDmtspZlbpKL5QUZCecH497yef/rr8MAdztMGvwv8Rd+3rcsblqgW4OwZ6AM/siq@nongnu.org
X-Gm-Message-State: AOJu0YwEeUST1tBCSjnZFtqiuiRd0RXPaE8wkTGAegwyqfnGb9U/GbhH
 dc0bWWxeMmLDSe9xGIiBvWrCfwN/IWjYdstG1qeBf4WRaDkCb/Cuk7w7010sn4LKKBw=
X-Gm-Gg: AY/fxX66rQhDXJvizfjF5FeDGBr/+5wF5IcU+vTAUnQlcO8UMnhSpBTSJqIAp2T8kYl
 LKA3tvcgu/1lbKntDpBuf3U/P8mstWV1ys7rQJCrU/oLCIt0at37omEIrRrgZy5AF0tuhJowq+v
 sIPeHw+3giseGoePcAqoqV3rxTs7VkGjdDWLOnHmHhNIjL5W29hNGFnXJuH85NJsC/75TboVYFP
 uCa3mjTIHrE4W1h4bcePQ6sWQgZAI3F9v2o8XOinfwb32f9Fzqv/Sn9UEFdx5rHmoBmWDdLzJuS
 jXaDN3jP4Oof8x15ElmGY/qcfkf724GwmHWwx/YMQaRnpiky89gQ7z3ihb18S9iSxKN9bHjog7Q
 udKijHxLT+v73qnUDdvBVeso6FfYiCFAkdKPRow7THTQdNCscqh/LwrIC7GT6BkzOOgrg56bo5u
 9U9LTUhlJa6mfO43OUM72VNcxpE9d9gHyIawsauWeB
X-Google-Smtp-Source: AGHT+IG/JPqEc5t/w3AGsXZjNoQhACOOOYk0Yu9mAOmuGNxGregataId72v/Xcd5h737ojqQPqFi8w==
X-Received: by 2002:a17:902:f60d:b0:2a0:daa7:8a3d with SMTP id
 d9443c01a7336-2a3ee47f15amr6236065ad.23.1767745682428; 
 Tue, 06 Jan 2026 16:28:02 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c5ce06sm31853785ad.44.2026.01.06.16.27.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 16:28:01 -0800 (PST)
Message-ID: <75b13774-93f3-45db-bc1a-5b8687fcb3b9@linaro.org>
Date: Wed, 7 Jan 2026 11:27:56 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] target/alpha: Factor mo_endian() helper out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson
 <anjo@rev.ng>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260106155755.53646-1-philmd@linaro.org>
 <20260106155755.53646-6-philmd@linaro.org>
 <f465bc94-4343-47f7-8526-3fb63eed54cd@linaro.org>
 <72543341-2fea-448d-a610-76e1003778a2@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <72543341-2fea-448d-a610-76e1003778a2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/7/26 07:05, Philippe Mathieu-Daudé wrote:
> On 6/1/26 20:00, Richard Henderson wrote:
>> On 1/7/26 02:57, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   target/alpha/translate.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
>>> index 3be97057465..4f918cbfe63 100644
>>> --- a/target/alpha/translate.c
>>> +++ b/target/alpha/translate.c
>>> @@ -96,6 +96,11 @@ static TCGv cpu_lock_value;
>>>   static TCGv cpu_pal_ir[31];
>>>   #endif
>>> +static inline MemOp mo_endian(DisasContext *dc)
>>> +{
>>> +    return MO_TE;
>>> +}
>>> +
>>>   void alpha_translate_init(void)
>>>   {
>>>   #define DEF_VAR(V)  { &cpu_##V, #V, offsetof(CPUAlphaState, V) }
>>> @@ -2905,7 +2910,7 @@ static void alpha_tr_translate_insn(DisasContextBase *dcbase, 
>>> CPUState *cpu)
>>>   {
>>>       DisasContext *ctx = container_of(dcbase, DisasContext, base);
>>>       uint32_t insn = translator_ldl_end(cpu_env(cpu), &ctx->base,
>>> -                                       ctx->base.pc_next, MO_TE);
>>> +                                       ctx->base.pc_next, mo_endian(ctx));
>>>       ctx->base.pc_next += 4;
>>>       ctx->base.is_jmp = translate_one(ctx, insn);
>>
>> I don't think we need this or the next.
> 
> Shouldn't we define mo_endian() for each target for consistency?

Eh.  You wouldn't suggest this for x86, surely?


r~

