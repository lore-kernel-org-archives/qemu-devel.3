Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03ABCAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 20:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v19dR-0002bL-90; Tue, 23 Sep 2025 16:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v19dK-0002aQ-JM
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 16:29:08 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v19dH-0008CG-EB
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 16:29:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-25669596955so54043205ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758659341; x=1759264141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TueKAXxicr8LpxwRHWuGX9s+twLAY3aqBgl/b3SMYsI=;
 b=j33bFtR44OagBmMKlHK300Om1NEfLdPw1qS/0Ln5ABkHMxFm82vVy2X3T+v1y4YsP8
 7JB72Aex8gSrACbfUUnaXq7ZJQBP3/d0jB1GC6MJmnp+5+NOpmcVOK7ssmIYUyAHx9lF
 3pecHZLWIhFL30wbY2xj+HzaMZGvuWMjnOQ78rEkv0nxQo3OviO6LOGAQcsVc11DykY1
 80Q0YNeA//Pzueg/ivwfgJ0EvAiabsU4KHLwdvPdivRAyyDavPDnBzFgxhFgDgQZVawJ
 Dg8c50uN7ph1ph+bxDib9txHvwaG7QiETIZpdEblImu+qJFt4MUojwJFaMt9VAAH9FER
 qw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758659341; x=1759264141;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TueKAXxicr8LpxwRHWuGX9s+twLAY3aqBgl/b3SMYsI=;
 b=Lwn8xMMeyHuyHjCre4sOcufsS8gxfVc1FZMezaT3gZEulURWokloOVes9fQ5iQDQOu
 FgL2pLFW7QhC2ZV2PxYksBwu7ccruJZV5YJ7jjNE1S3SfTlwAA324yuRxI68/shA2AeY
 gMz7GPXEJ4lzImfGkxr49OVsqvjDxevTKlZ01rixIerGALOm1qwXiZxiWR2TbYdjTknh
 XWbr886jkb9IBYYOBNMfLAbIAoOS10tCplPlBnNWwjBNDp4oCRfdB8lrUt/PpBnR6jx0
 JLCS2jR3VE+C8FxxsWbVPtHaX9GBUIQ5hgPgQvN8PXySCaJGqshPFau3CCTH9YMMLnkr
 QzfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3M2Oytd1SljYPp+y5IjQEaAwCST3obYY0hulWdRVP7zeFE0Wz4YIp8flXemakZU1gUksrKVbchq0B@nongnu.org
X-Gm-Message-State: AOJu0Yz2E8fZ/UtZgCm1GJYcadw4jTI78+LQ3uLcpV4HUy7LklCBBhzl
 RPFrcONgEOqQEMBNWnvszNyveIrKbCy4Dyf/H/9EajRuTz2JMhoOKea1DF+knUwOixc=
X-Gm-Gg: ASbGncvEP4rjQ4a5Ubv5YiT9ZV31ndlhku4ieY3e9Y7h5eCUGPzjcZlMl9eZciaka4U
 XO3SO3rROTsDpNbuedPniESDSRL3rm3HxIB1zxn8clqTdsTPTh9xAq4XDG0Zcmm2QFgFbIBPRRK
 zcPgntqdfxNiVnRomZPxRTYUB7ibaNaw4BQRmiPPFn/rnPZhVC8AQwJm/l2Gkkb/NrqnZoekfO0
 15yaSw+zW6tuNXXOOtjuVRHKQSm3JHRp0Ynz+Ts2uGkSNY1aWPP6awLiRHXuQDXT9dJ+/YfrCif
 EvNB04wmXhusYZBv8vUK6+mrapjbZpSo95Pg6jk1tHQG2G0138wy2KXXXU07zhNZUYFZszkrfCb
 ikz7cd5ebNKkTzK118aC/G0ZhbJOGd1tea2cx
X-Google-Smtp-Source: AGHT+IH9kRM3DFG0P/yMpCIAYlP+tuuwjWhJEnD/6V7vkWEsx7WxqhZRSq3rBZNRpexWREVjcWtOrA==
X-Received: by 2002:a17:902:e946:b0:25c:d4b6:f117 with SMTP id
 d9443c01a7336-27cc580e150mr44975975ad.35.1758659341268; 
 Tue, 23 Sep 2025 13:29:01 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698035d6f4sm170181315ad.140.2025.09.23.13.29.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 13:29:00 -0700 (PDT)
Message-ID: <d8f4298e-f89c-4a39-8eee-12e5c8504f51@linaro.org>
Date: Tue, 23 Sep 2025 13:28:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] plugins: Use tb_flush__exclusive
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>, qemu-devel@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-9-richard.henderson@linaro.org>
 <d9624d53-9562-4ac8-94c5-bdc5fefddb3f@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <d9624d53-9562-4ac8-94c5-bdc5fefddb3f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 9/23/25 06:35, Philippe Mathieu-Daudé wrote:
> On 23/9/25 04:39, Richard Henderson wrote:
>> In all cases, we are already within start_exclusive.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> Cc: Alex Bennée" <alex.bennee@linaro.org>
>> Cc: Alexandre Iooss <erdnaxe@crans.org>
>> Cc: Mahmoud Mandour <ma.mandourr@gmail.com>
>> Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   plugins/core.c   | 6 ++----
>>   plugins/loader.c | 2 +-
>>   2 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/plugins/core.c b/plugins/core.c
>> index c6e9ef1478..4ae1a6ae17 100644
>> --- a/plugins/core.c
>> +++ b/plugins/core.c
>> @@ -248,7 +248,7 @@ static void plugin_grow_scoreboards__locked(CPUState *cpu)
>>           }
>>           plugin.scoreboard_alloc_size = scoreboard_size;
>>           /* force all tb to be flushed, as scoreboard pointers were changed. */
>> -        tb_flush(cpu);
>> +        tb_flush__exclusive();
>>       }
>>       end_exclusive();
>>   }
>> @@ -684,8 +684,6 @@ void qemu_plugin_user_exit(void)
>>        * with the one in fork_start(). That is:
>>        * - start_exclusive(), which acquires qemu_cpu_list_lock,
>>        *   must be called before acquiring plugin.lock.
>> -     * - tb_flush(), which acquires mmap_lock(), must be called
>> -     *   while plugin.lock is not held.
>>        */
>>       start_exclusive();
>> @@ -705,7 +703,7 @@ void qemu_plugin_user_exit(void)
>>       }
>>       qemu_rec_mutex_unlock(&plugin.lock);
>> -    tb_flush(current_cpu);
>> +    tb_flush__exclusive();
>>       end_exclusive();
>>       /* now it's safe to handle the exit case */
> 
> Hmm it seems we are triggering again the issue reported about
> TARGET_NR_exit_group in https://linaro.atlassian.net/browse/QEMU-706:
> 
>    "Under user emulation, threads can exit via pthread_join or at
>     the end of the process via exit_group syscall.
> 
>    The current plugin exit hook affects all vcpus (see
>    qemu_plugin_disable_mem_helpers call in qemu_plugin_user_exit)."
> 
> Crash log:
> 
> qemu-loongarch64: ../../accel/tcg/tb-maint.c:94: tb_remove_all: Assertion 
> `have_mmap_lock()' failed.
> 
> Thread 1 "qemu-loongarch6" received signal SIGABRT, Aborted.
> __pthread_kill_implementation (no_tid=0, signo=6, threadid=140737340860416) at ./nptl/ 
> pthread_kill.c:44
> 44    ./nptl/pthread_kill.c: No such file or directory.
> (gdb) bt
> #0  __pthread_kill_implementation (no_tid=0, signo=6, threadid=140737340860416) at ./nptl/ 
> pthread_kill.c:44
> #1  __pthread_kill_internal (signo=6, threadid=140737340860416) at ./nptl/pthread_kill.c:78
> #2  __GI___pthread_kill (threadid=140737340860416, signo=signo@entry=6) at ./nptl/ 
> pthread_kill.c:89
> #3  0x00007ffff746f476 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> #4  0x00007ffff74557f3 in __GI_abort () at ./stdlib/abort.c:79
> #5  0x00007ffff745571b in __assert_fail_base (fmt=0x7ffff760a130 "%s%s%s:%u: %s%sAssertion 
> `%s' failed.\n%n", assertion=0x555555733f0c "have_mmap_lock()",
>      file=0x555555733ef1 "../../accel/tcg/tb-maint.c", line=94, function=<optimized out>) 
> at ./assert/assert.c:94
> #6  0x00007ffff7466e96 in __GI___assert_fail (assertion=assertion@entry=0x555555733f0c 
> "have_mmap_lock()",
>      file=file@entry=0x555555733ef1 "../../accel/tcg/tb-maint.c", line=line@entry=94, 
> function=function@entry=0x555555734038 <__PRETTY_FUNCTION__.8> "tb_remove_all")
>      at ./assert/assert.c:103
> #7  0x0000555555612e41 in tb_remove_all () at ../../accel/tcg/tb-maint.c:94
> #8  tb_flush__exclusive () at ../../accel/tcg/tb-maint.c:781
> #9  0x0000555555623a0c in qemu_plugin_user_exit () at ../../plugins/core.c:706
> #10 0x0000555555696e54 in preexit_cleanup (env=<optimized out>, code=code@entry=0) 
> at ../../linux-user/exit.c:36

I fixed this by replacing the assert in the user-only version of tb_remove_all.


r~

