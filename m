Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7076D232EB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7Ws-0006It-Q3; Fri, 09 Jan 2026 03:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7Wf-0006CC-Sa
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:07:20 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7We-0006oP-4V
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:07:17 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-432d2670932so955874f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 00:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767946034; x=1768550834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EEeukaXsx6QHKDsVimqjqNOpXIbrhfAtUKPTBwppM/g=;
 b=zinQfl+NqOYfdTgrFhr8JqWm4XcDwCn/K9KA7AambKnkrjkGvZZAwnocvjEwOXHjKC
 2Dko3PJdClREkhD4moQWHkNEVABNYDvL0NqhwEBlIpEar0c8igisdOX0VxgSTfkOyYIa
 Dwm+IjgAHFA3Y2NaWMWKszvDrxer6TJUxWP1ISvvZvGVSkxGuSX1oBBtAD8tWfPRTo6X
 vIh+0aEqyiRPfoO5kSDM9FloCkjQYTB6ltIUQhPRBMXmxaP/Mo1W7WndrvglaotZMSuC
 ZS7Eb9ffCYtxvp3/EyMM04vCe5A0fNZMhfXM62lnhJ/NQ7qiab3OFGR39b+BmHI7E+vm
 lS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767946034; x=1768550834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EEeukaXsx6QHKDsVimqjqNOpXIbrhfAtUKPTBwppM/g=;
 b=rWLLYdIdNtMjJ/lYiWzKdwn9urENl7EnvgvE5uPMfB4dQQA1WjYUfn8vCpAzey+VaZ
 a3kFqmUmrRj8sgDyQtK9obWCLAuD8cE3te5zI1sEHsu4S8PZlQgKKskPDdDR7MjTCNdT
 e6yzocdOGTkE6mgBk7ZUjZpZT9+p3xpE4sjM4phnwhQ+s+vsMTLwV9LMKOHCRqHpDB5F
 mYyeTa6L66oMzcgGT2Oy3IIgxiYTQwtsmbU1/tLZXaUzwmeL2AAGtSyCzehnMlxefqij
 FpZxG7V/zad7gb8P5BJVClgEDF8ckEYzvp+W5v+rNSZuD59BTrBzpMkSDeerJNMMi6G3
 glpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfagWtmTRpOrRlaGLGld61m2Xd3KNgsa61WHTGO0CIx7LwGCnoEomMcXiwEd4QB9VPnOWFQ+6+azMo@nongnu.org
X-Gm-Message-State: AOJu0Yycq0qZkuvFTCn+t60hAjt2ZKxET719Gqw8ZxFlXHAtnJ+3fiBJ
 JDJos9vROOhnL1DIvgaNFoORC8WE81fMYrUuuA6U8gcD/dETm0k0RC5Bv5zbQOi/dT7y/EhzpFN
 ovhNspyI=
X-Gm-Gg: AY/fxX4Ba8yQSLHQvCycjIl332GUHNG4mh7WFuH15quKc7SlQaABkGdACmE7DX+SGl5
 vXjzs6mx0xa0w0s4u7As1UgX+A/DjTxZs3zl0U6E87BX3tGrAzLTRBxacL2z/BLLcR1uGk32gG/
 DgMhM1jv52H2ix2FINZacLB0njUu1foqKgGi00WLZfO8TBD7XluBbQ2w3wV+YPY+QjlueK311xq
 zKR8+OBAhMxKSCT7cMo1dvj8lcwTuI+rSZp1OVvyRfqas6mkMF8ITu1V+rdr+WEXv7nZ5lPbcnc
 BXd1bNN3M5yBbUgAM1dw2ahMMZg+m9nXDp/aiLSOGggH/S5K7E2j5Y95Cl7b6VxwSOqYwsaDZju
 6Qw8UUQCH9A9tXkgVsXt4mOPqo7mXrzezSbwsdwjhH4DeyNkJ3IoxkZQsAJeymbzParKJkDYArS
 PjqcymnqVKDZ3E6PPB2JOVaZ643ZOqTiZr+CcqP/8Wtl6ZQxQ1erBoVQ==
X-Google-Smtp-Source: AGHT+IFyGzAERJ+Ro1lDTiSh7SSFeNdXGvS/BteHIRlq0G7QVGUkw2Lj7DlakBwwfsqzblTyc/CRmQ==
X-Received: by 2002:a05:600c:8b58:b0:477:af07:dd1c with SMTP id
 5b1f17b1804b1-47d84b4079fmr105914185e9.35.1767946033677; 
 Fri, 09 Jan 2026 00:07:13 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d870e80bbsm61476965e9.5.2026.01.09.00.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 00:07:13 -0800 (PST)
Message-ID: <4d0180b4-d73a-460f-a10c-9bda9799343f@linaro.org>
Date: Fri, 9 Jan 2026 09:07:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/29] target/arm/tcg/translate.c: remove TARGET_AARCH64
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jim MacArthur <jim.macarthur@linaro.org>,
 anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-29-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260109053158.2800705-29-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 9/1/26 06:31, Pierrick Bouvier wrote:
> We now need to stub aarch64_translator_ops. Those ops will never be
> called anyway for 32 bit target.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/stubs32.c   | 2 ++
>   target/arm/tcg/translate.c | 2 --
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


