Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74570C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 20:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpCaR-0002h2-PN; Mon, 03 Mar 2025 15:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpCaO-0002gV-0Q
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 15:40:24 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpCaK-0002ws-EO
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 15:40:23 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2feb1d7a68fso8491931a91.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 12:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741034418; x=1741639218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WSVpbeBC0M7td4s9rrRuDbmzSs+yKYeFHWOute9mMo4=;
 b=o0GPImlnUdlw4t/mX3UecL94nSdT1PvNRGU5DJ8Glp6oZClIe2u5ZxeLxh18qb9n+z
 QU4B6pHnr4jzEjPQcXngvR5T1TI3wbjXDNoRhRjUXmY5JpG3rBWFgTQEFbq4XRwXhZWe
 fjzvvCj5/MjPJE2UYQgm6gYGBjmPnMZ4x2YtoCpIAyRDhqAKBWkwaU162QZxw6/j2RKv
 mHI7c7HXN1dB9Bu31mKvrWHp5xmhq7uXsB1xFv8tt1OBs9cglRmnOxsxDQBv6a/O3pDH
 w/pK+YQdHCKtwzvtwkJOE/aq+t0fLBbWA1ReqgNr8qRhQzBP5eJKv8UVhQkmx/5X5ZsT
 5hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741034418; x=1741639218;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WSVpbeBC0M7td4s9rrRuDbmzSs+yKYeFHWOute9mMo4=;
 b=B+tjDZMkUsu9oy2Fn/bXOyeIZBdzU0GRxVPzfGD0m+PLWZIMo9smOKwhG9J5k5qBNK
 mtYB/FrnxmDcl4f48OpclrgtloBaTtiIbjTIJaClEMeadaGCUNQdI8ya3e5b22b2d5I/
 zSE6WJW8atd/HcrplESi5Xczaalp7VZwGS9YBJpX0c6n6Tjqj5KgKn2MUbUu/3Wc8qpL
 p/48pyWYO0Ytuu5UCvNlmk14YgVd3tzaJh8EfR7ZKmCmyzwpH3hQN6M7HBnQjjJxRMAv
 iAb8Lh/LTxqvfgRAp6NLwalQrgKYKvFiOHsUjBd2zW+cfUdrfC2zgZmyJbF6eQidrR+z
 TWLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfNiLL3zMjkCPEGtwTz/Wg5KP5kZs5r0mQdCVQ8Uwk1zjFgxC0QX/MmRpbiZiJ1qWU65N3KgdmDITa@nongnu.org
X-Gm-Message-State: AOJu0YxSiVLknVOdg0pMZ9Sj3iKpCilQml8x4GHauRfpxWk+5Y37LDhp
 eySLO9NEdnTo4vbH4EcSFQIWxK0fIl0opu8HrfBuazqeLnBpTs/Bv4+i0jTdXXo=
X-Gm-Gg: ASbGncuTTSuYuOHcAlIKKvFdVSZEP8bCZaT3vbgYOGBgG9togp8Y1ReE8ipMVAasaSI
 nyhkHr9UD/+FFCx9P1F8qe4+YMygGVSyWaHv+2XzYDIbFBRvxYyi8Gzsd9tz+bSwDKYKZaWFue+
 4k4r2yo3/gQ2/GNZik68Ed/rXjhSEbMaev+kE45rwCLsa77spc2tHdpSRz9w21ZIlbIp2EH8XNd
 FM9sThnvM9/jq06q5OCpdgnFKMphfyJxRuULENKpXvzEa3vpU7Oa9Drht0zULpL7W9nqhxxLCig
 9ZyR6swNSuNTJmL9sdNi7r7GIjQCf483BRrN06QedojlSl3ioi4AzGiK7mFAeDiC8XiZAwWJwH4
 bnkoqZ7gH
X-Google-Smtp-Source: AGHT+IHUsR+Q439cJbXFpvkOjo6adVPXFG0qm1IbBELjSC6nt0pMUaY2eWrG2aGknyrrNRSScXUacQ==
X-Received: by 2002:a17:90b:2792:b0:2fa:137f:5c61 with SMTP id
 98e67ed59e1d1-2febab50e88mr28125160a91.12.1741034416867; 
 Mon, 03 Mar 2025 12:40:16 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm9390129a91.23.2025.03.03.12.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 12:40:16 -0800 (PST)
Message-ID: <34beaac3-405b-47bb-b12a-91a0dd3e9f5b@linaro.org>
Date: Mon, 3 Mar 2025 12:40:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/24] target/m68k: Implement FPIAR
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20250224171444.440135-1-richard.henderson@linaro.org>
 <20250224171444.440135-25-richard.henderson@linaro.org>
 <81d01563-8a5d-4002-81e0-1b34108bfce3@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <81d01563-8a5d-4002-81e0-1b34108bfce3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 3/3/25 10:39, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 24/2/25 18:14, Richard Henderson wrote:
>> So far, this is only read-as-written.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2497
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/m68k/cpu.h       |  1 +
>>   target/m68k/cpu.c       | 23 ++++++++++++++++++++++-
>>   target/m68k/helper.c    | 14 ++++++++------
>>   target/m68k/translate.c |  3 ++-
>>   4 files changed, 33 insertions(+), 8 deletions(-)
> 
> 
>> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
>> index 6e3bb96762..bc787cbf05 100644
>> --- a/target/m68k/helper.c
>> +++ b/target/m68k/helper.c
>> @@ -45,8 +45,8 @@ static int cf_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
>>           return gdb_get_reg32(mem_buf, env->fpcr);
>>       case 9: /* fpstatus */
>>           return gdb_get_reg32(mem_buf, env->fpsr);
>> -    case 10: /* fpiar, not implemented */
>> -        return gdb_get_reg32(mem_buf, 0);
>> +    case 10: /* fpiar */
>> +        return gdb_get_reg32(mem_buf, env->fpiar);
>>       }
>>       return 0;
>>   }
>> @@ -69,7 +69,8 @@ static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
>>       case 9: /* fpstatus */
>>           env->fpsr = ldl_be_p(mem_buf);
>>           return 4;
>> -    case 10: /* fpiar, not implemented */
>> +    case 10: /* fpiar */
>> +        env->fpiar = ldl_p(mem_buf);
> 
> Should we consider target endianness?

I am.  Are you suggesting that the TARGET_BIG_ENDIAN shorthand be eliminated entirely, 
even from target-specific code?


r~

