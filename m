Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034D2D0BB56
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4MN9-000184-2t; Fri, 25 Oct 2024 11:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t4MN7-00017f-Ru
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:37:05 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t4MN5-0001un-VM
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:37:05 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539983beb19so2801277e87.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729870621; x=1730475421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xdTpAh/H4IE8xw4sTZvG5a2N+FOfeO8fbZ3W37DlIhI=;
 b=hzPV8mH+PF+B9/52S/LsNQ0lfMppyUQaboTz0fUPOyMJYNrn81PcGbBjpFJ0AvtvIA
 0/z8jMSvC32VPbKSrrxuQaEXH16Hw9ZKFWabaxQIfkI05omvUX5bGIV/v4GOKJjxL2ey
 FIxukaoZatPuihX1aRbHlAYUc21IarhOwWfUT9bm1BFFj4WSvJQL2slA6KuDXqSSH2+G
 a14mHQqVllDUjO+8jEtdrvMg7xJPKNoxgo51Q7KPpVApofAOzpb5W3Hh3QpkfZc9mKtN
 mFvi8xpADtPg2d9iF2ns6O7EVX79e47YObC9hzYBob3wQbvZZuNVY281PRIfSAMspqjZ
 30Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729870621; x=1730475421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xdTpAh/H4IE8xw4sTZvG5a2N+FOfeO8fbZ3W37DlIhI=;
 b=t5eLZBdBs9fcH33JqxGqb1u5Dlf7MkKtGibHDq85LYEZnK1qJnX8uUt/GD4JLaZm1i
 DnX0T/jVNufMR6qpHqMVrdoL0PxQWU/WV2Zxk3eLD4iVIfavE44cHo1zY7nWX9L6eckV
 EPRZpD1WAmYZBr+zBmIFMHrlCSa5Vlzs9eirpSg3W6bwq5KOHEk3mZ56PzHBpDh3yWdH
 d8PFeG//4gXowJKBiBQh8ZAdpCdy2qEYzGgZlwH3ySNy2Jn6NYxcG5XOR3yo3/WqM0Bt
 GDLrjf3q83bT1saf/mHuwWW7mVgqT/Vx8pCiCFjuUGgb/J0ONzrQoK8gAPom6RWJHNFS
 XnBg==
X-Gm-Message-State: AOJu0YzKXTTB4d2Qtyit2sPfdJPT1BM93S3ZscyFUAT0EsVHfEY9upx7
 RfOcWqqh7q/BEAUqwvSAYpPW4A9JWZ4DVudM2i9prxkqzG3Ouxxnfx+CQtO2sTg=
X-Google-Smtp-Source: AGHT+IE9VotOM9qqqlLKtbos0qW5oITXh6gBZN0gP5FETpItu8bPHdYkVWa7zVxW+oKPp2NSbp9QwA==
X-Received: by 2002:a05:6512:b1e:b0:536:54e9:3a63 with SMTP id
 2adb3069b0e04-53b1a375b25mr5997559e87.49.1729870621429; 
 Fri, 25 Oct 2024 08:37:01 -0700 (PDT)
Received: from [192.168.5.26] ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193594fe7sm20901655e9.14.2024.10.25.08.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 08:37:01 -0700 (PDT)
Message-ID: <b45d04e1-b6f5-4b70-a59d-3df4320b8b07@linaro.org>
Date: Fri, 25 Oct 2024 16:36:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ping: [PATCH v2 1/2] linux-user: Map low priority rt signals
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Brian Cain <bcain@quicinc.com>,
 "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>
References: <20240212205022.242968-1-iii@linux.ibm.com>
 <20240212205022.242968-2-iii@linux.ibm.com>
 <2afc8b53-5a35-482c-aa89-c61a882cedf0@linaro.org>
 <6d3832490ebc7abc62652c9be1d27a70c5d7551c.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6d3832490ebc7abc62652c9be1d27a70c5d7551c.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
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

On 10/25/24 10:32, Ilya Leoshkevich wrote:
> On Tue, 2024-02-13 at 07:51 +0100, Philippe Mathieu-Daudé wrote:
>> Cc'ing Brian & Taylor
>>
>> On 12/2/24 21:45, Ilya Leoshkevich wrote:
>>> Some applications want to use low priority realtime signals (e.g.,
>>> SIGRTMAX). Currently QEMU cannot map all target realtime signals to
>>> host signals, and chooses to sacrifice the end of the target
>>> realtime
>>> signal range.
>>>
>>> Change this to the middle of that range, hoping that fewer
>>> applications
>>> will need it.
>>>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>    linux-user/signal.c | 18 +++++++++++++-----
>>>    1 file changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/linux-user/signal.c b/linux-user/signal.c
>>> index d3e62ab030f..a81533b563a 100644
>>> --- a/linux-user/signal.c
>>> +++ b/linux-user/signal.c
>>> @@ -511,13 +511,14 @@ static int core_dump_signal(int sig)
>>>    
>>>    static void signal_table_init(void)
>>>    {
>>> -    int hsig, tsig, count;
>>> +    int hsig, hsig_count, tsig, tsig_count, tsig_hole,
>>> tsig_hole_size, count;
>>>    
>>>        /*
>>> -     * Signals are supported starting from TARGET_SIGRTMIN and
>>> going up
>>> -     * until we run out of host realtime signals.  Glibc uses the
>>> lower 2
>>> -     * RT signals and (hopefully) nobody uses the upper ones.
>>> -     * This is why SIGRTMIN (34) is generally greater than
>>> __SIGRTMIN (32).
>>> +     * Signals are supported starting from TARGET_SIGRTMIN and up
>>> to
>>> +     * TARGET_SIGRTMAX, potentially with a hole in the middle of
>>> this
>>> +     * range, which, hopefully, nobody uses. Glibc uses the lower
>>> 2 RT
>>> +     * signals; this is why SIGRTMIN (34) is generally greater
>>> than
>>> +     * __SIGRTMIN (32).
>>>         * To fix this properly we would need to do manual signal
>>> delivery
>>>         * multiplexed over a single host signal.
>>>         * Attempts for configure "missing" signals via sigaction
>>> will be
>>> @@ -536,9 +537,16 @@ static void signal_table_init(void)
>>>        host_to_target_signal_table[SIGABRT] = 0;
>>>        host_to_target_signal_table[hsig++] = TARGET_SIGABRT;
>>>    
>>> +    hsig_count = SIGRTMAX - hsig + 1;
>>> +    tsig_count = TARGET_NSIG - TARGET_SIGRTMIN + 1;
>>> +    tsig_hole_size = tsig_count - MIN(hsig_count, tsig_count);
>>> +    tsig_hole = TARGET_SIGRTMIN + (tsig_count - tsig_hole_size) /
>>> 2;
>>>        for (tsig = TARGET_SIGRTMIN;
>>>             hsig <= SIGRTMAX && tsig <= TARGET_NSIG;
>>>             hsig++, tsig++) {
>>> +        if (tsig == tsig_hole) {
>>> +            tsig += tsig_hole_size;
>>> +        }
>>>            host_to_target_signal_table[hsig] = tsig;
>>>        }
>>>    
> 
> Ping.
> 
> I wonder if it would make sense to make this configurable?

There are plenty of IPC use-cases for which we need a consistent mapping of guest signals. 
  Because we must steal some for emulation, we cannot give the guest the full set.  But 
you're right that different applications allocate the rt signals differently, and 
arbitrarily nixing the highest signal numbers may be problematic.

Nixing the middle rt signals seems equally problematic, so some sort of configuration 
seems the only solution.  Perhaps we could come up with some generalized mapping?


r~


  perhaps a generalized mapping



