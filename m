Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ECF10987B0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3czm-00058m-N5; Fri, 20 Mar 2026 12:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cza-000589-RX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:46:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3czY-0008N4-Sm
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:46:34 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so16064795e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774025191; x=1774629991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7CmzD9loR/apzA29eyUdSzp7kIKRGcBUvjQ+0lMS6lM=;
 b=Qha8AIdhJqwM7YVzLpS9oUKrnzB7TaJNoNfaZhlyu+o2UzT9II70U5AQIGmMKMvf2P
 cosldSQRwsPwBfpis2AWvNjMFEEd19pc20/PZFXDmZjs7zPo+p6JtlT3WBLB0zRjSOzI
 7hLARCJaelMt1fGwKR/RKEx3Q+/b8JmmNaenS+5Ko03sfXpZR2cn1CH1HAG3HBNtgnqu
 xkF68uDrgcZk291nBGjW6TinX6+tlbRRmysmsGmem51RUCiSPEH6QzkLyQ1OXHr+yBDq
 TooTLv+N+0/clkJqs8RKyy15xfqlAh/NbHeGdkf+nTpi/BwfZTGAs8MWJ1vM5Bblr9ar
 HOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774025191; x=1774629991;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7CmzD9loR/apzA29eyUdSzp7kIKRGcBUvjQ+0lMS6lM=;
 b=cZoFSL0CXNCgGGNKcNAzV1+8r0MHju3ocI2Jin0F6A1583yrRTivRuE4jSq4zeGY16
 551rDDUTLbFl6aoRoLAbjbMFihLgQ24lhjXlvOCymPb7dILu4zBYyeTWlIul8vXFCYB/
 3QRJfGCngZlXwOtI/ZDsEoasW0RaHrMHGk701YhQf1l8qWFypOpzTlF0lFLfxVN1Liv3
 KRI3YCVMafMbGA4yGRH1KvNToNB+VhZWSDzCa3Uik7UyKX2lQuyzEC38KUbbBa15JXAf
 KIkttxevvRxGalpvnC9hrDkitKAFhHZ6bNfpClaScZNK0tkJJl/P+eHNS1+QR0ANFs0e
 FDaw==
X-Gm-Message-State: AOJu0YyZrQL7UVcin6L17CiUx9ziqkICCKmzxDajbNYB973E731axo/e
 izdhH3sP4dHpOuCJWE32pSXyv3s0EX2WoVJ3Xh2wJ4dAnmB7nFgGytFAmRvlf/v1UXA=
X-Gm-Gg: ATEYQzxHkynq9sAMCjTeFp2n3zy4CYgeZK4WwshxhmeWeVxy0VCmznsBpYrgN90w3Ud
 DGgGJc1zIBzYEFiAZu67El9GcReDaIzme9e2YqQpgErPKDPAXsQGKADsL6h/cw8DJw5GvJ5LU/k
 XJg6NOLJ26OyTAQVYjV5NL8l1lyd4XUBTBWp3YYj8+e4htdrRQG9jiGWyg8OblFUXfe5hd7qgmw
 lfwR1r/YHquA34kHcxXAA6pEsM6u/lvvjy84s522pm9jGJ9fOFMN3LdqgxP24UhZXz8Jg30H0ED
 hKI7JtXoJ8mq9MHo20HjFypdZIHxXQMgloreyNoIrqftrsz8p/hIi0EaG5MhilA1ZfEdHwZ+SRL
 VunTalIoUPYNH68iJSvUujOpvEIB7DjEzjzmkJLqtflLuLhUCSF8LR9zcdcAC6UhyUTqzZ8mayR
 u/PxqcuXy4/fPSJ6LjgA/5V6Lur1TNDteaT8g0saQIlmD4xonvohqcxL9VEzHoLuvh+A==
X-Received: by 2002:a05:600c:1383:b0:486:fbc4:8fe2 with SMTP id
 5b1f17b1804b1-486fe8fb2b2mr62901125e9.15.1774025191000; 
 Fri, 20 Mar 2026 09:46:31 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe80a0b1sm36968495e9.0.2026.03.20.09.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 09:46:30 -0700 (PDT)
Message-ID: <b23f0bbf-48cf-4beb-a0db-8ab215ca9e0b@linaro.org>
Date: Fri, 20 Mar 2026 17:46:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1] target/xtensa: Have 'info tlb' dump MMU
 information on monitor
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson
 <anjo@rev.ng>, "Dr . David Alan Gilbert" <dave@treblig.org>
References: <20260320135039.26546-1-philmd@linaro.org>
 <CAFEAcA-M=jNzRcPbVyb3YBFSzdnd1frwnR+1Rmcxha2niwEyvA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-M=jNzRcPbVyb3YBFSzdnd1frwnR+1Rmcxha2niwEyvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 20/3/26 14:56, Peter Maydell wrote:
> On Fri, 20 Mar 2026 at 13:51, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Currently 'info tlb' dumps the MMU information on stdout.
>> Propagate the @Monitor argument and replace qemu_printf()
>> by monitor_printf() to dump information over the monitor
>> (which is not always stdout).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/xtensa/cpu.h        |  2 +-
>>   target/xtensa/mmu_helper.c | 44 ++++++++++++++++++--------------------
>>   target/xtensa/monitor.c    |  2 +-
>>   3 files changed, 23 insertions(+), 25 deletions(-)


>> -static void dump_tlb(CPUXtensaState *env, bool dtlb)
>> +static void dump_tlb(Monitor *mon, CPUXtensaState *env, bool dtlb)
>>   {
>>       unsigned wi, ei;
>>       const xtensa_tlb *conf =
>> @@ -1091,6 +1091,7 @@ static void dump_tlb(CPUXtensaState *env, bool dtlb)
>>           xtensa_option_enabled(env->config, XTENSA_OPTION_MMU) ?
>>           mmu_attr_to_access : region_attr_to_access;
>>
>> +    monitor_printf(mon, "\n%cTLB:\n", dtlb ? 'D' : 'I');
> 
> Shouldn't the change to this function be purely
>   s/qemu_printf/monitor_printf(mon, / ?

OK, will split as v2 (but still use puts replacement when no formatting)


