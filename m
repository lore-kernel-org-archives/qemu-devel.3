Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3590DC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 16:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uChRk-00053p-Ci; Wed, 07 May 2025 12:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uChRd-00050p-Im
 for qemu-devel@nongnu.org; Wed, 07 May 2025 12:16:29 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uChRW-0005n2-VL
 for qemu-devel@nongnu.org; Wed, 07 May 2025 12:16:29 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so109210b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746634580; x=1747239380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qf1F8oPA8ZZ6Qg+U7WD2aIsV0/2k/8qi9jG+1yRTRno=;
 b=VnPJOjvkEwX4/9zNjDH3BGbx8KqfMv3NqMREjgTRbmpMdKq1b5WGJEPjoUcmSNDegD
 s7rtSrbDEJ+TaMYXHjBh+3OOh/hHxTcHYpWqxQr9kkZUXa6jAxlvEu+z+FligkkfZSPd
 s2mJrUUZDXzgOCyMNpHvBEj8yi3Jq7lCVX4lEytWDTdWCiwu8G0caSt5BApxs7BLiaqi
 zmUSK3cpW0bybqqPH9/elkxOC03M8svgs0xuy6d2T9mADQGxkTZYlPokskU2ACsOQN4i
 PrEYJ1R4u85XGAdNTSnOqT3xI9HsYOhKkmw3zLezVHokDt8IjrfnL7M8SgKt6Wz1rtWg
 rCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746634580; x=1747239380;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qf1F8oPA8ZZ6Qg+U7WD2aIsV0/2k/8qi9jG+1yRTRno=;
 b=DnoPDjDqM7AOkriulIqvJnmV992WO87afoJC8J69yI4kmEcOMpR8XHLQTeyxA77dtv
 FTXWHqeP+li0iZNaTNpIoyGvXyK+Hkm8/Ve7FdWgFeG1ZRgDeRdSSOYdw0JRpUqTDZzo
 xb/jMZr4wZ7eNGpRtjAqa5b7/59xDFIfuUDje3fUTdOje6FBY7hkbZQkSiJFH0+YW+/j
 T+CCbPO60yvhXlh/x6UHz6RlhnxKJbSTto53aWlx7pVMGtm5qcE0udC4ujAuQL7ws8ZP
 /SRile3y45QcneJQoUjy8XOO8k4bLnA8z4eBK1DAVJjSdqDRro210wsMMcL2GnXR1TNp
 WsbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlGKxKbMss/LXsBx+uQsC+n+ShjdT6row4BgLLaKDJih8VyAB4gIQNLOlRr7yiPaFzAjtpCHievcNF@nongnu.org
X-Gm-Message-State: AOJu0YyYgR/ht8xwcpEGei70njAzNY+tFFO9QYHrFFKbEvgIPWrIR6eZ
 QIl+0rCFs9X9ylM04wVJBpdKzAkvUSkrQlGTdu2NpfdPULEkxrfeSJI/HAR9K2o=
X-Gm-Gg: ASbGncsPJFXL/W6S8ewa3qkxF4paR1IXJSDQcXIEC/Q5EwUtxDKKcPdNj4I412AB+J8
 55TWmE9PrHOr/dOVRbn329GYLfDLfgPfMhDH2yCLJKyfgpIKM1eoWPEvfFRPA2KD/rQUioK52Uq
 D3xwRHdEAqMk9tyUE1l0XGltsAi1gAAu1s60SzlXc7dGYZefMTYA2qOEdWVNylOUiTq8I/JfVH9
 AVos5eYVB/QQPyM/XMWtxI0FLr0qM/U6jebSRe9wtp7pUBa3nmTmyT5XQjVmiuMOkhJh9skJFFY
 bwrO8UjoLXoIcbz6Full5VYIQavomSyT3u7qRbBSZf5MnCOnMvsA2ZdeCUUSp4mDnMh8p+F4WrU
 F1aDrKso=
X-Google-Smtp-Source: AGHT+IHuvAHTkrCGR3gS9Ek4irr1DNKF1M9il/RJccbedlFZbaPEz7DBDf34+20Gv/x6icCULh+j4g==
X-Received: by 2002:a05:6a00:3314:b0:736:7270:4d18 with SMTP id
 d2e1a72fcca58-7409cf1b4d9mr5497889b3a.14.1746634580164; 
 Wed, 07 May 2025 09:16:20 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3c6b327sm9744804a12.71.2025.05.07.09.16.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 09:16:19 -0700 (PDT)
Message-ID: <0e8eb12f-cf6c-4021-842d-ebed0ffb1fe4@linaro.org>
Date: Wed, 7 May 2025 09:16:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] target/loongarch: Fix incorrect rounding in
 fnm{add,sub} under certain modes
To: WANG Rui <wangrui@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org, qemu@hev.cc,
 mengqinggang <mengqinggang@loongson.cn>
References: <20250507091455.3257138-1-wangrui@loongson.cn>
 <f92c8c65-8fb4-4cfe-b793-a5aa17f11c1d@linaro.org>
 <CAHirt9jd4LGkGyp0xKFQYKM3CnPYUs4xJmSyg4je6iMKR_0b5A@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAHirt9jd4LGkGyp0xKFQYKM3CnPYUs4xJmSyg4je6iMKR_0b5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 5/7/25 08:25, WANG Rui wrote:
> Hi Richard,
> 
> On Wed, May 7, 2025 at 11:04 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 5/7/25 02:14, WANG Rui wrote:
>>> This patch fixes incorrect results for `[xv]fnm{add,sub}.{s,d}`
>>> instructions when rounding toward {zero, positive, negative}.
>>>
>>> According to the LoongArch ISA specification, the result of an
>>> instruction like `FNMSUB.D` is computed as:
>>>
>>>     FR[fd] = -FP64_fusedMultiplyAdd(FR[fj], FR[fk], -FR[fa])
>>>
>>> Here, `FP64_fusedMultiplyAdd()` performs a fused multiply-add operation
>>> compliant with IEEE 754-2008. The negation is applied to the fully
>>> rounded result of the fused operation - not to any intermediate value.
>>> This behavior is specifiec to LoongArch and differs from other arches,
>>> which is why the existing `float_muladd_negate_result` flag does not
>>> model it correctly.
>>
>> Loongarch does not differ from other arches; we got it wrong for everyone.
>> There's no need for a new flag.
> 
> I'm not familiar with PowerPC and s390x. The official PowerPC docs[^1]
> doesn't clearly specify the order of negation and rounding operations.

Certainly it does.

   This instruction produces the same result as would be
   obtained by using the Floating Multiply-Subtract
   instruction and then negating the result, with the
   following exceptions.

Round is done the same as FMSUB, *and then negating*.
So the negation must happen second.


> I also don't have access to the hardware to run experiments. However,
> I did find the Linux kernel's emulation code[^2][^3] for the PowerPC
> `fnmsub` instruction, which seems to suggest that negation occurs
> before rounding - though it's possible that interpretation is
> incorrect.

That code gets this case wrong, just like we did.


> 
> [^1]: https://www.ibm.com/docs/en/aix/7.2?topic=set-fnmsub-fnms-floating-negative-multiply-subtract-instruction
> [^2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/math-emu/fnmsub.c?h=v6.15-rc5#n49
> [^3}: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/math-emu/fnmsub.c?h=v6.15-rc5#n55
> 
> Regards,
> -hev
> 
>>
>>
>> r~
> 


