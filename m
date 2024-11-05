Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE3FD3E77A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8S4k-0005v1-RL; Tue, 05 Nov 2024 17:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8S4i-0005un-Kv
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:31:00 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8S4h-0001WX-1x
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:31:00 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4315f24a6bbso47237085e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730845857; x=1731450657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qMRl51ZHH1GlPIH3BSyH8f14+Oq4zE2Go9Xkc9ns3OM=;
 b=VLa63o1A6D3hNn4QliLLzYG0CrmIFC0g7dLLkjdhxhuhHPSO2SYJ7NnVa+lEeOLvXl
 +HN8aGnNPZms6+o0ulgvbCV9RHFnJnY07wAqB0I7zrhj0IS1LIt3V5HKGZ+mce7xL6es
 04eFunj/dafbldqHyy74kQf6HfaQ8PQJVDxXfNMhtgv/mkMf02F8I2jXc6V8k0+Q9uU+
 nVs356xMN/Z0B/ZeM3Fib7jWMxj+6SPSzKzYgq2i9IkJPqDYisIhiPrQVDyGhEpfWP1g
 gXe7ucf8+zfx0T5gtHgy9wlmMsE3lOQzKnt/kONCUNRzO7IifFOZoRVKaGwXOJGsaLS6
 i7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730845857; x=1731450657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qMRl51ZHH1GlPIH3BSyH8f14+Oq4zE2Go9Xkc9ns3OM=;
 b=MTbkwD5e4bOHS9TjbCbdEHnQ0WnmREdSrYiX6VK2LpVWyKUHQfpTeyrDv9YKxwcth5
 Jb3Uz9PbCh2whMOiko9/N4C2skGsiQOxWr4QYC139rnKyBS0Wxlfxvoz7wGN8QQl0ATp
 U4pO2QxJpcoxOPDjOvBXBrEl89ZMuYnE3AdNJdXP1in7OJYlbu9b9rysfgPGpWOzRUE0
 +4iNH+doTZfqtRPuEOVLX/xPdU+fgxX6rCHRMpQsmEBdaiFOFqLvdTPGEUl1GEb273M+
 Drwp/CcrI6gSUkZ4s5ZxbqRe2Lp+Qy1PrmF+yKbD/3f5irqbWGl3sUeYQpFd1YE2sVKh
 yzrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUN3yBfK2ahhsUpqkDd2pdPKp9yWvRfxzrq/zOdjkt3CxA276OETYcOg57EBGowwrKxlJyjgoIyUWr@nongnu.org
X-Gm-Message-State: AOJu0Yy9FkFB+HCVaeAwraPh/9uvsK+h6cQys+O+DlsLJbJ+AcwrWYgQ
 OEikD1mfC7eU5wGamcEfjmFk7n73XbFdwlONGNoCFzFaYZdf4FYE+TRbIB5T21M=
X-Google-Smtp-Source: AGHT+IE28evwYtfdrTVpFOqyUDsAbOAz0PlKUKXpKUEq0iOBLjdSwRkIobVHlFL6cABSRNoYCW/yDQ==
X-Received: by 2002:a05:600c:4f4a:b0:431:50fa:89c4 with SMTP id
 5b1f17b1804b1-4319ac6fb17mr356016225e9.3.1730845857240; 
 Tue, 05 Nov 2024 14:30:57 -0800 (PST)
Received: from [192.168.21.227] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5fc9sm744705e9.3.2024.11.05.14.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 14:30:56 -0800 (PST)
Message-ID: <10571acb-fb5a-4288-8236-4a95b4247829@linaro.org>
Date: Tue, 5 Nov 2024 22:30:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] user: Introduce host_interrupt_signal
To: Ilya Leoshkevich <iii@linux.ibm.com>, Warner Losh <imp@bsdimp.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241024200031.80327-1-iii@linux.ibm.com>
 <20241024200031.80327-5-iii@linux.ibm.com>
 <CANCZdfrhzc-HZabUjkAMTgcHR0+6OQPxNshkQfMYD4wbNcm=wQ@mail.gmail.com>
 <74ef513603500e76330c2735803d5e1402406f4a.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <74ef513603500e76330c2735803d5e1402406f4a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 11/5/24 15:50, Ilya Leoshkevich wrote:
> On Tue, 2024-11-05 at 08:39 -0700, Warner Losh wrote:
>> On Thu, Oct 24, 2024 at 2:00 PM Ilya Leoshkevich <iii@linux.ibm.com>
>> wrote:
>>> Attaching to the gdbstub of a running process requires stopping its
>>> threads. For threads that run on a CPU, cpu_exit() is enough, but
>>> the
>>> only way to grab attention of a thread that is stuck in a long-
>>> running
>>> syscall is to interrupt it with a signal.
>>>
>>> Reserve a host realtime signal for this, just like it's already
>>> done
>>> for TARGET_SIGABRT on Linux. This may reduce the number of
>>> available
>>> guest realtime signals by one, but this is acceptable, since there
>>> are
>>> quite a lot of them, and it's unlikely that there are apps that
>>> need
>>> them all.
>>>
>>> Set signal_pending for the safe_sycall machinery to prevent
>>> invoking
>>> the syscall. This is a lie, since we don't queue a guest signal,
>>> but
>>> process_pending_signals() can handle the absence of pending
>>> signals.
>>> The syscall returns with QEMU_ERESTARTSYS errno, which arranges for
>>> the automatic restart. This is important, because it helps avoiding
>>> disturbing poorly written guests.
>>>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>   bsd-user/signal.c     | 12 ++++++++++++
>>>   include/user/signal.h |  2 ++
>>>   linux-user/signal.c   | 11 +++++++++++
>>>   3 files changed, 25 insertions(+)
>>>
>>> diff --git a/bsd-user/signal.c b/bsd-user/signal.c
>>> index a2b11a97131..992736df5c5 100644
>>> --- a/bsd-user/signal.c
>>> +++ b/bsd-user/signal.c
>>> @@ -49,6 +49,8 @@ static inline int sas_ss_flags(TaskState *ts,
>>> unsigned long sp)
>>>           on_sig_stack(ts, sp) ? SS_ONSTACK : 0;
>>>   }
>>>
>>> +int host_interrupt_signal = SIGRTMAX;
>>> +
>>>
>>
>>
>> I'd be tempted to use SIGRTMAX + 1 or even TARGET_NSIG. 127 or 128
>> would
>> work and not overflow any arrays (or hit any bounds tests) I'd likely
>> use SIGRTMAX + 1,
>> though, since it avoids any edge-cases from sig == NSIG that might be
>> in the code
>> unnoticed.
>>
>> Now, having said that, I don't think that there's too many (any?)
>> programs we need
>> to run as bsd-user that have real-time signals, much less one that
>> uses SIGRTMAX,
>> but stranger things have happened. But it is a little wiggle room
>> just in case.
>>
>> Other than that:
>>
>> Reviewed-by: Warner Losh <imp@bsdimp.com>
> 
> Thanks for the suggestion, I'll use SIGRTMAX + 1 in v2.


That can't be right -- SIGRTMAX+1 is not a valid signal.


r~


