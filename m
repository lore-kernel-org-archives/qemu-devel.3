Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F33BD12D5F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 13:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQmkH-0006wt-Cd; Wed, 03 Dec 2025 08:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQmkG-0006wT-6N
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 08:18:12 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQmkE-0001aK-Im
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 08:18:11 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-3f4f9ea26aaso141101fac.0
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 05:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764767887; x=1765372687; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WqxbQ1rHLqHDGAaA47vf4nrVCpzKzWZjm5AVHggxw5Q=;
 b=WTaHG052EkwUGSFRooyQD5nIZgjdT/t5btutJaEawVrus1kabQTf2FANRYti5KMniw
 JRGR8x3h4St15kbZsDsDrAGjwuIWlrN+5i+NyBnCB11fNtRWekz2pmbqrGe3FyeroXjl
 d59gJacBprcY8IoOtmNp2AeYkKijI+srpKtGon47wMcgz7C2jMUb0X+/P+Tixpoyyytu
 yxbwzyVjczsIR3/jqamwb5Hxh0kfpjiAE75akXDG/aZg8n+76uqzzzlbQMTfLwDnhGr1
 Fpj2nZKJwKxrh4q/UA2EN7ULI0R7ql37i2VqFH3taNmOvAi5GGU5KkfBIPxOa3L5wn9c
 dkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764767887; x=1765372687;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WqxbQ1rHLqHDGAaA47vf4nrVCpzKzWZjm5AVHggxw5Q=;
 b=bUHEa7gRe9K6AsNqkxuzbJ1T4zNilyKKNWLyyKjpRg9Ygp/5NBEglTSdEr9BcJQJQ6
 61j538+u4ThGgrNBTmsfDGOiLagxPdKzr2TK7r/iHJ2rySzCbj2HNxIcQvyZogT3It3c
 nSZtY8bglxUDByvMbwCPQSrU2g1p+R8EjRtaG/lDmxWyp3NqM7ERMbgq/aKlvLhFGhwO
 nuCkaTIx9BlYfvba+F+FNI9+BcmVM6OXNpOejz9UyjJB0VB/PZsN4GlSqOyCZbhofDVS
 XBR1tHKcbpem+Rnr5dGimYZmWj/9bw+KBAWooy6efCNGVmE9Q/79eo203wNacR6GCBZ1
 FiQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU44XL1EZkoQSE5mWEs/TBnhHZv2tEq7nULxTn5lVeJfS4gBRQhSzAJ19M/WogssOzg7PHxI0U5VaSR@nongnu.org
X-Gm-Message-State: AOJu0Yz0/CBD1cqCGGFfzq6rMj9X0NrP1C5hxsvuqNB+X3OKWf8titaU
 uuVloso70WCruwMbdvgpEpeYIzKeTMyKyDJ//AaRbI3wI3jjDbNLejyhjs+B5T5kHG0=
X-Gm-Gg: ASbGncuzFHgfGM9+1+jSEG7+oGKPNhsoGNIHC9qSbG4yE1p6uNqek3Yut07jmjRkTvp
 LSa6buhx/fz0AzzswIvpP5BsaEunVbVw2gRty+PP6X5UNlPC8IOmmBk5+jZuJ7sWj3fZjwuGXcn
 YYtrg8ktJ8K01lqCIJW93ltTSENOlkPZxTtj4pfF/0m8THOSumvqaexZpL3OBiRslAoxvY8NUj1
 DyABY2LnpM19BWq/DhqMwSIwLpj56PLXz7EJbU0rToj6u2BwOw7AVnUSO3abZlmuKXOaCRq6bRM
 CauHh5+rj97HX68Ops9L+tmF5W1JLZA2v0pTv+GX2q5QpkVclwKSefZ9rgkr4JlyGS483/sCH61
 GR54c2Z2Vw+NERmx79fbWgke4ptHQqgn6SN9tS97CRTZ32D09PPSXHUHBkenubKvsTGCJKCYzFi
 WUOYLp/I3W+/9UKCTr7nnK7yBchw==
X-Google-Smtp-Source: AGHT+IGJ9g4kYN5mdRaoNrh7ZJEh/3RarEH44RjDZffHtdh3aAQTudvYtvmOciA4Xl+aJ80kDTXWjQ==
X-Received: by 2002:a05:6870:d609:b0:3ec:3437:e395 with SMTP id
 586e51a60fabf-3f1691fff57mr1099223fac.17.1764767887111; 
 Wed, 03 Dec 2025 05:18:07 -0800 (PST)
Received: from [10.27.7.193] ([187.210.107.189])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd021aa4sm9998415fac.15.2025.12.03.05.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 05:18:06 -0800 (PST)
Message-ID: <42b65dcf-e3a6-4f7a-b012-b4d1d7a70b2f@linaro.org>
Date: Wed, 3 Dec 2025 05:18:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 2/2] tcg/tci: Disable Int128 support
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20251202184653.33998-1-philmd@linaro.org>
 <20251202184653.33998-3-philmd@linaro.org>
 <2f307b46-42d8-445a-8aec-91fa101244f2@linaro.org>
Content-Language: en-US
In-Reply-To: <2f307b46-42d8-445a-8aec-91fa101244f2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/2/25 14:30, Richard Henderson wrote:
> On 12/2/25 10:46, Philippe Mathieu-Daudé wrote:
>> Disable Int128 on TCI, otherwise build fails:
>>
>>    In file included from ../../tcg/optimize.c:29:
>>    In file included from include/tcg/tcg-op-common.h:12:
>>    In file included from include/exec/helper-proto-common.h:10:
>>    In file included from include/qemu/atomic128.h:62:
>>    In file included from host/include/aarch64/host/atomic128-cas.h.inc:16:
>>    host/include/generic/host/atomic128-cas.h.inc:37:12: error: initializing 
>> 'Int128' (aka 'struct Int128') with an expression of incompatible type '__int128_t' (aka 
>> '__int128')
>>       37 |     Int128 old = *ptr_align;
>>          |            ^     ~~~~~~~~~~
>>    host/include/generic/host/atomic128-cas.h.inc:39:52: warning: incompatible pointer 
>> types passing 'Int128 *' (aka 'struct Int128 *') to parameter of type '__int128_t 
>> *' (aka '__int128 *') [-Wincompatible-pointer-types]
>>       39 |     while (!__atomic_compare_exchange_n(ptr_align, &old, new, true,
>>          |                                                    ^~~~
>>    host/include/generic/host/atomic128-cas.h.inc:39:58: error: passing 'Int128' (aka 
>> 'struct Int128') to parameter of incompatible type '__int128_t' (aka '__int128')
>>       39 |     while (!__atomic_compare_exchange_n(ptr_align, &old, new, true,
>>          |                                                          ^~~
>>    host/include/generic/host/atomic128-cas.h.inc:50:12: error: initializing 
>> 'Int128' (aka 'struct Int128') with an expression of incompatible type '__int128_t' (aka 
>> '__int128')
>>       50 |     Int128 old = *ptr_align;
>>          |            ^     ~~~~~~~~~~
>>    host/include/generic/host/atomic128-cas.h.inc:52:62: error: invalid operands to 
>> binary expression ('Int128' (aka 'struct Int128') and 'Int128')
>>       52 |     while (!__atomic_compare_exchange_n(ptr_align, &old, old & val, true,
>>          |                                                          ~~~ ^ ~~~
>>    host/include/generic/host/atomic128-cas.h.inc:63:12: error: initializing 
>> 'Int128' (aka 'struct Int128') with an expression of incompatible type '__int128_t' (aka 
>> '__int128')
>>       63 |     Int128 old = *ptr_align;
>>          |            ^     ~~~~~~~~~~
>>    host/include/generic/host/atomic128-cas.h.inc:65:62: error: invalid operands to 
>> binary expression ('Int128' (aka 'struct Int128') and 'Int128')
>>       65 |     while (!__atomic_compare_exchange_n(ptr_align, &old, old | val, true,
>>          |                                                          ~~~ ^ ~~~
>>    1 warning and 6 errors generated.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> And what of the CONFIG_TCG_INTERPRETER test that already exists in int128.h?
> 
> There's got to be more to this than that.

If you disable Int128 entirely, then we can't use 
host/include/generic/host/atomic128-cas.h.inc at all.  The bug is within that header, were 
we need to use Int128Alias more, as we already do for atomic16_cmpxchg.

I'll post a fix.


r~

