Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C95C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 13:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdrD8-0004i8-L7; Fri, 31 Jan 2025 08:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tdrD7-0004hs-K7
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 08:37:29 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tdrD5-0000lU-UO
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 08:37:29 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ef70c7efa5so2721438a91.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 05:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738330646; x=1738935446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wdxCDNplt2fe5LaB2T3UPL9Sl8d0nhleNeASlwf62bo=;
 b=dg/i1rRxd/wuKc0M57YktMUlw4iYl9c9Dkw5gq1v5sJijow4qaGOyqQwPyckS4BS5K
 l7cDDqr1xl6YgAa77MQ8f2ACE+ZgCnv2aqim99gcQR4ZUFJlP0jckJvsHkxHYWX10OVo
 8q020xr26G2WC1Yxuktut/bXRi52el6nNWB2+p5GPGqQWsH/sbtWZa+vJ20ufmrO1WyU
 oT16NKqYlRWRJ80BhrpCe8yDmRuJR8qDIVPmIhKaL+0hrWftKgz2PBD2/W6pxdQhbjfB
 aDuC1Q7iHLNxKLdnPJqypvKpwwzEU40ffY5CQmEuuzbJ7piNedd9C4aggWQODkacb/Dm
 rIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738330646; x=1738935446;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wdxCDNplt2fe5LaB2T3UPL9Sl8d0nhleNeASlwf62bo=;
 b=MRLzfqeXCWqnW6ixP2IsFQ4+kbmsxxmE6agiQ7VwhtMtlJzZFGqQ6h1V5vOGSyytWy
 W9LBFUTkEnK35mzofA9Y5tfYVnNXmL+bgEERXfr3sX/qwdbtSSx8tqE75mNjokLeh8hM
 fL3r3sxrraYtHrxv8vegLbm81FNEf0k72EW9a9vERgm2txpVXSknkT7Rye1szV2kdELS
 aYfMX71t2IwNAV3OVYcP8a9Gjc0gUlWlVMQKXE9I29LnvWWvZA/02DZZvw6F5VtrxYK/
 6h2XLJ2nM+X7dSAfA8rY/+guk8j/sKJH16Z7loSkvCVIIprc959wtqOLA0asvspD0XNM
 FzXQ==
X-Gm-Message-State: AOJu0YxX0+l27SHdD2iLzzgMvzIBPQwBX3wSF9SAqB2lHyEularJUcih
 EEL14Pm9HkhtWRLY0PxsZYId2pHvHAjkpq7zCJoSl9hd/fBxMV9CUNgmkv5NX85p4ghEKLFc9bZ
 9
X-Gm-Gg: ASbGncsdW6KRLrK7erL9FnOeZIveYM7uZF6SU0Io999jHaxCjRvkVyLlD8+DDIRv3c4
 GgtzGXD3/MUkvSVzjxNFRuPD75GYPvTCxgMm9eun3V8yQp1pdgPJLnnIAHiUsAd7Bk9LAsmxQFQ
 N8NJwmDHzyMf+NVGW/VgGDjayMKeQCAVEAVn56GiVfrC5iKMjw4eUo6pjcp9a2YEYgDIlplkTRj
 xNeQAmqCtsa+Vi1I0i2PuEvWPOFBhrQ53K2bq5wb7ZpxJJYJDad1DQo9URpqdgSMkBEEf7g+d+b
 X2DybCClMeGYr2SIGPy2NfvlEjZUW4IB
X-Google-Smtp-Source: AGHT+IFY25LMlzlU/diojJHOQ0GPjRw66fUXzGFetUxgbuwzZ8GOmlAAhEd0w/lziEqus5waOrCcJw==
X-Received: by 2002:a17:90b:54ce:b0:2ee:f80c:6884 with SMTP id
 98e67ed59e1d1-2f83ac8ace6mr18652512a91.33.1738330646295; 
 Fri, 31 Jan 2025 05:37:26 -0800 (PST)
Received: from [192.168.163.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de33254a8sm30154945ad.246.2025.01.31.05.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 05:37:25 -0800 (PST)
Message-ID: <3a8cca34-bb6f-471d-a879-6e573fa00fac@linaro.org>
Date: Fri, 31 Jan 2025 05:37:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 45/76] target/arm: Implement FPCR.AH semantics for scalar
 FMIN/FMAX
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-46-peter.maydell@linaro.org>
 <7e368ef4-a60e-4308-aeb9-ec910361c424@linaro.org>
 <CAFEAcA9RbsEpp3yyXe2Nf2KJ6yTXp36oEP7SHSrvX1NyPS3k1Q@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9RbsEpp3yyXe2Nf2KJ6yTXp36oEP7SHSrvX1NyPS3k1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 1/31/25 05:09, Peter Maydell wrote:
>>> +/*
>>> + * AH=1 min/max have some odd special cases:
>>> + * comparing two zeroes (even of different sign), (NaN, anything),
>>> + * or (anything, NaN) should return the second argument (possibly
>>> + * squashed to zero).
>>> + * Also, denormal outputs are not squashed to zero regardless of FZ or FZ16.
>>> + */
>>> +#define AH_MINMAX_HELPER(NAME, CTYPE, FLOATTYPE, MINMAX)                \
>>> +    CTYPE HELPER(NAME)(CTYPE a, CTYPE b, float_status *fpst)            \
>>> +    {                                                                   \
>>> +        bool save;                                                      \
>>> +        CTYPE r;                                                        \
>>> +        a = FLOATTYPE ## _squash_input_denormal(a, fpst);               \
>>> +        b = FLOATTYPE ## _squash_input_denormal(b, fpst);               \
>>> +        if (FLOATTYPE ## _is_zero(a) && FLOATTYPE ## _is_zero(b)) {     \
>>
>> The comment says "even of different sign", the pseudocode explicitly checks different
>> sign.  But of course if they're the same sign a and b are indistinguishable.  Perhaps
>> slightly different wording?
> 
> Sure. I changed from "(even of different sign)" to
> "(regardless of sign)". Let me know if you have a
> more specific tweak you'd like.

Sounds good.


r~

