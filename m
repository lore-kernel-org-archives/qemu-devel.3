Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D196CEFC39
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syEmQ-0007Tv-6p; Tue, 08 Oct 2024 14:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syEmO-0007TS-5A
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:17:52 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syEmL-00076D-Na
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:17:51 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20b5fb2e89dso47315385ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728411468; x=1729016268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=blgVudscveX31njLbd+dJ2k2y2SyCCUUFo/u+umo9tA=;
 b=IilDBDSyortNt/MxBH7GQwWB9PWIYKNGCI1NQt2Lvnl4BQLrQRfSlYscEZeHcYVgJE
 VcRqoKzxV2IqRf+HZ0/JtBu6LLK+Kz+TcxNQWEmqa3mg46T3UktVAluYyGj5kWZes0hK
 gJG3+jfa5P1KedJoRbbfwM+jXj9F3a9UNfTQi33CJ3TnzGJWEJgTevMFp8IGDjvMpjCx
 Onv8YIaEp5ZOP5JyhF3HxrSIk8jb9wJo0EjF2xKYtgshLq0aDKYbI/rzePcJMJpckrCl
 zsjtjY299/KnQxN8AzvlcpRweBuWbzPkAzhha7RtvM+hqiqoIby3I6PlI8USLducIb68
 vFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728411468; x=1729016268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=blgVudscveX31njLbd+dJ2k2y2SyCCUUFo/u+umo9tA=;
 b=SJKF/Au3TLPPB3zPWxAsu4lTiII0lJ74PbKqNgA3gZ8QQoxfrapLxVjL4UlGejODO4
 tJCwdYLs1pASbQfFIGetvff5U03XiU+/548KnY7iyN6eshm3rHTJS/BOHETBAS/XbxpD
 d1zYOomSJryw+PfbFpVO2UnlcOCX98skfzWNO6znUFyrrGwxWY5cWM7goX9w0kkfZaXR
 sskfnJWxLPSEMkleEj4T9lQtyQttE5ASY3CidbiC/i5BMQ0lD7ykec8ETfIJnNIprLKW
 bHD8evKPL5mddrwWYAyS9H7onl0OHIFw0rpRN+5XDZbuHXQAp+u+8CTKEmVoah7sT052
 szrg==
X-Gm-Message-State: AOJu0YyJQpcesB/LRB7VZniojEmxDWgr/rRm6jbPHD40yqCSmbP4SiOp
 7G3R2WFUQAYMd9fubpg5RhLazpCiSeDdeJkKuZl5GlDrbxWrG4HCdxpcErZ5TRE=
X-Google-Smtp-Source: AGHT+IFwt5JiDs+JQaoom5c6uwume7LZx70+24IrfmMCYHXTyBwwcvR3AVVVveUor5iCvJO7F8wUuQ==
X-Received: by 2002:a17:903:120d:b0:20b:6d8c:9d2 with SMTP id
 d9443c01a7336-20bff1df1cfmr215358055ad.54.1728411467958; 
 Tue, 08 Oct 2024 11:17:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c5c0f2edbsm8263955ad.175.2024.10.08.11.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 11:17:47 -0700 (PDT)
Message-ID: <94ebebf2-e775-4fd2-8fcf-921610261a7e@linaro.org>
Date: Tue, 8 Oct 2024 11:17:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] Stop all qemu-cpu threads on a breakpoint
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240923162208.90745-1-iii@linux.ibm.com>
 <8c7ed3d0-15c2-426b-baf5-304a984d2559@linaro.org>
 <7164df57c9c3eae2e6f27be7f6c890081740b2cc.camel@linux.ibm.com>
 <6d820efe-7f0b-4b6b-946d-e1815934e4e9@linaro.org>
 <7cf5d0a94cc52ac9f8144eb5d1cc83811755ea98.camel@linux.ibm.com>
 <7531a0890a2f804b9e5e89e80d019ea53c738eab.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7531a0890a2f804b9e5e89e80d019ea53c738eab.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 10/5/24 13:35, Ilya Leoshkevich wrote:
>> How can we handle the long-running syscalls?
>> Just waiting sounds unsatisfying.
>> Sending a reserved host signal may alter the guest's behaviour if a
>> syscall like pause() is interrupted.
>> What do you think about SIGSTOP-ping the "in_syscall" threads?
>> A quick experiment shows that it should be completely invisible to
>> the
>> guest - the following program continues to run after SIGSTOP/SIGCONT:
>>
>> #include <sys/syscall.h>
>> #include <unistd.h>
>> int main(void) { syscall(__NR_pause); };
> 
> Hmm, no, that won't work: SIGSTOP would stop all threads.
> 
> So I wonder if reserving a host signal for interrupting "in_syscall"
> threads would be an acceptable tradeoff?

Could work, yes.  We already steal SIGRTMIN for guest abort (to distinguish from host 
abort), and remap guest __SIGRTMIN to host SIGRTMIN+1.  Grabbing SIGRTMIN+1 should work 
ok, modulo the existing problem of presenting the guest with an incomplete set of signals.

I've wondered from time to time about multiplexing signals in this space, but I think that 
runs afoul of having a consistent mapping for interprocess signaling.


r~

