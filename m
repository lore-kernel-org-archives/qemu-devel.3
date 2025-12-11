Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7483D41D62
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTita-0002Wu-GW; Thu, 11 Dec 2025 10:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTitY-0002WS-7x
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:47:56 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTitW-00020L-NZ
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:47:55 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-3f0cbfae787so174975fac.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765468073; x=1766072873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t2juk5Vm4ck9/nk24tUYpq7Odg0a8S/D2qotEA3WIE8=;
 b=AathLCZBK/XjnSRDIxdnApJmqPnt19CPtsjvBhexMtKA9OhuiV4lSFo74Z85Rc+MrK
 IlY/ULyNRCwaHrFnWbaX16Z9ALMgReMHZksrrpTTCz6i03PyZ7ZITHYsagshp7Uo2bMD
 1UuVVyZu2A/er3RQnXZBTFiQwDKVqocPIwvZvkIG8Lx4a34XGHfUIf+3sLgMq1Ol3qsJ
 mrEmzaQCiU7IylhRnQMPITqYYaAVDhG5+dlrgo8/NlM+dksONeRspdXYrBmmjavgN8q1
 Dy4AmmGrytfOcjAIlgAxQQc+ooxcqQJHXLrT8RlgeHCipML5LAg/OC8fNBQsaL7aVsD6
 +XOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765468073; x=1766072873;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t2juk5Vm4ck9/nk24tUYpq7Odg0a8S/D2qotEA3WIE8=;
 b=Hb0n8HG3ytriw1J9a7FYn5q8gs9VaKDSCIKTidw1IjtMUnqXV6l8imWusBDqSAcN56
 JrehMcElH9ZcPs3WRLrNo8cB7ApCyMY+UUiKv1ccWVcAQTZZTFlRwQETrBo85sXRbC/M
 MkHs7oBCcZLoCIMLY3fEExGsXRAf8KDop4cr/YhJ/fCONWxQYsMl4yYUru17YDi91cKk
 GPb2kHRtl+Zi4WVCrKt2pgOLqsDCquLz9ORexkzajjV1dsCMOHTCjPfJJKLpXQgXB+q5
 z4OWw4jzUV1i4CU13a3p8NAkIY+bkeq3sPN2gEfV514CHhHphkzKNLh9jMI/UrTPv93s
 FIZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLVLCTteIo1jYmeAoqPikFbKNt/ouhdfG21uHGdP9CgnDlZMYFwQc4WldrmK68HQCROXtCCKliAlW+@nongnu.org
X-Gm-Message-State: AOJu0YzQ5tTwLv4tOCR7TBj9d+MvEPWUPgJBCMOfdZkgqBp8VU+3eLMw
 P5WkQ2DA7AzD6ERiuCDxAV3w5e9N5RfIpTfjwKPlZO5QKqalQbYB4GiYHpAiBf3zQqQ=
X-Gm-Gg: AY/fxX5I3n8jG7grJh5yuNdjMzDGQw8pGpH+wBYp+nZSjZeuQ0r4Hy9XjYIi7FKk7nc
 3yvJwmMjb9ZNZKZvU8ha65cNdI6WqSlUITWUEasgBQZIHlBWujabvwsjwCx+7UzUwELsJWJP4lk
 jl78t4p2cjmo0HYvHzkynn9Bf2luuqg/YseYaDGBKjwdyKT8guHTz80lgMxQhUBCy32D1eO3IJz
 SUN0ef7v6S5hRVgqTmyIC41XFuckV4zxpPbbXp93grY13kOWM7YdU5EX917u+y931pXWeqArUDy
 czSleLki1pqfSKNWyDiXuY75AZ9ggF1Fm2UY3LGKCr8LyGg0k0f2ZBz644KQKBe2Jhl4KkKrhXu
 H1KtuptNAPPDpYQFMuhwUJuSYfD/egTTocfkMtqjKIC3COJjYZIHApiYD/YpOYyKB4uTXfmn72t
 ZRilDa6suGDGaYrUzOue3Kz4dI+xhsgRSufOW1XaBS1vPLe45r+cMaxUewcgy2CtAS
X-Google-Smtp-Source: AGHT+IGom1ftq0semaJNxXuUX5ApyYN7ljgWC0ybFA56AesdUJU1JIahGOYgRS1wuBcCykt0wp/h1g==
X-Received: by 2002:a05:6870:2246:b0:3ec:4089:f963 with SMTP id
 586e51a60fabf-3f5bdc6a255mr4083809fac.44.1765468072816; 
 Thu, 11 Dec 2025 07:47:52 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d50f398bsm1768023fac.11.2025.12.11.07.47.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 07:47:52 -0800 (PST)
Message-ID: <bbca9504-2b47-4aa0-8cc0-be17b3db85d0@linaro.org>
Date: Thu, 11 Dec 2025 09:47:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] target/i386/tcg: fix check for invalid VSIB
 instruction
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

On 12/10/25 07:16, Paolo Bonzini wrote:
> VSIB instructions (VEX class 12) must not have an address prefix.
> Checking s->aflag == MO_16 is not enough because in 64-bit mode
> the address prefix changes aflag to MO_32.  Add a specific check
> bit instead.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |  3 +++
>   target/i386/tcg/decode-new.c.inc | 27 +++++++++++++--------------
>   2 files changed, 16 insertions(+), 14 deletions(-)

Where do you see this?  I think this is wrong.

In particular,

Table 2-27. Type 12 Class Exception Conditions
- If address size attribute is 16 bit.

and

2.3.12 Vector SIB (VSIB) Memory Addressing
In 16-bit protected mode, VSIB memory addressing is permitted if address size attribute is 
overridden to 32 bits.

Therefore, in 16-bit mode, one *must* use the address prefix.



r~

