Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040F1C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRdO-0000jD-Na; Thu, 16 Jan 2025 10:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYRcq-0000Vm-KY
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:17:42 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYRcm-0004wt-K9
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:17:39 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216395e151bso16278565ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737040655; x=1737645455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/wkcKaFRXPhb9u/VjkQNV6F39YFmaAYeWGSbaUleCvA=;
 b=crCnsZPedHB/2yGB3L72Y7Kw5R2ZqY27gG9Punh3PDc22mOnaEwh+nApunDUQL4n81
 UL/Rgh94Pgt3pJQeRCH0kw/Icid6CB4hQ+AM1wgr57sNEol6fa4DU0S21D9ZmSZ7xBl0
 V1a1tGXbDvn4OMomNecGcUP940BoP/hlnYKm0tJm2ASaWMl0Q05OTB++VpggZTGlCVlE
 7txQtgsVb2FUVU21vE+Wv1JY1spYpdgDMNAZ74E68+2EHw8ctQry/1SNp+8Msd17uD7J
 eZvHXUe/5lF1OqSzKhXApH+KDxucpeB5/4gqPqrzx6pl1MHODOw8Y7wMzbwCWIwCtrVB
 EVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737040655; x=1737645455;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/wkcKaFRXPhb9u/VjkQNV6F39YFmaAYeWGSbaUleCvA=;
 b=UVCWLmTh2mwvK6BvQ8+ih5RyJPLSrIMeOBC3wYxDy2tM7NrV4ne/e6xwhnzU/C35OB
 UvXkoSvYr76oAdFfQR25Xmc8eG1ZjmRVWxGkkXmOKWPo5iFvS8FiQPpTUXi8VRI0TJ7n
 92m1z+r+vRWJ2yIv/jRXbaWrP+MYexgM0d8Zw39nJSLhm5NLh+Z0kOj/60JLJoS0SrT2
 Pw6EQ3HXV9gyGtFnjiH6diyXOnUqbdEkszJWINFJqBV7r0grS2qH81xLy1flmLKa63jS
 BiuhLc8ak0jyBXCAxlAh7YKf03UGT0+p9PdS1YJVv2fdjD0rtzflGTdSomo1JxheKzCl
 fz4Q==
X-Gm-Message-State: AOJu0YzmX6BGM8IvTClvD65DZI1vYdmKdcd+B+SInaOX5m7LnlHOY2iQ
 /vuXAF++ol1fTBLlDck9A0e9DfJZErfMZYDF1aajNZrcRtPci5IqpQndO7vd1kc=
X-Gm-Gg: ASbGncsI4XTZLe4D+NC0RyRdr8elzUDxvlLQ/6KzEKgUMh6p/zmTVxYdKd8MD8804eU
 LDSAC3aaQcE4bwdUMCyR/oqpxl8Z9xvV27JcoAyBlG6E7anr0lgx2ydorHjQMCloBRAqzrWlFFB
 rlrXD4rVK0ncruPEWvlHW8lIlUZ0lHdBtHJBRpJoBjmO5PyVTKRtv0PJRnREPnv6b4gJMG8t7FB
 pdDyOF5OIdnS2xIL7T9wDbs6FCur8BsQfzoVGosiCFGnO2ihxEo+KIMC7Gh1Cckt3LOzbME2Sh+
 JNBmLC3gDPnZEidAr/8nTik=
X-Google-Smtp-Source: AGHT+IEfzlm7jtOVDtwr600aEKhLJajW8VR5GX7n6VGfQze1VHc8T9OCqJ8qwi8mPBY0mFrroYKt7w==
X-Received: by 2002:a17:902:f605:b0:216:33f0:58d5 with SMTP id
 d9443c01a7336-21bf0cc0464mr113292745ad.17.1737040655135; 
 Thu, 16 Jan 2025 07:17:35 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3ac0b2sm1582725ad.156.2025.01.16.07.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 07:17:33 -0800 (PST)
Message-ID: <e344e8da-8460-42da-850d-79623daffa06@linaro.org>
Date: Thu, 16 Jan 2025 07:17:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20250115232022.27332-1-iii@linux.ibm.com>
 <e74110e7-2dc4-4626-b64d-f42e3ffe7413@linaro.org>
 <5bd1b396d06a3ab42a98cdff25a1dc2051e98b0b.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5bd1b396d06a3ab42a98cdff25a1dc2051e98b0b.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/16/25 07:06, Ilya Leoshkevich wrote:
> On Thu, 2025-01-16 at 06:54 -0800, Richard Henderson wrote:
>> On 1/15/25 15:20, Ilya Leoshkevich wrote:
>>> Currently single-insn TBs created from I/O memory are not added to
>>> region_trees. Therefore, when they generate exceptions, they are
>>> not
>>> handled by cpu_restore_state_from_tb(). For x86 this is not a
>>> problem,
>>> because x86_restore_state_to_opc() only restores pc and cc, which
>>> are
>>> already correct. However, on several other architectures,
>>> restore_state_to_opc() restores more registers, and guests can
>>> notice
>>> incorrect values.
>>>
>>> Fix by always calling tcg_tb_insert(). This may increase the size
>>> of
>>> region_trees, but tcg_region_reset_all() clears it once
>>> code_gen_buffer
>>> fills up, so it will not grow uncontrollably.
>>>
>>> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>    accel/tcg/translate-all.c | 16 ++++++++--------
>>>    1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>>> index 453eb20ec95..6333302813e 100644
>>> --- a/accel/tcg/translate-all.c
>>> +++ b/accel/tcg/translate-all.c
>>> @@ -531,23 +531,23 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>>>            tb_reset_jump(tb, 1);
>>>        }
>>>    
>>> +    /*
>>> +     * Insert TB into the corresponding region tree before
>>> publishing it
>>> +     * through QHT. Otherwise rewinding happened in the TB might
>>> fail to
>>> +     * lookup itself using host PC.
>>> +     */
>>> +    tcg_tb_insert(tb);
>>
>> I think what we need is to mark the tb CF_INVALID before inserting
>> it. That way we'll
>> never match in tb_lookup (comparing guest state, including cflags),
>> but *will* find it in
>> tcg_tb_lookup (comparing host_pc).
>>
>>
>> r~
> 
> How can tb_lookup() find it? With this change, it is inserted into
> region_trees, but not into tb_ctx.htable - this is done by
> tb_link_page(), which is not called. And because it's not in
> tb_ctx.htable, it can't end up in tb_jmp_cache either.

You're absolutely right.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

