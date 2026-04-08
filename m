Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793AF10FC459
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 22:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAb8i-0008Ea-G0; Wed, 08 Apr 2026 18:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAb0n-00078J-Tu
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 18:04:47 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAb0c-0002QJ-Hg
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 18:04:30 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso1479665ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775685837; x=1776290637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7L62OfBt9iJs1fG3sTq7m+DwJBsZVdcDG6w6q84MISo=;
 b=SeiU70VQ1Tu/PW1xuAZCrOPX/tbeX5LjTnlQJkn9SUDjMwFgKAEETegv+SWueQpZyh
 4AK0QZ7tx6AyQZSYCaFGv4Hbk0atKuPlmlJUJVm/qV+Ucvdv9vixFS2gUN3uTSiUTqR4
 MhRG2vnZSnH10GwG2lAJFWWiYsBIYv7mLdor+3k3Sb7wvFl1dO2nAYyIgUTXhzOc2H9i
 OynlnnD6+X2hICmR0TXm/YDKxfbU0WpW0IeneJ2bFHwg2BjM6xJ3U00Od3wer7eob14V
 e/2ebLIZ/VqzI1WGMt2m4wx88VEcshsDB5M+xEUc8lnlnXd0zjLlN6L/3i0qzO/wIQot
 lvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775685837; x=1776290637;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7L62OfBt9iJs1fG3sTq7m+DwJBsZVdcDG6w6q84MISo=;
 b=dU9ALL+TQGnZLbIG/bfcHq2AdWwXqcmnqfPjjSCVRL1PRcHHw2EJI03QpKBVVq09if
 KFtXmlJ75sygfTZ48tstbUHp3npffLsuAgywOD059oj+UFcBk/wiQr7XZiw0Z0DrCwo/
 EZ6GJJK5B3BpJjGfFqslWDSvKK75IvnMShyWxEAI6UlfRxVbLpqlnzrw3e4TI5QVbW/H
 25YaMrTH6FGBJsQP1aRi4hfTyBDjO8DXNDm49S1MjFWlib+j8P/xTqCxDDT9K83UqN9/
 3qt7pX1uTRN9ix0EJSVoxsngPVplI0BWfQESiqvbcPkvy608vHs8XCOP458lq3/I/fx1
 ebgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvWiwRoxKDkO7Cbo3gkFD3rwi/69nffIznrZ22l7JhqPZHL66nb/G4e7N3OCekuGQBfVws0epulL9o@nongnu.org
X-Gm-Message-State: AOJu0Yyew7yF4SXK/d9eTNxwng7C2XGTVvpRXWkYGwEuaex15mJboStV
 W7oaN0I7wMAvAmlhFz06DAFHtkXUuu37OGNQ0EAgy/hzZxzqAfH3Hl33qOdCB9ljgXw=
X-Gm-Gg: AeBDies37n9U7fcqxlLT7DVphZWpajh8O5NB03H9Hxvr0rhcfooVGNqo+eE4v164BDc
 ALfaUj/RNovbd+IX0Ty3ZG35qm6QX9ukaF/b64s+q1ZhKtgXORmrPasQ3xLIGy0/4fp2o1Z8yoH
 32vQ/8a9iFaEgkfsggKrB+H0WJhEc6Jm2HcTd4GkdU+hCD6bS1drpPZiiY0hRG7OnHQTaL/zO3f
 UI/tMM9LELuxGEwB8SFAWSe2Hu4l5SFv9zh1DF1Xwzc9z5Awtkacr46uwDvgmm4CngD1/dACenM
 S+VPdyx+Y/PC6NQR50BedmNnZIMh8S1R4jQLBZZxsfdqNSo4zkoSvfts+4O9NFqxeLQrkzXNR4x
 +1O90CelCNgoEkQ6+8GKt3iBhPAmq8s52iCU976Emxt/AdPJ5A7PtuprSCIwIUakQ+gePrMZIzr
 JYHY1eV2R/jIeNq8ucfJN6yAqEkcGVokbPHj4OnETBwwudqIPtjS3lhzsfvK1Sf3bYqWUhHzlpL
 dtm0Q==
X-Received: by 2002:a17:903:3904:b0:2b0:c0a8:5000 with SMTP id
 d9443c01a7336-2b2816ae915mr261289615ad.14.1775685837006; 
 Wed, 08 Apr 2026 15:03:57 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27473583dsm214589575ad.9.2026.04.08.15.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 15:03:56 -0700 (PDT)
Message-ID: <5478ff4e-7f84-4862-a55c-7608716a01b8@linaro.org>
Date: Thu, 9 Apr 2026 08:03:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/29] target/arm/tcg/translate.c: remove MO_TE usage
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-27-pierrick.bouvier@linaro.org>
 <5fc9d07c-cd22-45c0-bb5e-8bf93d20f112@linaro.org>
 <f40a06f2-d3b7-4130-a7ea-cd90337c6bb2@linaro.org>
 <f2abb1dd-55c7-47ca-8000-21fc9f5d987b@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <f2abb1dd-55c7-47ca-8000-21fc9f5d987b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 4/9/26 01:57, Philippe Mathieu-Daudé wrote:
> On 8/4/26 10:20, Philippe Mathieu-Daudé wrote:
>> On 9/1/26 23:50, Richard Henderson wrote:
>>> On 1/9/26 16:31, Pierrick Bouvier wrote:
>>>> dc->be_data is already set just above in the same function:
>>>> ```
>>>>      dc->be_data = EX_TBFLAG_ANY(tb_flags, BE_DATA) ? MO_BE : MO_LE;
>>>> ```
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>   target/arm/tcg/translate.c | 1 -
>>>>   1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
>>>> index ec4358ba402..55b89817cb1 100644
>>>> --- a/target/arm/tcg/translate.c
>>>> +++ b/target/arm/tcg/translate.c
>>>> @@ -6327,7 +6327,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, 
>>>> CPUState *cs)
>>>>       if (arm_feature(env, ARM_FEATURE_M)) {
>>>>           dc->vfp_enabled = 1;
>>>> -        dc->be_data = MO_TE;
>>>>           dc->v7m_handler_mode = EX_TBFLAG_M32(tb_flags, HANDLER);
>>>>           dc->v8m_secure = EX_TBFLAG_M32(tb_flags, SECURE);
>>>>           dc->v8m_stackcheck = EX_TBFLAG_M32(tb_flags, STACKCHECK);
>>>
>>> Whoops, yes indeed.
>>>
>>> Cc: qemu-stable@nongnu.org
>>
>> As per my v10 comments, why Cc stable? This is just removing pointless code, right?
>>
>>> Fixes: a729a46b05a ("target/arm: Add wrapper macros for accessing tbflags")
>>
>> This commit doesn't seem to be related.
>>
>> Do you mean commit 79cabf1f473 ("target/arm: Recover 4 bits from
>> TBFLAGs")?
>>
>>      We had completely run out of TBFLAG bits.
>>      Split A- and M-profile bits into two overlapping buckets.
>>      This results in 4 free bits.
>>
>>      We used to initialize all of the a32 and m32 fields in DisasContext
>>      by assignment, in arm_tr_init_disas_context.  Now we only initialize
>>      either the a32 or m32 by assignment, because the bits overlap in
>>      tbflags.  So zero the entire structure in gen_intermediate_code.
>>
>> Since BE_DATA is in the TBFLAG_ANY set, I don't get why it
>> is set to MO_TE for M-profile.
> 
> This is a question to Richard btw, not Pierrick ;)

It shouldn't be there.  That's why this patch is a bug fix.


r~

