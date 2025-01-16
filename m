Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485A6C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRcl-0000P7-5G; Thu, 16 Jan 2025 10:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRcf-0000Nn-9X
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:17:30 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRcd-0004ug-9N
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:17:28 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so6970335e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737040645; x=1737645445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MjA6IByeKPWxn0eOHPWFnTpcuEOKNk/7MHDsb7i1wjg=;
 b=jzwaULLVYxZU7XH/oDa841tb3qyGyes1INbvp+hS8DTLCfC4W/MmiTUJjdTLWZDdvK
 GrDjUpAhAnkwz62GI72mU6PwIWnNNNcoJlYvEEiqsYR08HJj8twCFXcY/MTccjIEw/RD
 g7beJTuI8PAWCDWutDG6kEjIK0HMYJs198BcKAmvxLANnmkzO/cKQrBESy86qnHHetS9
 LtyHnYj5/uL/8MCVaA0H42S3CWGkOJQSCm+jA1oGvUCIiV3xbHaSW/8+AsWY8z3BXoZ+
 t2gP/fIC+biq/boi0Er9hm5bJP0kitXbAgWoVe+HCe2hweUrk1NIhafioRXUwx2TeSuD
 3GyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737040645; x=1737645445;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MjA6IByeKPWxn0eOHPWFnTpcuEOKNk/7MHDsb7i1wjg=;
 b=HZ05ZvwuwIWrwjLP+6fND+8JnHWgIV2ezeCSbfGItrX6F2MrR9/LdHgCJyS4QzBiQ0
 7Tt14wm59zaL9rFJYWJTTkI/lJrw8T7M5UuOdlcJznkrEJb7C2qZ4ul5S1mU5dT4zLP0
 b/Peop9cCclLZf5VvKty1mflJQNV+p8j7vUD+QUruuFdNC6WGweTN9+9H929wdFKoajK
 pfTHGDQLhhn0wViBpy+6oCZ/pJl6qzcyqho5l/OfUIq3CpFvcfMKwyDkIHi2ecibdVSj
 JnHRnYVYWjjSOrtDHNLrngIoz8NqYryuatJvsWD7VgBeSJ7oTHWErWPKWQOAlc8M7JUf
 pthw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWATtAaZRgQwU/tws8xegwwiZHlI8bEl0hNI9iFuq2ARP2ZdCgDIMnDvUI0stX7BSFIfIaeLWP7VKaZ@nongnu.org
X-Gm-Message-State: AOJu0Yxcyms/5klJM0vP9HPQ0f+AR0E+6rSVmJTwk/2TD1kRrcOvNurO
 lAlIQ1SeBqcw2C2HiAfwRFZCYtlkXH+qQSoEImHjVaCH/nnLWUDR2WrjxgbUlMk=
X-Gm-Gg: ASbGncuou2FlczqLNHFtIxEqGaINZ7MdjZxH1zCwieWzgF2iQU1OLX0kIskqPqM9H8Y
 HRZFhoIk0DF+tOmTK8Y4ImTC/c4ge0qW5QQ3aEIA66uzgBHIzPuJvF8fd+kHLEEjRgW4TgDmu/X
 o1R8b776KNSn8w+5xFu1dc/vYum3jHGkFtNIPPqBg6Oy7dmRW7jyykrQhdbwYeHHzdLrAkL7A2H
 2otDT/BRtJRYDNAp2kuUMz9zic9efXm0qsxEsutRZ0jM0W0iqa4Hyy88ztdEwxt+zxkkNsUlZLs
 fu20I/CL89vggALe96bG+vTu
X-Google-Smtp-Source: AGHT+IG1Rd8Y3KeTrm0+fimHUkxcDcAtboqHe9OhrPiNQwcs2A/fdbJu8yglbAvPSQcaTvV86eMDMw==
X-Received: by 2002:a05:600c:1e17:b0:434:9d62:aa23 with SMTP id
 5b1f17b1804b1-436e26dda97mr284041415e9.20.1737040645463; 
 Thu, 16 Jan 2025 07:17:25 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c749956fsm63034855e9.4.2025.01.16.07.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 07:17:24 -0800 (PST)
Message-ID: <7d1980bd-2b07-442c-b992-70f5c48aa0ec@linaro.org>
Date: Thu, 16 Jan 2025 16:17:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20250115232022.27332-1-iii@linux.ibm.com>
 <ac4d48c3-d139-4af0-ab28-f2674b74cb8c@linaro.org>
 <a82c41712409ac77d66f03e19b98382bcf11ba45.camel@linux.ibm.com>
 <87frljhvzk.fsf@draig.linaro.org>
 <CAFEAcA-4M5W4=JH3s45+9JZnKrVVAgKcRcH+gVqMJqGxRfjrpw@mail.gmail.com>
 <65e146746377bc307affc627f47c4700aaaac4ba.camel@linux.ibm.com>
 <CAFEAcA-ZOJUQPGWs7Czt1A1CdyojNoQ2L62Z-MvREgkg6GO4-A@mail.gmail.com>
 <87y0zahk2p.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87y0zahk2p.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 16/1/25 16:09, Alex Bennée wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Thu, 16 Jan 2025 at 11:48, Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>>>
>>> On Thu, 2025-01-16 at 11:06 +0000, Peter Maydell wrote:
>>>> The original reported problem here seems to me like it's a
>>>> problem with whatever target's frontend code this is.
>>>> This is a single instruction TB, so either:
>>>>   * the generated code for it completes the insn without
>>>>     raising an exception (no problem)
>>>>   * the generated code for it should raise an exception
>>>>     without having modified the CPU state (so there would
>>>>     be nothing to do for restore_state_to_opc)
>>>>
>>>> It sounds like the target is generating code which does
>>>> something like:
>>>>   * do part of the instruction, including updating some of
>>>>     the CPU state
>>>>   * then decide it needs to raise an exception, and rely on
>>>>     the restore_state_to_opc handling to undo the state updates
>>>>     it did previously
>>>>
>>>> The assumption of the "throwaway single insn TB" is that
>>>> you don't do that (i.e. that restore_state_to_opc is only
>>>> there for the benefit of multi-insn TBs).
>>
>>> The problem is not a partial state update in an instruction, but rather
>>> that on some targets restore_state_to_opc is more than just a
>>> "restore" - it is also "prepare for handling an exception", i.e.:
>>>
>>> - arm: exception.syndrome
>>> - hppa: unwind_breg, psw_n
>>> - mips: btarget
>>> - openrisc: ppc
>>> - riscv: excp_uw2
>>> - s390x: int_pgm_ilen

Should we move that to another TCGCPUOps handler?

>>> Some of these may be wrong due to unfamiliarity with the respective
>>> architectures, sorry - but this illustrates the idea.
>>
>> Ah, yes, thanks for the clear explanation. The "throw away
>> the TB" design didn't consider that (or vice-versa).
> 
> We can certainly do with better docstrings for tcg_tb_lookup (via the
> region tree) and tb_lookup (using cache and/or QHT) to make it clear the
> difference between the two. I don't think we should ever use
> tcg_tb_lookup for the purposes of executing a TB, just for resolution.
> 
> We have a few spare CF_ flags so maybe we could have a CF_RUNONCE flag
> which is set for these TBs and assert its not set in tb_lookup along
> with the current CF_INVALID flag. We could possibly set CF_INVALID
> before executing the TB as we don't check the tb state from
> tb_gen_code() before executing it but I guess that might be a little too
> magic.
> 
> Rich, WDYT?
> 
>>
>> thanks
>> -- PMM
> 


