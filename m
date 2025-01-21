Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFD8C0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJHj-0002fE-UE; Tue, 21 Jan 2025 13:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taJHR-0002Br-8q
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:47:18 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taJHP-0004vV-EL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:47:16 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2efe25558ddso7802705a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737485233; x=1738090033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UC9vhkIhQz3zAYoW6dUSHkOnB7BHD1z7RRpICZPKN5Q=;
 b=ZBQ+tRHgX9EHJS98VO/kxnBtrihsRPbR8bSHiK+zIVLJCxgcUwy+PKlQXTFbTKPbzG
 JafxLBpip92hgRtPPTD7Vw+ohEoSJX66iCVsvExHrB2ERrvezqT7xT6lKpn7TmBBHdmT
 loX7SBi1MVzAlAOBBdOGcUVB2Doi9prKLwYAt0jKy644jUyMJXkZ6msN3Hmhmjh3tPyV
 RRuHujhxOZT94BB6tLcNSjxtI424Qma/5fTgDecwEqRaIIynjKpKfGyaIpymGvRIC0wH
 FWrirr1L4j5Mjy7UgdOpYGq9Eq+j2x7ysXsnfFFqgPCAxXXLLv1vmQR0AauAwcWBGkzV
 1h0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737485233; x=1738090033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UC9vhkIhQz3zAYoW6dUSHkOnB7BHD1z7RRpICZPKN5Q=;
 b=EoPRfQXm1brP+DDaX2DDQTZiOdwuoYaXn0O6OSCL6FFZGGbdg/K8wDkz1Pi87/M1st
 rxFzogRjlZef5POO15xnqo9naQ+2nPNqqP/6KxVMSG9aUcQSuskQeU9UnxMt7dUpW8CY
 rtqfpW+7QV1AkJu1EIJnZ/8TUGUsuXok3AfE13rTQyJ0c+vnzWbfOpwDzx418pmL1zLk
 LqJWRO4W98fqR8AnGtUmx6hd6Wxmmq+8pY3rKESugtXtm6fl2vEssNL3VD2fmekhJ+4t
 KTb7GW4r/Oxz5SbTenuxB64lijW+fxuVnbnLct857My4orZHXMvOoWAHwRtWHPGLH57M
 B4Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiagrCy9aKyXDZtz0REwEgpJTp2RnAI6vEqPoQ5kmtgNYGOUTrBA8MHhgBzwOcQYxAYN7HoEEK+1Zb@nongnu.org
X-Gm-Message-State: AOJu0Yzhf4h2+qzCA3NNBA6YzwFrPegEuF4wU1QD5JFf/8tO3fCQbFVG
 fXkyXMeWVKST+OsQyJ40PWD0qoxu2FlIxpV2d+9AaMPkf57m/UneCtmJz4xmwzQ=
X-Gm-Gg: ASbGnctS+EPS6fTsFmkva4I/e9pkTw9VM2b7us7ArezHoy/qUVAPkDy5UL+7APcBvEh
 TStfevjH3pOFSADIwrau2RM/Pur4OlfPya2YxNCf04fbNe2UUjly5ltEtsSb3fmB6D+CN4k47i5
 UZcBh2Fi9e3fhhZ74q5hNHnQ20FB4MZglXgWBgs7niy6M1dPVuzfE/3uPDyAJSi9+a9wh7K7OIQ
 sUAgTkkeXqRa1ozsEQW8Wf3jmob+DtdhOiGnRxhoX9dQainwpE8+e8tgADm+Bxfn4dEXquAwKEE
 HEVhTGv7
X-Google-Smtp-Source: AGHT+IFU5R03H49ksRLSlG2egRPJj5Jxf+QnMfeR40ZB3v+o2TIuzMpjMR5LoosRJhlIZ2a4+B7COQ==
X-Received: by 2002:a17:90a:d2d0:b0:2ee:b6c5:1de7 with SMTP id
 98e67ed59e1d1-2f782c4c297mr27844104a91.2.1737485232958; 
 Tue, 21 Jan 2025 10:47:12 -0800 (PST)
Received: from [192.168.68.110] ([191.202.238.10])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7c30d60acsm4760983a91.47.2025.01.21.10.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 10:47:12 -0800 (PST)
Message-ID: <a6f3ed4a-94be-484e-a9ac-9f3b1eb9cf1d@ventanamicro.com>
Date: Tue, 21 Jan 2025 15:47:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/riscv/debug.c: use wp size = 4 for 32-bit
 CPUs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org
References: <20250120204910.1317013-1-dbarboza@ventanamicro.com>
 <20250120204910.1317013-2-dbarboza@ventanamicro.com>
 <9b2114bb-ed61-42bc-a5fe-f28a6a5319dc@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <9b2114bb-ed61-42bc-a5fe-f28a6a5319dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1032.google.com
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



On 1/21/25 2:40 PM, Philippe Mathieu-Daudé wrote:
> On 20/1/25 21:49, Daniel Henrique Barboza wrote:
>> The mcontrol select bit (19) is always zero, meaning our triggers will
>> always match virtual addresses. In this condition, if the user does not
>> specify a size for the trigger, the access size defaults to XLEN.
>>
>> At this moment we're using def_size = 8 regardless of CPU XLEN. Use
>> def_size = 4 in case we're running 32 bits.
>>
>> Fixes: 95799e36c1 ("target/riscv: Add initial support for the Sdtrig extension")
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/debug.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
>> index f6241a80be..9db4048523 100644
>> --- a/target/riscv/debug.c
>> +++ b/target/riscv/debug.c
>> @@ -478,7 +478,7 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
>>       bool enabled = type2_breakpoint_enabled(ctrl);
>>       CPUState *cs = env_cpu(env);
>>       int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
>> -    uint32_t size;
>> +    uint32_t size, def_size;
>>       if (!enabled) {
>>           return;
>> @@ -501,7 +501,9 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
>>               cpu_watchpoint_insert(cs, addr, size, flags,
>>                                     &env->cpu_watchpoint[index]);
>>           } else {
>> -            cpu_watchpoint_insert(cs, addr, 8, flags,
>> +            def_size = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;
> 
> riscv_cpu_mxl() seems bugprone w.r.t. MXL_RV128, better could be
> some riscv_cpu_mxl_wordsize() helper like riscv_cpu_mxl_bits()
> (or better named).

This existing pattern is benign since we don't have a functional RV128 and
is safe seems to interpret RV64 == RV128.

However, if/when RV128 becomes a thing, we'll spare a moderate amount of agony
if we choose to have a little suffering right now. I'll take a note about it
and perhaps a refactor might be in order.


Thanks,

Daniel

> 
> Anyway this pattern is already all over, so meanwhile:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> +
>> +            cpu_watchpoint_insert(cs, addr, def_size, flags,
>>                                     &env->cpu_watchpoint[index]);
>>           }
>>       }
> 


