Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD8FC369B5
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 10:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4H08-0001kC-SV; Mon, 14 Apr 2025 06:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4H03-0001ik-R6
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:25:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4H01-0003ur-8z
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:25:11 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so25839255e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 03:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744626307; x=1745231107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TwwdN8px0JpjPC5tPHPQgVn/g5LVyOTcYATOAQJf1zY=;
 b=c4XFydlnnbAHoHw2NrD5rV5iVA1c024b0nI/ecSLvJs/x28IX9YtOrhYOJoAQ9IerV
 6Sqr4NWB2ZP4Xl5QiAdKOhovxQPW9DDuVt6gf+rtYYX9Q4mQaVw6sT5Q2HKsxH/grw13
 efUt3Aq8EiXExUAWsxkQsKdnv2UtSnlu31HCbcjamtHtPtNllCb4eDmQo6zVdW0YMeS9
 QHLzlh37yrTjCg9Nexhd1aKO2rHhB4t9xSKzmqlhSFrPYqQ+O+wI2e2hih5ITO3mAkFY
 lZN+puX7vCmF19KEG5oSiKr91JYhP9Fu++dh9grFOtYRhMrJcYVEVR2KB2pKhB5XH2jb
 UoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744626307; x=1745231107;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TwwdN8px0JpjPC5tPHPQgVn/g5LVyOTcYATOAQJf1zY=;
 b=T+EmJAPLplWXqeKtzQgSqyrTGo6s9YWGX1/0QBmdP42QXOgGjPVpPPQ8AH/k4D8VAP
 e2Qt/LgWHuy5ANz7bBuAOZeWKDsCtkIk6WS9qV54OUjOnvNT45QkSBgYew4fR3dK1m1H
 ws8PaXeTX6S4ajxcR3HjjFFZ1NnB/BNWyu2+P6H1tjTQGOUVtrD+1QzN3KqIlXWQfoTN
 h5I78PL1FP1i9L//EP7MA+VEeG0wmBa9HrpmFrQPMq7QBYTSfZxyBp8pvG0IGU1X+w3U
 xCG+6vBbHAnZrZE32IYLHfmwrDumIYSMEjAGe+B2er0SvNYuF2RviDK5Aj8DB9Kufcb7
 UPIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUaaNBVkZfeVvGsAmgetkOO0sIVn9cMzt2i2CYsZJx+iXL4ZcCc3SqhuguQTQm4pzd9JWS0XWoFMEM@nongnu.org
X-Gm-Message-State: AOJu0YxjMTqGomnmregfkYZzIvt2Pq1UfIFSonTg3qsCvaMvuh5f/3RY
 B5o+aNMrAIUIRJN7lsVboUrZcqg76P7MnrfmZlN+IrxvSSKjfcStUGD8APeKx98=
X-Gm-Gg: ASbGncvNg7r9xTAAGykoN5msv1/IuCXNJB6FRKIDyFdWWmX4vJMhb63rXLnzWytNqCE
 7Tm8zp1CH8seVZBon26vUVlwr2QHXfbu/Xv0nCgIJp0cz6Gx2AOLB9xWZ6V0aUhdDreo2DiP9o6
 n3V7zCSp+xiH6xQ7PcmZycIONxQgV/4CrfsiIA1lqbeiyZdm8LpHpA8jOUa8/dKkLs2R8AISsiI
 RPasuKOCtbg89HXqRbQWPt1ZJArFNebItRdWThUOoM3LVKph46w6zn6tiRqbT5U8/BGyRgpXLFM
 YRpj+bU6Vwwqka+yewbn1qClbXGfOUnwlthCwH9vWNIEGE9eMZTas47BKrnFAAi1ksZOXfr9m8L
 I4M4P9+S9
X-Google-Smtp-Source: AGHT+IEelvbq8s68X88qqywUdmXOuyu1SR6FlOdIGOjIEX1vvhB+fl6IHj/bO/FT/YquqpSsdWEmuQ==
X-Received: by 2002:a05:600c:1e1c:b0:43d:1bf6:15e1 with SMTP id
 5b1f17b1804b1-43f39622728mr97859205e9.1.1744626307165; 
 Mon, 14 Apr 2025 03:25:07 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae963c15sm10820453f8f.13.2025.04.14.03.25.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 03:25:06 -0700 (PDT)
Message-ID: <dee088aa-436f-48dc-8a28-f675de42767b@linaro.org>
Date: Mon, 14 Apr 2025 12:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/main: transfer replay mutex ownership from
 main thread to main loop thread
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
 <20250410225550.46807-2-pierrick.bouvier@linaro.org>
 <D94EWG4QRMFP.123EPDW889YVC@gmail.com>
 <7e760e04-0571-48f3-9aa7-e71c631dcaff@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7e760e04-0571-48f3-9aa7-e71c631dcaff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 12/4/25 19:24, Pierrick Bouvier wrote:
> On 4/11/25 22:30, Nicholas Piggin wrote:
>> On Fri Apr 11, 2025 at 8:55 AM AEST, Pierrick Bouvier wrote:
>>> On MacOS, UI event loop has to be ran in the main thread of a process.
>>> Because of that restriction, on this platform, qemu main event loop is
>>> ran on another thread [1].
>>>
>>> This breaks record/replay feature, which expects thread running 
>>> qemu_init
>>> to initialize hold this lock, breaking associated functional tests on
>>> MacOS.
>>>
>>> Thus, as a generalization, and similar to how BQL is handled, we release
>>> it after init, and reacquire the lock before entering main event loop,
>>> avoiding a special case if a separate thread is used.
>>>
>>> Tested on MacOS with:
>>> $ meson test -C build --setup thorough --print-errorlogs \
>>> func-x86_64-x86_64_replay func-arm-arm_replay func-aarch64- 
>>> aarch64_replay
>>> $ ./build/qemu-system-x86_64 -nographic -icount 
>>> shift=auto,rr=record,rrfile=replay.log
>>> $ ./build/qemu-system-x86_64 -nographic -icount 
>>> shift=auto,rr=replay,rrfile=replay.log
>>>
>>> [1] https://gitlab.com/qemu-project/qemu/-/commit/ 
>>> f5ab12caba4f1656479c1feb5248beac1c833243
>>>
>>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2907
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   system/main.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/system/main.c b/system/main.c
>>> index ecb12fd397c..1c022067349 100644
>>> --- a/system/main.c
>>> +++ b/system/main.c
>>> @@ -25,6 +25,7 @@
>>>   #include "qemu/osdep.h"
>>>   #include "qemu-main.h"
>>>   #include "qemu/main-loop.h"
>>> +#include "system/replay.h"
>>>   #include "system/system.h"
>>>   #ifdef CONFIG_SDL
>>> @@ -44,10 +45,12 @@ static void *qemu_default_main(void *opaque)
>>>   {
>>>       int status;
>>> +    replay_mutex_lock();
>>>       bql_lock();
>>>       status = qemu_main_loop();
>>>       qemu_cleanup(status);
>>>       bql_unlock();
>>> +    replay_mutex_unlock();
>>>       exit(status);
>>>   }
>>> @@ -67,6 +70,7 @@ int main(int argc, char **argv)
>>>   {
>>>       qemu_init(argc, argv);
>>>       bql_unlock();
>>> +    replay_mutex_unlock();
>>>       if (qemu_main) {
>>>           QemuThread main_loop_thread;
>>>           qemu_thread_create(&main_loop_thread, "qemu_main",
>>
>> Do we actually need to hold replay mutex (or even bql) over qemu_init()?
>> Both should get dropped before we return here. But as a simple fix, I
>> guess this is okay.
>>
> 
> For the bql, I don't know the exact reason.
> For replay lock, we need to hold it as clock gets saved as soon as the 
> devices are initialized, which happens before end of qemu_init.

Could be worth adding a comment with that information.

> 
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 


