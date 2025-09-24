Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08FDCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 03:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1G2E-0000b2-Hc; Tue, 23 Sep 2025 23:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1G2A-0000aG-EX
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 23:19:10 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1G24-0008Ru-IW
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 23:19:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso5598179f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 20:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758683935; x=1759288735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HG3oKhecWK/sHNXz8PfBRqmBt3VIBGWx/iJwdhEkkBM=;
 b=N6QiCUeNzXibGNrkANWjFDhr4S8frfrwR7zJJ6HjXziP5BOrqvqlzeTe1AkBX8fZxf
 avQS5JeCZw+SqY5SwfJmseuGkQ0Eo43VS52R56yO1EU6TxZm8Az83BcC2xnfcZmg1eZ7
 78DxDLy3t347FfPrh8VG6Xvv6SrkLW5yQDqcsSCr+wgzgPuPZ087MX98lYR4tQHtPJpi
 /fiYJeoC2rHGGa7VQq2F6DhOH5+IwrMeoYzgqCniSA8rtmX4VYtg4k72L9sllZuudDJQ
 iYo3ai+TUyq6C2K1xO0wD59folY0+IQu2wLr6nnTGJ5oTBfhMDvGarmF592UPQ/e1Ybg
 ny9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758683935; x=1759288735;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HG3oKhecWK/sHNXz8PfBRqmBt3VIBGWx/iJwdhEkkBM=;
 b=RHydZI/Kup+r73VMFU+4Y94KGOt6VWLneLP1bwQgeO0Pn2S98kaB2+WtXZaAPimPbv
 qDttOa1vbW00vx6nw+9HeAFT0q1EE2/dngC8SPGQiCyFD+WhVvSXvxDq6VnjerKxC6YY
 gGonZ1o/uxhYe+byFJchO8CAn58oM/YoAr0OvtPT5EI+6mdJqzTX2B6sPtS8LoTchWIM
 sb6VbwIvwzxA0VsxEvzDl1hmbKOjFBvlJ0kGyIHXbVlvetyaSWMyI/ozv9m0Ij37d3C2
 WG5KcJ0j1Z/N/Tlhoguz4IIxN3IH7YSKvEZhG94s/t5YLvWGDBUeqLDEF+oF0WYcC7Du
 Lw3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw+LxJlunbQMQwg5Dm6rsW3FBc7cqGLh1ada6qRrjtW+kxoomUQKy6ohQkswHSsL3zJ91THkmtftdL@nongnu.org
X-Gm-Message-State: AOJu0YwE2aJGGrNURg1xfwAf1TGKzkKjCwzfUH0uMa3GcIj+w6P4Z0OI
 +08iKrsPHP0bzmlGqP8/3L0Gaw4oQmd0jaS20M61SjACZb9/obWO6VzaDHm7G5OJdj8=
X-Gm-Gg: ASbGnct7RTaNp0NywdODkL8R2ZwKFeZ8q1G0lBqvC6pGYy7+IdIpo13Z1FIqcIcVnFO
 bOUUqtxcryoMGKSyBYgS9lJMIyA1Yqyt3BpPnFzUx9oaHLY3DqhDp55Da4n2fVRg+Q/LUiLV7e0
 W4q0kayoV/iZKk/eoP+YbWY7HFaGVgwxLsh+jZT8mOQmc1LoNmByWVKlTw/r2z6NodtGaI6SPeu
 Nxad7UozwdDhNUxf+Jhdd5ORD6OroAfaMGAoTiFBUXxXLDcXmOZEW5QvWY5NsyvlxZwGIJ+gFEf
 XmgTW8vhI1BVK2rBBE0U8H0VS0dWWYOhbqQjkS18KwBVCIgqz4lOnIDe4QsVrzCODnQ5/uLKzw2
 Kdkv7OtZWeg+tfV29d+0njPW2YdGk/2hG+7hfO8N9aMatvh/Rnl4dYnvNpBaDYbizqQ==
X-Google-Smtp-Source: AGHT+IHPas1+V0sFC+PF4RB6QRZ/fsJzlgJH0hchrRA88WSdLNpRJR8DxqBLNTP/VAKflzIQpEugwA==
X-Received: by 2002:a5d:5f92:0:b0:3f9:6657:d05 with SMTP id
 ffacd0b85a97d-405c551a369mr3692864f8f.12.1758683935025; 
 Tue, 23 Sep 2025 20:18:55 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407aebsm27199598f8f.14.2025.09.23.20.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 20:18:53 -0700 (PDT)
Message-ID: <d40596b3-3790-4d4a-ab2a-0ddd2e92bae8@linaro.org>
Date: Wed, 24 Sep 2025 05:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] plugins: Use tb_flush__exclusive
To: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>, qemu-devel@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-9-richard.henderson@linaro.org>
 <d9624d53-9562-4ac8-94c5-bdc5fefddb3f@linaro.org>
 <d8f4298e-f89c-4a39-8eee-12e5c8504f51@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d8f4298e-f89c-4a39-8eee-12e5c8504f51@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

On 23/9/25 22:28, Richard Henderson wrote:
> On 9/23/25 06:35, Philippe Mathieu-Daudé wrote:
>> On 23/9/25 04:39, Richard Henderson wrote:
>>> In all cases, we are already within start_exclusive.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>> Cc: Alex Bennée" <alex.bennee@linaro.org>
>>> Cc: Alexandre Iooss <erdnaxe@crans.org>
>>> Cc: Mahmoud Mandour <ma.mandourr@gmail.com>
>>> Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   plugins/core.c   | 6 ++----
>>>   plugins/loader.c | 2 +-
>>>   2 files changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/plugins/core.c b/plugins/core.c
>>> index c6e9ef1478..4ae1a6ae17 100644
>>> --- a/plugins/core.c
>>> +++ b/plugins/core.c
>>> @@ -248,7 +248,7 @@ static void 
>>> plugin_grow_scoreboards__locked(CPUState *cpu)
>>>           }
>>>           plugin.scoreboard_alloc_size = scoreboard_size;
>>>           /* force all tb to be flushed, as scoreboard pointers were 
>>> changed. */
>>> -        tb_flush(cpu);
>>> +        tb_flush__exclusive();
>>>       }
>>>       end_exclusive();
>>>   }
>>> @@ -684,8 +684,6 @@ void qemu_plugin_user_exit(void)
>>>        * with the one in fork_start(). That is:
>>>        * - start_exclusive(), which acquires qemu_cpu_list_lock,
>>>        *   must be called before acquiring plugin.lock.
>>> -     * - tb_flush(), which acquires mmap_lock(), must be called
>>> -     *   while plugin.lock is not held.
>>>        */
>>>       start_exclusive();
>>> @@ -705,7 +703,7 @@ void qemu_plugin_user_exit(void)
>>>       }
>>>       qemu_rec_mutex_unlock(&plugin.lock);
>>> -    tb_flush(current_cpu);
>>> +    tb_flush__exclusive();
>>>       end_exclusive();
>>>       /* now it's safe to handle the exit case */
>>
>> Hmm it seems we are triggering again the issue reported about
>> TARGET_NR_exit_group in https://linaro.atlassian.net/browse/QEMU-706:
>>
>>    "Under user emulation, threads can exit via pthread_join or at
>>     the end of the process via exit_group syscall.
>>
>>    The current plugin exit hook affects all vcpus (see
>>    qemu_plugin_disable_mem_helpers call in qemu_plugin_user_exit)."
>>
>> Crash log:
>>
>> qemu-loongarch64: ../../accel/tcg/tb-maint.c:94: tb_remove_all: 
>> Assertion `have_mmap_lock()' failed.
>>
>> Thread 1 "qemu-loongarch6" received signal SIGABRT, Aborted.
>> __pthread_kill_implementation (no_tid=0, signo=6, 
>> threadid=140737340860416) at ./nptl/ pthread_kill.c:44
>> 44    ./nptl/pthread_kill.c: No such file or directory.
>> (gdb) bt
>> #0  __pthread_kill_implementation (no_tid=0, signo=6, 
>> threadid=140737340860416) at ./nptl/ pthread_kill.c:44
>> #1  __pthread_kill_internal (signo=6, threadid=140737340860416) at ./ 
>> nptl/pthread_kill.c:78
>> #2  __GI___pthread_kill (threadid=140737340860416, 
>> signo=signo@entry=6) at ./nptl/ pthread_kill.c:89
>> #3  0x00007ffff746f476 in __GI_raise (sig=sig@entry=6) at ../sysdeps/ 
>> posix/raise.c:26
>> #4  0x00007ffff74557f3 in __GI_abort () at ./stdlib/abort.c:79
>> #5  0x00007ffff745571b in __assert_fail_base (fmt=0x7ffff760a130 
>> "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=0x555555733f0c 
>> "have_mmap_lock()",
>>      file=0x555555733ef1 "../../accel/tcg/tb-maint.c", line=94, 
>> function=<optimized out>) at ./assert/assert.c:94
>> #6  0x00007ffff7466e96 in __GI___assert_fail 
>> (assertion=assertion@entry=0x555555733f0c "have_mmap_lock()",
>>      file=file@entry=0x555555733ef1 "../../accel/tcg/tb-maint.c", 
>> line=line@entry=94, function=function@entry=0x555555734038 
>> <__PRETTY_FUNCTION__.8> "tb_remove_all")
>>      at ./assert/assert.c:103
>> #7  0x0000555555612e41 in tb_remove_all () at ../../accel/tcg/tb- 
>> maint.c:94
>> #8  tb_flush__exclusive () at ../../accel/tcg/tb-maint.c:781
>> #9  0x0000555555623a0c in qemu_plugin_user_exit () at ../../plugins/ 
>> core.c:706
>> #10 0x0000555555696e54 in preexit_cleanup (env=<optimized out>, 
>> code=code@entry=0) at ../../linux-user/exit.c:36
> 
> I fixed this by replacing the assert in the user-only version of 
> tb_remove_all.

Clever shortcut :)


