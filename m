Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A637D2AB2C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 08:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t64WX-0002D1-O3; Wed, 30 Oct 2024 04:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t64WV-0002CD-JE
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 04:57:51 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t64WT-0003NW-Ev
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 04:57:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d4a5ecc44so4059002f8f.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 01:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730278667; x=1730883467;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/uNAEeIssZK3ynFfRGiGINMEGYrxwuoRbyQtC8r+gx4=;
 b=RUrmO09Xw8aT6QMug/EMyN2b/V9gBgAZJDogRIBwa6zneZQexuBNPhsLTnLbTYsaXc
 e+K0K7kui2DQIpWLcyO1k9uqtxF/G7veWHX4Fw9ov4UhrsckJgyyyHAUo4hbjhXz8pXo
 wU5ig+yJRcFGDSEDXPSui+CM5tdd9lqAZlHd/gtDF25LDRNV7nTx8LDI6YTlYGIIC7T7
 KmBaK8PxX1OzO+g43MFXmWcChcGahHef/F/6t6pwBfxDlScqffoFFlTj6fqjCOZqtc68
 EMCbj91gNTFPauwtEFRNZQvPCAAbS+SamvZ8ZHRcUjJ4x0fVnkCSLLppP1wLKwhDtyph
 71Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730278667; x=1730883467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/uNAEeIssZK3ynFfRGiGINMEGYrxwuoRbyQtC8r+gx4=;
 b=ipbidlAKYguglKAxyyJgAynvWZVMrUMA5sgU0zIzJFyfh55kYIjlDiaZS230bCZ7EO
 12EJlHHL+nWXXqPqtCKUnS9XF++F/5v12Z0Icfh2ehnpq+J+uqjftaChgyJV/WUXhnKf
 tlPFR9e8FcBp6kNv95N7p2c/tnSCuY0U4La2XmO2lfoCB92F0uEy7zK9RdadHVoqtRew
 +H6hEcIS9juPXfrwS4otEcLpFhr7zZn0CdLlpb1bAgUQAMfpJcvczjKyLhWwfUuEjfZF
 sUsr8LVtx5u6qZ1bb+coQxaYUnJFkmEyFoZlJLbTfsC68oC+CY7t3xXo7E5/VAYDuwqg
 MgvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpqFqNLOxV7FtpMvhRgxNF7Q0Q4SHMK9DwtKOLXv2od+eBmJoUn0RMGT8rMdItbKnoYeDdiqCuKxhD@nongnu.org
X-Gm-Message-State: AOJu0YwHq3ov4UR1XSMLLA2aiD/ssmj7vM5ubJihCmzmIqg7Cgd/fyq7
 rI0jGO8XwejiwEqP72SkeiZnStWXX12B5DupMDBQdwcSwwvg5g2bZEEsMUbI+2I=
X-Google-Smtp-Source: AGHT+IEZxRL9FJpoXBtxaqPXbQWIsfJZ6Pgbx338NFVRZQmMHHEMRgZ4FC4aFG8krlaJRZToE4OC3w==
X-Received: by 2002:a5d:52c1:0:b0:37d:529f:ac1e with SMTP id
 ffacd0b85a97d-3806120087bmr10977977f8f.53.1730278667297; 
 Wed, 30 Oct 2024 01:57:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b47f6fsm14736927f8f.50.2024.10.30.01.57.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 01:57:46 -0700 (PDT)
Message-ID: <99d02504-92c4-4e8c-8f28-113dcdfb951b@rivosinc.com>
Date: Wed, 30 Oct 2024 09:57:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] target/riscv: fix henvcfg potentially containing
 stale bits
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue
 <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
References: <20241017145226.365825-1-cleger@rivosinc.com>
 <20241017145226.365825-2-cleger@rivosinc.com>
 <CAKmqyKMoDSFaJz7LhX4GMV9AhOQUDLOt79Fctw_k97SazpSjjQ@mail.gmail.com>
 <f99c19eb-2986-49a7-a334-b086e19ad4c4@rivosinc.com>
 <CAKmqyKM2dsjF4YaVbvemqA73=xmgVFsUd64v7k0qjBzT_n=JDw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAKmqyKM2dsjF4YaVbvemqA73=xmgVFsUd64v7k0qjBzT_n=JDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 23/10/2024 04:51, Alistair Francis wrote:
> On Mon, Oct 21, 2024 at 7:30 PM Clément Léger <cleger@rivosinc.com> wrote:
>>
>>
>>
>> On 21/10/2024 02:46, Alistair Francis wrote:
>>> On Fri, Oct 18, 2024 at 12:55 AM Clément Léger <cleger@rivosinc.com> wrote:
>>>>
>>>> With the current implementation, if we had the current scenario:
>>>> - set bit x in menvcfg
>>>> - set bit x in henvcfg
>>>> - clear bit x in menvcfg
>>>> then, the internal variable env->henvcfg would still contain bit x due
>>>> to both a wrong menvcfg mask used in write_henvcfg() as well as a
>>>> missing update of henvcfg upon menvcfg update.
>>>> This can lead to some wrong interpretation of the context. In order to
>>>> update henvcfg upon menvcfg writing, call write_henvcfg() after writing
>>>> menvcfg and fix the mask computation used in write_henvcfg() that is
>>>> used to mesk env->menvcfg value (which could still lead to some stale
>>>> bits). The same mechanism is also applied for henvcfgh writing.
>>>>
>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>> ---
>>>>  target/riscv/csr.c | 17 +++++++++++++----
>>>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>>>> index b84b436151..9e832e0b39 100644
>>>> --- a/target/riscv/csr.c
>>>> +++ b/target/riscv/csr.c
>>>> @@ -2345,6 +2345,8 @@ static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
>>>>      return RISCV_EXCP_NONE;
>>>>  }
>>>>
>>>> +static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>>>> +                                    target_ulong val);
>>>>  static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>>>>                                      target_ulong val)
>>>>  {
>>>> @@ -2357,6 +2359,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>>>>                  (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>>>>      }
>>>>      env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
>>>> +    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
>>>>
>>>>      return RISCV_EXCP_NONE;
>>>>  }
>>>> @@ -2368,6 +2371,8 @@ static RISCVException read_menvcfgh(CPURISCVState *env, int csrno,
>>>>      return RISCV_EXCP_NONE;
>>>>  }
>>>>
>>>> +static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
>>>> +                                    target_ulong val);
>>>>  static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>>>>                                       target_ulong val)
>>>>  {
>>>> @@ -2378,6 +2383,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>>>>      uint64_t valh = (uint64_t)val << 32;
>>>>
>>>>      env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
>>>> +    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
>>>>
>>>>      return RISCV_EXCP_NONE;
>>>>  }
>>>> @@ -2435,6 +2441,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>>>>                                      target_ulong val)
>>>>  {
>>>>      uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
>>>> +    uint64_t menvcfg_mask = 0;
>>>>      RISCVException ret;
>>>>
>>>>      ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
>>>> @@ -2443,10 +2450,11 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>>>>      }
>>>>
>>>>      if (riscv_cpu_mxl(env) == MXL_RV64) {
>>>> -        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
>>>> +        menvcfg_mask = HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
>>>> +        mask |= env->menvcfg & menvcfg_mask;
>>>
>>> This doesn't seem right.
>>>
>>> Should it be something like
>>
>> That is what I did before but that didn't work, henvcfg still contained
>> some stale bits.
>>
>>>
>>>     if (riscv_cpu_mxl(env) == MXL_RV64) {
>>>         mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
>>>     }
>>>
>>>     mask = env->menvcfg & mask;
>>>
>>>>      }
>>>>
>>>> -    env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
>>>> +    env->henvcfg = (env->henvcfg & ~menvcfg_mask) | (val & mask);
>>>
>>> Using both menvcfg_mask and mask seems wrong here
>>
>> The problem is that if you use:
>>
>> mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE)
>>
>> Then, if a bit was cleared in menvcfg before writing henvcfg (let's say
>> HENVCFG_ADUE), then env->henvcfg will be masked with mask =
>> HENVCFG_PBMTE | HENVCFG_STCE, leaving the HENVCFG_ADUE stale bit in
>> env->henvcfg which is wrong for the internal state.
>>
>> The idea here is to actually clear any menvcfg related bit (the 1:1
>> bits) using the raw mask (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE)
>> to clear everything and then OR it with the value to be written (which
>> is masked with raw bits + menvcfg content) to avoid any stale bits.
> 
> When calling write_henvcfg() can't you just do:
> 
> write_henvcfg(env, CSR_HENVCFG, env->henvcfg & env->menvcfg)

Yeah it's clearer and I thought of that but you'll end up with the same
result since the problem does not come from the value you supply but
rather by the old masked henvcfg value used at the end of
write_henvcg()(and the mask is computed independently of the new value),
ie this line:

env->henvcfg = (env->henvcfg & ~mask) | (val & mask);

The mask is actually not containing the bits that were cleared in menvcfg.

We could actually use

write_henvcfg(env, CSR_HENVCFG, env->henvcfg & env->menvcfg)

But maybe we could call it prior to menvcfg update in order to clear all
currently set bit in menvcfg and mask env->henvcfg with the new value to
be written. That seems a bit off as well. But I'll take whatever you
think is clearer.

Clément

> 
> I feel like that's clearer then the current approach
> 
> Alistair
> 
>>
>> Thanks,
>>
>> Clément
>>
>>>
>>> Alistair
>>


