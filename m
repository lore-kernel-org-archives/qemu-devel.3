Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3868D606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=univ-grenoble-alpes.fr header.i=@univ-grenoble-alpes.fr header.a=rsa-sha256 header.s=2020 header.b=X6MaVnzJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKEEe-0003yn-Ff; Fri, 23 Oct 2026 08:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xKEEa-0003x0-0D; Fri, 23 Oct 2026 08:18:57 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xKEEX-0002oq-Hs; Fri, 23 Oct 2026 08:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1792757927;
 bh=YqaTwy1/mUnFcPHG9KcifDzXKTzd9LG/3Xpfw+eNxdc=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=X6MaVnzJ240npgR9moXejUso9P18nUoeW4En6YRiOMsC4rXc911xmUqtqDNAWHawn
 d+M7aSLvBayiT2ocY3cyfTg0dNp/RrIgdy2pnazFiPlRkUfz2SvGRYbCWxGnyTZkWN
 8Ikp/lArptNoIgCkEZzgp0dn0u+8Hl+DrZ5bA+N/2Np2Cby+eb7GHKfPAzCzvWtj0K
 8mmeMuRtbvrrISsj9+1jdB9pAdaid4Z6LTrhDZpKQQpTYZl8BWU+59QXVGwwzu7yZ0
 G3ESnRrNsVbfnF0GdW/N8giQ3I+zLTdGtxM95LTicNLCu+CIPobkZNs56c9qgHhzV8
 x7uqVLgDCUnPQ==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 8B9074021D;
 Fri, 23 Oct 2026 14:18:47 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id 8726CFF855;
 Fri, 23 Oct 2026 14:18:47 +0200 (CEST)
Received: from [147.171.132.150] (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 2A6D14004A;
 Fri, 23 Oct 2026 14:18:47 +0200 (CEST)
Message-ID: <0e80ee62-c48e-4d08-a317-41b6baf6fa75@univ-grenoble-alpes.fr>
Date: Fri, 23 Oct 2026 14:18:46 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/riscv: fix riscv_cpu_do_interrupt sanitize
 error for x-rv128
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 daniel.barboza@oss.qualcomm.com, peter.maydell@linaro.org,
 chao.liu@processmission.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, palmer@dabbelt.com, liwei1518@gmail.com
References: <20261022112145.356726-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20261022112145.356726-3-frederic.petrot@univ-grenoble-alpes.fr>
 <31c4f71a924f57f20b2427bf4c49e8e4fb4b10bc.camel@wdc.com>
Content-Language: en-US, fr
From: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <31c4f71a924f57f20b2427bf4c49e8e4fb4b10bc.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 07:14, Alistair Francis wrote:
> On Thu, 2026-10-22 at 13:21 +0200,
> frederic.petrot@univ-grenoble-alpes.fr wrote:
>> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
>>
>> UndefinedBehaviorSanitizer reports an undefined behavior when setting
>> the Interrupt flag (msb) in the [ms]cause registers due to an out of
>> bounds shift.
>> We specifically correct these cases, leaving the ones depending on
>> specific extensions untouched.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Frédéric Pétrot
>> <frederic.petrot@univ-grenoble-alpes.fr>
>> ---
>>   target/riscv/cpu.h            |  2 ++
>>   target/riscv/tcg/cpu_helper.c | 14 ++++++++++++--
>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index b65d631994..17bfcf38c0 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -354,10 +354,12 @@ struct CPUArchState {
>>       uint64_t stvec;
>>       uint64_t sepc;
>>       uint64_t scause;
>> +    uint64_t scauseh;
>>   
>>       uint64_t mtvec;
>>       uint64_t mepc;
>>       uint64_t mcause;
>> +    uint64_t mcauseh;
> 
> This isn't correct though, there is no mcauseh CSR in RISC-V
> 
> I do think this is getting hard to justify as we are adding CSRs and
> CPU state that doesn't actually exist and there appears to be no effort
> towards making it exist (from a RIV perspective).
> 
> It's not clear if these should just be 64-bit CSRs

   Fair enough.
   Right now the 32 and 64 bits RV specs assume (with a few
   exceptions) XLEN csrs.
   Some have information in their MSb, e.g. XLEN in misa,
   SD in mstatus, Interrupt in mcause.
   In the end, I would expect rv128 to align with that (since
   it is at zero hardware cost).

> 
>>       uint64_t mtval;  /* since: priv-1.10.0 */
>>   
>>       uint64_t mctrctl;
>> diff --git a/target/riscv/tcg/cpu_helper.c
>> b/target/riscv/tcg/cpu_helper.c
>> index 58e98e975c..b35b61dc01 100644
>> --- a/target/riscv/tcg/cpu_helper.c
>> +++ b/target/riscv/tcg/cpu_helper.c
>> @@ -2375,7 +2375,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>           }
>>           env->mstatus = s;
>>           sxlen = 16 << riscv_cpu_sxl(env);
>> -        env->scause = cause | ((target_ulong)async << (sxlen - 1));
>> +        if (riscv_cpu_sxl(env) != MXL_RV128) {
>> +            env->scause = cause | ((target_ulong)async << (sxlen -
>> 1));
>> +        } else {
>> +            env->scause = cause;
>> +            env->scauseh = (target_ulong)async << 63;
>> +        }
>>           env->sepc = env->pc;
>>           env->stval = tval;
>>           env->htval = htval;
>> @@ -2447,7 +2452,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>               s = set_field(s, MSTATUS_MDT, 1);
>>           }
>>           env->mstatus = s;
>> -        env->mcause = cause | ((target_ulong)async << (mxlen - 1));
>> +        if (riscv_cpu_mxl(env) != MXL_RV128) {
>> +            env->mcause = cause | ((target_ulong)async << (mxlen -
>> 1));
>> +        } else {
>> +            env->mcause = cause;
>> +            env->mcauseh = (target_ulong)async << 63;
>> +        }
> 
> It's great you set these, but they are never read or used anywhere

   I'll do a v3 with the proper "i128" functions to access [ms]cause
   (and their dependents) properly.
   I wanted at first to answer Peter's concerns quickly.

   Frédéric

> 
> Alistair
> 
>>           if (smode_double_trap) {
>>               env->mtval2 = env->mcause;
>>               env->mcause = RISCV_EXCP_DOUBLE_TRAP;
> 

-- 
+---------------------------------------------------------------------------+
| Frédéric Pétrot, Pr. Grenoble INP-UGA@Ensimag/TIMA, MADMAX UGA/CNRS/Inria |
| Mob/Pho: +33 6 74 57 99 65/+33 4 76 57 48 70      Ad augusta  per angusta |
| http://tima.univ-grenoble-alpes.fr frederic.petrot@univ-grenoble-alpes.fr |
+---------------------------------------------------------------------------+


