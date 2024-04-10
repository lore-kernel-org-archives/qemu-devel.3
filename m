Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA677CD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 20:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rueUk-0001rR-6r; Wed, 10 Apr 2024 16:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rueUj-0001r2-9Q
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 16:24:33 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rueUh-0003Ci-4f
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 16:24:32 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ecf8ebff50so148386b3a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 13:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1712780669; x=1713385469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K0fdxUMTObtc6VatQxbqJ67dC34jcDtKHMHbSEy6M2k=;
 b=LVNUlrFJLPJN+rSB4HOaO184wy4FH/6LxQQLZE3o6Th3qtjdHg+E7k7IlP6vPAPgBw
 bJUQr4e2Nj5pQy9DYgS5enD4nT5bWYo/PfWaB8XqSZfDdDJHDovq1fhvPNmh74N8WDP9
 PgGJ14Kyr4H/DVlaoWfeZ9tekdxP/2bv4WZi6Gvk8orPLEkOT+rsvfrNrm2H3DasngPf
 YlAKUp7ppTW0ZhF9GnbnCURxxBwkeKGgMHypwQuyIiA/OjdJmm7KnDjeJri3o8m/AMpM
 TpZUdkBc8lmV7Rj5vf/wPdVv6YTzmpUrkA9NDnCjZbEb5WNoP1NDiqrPEKxWqITq96nc
 IGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712780669; x=1713385469;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K0fdxUMTObtc6VatQxbqJ67dC34jcDtKHMHbSEy6M2k=;
 b=gNxAEzzFEliC3DgSt8kXz0YFrkwbFHEKJjBlXKnFryUMVbvitfccaPLyqvBiC5ad30
 x5aIJaiSwzacOj3vklyI/88Wo4IFWmsvu169fQdi9j/RUmjvZHAMmuFRcRZtUNkGBF7A
 2F8GO0KkNr2b7c4CTYVNkJeFPeaOHStShd8BJFRcJ9NvkMxHMcq/lAynCJdfzcLGVQOQ
 yEYvxYXMMoVqr6X6jKWcbTnGexEtGR7GOUtMNZK5dKsOh68P4fqCA34FE/yWmY+k00Oh
 GzsV+duUtEN9798roo057R5q2uCb7gFOo/TunxGRXEtgFbcw/fBepciNuPe5PZ+qq1f0
 q1rA==
X-Gm-Message-State: AOJu0Yx72d5M8eObGkOgns6FltObL//Y00a9VcXleYk9SpIo55J5LqJm
 Zia4IPNscctijxjDlRC+saoYy7WaL3oa0kTecIIzEIuqygZ2ToePxp/inRAf7Vw=
X-Google-Smtp-Source: AGHT+IFJBBzzbVoe/ecEwIfB10Piuo5mBfuOpNOiJRTQZVHpW4GEEaW2s1tDfQsNHc4CCOPZyJ7T7w==
X-Received: by 2002:a05:6a00:acc:b0:6ea:f3fb:26fe with SMTP id
 c12-20020a056a000acc00b006eaf3fb26femr993065pfl.12.1712780668713; 
 Wed, 10 Apr 2024 13:24:28 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 r15-20020aa78b8f000000b006edda81101esm47879pfd.80.2024.04.10.13.24.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 13:24:28 -0700 (PDT)
Message-ID: <e6b49db7-ec02-4d76-8d57-b47dbcbb8ee7@ventanamicro.com>
Date: Wed, 10 Apr 2024 17:24:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] target/riscv/debug: set tval=pc in breakpoint
 exceptions
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, Joseph Chan <jchan@ventanamicro.com>
References: <20240320093221.220854-1-dbarboza@ventanamicro.com>
 <CAKmqyKMDu7UTMhHOxs2=5qjRkcgWson+iQoUDhG+23xAtQF3rQ@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAKmqyKMDu7UTMhHOxs2=5qjRkcgWson+iQoUDhG+23xAtQF3rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
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



On 3/22/24 00:59, Alistair Francis wrote:
> On Wed, Mar 20, 2024 at 7:33 PM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> We're not setting (s/m)tval when triggering breakpoints of type 2
>> (mcontrol) and 6 (mcontrol6). According to the debug spec section
>> 5.7.12, "Match Control Type 6":
>>
>> "The Privileged Spec says that breakpoint exceptions that occur on
>> instruction fetches, loads, or stores update the tval CSR with either
>> zero or the faulting virtual address. The faulting virtual address for
>> an mcontrol6 trigger with action = 0 is the address being accessed and
>> which caused that trigger to fire."
> 
> Setting zero is valid though. I agree it's probably worth setting a
> value, but I don't think we need this for 9.0

In fact, when fixing another related bug I learned that this except I mentioned
from the debug spec doesn't tell the whole story. The section for mtval, priv
spec 3.1.16, says:

"When a trap is taken into M-mode, mtval is either set to zero or written with
exception-specific information to assist software in handling the trap. Otherwise,
mtval is never written by the implementation (...)"


So "mtval" zero is valid. However the section for stval, priv spec 4.1.9, says:

"When a trap is taken into S-mode, stval is written with exception-specific information
to assist software in handling the trap. Otherwise, stval is never written by the
implementation, though it may be explicitly written by software. The hardware platform
will specify which exceptions must set stval informatively and which may unconditionally
set it to zero."

This a bit more cryptic to me. It doesn't mention "it's either zero or written", giving
the impression that we must set it to a valid addr. But then in the end it follows up
with  "The hardware platform will specify which exceptions must set stval informatively
and which may unconditionally set it to zero.". So I'm not sure whether stval can be
zero or not. I *think* zero is kind of valid ...

Due to the apparent ambiguity I can't claim that this patch, and another patch I'm about
to send that kind of does the same thing, is 9.0 material. I'll send both as 9.1.


Thanks,

Daniel




> 
> Alistair
> 
>>
>> A similar text is also found in the Debug spec section 5.7.11 w.r.t.
>> mcontrol.
>>
>> Given that we always use action = 0, save the faulting address for the
>> mcontrol and mcontrol6 trigger breakpoints into env->badaddr, which is
>> used as as scratch area for traps with address information. 'tval' is
>> then set during riscv_cpu_do_interrupt().
>>
>> Reported-by: Joseph Chan <jchan@ventanamicro.com>
>> Fixes: b5f6379d13 ("target/riscv: debug: Implement debug related TCGCPUOps")
>> Fixes: c472c142a7 ("target/riscv: debug: Add initial support of type 6 trigger")
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu_helper.c | 1 +
>>   target/riscv/debug.c      | 3 +++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index ce7322011d..492ca63b1a 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -1717,6 +1717,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>               tval = env->bins;
>>               break;
>>           case RISCV_EXCP_BREAKPOINT:
>> +            tval = env->badaddr;
>>               if (cs->watchpoint_hit) {
>>                   tval = cs->watchpoint_hit->hitaddr;
>>                   cs->watchpoint_hit = NULL;
>> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
>> index e30d99cc2f..b110370ea6 100644
>> --- a/target/riscv/debug.c
>> +++ b/target/riscv/debug.c
>> @@ -798,6 +798,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>>                   if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
>>                       /* check U/S/M bit against current privilege level */
>>                       if ((ctrl >> 3) & BIT(env->priv)) {
>> +                        env->badaddr = pc;
>>                           return true;
>>                       }
>>                   }
>> @@ -810,11 +811,13 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>>                       if (env->virt_enabled) {
>>                           /* check VU/VS bit against current privilege level */
>>                           if ((ctrl >> 23) & BIT(env->priv)) {
>> +                            env->badaddr = pc;
>>                               return true;
>>                           }
>>                       } else {
>>                           /* check U/S/M bit against current privilege level */
>>                           if ((ctrl >> 3) & BIT(env->priv)) {
>> +                            env->badaddr = pc;
>>                               return true;
>>                           }
>>                       }
>> --
>> 2.44.0
>>
>>

