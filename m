Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403EBFD9E30
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 03:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvo6s-0005a5-N3; Thu, 26 Feb 2026 22:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vvo6q-0005Zb-EK
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 22:01:44 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vvo6o-00074a-Ii
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 22:01:43 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso613053a12.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 19:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772161301; x=1772766101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uKOAVA9B8bemDOxyE9wlnutso3V4zsT+pJhQ+huAKCk=;
 b=EZS/mFfUTkv7q/XFWMpYg/mR/gn/77UOlmtGeFrgpgqxCj13miGDH2pRl8uzOnUs2w
 soms7djfTkwcQPjYSt5KZinjYz1fRhTQAOeerrVLz318CPTIddREAvEvAOmrS6UJSyRV
 oKVypWPimle7X8Nj9UisiXctrW8REntSZtleS+7tLrS5SO1bVWc66q3s4VRlSp0KPotT
 rzrP8VJzeyBEg1e091B/JRHMuyeA7OEWnNS1uPI6VaKn0SoNnimJ42Y+Gg6FF1Ux6rKc
 Y4Gfl4tWJp7qoKnz4PdsxLuvRJUXltPItJNz1ZA2XM0CmdgtOEcxKq2EvgDVIt97lloT
 s2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772161301; x=1772766101;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uKOAVA9B8bemDOxyE9wlnutso3V4zsT+pJhQ+huAKCk=;
 b=Ibh9UBs91xVIVTZRbOphCffkR8cwp06iiOHlecjseay09UusQqZtRUuvMj4Kvd38bD
 HG2/nl7+GxDR6H+WMFLzGrfpgC9WC1a4oF72tdbDcf7Oc5P/iQukdSEPHmJG/Ab/fpD4
 ZDTT2bwIxYW5aJMvlzzsycYm8cNck6yNRKf2bwEhfuqTud/v7gTllHLyrnPF24o9Djcc
 MCQ+bGp/6XFz4ar2SovyUASCafzDuwnM3Rt1kKsux6BTzxSF+XLOTMiEtg/ODYdYz98Q
 9pDnXDJZaD2jfQwnywvw2xYSJsM+5JzNnYeGFkuKs53bpMAZ+gFDyHOI1pF983YAQRV9
 7a4g==
X-Gm-Message-State: AOJu0Yw47NY7l36b6XUhhHUNsWipF+SZJ/9Lo3oig6IenSrqZB+tUyg8
 UVwaDGC6dvGSBflhndStHIuCC98fOfayeXHYfR0llb4hYnUfqSxqLWfe39nyIG/1NOE=
X-Gm-Gg: ATEYQzwiee+K8dzhJoAkiENRB3xmTjKgyVWgBGu942IIdD4SzG3Lay9JJZLjACfcE73
 m/bQ8TflOjc41iS6oVEGNQ3USapR056K5/m4DAcNW+4pP/vVRYc+4ZH/nJsPxU6zLLWrNv0pwmi
 pUqQGc3WsMoyuHZHWe6XY2B3bsIt9e3UJFjQKn8m33R14FMYrqT0nUdeS2BddDfLARmTS64ryzr
 C+7wtdj4bYGTweurT3qzbWpuGL0Zr/R1rjUmMoh1ln0gADRUrv1R/e9yt+DLS/ApbdQNKOTBbOB
 lIwFYcrKP3Bg7bj/O1fURHiYLm02ws4jyc6/mgLuwiTupDDWMu9DeDJgttAISFE5OFQ8Laa1htb
 4rzMUyaG8OZee1aKjxS5GYwxnzNqPmxaVqZreKcpBd0n783nVzj9+b69QWeLPzceE3E7ba8dej3
 ULdrB+ClqIExjBAbIorYz8nUImNNdeFMoyoBimkoc=
X-Received: by 2002:a17:90a:f950:b0:356:22ef:57ba with SMTP id
 98e67ed59e1d1-35965c17f28mr1074569a91.7.1772161300557; 
 Thu, 26 Feb 2026 19:01:40 -0800 (PST)
Received: from [192.168.1.38] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3593db82627sm3551465a91.0.2026.02.26.19.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 19:01:40 -0800 (PST)
Message-ID: <a865e4fc-04a9-42d3-9793-f1d7242565b0@linaro.org>
Date: Fri, 27 Feb 2026 14:01:35 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/84] target/arm: Skip AF and DB updates for
 AccessType_AT
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
 <20250830054128.448363-9-richard.henderson@linaro.org>
 <c805cd6f-e69c-4cf1-8773-0a45bfb677f8@linux.dev>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <c805cd6f-e69c-4cf1-8773-0a45bfb677f8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/27/26 04:12, Zenghui Yu wrote:
>> +    /*
>> +     * For AccessType_AT, DB is not updated (AArch64.SetDirtyFlag),
>> +     * and it is IMPLEMENTATION DEFINED whether AF is updated
>> +     * (AArch64.SetAccessFlag; qemu chooses to not update).
>> +     */
>> +    if (likely(!ptw->in_at)) {
>>           /*
>>            * Access flag.
>>            * If HA is enabled, prepare to update the descriptor below.
> 
> |           * Otherwise, pass the access fault on to software.
> |           */
> |          if (!(descriptor & (1 << 10))) {
> |              if (param.ha) {
> |                  new_descriptor |= 1 << 10; /* AF */
> |              } else {
> |                  fi->type = ARMFault_AccessFlag;
> |                  goto do_fault;
> 
> This also skips the access flag fault which could be generated by an AT
> instruction. Is this an expected change?

Yes.  As mentioned right there in the comment, the access flag fault is IMPLEMENTATION 
DEFINED.


r~

