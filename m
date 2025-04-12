Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE27C369AE
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 17:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3eaw-0002sh-Jz; Sat, 12 Apr 2025 13:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u3eat-0002sK-RQ
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 13:24:40 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u3eas-00077R-2u
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 13:24:39 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22622ddcc35so40420415ad.2
 for <qemu-devel@nongnu.org>; Sat, 12 Apr 2025 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744478676; x=1745083476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oXubs4yeHo2sCPpxl8mtjQPmIP+cIRXISNZpXqBAsaA=;
 b=oEJq9lrMl0QosA0XVYKO2VaTQpErVxaCv+QLU5dKd36gNVndB+tUgNdVTJLa7LfWbJ
 LmF03rN4Zev9pOzYIJGrBSKmRxV0rL8h/AtMbAPiGP5UJ80bQEz8dUsjF4U86aRpJ9s5
 wSDz6AnA+9y05EhBs7RSewsw9y0DpWU3kt0ifglZUKBmcyhHIbjMTj1Bs8t8k7XVEXna
 PJNG6Aix+jlbp5oUSjViG11hSxwgbw855jZaLinBD53+wXIwjlpvgHi/R5B6EIh/miIs
 QoA8R1EFFEZPff7EE9tfGJUxUTmPU4SGIqv9YIqYd+LQTKRTT5qg6hJvRUg2BL7Vv5TW
 KsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744478676; x=1745083476;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oXubs4yeHo2sCPpxl8mtjQPmIP+cIRXISNZpXqBAsaA=;
 b=prFgGPR7j22M2N5A2dh2KYewmeks9veFLayrF9d6FlEkatI+IuBrr5BrJYQ73VflNx
 lT5xD5iW1V+e/3VO+iT/5NoFoAaBKpuka4Z3Dbp6mxQcGO0Gc2z8c86kQbgzaTWHKJWM
 AnJKWDoDTNRHY357E+PblBLrp/eErDF5PTyKWKVaIPmOLhyR3iS3fN7AsY9Qg2QFOds/
 ubEnWxPzzEb+9fPgvJI8Gp2YLUq/GEz85my+ReGnWJ1T21jQ9jsu4iKL0QKHua5YNiKo
 iZG86TmOp7HhMT8XMq+Aa9OWDF1I9+A2HDCo4wS+rPye11PiaW1TPK95cuXpAFNmjd0j
 1BvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzlQHD4TxKD2sSMxEeFipc6xdFNJ74l8gFYQyIPW423hRRWGLrT31hUoC4z3ZUA90UtsMe4HNLNr1Z@nongnu.org
X-Gm-Message-State: AOJu0Yyc7EPTO4eI+bXODOOtfq106KwmAyhoiaAL/w59I7+x5yR/dE8a
 2/EroCHbTWwP84pJXhgP4S4Jpmw39aZ92BvYBLZxNtt7fyj6NVfBirwxftujPrk=
X-Gm-Gg: ASbGncv8XDoGpHNry5coQRfnrBhRvMbcdu0lyCt8hk3frQw13gVarSqZeuaZuN3+UnL
 mU/UhsKZGswbAvjKU3VVBXJk5MEYEHG26bRYwWxLt1X0p5kYv4ExRIK5IXyVIyTQL/olVpbkNp+
 +d3G2p9Z4My75XZuZeyZ5pj1pBljWp+zTeTbMJ4JephsJ2J1x7h+A8bLQyntrXncQGJ+4YUi8lr
 XceeAUhJp1QiWihKpIjxqrTYJQfV1qzoP8HOmeId4+tEJKyJzKOS2QO760lotapnpL2ksUTMvst
 tsKuvOZ6Xb+nUEFtT8lOZwSs9HNdMP7Su7Qw+oRWpB+Ke0et54JKyA==
X-Google-Smtp-Source: AGHT+IE4arvjXyQPz8aAugIdk9OqKmnpkrubuzzSPF0Bjpr5coy5ce3BzkJr0bxyBrDrj0GGFr4+3w==
X-Received: by 2002:a17:903:2bce:b0:224:a79:5fe9 with SMTP id
 d9443c01a7336-22bea4bd2cbmr95865215ad.30.1744478675937; 
 Sat, 12 Apr 2025 10:24:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f10b3sm3612393b3a.118.2025.04.12.10.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Apr 2025 10:24:35 -0700 (PDT)
Message-ID: <7e760e04-0571-48f3-9aa7-e71c631dcaff@linaro.org>
Date: Sat, 12 Apr 2025 10:24:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/main: transfer replay mutex ownership from
 main thread to main loop thread
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
 <20250410225550.46807-2-pierrick.bouvier@linaro.org>
 <D94EWG4QRMFP.123EPDW889YVC@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <D94EWG4QRMFP.123EPDW889YVC@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 4/11/25 22:30, Nicholas Piggin wrote:
> On Fri Apr 11, 2025 at 8:55 AM AEST, Pierrick Bouvier wrote:
>> On MacOS, UI event loop has to be ran in the main thread of a process.
>> Because of that restriction, on this platform, qemu main event loop is
>> ran on another thread [1].
>>
>> This breaks record/replay feature, which expects thread running qemu_init
>> to initialize hold this lock, breaking associated functional tests on
>> MacOS.
>>
>> Thus, as a generalization, and similar to how BQL is handled, we release
>> it after init, and reacquire the lock before entering main event loop,
>> avoiding a special case if a separate thread is used.
>>
>> Tested on MacOS with:
>> $ meson test -C build --setup thorough --print-errorlogs \
>> func-x86_64-x86_64_replay func-arm-arm_replay func-aarch64-aarch64_replay
>> $ ./build/qemu-system-x86_64 -nographic -icount shift=auto,rr=record,rrfile=replay.log
>> $ ./build/qemu-system-x86_64 -nographic -icount shift=auto,rr=replay,rrfile=replay.log
>>
>> [1] https://gitlab.com/qemu-project/qemu/-/commit/f5ab12caba4f1656479c1feb5248beac1c833243
>>
>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2907
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   system/main.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/system/main.c b/system/main.c
>> index ecb12fd397c..1c022067349 100644
>> --- a/system/main.c
>> +++ b/system/main.c
>> @@ -25,6 +25,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu-main.h"
>>   #include "qemu/main-loop.h"
>> +#include "system/replay.h"
>>   #include "system/system.h"
>>   
>>   #ifdef CONFIG_SDL
>> @@ -44,10 +45,12 @@ static void *qemu_default_main(void *opaque)
>>   {
>>       int status;
>>   
>> +    replay_mutex_lock();
>>       bql_lock();
>>       status = qemu_main_loop();
>>       qemu_cleanup(status);
>>       bql_unlock();
>> +    replay_mutex_unlock();
>>   
>>       exit(status);
>>   }
>> @@ -67,6 +70,7 @@ int main(int argc, char **argv)
>>   {
>>       qemu_init(argc, argv);
>>       bql_unlock();
>> +    replay_mutex_unlock();
>>       if (qemu_main) {
>>           QemuThread main_loop_thread;
>>           qemu_thread_create(&main_loop_thread, "qemu_main",
> 
> Do we actually need to hold replay mutex (or even bql) over qemu_init()?
> Both should get dropped before we return here. But as a simple fix, I
> guess this is okay.
> 

For the bql, I don't know the exact reason.
For replay lock, we need to hold it as clock gets saved as soon as the 
devices are initialized, which happens before end of qemu_init.

> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


