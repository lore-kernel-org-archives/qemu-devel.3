Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91164C3ABA5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 02:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9xPk-00029W-G8; Tue, 29 Apr 2025 22:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9xPj-00029L-Dk
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 22:43:11 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9xPh-00052o-Io
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 22:43:11 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so7466815b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 19:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745980988; x=1746585788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4UYTk3bYMo3RfV5UAnGcqbAKE/oiNrtVZdqX+RIWBME=;
 b=JgsVk6lutP19oJCytW3h1SAvqAqJM0qQCLBAPFCjpEKC7tT/kFhfR5c4+7pBVPXX0B
 Hww4cj3Z9CTQ3oI8wHdipJYm+ZsGEXZEXDarkWOJdSsD0mZMkOe290jxJm+p+KiJXztS
 po8ywBgulTXU8G8sDAj53nQbnk8YneSYS//PnU8yMzKryQnaLXYrwy9+JXFB8W3wVPmM
 cxn+h60bXabEjxrpcUeRRYa/N1MykWO5kv7tuPo22mJUe9THVDtYQ8NPsDy2nRWbCGO9
 YW+CUEM8bQSmF7n+NaoaGDxlj+pkVFnHFz7FkXqonQSt0fBWQ+4OK1EmXKNGP3BpGkoH
 DSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745980988; x=1746585788;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4UYTk3bYMo3RfV5UAnGcqbAKE/oiNrtVZdqX+RIWBME=;
 b=h53+6XFgcM2xOWAoINq76g7B3EyDNZX5QIRVgAd+3TqIrcoQ6p7723mSXxnE6EARQb
 qZ0FPN8DqWAN28P0tReUPh01ekqOltBsA9hvGaUK9jTChJnvqtz4ALwDEg7uHTjobC36
 apKYQHEtaNzkwsZxA3yPOcMe+Qq9KM2gfS/d8szWMQX+GBSm/GdOf50Qk+6t55T0XxDc
 ws2IdDPFsbdiHuZfPt1GgcyE/4zGecvhpxxp6CZaKvjfsnEhkJFU70zfMu2qRCKPAiUc
 OGMcCQHSybeU8XPqXeZCCdVx3nH8r2vQfbGA5/F89378GlyPGRrySDYip2C6XOEKJmfD
 CBOw==
X-Gm-Message-State: AOJu0YwtB1qshgmXFicBLtk+LvgNuydUpaMKidYwVQtrT5g4/HcLWuA8
 dYETC3XlrgSLSlsgBALvqbvVM7k9IySa+crJ9gNRB2xfFbW9R4dN54FqIf0F/0A=
X-Gm-Gg: ASbGncuag3DSaklDVK1n/q8OcJwUhQ1F1Utp5Me5ZQYKREdw56XupAPx/wj/sN8UBU0
 JpKig+UjPchGEPA97nX3NXAEWti8BQxlLVPJxynYxIs3efIooy8Xa/620nrlZZg4vtxcl+cNOPL
 zvZ3qhAsVhdLEj4pPGDDb88FnkVPNOECw2wu+COwSkCMJlNDaSNcf9lD6FTwr4i1YzmwhBbeNzx
 raLzkLp0NH+p5Dx4j8i/pAH2bIus3i9OROrynaIUYP1M0oq2O2QMgLK9B7dwOSYvVqGtlVMmSAr
 AGx3g2izveI1Fb3BdIQH4bFF5BDYC5qabxZ4ldhctf4hMgtCamUF7syG8zD2HRncTfPXuWErmO9
 +C8BUezw=
X-Google-Smtp-Source: AGHT+IH4bu+VVO4eeR2ZwxWWiX7X/CYZ76u7D1j2fkt+ZK07ynqvuWBsDTtsirJdtvNuZxj/2o8QpQ==
X-Received: by 2002:a05:6a21:8dc5:b0:1f5:6e71:e55 with SMTP id
 adf61e73a8af0-20a8754292emr1891497637.6.1745980987666; 
 Tue, 29 Apr 2025 19:43:07 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f7ec0d20sm9726493a12.28.2025.04.29.19.43.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 19:43:07 -0700 (PDT)
Message-ID: <04875ca2-781b-4000-b74c-fc338bc6ec4d@linaro.org>
Date: Tue, 29 Apr 2025 19:43:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 066/147] include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE to
 slow flags
To: Alistair Francis <alistair23@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linuxarm@huawei.com
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-67-richard.henderson@linaro.org>
 <20250425183524.00000b28@huawei.com>
 <CAKmqyKMN5bo12Oh8hrwdiimqJSzHMZwB7JjAquBrEK3PTbtGyA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAKmqyKMN5bo12Oh8hrwdiimqJSzHMZwB7JjAquBrEK3PTbtGyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/29/25 14:35, Alistair Francis wrote:
> On Sat, Apr 26, 2025 at 3:36 AM Jonathan Cameron via
> <qemu-devel@nongnu.org> wrote:
>>
>> On Tue, 22 Apr 2025 12:26:55 -0700
>> Richard Henderson <richard.henderson@linaro.org> wrote:
>>
>>> Recover two bits from the inline flags.
>>
>>
>> Hi Richard,
>>
>> Early days but something (I'm fairly sure in this patch) is tripping up my favourite
>> TCG corner case of running code out of MMIO memory (interleaved CXL memory).
>>
>> Only seeing it on arm64 tests so far which isn't upstream yet..
>> (guess what I was getting ready to post today)
>>
>> Back trace is:
>>
>> #0  0x0000555555fd4296 in cpu_atomic_fetch_andq_le_mmu (env=0x555557ee19b0, addr=18442241572520067072, val=18446744073701163007, oi=8244, retaddr=<optimized out>) at ../../accel/tcg/atomic_template.h:140
>> #1  0x00007fffb6894125 in code_gen_buffer ()
>> #2  0x0000555555fc4c46 in cpu_tb_exec (cpu=cpu@entry=0x555557ededf0, itb=itb@entry=0x7fffb6894000 <code_gen_buffer+200511443>, tb_exit=tb_exit@entry=0x7ffff4bfb744) at ../../accel/tcg/cpu-exec.c:455
>> #3  0x0000555555fc51c2 in cpu_loop_exec_tb (tb_exit=0x7ffff4bfb744, last_tb=<synthetic pointer>, pc=<optimized out>, tb=0x7fffb6894000 <code_gen_buffer+200511443>, cpu=0x555557ededf0) at ../../accel/tcg/cpu-exec.c:904
>> #4  cpu_exec_loop (cpu=cpu@entry=0x555557ededf0, sc=sc@entry=0x7ffff4bfb7f0) at ../../accel/tcg/cpu-exec.c:1018
>> #5  0x0000555555fc58f1 in cpu_exec_setjmp (cpu=cpu@entry=0x555557ededf0, sc=sc@entry=0x7ffff4bfb7f0) at ../../accel/tcg/cpu-exec.c:1035
>> #6  0x0000555555fc5f6c in cpu_exec (cpu=cpu@entry=0x555557ededf0) at ../../accel/tcg/cpu-exec.c:1061
>> #7  0x0000555556146ac3 in tcg_cpu_exec (cpu=cpu@entry=0x555557ededf0) at ../../accel/tcg/tcg-accel-ops.c:81
>> #8  0x0000555556146ee3 in mttcg_cpu_thread_fn (arg=arg@entry=0x555557ededf0) at ../../accel/tcg/tcg-accel-ops-mttcg.c:94
>> #9  0x00005555561f6450 in qemu_thread_start (args=0x555557f8f430) at ../../util/qemu-thread-posix.c:541
>> #10 0x00007ffff7750aa4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:447
>> #11 0x00007ffff77ddc3c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
>>
>> I haven't pushed out the rebased tree yet making this a truly awful bug report.
>>
>> The pull request you sent with this in wasn't bisectable so this was a bit of a guessing
>> game. I see the seg fault only after this patch.
> 
> I see the same thing with some RISC-V tests. I can provide the test
> images if you want as well


Yes please.


r~

