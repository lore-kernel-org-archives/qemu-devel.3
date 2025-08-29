Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A9CCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNfB-0005x0-OW; Sat, 30 Aug 2025 11:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us5pB-0005MO-GA
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:35:53 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us5p9-0002fF-UD
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:35:53 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7722f2f2aa4so1339391b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756499750; x=1757104550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=voh6hTsyJedDQ5rjPxgvuyneGnLMXEyO8MueSNBNquk=;
 b=O5kmUSd4JF2BiGgEaBjodDUdcBppyaj50UE2OdvMrZGr3aJMcTxzfY9ei6DrfnqiLU
 LKHQm+68H1YxS19NyAJnX7T3K8HqR8VsN5HJptI711p09QLI7CO55QWxA/KaYHcwpyPk
 9HfUm3Ao9W4Zz9QdaF7QTCcUggML6kpfv4U5Qy3r4vayeGz3xj0l5xvq0sbo93fncdlX
 6bnZ/utZsMThL+IdUxCBcb2Uyrt9WOHgWUww7ZV5Rr/3TTSjCbjuomLD/7sI2K516LMc
 DvSi+RuD3OKq/PsWt+QIeXh22/pS12c9DkezUjnr+qJx1h7iOLAY30UbEi9XOeMB8VTT
 SS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756499750; x=1757104550;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=voh6hTsyJedDQ5rjPxgvuyneGnLMXEyO8MueSNBNquk=;
 b=N5bT8uaLKzas4UYCdvFrjN9WXebXJxdgW4pj1HyDiL+0CJZKMV7sfAH6pruRewqmwg
 1FkyroK6jnAFQTiHXGYis35HAXNKHnemkijLtLscuJGS0dhCUCfVH/t1gymwC6wFyIM9
 Yppp9MUgVwe9rDC89PYvhKVSU2uzSGmLhnq0vBtR0A0NrBAUzrb7RxaKvfwj2+48C0QE
 HjosQua9ugEi8Fqilui96yFQHk+c8584fJNui/dSaqK0R3oC/jyy5QSM+0DTpw9nbthj
 KHjYoI5zg4sgYVemZB8/QqzcIhzcBWhJUQUJym+YPdSjwrLH5fti9Ntw4/uLoa39tTYg
 HcLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVENoTIVMzWrYHD1z086n92I+xLZjceMT9wgAQWwJuYfxQtDUSXSSL0LsyiLceVxnb2cvTAZun4WIy2@nongnu.org
X-Gm-Message-State: AOJu0YzDHn+gXCTVOhy/C3gFAOXuycRYpz139r9r06rdg7qffTzjp2GS
 BaVZDWDUFwjoRrKrxoeR1D9WuGqc+O+0F0yKRHwtSsIuhbtpDENl0Tg2dpQqAnITCob4eFMmTYT
 /3nyhJKY=
X-Gm-Gg: ASbGnctR1pxybNgrFvmvyiPN6I+puvRx0jnWYLKmZAII2AXhRj8cbzbYjvaido0LFXJ
 7IL42LgYwqrPIQtr1gJW2TWPR1pSY78p0dxnlm5iPR6MPTD4u2s7mAaNnjZGrNif0nnU3rXnAlV
 iQMRyW9O03Vo7euOuyGQ+1cbwP2LL6DvdAsxcUtLl/usaZg5e8heZOUAvMm99Vw5CSFrLNxfAzu
 r6DIfzStqkFBGo17PU/Sbw+4CSE7D0biX+HLDiT91iIuSi8WFdd0PEfgnUIk1jsBSTSs8FK1SMl
 +PKFHp8VUcQuajQXh3fvqPYb8hisNQjoHrSaGvv+5LCOcstZgwi3stS/h0J0ASPnPKFEwqQll3W
 GjOZ2vNC4ZcqrNIS3DgeL5dtG+bYFkFD7v5BwizfmNqAbwcFWAZ7TvoWdQjZy4LacScuM+fsTLB
 wJC5PtpwU=
X-Google-Smtp-Source: AGHT+IHSmvaQGbhO8BRMCzJHj7zRwLwLGDaoGgdkeyPptwos2B2Se1/QqQi0oT7aM0mhwRKfnwEqdw==
X-Received: by 2002:a05:6a00:124d:b0:772:d15:5f55 with SMTP id
 d2e1a72fcca58-7720d156416mr16579333b3a.32.1756499750193; 
 Fri, 29 Aug 2025 13:35:50 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-179.dyn.ip.vocus.au.
 [122.150.204.179]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71fa66sm3210927b3a.96.2025.08.29.13.35.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 13:35:49 -0700 (PDT)
Message-ID: <76c1f293-4e7d-4b15-9c1f-811b126a6aeb@linaro.org>
Date: Fri, 29 Aug 2025 23:55:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/61] target/arm: Add CP_REG_AA32_64BIT_{SHIFT,MASK}
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-20-richard.henderson@linaro.org>
 <t1qvih.2mkqztkoudm9n@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <t1qvih.2mkqztkoudm9n@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/29/25 17:27, Manos Pitsidianakis wrote:
> On Wed, 27 Aug 2025 04:04, Richard Henderson <richard.henderson@linaro.org> wrote:
>> Give a name to the bit we're already using.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> target/arm/cpregs.h | 15 ++++++++++-----
>> 1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
>> index b6c8eff0dd..3dc4c9927b 100644
>> --- a/target/arm/cpregs.h
>> +++ b/target/arm/cpregs.h
>> @@ -178,9 +178,14 @@ enum {
>> #define CP_REG_NS_SHIFT 29
>> #define CP_REG_NS_MASK (1 << CP_REG_NS_SHIFT)
>>
>> +/* Distinguish 32-bit and 64-bit views of AArch32 system registers. */
>> +#define CP_REG_AA32_64BIT_SHIFT  15
>> +#define CP_REG_AA32_64BIT_MASK   (1 << CP_REG_AA32_64BIT_SHIFT)
> 
> You could use include/qemu/bitops.h

For what purpose?


r~

