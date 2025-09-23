Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF6BCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13Aw-0007jb-Sh; Tue, 23 Sep 2025 09:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v13Av-0007jM-F6
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 09:35:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v13Al-0000cN-AG
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 09:35:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3f42b54d1b9so2647119f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758634503; x=1759239303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eodG4YR1JgOg8AZig+FSUlxob+fpQZD/gP9Y2m4O/T4=;
 b=Xto/aY5uBiLuZqfL+mtyZHJEPuYuaLOg3FrligPWv5Fhf8ZtNnmYK0x3s09TzhH+G5
 Rs/tRoMwJ9tZo2e7B+C604CBsUywtGODxjC+SvnwejVI4WxNRUaq7CDEfj0J8ZW77q4h
 fGJ2jx5vzCWLbaev80YgZ/HV154+yVN1uSc4n7RASphtR5+bt2uy6u7ybV7rNe5QPMdg
 2GUk5iLlup76cSG3Zx37CYarJMlIV7zMo7ADABR9Pxr9tNtRTeM5FoRz+T5kukmD06Yu
 D/WgPdjwrp/1gsNirf+2M71GH7K60NtTgCn2YwcgHpKQJUcOn+6UHx1fRuOy01Poz7kB
 UVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758634503; x=1759239303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eodG4YR1JgOg8AZig+FSUlxob+fpQZD/gP9Y2m4O/T4=;
 b=vfcMM7BRgSKutP6ue/uGfBNMZnVloETwanemkEK1CCex2DhPaCut+8FINAD26ye+rV
 faF7up4TpNBVk6HUyV7Q3JU9zDqBZu+La/ph+G0FtFtnDbZ939BBkdvO26NiDn02xgx+
 1b9dsbTtXFyJQjPjW26uWiJtDux19nD1jpvJZn2bIlm8cSkRp2GvjDfRpP64cMaCiPPT
 ouUFT0Gdd/EOL4G89Lm1s9iiip4CTZ7qCGK2c1dztbQJw6n/tvj5nR8iJ4koiP9qQh4Y
 vyTjukiNGaFJhiCk2NQlSwhCh1HXm76T+YYDdAVcHchP/yduY3LAp7m4TjOmSY/nQrf2
 lrPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa0ADo+kpJwIKOddE7jzryuhiQmaO9h5kfDYjfNwnGBTQi06McZwI5kFjTFd0AfRsfEmzTp+2vuTj1@nongnu.org
X-Gm-Message-State: AOJu0YzSaV16mMc+tYKn8gYw4fYrtnfRfaXwTysgZjAQptthgjflohtz
 n4tH+uK2F5Rcw+DvNz6MVoGZuUDmX+TBBACeHDCyzpuse+gSvSHNZDSYKyeJzZzA83I=
X-Gm-Gg: ASbGncvTbJQ5dUuL90VQvjuyKm+JffgjEY6cb28RoIKabwukniCdhVCOOc8D+D+sssd
 eGiIcY5CIK7zuoVdTXITNvDEd+QD07f2Ilo6X61Sqo2Rrjz0cVlh1Ri1yxFjQ22DWQoXzlPh/H+
 XlwpLaBeXhgEJrRKQ9PF/QfCIqgCeCwlZzRd0L8Y6/6te5n3vjldaUWv9SZRYo208GsVL9J7JGt
 tnN+J/8Oy8rQ+7FVYtCrsihQ9866e4m3q0mckRnBh3Pt/VyLRXl9R20QM18H+zx8K+qPY2cNs1y
 +XzeNWUBshjlQxsEZJEoYQ0JrNT+34WNibonrC/8SGNZ8jErVipn22LhUsjogZKh8DvR4iEjDPl
 +NrPlb/V/8MnxWFzRZmNrbGAFKorj7PCVd77x0kEj7t01bJgiPh/J8RyHMhQ0XlX5ug==
X-Google-Smtp-Source: AGHT+IFvMQeCT4K/jdPsRcGfsdp2aoAubxAqu9Uzlgv3XMpvz0vUPBuwgLOGs9MnwBrU5C2yN/qc5g==
X-Received: by 2002:a05:6000:2c10:b0:401:70eb:eec7 with SMTP id
 ffacd0b85a97d-405cb5d1ca4mr2724967f8f.43.1758634503367; 
 Tue, 23 Sep 2025 06:35:03 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07411f4dsm23819303f8f.26.2025.09.23.06.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 06:35:02 -0700 (PDT)
Message-ID: <d9624d53-9562-4ac8-94c5-bdc5fefddb3f@linaro.org>
Date: Tue, 23 Sep 2025 15:35:01 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923023922.3102471-9-richard.henderson@linaro.org>
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

On 23/9/25 04:39, Richard Henderson wrote:
> In all cases, we are already within start_exclusive.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: Alex Bennée" <alex.bennee@linaro.org>
> Cc: Alexandre Iooss <erdnaxe@crans.org>
> Cc: Mahmoud Mandour <ma.mandourr@gmail.com>
> Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   plugins/core.c   | 6 ++----
>   plugins/loader.c | 2 +-
>   2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/plugins/core.c b/plugins/core.c
> index c6e9ef1478..4ae1a6ae17 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -248,7 +248,7 @@ static void plugin_grow_scoreboards__locked(CPUState *cpu)
>           }
>           plugin.scoreboard_alloc_size = scoreboard_size;
>           /* force all tb to be flushed, as scoreboard pointers were changed. */
> -        tb_flush(cpu);
> +        tb_flush__exclusive();
>       }
>       end_exclusive();
>   }
> @@ -684,8 +684,6 @@ void qemu_plugin_user_exit(void)
>        * with the one in fork_start(). That is:
>        * - start_exclusive(), which acquires qemu_cpu_list_lock,
>        *   must be called before acquiring plugin.lock.
> -     * - tb_flush(), which acquires mmap_lock(), must be called
> -     *   while plugin.lock is not held.
>        */
>       start_exclusive();
>   
> @@ -705,7 +703,7 @@ void qemu_plugin_user_exit(void)
>       }
>       qemu_rec_mutex_unlock(&plugin.lock);
>   
> -    tb_flush(current_cpu);
> +    tb_flush__exclusive();
>       end_exclusive();
>   
>       /* now it's safe to handle the exit case */

Hmm it seems we are triggering again the issue reported about
TARGET_NR_exit_group in https://linaro.atlassian.net/browse/QEMU-706:

   "Under user emulation, threads can exit via pthread_join or at
    the end of the process via exit_group syscall.

   The current plugin exit hook affects all vcpus (see
   qemu_plugin_disable_mem_helpers call in qemu_plugin_user_exit)."

Crash log:

qemu-loongarch64: ../../accel/tcg/tb-maint.c:94: tb_remove_all: 
Assertion `have_mmap_lock()' failed.

Thread 1 "qemu-loongarch6" received signal SIGABRT, Aborted.
__pthread_kill_implementation (no_tid=0, signo=6, 
threadid=140737340860416) at ./nptl/pthread_kill.c:44
44	./nptl/pthread_kill.c: No such file or directory.
(gdb) bt
#0  __pthread_kill_implementation (no_tid=0, signo=6, 
threadid=140737340860416) at ./nptl/pthread_kill.c:44
#1  __pthread_kill_internal (signo=6, threadid=140737340860416) at 
./nptl/pthread_kill.c:78
#2  __GI___pthread_kill (threadid=140737340860416, signo=signo@entry=6) 
at ./nptl/pthread_kill.c:89
#3  0x00007ffff746f476 in __GI_raise (sig=sig@entry=6) at 
../sysdeps/posix/raise.c:26
#4  0x00007ffff74557f3 in __GI_abort () at ./stdlib/abort.c:79
#5  0x00007ffff745571b in __assert_fail_base (fmt=0x7ffff760a130 
"%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=0x555555733f0c 
"have_mmap_lock()",
     file=0x555555733ef1 "../../accel/tcg/tb-maint.c", line=94, 
function=<optimized out>) at ./assert/assert.c:94
#6  0x00007ffff7466e96 in __GI___assert_fail 
(assertion=assertion@entry=0x555555733f0c "have_mmap_lock()",
     file=file@entry=0x555555733ef1 "../../accel/tcg/tb-maint.c", 
line=line@entry=94, function=function@entry=0x555555734038 
<__PRETTY_FUNCTION__.8> "tb_remove_all")
     at ./assert/assert.c:103
#7  0x0000555555612e41 in tb_remove_all () at ../../accel/tcg/tb-maint.c:94
#8  tb_flush__exclusive () at ../../accel/tcg/tb-maint.c:781
#9  0x0000555555623a0c in qemu_plugin_user_exit () at 
../../plugins/core.c:706
#10 0x0000555555696e54 in preexit_cleanup (env=<optimized out>, 
code=code@entry=0) at ../../linux-user/exit.c:36
#11 0x00005555556b49e7 in do_syscall1 (cpu_env=<optimized out>, num=94, 
arg1=0, arg2=0, arg3=-4096, arg4=4832763904, arg5=2, arg6=140737354113832,
     arg8=<optimized out>, arg7=<optimized out>) at 
../../linux-user/syscall.c:11199
#12 0x00005555556b966a in do_syscall 
(cpu_env=cpu_env@entry=0x555555860df0, num=94, arg1=0, arg2=<optimized 
out>, arg3=<optimized out>, arg4=<optimized out>,
     arg5=2, arg6=140737354113832, arg7=-1, arg8=-1) at 
../../linux-user/syscall.c:13929
#13 0x0000555555623d3d in cpu_loop (env=env@entry=0x555555860df0) at 
../../linux-user/loongarch64/cpu_loop.c:38
#14 0x000055555558886d in main (argc=<optimized out>, argv=<optimized 
out>, envp=<optimized out>) at ../../linux-user/main.c:1033


