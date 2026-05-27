Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3E4CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGA3-0003Wt-GA; Wed, 27 May 2026 11:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSG9o-0003Tf-Kt
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:27:03 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSG9m-0003dA-Ux
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:26:56 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c8025aecc40so5466254a12.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779895613; x=1780500413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ILCVxiLOiVg+g6Pjgfzl5arsUOrVOLofq1UK5DFGc4o=;
 b=fVj3WhfLelfps2beBVbPJGq6YDSyZDq1iZQIppBP/pt1j+ec7W8YzVqcnYjF01C5qy
 wiekQqajJJl8uwNPXO2ppq+NTVvO/NwXXp5Dp9YY8wb6+MrlsFhTnZjMXEXBUOHwLwqK
 brYFv0GX4N2LoQ+QhvIGcbZji8za8nlK+b9gVrl6BPLWkP8qeLfSTDzPEq13nxBGwEWT
 WOHjGKChB7y5yzkDDw7TZbNWcvOIqPaWONb5AsuVa7FjWTpNn2XaOa3juCZ9tTKehUse
 6/KmuoiyA2UHDMVgP8RlUq+2Js0sy5NgUPcwbxPbXydp34V9EEeVnmzh7zMQ1HYjTGyl
 0EUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779895613; x=1780500413;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ILCVxiLOiVg+g6Pjgfzl5arsUOrVOLofq1UK5DFGc4o=;
 b=cFQaRxzwgYVTgvG1iqBX8VjR9e/eC05xt2dT3f485V4u0NKupoH0hP4SwCLjdF4hin
 2bXl7FwXz4eLFifUPI4GOPwZntNbAEY7gh09WWYyjXhS4G3OSZ2WCc+cp9F9k2DscPuN
 /VMiea1MQDLt79GTrjI5JJOHlhychgnOs3pwvl+EVky73e3A+5wrG4GEcJRjm7u7GXWD
 Y7s79taKfSFuVzlY2ZZbkklHp8F/RfvClSgTZ2vGC2bCi1Kr4+zpczyJSr7nFfZjk2Zw
 evo+BG+zyVjyMinDhc8KtFYTVZK2BtLAfNSQhwCxqpxB9sYey0h0eXoRZw6AzpMe3G0f
 y5cg==
X-Forwarded-Encrypted: i=1;
 AFNElJ89cJFgWVk10LYDHv9WTZnKKEqrmVxC+oUj3YWCxd5YEV7x1lX7jk2VaNZGsAR2mvxrL1ACkfSxpjMV@nongnu.org
X-Gm-Message-State: AOJu0Yy8nDQeh1bY8K2vJzEq1HhsliBYNQSXYCcB8Ai+6ddsiMc9AnW/
 ylQPlTea7JA7LW10xilGUyuuFZqFHzswlxWNCIfxU46gY9c+bZdLb/drKqoUtgiNEYM=
X-Gm-Gg: Acq92OHybj0B6xctdJ/RPal1EEV19EkeBxYcyFr7ivqEMZ1HQ5DmOEwQpkRbLxNejh2
 eso0YQmRLfiy5E+6qJxFmCQ97XRQSgRxU1S2zGufCMmflTnnbjbd2L7DBC5p71+RKkNqU7YnBp3
 plt33ucwRB7iqCZoEA0BkBWTyCiaB/pz6ED7W/bjK2LrY8nNeVfS4ozWA2HatWsFdz+vzB8YGKL
 P9ggUpN/CpHp+JUErNPRyNJi0765GosdEu46gJSQ4tcs0O6+IFG6Rs5XEcBQ75/59TMWVXKZ3OL
 ZksNuaRjkrhtV+69MhFiEXaXNfPW2B4Fwc0XI5qyH/PMc8jMFRoD48nzWf/jvV+E7+SfJSWODxN
 Ma7cgTYXQb5SMH4R10RFnYkUTNT4CUPlipSNaqqVdB71I3suYtc49+Ts6bbPMD4BIwdhjsdXRol
 tWIOhAiUWF+bYTmOM/fFYw9wVg7rIqghQlhVnniSIL756vmaQ=
X-Received: by 2002:a05:6300:68c2:20b0:3aa:f9e0:7a29 with SMTP id
 adf61e73a8af0-3b307fd0643mr14357941637.37.1779895612510; 
 Wed, 27 May 2026 08:26:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8520561e94sm14181051a12.22.2026.05.27.08.26.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 08:26:51 -0700 (PDT)
Message-ID: <5479a7e3-fe6e-4399-8c20-5a8136957030@linaro.org>
Date: Wed, 27 May 2026 08:26:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sh4: decode_gusa: recognize add#imm with prior mov
 Rm,Rn
To: yoshinori.sato@nifty.com
Cc: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260525152739.4122267-1-mattst88@gmail.com>
 <20c744a7-369f-4abf-93f5-c6553c3340fd@linaro.org>
 <878q95asor.wl-yoshinori.sato@nifty.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <878q95asor.wl-yoshinori.sato@nifty.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 5/27/26 06:27, yoshinori.sato@nifty.com wrote:
> On Tue, 26 May 2026 09:55:28 +0900,
> Richard Henderson wrote:
>>
>> On 5/25/26 08:27, Matt Turner wrote:
>>> The gUSA pattern matcher rejected `add #imm, Rn` whenever any prior
>>> `mov Rm, Rn` appeared (mv_src >= 0), forcing a fallback to
>>> cpu_exec_step_atomic for sequences like:
>>>
>>>     mov.l  @r2, r3      ; load
>>>     mov    r3, r7       ; save old value (mv_src == ld_dst)
>>>     add    #1, r7       ; increment copy
>>>     mov.l  r7, @r2      ; store
>>>
>>> When mv_src == ld_dst the move merely copies the loaded value to
>>> preserve it -- exactly the situation already accepted for the
>>> `add Rm, Rn` form. The immediate form can be handled identically with
>>> tcg_gen_atomic_fetch_add_i32 + tcg_gen_add_i32, so translate it inline
>>> instead of taking the slower single-step atomic fallback.
>>> ---
>>>    target/sh4/translate.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git ./target/sh4/translate.c ./target/sh4/translate.c
>>> index 5adf650744..d38a6bd352 100644
>>> --- ./target/sh4/translate.c
>>> +++ ./target/sh4/translate.c
>>> @@ -1974,7 +1974,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
>>>            break;
>>>          case 0x7000 ... 0x700f: /* add #imm,Rn */
>>> -        if (op_dst != B11_8 || mv_src >= 0) {
>>> +        if (op_dst != B11_8 || (mv_src >= 0 && mv_src != ld_dst)) {
>>>                goto fail;
>>
>> Hmm, but then you don't further constrain B11_8.
>>
>> For the given example, afaics, B11_8 == op_dst, so we're failing only
>> because mv_src >= 0.  Do we actually need the mv_src check?  I'm
>> guessing not.
>>
>>
>> r~
> 
> This check is necessary because the intention is to cause failure in the
> case of an unintended sequence of instructions.

Of course, but what's the unintended sequence prevented by mv_src >= 0?
Matt has identified a sequence that *is* possible, which is prevented by that check.


r~

