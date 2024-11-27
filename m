Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F409BD6ACF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 17:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGM2S-0005uR-QE; Wed, 27 Nov 2024 12:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGM2Q-0005rP-WA
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:41:19 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGM2P-0006eT-DA
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:41:18 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ffd796ba0aso9636361fa.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 09:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732729275; x=1733334075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vEbuEMVWhAXfX38fSgMWlxt0Aixn/L9mZD/G9ye829s=;
 b=Lox8JUemftwQAjrHh346PTqXiuhgW76tJNio0c36QExSzmgufqnO/fsadZ7qqPsfzj
 ZrNHpJy3e+Hr+YsQIgUXfCXdz5SOBqd+1egJbRz9duN03uQsEU4DhOBNr60L4hQ3e32Q
 YoTQr764eC9Amyqvt6JWQmdGRlK/4ZVvikqp3CGL8XVlpoU0rbWaGl3SRad/ZFOBWM3e
 z1PB8KBujrwmOAMCZ3KoXDU3hFYPmCTj2EZfPmVwsonhQEnFiXtP5R1P0V0rm4dMf+DI
 tkGUULOzytQSe2dD3KrObUtIvdDZ79MITd6AiUUlcIC3xDWm/Jgw6GUfTEbzBtmBnPEv
 XT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732729275; x=1733334075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vEbuEMVWhAXfX38fSgMWlxt0Aixn/L9mZD/G9ye829s=;
 b=IN1BNAas2F127KOslEeohzWEe/jYY215Fgw93Q/bLOqOIbi+7t6lsa1cVtnOkmmwqq
 8SGRKoe9mPqjKvoVUaDf2L4XwVDLBwXp4XGLrg66c/gNxHj/mWvbU9RiDo9ZVl2CyGqi
 rmB+nt9Yp0C9SsjJVoGD/sl0nLj/GBWEBnx4OeR9UwaGHATyY5UMRRYpx/pi4WOXr2JN
 ZzuRA+zgQvnugLk7Qto9Ao6Kxma2iPiGtthwndY1l2BirIzYlD2ZvjDCTq3s9yoJ+GmR
 MZlAsjsepNMU45LyN5SpYt53fGR0oKoy87Hks2CicC506xkgUcJjBzM6rTwyt8fbhHU4
 aWCA==
X-Gm-Message-State: AOJu0YwkpmVvaKRtnxqfgUsLRrlAUvhjJoBO0cXkLSp5/ti9g9sUuwmz
 I8gplhjzUxvm6HdIDBnXIyxrow3Oz0I4iz1C6hpHtr8tXmozODjgUxke4JJWiOQ=
X-Gm-Gg: ASbGncvPXNQ645pTPy56+iLvLeRSoML9DkznFbiRbpIkSaLJMzsmUu3RmbW6zJ3J9jC
 QXiaXpqglSSEU2q3nCJdLX21k8RE9Yyvuns6CMzdZ7YWY38PdpmADk+FCRz3FhBZqK/Au1hlAbs
 zL6A2hGe6X8FDN9WScEovm+dMHhrOiUjDu7ei3y/ZZRWjj0VTpqPX7bOTz8sSnonjY4D7FbRmiJ
 JquxMWDQ7QOWJrY/Lw8Pr43sOWlziSAkDc3EvC8Ly/Dgd4J/A/PUJ8a5onuTYbgxJUR
X-Google-Smtp-Source: AGHT+IEDDsOtZnq3lpwe7koPosYVpfuHPq2zTPr1q/ASeU40x91GYPcuYizVYoCzGhb0lvvW+RUA/Q==
X-Received: by 2002:a2e:be8d:0:b0:2ff:b6df:ce0a with SMTP id
 38308e7fff4ca-2ffd60debb1mr26648811fa.28.1732729275142; 
 Wed, 27 Nov 2024 09:41:15 -0800 (PST)
Received: from [192.168.170.227] ([91.209.212.66])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ffa4d17543sm21573981fa.6.2024.11.27.09.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 09:41:13 -0800 (PST)
Message-ID: <ce0df450-537a-49d5-bed6-caf2db11e536@linaro.org>
Date: Wed, 27 Nov 2024 11:41:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 6/6] accel/tcg: Allow tcg_exec_realizefn()
 initialize multiple frontends
To: Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241127121658.88966-1-philmd@linaro.org>
 <20241127121658.88966-7-philmd@linaro.org>
 <pfndwuswldc3bqu5p4uof53nu6wxuvoeuzsbo3c7uaqij7go3e@yypfckmjv4dc>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <pfndwuswldc3bqu5p4uof53nu6wxuvoeuzsbo3c7uaqij7go3e@yypfckmjv4dc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x233.google.com
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

On 11/27/24 11:28, Anton Johansson wrote:
> On 27/11/24, Philippe Mathieu-Daudé wrote:
>> Rather than initializing the first random target architecture
>> and ignore the following ones when a global boolean is set,
>> use a bitmask allowing different frontend targets to be
>> initialized.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/tcg/cpu-exec.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> index ab77740c954..b37995f7d0c 100644
>> --- a/accel/tcg/cpu-exec.c
>> +++ b/accel/tcg/cpu-exec.c
>> @@ -1070,16 +1070,17 @@ int cpu_exec(CPUState *cpu)
>>   
>>   bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
>>   {
>> +    static unsigned initialized_targets;
>>       const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
>>   
>> -    if (!tcg_target_initialized) {
>> +    if (!(initialized_targets & tcg_ops->arch_id)) {
>>           /* Check mandatory TCGCPUOps handlers */
>>   #ifndef CONFIG_USER_ONLY
>>           assert(tcg_ops->cpu_exec_halt);
>>           assert(tcg_ops->cpu_exec_interrupt);
>>   #endif /* !CONFIG_USER_ONLY */
>>           tcg_ops->initialize_once();
>> -        tcg_target_initialized = true;
>> +        initialized_targets |= tcg_ops->arch_id;
>>       }
>>   
>>       cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
>> -- 
>> 2.45.2
>>
> 
> Only suggestion would be to assert that arch_id is set, might save some
> headache in the future.

Yep.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

