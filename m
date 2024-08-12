Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838CFC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 07:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdP56-000740-GF; Mon, 12 Aug 2024 03:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdP54-00073V-8U
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 03:03:02 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdP52-0000p1-B8
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 03:03:01 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fd6ed7688cso33744545ad.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723446178; x=1724050978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pUSwd+I5HA5+K4SJCb7NWrcUu0MNeoI1nXmCi6HLTx8=;
 b=Bs24NWvFQQLBP3kxFXwAMyyR53TOETqRx71YXs/Bt91iPhY28HUYKevy6fFTWruCUA
 x1ut6FsYhwMKTy9QW0BWLyX7Zh15TtUhUB1YCNMPlvG+guKQ26jYRx0lT9uW7ytJIy16
 mYdI55TbKAmuI7ykTnQ98MXgDlezEmsJ32VXxsLxte8ywqlzPs//Eu3PvJEQ4IS7CM89
 R2pj9tQlCoGc7B9y7rGzmticBkEq58kjWsj/rzbrQ2/yt27sNhhtem063Swv3zopbQU8
 jKvic/toC8rN9KI09cXLIcsOhEfc7L2KdwT9JHItxWvaqAphzzqQ92RsSG3i5zJKVjYn
 SWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723446178; x=1724050978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pUSwd+I5HA5+K4SJCb7NWrcUu0MNeoI1nXmCi6HLTx8=;
 b=PfKsptQMETpu0Jt/MYZ7YZ5Jpw49erB41xc0mBYS+9p41kQ5KFjRgqNCcdfIvCUFOy
 NsvkJOg7LK433B43RC/eKKOV0ykE5307wIIW/02zwhURPE42WF2JNljE5qQYV+JYHjvR
 AI3LmEwaCuFeG62IG7fbcrqAQe+un8bWDxeGooAh6qUNkEzJUG5lx6gKEhmPHVBxTyeZ
 iwbJZp/jKjAOkLjD1JZutD8naRDi5d2byTZE//SRTakG+se8xW6EZJKeDkAh1NHtPcqy
 bypiQi21C5K0T7HOQ4vgfcyu0xcjWWMeLIEliEj9vX/gGl5k0IsN+3BSkcjQkBsZq+tF
 sn/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW8K+wK8IwM8iVNDzES1aTLw77Z8Ohi3pgX+QMXCvmmkAfAoPAuzJvdxJixlaQhnWN2vxrNuqgG1e4fpVeLc9ZgmTRUos=
X-Gm-Message-State: AOJu0Yz0oBpDhFITr4kOON7OH/4LosHQq/sFSp+WLos4lfBdY7pEQCkA
 HNtXdaBQCrFhsrWvVrMJe3DpJmQSWLcw3ycKKO+BChTztW6caZnlQ6b8SJp7ZCw=
X-Google-Smtp-Source: AGHT+IGuKQbHtVM8cPv/6hmkXT/ci5zHjMOwIpJ8/3Qwm56Vpd+rnSbXaj+Z2XCTljIWi18iRtQ0uQ==
X-Received: by 2002:a17:902:d2d1:b0:1fb:5813:998c with SMTP id
 d9443c01a7336-200ae4da595mr61218455ad.20.1723446177877; 
 Mon, 12 Aug 2024 00:02:57 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bb9b47besm31375995ad.127.2024.08.12.00.02.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 00:02:57 -0700 (PDT)
Message-ID: <62e4979d-bf44-4555-996c-c51bdf6e2441@linaro.org>
Date: Mon, 12 Aug 2024 17:02:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] target/mips: Fix execution mode in
 page_table_walk_refill()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>
References: <20240811165407.26312-1-philmd@linaro.org>
 <be719b7b-9096-4d15-9947-8e4003de302d@linaro.org>
 <2506e429-b5ca-4ff1-99a0-2df157321c4d@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2506e429-b5ca-4ff1-99a0-2df157321c4d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/12/24 15:35, Philippe Mathieu-Daudé wrote:
> On 12/8/24 02:48, Richard Henderson wrote:
>> On 8/12/24 02:54, Philippe Mathieu-Daudé wrote:
>>> When refactoring page_table_walk_refill() in commit 4e999bf419
>>> we replaced the execution mode and forced it to kernel mode.
>>> Restore the previous behavior to also get supervisor / user modes.
>>>
>>> Reported-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>>> Reported-by: Waldemar Brodkorb <wbx@uclibc-ng.org>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2470
>>> Fixes: 4e999bf419 ("target/mips: Pass ptw_mmu_idx down from mips_cpu_tlb_fill")
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   target/mips/tcg/sysemu/tlb_helper.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
>>> index 3ba6d369a6..e7ae4f0bef 100644
>>> --- a/target/mips/tcg/sysemu/tlb_helper.c
>>> +++ b/target/mips/tcg/sysemu/tlb_helper.c
>>> @@ -940,8 +940,9 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>>            * Memory reads during hardware page table walking are performed
>>>            * as if they were kernel-mode load instructions.
>>>            */
>>> -        int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL ?
>>> -                           MMU_ERL_IDX : MMU_KERNEL_IDX);
>>> +        int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL)
>>> +                          ? MMU_ERL_IDX
>>> +                          : (env->hflags & MIPS_HFLAG_KSU);
>>
>> This contradicts the comment above.
>> If this code change is correct, then the comment isn't.
> 
> OK.
> 
>> But the comment certainly makes sense -- page tables are never accessible to user mode.
> 
> But we are still dropping the supervisor mode, so OK if I
> reword as:
> 
> "Restore the previous behavior to also get supervisor modes."

The old code

-        env->hflags &= ~MIPS_HFLAG_KSU;

drops both supervisor and user bits, so my comment still stands.


r~

