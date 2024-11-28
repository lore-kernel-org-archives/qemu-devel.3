Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C107D70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 18:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGjHz-00045F-CZ; Thu, 28 Nov 2024 13:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGjHp-00043H-Dm
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 13:30:49 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGjHm-0000VV-HP
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 13:30:44 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2965e10da1bso591714fac.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 10:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732818641; x=1733423441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dUHKJgjEEEFZc6PW8mU47gJep8BmGqww2h6z5g4TTFA=;
 b=j0a7AOdlyLWiDKs2unjcDPduSDlvEx6WU5AYN+CmdxwWxPq3jU5Esr+0QQ99NKc5vi
 02TTaU3Irt4hWU8RMmhgrgemIXoosSO3AHsWpTUcAk5U1AM6jalMIvoqwpa63H+9mR1X
 xL2i47BcQQZ28pZAMWf97TDGg5jdBxGkZ8m/5lqMjiKrbcD4886h1paXbBrsKjCltHqa
 cEMuxsi6Rk/X8SzOxUW7x4kp98vvBOxDJ5fVv63u3bN0+D+eTmFbiH7fWY+29v1Jlfy4
 a167RNwrYHOrNoCYojUAQBWeeSZeAKgaQPN1oRvDu/W2oB1k4+JATgXFf0ZXfnukbbIo
 MAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732818641; x=1733423441;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dUHKJgjEEEFZc6PW8mU47gJep8BmGqww2h6z5g4TTFA=;
 b=suBW2bSxy0tCcFPmOKcq/x5RVBRzFZkWPcf2jBQgA+L5nd6Fa4/aLxC0x/6qR3QEZO
 DLRNMfodsF4C+WG0dM8tWvM45Larz5OzqAAEe47TNW9tuRfEUaJV4H6FYi8j3qwyerWq
 o3HU/9oLAmjtGt1t4XOPeXW/6eiRomM76oq2HEY5TmaYoutrVYEImC+ozNL1doa7IBl2
 Mihbv2CdZM2XAEZ2s+EKq+oh5hgpyHMLMAKMyNSpzNstd80OpJngkRRo4mqIlCXw03hp
 Faa4Lzp9PYqnzXt2DjYhR277IBNeVN0qFzEQWTIYuBGSGvqhiTuZpACzOyjtp+mdVNAJ
 n9Ww==
X-Gm-Message-State: AOJu0Yz3pynEtU3EWW/gAVsMkCV3J5Cf2QF+ZBc0ipqJkU/mM58eWiQU
 RmwMHp9zciqry453G3pcCq+I0SsI8YUzEOaVSjgRQrQ/RdeDi4WxC6TJTDp7o2+Z3BIN1zxAsCb
 Hd9U=
X-Gm-Gg: ASbGncvdK4EyvAWWYDZlIhfJN+V7umkjQ0n38ow7OR9Zgni88AeJ3ud9C5EQowIjiHn
 IpxsRJka6MgcgB8FTSY3K8MWScMDn17M+4Pxab5K1qykv/30sJWDYmCjWNob8hL2Wsz1pTtgZtl
 GZ17TrCM4GJARi9hlI1QoT1aXjZz8lOkunh91U+QWK4A+0umtaz5Q8y4THLp3eHcatl6vfSlBoN
 hDDXI7kNZY1xLTOS+JPBffv/Yfz0npE78HVGYGNuf15c2T/XMbW56XZITX1S5B46Fk=
X-Google-Smtp-Source: AGHT+IFqpCkvm19qgyxBQ2/zC9DMidFVNrhQByXoD6TUltyhNr9Ctu1yn8oCvYEfnOiaiVgYAkxHLQ==
X-Received: by 2002:a05:6870:7010:b0:296:e54c:324b with SMTP id
 586e51a60fabf-29dc42f5ceemr7933962fac.31.1732818639314; 
 Thu, 28 Nov 2024 10:30:39 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e0635c43dsm195802fac.24.2024.11.28.10.30.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 10:30:38 -0800 (PST)
Message-ID: <fe6510ba-ca3f-4340-92a7-f504276ab11d@linaro.org>
Date: Thu, 28 Nov 2024 12:30:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 15/31] Hexagon (target/hexagon) use softfloat default
 NaN and tininess
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Brian Cain <bcain@quicinc.com>
References: <20210502144419.1659844-1-richard.henderson@linaro.org>
 <20210502144419.1659844-16-richard.henderson@linaro.org>
 <CAFEAcA_zePe98nx31F_KmeG=S2Kj7__chb51LK_GTcWkY5u4JA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_zePe98nx31F_KmeG=S2Kj7__chb51LK_GTcWkY5u4JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/28/24 07:29, Peter Maydell wrote:
> On Sun, 2 May 2021 at 15:44, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> From: Taylor Simpson <tsimpson@quicinc.com>
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-Id: <1617930474-31979-11-git-send-email-tsimpson@quicinc.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
>> index c2f87addb2..9ea318f3e2 100644
>> --- a/fpu/softfloat-specialize.c.inc
>> +++ b/fpu/softfloat-specialize.c.inc
>> @@ -145,6 +145,9 @@ static FloatParts parts_default_nan(float_status *status)
>>   #elif defined(TARGET_HPPA)
>>       /* snan_bit_is_one, set msb-1.  */
>>       frac = 1ULL << (DECOMPOSED_BINARY_POINT - 2);
>> +#elif defined(TARGET_HEXAGON)
>> +    sign = 1;
>> +    frac = ~0ULL;
>>   #else
>>       /* This case is true for Alpha, ARM, MIPS, OpenRISC, PPC, RISC-V,
>>        * S390, SH4, TriCore, and Xtensa.  I cannot find documentation
> 
> This change has the effect that Hexagon is unique in that its
> default_nan value doesn't correspond with its setting for
> snan_bit_is_one(): the default NaN is supposed to be
> a QNaN but this value is what snan_bit_is_one() thinks is an SNaN.
> 
> Is that intentional? Should we adjust snan_bit_is_one() too ?

Best I can tell, hexagon does not distinguish signalling nans at all. Certainly there's no 
language about either "quiet" or "signalling" in the manual, only the pseudo-function 
is_nan() and the value NAN when assigning the default.

I think we should be setting no_signalling_nans, like xtensa.


r~

