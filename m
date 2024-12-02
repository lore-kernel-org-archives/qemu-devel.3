Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15670D7831C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIARV-0000Pb-SU; Mon, 02 Dec 2024 12:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIART-0000PA-Hj
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:42:39 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIARQ-0004rB-Rh
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:42:39 -0500
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-46690cbec70so35594781cf.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733161355; x=1733766155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t325FAHpD6FaZW+DFVGrJEWW7GPTGVJnv+EL2jEWUb4=;
 b=JFXmBTtb9LKyHqgf1Cp1gMVKrsB/rZmkUQH+UzKhMHkZGGxuGp9yMCDeSM63XZbhAQ
 RuiOkVDHl7A+zYZXkV0YJqCaty9tv0kO50Q8bdWRg5wv6o4oPz24fO9TWrPqEWDD2Zm2
 0iDJHAjfjsS/7dMrGlxw6z1X341hwnh4yxeR6r3jaGk0qA8TzkNztJ1/SY8x+ncTHsdy
 7a/CEbJMd/TISJ3f0DG7arQ1s5BndVBypQaHp8aC+/nheIEJ0F+r6yDEvId6NdLzqevP
 pZsoJKhw5cFOYQA9QEAF5Pcoqh2w6Plpbn70DNYwJ8cMyj/rhWr1XvqGS1je00+GaZtx
 vs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733161355; x=1733766155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t325FAHpD6FaZW+DFVGrJEWW7GPTGVJnv+EL2jEWUb4=;
 b=nLqpmNydl7W+yPhXZIl3JOLe3637lP9YipAHpQRCTv9Uj3YwgInaDGBN7MFGpJe1fY
 kIHdVco59VWFb2gYLn55U+Qcf4iMZl6TRxgxQjvxP1qK6s4pfgiKhbZ7CxbswrUNQqQa
 abWNO7KLJzXXLRuNPNYNESg8e+3MoDur8EQl5FPU6fSdNrLLmzJmWvb8U2BeqsuWgfrk
 suaRdZhUtjyUQkLgx1zD+fc6mUlUopBoReEXjgQe++7ovYcXHAWFSEaCjDPM4ZZSqRik
 E2Tg408ELOW1bCpLXa7RHWUhWkTMvj2t38tdQTvAfcevB5Tkgx++g6peprHF7gCYqeUY
 woNg==
X-Gm-Message-State: AOJu0Yx0sLgi0+nixSGfG8yRMtf+3jNj+QmcPQDAfd0NPPwow5IV5Z99
 6/Sbghx0b69L/MxYeaOMWBRQELptEXhchxXB+8wx/6YdnRlv1A7Z2iHa43Pf/t9PbEFTHvgsq9c
 VKNM=
X-Gm-Gg: ASbGnctZYm7LvQCNYo4aErbH0L/0afhmiSboXx6aCDI4U1AZkv5qwwovRMELdIji1hv
 w6zuFZ80hqQ2tWOgDECDVBqLnq1T0w542+WOB3HWaK4+Cd+x7visBAVAqEwN86yufim5B2NdtZ+
 vaQyO1xqHlQ1r0xVUY+5qeDCLt1O2ezpPwmdqAU62pimBxOhqmByrYuYvwCaCiBmpRqbMbmQkzp
 nb15XYCRNfnZgNKrdPFklMQDD9/Z4OEAkfbthaH5xTIhVqSDFvt0v0NXBmIpHL7uLIbQ5E=
X-Google-Smtp-Source: AGHT+IF5T66osqDYYEQqxjKzdq5Mtj1JSbMTL8wM9VjS0EXh4XNAeY1Mbl/88qafpdsnXRLtcol0Qg==
X-Received: by 2002:a05:622a:24c:b0:466:a983:a15a with SMTP id
 d75a77b69052e-466b3618637mr307193521cf.42.1733161355584; 
 Mon, 02 Dec 2024 09:42:35 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c4055062sm50806801cf.6.2024.12.02.09.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:42:35 -0800 (PST)
Message-ID: <31e4132b-f5cf-4d08-a459-f4987c8f03ab@linaro.org>
Date: Mon, 2 Dec 2024 11:42:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2] target/riscv: Avoid bad shift in
 riscv_cpu_do_interrupt()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241128103831.3452572-1-peter.maydell@linaro.org>
 <c6ea5acc-e07f-4eb8-ad8a-b339f27c9102@linaro.org>
 <CAFEAcA_GA+UKqj6izUXY_snEECJc6buNiKrgA9yXXAW8skqcBg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_GA+UKqj6izUXY_snEECJc6buNiKrgA9yXXAW8skqcBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x831.google.com
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

On 12/2/24 07:46, Peter Maydell wrote:
> On Thu, 28 Nov 2024 at 12:59, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 11/28/24 04:38, Peter Maydell wrote:
>>> In riscv_cpu_do_interrupt() we use the 'cause' value we got out of
>>> cs->exception as a shift value.  However this value can be larger
>>> than 31, which means that "1 << cause" is undefined behaviour,
>>> because we do the shift on an 'int' type.
>>>
>>> This causes the undefined behaviour sanitizer to complain
>>> on one of the check-tcg tests:
>>>
>>> $ UBSAN_OPTIONS=print_stacktrace=1:abort_on_error=1:halt_on_error=1 ./build/clang/qemu-system-riscv64 -M virt -semihosting -display none -device loader,file=build/clang/tests/tcg/riscv64-softmmu/issue1060
>>> ../../target/riscv/cpu_helper.c:1805:38: runtime error: shift exponent 63 is too large for 32-bit type 'int'
>>>       #0 0x55f2dc026703 in riscv_cpu_do_interrupt /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../target/riscv/cpu_helper.c:1805:38
>>>       #1 0x55f2dc3d170e in cpu_handle_exception /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../accel/tcg/cpu-exec.c:752:9
>>>
>>> In this case cause is RISCV_EXCP_SEMIHOST, which is 0x3f.
>>
>> Semihosting is completely artificial and should never be injected.
>> The maximum "real" cause is
>>
>>       RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT = 0x17,
>>
>> We ought to hoist the handling of RISCV_EXCP_SEMIHOST higher in the function, before these
>> calculations.
> 
> Perhaps so, but looking at
> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupts-1.0.pdf
> it says that mvien, mie, etc are 64-bit registers and the
> cause value can be validly greater than 31. So we need to
> use the ULL suffix here. And if we're doing that, then it's
> harmless to also calculate these booleans even in the
> semihosting case, because we don't look at them then.
> 
> So I think we definitely need this patch, and whether
> to refactor the code to move the bool initializers around
> is a separate question.
I missed that the registers are 64-bit, so fair enough.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

